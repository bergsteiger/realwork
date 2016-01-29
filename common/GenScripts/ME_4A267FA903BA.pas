unit evHotSpot;

interface

uses
 l3IntfUses
 , k2ProcTagTool
 , nevGUIInterfaces
 , nevTools
 , afwInterfaces
;

type
 TevHotSpot = class(Tk2ProcTagTool)
  procedure DoHitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
 end;//TevHotSpot
 
implementation

uses
 l3ImplUses
;

end.
