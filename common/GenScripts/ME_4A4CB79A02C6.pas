unit l3CanvasPrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , l3InternalInterfaces
 , l3PrinterInterfaces
 , l3Units
 , l3RectList
 , Windows
 , l3LongintList
 , l3Defaults
;

type
 Tl3OpenPageResult = (
  l3_oprNo
  , l3_oprYes
  , l3_oprEndDoc
 );//Tl3OpenPageResult
 
 Tl3DrawFlag = (
  ev_dfDrawCursor
  , ev_dfDrawRegion
  , ev_dfDrawSpecial
  , ev_dfPrinting
  , ev_dfSelfStarted
  , ev_dfPrinted
 );//Tl3DrawFlag
 
 TevDrawFlags = set of Tl3DrawFlag;
 
 TevDCFlag = (
  {* флаги способа получения Handle канвы }
  ev_dcfCanvas
  , ev_dcfGot
  , ev_dcfCreated
  , ev_dcfLinked
 );//TevDCFlag
 
 Tl3DeviceCaps = record
  {* Информация об устройстве вывода }
 end;//Tl3DeviceCaps
 
 Tl3CanvasPrim = class(Tl3ProtoObject, Il3PageSetup)
  function CalcPrintableArea: Tl3_Rect;
  procedure DrawSub(aSubTarget: TObject;
   const R: Tl3Rect;
   LayerHandle: Integer;
   aSub: TObject);
  procedure UpdatePixelsPerInch;
  function GetIsPagesCounter: Boolean;
  function GetGlobalClipRectWithZoom: Tl3Rect;
  function DoGetPageSetupWidth: Tl3Inch;
  function DoGetPageSetupHeight: Tl3Inch;
  function DoGetDrawEnabled: Boolean;
  function DeviceCaps(anIndex: Integer): Integer;
  function GetPrinting: Boolean;
  function AsIl3Canvas: Il3Canvas;
  procedure AssignDeviceCaps;
   {* Инициализировать информацию об устройстве }
  function DoGetPaperWidth: Tl3Inch;
  function PageNumber: Integer;
   {* номер страницы в высоту. }
  function PageWidthNumber: Integer;
   {* номер страницы в ширину. }
  function Width: Tl3Inch;
   {* ширина печатаемой области. }
  function Height: Tl3Inch;
   {* высота печатаемой области. }
  function PaperWidth: Tl3Inch;
   {* ширина бумаги. }
  function PaperHeight: Tl3Inch;
   {* высота бумаги. }
  function Margins: Tl3_Rect;
   {* Поля от края листа (с учетом непечатаемой области) }
  function DP2LP(const aP: Tl3_SPoint): Tl3Point;
   {* Преобразует точку в пикселях в точку в дюймах }
  function IsPagesCounter: Boolean;
  function OverallPageNumber: Integer;
  function InitialDCOffset: Tl3Point;
  function PushClipRect: Tl3Rect;
  procedure PopClipRect;
  function ClipRegion: Il3Region;
  function LineSpacing: Integer;
   {* Интерлиньяж в процентах от размера строки }
  procedure PushLineSpacing;
  procedure PopLineSpacing;
  function InitialDCOffsetStored: Tl3Point;
 end;//Tl3CanvasPrim
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , l3Math
 , l3Const
 , SysUtils
;

end.
