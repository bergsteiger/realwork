{ ********************************************************************* }
{ *                  Microsoft Windows                               ** }
{ *            Copyright(c) Microsoft Corp., 1996-1998               ** }
{ *                                                                  ** }
{ *     Translator: Embarcadero Technologies, Inc.                   ** }
{ *     Copyright(c) 2016 Embarcadero Technologies, Inc.             ** }
{ *                  All rights reserved                             ** }
{ ********************************************************************* }
unit mshtmcid;

interface

uses Winapi.Windows;

{ +--------------------------------------------------------------------------- }

{  Microsoft Windows }
{  Copyright (C) Microsoft Corporation.  All Rights Reserved. }

{  File:       mshtmcid.h }

{ ---------------------------------------------------------------------------- }
{ MSHTML Command IDs }
{ ---------------------------------------------------------------------------- }

const
  IDM_UNKNOWN                     = 0;
  IDM_ALIGNBOTTOM                 = 1;
  IDM_ALIGNHORIZONTALCENTERS      = 2;
  IDM_ALIGNLEFT                   = 3;
  IDM_ALIGNRIGHT                  = 4;
  IDM_ALIGNTOGRID                 = 5;
  IDM_ALIGNTOP                    = 6;
  IDM_ALIGNVERTICALCENTERS        = 7;
  IDM_ARRANGEBOTTOM               = 8;
  IDM_ARRANGERIGHT                = 9;
  IDM_BRINGFORWARD                = 10;
  IDM_BRINGTOFRONT                = 11;
  IDM_CENTERHORIZONTALLY          = 12;
  IDM_CENTERVERTICALLY            = 13;
  IDM_CODE                        = 14;
  IDM_DELETE                      = 17;
  IDM_FONTNAME                    = 18;
  IDM_FONTSIZE                    = 19;
  IDM_GROUP                       = 20;
  IDM_HORIZSPACECONCATENATE       = 21;
  IDM_HORIZSPACEDECREASE          = 22;
  IDM_HORIZSPACEINCREASE          = 23;
  IDM_HORIZSPACEMAKEEQUAL         = 24;
  IDM_INSERTOBJECT                = 25;
  IDM_MULTILEVELREDO              = 30;
  IDM_SENDBACKWARD                = 32;
  IDM_SENDTOBACK                  = 33;
  IDM_SHOWTABLE                   = 34;
  IDM_SIZETOCONTROL               = 35;
  IDM_SIZETOCONTROLHEIGHT         = 36;
  IDM_SIZETOCONTROLWIDTH          = 37;
  IDM_SIZETOFIT                   = 38;
  IDM_SIZETOGRID                  = 39;
  IDM_SNAPTOGRID                  = 40;
  IDM_TABORDER                    = 41;
  IDM_TOOLBOX                     = 42;
  IDM_MULTILEVELUNDO              = 44;
  IDM_UNGROUP                     = 45;
  IDM_VERTSPACECONCATENATE        = 46;
  IDM_VERTSPACEDECREASE           = 47;
  IDM_VERTSPACEINCREASE           = 48;
  IDM_VERTSPACEMAKEEQUAL          = 49;
  IDM_JUSTIFYFULL                 = 50;
  IDM_BACKCOLOR                   = 51;
  IDM_BOLD                        = 52;
  IDM_BORDERCOLOR                 = 53;
  IDM_FLAT                        = 54;
  IDM_FORECOLOR                   = 55;
  IDM_ITALIC                      = 56;
  IDM_JUSTIFYCENTER               = 57;
  IDM_JUSTIFYGENERAL              = 58;
  IDM_JUSTIFYLEFT                 = 59;
  IDM_JUSTIFYRIGHT                = 60;
  IDM_RAISED                      = 61;
  IDM_SUNKEN                      = 62;
  IDM_UNDERLINE                   = 63;
  IDM_CHISELED                    = 64;
  IDM_ETCHED                      = 65;
  IDM_SHADOWED                    = 66;
  IDM_FIND                        = 67;
  IDM_SHOWGRID                    = 69;
  IDM_OBJECTVERBLIST0             = 72;
  IDM_OBJECTVERBLIST1             = 73;
  IDM_OBJECTVERBLIST2             = 74;
  IDM_OBJECTVERBLIST3             = 75;
  IDM_OBJECTVERBLIST4             = 76;
  IDM_OBJECTVERBLIST5             = 77;
  IDM_OBJECTVERBLIST6             = 78;
  IDM_OBJECTVERBLIST7             = 79;
  IDM_OBJECTVERBLIST8             = 80;
  IDM_OBJECTVERBLIST9             = 81;
  IDM_OBJECTVERBLISTLAST     = IDM_OBJECTVERBLIST9;
  IDM_CONVERTOBJECT               = 82;
  IDM_CUSTOMCONTROL               = 83;
  IDM_CUSTOMIZEITEM               = 84;
  IDM_RENAME                      = 85;
  IDM_IMPORT                      = 86;
  IDM_NEWPAGE                     = 87;
  IDM_MOVE                        = 88;
  IDM_CANCEL                      = 89;
  IDM_FONT                        = 90;
  IDM_STRIKETHROUGH               = 91;
  IDM_DELETEWORD                  = 92;
  IDM_EXECPRINT                   = 93;
  IDM_JUSTIFYNONE                 = 94;
  IDM_TRISTATEBOLD = 95; 
  IDM_TRISTATEITALIC = 96; 
  IDM_TRISTATEUNDERLINE = 97; 

  IDM_FOLLOW_ANCHOR               = 2008;

  IDM_INSINPUTIMAGE               = 2114;
  IDM_INSINPUTBUTTON              = 2115;
  IDM_INSINPUTRESET               = 2116;
  IDM_INSINPUTSUBMIT              = 2117;
  IDM_INSINPUTUPLOAD              = 2118;
  IDM_INSFIELDSET                 = 2119;

  IDM_PASTEINSERT                 = 2120;
  IDM_REPLACE                     = 2121;
  IDM_EDITSOURCE                  = 2122;
  IDM_BOOKMARK                    = 2123;
  IDM_HYPERLINK                   = 2124;
  IDM_UNLINK                      = 2125;
  IDM_BROWSEMODE                  = 2126;
  IDM_EDITMODE                    = 2127;
  IDM_UNBOOKMARK                  = 2128;

  IDM_TOOLBARS                    = 2130;
  IDM_STATUSBAR                   = 2131;
  IDM_FORMATMARK                  = 2132;
  IDM_TEXTONLY                    = 2133;
  IDM_OPTIONS                     = 2135;
  IDM_FOLLOWLINKC                 = 2136;
  IDM_FOLLOWLINKN                 = 2137;
  IDM_VIEWSOURCE                  = 2139;
  IDM_ZOOMPOPUP                   = 2140;

