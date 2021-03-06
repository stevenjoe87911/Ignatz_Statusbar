/*
Status Bar for Epochmod
Developed by:	Darth_Rogue
Changed By:		[Ignatz] He-Man
Date:			2017-04-06
*/

[] spawn {
	waituntil {!isnull (finddisplay 46) && alive player};
	
	Ignatz_StatusbarSelected 		= 1;			/* Status Bar on Start - 0 = off / 1 = full / 2 = half / 3 = small */
	Ignatz_UseStatusBarSwitchKey 	= true;			/* Use SwitchKey to switch between different Status Bars */
	Ignatz_StatusBarSwitchKey 		= 0x36;			/* Key to switch between the Status Bars (right shift key) full list: https://community.bistudio.com/wiki/DIK_KeyCodes */
	_RestartTime 					= 3;			/* in hours */
	_Restart_offset 				= -120; 		/* in seconds - if you restart some seconds earlier (kick players for example) */
	_RestartWarningTimes 			= [1,2,5,10];	/* Array of restart-warning (x minutes before Restart) */
	
	_playersTxt = 		"<t shadow='1' shadowColor='#000000' color='%17'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\players.paa' color='%17'/>%1</t>";
	_energyTxt = 		"<t shadow='1' shadowColor='#000000' color='%17'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\energy.paa' color='%17'/>%2</t>";
	_StaminaTxt = 		"<t shadow='1' shadowColor='#000000' color='%17'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\stamina.paa' color='%19'/>%3</t>";
	_KryptoTxt = 		"<t shadow='1' shadowColor='#000000' color='%17'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\krypto.paa' color='%17'/>%4</t>";
	_DamageTxt = 		"<t shadow='1' shadowColor='#000000' color='%20'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\damage.paa' color='%20'/>%5%15</t>";
	_HungerTxt = 		"<t shadow='1' shadowColor='#000000' color='%21'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\hunger.paa' color='%21'/>%6%15</t>";
	_ThirstTxt = 		"<t shadow='1' shadowColor='#000000' color='%22'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\thirst.paa' color='%22'/>%7%15</t>";
	_TempTxt = 			"<t shadow='1' shadowColor='#000000' color='%23'><img size='1.1' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\temp.paa' color='%23'/> %8%16</t>";
	_ToxicTxt = 		"<t shadow='1' shadowColor='#000000' color='%24'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\toxicity.paa' color='%24'/>%9</t>";
	_BloodTxt = 		"<t shadow='1' shadowColor='#000000' color='%25'><img size='1.3' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\blood.paa' color='%25'/>%10</t>";
	_GPSTxt =			"<t shadow='1' shadowColor='#000000' color='%17'><img size='1.0' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\compass.paa' color='%17'/> %11</t>";
	_FPSTxt = 			"<t shadow='1' shadowColor='#000000' color='%17'>FPS %12</t>";
	_RestartTxt = 		"<t shadow='1' shadowColor='#000000' color='%17'><img size='1.6' shadowColor='#000000' image='addons\pics\Ignatz_Statusbar\restart.paa' color='%17'/>%13:%14</t>";
	_blanks = 			"   ";	/* Blanks for adjust the distance between the Icons */

	_StatusbarTxt1 =	
						_playersTxt + _blanks +
						_StaminaTxt + _blanks + 
						_KryptoTxt + _blanks + 
						_DamageTxt + _blanks + 
						_HungerTxt + _blanks + 
						_ThirstTxt + _blanks + 
						_TempTxt + _blanks + 
						_ToxicTxt + _blanks + 
						_BloodTxt + _blanks + 
						_GPSTxt + _blanks + 
						_FPSTxt + _blanks + 
						_RestartTxt;

	_StatusbarTxt2 = 	
						_StaminaTxt + _blanks + 
						_DamageTxt + _blanks + 
						_HungerTxt + _blanks + 
						_ThirstTxt + _blanks + 
						_TempTxt + _blanks + 
						_ToxicTxt + _blanks + 
						_BloodTxt + _blanks + 
						_GPSTxt + _blanks + 
						_RestartTxt;

	_StatusbarTxt3 =	
						_StaminaTxt + _blanks +
						_DamageTxt + _blanks + 
						_HungerTxt + _blanks + 
						_ThirstTxt + _blanks + 
						_RestartTxt;

	_StatusbarPosY =	safezoneY+safezoneH-0.1;	/* 10% from the bottom */
	_StatusbarHeight =	0.07;
	_StatusbarWidth1 =	1.2;
	_StatusbarWidth2 =	0.9;
	_StatusbarWidth3 =	0.55;
	_BackgrundColor =	[0,0,0,0.4];				/* [RR,GG,BB,TRANSPARENCY]	RGB in 0-1!!! */

/*	
	1		count playableunits,
	2		_energyPercent,
	3		_stamina,
	4		_wallet,
	5		_damage,
	6		_hunger,
	7		_thirst,
	8		_temp,
	9		_toxPercent,
	10		_bloodpressure,
	11		format['%1/%2',_xx,_yy],
	12		round diag_fps,
	13		_hours,
	14		_minutes,
	15		'%',
	16		'°C',
	17		_colourDefault,
	18		_colourEnergy,
	19		_colourStamina,
	20		_colourDamage,
	21		_colourHunger,
	22		_colourThirst,
	23		_colourTemp,
	24		_colourToxicity,
	25		_colourBloodP
/*
End Config
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/
	disableSerialization;
	_display = finddisplay 46;
	_Ignatz_StatusbarActive = 0;
	_tempblink 		= false;
	_damageblink 	= false;
	_hungerblink 	= false;
	_thirstblink 	= false;
	_toxicblink 	= false;
	_bloodpblink 	= false;
	
	_colourDefault 		= parseText '#ADADAD';
	_colour100 			= parseText '#336600';
	_colour90 			= parseText '#339900';
	_colour80 			= parseText '#33CC00';
	_colour70 			= parseText '#33FF00';
	_colour60 			= parseText '#66FF00';
	_colour50 			= parseText '#CCFF00';
	_colour40 			= parseText '#CCCC00';
	_colour30 			= parseText '#CC9900';
	_colour20 			= parseText '#CC6600';
	_colour10 			= parseText '#CC3300';
	_colour0 			= parseText '#CC0000';
	_colourDead 		= parseText '#000000';
	_colourTempLowest	= parseText '#0000CC';	
	_colourTempLower	= parseText '#9600CC';	
	_colourTempMid		= parseText '#336600';	
	_colourTempHigher	= parseText '#CC0055';	
	_colourTempHighest	= parseText '#FF0000';	
		
	_Statusbar = _display ctrlCreate ["RscStructuredText", 10000];
	_statusbar ctrlsetbackgroundcolor _BackgrundColor;
	_Statusbar ctrlSetPosition [
		safezoneX + safezoneW / 2 - 0,
		_StatusbarPosY,
		0,
		_StatusbarHeight
	];
	_Statusbar ctrlCommit 0.5;
	
	_minutes = -1;
	_restart = false;
	
	while {true} do {
		if (_Ignatz_StatusbarActive != Ignatz_StatusbarSelected) then {
			switch Ignatz_StatusbarSelected do {
				case 0:{
					_Ignatz_StatusbarActive = 0;
					_Statusbar ctrlSetPosition [
						safezoneX + safezoneW / 2 - 0,
						_StatusbarPosY,
						0,
						_StatusbarHeight
					];
				};
				case 1:{
					_Ignatz_StatusbarActive = 1;
					_Statusbar ctrlShow true;
					_Statusbar ctrlSetPosition [
						safezoneX + safezoneW / 2 - _StatusbarWidth1/2,
						_StatusbarPosY,
						_StatusbarWidth1,
						_StatusbarHeight
					];
				};
				case 2:{
					_Ignatz_StatusbarActive = 2;
					_Statusbar ctrlShow true;
					_Statusbar ctrlSetPosition [
						safezoneX + safezoneW / 2 - _StatusbarWidth2/2,
						_StatusbarPosY,
						_StatusbarWidth2,
						_StatusbarHeight
					];
				};
				case 3:{
					_Ignatz_StatusbarActive = 3;
					_Statusbar ctrlShow true;
					_Statusbar ctrlSetPosition [
						safezoneX + safezoneW / 2 - _StatusbarWidth3/2,
						_StatusbarPosY,
						_StatusbarWidth3,
						_StatusbarHeight
					];
				};
			};
			_Statusbar ctrlCommit 0.5;
			uisleep 0.5;
			if (_Ignatz_StatusbarActive == 0) then {
				_Statusbar ctrlShow false;
				_Statusbar ctrlSetText '';
			};
		}
		else {
			uisleep 1;
		};
		
		_time = (round(_RestartTime*3600+_Restart_offset-serverTime)) max 0;
		if (!isnil 'Ignatz_RestartOverrideTime') then {
			_time = (Ignatz_RestartOverrideTime+_Restart_offset-serverTime) max 0;
		};
		_hours = (floor(_time/3600));
		_minutes = (floor ((_time - _hours*3600)/60));
		if (_restart) exitwith {
			_txt = 'SERVER IS SHUTTING DOWN NOW - PLEASE LOGOUT!';
			_logouttime = 40 + (random 15);
			_randomwait = random _logouttime;
			TitleText [_txt,'BLACK OUT',40];
			uisleep _randomwait;
			true call EPOCH_pushCustomVar;
			uisleep ((_logouttime - _randomwait) max 1);
			[] spawn {_result = ["Server Restart! - You will be kicked in a few seconds ...","Restart"] call BIS_fnc_guiMessage;};
			uisleep 0.5;
			(finddisplay 46) closedisplay 0;
		};
		if ((_hours*60+_minutes) == 0) then {
			_restart = true;
		};
		if ((_hours*60+_minutes) in _RestartWarningTimes)then {
			if ((_hours*60+_minutes) == 1) then {
				_msg = format ["<t size='1' color='#DA1700' align='center'>RESTART IN %1 MINUTE<br/>PLEASE LOGOUT NOW!</t>",_minutes]; 
				_Ignatz_dyn = [_msg,0,safezoneY + safezoneH/2,5,0.5];
				_Ignatz_dyn spawn BIS_fnc_dynamicText; 
			}
			else {
				_msg = format ["<t size='0.7' color='#DA1700' align='left'>RESTART IN %1 MINUTES</t>",_minutes];  
				_Ignatz_dyn = [_msg,safezoneX+safezoneW/1.5,safezoneY+safezoneH/1.5,5,0.5];
				_Ignatz_dyn spawn BIS_fnc_dynamicText;
			};
			_RestartWarningTimes = _RestartWarningTimes - [_hours*60+_minutes];
		};
		if (_minutes < 10) then {
			_minutes = "0" + (str _minutes);
		};
		
		if !(_Ignatz_StatusbarActive == 0) then {
			_temp = round((EPOCH_playerTemp-32)/1.8*10)/10;
			_highestDMG = 0;
			{
				_currentDMG = _x;
				if (_currentDMG > _highestDMG) then{
					_highestDMG = _currentDMG;
				};
			} forEach (((getAllHitPointsDamage player) param[2,[]]) + [damage player]);
			_damage = round ((1 - _highestDMG) * 100);
			_hunger = round((EPOCH_playerHunger/5000) * 100);
			_thirst = round((EPOCH_playerThirst/2500) * 100);
			_wallet = EPOCH_playerCrypto;
			_stamina = round(EPOCH_playerStamina);
			_toxPercent = round (EPOCH_playerToxicity);
			_bloodpressure = round (EPOCH_playerBloodP);
			_energy = round(EPOCH_playerEnergy);
			_energyPercent =  floor(_energy);
			_grid = mapGridPosition  player; 
			_xx = (format[_grid]) select  [0,3]; 
			_yy = (format[_grid]) select  [3,3];  
			
			_colourBloodP = _colourDefault;
			if (_bloodpressure > 140 && _bloodpblink) then {
				_bloodpblink = false;
			}
			else {
				switch true do {
					case (_bloodpressure < 110) : {_colourBloodP =  _colour100;};
					case ((_bloodpressure >= 110) && (_bloodpressure < 120)) : {_colourBloodP =  _colour90;};
					case ((_bloodpressure >= 120) && (_bloodpressure < 130)) : {_colourBloodP =  _colour80;};
					case ((_bloodpressure >= 130) && (_bloodpressure < 140)) : {_colourBloodP =  _colour70;};
					case ((_bloodpressure >= 140) && (_bloodpressure < 150)) : {_colourBloodP =  _colour50;};
					case ((_bloodpressure >= 150) && (_bloodpressure < 160)) : {_colourBloodP =  _colour40;};
					case ((_bloodpressure >= 160) && (_bloodpressure < 170)) : {_colourBloodP =  _colour30;};
					case ((_bloodpressure >= 170) && (_bloodpressure < 180)) : {_colourBloodP =  _colour20;};
					case ((_bloodpressure >= 180) && (_bloodpressure < 190)) : {_colourBloodP =  _colour10;};
					case (_bloodpressure >= 190) : {_colourBloodP =  _colourDead;};
				};
				if (_bloodpressure > 150) then {
					_bloodpblink = true;
				}
				else {
					_bloodpblink = false;
				};
			};
			
			_colourTemp = _colourDefault;
			if ((_temp <= 35.5 || _temp > 38.5) && _tempblink) then {
				_tempblink = false;
			}
			else {
				switch true do {
					case (_temp < 35.5) : {_colourTemp =  _colourTempLowest;};
					case ((_temp >= 35.5) && (_temp < 36.5)) : {_colourTemp =  _colourTempLower;};
					case ((_temp >= 36.5) && (_temp < 37.5)) : {_colourTemp =  _colourTempMid;};
					case ((_temp >= 37.5) && (_temp < 38.5)) : {_colourTemp =  _colourTempHigher;};
					case (_temp > 38.5) : {_colourTemp =  _colourTempHighest;};
				};
				if (_temp <= 35.5 || _temp > 38.5) then {
					_tempblink = true;
				}
				else {
					_tempblink = false;
				};
			};
			
			_colourDamage = _colourDefault;
			if (_damage < 30 && _damageblink) then {
				_damageblink = false;
			}
			else {
				switch true do {
					case(_damage >= 100) : {_colourDamage = _colour100;};
					case((_damage >= 90) && (_damage < 100)) : {_colourDamage =  _colour90;};
					case((_damage >= 80) && (_damage < 90)) : {_colourDamage =  _colour80;};
					case((_damage >= 70) && (_damage < 80)) : {_colourDamage =  _colour70;};
					case((_damage >= 60) && (_damage < 70)) : {_colourDamage =  _colour60;};
					case((_damage >= 50) && (_damage < 60)) : {_colourDamage =  _colour50;};
					case((_damage >= 40) && (_damage < 50)) : {_colourDamage =  _colour40;};
					case((_damage >= 30) && (_damage < 40)) : {_colourDamage =  _colour30;};
					case((_damage >= 20) && (_damage < 30)) : {_colourDamage =  _colour20;};
					case((_damage >= 10) && (_damage < 20)) : {_colourDamage =  _colour10;};
					case((_damage >= 1) && (_damage < 10)) : {_colourDamage =  _colour0;};
					case(_damage < 1) : {_colourDamage =  _colourDead;};
				};
				if (_damage < 30) then {
					_damageblink = true;
				}
				else {
					_damageblink = false;
				};
			};
			
			_colourHunger = _colourDefault;
			if (_hunger < 10 && _hungerblink) then {
				_hungerblink = false;
			}
			else {
				switch true do {
					case(_hunger >= 100) : {_colourHunger = _colour100;};
					case((_hunger >= 90) && (_hunger < 100)) :  {_colourHunger =  _colour90;};
					case((_hunger >= 80) && (_hunger < 90)) :  {_colourHunger =  _colour80;};
					case((_hunger >= 70) && (_hunger < 80)) :  {_colourHunger =  _colour70;};
					case((_hunger >= 60) && (_hunger < 70)) :  {_colourHunger =  _colour60;};
					case((_hunger >= 50) && (_hunger < 60)) :  {_colourHunger =  _colour50;};
					case((_hunger >= 40) && (_hunger < 50)) :  {_colourHunger =  _colour40;};
					case((_hunger >= 30) && (_hunger < 40)) :  {_colourHunger =  _colour30;};
					case((_hunger >= 20) && (_hunger < 30)) :  {_colourHunger =  _colour20;};
					case((_hunger >= 10) && (_hunger < 20)) :  {_colourHunger =  _colour10;};
					case((_hunger >= 1) && (_hunger < 10)) :  {_colourHunger =  _colour0;};
					case(_hunger < 1) : {_colourHunger =  _colourDead;};
				};
				if (_hunger < 10) then {
					_hungerblink = true;
				}
				else {
					_hungerblink = false;
				};
			};
			
			
			_colourThirst = _colourDefault;		
			if (_thirst < 10 && _thirstblink) then {
				_thirstblink = false;
			}
			else {
				switch true do{
					case(_thirst >= 100) : {_colourThirst = _colour100;};
					case((_thirst >= 90) && (_thirst < 100)) :  {_colourThirst =  _colour90;};
					case((_thirst >= 80) && (_thirst < 90)) :  {_colourThirst =  _colour80;};
					case((_thirst >= 70) && (_thirst < 80)) :  {_colourThirst =  _colour70;};
					case((_thirst >= 60) && (_thirst < 70)) :  {_colourThirst =  _colour60;};
					case((_thirst >= 50) && (_thirst < 60)) :  {_colourThirst =  _colour50;};
					case((_thirst >= 40) && (_thirst < 50)) :  {_colourThirst =  _colour40;};
					case((_thirst >= 30) && (_thirst < 40)) :  {_colourThirst =  _colour30;};
					case((_thirst >= 20) && (_thirst < 30)) :  {_colourThirst =  _colour20;};
					case((_thirst >= 10) && (_thirst < 20)) :  {_colourThirst =  _colour10;};
					case((_thirst >= 1) && (_thirst < 10)) :  {_colourThirst =  _colour0;};
					case(_thirst < 1) : {_colourThirst =  _colourDead;};
				};
				if (_thirst < 10) then {
					_thirstblink = true;
				}
				else {
					_thirstblink = false;
				};
			};
			
			_colourEnergy = _colourDefault;
			switch true do {
				case(_energyPercent >= 100) : {_colourEnergy = _colour100;};
				case((_energyPercent >= 90) && (_energyPercent < 100)) :  {_colourEnergy =  _colour90;};
				case((_energyPercent >= 80) && (_energyPercent < 90)) :  {_colourEnergy =  _colour80;};
				case((_energyPercent >= 70) && (_energyPercent < 80)) :  {_colourEnergy =  _colour70;};
				case((_energyPercent >= 60) && (_energyPercent < 70)) :  {_colourEnergy =  _colour60;};
				case((_energyPercent >= 50) && (_energyPercent < 60)) :  {_colourEnergy =  _colour50;};
				case((_energyPercent >= 40) && (_energyPercent < 50)) :  {_colourEnergy =  _colour40;};
				case((_energyPercent >= 30) && (_energyPercent < 40)) :  {_colourEnergy =  _colour30;};
				case((_energyPercent >= 20) && (_energyPercent < 30)) :  {_colourEnergy =  _colour20;};
				case((_energyPercent >= 10) && (_energyPercent < 20)) :  {_colourEnergy =  _colour10;};
				case((_energyPercent >= 1) && (_energyPercent < 10)) :  {_colourEnergy =  _colour0;};
				case(_energyPercent < 1) : {_colourEnergy =  _colour0;};
			};
			
			_colourToxicity = _colourDefault;
			if (_toxPercent > 80 && _toxicblink) then {
				_toxicblink = false;
			}
			else {
				switch true do {
					case(_toxPercent >= 100) : {_colourToxicity = _colourDead;};
					case((_toxPercent >= 90) && (_toxPercent < 100)) :  {_colourToxicity =  _colour0;};
					case((_toxPercent >= 80) && (_toxPercent < 90)) :  {_colourToxicity =  _colour10;};
					case((_toxPercent >= 70) && (_toxPercent < 80)) :  {_colourToxicity =  _colour20;};
					case((_toxPercent >= 60) && (_toxPercent < 70)) :  {_colourToxicity =  _colour30;};
					case((_toxPercent >= 50) && (_toxPercent < 60)) :  {_colourToxicity =  _colour40;};
					case((_toxPercent >= 40) && (_toxPercent < 50)) :  {_colourToxicity =  _colour50;};
					case((_toxPercent >= 30) && (_toxPercent < 40)) :  {_colourToxicity =  _colour60;};
					case((_toxPercent >= 20) && (_toxPercent < 30)) :  {_colourToxicity =  _colour70;};
					case((_toxPercent >= 10) && (_toxPercent < 20)) :  {_colourToxicity =  _colour80;};
					case((_toxPercent >= 1) && (_toxPercent < 10)) :  {_colourToxicity =  _colour90;};
					case(_toxPercent < 1) : {_colourToxicity =  _colour100;};
				};
				if (_toxPercent > 80) then {
					_toxicblink = true;
				}
				else {
					_toxicblink = false;
				};
			};
			_colourStamina = _colourDefault;
			
			_bartext = switch _Ignatz_StatusbarActive do {
				case 0:{
					"";
				};
				case 1:{
					_StatusbarTxt1;
				};
				case 2:{
					_StatusbarTxt2;
				};
				case 3:{
					_StatusbarTxt3;
				};
			};
			
			_Statusbar ctrlSetStructuredText parseText format ["<t align='center'>" + _bartext + "</t>",
				count playableunits,
				_energyPercent,
				_stamina,
				_wallet,
				_damage,
				_hunger,
				_thirst,
				_temp,
				_toxPercent,
				_bloodpressure,
				format['%1/%2',_xx,_yy],
				round diag_fps,
				_hours,
				_minutes,
				'%',
				'°C',
				_colourDefault,
				_colourEnergy,
				_colourStamina,
				_colourDamage,
				_colourHunger,
				_colourThirst,
				_colourTemp,
				_colourToxicity,
				_colourBloodP
			];
		};
	}; 
};
