unit afwInterfaces;
 {* ���������� ���������� afw, ��������������� ��� ���������������� ������� �� �������� ����������. }

// ������: "w:\common\components\gui\Garant\AFW\afwInterfaces.pas"
// ���������: "Interfaces"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , l3InternalInterfaces
 , l3Core
 , afwTypes
 , l3PrinterInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 afw_lpwTimeout = 500;
  {* �������� � �� ����� ������� ������������ ���� ��� ���������� �������� }
 ssControl = ssCtrl;
{$If NOT Defined(NoVCL)}
 afw_CM_TEXTCHANGED = Controls.CM_TEXTCHANGED;
{$IfEnd} // NOT Defined(NoVCL)
 afw_lngRussian = 'ru';
 afw_lngEnglish = 'en';

type
 IafwBase = interface(Il3Base)
  {* ������� ��������� ���������� AFW. }
  ['{A9D8280E-5E96-492B-98D9-3657A9067BFE}']
 end;//IafwBase

 TafwRect = Tl3_Rect;

 IafwCString = Il3CString;

 IafwFontCache = interface(IafwBase)
  ['{AA1123D5-C393-467C-9630-EEF98BCFF422}']
 end;//IafwFontCache

 {$If NOT Defined(DesignTimeLibrary)}
 IafwStyleTableSpy = interface(IafwBase)
  {* ������, ����������� ����������� �� ������� ������. }
  ['{30EEA38C-9A5B-4DEF-A4E8-011D85916E59}']
  procedure StyleTableChanged;
   {* ������� ������ ����������. }
 end;//IafwStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)

 IafwScrollListener = interface(IafwBase)
  {* ������ ����������� ����������� �� ���������. }
  ['{92451A9B-7A66-4C4C-91A8-63D25A251423}']
  procedure Signal;
   {* ������� ��������� ����������. }
 end;//IafwScrollListener

 IafwPreviewPage = interface(IafwBase)
  {* �������� Preview. }
  ['{5126F4E2-7A97-441F-A507-6A5C84F9D490}']
  function pm_GetPageNumber: Integer;
  function pm_GetPageWidthNumber: Integer;
  function Get_OverallPageNumber: Integer;
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
  property PageNumber: Integer
   read pm_GetPageNumber;
   {* ����� �������� � ������. }
  property PageWidthNumber: Integer
   read pm_GetPageWidthNumber;
   {* ����� �������� � ������. }
  property OverallPageNumber: Integer
   read Get_OverallPageNumber;
 end;//IafwPreviewPage

 IafwStrings = Il3StringsEx;
  {* ������ �����. }

 IafwFont = interface(Il3FontPrim)
  {* �����. }
  ['{A15E1284-62FB-47A0-9B84-07F6949E9745}']
  procedure Assign2Font(aFont: TFont);
 end;//IafwFont

 TafwPagesInfo = object
  public
   rPagesCount: Integer;
   rOverallPagesCount: Integer;
  public
   function IsValid: Boolean;
   function Add(const anAdder: TafwPagesInfo): TafwPagesInfo;
 end;//TafwPagesInfo

 IafwPreviewCanvas = interface(IafwBase)
  {* ����� ��� ������ ���������������� ��������� ������. }
  ['{CAA9C8A6-0148-45C5-8DA4-E00BEAEB31EC}']
  function Get_PagesInfo: TafwPagesInfo;
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
   const aRange: Il3RangeManager = nil): TafwPrintPagesArray;
   {* �������� ������ �������, �� ���������. }
  procedure Drop;
   {* ���������� �������� �� ����. }
  function IsPagesCounter: Boolean;
   {* ����� ��� �������� ����� �������? }
  function PreviewPage(aIndex: Integer;
   aWIndex: Integer): IafwPreviewPage;
   {* �������� preview. }
  property PagesInfo: TafwPagesInfo
   read Get_PagesInfo;
 end;//IafwPreviewCanvas

 IafwPrinter = Il3Printer;
  {* �������. }

 IafwPreviewNotifier = interface(IafwBase)
  {* ��������� �� ��������� ����������� ������ }
  ['{4A93B65C-2EE5-48F2-9DE7-DF2EBF47B98E}']
  procedure ContentChanged;
   {* ���������� preview ����������. }
 end;//IafwPreviewNotifier

 TafwPreviewContentKind = (
  afw_pckDocument
  , afw_pckInfo
  , afw_pckSelection
 );//TafwPreviewContentKind

 IafwPreviewPanel = interface(IafwBase)
  {* ������ Print-preview. }
  ['{2DF654AF-58CD-4D9D-8F24-E3696D42EB3A}']
  procedure pm_SetPreviewCanvas(const aValue: IafwPreviewCanvas);
  function pm_GetPainted: Boolean;
  procedure SetCurrentPage(aValue: Integer);
  procedure Invalidate;
  procedure Done;
  {$If Defined(nsTest)}
  function ShouldStop: Boolean;
  {$IfEnd} // Defined(nsTest)
  property PreviewCanvas: IafwPreviewCanvas
   write pm_SetPreviewCanvas;
  property Painted: Boolean
   read pm_GetPainted;
 end;//IafwPreviewPanel

 IafwDocumentPreview = interface(IafwBase)
  ['{DD4C8522-0202-4037-9D3B-6D13C4368A7B}']
  function pm_GetPrinter: IafwPrinter;
  procedure pm_SetPrinter(const aValue: IafwPrinter);
  function pm_GetHasText: Boolean;
  function pm_GetPagesInfo: TafwPagesInfo;
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
  procedure Print(anInterval: TafwPagesInterval = afwTypes.afw_piAll;
   const aRange: Il3RangeManager = nil;
   aCopies: Integer = 1;
   const aFileName: AnsiString = '';
   aCollate: Boolean = True);
   {* ���������� �� �������. }
  procedure Stop(aWnd: THandle = 0);
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
  property Printer: IafwPrinter
   read pm_GetPrinter
   write pm_SetPrinter;
   {* ������� ��� Preview/������. }
  property HasText: Boolean
   read pm_GetHasText;
   {* ���� �� ����� ��� ������. }
  property PagesInfo: TafwPagesInfo
   read pm_GetPagesInfo;
 end;//IafwDocumentPreview

 IafwPageSetup = interface(IafwBase)
  {* ��������� ������. }
  ['{8080A4A6-E1FA-4E80-8991-3EA559018FCF}']
  function pm_GetMargins: TafwRect;
  function pm_GetOrientation: Tl3PageOrientation;
  property Margins: TafwRect
   read pm_GetMargins;
  property Orientation: Tl3PageOrientation
   read pm_GetOrientation;
 end;//IafwPageSetup

 TafwPoint = Tl3_Point;

 IafwShape = interface(IafwBase)
  ['{3BDB624D-DDC6-4C5F-8D8A-90ADAA8361DE}']
  function pm_GetBounds: TafwRect;
  function pm_GetOuter: IafwShape;
  property Bounds: TafwRect
   read pm_GetBounds;
  property Outer: IafwShape
   read pm_GetOuter;
 end;//IafwShape

 IafwPrintManager = interface(IafwBase)
  {* �������� ������. }
  ['{EFE4300A-2FBB-433F-B79C-A9BCC419F8B4}']
  function pm_GetPageSetup: IafwPageSetup;
  function CanPrint: Boolean;
  procedure PrintDialog(const aPreview: IafwDocumentPreview);
   {* ������� ������ ������. }
  procedure ShowPreview(const aPreview: IafwDocumentPreview);
   {* ���������� ��������������� �������� ������. }
  property PageSetup: IafwPageSetup
   read pm_GetPageSetup;
   {* ��������� ��������. }
 end;//IafwPrintManager

 IafwDropDownWindow = interface(IafwBase)
  {* ��������� ��� ������������� ����������� ����. ��� �������� ������� ���
      ���������� ����������� ��������� � ���������� ����. }
  ['{2CCBCD14-F408-4575-80C7-5C2BED0AD2F4}']
 end;//IafwDropDownWindow

 IafwStringsSource = interface(IafwBase)
  ['{B924373D-A2DF-4DD1-A485-723290D3C952}']
  procedure FillStrings(const aStrings: IafwStrings);
 end;//IafwStringsSource

 IafwResources = Il3ApplicationL10NStrings;

 IafwLongProcessVisualizer = interface(IafwBase)
  {* ������������ ���������� ��������� }
  ['{3C6771BC-5FC2-4155-A572-35AD0524E718}']
 end;//IafwLongProcessVisualizer

 IafwForm = interface(IafwBase)
  {* ����� ����������. }
  ['{6C85D90F-70B6-4604-925F-4DE6866C96FF}']
  function pm_GetBoundsRect: TRect;
  procedure UpdateCaption(const aCaption: IafwCString);
   {* ���������� ��������� �����. }
  property BoundsRect: TRect
   read pm_GetBoundsRect;
   {* �������������, ������� �������� �����. }
 end;//IafwForm

 TafwStringArray = Tl3CStringArray;

 TafwStatusInfo = record
  {* ������ ����� �������. }
  rStrings: TafwStringArray;
  rNeedProgress: Boolean;
 end;//TafwStatusInfo

 IafwStatusElement = interface(IafwBase)
  {* GetStatusInfo(out theString: IafwCString; out theNeedProgress: Boolean) }
  ['{609BB000-5209-4A7A-BF5F-3D17A4B4B581}']
  procedure GetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
 end;//IafwStatusElement

 IafwStatus = interface(IafwBase)
  {* ������ �������. }
  ['{36F50AA0-FE91-45B2-9C46-4307BA18D56A}']
  procedure AddElement(const anElement: IafwStatusElement);
  procedure RemoveElement(const anElement: IafwStatusElement);
  procedure Update;
  procedure GetStatus(out theStatus: TafwStatusInfo);
 end;//IafwStatus

 IafwStatusBar = interface(IafwBase)
  {* ������������ ������ �������. }
  ['{06889743-137B-4A6E-9B8C-9AD583C92B5A}']
  procedure UpdateStrings(const aStrings: TafwStatusInfo);
 end;//IafwStatusBar

 IafwUserQuery = interface(IafwBase)
  {* "������" ��� ������� ������������. }
  ['{47F46BFD-0666-4CDC-AEF9-5ADF7074B324}']
  function Ask(const aQuery: AnsiString): Boolean;
   {* ������ ������ ������������ � �������� �����. }
 end;//IafwUserQuery

 IafwMainForm = interface(IafwForm)
  {* �������� ����� ����������. }
  ['{5F103692-A022-41FE-8561-AD0167E18D0F}']
  function pm_GetStatusBar: IafwStatusBar;
  procedure pm_SetStatusBar(const aValue: IafwStatusBar);
  function pm_GetStatus: IafwStatus;
  procedure pm_SetStatus(const aValue: IafwStatus);
  property StatusBar: IafwStatusBar
   read pm_GetStatusBar
   write pm_SetStatusBar;
   {* ������, ������������ ������ �������. }
  property Status: IafwStatus
   read pm_GetStatus
   write pm_SetStatus;
   {* ������ �������. }
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
   aDefault: Integer = 0;
   aRestoreDefault: Boolean = False): Integer;
  function LoadParam(const aSettingId: TafwSettingId;
   aType: byte;
   out aValue;
   aDefault;
   aRestoreDefault: Boolean): Boolean;
  function LoadString(const aSettingId: TafwSettingId;
   const aDefault: AnsiString = '';
   aRestoreDefault: Boolean = False): IafwCString;
  procedure SaveBoolean(const aSettingId: TafwSettingId;
   aValue: Boolean;
   aDefault: Boolean = False;
   aSetAsDefault: Boolean = False);
  procedure SaveInteger(const aSettingId: TafwSettingId;
   aValue: Integer;
   aDefault: Integer = 0;
   aSetAsDefault: Boolean = False);
   {* aValue - ������� ��������, aDefault - �������� �� ���������, ��������������� ��� ������������� ��������. }
  procedure SaveParam(const aSettingId: TafwSettingId;
   aType: byte;
   aValue;
   aDefault;
   aSetAsDefault: Boolean);
  procedure SaveString(const aSettingId: TafwSettingId;
   const aValue: IafwCString;
   const aDefault: AnsiString = '';
   aSetAsDefault: Boolean = False);
  function LoadBoolean(const aSettingId: TafwSettingId;
   aDefault: Boolean = False;
   aRestoreDefault: Boolean = False): Boolean;
  function LoadStrings(const aSettingId: TafwSettingId;
   aRestoreDefault: Boolean = False): IafwStrings;
  procedure SaveStrings(const aSettingId: TafwSettingId;
   const aValue: IafwStrings;
   aSetAsDefault: Boolean = False);
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
  rInitialPoint: TafwPoint;
  rPoint: TafwPoint;
  rKeys: TafwShiftState;
  rInitialClick: TafwClickKind;
  rInMove: Boolean;
 end;//TafwMouseState

 TafwCursorState = type TafwMouseState;

 TafwMouseEffect = record
  rNeedAsyncLoop: Boolean;
  rStrob: TafwStrobType;
  rAllowAutoSelect: Boolean;
  rExtendingSelection: Boolean;
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
  rCursor: TafwCursorShape;
  rHint: IafwCString;
 end;//TafwCursorInfo

 IafwAbortableProcess = interface(IafwBase)
  ['{E68E7A82-E9D4-40DC-91BA-F49CE9559A83}']
  procedure Abort;
 end;//IafwAbortableProcess

 IafwTextControl = interface(IafwBase)
  ['{E5B1F77E-70EF-4E53-9B61-40EB6888A7A0}']
  function pm_GetCCaption: IafwCString;
  procedure pm_SetCCaption(const aValue: IafwCString);
  property CCaption: IafwCString
   read pm_GetCCaption
   write pm_SetCCaption;
 end;//IafwTextControl

 IafwWeightListener = interface(IafwBase)
  {* ��������� �������� ��� �������������� �� ���������� ������������. }
  ['{DCCC4FCC-3575-4A8B-9D55-AC07E7A2C496}']
  procedure WeightChanged;
   {* ��� ���������� ��� �������, ���� �������������� ����������. }
 end;//IafwWeightListener

 IafwGUIDHolder = interface(IafwBase)
  ['{55BB4E8E-CC92-4732-99FC-8F634968DBAF}']
  function pm_GetGUID: TGUID;
  property GUID: TGUID
   read pm_GetGUID;
 end;//IafwGUIDHolder

 IafwTabSheetControl = interface(IafwBase)
  {* ��������� ������� ����� ���������� ������ ��� ����������� ��� ���� �� ��������� � ������� ��������� ��������������� ���� ���������. }
  ['{F94B33C7-9D95-4569-81AD-12D1326C16B8}']
  function pm_GetWeight: Integer;
  procedure PageInactive;
   {* �������� �������� ����� �� ��������. }
  procedure PageActive;
   {* �������� ����� ��������. }
  property Weight: Integer
   read pm_GetWeight;
   {* ��� ����������, ����������� ��� ���������� ��������. }
 end;//IafwTabSheetControl

 TafwValueMapID = Tl3ValueMapID;

 IafwValueMap = Il3ValueMap;

 IafwStringValueMap = Il3StringValueMap;

 IafwStringValueMapFactory = Il3StringValueMapFactory;

 IafwStringValueMapManager = Il3StringValueMapManager;

 IafwIntegerValueMap = Il3IntegerValueMap;

 IafwIntegerValueMapFactory = Il3IntegerValueMapFactory;

 IafwIntegerValueMapManager = Il3IntegerValueMapManager;

 IafwPreviewNotificationSource = interface(IafwBase)
  {* �������� ����������� �� ��������� ����������� ������ }
  ['{0D0B9DFC-F186-4A9B-BAA7-9B77284AD4C0}']
  procedure Subscribe(const aNotifier: IafwPreviewNotifier);
  procedure UnSubscribe(const aNotifier: IafwPreviewNotifier);
 end;//IafwPreviewNotificationSource

 IafwSettingListener = interface(IafwBase)
  {* ���������� ���������. }
  ['{3DEC2821-094A-4FA7-9F9B-B3FC49767678}']
  function SettingChanged(const aSettingId: TafwSettingId): Boolean;
   {* ��������� ����������. }
 end;//IafwSettingListener

 IafwSettingsReplaceListener = interface(IafwBase)
  {* ��������� ������ ��������. }
  ['{54DE6AC5-7087-4EDD-90A9-22EBD9C5040D}']
  procedure Start;
   {* ����� ������� ��������. }
  procedure Finish;
   {* ����� ������ ��������. }
 end;//IafwSettingsReplaceListener

 IafwApplicationDataListener = interface(IafwBase)
  {* ��������� ������� ������ ����������. }
  ['{93FC76DF-F425-447B-9C04-D6A0A12820B8}']
  procedure UpdateFinished;
   {* ����������� ��������� �� ��������� ���������� ������ }
 end;//IafwApplicationDataListener

 IafwApplicationDataNotify = interface(IafwBase)
  {* ���������� � �������� ������ ����������. }
  ['{DA565FE5-2D82-445A-95FC-C7CA9B71EB7B}']
  procedure AddListener(const aListener: IafwApplicationDataListener);
   {* - �������� ���������. }
  procedure RemoveListener(const aListener: IafwApplicationDataListener);
   {* - ������� ���������. }
 end;//IafwApplicationDataNotify

 IafwApplicationData = interface(IafwBase)
  {* ������ ����������. }
  ['{27DBC7AA-7FBE-4964-9287-4A68D45D1691}']
  function Get_Notify: IafwApplicationDataNotify;
  function Get_InUpdate: Boolean;
  procedure FinishUpdate;
   {* ����������� ������� � ����� ���������� ������. }
  property Notify: IafwApplicationDataNotify
   read Get_Notify;
   {* - �������� �� ������� ������ ����������. }
  property InUpdate: Boolean
   read Get_InUpdate;
 end;//IafwApplicationData

 {$If NOT Defined(NoVCL)}
 TafwCustomImageList = TCustomImageList;
  {* ������� ������ ��������. }
 {$IfEnd} // NOT Defined(NoVCL)

 IafwComplexDocumentPreview = interface(IafwDocumentPreview)
  {* ��������������� �������� ������ ���������� ���������. }
  ['{FC63F0FC-C367-40E4-BF17-0417DB58D238}']
  function pm_GetContentKind: TafwPreviewContentKind;
  procedure pm_SetContentKind(aValue: TafwPreviewContentKind);
  function Current: IafwDocumentPreview;
  function Document: IafwDocumentPreview;
  procedure SetDocument(const aDocument: IafwDocumentPreview);
  function Selection: IafwDocumentPreview;
  procedure SetSelection(const aSelection: IafwDocumentPreview);
  function Info: IafwDocumentPreview;
  procedure SetInfo(const anInfo: IafwDocumentPreview);
  property ContentKind: TafwPreviewContentKind
   read pm_GetContentKind
   write pm_SetContentKind;
   {* ��� ������������� �������� ���������. }
 end;//IafwComplexDocumentPreview

 THandle = l3Core.THandle;
  {* Handle ������� Windows. }

 TPersistent = l3Core.TPersistent;

 IafwCaret = Il3Caret;

 IafwScrollCaret = Il3ScrollCaret;

 TafwSPoint = Tl3_SPoint;

 IafwSettingsPrim = interface(IafwBase)
  ['{A6414152-AAC3-426A-8A45-22498E6A8B38}']
  function LoadInteger(const aSettingId: TafwSettingId;
   aDefault: Integer = 0;
   aRestoreDefault: Boolean = False): Integer;
  function LoadParam(const aSettingId: TafwSettingId;
   aType: byte;
   out aValue;
   aDefault;
   aRestoreDefault: Boolean): Boolean;
  function LoadString(const aSettingId: TafwSettingId;
   const aDefault: AnsiString = '';
   aRestoreDefault: Boolean = False): IafwCString;
  procedure SaveBoolean(const aSettingId: TafwSettingId;
   aValue: Boolean;
   aDefault: Boolean = False;
   aSetAsDefault: Boolean = False);
  procedure SaveInteger(const aSettingId: TafwSettingId;
   aValue: Integer;
   aDefault: Integer = 0;
   aSetAsDefault: Boolean = False);
   {* aValue - ������� ��������, aDefault - �������� �� ���������, ��������������� ��� ������������� ��������. }
  procedure SaveParam(const aSettingId: TafwSettingId;
   aType: byte;
   aValue;
   aDefault;
   aSetAsDefault: Boolean);
  procedure SaveString(const aSettingId: TafwSettingId;
   const aValue: IafwCString;
   const aDefault: AnsiString = '';
   aSetAsDefault: Boolean = False);
  function LoadBoolean(const aSettingId: TafwSettingId;
   aDefault: Boolean = False;
   aRestoreDefault: Boolean = False): Boolean;
  function LoadStrings(const aSettingId: TafwSettingId;
   aRestoreDefault: Boolean = False): IafwStrings;
  procedure SaveStrings(const aSettingId: TafwSettingId;
   const aValue: IafwStrings;
   aSetAsDefault: Boolean = False);
 end;//IafwSettingsPrim

 TafwScrollBarType = (
  {* ��� ����������� ����� ���������. }
  afw_sbHorz
  , afw_sbVert
 );//TafwScrollBarType

 TafwScrollBars = set of TafwScrollBarType;
  {* ��������� ����������� ����� ���������. }

 // afw_sbBoth

 IafwControl = interface(IafwBase)
  {* ������� ������. }
  ['{D04BE1CD-35E0-4131-AB4D-4D60A6104288}']
  procedure UpdateScrollRange(WhatUpdate: TafwScrollBars = afw_sbBoth);
  function IsA(anObj: TObject): Boolean;
 end;//IafwControl

 IafwAlwaysOnTopControl = interface(IafwBase)
  {* ��������� ���������-����. �� ������� [$86478352]. }
  ['{13C9441A-B0D5-4AC9-B902-1643631DDE81}']
 end;//IafwAlwaysOnTopControl

 IafwTempStream = Il3TempStream;

 TafwColor = Tl3Color;
  {* ����. }

 TafwFontIndex = Tl3FontIndex;

 IafwHAFPainter = Il3HAFPainter;

 IafwMultiDocumentPreview = interface(IafwDocumentPreview)
  {* ��������������� �������� ���������� ���������� ������. }
  ['{36824BC9-3662-4C27-8C3C-74C85CACADC3}']
  function Get_DocCount: Integer;
  procedure AddDocument(const aDocument: IafwDocumentPreview);
   {* ��������� �������� � �����. }
  property DocCount: Integer
   read Get_DocCount;
 end;//IafwMultiDocumentPreview

 IafwSettings = interface(IafwSettingsPrim)
  {* ��������� ��� ������ � �����������. }
  ['{AA09C807-50E6-404C-9A06-F3F9818A3375}']
  function pm_GetState: TafwSettingsState;
  procedure pm_SetState(aValue: TafwSettingsState);
  function LoadDouble(const aSettingId: TafwSettingId;
   aDefault: Double = 0;
   aRestoreDefault: Boolean = False): Double;
  procedure SaveDouble(const aSettingId: TafwSettingId;
   aValue: Double;
   aDefault: Double = 0;
   aSetAsDefault: Boolean = False);
  property State: TafwSettingsState
   read pm_GetState
   write pm_SetState;
   {* - ��������� ����������. }
 end;//IafwSettings

 TafwPreviewCaleeArea = (
  afw_pcaMain
  , afw_pcaReference
  , afw_pcaAnnotation
  , afw_pcaTranslation
  , afw_pcaChronology
 );//TafwPreviewCaleeArea

 IafwHAFMacroReplacer = Il3HAFMacroReplacer;

 IafwProportionalControl = interface(IafwBase)
  {* ��� ����������� �������� � �������� �������� ����������� �������� ��� �����. K-137463980 }
  ['{1573E995-8252-4B0D-B18A-C430034F6C42}']
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

 IafwMenuUnlockedPostBuild = interface(IafwBase)
  ['{1B689030-CE18-4476-8B7A-5B8C3C63B4A3}']
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

 IafwComplexDocumentPreviewFactory = interface(IafwBase)
  {* ������� � ����� }
  ['{C51B432A-9769-4B0D-B6C4-4EC1960CE152}']
  function pm_GetItem(anIndex: Integer): IafwComplexDocumentPreview; { can raise EListError }
  function Make: IafwComplexDocumentPreview;
  function Count: Integer;
  procedure ResetCache(ResetInfo: Boolean);
  property Item[anIndex: Integer]: IafwComplexDocumentPreview
   read pm_GetItem;
 end;//IafwComplexDocumentPreviewFactory

 IafwFormView = interface(IafwBase)
  {* [RequestLink:259168102] }
  ['{00FE25B8-9B43-4535-83B2-0FA7AD47BED9}']
  function CalculateHeightByWidth(var theWidth: Integer;
   aForceLoadData: Boolean): Integer;
  procedure SetBackColor(aColor: TafwColor);
 end;//IafwFormView

 IafwFloatingWindow = interface(IafwBase)
  ['{C8E7A039-5292-4B18-B658-C286D7AD4D66}']
  procedure DisableClose;
  procedure DisableReactivate;
 end;//IafwFloatingWindow

 IafwSettingsSource = interface(IafwBase)
  {* ������, ������� �������� � �����������. }
  ['{00A4BB1F-77DB-4112-B607-FF533DCF6BD3}']
  function pm_GetSettings: IafwSettings;
  procedure pm_SetSettings(const aValue: IafwSettings);
  function pm_GetBaseId: AnsiString;
  procedure pm_SetBaseId(const aValue: AnsiString);
  property Settings: IafwSettings
   read pm_GetSettings
   write pm_SetSettings;
   {* ��������� �������� ������������ �������. }
  property BaseId: AnsiString
   read pm_GetBaseId
   write pm_SetBaseId;
   {* ������� ������������� ���������. ������������ ��� ������ ����� ���� ��� ��������������� ��������. }
 end;//IafwSettingsSource

 (*
 MafwSettingsNotify = interface
  procedure AddListener(const aListener: IafwSettingListener); overload;
  procedure AddListener(const aListener: IafwSettingsReplaceListener); overload;
  procedure RemoveListener(const aListener: IafwSettingListener); overload;
  procedure RemoveListener(const aListener: IafwSettingsReplaceListener); overload;
 end;//MafwSettingsNotify
 *)

 {$If NOT Defined(NoVCL)}
 TafwCustomForm = TCustomForm;
 {$IfEnd} // NOT Defined(NoVCL)

 {$If NOT Defined(NoVCL)}
 IafwMainFormContainer = interface(IafwBase)
  ['{1A7F2DE9-5ED8-46F5-88C9-B5FD9AF1DEF4}']
  function Get_CurrentMainForm: TafwCustomForm;
  procedure UpdateFormCaption(aForm: TafwCustomForm);
  property CurrentMainForm: TafwCustomForm
   read Get_CurrentMainForm;
 end;//IafwMainFormContainer
 {$IfEnd} // NOT Defined(NoVCL)

 IafwMainFormProvider = interface(IafwBase)
  ['{86D8BAFB-92AB-45E0-8A82-5405716DF65A}']
 end;//IafwMainFormProvider

 {$If NOT Defined(NoVCL)}
 (*
 MafwVisualizater = interface
  function MakeLongProcessVisualizer(const aCaption: IafwCString;
   anAttachWnd: THandle = 0;
   anInitialTimeout: Cardinal = afw_lpwTimeout;
   anImageList: TafwCustomImageList = nil;
   anImageIndex: Integer = -1): IafwLongProcessVisualizer;
 end;//MafwVisualizater
 *)
 {$IfEnd} // NOT Defined(NoVCL)

 IafwApplication = interface(IafwBase)
  {* ������ ����������, ������� �� �������� ��������. }
  ['{6E54960B-A515-4FB2-869E-5F3EAF9F5DDB}']
  function pm_GetCurrentMainForm: IafwMainForm;
  function pm_GetSettings: IafwSettings;
  procedure pm_SetSettings(const aValue: IafwSettings);
  function pm_GetPrintManager: IafwPrintManager;
  procedure pm_SetPrintManager(const aValue: IafwPrintManager);
  function pm_GetUserQuery: IafwUserQuery;
  procedure pm_SetUserQuery(const aValue: IafwUserQuery);
  function pm_GetIsInternal: Boolean;
  function pm_GetLocaleInfo: IafwLocaleInfo;
  function Get_Data: IafwApplicationData;
  function Get_PermanentSettings: IafwSettingsPrim;
  function Get_TabInterfaceType: TafwTabInterfaceType;
  function IsTrialMode: Boolean;
  procedure ApplyActiveLanguage(const aTarget: IafwResources);
  procedure LockKeyBoard;
  procedure UnlockKeyBoard;
  function AskClearClipboardProc: TafwAskClearClipboardProc;
  {$If NOT Defined(NoVCL)}
  function MakeLongProcessVisualizer(const aCaption: IafwCString;
   anAttachWnd: THandle = 0;
   anInitialTimeout: Cardinal = afw_lpwTimeout;
   anImageList: TafwCustomImageList = nil;
   anImageIndex: Integer = -1): IafwLongProcessVisualizer;
  {$IfEnd} // NOT Defined(NoVCL)
  property CurrentMainForm: IafwMainForm
   read pm_GetCurrentMainForm;
   {* ������� �������� �����. }
  property Settings: IafwSettings
   read pm_GetSettings
   write pm_SetSettings;
   {* ��������� �������� ������������ �������. }
  property PrintManager: IafwPrintManager
   read pm_GetPrintManager
   write pm_SetPrintManager;
   {* �������� ������. }
  property UserQuery: IafwUserQuery
   read pm_GetUserQuery
   write pm_SetUserQuery;
   {* "������" ��� ������� ������������. }
  property IsInternal: Boolean
   read pm_GetIsInternal;
   {* ���������� ������ ���������� (����������, ������������). ���� ���� ����������, �� ������ ������������ ������ �������� � ����� ��������� ������� � ���������.
��������� ������������ ��������: OIT500019874. }
  property LocaleInfo: IafwLocaleInfo
   read pm_GetLocaleInfo;
   {* ���������� � ������. }
  property Data: IafwApplicationData
   read Get_Data;
   {* - ������ ����������. }
  property PermanentSettings: IafwSettingsPrim
   read Get_PermanentSettings;
  property TabInterfaceType: TafwTabInterfaceType
   read Get_TabInterfaceType;
 end;//IafwApplication

