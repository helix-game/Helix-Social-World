function SocialWorld:AddNameTag(playerIndex)
    Events.BroadcastRemote('NameTags:PlayerConnection', self.Players[playerIndex])
end

function SocialWorld:RemoveNameTag(playerIndex)
    Events.BroadcastRemote('NameTags:PlayerDisconnection', self.Players[playerIndex])
end