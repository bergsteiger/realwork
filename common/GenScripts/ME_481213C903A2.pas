unit nevVirtualDrawView;

interface

uses
 l3IntfUses
 , nevBaseDetachedView
 , evdStyles
 , nevBase
 , nevTools
;

type
 TnevVirtualDrawView = class(TnevBaseDetachedView)
  procedure Create(const aText: InevObject;
   aParentFI: TnevFormatInfoPrim;
   const aCanvas: InevCanvas;
   const aViewMetrics: InevViewMetrics);
  function Make(const aText: InevObject;
   aParentFI: TnevFormatInfoPrim;
   const aCanvas: InevCanvas;
   const aViewMetrics: InevViewMetrics): InevView;
 end;//TnevVirtualDrawView
 
implementation

uses
 l3ImplUses
;

end.
