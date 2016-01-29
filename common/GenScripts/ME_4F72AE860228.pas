unit kwPrintDataSaver;

interface

uses
 l3IntfUses
 , evCustomPrintDataSaver
 , afwInterfaces
 , nevShapesPaintedSpy
 , afwPreviewPageSpy
 , tfwScriptingInterfaces
 , nevTools
 , afwPreviewPage
;

type
 TkwPrintDataSaver = class(TevCustomPrintDataSaver, IafwPreviewPanel, InevShapesLogger, IafwPagesLogger)
  {* ������ ������� ��������� ���������� ������ � ����. }
  function PageFileName(aNumber: Integer;
   aWidthNumber: Integer;
   aCounter: Boolean;
   anEtalon: Boolean): AnsiString;
  procedure ClearFields;
  procedure StartWaitingToPrint(const aCtx: TtfwContext);
  procedure EndWatingToPrint;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure SetCurrentPage(aValue: Integer);
  procedure Invalidate;
  procedure Done;
  function PreviewCanvas: IafwPreviewCanvas;
  function Painted: Boolean;
  function OpenLog(const aView: InevView): AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
  function LogScreen(const aView: InevView): Boolean;
  procedure LogPage(aPage: TafwPreviewPage;
   aCounter: Boolean);
  function ShouldStop: Boolean;
  function GetPanel: IafwPreviewPanel;
  procedure CheckResult;
  function IsWaitingPrint: Boolean;
  procedure IncCounterPageNumer;
 end;//TkwPrintDataSaver
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , imageenio
 , Graphics
 , Classes
 , l3FileUtils
 , Windows
;

end.
