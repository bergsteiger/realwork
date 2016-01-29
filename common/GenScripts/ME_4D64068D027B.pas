unit evReqGroupHotSpotTester;

interface

uses
 l3IntfUses
 , evTableHotSpot
 , nevTools
 , nevGUIInterfaces
 , evHotSpot
 , l3Variant
 , k2Interfaces
 , l3Interfaces
 , afwInterfaces
;

type
 TevReqGroupHotSpot = class(TevHotSpot, IevAdvancedHotSpot)
  function Make(aTag: Tl3Variant;
   const aProcessor: Ik2Processor): IevAdvancedHotSpot;
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* обрабатывает событие от мыши. Возвращает true - если обработано, иначе - false }
  function CanDrag: Boolean;
 end;//TevReqGroupHotSpot
 
 TevReqGroupHotSpotTester = class(TevTableHotSpotTester)
 end;//TevReqGroupHotSpotTester
 
implementation

uses
 l3ImplUses
 , evHotSpotMisc
 , k2Tags
 , l3Units
 , l3Const
 , l3MinMax
 , ReqGroup_Const
 , SysUtils
;

end.
