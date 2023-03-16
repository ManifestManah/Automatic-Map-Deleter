# [Automatic Map Deleter]
## About
Whenever a new Steam update is pushed out, and your game server updates, you may have noticed that you have some new maps in your csgo/maps/ directory. 
In most cases your server will not be using all of these maps, and you may remove them to save some disk space on your server. But whenever a new update comes around, the same maps that you have removed previously, will get re-added. This plugin is designed to automatically remove any of the maps that you deem to be redundant and don't plan to use on your server, thereby saving you a lot of disk space, as well as time that is no longer spent removing unused content again and again.

The way this works is, that when this plugin is loaded, it will look through all of the map on your server inside of your maps folder. It will then compare the mapsto the maps inside of the whitelist.txt file located in the addons/sourcemod/configs/AutomaticMapDeleter directory. If the map's name is not mentioned within the whitelist.txt then the plugin will proceed to remove that particular map, along with all of its associated files.


## Additional Information
IMPORTANT: To avoid accidently removing any of your maps unintentionally, then make sure to configurate your addons/sourcemod/configs/AutomaticMapDeleter/whitelist.txt BEFORE loading the plugin as listed in the installation guide. Failing to do so will result in removal of any map files, that aren't listed in the whitelist.txt by default.


## Requirements
In order for the plugin to work, you must have the following installed:
- [SourceMod](https://www.sourcemod.net/downloads.php?branch=stable) 


## Installation
1) Download the contents and open the downloaded zip file.
2) Drag the addons folder in to your server's csgo directory.
3) Edit the addons/sourcemod/configs/AutomaticMapDeleter/whitelist.txt to match your preferences
4) Restart your server.


## Known Bugs & Issues
- None.


## Future development plans
- [ ] Fix any bugs/issues that gets reported.


## Bug Reports, Problems & Help
This plugin has been tested and used on a server, there should be no bugs or issues aside from the known ones found here.
Should you run in to a bug that isn't listed here, then please report it in by creating an issue here on GitHub.



# AutomaticMapDeleter
Helps reducing the amount of disk space each server requires, by automatically removing any redundant unused maps.
