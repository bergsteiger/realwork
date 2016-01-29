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
  {* Предварительный просмотр печати документа }
  procedure DoPrint;
   {* Собственно процесс печати }
  function GetText: InevObject;
   {* Получаем текст документа для просмотра }
  function GetPreviewCanvas(const aPagesInfo: TafwPagesInfo;
   aCounter: Boolean): IafwPreviewCanvas;
   {* Подготавливает виртуальную канву }
  procedure TryClose;
   {* Пытается прервать печать и закрыть окно }
  procedure AbortPreviewPrepare;
   {* Прекратить подготовку и очистить превью - что-то поменялось и надо его переделывать заново }
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
   {* Сбрасывает информацию о форматировании для конкретного View }
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
   {* Нужно ли добавлять имена блоков }
  function DocumentName: IafwCString;
   {* имя документа для preview. }
  function InProcess: Boolean;
   {* идет процесс? }
  function InPagesCounting: Boolean;
   {* сейчас в процессе подсчета страниц? }
  function InUpdate: Boolean;
   {* находимся в процессе построения preview? }
  function InPrinting: Boolean;
   {* находимся в процессе построения печати? }
  procedure Update(const aPanel: IafwPreviewPanel);
   {* установить preview на панель для отображения. }
  procedure Print(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager;
   aCopies: Integer;
   const aFileName: AnsiString;
   aCollate: Boolean);
   {* напечатать на принтер. }
  procedure Stop(aWnd: THandle);
   {* остановит процесс построение preview/печати. }
  function Stopped: Boolean;
   {* процесс остановлен? }
  function CloseRequested: Boolean;
   {* при остановке процесса был запрос на закрытие превью }
  function PreviewResetting: Boolean;
   {* канва отсутствует, но будет передалываться }
  procedure SetCurrentPage(const aCursor: IUnknown);
   {* устанавливает курсор на текущую страницу. }
  procedure SetCurrentPagePara(aParaID: Integer);
   {* устанавливает курсор на текущую страницу. }
  procedure SetCurrentPageNumber(aPageNumber: Integer);
   {* устанавливает курсор на текущую страницу. }
  function CurrentPage: Integer;
   {* текущая страница для печати. }
  function HasCurrentPage: Boolean;
   {* установлена ли текущая страница. }
  function HasText: Boolean;
   {* есть ли текст для печати. }
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
   {* Собственно процесс получения информации }
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
