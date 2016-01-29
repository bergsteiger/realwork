unit evParaInterfaceFactoryPrim;

interface

uses
 l3IntfUses
 , k2InterfaceFactory
 , l3Variant
 , l3IID
;

type
 TevParaInterfaceFactoryPrim = class(Tk2InterfaceFactory)
 end;//TevParaInterfaceFactoryPrim
 
implementation

uses
 l3ImplUses
 , k2ToolPrim
 , nevTools
 , evdInterfaces
 , SysUtils
 , l3InterfacesMisc
 , evSelection
 , evCursor
;

end.
