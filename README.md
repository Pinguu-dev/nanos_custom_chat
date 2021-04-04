# nanos_custom_chat

This is a custom chat for nanos.world! 
It's not the yellow from the egg xD but you can use it to see how i do it.

Events:
```LUA
-- Client
ChangeChatState(boolean state) -- Calls if the chat state changed
ChatMessage(string message) -- Calls if a client enter a chat message
CommandExecute(string command) -- Calls if the client enters a command (prefix /)

Chat_SendMessage(string message) -- Push a message intro the client chat ui

-- Server
Chat_SV_CheckMessage(Player player, string message) -- Calls from client to server to format the message (player: text)
Chat_SV_CommandExecute(Player player, string command) -- Calls if the client execute a command in the chat
```

Example for CommandHandler with the new ChatUI

```LUA
local commands = {}

Events:Subscribe("Chat_SV_CommandExecute", function(player, command)
	print(player:GetName() .." calls command ".. command)
	
	if commands[command] then
        commands[command](player)
        return false
    end
end)

function RegisterServerCommand(command, func)
	if not commands[command] then
		commands[command] = func
    else
        return false
	end
end

RegisterServerCommand("test", function(player) 
	Events:CallRemote("Chat_SendMessage", player, { "<b>Server:</b> you execute <font style='color: red;'>/test</font>, this is a local msg" })
end)
```
