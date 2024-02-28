SocialWorld.emotesList = {
    ["hoosie slide"] = {path = "emotes::SK_HoosieSlideDance", looped = false}
    --[[
    SK_Drinking = {path = "animations/Drinking"},
        SK_EatDonut = {path = "animations/Eating_donut"},
        SK_HandsDown_01 = {path = "animations/HandDown_01"},
        SK_HandsDown_02 = {path = "animations/HandDown_02"},
        SK_HandsUpIdle_01 = {path = "animations/HandUp_Idle_01"},
        SK_HandsUpIdle_02 = {path = "animations/HandUp_Idle_02"},
        SK_HandsUp_01 = {path = "animations/HandUp_01"},
        SK_HandsUp_02 = {path = "animations/HandUp_02"},
        SK_HoldCup = {path = "animations/Holding_a_cup"},
        SK_TalkOnRadio = {path = "animations/Talking_on_police_radio"},

        SK_Whistle = {path = "Whistle_Animation"},
        SK_Wave = {path = "WavingHii_Animation"},
        SK_Punch = {path = "Punch_Animation"},
        SK_Hug = {path = "Hug_Animation"},
        SK_HandShake = {path = "Hand_Shake_Animation"},
        SK_CrossHand2 = {path = "CrossHand_Animation_2"},
        SK_CrossHand1 = {path = "CrossHand_Animation"},
        SK_Clap = {path = "Clapping_Animation"},
    ]]
} -- path to animation + other params 


function SocialWorld:PlayEmote(player, animation)
    if not self.emotesList[animation] then return end

    local playerInfo = self:GetPlayerFromSource(player:GetID())
    local emote = self.emotesList[animation]
    local emotePath = emote.path
    local looped = emote.looped or false

    playerInfo.character:PlayAnimation(emotePath)
end

Events.SubscribeRemote("Emotes::client:EmoteRequest", function(...)
    SocialWorld:PlayEmote(...)
end)
