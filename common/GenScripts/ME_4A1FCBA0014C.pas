unit nevGUIInterfaces;

interface

uses
 l3IntfUses
 , nevTools
 , afwInterfaces
 , l3Interfaces
;

 (*
 MnevHotSpotHint = interface
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
 end;//MnevHotSpotHint
 *)
 
type
 InevHotSpotHint = interface
  {* Интерфейс для части объекта, имеющей собственную подсказку (Hint) }
  function CanDrag: Boolean;
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
 end;//InevHotSpotHint
 
 IevHotSpot = interface(InevHotSpotHint)
  {* Интерфейс для части объекта, обрабатывающей действия мышью.
      Для обратной совместимости. Сейчас лучше использовать IevAdvancedHotSpot }
  function MouseMove(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* Обрабатывает перемещение мыши }
  function LButtonDown(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* Обрабатывает нажатие левой кнопки мыши }
  function LButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* Обрабатывает отпускание левой кнопки мыши }
  function LButtonDoubleClick(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* Обрабатывает двойное нажатие левой кнопки мыши }
  function RButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* Обрабатывает нажатие правой кнопки мыши }
  function RButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* Обрабатывает отпускание правой конопки мыши }
  function MButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* Обрабатывает нажатие колеса мыши }
  function MButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* Обрабатывает отпускание колеса мыши }
 end;//IevHotSpot
 
 InevHotSpotTester2 = interface
  {* Интерфейс для получения "горячей точки" ([InevHotSpot]) }
  function GetAdvancedHotSpot(const aView: InevControlView;
   const aState: TevCursorState;
   const aPt: InevBasePoint;
   const aMap: InevMap;
   out theSpot: IevHotSpot): Boolean;
   {* Возвращает "горячую точку" }
 end;//InevHotSpotTester2
 
 IevMouseMoveHandler = interface
  {* Обработчик движения мыши }
  function TransMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState;
   out theActiveElement: InevActiveElement): Boolean;
   {* Собственно реальный MouseMove, передаваемый редактору }
 end;//IevMouseMoveHandler
 
 TevObjectArea = (
  {* Часть объекта (в частности в которую попали мышью) }
  ev_oaNone
  , ev_oaLeftEdge
  , ev_oaRightEdge
  , ev_oaTopEdge
  , ev_oaBottomEdge
  , ev_oaCollapse
  , ev_oaProperties
  , ev_oaDragPoint
  , ev_oaHeader
 );//TevObjectArea
 
 IevHotSpotDelta = interface
  {* Точность "горячей точки" (IevAdvancedHotSpot) }
  function Delta: Integer;
   {* точность }
 end;//IevHotSpotDelta
 
 IevAdvancedHotSpot = interface(InevHotSpotHint)
  {* Интерфейс для части объекта, обрабатывающей действия мышью }
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* обрабатывает событие от мыши. Возвращает true - если обработано, иначе - false }
 end;//IevAdvancedHotSpot
 
 IevHotSpotSink = interface
  {* Callback-интерфейс, определяющий пользовательскую реакцию на действие мышью в пределах aHotSpot }
  function MouseAction(const aHotSpot: IevHotSpot;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TafwMouseState;
   var Effect: TafwMouseEffect): Boolean;
   {* Обрабатывает операцию мышью для aHotSpot. Возвращает true - если обработано, иначе - false }
 end;//IevHotSpotSink
 
implementation

uses
 l3ImplUses
;

end.
