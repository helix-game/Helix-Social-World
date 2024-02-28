SocialWorld.playerAnims = {}
SocialWorld.emotesUi = nil


function SocialWorld:InitialiseEmotes()
    self.emotesUi = WebUI("Radial Animation", "file://UI/emote-menu/index.html")
    self.emotesUi:SetVisibility(WidgetVisibility.Hidden)

    self.emotesUi:Subscribe("Ready", function ()
        self.emotesUi:Subscribe("radialmenu::addEmote", function(anim, index)
            self.playerAnims[index] = anim
        end)

        self.emotesUi:Subscribe("radialmenu::playEmote", function(anim,index)
            self.emotesUi:SetVisibility(WidgetVisibility.Hidden)
            Input.SetMouseEnabled(false)
            Events.CallRemote("Emotes::client:EmoteRequest", anim, index)
        end)
    end)
end


function SocialWorld:OpenEmotes()
    if self.emotesUi:GetVisibility() == WidgetVisibility.Hidden then
        SocialWorld.emotesUi:SetVisibility(WidgetVisibility.Visible)
        SocialWorld.emotesUi:BringToFront()
        Input.SetMouseEnabled(true)
        return
    end

    SocialWorld.emotesUi:SetVisibility(WidgetVisibility.Hidden)
    Input.SetMouseEnabled(false)
end

function SocialWorld:PlayFirstEmote()
    self.emotesUi:SetVisibility(WidgetVisibility.Hidden)
    Input.SetMouseEnabled(false)

    Events.CallRemote("Emotes::client:EmoteRequest", self.playerAnims["1"])
end

Input.Register("OpenRadialAnims", "K")
Input.Register("Anim_One", "One")

Input.Bind("OpenRadialAnims", InputEvent.Pressed, function()
    SocialWorld:OpenEmotes()
end)

Input.Bind("Anim_One", InputEvent.Pressed, function()
    SocialWorld:PlayFirstEmote()
end)

Events.SubscribeRemote('SocialWorld:OnCharacterSpawn', function()
    SocialWorld:InitialiseEmotes()
end)