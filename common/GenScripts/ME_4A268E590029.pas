unit evSegmentHotSpot;

interface

uses
 l3IntfUses
 , evHotSpot
 , afwNavigation
 , nevGUIInterfaces
 , nevTools
 , l3Variant
 , nevBase
 , afwInterfaces
 , l3Units
 , l3IID
;

type
 TevSegmentPlacement = (
  {* Положение курсора относительно сегмента }
  ev_spNone
  , ev_spLeft
  , ev_spBody
  , ev_spRight
 );//TevSegmentPlacement
 
 TevSegmentHotSpot = class(TevHotSpot, IevMoniker, IevMouseMoveHandler, IevHotSpot)
  {* Горячая точка для сегмента оформления текстового параграфа }
  function TryDoHyperlink(const aView: InevControlView;
   anEffects: TafwJumpToEffects): Boolean;
  function IsHyperlink: Boolean;
  procedure GetHyperLink;
   {* Возвращает гиперссылку, от продолжения на данном сегменте }
  function GetPlacement: TevSegmentPlacement;
  procedure ChangeBorder(const aTag: InevObject;
   aPosition: Integer;
   const aPack: InevOp);
  procedure CanChangeBorderPrim;
  function CanChangeBorder(const aView: InevControlView;
   const aPt: Tl3Point;
   out aPlacement: TevSegmentPlacement): Boolean;
  procedure TryToSelectHypelink(const aView: InevControlView);
  function GetDownPointPara: InevPara;
  procedure Create(const aDownPoint: InevBasePoint;
   aTarget: Tl3Variant;
   aLayerHandle: Integer;
   const aProcessor: InevProcessor);
  function Make(const aDownPoint: InevBasePoint;
   aTarget: Tl3Variant;
   aLayerHandle: Integer;
   const aProcessor: InevProcessor): IevHotSpot;
   {* Сознаёт горячую точку для сегмента }
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
 end;//TevSegmentHotSpot
 
implementation

uses
 l3ImplUses
 , nevNavigation
 , l3Base
 , evHotSpotMisc
 , nevInterfaces
 , evHyperlink
 , evInternalInterfaces
 , Classes
 , Segment_Const
 , evSegLst
 , l3Const
 , nevActiveHyperlink
 , evParaTools
 , evAACContentUtils
 , SysUtils
 , evdStyles
 , k2Tags
 , k2Base
 , evdTypes
 , HyperLink_Const
;

type
 TEffectMap = array [Boolean] of TafwJumpToEffects;
 
end.
