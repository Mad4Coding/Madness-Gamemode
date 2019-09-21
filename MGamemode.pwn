// -------------------------------------------------- //
//                                                    //
//           SA:MP: Madness Gamemode v0.1:            //
//                Scripted by Mad                     //
//                                                    //
// -------------------------------------------------- //
//    A better version of Mad Freeroam Gamemode.      //
// -------------------------------------------------- //
//                                                    //
// Current shops: Ammu-nation, DrugFellas.            //
//                                                    //
// -------------------------------------------------- //
// Thanks to Dripac for the Random Messages Textdraw. //        
// -------------------------------------------------- //

// ------------------------------------------------------------------------- //

#include <a_samp> // Thanks to SA:MP Team.
#include <YSI\y_ini> // Thanks to Y_Less.
#include <sscanf2> // Thanks to Y_Less & Emmet_.
#include <zcmd> // Thanks to Zeex & Yashas.
#include <mSelection> // Thanks to d0.

// ------------------------------------------------------------------------- //

#define DRegister 1
#define DLogin 2
#define DRSuccess 3
#define DLSuccess 4
#define DHelp 5
#define DRules 6
#define DCmds 7
#define DUpdates 8
#define DCredits 9
#define DWeb 10
#define DAhelp 11
#define DVhelp 12
#define DVC 13
#define Wshop 14
#define Dshop 15

// ------------------------------------------------------------------------- //

#define Save "/Data/%s.ini"

// ------------------------------------------------------------------------- //

#define DWhite "{FFFFFF}"
#define DRed "{F81414}" 
#define TGrey  0xAFAFAFAA
#define TGreen  0x33AA33AA
#define TYellow 0xFFFF00AA
#define TBlue 0x0000BBAA
#define TLBlue 0x33CCFFAA
#define TOrange 0xFF9900AA
#define TRed 0xAA3333AA
#define TLime 0x10F441AA
#define TMagenta 0xFF00FFFF
#define TNavy 0x000080AA
#define TAqua 0xF0F8FFAA

// ------------------------------------------------------------------------- //
forward Banp(playerid);
forward Kickp(playerid);
forward RandomMessage();
// ------------------------------------------------------------------------- //
 

enum pInfo
{
    pPass,
    pCash,
    pAdmin,
    pKills,
    pDeaths,
	pScore,
	pSkin,
	pVip,
	pBanned,
	pMuted,
	pWeed,
	pCoke,
	pMeth
	
}
new PlayerInfo[MAX_PLAYERS][pInfo]; // Saving system.
new PM[MAX_PLAYERS]; // PM on / off.
new Spawned[MAX_PLAYERS]; // Check if player is spawned.
new Goto[MAX_PLAYERS]; // Disables V.I.Ps teleporting to you.
new Get[MAX_PLAYERS]; // Disables V.I.Ps from teleporting you to their location.
new Jailed[MAX_PLAYERS]; // Used when a player gets jailed.
new skins; // Skin selection for V.I.Ps.
new cskins; // Skin selection for Clothes shop.
new Text:rmsg; // Random messages.
new Weaponshop; // Ammu-nation.
new DrugFellas; // Drug Fellas.
new DrugDepot; // Drug Depot.
new DrugDen; // Drug Den.
new ClothesShop2; // Another Clothes shop.
new ClothesShop3; // Another Clothes shop.
new ClothesShop; // Clothes Shop.
new Weaponshop2; // Another Ammu-nation.
new RandomMessages[][] =
{
    "~y~Madness server: ~w~Make sure to read /rules to avoid ~r~Punishments~w~.",
    "~y~Madness server: ~w~Invite your ~g~friends~w~ to play here!",
    "~y~Madness server: ~w~Having a hard time? read /help & /commands.",
    "~y~Madness server: ~w~Found a ~r~Cheater~w~? Contact a Staff member."

};


forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password",PlayerInfo[playerid][pPass]);
    INI_Int("Cash",PlayerInfo[playerid][pCash]);
    INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Int("Kills",PlayerInfo[playerid][pKills]);
    INI_Int("Deaths",PlayerInfo[playerid][pDeaths]);
    INI_Int("Score",PlayerInfo[playerid][pScore]);
    INI_Int("Skin",PlayerInfo[playerid][pSkin]);
    INI_Int("Vip", PlayerInfo[playerid][pVip]);
    INI_Int("Banned", PlayerInfo[playerid][pBanned]);
    INI_Int("Muted", PlayerInfo[playerid][pMuted]);
    INI_Int("Weed", PlayerInfo[playerid][pWeed]);
    INI_Int("Cocaine", PlayerInfo[playerid][pCoke]);
    INI_Int("Meth", PlayerInfo[playerid][pMeth]);


    return 1;
}

main()
{
	print("[MAD]: Loading...");
	print("[MAD]: Loading...");
	print("[MAD]: Loading...");
	print("[MAD]: Successfully loaded Madness Gamemode!");
}

