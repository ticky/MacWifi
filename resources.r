#include "Retro68.r"
#include "Finder.r"
#include "MacTypes.r"
#include "Processes.r"
#include "Dialogs.r"
#include "Menus.r"
#include "Controls.r"

type 'INIT' {
	RETRO68_CODE_TYPE
};

resource 'INIT' (128, sysheap, locked, nonpurgeable) {
	dontBreakAtEntry, $$read("MacWifiINIT");
};

resource 'FREF' (128, purgeable) {
   'appe', 0, ""
};

type 'MWFI' as 'STR ';
resource 'MWFI' (0, purgeable) {
   "1.0, 2018 Anthony Super."
};

resource 'BNDL' (128, purgeable) {
   'MWFI', 0,
   {  'ICN#', {0, 128},
      'FREF', {0, 128}
   }
};

resource 'SIZE' (-1) {
	dontSaveScreen,
	acceptSuspendResumeEvents,
	enableOptionSwitch,
	canBackground,
	multiFinderAware,
	onlyBackground,
	dontGetFrontClicks,
	ignoreChildDiedEvents,
	is32BitCompatible,
	isHighLevelEventAware,
	onlyLocalHLEvents,
	notStationeryAware,
	reserved,
	reserved,
	reserved,
	reserved,
	1000 * 1024,
	1000 * 1024
};

resource 'DLOG' (128, purgeable) {
	{ 0, 0, 149, 377 },
	dBoxProc,
	visible,
	goAway,
	0,
	128,
	"",
	alertPositionMainScreen
};

data 'dctb' (128, purgeable) {
   $"0000 0000 0000 FFFF"
};

resource 'DITL' (128, purgeable) {
	{
		{ 12, 24, 44, 56 },
		Icon { enabled, 262 };

		{ 12, 80, 46, 350 },
		StaticText { enabled, "The wifi network \"^0\" requires a ^1 password." };

		{ 60, 80, 80, 160 },
		StaticText { enabled, "Password:" };

		{ 56, 162, 72, 350 },
		EditText { enabled, "" };

		{ 79, 157, 97, 350 },
		CheckBox { enabled, "Show password" };

		{ 114, 224, 134, 291 },
		Button { enabled, "Cancel" };

		{ 114, 306, 134, 362 },
		Button { enabled, "Join" };
	}
};

resource 'ALRT' (129, purgeable ) {
   { 0, 0, 110, 400 },
   129,
   {
      OK, visible, silent,
      OK, visible, silent,
      OK, visible, silent,
      OK, visible, silent
   },
   alertPositionMainScreen
};

resource 'DITL' (129, purgeable) {
	{
		{ 76, 300, 76+20, 380 },
		Button { enabled, "OK" };

		{8, 72, 70, 380},
		StaticText { disabled, "^0" };
	}
};

resource 'DLOG' (130, purgeable) {
	{ 0, 0, 249, 377 },
	dBoxProc,
	visible,
	goAway,
	0,
	130,
	"",
	alertPositionMainScreen
};

data 'dctb' (130, purgeable) {
   $"0000 0000 0000 FFFF"
};

resource 'MENU' (130) {
    130, textMenuProc;
    allEnabled, enabled;
    "Wifi Module";
    {
        "Vonets", noIcon, noKey, noMark, plain;
        "OpenWRT", noIcon, noKey, noMark, plain;
    }
};

resource 'CNTL' (130) {
    { 36, 162, 52, 350 },
    0,
    visible,
    0,
    130,
    1008,
    0,
    "Wifi Module"
};

resource 'DITL' (130, purgeable) {
	{
		{ 12, 24, 44, 56 },
		Icon { enabled, 262 };

		{ 12, 80, 26, 350 },
		StaticText { enabled, "Wifi Settings" };

		{ 40, 80, 56, 160 },
		StaticText { enabled, "Device:" };
		
		{ 40, 162, 56, 350 },
		Control { enabled, 130 };

		{ 70, 80, 90, 160 },
		StaticText { enabled, "Hostname:" };

		{ 66, 162, 82, 350 },
		EditText { enabled, "" };

		{ 100, 80, 110, 160 },
		StaticText { enabled, "Username:" };

		{ 96, 162, 112, 350 },
		EditText { enabled, "" };

		{ 130, 80, 140, 160 },
		StaticText { enabled, "Password:" };

		{ 126, 162, 142, 350 },
		EditText { enabled, "" };

		{ 180, 224, 200, 291 },
		Button { enabled, "Cancel" };

		{ 180, 306, 200, 362 },
		Button { enabled, "OK" };
	}
};

