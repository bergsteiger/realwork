unit ddTablePrim;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTablePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTablePrim" MUID: (4FACE16602E1)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddRowList
 , ddTableRow
 , ddTextParagraph
 , ddTableCell
 , ddCellProperty
 , ddTypes
 , l3Base
 , ddRowProperty
 , ddParagraphProperty
 , ddPicture
 , ddCustomDestination
 , k2Interfaces
 , l3ProtoObject
;

type
 TddTablePrim = class(TddDocumentAtom)
  private
   f_EtalonRow: TddTableRow;
   f_RowList: TddRowList;
   f_Level: Integer;
   f_Scale: Integer;
   f_Width: Integer;
   f_LeftIndent: Integer;
   f_Nested: Boolean;
   f_IsPercent: Boolean;
   f_IsSBS: Boolean;
   f_Style: Integer;
  private
   function GetLineLen(const aText: Tl3String): Integer;
   function FindPrevRowWithCellProps(aStartIndex: Integer): TddTableRow;
   procedure CorrectParaLevelAfterCloseTable(aParaProp: TddParagraphProperty);
    {* Уменьшает уровень текущего параграфа на 1, чтобы следующие даннные добавлялись на уровень выше. }
   procedure Try2AlignRowWidth(aRow: TddTableRow);
  protected
   function pm_GetLastRow: TddTableRow;
   function pm_GetRows(anRowID: Integer): TddTableRow;
   function pm_GetRowCount: Integer;
   procedure ProcessTableRow(aRow: TddTableRow;
    aPrevRow: TddTableRow;
    anIndex: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetEmpty: Boolean; override;
  public
   procedure AddRow(aRow: TddTableRow); overload;
   procedure AddRow(anEmpty: Boolean); overload;
   procedure ClearLastRow;
   procedure CloneRow;
   procedure CloseCell;
   procedure AdjustWidth(aNewWidth: Integer);
   function LastParagraph: TddTextParagraph;
   function AddParaWithCheckingRow(const aPara: TddDocumentAtom;
    anAssign2Last: Boolean): TddDocumentAtom;
   procedure ApplyCellProperty(const aCellProp: TddCellProperty;
    aClearBorder: TddClearBoder);
   function GetLastNotClosedRow: TddTableRow;
   function Cells(aRowID: Integer;
    aCellID: Integer): TddTableCell;
   function CellsProps(aRowID: Integer;
    aCellID: Integer): TddCellProperty;
   procedure CheckLastRow(aNeedClone: Boolean);
   procedure CalculateCellsWidth;
   procedure CheckPercentCells(aRow: TddTableRow);
   procedure CheckSpanCells(aScaleCellWidth: Boolean;
    aDocTextWidth: Integer);
   procedure NormalizeCells;
   procedure CloseRow;
   procedure CloseTable(aScaleCellWidth: Boolean;
    aDocTextWidth: Integer);
   function BeforeParseCell: TddTableRow;
   procedure CloseLastRow(aRowProp: TddRowProperty;
    aParaProp: TddParagraphProperty;
    out aLastRow: Boolean);
   procedure Try2CloseNotClosedRow(aWidth: Integer);
   function GetFirstRowWidth: Integer;
   function IsTableCorrect: Boolean;
    {* Проверяет таблицу на корректность. }
   procedure AddPicture(aPicture: TddPicture;
    aPAP: TddParagraphProperty;
    anAssign2Last: Boolean);
   function RowIndex(aRow: TddTableRow): Integer;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
   procedure Clear; override;
   constructor Create(aDetination: TddCustomDestination); override;
   function IsTable: Boolean; override;
   function GetLastPara: TddDocumentAtom; override;
   procedure Assign(const aDocAtomObj: Tl3ProtoObject); override;
  protected
   property RowList: TddRowList
    read f_RowList;
  public
   property Level: Integer
    read f_Level
    write f_Level;
   property Scale: Integer
    read f_Scale
    write f_Scale;
   property Width: Integer
    read f_Width
    write f_Width;
   property LeftIndent: Integer
    read f_LeftIndent
    write f_LeftIndent;
   property Nested: Boolean
    read f_Nested
    write f_Nested;
   property IsPercent: Boolean
    read f_IsPercent
    write f_IsPercent;
   property IsSBS: Boolean
    read f_IsSBS
    write f_IsSBS;
   property LastRow: TddTableRow
    read pm_GetLastRow;
   property Rows[anRowID: Integer]: TddTableRow
    read pm_GetRows;
    default;
   property RowCount: Integer
    read pm_GetRowCount;
   property Style: Integer
    read f_Style
    write f_Style;
 end;//TddTablePrim

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Math
 , l3Defaults
 , l3MinMax
 , l3UnitsTools
 , StrUtils
 , RTFtypes
 , ddEVDTypesSupport
 , l3Const
 , ddBase
 , ddBorder
 , ddConst
 //#UC START# *4FACE16602E1impl_uses*
 //#UC END# *4FACE16602E1impl_uses*
;

function TddTablePrim.pm_GetLastRow: TddTableRow;
//#UC START# *519B7458025F_4FACE16602E1get_var*
//#UC END# *519B7458025F_4FACE16602E1get_var*
begin
//#UC START# *519B7458025F_4FACE16602E1get_impl*
 if (f_RowList <> nil) and (f_RowList.Count > 0) then
  Result := f_RowList.Last
 else
  Result := nil;
//#UC END# *519B7458025F_4FACE16602E1get_impl*
end;//TddTablePrim.pm_GetLastRow

function TddTablePrim.pm_GetRows(anRowID: Integer): TddTableRow;
//#UC START# *519B7CC3008E_4FACE16602E1get_var*
//#UC END# *519B7CC3008E_4FACE16602E1get_var*
begin
//#UC START# *519B7CC3008E_4FACE16602E1get_impl*
 Result := f_RowList.Items[anRowID];
//#UC END# *519B7CC3008E_4FACE16602E1get_impl*
end;//TddTablePrim.pm_GetRows

function TddTablePrim.pm_GetRowCount: Integer;
//#UC START# *519B805901DF_4FACE16602E1get_var*
//#UC END# *519B805901DF_4FACE16602E1get_var*
begin
//#UC START# *519B805901DF_4FACE16602E1get_impl*
 Result := f_RowList.Count;
//#UC END# *519B805901DF_4FACE16602E1get_impl*
end;//TddTablePrim.pm_GetRowCount

procedure TddTablePrim.AddRow(aRow: TddTableRow);
//#UC START# *5193529401A7_4FACE16602E1_var*
//#UC END# *5193529401A7_4FACE16602E1_var*
begin
//#UC START# *5193529401A7_4FACE16602E1_impl*
 f_RowList.Add(aRow);
 aRow.TAP.Left:= LeftIndent;
//#UC END# *5193529401A7_4FACE16602E1_impl*
end;//TddTablePrim.AddRow

procedure TddTablePrim.AddRow(anEmpty: Boolean);
//#UC START# *519352D60008_4FACE16602E1_var*
var
 l_Row : TddTableRow;
//#UC END# *519352D60008_4FACE16602E1_var*
begin
//#UC START# *519352D60008_4FACE16602E1_impl*
 l_Row := TddTableRow.Create(f_Destination);
 try
  f_RowList.Add(l_Row);
  if anEmpty then
   l_Row.AddCellAndPara(True);
 finally
  FreeAndNil(l_Row);
 end;
//#UC END# *519352D60008_4FACE16602E1_impl*
end;//TddTablePrim.AddRow

procedure TddTablePrim.ClearLastRow;
//#UC START# *5193530901C8_4FACE16602E1_var*
var
 l_LastRow : TddTableRow;
//#UC END# *5193530901C8_4FACE16602E1_var*
begin
//#UC START# *5193530901C8_4FACE16602E1_impl*
 l_LastRow := GetLastNotClosedRow;
 if l_LastRow <> nil then
  l_LastRow.Clear;
//#UC END# *5193530901C8_4FACE16602E1_impl*
end;//TddTablePrim.ClearLastRow

procedure TddTablePrim.ProcessTableRow(aRow: TddTableRow;
 aPrevRow: TddTableRow;
 anIndex: Integer);
//#UC START# *519353210123_4FACE16602E1_var*
var
 l_CellProp: TddCellProperty;

 procedure lp_CheckBorder;
 var
  l_Index   : Integer;
  l_Count   : Integer;
  l_NextRow : TddTableRow;

  procedure lp_CheckRightCellProp;
  var
   l_NextProp: TddCellProperty;
  begin
   if l_Index < l_Count then
    l_NextProp := l_NextRow[l_Index + 1].Props
   else
    l_NextProp := nil;
   if (l_NextProp <> nil) and l_CellProp.Border.Frames[bpRight].Enable then
    if not l_NextProp.Border.Frames[bpLeft].Enable then
     l_NextProp.Border.Frames[bpLeft].Enable := True;
  end;

 var
  l_Prop    : TddCellProperty;
  l_RowID   : Integer;
  l_Border  : TddBorder;
  l_LastProp: TddCellProperty;
 begin
  l_Border := nil;
  for l_RowID := anIndex + 1 to RowCount - 1 do
  begin
   l_LastProp := nil;
   l_NextRow := Rows[l_RowID];
   l_Count := l_NextRow.CellCount - 1;
   for l_Index := 0 to l_Count do
   begin
    l_Prop := l_NextRow[l_Index].Props;
    if (l_CellProp.CellOffset = l_Prop.CellOffset) and l_Prop.VMerged then
    begin
     lp_CheckRightCellProp;
     l_LastProp := l_Prop;
     l_Border := l_Prop.Border;
     Break;
    end; // if (l_CellProp.Width = l_Prop.Width) and l_Prop.VMerged then
    if l_CellProp.CellOffset < l_Prop.CellOffset then Break;
   end; // for l_Index := 0 to l_NextRow.CellCount - 1 do
   if l_LastProp = nil then Break;
  end; // if anIndex > 0 then
  if (l_Border <> nil) and l_Border.Frames[bpBottom].Enable then
   l_CellProp.Border.Frames[bpBottom].Enable := True;
  if (l_Border <> nil) and not l_Border.Frames[bpLeft].Enable then
   l_CellProp.Border.Frames[bpLeft].Enable := False;
 end;

const
 cnStartCellID = -2;
var
 k          : Integer;
 l          : Integer;
 i          : Integer;
 l_PrevProp : TddCellProperty;
//#UC END# *519353210123_4FACE16602E1_var*
begin
//#UC START# *519353210123_4FACE16602E1_impl*
 l := cnStartCellID;
 // - чтобы упало, если не инициализировано
 if aRow.CellCount > 0 then
 begin
  // Коррекция флага "объединение по вертикали"
  if aPrevRow = nil then
   for i := 0 to aRow.CellCount - 1 do
   begin
    l_CellProp := aRow[i].Props;
    if l_CellProp.VMergeFirst then
     lp_CheckBorder;
   end // for i := 0 to aRow.CellCount - 1 do
  else
   for i := 0 to Pred(aRow.CellCount) do
   begin
    l_CellProp := aRow[i].Props;
    if l_CellProp.VMergeFirst and (i < aPrevRow.CellCount) then
    begin
     l_PrevProp := aPrevRow[i].Props;
     if (l_CellProp.CellOffset = l_PrevProp.CellOffset) then
      if l_PrevProp.VMergeFirst and not l_PrevProp.VMerged then
      begin
       l_PrevProp.VMergeFirst := False;
       l_CellProp.VMergeFirst := False;
       l_CellProp.VMerged := False;
      end // if l_PrevProp.VMergeFirst and not l_PrevProp.VMerged then
      else
      if (l_PrevProp.VMergeFirst) or (l_PrevProp.VMerged and aRow[i].Empty) then
      begin
       l_CellProp.VMergeFirst := False;
       l_CellProp.VMerged := True;
       // Добавить свои абзацы в верхнюю (самую?) ячейку
      end; // if (l_PrevProp.VMergeFirst) or (l_PrevProp.VMerged and aRow[i].Empty) then
    end; // if l_CellProp.VMergeFirst and (i < aPrevRow.CellCount) then
    if l_CellProp.VMergeFirst then
     lp_CheckBorder;
   end; // for i
 // Ищем и объединяем ячейки по горизонтали
  k := 0;
  while k < aRow.CellCount do
  begin
   if aRow.Cells[k].Props.MergeFirst then
   begin
    l := k;
    Inc(k);
   end // if aRow.Cells[k].Props.MergeFirst then
   else
    if aRow.Cells[k].Props.Merged and (l > cnStartCellID) then
    begin
     aRow.Cells[l].Props.CellOffset := aRow.Cells[k].Props.CellOffset;
     aRow.DeleteCell(k);
    end // if aRow.Cells[k].Props.Merged then
    else
     Inc(k);
  end; // for k
 end; // aRow.CellCount > 0
 if (aRow.CellCount = 1) and aRow[0].Props.VMergeFirst then
  with aRow[0].Props do
  begin
   VMergeFirst := False;
   VMerged := False;
  end; // with aRow[0].Props do
 Try2AlignRowWidth(aRow);
//#UC END# *519353210123_4FACE16602E1_impl*
end;//TddTablePrim.ProcessTableRow

procedure TddTablePrim.CloneRow;
//#UC START# *51935359008C_4FACE16602E1_var*
var
 i     : Integer;
 l_Row : TddTableRow;
//#UC END# *51935359008C_4FACE16602E1_var*
begin
//#UC START# *51935359008C_4FACE16602E1_impl*
 if GetLastNotClosedRow <> nil then
 begin
  l_Row := TddTableRow.Create(f_Destination);
  try
   l_Row.Assign(LastRow);
   l_Row.Closed := False;
   for i := 0 to Pred(l_Row.CellCount) do
    l_Row[i].Clear;
   f_RowList.Add(l_Row);
  finally
   FreeAndNil(l_Row);
  end;
 end // if LastRow <> nil then
 else // Нет ни абзаца, ни таблицы...
  AddRow(True);
//#UC END# *51935359008C_4FACE16602E1_impl*
end;//TddTablePrim.CloneRow

procedure TddTablePrim.CloseCell;
//#UC START# *519353720016_4FACE16602E1_var*
var
 l_LastRow : TddTableRow;
 l_LastCell: TddTableCell;
//#UC END# *519353720016_4FACE16602E1_var*
begin
//#UC START# *519353720016_4FACE16602E1_impl*
 l_LastRow := GetLastNotClosedRow;
 if l_LastRow = nil then
 begin
  CloneRow;
  l_LastRow := LastRow;
 end; // if LastRow = nil then
 l_LastCell := l_LastRow.GetLastNonClosedCell;
 if l_LastCell = nil then
 begin
  l_LastRow.AddEmptyCell;
  l_LastCell := l_LastRow.GetLastNonClosedCell;
 end; // if l_LastCell = nil then
 l_LastCell.Closed := True;
 l_LastRow.CellPropsCompleate := True;
//#UC END# *519353720016_4FACE16602E1_impl*
end;//TddTablePrim.CloseCell

procedure TddTablePrim.AdjustWidth(aNewWidth: Integer);
//#UC START# *5193538A0211_4FACE16602E1_var*
var
 i, j : Integer;
 l_R: TddTableRow;
 l_OldWidth : Integer;
//#UC END# *5193538A0211_4FACE16602E1_var*
begin
//#UC START# *5193538A0211_4FACE16602E1_impl*
 for i := 0 to RowList.Hi do
 begin
  l_R := TddTableRow(RowList.Items[i]);
  l_OldWidth := 0;
  for j := 0 to Pred(l_R.CellCount) do
  begin
   Inc(l_OldWidth, l_R.Cells[j].Props.CellOffset);
   if j > 0 then
    Dec(l_OldWidth, l_R.Cells[Pred(j)].Props.CellOffset);
  end; // for j
  if (l_OldWidth > aNewWidth) or (l_OldWidth = 0) then
   for j := 0 to Pred(l_R.CellCount) do
    l_R.Cells[j].Props.CellOffset := l3MulDiv(l_R.Cells[j].Props.CellOffset, aNewWidth, l_OldWidth);
 end; // for i
//#UC END# *5193538A0211_4FACE16602E1_impl*
end;//TddTablePrim.AdjustWidth

function TddTablePrim.LastParagraph: TddTextParagraph;
//#UC START# *519353B400B5_4FACE16602E1_var*
var
 l_Cell    : TddTableCell;
 l_LastRow : TddTableRow;
//#UC END# *519353B400B5_4FACE16602E1_var*
begin
//#UC START# *519353B400B5_4FACE16602E1_impl*
 Result := nil;
 l_LastRow := GetLastNotClosedRow;
 if l_LastRow <> nil then // иначе строка уже закончилась
 begin
  l_Cell := l_LastRow.GetLastNonClosedCell;
  if (l_Cell <> nil) and not l_Cell.Empty then
   Result := l_Cell.LastTextPara;
 end; // l_LastRow <> nil
//#UC END# *519353B400B5_4FACE16602E1_impl*
end;//TddTablePrim.LastParagraph

function TddTablePrim.AddParaWithCheckingRow(const aPara: TddDocumentAtom;
 anAssign2Last: Boolean): TddDocumentAtom;
//#UC START# *51935B02008F_4FACE16602E1_var*
var
 l_LastRow : TddTableRow;
 l_LastCell: TddTableCell;
//#UC END# *51935B02008F_4FACE16602E1_var*
begin
//#UC START# *51935B02008F_4FACE16602E1_impl*
 CheckLastRow(True);
 l_LastRow := GetLastNotClosedRow;
 Result := nil;
 if l_LastRow <> nil then
 begin
  l_LastCell := l_LastRow.GetLastNonClosedCell;
  if l_LastCell = nil then
  begin
   l_LastRow.AddEmptyCell;
   l_LastCell := l_LastRow.GetLastNonClosedCell;
  end; // if l_LastCell = nil then
  if l_LastCell <> nil then
   if aPara = nil then
    Result := l_LastCell.AddParagraph 
   else
   begin
    l_LastCell.Add(aPara, anAssign2Last);
    Result := aPara;
   end;
 end; // if l_LastRow <> nil then
//#UC END# *51935B02008F_4FACE16602E1_impl*
end;//TddTablePrim.AddParaWithCheckingRow

procedure TddTablePrim.ApplyCellProperty(const aCellProp: TddCellProperty;
 aClearBorder: TddClearBoder);
//#UC START# *51935B27022C_4FACE16602E1_var*
var
 l_LastRow : TddTableRow;
//#UC END# *51935B27022C_4FACE16602E1_var*
begin
//#UC START# *51935B27022C_4FACE16602E1_impl*
 if GetLastNotClosedRow = nil then
  AddRow(False);
 l_LastRow := LastRow;
 l_LastRow.AddCellProp(aCellProp, aClearBorder);
//#UC END# *51935B27022C_4FACE16602E1_impl*
end;//TddTablePrim.ApplyCellProperty

function TddTablePrim.GetLastNotClosedRow: TddTableRow;
//#UC START# *519B67FC0314_4FACE16602E1_var*
//#UC END# *519B67FC0314_4FACE16602E1_var*
begin
//#UC START# *519B67FC0314_4FACE16602E1_impl*
 Result := LastRow;
 if (Result <> nil) and Result.Closed then
  Result := nil;
//#UC END# *519B67FC0314_4FACE16602E1_impl*
end;//TddTablePrim.GetLastNotClosedRow

function TddTablePrim.Cells(aRowID: Integer;
 aCellID: Integer): TddTableCell;
//#UC START# *519B6E6E0351_4FACE16602E1_var*
//#UC END# *519B6E6E0351_4FACE16602E1_var*
begin
//#UC START# *519B6E6E0351_4FACE16602E1_impl*
 if (aRowID >= 0) and (aRowID < RowList.Count) and
    (aCellID >= 0) and (aCellID < TddTableRow(RowList.Items[aRowID]).CellCount) then
  Result := TddTableRow(RowList.Items[aRowID]).Cells[aCellID]
 else
  Result := nil;
//#UC END# *519B6E6E0351_4FACE16602E1_impl*
end;//TddTablePrim.Cells

function TddTablePrim.CellsProps(aRowID: Integer;
 aCellID: Integer): TddCellProperty;
//#UC START# *519B6EBD031F_4FACE16602E1_var*
//#UC END# *519B6EBD031F_4FACE16602E1_var*
begin
//#UC START# *519B6EBD031F_4FACE16602E1_impl*
  if (aRowID >= 0) and (aRowID < RowList.Count) and
     (aCellID >= 0) and (aCellID < TddTableRow(RowList[aRowID]).CellCount) then
   Result := TddTableRow(RowList[aRowID]).Cells[aCellID].Props
  else
   Result := nil;
//#UC END# *519B6EBD031F_4FACE16602E1_impl*
end;//TddTablePrim.CellsProps

procedure TddTablePrim.CheckLastRow(aNeedClone: Boolean);
//#UC START# *519B755501DD_4FACE16602E1_var*
//#UC END# *519B755501DD_4FACE16602E1_var*
begin
//#UC START# *519B755501DD_4FACE16602E1_impl*
 if GetLastNotClosedRow = nil then
  if aNeedClone then
   CloneRow
  else
   AddRow(True);
//#UC END# *519B755501DD_4FACE16602E1_impl*
end;//TddTablePrim.CheckLastRow

procedure TddTablePrim.CalculateCellsWidth;
//#UC START# *519C6553007B_4FACE16602E1_var*
var
 i: Integer;
 l_DocAtom: TddDocumentAtom;
 l_Row: TddTableRow;
 l_Cell: TddTableCell;
 RowIndex: Integer;
 CellIndex: Integer;
 l_CellWidth: LongInt;
 l_RowWidth: LongInt;
 l_P: TddTextParagraph;
 l_NeedAdjust: Boolean;
 l_TableWidth: Integer;
//#UC END# *519C6553007B_4FACE16602E1_var*
begin
//#UC START# *519C6553007B_4FACE16602E1_impl*
 l_RowWidth := 0;
 l_NeedAdjust := False;
 for RowIndex := 0 to RowCount - 1 do
 begin
   l_Row:= Rows[RowIndex];

   CheckPercentCells(l_Row);

   l_RowWidth := 0;
   for CellIndex := 0 to l_Row.CellCount - 1 do
   begin
    l_Cell := l_Row.Cells[CellIndex];

    if RowIndex = 0 then // Заполняем эталонную строку ячейками
     for i := 1 to l_Row.CellSpan[CellIndex] do
      f_EtalonRow.AddCellAndPara(True);

    if l_Row.CellWidth[CellIndex] = ddGetMinimalCellWidth then
    begin
     l_CellWidth := 0;
     for i := 0 to l_Cell.Hi do
     begin
      l_DocAtom := l_Cell.Items[i];
      if l_DocAtom is TddTextParagraph then
      begin
       l_P := l_DocAtom as TddTextParagraph;
       l_CellWidth := Max(GetLineLen(l_P.Text), l_CellWidth);
      end
      else
       l_CellWidth := Max((l_DocAtom as TddTablePrim).LastRow.TAP.Width, l_CellWidth);
     end; { for i }
     // Ширина ячейки в символах, переводим в дюймы
     l_Row.CellWidth[CellIndex]:= evChar2Inch(l_CellWidth) + ddDefaultCellWidth;
     l_NeedAdjust := True;
    end
    else
    // Перерассчитываем в дюймы ;
    begin
     if l_Row.Cells[CellIndex].Props.IsPercent then
      l_Row.CellWidth[CellIndex] := l3MulDiv(Width, l_Row.CellWidth[CellIndex], 100)
     else // Пикселы
      if l_Row.CellWidth[CellIndex] = propUndefined then
       l_Row.CellWidth[CellIndex] := ddDefaultCellWidth
      else
       l_Row.CellWidth[CellIndex] := 96 * (l_Row.CellWidth[CellIndex])* 144 div 100;
    end;
    Inc(l_RowWidth, l_Row.CellWidth[CellIndex]);
   end; // for CellIndex
   l_Row.TAP.Width := l_RowWidth;
 end; // Все ячейки имеют длину в шурадюймах

 // Корректируем ширины эталона по максимальной ширине ячеек
 f_EtalonRow.TAP.Width := 0;
 for CellIndex := 0 to Pred(f_EtalonRow.CellCount) do
 begin
   l_CellWidth := 0;
   // Находим максимальную ширину
   for RowIndex:= 0 to Pred(RowCount) do
   begin
    l_Row := Rows[RowIndex];
    l_CellWidth := Max(l_Row.CellWidthBySpan[CellIndex], l_CellWidth);
   end; { for RowIndex }
   if l_CellWidth = 0 then
    l_CellWidth := ddDefaultCellWidth;
   f_EtalonRow.CellWidth[CellIndex] := l_CellWidth;
   f_EtalonRow.TAP.Width := f_EtalonRow.TAP.Width + l_CellWidth;
 end; { for CellIndex };
//#UC END# *519C6553007B_4FACE16602E1_impl*
end;//TddTablePrim.CalculateCellsWidth

procedure TddTablePrim.CheckPercentCells(aRow: TddTableRow);
//#UC START# *519C65E700C6_4FACE16602E1_var*
var
 i, j             : Integer;
 l_Percent        : Integer;
 l_NonPercentCount: Integer;
//#UC END# *519C65E700C6_4FACE16602E1_var*
begin
//#UC START# *519C65E700C6_4FACE16602E1_impl*
 l_Percent := 0;
 l_NonPercentCount:= 0;
 for i := 0 to Pred(aRow.CellCount) do
 begin
   if aRow.CellWidth[i] = ddGetMinimalCellWidth then
    Inc(l_NonPercentCount)
   else
   if aRow.Cells[i].Props.IsPercent then
    Inc(l_Percent, aRow.CellWidth[i]);
 end; // for i
 if l_Percent > 0 then
  if (l_NonPercentCount = 0) and (l_Percent = aRow.CellCount) then
   for j := 0 to Pred(aRow.CellCount) do
   begin
    aRow.CellWidth[j] := 100 div l_Percent
   end   
  else
  for j := 0 to Pred(aRow.CellCount) do
  begin
    if aRow.CellWidth[j] = ddGetMinimalCellWidth then
    begin
     aRow.CellWidth[j] := (100 - l_Percent) div l_NonPercentCount;
     aRow.Cells[j].Props.IsPercent := True;
    end; // aRow.CellWidth[i] = 0
  end; // for i
//#UC END# *519C65E700C6_4FACE16602E1_impl*
end;//TddTablePrim.CheckPercentCells

procedure TddTablePrim.CheckSpanCells(aScaleCellWidth: Boolean;
 aDocTextWidth: Integer);
//#UC START# *519C65FC03D1_4FACE16602E1_var*
var
 i: Integer;
 k: Integer;
 l_Row: TddTableRow;
 RowIndex: Integer;
 CellIndex, l_EtalonCellIndex: Integer;
 l_Len: LongInt;
 l_Scale: Integer;
//#UC END# *519C65FC03D1_4FACE16602E1_var*
begin
//#UC START# *519C65FC03D1_4FACE16602E1_impl*
 // Даже без масштаба нужно ограничивать ширину таблицы...
 if aScaleCellWidth then
  l_Scale := aDocTextWidth
 else
  l_Scale := aDocTextWidth * 2;
 l_Scale := l3MulDiv(100, l_Scale, f_EtalonRow.TAP.Width);
 l_Scale := Min(100, l_Scale);
 for RowIndex := 0 to RowCount - 1 do
 begin
  l_Row := Rows[RowIndex];
  l_EtalonCellIndex := 0;
  for CellIndex := 0 to Pred(l_Row.CellCount) do
  begin
   l_Len := 0;
   for k := 1 to l_Row.Cells[CellIndex].Props.CellSpan do
   begin
    // Найти соответствующую ячейку в эталонном столбце и прибавить ее ширину
    if f_EtalonRow.Cells[l_EtalonCellIndex] <> nil then
    begin
     Inc(l_Len, f_EtalonRow.CellWidth[l_EtalonCellIndex]);
     Inc(l_EtalonCellIndex);
    end // if f_EtalonRow.Cells[l_EtalonCellIndex] <> nil then
   end; // l_Row.TAP.CellsProps[CellIndex].CellSpan > 1
   if (l_Len <> 0)  then
    l_Row.CellWidth[CellIndex] := l3MulDiv(l_Len, l_Scale, 100) + l_Row.CellSpan[CellIndex] * ddDefaultCellWidth;
  end; // for CellIndex
 end; // for RowIndex;
//#UC END# *519C65FC03D1_4FACE16602E1_impl*
end;//TddTablePrim.CheckSpanCells

function TddTablePrim.GetLineLen(const aText: Tl3String): Integer;
//#UC START# *519C6F6A0171_4FACE16602E1_var*
var
 l_Pos, l_PrevPos: Integer;
//#UC END# *519C6F6A0171_4FACE16602E1_var*
begin
//#UC START# *519C6F6A0171_4FACE16602E1_impl*
 l_PrevPos := 1;
 Result := 0;
 repeat
  l_Pos := PosEx(#10, aText.AsString, l_PrevPos);
  if l_Pos = 0 then
   l_Pos := aText.Len;
  Result := Max(Result, l_Pos - l_PrevPos + 1);
  l_PrevPos := Succ(l_Pos);
 until l_Pos = aText.Len;
//#UC END# *519C6F6A0171_4FACE16602E1_impl*
end;//TddTablePrim.GetLineLen

procedure TddTablePrim.NormalizeCells;
//#UC START# *519C7ACE00A5_4FACE16602E1_var*
var
 l_Row       : TddTableRow;
 l_RowIndex  : Integer;
 l_CellIndex : Integer;
//#UC END# *519C7ACE00A5_4FACE16602E1_var*
begin
//#UC START# *519C7ACE00A5_4FACE16602E1_impl*
 for l_RowIndex := 0 to RowCount - 1 do
 begin
  l_Row := Rows[l_RowIndex];
  for l_CellIndex := 0 to l_Row.CellCount - 1 do
  begin
   if l_CellIndex > 0 then
    l_Row.CellWidth[l_CellIndex]:= l_Row.CellWidth[l_CellIndex] + l_Row.CellWidth[l_CellIndex - 1];
  end;
 end;
//#UC END# *519C7ACE00A5_4FACE16602E1_impl*
end;//TddTablePrim.NormalizeCells

procedure TddTablePrim.CloseRow;
//#UC START# *519C7E26026D_4FACE16602E1_var*
var
 l_PrevRow, l_Row: TddTableRow;
 l_PrevCellIndex: Integer;
//#UC END# *519C7E26026D_4FACE16602E1_var*
begin
//#UC START# *519C7E26026D_4FACE16602E1_impl*
 l_Row := LastRow;
 l_Row.Closed := True;
 if RowCount < 2 then Exit;
 l_PrevRow := Rows[RowCount - 2]; // Предыдущий ряд
 if l_Row.CellCountBySpan < l_PrevRow.CellCountBySpan then { TODO : Нужно учитывать объединенные по горизонтали ячейки }
 begin
  l_PrevCellIndex := l_Row.CellCountBySpan;
  while l_PrevCellIndex < l_PrevRow.CellCountBySpan do
  begin
   if l_PrevRow.CellPropBySpan[l_PrevCellIndex].RowSpan > 1 then
    l_Row.CloneCell(l_PrevRow.CellPropBySpan[l_PrevCellIndex]);
   Inc(l_PrevCellIndex, l_PrevRow.CellPropBySpan[l_PrevCellIndex].CellSpan);
  end; // f_Table.RowList.Count > 0
 end;
//#UC END# *519C7E26026D_4FACE16602E1_impl*
end;//TddTablePrim.CloseRow

procedure TddTablePrim.CloseTable(aScaleCellWidth: Boolean;
 aDocTextWidth: Integer);
//#UC START# *519C7EE102E3_4FACE16602E1_var*
//#UC END# *519C7EE102E3_4FACE16602E1_var*
begin
//#UC START# *519C7EE102E3_4FACE16602E1_impl*
 f_EtalonRow := TddTableRow.Create(f_Destination);
 try
  CalculateCellsWidth;
  // Коррекция объединенных по горизонтали
  CheckSpanCells(aScaleCellWidth, aDocTextWidth);

  // Приведение ширин к нормальному виду, расстановка рамок
  NormalizeCells;
  Closed := True;
 finally
  FreeAndNil(f_EtalonRow);
 end;
//#UC END# *519C7EE102E3_4FACE16602E1_impl*
end;//TddTablePrim.CloseTable

function TddTablePrim.BeforeParseCell: TddTableRow;
//#UC START# *519C7F2303A2_4FACE16602E1_var*
var
 l_NeedAdd: Boolean;
 l_PrevRow: TddTableRow;
 l_PrevCellIndex: Integer;
//#UC END# *519C7F2303A2_4FACE16602E1_var*
begin
//#UC START# *519C7F2303A2_4FACE16602E1_impl*
 Result := LastRow;
 l_NeedAdd := False;
 if Result = nil then
 begin
  AddRow(False);
  Result := LastRow;
 end; // if Result = nil then 
 if (RowCount > 1) then
 begin
  l_PrevCellIndex := Result.CellCountBySpan;
  l_PrevRow := Rows[RowCount - 2]; // Предыдущий ряд
  while (l_PrevRow.CellPropBySpan[l_PrevCellIndex] <> nil) and
        (l_PrevRow.CellPropBySpan[l_PrevCellIndex].RowSpan > 1) do
  begin
   Result.CloneCell(l_PrevRow.CellPropBySpan[l_PrevCellIndex]);
   Inc(l_PrevCellIndex, l_PrevRow.CellPropBySpan[l_PrevCellIndex].CellSpan);
   l_NeedAdd := True;
  end; // while
 end; // f_Table.RowList.Count > 1
 if (Result.LastCell = nil) or Result.LastCell.Closed or l_NeedAdd then
  Result.AddCellAndPara(True);
 Result.LastCell.Props.Border.IsFramed := False; 
//#UC END# *519C7F2303A2_4FACE16602E1_impl*
end;//TddTablePrim.BeforeParseCell

function TddTablePrim.FindPrevRowWithCellProps(aStartIndex: Integer): TddTableRow;
//#UC START# *51E64EC500BE_4FACE16602E1_var*
var
 i     : Integer;
 l_Row : TddTableRow;
//#UC END# *51E64EC500BE_4FACE16602E1_var*
begin
//#UC START# *51E64EC500BE_4FACE16602E1_impl*
 Result := nil;
 for i := aStartIndex downto 0 do
 begin
  l_Row := f_RowList[i];
  if l_Row.IsCellPropsInit then
  begin
   Result := l_Row;
   Break;
  end; // if l_Row.IsCellPropsInit then
 end; // for i := f_RowList.Count - 1 downto 0 do
//#UC END# *51E64EC500BE_4FACE16602E1_impl*
end;//TddTablePrim.FindPrevRowWithCellProps

procedure TddTablePrim.CloseLastRow(aRowProp: TddRowProperty;
 aParaProp: TddParagraphProperty;
 out aLastRow: Boolean);
//#UC START# *51E65C1C0375_4FACE16602E1_var*
var
 l_Row: TddTableRow;
//#UC END# *51E65C1C0375_4FACE16602E1_var*
begin
//#UC START# *51E65C1C0375_4FACE16602E1_impl*
 l_Row := LastRow;
 aLastRow := False;
 l_Row.CellPropsCompleate := True;
 l_Row.TAP := aRowProp;
 if l_Row.IsCellPropsInit then
  l_Row.ApplyCellProps
 else
  l_Row.ApplyExternalCellPropsDef(FindPrevRowWithCellProps(f_RowList.Count - 1));
 l_Row.Closed := True;
 if l_Row.TAP.IsLastRow then
 begin
  Closed := True;
  aLastRow := True;
  CorrectParaLevelAfterCloseTable(aParaProp);
 end; // if LastRow.TAP.LastRow then
//#UC END# *51E65C1C0375_4FACE16602E1_impl*
end;//TddTablePrim.CloseLastRow

procedure TddTablePrim.CorrectParaLevelAfterCloseTable(aParaProp: TddParagraphProperty);
 {* Уменьшает уровень текущего параграфа на 1, чтобы следующие даннные добавлялись на уровень выше. }
//#UC START# *51E6661502F3_4FACE16602E1_var*
//#UC END# *51E6661502F3_4FACE16602E1_var*
begin
//#UC START# *51E6661502F3_4FACE16602E1_impl*
 if aParaProp.itap > 1 then // Чтобы не начинать новую таблицу по приходу обычного параграфа...
  aParaProp.itap := aParaProp.itap - 1;
//#UC END# *51E6661502F3_4FACE16602E1_impl*
end;//TddTablePrim.CorrectParaLevelAfterCloseTable

procedure TddTablePrim.Try2CloseNotClosedRow(aWidth: Integer);
//#UC START# *5236AD200270_4FACE16602E1_var*
var
 i             : Integer;
 k             : Integer;
 l_Row         : TddTableRow;
 l_Last        : Integer;
 l_HasNotClosed: Boolean;
//#UC END# *5236AD200270_4FACE16602E1_var*
begin
//#UC START# *5236AD200270_4FACE16602E1_impl*
 l_Last := f_RowList.Count - 1;
 l_HasNotClosed := False;
 for i := l_Last downto 0 do
 begin
  l_Row := f_RowList[i];
  if l_Row.Closed then
   Break
  else
   l_HasNotClosed := True;
 end; // while i >= 0 do
 Inc(i);
 if l_HasNotClosed then
 begin
  if i > 0 then
   for k := i to l_Last do
   begin
    l_Row := f_RowList[k];
    l_Row.CellPropsCompleate := True;
    l_Row.ApplyExternalCellPropsDef(FindPrevRowWithCellProps(i - 1));
   end //  for k := i to l_Last do
  else
   AdjustWidth(aWidth);
 end; // if l_HasNotClosed then
 Closed := True;
//#UC END# *5236AD200270_4FACE16602E1_impl*
end;//TddTablePrim.Try2CloseNotClosedRow

function TddTablePrim.GetFirstRowWidth: Integer;
//#UC START# *5236F13F02F8_4FACE16602E1_var*
var
 i    : Integer;
 l_Row: TddTableRow;
//#UC END# *5236F13F02F8_4FACE16602E1_var*
begin
//#UC START# *5236F13F02F8_4FACE16602E1_impl*
 Result := 0;
 l_Row := f_RowList.First;
 for i := 0 to l_Row.CellCount - 1 do
  with l_Row.Cells[i].Props do
   if CellOffset = -1 then
    Inc(Result, CellWidth)
   else
    Inc(Result, CellOffset);
//#UC END# *5236F13F02F8_4FACE16602E1_impl*
end;//TddTablePrim.GetFirstRowWidth

function TddTablePrim.IsTableCorrect: Boolean;
 {* Проверяет таблицу на корректность. }
//#UC START# *5385C5770229_4FACE16602E1_var*
const
 cnMaxLeftIndent = 15000;
var
 l_RowWidth: Integer;
//#UC END# *5385C5770229_4FACE16602E1_var*
begin
//#UC START# *5385C5770229_4FACE16602E1_impl*
 Result := (f_RowList.Count > 0) and (f_RowList.First.CellCount > 0);
 if Result then
  if (f_Level >= 1) and (f_RowList.Count = 1) then // Не пишем всякий мусор...
  begin
   l_RowWidth := GetFirstRowWidth;
   if (f_Level = 1) then
    Result := l_RowWidth >= ddGetMinimalCellWidth
   else
    Result := l_RowWidth >= ddGetMinimalCellWidth * 7;
  end // if (f_Level >= 1) and (f_RowList.Count = 1) and (GetFirstRowWidth < ddGetMinimalCellWidth * 7) then
  else
   if (f_Level = 1) and (f_RowList.Count >= 1) and (GetFirstRowWidth < ddGetMinimalCellWidth * 7) and (f_RowList.First.TAP.Left > cnMaxLeftIndent) then
    Result := False;
//#UC END# *5385C5770229_4FACE16602E1_impl*
end;//TddTablePrim.IsTableCorrect

procedure TddTablePrim.AddPicture(aPicture: TddPicture;
 aPAP: TddParagraphProperty;
 anAssign2Last: Boolean);
//#UC START# *54F711F202AF_4FACE16602E1_var*
var
 l_Picture : TddPicture;
 l_TextPara: TddTextParagraph;
//#UC END# *54F711F202AF_4FACE16602E1_var*
begin
//#UC START# *54F711F202AF_4FACE16602E1_impl*
 l_TextPara := LastParagraph;
 l_Picture := nil;
 try
  if (l_TextPara <> nil) and l_TextPara.IsPicture and anAssign2Last then
  begin
   if aPAP <> nil then
    l_TextPara.PAP.AssignFrom(aPAP);
   l_TextPara.Assign(aPicture);
  end // if anAssign2Last then
  else
  begin
   l_Picture := aPicture.Clone(aPAP);
   if (l_TextPara = nil) or l_TextPara.Closed or l_TextPara.IsPicture then
    AddParaWithCheckingRow(l_Picture, anAssign2Last)
   else
    l_TextPara.AddPicture(l_Picture, anAssign2Last);
  end;
 finally
  FreeAndNil(l_Picture);
 end;
//#UC END# *54F711F202AF_4FACE16602E1_impl*
end;//TddTablePrim.AddPicture

procedure TddTablePrim.Try2AlignRowWidth(aRow: TddTableRow);
//#UC START# *5616479402CF_4FACE16602E1_var*
var
 l_NewCell  : TddTableCell;
 l_LastCell : TddTableCell;
 l_HasDelta : Boolean;
//#UC END# *5616479402CF_4FACE16602E1_var*
begin
//#UC START# *5616479402CF_4FACE16602E1_impl*
 if f_Destination.IdenticalRowWidths then
 begin
  l_HasDelta := (aRow.TAP.trwWidthA > 0) and (aRow.TAP.trftsWidthA = dd_wuTwips);
  if l_HasDelta then
  begin
   l_LastCell := aRow.LastCell;
   aRow.AddCellAndPara;
   l_NewCell := aRow.LastCell;
   l_NewCell.Props.CellOffset := l_LastCell.Props.CellOffset + aRow.TAP.trwWidthA;
   l_NewCell.Props.Border.IsFramed := False;
  end; // if (aPrevRow <> nil) and (aRow.CellCount < aPrevRow.CellCount) then
 end; // if f_Destination.IdenticalRowWidths then
//#UC END# *5616479402CF_4FACE16602E1_impl*
end;//TddTablePrim.Try2AlignRowWidth

function TddTablePrim.RowIndex(aRow: TddTableRow): Integer;
//#UC START# *56C56E1C0271_4FACE16602E1_var*
//#UC END# *56C56E1C0271_4FACE16602E1_var*
begin
//#UC START# *56C56E1C0271_4FACE16602E1_impl*
 Result := f_RowList.IndexOf(aRow);
//#UC END# *56C56E1C0271_4FACE16602E1_impl*
end;//TddTablePrim.RowIndex

procedure TddTablePrim.Write2Generator(const Generator: Ik2TagGenerator;
 aNeedProcessRow: Boolean;
 LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_4FACE16602E1_var*
var
 i         : Integer;
 l_Row     : TddTableRow;
 l_PrevRow : TddTableRow;
//#UC END# *518A504F00F5_4FACE16602E1_var*
begin
//#UC START# *518A504F00F5_4FACE16602E1_impl*
 if IsTableCorrect then
 begin
  StartTablePara(Generator);
  try
   l_PrevRow := nil;
   for i := 0 to RowList.Hi do
   begin
    l_Row := RowList.Items[i];
    if aNeedProcessRow then
     ProcessTableRow(l_Row, l_PrevRow, i);
    l_Row.Write2Generator(Generator, aNeedProcessRow, LiteVersion);
    l_PrevRow := l_Row;
   end; // for i := 0 to f_RowList.Hi do
  finally
   Generator.Finish;
  end;
 end // if RowList.Count > 0 then
 {$IFNDEF EverestLite}
 {$IFDEF nsTest}
 else
  Assert(f_Level > 2, 'Попытка выливать пустую таблицу');
 {$ENDIF nsTest}
 {$ENDIF EverestLite}
//#UC END# *518A504F00F5_4FACE16602E1_impl*
end;//TddTablePrim.Write2Generator

procedure TddTablePrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FACE16602E1_var*
//#UC END# *479731C50290_4FACE16602E1_var*
begin
//#UC START# *479731C50290_4FACE16602E1_impl*
 f_Style := 0;
 FreeAndNil(f_RowList);
 inherited
//#UC END# *479731C50290_4FACE16602E1_impl*
end;//TddTablePrim.Cleanup

function TddTablePrim.GetEmpty: Boolean;
//#UC START# *4A54E03B009A_4FACE16602E1_var*
var
 i      : Integer;
 l_Empty: Boolean;
//#UC END# *4A54E03B009A_4FACE16602E1_var*
begin
//#UC START# *4A54E03B009A_4FACE16602E1_impl*
 Result := inherited GetEmpty;
 if not Result then
 begin
  l_Empty := True;
  for i := 0 to f_RowList.Count - 1 do
   if not f_RowList[i].Empty then
   begin
    l_Empty := False;
    Break;
   end; // if not f_RowList[i].Empty then
  Result := l_Empty; 
 end; // if not Result then
//#UC END# *4A54E03B009A_4FACE16602E1_impl*
end;//TddTablePrim.GetEmpty

procedure TddTablePrim.Clear;
//#UC START# *518A48F500CF_4FACE16602E1_var*
//#UC END# *518A48F500CF_4FACE16602E1_var*
begin
//#UC START# *518A48F500CF_4FACE16602E1_impl*
 inherited;
 f_RowList.Clear;
 f_LeftIndent := 0;
 f_Style := 0;
//#UC END# *518A48F500CF_4FACE16602E1_impl*
end;//TddTablePrim.Clear

constructor TddTablePrim.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_4FACE16602E1_var*
//#UC END# *51E91BA80051_4FACE16602E1_var*
begin
//#UC START# *51E91BA80051_4FACE16602E1_impl*
 inherited Create(aDetination);
 f_RowList := TddRowList.Make;
 f_IsSBS := False;
 f_Scale := def_Zoom;
 f_Nested := False;
//#UC END# *51E91BA80051_4FACE16602E1_impl*
end;//TddTablePrim.Create

function TddTablePrim.IsTable: Boolean;
//#UC START# *5268D575002D_4FACE16602E1_var*
//#UC END# *5268D575002D_4FACE16602E1_var*
begin
//#UC START# *5268D575002D_4FACE16602E1_impl*
 Result := True;
//#UC END# *5268D575002D_4FACE16602E1_impl*
end;//TddTablePrim.IsTable

function TddTablePrim.GetLastPara: TddDocumentAtom;
//#UC START# *5268DBC503E2_4FACE16602E1_var*
var
 l_Row : TddTableRow;
 l_Cell: TddTableCell;
//#UC END# *5268DBC503E2_4FACE16602E1_var*
begin
//#UC START# *5268DBC503E2_4FACE16602E1_impl*
 Result := nil;
 l_Row := LastRow;
 if l_Row <> nil then
 begin
  l_Cell := LastRow.LastCell;
  if l_Cell <> nil then
   Result := LastRow.LastCell.LastTextPara;
 end; // if l_Row <> nil then
//#UC END# *5268DBC503E2_4FACE16602E1_impl*
end;//TddTablePrim.GetLastPara

procedure TddTablePrim.Assign(const aDocAtomObj: Tl3ProtoObject);
//#UC START# *528C8C2F02D9_4FACE16602E1_var*
var
 i         : Integer;
 l_Row     : TddTableRow;
 l_OldTable: TddTablePrim;
//#UC END# *528C8C2F02D9_4FACE16602E1_var*
begin
//#UC START# *528C8C2F02D9_4FACE16602E1_impl*
 if aDocAtomObj is TddTablePrim then
 begin
  l_OldTable := aDocAtomObj as TddTablePrim;
  for i := 0 to l_OldTable.RowCount - 1 do
  begin
   AddRow(False);
   l_Row := LastRow;
   l_Row.Assign(l_OldTable.Rows[i]);
  end; // for i := 0 to l_OldTable.RowCount - 1 do
 end // if aDocAtomObj is TddTable then
 else
  inherited;
//#UC END# *528C8C2F02D9_4FACE16602E1_impl*
end;//TddTablePrim.Assign

end.
