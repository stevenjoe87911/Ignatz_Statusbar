# Ignatz_Statusbar
This is a Player-Statusbar based on the Status Bar from Darth_Rogue with several changes.
- Only a Playerbar (no additional AdminBar)
- Added blinking for dangerous values
- Added Shortcut to change between different Statusbar sizes
- Resorted Script for easier changes
- Added GPS Icon
- Added Bloodpressure
- Removed Config (no longer needed)
- ...

Battleye Filters:<br/>
scripts.txt:<br/>
7 "BIS_fnc_dynamictext" !="_Ignatz_dyn spawn BIS_fnc_dynamicText"<br/>
7 ctrlCreate !="_display ctrlCreate [\"RscStructuredText\", 10000]"<br/>

Changelog:
- 2017-04-06
 - Updated to new Epoch custom functions
 - Resorted file structure
 - Added Restart warnings
 - Added Realtime Restart Check