public OnGameModeInit()
{
	SetGameModeText("| Madness Gamemode |");
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	SetTimer("RandomMessage",10000,1); 
	AddPlayerClass(0, 2507.9558,-1670.9633,13.3790, 0, 0, 0, 0, 0, 0, 0);
    Weaponshop = CreatePickup(1242, 1, 1365.4104,-1280.0146,13.5469, 0); // Ammu-nation pickup.
    Weaponshop2 = CreatePickup(1242, 1, 2400.5239,-1981.5889,13.5469, 0); // Ammu-nation pickup.
    DrugFellas = CreatePickup(1279, 1,2351.2463,-1169.8097,28.0331, 0); // DrugFellas pickup.
    DrugDen = CreatePickup(1279, 1,2166.2820,-1671.3414,15.0736, 0); // Drug Den pickup.
    DrugDepot = CreatePickup(1279, 1,1919.9303,-1863.7692,13.5608, 0); // Drug Depot pickup.
    ClothesShop = CreatePickup(1275, 1, 2245.0327,-1663.6989,15.4766, 0); // Clothes Shop.
    ClothesShop2 = CreatePickup(1275, 1, 1498.5842,-1582.4598,13.5469, 0); // Clothes Shop.
    ClothesShop3 = CreatePickup(1275, 1, 2045.2283,-1913.0979,13.5469, 0); // Clothes Shop.
    skins = LoadModelSelectionMenu("skins.txt");
    cskins = LoadModelSelectionMenu("skins.txt");
    rmsg = TextDrawCreate(7.000000, 427.000000, "You don't need to add any text here");
    TextDrawBackgroundColor(rmsg, 255);
    TextDrawFont(rmsg, 1);
    TextDrawLetterSize(rmsg, 0.379999, 1.499999);
    TextDrawColor(rmsg, -1);
    TextDrawSetOutline(rmsg, 1);
    TextDrawSetProportional(rmsg, 1);
    AddStaticVehicle(534,2453.3999000,-1662.4000000,13.1000000,90.0000000,156,161);
	AddStaticVehicle(534,2443.3999000,-1662.4000000,13.1000000,90.0000000,156,161);
	AddStaticVehicle(534,2427.8999000,-1662.3000000,13.2000000,90.0000000,156,161);
	AddStaticVehicle(534,2435.6001000,-1662.4000000,13.2000000,90.0000000,156,161);
	AddStaticVehicle(576,2406.2000000,-1655.5000000,13.1000000,90.0000000,153,78);
	AddStaticVehicle(576,2398.7000000,-1655.3000000,13.1000000,90.0000000,153,78);
	AddStaticVehicle(576,2391.5000000,-1655.3000000,13.1000000,90.0000000,153,78);
	AddStaticVehicle(576,2412.8000000,-1655.6000000,13.1000000,90.0000000,153,78);
	AddStaticVehicle(426,2291.8999000,-1680.1000000,13.9000000,0.0000000,124,28);
	AddStaticVehicle(412,2303.3999000,-1637.7000000,14.5000000,0.0000000,66,31);
	AddStaticVehicle(401,2186.6001000,-1668.4000000,14.4000000,0.0000000,57,90);
	AddStaticVehicle(533,2181.6001000,-1700.9000000,13.3000000,0.0000000,30,46);
	AddStaticVehicle(534,2121.3000000,-1780.3000000,13.2000000,0.0000000,101,106);
	AddStaticVehicle(547,2116.7000000,-1780.3000000,13.2000000,0.0000000,70,89);
	AddStaticVehicle(448,2110.5000000,-1783.7000000,13.1000000,0.0000000,132,4);
	AddStaticVehicle(448,2109.1001000,-1783.5000000,13.1000000,0.0000000,132,4);
	AddStaticVehicle(448,2107.8000000,-1783.5000000,13.1000000,0.0000000,132,4);
	AddStaticVehicle(448,2106.4004000,-1783.4004000,13.1000000,0.0000000,132,4);
	AddStaticVehicle(448,2105.2002000,-1783.5000000,13.1000000,0.0000000,132,4);
	AddStaticVehicle(448,2103.7000000,-1783.5000000,13.1000000,0.0000000,132,4);
	AddStaticVehicle(448,2102.2000000,-1783.6000000,13.1000000,0.0000000,132,4);
	AddStaticVehicle(448,2100.6001000,-1783.5000000,13.1000000,0.0000000,132,4);
	AddStaticVehicle(463,2069.3000000,-1919.7000000,13.2000000,0.0000000,101,106);
	AddStaticVehicle(486,2056.0000000,-1940.8000000,13.7000000,90.0000000,245,245);
	AddStaticVehicle(451,2065.5000000,-1919.7000000,13.3000000,0.0000000,27,55);
	AddStaticVehicle(603,2055.8000000,-1904.7000000,13.5000000,0.0000000,109,24);
	AddStaticVehicle(549,2131.5000000,-1908.7000000,13.2000000,0.0000000,88,88);
	AddStaticVehicle(549,2131.3999000,-1917.8000000,13.2000000,0.0000000,88,88);
	AddStaticVehicle(529,2077.0000000,-1698.5000000,13.1000000,0.0000000,101,106);
	AddStaticVehicle(466,2077.6001000,-1736.1000000,13.3000000,0.0000000,51,95);
	AddStaticVehicle(574,2186.9004000,-1991.4004000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(574,2189.2998000,-1991.2002000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(574,2184.7002000,-1986.2998000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(574,2186.7000000,-1986.4000000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(574,2189.2000000,-1986.5000000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(574,2189.0000000,-1982.5000000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(574,2186.6001000,-1982.1000000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(574,2184.2002000,-1982.0000000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(574,2184.3999000,-1991.5000000,13.3000000,0.0000000,165,169);
	AddStaticVehicle(487,1961.1000000,-2341.1001000,13.8000000,0.0000000,151,149);
	AddStaticVehicle(487,1939.2000000,-2341.2000000,13.8000000,0.0000000,151,149);
	AddStaticVehicle(487,1950.5000000,-2371.2000000,13.8000000,0.0000000,151,149);
	AddStaticVehicle(488,1856.7000000,-2404.3999000,13.8000000,0.0000000,42,119);
	AddStaticVehicle(553,1977.5000000,-2631.2000000,15.8000000,0.0000000,77,132);
	AddStaticVehicle(553,1945.3000000,-2629.7000000,15.8000000,0.0000000,77,132);
	AddStaticVehicle(577,1894.3000000,-2492.1001000,12.5000000,90.0000000,34,25);
	AddStaticVehicle(420,1784.4000000,-1932.4000000,13.2000000,0.0000000,215,142);
	AddStaticVehicle(420,1789.2000000,-1932.0000000,13.2000000,0.0000000,215,142);
	AddStaticVehicle(420,1793.7000000,-1931.9000000,13.2000000,0.0000000,215,142);
	AddStaticVehicle(420,1798.3000000,-1932.0000000,13.2000000,0.0000000,215,142);
	AddStaticVehicle(420,1803.3000000,-1931.9000000,13.2000000,0.0000000,215,142);
	AddStaticVehicle(580,1778.5000000,-1891.4000000,13.3000000,0.0000000,95,10);
	AddStaticVehicle(458,1834.7000000,-1870.8000000,13.4000000,0.0000000,37,37);
	AddStaticVehicle(434,1844.2000000,-1871.3000000,13.5000000,0.0000000,215,142);
	AddStaticVehicle(416,2000.5000000,-1413.9000000,17.3000000,180.0000000,245,245);
	AddStaticVehicle(416,2004.2000000,-1455.9000000,13.9000000,90.0000000,245,245);
	AddStaticVehicle(416,2032.6000000,-1437.1000000,17.5000000,0.0000000,245,245);
	AddStaticVehicle(481,1887.2000000,-1399.0000000,13.2000000,0.0000000,214,218);
	AddStaticVehicle(481,1889.9004000,-1395.5000000,13.2000000,0.0000000,214,218);
	AddStaticVehicle(481,1891.9000000,-1392.0000000,13.2000000,0.0000000,214,218);
	AddStaticVehicle(481,1892.9004000,-1388.5000000,13.2000000,0.0000000,214,218);
	AddStaticVehicle(481,1895.2002000,-1383.7002000,13.2000000,0.0000000,214,218);
	AddStaticVehicle(481,1896.7000000,-1380.2000000,13.2000000,0.0000000,214,218);
	AddStaticVehicle(407,1748.9000000,-1455.4000000,13.9000000,270.0000000,132,4);
	AddStaticVehicle(596,1559.2998000,-1611.0996000,13.2000000,0.0000000,-1,-1);
	AddStaticVehicle(596,1562.7002000,-1611.0000000,13.2000000,0.0000000,-1,-1);
	AddStaticVehicle(596,1566.2000000,-1611.7000000,13.2000000,0.0000000,-1,-1);
	AddStaticVehicle(596,1569.9004000,-1611.9004000,13.2000000,0.0000000,-1,-1);
	AddStaticVehicle(596,1555.6000000,-1611.1000000,13.2000000,0.0000000,-1,-1);
	AddStaticVehicle(596,1552.1000000,-1611.1000000,13.2000000,0.0000000,-1,-1);
	AddStaticVehicle(601,1535.5000000,-1667.0000000,13.3000000,0.0000000,245,245);
	AddStaticVehicle(601,1535.0996000,-1675.2002000,13.3000000,0.0000000,245,245);
	AddStaticVehicle(416,1180.4000000,-1339.2000000,14.1000000,90.0000000,245,245);
	AddStaticVehicle(416,1178.3000000,-1309.7000000,14.1000000,90.0000000,245,245);
	AddStaticVehicle(402,1210.8000000,-1378.9000000,13.2000000,0.0000000,66,31);
	AddStaticVehicle(560,1693.7000000,-1612.1000000,13.2000000,0.0000000,115,46);
	AddStaticVehicle(439,1685.7000000,-1677.7000000,13.4000000,0.0000000,189,190);
	AddStaticVehicle(409,1790.0000000,-1811.0000000,13.5000000,90.0000000,245,245);
	CreateObject(1344,2482.1001000,-1650.2000000,13.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1299,2497.3000000,-1673.6000000,12.8000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1221,2498.8999000,-1676.5000000,12.8000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1220,2497.2000000,-1675.7000000,12.7000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1221,2496.2000000,-1677.6000000,12.8000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1221,2498.8000000,-1676.5000000,13.7000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1220,2496.1001000,-1677.6000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1221,2499.0000000,-1675.4000000,12.8000000,0.0000000,0.0000000,0.0000000);
	CreateObject(3594,2503.2000000,-1668.6000000,13.0000000,0.0000000,0.0000000,0.0000000);
	CreateObject(3593,2496.8999000,-1667.3000000,13.1000000,0.0000000,0.0000000,60.0000000);
	CreateObject(3221,2495.1001000,-1670.1000000,12.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(3350,2486.1001000,-1656.6000000,12.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(3533,2465.1001000,-1665.9000000,16.7000000,0.0000000,0.0000000,0.0000000);
	CreateObject(3533,2466.5000000,-1651.5000000,16.7000000,0.0000000,0.0000000,0.0000000);
	CreateObject(14537,2482.5000000,-1667.3000000,14.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1825,2474.7000000,-1659.9000000,12.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1825,2473.0000000,-1663.4000000,12.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1825,2473.1001000,-1667.0000000,12.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1825,2474.5000000,-1670.3000000,12.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1825,2476.3000000,-1674.3000000,12.3000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1364,2480.6001000,-1655.8000000,13.1000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1364,2474.6001000,-1655.6000000,13.1000000,0.0000000,0.0000000,0.0000000);
	CreateObject(851,2499.1001000,-1680.9000000,12.7000000,0.0000000,0.0000000,0.0000000);
	CreateObject(3035,2465.0000000,-1662.2000000,13.1000000,0.0000000,0.0000000,90.0000000);
	CreateObject(3035,2464.8000000,-1659.2000000,13.1000000,0.0000000,0.0000000,90.0000000);
	CreateObject(3035,2465.1001000,-1655.8000000,13.1000000,0.0000000,0.0000000,90.0000000);
	CreateObject(1347,2495.2000000,-1675.1000000,12.9000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1550,2487.0000000,-1666.6000000,13.9000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1550,2486.8999000,-1667.8000000,13.9000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1550,2487.8999000,-1667.8000000,13.9000000,0.0000000,0.0000000,0.0000000);
	CreateObject(2035,2487.0000000,-1664.0000000,13.5000000,0.0000000,0.0000000,0.0000000);
	CreateObject(2044,2487.0000000,-1663.5000000,13.5000000,0.0000000,0.0000000,0.0000000);
	CreateObject(2710,2484.8593800,-1664.8418000,12.5147500,0.0000000,0.0000000,0.0000000);
	CreateObject(2710,2484.8999000,-1671.8000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(2710,2485.3000000,-1671.8000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(2710,2485.7000000,-1671.8000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1486,2484.5000000,-1671.8000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1520,2486.0000000,-1671.9000000,13.5000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1517,2486.3000000,-1672.0000000,13.7000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1543,2486.5000000,-1672.0000000,13.5000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1544,2486.6001000,-1671.8000000,13.5000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1544,2486.7000000,-1672.0000000,13.5000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1546,2486.8999000,-1669.7000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1668,2487.0000000,-1671.1000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1667,2487.1001000,-1670.7000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1669,2486.7000000,-1669.9000000,13.6000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1748,2483.5000000,-1671.7000000,13.5000000,0.0000000,0.0000000,0.0000000);
	CreateObject(1720,2483.3000000,-1674.0000000,12.3000000,0.0000000,0.0000000,160.0000000);
	CreateObject(3819,2484.8999000,-1679.4000000,13.3000000,0.0000000,0.0000000,270.0000000);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	Spawned[playerid] = 0;
	SetPlayerPos(playerid, 2507.9558,-1670.9633,13.3790);
	SetPlayerCameraPos(playerid, 2507.9558,-1670.9633,13.3790);
	SetPlayerCameraLookAt(playerid, 2502.1716,-1670.2261,13.3584);
	return 1;
}

public OnPlayerConnect(playerid)
{
    SetPlayerMapIcon(playerid, 0, 1365.4104,-1280.0146,13.5469, 6, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 1, 2351.2463,-1169.8097,28.0331, 24, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 2, 2245.0327,-1663.6989,15.4766, 45, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 3, 2400.5239,-1981.5889,13.5469, 6, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 4, 2166.2820,-1671.3414,15.0736, 24, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 5, 1919.9303,-1863.7692,13.5608, 24, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 6,1498.5842,-1582.4598,13.5469, 45, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 6,2045.2283,-1913.0979,13.5469, 45, MAPICON_LOCAL);
    CreatePlayer3DTextLabel(playerid, " Ammu-nation ", TLime, 1365.4104,-1280.0146,13.5469, 50);
    CreatePlayer3DTextLabel(playerid, " Drug Fellas ", TLime, 2351.2463,-1169.8097,28.0331, 50);
    CreatePlayer3DTextLabel(playerid, " Clothes Shop ", TLime, 2245.0327,-1663.6989,15.4766, 50);
    CreatePlayer3DTextLabel(playerid, " Ammu-nation ", TLime, 2400.5239,-1981.5889,13.5469, 50);
    CreatePlayer3DTextLabel(playerid, " Drug Depot ", TLime, 1919.9303,-1863.7692,13.5608, 50);
    CreatePlayer3DTextLabel(playerid, " Clothes Shop ", TLime, 1498.5842,-1582.4598,13.5469, 50);
    CreatePlayer3DTextLabel(playerid, " Drug Den ", TLime, 2166.2820,-1671.3414,15.0736, 50);
    CreatePlayer3DTextLabel(playerid, " Clothes Shop ", TLime, 2045.2283,-1913.0979,13.5469, 50);
    if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        ShowPlayerDialog(playerid, DLogin, DIALOG_STYLE_PASSWORD,""DWhite"Login",""DWhite"Type your password below to login.","Login","Quit");
    }
    else
    {
        ShowPlayerDialog(playerid, DRegister, DIALOG_STYLE_PASSWORD,""DWhite"Registering...",""DWhite"Type your password below to register a new account.","Register","Quit");
    }
    new pname[MAX_PLAYER_NAME], string[128];
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "[SERVER]: %s has joined the server.", pname);
	SendClientMessageToAll(TLime, string);
	SetPlayerColor(playerid, -1);
	INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
	SendClientMessage(playerid, TOrange, "[SERVER]: Welcome to Madness Gamemode, enjoy your stay with us.");
	if(PlayerInfo[playerid][pBanned] == 1)
	{
		SendClientMessage(playerid, TRed, "[SERVER]: You have been banned for ' Ban Evade '.");
		Banp(playerid);
	}
    new Text3D:slabel = Create3DTextLabel("Staff member", 0x008080FF, 30.0, 40.0, 50.0, 40.0, 0);
    if(PlayerInfo[playerid][pAdmin] > 0) return Attach3DTextLabelToPlayer(slabel, playerid, 0.0, 0.0, 0.7);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new INI:File = INI_Open(UserPath(playerid)), pname[MAX_PLAYER_NAME], string[128];
    INI_SetTag(File,"data");
    INI_WriteInt(File,"Cash",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Kills",PlayerInfo[playerid][pKills]);
    INI_WriteInt(File,"Deaths",PlayerInfo[playerid][pDeaths]);
    INI_WriteInt(File,"Score",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Skin",GetPlayerSkin(playerid));
    INI_WriteInt(File, "Vip", PlayerInfo[playerid][pVip]);
    INI_WriteInt(File, "Banned", PlayerInfo[playerid][pBanned]);
    INI_WriteInt(File, "Muted", PlayerInfo[playerid][pMuted]);
    INI_WriteInt(File, "Weed", PlayerInfo[playerid][pWeed]);
    INI_WriteInt(File, "Cocaine", PlayerInfo[playerid][pCoke]);
    INI_WriteInt(File, "Meth", PlayerInfo[playerid][pMeth]);



    INI_Close(File);
    GetPlayerName(playerid, pname, sizeof(pname));
    print(string);
	format(string, sizeof(string),"[SERVER]: %s has left the server.", pname);
	SendClientMessageToAll(TGrey, string);

    return 1;
}

public OnPlayerSpawn(playerid)
{
	Spawned[playerid] = 1;
	TextDrawShowForPlayer(playerid, rmsg);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    PlayerInfo[killerid][pKills]++;
    PlayerInfo[playerid][pDeaths]++;
	if(GetPlayerMoney(playerid) < 500)
	{
	  SendClientMessage(playerid, TRed, "[SERVER]: You didn't have $500 to fix your wounds, get some money junkie.");
	}
	else if(GetPlayerMoney(playerid) > 500)
	{
      SendClientMessage(playerid, TRed, "[SERVER]: You got killed and paid $500 to fix your wounds.");
	}
	new pname[MAX_PLAYER_NAME], ename[MAX_PLAYER_NAME], string[128];
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(killerid, ename, sizeof(ename));
	format(string, sizeof(string), "[SERVER]: You killed %s and looted $1,000 from him (+ 1 Score).", pname);
	SendClientMessage(killerid, TGreen, string);
	format(string, sizeof(string), "[SERVER]: You have been killed by %s!", ename);
	SendClientMessage(playerid, TRed, string);
	GivePlayerMoney(killerid, 1000);
	GivePlayerMoney(playerid, -500);
	SendDeathMessage(killerid, playerid, reason);
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(PlayerInfo[playerid][pMuted] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: You're muted, you can't talk on the chat!");
	else if(PlayerInfo[playerid][pMuted] == 0) return 1;
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, TRed, "[SERVER]: You must be spawned!");
	return 1;
}
CMD:inventory(playerid, params[])
{
	new string[64];
	format(string, sizeof(string), "Weed: %d | Cocaine: %d | Meth: %d.", PlayerInfo[playerid][pWeed], PlayerInfo[playerid][pCoke], PlayerInfo[playerid][pMeth]);
	SendClientMessage(playerid, TLime, string);
    return 1;
}
CMD:useweed(playerid, params[])
{
	new Float:phealth;
	if(PlayerInfo[playerid][pWeed] < 5) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough weed to smoke!");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	GetPlayerHealth(playerid, Float:phealth);
	SetPlayerHealth(playerid, phealth+20);
	PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed]-5;
	SendClientMessage(playerid, TOrange, "[SERVER]: You used 5 grams of weed.");
   	return 1;
}
CMD:usecocaine(playerid, params[])
{
	new Float:phealth;
	if(PlayerInfo[playerid][pCoke] < 5) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough cocaine to use!");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	GetPlayerHealth(playerid, Float:phealth);
	SetPlayerHealth(playerid, phealth+50);
	PlayerInfo[playerid][pCoke] = PlayerInfo[playerid][pCoke]-5;
	SendClientMessage(playerid, TOrange, "[SERVER]: You used 5 grams of cocaine.");
  	return 1;
}
CMD:usemeth(playerid, params[])
{
	new Float:phealth;
	if(PlayerInfo[playerid][pMeth] < 5) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough meth to use!");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	GetPlayerHealth(playerid, Float:phealth);
	SetPlayerHealth(playerid, phealth+80);
	PlayerInfo[playerid][pMeth] = PlayerInfo[playerid][pMeth]-5;
	SendClientMessage(playerid, TOrange, "[SERVER]: You used 5 grams of meth.");
   	return 1;
}
CMD:help(playerid, params[])
{
	ShowPlayerDialog(playerid, DHelp, DIALOG_STYLE_MSGBOX, DRed"Server help:", DWhite"- You can earn money by killing other players or opening Random packages.\n- You can get vehicles from Vehicles shop.\n- You can get weapons from ammu-nation.\n- You can get food & drinks from shops around the map.\n- You can get drugs from drug den.", "Close","");
	return 1;
}
CMD:rules(playerid, params[])
{
	ShowPlayerDialog(playerid, DRules, DIALOG_STYLE_LIST, DRed"Server rules:", DWhite"- Do not use any cheats.\n- Do not spam, flood or insult.\n- Do not advertise any servers or websites.\n- Do not quit to avoid death.\n- Do not do /q jokes.\n- Do not ban evade.\n- Do not bug abuse.", "Close","");
	return 1;
}
CMD:commands(playerid, params[])	
{
	ShowPlayerDialog(playerid, DCmds, DIALOG_STYLE_MSGBOX, DRed"Player commands:", DWhite"- Commands: /help, /rules, /commands, /updates, /credits, /web, /stuck, /kill, /pmon, /pmoff, /pm, /disableget, /disablegoto, /enableget, /enablegoto, /givecash, /useweed, /usecocaine, /usemeth, /mydrugs", "Close","");
	return 1;
}
CMD:stuck(playerid, params[])	
{
	new Float:x, Float:y, Float:z;
	SendClientMessage(playerid, TGreen, "[SERVER]: You're not stuck anymore.");
	SendClientMessage(playerid, TRed, "[SERVER]: You will get punished if you abuse this command!");
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x+3, y, z);
	ClearAnimations(playerid);

	return 1;
}

CMD:kill(playerid, params[])
{
	if(Jailed[playerid] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: You're jailed, don't use that buddy.");
	SetPlayerHealth(playerid, 0.0);
	PlayerInfo[playerid][pDeaths]++;
	SendClientMessage(playerid, TRed, "[SERVER]: You used suicide pills and you just died...");
	return 1;
}
CMD:stats(playerid, params[])
{
	new string[128], pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(string, sizeof(string),"| Username: %s | Kills: %d | Deaths: %d | Money: %d | Score: %d | Skin ID: %d | V.I.P: %d | Admin: %d", pname,PlayerInfo[playerid][pKills], PlayerInfo[playerid][pDeaths], PlayerInfo[playerid][pCash], PlayerInfo[playerid][pScore], PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pVip], PlayerInfo[playerid][pAdmin]);
	SendClientMessage(playerid, TBlue, string);
	return 1;
}
CMD:updates(playerid, params[])
{
	ShowPlayerDialog(playerid, DUpdates, DIALOG_STYLE_MSGBOX, DRed"Server updates:", DWhite"- Last Updates: 'Nothing'.", "Close", "");
	return 1;
}
CMD:credits(playerid, params[])
{
	ShowPlayerDialog(playerid, DCredits, DIALOG_STYLE_MSGBOX, DRed"Server credits:", DWhite"- This gamemode is developed by Mad.", "Close","");
	return 1;
}
CMD:web(playerid, params[])	
{
	ShowPlayerDialog(playerid, DWeb, DIALOG_STYLE_MSGBOX, DRed"Server website:", DWhite" www.website.com ", "Close", "");
	return 1;
}

CMD:pmon(playerid, params[])
{
	if(PM[playerid] == 0) return SendClientMessage(playerid, TRed, "[SERVER]: Your PM is already on!");
	PM[playerid] = 0;
	SendClientMessage(playerid, TOrange, "[SERVER]: 'PM' turned ON!");

	return 1;
}
CMD:pmoff(playerid, params[])
{
	if(PM[playerid] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: Your PM is already off!");
	PM[playerid] = 1;
	SendClientMessage(playerid, TOrange, "[SERVER]: 'PM' turned OFF!");
	return 1;
}
CMD:pm(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, message;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
	if(sscanf(params, "us", tplayer, message)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /PM <ID> <Message>.");
  	if(tplayer == INVALID_PLAYER_ID) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	if(PM[playerid] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: Your PM is off, you can't send messages!");
  	if(PM[tplayer] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: This player's PM is off, you can't send him messages!");
  	if(PlayerInfo[playerid][pMuted] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: You're muted, you can't use this command!");
    format(string, sizeof(string), "(PM)%s: %s", pname, message);
    SendClientMessage(playerid, TOrange, string);
    format(string, sizeof(string), "(PM)%s: %s", pname, message);
    SendClientMessage(tplayer, TBlue, string);
	return 1;
}
CMD:disablegoto(playerid, params[])
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	if(Goto[playerid] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: 'GOTO' is already disabled.");
	else Goto[playerid] = 1;
	SendClientMessage(playerid, TLime, "[SERVER): 'GOTO' disabled!" );
	return 1;
}
CMD:enablegoto(playerid, params[])
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	if(Goto[playerid] == 0) return SendClientMessage(playerid, TRed, "[SERVER]: 'GOTO' is already enabled.");
	else Goto[playerid] = 0;
	SendClientMessage(playerid, TLime, "[SERVER): 'GOTO' enabled!" );
	return 1;
}
CMD:disableget(playerid, params[])
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	if(Get[playerid] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: 'GET' is already disabled.");
	else Get[playerid] = 1;
	SendClientMessage(playerid, TLime, "[SERVER): 'GET' disabled!" );
	return 1;
}
CMD:enableget(playerid, params[])
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	if(Get[playerid] == 0) return SendClientMessage(playerid, TRed, "[SERVER]: 'GET' is already enabled.");
	else Get[playerid] = 0;
	SendClientMessage(playerid, TLime, "[SERVER): 'GET' enabled!" );
	return 1;
}
CMD:givecash(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, cash;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
	if(sscanf(params, "ud", tplayer, cash)) return SendClientMessage(playerid, TRed, "[SERVER]: Use /givecash <ID> <amount>");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player ID!");
	if(tplayer == playerid) return SendClientMessage(playerid, TRed, "[SERVER]: You can't send money to yourself!");
	if(GetPlayerMoney(playerid) < cash) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money!");
	GivePlayerMoney(tplayer, cash);
	GivePlayerMoney(playerid, -cash);
	format(string, sizeof(string), "[SERVER]: You've sent %s $%d.", tname, cash);
	SendClientMessage(playerid, TOrange, string);
	format(string, sizeof(string), "[SERVER]: %s sent you $%d.", pname, cash);
	SendClientMessage(tplayer, TLime, string);
	return 1;

}

	// ------------------------- [ Admin Section ]: ---------------------------- //

	// -------------------------[ All Admins ]: -------------------------------- //

CMD:ahelp(playerid, params[])
{

	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	ShowPlayerDialog(playerid, DAhelp, DIALOG_STYLE_MSGBOX, "Admin help:", "- Admin level 1: /mute, /disarm, /agoto, /aget, /setvw, /aslap, /getarmour, /gethealth.\n- Admin level 2: /fine, /jail, /unjail, /setskin, /agiveweapon, /sethealth, /setarmour, /akill, /explode, /getstats, /kick, /write, /spec, /freeze, /unspec, /unfreeze\n- Admin level 3: /ban, /sban, /skick, /agivecash. ", "Close", "");
    return 1;
}

	// -------------------------[ RCON Admin ]: -------------------------------- //

CMD:setadmin(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, alevel;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", tplayer, alevel)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /setadmin <ID> <Level>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    if(0 > alevel || alevel > 3 ) return SendClientMessage(playerid, TRed, "[SERVER]: Level must be between 0 & 3.");
	format(string, sizeof(string), "[ADMIN]: Admin %s set your admin level to %d!", pname, alevel);
	SendClientMessage(tplayer, TOrange, string);
	format(string, sizeof(string), "[ADMIN]: You've set %s's admin level to %d.", tname, alevel);
	SendClientMessage(playerid, TLime, string);
	PlayerInfo[tplayer][pAdmin] = alevel;
	return 1;
}
CMD:setvip(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, vlevel;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", tplayer, vlevel)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /setvip <ID> <Level>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    if(0 > vlevel || vlevel > 3 ) return SendClientMessage(playerid, TRed, "[SERVER]: Level must be between 0 & 3.");
	format(string, sizeof(string), "[ADMIN]: Admin %s set your V.I.P level to %d!", pname, vlevel);
	SendClientMessage(tplayer, TOrange, string);
	format(string, sizeof(string), "[ADMIN]: You've set %s's V.I.P level to %d.", tname, vlevel);
	SendClientMessage(playerid, TLime, string);
	PlayerInfo[tplayer][pVip] = vlevel;
	return 1;
}

	// -------------------------[ All V.I.Ps ]: -------------------------------- //

CMD:vhelp(playerid, params[])
{
	if(PlayerInfo[playerid][pVip] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level V.I.P to use this command!");
	ShowPlayerDialog(playerid, DVhelp, DIALOG_STYLE_MSGBOX, "V.I.P help:", "- V.I.P Level 1: /vgoto, /vget\n- V.I.P Level 2: /vskin, /vwrite /vcolor\n- V.I.P Level 3: /vfreeweapon, /vjetpack.", "Close", "");
	return 1;
}

	// -------------------------[ V.I.P level 1 ]: -------------------------------- //

CMD:vgoto(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, Float:x, Float: y, Float: z;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pVip] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level V.I.P to use this command!");
	if(sscanf(params, "d", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /vgoto <ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
  	if(tplayer == playerid) return SendClientMessage(playerid, TRed, "[SERVER]: You can't teleport to yourself!");
  	if(Goto[tplayer] == 0) return SendClientMessage(playerid, TRed, "[SERVER]: Player disabled 'GOTO");
	GetPlayerPos(tplayer, x, y, z);
	SetPlayerPos(playerid, x, y, z);
	format(string, sizeof(string), "[V.I.P]: V.I.P member %s teleported to you.", pname);
	SendClientMessage(playerid, TOrange, string);
	format(string, sizeof(string), "[V.I.P]: You successfully teleported to %s!", tname);
	SendClientMessage(playerid, TLime, string);
	SendClientMessage(tplayer, TRed, "[SERVER]: If you want to stop V.I.P members from teleporting to you, use /disablegoto.");
	return 1;
}
CMD:vget(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, Float:x, Float:y, Float:z;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pVip] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level V.I.P to use this command!");
	if(sscanf(params, "d", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /vget <ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
  	if(tplayer == playerid) return SendClientMessage(playerid, TRed, "[SERVER]: You can't get yourself!");
  	if(Get[tplayer] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: Player disabled 'GET");
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(tplayer, x, y, z);
	format(string, sizeof(string), "[V.I.P]: V.I.P %s teleported you to their location.", pname);
	SendClientMessage(playerid, TOrange, string);
	format(string, sizeof(string), "[V.I.P]: You successfully teleported %s to your location!", tname);
	SendClientMessage(playerid, TLime, string);
	SendClientMessage(tplayer, TRed, "[SERVER]: If you want to stop V.I.P members from teleporting you, use /disableget.");
	return 1;
}

	// -------------------------[ V.I.P level 2 ]: -------------------------------- //

CMD:vwrite(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], string[128];
	GetPlayerName(playerid, pname, sizeof(pname));
   	if(PlayerInfo[playerid][pVip] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level V.I.P to use this command!");
  	if(sscanf(params, "s", string)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /vwrite <Text>.");
  	format(string, sizeof(string), "[V.I.P - %s]: %s", pname, string);
  	SendClientMessageToAll(TLBlue, string);
	return 1;
}
CMD:vskin(playerid, params[])
{
   	if(PlayerInfo[playerid][pVip] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level V.I.P to use this command!");
    ShowModelSelectionMenu(playerid, skins, "Select a Skin");
	return 1;
}
CMD:vcolor(playerid, params[])
{
	if(PlayerInfo[playerid][pVip] < 2) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level V.I.P to use this command!");
    ShowPlayerDialog(playerid, DVC, DIALOG_STYLE_LIST, "V.I.P colors:", "- Red\n- Grey\n- Green\n- Yellow\n- Blue\n- Orange\n- Lime\n- Magenta", "Select","Close");
	return 1;
}

	// -------------------------[ V.I.P level 3 ]: -------------------------------- //



CMD:vfreeweapon(playerid, params[])
{
	if(PlayerInfo[playerid][pVip] < 3) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level V.I.P to use this command!");
	GivePlayerWeapon(playerid, 24, 9999);
	SendClientMessage(playerid, TLime, "[SERVER]: You recieved free V.I.P weapon.");
	return 1;
}
CMD:vjetpack(playerid, params[])
{
	if(PlayerInfo[playerid][pVip] < 3) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level V.I.P to use this command!");
	if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid, TRed, "[SERVER]: You need atleast $50,000 to buy a V.I.P Jetpack.");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, TRed, "[SERVER]: Exit your vehicle please.");
	GivePlayerMoney(playerid, -50000);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}

    // -------------------------[ Admin level 1 ]: -------------------------------- //

CMD:gethealth(playerid, params[])
{
	new tname[MAX_PLAYER_NAME], string[128], tplayer, Float:phealth;
	GetPlayerName(tplayer, tname, sizeof(tname));
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "u", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /gethealth <ID>");
    if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player.");
    GetPlayerHealth(playerid, phealth);
    format(string, sizeof(string), "[ADMIN]: %s's health is %d.", tname, phealth );
    SendClientMessage(playerid, TLime, string);
    return 1;
}
CMD:getarmour(playerid, params[])
{
	new tname[MAX_PLAYER_NAME], string[128], tplayer, Float:armour;
	GetPlayerName(tplayer, tname, sizeof(tname));
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "u", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /getarmour <ID>");
    if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player.");
    GetPlayerArmour(tplayer, armour);
    format(string, sizeof(string), "[ADMIN]: %s's armour is %d.", tname, armour);
    SendClientMessage(playerid, TLime, string);
    return 1;
}
CMD:agoto(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, Float:x, Float: y, Float: z; 
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	if(sscanf(params, "d", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /agoto <ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
  	if(tplayer == playerid) return SendClientMessage(playerid, TRed, "[SERVER]: You can't teleport to yourself!");
	GetPlayerPos(tplayer, x, y, z);
	SetPlayerPos(playerid, x, y, z);
	format(string, sizeof(string), "[ADMIN]: Admin %s teleported to you.", pname);
	SendClientMessage(playerid, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You successfully teleported to %s!", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:aget(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, Float:x, Float:y, Float:z;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	if(sscanf(params, "d", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /aget <ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
  	if(tplayer == playerid) return SendClientMessage(playerid, TRed, "[SERVER]: You can't get yourself!");
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(tplayer, x, y, z);
	format(string, sizeof(string), "[ADMIN]: Admin %s teleported you to their location.", pname);
	SendClientMessage(playerid, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You successfully teleported %s to your location!", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:aslap(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, Float:x, Float:y, Float:z;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	if(sscanf(params, "d", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /aslap <ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	PlayerPlaySound(tplayer, 1190, 0.0, 0.0, 0.0);
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(tplayer, x, y, z+6);
	format(string, sizeof(string), "[ADMIN]: Admin %s slapped you.", pname);
	SendClientMessage(playerid, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You successfully slapped %s.", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:disarm(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	if(sscanf(params, "d", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /disarm <ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    ResetPlayerWeapons(tplayer);
	format(string, sizeof(string), "[ADMIN]: Admin %s disarmed you.", pname);
	SendClientMessage(playerid, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You successfully disarmed %s.", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:setvw(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, vw;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", tplayer, vw)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /setvw <ID> <Virtual world ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    if(0 > vw || vw > 1000 ) return SendClientMessage(playerid, TRed, "[SERVER]: For technical reasons, Virtual world ID must be between 0 & 1000.");
    if(Jailed[tplayer] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: Don't you dare.");
	format(string, sizeof(string), "[ADMIN]: Admin %s set your virtual world to %d!", pname, vw);
	SendClientMessage(tplayer, TGreen, string);
	format(string, sizeof(string), "[ADMIN]: You've set %s's virtual world to %d.", tname, vw);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:fine(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, amount;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	if(sscanf(params, "ud", tplayer, amount)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /fine <ID> <Amount>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	if(GetPlayerMoney(tplayer) < 0) return SendClientMessage(playerid, TRed, "[SERVER]: Somehow this player have -$0, maybe he is a rule-breaker.");
	GivePlayerMoney(tplayer, -amount);
	format(string, sizeof(string), "[ADMIN]: Admin %s fined with $%d!", pname, amount);
	SendClientMessage(tplayer, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You've fined %s with $%d.", tname, amount);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:mute(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, reason[28];
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 1 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "us", tplayer, reason)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /mute <ID> <Reason>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    PlayerInfo[tplayer][pMuted] = 1;
	format(string, sizeof(string), "[ADMIN]: Admin %s muted  %s for ' %s '!", pname, tname, reason);
	SendClientMessageToAll(TRed, string);
	format(string, sizeof(string), "[ADMIN]: You muted %s for ' %s '!", tname, reason);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:unmute(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 1 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "us", tplayer)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /unmute <ID>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    PlayerInfo[tplayer][pMuted] = 0;
	format(string, sizeof(string), "[ADMIN]: Admin %s unmuted  %s.", pname, tname);
	SendClientMessageToAll(TRed, string);
	format(string, sizeof(string), "[ADMIN]: You unmuted %s for ' %s '!", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:respawnvehicles(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], string[128];
	GetPlayerName(playerid, pname, sizeof(pname));
   	if(PlayerInfo[playerid][pAdmin] < 1 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
   	for(new c=0;c<MAX_VEHICLES;c++)
    {
        SetVehicleToRespawn(c);
    }
    format(string, sizeof(string), "[ADMIN]: Admin %s respawned all vehicles!", pname);
    SendClientMessageToAll(TLime, string);
    return 1;

}

	// -------------------------[ Admin level 2 ]: -------------------------------- //

CMD:ajetpack(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, TRed, "[SERVER]: Exit your vehicle please.");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}

CMD:setskin(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, skinid;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, TRed, "[SERVER]: You must be spawned!");
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", tplayer, skinid)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /setskin <ID> <Skin ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    if(0 > skinid || skinid > 311 ) return SendClientMessage(playerid, TRed, "[SERVER]: SA:MP supports skins from 0 to 311.");
    SetPlayerSkin(playerid, skinid);
   	format(string, sizeof(string), "[ADMIN]: Admin %s set your skin to %d!", pname, skinid);
	SendClientMessage(tplayer, TGreen, string);
	format(string, sizeof(string), "[ADMIN]: You've set %s's skin to %d.", tname, skinid);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:jail(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "u", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /jail <ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	if(Jailed[tplayer] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: Player is already jailed!");
	Jailed[tplayer] = 1;
	SetPlayerInterior(tplayer, 3);
	SetPlayerVirtualWorld(tplayer, 2);
	SetPlayerFacingAngle(playerid, 360.0);
	SetPlayerPos(tplayer, 197.5662, 175.4800, 1004.0 );
	ResetPlayerWeapons(tplayer);
	format(string, sizeof(string), "[ADMIN]: You have been jailed by %s.", pname);
	SendClientMessage(tplayer, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You successfully jailed %s!", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:unjail(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "u", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /unjail <ID>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	if(Jailed[tplayer] == 0) return SendClientMessage(playerid, TRed, "[SERVER]: Player is already unjailed!");
	Jailed[tplayer] = 0;
	SetPlayerInterior(tplayer, 0);
	SetPlayerVirtualWorld(tplayer, 0);
	SpawnPlayer(tplayer);
	format(string, sizeof(string), "[ADMIN]: You have been unjailed by %s.", pname);
	SendClientMessage(tplayer, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You successfully unjailed %s!", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:agiveweapon(playerid, params[]) 
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, weaponid, ammo;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "udd", tplayer, weaponid, ammo)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /agiveweapon <ID> <Weapon ID> <Ammo>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    if(weaponid > 42 ) return SendClientMessage(playerid, TRed, "[SERVER]: Do not use invalid weapons please.");
    GivePlayerWeapon(tplayer, weaponid, ammo);
   	format(string, sizeof(string), "[ADMIN]: Admin %s gave you weapon ID: %d with %d ammo!", pname, weaponid, ammo);
	SendClientMessage(tplayer, TGreen, string);
	format(string, sizeof(string), "[ADMIN]: You've given %s the weapon ID: %d with %d ammo.", tname, weaponid, ammo);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:sethealth(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, Float:health;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", tplayer, health)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /sethealth <ID> <Amount>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    SetPlayerHealth(playerid, health);
   	format(string, sizeof(string), "[ADMIN]: Admin %s set your health to %d!", pname, health);
	SendClientMessage(tplayer, TGreen, string);
	format(string, sizeof(string), "[ADMIN]: You've set %s's health to %d.", tname, health);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:setarmour(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, armour;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", tplayer, armour)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /setarmour <ID> <Amount>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    SetPlayerArmour(playerid, armour);
   	format(string, sizeof(string), "[ADMIN]: Admin %s set your armour to %d!", pname, armour);
	SendClientMessage(tplayer, TGreen, string);
	format(string, sizeof(string), "[ADMIN]: You've set %s's armour to %d.", tname, armour);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:akill(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	if(sscanf(params, "u", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /akill <ID>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
  	if(Jailed[tplayer] == 1) return SendClientMessage(playerid, TRed, "[SERVER]: I know i'm a program, but not stupid.");
	SetPlayerHealth(tplayer, 0);
	PlayerInfo[tplayer][pDeaths]++;
	format(string, sizeof(string), "[ADMIN]: Admin %s killed you.", pname);
	SendClientMessage(playerid, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You successfully killed %s!", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:explode(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, Float:x, Float: y, Float: z;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
	if(sscanf(params, "u", tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /explode <ID>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	GetPlayerPos(tplayer, x, y, z);
	CreateExplosion(x, y, z, 1, 1);
	format(string, sizeof(string), "[ADMIN]: Admin %s exploded you.", pname);
	SendClientMessage(playerid, TRed, string);
	format(string, sizeof(string), "[ADMIN]: You successfully exploded %s!", tname);
	SendClientMessage(playerid, TLime, string);
	return 1;
}
CMD:getstats(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
   	if(PlayerInfo[playerid][pAdmin] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "u", tplayer)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /getstats <ID>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	format(string, sizeof(string),"| Kills: %d | Deaths: %d | Money: %d | Score: %d | Skin ID: %d | V.I.P: %d", PlayerInfo[tplayer][pKills], PlayerInfo[tplayer][pDeaths], PlayerInfo[tplayer][pCash], PlayerInfo[tplayer][pScore], PlayerInfo[tplayer][pSkin], PlayerInfo[tplayer][pVip]);
	SendClientMessage(playerid, TBlue, string);
	return 1;
}
CMD:kick(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, reason[28];
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "us", tplayer, reason)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /kick <ID> <Reason>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	format(string, sizeof(string), "[ADMIN]: Admin %s kicked  %s for ' %s '!", pname, tname, reason);
	SendClientMessageToAll(TRed, string);
	format(string, sizeof(string), "[ADMIN]: You kicked %s for ' %s '!", tname, reason);
	SendClientMessage(playerid, TLime, string);
	SetTimer("Kickp", 2000, false);
	return 1;
}
CMD:write(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], string[128];
	GetPlayerName(playerid, pname, sizeof(pname));
   	if(PlayerInfo[playerid][pAdmin] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "s", string)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /write <Text>.");
  	format(string, sizeof(string), "[ADMIN - %s]: %s", pname, string);
  	SendClientMessageToAll(TOrange, string);
	return 1;
}
CMD:spec(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "u", tplayer)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /spec <ID>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	format(string, sizeof(string), "[ADMIN]: You're spectating %s!", tname);
	SendClientMessage(playerid, TLime, string);
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectatePlayer(playerid, tplayer, SPECTATE_MODE_NORMAL);
	return 1;
}
CMD:freeze(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "u", tplayer)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /freeze <ID>.");
   	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	format(string, sizeof(string), "[ADMIN]: You froze %s!", tname);
	SendClientMessage(playerid, TLime, string);
	format(string, sizeof(string), "[ADMIN: Admin %s froze you!");
	TogglePlayerControllable(tplayer, 0);
	return 1;
}
CMD:unspec(playerid, params[])
{
   	if(PlayerInfo[playerid][pAdmin] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    TogglePlayerSpectating(playerid, 0);
    SendClientMessage(playerid, TLime, "[SERVER]: You stopped spectating!");
	return 1;
}
CMD:unfreeze(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 2 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "u", tplayer)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /unfreeze <ID>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	format(string, sizeof(string), "[ADMIN]: You unfroze %s!", tname);
	SendClientMessage(playerid, TLime, string);
	format(string, sizeof(string), "[ADMIN: Admin %s unfroze you!");
	TogglePlayerControllable(tplayer, 1);
	return 1;
}

	// -------------------------[ Admin level 3 ]: -------------------------------- //

CMD:ban(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, reason[28];
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 3 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "us", tplayer, reason)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /ban <ID> <Reason>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    PlayerInfo[tplayer][pBanned] = 1;
	format(string, sizeof(string), "[ADMIN]: Admin %s banned  %s for ' %s '!", pname, tname, reason);
	SendClientMessageToAll(TRed, string);
	format(string, sizeof(string), "[ADMIN]: You banned %s for ' %s '!", tname, reason);
	SendClientMessage(playerid, TLime, string);
	SetTimer("Banp", 2000, false);
	return 1;
}
CMD:skick(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 3 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "us", tplayer)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /skick <ID>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
	format(string, sizeof(string), "[ADMIN]: You silently kicked %s!", tname);
	SendClientMessage(playerid, TLime, string);
	SetTimer("Kickp", 2000, false);
	return 1;
}
CMD:sban(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
   	if(PlayerInfo[playerid][pAdmin] < 3 ) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
  	if(sscanf(params, "u", tplayer)) SendClientMessage(playerid, TRed, "[SERVER]: Usage: /sban <ID>.");
  	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
  	PlayerInfo[tplayer][pBanned] = 1;
	format(string, sizeof(string), "[ADMIN]: You silently banned %s!", tname);
	SendClientMessage(playerid, TLime, string);
	SetTimer("Banp", 2000, false);
	return 1;
}
CMD:agivecash(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, cash;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
    if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, TRed, "[SERVER]: You must be a high level admin to use this command!");
    if(sscanf(params, "ud", tplayer, cash)) return SendClientMessage(playerid, TRed, "[SERVER]: Usage: /agivecash <ID> <Amount>.");
	if(!IsPlayerConnected(tplayer)) return SendClientMessage(playerid, TRed, "[SERVER]: Invalid player id.");
    GivePlayerMoney(tplayer, cash);
   	format(string, sizeof(string), "[ADMIN]: Admin %s gave you $%d from the Staff team budget!", pname, cash);
	SendClientMessage(tplayer, TLime, string);
	format(string, sizeof(string), "[ADMIN]: You've gave %s's  $%d from the Staff team budget.", tname, cash);
	SendClientMessage(playerid, TYellow, string);
    SetPlayerScore(tplayer, GetPlayerMoney(tplayer));
	return 1;
}

public RandomMessage()
{
        TextDrawSetString(rmsg, RandomMessages[random(sizeof(RandomMessages))]); 
        return 1;
}
public Banp(playerid)
{
	Ban(playerid);
}
public Kickp(playerid)
{
	Kick(playerid);
}
public OnPlayerModelSelection(playerid, response, listid, modelid)
{

    if(listid == skins)
    {
        if(response)
        {
            SendClientMessage(playerid, TLime, "[SERVER]: You successfully changed your skin!");
            SetPlayerSkin(playerid, modelid);
        }
        else SendClientMessage(playerid, TRed, "[SERVER]: You successfully canceled Skin Selection.");
        return 1;
    }
    if(listid == cskins)
    {
        if(response)
        {
        	if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money!");
            SendClientMessage(playerid, TLime, "[SERVER]: You successfully changed your skin and paid $5,000!");
            GivePlayerMoney(playerid, -5000);
            SetPlayerSkin(playerid, modelid);
        }
        else SendClientMessage(playerid, TRed, "[SERVER]: You successfully canceled Skin Selection.");
        return 1;
    }
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == Weaponshop)
	{
		ShowPlayerDialog(playerid, Wshop, DIALOG_STYLE_LIST, "Ammu-nation:", "- 9mm [$300] [100 ammo]\n- Silenced 9mm [$500] [100 ammo]\n- Desert Eagle [$1,000] [100 ammo]\n- Pump shotgun [$1,500] [100 ammo]\n- Sawn off [$2,000] [50 ammo]\n- Combat Shotgun [$3,000] [50 ammo]\n- Tec9 [$500] [500 ammo]\n- Micro SMG [$800] [500 ammo]\n- SMG [$1,000] [300 ammo]\n- AK47 [$3,000] [200 ammo]\n- M4 [$5,000] [200 ammo]\n- County rifle [$2,000] [100 ammo]\n- Sniper rifle [$8,000] [100 ammo]", "Select","Close");
	}
	if(pickupid == DrugFellas)
	{
		ShowPlayerDialog(playerid, Dshop, DIALOG_STYLE_LIST, "Drug Fellas:", "- Weed [$1,000] per 5 grams.\n- Cocaine [$2,500] per 5 grams.\n- Meth [$5,000] per 5 grams.", "Select","Close");
	}
    if(pickupid  == ClothesShop)
    {
    	ShowModelSelectionMenu(playerid, skins, "Select a Skin");
    }
    if(pickupid == Weaponshop2)
	{
		ShowPlayerDialog(playerid, Wshop, DIALOG_STYLE_LIST, "Ammu-nation:", "- 9mm [$300] [100 ammo]\n- Silenced 9mm [$500] [100 ammo]\n- Desert Eagle [$1,000] [100 ammo]\n- Pump shotgun [$1,500] [100 ammo]\n- Sawn off [$2,000] [50 ammo]\n- Combat Shotgun [$3,000] [50 ammo]\n- Tec9 [$500] [500 ammo]\n- Micro SMG [$800] [500 ammo]\n- SMG [$1,000] [300 ammo]\n- AK47 [$3,000] [200 ammo]\n- M4 [$5,000] [200 ammo]\n- County rifle [$2,000] [100 ammo]\n- Sniper rifle [$8,000] [100 ammo]", "Select","Close");
	}
	if(pickupid == DrugDepot)
	{
		ShowPlayerDialog(playerid, Dshop, DIALOG_STYLE_LIST, "Drug Fellas:", "- Weed [$1,000] per 5 grams.\n- Cocaine [$2,500] per 5 grams.\n- Meth [$5,000] per 5 grams.", "Select","Close");
	}
    if(pickupid  == ClothesShop2)
    {
    	ShowModelSelectionMenu(playerid, skins, "Select a Skin");
    }
    if(pickupid == DrugDen)
	{
		ShowPlayerDialog(playerid, Dshop, DIALOG_STYLE_LIST, "Drug Fellas:", "- Weed [$1,000] per 5 grams.\n- Cocaine [$2,500] per 5 grams.\n- Meth [$5,000] per 5 grams.", "Select","Close");
	}
    if(pickupid  == ClothesShop3)
    {
    	ShowModelSelectionMenu(playerid, skins, "Select a Skin");
    }
	return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
    SetPlayerScore(playerid, GetPlayerMoney(playerid));
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch( dialogid )
    {
        case DRegister:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DRegister, DIALOG_STYLE_PASSWORD, ""DWhite"Registering...",""DRed"You have entered an invalid password.\n"DWhite"Type your password below to register a new account.","Register","Quit");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",5000);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Kills",0);
                INI_WriteInt(File,"Deaths",0);
                INI_WriteInt(File,"Score",0);
                INI_WriteInt(File,"Skin", 2);
                INI_WriteInt(File,"Virtual World", 0);
                INI_WriteFloat(File, "Interior", 0);
                INI_WriteFloat(File, "Vip", 0);
                INI_WriteFloat(File, "Banned", 0);
                INI_WriteFloat(File, "Muted", 0);
                INI_WriteFloat(File, "Weed", 0);
                INI_WriteFloat(File, "Cocaine", 0);
                INI_WriteFloat(File, "Meth", 0);



                INI_Close(File);
                SpawnPlayer(playerid);
                ShowPlayerDialog(playerid, DRSuccess, DIALOG_STYLE_MSGBOX,""DWhite"Success!",""DWhite"You successfully registered.","Okay","");
			}
        }

        case DLogin:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
					ShowPlayerDialog(playerid, DLSuccess, DIALOG_STYLE_MSGBOX,""DWhite"Success!",""DWhite"You have successfully logged in!","Ok","");
                }
                else
                {
                    ShowPlayerDialog(playerid, DLogin, DIALOG_STYLE_PASSWORD,""DWhite"Login",""DRed"You have entered an incorrect password.\n"DWhite"Type your password below to login.","Login","Quit");
                }
                return 1;
            }
        }
        case DVC:
        {
    	    if(response)
    	    {

                switch(listitem)
                {

    		       case 0: SetPlayerColor(playerid, TRed);
    		       case 1: SetPlayerColor(playerid, TGrey);
    		       case 2: SetPlayerColor(playerid, TGreen);
    	           case 3: SetPlayerColor(playerid, TBlue);
    		       case 4: SetPlayerColor(playerid, TOrange);
    	    	   case 5: SetPlayerColor(playerid, TLime);
    		       case 6: SetPlayerColor(playerid, TMagenta);
                }
                return 1;

    		}
    	
        }
        case Wshop:
        {
    	    if(response)
    	    {

                switch(listitem)
                {
    		       case 0: {

    		       	if(GetPlayerMoney(playerid) < 300) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -300);
    		       	GivePlayerWeapon(playerid, WEAPON_COLT45, 100);
    		       }
    		       case 1: {

    		       	if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -500);
    		       	GivePlayerWeapon(playerid, WEAPON_SILENCED, 100);
    		       }
    		       case 2: {

    		       	if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -1000);
    		       	GivePlayerWeapon(playerid, WEAPON_DEAGLE, 100);
    		       }
    		       case 3: {

    		       	if(GetPlayerMoney(playerid) < 1500) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -1500);
    		       	GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 100);
    		       }
    		       case 4: {

    		       	if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -2000);
    		       	GivePlayerWeapon(playerid, WEAPON_SAWEDOFF, 50);
    		       }
    		       case 5: {

    		       	if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -3000);
    		       	GivePlayerWeapon(playerid, WEAPON_SHOTGSPA, 50);
    		       }
    		        case 6: {

    		       	if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -500);
    		       	GivePlayerWeapon(playerid, WEAPON_TEC9, 500);
    		       }
    		        case 7: {

    		       	if(GetPlayerMoney(playerid) < 800) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -800);
    		       	GivePlayerWeapon(playerid, WEAPON_UZI, 800);
    		       }
    		        case 8: {

    		       	if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -1000);
    		       	GivePlayerWeapon(playerid, WEAPON_MP5, 300);
    		       }
    		        case 9: {

    		       	if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -3000);
    		       	GivePlayerWeapon(playerid, WEAPON_AK47, 200);
    		       }
    		        case 10: {

    		       	if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -5000);
    		       	GivePlayerWeapon(playerid, WEAPON_M4, 200);
    		       }
    		        case 11: {

    		       	if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -2000);
    		       	GivePlayerWeapon(playerid, WEAPON_RIFLE, 100);
    		       }
    		        case 12: {

    		       	if(GetPlayerMoney(playerid) < 8000) return SendClientMessage(playerid, TRed, "[SERVER]: You don't have enough money to buy this weapon");
    		       	GivePlayerMoney(playerid, -8000);
    		       	GivePlayerWeapon(playerid, WEAPON_SNIPER, 100);
    		       }


                }
                return 1;

    		}
    	}
        case Dshop:
        {
    	    if(response)
    	    {

                switch(listitem)
                {

    		        case 0: {

    		       	if(GetPlayerMoney(playerid < 1000)) return SendClientMessage(playerid, TRed, "[SERVER]: You need more money to buy 5 grams of weed.");
    		        GivePlayerMoney(playerid, -1000);
    		        SendClientMessage(playerid, TLime, "[SERVER]: You bought 5 grams of weed!");
    		        PlayerInfo[playerid][pWeed] = PlayerInfo[playerid][pWeed]+5;
    		       }
    		        case 1: {

    		       	if(GetPlayerMoney(playerid < 2500)) return SendClientMessage(playerid, TRed, "[SERVER]: You need more money to buy 5 grams of cocaine.");
    		        GivePlayerMoney(playerid, -2500);
    		        SendClientMessage(playerid, TLime, "[SERVER]: You bought 5 grams of cocaine!");
    		        PlayerInfo[playerid][pCoke] = PlayerInfo[playerid][pCoke]+5;
    		       }
    		        case 2: {

    		       	if(GetPlayerMoney(playerid < 5000)) return SendClientMessage(playerid, TRed, "[SERVER]: You need more money to buy 5 grams of meth.");
    		        GivePlayerMoney(playerid, -5000);
    		        SendClientMessage(playerid, TLime, "[SERVER]: You bought 5 grams of meth!");
    		        PlayerInfo[playerid][pMeth] = PlayerInfo[playerid][pMeth]+5;
    		       }

                }
                return 1;
    		}
    	}
	
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{

	return 1;
}

// ------------------------------------------------------------------------- //

stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),Save,playername);
    return string;
}
// ------------------------------------------------------------------------- //
