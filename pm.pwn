// this is a script you can add it to your own samp server by just a copy paste
// Feel free to use it!
// Credits: Ragnarok

#define COLOR_YELLOW (0xdfe52eFF) // yellow PM color to
#define COLOR_YELLOWD (0xc0c52cFF) // yellow PM color from
#define COLOR_RED (0xdb1a1aFF) // red color
#define COLOR_CYAN (0x1fe0ddFF) // cyan color

new pms[MAX_PLAYERS], pPM[MAX_PLAYERS]; // variable

CMD:pms(playerid,params[]) // cmd (/pms) is used to turn off your personal messages.
{
    if(pms[playerid] == 1)
    {
        pms[playerid] = 0;
        SendClientMessage(playerid, COLOR_CYAN, "Your PMS is set to ON");
    }
    else if(pms[playerid] == 0)
    {
        pms[playerid] = 1;
        SendClientMessage(playerid, COLOR_CYAN, "Your PMS is set OFF");
    }
    return 1;
}

CMD:pm(playerid, params[]) // cmd (/pm) to send a personal message to someone.
{
    new id, str[500], ip[16];
    
    if(sscanf(params, "us[500]", id, params))
 	{
		return SendClientMessage(playerid, COLOR_RED, "Usage: /pm [id] [text]");
	}
	
	if(id == INVALID_PLAYER_ID)
	{
		return SendClientMessage(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(pms[id] == 1)
	{
		return SendClientMessage(playerid, COLOR_RED, "Player has Disabled their pms");
	}
	
	if(pms[playerid] == 1)
	{
 		SendClientMessage(playerid,COLOR_RED, "You have disabled your pms");
		return SendClientMessage(playerid, COLOR_RED, "Type /pms to enable your pms");
	}
	
	GetPlayerIp(playerid, ip, sizeof(ip));
    format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
    SendClientMessage(playerid, COLOR_YELLOW, str);
    pPM[playerid] = id;
    pPM[id] = playerid;
    format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
    SendClientMessage(id, COLOR_YELLOWD, str);
    return 1;
}

CMD:r(playerid, params[]) // cmd (/r) used to respond personal messages
{
    new str[128], ip[16],id = pPM[playerid];
    
    if(id == -1)
	{
		return SendClientMessage(playerid, COLOR_RED, "Player is not connected");
	}
	
	if(!IsPlayerConnected(id))
	{
		return SendClientMessage(playerid, COLOR_RED, "Player is not connected");
	}

	GetPlayerIp(playerid, ip, sizeof(ip));
	
    if(IsPlayerConnected(id))
    {
        if(isnull(params))
		{
			return SendClientMessage(playerid, COLOR_RED, "Usage: /r (text)");
		}
	    format(str, sizeof(str), "PM to %s(%d): %s", GetName(id), id, params);
        SendClientMessage(playerid, COLOR_YELLOW, str);
        format(str, sizeof(str), "PM from %s(%d): %s", GetName(playerid), playerid, params);
        SendClientMessage(id, COLOR_YELLOWD, str);
    }
    else return SendClientMessage(playerid, COLOR_RED, "Player is not connected");
    return 1;
}