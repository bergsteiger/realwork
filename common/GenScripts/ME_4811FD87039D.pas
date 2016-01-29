unit nevVirtualView;

interface

uses
 l3IntfUses
 , nevBaseDrawView
 , nevBase
;

type
 TnevVirtualView = class(TnevBaseDrawView)
  {* Виртуальная область вывода. }
 end;//TnevVirtualView
 
implementation

uses
 l3ImplUses
 , l3VirtualCanvas
;

end.
