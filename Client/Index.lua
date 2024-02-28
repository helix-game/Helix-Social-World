Package.Require('NameTags.lua')
Package.Require('ChatBubble.lua')
Package.Require('Emotes.lua')

SocialWorld.mutedPlayers = {}

--- Mutes the given player locally.
function SocialWorld:MutePlayer(otherPlayerInfo)
    if not otherPlayerInfo then return end

    local otherPlayer = otherPlayerInfo.player
    local otherPlayerSource = otherPlayerInfo.source
    local otherPlayername = otherPlayerInfo.name
    local muteState = not self.mutedPlayers[otherPlayerSource]
    local notify = muteState and 'Muted' or 'Unmuted'
    local VOIPSetting = muteState and VOIPSetting.Muted or VOIPSetting.Local

    otherPlayer:SetVOIPSetting(VOIPSetting)
    self:UpdateTagState(otherPlayerSource, muteState)
    self.mutedPlayers[otherPlayerSource] = muteState

    Chat.AddMessage(string.format('%s %s.', notify, otherPlayername))
end



--- Listens for mute command, and calls the MutePlayer function to process the request.
Events.SubscribeRemote('MutePlayer', function(...)
    SocialWorld:MutePlayer(...)
end)