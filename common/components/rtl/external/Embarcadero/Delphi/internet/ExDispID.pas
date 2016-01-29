//+-------------------------------------------------------------------------
//
//  Microsoft Windows
//  Copyright 1995-1998 Microsoft Corporation. All Rights Reserved.
//	Copyright(c) 2012-2013 Embarcadero Technologies, Inc.	
//  File: exdispid.h
//
//--------------------------------------------------------------------------

unit ExDispID;

interface

const

//
// Dispatch IDS for IExplorer Dispatch Events.
//
  DISPID_BEFORENAVIGATE     = 100;   // this is sent before navigation to give a chance to abort
  DISPID_NAVIGATECOMPLETE   = 101;   // in async, this is sent when we have enough to show
  DISPID_STATUSTEXTCHANGE   = 102;
  DISPID_QUIT               = 103;
  DISPID_DOWNLOADCOMPLETE   = 104;
  DISPID_COMMANDSTATECHANGE = 105;
  DISPID_DOWNLOADBEGIN      = 106;
  DISPID_NEWWINDOW          = 107;   // sent when a new window should be created
  DISPID_PROGRESSCHANGE     = 108;   // sent when download progress is updated
  DISPID_WINDOWMOVE         = 109;   // sent when main window has been moved
  DISPID_WINDOWRESIZE       = 110;   // sent when main window has been sized
  DISPID_WINDOWACTIVATE     = 111;   // sent when main window has been activated
  DISPID_PROPERTYCHANGE     = 112;   // sent when the PutProperty method is called
  DISPID_TITLECHANGE        = 113;   // sent when the document title changes
  DISPID_TITLEICONCHANGE    = 114;   // sent when the top level window icon may have changed.

  DISPID_FRAMEBEFORENAVIGATE    = 200;
  DISPID_FRAMENAVIGATECOMPLETE  = 201;
  DISPID_FRAMENEWWINDOW         = 204;

  DISPID_BEFORENAVIGATE2      = 250;   // hyperlink clicked on
  DISPID_NEWWINDOW2           = 251   ;
  DISPID_NAVIGATECOMPLETE2    = 252;   // UIActivate new document
  DISPID_ONQUIT               = 253   ;
  DISPID_ONVISIBLE            = 254;   // sent when the window goes visible/hidden
  DISPID_ONTOOLBAR            = 255;   // sent when the toolbar should be shown/hidden
  DISPID_ONMENUBAR            = 256;   // sent when the menubar should be shown/hidden
  DISPID_ONSTATUSBAR          = 257;   // sent when the statusbar should be shown/hidden
  DISPID_ONFULLSCREEN         = 258;   // sent when kiosk mode should be on/off
  DISPID_DOCUMENTCOMPLETE     = 259;   // new document goes ReadyState_Complete
  DISPID_ONTHEATERMODE        = 260;   // sent when theater mode should be on/off
  DISPID_ONADDRESSBAR         = 261;   // sent when the address bar should be shown/hidden
  DISPID_WINDOWSETRESIZABLE   = 262;   // sent to set the style of the host window frame
  DISPID_WINDOWCLOSING        = 263;   // sent before script window.close closes the window
  DISPID_WINDOWSETLEFT        = 264;   // sent when the put_left method is called on the WebOC
  DISPID_WINDOWSETTOP         = 265;   // sent when the put_top method is called on the WebOC
  DISPID_WINDOWSETWIDTH       = 266;   // sent when the put_width method is called on the WebOC
  DISPID_WINDOWSETHEIGHT      = 267;   // sent when the put_height method is called on the WebOC
  DISPID_CLIENTTOHOSTWINDOW   = 268;   // sent during window.open to request conversion of dimensions
  DISPID_SETSECURELOCKICON    = 269;   // sent to suggest the appropriate security icon to show
  DISPID_FILEDOWNLOAD         = 270;   // Fired to indicate the File Download dialog is opening
  DISPID_NAVIGATEERROR        = 271;   // Fired to indicate the a binding error has occured
  DISPID_PRIVACYIMPACTEDSTATECHANGE   = 272;  // Fired when the user's browsing experience is impacted

// Printing events
  DISPID_PRINTTEMPLATEINSTANTIATION   = 225;   // Fired to indicate that a print template is instantiated
  DISPID_PRINTTEMPLATETEARDOWN        = 226;   // Fired to indicate that a print templete is completely gone
  DISPID_UPDATEPAGESTATUS             = 227;   // Fired to indicate that the spooling status has changed

// define the events for the shell wiwndow list
  DISPID_WINDOWREGISTERED     = 200;     // Window registered
  DISPID_WINDOWREVOKED        = 201;     // Window Revoked

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
  DISPID_SHELLUIHELPERLAST        = 13;

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

// Dispatch IDS for ShellFavoritesNameSpace Dispatch Events.
//
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
