--[[
ChatBot_Save_All 			-- saves all
ChatBot_Save 				-- saves basic stuff
ChatBot_Save_AdminGreetings -- saves Admin greetings
ChatBot_Save_Greetings 		-- saves stuff when you say hey
--]]



-- vars 
local ChatBotSettings = { }
ChatBotSettings.Name = ".:CG:. Nick" -- His name , this is Nick by default
ChatBotSettings.Color = Color( 0 , 0 , 255 , 255 ) -- His team color , this is blue by default
ChatBotSettings.Inter = " : " -- Simple stoof, for the funz
ChatBotSettings.Delay = 0.5 -- retardness of nick , 0.3 by default
ChatBotSettings.EasterEgg = "CupCakes are fun to eat"
ChatBotSettings.EasterEggAnswer = "OMG !!! You just found my favorite phrase! Congrats!"
ChatBotSettings.WierdDelay = 90
ChatBotSettings.File = "ChatBot.txt"
ChatBotSettings.FileG = "ChatBot_G.txt"
ChatBotSettings.FileAG = "ChatBot_AG.txt"

ChatBotSettings.Adverts = { }
ChatBotSettings.Adverts.Color = Color( 100,100,100 )
ChatBotSettings.Adverts.Delay = math.random( 90,120 )

if SERVER then

	Msg("Loading " .. string.upper(ChatBotSettings.Name) .. " , Made by Meisno \n")
	
	AddCSLuaFile("ChatBot.lua")
	
	local Tab = nil

	if !file.ExistsEx(ChatBotSettings.File) then
		Tab = { }
		print("ChatBot : Didn't find TableFile ! Starting new one , Use the command ChatBot_Save to fix this" )
	else
		Tab = KeyValuesToTable( file.Read(ChatBotSettings.File))
		print("ChatBot : Loaded TableFile and inserted into main ChatBot AI !")
	end

	Tab["lol"] = { }
	Tab["lol"][1] = "It's funny, isn't it."
	Tab["lol"][2] = "Thats not funny..."
	Tab["lol"][3] = "Hahaha."
	
	Tab["lol?"] = { }
	Tab["lol?"][1] = "What?"
	Tab["lol?"][2] = "Thats not funny..."
	Tab["lol?"][3] = "Are you mocking me?"
	
	Tab["rofl"] = { }
	Tab["rofl"][1] = "It's funny, isn't it."
	Tab["rofl"][2] = "Thats not funny..."
	Tab["rofl"][3] = "Hahaha."
	
	Tab["lmao"] = { }
	Tab["lmao"][1] = "It's funny, isn't it."
	Tab["lmao"][2] = "Thats not funny..."
	Tab["lmao"][3] = "Hahaha."
	
	Tab["shhh"] = { }
	Tab["shhh"][1] = "Don't you shush me!"
	
	Tab["fuck"] = { }
	Tab["fuck"][1] = "You never know, I might be your mother , so don't swear XD ."
	Tab["fuck"][2] = "Don't swear please, it will make your teeth fall out!"
	
	Tab["why?"] = { }
	Tab["why?"][1] = "Why what?"
	Tab["why?"][2] = "'Why?' is not proper grammar!"
	
	Tab["what?"] = { }
	Tab["what?"][1] = "I didn't say anything ..."
	Tab["what?"][2] = "Nothing ..."
	
	Tab["what"] = { }
	Tab["what"][1] = "I didn't say anything ..."
	Tab["what"][2] = "Nothing ..."
	
	Tab["sugar"] = { }
	Tab["sugar"][1] = "I love sugar :D."
	Tab["sugar"][2] = "Sugar is sweet and so is choclate!!"
	
	Tab["darkrp"] = { }
	Tab["darkrp"][1] = "DarkRP is rubbish"
	
	Tab["rp"] = { }
	Tab["rp"][1] = "RP is rubbish"
	
	Tab[":d"] = { }
	Tab[":d"][1] = "You seem happy today!"
	
	Tab[":)"] = { }
	Tab[":)"][1] = "You seem happy today!"
	
	Tab[":("] = { }
	Tab[":("][1] = "What's wrong?"
	
	Tab["d:"] = { }
	Tab["d:"][1] = "What's wrong?"
	
	Tab["xd"] = { }
	Tab["xd"][1] = "LOL."
	
	Tab["nothing"] = { }
	Tab["nothing"][1] = "Nothing is everything that isn't known yet ..."
	
	Tab["anything"] = { }
	Tab["anything"][1] = "Anything is the things that are all around us ...."
	
	Tab["up"] = { }
	Tab["up"][1] = "The sky is up :D and so are the birds!"
	Tab["up?"] = { }
	Tab["up?"][1] = "The sky is up :D and so are the birds!"
	
	Tab["no"] = { }
	Tab["no"][1] = "meh"
	
	Tab["cool"] = { }
	Tab["cool"][1] = "Yes, it is cool, but not cold really..."
	
	Tab["nick?"] = { }
	Tab["nick?"][1] = "Yes?"
	
	Tab["yes"] = { }
	Tab["yes"][1] = "Yey!"
	
	Tab["yes?"] = { }
	Tab["yes?"][1] = "What?"
	
	local feelings = { }
	feelings[1] = "I'm fine :)"
	//feelings[2] = "No, your here!"
	feelings[3] = "It's going good today"
	//feelings[4] = "No, My leg hurts!"
	feelings[5] = "I don't wana speek ... "
	
	local feelings2 = { }
	
	feelings2[1] = "Yes thank you"
	feelings2[2] = "No, your here!"
	feelings2[3] = "No, my leg hurts!"
	feelings2[4] = "Fine thanks"
	
	
	ChatBot = { }
	
	
	function ChatBot.AddFeeling( tab )
		for k,v in pairs( tab ) do
			table.insert( feelings , v )
			print("ChatBot : Added feeling !" )
		end
	end
	
	hook.Add("PlayerSay", "ChatBot.Feelings", function( ply, text )
		if( string.match(text, "%how are you") )then
			umsg.Start("ChatBot.Call")
				umsg.String( table.Random(feelings) )
			umsg.End()
		end
		
		if( string.match(text, "%are you ok") )then
			umsg.Start("ChatBot.Call")
				umsg.String( table.Random(feelings2) )
			umsg.End()
		end
	end)
	
	
	local wierd = { }
	wierd[1] = "I used to work at BlackMesaEast you know? but well before the incident .... "
	wierd[2] = "I am watching your every move you know?"
	wierd[3] = "I am scotish you know? I am also friends with the TF2 demoman!"
	wierd[4] = "Speek to me D: "
	wierd[5] = "Wanna be friends?"
	
	if !file.ExistsEx(ChatBotSettings.FileG) then
		greetings = { }
		print("ChatBot : Didn't find GTableFile ! Starting new one , Use the command ChatBot_Save_Greetings to fix this" )
	else
		greetings = KeyValuesToTable( file.Read(ChatBotSettings.FileG))
		print("ChatBot : Loaded GTableFile and inserted into main ChatBot AI !")
	end

	greetings[1] = "Hey! What's up?"
	
	
	function ChatBot.AddGreeting( tab )
		for k,v in pairs( tab ) do
			table.insert( greetings , v )
			print("ChatBot : Added Greeting !" )
		end
	end
	
	if !file.ExistsEx(ChatBotSettings.FileAG) then
		AdminGreet = { }
		print("ChatBot : Didn't find AGTableFile ! Starting new one , Use the command ChatBot_Save_AdminGreetings to fix this" )
	else
		AdminGreet = KeyValuesToTable( file.Read(ChatBotSettings.FileAG))
		print("ChatBot : Loaded AGTableFile and inserted into main ChatBot AI !")
	end
	AdminGreet[1] = "Hey <n>."
	AdminGreet[2] = "What's up <n> ?"
	AdminGreet[3] = "Uh oh! <n> has join :O."
	
	function ChatBot.AddAdminGreeting( tab )
		for k,v in pairs( tab ) do
			table.insert( AdminGreet , v )
			print("ChatBot : Added Admin Greeting !" )
		end
	end
	
	timer.Create("ChatBot.WierdStuff", ChatBotSettings.WierdDelay, 0,function()
		umsg.Start("ChatBot.Call")
			umsg.String( table.Random(wierd) )
		umsg.End()
	end)
	
	
	function ChatBot.Add( trig , tab )
		if !Tab[trig] then 
			Tab[trig] = { }
			for k,v in pairs( tab ) do
				table.insert( Tab[trig] , v )
				print("ChatBot : Added chat trigger and response !" )
			end
		else
			for k,v in pairs( tab ) do
				table.insert( Tab[trig] , v )
				print("ChatBot : Added chat trigger and response !" )
			end
		end
	end
	
	hook.Add("PlayerInitialSpawn", "ChatBot.Greet", function( ply )
		timer.Simple( 2 , function()
			if ply:IsAdmin() then
				local replacement = table.Random( AdminGreet )
				local sub = string.gsub( replacement , "<n>" , ply:Nick() )
				umsg.Start("ChatBot.Call")
					umsg.String( sub )
				umsg.End()
			end
		end)
	end)

	hook.Add("PlayerSay", "ChatBot.Trig", function( ply , text )
		if string.ToTable( text )[1] != "$" then
			if text == ChatBotSettings.EasterEgg then
				umsg.Start("ChatBot.Call")
					umsg.String( ChatBotSettings.EasterEggAnswer )
				umsg.End()
			end
			
			if string.lower(text) == "hey nick" or string.lower(text) == "hey nick!" or string.lower(text) == "hey!" or string.lower(text) == "hey" then
				local replacement = table.Random( greetings )
				umsg.Start("ChatBot.Call")
					umsg.String( replacement )
				umsg.End()
			end

			for k,v in pairs( string.Explode( " ", text ) ) do
				for key, value in pairs( Tab ) do
					if string.lower(v) == key then
						local replacement = table.Random( value )
						umsg.Start("ChatBot.Call")
							umsg.String( replacement )
						umsg.End()
					end
				end
			end
		end
	end)
	
	function ChatBot.SaveTable()
		print("ChatBot : Saving Table contents to " .. ChatBotSettings.File .. "  ... " )
		file.Write( ChatBotSettings.File , TableToKeyValues( Tab ) )
		print("ChatBot : Saved Table contents to " .. ChatBotSettings.File .. " ! " )
	end
	
	function ChatBot.SaveGreetingsTable()
		print("ChatBot : Saving Greetings Table contents to " .. ChatBotSettings.FileG .. "  ... " )
		file.Write( ChatBotSettings.FileG , TableToKeyValues( greetings ) )
		print("ChatBot : Saved Greetings Table contents to " .. ChatBotSettings.FileG .. " ! " )
	end
	
	function ChatBot.SaveAdminGreetingsTable()
		print("ChatBot : Saving Admin Greetings Table contents to " .. ChatBotSettings.FileAG .. "  ... " )
		file.Write( ChatBotSettings.FileAG , TableToKeyValues( AdminGreet ) )
		print("ChatBot : Saved Admin Greetings Table contents to " .. ChatBotSettings.FileAG .. " ! " )
	end
	
	concommand.Add("ChatBot_Save", function()
		ChatBot.SaveTable()
	end)
	
	concommand.Add("ChatBot_Save_AdminGreetings", function()
		ChatBot.SaveAdminGreetingsTable()
	end)
	
	concommand.Add("ChatBot_Save_Greetings", function()
		ChatBot.SaveGreetingsTable()
	end)
	
	concommand.Add("ChatBot_Save_ALL", function()
		ChatBot.SaveGreetingsTable()
		ChatBot.SaveAdminGreetingsTable()
		ChatBot.SaveTable()
	end)
	
	concommand.Add("ChatBot_Add", function( ply, cmd , args)
		local trig = table.remove(args, 1)
		ChatBot.Add( trig, args )
	end)
	
	concommand.Add("ChatBot_FlushCache", function( ply )
		if ply:IsAdmin() then
			file.Delete(ChatBotSettings.File)
			file.Delete(ChatBotSettings.FileG)
			file.Delete(ChatBotSettings.FileAG)
			print("ChatBot : Flushed cache files! Please use the command ChatBot_Save_all to restore the files")
		end
	end)
	
	concommand.Add("ChatBot_OVERIDE", function( ply , cmd, args)
		if ply:IsSuperAdmin() then
			local text = string.Implode(" ", args)
			umsg.Start("ChatBot.Call")
				umsg.String( text )
			umsg.End()
		end
	end)
	
	
	local _ChatCommands = { };
	local _ChatPrefix = "$";

	function ChatBot.AddCommand( txt, func )
		_ChatCommands[ _ChatPrefix .. txt ] = func;
	end

	hook.Add( "PlayerSay", "ChatBot.Command.Caller", function( ply, text, toall )

		local tab = string.Explode( " ", text );
		local func = _ChatCommands[ tab[1] ];
		
		if ( func ) then
		
			local c = tab[1];
			table.remove( tab, 1 )
			
			func( ply, c, tab  );
			
			return "";
			
		
		end

	end );

	function ChatBot.Reply( ply ,text )
		if ply:IsSuperAdmin() or ply == nil then
			umsg.Start("ChatBot.Call")
				umsg.String( text )
			umsg.End()
		end
	end
	
	ChatBot.AddCommand( "Sep", function(ply, cmd , args)
		print( "ChatBot : " .. string.Implode( " , ", args ) )
		ChatBot.Reply( ply,"Printed your request to the console!" )
	end)
	
	ChatBot.AddCommand( "Kill_All", function(ply, cmd , args)
		if ply:IsAdmin() then
			for k,v in pairs( player.GetAll() ) do
				v:Kill()
			end
			ChatBot.Reply( ply , "Killed everyone!" )
		end
	end )
	
	local _Adverts = { }
	
	function ChatBot.AddAdvert( Advert, index )
		if !_Adverts[index] then
			_Adverts[index] = Advert
		else
			return false
		end
	end
	
	function ChatBot.PrimeAdverts()
		timer.Create( "ChatBot.Adverts.Delay",ChatBotSettings.Adverts.Delay,0, function()
			umsg.Start("ChatBot.Call.Advert")
				umsg.String( table.Random( _Adverts ) )
			umsg.End()
		end)
	end
	
	ChatBot.AddAdvert( "Your playing on CG's Sandbox server! Have fun! ", "HFun1" )
	ChatBot.AddAdvert( "I'm nick, your friendly AI ChatBot. I was Created by Meisno!", "HFun2" )
	
	function ChatBot.SendAdvert( index )
		if index and _Adverts[index] then
			umsg.Start("ChatBot.Call.Advert")
				umsg.String( _Adverts[index] )
			umsg.End()
		end
	end
	
	concommand.Add("ChatBot_AdvertBeta", function()
		ChatBot.SendAdvert( "HFun2" )
	end)
	