data 'ICN#' (128) {
	$"7FFF FFF0 8000 0008 8000 0008 8000 0008"            /* ....�...�...�... */
	$"8000 0008 8000 0008 8000 0008 8000 0008"            /* �...�...�...�... */
	$"A000 0008 D000 000A 9000 000D 1007 E009"            /* �...�...�..�...� */
	$"101F F801 107C 3E01 10F0 0F01 1043 C201"            /* .....|>......C�. */
	$"100F F001 101E 7801 1008 1001 1001 8001"            /* ......x.......�. */
	$"1003 C009 9001 800D D000 000A A000 0008"            /* ..�Ɛ.���...�... */
	$"8000 0008 8000 0008 8000 0008 8000 0008"            /* �...�...�...�... */
	$"8000 0008 8000 0008 8000 0008 7FFF FFF0"            /* �...�...�....... */
	$"7FFF FFF0 FFFF FFF8 FFFF FFF8 FFFF FFF8"            /* ................ */
	$"FFFF FFF8 FFFF FFF8 FFFF FFF8 FFFF FFF8"            /* ................ */
	$"FFFF FFF8 DFFF FFFA 9FFF FFFF 1FFF FFFF"            /* ........�....... */
	$"1FFF FFFF 1FFF FFFF 1FFF FFFF 1FFF FFFF"            /* ................ */
	$"1FFF FFFF 1FFF FFFF 1FFF FFFF 1FFF FFFF"            /* ................ */
	$"1FFF FFFF 9FFF FFFF DFFF FFFA FFFF FFF8"            /* ....�........... */
	$"FFFF FFF8 FFFF FFF8 FFFF FFF8 FFFF FFF8"            /* ................ */
	$"FFFF FFF8 FFFF FFF8 FFFF FFF8 7FFF FFF0"            /* ................ */
};

data 'ics#' (128) {
	$"FFFE 8002 8002 8002 83C2 CFF3 5C39 5BD9"            /* ..�.�.�.���.\9[. */
	$"47E1 4661 C183 8182 8002 8002 8002 FFFE"            /* G.Fa�����.�.�... */
	$"FFFE FFFE FFFE FFFE FFFE FFFF 7FFF 7FFF"            /* ................ */
	$"7FFF 7FFF FFFF FFFE FFFE FFFE FFFE FFFE"            /* ................ */
};

data 'icl8' (128) {
	$"00FF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"            /* ................ */
	$"FFFF FFFF FFFF FFFF FFFF FFFF 0000 0000"            /* ................ */
	$"FF00 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 00F6 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F7F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 FFF7 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FFFF 00FF 00F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 FF00"            /* ................ */
	$"FF00 00FF 00F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FFFF 00FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F6F6 F6F6 F6FF FFFF"            /* ................ */
	$"FFFF FFF6 F6F6 F6F6 F6F6 F6F7 FF00 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F6F6 F6FF FFFF FFFF"            /* ................ */
	$"FFFF FFFF FFF6 F6F6 F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F6FF FFFF FFFF F7F7"            /* ................ */
	$"F7F7 FFFF FFFF FFF6 F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 FFFF FFFF F7F7 F6F6"            /* ................ */
	$"F6F6 F7F7 FFFF FFFF F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F7FF F7F7 F6F6 FFFF"            /* ................ */
	$"FFFF F6F6 F7F7 FFF7 F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F6F7 F6F6 FFFF FFFF"            /* ................ */
	$"FFFF FFFF F6F6 F7F6 F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F6F6 F6FF FFFF FFF7"            /* ................ */
	$"F7FF FFFF FFF6 F6F6 F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F6F6 F6F7 FFF7 F7F6"            /* ................ */
	$"F6F7 F7FF F7F6 F6F6 F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F6F6 F6F6 F7F6 F6FF"            /* ................ */
	$"FFF6 F6F7 F6F6 F6F6 F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"0000 00FF 00F6 F6F6 F6F6 F6F6 F6F6 FFFF"            /* ................ */
	$"FFFF F6F6 F6F6 F6F6 F6F6 F6F7 FFF7 F7FF"            /* ................ */
	$"FF00 00FF 00F6 F6F6 F6F6 F6F6 F6F6 F7FF"            /* ................ */
	$"FFF7 F6F6 F6F6 F6F6 F6F6 F6F7 FFFF F7FF"            /* ................ */
	$"FFFF 00FF 00F6 F6F6 F6F6 F6F6 F6F6 F6F7"            /* ................ */
	$"F7F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 FF00"            /* ................ */
	$"FF00 FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 00F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6 F6F6"            /* ................ */
	$"F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00 0000"            /* ................ */
	$"FFF6 F7F7 F7F7 F7F7 F7F7 F7F7 F7F7 F7F7"            /* ................ */
	$"F7F7 F7F7 F7F7 F7F7 F7F7 F7F7 FF00 0000"            /* ................ */
	$"00FF FFFF FFFF FFFF FFFF FFFF FFFF FFFF"            /* ................ */
	$"FFFF FFFF FFFF FFFF FFFF FFFF 0000 0000"            /* ................ */
};

