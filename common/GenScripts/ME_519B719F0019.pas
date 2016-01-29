unit ddTable;

interface

uses
 l3IntfUses
 , ddTablePrim
 , ddCustomDestination
;

type
 TddTable = class(TddTablePrim)
  procedure ClearRows;
 end;//TddTable
 
implementation

uses
 l3ImplUses
;

end.
