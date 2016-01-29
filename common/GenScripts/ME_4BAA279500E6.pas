unit nevRangePrim;

interface

uses
 l3IntfUses
 , evLocation
 , nevTools
;

type
 TnevRangePrim = class(TevLocation, InevRangePrim)
  {* Выделенная часть объекта }
 end;//TnevRangePrim
 
implementation

uses
 l3ImplUses
 , evSelection
 , nevFacade
;

end.
