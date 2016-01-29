unit ObjTypes;

{
  The ObjTypes unit declares constants for all object type IDs used in the
  FreeVision library.  They have been moved here for easier management.  No
  values for views declared in TV 2.0 have been changed from so that original
  resource files may still be used.
}

interface

const
  { Views Unit }
  idView = 1;
  idFrame = 2;
  idScrollBar = 3;
  idScroller = 4;
  idListViewer = 5;
  idGroup = 6;
  idWindow = 7;

  { Dialogs Unit 10 - ? }
  idDialog = 10;
  idInputLine = 11;
  idButton = 12;
  idCluster = 13;
  idRadioButtons = 14;
  idCheckBoxes = 15;
  idMultiCheckBoxes = 27;
  idListBox = 16;
  idStaticText = 17;
  idLabel = 18;
  idHistory = 19;
  idParamText = 20;
  idCommandCheckBoxes = 21;
  idCommandRadioButtons = 22;
  idCommandIcon = 23;
  idBrowseButton = 24;

  { App Unit }
  idBackground = 30;
  idDesktop = 31;

  { Config Unit }
  idConfig = 32;
  idMouseDlg = 33;
  idVideoDlg = 34;
  idClickTester = 35;

  { Menus Unit }
  idMenuBar = 40;
  idMenuBox = 41;
  idStatusLine = 42;
  idMenuPopup = 43;
  idMenuButton = 44;

  { Objects Unit }
  idCollection = 50;
  idStringCollection = 51;
  idStringList = 52;
  idStrListMaker = 52;
  idStrCollection = 69;

  { Resource Unit }
  idMemStringList = 52;

  { StdDlg Unit }
  idFileInputLine = 60;
  idFileCollection = 61;
  idFileList = 62;
  idFileInfoPane = 63;
  idFileDialog = 64;
  idDirCollection = 65;
  idDirListBox = 66;
  idChDirDialog = 67;
  idSortedListBox = 68;
  idEditChDirDialog = 69;

  { Editors Unit   70 - ? }
  idEditor = 70;
  idMemo = 71;
  idFileEditor = 72;
  idIndicator = 73;
  idEditWindow = 74;
  idEditWindowCollection = 75; { this value may need to be changed }
  idEditorEngine = 76;

  { Validate Unit }
  idPXPictureValidator = 80;
  idFilterValidator = 81;
  idRangeValidator = 82;
  idStringLookupValidator = 83;

  { Outline Unit }
  idOutline = 91;

  { ColorSel Unit }
  idColorSelector = 92;
  idMonoSelector = 93;
  idColorDisplay = 94;
  idColorGroupList = 95;
  idColorItemList = 96;
  idColorDialog = 97;

  { Statuses Unit }
  idStatus   = 300;
  idStatusDlg = 301;
  idStatusMessageDlg = 302;
  idGauge = 303;
  idArrowGauge = 304;
  idBarGauge = 305;
  idPercentGauge = 306;
  idSpinnerGauge = 307;
  idAppStatus = 308;
  idHeapMinAvail = 309;
  idHeapMemAvail = 310;


implementation

end.