unit evVisualInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , Controls
 , nevTools
;

type
 IevToolWindow = interface
  procedure Scroll(iD: Tl3Inch);
  procedure Invalidate;
 end;//IevToolWindow
 
 IevLinkedToolWindow = interface(IevToolWindow)
 end;//IevLinkedToolWindow
 
 IevZoomedLinkedToolWindow = interface(IevLinkedToolWindow)
 end;//IevZoomedLinkedToolWindow
 
 IevSubPanel = interface(IevZoomedLinkedToolWindow)
  procedure NeedDrawSub(const aR: Tl3Rect;
   const aSub: IevSub);
 end;//IevSubPanel
 
 TevOnSetMarker = procedure(aSender: TObject;
  const aMarker: IevMarker;
  aValue: Integer) of object;
 
 IevRuler = interface(IevZoomedLinkedToolWindow)
  procedure MarkersChanged(const aView: InevView;
   const aCursor: IevMarkersSource);
  procedure ViewChanged(const aView: InevView);
  procedure ControlMoved;
 end;//IevRuler
 
implementation

uses
 l3ImplUses
;

end.
