unit evControlParaHotSpot;

interface

uses
 l3IntfUses
 , k2TagTool
 , nevGUIInterfaces
 , nevTools
 , evQueryCardInt
 , l3Variant
 , afwInterfaces
 , l3Units
;

type
 TevControlParaHotSpot = class(Tk2TagTool, IevMouseMoveHandler, IevHotSpot)
  {* –еализаци€ "гор€чей точки" дл€ параграфа, представл€ющего контрол ввода }
  function PtInButton(const aPt: TafwPoint): Boolean;
   {* ўелчок по кнопке редактора }
  function PtInCtrButton(const aPt: Tl3Point): Boolean;
   {* ўелчок по кнопке-параграфу }
  function PtInPara(const aPt: TafwPoint): Boolean;
  function PtToPara(const aPt: TafwPoint): Tl3Point;
   {* переводит из глобальных координат в координаты параграфа }
  procedure TrySendToGroup(aTag: Tl3Variant);
  procedure CheckMapValid(const aView: InevControlView);
  procedure Create(const aMap: InevMap;
   aTagWrap: Tl3Variant);
  function Make(const aMap: InevMap;
   aTagWrap: Tl3Variant): IevHotSpot;
   {* ‘абричный метод }
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  function TransMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState;
   out theActiveElement: InevActiveElement): Boolean;
   {* —обственно реальный MouseMove, передаваемый редактору }
  function MouseMove(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ќбрабатывает перемещение мыши }
  function LButtonDown(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ќбрабатывает нажатие левой кнопки мыши }
  function LButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ќбрабатывает отпускание левой кнопки мыши }
  function LButtonDoubleClick(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ќбрабатывает двойное нажатие левой кнопки мыши }
  function RButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ќбрабатывает нажатие правой кнопки мыши }
  function RButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ќбрабатывает отпускание правой конопки мыши }
  function MButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ќбрабатывает нажатие колеса мыши }
  function MButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ќбрабатывает отпускание колеса мыши }
  function CanDrag: Boolean;
 end;//TevControlParaHotSpot
 
implementation

uses
 l3ImplUses
 , evdTypes
 , SysUtils
 , evControlParaConst
 , evMsgCode
 , k2Tags
 , ControlsBlock_Const
 , evParaTools
;

end.
