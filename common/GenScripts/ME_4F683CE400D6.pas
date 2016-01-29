unit ddVirtualTable;

interface

uses
 l3IntfUses
 , ddTable
 , ddTableConvTypes
 , ddCustomDestination
;

type
 TddVirtualTable = class(TddTable)
  procedure Restructure(NewCellCount: Integer);
 end;//TddVirtualTable
 
implementation

uses
 l3ImplUses
 , l3UnitsTools
 , l3MinMax
 , l3Base
 , ddTableRow
 , ddTextParagraph
;

end.