data 'ics8' (128) {
	$"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FF00"            /* ................ */
	$"FF00 0000 0000 0000 0000 0000 0000 FF00"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00"            /* ................ */
	$"FF00 F6F6 F6F6 FFFF FFFF F6F6 F6F7 FF00"            /* ................ */
	$"FFFF 00F6 FFFF FFFF FFFF FFFF F6F7 FFFF"            /* ................ */
	$"00FF 00FF FFFF F6F6 F6F6 FFFF FFF6 F7FF"            /* ................ */
	$"00FF 00FF FFF6 FFFF FFFF F6FF FFF6 F7FF"            /* ................ */
	$"00FF 00F6 F6FF FFFF FFFF FFF6 F6F6 F7FF"            /* ................ */
	$"00FF 00F6 F6FF FFF6 F6FF FFF6 F6F6 F7FF"            /* ................ */
	$"FFFF 00F6 F6F6 F6FF FFF6 F6F6 F6F7 FFFF"            /* ................ */
	$"FF00 F6F6 F6F6 F6FF FFF6 F6F6 F6F7 FF00"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00"            /* ................ */
	$"FF00 F6F6 F6F6 F6F6 F6F6 F6F6 F6F7 FF00"            /* ................ */
	$"FFF6 F7F7 F7F7 F7F7 F7F7 F7F7 F7F7 FF00"            /* ................ */
	$"FFFF FFFF FFFF FFFF FFFF FFFF FFFF FF00"            /* ................ */
};

data 'ics4' (128) {
	$"0FFF FFFF FFFF FF00 F000 0000 0000 00F0"            /* ................ */
	$"F0CC CCCC CCCC CDF0 F0CC CCCC CCCC CDF0"            /* .������..������. */
	$"F0CC CCFF FFCC CDF0 0F0C FFFF FFFF CDFF"            /* .��..��.......�. */
	$"0F0F FFCC CCFF FCDF 0F0F FCFF FFCF FCDF"            /* ...��........�.. */
	$"0F0C CFFF FFFC CCDF 0F0C CFFC CFFC CCDF"            /* ..�...�...�.�.�. */
	$"0F0C CCCF FCCC CDFF F0CC CCCF FCCC CDF0"            /* ..��.��..���.��. */
	$"F0CC CCCC CCCC CDF0 F0CC CCCC CCCC CDF0"            /* .������..������. */
	$"F0DD DDDD DDDD DDF0 0FFF FFFF FFFF FF00"            /* ................ */
};

