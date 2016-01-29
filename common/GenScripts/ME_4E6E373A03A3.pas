unit evParaListHotSpotTesterPrim;

interface

uses
 l3IntfUses
 , evHotSpot
 , nevGUIInterfaces
 , nevTools
 , l3Variant
 , nevBase
;

type
 TevParaListHotSpotTesterPrim = class(_nevParaListTool_, InevHotSpotTester2)
  function GetChildHotSpot(const aView: InevControlView;
   const aState: TevCursorState;
   const aPt: InevBasePoint;
   const aMap: InevMap;
   const aChild: InevObject;
   out theSpot: IevHotSpot): Boolean;
  procedure Create(aTag: Tl3Variant;
   const aProcessor: InevProcessor);
  function Make(aTag: Tl3Variant;
   const aProcessor: InevProcessor): InevHotSpotTester2;
  function DoGetAdvancedHotSpot(const aView: InevControlView;
   const aState: TevCursorState;
   const aPt: InevBasePoint;
   const aMap: InevMap;
   out theSpot: IevHotSpot): Boolean;
  function GetAdvancedHotSpot(const aView: InevControlView;
   const aState: TevCursorState;
   const aPt: InevBasePoint;
   const aMap: InevMap;
   out theSpot: IevHotSpot): Boolean;
   {* Возвращает "горячую точку" }
 end;//TevParaListHotSpotTesterPrim
 
implementation

uses
 l3ImplUses
 , evDecorHotSpot
 , evParaTools
 , SysUtils
;

end.
