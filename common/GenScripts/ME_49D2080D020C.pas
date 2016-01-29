unit nevRealTools;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
 , l3InternalInterfaces
 , l3Variant
;

type
 InevBaseTool = InevBase;
  {* Базовый инструмент }
 
 TnevShapeArea = object
  {* Область вывода }
 end;//TnevShapeArea
 
 TnevShapeInfo = record
  {* Информация об отрисованном объекте. }
 end;//TnevShapeInfo
 
 TnevShapePoints = record
  {* Данные для отображения. }
 end;//TnevShapePoints
 
 TnevShapeAreaEx = object(TnevShapeArea)
 end;//TnevShapeAreaEx
 
 PnevShapeArea = ^TnevShapeArea;
  {* Указатель на область вывода }
 
 InevDrawingShape = interface(InevTool)
  {* Визуально отображаемый объект умеющий себя рисовать. }
  function Draw(const anArea: TnevShapeArea;
   const aPoints: TnevShapePoints;
   out theInfo: TnevShapeInfo): Boolean;
 end;//InevDrawingShape
 
 TevParaMarkStyle = (
  {* Стиль рисования конца параграфа }
  ev_pmUsial
  , ev_pmCell
 );//TevParaMarkStyle
 
 InevPaintersHolder = interface
  {* Интерфейс для поддержки отложенного рисования. [$89096971]. [$89096991] }
  procedure RemeberSelPart(const aChildMap: InevMap;
   aSelection: Boolean);
   {* Запомнить прямоугольник для отрисовки. }
  procedure SetHeight(aHeight: Integer);
 end;//InevPaintersHolder
 
 TnevCheckType = (
  {* вид проверки отрисованности }
  nev_None
   {* не проверять }
  , nev_CheckOnly
   {* только проверка }
  , nev_NeedAdd
   {* проверить и добавить новое значение }
 );//TnevCheckType
 
 IevTablePainter = interface
  {* Интерфейс инструмента рисования таблицы. }
  procedure CheckCell(aPara: Tl3Tag;
   aCheckType: TnevCheckType);
  procedure CalcOffset;
   {* Пересчитать смещение для следующей ячейки }
  function WasPainted(aPara: Tl3Tag;
   anPID: Integer;
   aForLines: Boolean): Boolean;
   {* Проверка была ли отрисована начальная ячейка объединения. }
  function HasOwnStyle: Boolean;
 end;//IevTablePainter
 
 IevTableRowPainter = interface
  {* Интерфейс инструмента рисования строки. }
  function CheckChildren(const aFI: TnevFormatInfoPrim;
   const aCanvas: Il3Canvas): Boolean;
   {* [$219123966] }
  procedure CorrectTopDelta(var aDelta: Integer);
  function IsTopAnchorAtStart: Boolean;
  function GetTopAnchor4Row: InevBasePoint;
   {* Возвращает указатель на строку из View.TopAnchor }
 end;//IevTableRowPainter
 
 IevPainter = interface(InevDrawingShape)
  {* Интерфейс инструментов для рисования объектов. }
  function IsSelectedOneWholePara(const aPara: InevPara): Boolean;
 end;//IevPainter
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
