unit l3Diff;

interface

uses
 l3IntfUses
;

type
 Tl3DiffCompareFunc = function(I: Integer;
  J: Integer): Boolean;
 
 Tl3DiffOperation = (
  l3diffSame
  , l3diffDeleted
  , l3diffAdded
 );//Tl3DiffOperation
 
 Tl3DiffReportRec = record
 end;//Tl3DiffReportRec
 
 Tl3DiffReportProc = procedure(const aRR: Tl3DiffReportRec);
 
implementation

uses
 l3ImplUses
 , Math
 , l3Base
;

end.
