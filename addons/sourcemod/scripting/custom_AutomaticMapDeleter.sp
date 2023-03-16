// List of Includes
#include <sourcemod>

// The code formatting rules we wish to follow
#pragma semicolon 1;
#pragma newdecls required;


//////////////////////////
// - Global Variables - //
//////////////////////////


public Plugin myinfo =
{
	name		= "[CS:GO] Automatic Map Deleter",
	author		= "Manifest @Road To Glory",
	description	= "Automatically removes any map, that is not listed to be used on the server.",
	version		= "V. 1.0.0 [Beta]",
	url			= ""
};



//////////////////////////
// - Forwards & Hooks - //
//////////////////////////


public void OnPluginStart()
{
	BrowseMaps();
}



///////////////////////////
// - Regular Functions - //
///////////////////////////


public void BrowseMaps()
{
	FileType filetype;

	char nameOfMap[PLATFORM_MAX_PATH];
	char nameOfFile[PLATFORM_MAX_PATH];

	Handle mapsDirectory = OpenDirectory("maps/");

	if(mapsDirectory == INVALID_HANDLE)
	{
		return;
	}

	if(mapsDirectory != INVALID_HANDLE)
	{
		// Reads the current directory entry as a local filename, then moves to the next file.
		while(ReadDirEntry(mapsDirectory, nameOfFile, sizeof(nameOfFile), filetype))
		{
			// If the filetype is a file, and not a directory, device or socket then execute this section
			if(filetype != FileType_File)
			{
				continue;
			}

			// If the name of the file does not contain .bsp 
			if(StrContains(nameOfFile, ".bsp", false) == -1)
			{
				continue;
			}

			// Sets the nameOfMap variable to be the same as the contents of nameOfFile
			nameOfMap = nameOfFile;

			// Removes the ".bsp" from our nameOfMap variable by replacing ".bsp" with nothing
			ReplaceString(nameOfMap, sizeof(nameOfMap), ".bsp", "", true);

			// If the name of the map appears inside of file containing whitelisted maps then execute this section
			if(IsMapWhitelisted(nameOfMap))
			{
				continue;
			}

			RemoveMapFiles(nameOfMap);
		}

		CloseHandle(mapsDirectory);
	}
}


public void RemoveMapFiles(const char[] mapName)
{
	char fullFileName[PLATFORM_MAX_PATH];

	Format(fullFileName, sizeof(fullFileName), "maps/%s.bsp", mapName);
	RemoveFile(fullFileName);

	Format(fullFileName, sizeof(fullFileName), "maps/%s.nav", mapName);
	RemoveFile(fullFileName);

	Format(fullFileName, sizeof(fullFileName), "maps/%s.jpg", mapName);
	RemoveFile(fullFileName);

	Format(fullFileName, sizeof(fullFileName), "maps/%s_cameras.txt", mapName);
	RemoveFile(fullFileName);

	Format(fullFileName, sizeof(fullFileName), "maps/%s_story.txt", mapName);
	RemoveFile(fullFileName);
}


public void RemoveFile(const char[] fullFileName)
{
	if(!FileExists(fullFileName))
	{
		return;
	}

	PrintToServer("[AutomaticMapDeleter]: The File: %s - has been deleted", fullFileName);

	DeleteFile(fullFileName);
}



////////////////////////////////
// - Return Based Functions - //
////////////////////////////////


public bool IsMapWhitelisted(const char[] mapName)
{
	Handle kv = CreateKeyValues("WhiteListedMaps");

	FileToKeyValues(kv, "addons/sourcemod/configs/AutomaticMapDeleter/whitelist.txt");

	if(!KvGotoFirstSubKey(kv))
	{
		return false;
	}

	do
	{
		char KeyValueMapName[PLATFORM_MAX_PATH];

		KvGetString(kv, "map", KeyValueMapName, sizeof(KeyValueMapName));

		if(StrContains(mapName, KeyValueMapName, false) != -1)
		{
			return true;
		}
	}

	while (KvGotoNextKey(kv));

	CloseHandle(kv);

	return false;
}