function TafwPagesInfo_E: TafwPagesInfo;
function TafwPagesInfo_H: TafwPagesInfo;
function TafwPagesInfo_Z: TafwPagesInfo;

implementation

uses
 l3ImplUses
;

function TafwPagesInfo_E: TafwPagesInfo;
//#UC START# *4CC6AD9E0250_4CC6A3D403D7_var*
//#UC END# *4CC6AD9E0250_4CC6A3D403D7_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4CC6AD9E0250_4CC6A3D403D7_impl*
 Result.rPagesCount := -1;
 Result.rOverallPagesCount := -1;
//#UC END# *4CC6AD9E0250_4CC6A3D403D7_impl*
end;//TafwPagesInfo_E

function TafwPagesInfo_H: TafwPagesInfo;
//#UC START# *4CC6B48F01FD_4CC6A3D403D7_var*
//#UC END# *4CC6B48F01FD_4CC6A3D403D7_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4CC6B48F01FD_4CC6A3D403D7_impl*
 Result.rPagesCount := High(Result.rPagesCount);
 Result.rOverallPagesCount := High(Result.rOverallPagesCount);
//#UC END# *4CC6B48F01FD_4CC6A3D403D7_impl*
end;//TafwPagesInfo_H

function TafwPagesInfo_Z: TafwPagesInfo;
//#UC START# *4CC6B8FE0293_4CC6A3D403D7_var*
//#UC END# *4CC6B8FE0293_4CC6A3D403D7_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4CC6B8FE0293_4CC6A3D403D7_impl*
 Result.rPagesCount := 0;
 Result.rOverallPagesCount := 0;
//#UC END# *4CC6B8FE0293_4CC6A3D403D7_impl*
end;//TafwPagesInfo_Z

function TafwPagesInfo.IsValid: Boolean;
//#UC START# *4CC6B0320014_4CC6A3D403D7_var*
//#UC END# *4CC6B0320014_4CC6A3D403D7_var*
begin
//#UC START# *4CC6B0320014_4CC6A3D403D7_impl*
 Result := (rPagesCount > 0) AND (rOverallPagesCount > 0);
//#UC END# *4CC6B0320014_4CC6A3D403D7_impl*
end;//TafwPagesInfo.IsValid

function TafwPagesInfo.Add(const anAdder: TafwPagesInfo): TafwPagesInfo;
//#UC START# *4CC6B588002A_4CC6A3D403D7_var*
//#UC END# *4CC6B588002A_4CC6A3D403D7_var*
begin
//#UC START# *4CC6B588002A_4CC6A3D403D7_impl*
 Result.rPagesCount := Self.rPagesCount + anAdder.rPagesCount;
 Result.rOverallPagesCount := Self.rOverallPagesCount + anAdder.rOverallPagesCount;
//#UC END# *4CC6B588002A_4CC6A3D403D7_impl*
end;//TafwPagesInfo.Add

end.
