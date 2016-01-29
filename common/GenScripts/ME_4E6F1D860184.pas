unit evDecorHotSpotTester.imp;

interface

uses
 l3IntfUses
 , l3Variant
 , nevGUIInterfaces
 , nevTools
 , nevBase
;

type
 _evDecorHotSpotTester_ = class
  function GetDecorHotSpot(aType: TnevDecorType;
   const aView: InevControlView;
   const aState: TevCursorState;
   const aMap: InevMap;
   out theSpot: IevHotSpot): Boolean;
 end;//_evDecorHotSpotTester_
 
implementation

uses
 l3ImplUses
;

end.
