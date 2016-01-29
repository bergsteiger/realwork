unit evDocumentPreviewPrim;

interface

uses
 l3IntfUses
 , nevObjectHolderPrim
 , afwInterfaces
 , nevTools
 , l3InternalInterfaces
 , nevBase
 , Windows
 , l3Interfaces
 , l3TimeEstimation
 , afwPreviewNotifierPtrList
 , l3Variant
 , k2TagGen
 , nevRealTools
 , l3PrinterInterfaces
 , afwTypes
 , l3Units
 , k2DocumentBuffer
 , afwPreviewCanvas
 , l3Core
;

type
 TevDocumentPreviewPrim = class(_afwSettingChanged_, IafwDocumentPreview, IafwPreviewNotificationSource, IevDocumentPreviewInfo, Il3AbortChecker)
  {* ��������������� �������� ������ ��������� }
  procedure DoPrint;
   {* ���������� ������� ������ }
  function GetText: InevObject;
   {* �������� ����� ��������� ��� ��������� }
  function GetPreviewCanvas(const aPagesInfo: TafwPagesInfo;
   aCounter: Boolean): IafwPreviewCanvas;
   {* �������������� ����������� ����� }
  procedure TryClose;
   {* �������� �������� ������ � ������� ���� }
  procedure AbortPreviewPrepare;
   {* ���������� ���������� � �������� ������ - ���-�� ���������� � ���� ��� ������������ ������ }
  function CurrentPageForUpdate: Integer;
  function GetPreviewForCurrentPage: IafwPreviewCanvas;
  procedure NotifyPreviewSubscribers;
  procedure DoSetFilters(var theGenerator: Tk2TagGenerator);
  function HasPreviewBuilder: Boolean;
  procedure Create(const aText: InevStorable;
   const aKey: TevPreviewCacheKey;
   const aHAF: IafwHAFPainter); overload;
  procedure Create(const aText: InevDocumentProvider;
   const aKey: TevPreviewCacheKey;
   const aHAF: IafwHAFPainter); overload;
  procedure UnformatView(const aView: InevView);
   {* ���������� ���������� � �������������� ��� ����������� View }
  procedure Print2PDF(const aCanvas: Il3Canvas);
  procedure SetFilters(var theGenerator: Tk2TagGenerator);
  procedure ClearPreview;
  function InClose: Boolean;
  function PrePrint(anIndex: Integer): TafwPagesInfo;
  procedure ProgressProcEv(aState: Byte;
   aValue: Integer;
   const aMsg: AnsiString);
  procedure CheckAborted(var Aborted: Boolean);
  function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
  procedure AfterPrint;
  function NeedAddBlockNames: Boolean;
   {* ����� �� ��������� ����� ������ }
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
  function HasText: Boolean;
   {* ���� �� ����� ��� ������. }
  procedure Subscribe(const aNotifier: IafwPreviewNotifier);
  procedure UnSubscribe(const aNotifier: IafwPreviewNotifier);
  function HAFMacroReplacer: IafwHAFMacroReplacer;
  function Preview: IafwDocumentPreview;
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function GetTagReader: InevTagReader;
  function GetTagWriter: InevTagWriter;
  function CacheKey: TevPreviewCacheKey;
  procedure DoGetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
   {* ���������� ������� ��������� ���������� }
  function IsAborted: Boolean;
 end;//TevDocumentPreviewPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Printer
 , evPreviewProcessor
 , k2Tags
 , l3Base
 , l3MinMax
 , nevInterfaces
 , l3String
 , l3Math
 , l3Defaults
 , l3Const
 , evExcept
 , evParaDrawTools
 , Graphics
 , l3SimpleObject
 , evdBlockNameAdder
 , nevDocumentProvider
 , evPreviewForTestsTuning
 , PrintRowHeightsSpy
 , l3FileUtils
 , evCustomPrintDataSaver
 , afwAnswer
 , l3BatchService
 , afwFacade
 , afwSettingsChangePublisher
 , k2Except
 , Forms
 , afwCanvasEx
 , nevPrintView
 , l3Prg
 , DecorTextPara_Const
 , PageBreak_Const
 , Table_Const
 , SectionBreak_Const
 , evSectionPara
 , evAbortFilter
 , l3Except
 , evMsgCode
 , Messages
 , evHiddenFilter
 , evdPageParamsFilter
;

end.