{ IDM_BASELINEFONT1, IDM_BASELINEFONT2, IDM_BASELINEFONT3, IDM_BASELINEFONT4, }
{ and IDM_BASELINEFONT5 should be consecutive integers; }

  IDM_BASELINEFONT1               = 2141;
  IDM_BASELINEFONT2               = 2142;
  IDM_BASELINEFONT3               = 2143;
  IDM_BASELINEFONT4               = 2144;
  IDM_BASELINEFONT5               = 2145;

  IDM_HORIZONTALLINE              = 2150;
  IDM_LINEBREAKNORMAL             = 2151;
  IDM_LINEBREAKLEFT               = 2152;
  IDM_LINEBREAKRIGHT              = 2153;
  IDM_LINEBREAKBOTH               = 2154;
  IDM_NONBREAK                    = 2155;
  IDM_SPECIALCHAR                 = 2156;
  IDM_HTMLSOURCE                  = 2157;
  IDM_IFRAME                      = 2158;
  IDM_HTMLCONTAIN                 = 2159;
  IDM_TEXTBOX                     = 2161;
  IDM_TEXTAREA                    = 2162;
  IDM_CHECKBOX                    = 2163;
  IDM_RADIOBUTTON                 = 2164;
  IDM_DROPDOWNBOX                 = 2165;
  IDM_LISTBOX                     = 2166;
  IDM_BUTTON                      = 2167;
  IDM_IMAGE                       = 2168;
  IDM_OBJECT                      = 2169;
  IDM_1D                          = 2170;
  IDM_IMAGEMAP                    = 2171;
  IDM_FILE                        = 2172;
  IDM_COMMENT                     = 2173;
  IDM_SCRIPT                      = 2174;
  IDM_JAVAAPPLET                  = 2175;
  IDM_PLUGIN                      = 2176;
  IDM_PAGEBREAK                   = 2177;
  IDM_HTMLAREA                    = 2178;

  IDM_PARAGRAPH                   = 2180;
  IDM_FORM                        = 2181;
  IDM_MARQUEE                     = 2182;
  IDM_LIST                        = 2183;
  IDM_ORDERLIST                   = 2184;
  IDM_UNORDERLIST                 = 2185;
  IDM_INDENT                      = 2186;
  IDM_OUTDENT                     = 2187;
  IDM_PREFORMATTED                = 2188;
  IDM_ADDRESS                     = 2189;
  IDM_BLINK                       = 2190;
  IDM_DIV                         = 2191;

  IDM_TABLEINSERT                 = 2200;
  IDM_RCINSERT                    = 2201;
  IDM_CELLINSERT                  = 2202;
  IDM_CAPTIONINSERT               = 2203;
  IDM_CELLMERGE                   = 2204;
  IDM_CELLSPLIT                   = 2205;
  IDM_CELLSELECT                  = 2206;
  IDM_ROWSELECT                   = 2207;
  IDM_COLUMNSELECT                = 2208;
  IDM_TABLESELECT                 = 2209;
  IDM_TABLEPROPERTIES             = 2210;
  IDM_CELLPROPERTIES              = 2211;
  IDM_ROWINSERT                   = 2212;
  IDM_COLUMNINSERT                = 2213;

  IDM_HELP_CONTENT                = 2220;
  IDM_HELP_ABOUT                  = 2221;
  IDM_HELP_README                 = 2222;

  IDM_REMOVEFORMAT                = 2230;
  IDM_PAGEINFO                    = 2231;
  IDM_TELETYPE                    = 2232;
  IDM_GETBLOCKFMTS                = 2233;
  IDM_BLOCKFMT                    = 2234;
  IDM_SHOWHIDE_CODE               = 2235;
  IDM_TABLE                       = 2236;

  IDM_COPYFORMAT                  = 2237;
  IDM_PASTEFORMAT                 = 2238;
  IDM_GOTO                        = 2239;

  IDM_CHANGEFONT                  = 2240;
  IDM_CHANGEFONTSIZE              = 2241;
  IDM_CHANGECASE                  = 2246;
  IDM_SHOWSPECIALCHAR = 2249; 

  IDM_SUBSCRIPT                   = 2247;
  IDM_SUPERSCRIPT                 = 2248;

  IDM_CENTERALIGNPARA             = 2250;
  IDM_LEFTALIGNPARA               = 2251;
  IDM_RIGHTALIGNPARA              = 2252;
  IDM_REMOVEPARAFORMAT            = 2253;
  IDM_APPLYNORMAL                 = 2254;
  IDM_APPLYHEADING1               = 2255;
  IDM_APPLYHEADING2               = 2256;
  IDM_APPLYHEADING3               = 2257;

  IDM_DOCPROPERTIES               = 2260;
  IDM_ADDFAVORITES                = 2261;
  IDM_COPYSHORTCUT                = 2262;
  IDM_SAVEBACKGROUND              = 2263;
  IDM_SETWALLPAPER                = 2264;
  IDM_COPYBACKGROUND              = 2265;
  IDM_CREATESHORTCUT              = 2266;
  IDM_PAGE                        = 2267;
  IDM_SAVETARGET                  = 2268;
  IDM_SHOWPICTURE                 = 2269;
  IDM_SAVEPICTURE                 = 2270;
  IDM_DYNSRCPLAY                  = 2271;
  IDM_DYNSRCSTOP                  = 2272;
  IDM_PRINTTARGET                 = 2273;
  IDM_IMGARTPLAY                  = 2274;  { no longer in use }
  IDM_IMGARTSTOP                  = 2275;  { no longer in use }
  IDM_IMGARTREWIND                = 2276;  { no longer in use }
  IDM_PRINTQUERYJOBSPENDING       = 2277;
  IDM_SETDESKTOPITEM              = 2278;

  IDM_CONTEXTMENU                 = 2280;
  IDM_GOBACKWARD                  = 2282;
  IDM_GOFORWARD                   = 2283;
  IDM_PRESTOP                     = 2284;

