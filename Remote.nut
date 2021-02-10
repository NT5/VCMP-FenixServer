//Echo
class EchoInfo {
	MeIP = 0;
	NetName = null;
	Users = null;
	Chan = Config.Irc.Chan;
	CPass = Config.Irc.ChanPass;
	Nick = Config.Irc.User;
	Pass = Config.Irc.Password;
	Net = Config.Irc.NetIp;
	Port = Config.Irc.Port;
}
class icSpam { Count = 0; Text = null; Time =0 ; }
class EInfo { Name = null; Level = 0; }
Bot <- EchoInfo();
IRCCMDS <- ["4,!exe", "4,!pass", "0,!uptime", "0,!players", "0,!spree", "0,!server", "0,!stats", "0,!seen", "0,!pm"];
function ReconectEcho() {
	Socket.Delete();
	ConnectEcho();
}
function ConnectEcho() {
	if ( Config.Irc.Enable ) {
		print( "--- Confirming Details of Bot... ---" );
		iSpam <- array(51, null);
		for (local i=0; i<=50; i++){ iSpam[i] = icSpam(); }
		Socket <- NewSocket( "ParceData" );
		Socket.Connect( Bot.Net, Bot.Port );
		Socket.SetNewConnFunc( "Login" );
		Socket.SetLostConnFunc( "ReconectEcho" );
		print( "--- Details Confirmed! ---" );
	}
}
function KillBots() {
	if ( Config.Irc.Enable ) {
		print( "Disconnecting IRC Bot..." );
		Socket.Send( "QUIT " + Bot.Nick + "\n" );
		Socket.Delete();
		print(Bot.Nick+" Succesfully disconnected from IRC.");
	}
}
function Login() {
	print( "--- Connecting to "+Bot.Chan+"... ---" );
	Socket.Send( "USER " + Bot.Nick + " 0 * :"+Bot.Nick+" NT5 Echo Bot\n" );
	Socket.Send( "NICK " + Bot.Nick + "\n" ); 
	Socket.Send( "PRIVMSG NickServ IDENTIFY " + Bot.Pass + "\n" ); 
	NewTimer("JoinEcho", 2000,1);
}
function JoinEcho() {
	Socket.Send( "JOIN " + Bot.Chan + " " + Bot.CPass + "\n" );
	Socket.Send( "PRIVMSG NickServ IDENTIFY " + Bot.Pass + "\n" );
	Socket.Send( "MODE "+Bot.Nick+" +B\n" );
	print("--- Now Connected to "+Bot.Chan+" ---");
	Echo( "4---5> 10"+GetServerName()+" is now Connected 5<4---" );
}
function ParceData( data ) {
	local PING = GetTok( data, " ", 1 ), EVENT = GetTok( data, " ", 2 ), CHANEVENT = GetTok( data, " ", 3 ), Count = NumTok( data, " " );
	local Nick, Command, Prefix, Text;
	if ( PING == "PING") Socket.Send( "PONG " + PING + "\n" );
	if ( EVENT == "353" ) { Bot.Users=GetTok(data,":",2),Bot.Users=Bot.Users.slice(0,Bot.Users.len()-1); ExamineNicks(); }
	if (data.find("IP") && EVENT=="NOTICE" && !Bot.MeIP) { 
		Bot.MeIP = split(data, " ")[17];
		Bot.MeIP = split(Bot.MeIP, "()")[0];
		Bot.NetName = split(data, " ")[0].slice(1);
		EditSQConfig("server_ip", Bot.MeIP+":" + Config.Server.Port);
		EditSQConfig("bot_netname", Bot.NetName); 
	}
	if ( EVENT == "JOIN" ) {
	local msg1 = "(IRC)" + GetTok(data, "!", 1 ).slice( 1 )+" has joined " + Bot.Chan;
	msg( msg1, 200, 200, 0 );
	print( msg1 );
	}
	if ( EVENT == "PART" ) {
	local msg2="(IRC)"+GetTok(data,"!",1).slice(1)+" has left "+Bot.Chan;
	msg( msg2, 200, 200, 0 );
	print(msg2);
	}
	if ( EVENT == "NICK" ) {
	local msg3="(IRC)"+GetTok(data,"!",1).slice(1)+" is now known as "+GetTok(data," ",3),msg3=msg3.slice(0,msg3.len()-1);
	msg( msg3, 200, 200, 0 );
	print(msg3);
	}
	if ( EVENT == "KICK" ) {
	local nick=GetTok(data,"!",1).slice(1),knick=GetTok(data," ",4),reason=GetTok(data," ",5,Count);
	msg("(IRC)"+knick+" "+"was kicked by "+nick+" ( "+reason.slice(0,reason.len()-1)+" )",200,200,0);
	print("(IRC)"+knick+" "+"was kicked by "+nick+" Reason"+reason.slice(0,reason.len()-1));
	if (knick==Bot.Nick) Socket.Send("JOIN "+Bot.Chan+" "+Bot.CPass+"\n");
	}
	if ( EVENT == "QUIT" ) {
	local quit=GetTok(data," ",3,Count),msg4="(IRC)Quit: "+GetTok(data,"!",1).slice(1)+" ->"+quit.slice(0,quit.len()-1);
	local id=FindIrcUserID(GetTok(data,"!",1).slice(1));
	msg(msg4, 200, 200, 0 );
	print(msg4);
	}
	if ( EVENT == "MODE" ) {
	local msg5="(IRC)"+GetTok(data,"!",1).slice(1)+" Set Mode: "+GetTok(data," ",4,Count),msg5=msg5.slice(0,msg5.len()-1);
	msg(msg5,200,200,0);
	print(msg5);
	}
	if ( ( EVENT == "MODE" ) || ( EVENT == "KICK" ) || ( EVENT == "NICK" ) || ( EVENT == "JOIN" ) || ( EVENT == "PART" ) || ( EVENT == "QUIT" ) ) Socket.Send("NAMES :"+Bot.Chan+"\n");
	if ( CHANEVENT == Bot.Chan ) {
		Nick = GetTok( data, "!", 1 ).slice( 1 );
		local toc = GetTok( data, " ", 2 );
		if ( toc == "PRIVMSG") Command = GetTok( data, " ", 4 ).slice( 1 );
		if ( Command ) {
		if ( NumTok( data, " " ) > 4 ) Text = GetTok( data, " ", 5, Count );
		else Command = split( Command, "\r\n" )[ 0 ];
		if ( ( Count > 4 ) ) IrcCommand( Nick, Command, Text );
		else if ( Count == 4 ) IrcCommand( Nick, Command, null );
		}
	}
}
function EchoN( nick, text ) {
	if ( Config.Irc.Enable ) {
		Socket.Send( "NOTICE " + nick + " " + text + "\n" );
	}
}
function Echo( text ) {
	if ( Config.Irc.Enable ) {
		Socket.Send( "PRIVMSG " + Bot.Chan + " " + text + "\n" );
	}
}	
function IrcKick(user, reason) Socket.Send("KICK "+Bot.Chan+" "+user+" "+reason+" \n");
function ExamineNicks() {
local c,b,nicks=Bot.Users,a=0,nun=split(nicks," ").len(); IrcUsers<-array(51,null);
for (local i=0; i<=50; i++) { IrcUsers[i] = EInfo(); }
while ( a < nun ) {
b=split(nicks," ")[a];
if(b.slice(0,1) == "~") { b=b.slice(1); c=5 }
else if(b.slice(0,1) == "&") { b=b.slice(1); c=4 }
else if(b.slice(0,1) == "@") { b=b.slice(1); c=3 }
else if(b.slice(0,1) == "%") { b=b.slice(1); c=2 }
else if(b.slice(0,1) == "+") { b=b.slice(1); c=1 }
else { b=b; c=0; }
if(!IrcUsers[a].Name) { IrcUsers[a].Name=b; IrcUsers[a].Level=c; }
a++;
}}
function FindIrcUserName(id) return IrcUsers[id].Name
function FindIrcUserID(user) for (local a=0;a <= 50; a++) if (IrcUsers[a].Name == user) { return a; break;}
function SendIRCUsers(player) {
	if ( Config.Irc.Enable ) {
		PrivMessage( "IRC Users: "+Bot.Chan+": ",player); local buffer;
		for (local i=0,t=0; i<=50; i++,t++) {
			if(IrcUsers[i].Name) {
				if (t >= 15) { PrivMessage(buffer,player); buffer=""; t=0; }
				if (!buffer) buffer = IrcUsers[i].Name;
				else buffer = buffer+", "+IrcUsers[i].Name;
				if (buffer.slice(0,1) == ","  ) buffer=buffer.slice(2);
			}
		} 
		PrivMessage(buffer,player);
	}
	else PrivMessage("Irc Echo Channel is Offline.", player);
}
function IrcSpam(user,text) {
	local id = FindIrcUserID(user);
	iSpam[id].Count++;
	if (!iSpam[id].Text) iSpam[id].Text = text;
	if (!iSpam[id].Time) iSpam[id].Time = GetTime();
	if (iSpam[id].Count >= 3 && iSpam[id].Text == text && GetTime()-iSpam[id].Time <= 5) {
		IrcKick(user,"Spam "+iSpam[id].Count+"Reps, "+duration(GetTime() - iSpam[id].Time));
		iSpam[id].Count = 0; iSpam[id].Text = null; iSpam[id].Time = 0;
	}
	if (iSpam[id].Count >= 5 && GetTime()-iSpam[id].Time >= 5) { iSpam[id].Count = 0; iSpam[id].Text = null; iSpam[id].Time = 0; }
}
function IrcCommand( user, cmd, text ) {
	if (cmd && text) IrcSpam(user,cmd+" "+text);
	else IrcSpam(user,cmd);
	local level = IrcUsers[FindIrcUserID(user)].Level;
	if (!level) level=0;
	if (text) text=text.slice(0,text.len()-2);
	if (!cmd) cmd=" ";

	if (cmd=="ACTION") {
		if (text.slice(0,text.len()-1).find(Bot.Nick)) IrcKick(user,"Oopss!");
		msg("(IRC)"+user+" "+text.slice(0,text.len()-1),200,0,200); print("(IRC)"+user+" "+text.slice(0,text.len()-1)); 
	}
	if (cmd.slice(0,1) != "!") {
		if (cmd && text) { msg("(IRC)"+user+": "+cmd+" "+text,200,200,0); print("(IRC)"+user+": "+cmd+" "+text); }
		else if (cmd) { msg("(IRC)"+user+": "+cmd,200,200,0); print("(IRC)"+user+": "+cmd); }
	}
	if (cmd.slice(0,1) == "!") {
	local cmdlevel = 0;
	for (local i = 0; i < IRCCMDS.len(); i++) {
	if (IRCCMDS[i].slice(2,IRCCMDS[i].len()) == cmd) { cmdlevel = IRCCMDS[i].slice(0,1).tointeger();break;}
	}
	if (level >= cmdlevel) {
	
	if ( cmd == "!commands" || cmd == "!cmds" ) {
	local ml=level,l,t=0,buffer;
	while ( t < IRCCMDS.len() ) {
	l=IRCCMDS[t].slice(0,1);
	if (ml.tointeger()>=l.tointeger()) {
	if (!buffer) buffer=IRCCMDS[t].slice(2);
	else buffer=buffer+", "+IRCCMDS[t].slice(2); } 
	t++; } 
	if(buffer) EchoN(user,"All Commands: "+buffer);
	else EchoN(user,"No Commands Available for You") }
	
	else if ( cmd == "!exe" ) {
	if ( !text ) EchoN( user,"Correct Syntax: "+cmd+" <code>");
	else if (text.find("~")) EchoN(user,"Please do Not use Special Characters.");
	else {
		try {
			local script = compilestring(text);
			script();
		}
		catch(e) { Echo("4Error: "+e+".");}
		}
	}
	
	else if ( cmd == "!pass" ) {
	local param = text;
	if ( param ) {
	if (GetPassword() == param) EchoN(user,"Error the pass is allredy "+param);
	else {
		SetPassword(param);
		Echo( "10>> Server password was changed to:1 "+param );
		msg( ">> Server password was changed to: "+param,0,250,0);
		}
	}
	else {
		if (GetPassword() == "none") EchoN(user,"Error the Pass is allready turner off");
		else {
			Echo( "10>> Server password was turned off" );
			msg( ">> Server password was turned off",0,250,0);
			SetPassword();
			}
		}
	}
	
	else if ( cmd == "!players" ) {
		local b=null;
		for (local a=0; a<GetMaxPlayers(); a++) {
			local plr = FindPlayer( a.tointeger() );
			if ( plr ) {
				if ( b ) b = b + ", ["+plr.ID+"] " + plr.Name
				else b = "["+plr.ID+"] " + plr.Name
			}
		}
		if ( b ) Echo( "2-> 12Players: 5[" + GetPlayers() + "/" + GetMaxPlayers() + "] " + " - " + b  );
		else Echo( "4> No Players On The Server." );
	}
	
	else if ( cmd == "!spree" ) {
	local a = 0, b = null;
	while ( a < GetMaxPlayers() ) {
	local plr = FindPlayer( a );
	if ( plr ) {
		if (PlayerLocal[plr.ID]) {
			local spree =  PlayerLocal[plr.ID].Spree;
			if ( spree >= 5 ) {
			if ( b ) b = b + " - " + plr.Name + " (" + spree + ")";
			else b = plr.Name + " (" + spree + ")";
			}
		}
	}
	a ++;
	}
	if ( b ) { 
		Echo( "2-> 12Players in spree: 1" + b ); 
		print( "-> Players in spree:" + b );
		msg( "-> Players in spree:" + b, 0, 200, 0 );
	}
	else {
		Echo( "5-> No Players in killing Spree." );
		print( "-> No Players In Killing Spree." );
		msg( "-> No Players In Killing Spree.", 200, 0, 0 );
	}
	}
	
	else if (cmd == "!server") {
	Echo("7>10 Server Name: ["+GetServerName()+"] GameMode: ["+GetGamemodeName()+"] IP:["+Bot.MeIP+":"+Config.Server.Port+"] Players: ["+GetPlayers()+"/"+GetMaxPlayers()+"] Password: ["+GetPassword()+"]");
	}
	
	else if ( cmd == "!uptime" ) Echo( "5Server Online Time:1 "+duration(GetTime() - Server.UpTime));
	
	else if ( cmd == "!seen" ) {
	if (!text) EchoN(user,cmd+" <FullName>");
	else {
		local player = ( GetPlayer( text ) ? GetPlayer( text ):text );
		if (!ExistUser(player)) EchoN(user,"Not Registered NickName.");
		else {
			player = FetchUserInfo(player);
			Echo("10>> 1"+player["name"]+"10 last join: "+duration(GetTime() - player["lastactive"])+" Register: "+player["datereg"]);
			}
		}
	}
	
	else if (cmd == "!stats"){
	if ( !text ) EchoN(user,"Error - Invalid Format "+cmd+" <fullnick>");
	else {
		local plr = ( GetPlayer( text ) ? GetPlayer( text ):text );
		if (!ExistUser(plr)) {
			local msgs = " Not registered nick name.";
			msg( "* " + text + msgs, 200, 0, 0 ); 
			print( "* " + text + msgs );
			Echo( "*3 " + text + msgs );
		}
		else {
			local p = "";
			if (GetPlayer(text)) { p = PlayerInfo[GetPlayer(text).ID]; } else { p = FetchUserInfo(text); }
			local kills = p["kills"], deaths = p["deaths"], joins = p["joins"], spree = p["spree"], pickups = p["pickups"], ratio, show;
			if (kills > 0 && deaths > 0) { ratio = kills.tofloat() / deaths.tofloat(); ratio = format("%.2f",ratio); }
			if ( ratio ) {
				show = "* Stats: "+p["name"]+", Joins: "+joins+", Kills: "+kills+" ("+RankTag(0,kills)+") Deaths: "+deaths+" Spree's: "+spree+", Pickups: "+pickups+" ("+RankTag(1,pickups)+") Ratio: "+ratio;
				msg( show, 139, 69, 19 ); Echo("5"+show); print(show);
			}
			else {
				show = "* Stats: "+p["name"]+", Joins: "+joins+", Kills: "+kills+" ("+RankTag(0,kills)+") Deaths: "+deaths+" Spree's: "+spree+", Pickups: "+pickups+" ("+RankTag(1,pickups)+")";
				msg( show, 139, 69, 19 ); Echo( "5" + show); print( show );
				}
			}
		}	
	}
	
	else if ( cmd == "!pm" ) {
	if ( !text ) EchoN(user,"Error -Require Syntax: "+cmd+" <name><messege>");
	else if (text.find("~")) EchoN(user,"Please do Not use Special Characters.");
	else {
		local msg = GetTok( text, " ", 2,NumTok( text, " "));
		local plr = GetPlayer( GetTok( text, " ", 1 ) );
		if ( !msg ) EchoN(user,"Require Syntax: "+cmd+" <name><messege>");
		else if ( !plr ) EchoN(user,"Error - Invalid Nick/ID.");
		else {  
			EchoN(user,"PM Sent to: "+plr+", '"+msg+"'");
			PrivMessage("(IRC) "+user+": "+msg+"." plr);
			Announce("~b~read~t~mp",plr);
		}
		}
	}
	
	else EchoN(user,"Error - Invalid Command.");
	}
	else {EchoN( user,"Not Have Access To this Command!");}
}}
//Console
function onConsoleInput( cmd, text ) {

	if ( cmd == "!exe" ) {
		if ( !text ) print("Correct Syntax: "+cmd+" <code>");
		else {
			try {
				local script = compilestring(text);
				script();
			}
		catch(e) { 
			print("Error: "+e+".");
			} 
		} 
	}
	
	else {
	if ( cmd == cmd ) {		
		if( !text )  {
			Echo( "5(3Console5) 3Admin: 1" + cmd );
			msg( "(Console) Admin: " + cmd, 200, 200, 0 );
		}
		else {
			Echo( "5(3Console5) 3Admin: 1" + cmd + " " + text );
			msg( "(Console) Admin: " + cmd + " " + text, 200, 200, 0 );
			}
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function GetTok(string, separator, n, ...) {
	local m=vargv.len()>0?vargv[0]:n,tokenized=split(string,separator),text="";
	if (n > tokenized.len() || n < 1) return null;
	for (; n <= m; n++) {
		text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
	} return text; 
}
function NumTok(string, separator) return split(string,separator).len();
/*=====================================================================
	                       Json Map Script
=====================================================================*/
Json <- {
	Socket = null,
	Client = array( 0 ),
	Config = {
		Port = 80
	}
};

Map <- {
	Players = {},
	Messages = class {
		Data = [];
		Add = function( msg ) {
			local max = 15;
			this.Data.append( msg );
			if ( this.Data.len() > max ) {
				this.Data.remove(0);
			}
		};
	}
};

function json_start( ... ) {
	Json.Socket = NewSocket( json_listen );
	Json.Socket.Start( ( vargv.len() > 0 ? vargv[ 0 ]:Json.Config.Port ), 1 );
	Json.Socket.SetNewConnFunc( json_connection );
	Json.Socket.SetLostConnFunc( json_stop );
}

function json_disconnect(){
	if( Json.Socket ) {
		Json.Socket.Stop();
		if( Json.Socket ) {
			Json.Socket.Delete();
		}
		foreach( id, key in Json.Client ){
			Json.Socket.Close( Json.Client[ id ] );
		}
	}	
}

function json_connection( client, ip, port ) {
	Json.Client.append( client );
}

function json_stop( client, ip, port ) {
	foreach( id, key in Json.Client ) {
		if( Json.Client[ id ] == client ) {
			Json.Client.remove( id );
			break;
		}
	}
}

function json_listen( client, data ) {
	local data_s = split( data, " " );
	
	if ( data_s[ 0 ] == "GET" && data_s[ 1 ] == "/data.json" ) {
		local output = {
			server = {
				name = GetServerName(),
				time = { hour = GetHour(), minute = GetMinute() },
				weather = GetWeather(),
				numplayers = GetPlayers(),
				maxplayers = GetMaxPlayers()
			},
			players = [],
			messages = Map.Messages.Data.len() > 0 ? Map.Messages.Data:[]
		};
		if ( Map.Players.len() > 0 ) {
			local buffer;
			foreach( plr in Map.Players ){
				buffer = {
					id = plr.ID,
					name = plr.Name,
					skin = plr.Skin,
					team = plr.Team,
					health = plr.Health,
					armour = plr.Armour,
					score = plr.Score,
					cash = plr.Cash,
					ping = plr.Ping,
					weapon = plr.Weapon,
					vehicle = ( plr.Vehicle ? { model = plr.Vehicle.Model, health = plr.Vehicle.Health, color = [ plr.Vehicle.Colour1, plr.Vehicle.Colour2 ] }:null ),
					pos = { x = plr.Pos.x, y = plr.Pos.y },
					spawned = plr.IsSpawned
				}
				output.players.push( buffer );
			}
		}
		
		local json_send, encode = json_encode( output );
		json_send = "HTTP/1.1 200 OK\r\n";
		json_send += "Access-Control-Allow-Origin: *\r\n";
		json_send += "Content-Type: application/json\r\n";
		json_send += "Connection: close\r\n";
		json_send += "\r\n\r\n";
		
		Json.Socket.SendClient( json_send, client );
		
		foreach( e in encode ) {
			Json.Socket.SendClient( e, client );
		}
	}
	else {
		local json_send;
		json_send = "HTTP/1.1 404 Not Found\r\n";
		json_send += "Connection: close\r\n";
		json_send += "Server: Json-Squirrel v0.1\r\n";
		json_send += "\r\n\r\n";
		json_send += "<h1>404 Not Found</h1>\r\n\r\n";

		Json.Socket.SendClient( json_send, client );
	}
	
	Json.Socket.Close( client );
}

function json_encode( object, ... ) {
	local buffer = [], count = { table = 0, total = 0 }, brakets = vargv.len() > 0 ? false:true;

	function item_parse( item ) {
		local item = { type = type( item ), data = item };
		switch( item.type ) {
			case "table":
				local returned, response = json_encode( item.data );
				foreach( e in response ) returned = returned ? returned+e:e;
				return returned ? returned:"";
			break;
			case "array":
				local returned;
				foreach( e in item.data ) returned = ( returned ? returned+","+item_parse(e):item_parse(e) );
				return "["+(returned ? returned:"")+"]";
			break;
			case "bool":
				return item.data.tostring();
			break;
			case "null":
				return "null";
			break;
			case "string":
				local returned = function(){local b=""; foreach(e in item.data) {b+=[34].find(e)==null?e.tochar():""} return b;};
				return "\"" + returned() + "\"";
			break;
			default:
				return item.data;
			break;
		}
	}
	
	if( typeof object == "table" ) {
		if ( brakets ) {
			buffer.push( "{" );
		}
		foreach( key, item in object ) {
			if ( typeof item == "table" ) {
				count.table++;
				buffer.push( "\"" + key + "\":" );
				local returned = json_encode( item );
				foreach( x in returned ) {
					buffer.push( x );
				}
				if ( object.len() > (count.total + count.table) ){
					buffer.push( "," );
				}
			}
			else{
				count.total++;
				buffer.push( "\"" + key + "\":" + item_parse( item ) + ( object.len() > (count.total + count.table) ? ",":"" ) );
			}
		}
		if ( brakets ){
			buffer.push( "}" );
		}
	}
	return buffer;
}