unit nevNodeView;

interface

uses
 l3IntfUses
 , nevBaseDetachedView
 , nevObjectHolder
 , nevTools
;

type
 TnevNodeView = class(TnevBaseDetachedView)
  procedure Create(const aNode: InevObject;
   const aCanvas: InevCanvas);
  function Make(const aNode: InevObject;
   const aCanvas: InevCanvas): InevView;
 end;//TnevNodeView
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