{ ;begin_internal }
  IDM_GOTOCLIPBOARDADDRESS        = 2285;
  IDM_GOTOCLIPBOARDTEXT           = 2286;
{ ;end_internal }

  IDM_MP_MYPICS                   = 2287; 
  IDM_MP_EMAILPICTURE             = 2288; 
  IDM_MP_PRINTPICTURE             = 2289; 

  IDM_CREATELINK                  = 2290;
  IDM_COPYCONTENT                 = 2291;

  IDM_LANGUAGE                    = 2292;

  IDM_GETPRINTTEMPLATE            = 2295; 
  IDM_SETPRINTTEMPLATE            = 2296; 
  IDM_TEMPLATE_PAGESETUP          = 2298; 

  IDM_REFRESH                     = 2300;
  IDM_STOPDOWNLOAD                = 2301;

  IDM_ENABLE_INTERACTION          = 2302;

  IDM_LAUNCHDEBUGGER              = 2310;
  IDM_BREAKATNEXT                 = 2311;

  IDM_INSINPUTHIDDEN              = 2312;
  IDM_INSINPUTPASSWORD            = 2313;

  IDM_OVERWRITE                   = 2314;

  IDM_PARSECOMPLETE               = 2315;

  IDM_HTMLEDITMODE                = 2316;

  IDM_REGISTRYREFRESH             = 2317;
  IDM_COMPOSESETTINGS             = 2318;

  IDM_SHOWALLTAGS = 2327; 
  IDM_SHOWALIGNEDSITETAGS         = 2321;
  IDM_SHOWSCRIPTTAGS              = 2322;
  IDM_SHOWSTYLETAGS               = 2323;
  IDM_SHOWCOMMENTTAGS             = 2324;
  IDM_SHOWAREATAGS                = 2325;
  IDM_SHOWUNKNOWNTAGS             = 2326;
  IDM_SHOWMISCTAGS = 2320; 
  IDM_SHOWZEROBORDERATDESIGNTIME  = 2328;

  IDM_AUTODETECT                  = 2329;

  IDM_SCRIPTDEBUGGER              = 2330;

  IDM_GETBYTESDOWNLOADED          = 2331;

  IDM_NOACTIVATENORMALOLECONTROLS = 2332;
  IDM_NOACTIVATEDESIGNTIMECONTROLS = 2333;
  IDM_NOACTIVATEJAVAAPPLETS       = 2334;
  IDM_NOFIXUPURLSONPASTE          = 2335;

  IDM_EMPTYGLYPHTABLE             = 2336;
  IDM_ADDTOGLYPHTABLE             = 2337;
  IDM_REMOVEFROMGLYPHTABLE        = 2338;
  IDM_REPLACEGLYPHCONTENTS        = 2339;

  IDM_SHOWWBRTAGS                 = 2340;

  IDM_PERSISTSTREAMSYNC           = 2341;
  IDM_SETDIRTY                    = 2342;

  IDM_RUNURLSCRIPT                = 2343;

