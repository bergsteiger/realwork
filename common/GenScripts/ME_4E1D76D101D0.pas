unit evHotSpotProxy;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevGUIInterfaces
 , nevTools
 , afwInterfaces
 , l3Interfaces
;

type
 TevHotSpotProxy = class(Tl3CProtoObject, IevMouseMoveHandler, IevHotSpot)
  procedure Create(const aHotSpot: IevHotSpot);
  function Make(const aHotSpot: IevHotSpot): IevHotSpot;
  function DoLButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
  function DoLButtonDoubleClick(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
  function DoTransMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState;
   out theActiveElement: InevActiveElement): Boolean;
  function DoLButtonDown(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
  function DoMButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  function TransMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState;
   out theActiveElement: InevActiveElement): Boolean;
   {* Собственно реальный MouseMove, передаваемый редактору }
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
 end;//TevHotSpotProxy
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
;

end.
