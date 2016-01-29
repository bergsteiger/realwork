unit evControlsBlockHotSpotTesterPrim;

interface

uses
 l3IntfUses
 , evDocumentPartHotSpotTester
 , nevGUIInterfaces
 , nevTools
 , evQueryCardInt
 , l3Units
 , afwInterfaces
;

type
 TContrBlockActFlags = (
  ev_cbNoAction
  , ev_cbMainSurface
  , ev_cbButton
 );//TContrBlockActFlags
 
 TevControlsBlockHotSpotTesterPrim = class(TevDocumentPartHotSpotTester, IevMouseMoveHandler)
  function GetControl: IevQueryGroup;
  function PtToPara(const aPt: TafwPoint): Tl3Point;
  function MouseInBtn(const aPt: Tl3Point): Boolean;
  function TransMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState;
   out theActiveElement: InevActiveElement): Boolean;
   {* Собственно реальный MouseMove, передаваемый редактору }
 end;//TevControlsBlockHotSpotTesterPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evControlsBlockConst
;

end.
