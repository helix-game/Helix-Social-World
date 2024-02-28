
function SocialWorld:AddChatBubble(message, otherPlayer)
    if not message then return end
    if not otherPlayer then return end

    local player = Client.GetLocalPlayer()
    local playerSource = player:GetID()
    local playerCharacter = player:GetControlledCharacter()
    local playerLocation = playerCharacter:GetLocation()
    local otherPlayerSource = otherPlayer:GetID()
    local otherPlayerCharacter = otherPlayer:GetControlledCharacter()
    local otherPlayerLocation = otherPlayerCharacter:GetLocation()

    if playerSource == otherPlayerSource then
        return
    end

    if playerLocation:Distance(otherPlayerLocation) > 3000 then
        return
    end

    local bubbleMaterial = WebUI("chatbox", "file:///Ui/chat-bubble/index.html", WidgetVisibility.Hidden, true)
    local bubble = Billboard(Vector(0, 0, 100), "helix::M_Default_Translucent_Lit", Vector2D(55, 100))

    bubbleMaterial:CallEvent('newChatBubble', message)
    bubble:AttachTo(otherPlayerCharacter)
    bubble:SetRelativeLocation(Vector(0, 0, 200))
    bubble:SetMaterialFromWebUI(bubbleMaterial)
    bubble:SetMaterialScalarParameter('Opacity', 0.8)

    Timer.SetTimeout(function ()
        bubbleMaterial:Destroy()
        bubble:Destroy()
    end, 3000)
end



--- Listens for new chats posted by other players, and calls AddChatBubble to process the chat.
Events.SubscribeRemote('ChatBubble:Add', function(...)
    SocialWorld:AddChatBubble(...)
end)