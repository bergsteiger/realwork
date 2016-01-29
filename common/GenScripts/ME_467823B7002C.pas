unit afwInterfaces;

interface

uses
 l3IntfUses
 , Controls
 , l3Interfaces
 , l3InternalInterfaces
 , l3Core
 , afwTypes
 , l3PrinterInterfaces
 , ImgList
 , Forms
;

type
 TafwRect = Tl3_Rect;
 
 IafwCString = Il3CString;
 
 IafwFontCache = interface
 end;//IafwFontCache
 
 IafwStyleTableSpy = interface
  {* ������, ����������� ����������� �� ������� ������. }
  procedure StyleTableChanged;
   {* ������� ������ ����������. }
 end;//IafwStyleTableSpy
 
 IafwScrollListener = interface
  {* ������ ����������� ����������� �� ���������. }
  procedure Signal;
   {* ������� ��������� ����������. }
 end;//IafwScrollListener
 
 IafwPreviewPage = interface
  {* �������� Preview. }
  procedure Add(const aPage: IafwPreviewPage);
   {* ��������� �������� � ������. }
  procedure Drop(aCounter: Boolean);
   {* ���������� �������� �� ����. }
  procedure Finish(aPageNumber: Integer;
   aPageWidthNumber: Integer;
   anOverallPageNumber: Integer);
   {* ��������� ���������� ��������. }
  function GetMMWidth: Integer;
   {* ������ �������� � ��. }
  function GetMMHeight: Integer;
   {* ������ (�����) �������� � ��. }
  procedure DrawTo(const aRect: TRect;
   aBitmap: VCLBitmap);
   {* ������ �������� � �������������� �� ������� }
  function WidthCount: Integer;
   {* ���������� ������� � ������. }
  function WidthPage(anIndex: Integer): IafwPreviewPage;
   {* �������� � ������. }
 end;//IafwPreviewPage
 
 IafwStrings = Il3StringsEx;
  {* ������ �����. }
 
 IafwFont = interface(Il3FontPrim)
  {* �����. }
  procedure Assign2Font(aFont: TFont);
 end;//IafwFont
 
 IafwBase = interface(Il3Base)
  {* ������� ��������� ���������� AFW. }
 end;//IafwBase
 
 TafwPagesInfo = object
 end;//TafwPagesInfo
 
 IafwPreviewCanvas = interface
  {* ����� ��� ������ ���������������� ��������� ������. }
  function IsMonochrome: Boolean;
   {* true, ���� ���������� ���������� �� ������������ ����; ����������, ����� ��-��������� �������� ����. }
  function GetPagesCount: Integer;
   {* ����� ��������� � ��������� (���������� ������� "� ������"). }
  function GetPagesWidthCount(aIndex: Integer): Integer;
   {* ������� ������� � ������, ��� �������� ��������. }
  function GetPageByObject(anObjectID: Integer): Integer;
   {* �������� �� �������� � ������. }
  function GetMMPageWidth(aIndex: Integer;
   aWIndex: Integer): Integer;
   {* ������ �������� � ��. }
  function GetMMPageHeight(aIndex: Integer;
   aWIndex: Integer): Integer;
   {* ������ (�����) �������� � ��. }
  procedure DrawTo(aIndex: Integer;
   aWIndex: Integer;
   const aRect: TRect;
   aBitmap: VCLBitmap);
   {* ������ �������� � �������������� �� ������� }
  function GetIntervalPages(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager): TafwPrintPagesArray;
   {* �������� ������ �������, �� ���������. }
  procedure Drop;
   {* ���������� �������� �� ����. }
  function IsPagesCounter: Boolean;
   {* ����� ��� �������� ����� �������? }
  function PreviewPage(aIndex: Integer;
   aWIndex: Integer): IafwPreviewPage;
   {* �������� preview. }
 end;//IafwPreviewCanvas
 
 IafwPrinter = Il3Printer;
  {* �������. }
 
 IafwPreviewNotifier = interface
  {* ��������� �� ��������� ����������� ������ }
  procedure ContentChanged;
   {* ���������� preview ����������. }
 end;//IafwPreviewNotifier
 
 TafwPreviewContentKind = (
  afw_pckDocument
  , afw_pckInfo
  , afw_pckSelection
 );//TafwPreviewContentKind
 
 IafwPreviewPanel = interface
  {* ������ Print-preview. }
  procedure SetCurrentPage(aValue: Integer);
  procedure Invalidate;
  procedure Done;
  function ShouldStop: Boolean;
 end;//IafwPreviewPanel
 
 IafwDocumentPreview = interface
  function DocumentName: IafwCString;
   {* ��� ��������� ��� preview. }
  function InProcess: Boolean;
   {* ���� �������? }
  function InPagesCounting: Boolean;
   {* ������ � �������� �������� �������? }
  function InUpdate: Boolean;
   {* ��������� � �������� ���������� preview? }
  function InPrinting: Boolean;
   {* ��������� � �������� ���������� ������? }
  procedure Update(const aPanel: IafwPreviewPanel);
   {* ���������� preview �� ������ ��� �����������. }
  procedure Print(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager;
   aCopies: Integer;
   const aFileName: AnsiString;
   aCollate: Boolean);
   {* ���������� �� �������. }
  procedure Stop(aWnd: THandle);
   {* ��������� ������� ���������� preview/������. }
  function Stopped: Boolean;
   {* ������� ����������? }
  function CloseRequested: Boolean;
   {* ��� ��������� �������� ��� ������ �� �������� ������ }
  function PreviewResetting: Boolean;
   {* ����� �����������, �� ����� �������������� }
  procedure SetCurrentPage(const aCursor: IUnknown);
   {* ������������� ������ �� ������� ��������. }
  procedure SetCurrentPagePara(aParaID: Integer);
   {* ������������� ������ �� ������� ��������. }
  procedure SetCurrentPageNumber(aPageNumber: Integer);
   {* ������������� ������ �� ������� ��������. }
  function CurrentPage: Integer;
   {* ������� �������� ��� ������. }
  function HasCurrentPage: Boolean;
   {* ����������� �� ������� ��������. }
 end;//IafwDocumentPreview
 
 IafwPageSetup = interface
  {* ��������� ������. }
 end;//IafwPageSetup
 
 TafwPoint = Tl3_Point;
 
 IafwShape = interface
 end;//IafwShape
 
 IafwPrintManager = interface
  {* �������� ������. }
  function CanPrint: Boolean;
  procedure PrintDialog(const aPreview: IafwDocumentPreview);
   {* ������� ������ ������. }
  procedure ShowPreview(const aPreview: IafwDocumentPreview);
   {* ���������� ��������������� �������� ������. }
 end;//IafwPrintManager
 
 IafwDropDownWindow = interface
  {* ��������� ��� ������������� ����������� ����. ��� �������� ������� ���
      ���������� ����������� ��������� � ���������� ����. }
 end;//IafwDropDownWindow
 
 IafwStringsSource = interface
  procedure FillStrings(const aStrings: IafwStrings);
 end;//IafwStringsSource
 
 IafwResources = Il3ApplicationL10NStrings;
 
 IafwLongProcessVisualizer = interface
  {* ������������ ���������� ��������� }
 end;//IafwLongProcessVisualizer
 
 IafwForm = interface
  {* ����� ����������. }
  procedure UpdateCaption(const aCaption: IafwCString);
   {* ���������� ��������� �����. }
 end;//IafwForm
 
 TafwStringArray = Tl3CStringArray;
 
 TafwStatusInfo = record
  {* ������ ����� �������. }
 end;//TafwStatusInfo
 
 IafwStatusElement = interface
  {* GetStatusInfo(out theString: IafwCString; out theNeedProgress: Boolean) }
  procedure GetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
 end;//IafwStatusElement
 
 IafwStatus = interface
  {* ������ �������. }
  procedure AddElement(const anElement: IafwStatusElement);
  procedure RemoveElement(const anElement: IafwStatusElement);
  procedure Update;
  procedure GetStatus(out theStatus: TafwStatusInfo);
 end;//IafwStatus
 
 IafwStatusBar = interface
  {* ������������ ������ �������. }
  procedure UpdateStrings(const aStrings: TafwStatusInfo);
 end;//IafwStatusBar
 
 IafwUserQuery = interface
  {* "������" ��� ������� ������������. }
  function Ask(const aQuery: AnsiString): Boolean;
   {* ������ ������ ������������ � �������� �����. }
 end;//IafwUserQuery
 
 IafwMainForm = interface(IafwForm)
  {* �������� ����� ����������. }
 end;//IafwMainForm
 
 TafwSettingId = AnsiString;
  {* ������������� ���������. }
 
 TafwSettingsState = (
  {* ��������� ���������� ������ � �����������. }
  afw_ssNone
   {* - ������� ���������. }
  , afw_ssSaveInAllSettings
   {* - ��������� ��������� �� ��� ������������. }
 );//TafwSettingsState
 
 (*
 afwSettingsPrim = interface
  function LoadInteger(const aSettingId: TafwSettingId;
   aDefault: Integer;
   aRestoreDefault: Boolean): Integer;
  function LoadParam(const aSettingId: TafwSettingId;
   aType: byte;
   out aValue;
   aDefault;
   aRestoreDefault: Boolean): Boolean;
  function LoadString(const aSettingId: TafwSettingId;
   const aDefault: AnsiString;
   aRestoreDefault: Boolean): IafwCString;
  procedure SaveBoolean(const aSettingId: TafwSettingId;
   aValue: Boolean;
   aDefault: Boolean;
   aSetAsDefault: Boolean);
  procedure SaveInteger(const aSettingId: TafwSettingId;
   aValue: Integer;
   aDefault: Integer;
   aSetAsDefault: Boolean);
   {* aValue - ������� ��������, aDefault - �������� �� ���������, ��������������� ��� ������������� ��������. }
  procedure SaveParam(const aSettingId: TafwSettingId;
   aType: byte;
   aValue;
   aDefault;
   aSetAsDefault: Boolean);
  procedure SaveString(const aSettingId: TafwSettingId;
   const aValue: IafwCString;
   const aDefault: AnsiString;
   aSetAsDefault: Boolean);
  function LoadBoolean(const aSettingId: TafwSettingId;
   aDefault: Boolean;
   aRestoreDefault: Boolean): Boolean;
  function LoadStrings(const aSettingId: TafwSettingId;
   aRestoreDefault: Boolean): IafwStrings;
  procedure SaveStrings(const aSettingId: TafwSettingId;
   const aValue: IafwStrings;
   aSetAsDefault: Boolean);
 end;//afwSettingsPrim
 *)
 
 IafwLocaleInfo = Il3LocaleInfo;
  {* ���������� � ������. }
 
 TafwShiftState = TShiftState;
 
 TafwClickKind = (
  afw_ckSingle
  , afw_ckDouble
  , afw_ckTriple
 );//TafwClickKind
 
 TafwStrobType = (
  {* ��� ������. }
  afw_stNone
  , afw_stHorz
  , afw_stVert
 );//TafwStrobType
 
 TafwMouseState = record
 end;//TafwMouseState
 
 TafwCursorState = type TafwMouseState;
 
 TafwMouseEffect = record
 end;//TafwMouseEffect
 
 TafwCursorShape = (
  {* ����� �������. }
  ev_csDefault
  , ev_csNone
  , ev_csArrow
  , ev_csCross
  , ev_csIBeam
  , ev_csSizeNESW
  , ev_csSizeNS
  , ev_csSizeNWSE
  , ev_csSizeWE
  , ev_csUpArrow
  , ev_csHourGlass
  , ev_csDrag
  , ev_csNoDrop
  , ev_csHSplit
  , ev_csVSplit
  , ev_csMultiDrag
  , ev_csSQLWait
  , ev_csNo
  , ev_csAppStart
  , ev_csHelp
  , ev_csHandPoint
  , ev_csSize
  , ev_csSizeAll
  , ev_csSelectCell
  , ev_csSelectColumn
  , ev_csSelectLine
  , ev_csProperties
  , ev_csExternalHand
  , ev_csInvalidHand
  , ev_csAbolishedHand
  , ev_csPreactiveHand
  , ev_csExternalEno
   {* ������� ���������� }
  , ev_csTimeMachineHand
 );//TafwCursorShape
 
 TafwCursorInfo = record
 end;//TafwCursorInfo
 
 IafwAbortableProcess = interface
  procedure Abort;
 end;//IafwAbortableProcess
 
 IafwTextControl = interface
 end;//IafwTextControl
 
 IafwWeightListener = interface
  {* ��������� �������� ��� �������������� �� ���������� ������������. }
  procedure WeightChanged;
   {* ��� ���������� ��� �������, ���� �������������� ����������. }
 end;//IafwWeightListener
 
 IafwGUIDHolder = interface
 end;//IafwGUIDHolder
 
 IafwTabSheetControl = interface
  {* ��������� ������� ����� ���������� ������ ��� ����������� ��� ���� �� ��������� � ������� ��������� ��������������� ���� ���������. }
  procedure PageInactive;
   {* �������� �������� ����� �� ��������. }
  procedure PageActive;
   {* �������� ����� ��������. }
 end;//IafwTabSheetControl
 
 TafwValueMapID = Tl3ValueMapID;
 
 IafwValueMap = Il3ValueMap;
 
 IafwStringValueMap = Il3StringValueMap;
 
 IafwStringValueMapFactory = Il3StringValueMapFactory;
 
 IafwStringValueMapManager = Il3StringValueMapManager;
 
 IafwIntegerValueMap = Il3IntegerValueMap;
 
 IafwIntegerValueMapFactory = Il3IntegerValueMapFactory;
 
 IafwIntegerValueMapManager = Il3IntegerValueMapManager;
 
 IafwPreviewNotificationSource = interface
  {* �������� ����������� �� ��������� ����������� ������ }
  procedure Subscribe(const aNotifier: IafwPreviewNotifier);
  procedure UnSubscribe(const aNotifier: IafwPreviewNotifier);
 end;//IafwPreviewNotificationSource
 
 IafwSettingListener = interface
  {* ���������� ���������. }
  function SettingChanged(const aSettingId: TafwSettingId): Boolean;
   {* ��������� ����������. }
 end;//IafwSettingListener
 
 IafwSettingsReplaceListener = interface
  {* ��������� ������ ��������. }
  procedure Start;
   {* ����� ������� ��������. }
  procedure Finish;
   {* ����� ������ ��������. }
 end;//IafwSettingsReplaceListener
 
 IafwApplicationDataListener = interface
  {* ��������� ������� ������ ����������. }
  procedure UpdateFinished;
   {* ����������� ��������� �� ��������� ���������� ������ }
 end;//IafwApplicationDataListener
 
 IafwApplicationDataNotify = interface
  {* ���������� � �������� ������ ����������. }
  procedure AddListener(const aListener: IafwApplicationDataListener);
   {* - �������� ���������. }
  procedure RemoveListener(const aListener: IafwApplicationDataListener);
   {* - ������� ���������. }
 end;//IafwApplicationDataNotify
 
 IafwApplicationData = interface
  {* ������ ����������. }
  procedure FinishUpdate;
   {* ����������� ������� � ����� ���������� ������. }
 end;//IafwApplicationData
 
 TafwCustomImageList = TCustomImageList;
  {* ������� ������ ��������. }
 
 IafwComplexDocumentPreview = interface(IafwDocumentPreview)
  {* ��������������� �������� ������ ���������� ���������. }
  function Current: IafwDocumentPreview;
  function Document: IafwDocumentPreview;
  procedure SetDocument(const aDocument: IafwDocumentPreview);
  function Selection: IafwDocumentPreview;
  procedure SetSelection(const aSelection: IafwDocumentPreview);
  function Info: IafwDocumentPreview;
  procedure SetInfo(const anInfo: IafwDocumentPreview);
 end;//IafwComplexDocumentPreview
 
 THandle = l3Core.THandle;
  {* Handle ������� Windows. }
 
 TPersistent = l3Core.TPersistent;
 
 IafwCaret = Il3Caret;
 
 IafwScrollCaret = Il3ScrollCaret;
 
 TafwSPoint = Tl3_SPoint;
 
 IafwSettingsPrim = interface
  function LoadInteger(const aSettingId: TafwSettingId;
   aDefault: Integer;
   aRestoreDefault: Boolean): Integer;
  function LoadParam(const aSettingId: TafwSettingId;
   aType: byte;
   out aValue;
   aDefault;
   aRestoreDefault: Boolean): Boolean;
  function LoadString(const aSettingId: TafwSettingId;
   const aDefault: AnsiString;
   aRestoreDefault: Boolean): IafwCString;
  procedure SaveBoolean(const aSettingId: TafwSettingId;
   aValue: Boolean;
   aDefault: Boolean;
   aSetAsDefault: Boolean);
  procedure SaveInteger(const aSettingId: TafwSettingId;
   aValue: Integer;
   aDefault: Integer;
   aSetAsDefault: Boolean);
   {* aValue - ������� ��������, aDefault - �������� �� ���������, ��������������� ��� ������������� ��������. }
  procedure SaveParam(const aSettingId: TafwSettingId;
   aType: byte;
   aValue;
   aDefault;
   aSetAsDefault: Boolean);
  procedure SaveString(const aSettingId: TafwSettingId;
   const aValue: IafwCString;
   const aDefault: AnsiString;
   aSetAsDefault: Boolean);
  function LoadBoolean(const aSettingId: TafwSettingId;
   aDefault: Boolean;
   aRestoreDefault: Boolean): Boolean;
  function LoadStrings(const aSettingId: TafwSettingId;
   aRestoreDefault: Boolean): IafwStrings;
  procedure SaveStrings(const aSettingId: TafwSettingId;
   const aValue: IafwStrings;
   aSetAsDefault: Boolean);
 end;//IafwSettingsPrim
 
 TafwScrollBarType = (
  {* ��� ����������� ����� ���������. }
  afw_sbHorz
  , afw_sbVert
 );//TafwScrollBarType
 
 TafwScrollBars = set of TafwScrollBarType;
  {* ��������� ����������� ����� ���������. }
 
 // afw_sbBoth
 
 IafwControl = interface
  {* ������� ������. }
  procedure UpdateScrollRange(WhatUpdate: TafwScrollBars);
  function IsA(anObj: TObject): Boolean;
 end;//IafwControl
 
 IafwAlwaysOnTopControl = interface
  {* ��������� ���������-����. �� ������� [$86478352]. }
 end;//IafwAlwaysOnTopControl
 
 IafwTempStream = Il3TempStream;
 
 TafwColor = Tl3Color;
  {* ����. }
 
 TafwFontIndex = Tl3FontIndex;
 
 IafwHAFPainter = Il3HAFPainter;
 
 IafwMultiDocumentPreview = interface(IafwDocumentPreview)
  {* ��������������� �������� ���������� ���������� ������. }
  procedure AddDocument(const aDocument: IafwDocumentPreview);
   {* ��������� �������� � �����. }
 end;//IafwMultiDocumentPreview
 
 IafwSettings = interface(IafwSettingsPrim)
  {* ��������� ��� ������ � �����������. }
  function LoadDouble(const aSettingId: TafwSettingId;
   aDefault: Double;
   aRestoreDefault: Boolean): Double;
  procedure SaveDouble(const aSettingId: TafwSettingId;
   aValue: Double;
   aDefault: Double;
   aSetAsDefault: Boolean);
 end;//IafwSettings
 
 TafwPreviewCaleeArea = (
  afw_pcaMain
  , afw_pcaReference
  , afw_pcaAnnotation
  , afw_pcaTranslation
  , afw_pcaChronology
 );//TafwPreviewCaleeArea
 
 IafwHAFMacroReplacer = Il3HAFMacroReplacer;
 
 IafwProportionalControl = interface
  {* ��� ����������� �������� � �������� �������� ����������� �������� ��� �����. K-137463980 }
  procedure NotifyLoaded;
   {* ��� ���� ��������� }
 end;//IafwProportionalControl
 
 TafwJumpToEffect = (
  {* ��������� ��������� ��� �������� �� ����������� }
  afw_jteRequestNewWindow
   {* ������������ � ����� ���� }
  , afw_jteRequestNewTab
  , afw_jteRequestNoActivate
 );//TafwJumpToEffect
 
 TafwJumpToEffects = set of TafwJumpToEffect;
  {* ��������� ��������� ��� �������� �� ����������� }
 
 TafwAskClearClipboardProc = Tl3AskClearClipboardProc;
 
 IafwMenuUnlockedPostBuild = interface
  procedure MenuUnlockedFixUp;
 end;//IafwMenuUnlockedPostBuild
 
 TafwTabInterfaceType = (
  afw_titNoTabs
   {* ���������� ��� ������� }
  , afw_titTabs
   {* ���������� � ��������� }
  , afw_titTabsDisabled
   {* ���������� � ���������, �� ��� ��������� }
 );//TafwTabInterfaceType
 
 IafwComplexDocumentPreviewFactory = interface
  {* ������� � ����� }
  function Make: IafwComplexDocumentPreview;
  function Count: Integer;
  procedure ResetCache(ResetInfo: Boolean);
 end;//IafwComplexDocumentPreviewFactory
 
 IafwFormView = interface
  {* [RequestLink:259168102] }
  function CalculateHeightByWidth(var theWidth: Integer;
   aForceLoadData: Boolean): Integer;
  procedure SetBackColor(aColor: TafwColor);
 end;//IafwFormView
 
 IafwFloatingWindow = interface
  procedure DisableClose;
  procedure DisableReactivate;
 end;//IafwFloatingWindow
 
 IafwSettingsSource = interface
  {* ������, ������� �������� � �����������. }
 end;//IafwSettingsSource
 
 (*
 MafwSettingsNotify = interface
  procedure AddListener(const aListener: IafwSettingListener); overload;
  procedure AddListener(const aListener: IafwSettingsReplaceListener); overload;
  procedure RemoveListener(const aListener: IafwSettingListener); overload;
  procedure RemoveListener(const aListener: IafwSettingsReplaceListener); overload;
 end;//MafwSettingsNotify
 *)
 
 TafwCustomForm = TCustomForm;
 
 IafwMainFormContainer = interface
  procedure UpdateFormCaption(aForm: TafwCustomForm);
 end;//IafwMainFormContainer
 
 IafwMainFormProvider = interface
 end;//IafwMainFormProvider
 
 (*
 MafwVisualizater = interface
  function MakeLongProcessVisualizer(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer): IafwLongProcessVisualizer;
 end;//MafwVisualizater
 *)
 
 IafwApplication = interface
  {* ������ ����������, ������� �� �������� ��������. }
  function IsTrialMode: Boolean;
  procedure ApplyActiveLanguage(const aTarget: IafwResources);
  procedure LockKeyBoard;
  procedure UnlockKeyBoard;
  function AskClearClipboardProc: TafwAskClearClipboardProc;
  function MakeLongProcessVisualizer(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer): IafwLongProcessVisualizer;
 end;//IafwApplication
 
implementation

uses
 l3ImplUses
;

end.
