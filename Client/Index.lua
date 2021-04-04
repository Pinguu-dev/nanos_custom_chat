ChatUI = WebUI("ChatUI", "file:///UI/index.html", true)

Chat = {
	active = true,
	inputOpened = false
}

Package:Subscribe("Load", function()
	Client:SetChatVisibility(false)
end)

NanosWorld:Subscribe("SpawnLocalPlayer", function(local_player)
	Client:SetChatVisibility(false)
end)

Events:Subscribe("Chat_SendMessage", function(message) 
	ChatUI:CallEvent("PushChat", { message })
end)

ChatUI:Subscribe("CommandExecute", function(command)
	Package:Log("execute command ".. command)
	Events:CallRemote("Chat_SV_CommandExecute", { command })
end)

ChatUI:Subscribe("ChatMessage", function(text)
	Events:CallRemote("Chat_SV_CheckMessage", { text })
	Chat.inputOpened = false
end)

ChatUI:Subscribe("ChangeChatState", function(state)
	Chat.inputOpened = state
end)

Client:Subscribe("KeyUp", function(KeyName, _, _)
	if(KeyName == "T" and Chat.active == true and Chat.inputOpened == false) then
		ChatUI:CallEvent("CallEnableChatInput", {})
		Chat.inputOpened = true
		
		ChatUI:SetFocus()
		ChatUI:BringToFront()
	end	

	if(KeyName == "Escape" and Chat.active == true and Chat.inputOpened == true) then
		ChatUI:CallEvent("CloseChatInput", {})
		Chat.inputOpened = false
	end
	
end)
