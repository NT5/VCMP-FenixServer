//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
//Config
function ReadConfig(param, text) { local File = XmlDocument("data/Server.xml"); return (File.LoadFile() ? File.FirstChild("Server").FirstChild(param).FirstChild(text).Text:null); }
function sReadConfig(param, text) { local File = XmlDocument("server.conf"); return (File.LoadFile() ? File.FirstChild(param).FirstChild(text).Text:null); }
Config <- {
	Server = {
		Name = ReadConfig("config", "name"),
		GameMode = ReadConfig("config", "gamemode"),
		Prefix = ReadConfig("config", "cmdprefix"),
		Port = sReadConfig("Settings", "ListenPort"),
		MaxPlayers = ReadConfig("config", "maxplayers").tointeger(),
		MaxProps = ReadConfig("config", "maxprops").tointeger(),
		MaxCars = ReadConfig("config", "maxcars").tointeger(),
		MaxGotolocs = ReadConfig("config", "maxgotolocs").tointeger(),
		Password = ReadConfig("config", "pass"),
		News = ReadConfig("config", "news")
	},
	Json = {
		Enable = ( ReadConfig("json", "enable") == "true" ? true:false ),
		Port = ReadConfig("json", "port").tointeger()
	},
	Irc = {
		Enable = ( ReadConfig("irc", "enable") == "true" ? true:false ),
		NetIp = ReadConfig("irc", "ip"),
		Port = ReadConfig("irc", "port").tointeger(),
		User = ReadConfig("irc", "user"),
		Password = ReadConfig("irc", "pass"),
		Chan = ReadConfig("irc", "channel"),
		ChanPass = ReadConfig("irc", "chanpass")
	},
	MySQL = {
		Enable = ( ReadConfig("sql", "enable") == "true" ? true:false ),
		Host = ReadConfig("sql", "host"),
		User = ReadConfig("sql", "user"),
		Pass = ReadConfig("sql", "pass"),
		Database = ReadConfig("sql", "database")
	}
}
//Vars
Server <- { 
	UpTime = GetTime(), 
	CountDown = 0, 
	WeaterChange = 0, 
	OpenStore = true,
	Commands = [],
	Main = {
		Timer = null,
		Last = GetTime()
	},
	Hunt = {
		Started = false,
		Player = null,
		Time = 0,
		Rewar = 0
	},
	ADRound = {
		Started = false,
		Players = {},
		Bases = [],
		Teams = [ "Red", "Blue" ],
		Score = array( 2, 0 ),
		Time = 0
	},
	Races = {
		Started = false,
		Players = {},
		Tracks = [],
		Time = 0
	}
	cKing = {
		Started = false,
		jPlayers = false,
		Players = null,
		onPlay = 0,
		Pickup = null,
		Bases = [],
		Rewar = 0,
		Time = 0
	},
	rBank = {
		Started = false,
		Rewar = 0,
		Time = 0,
		Checks = []
	},
	Cars = 0,
	Props = 0,
	WepB = 0
};
class pLocal {
	Spree = 0;
	onEvent = false;
	onArena = null;
	cKing = [];
	Race = [];
	ADRound = [];
	IsDrunk = false;
	Hide = false;
	TimePlay = 0;
	LastPos = 0;
	Waiting = null;
	Speedo = null;
	Stunt = null;
};
class cSpam { 
	Wait = 0;
	Count = 0;
	Text = null;
	Time = 0; 
};

