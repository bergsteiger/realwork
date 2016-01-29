unit nevHAFPainterView;

interface

uses
 l3IntfUses
 , nevVirtualDrawView
 , nevTools
 , nevObjectHolder
 , nevBase
;

type
 TnevHAFPainterView = class(TnevVirtualDrawView)
  procedure Create(const aText: InevObjectList;
   const aCanvas: InevCanvas);
  function Make(const aText: InevObjectList;
   const aCanvas: InevCanvas): InevView;
 end;//TnevHAFPainterView
 
implementation

uses
 l3ImplUses
 , nevBaseDetachedView
 , SysUtils
;

end.