data 'icl4' (128) {
	$"0FFF FFFF FFFF FFFF FFFF FFFF FFFF 0000"            /* ................ */
	$"F000 0000 0000 0000 0000 0000 000C F000"            /* ................ */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0FC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* ..������������.. */
	$"FF0F CCCC CCCC CCCC CCCC CCCC CCCD F0F0"            /* ..������������.. */
	$"F00F 0CCC CCCC CCCC CCCC CCCC CCCD FFCF"            /* ...�����������.� */
	$"000F 0CCC CCCC CFFF FFFC CCCC CCCD FCDF"            /* ...����...����.. */
	$"000F 0CCC CCCF FFFF FFFF FCCC CCCC CCDF"            /* ...���.....����. */
	$"000F 0CCC CFFF FFDD DDFF FFFC CCCC CCDF"            /* ...��.......���. */
	$"000F 0CCC FFFF DDCC CCDD FFFF CCCC CCDF"            /* ...�...��...���. */
	$"000F 0CCC DFDD CCFF FFCC DDFD CCCC CCDF"            /* ...�..�..�..���. */
	$"000F 0CCC CDCC FFFF FFFF CCDC CCCC CCDF"            /* ...���....�.���. */
	$"000F 0CCC CCCF FFFD DFFF FCCC CCCC CCDF"            /* ...���.....����. */
	$"000F 0CCC CCCD FDDC CDDF DCCC CCCC CCDF"            /* ...���..�..����. */
	$"000F 0CCC CCCC DCCF FCCD CCCC CCCC DCDF"            /* ...���.�.�����.. */
	$"000F 0CCC CCCC CCFF FFCC CCCC CCCD FDDF"            /* ...����..�����.. */
	$"F00F 0CCC CCCC CCDF FDCC CCCC CCCD FFDF"            /* ...����..�����.. */
	$"FF0F 0CCC CCCC CCCD DCCC CCCC CCCD F0F0"            /* ...�����.�����.. */
	$"F0F0 CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* ..������������.. */
	$"F00C CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* ..������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"F0CC CCCC CCCC CCCC CCCC CCCC CCCD F000"            /* .�������������.. */
	$"FCDD DDDD DDDD DDDD DDDD DDDD DDDD F000"            /* ................ */
	$"0FFF FFFF FFFF FFFF FFFF FFFF FFFF 0000"            /* ................ */
};

data 'cicn' (257, purgeable) {
	$"0000 0000 8002 0000 0000 0010 0010 0000"            /* ....�........... */
	$"0000 0000 0000 0048 0000 0048 0000 0000"            /* .......H...H.... */
	$"0001 0001 0001 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0002 0000 0000 0010 0010"            /* ................ */
	$"0000 0000 0002 0000 0000 0010 0010 0000"            /* ................ */
	$"0000 0000 0000 07C0 1FF0 7C7C F01E 4384"            /* .......�..||..C� */
	$"0FE0 1EF0 0820 0100 0380 0100 0000 0000"            /* ..... ...�...... */
	$"0000 0000 0000 07C0 1FF0 7C7C F01E 4384"            /* .......�..||..C� */
	$"0FE0 1EF0 0820 0100 0380 0100 0000 0000"            /* ..... ...�...... */
	$"0000 0000 0000 0000 0001 0000 FFFF FFFF"            /* ................ */
	$"FFFF 0001 4444 4444 4444 0000 0000 07C0"            /* ....DDDDDD.....� */
	$"1FF0 7C7C F01E 4384 0FE0 1EF0 0820 0100"            /* ..||..C�..... .. */
	$"0380 0100 0000 0000 0000"                           /* .�........ */
};

data 'cicn' (258, purgeable) {
	$"0000 0000 8004 0000 0000 0010 0010 0000"            /* ....�........... */
	$"0000 0000 0000 0048 0000 0048 0000 0000"            /* .......H...H.... */
	$"0002 0001 0002 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0002 0000 0000 0010 0010"            /* ................ */
	$"0000 0000 0002 0000 0000 0010 0010 0000"            /* ................ */
	$"0000 0000 0000 07C0 1FF0 7C7C F01E 4384"            /* .......�..||..C� */
	$"0FE0 1EF0 0820 0100 0380 0100 0000 0000"            /* ..... ...�...... */
	$"0000 0000 0000 0540 0AA0 5454 A00A 4384"            /* .......@.�TT�.C� */
	$"0FE0 1EF0 0820 0100 0380 0100 0000 0000"            /* ..... ...�...... */
	$"0000 0000 0000 0000 0002 0000 FFFF FFFF"            /* ................ */
	$"FFFF 0001 BBBB BBBB BBBB 0002 4444 4444"            /* ....������..DDDD */
	$"4444 0000 0000 0000 0000 0015 5000 0155"            /* DD..........P..U */
	$"5500 1550 1550 5500 0154 100A 8010 00AA"            /* U..P.PU..T..�..� */
	$"A800 02A8 AA00 0080 0800 0002 0000 000A"            /* �..��..�........ */
	$"8000 0002 0000 0000 0000 0000 0000 0000"            /* �............... */
	$"0000"                                               /* .. */
};

