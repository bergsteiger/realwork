unit nevRealTools;
 {* Реальные инструменты для работы с EVD документами (в отличии от nevTools - куда свалено всё подряд). Инструмент получается методом QT, и ТОЛЬКО им }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevRealTools.pas"
// Стереотип: "Interfaces"
// Элемент модели: "nevRealTools" MUID: (49D2080D020C)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

uses
 l3IntfUses
 , l3Types
 , nevBase
 , l3InternalInterfaces
 , nevTools
 , nevViewInterfaces
 , l3Variant
;

type
 InevBaseTool = InevBase;
  {* Базовый инструмент }

 PnevShapeArea = ^TnevShapeArea;
  {* Указатель на область вывода }

 TnevShapeArea = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Область вывода }
  public
   rView: HnevView;
    {* Область вывода }
   rCanvas: Hl3Canvas;
    {* Канва для рисования }
   rNeedBottom: Boolean;
    {* Нужно ли вычислять rBottom }
 end;//TnevShapeArea

 TnevShapeInfo = record
  {* Информация об отрисованном объекте. }
  rMap: InevMap;
   {* Карта форматирования. }
  rBottom: InevBasePoint;
   {* Точка указывающая за последний отрисованный элемент объекта. }
  rCalculatedHeight: Integer;
   {* Посчтианная высота оставшейся части таблицы, для использования на следующих страницах. }
  rCellBottom: InevBasePoint;
   {* Продолжение объедиенной ячейки (если есть). }
 end;//TnevShapeInfo

 TnevShapePoints = record
  {* Данные для отображения. }
  rTop: InevBasePoint;
   {* Точка начала отображения. }
  rCaret: InevBasePoint;
   {* Точка, в которой надо рисовать каретку. }
  rSelection: InevRange;
   {* Выделенные участки. }
  rPrevHeight: Integer;
   {* Высота оставшейся части таблицы, вычисленная на при печати предыдущих страниц. }
  rRealTop: InevBasePoint;
   {* Точка, которая реально отрисовывается в этом месте (начало объедиения). }
  rFake: Boolean;
   {* Фейковая точка. }
  rCheckCaret: InevBasePoint;
   {* Каретка для проверки в дочерних }
  rCheckSelection: InevRange;
   {* Выделение для проверки дочерними. }
 end;//TnevShapePoints

 TnevShapeAreaEx = {$IfDef XE4}record{$Else}object(TnevShapeArea){$EndIf}
  public
   {$If Defined(XE4)}
   rTnevShapeArea: TnevShapeArea;
   {$IfEnd} // Defined(XE4)
  public
   procedure Init(const aView: InevView;
    const aCanvas: Il3Canvas;
    aNeedBottom: Boolean); overload;
   procedure Init(const anArea: TnevShapeArea); overload;
   procedure Free;
    {* Освобождает запись }
 end;//TnevShapeAreaEx

 InevDrawingShape = interface(InevTool)
  {* Визуально отображаемый объект умеющий себя рисовать. }
  ['{7EB9B9FF-B988-4F9B-9D6F-13730A7BDD39}']
  function Draw(const anArea: TnevShapeArea;
   const aPoints: TnevShapePoints;
   out theInfo: TnevShapeInfo): Boolean;
 end;//InevDrawingShape

 TevParaMarkStyle = (
  {* Стиль рисования конца параграфа }
  ev_pmUsial
  , ev_pmCell
 );//TevParaMarkStyle

 IevPainter = interface;

 InevPaintersHolder = interface(InevBaseTool)
  {* Интерфейс для поддержки отложенного рисования. [$89096971]. [$89096991] }
  ['{98A8C324-A25A-412A-8028-FF614D4C7756}']
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

 IevTablePainter = interface(InevBaseTool)
  {* Интерфейс инструмента рисования таблицы. }
  ['{1F693F22-31C3-49CE-BDCE-7E9001DC432C}']
  procedure CheckCell(aPara: Tl3Tag;
   aCheckType: TnevCheckType = nev_None);
  procedure CalcOffset;
   {* Пересчитать смещение для следующей ячейки }
  function WasPainted(aPara: Tl3Tag;
   anPID: Integer;
   aForLines: Boolean): Boolean;
   {* Проверка была ли отрисована начальная ячейка объединения. }
  function HasOwnStyle: Boolean;
 end;//IevTablePainter

 IevTableRowPainter = interface(InevBaseTool)
  {* Интерфейс инструмента рисования строки. }
  ['{DF548913-37DF-44B8-8C6A-67A83D991141}']
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
  ['{60FC0B5C-FC01-47F4-9FAB-9AE04B1520DE}']
  function pm_GetCurrentBlock: InevRange;
  function pm_GetDrawingTopmostChild: Boolean;
  function pm_GetDrawingLastChild: Boolean;
  function pm_GetParaMarkStyle: TevParaMarkStyle;
  procedure pm_SetParaMarkStyle(aValue: TevParaMarkStyle);
  function pm_GetParentPainter: IevPainter;
  procedure pm_SetParentPainter(const aValue: IevPainter);
  function Get_PaintersHolder: InevPaintersHolder;
  function Get_TablePainter: IevTablePainter;
  function Get_TableRowPainter: IevTableRowPainter;
  function IsSelectedOneWholePara(const aPara: InevPara): Boolean;
  property CurrentBlock: InevRange
   read pm_GetCurrentBlock;
  property DrawingTopmostChild: Boolean
   read pm_GetDrawingTopmostChild;
   {* рисуется самый верхний ребенок? }
  property DrawingLastChild: Boolean
   read pm_GetDrawingLastChild;
   {* рисуется самый последний ребенок? }
  property ParaMarkStyle: TevParaMarkStyle
   read pm_GetParaMarkStyle
   write pm_SetParaMarkStyle;
   {* Стиль рисования конца параграфа. }
  property ParentPainter: IevPainter
   read pm_GetParentPainter
   write pm_SetParentPainter;
   {* инструмент для рисования объекта более верхнего уровня. }
  property PaintersHolder: InevPaintersHolder
   read Get_PaintersHolder;
  property TablePainter: IevTablePainter
   read Get_TablePainter;
  property TableRowPainter: IevTableRowPainter
   read Get_TableRowPainter;
   {* Инструмент для рисования строки таблицы (доступен только при отрисовке строки). }
 end;//IevPainter

