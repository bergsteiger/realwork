unit dd_lcTableEliminator;

interface

uses
 l3IntfUses
 , k2TagFilter
 , evdBufferedFilter
;

type
 TlcTableEliminator = class(Tk2TagFilter)
 end;//TlcTableEliminator
 
 TlcTableEliminator2 = class(TevdCustomChildBufferedFilter)
 end;//TlcTableEliminator2
 
implementation

uses
 l3ImplUses
;

end.