data 'cicn' (259, purgeable) {
	$"0000 0000 8004 0000 0000 0010 0010 0000"            /* ....�........... */
	$"0000 0000 0000 0048 0000 0048 0000 0000"            /* .......H...H.... */
	$"0002 0001 0002 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0002 0000 0000 0010 0010"            /* ................ */
	$"0000 0000 0002 0000 0000 0010 0010 0000"            /* ................ */
	$"0000 0000 0000 07C0 1FF0 7C7C F01E 4384"            /* .......�..||..C� */
	$"0FE0 1EF0 0820 0100 0380 0100 0000 0000"            /* ..... ...�...... */
	$"0000 0000 0000 0540 0AA0 5454 A00A 4104"            /* .......@.�TT�.A. */
	$"0AA0 1450 0820 0100 0380 0100 0000 0000"            /* .�.P. ...�...... */
	$"0000 0000 0000 0000 0002 0000 FFFF FFFF"            /* ................ */
	$"FFFF 0001 BBBB BBBB BBBB 0002 4444 4444"            /* ....������..DDDD */
	$"4444 0000 0000 0000 0000 0015 5000 0155"            /* DD..........P..U */
	$"5500 1550 1550 5500 0154 1005 4010 0055"            /* U..P.PU..T..@..U */
	$"5400 0154 5500 0040 0400 0002 0000 000A"            /* T..TU..@........ */
	$"8000 0002 0000 0000 0000 0000 0000 0000"            /* �............... */
	$"0000"                                               /* .. */
};

data 'cicn' (260, purgeable) {
	$"0000 0000 8002 0000 0000 0010 0010 0000"            /* ....�........... */
	$"0000 0000 0000 0048 0000 0048 0000 0000"            /* .......H...H.... */
	$"0001 0001 0001 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0002 0000 0000 0010 0010"            /* ................ */
	$"0000 0000 0002 0000 0000 0010 0010 0000"            /* ................ */
	$"0000 0000 0000 07C0 1FF0 7C7C F01E 4384"            /* .......�..||..C� */
	$"0FE0 1EF0 0820 0100 0380 0100 0000 0000"            /* ..... ...�...... */
	$"0000 0000 0000 0540 0AA0 5454 A00A 4104"            /* .......@.�TT�.A. */
	$"0AA0 1450 0820 0100 0280 0100 0000 0000"            /* .�.P. ...�...... */
	$"0000 0000 0000 0000 0001 0000 FFFF FFFF"            /* ................ */
	$"FFFF 0001 BBBB BBBB BBBB 0000 0000 07C0"            /* ....������.....� */
	$"1FF0 7C7C F01E 4384 0FE0 1EF0 0820 0100"            /* ..||..C�..... .. */
	$"0380 0100 0000 0000 0000"                           /* .�........ */
};

data 'cicn' (261) {
	$"0000 0000 8004 0000 0000 0010 0010 0000"            /* ....�........... */
	$"0000 0000 0000 0048 0000 0048 0000 0000"            /* .......H...H.... */
	$"0002 0001 0002 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0002 0000 0000 0010 0010"            /* ................ */
	$"0000 0000 0002 0000 0000 0010 0010 0000"            /* ................ */
	$"0000 0180 03C0 03C0 07E0 07E0 0FF0 0FF0"            /* ...�.�.�........ */
	$"1FF8 1FF8 3FFC 3FFC 7FFE 7FFE FFFF FFFF"            /* ....?.?......... */
	$"FFFF 0180 03C0 0240 0660 0420 0DB0 0990"            /* ...�.�.@.`. °Ɛ */
	$"1998 1188 318C 2184 6006 4182 C183 8001"            /* .�.�1�!�`.A����. */
	$"FFFF 0000 0000 0000 0002 0000 FFFF FFFF"            /* ................ */
	$"FFFF 0001 DDDD DDDD DDDD 0002 4444 4444"            /* ............DDDD */
	$"4444 0002 8000 000A A000 0009 6000 0029"            /* DD..�...�..�`..) */
	$"6800 0025 5800 00A6 9A00 0096 9600 0296"            /* h..%X..��..��..� */
	$"9680 0256 9580 0A56 95A0 0956 9560 2955"            /* ��.V��.V���V�`)U */
	$"5568 2556 9558 A556 955A 9555 5556 AAAA"            /* Uh%V�X�V�Z�UUV�� */
	$"AAAA"                                               /* �� */
};