implementation

uses
 l3ImplUses
 , l3Base
;

procedure TnevShapeAreaEx.Init(const aView: InevView;
 const aCanvas: Il3Canvas;
 aNeedBottom: Boolean);
//#UC START# *4A4B359D0072_4A4B3579038F_var*
//#UC END# *4A4B359D0072_4A4B3579038F_var*
begin
//#UC START# *4A4B359D0072_4A4B3579038F_impl*
 l3FillChar(Self, SizeOf(Self));
 // - обходим очередной глюк компилятора
 {$IfDef XE4}rTnevShapeArea.{$EndIf}rView.Init(aView);
 {$IfDef XE4}rTnevShapeArea.{$EndIf}rCanvas.Init(aCanvas);
 {$IfDef XE4}rTnevShapeArea.{$EndIf}rNeedBottom := aNeedBottom;
//#UC END# *4A4B359D0072_4A4B3579038F_impl*
end;//TnevShapeAreaEx.Init

procedure TnevShapeAreaEx.Init(const anArea: TnevShapeArea);
//#UC START# *4A4B35A1004C_4A4B3579038F_var*
//#UC END# *4A4B35A1004C_4A4B3579038F_var*
begin
//#UC START# *4A4B35A1004C_4A4B3579038F_impl*
 l3FillChar(Self, SizeOf(Self));
 // - обходим очередной глюк компилятора
 {$IfDef XE4}rTnevShapeArea.{$EndIf}rView.Init(anArea.rView.As_InevView);
 {$IfDef XE4}rTnevShapeArea.{$EndIf}rCanvas.Init(anArea.rCanvas.As_Il3Canvas);
 {$IfDef XE4}rTnevShapeArea.{$EndIf}rNeedBottom := anArea.rNeedBottom;
//#UC END# *4A4B35A1004C_4A4B3579038F_impl*
end;//TnevShapeAreaEx.Init

procedure TnevShapeAreaEx.Free;
 {* Освобождает запись }
//#UC START# *4A4B35A400CE_4A4B3579038F_var*
//#UC END# *4A4B35A400CE_4A4B3579038F_var*
begin
//#UC START# *4A4B35A400CE_4A4B3579038F_impl*
 {$IfDef XE4}rTnevShapeArea.{$EndIf}rView.Free;
 {$IfDef XE4}rTnevShapeArea.{$EndIf}rCanvas.Free;
 inherited;
//#UC END# *4A4B35A400CE_4A4B3579038F_impl*
end;//TnevShapeAreaEx.Free

end.
