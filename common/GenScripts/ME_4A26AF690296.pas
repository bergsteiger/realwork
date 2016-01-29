unit evTextParaHotSpotTester;

interface

uses
 l3IntfUses
 , k2TagTool
 , nevGUIInterfaces
 , l3Variant
 , nevTools
 , evSegmentHotSpot
;

type
 RevSegmentClass = class of TevSegmentHotSpot;
 
 TevTextParaHotSpotTester = class(Tk2TagTool, InevHotSpotTester2)
  function GetSegmentClass: RevSegmentClass;
  procedure Make(aTag: Tl3Variant);
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
 end;//TevTextParaHotSpotTester
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , k2Base
 , l3Units
 , l3Types
 , evTextParaHeaderHotSpot
 , evdStyles
 , evParaCollapser
 , evDecorHotSpot
 , l3String
 , evTextParaTools
 , evExpandedTextCollapser
 , evArchiCollapser
 , evAACContentUtils
;

end.