data 'cicn' (262, purgeable) {
	$"0000 0000 8004 0000 0000 0020 0020 0000"            /* ....�...... . .. */
	$"0000 0000 0000 0048 0000 0048 0000 0000"            /* .......H...H.... */
	$"0001 0001 0001 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0004 0000 0000 0020 0020"            /* ............. .  */
	$"0000 0000 0004 0000 0000 0020 0020 0000"            /* ........... . .. */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 001F F800 00FF FF00 03FF FFC0 0FFF"            /* .............�.. */
	$"FFF0 3FF8 1FFC 7FC0 03FE FE00 007F FC00"            /* ..?....�........ */
	$"003F 7007 E00E 203F FC04 00FF FF00 01FF"            /* .?p... ?........ */
	$"FF80 03FF FFC0 03F0 0FC0 01C0 0380 0080"            /* .�...�...�.�.�.� */
	$"0100 0000 0000 0007 E000 000F F000 000F"            /* ................ */
	$"F000 0007 E000 0003 C000 0001 8000 0000"            /* ........�...�... */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 001F F800 00FF FF00 03FF FFC0 0FFF"            /* .............�.. */
	$"FFF0 3FF8 1FFC 7FC0 03FE FE00 007F FC00"            /* ..?....�........ */
	$"003F 7007 E00E 203F FC04 00FF FF00 01FF"            /* .?p... ?........ */
	$"FF80 03FF FFC0 03F0 0FC0 01C0 0380 0080"            /* .�...�...�.�.�.� */
	$"0100 0000 0000 0007 E000 000F F000 000F"            /* ................ */
	$"F000 0007 E000 0003 C000 0001 8000 0000"            /* ........�...�... */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0001 0000 FFFF FFFF"            /* ................ */
	$"FFFF 0001 3333 9999 FFFF 0000 0000 0000"            /* ....33��........ */
	$"0000 0000 0000 0000 0000 001F F800 00FF"            /* ................ */
	$"FF00 03FF FFC0 0FFF FFF0 3FF8 1FFC 7FC0"            /* .....�....?....� */
	$"03FE FE00 007F FC00 003F 7007 E00E 203F"            /* .........?p... ? */
	$"FC04 00FF FF00 01FF FF80 03FF FFC0 03F0"            /* .........�...�.. */
	$"0FC0 01C0 0380 0080 0100 0000 0000 0007"            /* .�.�.�.�........ */
	$"E000 000F F000 000F F000 0007 E000 0003"            /* ................ */
	$"C000 0001 8000 0000 0000 0000 0000 0000"            /* �...�........... */
	$"0000 0000 0000 0000 0000"                           /* .......... */
};

data 'ics8' (129) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 00FC FCFC FCFC 0000 0000 0000"            /* ................ */
	$"0000 00FC FCFC FCFC FCFC FCFC 0000 0000"            /* ................ */
	$"00FC FCFC FCFC 0000 00FC FCFC FCFC 0000"            /* ................ */
	$"FCFC FCFC 0000 0000 0000 00FC FCFC FC00"            /* ................ */
	$"00FC 0000 0000 FCFC FC00 0000 00FC 0000"            /* ................ */
	$"0000 0000 FCFC FCFC FCFC FC00 0000 0000"            /* ................ */
	$"0000 00FC FCFC FC00 FCFC FCFC 0000 0000"            /* ................ */
	$"0000 0000 FC00 0000 0000 FC00 0000 0000"            /* ................ */
	$"0000 0000 0000 00FC 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 FCFC FC00 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 00FC 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
};

data 'ics#' (129) {
	$"0000 0000 07C0 1FF0 7C7C F01E 4384 0FE0"            /* .....�..||..C�.. */
	$"1EF0 0820 0100 0380 0100 0000 0000 0000"            /* ... ...�........ */
	$"0000 0000 07C0 1FF0 7C7C F01E 4384 0FE0"            /* .....�..||..C�.. */
	$"1EF0 0820 0100 0380 0100 0000 0000 0000"            /* ... ...�........ */
};

data 'ics4' (129) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0EEE EE00 0000 000E EEEE EEEE 0000"            /* ................ */
	$"0EEE EE00 0EEE EE00 EEEE 0000 000E EEE0"            /* ................ */
	$"0E00 00EE E000 0E00 0000 EEEE EEE0 0000"            /* ................ */
	$"000E EEE0 EEEE 0000 0000 E000 00E0 0000"            /* ................ */
	$"0000 000E 0000 0000 0000 00EE E000 0000"            /* ................ */
	$"0000 000E 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
};