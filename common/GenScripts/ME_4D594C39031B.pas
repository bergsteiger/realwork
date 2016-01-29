unit evTextParaHeaderHotSpot;

interface

uses
 l3IntfUses
 , evHotSpot
 , nevGUIInterfaces
 , nevTools
 , nevBase
 , afwInterfaces
 , l3StringIDEx
;

type
 TevTextParaHeaderHotSpot = class(TevHotSpot, IevHotSpot)
  {* HotSpot на заголовок параграфа }
  procedure Create(const aPara: InevPara;
   const aProcessor: InevProcessor);
  function Make(const aPara: InevPara;
   const aProcessor: InevProcessor): IevHotSpot;
  procedure DoCollapse(const aView: InevControlView);
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
 end;//TevTextParaHeaderHotSpot
 
implementation

uses
 l3ImplUses
 , l3MessageID
 , evParaTools
 , k2Tags
 , evdStyles
;

end.
