SocialWorld.activeTags = {}
SocialWorld.activeTagMaterials = {}


-- Clears any existing tags on the character.
function SocialWorld:ClearTags(source)
    if not self.activeTags[source] then return end

    self.activeTags[source]:Destroy()
    self.activeTagMaterials[source]:Destroy()
end


-- Gets called from the server, and does checks to make sure it doesn't put the name tag on self by comparing the sources/ids.
-- Creates a TextRender with the other player's name and attaches it above the player's head.
function SocialWorld:CreateTag(otherPlayerInfo)
    if not otherPlayerInfo then return end

    local player = Client.GetLocalPlayer()
    local playerSource = player:GetID()
    local otherPlayer = otherPlayerInfo.player
    local otherPlayerSource = otherPlayer:GetID()
    local otherPlayerCharacter = otherPlayer:GetControlledCharacter()
    local otherPlayerName = otherPlayerInfo.name

    if playerSource == otherPlayerSource then
        return
    end

    self:ClearTags(otherPlayerSource)

    local tagMaterial = WebUI("nametag"..otherPlayerName , "file:///Ui/nametag/index.html", WidgetVisibility.Hidden, true)
    local tag = Billboard(Vector(0, 0, 100), "helix::M_Default_Translucent_Lit", Vector2D(55, 100))

    tagMaterial:CallEvent('newTag', otherPlayerName)
    tag:AttachTo(otherPlayerCharacter)
    tag:SetRelativeLocation(Vector(0, 0, 180))
    tag:SetMaterialFromWebUI(tagMaterial)
    tag:SetMaterialScalarParameter('Opacity', 0.8)

    self.activeTags[otherPlayerSource] = tag
    self.activeTagMaterials[otherPlayerSource] = tagMaterial
end


--- Updates the mute state of the given player.
function SocialWorld:UpdateTagState(otherPlayerSource, bool)
    if not self.activeTags[otherPlayerSource] then return end

    local tagMaterial = self.activeTagMaterials[otherPlayerSource]
    tagMaterial:CallEvent('setMuteState', bool)
end


-- Called when need to remove a player's tag.
function SocialWorld:ClearTag(otherPlayerInfo)
    if not otherPlayerInfo then return end

    local player = Client.GetLocalPlayer()
    local playerSource = player:GetID()
    local otherPlayer = otherPlayerInfo.player
    local otherPlayerSource = otherPlayer:GetID()

    if playerSource == otherPlayerSource then
        return
    end

    self:ClearTags(otherPlayerSource)

    self.activeTags[otherPlayerSource] = nil
    self.activeTagMaterials[otherPlayerSource] = nil
end


function SocialWorld:PlayerTalking(otherPlayer, isTalking)
    if not otherPlayer then return end

    local player = Client.GetLocalPlayer()
    local playerSource = player:GetID()
    local otherPlayerSource = otherPlayer:GetID()
    local otherPlayerTag = self.activeTags[otherPlayerSource]

    if playerSource == otherPlayerSource then
        return
    end

    if not otherPlayerTag then
        return
    end

    if isTalking then
        otherPlayerTag:SetMaterialColorParameter("Tint", Color(1, 0, 0)) -- Red
    else
        otherPlayerTag:SetMaterialColorParameter("Tint", Color(1, 1, 1)) -- White
    end
end






-- Gets called when a player starts/stops using VOIP.
-- Calls PlayerTalking function for processing their nametag.
Player.Subscribe("VOIP", function(...)
    SocialWorld:PlayerTalking(...)
end)

--- Gets called when a player joins the world.
Events.SubscribeRemote('NameTags:PlayerConnection', function(...)
    SocialWorld:CreateTag(...)
end)

--- Gets called when a player leaves the world.
Events.SubscribeRemote('NameTags:PlayerDisconnection', function(...)
    SocialWorld:ClearTag(...)
end)

-- Called when the players joins, and receives and adds nametags for the other players.
Events.SubscribeRemote('NameTags:AddExistingPlayers', function(players)
    for _, player in pairs(players) do
        SocialWorld:CreateTag(player)
    end
end)