{$ifdef IE5_ZOOM}
  IDM_ZOOMRATIO                   = 2344;
  IDM_GETZOOMNUMERATOR            = 2345;
  IDM_GETZOOMDENOMINATOR          = 2346;
{$endif  // IE5_ZOOM}

{ COMMANDS FOR COMPLEX TEXT }
  IDM_DIRLTR                      = 2350;
  IDM_DIRRTL                      = 2351;
  IDM_BLOCKDIRLTR                 = 2352;
  IDM_BLOCKDIRRTL                 = 2353;
  IDM_INLINEDIRLTR                = 2354;
  IDM_INLINEDIRRTL                = 2355;

{ SHDOCVW }
  IDM_ISTRUSTEDDLG                = 2356;

{ MSHTMLED }
  IDM_INSERTSPAN                  = 2357;
  IDM_LOCALIZEEDITOR              = 2358;

{ XML MIMEVIEWER }
  IDM_SAVEPRETRANSFORMSOURCE      = 2370;
  IDM_VIEWPRETRANSFORMSOURCE      = 2371;

{ Scrollbar context menu }
  IDM_SCROLL_HERE                 = 2380;
  IDM_SCROLL_TOP                  = 2381;
  IDM_SCROLL_BOTTOM               = 2382;
  IDM_SCROLL_PAGEUP               = 2383;
  IDM_SCROLL_PAGEDOWN             = 2384;
  IDM_SCROLL_UP                   = 2385;
  IDM_SCROLL_DOWN                 = 2386;
  IDM_SCROLL_LEFTEDGE             = 2387;
  IDM_SCROLL_RIGHTEDGE            = 2388;
  IDM_SCROLL_PAGELEFT             = 2389;
  IDM_SCROLL_PAGERIGHT            = 2390;
  IDM_SCROLL_LEFT                 = 2391;
  IDM_SCROLL_RIGHT                = 2392;

{ IE 6 Form Editing Commands }
  IDM_MULTIPLESELECTION           = 2393;
  IDM_2D_POSITION                 = 2394;
  IDM_2D_ELEMENT                  = 2395;
  IDM_1D_ELEMENT                  = 2396;
  IDM_ABSOLUTE_POSITION           = 2397;
  IDM_LIVERESIZE                  = 2398;
  IDM_ATOMICSELECTION             = 2399;

{ Auto URL detection mode }
  IDM_AUTOURLDETECT_MODE          = 2400;

{ Legacy IE50 compatible paste }
  IDM_IE50_PASTE                  = 2401;

{ ie50 paste mode }
  IDM_IE50_PASTE_MODE             = 2402;

{ ;begin_internal }
  IDM_GETIPRINT                   = 2403;
{ ;end_internal }

{ for disabling selection handles }
  IDM_DISABLE_EDITFOCUS_UI        = 2404;

{ for visibility/display in design }
  IDM_RESPECTVISIBILITY_INDESIGN  = 2405;

{ set css mode }
  IDM_CSSEDITING_LEVEL            = 2406;

{ New outdent }
  IDM_UI_OUTDENT                  = 2407;

{ Printing Status }
  IDM_UPDATEPAGESTATUS            = 2408;

{ IME Reconversion }
  IDM_IME_ENABLE_RECONVERSION     = 2409;

  IDM_KEEPSELECTION               = 2410;

  IDM_UNLOADDOCUMENT              = 2411;

  IDM_OVERRIDE_CURSOR             = 2420;

  IDM_PEERHITTESTSAMEINEDIT       = 2423;

  IDM_TRUSTAPPCACHE               = 2425;

  IDM_BACKGROUNDIMAGECACHE        = 2430;

  IDM_GETUSERACTIONTIME           = 2431;
  IDM_BEGINUSERACTION             = 2432;
  IDM_ENDUSERACTION               = 2433;
  IDM_SETCUSTOMCURSOR             = 2434;

{ Open Link in New Tab }
  IDM_FOLLOWLINKT                 = 2435;

{ Caret Browsing Mode }
  IDM_CARETBROWSINGMODE           = 2436;

{ Style menu }
  IDM_STYLEMENU_SETNOSTYLE        = 2437;
  IDM_STYLEMENU_GETNOSTYLE        = 2438;
  IDM_STYLEMENU_GETPREFSTYLE      = 2439;
  IDM_STYLEMENU_CHANGESELECTEDSTYLE = 2440;

{ Media element commands (context menu/keyboard accelerators) }
  IDM_MEDIA_PLAYPAUSE             = 2441;
  IDM_MEDIA_MUTEUNMUTE            = 2442;
  IDM_MEDIA_PLAY                  = 2443;
  IDM_MEDIA_PAUSE                 = 2444;
  IDM_MEDIA_STOP                  = 2445;
  IDM_MEDIA_FULLSCREEN_TOGGLE     = 2446;
  IDM_MEDIA_FULLSCREEN_EXIT       = 2447;
  IDM_MEDIA_VOLUME_UP             = 2448;
  IDM_MEDIA_VOLUME_DOWN           = 2449;
  IDM_MEDIA_SEEK_TO_START         = 2450;
  IDM_MEDIA_SEEK_TO_END           = 2451;
  IDM_MEDIA_SEEK_FWD_SMALL        = 2452;
  IDM_MEDIA_SEEK_BACK_SMALL       = 2453;
  IDM_MEDIA_SEEK_FWD_LARGE        = 2454;
  IDM_MEDIA_SEEK_BACK_LARGE       = 2455;
  IDM_MEDIA_RATE_FASTER           = 2456;
  IDM_MEDIA_RATE_SLOWER           = 2457;
  IDM_MEDIA_SHOWCONTROLS_TOGGLE   = 2458;
  IDM_MEDIA_ZOOMMODE_TOGGLE       = 2459;
  IDM_MEDIA_FRAMESTEP_FWD         = 2460;
  IDM_MEDIA_FRAMESTEP_BACK        = 2461;
  IDM_MEDIA_MUTE                  = 2462;
  IDM_MEDIA_UNMUTE                = 2463;
  IDM_MEDIA_SHOW_AUDIO_ACCESS     = 2464;
  IDM_MEDIA_SHOW_SUBTITLE_ACCESS  = 2465;

{ These should be enough to reserve a block covering all playrates }
{ displayed on the context menu (must be consecutive integers) }
  IDM_MEDIA_PLAYRATE0             = 2480;
  IDM_MEDIA_PLAYRATE1             = 2481;
  IDM_MEDIA_PLAYRATE2             = 2482;
  IDM_MEDIA_PLAYRATE3             = 2483;
  IDM_MEDIA_PLAYRATE4             = 2484;
  IDM_MEDIA_PLAYRATE5             = 2485;
  IDM_MEDIA_PLAYRATE6             = 2486;
  IDM_MEDIA_PLAYRATE7             = 2487;
  IDM_MEDIA_PLAYRATE8             = 2488;
  IDM_MEDIA_PLAYRATE9             = 2489;

  IDM_PASTECONTENTONLY            = 2500;
  IDM_PASTETEXTONLY               = 2501;

  IDM_DEFAULTBLOCK                = 6046;

  IDM_MIMECSET__FIRST__           = 3609;
  IDM_MIMECSET__LAST__            = 3699; 

  IDM_MENUEXT_FIRST__             = 3700;
  IDM_MENUEXT_LAST__              = 3732;
  IDM_MENUEXT_COUNT               = 3733;

{ New for IE10 }
  IDM_ADDCONSOLEMESSAGERECEIVER   = 3800;
  IDM_REMOVECONSOLEMESSAGERECEIVER = 3801;
  IDM_STARTDIAGNOSTICSMODE        = 3802;
  IDM_GETSCRIPTENGINE             = 3803;
  IDM_ADDDEBUGCALLBACKRECEIVER    = 3804;  { pvaIn: IDebugCallbackNotificationHandler*, pvaOut: cookie for unregister }
  IDM_REMOVEDEBUGCALLBACKRECEIVER = 3805;  { pvaIn: cookie from register, pvaOut: NULL }

{ New for IE11 }
  IDM_DEFAULTPARAGRAPHSEPARATOR   = 3900;
  IDM_BEGINUNDOUNIT               = 3901;
  IDM_ENDUNDOUNIT                 = 3902;
  IDM_CLEARUNDO                   = 3903;
  IDM_INSPECTELEMENT              = 3904;

{ Commands mapped from the standard set.  We should }
{ consider deleting them from public header files. }

  IDM_OPEN                        = 2000;
  IDM_NEW                         = 2001;
  IDM_SAVE                        = 70;
  IDM_SAVEAS                      = 71;
  IDM_SAVECOPYAS                  = 2002;
  IDM_PRINTPREVIEW                = 2003;
  IDM_SHOWPRINT                   = 2010; 
  IDM_SHOWPAGESETUP               = 2011; 
  IDM_PRINT                       = 27;
  IDM_PAGESETUP                   = 2004;
  IDM_SPELL                       = 2005;
  IDM_PASTESPECIAL                = 2006;
  IDM_CLEARSELECTION              = 2007;
  IDM_PROPERTIES                  = 28;
  IDM_REDO                        = 29;
  IDM_UNDO                        = 43;
  IDM_SELECTALL                   = 31;
  IDM_ZOOMPERCENT                 = 50;
  IDM_GETZOOM                     = 68;
  IDM_STOP                        = 2138;
  IDM_COPY                        = 15;
  IDM_CUT                         = 16;
  IDM_PASTE                       = 26;

{ Defines for IDM_ZOOMPERCENT }
  CMD_ZOOM_PAGEWIDTH              = -1;
  CMD_ZOOM_ONEPAGE                = -2;
  CMD_ZOOM_TWOPAGES               = -3;
  CMD_ZOOM_SELECTION              = -4;
  CMD_ZOOM_FIT                    = -5;

{ IDMs for CGID_EditStateCommands group }
  IDM_CONTEXT                     = 1;
  IDM_HWND                        = 2;

{ Shdocvw Execs on CGID_DocHostCommandHandler }
  IDM_NEW_TOPLEVELWINDOW          = 7050;


{ Undo persistence comands }

  IDM_PRESERVEUNDOALWAYS          = 6049;
  IDM_PERSISTDEFAULTVALUES        = 7100;
  IDM_PROTECTMETATAGS             = 7101;

  IDM_GETFRAMEZONE                = 6037;

  IDM_REFRESH_THIS                = 6042;

{ placeholder for context menu extensions }
  IDM_MENUEXT_PLACEHOLDER         = 6047;


{ ;begin_internal }
{ <New in IE6> }
  IDM_FIRE_PRINTTEMPLATEUP        = 15000;
  IDM_FIRE_PRINTTEMPLATEDOWN      = 15001;
  IDM_SETPRINTHANDLES             = 15002;
  IDM_CLEARAUTHENTICATIONCACHE    = 15003;
  IDM_GETUSERINITFLAGS            = 15004;
  IDM_GETDOCDLGFLAGS              = 15005;
{ <New in IE7> }
  IDM_OLEWINDOWSTATECHANGED       = 15006;
{ <New in IE8> }
  IDM_ACTIVEXINSTALLSCOPE         = 15007;
  IDM_SETSESSIONDOCUMENTMODE      = 15008;
  IDM_GETSESSIONDOCUMENTMODE      = 15009;
  IDM_SETPROFILINGONSTART         = 15010;
  IDM_GETPROFILINGONSTART         = 15011;
  IDM_SETSCRIPTCONSOLE = 15012;           { no longer in use, use IDM_SETDEVTOOLBARCONSOLE }
  IDM_SETNAVIGATEEVENTSINK        = 15013;
{ <New in IE9> }
{ UNUSED :                          15014 }
{ UNUSED :                          15015 }
  IDM_SETDEVTOOLBARCONSOLE = 15016;       { no longer in use, use IDM_ADDCONSOLEMESSAGERECEIVER & IDM_REMOVECONSOLEMESSAGERECEIVER }
{ <New in IE10> }
  IDM_POPSTATEEVENT               = 15017;
{ UNUSED :                          15018 }
{ UNUSED :                          15019 }
{ UNUSED :                          15020 }
  IDM_SETPARTIALLAYOUTSTATUS      = 15021;
  IDM_GETPARTIALLAYOUTSTATUS      = 15022;
  IDM_ADDPARTIALTESTSTEPCOUNT     = 15023;
  IDM_SETL9QUIRKSEMULATIONENABLED = 15024;
  IDM_GETL9QUIRKSEMULATIONENABLED = 15025;
{ UNUSED :                          15026 }
  IDM_GETDEFAULTZOOMLEVEL         = 15027;
  IDM_GETELEMENTBOUNDINGBOX       = 15028;
  IDM_SETGEOLOCATIONCONSENT       = 15029;
  IDM_ACTIVEXFILTERINGENABLED     = 15030;
{ <New in WIN8> }
  IDM_SHARE                       = 15031;
  IDM_SETAPPCACHESIZECONSENT      = 15032;
  IDM_SHAREAPPCACHEEVENT          = 15033;
  IDM_SETINDEXDBSIZECONSENT       = 15034;
{ Diagnostics mode commands }
{ UNUSED:                           15035 }
{ UNUSED:                           15036 }
{ 15037 unused. Repurpose as needed. }
{ PrintManager Printing Support }
  IDM_GETPRINTMANAGERDOCSOURCE    = 15038;
  IDM_SETEXTRAHEADERS             = 15039;
  IDM_SETACCESSIBILITYNAME        = 15040;
{ Dynamic setting registry update }
  IDM_UPDATESETTINGSFROMREGISTRY  = 15041;
{ PhoneLegacyHost only: perform edit activation }
  IDM_PERFORMEDITACTIVATION       = 15042;
{ Get/set default background color }
  IDM_SETDEFAULTBACKGROUNDCOLOR   = 15043;
  IDM_GETDEFAULTBACKGROUNDCOLOR   = 15044;
{ PhoneLegacyHost only: notify the end of a zoom and scroll animation }
  IDM_NOTIFYZOOMANDSCROLLANIMATIONEND = 15045;
{ PhoneLegacyHost only: notify the context menu on phone has been dismissed }
  IDM_NOTIFYCONTEXTMENUDISMISSED  = 15046;
{ ;end_internal }

{ Security band commands }
  IDM_SETPAGEACTIONALLOWEDFLAGS   = 15100;

{ Flip Ahead commands }
  IDM_INVOKEFLIPAHEADTARGET       = 15200;
  IDM_ENABLEFLIPAHEADTARGET       = 15201;

{ <New in IE11> }
{ Debug w/o Refresh commands }
  IDM_DEBUGGERDYNAMICATTACH       = 15202;
  IDM_DEBUGGERDYNAMICDETACH       = 15203;
  IDM_DEBUGGERDYNAMICATTACHSOURCERUNDOWN = 15204;
  IDM_GETDEBUGGERSTATE            = 15205;
  IDM_SELECTIONSEARCH             = 15206;
  IDM_SHOWSHAREUI                 = 15207;

implementation

end.
