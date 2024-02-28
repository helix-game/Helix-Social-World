Package.Require('NameTags.lua')
Package.Require('Emotes.lua')

SocialWorld.Database = Database(DatabaseEngine.MySQL, "db=social-world user=root host=localhost")
SocialWorld.SpawnPoint = Vector(0.0, 0.0, 10.0)
SocialWorld.recentChatBubbles = {} -- don't touch, used for avoiding chat spams.



-- Gets called via the player classes's "Spawn" event, and creates the character for the player as well as remembers important information of the player for future reference.
-- Calls NameTags for processing the player's name tag as well as other player tags.
-- The spawn location can be changed by changing the vector in SocialWorld.SpawnPoint.
-- The self keyword in this function is just SocialWorld.
function SocialWorld:PlayerConnection(player)
    if not player then return end

    local newCharacter = HCharacter(SocialWorld.SpawnPoint, Rotator(0.0, 0.0, 0.0), player)
    local playerName = player:GetName()
    local playerIdentifier = player:GetAccountID()
    local playerSource = player:GetID()
    local playerIndex = #self.Players + 1

    print(('%s Has Joined Your Social World.'):format(playerName))

    self.Players[playerIndex] = {
        source = playerSource,
        player = player,
        character = newCharacter,
        name = playerName
    }
    self.Characters[newCharacter] = playerIndex
    self.PlayerIDs[playerSource] = playerIndex

    player:Possess(newCharacter)
--[[     player:SetVOIPSetting(VOIPSetting.Local)
    player:SetVOIPChannel(1) ]]

    self.Database:SelectAsync('SELECT * FROM players WHERE identifier = :0', function(result)
        if not result[1] then
            SocialWorld.Database:Execute('INSERT INTO players VALUES (:0, :0)', playerIdentifier, playerName)
        end

        local playerInfo = self.Players[playerIndex]
        if result[1] then
            playerInfo.name = result[1].name
        end

        self:AddNameTag(playerIndex)

        Events.CallRemote('NameTags:AddExistingPlayers', player, self.Players)
        Events.CallRemote('SocialWorld:OnCharacterSpawn', player)
    end, playerIdentifier)
end


function SocialWorld:GetPlayerFromSource(source)
    return self.Players[self.PlayerIDs[source]]
end

-- Gets the player's info from the SocialWorld object to clear it from memory.
-- Lets the other players know the disconnection for clearing NameTags, etc.
function SocialWorld:PlayerDisconnection(player)
    if not player then return end

    local playerSource = player:GetID()
    local playerCharacter = player:GetControlledCharacter()
    local playerIndex = self.PlayerIDs[playerSource]
    local playerInfo = self.Players[playerIndex]

    print(('%s Has Left Your Social World.'):format(playerInfo.name))

    if playerCharacter then
        self:RemoveNameTag(playerIndex)
        playerCharacter:Destroy()
    end

    self.Characters[playerCharacter] = nil
    self.PlayerIDs[playerSource] = nil
    self.Players[playerIndex] = nil
end



-- Called to process messages and checks for possible commands.
function SocialWorld.NewChat(message, posterPlayer)
    local isChatBubble, endOfPrefixC = string.find(message, '/t%s')
    local isMutePlayer, endOfPrefixM = string.find(message, '/m%s')
    local posterPlayerSource = posterPlayer:GetID()

    if isChatBubble and endOfPrefixC then
        local prefixRemoved = string.sub(message, endOfPrefixC, string.len(message))
        local messageLength = string.len(prefixRemoved)

        if messageLength > 30 then
            Chat.SendMessage(posterPlayer, 'Message has to be less than 30 characters for chat bubble.')
            return false
        end

        if SocialWorld.recentChatBubbles[posterPlayerSource] then
            Chat.SendMessage(posterPlayer, 'Please wait to post another proximity chat.')
            return false
        end

        SocialWorld.recentChatBubbles[posterPlayerSource] = true
        Timer.SetTimeout(function ()
            SocialWorld.recentChatBubbles[posterPlayerSource] = false
        end, 3000)

        Events.BroadcastRemote('ChatBubble:Add', prefixRemoved, posterPlayer)
    end


    if isMutePlayer and endOfPrefixM then
        local prefixRemoved = string.sub(message, endOfPrefixM, string.len(message))
        local mutingPlayerSource = tonumber(prefixRemoved)
        local mutingPlayer = SocialWorld:GetPlayerFromSource(mutingPlayerSource)

        if not mutingPlayerSource then
            Chat.SendMessage(posterPlayer, 'Please provide the id of the player you want to mute.')
            return false
        end

        if not mutingPlayer then
            Chat.SendMessage(posterPlayer, 'This player is not currently online.')
            return false
        end

        if mutingPlayer.source == posterPlayerSource then
            Chat.SendMessage(posterPlayer, 'You cannot mute yourself.')
            return false
        end

        Events.CallRemote('MutePlayer', posterPlayer, mutingPlayer)
    end


    return false
end




-- Calls the PlayerConnection to process player connection.
Player.Subscribe("Spawn", function(...)
    SocialWorld:PlayerConnection(...)
end)

-- Calls the PlayerDisconnection to process disconnected player.
Player.Subscribe("Destroy", function(...)
    SocialWorld:PlayerDisconnection(...)
end)

Package.Subscribe("Load", function()
	for _, player in pairs(Player.GetPairs()) do
        SocialWorld:PlayerConnection(player)
    end
end)

-- Calls NewChat to process new chat posted by player.
Chat.Subscribe("PlayerSubmit", SocialWorld.NewChat)