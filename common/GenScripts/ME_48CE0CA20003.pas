unit nevTableCell;

interface

uses
 l3IntfUses
 , nevParaList
 , nevTools
 , l3Variant
 , nevBase
;

type
 TnevTableCell = class(TnevParaList, InevTableCell)
  function FindCell(const aRow: InevPara): InevPara;
  function Make(aTag: Tl3Variant): InevTableCell;
  function GetMergeHead(anIgnoreMergeStatus: Boolean): InevTableCell;
   {* Возвращает первую ячейку в объединении. }
  function GetContinueCell(aNeedValidate: Boolean;
   aWhereFind: TnevFindCell): InevTableCell;
   {* Возвращает нижнюю ячейку объединения, если такая существует. }
  function GetContinueCellInRow(const aRow: InevPara;
   aWhereFind: TnevFindCell): InevTableCell;
  function GetHeadCellPara(anIgnoreMergeStatus: Boolean): InevPara;
  function GetContinueCellPara(aNeedValidate: Boolean;
   aWhereFind: TnevFindCell): InevPara;
  function CheckCellWidth(aValue: Integer;
   aOuterWidth: Integer): Integer;
  function IsEmptyCell: Boolean;
  function GetUpperCell: InevPara;
   {* Возвращает ячейку сверху. }
 end;//TnevTableCell
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , nevFacade
 , k2Base
 , evDef
 , l3MinMax
 , evConst
 , evTableCellUtils
 , l3UnitsTools
;

end.