//Functions
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function pmsg ( text, player, r, g, b ) ClientMessage( text, player, r, g, b );
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function msg(text, r, g, b) ClientMessageToAll( text, r, g, b );
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function onTimeChange( hr, min ) {
	Main();
}
function Main() {
	if ( GetPlayers() > 0 ){
	
		local rPlr, rAc, pInfo;
		foreach( plr in players ) {
				if ( PlayerInfo[plr.ID] && plr.IsSpawned ) {
				
					rPlr = ( RandNum(0,2) && !rPlr ? plr:null);
					pInfo = PlayerInfo[plr.ID];
					
					if ( plr.Vehicle ) {
						local speed;
						if ( pInfo.Local.Speedo ) {
							local param = split( pInfo.Local.Speedo, " " );
							speed = sqrt( ( plr.Pos.x-param[0].tofloat())*(plr.Pos.x-param[0].tofloat())+(plr.Pos.y-param[1].tofloat())*(plr.Pos.y-param[1].tofloat())+(plr.Pos.z-param[2].tofloat())*(plr.Pos.z-param[2].tofloat()) ) * 2.8;
							Announce( format( "~b~K~p~p~y~H: ~b~ %i", speed ), plr, 1 );
							pInfo.Local.Speedo = format("%.4f %.4f %.4f", plr.Pos.x, plr.Pos.y, plr.Pos.z );
						}
						if ( pInfo.Local.Stunt ) {
							if ( GetVehicleType( plr.Vehicle.Model, 1 ) == 3 || GetVehicleType( plr.Vehicle.Model, 1 ) == 6 ) {
								local ThePos = plr.Pos.z.tointeger();
								local oldpos = split( pInfo.Local.Stunt, " ")[0].tointeger();
								local Theoldpos = split( pInfo.Local.Stunt, " ")[1].tointeger()+1;
								local Thealture = split( pInfo.Local.Stunt, " ")[2].tointeger()+1;
								local gan = Theoldpos + Thealture;
								oldpos += 2;
								
								if ( oldpos < ThePos ) {
									Announce( "~t~\x10 \x10 \x10 \x10 \x10 \x10 stunt $" + mformat( gan ), plr );
									plr.Cash += gan;
									pInfo.cash += gan;
									pInfo.Local.Stunt = format( "%i 0 0", plr.Pos.z );
								}
								else pInfo.Local.Stunt = format( "%i %i %i", plr.Pos.z, Theoldpos, Thealture );
							}
						}
						if ( Vehicles[plr.Vehicle.ID].Local.Gas >= 0 && speed > 0 ) {
							if ( GetTime() - Vehicles[plr.Vehicle.ID].Local.LastUse >= 35 ) {
								Vehicles[plr.Vehicle.ID].Local.Gas--;
								Vehicles[plr.Vehicle.ID].Local.LastUse = GetTime();
								
								if ( Vehicles[plr.Vehicle.ID].Local.Gas < 5 ) {
									pmsg( format( "> Danger! Low Gasoline - %s - %i Gal.", RateVar( Vehicles[plr.Vehicle.ID].Local.Gas ), Vehicles[plr.Vehicle.ID].Local.Gas ), plr, 200, 0, 0 );
								}
								
								if ( Vehicles[plr.Vehicle.ID].Local.Gas <= 0 ) {
									plr.Vehicle.KillEngine();
								}
							}
						}
					}
					
					if ( Server.cKing.Started )	{
						if ( Server.cKing.Players.len() > 0 ) {
							if ( Server.cKing.Players.rawin( plr.Name ) ) {
								local sp = split( Server.cKing.Bases[ Server.cKing.onPlay ], " " ), x = sp[0].tofloat(), y = sp[1].tofloat(), z = sp[2].tofloat(), d;
								d = sqrt((x-plr.Pos.x)*(x-plr.Pos.x)+(y-plr.Pos.y)*(y-plr.Pos.y)+(z-plr.Pos.z)*(z-plr.Pos.z));
								if ( d <= 5 ) {
									ShowMsg( "> "+plr.Name+" go score!", 4, 1 );
								}
								else if ( d > 120 ) {
									ShowMsg( "> "+plr.Name+" descalifacado del evento.", 4, 1 );
									Server.cKing.Players.rawdelete( plr.Name );
								}
							}
						}
					}
					
					if ( pInfo.Local.onArena ) {
						local sp = split( pInfo.Local.onArena, "," ), sP = split(sp[1], " "), x = sP[0].tofloat(), y = sP[1].tofloat(), z = sP[2].tofloat(), d;
						d = sqrt((x-plr.Pos.x)*(x-plr.Pos.x)+(y-plr.Pos.y)*(y-plr.Pos.y)+(z-plr.Pos.z)*(z-plr.Pos.z));
						if ( d > 120 ) {
							Announce("rejoin to arena", plr);
							plr.Pos = Vector( x, y, z );
						}	
					}
					if ( pInfo.Local.Waiting ) {
						if ( GetTime() - pInfo.Local.Waiting[0] >= 5 ) {
							switch( pInfo.Local.Waiting[1] ) {
								case 0:
									local Cost = pInfo.Local.Waiting[3];
									if ( Cost == 0 ) PrivMessage("Heal Free!", plr);
									msg( "* " + plr.Name +" Healed Cost: $" + Cost, 255, 255, 0 );
									Echo( "7* " + plr.Name + " Healed Cost: $" + Cost );
									PlayerInfo[plr.ID]["cash"] -= Cost;
									plr.Cash -= Cost;
									plr.Health = 100;
									plr.IsFrozen = false;
								break;
								case 1:
									local cost = pInfo.Local.Waiting[3], gplr = pInfo.Local.Waiting[4];
									msg( "* " + plr + " has teleported to " + gplr + " for $" + mformat( cost ), 34, 139, 34 );
									Echo( "10* " + plr + " has teleported to " + gplr + " for $" + mformat( cost ) );
									PrivMessage( plr + " teleport to you.", gplr );
									PlayerInfo[plr.ID]["cash"] -= cost;
									plr.Cash -= cost;
									plr.Pos = gplr.Pos;
									plr.IsFrozen = false;
								break;
								case 2:
									local gt = pInfo.Local.Waiting[3], name = gt["name"], crt = gt["creator"], pos = split(gt["pos"], " ");
									plr.Pos = Vector( pos[0].tofloat(), pos[1].tofloat(), pos[2].tofloat() );
									PrivMessage(">> Location: " + name + " - Creator: " + crt + ".", plr );
									plr.IsFrozen = false;
								break;
							}
							pInfo.Local.Waiting = null;
						}
					}
				}
			}
			
		if ( Server.cKing.Started )	{
			if ( GetTime() - Server.cKing.Time >= 60 && Server.cKing.Players.len() <= 0 ) {
				KingC( 2, "Nobody join to event." );
			}
			else if ( Server.cKing.jPlayers && Server.cKing.Players.len() > 0 && GetTime() - Server.cKing.Time >= 60 ) {
				ShowMsg( "King of the hill starter! 3min to finished.", 4 , 1 );
				Server.cKing.jPlayers = false;
				Server.cKing.Time = GetTime();
			}
			else if ( GetTime() - Server.cKing.Time >= 180 && !Server.cKing.jPlayers ) {
				KingC( 2, "nadie iso el tiempo requerido para ganar." );
			}
		}
		
		
		if ( GetTime() - Server.Main.Last >= 300 ) {
			
			rAc = RandNum( 0, 5 );
			
			ShowMsg( "> " + Messages[RandNum(0,Messages.len())], 3, 0 );
			
			if ( Server.Hunt.Started ) {
			local rtime = 900 - ( GetTime() - Server.Hunt.Time );
			if ( rtime > 0 ) {
				ShowMsg( "[Hunt Status] Remaining time: " + duration( rtime ) + " Player: " + Server.Hunt.Player.Name + " Reward: $"+Server.Hunt.Rewar, 4, 0 );
				PrivMessage( "Reward for surviving the hunt: $50", Server.Hunt.Player );
				PlayerInfo[Server.Hunt.Player.ID]["cash"] += 50;
				Server.Hunt.Player.Cash += 50;
			}
			else {
				ManHunt( 1 );
				}
			}
			
			if ( Server.rBank.Started ) {
				local rtime = 120 - ( GetTime() - Server.rBank.Time );
				if ( rtime > 0 ) {
					ShowMsg( "[Rob Bank Status] Remaining time: " + duration( rtime ) + " Reward: $"+Server.rBank.Rewar, 4, 0 );
				}
				else {
					RobBank( 2, "Nobody Rob The Bank." );
				}
			}
			
			if ( rPlr && rAc && GetPlayers() >= 2 ) {
				switch( rAc ) {
					
					case 1:
						PlayerInfo[rPlr.ID]["cash"] += 50;
						rPlr.Cash += 50;
						PrivMessage("Thanks for playing on the server take $50", rPlr);
					break;
					
					case 2:
						if ( !Server.Hunt.Started ) {
							if ( rPlr.IsSpawned && PlayerInfo[rPlr.ID] ) {
								ManHunt(0, rPlr);
							}
						}
					break;
					
					case 3:
						local rwep = RandWep();
						Server.WepB = rwep;
						AnnounceAll( GetWeaponName( rwep ) + " time" );
						ShowMsg("> " + GetWeaponName( rwep ) + " time! kill with this weapon and get bonus!!", 10, 0);
						SetWeaponto( "all", rwep );
					break;
					
					case 4:
						RobBank( 1 );
					break;
					
					default:
						PlayerInfo[rPlr.ID]["cookies"] += 1;
						PrivMessage("Has been chosen! Have a cookie!", rPlr);
						Announce("cookie!", rPlr);
					break;
				}
			}
			Server.Main.Last = GetTime();
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function ShowMsg( text, colr, ... ) {
	local cl = "";
	switch( colr ) {
		case 0: 
			cl = "0,255-255-255"; //Blanco
			break;
		case 1: 
			cl = "1,0-0-0"; //Negro
			break;
		case 2: 
			cl = "2,25-25-112"; //Azul Fuerte
			break;
		case 3: 
			cl = "3,0-100-0"; //Verde
			break;
		case 4: 
			cl = "4,255-0-0"; //Rojo
			break;
		case 5: 
			cl = "5,139-69-19"; //Cafe
			break;
		case 6: 
			cl = "6,160-32-240"; //Purpura
			break;
		case 7: 
			cl = "7,255-165-0"; //Naranja
			break;
		case 8: 
			cl = "8,255-255-0"; //Amarillo
			break;
		case 9: 
			cl = "8,34-139-34"; //Verde Claro
			break;
		case 10: 
			cl = "10,95-158-160"; //Celeste Oscuro
			break;
		case 11: 
			cl = "11,0-255-255"; //Celeste
			break;
		case 12: 
			cl = "12,0-191-255"; //Azul Claro
			break;
		case 13: 
			cl = "13,255-192-203"; //Rosado
			break;
		case 14: 
			cl = "14,131-139-131"; //Gris Oscuro
			break;
		case 15: 
			cl = "15,193-205-193"; //Gris Claro
			break;
		default: 
			cl = "10,95-158-160";
			break;
	}
	local sp = split(cl,","), r, g, b, sp2 = split(sp[1],"-");
	r = sp2[0].tointeger();
	g = sp2[1].tointeger();
	b = sp2[2].tointeger();
	Echo( sp[0] + text );
	ClientMessageToAll( text, r, g, b );
	if ( vargv.len() > 0 ) print( text );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function AutoKick( player, reason ) {
	ShowMsg( "> Auto-Kick:[ " + player.Name + " ] Reason:[ " + reason + " ]",4, 1 );
	onPlayerPart( player, 2 );
	KickPlayer( player );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function IsBanned( player ) {
	foreach( i in Banneds ) {
		if (i["banned"] == player.Name || i["ip"] == player.IP) return i;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function SetKickPlayer( player, ... ) {
	local reason = ( vargv.len() >= 1 ? vargv[0]:"None" );
	ShowMsg( "> Kick:[ "+player+" ] Reason:[ "+reason+" ]", 4, 1 );
	onPlayerPart( player, 2 );
	KickPlayer( player );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function SetBanPlayer( banned, admin, ... ) {
	local reason = ( vargv.len() >= 1 ? vargv[0]:"None" );
	Banneds.rawset( banned.Name, { banned = banned.Name, admin = admin, reason = reason, time = GetFullTime(), ip = banned.IP } );
	local sql = "INSERT INTO bans (banned, admin, reason, time, ip) VALUES ('"+banned.Name+"', '"+admin+"', '"+reason+"', '"+GetFullTime()+"','"+banned.IP+"')"
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		sql = mysql_query(my_db, sql);
		mysql_free_result( sql );
		
	}
	else {
		sql = QuerySQL( sqlite, sql );
		FreeSQLQuery( sql );
	}
	SetKickPlayer( banned, "Banned" );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function DelBanPlayer( banned ) {
	if ( Banneds.rawin( banned ) ) {
		local sql = "DELETE FROM bans WHERE banned = '"+banned+"'";
		Banneds.rawdelete( banned );
		if ( Config.MySQL.Enable ) {
			CheckSqlConect();
			mysql_query( my_db, sql );
		}
		else {
			QuerySQL( sqlite, sql );
		}
		return true;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function ServerSpam(player, text) {
	local id = player.ID
	Spam[id].Count++;
	if (!Spam[id].Text) Spam[id].Text = text;
	if (!Spam[id].Time) Spam[id].Time = GetTime();
		if (Spam[id].Count >= 3 && Spam[id].Text == text && GetTime()-Spam[id].Time <= 5) {
		local show = ">> Auto Mute ["+player+"] Reason: [Spam "+Spam[id].Count+"Reps, "+duration(GetTime() - Spam[id].Time)+"] Time: 30segs.";
		msg(show,200,0,0);
		Echo("4"+show);
		print(show);
		player.IsMuted = true;
		Spam[id].Wait = GetTime();
		Spam[id].Count = 0; Spam[id].Text = null; Spam[id].Time = 0;
	}
	if (Spam[id].Count >= 5 && GetTime()-Spam[id].Time >= 5) { Spam[id].Count = 0; Spam[id].Text = null; Spam[id].Time = 0; }
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function AutoKill( player, ... ) {
	local reason = ( vargv.len() > 0 ? vargv[0]:"Unknown" );
	ShowMsg( "> Auto-Kill:[ " + player.Name + " ] Reason:[ " + reason + " ]", 4, 1 );		
	player.Health = 0;
	if ( player.Vehicle ) player.Pos = player.Pos;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function ManHunt( x, ... ) {
	local plr = ( vargv.len() > 0 ? vargv[0]:null );
	switch( x ) {
	case 0:
		if ( plr ) {
			local rw = RandNum( 500, 1000 );
			ShowMsg("Activate!, Man Hunt: " + plr.Name + ", Duration:[ 15min ], Reward:$ " + mformat( rw ) + ", to check remaining time type !hunted", 4, 0);
			PrivMessage("You are hunted! run for your life!", plr);
			AnnounceAll( "kill " + plr.Name );
			Server.Hunt.Started = true;
			Server.Hunt.Player = plr;
			Server.Hunt.Time = GetTime();
			Server.Hunt.Rewar = rw;
		}
	break;
	case 1:
		ShowMsg("Fail Man Hunt: " + Server.Hunt.Player.Name + ", nobody wanted the reward.", 4, 0 );
		Server.Hunt.Started = false;
		Server.Hunt.Player = null;
		Server.Hunt.Time = 0;
		Server.Hunt.Rewar = 0;
	break;
	case 2:
			local reason = ( vargv.len() > 0 ? vargv[0]:"Unknown" );
			ShowMsg( "Man Hunt: " + Server.Hunt.Player.Name + " finished!, Reason:[ " + reason + " ] type !hunt to start again.", 4, 0 );
			Server.Hunt.Started = false;
			Server.Hunt.Player = null;
			Server.Hunt.Time = 0;
			Server.Hunt.Rewar = 0;
	break;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function RobBank( x, ... ) {
	switch( x ) {
		case 1:
			if ( !Server.rBank.Started ) {
				local id = RandNum(0, Server.rBank.Checks.len()), rewar = RandNum( 500, 1001 );
				ShowMsg("> The Bank is now open to rob!, go search the money!! Time: 2min Reward: $"+rewar, 4, 1);
				Server.rBank.Started = true;
				Server.rBank.Rewar = rewar;
				Server.rBank.Time = GetTime();
				local p = split( Server.rBank.Checks[id], " ");
				CreatePickup( 408, Vector( p[0].tofloat(), p[1].tofloat(), p[2].tofloat() ) );
			}
		break;
		case 2:
			if ( Server.rBank.Started ) {
				local reason = ( vargv.len() > 0 ? vargv[0]:"Unknown" );
				ShowMsg( "Rob Bank Closed!, Reason:[ " + reason + " ]", 4, 1 );
				Server.rBank.Started = false;
				Server.rBank.Time = 0;
				Server.rBank.Rewar = 0;
			}
		break;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function KingC( x, ... ) {
	switch( x ) {
		case 1:
			if ( !Server.cKing.Started ) {
				local id = RandNum(0, Server.cKing.Bases.len()), rewar = RandNum( 500, 1001 );
				ShowMsg( "> King of the Hill is now open!, type !join hill To prove you're the best! Time: 1min Reward: $"+rewar, 4, 1 );
				local sp = split( Server.cKing.Bases[id], " ");
				CreatePickup( 338, Vector( sp[0].tofloat(), sp[1].tofloat(), sp[2].tofloat() ) );
				Server.cKing.Started = true;
				Server.cKing.jPlayers = true;
				Server.cKing.Pickup = FindPickup( GetPickupCount() );
				Server.cKing.onPlay = id;
				Server.cKing.Time = GetTime();
				Server.cKing.Rewar = rewar;
				Server.cKing.Players = {};
			}
		break;
		
		case 2:
			if ( Server.cKing.Started ) {
				local reason = ( vargv.len() > 0 ? vargv[0]:"Unknown" );
				ShowMsg( "King of the Hill Closed!, Reason:[ " + reason + " ]", 4, 1 );
				Server.cKing.Started = false;
				Server.cKing.Pickup.Remove();
				Server.cKing.Time = 0;
				Server.cKing.Rewar = 0;
				Server.cKing.Players = null;
			}
		break;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function RandNum(start, finish) return ( start < 0 ? ((rand()%(-start+finish))+start):((rand()%(finish-start))+start));
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function RandWep() {
	for( local i = 0, r, to; ; i++ ) {
		r = RandNum( 0, 33 );
		to = ( ValidWep( r ) ? r:null );
		if ( to ) { 
			return r;
			break; 
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function SetWeaponto( x, wep ) {
	if ( x == "all" ) {
		foreach( plr in players ) {
			if ( plr.IsSpawned  && PlayerInfo[plr.ID] ) {
					plr.SetWeapon( wep, 900 );
			}
		}
	}
	else {
		x.SetWeapon( wep, 900 );
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function RateVar( amount ) {
	local b;
	if ( amount >= 100 ) b = "[IIIIIIIIII]";
	else if ( amount >= 90 ) b = "[IIIIIIIII-]";
	else if ( amount >= 80 ) b = "[IIIIIIII--]";
	else if ( amount >= 70 ) b = "[IIIIIII---]";
	else if ( amount >= 60 ) b = "[IIIIII----]";
	else if ( amount >= 50 ) b = "[IIIII-----]";
	else if ( amount >= 40 ) b = "[IIII------]";
	else if ( amount >= 30 ) b = "[III-------]";
	else if ( amount >= 20 ) b = "[II--------]";
	else if ( amount >= 10 ) b = "[I---------]";
	else b  = "[----------]";
	return b;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function RankTag( x, level ) {
	switch ( x ) {
		case 0:
			if ( level <= 99 ) return "Newbie";
			else if ( level <= 199 ) return "Killer";
			else if ( level <= 299 ) return "Extreme Killer";
			else if ( level <= 399 ) return "Psycho";
			else if ( level <= 499 ) return "Professional";
			else if ( level <= 999 ) return "Pro. Legendary";
			else if ( level >= 999 ) return "EXTREME LEGEND OF VCMP";
		break;
		case 1:
			if ( level <= 99 ) return "Newbie Finder";
			else if ( level <= 199 ) return "Best Seach";
			else if ( level <= 299 ) return "Professional Searching";
			else if ( level <= 399 ) return "Pro. Hunt";
			else if ( level <= 999 ) return "Legend of Seach";
			else if ( level >= 999 ) return "INSANE SEACH";
		break;
		case 2:
		case 3:
			switch ( level ) {
				case 100:
				case 200:
				case 300:
				case 400:
				case 500:
				case 1000:
					return true;
				break;
				default:
					return false;
				break;
			}
		break;
		default:
			return "Unknown Acction";
		break;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function LevelTag(level) {
	local Tag = "";
	switch ( level ) {
		case 0:
			Tag = "No Registered";
			break;
		case 1:
			Tag = "Member";
			break;
		case 2:
			Tag = "Moderator";
			break;
		case 3:
			Tag = "Admin";
			break;
		case 4:
			Tag = "Management";
			break;
		case 5:
			Tag = "Owner";
			break;
	}
	return (Tag ? Tag:"Unknown");
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function ValidWep( wep ) {
	if ( wep > 33 || wep <= 0 || wep == 33 || wep == 13 || wep == 16) return false;
	else return true;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function GetBodyPart( id ) {
	local Part = "Unknown";
	switch ( id ) {
		case 0:
			Part = "Body";
			break;
		case 1:
			Part = "Torso";
			break;
		case 2:
			Part = "Left Arm";
			break;
		case 3:
			Part = "Right Arm";
			break;
		case 4:
			Part = "Left Leg";
			break;
		case 5:
			Part = "Right Leg";
			break;
		case 6:
			Part = "Head";
			break;
	}
	return Part;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function GetPartReason( reason ) {
	switch ( reason ) {
		case 0:
			return "Timeout";
			break;
		case 1:
			return "Quit";
			break;
		case 2:
			return "Kicked";
			break;
		case 3:
			return "Banned";
			break;
		default:
			return "Unknown";
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function GetVehicleType( model, ... ) {
	switch ( model ) {
		case 136:
		case 160:
		case 176:
		case 182:
		case 183:
		case 184:
		case 190:
		case 202:
		case 203:
		case 214:
		case 223:
			return ( vargv.len() > 0 ? 1:"Boat" );
		case 155:
		case 165:
		case 217:
		case 218:
		case 227:
			return ( vargv.len() > 0 ? 2:"Helicopter" );
		case 166:
		case 178:
		case 191:
		case 192:
		case 193:
		case 198:
			return ( vargv.len() > 0 ? 3:"Bike" );
		case 171:
		case 194:
		case 195:
		case 231:
			return ( vargv.len() > 0 ? 4:"RC" );
		case 180:
		case 181:
			return ( vargv.len() > 0 ? 5:"Plane" );
		default:
			return ( vargv.len() > 0 ? 6:"Car" );
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function WepSlot(wep) {
	wep = wep.tointeger();
	switch ( wep ) {
	case 0:
	case 1:
		return 0;
	case 2:
	case 3:
	case 5:
	case 6:
	case 7:
	case 8:
	case 9:
	case 10:
	case 11:
		return 1;
	case 12:
	case 13:
	case 14:
	case 15:
		return 2;
	case 17:
	case 18:
		return 3;
	case 19:
	case 20:
	case 21:
		return 4;
	case 22:
	case 23:
	case 24:
	case 25:
		return 5;
	case 26:
	case 27:
		return 6;
	case 28:
	case 29:
		return 8;
	case 30:	
	case 31:
	case 32:
	case 33:
		return 7;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function rWepSlot( string ) {
	string = split(string,",");
	local i = 0, x = 0, b;
	while (i < string.len()) {
		while (x < string.len()) {
			if (x != i){
				b = (WepSlot(string[i]) == WepSlot(string[x]) ? true:null);
			}
			x++;
		}
		x = 0;
		if ( b ) return true;	
		i++;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function SetWepString(string, player) {
	string = string.tostring();
	player.SetWeapon( 0, 0 );
	string = split(string, ",");
	for (local i = 0; i < string.len(); i++) player.SetWeapon( string[i].tointeger(), 900 );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function DistanceFromObjets(player) {
	local d, x, y, z, px = player.Pos.x, py = player.Pos.y, pz = player.Pos.z;
	for (local i = 0; i < Objects.len(); i++) {
		x = split(Objects[i]," ")[0].tofloat();
		y = split(Objects[i]," ")[1].tofloat();
		z = split(Objects[i]," ")[2].tofloat();
		d = sqrt( (x-px)*(x-px) + (y-py)*(y-py) + (z-pz)*(z-pz) );
		if (format("%.f",(d)).tointeger() <= 80) { return format("%.f",(d)); break; }
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function DistanceFromProp( player ) {
	local d, x, y, z, p = player.Pos;
	if ( PlayerInfo[player.ID] ) {
			for (local i = 0; i < Properties.len(); i++) {
				if ( Properties[i]["owner"] == player.Name ) {
				x = split(Properties[i]["pos"], " ")[0].tofloat();
				y = split(Properties[i]["pos"], " ")[1].tofloat();
				z = split(Properties[i]["pos"], " ")[2].tofloat();
				d = sqrt( (x-p.x)*(x-p.x) + (y-p.y)*(y-p.y) + (z-p.z)*(z-p.z) );
				if (format("%.f",(d)).tointeger() <= 50) { return format("%.f",(d)); break; }
			}
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function direction(x1, y1, x2, y2) {
	x1 = x1.tofloat();
	x2 = x2.tofloat();
	y1 = y1.tofloat();
	y2 = y2.tofloat();
	local m = (y2-y1)/(x2-x1);
	if (m >= 6 || m <= -6) {
		return (y2 > y1 ? "North":"South");
	}
	if (m < 6 && m >= 0.5) {
		return (y2 > y1 ? "North East":"South West");
	}
	else if (m < 0.5 && m > -0.5) {
		return (x2 > x1 ? "East":"West");
	}
	else if (m <= -0.5 && m > -6) {
		return (y2 > y1 ? "North West":"South East");
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function GetInfoOfCmd( cmd ) {
	local b = "";
	foreach( i in Server.Commands ) {
		foreach( x in i ) {
			b = split(x,",");
			if ( b[2] == cmd ) { 
				return b;
			}
		}
	}
	return ["0","0","unknown","None"];
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function ClanTag(strPlayer) {
	local D_DELIM = regexp(@"([\[(=^<]+\w+[\])=^>]+)").capture(strPlayer),S_DELIM = regexp(@"(\w.+[.*=]+)").capture(strPlayer);
	if ( D_DELIM != null ) return strPlayer.slice( D_DELIM[ 0 ].begin, D_DELIM[ 0 ].end );
	else if ( S_DELIM != null ) return strPlayer.slice( S_DELIM[ 0 ].begin, S_DELIM[ 0 ].end );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function SetCountDown() {
	local tdefault = 3;
	Server.CountDown++;
	if ( Server.CountDown <= tdefault ) {
		msg( "------- " + Server.CountDown + " -------", 0, 250, 250 );
		AnnounceAll( "~b~-~o~ " + Server.CountDown + " ~b~-" );
	}
	else if ( Server.CountDown >=  tdefault ) {
		msg( "-- Go, Go, Go! --", 0, 250, 250 );
		AnnounceAll( "~b~-~g~ go! ~b~-" );
		Server.CountDown = 0;
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function GetPlayer( target ) {
	target = target.tostring();
	if ( IsNum( target ) ) {
		target = target.tointeger();
		if ( FindPlayer( target ) ) return FindPlayer( target );
		else return null;
	}
	else if ( FindPlayer( target ) ) return FindPlayer( target );
	else return null;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function GetDistance( v1, v2 ) return sqrt( (v2.x-v1.x)*(v2.x-v1.x) + (v2.y-v1.y)*(v2.y-v1.y) + (v2.z-v1.z)*(v2.z-v1.z) );
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function CalcDistance( x1, y1, z1, x2, y2, z2 ) return sqrt( ( x1 - x2 ) * ( x1 - x2 ) + ( y1 - y2 ) * ( y1 - y2 ) + ( z1 - z2 ) * ( z1 - z2 ) );
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function NeedPlayerInArea(player, Xmin, Xmax, Ymin, Ymax) {
	if(player.Pos.x >= Xmin && player.Pos.x <= Xmax && player.Pos.y >= Ymin && player.Pos.y <= Ymax) return true;
	else return false;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function IsPlayerInArea(player, Xmin, Xmax, Ymin, Ymax) {
	if (player.Pos.x > Xmin && player.Pos.x < Xmax && player.Pos.y > Ymin && player.Pos.y < Ymax) return true;
	else return false;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function onBank( player ) {
	return InPoly( player.Pos.x, player.Pos.y, -898.2357,-326.6091,-898.2196,-355.5072,-936.2309,-355.5205,-939.2854,-352.5587,-952.3001,-342.9138,-957.1079,-341.7898,-966.5380,-337.4671,-966.5401,-328.1766 );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function onSunshine( player ) {
	return InPoly( player.Pos.x, player.Pos.y, -1060.54,-807.183,-959.702,-807.183,-959.702,-910.663,-1060.54,-910.663 );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function Replace( text, oldchar, newchar ) {
	local Str = "";
	foreach(i, char in text) {
		local chr = char.tochar();
		if ( chr == oldchar ) chr = newchar;
		Str += chr;
	}
	return Str;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function mformat( x ) {
	local v = "";
	local nvm = x % 1000;
	while(nvm != x) {
		v = format(",%03d", (nvm < 0 ? -nvm : nvm)) + v;
		x /= 1000;
		nvm = x % 1000;
	}
	v = nvm.tostring() + v;
	return v;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function JoinArray( array, delimit ) {
	local a, z = array.len(), output = "";
	if ( z > 0 ) {
		if ( z > 1 ) {
			for ( a = 1; a < z; a++ )
				output += delimit + array[ a ];
			return array[ 0 ] + output;
		}
		else return array[ 0 ];
	}
	else return output;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function unix_timestamp() {
	local date = date();
	return (((date.year - 1970) * 31556900) + (date.yday * 86400) + (date.hour * 3600) + (date.min * 60) + date.sec + ((date.year % 4) * 86400));
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function duration( ticks ) {
	//ticks	= floor ( ticks / 1000 );
	local days = floor ( ticks % 604800 / 86400 );
	local hours = floor ( ticks % 86400 / 3600 );
	local mins = floor ( ticks % 3600 / 60 );
	local secs = ticks % 60;
	local weeks	= floor ( ( ticks - days*86400 - hours*3600 - mins*60 - secs ) / 604800 );
	local a = [];
	if ( weeks != 0 ) a.append( weeks + "wks" );
	if ( days != 0 ) a.append( days + "days" );
	if ( hours != 0 ) a.append( hours + "hrs" );
	if ( mins != 0 ) a.append( mins + "mins" );
	if ( secs != 0 ) a.append( secs + "secs" );
	return JoinArray( a, " " );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function _duration( secs ) {
	//secs = GetTime() - secs;
	local days = "", hours = "", minutes = "", seconds = "", remainder;
	days = floor(secs / 86400);
	remainder = floor(secs % 86400);
	hours = floor(remainder / 3600);
	remainder = floor(remainder % 3600);
	minutes = floor(remainder / 60);
	seconds = floor(remainder % 60);

	if (days > 0) days = days+"day ";
	if (hours > 0) hours = hours+"hrs ";
	if (minutes > 0) minutes = minutes+"mins ";
	if (seconds > 0) seconds = seconds+"segs";
	return days+hours+minutes+seconds;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function SetServerConfig(){
	SetServerName( Config.Server.Name );
	SetGamemodeName( Config.Server.GameMode );
	SetMaxPlayers( Config.Server.MaxPlayers );
	if ( Config.Server.Password != "none") SetPassword( Config.Server.Password );
	print("---- Server Config Apply! ----");
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function LoadBanneds() {
	local sql = "SELECT * from bans", buffer, i = 0;
	Banneds <- {};
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		sql = mysql_query(my_db, sql);
		while ( mysql_num_rows( sql ) > i ) {
			buffer = mysql_fetch_assoc( sql );
			Banneds.rawset(buffer["banned"], buffer);
			i++;
		}
		mysql_free_result( sql );
	}
	else {
		sql = QuerySQL( sqlite, sql );
		while( GetSQLColumnData(sql,0) ){
			Banneds.rawset( GetSQLColumnData(sql,0), { banned = GetSQLColumnData(sql,0), admin = GetSQLColumnData(sql,1), reason = GetSQLColumnData(sql,2), time = GetSQLColumnData(sql,3), ip = GetSQLColumnData(sql,4) } );
			GetSQLNextRow( sql );
			i++;
		}
		FreeSQLQuery( sql );
	}
	print("--- "+i+", Complete Banned Load ---");
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function LoadVehicles(){
	local i = 0, sql, buffer;
	local model, pos, x, y, z, angle, col1, col2;
	Vehicles <- [];
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		sql = mysql_query(my_db, "SELECT * FROM cars");
		while ( mysql_num_rows( sql ) > i ) {
			buffer = mysql_fetch_assoc( sql );
			Vehicles.push( buffer );
			Vehicles[i].rawset( "Local", { Gas = RandNum(50, 101), LastUse = 0 } );
			
			model = buffer["model"].tointeger();
			pos = buffer["pos"];
			x = split(pos," ")[0].tofloat();
			y = split(pos," ")[1].tofloat();
			z = split(pos," ")[2].tofloat();
			angle = buffer["angle"].tofloat();
			col1 = buffer["col1"].tointeger();
			col2 = buffer["col2"].tointeger();
			CreateVehicle(model, Vector(x, y ,z), angle, col1, col2);
			if ( buffer["locked"] == "true" ) FindVehicle(i).IsLocked = true;
			if ( buffer["owner"] != "Vice City" ) Server.Cars++;
			i++;
		}
		mysql_free_result( sql );
	}
	else {
		sql = QuerySQL(sqlite, "SELECT * FROM cars");
		while (GetSQLColumnData(sql,0)) {
			Vehicles.push( { owner = GetSQLColumnData(sql,0), shared = GetSQLColumnData(sql,1), autofix = GetSQLColumnData(sql,2) model = GetSQLColumnData(sql,3), pos = GetSQLColumnData(sql,4), angle = GetSQLColumnData(sql,5), col1 = GetSQLColumnData(sql,6), col2 = GetSQLColumnData(sql,7), locked = GetSQLColumnData(sql,8), cost = GetSQLColumnData(sql,9) } );
			Vehicles[i].rawset( "Local", { Gas = RandNum(50, 101), LastUse = 0 } );
			buffer = Vehicles[i];
		
			model = buffer["model"].tointeger();
			pos = buffer["pos"];
			x = split(pos," ")[0].tofloat();
			y = split(pos," ")[1].tofloat();
			z = split(pos," ")[2].tofloat();
			angle = buffer["angle"].tofloat();
			col1 = buffer["col1"].tointeger();
			col2 = buffer["col2"].tointeger();
			
			CreateVehicle(model, Vector(x, y ,z), angle, col1, col2);
			if ( buffer["locked"] == "true" ) FindVehicle(i).IsLocked = true;
			if ( buffer["owner"] != "Vice City" ) Server.Cars++;
		
			GetSQLNextRow( sql );
			i++;
		}
		FreeSQLQuery( sql );
	}
	print("--- "+i+", Complete Vehicles Load ---");
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function LoadPickups() {
	Properties <- [];
	local sql = "SELECT * FROM properties", i = 0, buffer, pos, x, y, z;
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		sql = mysql_query(my_db, sql);
		while (mysql_num_rows(sql) > i) {
			buffer = mysql_fetch_assoc(sql);
			pos = buffer["pos"];
			CreatePickup(407, Vector(split(pos," ")[0].tofloat(), split(pos," ")[1].tofloat(), split(pos, " ")[2].tofloat()));
			Properties.push( buffer );
			if ( Properties[i]["owner"] != "Vice City" ) Server.Props++;
			i++;
		}
		mysql_free_result(sql);
		print("--- "+i+", Poperties Load! ---");
		LoadObjects();
	}
	else {
		sql = QuerySQL(sqlite,"SELECT * FROM properties");
		while (GetSQLColumnData(sql,0)) {
		
			pos = GetSQLColumnData(sql,4);
			x = split(pos, " ")[0], y = split(pos, " ")[1], z = split(pos, " ")[2];
			CreatePickup( 407, Vector( x.tofloat(), y.tofloat(), z.tofloat() ) );
			
			Properties.push( { name = GetSQLColumnData(sql,0), cost = GetSQLColumnData(sql,1), owner =  GetSQLColumnData(sql,2), shared =  GetSQLColumnData(sql,3), pos = GetSQLColumnData(sql,4) } );
			GetSQLNextRow( sql );
			if ( Properties[i]["owner"] != "Vice City" ) Server.Props++;
			i++;
		}
		FreeSQLQuery( sql );
		print("--- "+i+", Poperties Load! ---");
		LoadObjects();
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function LoadGotolocs(){
	GotoLocs <- {};
	local sql = "SELECT * FROM gotoloc", i = 0, buffer;
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		sql = mysql_query(my_db, sql);
		while (mysql_num_rows( sql ) > i) {
			buffer = mysql_fetch_assoc( sql );
			GotoLocs.rawset(buffer["name"], buffer);
			i++;
		}
		mysql_free_result( sql );
	}
	else {
		sql = QuerySQL(sqlite, sql);
		while (GetSQLColumnData(sql,0)) {
			GotoLocs.rawset( GetSQLColumnData(sql, 0), { name = GetSQLColumnData(sql, 0), pos = GetSQLColumnData(sql, 1), creator = GetSQLColumnData(sql, 2), createat = GetSQLColumnData(sql, 3) } );
			GetSQLNextRow( sql );
			i++;
		}
		FreeSQLQuery( sql );
	}
	print("--- "+i+", Locations Load! ---");
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function LoadFromXml(){
	local File = XmlDocument("data/Server.xml"), SpawnLoc, Object, Arena, Race, AD, cKing, rBank, Mesage, Commands, node;
	if ( File.LoadFile() ) {
		SpawnLoc = File.FirstChild("SpawnLoc");
		Object = File.FirstChild("Objects");
		Arena = File.FirstChild("Arenas");
		Race = File.FirstChild("RaceTracks");
		AD = File.FirstChild("ADBases");
		cKing = File.FirstChild("PKing");
		rBank = File.FirstChild("RBank");
		Mesage = File.FirstChild("Messages");
		Commands = File.FirstChild("Commands");
		node = SpawnLoc.FirstChild("Coordenates");
		Spawns <- [];
		Objects <- [];
		Messages <- [];
		Arenas <- {};
		while ( node ) {
			Spawns.push( node.Text );
			node = node.NextSibling("Coordenates");
		}
		print("--- " + Spawns.len() + ", Spawn Pos Loaded! ---");
		node = Object.FirstChild("Pickup");
		while ( node ) {
			Objects.push( node.Text );
			node = node.NextSibling("Pickup");
		}
		node = Arena.FirstChild("Area");
		while ( node ) {
			Arenas.rawset(node.FirstChild("Name").Text.tointeger(), node.FirstChild("Pos").Text);
			node = node.NextSibling("Area");
		}
		print("--- " + Arenas.len() + ", Arenas Loaded! ---");
		node = Mesage.FirstChild("Text");
		while ( node ) {
			Messages.push( node.Text );
			node = node.NextSibling("Text");
		}
		print("--- " + Messages.len() + ", Messages Loaded! ---");
		node = Commands.FirstChild("Cmd");
		local limit = 25, i = 0, id = 0, buffer;
		Server.Commands.push( [] );
		while ( node ) {
			if ( i >= limit ) { 
				Server.Commands.push( [] );
				id++;
				i = 0;
			}
			buffer = format( "%s,%s,%s,%s", node.FirstChild("Level").Text, node.FirstChild("eEnable").Text, node.FirstChild("Name").Text, "None" );
			Server.Commands[id].push( buffer );
			i++;
			node = node.NextSibling("Cmd");
		}
		print( "--- " + Server.Commands.len() + " List Commands Load! ---" );
		node = Race.FirstChild("Race");
		local point, id = 0;
		while ( node ) {
			Server.Races.Tracks.push( { Name = node.FirstChild("Name").Text, Track = [] } );
			point = node.FirstChild("CheckPoints");
			while ( point ) {
				Server.Races.Tracks[id].Track.push( point.FirstChild("Point").Text );
				point = point.NextSibling("Point");
			}
			id++;
			point = null;
			node = node.NextSibling("Race");
		}
		print( "--- " + Server.Races.Tracks.len() + ", Race Tracks Load! --- " );
		node = AD.FirstChild("Base");
		while( node ) {
			Server.ADRound.Bases.push( { Name = node.FirstChild("Name").Text, Pos = node.FirstChild("Pos").Text } );
			node = node.NextSibling("Base");
		}
		print( "--- " + Server.ADRound.Bases.len() + ", A/D Bases Load! --- " );
		node = cKing.FirstChild("Pos");
		while( node ) {
			Server.cKing.Bases.push( node.Text );
			node = node.NextSibling("Pos");
		}
		print( "--- " + Server.cKing.Bases.len() + ", C King Bases Load! --- " );
		node = rBank.FirstChild("Pos");
		while ( node ) {
			Server.rBank.Checks.push( node.Text );
			node = node.NextSibling("Pos");
		}
		print( "--- " + Server.rBank.Checks.len() + ", Rob Bank Check Points Load! --- " );
	}
	print("--- XML Data Loaded! ---");
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function LoadObjects() {
	local p = Objects, i = 0;
	while (i < p.len()) {
		CreatePickup( 431, Vector( split(p[i]," ")[0].tofloat(), split(p[i]," ")[1].tofloat(), split(p[i]," ")[2].tofloat()));
		i++;
	}
	print("--- "+i+", Objects Loaded ---");
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function EditSQConfig( name, param ) {
	if ( Config.MySQL.Enable ) {
		local sql = "";
		CheckSqlConect();
		sql = (mysql_num_rows(mysql_query( my_db, "SELECT * from data WHERE name = '"+name+"'" )) >= 1 ? "UPDATE data SET param = '"+param+"' WHERE name = '"+name+"'":"INSERT INTO data (name, param) VALUES('"+name+"', '"+param+"')");
		return ( !mysql_query( my_db, sql ) ? true:false );
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function CheckSqlConect() { 
	if ( !mysql_ping( my_db ) ) my_db = mysql_connect( Config.MySQL.Host, Config.MySQL.User, Config.MySQL.Pass, Config.MySQL.Database);
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function CheckSqlTables(){
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		local is_instal = null, sql = mysql_query(my_db,"select param from data where name = 'is_install'")
		if (sql) is_instal = mysql_num_rows(sql);
		if (is_instal == 0 || !is_instal){
			mysql_query(my_db,"CREATE TABLE IF NOT EXISTS data (name VARCHAR(32) NOT NULL, param VARCHAR(100) NOT NULL)");
			mysql_query(my_db,"INSERT INTO data (name, param) VALUES ('is_install','true'), ('last_run','"+GetTime()+"'), ('bot_name','"+Config.Irc.User+"') , ('bot_chan','"+Config.Irc.Chan+"'), ('bot_net','"+Config.Irc.NetIp+"'), ('server_name','"+Config.Server.Name+"'), ('server_game','"+Config.Server.GameMode+"'), ('server_players','"+Config.Server.MaxPlayers+"')");
			print("--- MySQL Tables Create! ---");
		}
		else {
			local name = ["bot_name","bot_chan","bot_net","server_name","server_game","server_players","last_run"];
			local param = [Config.Irc.User,Config.Irc.Chan,Config.Irc.NetIp,Config.Server.Name,Config.Server.GameMode,Config.Server.MaxPlayers,GetTime()];
			for (local i=0; i<name.len(); i++){
				mysql_query(my_db,"UPDATE data set param = '"+param[i]+"' WHERE name = '"+name[i]+"'");
			}
			print("--- MySQL Tables Update ---");
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function RegisterUser(player,password) {
	local sql = "INSERT INTO users (name,ip,password,datereg,lastactive) VALUES ('"+player+"','"+player.IP+"','"+password+"','"+GetFullTime()+"','"+GetTime()+"')";
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		mysql_query(my_db, sql);
	}
	else {
		QuerySQL(sqlite, sql);
	}
	PlayerInfo[player.ID] = FetchUserInfo(player);
	PlayerInfo[player.ID]["clan"] = ( !ClanTag(player.Name) ? "0":ClanTag(player.Name) );
	SetOnline( player );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function UpdatePlayerData(player){
	local p = PlayerInfo[player.ID];
	local sql = format( "UPDATE users SET ip = '%s', level = '%i', password = '%s', lastactive = '%i', cash = '%i', bank = '%i', kills = '%i', deaths = '%i', joins = '%i', spree = '%i', pickups = '%i', weps = '%s', locspw = '%s', skin = '%i', ccars = '%i', cprops = '%i', nogoto = '%s', clan = '%s', isonline = '%s', cgotolocs = '%i', playedtime = '%i', cookies = '%i', wstats = '%s', bstats = '%s', westats = '%s', rustats = '%s' WHERE name = '%s'", p.ip, p.level, p.password, p.lastactive, p.cash, p.bank, p.kills, p.deaths, p.joins, p.spree, p.pickups, p.weps, p.locspw, p.skin, p.ccars, p.cprops, p.nogoto, p.clan, p.isonline, p.cgotolocs, p.playedtime, p.cookies, p.wstats, p.bstats, p.westats, p.rustats, player.Name );
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		mysql_query(my_db, sql);
	}
	else {
		QuerySQL(sqlite, sql);
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function ExistUser(user){
	local sql = "SELECT level FROM users where name = '"+user+"'";
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		local result = mysql_query(my_db, sql);
		return (mysql_num_rows(result)>=1 ? true:false);
		mysql_free_result(result);
	}
	else {
		local result = QuerySQL(sqlite, sql);
		return (GetSQLColumnData(result,0) >= 1 ? true:false);
		FreeSQLQuery(result);
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function SetOnline( user ) {
	if ( Config.MySQL.Enable && PlayerInfo[ user.ID ] ) {
		CheckSqlConect();
		mysql_query(my_db, "UPDATE users SET isonline = 'true' WHERE name = '"+user.Name+"'");
		PlayerInfo[user.ID]["isonline"] = "false";
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function FetchUserInfo( user ) {
	local fetch = {};
	if ( Config.MySQL.Enable ) {
		CheckSqlConect();
		local sql = mysql_query(my_db,"SELECT * FROM users where name = '"+user+"'");
		fetch = mysql_fetch_assoc( sql );
		mysql_free_result( sql );
	}
	else {
		local sql =  QuerySQL(sqlite,"SELECT * FROM users WHERE name = '"+user+"'");
		fetch = { name = GetSQLColumnData(sql,0), ip = GetSQLColumnData(sql,1), level = GetSQLColumnData(sql,2), password =  GetSQLColumnData(sql,3), datereg =  GetSQLColumnData(sql,4), lastactive =  GetSQLColumnData(sql,5), cash =  GetSQLColumnData(sql,6), bank =  GetSQLColumnData(sql,7), kills =  GetSQLColumnData(sql,8), deaths = GetSQLColumnData(sql,9), joins =  GetSQLColumnData(sql,10), spree =  GetSQLColumnData(sql,11), pickups =  GetSQLColumnData(sql,12), weps =  GetSQLColumnData(sql,13), locspw =  GetSQLColumnData(sql,14), skin =  GetSQLColumnData(sql,15), ccars = GetSQLColumnData(sql,16), cprops = GetSQLColumnData(sql,17), nogoto = GetSQLColumnData(sql,18), clan = GetSQLColumnData(sql,19), isonline = GetSQLColumnData(sql,20), cgotolocs = GetSQLColumnData(sql,21), playedtime = GetSQLColumnData(sql,22), cookies = GetSQLColumnData(sql,23), wstats = GetSQLColumnData(sql,24), bstats = GetSQLColumnData(sql,25), westats = GetSQLColumnData(sql,26), rustats = GetSQLColumnData(sql,27) }
		FreeSQLQuery( sql );
	}
	fetch.rawset( "Local", pLocal() );
	return ( fetch ? fetch:null );
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function ManageProp( x, player, id ) {
	player = player.Name;
	local p = Properties[id], sql = "";
	//Buy Prop
	if (x == 0) {
		Server.Props++;
		sql = "UPDATE properties SET owner = '"+player+"' WHERE name = '"+p["name"]+"'";
		p["owner"] = player;
	}
	//Share Prop
	else if (x == 1) {
		sql = "UPDATE properties SET shared = '"+player+"' WHERE name = '"+p["name"]+"'";
		p["shared"] = player;
	}
	//Deshare Prop
	else if (x == 2) {
		sql = "UPDATE properties SET shared = 'None' WHERE name = '"+p["name"]+"'";
		p["shared"] = "None";
	}
	//Sell Prop
	else if (x == 3) {
		Server.Props--;
		sql = "UPDATE properties SET owner = 'Vice City', shared = 'None' WHERE name = '"+p["name"]+"'";
		p["owner"] = "Vice City";
		p["shared"] = "None";
	}
	else return false;
	
	if ( sql ) {
		if ( Config.MySQL.Enable ) {
			CheckSqlConect();
			mysql_query( my_db, sql );
			return true;
		}
		else { 
			QuerySQL(sqlite, sql);
			return true;
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function ManageVehicle(x, player, car) {
	local ccar = Vehicles[car]["pos"], sql = "";
	//Buy Car
	if (x == 0) {
		Server.Cars++;
		sql = "UPDATE cars SET owner = '"+player+"' WHERE pos = '"+ccar+"'";
		Vehicles[car]["owner"] = player;
	}
	//Share Car
	else if (x == 1) {
		sql = "UPDATE cars SET shared = '"+player+"' WHERE pos = '"+ccar+"'";
		Vehicles[car]["shared"] = player;
	}
	//Deshare Car
	else if (x == 2) {
		sql = "UPDATE cars SET shared = 'None' WHERE pos = '"+ccar+"'";
		Vehicles[car]["shared"] = "None";
	}
	//Lock Car
	else if (x == 3) {
		sql = "UPDATE cars SET locked = 'true' WHERE pos = '"+ccar+"'";
		Vehicles[car]["locked"] = "true";
		FindVehicle(car).IsLocked = true;
	}
	//Un-Lock Car
	else if (x == 4) {
		sql = "UPDATE cars SET locked = 'false' WHERE pos = '"+ccar+"'";
		Vehicles[car]["locked"] = "false";
		FindVehicle(car).IsLocked = false;
	}
	//Park Car
	else if (x == 5) {
		sql = "UPDATE cars SET pos = '"+player+"' WHERE pos = '"+ccar+"'";
		Vehicles[car]["pos"] = player;
		local veh = FindVehicle( car ), pos = Vector( split(player," ")[0].tofloat(), split(player," ")[1].tofloat(), split(player," ")[2].tofloat() );
		veh.Pos = pos; veh.SpawnPos = pos;
	}
	//AutoFix on
	else if (x == 6) {
		sql = "UPDATE cars SET autofix = 'true' WHERE pos = '"+ccar+"'";
		Vehicles[car]["autofix"] = "true";
	}
	//AutoFix off
	else if (x == 7) {
		sql = "UPDATE cars SET autofix = 'false' WHERE pos = '"+ccar+"'";
		Vehicles[car]["autofix"] = "false";
	}
	//Sell Car 
	else if (x == 8) {
		Server.Cars--;
		sql = "UPDATE cars SET owner = 'Vice City', shared = 'None' WHERE pos = '"+ccar+"'";
		Vehicles[car]["owner"] = "Vice City";
		Vehicles[car]["shared"] = "None";
		FindVehicle(car).IsLocked = false;
	}
	else return false;
	
	if ( sql ) {
		if ( Config.MySQL.Enable ) {
			CheckSqlConect();
			mysql_query( my_db, sql );
			return true;
		}
		else { 
			QuerySQL(sqlite, sql)
			return true;
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function EmoticonCount( text ) {
	text = text.tolower();
	local emos = ":d,d:,:),:(,:-),:-(,=d,>_>,<_<,>.>,<.<,>_<,>.<,><,:s,:-s,;-),;),;],:],:-],:*,:3,<3,:-*,;*,>:o,:o,;o,o:,o;,>:),>:],>:d,t.t,t_t,t-t,o_o,o.o,x.x,x_x,^^,^_^,^.^,¬¬,¬_¬,xd,dx,e.e,e_e,q_q,._.,.-.,-.-,-_-,:p,;p", z = 0, emos = split(emos, ",");
	foreach( i in emos ) {
		if ( text.find( i ) != null ) {
			z++;
		}
	}
	return z;
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function WordStats( player, text, ... ){
	if ( PlayerInfo[player.ID] ) {
		local b = PlayerInfo[player.ID]["wstats"], x = split(b, ","), le, pal, orc, ac, emos;
		le = x[0].tointeger();
		pal = x[1].tointeger();
		orc = x[2].tointeger();
		ac = x[3].tointeger();
		emos = x[4].tointeger();
		local nl, np, no, ne, nac;
		nl = le + Replace(text, " ", "").len();
		np = pal + split(text, " ").len();
		no = orc + 1;
		ne = EmoticonCount( text ) + emos;
		nac = ( vargv.len() > 0 ? ac + 1:ac );
		PlayerInfo[player.ID]["wstats"] = format( "%i,%i,%i,%i,%i", nl, np, no, nac, ne );
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function IncBodyStats( player, x ) {
	if ( PlayerInfo[player.ID] ) {
		local part = [], sp = split( PlayerInfo[player.ID]["bstats"], "," ), buffer, i = 0;
		if ( x < sp.len() && x >= 0 ) {
			while( i < sp.len() ) {
				part.push( sp[i].tointeger() );
				if ( i == x ) part[x]++;
				buffer = ( buffer != null ? buffer + "," + part[i]:part[i] );
				i++;
			}
			PlayerInfo[player.ID]["bstats"] = buffer;
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function WeaponStats( player, wep ) {
	if ( PlayerInfo[player.ID] ) {
		local local_wep = [], split_wep = split( PlayerInfo[player.ID]["westats"], "," ), buffer, i = 0;
		if ( wep < split_wep.len() && wep >= 0 ) {
			while( i < split_wep.len() ) {
				local_wep.push( split_wep[i].tointeger() );
				if ( i == wep ) local_wep[wep]++;
				buffer = ( buffer != null ? buffer + "," + local_wep[i]:local_wep[i] );
				i++;
			}
			PlayerInfo[player.ID]["westats"] = buffer;
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
function RunPlayerStats( player, x, am ) {
	if ( PlayerInfo[player.ID] ) {
		local local_item = [], split_run = split( PlayerInfo[player.ID]["rustats"], "," ), buffer, i = 0;
		if ( x < split_run.len() && x >= 0 ) {
			while( i < split_run.len() ) {
				local_item.push( split_run[i].tointeger() );
				if ( i == x ) local_item[x] += am;
				buffer = ( buffer != null ? buffer + "," + local_item[i]:local_item[i] );
				i++;
			}
			PlayerInfo[player.ID]["rustats"] = buffer;
		}
	}
}
//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~

//Script Event
function onScriptLoad() {
	print("--- NT5 SQLite & MySQL Script v0.1b ---");
	print("---- Loading Script ----");
	dofile("Remote.nut");
	if ( Config.Json.Enable ) {
		json_start( Config.Json.Port );
		print( "--- Json Server Started ---" );
	}
	
	if ( Config.MySQL.Enable ) {
		LoadModule("lu_mysql");
		my_db <- mysql_connect( Config.MySQL.Host, Config.MySQL.User, Config.MySQL.Pass, Config.MySQL.Database );
	}
	else {
		LoadModule("sq_lite");
		sqlite <- ConnectSQL( "data/database.sqlite" ); 
	}
	CheckSqlTables();
	ConnectEcho();
	players <- {};
	PlayerInfo <- array( Config.Server.MaxPlayers, null );
	Spam <- array( 51, null );
	for ( local i = 0; i <= 50; i++ ) Spam[i] = cSpam();
	print("---- Successful Connect Database! ----");
}
function onScriptUnload() {
	KillBots();
	print( "--- Unload Script... ---" );
	if ( Config.MySQL.Enable ) {
		if ( mysql_ping( my_db ) ) mysql_close( my_db );
	}
	else {
		DisconnectSQL( sqlite );
	}
	
	if ( Config.Json.Enable ) {
		json_disconnect();
		print( "--- Json Server Stopped -- " );
	}
}
function onServerStart(){
	NewTimer("SetServerConfig", 2000, 1);
	LoadVehicles();
	LoadBanneds();
	LoadFromXml();
	LoadGotolocs();
	LoadPickups();
}
function onPlayerJoin( player ) {
	players.rawset( player.Name, player );
	local country = "Unknown";
	Map.Players.rawset( player.Name, player );
	Map.Messages.Add( { name = player.Name, team = player.Team, country = country, type = 1 } );
	local noChars = ["$","#","'","~"], ban = IsBanned( player );
	print("[" + player.ID + "] " + player.Name + " has joined the server.");
	Echo("14[" + player.ID + "]3 " + player.Name + " has joined the server.");
	foreach(players in noChars) { if (player.Name.find(players)){ AutoKick(player,"Nick Invalid Caractes."); }}
	if ( player.Name == "None" || player.Name == "Vice City" ) AutoKick(player, "Nick Invalid Name.");
	if ( player.Name.len() < 3 || player.Name.len() >= 20 ) AutoKick(player, "Nick not long enough.");
	if ( ban ) AutoKick(player,"Banned: "+ban["reason"]);
	else {
		PrivMessage( "Welcome To " + GetServerName() + " " + player.Name + "!", player);
		if ( ExistUser( player ) ){
			local UserInfo = FetchUserInfo(player);
			if (UserInfo["ip"] == player.IP) {
				PlayerInfo[player.ID] = UserInfo;
				PlayerInfo[player.ID]["joins"]++;
				PlayerInfo[player.ID]["lastactive"] = GetTime();
				PlayerInfo[player.ID]["clan"] = ( !ClanTag(player.Name) ? "0":ClanTag(player.Name) );
				SetOnline( player );
				Announce( "auto logged", player );
				PrivMessage("Auto-Logged. Level: " + PlayerInfo[player.ID]["level"] + " (" + LevelTag( PlayerInfo[player.ID]["level"] ) + ")", player);
				Echo("10> " + player.Name + " Auto-Logged. Level: " + PlayerInfo[player.ID]["level"] + " (" + LevelTag( PlayerInfo[player.ID]["level"] ) + ")");
				msg("Auto-Logged. Level: " + PlayerInfo[player.ID]["level"] + " (" + LevelTag( PlayerInfo[player.ID]["level"] ) + ")", 0, 200, 0);
			}
		else { 
				PrivMessage("This nickname is already registered please login, /c login <password>",player);
				Announce( "/c login", player );
			}
		}
		else { 
			PrivMessage("Register Your Nick!, /c register",player);
			Announce( "/c register", player );
		}
		SendIRCUsers( player );
		Announce( "\x10", player, 1 ); 
	}
}
function onPlayerSpawn( player ) {
	Map.Messages.Add( { name = player.Name, team = player.Team, skin = player.Skin, type = 3 } );
	if ( !PlayerInfo[player.ID] ) { 
		pmsg("Please Login or Register! /c login <password>, /c register <password>", player, 200, 0, 0);
		AutoKill(player, "Fail Login.");
	}
	else {
		PlayerInfo[player.ID].Local.TimePlay = GetTime();
		local pPos;
		if ( PlayerInfo[player.ID].Local.onArena ) pPos = split(PlayerInfo[player.ID].Local.onArena,",")[1];
		else if (PlayerInfo[player.ID]["locspw"] != "0") pPos = PlayerInfo[player.ID]["locspw"];
		else pPos = Spawns[RandNum(0,Spawns.len())];
		player.Pos = Vector(split(pPos, " ")[0].tofloat(), split(pPos, " ")[1].tofloat(), split(pPos, " ")[2].tofloat());
		
		local pos = player.Pos;
		Echo("14->[" +player.ID+"] 5" + player.Name + " spawned, Location: " + GetDistrictName( pos.x, pos.y ) + " Ping: ("+player.Ping+"ms)." );
		print( "->[" + player.ID + "] " + player.Name + " spawned, Location: " + GetDistrictName( pos.x, pos.y ) + " Ping: ("+player.Ping+"ms)." );
		msg( player.Name + " spawned, Location: " + GetDistrictName( pos.x, pos.y ) + " Ping: ("+player.Ping+"ms).", 200 , 250, 0 );
		if ( PlayerInfo[player.ID].Local.Hide != false ) PlayerInfo[player.ID].Local.Hide = false;
		player.Cash = PlayerInfo[player.ID]["cash"];
		if ( PlayerInfo[player.ID].Local.onArena ) {
			player.SetWeapon( 0, 0 );
			player.SetWeapon( split(PlayerInfo[player.ID].Local.onArena,",")[2].tointeger(), 600 );
		}
		else if (PlayerInfo[player.ID]["weps"] != "0") SetWepString(PlayerInfo[player.ID]["weps"], player);
	}
	Announce("\x10",player); 
}
function onPickupRespawn( pickup ) {
	if ( pickup.Model == 408 ) {
		pickup.Remove();
	}
}
function onPickupPickedUp( player, pickup ){
	
	if ( pickup.Model == 431 && PlayerInfo[player.ID] ) {
		local gan = 50, p = PlayerInfo[player.ID];
		p["cash"] += gan;
		p["pickups"]++;
		player.Cash += gan;
		local tmsgg, tmsg = player.Name + " Found Object! Reward: $" + gan + ", Pickups Found: " + mformat(p["pickups"]) + " ("+ RankTag( 1, p["pickups"] ) + ").";
		Echo( "10-> " + tmsg );
		msg( "-> " + tmsg, 0, 200, 0 );
		print( tmsg );
		if ( RankTag( 3, p["pickups"] ) ) {
			ShowMsg( "> " + player.Name + " Rank up! to " + RankTag( 1, p["pickups"] ) + ".", 10, 0 );
			PrivMessage( "You are now " + RankTag( 1, p["pickups"] ) + "!", player );
			Announce( "rank up", player );
			PlayerInfo[player.ID]["cookies"] += 50;
			PrivMessage( "For increase your rank take 50 cookies!", player );
		}
	}
	
	if ( pickup.Model == 408 && PlayerInfo[player.ID] ) {
		if ( Server.rBank.Started ) {
			PlayerInfo[player.ID]["cash"] += Server.rBank.Rewar;
			player.Cash += Server.rBank.Rewar;
			RobBank( 2, player.Name + " Robbed The Bank Reward: $"+Server.rBank.Rewar );
			pickup.Respawn();
		}
	}
	
	if ( pickup.Model == 407 ) {
		local id = pickup.ID-1, prop = Properties[id];
		PrivMessage( "Property -", player );
		PrivMessage( "ID:[ "+id+" ] Name:[ "+prop["name"]+" ] Owner:[ "+prop["owner"]+" ] Shared with:[ "+prop["shared"]+" ] Cost:[ $"+mformat(prop["cost"].tointeger())+" ]", player );
		pickup.RespawnTime = 2;
	}
}
function onPlayerHealthChange( player, oldhp, newhp ) {
     if ( newhp.tointeger() >= 101 ) AutoKick(player, "HP Hack");
	 if ( oldhp.tointeger() > newhp.tointeger() ) Announce( "\x10 \x10 \x10 \x10 \x10 \x10 ouch!", player );
}
function onPlayerArmourChange( player, oldarm, newarm ) {
	 if ( newarm.tointeger() >= 101 ) AutoKick( player, "Armour Hack" );
}
function onPlayerStartSpectating( player, pSpectated ) {
	PrivMessage( player.Name + " start spectate you.", pSpectated );
}
function onPlayerExitSpectating( player ) {
	PrivMessage( "Stopped spectating.", player );
}
function onVehicleRespawn( vehicle ) {
		Vehicles[vehicle.ID].Local.Gas = RandNum( 50, 101 );
}
function onPlayerEnterVehicle( player, vehicle, isPassenger ) {
	local owner = GetPlayer( Vehicles[vehicle.ID]["owner"] );
	PrivMessage( "You are entering a " + vehicle + ", Heal [" + format("%.2f",(player.Vehicle.Health / 10)) + "%] Owner ["+Vehicles[player.Vehicle.ID]["owner"]+"] Shared ["+Vehicles[player.Vehicle.ID]["shared"]+"] Cost: [$"+mformat(Vehicles[player.Vehicle.ID]["cost"])+"]", player );
	PrivMessage( format("Gasoline: %s - %i Gal.", RateVar(Vehicles[vehicle.ID].Local.Gas), Vehicles[vehicle.ID].Local.Gas), player );
	if ( Vehicles[vehicle.ID].Local.Gas <= 0 ) {
		PrivMessage( "This vehicle no have Gasoline!", player );
		vehicle.KillEngine();
	}
	if ( owner ) {
		if ( owner.Name == Vehicles[player.Vehicle.ID]["owner"] && owner.Name != player.Name ) {
			PrivMessage( player.Name + " start drive on your "+ player.Vehicle + ", ID: " + player.Vehicle.ID + " type !getcar <id> to get him!", owner );
		}
	}
	 if ( PlayerInfo[player.ID] ) {
		PlayerInfo[player.ID].Local.Speedo = format("%.4f %.4f %.4f", player.Pos.x, player.Pos.y, player.Pos.z );
		if ( GetVehicleType( vehicle.Model, 1 ) == 3 || GetVehicleType( vehicle.Model, 1 ) == 6 ) {
			PlayerInfo[player.ID].Local.Stunt = format( "%i 0 0", player.Pos.z );
		}
	}
}
function onPlayerExitVehicle( player, vehicle, isPassenger ) {
     PrivMessage( "You have left a " + vehicle + ".", player );
	 if ( Vehicles[vehicle.ID].Local.Gas <= 0 ) {
		player.Pos = player.Pos;
		vehicle.Respawn();
		Vehicles[vehicle.ID].Local.Gas = RandNum( 50, 101 );
	 }
	 if ( PlayerInfo[player.ID] ) {
		Announce( "\x10", player, 1 ); 
		PlayerInfo[player.ID].Local.Speedo = null;
		PlayerInfo[player.ID].Local.Stunt = null;
	 }
}
function onVehicleHealthChange( vehicle, oldHealth, health ) {
	if ( Vehicles[vehicle.ID]["owner"] == vehicle.Driver.Name && Vehicles[vehicle.ID]["autofix"] == "true" && vehicle.Health <= 500 ) vehicle.Fix();
}
function onPlayerTeamKill( killer, player, reason, bodypart ) {
	Map.Messages.Add( { name = killer.Name, team = killer.Team, victim = player.Name, vteam = player.Team, reason = weapon, bodypart = bodypart, type = 8 } );
}
function onPlayerTeamChat( player, TeamTo, text ) {
	Map.Messages.Add( { name = player.Name, team = TeamTo, msg = text, type = 9 } );
}
function onPlayerDeath( player, weapon ){
	Map.Messages.Add( { name = player.Name, team = player.Team, reason = weapon, type = 6 } );
	local reason = ( weapon == 43 ? " Drowned.":" Died." );
	Echo( "10> 4" + player.Name + reason );
	Message( ">" + player.Name + reason );
	
	if ( PlayerInfo[player.ID] ) {
		if ( PlayerInfo[player.ID].Local.TimePlay != 0 ) PrivMessage( "Play Time after spawned: " + duration(GetTime() - PlayerInfo[player.ID].Local.TimePlay), player );
		PlayerInfo[player.ID]["deaths"]++;
		if ( PlayerInfo[player.ID].Local.Spree >= 5 ) {
			ShowMsg( "> " + player + " has ended their own killing spree.", 4, 0 );
		}
		if ( Server.Hunt.Started ) {
			if ( Server.Hunt.Player.Name == player.Name ) {
				ManHunt(2, "Player" + reason );
			}
		}
		PlayerInfo[player.ID].Local.Spree = 0;
		PlayerInfo[player.ID].Local.TimePlay = 0;
		PlayerInfo[player.ID].Local.Waiting = null;
	}
}
function onPlayerKill( killer, killed, weapon, bodypart ){
	Map.Messages.Add( { name = killer.Name, team = killer.Team, victim = killed.Name, vteam = killed.Team, reason = weapon, bodypart = bodypart, type = 7 } );
	local Part = GetBodyPart( bodypart ), dist = GetDistance( killer.Pos, killed.Pos ), gan = 100;
	print("** " + killer.Name + " killed " + killed.Name + " ("+GetWeaponName(weapon)+") (" + Part + ")" + " Distance:("+format("%.2f",(dist))+"m)");
	Echo("2> 4" + killer.Name + " killed " + killed.Name + " (" + GetWeaponName( weapon ) + ") (" + Part + ")" + " Distance:("+format("%.2f",(dist))+"m)");
	msg("** " + killer.Name + " killed " + killed.Name + " (" + GetWeaponName( weapon ) + ") (" + Part + ")" + "  Distance:("+format("%.2f",(dist))+"m)", 0, 200, 0);

	
	if ( PlayerInfo[killer.ID] && PlayerInfo[killed.ID] ){
		if ( onBank( killed ) ) AutoKill( killer, "Kill On Bank." );
		else if ( onSunshine( killed ) ) AutoKill( killer, "Kill On Sunshine." );
		else if ( GetTime() - PlayerInfo[killed.ID].Local.TimePlay <= 3 ) AutoKill( killer, "Spawn Kill." );
		else {
		
			::IncBodyStats( killer, bodypart );
			::WeaponStats( killer, weapon );
			
			if ( bodypart == 6 ) {
				Announce( "~b~head~t~shoot", killer );
				PrivMessage("Head Shot Reward: $100", killer);
				PlayerInfo[killer.ID]["cash"] += 100;
				killer.Cash += 100;
			}
			
			if ( PlayerInfo[killer.ID].Local.onArena && PlayerInfo[killed.ID].Local.onArena ) {
				if ( weapon == split(PlayerInfo[killer.ID].Local.onArena,",")[2].tointeger() ) {
					PrivMessage("Kill on Arena Bonus: $200", killer);
					PlayerInfo[killer.ID]["cash"] += 200;
					killer.Cash += 200;
				}
				else AutoKill( killer, "Killing whit invalid weapon on arena" );
			}
			
			if ( weapon == Server.WepB ) {
				PrivMessage("Kill whit weapon time Bonus: 50$", killer);
				PlayerInfo[killer.ID]["cash"] += 200;
				killer.Cash += 200;
			}
			
			if ( Server.Hunt.Started ) {
				if ( 900 - ( GetTime() - Server.Hunt.Time ) > 0 ) {
					if ( Server.Hunt.Player.Name == killed.Name ) {
						PlayerInfo[killer.ID]["cash"] += Server.Hunt.Rewar;
						killer.Cash += Server.Hunt.Rewar;
						ManHunt(2, "The player was Hunted by " + killer.Name + "." );
					}
				}
				else {
					ManHunt(2, "Not Kill the hunt on time");
				}
			}
			
			PrivMessage("You Kill "+killed+" Reward: $"+mformat(gan), killer);
			PrivMessage("You were killed by "+killer+" Lost: $"+mformat(gan), killed);
			PrivMessage("Play Time after spawned: " + duration(GetTime() - PlayerInfo[killed.ID].Local.TimePlay), killed);
			PlayerInfo[killer.ID].Local.Spree++;
			
			if ( PlayerInfo[killer.ID].Local.Spree % 5 == 0 && PlayerInfo[killer.ID].Local.Spree > 0 ) {
				local reward = PlayerInfo[killer.ID].Local.Spree * 500;
				msg("* "+killer+" is on a killing spree of "+PlayerInfo[killer.ID].Local.Spree+" kills in a row!",200, 0, 0);
				msg( "* Spree Reward: $" + mformat( reward ),112, 216, 219 );
				Echo("4>> "+killer+" is on a killing spree of "+PlayerInfo[killer.ID].Local.Spree+" kills in a row!");
				Echo("10>> Spree Reward: $" + mformat( reward ));
				Announce( "~o~killing spree", killer);
				PlayerInfo[killer.ID]["cash"] += reward;
				killer.Cash += reward;
				PlayerInfo[killer.ID]["spree"]++;
			}
		
			if ( PlayerInfo[killed.ID].Local.Spree >= 5 ) {
				ShowMsg("> " + killed + "'s killing spree was ended by " + killer, 4, 0);
				local reward = PlayerInfo[killer.ID].Local.Spree * 500;
				PrivMessage( "Spree Reward: $" + mformat( reward ) + ".", killer );
				PlayerInfo[killer.ID]["cash"] += reward;
				killer.Cash += reward;
				PlayerInfo[killed.ID].Local.Spree = 0;
			}
			
			PlayerInfo[killed.ID].Local.Spree = 0;
			PlayerInfo[killed.ID].Local.Waiting = null;
			PlayerInfo[killed.ID].Local.TimePlay = 0;
			
			PlayerInfo[killer.ID]["kills"]++;
			PlayerInfo[killer.ID]["cash"] += gan;
			killer.Cash += gan;
			PlayerInfo[killed.ID]["deaths"]++;
			if ( PlayerInfo[killed.ID]["cash"] >= gan ){ 
				PlayerInfo[killed.ID]["cash"] -= gan;
				killed.Cash -= gan;
			}
			else {
				PlayerInfo[killed.ID]["cash"] = 0;
				killed.Cash = 0;
			}
			
			if ( RankTag( 2, PlayerInfo[killer.ID]["kills"] ) ) {
				ShowMsg( "> " + killer.Name + " up rank to " + RankTag( 0, PlayerInfo[killer.ID]["kills"] ) + "!!", 10, 0 );
				Announce("rank up", killer);
				PlayerInfo[killer.ID]["cookies"] += 50;
				PrivMessage("For increase your rank take 50 cookies!", killer);
			}
			
			if ( !PlayerInfo[killer.ID].Local.onArena && PlayerInfo[killed.ID].Local.onArena ) {
				AutoKill( killer, "Disturbing in arena" );
			}
		}
	}
}
function onPlayerChat( player, text ) {
	if ( !player.IsMuted ) {
		::ServerSpam(player, text);
		::WordStats( player, text );
		Map.Messages.Add( { name = player.Name, team = player.Team, msg = text, type = 4 } );
		Echo( "10>[" + player.ID + "] 12" + player.Name + ": 1" + text );
	}
	if (Spam[player.ID].Wait != 0 && GetTime()-Spam[player.ID].Wait > 30) {
		PrivMessage(">> Spam Mute Disable.",player);
		player.IsMuted = false;
		Spam[player.ID].Wait = 0;
	}
	if ( text ) {
		if ( text.slice( 0, 1 ) == Config.Server.Prefix ) {
			local cmd, sp;
			sp = split(text, " ");
			text = (sp.len() > 1 ? text.slice(sp[0].len()+1):null);
			cmd = sp[0];
			onPlayerCommand( player, cmd, text);
		}
	}
}
function onPlayerAction( player, text ) {
	if ( text && !player.IsMuted ) {
		::ServerSpam(player, text);
		::WordStats( player, text, 0 );
		Map.Messages.Add( { name = player.Name, team = player.Team, msg = text, type = 5 } );
		Echo( "10>>13" + player.Name + " " + text );
		print( "** " + player.Name + " " + text );
	}
}
function onPlayerCrashDump( player, crash ) AutoKick( player, "Crash Index: "+crash );
function onPlayerPart( player, reason ) {
	local Reason = GetPartReason( reason );
	print( "[" + player.ID + "] " + player.Name + " left the server. (" + Reason + ")" );
	Echo( "10>>3[" + player.ID + "] " + player.Name + " left the server. (" + Reason + ")" );
	if (PlayerInfo[player.ID]) {
		PlayerInfo[player.ID]["playedtime"] = GetTime() - PlayerInfo[player.ID]["lastactive"] + PlayerInfo[player.ID]["playedtime"];
		UpdatePlayerData(player);
		if (PlayerInfo[player.ID].Local.Spree >= 5 ) {
		ShowMsg( "> " + player + " has ended their own killing spree.", 4, 0 );
		}
	}
	if ( Server.Hunt.Started ) {
		if ( Server.Hunt.Player.Name == player.Name ) {
			ManHunt(2, "Player left the server" );
		}
	}
	PlayerInfo[player.ID] = null;
	Spam[player.ID] = cSpam();
	players.rawdelete( player.Name );
	
	Map.Players.rawdelete( player.Name );
	Map.Messages.Add( { name = player.Name, team = player.Team, reason = reason, type = 2 } );
}

//~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~
//Commands
function onPlayerCommand(player, cmd, text){
	if ( cmd ) { cmd = cmd.tolower(); }
	local prefix = ( cmd.slice( 0, 1 ) == Config.Server.Prefix ? cmd.slice( 0, 1 ):null);
	cmd = ( prefix ? cmd.slice(1):cmd);
	local cmd_info = GetInfoOfCmd( cmd );
	local is_aviable = ( cmd_info[1] == "0" ? true:false );
	local cmdlevel = cmd_info[0].tointeger();
	
if ( cmd == "commands" || cmd == "cmds" ) {
	local l = 0, t = 0, buffer, id = 0;
	if ( text ) if ( IsNum( text ) ) id = (text.tointeger() >= Server.Commands.len() ? 0:text.tointeger());
	PrivMessage( "--- " + GetServerName() + " Commands ---", player);
	while ( t < Server.Commands[id].len() ) {
		local cmd = split( Server.Commands[id][t], "," );
		local cmd_level = cmd[0].tointeger();
		if ( (PlayerInfo[player.ID] ? PlayerInfo[player.ID]["level"]:0) >= cmd_level ) {
			if (l >= 16) { PrivMessage(buffer, player); buffer = ""; l = 0; }
			if ( !buffer ) buffer = (prefix ? prefix:"/c ") + cmd[2];
			else buffer = buffer + ", " + (prefix ? prefix:"/c ") + cmd[2];
			if ( buffer.slice(0,1) == ","  ) buffer = buffer.slice(2);
		}
		t++; 
		l++;
	}
	PrivMessage( buffer ? buffer:"No commands to show here.", player );
	PrivMessage("More Commands on "+(prefix ? prefix:"/c ")+cmd+" <0/1/..."+(Server.Commands.len()-1)+">", player);
}

else if (cmd == "register" || cmd == "reg"){
	local pass = null;
	if (text) { pass = split(text," ")[0];}
	if (!pass) {PrivMessage("Error - Required Syntax: " + (prefix ? prefix:"/c ") + cmd +" <password>", player);}
	else if (ExistUser(player)) {PrivMessage("Error - Already Registered!", player);}
	else {
		PrivMessage("Successfully Registered!, do Not Forget Your Password: "+pass,player);
		Echo("> 10 "+ player.Name + " Successfully Registered!");
		msg(player.Name + " Successfully Registered!", 0, 200, 0);
		RegisterUser(player,pass);
	}
}

else if (cmd == "login" || cmd == "log"){
	if (!text) {PrivMessage("Error - Required Syntax: " + (prefix ? prefix:"/c ") +cmd+" <password>", player);}
	else if (PlayerInfo[player.ID]) {PrivMessage("Error - Already Logged.", player);}
	else if (!ExistUser(player)){PrivMessage(player+", Is not Registered Nickname.", player);}
	else {
		local UserInfo = FetchUserInfo(player);
		if (text != UserInfo["password"]){PrivMessage("Error - Invalid Password.", player);}
		else {
			PlayerInfo[player.ID] = UserInfo;
			PlayerInfo[player.ID]["ip"] = player.IP;
			PlayerInfo[player.ID]["lastactive"] = GetTime();
			PlayerInfo[player.ID]["clan"] = ( !ClanTag(player.Name) ? "0":ClanTag(player.Name) );
			SetOnline( player );
			PrivMessage("As You Loggin Correcly!, Identified Level: "+ PlayerInfo[player.ID]["level"] + " (" + LevelTag( PlayerInfo[player.ID]["level"] ) + ")", player);
			PrivMessage("New Auto-Login IP: "+player.IP,player);
		}
	}
}

else if ( !PlayerInfo[player.ID] ){ PrivMessage("Error - You not logged, Loggin first to use this command!", player); }
else if ( PlayerInfo[player.ID]["level"] < cmdlevel ) PrivMessage("Error - Your Level is: "+PlayerInfo[player.ID]["level"]+" you need Level: "+cmdlevel+" to use the command '"+(prefix ? prefix:"/c ")+cmd+"'.", player);
else if ( PlayerInfo[player.ID].Local.onEvent && !is_aviable ) PrivMessage("Error - You are in '" + PlayerInfo[player.ID].Local.onEvent + "' leave there to use this command.", player);
else if ( PlayerInfo[player.ID].Local.onArena && !is_aviable ) PrivMessage("Error - you are in '"+split(PlayerInfo[player.ID].Local.onArena,",")[0]+"' leave there to use this command. (!leave or !la)", player);
else {

if ( cmd == "hide" ) {
	if (!player.IsSpawned) PrivMessage("Error - You havent spawned.",player);
	else if ( PlayerInfo[player.ID].Local.Hide == true ) PrivMessage("Error - You are in Silent Mode.Error - You are in Silent Mode.", player);
	else {
		PlayerInfo[player.ID].Local.Hide = true;
		Echo("14> "+player+" entered in Silent Mode.");
		msg("> "+player+" entered in Silent Mode.",0,0,200);
		player.RemoveMarker();
	}
}

else if ( cmd == "level" ) {
	ShowMsg( "> " + player.Name + "'s Level: " + PlayerInfo[player.ID]["level"] + " (" + LevelTag( PlayerInfo[player.ID]["level"]) + ")", 10, 0 );
}

else if ( cmd == "admin" || cmd == "admins" ) {
	local i = 0, buffer, plr, level, to;
	foreach( plr in players ) {
		if ( PlayerInfo[plr.ID] ) {
			level = PlayerInfo[plr.ID]["level"];
			if ( level >= 2 ) {
				buffer = ( buffer ? buffer + ", " + plr.Name + " (Level: " + level + " - " + LevelTag( level ) + ")":plr.Name + " (Level: " + level + " - " + LevelTag( level ) + ")" );
			}
		}
	}
	to = ( buffer ? "> Admins Online: " + buffer:"> There are no admins in game.");
	Echo( "10" + to );
	msg( to, 0, 200, 50);
	print( to );
}

else if ( cmd == "timeplay" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned.", player);
	else {
		local show = "> " + player.Name + "'s Total Play Time: [" + duration(GetTime() - PlayerInfo[player.ID]["lastactive"] + PlayerInfo[player.ID]["playedtime"]) + "] Play Time after spawned: [" + duration(GetTime() - PlayerInfo[player.ID].Local.TimePlay) + "]";
		msg( show, 0, 200, 0);
		Echo( "10" + show );
	}
}

else if ( cmd == "ipm" ) {
	if ( Config.Irc.Enable ) {
		if (!text) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <IrcUser> <Text>",player);
		else {
			local msg = GetTok(text," ",2,NumTok(text, " ")), usr = GetTok(text," ",1);
			if (!msg || !usr) PrivMessage("/c "+cmd+" <IrcUser> <Text>",player);
			else {
				if (FindIrcUserID(usr) >= 0) {
				PrivMessage("PM Sent to: "+usr+", '"+msg+"'",player);
				EchoN(usr,"(Server PM) ["+player.ID+"] "+player.Name+": "+msg);
				}
				else PrivMessage(usr+" No such nick/channel",player);
			}
		}
	}
	else PrivMessage("Irc Echo Channel is Offline.", player);
}

else if (cmd == "server") {
	Echo("7>10 Server Name: ["+GetServerName()+"] GameMode: ["+GetGamemodeName()+"] IP:["+Bot.MeIP+":"+Config.Server.Port+"] Players: ["+GetPlayers()+"/"+GetMaxPlayers()+"] Password: ["+GetPassword()+"]");
	msg("> Server Name: ["+GetServerName()+"] GameMode: ["+GetGamemodeName()+"] IP:["+Bot.MeIP+":"+Config.Server.Port+"] Players: ["+GetPlayers()+"/"+GetMaxPlayers()+"] Password: ["+GetPassword()+"]",200, 200, 0);
}

else if (cmd == "irc") {
	if ( Config.Irc.Enable ) {
		msg(">Channel: "+Bot.Chan+" Network: "+Bot.NetName,200,0,200);
		Echo("10>Channel: "+Bot.Chan+" Network: "+Bot.NetName);
		msg( " --- IRC Users --- ",200,0,200); 
		Echo("10--- IRC Users --- ");
		local buffer;
		for ( local i=0,t=0; i<=50; i++,t++ ) {
			if( IrcUsers[i].Name ) {
				if ( t >= 15 ) { msg(buffer,200,0,200); Echo("10"+buffer); buffer=""; t=0; }
				if ( !buffer ) buffer = IrcUsers[i].Name;
				else buffer = buffer+", "+IrcUsers[i].Name;
				if ( buffer.slice(0,1) == ","  ) buffer=buffer.slice(2);
			}
		}
		msg(buffer,200,0,200); Echo("10"+buffer);
	}
	else PrivMessage("Irc Echo Channel is Offline.", player);
}

else if ( cmd == "heal" ) {
	local Cash = PlayerInfo[player.ID]["cash"], Cost = 100 - player.Health;
	if ( DistanceFromProp( player ) ) Cost = 0;
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned.", player );
	else if ( player.Health <= 0 ) PrivMessage( "Error - You havent spawned.", player );
	else if ( PlayerInfo[player.ID].Local.Waiting ) PrivMessage( "Error - You are in process a '"+PlayerInfo[player.ID].Local.Waiting[2]+"'", player );
	else if ( player.Health == 100 ) PrivMessage("Error - Your life is 100%!", player );
	else if ( Cash < Cost ) PrivMessage( "Error - You Need $" + Cost + "!", player );
	else {
		PlayerInfo[player.ID].Local.Waiting = [GetTime(), 0, "Health", Cost];
		PrivMessage("Wait 5sec to prevent death evade...", player);
		player.IsFrozen = true;
	}
}

else if (cmd == "undrunk") {
if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned.", player);
else if ( PlayerInfo[player.ID].Local.IsDrunk == false ) PrivMessage("Error - you are not Drunk!", player);
else if ( !NeedPlayerInArea(player,-626.4150,-580.3410,622.6376,651.6790) ) PrivMessage("Error - You need to be in the biker bar!", player);
else {
		PlayerInfo[player.ID].Local.IsDrunk = false;
		PrivMessage("Enjoying You Sobriety!", player);
		player.SetDrunkLevel(0, 0);
	}
}

else if (cmd == "drunk") {
if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned.", player);
else if ( PlayerInfo[player.ID].Local.IsDrunk == true ) PrivMessage("Error - Already Drunk!", player);
else if ( !NeedPlayerInArea(player,-626.4150,-580.3410,622.6376,651.6790) ) PrivMessage("Error - You need to be in the biker bar!", player);
else {
		PlayerInfo[player.ID].Local.IsDrunk = true;
		PrivMessage("Drinking beer, now you're drunk.", player);
		player.SetDrunkLevel(100, 100);
	}
}

else if ( cmd == "spikes" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned.", player);
	else {	
		player.Spikes = ( player.Spikes ? false:true );
		PrivMessage( player.Spikes ? "Spikes turned ON. now type /spike to use.":"Spikes turned OFF.", player);
	}
}

else if ( cmd == "shootinair" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned.", player);
	else {
		player.ShootInAir = ( player.ShootInAir ? false:true );
		PrivMessage( "Shot in Air are now turned " + ( player.ShootInAir ? "on":"off" ), player );
	}
}

else if ( cmd == "cd" ) {
	if ( Server.CountDown > 0 ) PrivMessage("Error - Already active countdown.",player);
	else {
		SetCountDown();
		NewTimer("SetCountDown", 1000, 3);
	}
}

else if ( cmd == "day" ) {
if (GetTime() - Server.WeaterChange <= 15) PrivMessage( "Error - Wait 15 Seconds before Changing Weater!", player );
else {
	Server.WeaterChange = GetTime();
	msg( "* "+player+" set the time to day.",0,200,0 );
	Echo("10* "+player+" set the time to day.");
	SetTime(12,00);
	SetWeather(11);              
    }
}

else if ( cmd == "night" ) {
if (GetTime() - Server.WeaterChange <= 15) PrivMessage( "Error - Wait 15 Seconds before Changing Weater!", player );
else {
	Server.WeaterChange = GetTime();
	msg( "* "+player+" set the time to night.",0,200,0 );
	Echo("10* "+player+" set the time to night.");
	SetTime(00,00);
	SetWeather(6);
	}
}

else if ( cmd == "foogy" ) {
if (GetTime() - Server.WeaterChange <= 15) PrivMessage( "Error - Wait 15 Seconds before Changing Weater!", player );
else {
	Server.WeaterChange = GetTime();
	msg( "* "+player+" set the time to Foogy.",0,200,0);
	Echo("10* "+player+" set the time to Foogy.");
	SetTime(14,00);
	SetWeather(10);               
    }
}

else if ( cmd == "arena" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <weapon name>", player );
	else if ( player.Health < 50 ) PrivMessage( "Error - Need More Health to user this command.", player );
	else {
		local wep_id = GetWeaponID( text ), wep_n = GetWeaponName( wep_id ), pos;
		if ( !Arenas.rawin( wep_id ) ) PrivMessage( "Error - Invalid Arena Name.", player );
		else {
			pos = split( Arenas[wep_id], " ");
			PlayerInfo[player.ID].Local.onArena = "Arena " + wep_n + "," + Arenas[wep_id] + "," + wep_id + "," + player.Pos;
			player.Pos = Vector( pos[0].tofloat() + RandNum(1,5), pos[1].tofloat() + RandNum(1,5), pos[2].tofloat() );
			ShowMsg( "> " + player.Name + " joined to arena " + wep_n + " type !arena "+ wep_n + " to join him!", 4, 0 );
			player.SetWeapon( 0, 0 );
			player.SetWeapon( wep_id, 600 );
		}
	}
}

else if ( cmd == "leave" || cmd == "la" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else if ( !PlayerInfo[player.ID].Local.onArena ) PrivMessage("Error - You're not in any arena, type !arena <weapon name> to join.", player);
	else {
		local sp = split(PlayerInfo[player.ID].Local.onArena,","), pPos = sp[3];
		ShowMsg("> " + player.Name + " is leaving " + sp[0] + ".", 10, 0);
		player.Pos = Vector(split(pPos, " ")[0].tofloat(), split(pPos, " ")[1].tofloat(), split(pPos, " ")[2].tofloat());
		SetWepString("25,21,32", player);
		PlayerInfo[player.ID].Local.onArena = null;
	}
}

else if ( cmd == "hunt" ) {
	if ( Server.Hunt.Started ) PrivMessage( "Error - The hunted already set in " + Server.Hunt.Player.Name, player );
	else if ( GetPlayers() < 3 ) PrivMessage( "Error - Need more players for start hunt!", player );
	else {
		local plrs = [], plr;
		foreach( plr in players ) {
			if ( plr.IsSpawned && PlayerInfo[plr.ID] && plr.ID != player.ID ) {
				plrs.push( plr );
			}
		}
		plr = ( plrs.len() > 1 ? plrs[RandNum(0,plrs.len())]:null );
		if ( plr ) {
			ManHunt( 0, plr );
		}
		else {
			PrivMessage( "Error - Can't start the hunted please try again.", player );
		}
	}
}

else if ( cmd == "hunted" ) {
	if ( Server.Hunt.Started ) {
		local rtime = 900 - ( GetTime() - Server.Hunt.Time );
		if ( rtime <= 0 ) {
			ManHunt( 1 );
		}
		else {
			ShowMsg( "[Hunt Status] Remaining time: " + duration( rtime ) + " Player: " + Server.Hunt.Player.Name + " Reward: $"+Server.Hunt.Rewar, 4, 0 );
		}
	}
	else {
		PrivMessage( "Error - No players in hunt, type !hunt to start.", player);
	}
}

else if ( cmd == "wepstats" || cmd == "weaponstats" ) { 
	local plr = ( text ? GetPlayer( text ):player ), s, buffer;
	if ( !plr ) PrivMessage( "Error - Invalid Nick/ID.", player );
	else if ( !PlayerInfo[plr.ID] ) ShowMsg( "> " + plr + " not registered nickname.", 4, 0 );
	else {
		s = split( PlayerInfo[plr.ID]["westats"], "," );
		for( local i = 0; i < s.len(); i++ ){
			if ( s[i] != "0" ) {
				buffer = ( buffer != null ? buffer + " " + GetWeaponName( i ) + ": " + s[i]:GetWeaponName( i ) + ": " + s[i] );
			}
		}
		ShowMsg( "- " + plr.Name + "'s Weapon Stats - ", 10, 0 );
		ShowMsg( buffer ? buffer:"Not Have Weapon Stats For This Player.", 10, 0 );
	}
}

else if ( cmd == "bstats" || cmd == "bodystats" ) {
	local plr = ( text ? GetPlayer( text ):player ), s;
	if ( !plr ) PrivMessage( "Error - Invalid Nick/ID.", player );
	else if ( !PlayerInfo[plr.ID] ) ShowMsg( "> " + plr + " not registered nickname.", 4, 0 );
	else {
		s = split( PlayerInfo[plr.ID]["bstats"], ",");
		ShowMsg( "> " + plr.Name + "'s Body Stats - Body: " + s[0] + " Torso: " + s[1] + " Left Arm: " + s[2] + " Right Arm: " + s[3] + " Left Leg: " + s[4] + " Right Leg: " + s[5] + " Head: " + s[6] + ".", 10, 0 );
	}
}

else if ( cmd == "wstats" || cmd == "wordstats" ) {
	local plr = ( text ? GetPlayer( text ):player ), s;
	if ( !plr ) PrivMessage( "Error - Invalid Nick/ID.", player );
	else if ( !PlayerInfo[plr.ID] ) ShowMsg( "> " + plr + " not registered nickname.", 4, 0 );
	else {
		s = split( PlayerInfo[plr.ID]["wstats"], "," );
		ShowMsg( "> " + plr.Name + "'s Word Stats - Letters: " + s[0] + " Words: " + s[1] + " Lines: " + s[2] + " Actions: " + s[3] + " Smiles: " + s[4], 10, 0 );
	}
}

else if (cmd == "stat" || cmd == "stats"){
		local plr = ( text ? GetPlayer( text ):player );
		if ( !plr ) PrivMessage( "Error - Invalid Nick/ID.", player );
		else if (!PlayerInfo[plr.ID]) ShowMsg( "> " + plr + " not registered nickname.", 4, 0 );
		else {
		local p = PlayerInfo[plr.ID], kills = p["kills"], deaths = p["deaths"], joins = p["joins"], spree = p["spree"], pickups = p["pickups"], ratio, show;
		if (kills > 0 && deaths > 0) { ratio = kills.tofloat() / deaths.tofloat(); ratio = format("%.2f",ratio); }
		if ( ratio ) {
			show = "* Stats: "+plr+", Joins: "+joins+", Kills: "+kills+" ("+RankTag(0,kills)+") Deaths: "+deaths+" Spree's: "+spree+", Pickups: "+pickups+" ("+RankTag(1,pickups)+") Ratio: "+ratio;
			msg( show, 139, 69, 19 ); Echo("5"+show); print(show);
		}
		else {
			show = "* Stats: "+plr+", Joins: "+joins+", Kills: "+kills+" ("+RankTag(0,kills)+") Deaths: "+deaths+" Spree's: "+spree+", Pickups: "+pickups+" ("+RankTag(1,pickups)+")";
			msg( show, 139, 69, 19 ); Echo( "5" + show); print( show );
		}
	}
}

else if ( cmd == "rank" ) {
	local plr = ( text ? GetPlayer( text ):player );
	if ( !plr ) PrivMessage("Error - Invalid Nick/ID", player);
	else {
		local show = "> " + plr.Name + "'s Rank Kills[ " + RankTag( 0, PlayerInfo[plr.ID]["kills"] ) + " ]  Pickups[ " + RankTag(1, PlayerInfo[plr.ID]["pickups"]) + " ]."
		msg( show, 0, 200, 0 );
		Echo( "5" + show );
	}
}

else if ( cmd == "timewep" ) {
	ShowMsg( "> The Current weapon time is " + GetWeaponName( Server.WepB ) + " kill with this and get more money!", 4, 0 );
}

else if ( cmd == "disarm" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else { PrivMessage("Removed all weapons.",player); player.SetWeapon(0,0); }
}

else if ( cmd == "wep" || cmd == "we" ) {
	local wep, wepname;
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <wepname/id>", player );
	else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else {
		local arms = Replace( text, ",", " " ), a = 1, nun = NumTok( arms, " " );
		while ( a <= nun ) {
			local wep2 = GetTok( arms, " ", a );
			if ( IsNum( wep2 ) ) wep = wep2.tointeger();
			else wep = GetWeaponID( wep2 );	
			if ( !ValidWep( wep ) ) {
			PrivMessage( wep2 + " - Error - Invalid Weapon ID/Name.", player );
			a += 1;
			}
			else {
				if ( wepname ) wepname = wepname + ", " + GetWeaponName( wep );
				else wepname = GetWeaponName( wep );
				player.SetWeapon( wep, 900 );
				a++;
			}
		}
		if ( wepname ) {
		msg( ">> Giving: " + wepname + " - " + player, 95,158,160);
		Echo( "2>> 10Giving: " +  wepname + " - " + player );
		}
	}
}

else if ( cmd == "savewep" || cmd == "spawnwep" ) {
	local wep, wepname, wepid;
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <wep1,wep2,wep3.../off>", player );
	else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else {
	if (text == "off") {
	if (PlayerInfo[player.ID]["weps"] == "0") { PrivMessage("Error - Not have weapons saved.",player); }
	else {
	PrivMessage("Spawn Wep Turned Off, type !savewep <wep1,wep2,wep3...> to active again.", player);
	PlayerInfo[player.ID]["weps"] = "0";
		}
	}
	else {
		local arms = Replace( text, ",", " " ), a = 1, nun = NumTok( arms, " " );
		if ( nun <= 1 ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <wep1,wep2,wep3.../off>", player);
		else {
			player.SetWeapon( 0, 0);
			while ( a <= nun ) {
				local wep2 = GetTok( arms, " ", a );
				if ( IsNum( wep2 ) ) wep = wep2.tointeger();
				else wep = GetWeaponID( wep2 );	
				if ( !ValidWep( wep ) ) {
				PrivMessage( wep2 + " - Error - Invalid Weapon ID/Name.", player );
				a += 1;
				}
				else {
					if ( wepname ) { 
					wepname = wepname + ", " + GetWeaponName( wep ); 
					wepid = wepid + "," + wep;
					}
					else { 
					wepname = GetWeaponName( wep ); 
					wepid = wep;
					}
					a++;
				}
			}
			if ( wepname && wepid ) {
			if (rWepSlot(wepid)) { 
			PrivMessage("Error - You're using one slot for one of your weapons!",player);
			PrivMessage("Choose Other Weapons.",player);
			}
				else {
					PlayerInfo[player.ID]["weps"] = wepid;
					SetWepString(wepid, player);
					msg( ">> "+player+" Saved Weapon Pack: " + wepname, 95,158,160);
					Echo( "10>> "+player+" Saved Weapon Pack: " +  wepname);
					}
				}
			}
		}
	}
}

else if ( cmd == "ff" ) {
if ( !player.Vehicle ) PrivMessage( "Error - You are currently on foot.", player );
else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
else {
	player.Vehicle.Fix();
	local pos = player.Vehicle.Pos;
	pos.z += 1; pos.x += 1; pos.y += 1;
	player.Vehicle.Pos = pos;
	PrivMessage("Fixed and Flipped yur vehicle.",player);
	}
}

else if ( cmd == "flip" ) {
if ( !player.Vehicle ) PrivMessage( "Error - You are currently on foot.", player );
else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
else {
	local pos = player.Vehicle.Pos;
	pos.z += 1; pos.x += 1; pos.y += 1;
	player.Vehicle.Pos = pos;
	}
}

else if ( cmd == "fix" ) {
if (!player.Vehicle) PrivMessage( "Error - You are currently on foot.", player );
else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
else if (player.Vehicle.Health/10 >= 75 ) PrivMessage( "Error - Your vehicle no need fix.", player );
else {
	PrivMessage( "Your vehicle has been fixed.", player ); 
	player.Vehicle.Fix();
	}
}

else if ( cmd == "eject" ) {
if ( !player.Vehicle ) PrivMessage( "Error - You are currently on foot.", player );
else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
else {
	local pos = player.Vehicle.Pos;
    pos.z +=1; pos.x +=1; pos.y +=1;
	player.Pos = pos;
	}
}

else if ( cmd == "bstunt") {
if (!text) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + "<on/off>", player);
else if (!player.IsSpawned) PrivMessage( "Error - You havent spawned", player );
else if (!player.Vehicle) PrivMessage("Error - You are currently on foot.",player);
else {
	if (text == "on") {
	if (player.StuntMode == true) PrivMessage("Error - Stunt bike already turned on.",player); 
	else {
		PrivMessage("Stunt bike enabled.",player); 
		player.StuntMode = true;
		}
	}
	else if (text == "off") {
	if (player.StuntMode == false) PrivMessage("Error - Stunt bike already turned off.",player); 
	else {
		player.StuntMode = false;
		PrivMessage("Stunt bike disabled.",player); 
		}
	}
	else PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <on/off>", player);
	}
}

else if ( cmd == "forsale" ) {
	ShowMsg("> Vehicles: " + Vehicles.len() + " - Sold's: " + Server.Cars + " Available: " + ( Vehicles.len() - Server.Cars ) + " Property's: " + Properties.len() + " - Sold's: " + Server.Props + " Aviable: " + ( Properties.len() - Server.Props ), 10, 0 );
}

else if ( cmd == "car" ) {
	local plr = "";
	if ( !text ) { plr = player; } else { plr = GetPlayer(text); }
	if ( !plr ) { PrivMessage("Error - Invalid Nick/ID.", player); }
	else if ( !plr.IsSpawned ) { PrivMessage("Error - This player hasnt spawned.", player); }
	else if ( !plr.Vehicle ) { PrivMessage("Error - This player are currently on foot.", player); }
	else {
		local v = Vehicles[plr.Vehicle.ID];
		PrivMessage( "- Car -", player );
		PrivMessage( "Name: [" + GetVehicleNameFromModel( plr.Vehicle.Model ) + "], ID: [" + plr.Vehicle.ID + "] " + "Health: " + format("%.2f",(plr.Vehicle.Health / 10)) + "% Owner: ["+ v["owner"] + "] Shared: ["+ v["shared"] + "] Cost: [$"+mformat(v["cost"])+"]" , player );
		PrivMessage( format("Gasoline: %s - %i Gal.", RateVar(Vehicles[plr.Vehicle.ID].Local.Gas), Vehicles[plr.Vehicle.ID].Local.Gas), player );
		if ( plr.ID != player.ID) PrivMessage( "Distance from you: " + GetDistance(player.Pos, plr.Pos)+"m", player);
	}
}

else if ( cmd == "mycars" ) {
	if ( !player.IsSpawned ) PrivMessage( "Error - You havent spawned", player );
	else {
		local i = 0, x = 0;
		PrivMessage("- Car's -", player);
		while ( i < Vehicles.len()) {
			if (Vehicles[i]["owner"] == player.Name) {
				PrivMessage( "Owner [" + FindVehicle( i ) + "] - ID [" + i + "]", player );
				x++; 
			}
			if (Vehicles[i]["shared"] == player.Name) { 
				PrivMessage( "Shared ["+ FindVehicle( i ) + "] - ID [" + i + "]", player);
				x++; 
			}
			i++;
		}
		if ( x == 0 ) PrivMessage( "Error - You dont own any car.", player );
	}
}

else if ( cmd == "buycar" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else if ( !player.Vehicle ) PrivMessage("Error - You need to be in the vehicle you want to buy.", player);
	else if ( !onSunshine( player ) ) PrivMessage("Error - You must be in Sunshine Autos!", player);
	else if ( PlayerInfo[player.ID]["ccars"] >= Config.Server.MaxCars ) { PrivMessage("Error - You not have more space for other Car's!", player); }
	else {
		local idb = player.Vehicle.ID, veh = Vehicles[idb];
		if ( player.Vehicle.ID != idb ) PrivMessage("Error - You need to be in the vehicle you want to buy.", player);
		else if ( PlayerInfo[player.ID]["cash"] < veh["cost"] ) PrivMessage("Error - You Need: " + mformat(veh["cost"].tointeger()) + " to buy this Car.", player);
		else if ( veh["owner"] != "Vice City" ) PrivMessage("Error - This car is already owned.", player);
		else {
			if ( ManageVehicle(0, player.Name, idb) ) {
				PrivMessage("You Purchased: "+ FindVehicle(idb) + " ID: " + idb + " for $" + mformat(veh["cost"]),player);
				PrivMessage("You can now use the following commands: !sellcar, !mycars, !getcar, !sharecar, !lockcar, !parkcar", player);
				Echo("3> Vehicle Sold: "+FindVehicle(idb)+" ID: "+idb+" for $"+mformat(veh["cost"])+" to "+player.Name);
				msg("> Vehicle Sold: "+FindVehicle(idb)+" ID: "+idb+" for $"+mformat(veh["cost"])+" to "+player.Name,0, 206, 209);
				PlayerInfo[player.ID]["ccars"]++;
				PlayerInfo[player.ID]["cash"] -= veh["cost"];
				player.Cash -= veh["cost"];
			}
		}
	}
}

else if ( cmd == "sellcar" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else if ( !player.Vehicle ) PrivMessage("Error - You need to be in the vehicle you want to sell.", player);
	else if ( !onSunshine( player ) ) PrivMessage("Error - You must be in Sunshine Autos!", player);
	else {
		local idb = player.Vehicle.ID, veh = Vehicles[idb];
		if ( player.Vehicle.ID != idb ) PrivMessage("Error - You need to be in the vehicle you want to buy.", player);
		else if ( veh["owner"] != player.Name ) PrivMessage("Error - You dont own this car.", player);
		else {
			if ( ManageVehicle(8, player.Name, idb) ) {
				local cost = veh["cost"] - 150;
				PrivMessage("You Sell: "+ FindVehicle(idb) + " ID: " + idb + " for $" + mformat(cost),player);
				Echo("3> Sold a: "+FindVehicle(idb)+" ID: "+idb+" for $"+mformat(veh["cost"]));
				msg("> Sold a: "+FindVehicle(idb)+" ID: "+idb+" for $"+mformat(veh["cost"]),0, 206, 209);
				PlayerInfo[player.ID]["ccars"]--;
				PlayerInfo[player.ID]["cash"] += cost;
				player.Cash += cost;
			}
		}
	}
}

else if ( cmd == "sharecar" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else if ( !player.Vehicle ) PrivMessage("Error - You need to be in the vehicle you want to share.", player);
	else if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player>", player);
	else {
		local id = player.Vehicle.ID, v = Vehicles[id], plr = GetPlayer( text );
		if ( v["owner"] != player.Name ) PrivMessage("Error - You dont own this car.", player);
		else if ( v["shared"] != "None" ) PrivMessage("Error - This car already shared with " + v["shared"], player);
		else if ( !plr ) PrivMessage("Error - Invalid Nick/ID.", player);
		else if ( !plr.IsSpawned ) PrivMessage("Error This Player not Spawned.", player);
		else if ( player.ID == plr.ID ) PrivMessage("Error - Can Not share this car with you.", player);
		else if ( !PlayerInfo[plr.ID] ) PrivMessage("Error - Invalid Nick/ID.", player);
		else {
			if ( ManageVehicle(1, plr.Name, id) ) {
				PrivMessage("Started shared your "+FindVehicle( id ) + " with " + plr.Name, player);
				PrivMessage(player.Name + " start share vehicle: "+FindVehicle( id ) + " ID: " + id + " with you.", plr);
			}
		}
	}
}

else if ( cmd == "delsharecar" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else if ( !player.Vehicle ) PrivMessage("Error - You need to be in the vehicle you want to del share.", player);
	else {
		local id = player.Vehicle.ID, v = Vehicles[id];
		if ( v["owner"] != player.Name ) PrivMessage("Error - You dont own this car.", player);
		else if ( v["shared"] == "None" ) PrivMessage("Error - This car is not shared.", player);
		else {
			local share = v["shared"];
			if ( ManageVehicle(2, share, id) ) {
				PrivMessage( "You are no longer sharing your vehicle with [ " + share + " ]", player );
				PrivMessage( "Name: " + FindVehicle( id ) + ", ID: " + id, player );
			}
		}
	}
}

else if ( cmd == "lockcar" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player);
	else if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <car id>", player);
	else if ( !IsNum(text) || text.tointeger() >= Vehicles.len() || text.tointeger() < 0 ) PrivMessage( "Error - Vehicle does not exist.", player );
	else if ( Vehicles[text.tointeger()]["owner"] != player.Name ) PrivMessage("Error - You dont own this car.", player);
	else {
		local v = FindVehicle( text.tointeger() );
		if ( !v.IsLocked ) {
			if ( ManageVehicle(3, player, v.ID) ) {
				PrivMessage("Vehicle[" + v + "] ID[" + v.ID + "] are now locked for others players.", player);
			}
		}
		else {
			if ( ManageVehicle(4, player, v.ID) ) {
				PrivMessage("Vehicle[" + v + "] ID[" + v.ID + "] are now unlocked for others players.", player);
			}
		}
	}
}

else if ( cmd == "parkcar" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player);
	else if ( !player.Vehicle ) PrivMessage("Error - you are currently on foot.", player);
	else if ( Vehicles[player.Vehicle.ID]["owner"] != player.Name ) PrivMessage("Error - You dont own this car.", player);
	else {
		if ( GetVehicleType( player.Vehicle.Model ) == "Car" || GetVehicleType( player.Vehicle.Model ) == "Bike" ) {
			local v = FindVehicle( player.Vehicle.ID ), dis = DistanceFromProp( player ), pos = player.Pos.x+" "+player.Pos.y+" "+player.Pos.z;
			if ( !dis ) PrivMessage("Error - You need least 50m of one property to park your car.", player);
			else {
				if ( ManageVehicle( 5, pos, v.ID ) ) {
					PrivMessage("Parked Car! Location["+GetDistrictName( player.Pos.x, player.Pos.y )+"] Coordinates["+player.Pos+"]", player);
				}
			}
		}
		else PrivMessage("Error - "+player.Vehicle+" Invalid Vehicle Type.", player);
	}
}

else if ( cmd == "lights" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player);
	else if ( !player.Vehicle ) PrivMessage("Error - you are currently on foot.", player);
	else {
		local v = FindVehicle( player.Vehicle.ID );
		v.Lights = ( !v.Lights ? true:false );
		PrivMessage( v + " Lights turned " + ( !v.Lights ? "off":"on" ), player);
	}
}

else if ( cmd == "engine" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player);
	else if ( !player.Vehicle ) PrivMessage("Error - you are currently on foot.", player);
	else {
		PrivMessage( player.Vehicle + " Engine Turned off", player);
		FindVehicle( player.Vehicle.ID ).KillEngine();
	}
}

else if ( cmd == "detonate" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player);
	else if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <car id>", player);
	else if ( !IsNum(text) || text.tointeger() >= Vehicles.len() || text.tointeger() < 0 ) PrivMessage( "Error - Vehicle does not exist.", player );
	else {
		local id = text.tointeger(), v = FindVehicle( id ), plr;
		if ( Vehicles[id]["owner"] != player.Name ) PrivMessage("Error - You dont own this car.", player);
		else if ( !v.Driver ) PrivMessage("Error - " + v + " ID["+v.ID+"] not have drive.", player);
		else if ( v.Driver.Name == player.Name ) PrivMessage("Error - Not detonate the car if you are driver.", player);
		else if ( v.Health <= 0 ) PrivMessage("Error - " + v + " ID["+v.ID+"] not Spawned.", player);
		else {
			v.Health = 0;
			plr = FindPlayer( v.Driver.ID );
			plr.Health = 0;
			PrivMessage("Detonate your " + v + " ID["+v.ID+"], drive by "+plr.Name, player);
			PrivMessage(player.Name+" detonate your " + v + " ID["+v.ID+"]", plr);
		}
	}
}

else if ( cmd == "autofix" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player);
	else if ( !player.Vehicle ) PrivMessage("Error - you are currently on foot.", player);
	else {
		local id = player.Vehicle.ID, v = FindVehicle( id );
		if ( Vehicles[id]["owner"] != player.Name ) PrivMessage("Error - You dont own this car.", player);
		else {
			if ( Vehicles[id]["autofix"] == "true" ) {
				if ( ManageVehicle( 7, player, id ) ) {
					PrivMessage("Auto Fix of " + v + " ID["+v.ID+"] now turned off.", player);
				}
			}
			else {
				if ( ManageVehicle( 6, player, id ) ) {
					PrivMessage("Auto Fix of " + v + " ID["+v.ID+"] now turned on.", player);
				}
			}
		}
	}
}

else if ( cmd == "getcar" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player);
	else if ( player.Health < 50 ) PrivMessage("Error - You need at least 50HP to use this command.", player);
	else if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <car ID>", player);
	else if ( !IsNum(text) || text.tointeger() >= Vehicles.len() || text.tointeger() < 0 ) PrivMessage( "Error - Vehicle does not exist.", player );
	else if ( player.Vehicle ) { if ( player.Vehicle.ID == text.tointeger() ) PrivMessage("Error - Already drive on this car.", player); }
	else {
		local v = FindVehicle( text.tointeger() ), veh = Vehicles[text.tointeger()], pos = player.Pos;
		if ( veh["owner"] == player.Name || veh["shared"] == player.Name ) {
			v.Pos = Vector( pos.x + 2, pos.y, pos.z );
			PrivMessage("Spawned your "+v+" ID: "+text+" Health: "+format("%.2f",(v.Health / 10))+"%",player);
		}
		else PrivMessage("Error - You dont own this car.", player);
	}
}

else if ( cmd == "gotomycar" ) {
	if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player);
	else if ( player.Health < 50 ) PrivMessage("Error - You need at least 50HP to use this command.", player);
	else if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <car ID>", player);
	else if ( !IsNum(text) || text.tointeger() >= Vehicles.len() || text.tointeger() < 0 ) PrivMessage( "Error - Vehicle does not exist.", player );
	else {
		local v = Vehicles[text.tointeger()], pos = FindVehicle( text.tointeger() ).Pos;
		if ( v["owner"] == player.Name || v["shared"] == player.Name ) {
			player.Pos = Vector( pos.x + 2, pos.y, pos.z );
			PrivMessage("Teleported to your " + FindVehicle( text.tointeger() ) + " ID: "+text, player);
		}
		else PrivMessage("Error - You dont own this car.", player);
	}
}

else if ( cmd == "check" ) {
	local plr = ( text ? GetPlayer( text ):player );
	if ( !plr ) PrivMessage("Error - Invalid Nick/ID.", player );
	else if ( !plr.IsSpawned ) PrivMessage("Error - This player hasnt spawned.",player);
	else {
	msg("-> "+plr+"'s Health:["+plr.Health+"%] Armour:["+plr.Armour+"%] Ping: ["+plr.Ping+"ms]",0,100,0);
	Echo("10-> "+plr+"'s Health:["+plr.Health+"%] Armour:["+plr.Armour+"%] Ping: ["+plr.Ping+"ms]");
	print("-> "+plr+"'s Health:["+plr.Health+"%] Armour:["+plr.Armour+"%] Ping: ["+plr.Ping+"ms]");
	}
}

else if ( cmd == "ping" ) {
	local plr = ( text ? GetPlayer( text ):player );
	if ( !plr ) PrivMessage("Error - Invalid Nick/ID.", player );
	else {
		ShowMsg( "> " + plr.Name + " Ping: " + plr.Ping + "ms", 10, 0 );
	}
}

else if ( cmd == "hp" ) {
	local plr = ( text ? GetPlayer( text ):player );
	if ( !plr ) PrivMessage("Error - Invalid Nick/ID.", player );
	else if ( !plr.IsSpawned ) PrivMessage("Error - This player hasnt spawned.",player);
	else {
		ShowMsg( "> " + plr.Name + " Health: " + plr.Health + "%", 10, 0 );
	}
}

else if ( cmd == "arm" ) {
	local plr = ( text ? GetPlayer( text ):player );
	if ( !plr ) PrivMessage("Error - Invalid Nick/ID.", player );
	else if ( !plr.IsSpawned ) PrivMessage("Error - This player hasnt spawned.",player);
	else {
		ShowMsg( "> " + plr.Name + " Armour: " + plr.Armour + "%", 10, 0 );
	}
}

else if ( cmd == "loc" ) {
	local plr = ( text ? GetPlayer( text ):player );
	if ( !plr ) PrivMessage( "Error - Invalid Nick/ID.", player );
	else if ( !plr.IsSpawned ) PrivMessage( "Error - This player hasnt spawned.", player );
	else {
		local pos = plr.Pos, show = "";
		if (plr.ID == player.ID) { show = "* "+plr.Name+" spawned on ("+GetDistrictName(pos.x,pos.y)+") Coordenates: "+pos; }
		else { show = "* "+plr.Name+" spawned on ("+GetDistrictName(pos.x,pos.y)+") Coordenates: ("+pos+") Distance: ("+format("%.2f",(GetDistance(player.Pos,plr.Pos)))+"m) Direction: ("+direction(player.Pos.x,player.Pos.y,plr.Pos.x,plr.Pos.y)+ ")"; }
		msg( show, 0, 200, 200 );
		Echo( "10" + show );
		print( show );
	}
}

else if ( cmd == "spawnloc" ) {
if ( !player.IsSpawned ) PrivMessage( "Error - You havent spawned", player );
else if ( !text ) { PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <on/off>",player); }
else {
	if (text == "on") {
		local d = DistanceFromObjets(player);
		if (d) { PrivMessage("Error - You Are at "+d+"m of ane Object, You need more than 80m",player); }
		else {
		PrivMessage("Spawn Loc Saved! at "+player.Pos+" ("+GetDistrictName( player.Pos.x, player.Pos.y )+")", player);
		local pos = player.Pos.x+" "+player.Pos.y+" "+player.Pos.z;
		PlayerInfo[player.ID]["locspw"] = pos.tostring();
		}
	}
	else if (text == "off") {
		if (PlayerInfo[player.ID]["locspw"] == "0") { PrivMessage("Error - You not have activated the Spawn Loc",player); }
		else {
		PrivMessage("Spawn Loc now turned off, type !spanwloc on, to active again.",player);
		PlayerInfo[player.ID]["locspw"] = "0";
		}
	}
	else { PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd +  "<on/off>",player); }
	}
}

else if ( cmd == "goto" ) {
local Cash = PlayerInfo[player.ID]["cash"], plr = "", cost = 0;
if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <Nick/ID>", player );
else {
	plr = GetPlayer( split(text," ")[0] );
	if ( !plr ) PrivMessage("Error - Invalid Nick/ID.", player );
	else if ( !PlayerInfo[plr.ID] ) PrivMessage("Error - Invalid Nick/ID.", player );
	else if ( PlayerInfo[plr.ID]["nogoto"] == "true" ) PrivMessage("Error - This player has turned off the option for players to goto them.", player);
	else {
		cost = GetDistance(player.Pos,plr.Pos)/2;
		cost = format("%.f",(cost)).tointeger();
		cost = (cost >= 250 ? 250:cost);
		if ( plr.ID == player.ID ) PrivMessage("Error - You cant goto yourself.", player );
		else if ( Cash < cost ) PrivMessage("Error - You need to teleport, $"+mformat(cost), player );
		else if ( cost < 5 ) { PrivMessage("Error - You are at "+cost+"m, no need teleport.", player); }
		else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
		else if ( !plr.IsSpawned ) { PrivMessage("Error - This player hasnt spawned.", player); }
		else if ( PlayerInfo[plr.ID].Local.onArena ) PrivMessage("Error - This Player is in " + split(PlayerInfo[plr.ID].Local.onArena,",")[0], player);
		else if ( PlayerInfo[player.ID].Local.Waiting ) PrivMessage( "Error - You are in process a '"+PlayerInfo[player.ID].Local.Waiting[2]+"'", player );
		else {
			PlayerInfo[player.ID].Local.Waiting = [GetTime(), 1, "Goto", cost, plr];
			PrivMessage("Wait 5sec to prevent death evade...", player);
			player.IsFrozen = true;
			}
		}
	}
}

else if ( cmd == "nogoto" ) {
	if ( !player.IsSpawned ) PrivMessage( "Error - You havent spawned", player );
	else if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <on/off>", player );
	else if ( text == "on" ) {
		if ( PlayerInfo[player.ID]["nogoto"] == "true" ) PrivMessage( "Error - Your NoGoto is already turned on.", player );
		else {
			PlayerInfo[player.ID]["nogoto"] = "true";
			PrivMessage( "People are no longer able to teleport to you.", player );
		}
	}
	else if ( text == "off" ) {
		if ( PlayerInfo[player.ID]["nogoto"] == "false" ) PrivMessage("Error - Your NoGoto is already turned off.", player);
		else {
			PlayerInfo[player.ID]["nogoto"] = "false";
			PrivMessage( "People are now able to teleport to you.", player );
		}
	}
	else PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <on/off>", player );
}

else if ( cmd == "saveloc" ) {
	local d = DistanceFromObjets(player);
	if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <locname>", player );
	else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else if ( GotoLocs.rawin( text.tolower() ) ) PrivMessage("Error - The name of the location that is already in use!", player );
	else if ( PlayerInfo[player.ID]["cgotolocs"] >= Config.Server.MaxGotolocs ) PrivMessage("Error - You not have more space for other Saveloc!, try !delsaveloc to delete one.", player);
	else if ( d ) { PrivMessage("Error - You Are at "+d+"m of ane Object, You need more than 80m",player); }
	else {
		local name = text.tolower(), pos = player.Pos.x+" "+player.Pos.y+" "+player.Pos.z, loc = GetDistrictName(player.Pos.x, player.Pos.y);
		local show = "> "+player.Name+" Save New Location! Name["+name+"] Place["+loc+"] Coordenates["+pos+"]";
		local sql = "INSERT INTO gotoloc (name, pos, creator, createat) VALUES('"+name+"', '"+pos+"', '"+player.Name+"','"+loc+"')";
		GotoLocs.rawset( text.tolower(), {name = text.tolower(), pos = pos, creator = player.Name, createat = loc } );
		PlayerInfo[player.ID]["cgotolocs"]++;
		if ( Config.MySQL.Enable ) {
			CheckSqlConect();
			mysql_query(my_db, sql);
		}
		else {
			QuerySQL(sqlite, sql);
		}
		msg( show, 0, 200, 0 );
		Echo( "10" + show );
	}
}

else if ( cmd == "delgotoloc" ) {
	if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <locname>", player );
	else if ( !GotoLocs.rawin( text.tolower() ) ) PrivMessage("Error - The Location: '"+text+"' not Exist.", player);
	else if ( GotoLocs[text.tolower()]["creator"] != player.Name ) PrivMessage("Error - You not are owner of this location.", player);
	else {
		GotoLocs.rawdelete(text.tolower());
		PlayerInfo[player.ID]["cgotolocs"]--;
		local show = "> " + player.Name + " delete Location: '" + text.tolower() + "'.";
		local sql = "DELETE FROM gotoloc WHERE name = '"+text.tolower()+"'";
		if ( Config.MySQL.Enable ){
			CheckSqlConect();
			mysql_query(my_db, sql);
		}
		else {
			QuerySQL(sqlite, sql);
		}
		msg( show, 0, 200, 0 );
		Echo( "4" + show );
	}
}

else if ( cmd == "gotoloc" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <locname>", player );
	else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
	else if ( player.Health < 90 ) PrivMessage("Error - You need more Health to use this command!", player);
	else if ( !GotoLocs.rawin( text.tolower() ) ) PrivMessage("Error - The Location: '"+text+"' not Exist.", player);
	else if ( PlayerInfo[player.ID].Local.Waiting ) PrivMessage( "Error - You are in process a '"+PlayerInfo[player.ID].Local.Waiting[2]+"'", player );
	else {
		PlayerInfo[player.ID].Local.Waiting = [GetTime(), 2, "Goto Loc", GotoLocs[text.tolower()]];
		PrivMessage("Wait 5sec to prevent death evade...", player);
		player.IsFrozen = true;
	}
}

else if ( cmd == "mygotolocs" ) {
	local x = 0;
	foreach( loc in GotoLocs ) {
		if ( loc["creator"] == player.Name ) {
			PrivMessage("Location: " + loc["name"] + " Area: " + loc["createat"], player);
			x++;
		}
	}
	PrivMessage( x == 0 ? "Not have locations save, type !saveloc <loc name> to save one.":"Total Locations: " + x, player);
}

else if ( cmd == "tradecookie" ) {
	if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <item>", player);
	else if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned.", player);
	else {
		local item = split( text, " " )[0], cost, coi = PlayerInfo[player.ID]["cookies"];
			
		if ( item == "deaths" ) {
			cost = 150;
			if ( cost > coi ) PrivMessage( "Error - Not have sufficient cookies!!", player );
			else {
				PlayerInfo[player.ID]["deaths"] = 0;
				PlayerInfo[player.ID]["cookies"] -= cost;
				ShowMsg( "> " + player.Name + " exchange " + cost + " cookies for reset you'r deaths.", 10, 0 );
			}
		}
		else if ( item == "heal" ) {
			cost = 1;
			if ( cost > coi ) PrivMessage( "Error - Not have sufficient cookies!!", player );
			else if ( player.Health > 80 ) PrivMessage("Error - You no need health", player);
			else {
				player.Health = 100;
				PlayerInfo[player.ID]["cookies"] -= cost;
				ShowMsg( "> " + player.Name + " exchange " + cost + " cookies for set to 100% you'r health.", 10, 0 );
			}
		}
		else if ( item == "arm" ) {
			cost = 1;
			if ( cost > coi ) PrivMessage( "Error - Not have sufficient cookies!!", player );
			else if ( player.Armour > 80 ) PrivMessage("Error - You not need armour.", player);
			else {
				player.Armour = 100;
				PlayerInfo[player.ID]["cookies"] -= cost;
				ShowMsg( "> " + player.Name + " exchange " + cost + " cookies for set to 100% you'r armour", 10, 0 );
			}
		}
		else PrivMessage( "Error - Invalid Item Name aviable item's: deaths/heal/arm", player );
		}
}


else if ( cmd == "cookies" ){
	ShowMsg( player.Name + ( !PlayerInfo[player.ID]["cookies"] ? " not have cookies :(":" have " + PlayerInfo[player.ID]["cookies"] + " cookies!"), 10, 0 );
	Announce( PlayerInfo[player.ID]["cookies"].tostring(), player );
}


else if ( cmd == "cash" ) {
	PrivMessage("Current money: $"+mformat(PlayerInfo[player.ID]["cash"])+" Bank Balance: $"+mformat(PlayerInfo[player.ID]["bank"]),player);
	Announce( "~b~$"+mformat(PlayerInfo[player.ID]["cash"]), player );
}

else if ( cmd == "showcash" ) {
	local TheMSG = player+" "+"Current money: $"+mformat(PlayerInfo[player.ID]["cash"])+" Bank Balance: $"+mformat(PlayerInfo[player.ID]["bank"]);
	msg(">> "+TheMSG,25,25,112);
	Echo("10>> "+TheMSG);
	print(TheMSG);
}

else if ( cmd == "givecash" ) {
	if ( !player.IsSpawned ) { PrivMessage("Error - You havent spawned.", player); }
	else if ( !text ) { PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <amount>", player); }
	else {
		if ( split(text," ").len() < 2 ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <amount>", player);
		else {
			local plr = GetPlayer(split(text," ")[0]), amount = split(text," ")[1];
			if ( !plr ) { PrivMessage("Error - Unknown Player/ID.", player); }
			else if ( plr.ID == player.ID ) { PrivMessage("Error - You can not give money to yourself.", player); }
			else if ( !IsNum(amount) ) { PrivMessage("Error - Invalid Amount.", player); }
			else if ( !PlayerInfo[plr.ID] ) { PrivMessage("Error - "+plr.Name+" is not register Nick Name.", player); }
			else if ( !plr.IsSpawned ) { PrivMessage("Error - This Player is not spawned.", player); }
			else if ( !onBank( player ) || !onBank( plr ) ) { PrivMessage("Error - They are not in the bank.", player); }
			else if ( PlayerInfo[player.ID]["cash"] < amount.tointeger()) { PrivMessage("Error - You do not have Money.", player); }
			else if ( amount.tointeger() > 999999999 ) { PrivMessage("Error - Invalid Amount.", player); }
			else {
				amount = amount.tointeger();
				PlayerInfo[player.ID]["cash"] -= amount;
				PlayerInfo[plr.ID]["cash"] += amount;
				player.Cash -= amount;
				plr.Cash += amount;
				PrivMessage("You give $"+mformat(amount)+", to "+plr.Name+". New Balance: $"+mformat(PlayerInfo[player.ID]["cash"]), player);
				PrivMessage(player+", give $"+mformat(amount)+", to you. New Balance: $"+mformat(PlayerInfo[plr.ID]["cash"]), plr);
			}
		}
	}
}

else if ( cmd == "deposit" ) {
	if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <amount/all>", player);
	else if ( onBank( player ) != true ) PrivMessage( "Error - you must be in the bank!", player );
	else {
	local Cash = PlayerInfo[player.ID]["cash"];
	if ( text == "all" ) {
	if ( Cash == 0 ) PrivMessage( "Error - You do not have Money.", player );
	else {
		player.Cash -= Cash;
		PlayerInfo[player.ID]["cash"] -= Cash;
		PlayerInfo[player.ID]["bank"] += Cash;
		PrivMessage("Money Deposited.", player );
		PrivMessage("Current money: $"+mformat(PlayerInfo[player.ID]["cash"])+", Bank Balance: $"+mformat(PlayerInfo[player.ID]["bank"]),player);
		}
	}
	else {
		if ( !IsNum( text ) ) PrivMessage( "Error - Invalid Amount.", player );
		else if ( text.tointeger() > 999999999 ) { PrivMessage("Error - Invalid Amount.", player); }
		else if ( Cash < text.tointeger() ) PrivMessage("Error - You do not have Money.",player );
		else {
			player.Cash -= text.tointeger();
			PlayerInfo[player.ID]["cash"] -= text.tointeger();
			PlayerInfo[player.ID]["bank"] += text.tointeger();
			PrivMessage("Money Deposited.", player );
			PrivMessage("Current money: $"+mformat(PlayerInfo[player.ID]["cash"])+", Bank Balance: $"+mformat(PlayerInfo[player.ID]["bank"]),player);
			}
		}
	}
}

else if ( cmd == "withdraw" ) {
if ( !text ) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <amount/all>", player);
else if ( onBank( player ) != true ) PrivMessage( "Error - you must be in the bank!", player );
else {
	local Bank = PlayerInfo[player.ID]["bank"];
	if ( text == "all" ) {
	if ( Bank == 0 ) PrivMessage("Error - You do not have Money.",player );
	else {
	player.Cash += Bank;
	PlayerInfo[player.ID]["cash"] += Bank;
	PlayerInfo[player.ID]["bank"] -= Bank;
	PrivMessage( "Money Withdrawn.", player );
	PrivMessage("Current money: $"+mformat(PlayerInfo[player.ID]["cash"])+", Bank Balance: $"+mformat(PlayerInfo[player.ID]["bank"]),player);
	}}
	else {
		if ( !IsNum( text ) ) PrivMessage( "Error - Invalid Amount.", player );
		else if ( Bank < text.tointeger() ) PrivMessage("Error - You do not have Money.",player );
		else if ( text.tointeger() > 999999999 ) { PrivMessage("Error - Invalid Amount.", player); }
		else {
			player.Cash += text.tointeger();
			PlayerInfo[player.ID]["cash"] += text.tointeger();
			PlayerInfo[player.ID]["bank"] -= text.tointeger();
			PrivMessage("Money Withdrawn.", player );
			PrivMessage("Current money: $"+mformat(PlayerInfo[player.ID]["cash"])+", Bank Balance: $"+mformat(PlayerInfo[player.ID]["bank"]),player);

			}
		}
	}
}

else if ( cmd == "gotomyhome" ) {
if (!player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
else if (!text) PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <property ID>", player );
else if ( !IsNum(text) || text.tointeger() >= Properties.len() || text.tointeger() < 0 ) PrivMessage( "Error - Property does not exist.", player );
else {
	local p = Properties[text.tointeger()];
	if ( p["owner"] == player.Name || p["shared"] == player.Name ) {
		local pos = split(p["pos"]," ");
		local x = pos[0], y = pos[1], z = pos[2];
		player.Pos = Vector(x.tofloat(), y.tofloat(), z.tofloat());
	}
	else PrivMessage( "Error - You dont owner of this Property.", player );
	}
}

else if ( cmd == "buyprop" ) {
if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
else if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <property ID>", player );
else if (PlayerInfo[player.ID]["cprops"] >= Config.Server.MaxProps) { PrivMessage("Error - You not have more space for other Property!", player); }
else if ( !IsNum(text) || text.tointeger() >= Properties.len() || text.tointeger() < 0 ) PrivMessage( "Error - Property does not exist.", player );
else {
	local p = Properties[text.tointeger()];
	local x = split(p["pos"]," ")[0].tofloat(), y = split(p["pos"]," ")[1].tofloat(), z = split(p["pos"]," ")[2].tofloat(), pp = player.Pos.x+" "+player.Pos.y+" "+player.Pos.z;
	local px = split(pp," ")[0].tofloat(), py = split(pp," ")[1].tofloat(), pz = split(pp," ")[2].tofloat();
	if (PlayerInfo[player.ID]["cash"].tointeger() < p["cost"].tointeger()) PrivMessage("Error - You Need $"+mformat(p["cost"].tointeger())+" to buy this prop.", player );
	else if ( p["owner"] != "Vice City" ) PrivMessage( "Error - This property is already owned.", player );
	else if ( format("%.f",(sqrt( (x-px)*(x-px) + (y-py)*(y-py) + (z-pz)*(z-pz) ))).tointeger() > 5) { PrivMessage("Error - Have to be at least 5m from the property you want to buy.", player); }
	else {
			if ( ManageProp(0, player, text.tointeger()) ) {
				PlayerInfo[player.ID]["cash"] -= p["cost"].tointeger();
				PlayerInfo[player.ID]["cprops"]++;
				player.Cash -= p["cost"].tointeger();
				PrivMessage( "You have just purchased a property!", player );
				PrivMessage( "Name: "+p["name"]+", ID: "+text, player );
				PrivMessage( "You can now use the following commands: !sellprop, !myprops, !shareprop, !gotomyhome", player );
				msg("> Property Purchased! - "+p["name"]+" Cost: $"+mformat(p["cost"].tointeger()),0,200,0);
				Echo("3> Property Purchased! - "+p["name"]+" Cost: $"+mformat(p["cost"].tointeger()));
			}
		}
	}
}

else if (cmd == "shareprop") {
if ( !text || split(text," ").len() < 2) { PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd +  " <property ID> <player>", player); }
else if ( !player.IsSpawned ) { PrivMessage("Error - You havent spawned", player); }
else if ( !IsNum(split(text," ")[0]) || split(text," ")[0].tointeger() >= Properties.len() || split(text," ")[0].tointeger() < 0 ) PrivMessage( "Error - Property does not exist.", player );
else {
	local prop = split(text," ")[0].tointeger(), plr = GetPlayer(split(text," ")[1]);
	if (Properties[prop]["owner"] != player.Name) { PrivMessage("Error - You dont own this property.", player); }
	else if (Properties[prop]["shared"] != "None") { PrivMessage("Error - This property is already shared with, "+Properties[prop]["shared"], player); }
	else if (!PlayerInfo[plr.ID]) { PrivMessage("Error - "+plr.Name+" is not register Nick Name.", player); }
	else if (player.Name == plr.Name) { PrivMessage("Error - Can Not share this property with you.", player); }
	else {
		if ( ManageProp(1, plr, prop) ) {
			PrivMessage( "You are now sharing your property with:[ " + plr.Name + " ]", player );
			PrivMessage( "Name: " + Properties[prop]["name"] + ", ID: " + prop, player );
			PrivMessage( player.Name + " is now sharing this property (ID " + prop + ") with you.", plr );
			}
		}
	}
}

else if (cmd == "delshareprop") {
if ( !text ) { PrivMessage("Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <property ID>", player); }
else if ( !player.IsSpawned ) { PrivMessage("Error - You havent spawned", player); }
else if ( !IsNum(split(text," ")[0]) || split(text," ")[0].tointeger() >= Properties.len() || split(text," ")[0].tointeger() < 0 ) PrivMessage( "Error - Property does not exist.", player );
else {
	local prop = split(text," ")[0].tointeger();
	if (Properties[prop]["owner"] != player.Name) { PrivMessage("Error - You dont own this property.", player); }
	else if (Properties[prop]["shared"] == "None") { PrivMessage("Error - This property is not shared.",player); }
	else {
		local shared = Properties[prop]["shared"];
		if ( ManageProp(2, player, prop) ) {
			PrivMessage( "You are no longer sharing your property with [ " + shared + " ]", player );
			PrivMessage( "Name: " + Properties[prop]["name"] + ", ID: " + prop, player );
			}
		}
	}
}

else if ( cmd == "sellprop" ) {
if ( !player.IsSpawned ) PrivMessage("Error - You havent spawned", player );
else if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <property ID>", player );
else if ( !IsNum(text) || text.tointeger() >= Properties.len() || text.tointeger() < 0 ) PrivMessage( "Error - Property does not exist.", player );
else {
	local p = Properties[text.tointeger()];
	local x = split(p["pos"]," ")[0].tofloat(), y = split(p["pos"]," ")[1].tofloat(), z = split(p["pos"]," ")[2].tofloat(), pp = player.Pos.x+" "+player.Pos.y+" "+player.Pos.z;
	local px = split(pp," ")[0].tofloat(), py = split(pp," ")[1].tofloat(), pz = split(pp," ")[2].tofloat();
	if ( p["owner"] != player.Name ) PrivMessage( "Error - You dont own this property.", player );
	else if ( format("%.f",(sqrt( (x-px)*(x-px) + (y-py)*(y-py) + (z-pz)*(z-pz) ))).tointeger() > 5) { PrivMessage("Error - Have to be at least 5m from the property you want to sell.", player); }
	else {
		if ( ManageProp(3, player, text.tointeger()) ) {
			PlayerInfo[player.ID]["cash"] += p["cost"].tointeger() - 500;
			PlayerInfo[player.ID]["cprops"]--;
			player.Cash += p["cost"].tointeger() - 500;
			PrivMessage( "Sold Property for $" + mformat(p["cost"].tointeger()-500) + ".", player );
			PrivMessage( "Name: " + p["name"] + ", ID: " + text, player );
			msg("-> " + p["name"] + " - Sold Property for $" + mformat(p["cost"].tointeger()-500) + ".", 0, 200, 0);
			Echo("3->" + p["name"] + " - Sold Property for $" + mformat(p["cost"].tointeger()-500) + ".");
			}
		}
	}
}

else if ( cmd == "myprops" ) {
if ( !player.IsSpawned ) PrivMessage( "Error - You havent spawned", player );
else {
	local i = 0, x = 0;
	PrivMessage("- Property's -", player);
	while ( i < Properties.len()) {
		if (Properties[i]["owner"] == player.Name) { PrivMessage( "Owner [" + Properties[i]["name"] + "] - ID [" + i + "]", player ); x++; }
		if (Properties[i]["shared"] == player.Name) { PrivMessage( "Shared ["+ Properties[i]["name"] + "] - ID [" + i + "]", player); x++; }
		i++;
		}
		if ( x == 0) PrivMessage( "Error - You dont own any prop.", player );
	}
}

else if ( cmd == "spree" ) {
	local b = null;
	foreach( plr in players ) {
		if (PlayerInfo[plr.ID]) {
			local spree =  PlayerInfo[plr.ID].Local.Spree;
			if ( spree >= 5 ) {
				if ( b ) b = b + " - " + plr.Name + " (" + spree + ")";
				else b = plr.Name + " (" + spree + ")";
			}
		}
	}
	if ( b ) { 
		Echo( "2-> 12Players in spree: 1" + b ); 
		print( "-> Players in spree:" + b );
		msg( "-> Players in spree:" + b, 0, 200, 0 );
	}
	else {
		ShowMsg("-> No Players In Killing Spree.", 4, 0);
	}
}

else if (cmd == "logout"){
	if (!PlayerInfo[player.ID]){PrivMessage("Error - You not logged, Loggin first to use this command!", player);}
	else {	
	
		UpdatePlayerData(player);
		PlayerInfo[player.ID] = null;
		PrivMessage("Logout Successful!, type /c login <password> for logging again.", player);
	}
}

/*=====================================================================
	                       ADMIN COMMMANDS
=====================================================================*/

else if ( cmd == "exe" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <code>", player);
	else if (text.find("~")) PrivMessage("Please do Not use Special Characters.", player);
	else {
		try {
			local script = compilestring(text);
			script();
		}
		catch(e) { PrivMessage("Error: "+e+".", player); }
	}
}

else if ( cmd == "kick" ) {
	if (!text) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player/id> <reason>", player);
	else {
		local sp = split(text," "), plr = GetPlayer( sp[0] ), reason = ( sp.len() > 1 ? text.slice(sp[0].len()+1):null);
		if ( !plr ) PrivMessage("Error - Invalid Nick/ID", player);
		else if ( plr.ID == player.ID ) PrivMessage("Error - Can not use kick in yourself.", player);
		else {
			Message("> Admin "+player.Name+" Kick "+plr.Name+" Reason: "+( reason ? reason:"None" ));
			Echo("4> Admin "+player.Name+" Kick "+plr.Name+" Reason: "+( reason ? reason:"None" ));
			if ( reason ) SetKickPlayer( plr, reason );
			else SetKickPlayer( plr );
		}
	}
}

else if ( cmd == "ban" ) {
	if (!text) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player/id> <reason>", player);
	else {
		local sp = split(text," "), plr = GetPlayer( sp[0] ), reason = ( sp.len() > 1 ? text.slice(sp[0].len()+1):null);
		if ( !plr ) PrivMessage("Error - Invalid Nick/ID", player);
		else if ( IsBanned( plr ) ) PrivMessage("Error - This Player is already banned.", player);
		else if ( plr.ID == player.ID ) PrivMessage("Error - Can not use ban in yourself.", player);
		else {
			local show = "> Admin "+player.Name+" banned "+plr.Name+" reason: "+( reason ? reason:"None" )+".";
			Message( show );
			Echo( "4" + show );
			print( show );
			if ( reason ) SetBanPlayer(plr, player, reason);
			else SetBanPlayer(plr, player );
		}
	}
}

else if ( cmd == "unban" ) {
	if (!text) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player>", player);
	else if ( !IsBanned( text ) ) PrivMessage("Error - The Player '"+text+"' is not banned.", player);
	else {
		ShowMsg( "> Admin "+player.Name+" unbanned "+text+".", 10, 0 );
		DelBanPlayer( text );
	}
}

else if ( cmd == "ann" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player/all> <text>", player);
	else {
		local sp = split( text, " " ), plr, anc, show;
		if ( sp[0] == "all" ) {
			anc = ( sp.len() > 1 ? text.slice( sp[0].len()+1 ):null );
			if ( !anc ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player/all> <text>", player);
			else {
				show = "> Admin "+player.Name+" send announce '"+anc+"' to all players on server.";
				PrivMessageAll( show );
				Echo( "10" + show );
				print( show );
				AnnounceAll( anc );
			}
		}
		else {
			plr = GetPlayer( sp[0] );
			anc = ( sp.len() > 1 ? text.slice( sp[0].len()+1 ):null );
			if ( !plr ) PrivMessage("Error - Invalid Nick/ID", player);
			else if ( !anc ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player/all> <text>", player);
			else {
				PrivMessage( "You Send Announce '"+anc+"' to " + plr.Name + ".", player );
				PrivMessage( "Admin " + player.Name + " send announce '"+anc+"' to you.", plr );
				Announce( anc, plr );
			}
		}
	}
}

else if ( cmd == "mute" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <reason>", player);
	else {
		local sp = split(text, " "), plr = GetPlayer( sp[0] ), reason = ( sp.len() > 1 ? text.slice( sp[0].len()+1 ):"None" );
		if ( !plr ) PrivMessage("Error - Invalid Nick/ID", player);
		else {
			if ( !plr.IsMuted ) {
				PrivMessage("You has muted by admin " + player.Name + " Reason: " + reason, plr);
				PrivMessage("Type !mute again to un-mute him.", player)
				local show = "> Admin " + player.Name + " muted "+ plr.Name + " Reason : " + reason + ".";
				msg( show, 200, 0, 0 );
				Echo( "4" + show );
				plr.IsMuted = true;
			}
			else {
				local show = "> Admin " + player.Name + " un-muted " + plr.Name + ".";
				PrivMessage("You are now un-mute.", plr);
				msg( show, 0, 200, 0 );
				Echo( "10" + show );
				plr.IsMuted = false;
				Spam[plr.ID].Wait = 0;
			}
		}
	}
}

else if ( cmd == "freeze" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <reason>", player);
	else {
		local sp = split(text, " "), plr = GetPlayer( sp[0] ), reason = ( sp.len() > 1 ? text.slice( sp[0].len()+1 ):"None" );
		if ( !plr ) PrivMessage("Error - Invalid Nick/ID", player);
		else if ( !plr.IsSpawned ) PrivMessage("Error - The player is not spawned.", player);
		else {
			if ( !plr.IsFrozen ) {
				PrivMessage("You has freeze by admin " + player.Name + " Reason: " + reason, plr);
				PrivMessage("Type !freeze again to un-freeze him.", player);
				local show = "> Admin " + player.Name + " freeze "+ plr.Name + " Reason : " + reason + ".";
				msg( show, 200, 0, 0 );
				Echo( "4" + show );
				plr.IsFrozen = true;
			}
			else {
				local show = "> Admin " + player.Name + " un-freeze " + plr.Name + ".";
				PrivMessage("You are now un-freeze.", plr);
				msg( show, 0, 200, 0 );
				Echo( "10" + show );
				plr.IsFrozen = false;
				Spam[plr.ID].Wait = 0;
			}
		}
	}
}

else if ( cmd == "drown" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <reason>", player);
	else if ( !player.IsSpawned ) PrivMessage( "Error - You havent spawned", player );
	else {
		local sp = split(text, " "), plr = GetPlayer( sp[0] ), reason = ( sp.len() > 1 ? text.slice( sp[0].len()+1 ):"None" );
		if ( !plr ) PrivMessage("Error - Invalid Nick/ID", player);
		else if ( !plr.IsSpawned ) PrivMessage("Error - The player is not spawned.", player);
		else {
			PrivMessage( "You Have been Drowned.", plr );
			Announce( "~b~drowning", plr );
			plr.Health = 2;
			plr.Pos = Vector( 216.9180,-1897.6561,7.0830 );
			local show = "> Admin " + player.Name + " Drowning " + plr.Name + " Reason: " + reason;
			Echo( "4" + show );
			msg( show, 200, 0, 0 );
			print( show );
		}
	}
}

else if ( cmd == "sethp" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <health>", player);
	else if ( !player.IsSpawned ) PrivMessage( "Error - You havent spawned", player );
	else {
		local sp = split(text, " "), plr, heal;
		if ( sp.len() < 2 ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <reason>", player);
		else {
			plr = GetPlayer( sp[0] );
			heal = sp[1];
			if ( !plr ) PrivMessage( "Error - Invalid Nick/ID", player );
			else if ( !plr.IsSpawned ) PrivMessage("Error - The player is not spawned.", player);
			else if ( !IsNum( heal ) ) PrivMessage( "Error - Invalid Health.", player);
			else if ( heal.tointeger() > 100 ) PrivMessage("Error - Invalid Health", player);
			else {
				plr.Health = heal.tointeger();
				PrivMessage("> Admin " + player.Name + " chage your health to " + heal, plr );
				PrivMessage("> Change health of " + plr.Name + " to " + heal, player );
			}
		}
	}
}

else if ( cmd == "setarm" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <arm>", player);
	else if ( !player.IsSpawned ) PrivMessage( "Error - You havent spawned", player );
	else {
		local sp = split(text, " "), plr, arm;
		if ( sp.len() < 2 ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <reason>", player);
		else {
			plr = GetPlayer( sp[0] );
			arm = sp[1];
			if ( !plr ) PrivMessage( "Error - Invalid Nick/ID", player );
			else if ( !plr.IsSpawned ) PrivMessage("Error - The player is not spawned.", player);
			else if ( !IsNum( arm ) ) PrivMessage( "Error - Invalid Armour.", player);
			else if ( arm.tointeger() > 100 ) PrivMessage("Error - Invalid Armour", player);
			else {
				plr.Armour = arm.tointeger();
				PrivMessage("> Admin " + player.Name + " chage your armour to " + arm, plr );
				PrivMessage("> Change armour of " + plr.Name + " to " + arm, player );
			}
		}
	}
}

else if ( cmd == "healall" ) {
	local show;
	foreach( plr in players ) {
		if ( plr.IsSpawned ) plr.Health = 100;
	}
	show = "> Admin " + player.Name + " set health 100% to all players on server!";
	Echo( "10" + show );
	msg( show, 0, 200, 0);
	print ( show );
}

else if ( cmd == "armall" ) {
	local show;
	foreach( plr in players ) {
		if ( plr.IsSpawned ) plr.Armour = 100;
	}
	show = "> Admin " + player.Name + " set armour 100% to all players on server!";
	Echo( "10" + show );
	msg( show, 0, 200, 0);
	print ( show );
}

else if ( cmd == "shootinairall" ) {
	local show;
	foreach( plr in players ) {
		if ( plr.IsSpawned ) plr.ShootInAir = true;
	}
	show = "> Admin " + player.Name + " set Shoot in Air Mod to all players on server!";
	Echo( "10" + show );
	msg( show, 0, 200, 0);
	print ( show );
}

else if ( cmd == "bstuntall" ) {
	local show;
	foreach( plr in players ) {
		if ( plr.IsSpawned ) plr.StuntMode = true;
	}
	show = "> Admin " + player.Name + " set Bike Stunt Mode to all players on server!";
	Echo( "10" + show );
	msg( show, 0, 200, 0);
	print ( show );
}

else if ( cmd == "agoto" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player/id>", player);
	else if ( !player.IsSpawned ) PrivMessage( "Error - You havent spawned", player );
	else {
		local plr = GetPlayer( text );
		if ( !plr ) PrivMessage( "Error - Invalid Nick/ID", player );
		else if ( !plr.IsSpawned ) PrivMessage("Error - This Players is not Spawned.", player);
		else if ( plr.ID == player.ID ) PrivMessage("Error - Can not use agoto in yourself.", player);
		else {
			player.Pos = plr.Pos;
			PrivMessage("Teleported to " + plr.Name + ".", player);
		}
	}
}

else if ( cmd == "get" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player/all> <text>", player);
	else {
		local sp = split( text, " " ), plr, show;
		if ( sp[0] == "all" ) {
			foreach( plr in players ) {
				if ( plr.IsSpawned ) plr.Pos = player.Pos;
			}
			show = "> Admin "+player.Name+" sent to all players toward him.";
			Echo( "10" + show );
			print( show );
			msg( show, 153,50,204 );
		}
		else {
			plr = GetPlayer( sp[0] );
			if ( !plr ) PrivMessage("Error - Invalid Nick/ID", player);
			else if ( !plr.IsSpawned ) PrivMessage("Error - This Players is not Spawned.", player);
			else if ( plr.ID == player.ID ) PrivMessage("Error - Can not use ban in yourself.", player);
			else {
				PrivMessage( "You get " + plr.Name + " to you.", player );
				PrivMessage( "Admin " + player.Name + " get you.", plr );
				plr.Pos = player.Pos;
			}
		}
	}
}

else if ( cmd == "setcash" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <amount>", player);
	else {
		local sp = split( text, " " ), plr = GetPlayer( sp[0] ), am = ( sp.len() > 1 ? text.slice( sp[0].len()+1 ):null );
		if ( !plr ) PrivMessage( "Error - Invalid Nick/ID", player );
		else if ( !am ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <amount>", player);
		else if ( !IsNum( am ) ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <amount>", player);
		else if ( !PlayerInfo[plr.ID] ) PrivMessage( "Error - " + plr.Name + " is not register nick name.", player );
		else if ( am.tointeger() > 999999 || am.tointeger() < 0 ) PrivMessage("Error - Invalid Amount", player );
		else {
			PrivMessage( "> Admin " + player.Name + " set your cash to $" + mformat( am.tointeger() ), plr );
			PrivMessage( "Set cash of " + plr.Name + " to $" + mformat( am.tointeger() ), player );
			PlayerInfo[plr.ID]["cash"] = am.tointeger();
			plr.Cash = am.tointeger();
		}
	}
}

else if ( cmd == "setlevel" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player> <level>", player);
	else {
		local sp = split( text, " " ), plr = GetPlayer( sp[0] ), lv = ( sp.len() > 1 ? text.slice( sp[0].len()+1 ):null ), show;
		if ( !plr ) PrivMessage( "Error - Invalid Nick/ID", player );	
		else if ( plr.ID == player.ID ) PrivMessage("Error - Can not use this command in yourself.", player);
		else if ( !lv ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <player/all> <text>", player);
		else if ( !IsNum( lv ) ) PrivMessage( "Error - Invalid Level", player );
		else if ( lv.tointeger() > 5 || lv.tointeger() < 1 ) PrivMessage( "Error - Invalid Level", player );
		else if ( !PlayerInfo[plr.ID] ) PrivMessage( "Error - " + plr.Name + " is not register nick name.", player );
		else if ( PlayerInfo[plr.ID]["level"] == lv.tointeger() ) PrivMessage("Error - the level of " + plr.Name + " is already " + lv, player);
		else {
			PlayerInfo[plr.ID]["level"] = lv.tointeger();
			show = "> Admin " + player.Name + " change level of " + plr.Name + " to " + PlayerInfo[plr.ID]["level"] + " (" + LevelTag( PlayerInfo[plr.ID]["level"] ) + ")";
			Echo( "10" + show );
			print( show );
			msg( show, 153,50,204 );
		}
	}
}

else if ( cmd == "setspeed" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <fast/slow/medium/normal>", player);
	else {
		local speed = split(text, " ")[0].tolower(), sp;
		switch( speed ) {
			case "fast":
			case "f":
				sp = 5.00;
			break;
			case "slow":
			case "s":
				sp = 0.50;
			break;
			case "medium":
			case "m":
				sp = 0.80;
			break;
			case "normal":
			case "n":
				sp = 1.00;
			break;
			default:
				sp = false;
			break;
		}
		if ( sp ) {
			ShowMsg("> Admin " + player.Name + " set game speed to " + speed + ".", 6, 0);
			SetGamespeed( sp );
		}
		else PrivMessage("Error - Invalid Speed, type fast/slow/medium/normal.", player);
	}
}

else if ( cmd == "setgrav" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <none/medium/normal>", player);
	else {
		local gra = split(text, " ")[0].tolower(), gv;
		switch( gra ) {
			case "none":
				gv = 0.001;
			break;
			case "normal":
				gv = 0.008;
			break;
			case "medium":
				gv = 0.003;
			break;
			default:
				gv = false;
			break;
		}
		if ( gv ) {
			ShowMsg("> Admin " + player.Name + " set game gravaty to " + gra + ".", 6, 0);
			SetGravity( gv );
		}
		else PrivMessage("Error - Invalid Speed, type none/medium/normal.", player);
	}
}

else if (cmd == "setwlevel" ) {
	if ( !text ) PrivMessage( "Error - Required Syntax: "+ (prefix ? prefix:"/c ") + cmd + " <wather level>", player);
	else if ( !IsNum( text ) ) PrivMessage("Error - Invalid Water level, type numbers to Water level.", player);
	else if ( text.tointeger() > 500 ) PrivMessage("Error - Invalid Water leve.", player);
	else {
		local wlevel = split( text, " " )[0].tointeger(), wgrop;
		if ( wlevel >= 50 ) wgrop = "Height Level";
		else if ( wlevel <= 50 ) wgrop = "Low Level";
		ShowMsg("> Admin "+ player.Name + " set water level to " + wlevel + " (" + wgrop + ")", 6, 0 );
		SetWaterLevel( wlevel.tofloat() );
	}
}

else if ( cmd == "flycars" ) {
	SetFlyingCars( GetFlyingCars() ? false:true );
	ShowMsg( "> Admin " + player.Name + " turn " + ( GetFlyingCars() ? "on":"off" ) + " Flying cars.", 6, 0 );
}

else if ( cmd == "waterdrive" ) {
	SetDriveOnWater( GetDriveOnWater() ? false:true );
	ShowMsg( "> Admin " + player.Name + " turn " + ( GetDriveOnWater() ? "on":"off" ) + " Driving on water", 6, 0 );
}

else if ( cmd == "driveby" ) {
	SetDrivebyEnabled( GetDrivebyEnabled() ? false:true );
	ShowMsg( "> Admin " + player.Name + " turn " + ( GetDrivebyEnabled() ? "on":"off" ) + " Drive By.", 6, 0 );
}

	else if (cmd == "register" || cmd == "commands" || cmd == "cmds") { return; }
	else PrivMessage("Invalid Command.", player); 
	}
}