unit evRow;

// Модуль: "w:\common\components\gui\Garant\Everest\evRow.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevRow" MUID: (4FC493C90289)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedEditableCursors)}
uses
 l3IntfUses
 {$If Defined(k2ForEditor)}
 , evCustomParaListUtils
 {$IfEnd} // Defined(k2ForEditor)
 , evEditorInterfaces
 , nevTools
 , l3Variant
 , nevBase
 , evEditorInterfacesTypes
;

type
 TevRow = class({$If Defined(k2ForEditor)}
 TevTableChild
 {$IfEnd} // Defined(k2ForEditor)
 , IedRow)
  protected
   function pm_GetTable: IedTable;
   function pm_GetCellsIterator: IedCellsIterator;
   function AnalizeRowCells: TedRowType;
  public
   class function Make(const aView: InevView;
    const aTable: IedTable;
    aTagWrap: Tl3Variant;
    const aProcessor: InevProcessor;
    const aLocation: InevLocation = nil): IedRow;
 end;//TevRow
{$IfEnd} // Defined(evNeedEditableCursors)

implementation

{$If Defined(evNeedEditableCursors)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evCellsIterator
 {$IfEnd} // Defined(k2ForEditor)
 , l3Base
 , evdTypes
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
;

{$If Defined(k2ForEditor)}
class function TevRow.Make(const aView: InevView;
 const aTable: IedTable;
 aTagWrap: Tl3Variant;
 const aProcessor: InevProcessor;
 const aLocation: InevLocation = nil): IedRow;
//#UC START# *4FC4942400EF_4FC493C90289_var*
var
 l_Row : TevRow;
//#UC END# *4FC4942400EF_4FC493C90289_var*
begin
//#UC START# *4FC4942400EF_4FC493C90289_impl*
 l_Row := Create(aView, aTable, aTagWrap, aProcessor, aLocation);
 try
  Result := l_Row;
 finally
  l3Free(l_Row);
 end;//try..finally
//#UC END# *4FC4942400EF_4FC493C90289_impl*
end;//TevRow.Make

function TevRow.pm_GetTable: IedTable;
//#UC START# *4BBC94CF038F_4FC493C90289get_var*
//#UC END# *4BBC94CF038F_4FC493C90289get_var*
begin
//#UC START# *4BBC94CF038F_4FC493C90289get_impl*
 Result := GetTable;
//#UC END# *4BBC94CF038F_4FC493C90289get_impl*
end;//TevRow.pm_GetTable

function TevRow.pm_GetCellsIterator: IedCellsIterator;
//#UC START# *4BBC94F0016E_4FC493C90289get_var*
//#UC END# *4BBC94F0016E_4FC493C90289get_var*
begin
//#UC START# *4BBC94F0016E_4FC493C90289get_impl*
 Result := TevCellsIterator.Make(View, Self, TagInst, Processor, f_Location);
//#UC END# *4BBC94F0016E_4FC493C90289get_impl*
end;//TevRow.pm_GetCellsIterator

function TevRow.AnalizeRowCells: TedRowType;
//#UC START# *4FC49F620379_4FC493C90289_var*
const
 cnMinCellsCount4ChessTableRow = 4;
 cnMinDelta4ChessTaqbleRow = 3;
var
 l_Cell          : IedCell;
 l_Index         : Integer;
 l_WasHead       : Boolean;
 l_RowWidth      : Integer;
 l_CellType      : TedCellType;
 l_Iterator      : IedCellsIterator;
 l_FirstCell     : IedCell;
 l_CellsCount    : Integer;
 l_EmptyCount    : Integer;
 l_AverageWidth  : Integer;
 l_ContinueCount : Integer;
 l_AverWidthCount: Integer;
//#UC END# *4FC49F620379_4FC493C90289_var*
begin
//#UC START# *4FC49F620379_4FC493C90289_impl*
 Result := ed_rtNull;
 if TagInst.ChildrenCount = 1 then
  Result := ed_rtSingleCell
 else
 begin
  l_Iterator := pm_GetCellsIterator;
  try
   l_Cell := l_Iterator.First(False);
   l_FirstCell := l_Cell;
   l_Index := 1;
   Result := ed_rtNumericCels;
   l_EmptyCount := 0;
   l_RowWidth := 0;
   l_WasHead := False;
   l_ContinueCount := 0;
   l_AverageWidth := 0;
   l_AverWidthCount := 0;
   l_CellsCount := l_Iterator.CellsCount;
   while l_Cell <> nil do
   begin
    if l_Cell.MergeStatus <> ev_msNone then
    begin
     Result := ed_rtHasMergedCell;
     if l_Cell.MergeStatus = ev_msHead then l_WasHead := True;
     if not l_WasHead and (l_Cell.MergeStatus = ev_msContinue) then Inc(l_ContinueCount);
    end; // if l_Cell.MergeStatus <> ev_msNone then
    if Result <> ed_rtHasMergedCell then
    begin
     if Pos('____', l_Cell.GetFirstLineText) > 0 then
     begin
      Result := ev_rtFormCells;
      Break;
     end; // if Pos('____', l_Cell.GetFirstLineText) then
     if (l_Index <> l_Cell.TextAsInteger) and (Result = ed_rtNumericCels) then
      Result := ed_rtSimpleWithoutEmpty;
    end; // if Result <> ed_HasMergedCell then
    if l_Cell.IsEmptyCell then
    begin
     Inc(l_EmptyCount);
     if Result <> ed_rtHasMergedCell then
      Result := ed_rtSimpleCells;
    end; // if l_Cell.IsEmptyCell then
    l_CellType := l_Cell.GetCellType;
    if (Result in [ed_rtSimpleCells, ed_rtHasMergedCell]) and (l_CellType = ed_ctSmallText) then
     if evEqualOffset(l_AverageWidth, l_Cell.Width) then
      Inc(l_AverWidthCount)
     else
     begin
      if l_AverWidthCount <= 1 then
      begin
       l_AverageWidth := l_Cell.Width;
       l_AverWidthCount := 1;
      end // if l_AverWidthCount <= 1 then
     end
    else
     l_AverageWidth := 0;
    Inc(l_RowWidth, l_Cell.Width);
    l_Cell := l_Iterator.Next;
    Inc(l_Index);
   end; // while l_Cell <> nil do
   if (Result = ed_rtSimpleCells) and ((l_CellsCount - l_EmptyCount) = 1) then
    if not l_FirstCell.IsEmptyCell and (l_FirstCell.Width > l_RowWidth div 2) then
     Result := ed_rtPsevdoSingleCells;
   if (Result = ed_rtSimpleCells) and (l_CellsCount = l_EmptyCount) then
    Result := ed_rtSimpleEmptyCells;
   if (Result in [ed_rtSimpleCells, ed_rtHasMergedCell]) and (l_CellsCount > cnMinCellsCount4ChessTableRow) and ((l_CellsCount - l_AverWidthCount) <= cnMinDelta4ChessTaqbleRow) then
    Result := ed_rtChessTableRow;
   if Result = ed_rtHasMergedCell then
    if l_WasHead and (l_ContinueCount = 0) then
     Result := ed_rtHasHeadCells
    else
     if not l_WasHead and (l_ContinueCount > 0) and ((l_CellsCount - l_EmptyCount - l_ContinueCount) = 1) then
      Result := ed_rtEmptyWithContnueCells;
  finally
   l_Iterator := nil;
  end;
 end; // if l_CellsCount > 1 then
//#UC END# *4FC49F620379_4FC493C90289_impl*
end;//TevRow.AnalizeRowCells
{$IfEnd} // Defined(k2ForEditor)

{$IfEnd} // Defined(evNeedEditableCursors)
end.
