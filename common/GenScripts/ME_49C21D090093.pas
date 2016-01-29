unit evMergedCellFilter;

interface

uses
 l3IntfUses
 , k2TagFilter
 , evCellsOffsets
 , evdTypes
 , k2Base
 , l3Variant
;

type
 TevNeedAddTextPara = (
  ev_natNo
  , ev_natYes
  , ev_natWaitMergeStatus
 );//TevNeedAddTextPara
 
 TevMergedCellFilter = class(Tk2TagFilter)
  {* фильтр дл€ преобразовани€ "подвисших" €чеек объединени€ в нормальный вид. }
  function CellsOffsets: TevCellsOffsets;
  function IsTableCell: Boolean;
  procedure CheckCellWidth;
   {* ѕровер€ет ширину €чейки и, если надо корректирует еЄ. }
 end;//TevMergedCellFilter
 
implementation

uses
 l3ImplUses
 , l3Base
 , Table_Const
 , TableRow_Const
 , TableCell_Const
 , k2Tags
 , SBSCell_Const
 , l3UnitsTools
;

end.
