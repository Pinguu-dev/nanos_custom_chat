Events:Subscribe("Chat_SV_CheckMessage", function(player, message)
	local new_message = "<b>".. player:GetName() .."</b>: ".. message
	Events:BroadcastRemote("Chat_SendMessage", { new_message })
	
	--Events:CallRemote("Chat_SendMessage", player, { "<b>Server:</b> you execute /test, this is a local msg" })
end)


-- EXAMPLE COMMAND HANDLER

-- CommnandsHandler (Server Side)
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
