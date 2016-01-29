unit vtDateEditRes;

interface

uses
 l3IntfUses
 , Graphics
 , l3StringIDEx
 , l3Date
;

type
 TvtBeforeCorrectDate = procedure(const aDate: AnsiString) of object;
 
 // TvtMonths
 
implementation

uses
 l3ImplUses
 , l3MessageID
 , Windows
;

end.
