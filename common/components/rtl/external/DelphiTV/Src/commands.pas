unit Commands;


{
 The Commands unit contains all command constants used in the FreeVision
 library.  They have been extracted from their original units and placed here
 for easier maintainence and modification to remove conflicts, such as Borland
 created with the cmChangeDir constant in the StdDlg and App units.
}

interface

const
  { App Unit }
  cmNew           = 30;
  cmOpen          = 31;
  cmSave          = 32;
  cmSaveAs        = 33;
  cmSaveAll       = 34;
  cmSaveDone      = 35;
  cmChangeDir     = 36;
  cmDosShell      = 37;
  cmCloseAll      = 38;
  cmDelete        = 39;
  cmEdit          = 40;
  cmAbout         = 41;
  cmDesktopLoad   = 42;
  cmDesktopStore  = 43;
  cmNewDesktop    = 44;
  cmNewMenuBar    = 45;
  cmNewStatusLine = 46;
  cmNewVideo      = 47;

  cmRecordHistory  = 60;
  cmGrabDefault    = 61;
  cmReleaseDefault = 62;

  cmHelpContents  = 256;
  cmHelpIndex     = 257;
  cmHelpTopic     = 258;
  cmHelpPrev      = 259;
  cmHelpUsingHelp = 260;
  cmHelpAbout     = 261;

  cmBrowseDir     = 262;
  cmBrowseFile    = 263;

  { Views Unit }
  cmValid   = 0;
  cmQuit    = 1;
  cmError   = 2;
  cmMenu    = 3;
  cmClose   = 4;
  cmZoom    = 5;
  cmResize  = 6;
  cmNext    = 7;
  cmPrev    = 8;
  cmHelp    = 9;
  cmOK      = 10;
  cmCancel  = 11;
  cmYes     = 12;
  cmNo      = 13;
  cmDefault = 14;
  cmCut     = 20;
  cmCopy    = 21;
  cmPaste   = 22;
  cmUndo    = 23;
  cmClear   = 24;
  cmTile    = 25;
  cmCascade = 26;
  cmReceivedFocus     = 50;
  cmReleasedFocus     = 51;
  cmCommandSetChanged = 52;
  cmScrollBarChanged  = 53;
  cmScrollBarClicked  = 54;
  cmSelectWindowNum   = 55;
  cmListItemSelected  = 56;

  { ColorSel Unit }
  cmColorForegroundChanged = 71;
  cmColorBackgroundChanged = 72;
  cmColorSet               = 73;
  cmNewColorItem           = 74;
  cmNewColorIndex          = 75;
  cmSaveColorIndex         = 76;

  { StdDlg Unit   800 - ? }
  cmFileOpen    = 800;   { Returned from TFileDialog when Open pressed }
  cmFileReplace = 801;   { Returned from TFileDialog when Replace pressed }
  cmFileClear   = 802;   { Returned from TFileDialog when Clear pressed }
  cmFileInit    = 803;   { Used by TFileDialog internally }
  cmRevert      = 805;   { Used by TChDirDialog internally }
  cmFileFocused = 806;    { A new file was focused in the TFileList }
  cmFileDoubleClicked = 807;  { A file was selected in the TFileList }

  { Config Unit   130-140, 900-999 }
  cmConfigMouse       = 130; { Mouse command disabled by Init if no mouse }
  cmConfigOpen        = 900;
  cmConfigSave        = 901;
  cmConfigSaveAs      = 902;
  cmConfigMenu        = 903;
  cmConfigColors      = 904;
  cmConfigVideo       = 905;
  cmConfigCO80        = 906;
  cmConfigBW80        = 907;
  cmConfigMono        = 908;
  cmClock             = 909;
  cmClockSetFormat    = 910;

    { Editors Unit }
  cmFind           = 82;
  cmReplace        = 83;
  cmSearchAgain    = 84;
  cmPrint          = 85;
  cmRedo           = 86;
  cmJumpLine       = 87;
  cmWindowList     = 88;
  cmCharLeft       = 500;
  cmCharRight      = 501;
  cmWordLeft       = 502;
  cmWordRight      = 503;
  cmLineStart      = 504;
  cmLineEnd        = 505;
  cmLineUp         = 506;
  cmLineDown       = 507;
  cmPageUp         = 508;
  cmPageDown       = 509;
  cmTextStart      = 510;
  cmTextEnd        = 511;
  cmNewLine        = 512;
  cmBackSpace      = 513;
  cmDelChar        = 514;
  cmDelWord        = 515;
  cmDelStart       = 516;
  cmDelEnd         = 517;
  cmDelLine        = 518;
  cmInsMode        = 519;
  cmStartSelect    = 520;
  cmHideSelect     = 521;
  cmEndSelect      = 522;
  cmIndentMode     = 523;
  cmUpdateTitle    = 524;
  cmReformPara     = 525;
  cmTabKey         = 526;
  cmInsertLine     = 527;
  cmScrollUp       = 528;
  cmScrollDown     = 529;
  cmHomePage       = 530;
  cmEndPage        = 531;
  cmJumpMark0      = 532;
  cmJumpMark1      = 533;
  cmJumpMark2      = 534;
  cmJumpMark3      = 535;
  cmJumpMark4      = 536;
  cmJumpMark5      = 537;
  cmJumpMark6      = 538;
  cmJumpMark7      = 539;
  cmJumpMark8      = 540;
  cmJumpMark9      = 541;
  cmReformDoc      = 542;
  cmSetMark0       = 543;
  cmSetMark1       = 544;
  cmSetMark2       = 545;
  cmSetMark3       = 546;
  cmSetMark4       = 547;
  cmSetMark5       = 548;
  cmSetMark6       = 549;
  cmSetMark7       = 550;
  cmSetMark8       = 551;
  cmSetMark9       = 552;
  cmSelectWord     = 553;
  cmSaveExit       = 554;
  cmCenterText     = 555;
  cmSetTabs        = 556;
  cmRightMargin    = 557;
  cmWordwrap       = 558;
  cmBludgeonStats  = 559;
  cmPrinterSetup   = 560;
  cmClipboard      = 561;
  cmSpellCheck     = 562;
  cmCopyBlock      = 563;
  cmMoveBlock      = 564;
  cmDelSelect      = 565;
  cmFileHistory    = 600;

  { Statuses Unit }
  cmStatusUpdate = 300;  { note - need to set to valid value }
  cmStatusDone   = 301;
  cmStatusPause  = 302;
  cmStatusResume = 303;


implementation

end.