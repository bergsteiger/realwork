unit evHotSpotMisc;

interface

uses
 l3IntfUses
 , nevGUIInterfaces
 , nevTools
 , evInternalInterfaces
 , l3ProtoObject
 , afwInterfaces
 , l3Interfaces
;

type
 TevHotSpotWrap = class(Tl3ProtoObject, IevAdvancedHotSpot, IevHotSpot)
  procedure Create(const aHotSpot: IevAdvancedHotSpot;
   const aView: InevControlView); overload;
  function Make(const aHotSpot: IevAdvancedHotSpot;
   const aView: InevControlView): IevHotSpot; overload;
  procedure Create(const aHotSpot: IevAdvancedHotSpot;
   const aHotSpotSink: IevHotSpotSink); overload;
  function Make(const aHotSpot: IevAdvancedHotSpot;
   const aHotSpotSink: IevHotSpotSink): IevHotSpot; overload;
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
 end;//TevHotSpotWrap
 
implementation

uses
 l3ImplUses
 , l3Base
 , Classes
 , l3InterfacesMisc
 , SysUtils
;

end.