elseif CLIENT then

	Msg("Loading " .. string.upper(ChatBotSettings.Name) .. " , Made by Meisno \n")

	usermessage.Hook("ChatBot.Call", function( um )
		local _Message = um:ReadString()
		if _Message then
			timer.Simple( ChatBotSettings.Delay , function()
				chat.AddText(
					ChatBotSettings.Color , ChatBotSettings.Name ,
					Color(255,255,255), ChatBotSettings.Inter,
					Color(255,255,255), _Message)
				chat.PlaySound()
			end)
		end
	end)
	
	usermessage.Hook("ChatBot.Call.Advert", function( um )
		local _Message = um:ReadString()
		if _Message then
			timer.Simple( ChatBotSettings.Delay , function()
				chat.AddText(
					ChatBotSettings.Adverts.Color, "(ADVERT) ",
					ChatBotSettings.Color , ChatBotSettings.Name ,
					Color(255,255,255), ChatBotSettings.Inter,
					Color(255,255,255), _Message)
				chat.PlaySound()
			end)
		end
	end)
	
	function OpenChatBotUI()
		local DFrame1 = vgui.Create('DFrame')
		DFrame1:SetSize(500, 75)
		DFrame1:Center()
		DFrame1:SetTitle('NICK: Nice Intellegent ChatBot Kewl!!   --     UI    --')
		DFrame1:SetSizable(true)
		DFrame1:SetDeleteOnClose(false)
		DFrame1:SetScreenLock( true )
		DFrame1:SetDraggable(false)
		DFrame1:SetBackgroundBlur(true)
		DFrame1:SetSizable(false)
		DFrame1:MakePopup()

		local DPanel2 = vgui.Create('DPanel', DFrame1)
		DPanel2:SetPos(5, 27)
		DPanel2:SetSize(490, 40)
		

		local DTextEntry1 = vgui.Create('DTextEntry',DPanel2)
		DTextEntry1:SetPos(5, 10)
		DTextEntry1:SetSize(390, 25)
		DTextEntry1:SetText('Enter the text for nick to say!')
		DTextEntry1.OnEnter = function()
			RunConsoleCommand( "ChatBot_OVERIDE", DTextEntry1:GetValue() )
			DFrame1:Close()
		end

		local DButton2 = vgui.Create('DButton',DPanel2)
		DButton2:SetPos(400, 10)
		DButton2:SetSize(70, 25)
		DButton2:SetText('OVERIDE')
		DButton2.DoClick = function()
			RunConsoleCommand( "ChatBot_OVERIDE", DTextEntry1:GetValue() )
			DFrame1:Close()
		end

	end

	concommand.Add("ChatBot_UI", OpenChatBotUI )
end