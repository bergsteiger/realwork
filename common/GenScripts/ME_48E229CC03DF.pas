unit evEditorWindowHotSpot;

interface

uses
 l3IntfUses
 , l3Tool
 , nevGUIInterfaces
 , nevTools
 , nevBase
 , l3Interfaces
 , l3Base
 , afwInterfaces
 , l3IID
;

type
 TevForeignHotSpotMode = (
  ev_fhsmNone
  , ev_fhsmDisabled
  , ev_fhsmEnabled
 );//TevForeignHotSpotMode
 
 TevEditorWindowHotSpot = class(Tl3Tool, IevAdvancedHotSpot, IevHotSpot)
  procedure DoBeforeSelection(const aView: InevControlView);
   {* Запоминает точку начала выделения }
  function NeedSelectCursor(const aView: InevControlView;
   const aPt: TnevPoint): Boolean;
   {* Проверяет корректность выделения при движении мыши и, если
             выделение заканчивается за пределами параграфа-виджета, то
             возвращаемся к запомненной в DoBeforeSelection точке }
  function CheckCursorPos(const aView: InevView): Boolean;
   {* Вызывается для проверки позиционирования курсора и/или окончания
             выделения. Срабатывает после отпускания кнопки мыши, если
             управление не было перехвачено самим виджетом }
  function DoLButtonDoubleClick(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
  function DoLButtonDown(const aView: InevControlView;
   const aKeys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
  procedure Create(const anOwner: Il3ToolOwner;
   const aForeignHotSpot: IevHotSpot);
  function Make(const anOwner: Il3ToolOwner;
   const aForeignHotSpot: IevHotSpot): IevHotSpot;
  function DoMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState): Boolean;
   {* Обрабатывает движение мыши, после нажатия левой кнопки }
  function TryDragDrop(const aKeys: TevMouseState): Boolean;
  procedure TranslatePt(const aView: InevControlView;
   const aKeys: TevMouseState);
   {* транслирует точку aPt в ClickCursor или StartMark.
             Если транслируется в StartMark, то FinishMark = ClickCursor }
  procedure AlignMarks(const aView: InevControlView;
   const aKeys: TevMouseState);
   {* "выравнивает" StartMark и FinishMark - например на границу слова }
  procedure ExtendBlock(const aView: InevControlView);
   {* устанавливает StartMark и FinishMark в выделение }
  procedure DoExtendBlock(const aView: InevControlView;
   const aSelection: InevSelection);
   {* устанавливает StartMark и FinishMark в выделение }
  function DoLButtonUp(const aView: InevControlView;
   const aKeys: TevMouseState;
   aNeedUnselect: Boolean): Boolean;
   {* обрабатывает отпускание левой кнопки мыши }
  function BeginMouseOp(const aView: InevControlView;
   out theSelection: Tl3Base): InevOp;
   {* начало операторных скобок. Для закрытия скобки надо освободить OpPack.
             theSelection - объект, содержащий выделение, его надо освобождать
             процедурой l3Free в секции finally }
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* обрабатывает событие от мыши. Возвращает true - если обработано, иначе - false }
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
  function CanDrag: Boolean;
 end;//TevEditorWindowHotSpot
 
implementation

uses
 l3ImplUses
 , evCustomEditorWindow
 , evTypes
 , l3InternalInterfaces
 , evMsgCode
 , evDataObject
 , SysUtils
 , evOp
 , evExcept
 , Classes
 , l3Variant
;

end.
