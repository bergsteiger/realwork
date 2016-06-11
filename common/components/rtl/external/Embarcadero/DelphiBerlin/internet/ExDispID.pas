{ +------------------------------------------------------------------------- }
{  Microsoft Windows }
{  Copyright (C) Microsoft Corporation. All Rights Reserved. }
{  File: exdispid.h }
{ -------------------------------------------------------------------------- }

unit ExDispID;

interface

{ Dispatch IDS for IExplorer Dispatch Events. }

const
  DISPID_BEFORENAVIGATE = 100;      { this is sent before navigation to give a chance to abort }
  DISPID_NAVIGATECOMPLETE = 101;    { in async, this is sent when we have enough to show }
  DISPID_STATUSTEXTCHANGE   = 102;
  DISPID_QUIT               = 103;
  DISPID_DOWNLOADCOMPLETE   = 104;
  DISPID_COMMANDSTATECHANGE = 105;
  DISPID_DOWNLOADBEGIN      = 106;
  DISPID_NEWWINDOW = 107;           { sent when a new window should be created }
  DISPID_PROGRESSCHANGE = 108;      { sent when download progress is updated }
  DISPID_WINDOWMOVE = 109;          { sent when main window has been moved }
  DISPID_WINDOWRESIZE = 110;        { sent when main window has been sized }
  DISPID_WINDOWACTIVATE = 111;      { sent when main window has been activated }
  DISPID_PROPERTYCHANGE = 112;      { sent when the PutProperty method is called }
  DISPID_TITLECHANGE = 113;         { sent when the document title changes }
  DISPID_TITLEICONCHANGE = 114;     { sent when the top level window icon may have changed. }

  DISPID_FRAMEBEFORENAVIGATE    = 200;
  DISPID_FRAMENAVIGATECOMPLETE  = 201;
  DISPID_FRAMENEWWINDOW         = 204;

  DISPID_BEFORENAVIGATE2 = 250;                       { hyperlink clicked on }
  DISPID_NEWWINDOW2           = 251   ;
  DISPID_NAVIGATECOMPLETE2 = 252;                     { UIActivate new document }
  DISPID_ONQUIT               = 253   ;
  DISPID_ONVISIBLE = 254;                             { sent when the window goes visible/hidden }
  DISPID_ONTOOLBAR = 255;                             { sent when the toolbar should be shown/hidden }
  DISPID_ONMENUBAR = 256;                             { sent when the menubar should be shown/hidden }
  DISPID_ONSTATUSBAR = 257;                           { sent when the statusbar should be shown/hidden }
  DISPID_ONFULLSCREEN = 258;                          { sent when kiosk mode should be on/off }
  DISPID_DOCUMENTCOMPLETE = 259;                      { new document goes ReadyState_Complete }
  DISPID_ONTHEATERMODE = 260;                         { sent when theater mode should be on/off }
  DISPID_ONADDRESSBAR = 261;                          { sent when the address bar should be shown/hidden }
  DISPID_WINDOWSETRESIZABLE = 262;                    { sent to set the style of the host window frame }
  DISPID_WINDOWCLOSING = 263;                         { sent before script window.close closes the window }
  DISPID_WINDOWSETLEFT = 264;                         { sent when the put_left method is called on the WebOC }
  DISPID_WINDOWSETTOP = 265;                          { sent when the put_top method is called on the WebOC }
  DISPID_WINDOWSETWIDTH = 266;                        { sent when the put_width method is called on the WebOC }
  DISPID_WINDOWSETHEIGHT = 267;                       { sent when the put_height method is called on the WebOC }
  DISPID_CLIENTTOHOSTWINDOW = 268;                    { sent during window.open to request conversion of dimensions }
  DISPID_SETSECURELOCKICON = 269;                     { sent to suggest the appropriate security icon to show }
  DISPID_FILEDOWNLOAD = 270;                          { Fired to indicate the File Download dialog is opening }
  DISPID_NAVIGATEERROR = 271;                         { Fired to indicate the a binding error has occured }
  DISPID_PRIVACYIMPACTEDSTATECHANGE = 272;            { Fired when the user's browsing experience is impacted }
  DISPID_NEWWINDOW3 = 273; 
  DISPID_VIEWUPDATE = 281;                            { Fired when the contents of a shell browser window change }
  DISPID_SETPHISHINGFILTERSTATUS = 282;               { Fired by the Phishing Filter API to signal what state the analysis is in }
  DISPID_WINDOWSTATECHANGED = 283;                    { Fired to indicate that the browser window's visibility or enabled state has changed }
  DISPID_NEWPROCESS = 284;                            { Fired when a navigation must be redirected due to Protected Mode }
  DISPID_THIRDPARTYURLBLOCKED = 285;                  { Fired when a third-party url is blocked due to Privacy Advisor   }
  DISPID_REDIRECTXDOMAINBLOCKED = 286;                { Fired when a x-domain redirect is blocked due to browser nav constant   }
  DISPID_WEBWORKERSTARTED = 288; 
  DISPID_WEBWORKERFINISHED = 289; 
  DISPID_BEFORESCRIPTEXECUTE = 290;                   { Fired prior to any of a page's script is executed }

{ Printing events }
  DISPID_PRINTTEMPLATEINSTANTIATION = 225;            { Fired to indicate that a print template is instantiated }
  DISPID_PRINTTEMPLATETEARDOWN = 226;                 { Fired to indicate that a print templete is completely gone }
  DISPID_UPDATEPAGESTATUS = 227;                      { Fired to indicate that the spooling status has changed }

{ define the events for the shell window list }
  DISPID_WINDOWREGISTERED = 200;                      { Window registered }
  DISPID_WINDOWREVOKED = 201;                         { Window Revoked }

  DISPID_RESETFIRSTBOOTMODE       = 1;
  DISPID_RESETSAFEMODE            = 2;
  DISPID_REFRESHOFFLINEDESKTOP    = 3;
  DISPID_ADDFAVORITE              = 4;
  DISPID_ADDCHANNEL               = 5;
  DISPID_ADDDESKTOPCOMPONENT      = 6;
  DISPID_ISSUBSCRIBED             = 7;
  DISPID_NAVIGATEANDFIND          = 8;
  DISPID_IMPORTEXPORTFAVORITES    = 9;
  DISPID_AUTOCOMPLETESAVEFORM     = 10;
  DISPID_AUTOSCAN                 = 11;
  DISPID_AUTOCOMPLETEATTACH       = 12;
  DISPID_SHOWBROWSERUI            = 13;
  DISPID_ADDSEARCHPROVIDER = 14; 
  DISPID_RUNONCESHOWN = 15; 
  DISPID_SKIPRUNONCE = 16; 
  DISPID_CUSTOMIZESETTINGS = 17; 
  DISPID_SQMENABLED = 18; 
  DISPID_PHISHINGENABLED = 19; 
  DISPID_BRANDIMAGEURI = 20; 
  DISPID_SKIPTABSWELCOME = 21; 
  DISPID_DIAGNOSECONNECTION = 22; 
  DISPID_CUSTOMIZECLEARTYPE = 23; 
  DISPID_ISSEARCHPROVIDERINSTALLED = 24; 
  DISPID_ISSEARCHMIGRATED = 25; 
  DISPID_DEFAULTSEARCHPROVIDER = 26; 
  DISPID_RUNONCEREQUIREDSETTINGSCOMPLETE = 27; 
  DISPID_RUNONCEHASSHOWN = 28; 
  DISPID_SEARCHGUIDEURL = 29; 
  DISPID_ADDSERVICE = 30; 
  DISPID_ISSERVICEINSTALLED = 31; 
  DISPID_ADDTOFAVORITESBAR = 32; 
  DISPID_BUILDNEWTABPAGE = 33; 
  DISPID_SETRECENTLYCLOSEDVISIBLE = 34; 
  DISPID_SETACTIVITIESVISIBLE = 35; 
  DISPID_CONTENTDISCOVERYRESET = 36; 
  DISPID_INPRIVATEFILTERINGENABLED = 37; 
  DISPID_SUGGESTEDSITESENABLED = 38; 
  DISPID_ENABLESUGGESTEDSITES = 39; 
  DISPID_NAVIGATETOSUGGESTEDSITES = 40; 
  DISPID_SHOWTABSHELP = 41; 
  DISPID_SHOWINPRIVATEHELP = 42; 
  DISPID_ISSITEMODE = 43; 
  DISPID_SETSITEMODEICONOVERLAY = 44; 
  DISPID_CLEARSITEMODEICONOVERLAY = 45; 
  DISPID_UPDATETHUMBNAILBUTTON = 46; 
  DISPID_SETTHUMBNAILBUTTONS = 47; 
  DISPID_ADDTHUMBNAILBUTTONS = 48; 
  DISPID_ADDSITEMODE = 49; 
  DISPID_SETSITEMODEPROPERTIES = 50; 
  DISPID_SITEMODECREATEJUMPLIST = 51; 
  DISPID_SITEMODEADDJUMPLISTITEM = 52; 
  DISPID_SITEMODECLEARJUMPLIST = 53; 
  DISPID_SITEMODEADDBUTTONSTYLE = 54; 
  DISPID_SITEMODESHOWBUTTONSTYLE = 55; 
  DISPID_SITEMODESHOWJUMPLIST = 56; 
  DISPID_ADDTRACKINGPROTECTIONLIST = 57; 
  DISPID_SITEMODEACTIVATE = 58; 
  DISPID_ISSITEMODEFIRSTRUN = 59; 
  DISPID_TRACKINGPROTECTIONENABLED = 60; 
  DISPID_ACTIVEXFILTERINGENABLED = 61; 
  DISPID_PROVISIONNETWORKS = 62; 
  DISPID_REPORTSAFEURL = 63; 
  DISPID_SITEMODEREFRESHBADGE = 64; 
  DISPID_SITEMODECLEARBADGE = 65; 
  DISPID_DIAGNOSECONNECTIONUILESS = 66; 
  DISPID_LAUNCHNETWORKCLIENTHELP = 67; 
  DISPID_CHANGEDEFAULTBROWSER = 68; 
  DISPID_STOPPERIODICUPDATE = 69; 
  DISPID_STARTPERIODICUPDATE = 70; 
  DISPID_CLEARNOTIFICATION = 71; 
  DISPID_ENABLENOTIFICATIONQUEUE = 72; 
  DISPID_PINNEDSITESTATE = 73; 
  DISPID_LAUNCHINTERNETOPTIONS = 74; 
  DISPID_STARTPERIODICUPDATEBATCH = 75; 
  DISPID_ENABLENOTIFICATIONQUEUESQUARE = 76; 
  DISPID_ENABLENOTIFICATIONQUEUEWIDE = 77; 
  DISPID_ENABLENOTIFICATIONQUEUELARGE = 78; 
  DISPID_SCHEDULEDTILENOTIFICATION = 79; 
  DISPID_REMOVESCHEDULEDTILENOTIFICATION = 80; 
  DISPID_STARTBADGEUPDATE = 81; 
  DISPID_STOPBADGEUPDATE = 82; 
  DISPID_SHELLUIHELPERLAST = 83; 

  DISPID_ADVANCEERROR             = 10;
  DISPID_RETREATERROR             = 11;
  DISPID_CANADVANCEERROR          = 12;
  DISPID_CANRETREATERROR          = 13;
  DISPID_GETERRORLINE             = 14;
  DISPID_GETERRORCHAR             = 15;
  DISPID_GETERRORCODE             = 16;
  DISPID_GETERRORMSG              = 17;
  DISPID_GETERRORURL              = 18;
  DISPID_GETDETAILSSTATE          = 19;
  DISPID_SETDETAILSSTATE          = 20;
  DISPID_GETPERERRSTATE           = 21;
  DISPID_SETPERERRSTATE           = 22;
  DISPID_GETALWAYSSHOWLOCKSTATE   = 23;

{ Dispatch IDS for ShellFavoritesNameSpace Dispatch Events. }

  DISPID_FAVSELECTIONCHANGE       = 1;
  DISPID_SELECTIONCHANGE          = 2;
  DISPID_DOUBLECLICK              = 3;
  DISPID_INITIALIZED              = 4;

  DISPID_MOVESELECTIONUP          = 1;
  DISPID_MOVESELECTIONDOWN        = 2;
  DISPID_RESETSORT                = 3;
  DISPID_NEWFOLDER                = 4;
  DISPID_SYNCHRONIZE              = 5;
  DISPID_IMPORT                   = 6;
  DISPID_EXPORT                   = 7;
  DISPID_INVOKECONTEXTMENU        = 8;
  DISPID_MOVESELECTIONTO          = 9;
  DISPID_SUBSCRIPTIONSENABLED     = 10;
  DISPID_CREATESUBSCRIPTION       = 11;
  DISPID_DELETESUBSCRIPTION       = 12;
  DISPID_SETROOT                  = 13;
  DISPID_ENUMOPTIONS              = 14;
  DISPID_SELECTEDITEM             = 15;
  DISPID_ROOT                     = 16;
  DISPID_DEPTH                    = 17;
  DISPID_MODE                     = 18;
  DISPID_FLAGS                    = 19;
  DISPID_TVFLAGS                  = 20;
  DISPID_NSCOLUMNS                = 21;
  DISPID_COUNTVIEWTYPES           = 22;
  DISPID_SETVIEWTYPE              = 23;
  DISPID_SELECTEDITEMS            = 24;
  DISPID_EXPAND                   = 25;
  DISPID_UNSELECTALL              = 26;

implementation

end.
