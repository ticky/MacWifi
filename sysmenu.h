/*
	2018 Anthony Super.
	System Menu INIT code based on "SysMenu" shell project by Matt Slot, circa 1995.
*/

#include <Menus.h>
#include <string>
#include "WifiShared.h"

#ifndef ____SYSMENU_HEADER____
#define ____SYSMENU_HEADER____

using namespace std;

extern "C"
{
	// * ******************************************************************************* *
	// * ******************************************************************************* *

	// Basic debugging flag that enables/disables all Debug() 
	// and DebugStr() calls embedded into the source files.
	// #define ____DEBUG____ 

	// When we install the Menu, we will try to get this MenuID. If 
	// there is already one (2 copies of INIT?), we will do our best
	// to get another (but close) ID. (See InsertMenu patch)
	#define kPrefMenuID		-19999

	// This is an icon family for the menu. Currently the value is set
	// to something guaranteed to be available (from the system file).
	// You can set it to an icon from your resfile or to 0 for no icon.
	#define kPrefIconID		129

	// * ******************************************************************************* *
	// * ******************************************************************************* *

	typedef pascal void(*InsertMenuProcPtr) (MenuHandle mHdl, short beforeID);
	typedef pascal void(*DrawMenuProcPtr) ();
	typedef pascal long(*MenuSelectProcPtr) (Point where);
	typedef pascal void(*SystemMenuProcPtr) (long result);

	typedef struct {
		InsertMenuProcPtr saveInsertMenu;
		DrawMenuProcPtr saveDrawMenuBar;
		MenuSelectProcPtr saveMenuSelect;
		SystemMenuProcPtr saveSystemMenu;

		short menuID, **sysMenus;
		MenuHandle mHdl;
		Handle menuIcon;
		FSSpec homeFile;
	} GlobalsRec;

	// * ******************************************************************************* *
	// * ******************************************************************************* *
	// Function Prototypes

	void InitSharedData();
	void SaveSharedMemoryLocation();
	short CurResFileAsFSSpec(FSSpec *fileSpec);
	ProcPtr ApplyTrapPatch(short trap, ProcPtr patchPtr);
	pascal short DetachIcons(long iconType, Handle *iconHdl, void *data);
	pascal void Patched_InsertMenu(MenuHandle menu, short beforeID);
	pascal void Patched_DrawMenuBar(void);
	pascal long Patched_MenuSelect(Point where);
	pascal void Patched_SystemMenu(long result); 
	pascal Boolean PSWDModalFilter(DialogPtr dialog, EventRecord *theEvent, short *itemHit);
	pascal Boolean SettingsModalFilter(DialogPtr dialog, EventRecord *theEvent, short *itemHit);
	void ShowConnectDialog(Network& network);
	void ShowError();
	void ShowSettings();
	void PasswordKey(TEHandle teHndl, char theKey);
	string GetWifiModeLabel(WifiMode mode);
}

#endif