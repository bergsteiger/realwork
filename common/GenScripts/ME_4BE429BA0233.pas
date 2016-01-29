unit PreviewTestBefore235875079;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , afwInterfaces
 , nevShapesPaintedSpy
 , afwPreviewPageSpy
 , evHAFPainterEx
 , PrimTextLoad_Form
 , nevTools
 , afwPreviewPage
;

type
 TPreviewTestBefore235875079 = class(TTextEditorVisitor, IafwPreviewPanel, InevShapesLogger, IafwPagesLogger)
  {* Тест построения Preview }
  function PageFileName(aNumber: Integer;
   aWidthNumber: Integer;
   aCounter: Boolean;
   anEtalon: Boolean): AnsiString;
   {* Имя файла для сохранения страницы }
  function IsBefore235875079: Boolean;
  function IsBefore278833302: Boolean;
  function OnlyCheckPageCount: Boolean;
  procedure ReadColontituls(var theColontituls: TevColontituls);
  function GetHAFFontSize: Integer;
   {* Размер колонтитулов. 0 - по-умолчанию }
  procedure SetCurrentPage(aValue: Integer);
  procedure Invalidate;
  procedure Done;
  function PreviewCanvas: IafwPreviewCanvas;
  function Painted: Boolean;
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
  function OpenLog(const aView: InevView): AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
  function LogScreen(const aView: InevView): Boolean;
  procedure LogPage(aPage: TafwPreviewPage;
   aCounter: Boolean);
  function ShouldStop: Boolean;
  procedure IncCounterPageNumer;
 end;//TPreviewTestBefore235875079
 
implementation

uses
 l3ImplUses
 , Windows
 , evStyleInterface
 , evdStyles
 , SysUtils
 , vtPreviewPanel
 , Controls
 , Forms
 , l3String
 , l3Stream
 , l3Types
 , imageenio
 , l3FileUtils
 , Graphics
 , Classes
 , KTestRunner
 , evPreviewForTestsTuning
 , l3Defaults
 , l3CanvasPrim
 , TestFrameWork
;

end.
