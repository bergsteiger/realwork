unit destNormSpec;
 {* Специализированная dest, для колонок, например. }

// Модуль: "w:\common\components\rtl\Garant\dd\destNormSpec.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestNormSpec" MUID: (56BB14F503A0)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , destNorm
 , l3LongintList
 , ddSectionProperty
 , ddTableCell
 , ddTableRow
 , ddTable
 , ddRTFState
 , RTFtypes
 , ddParagraphProperty
 , ddTextParagraph
 , ddCustomRTFReader
 , l3Base
;

type
 TddSplitPara = (
  dd_spNone
  , dd_spNumber
  , dd_spHypen
 );//TddSplitPara

 TddWaitChar = (
  dd_wcNone
  , dd_wcDoubleQuote
 );//TddWaitChar

 TddTransferMode = (
  dd_tmNone
  , dd_tmColumn
  , dd_tmTab
  , dd_tmBreak
 );//TddTransferMode

 TdestNormSpec = class(TdestNorm)
  {* Специализированная dest, для колонок, например. }
  private
   f_PrevColsWidth: Integer;
    {* Предыдущая ширина строки. }
   f_ColIndex: Integer;
    {* Номер колонки (из атрибутов RTF). }
   f_ColCount: Integer;
    {* Число колонок (из атрибутов RTF). }
   f_ColWidths: Tl3LongintList;
    {* Ширины колонок (из атрибутов RTF). }
   f_SectProp: TddSectionProperty;
   f_StartRow: Integer;
    {* Номер строки, с которой начинается колонка. }
   f_LastCell: TddTableCell;
    {* Ячейка для добавления текста. }
   f_LastRow: TddTableRow;
    {* Строка для добавления текста. }
   f_ClearColumnOffset: Boolean;
    {* Очищать смещение колонки. }
   f_TabIndex: Integer;
    {* Текущий индекс табуляции параграфа. }
   f_Table: TddTable;
    {* Таблица, в которую пишем, даже если колонки кончились... }
   f_SplitPara: TddSplitPara;
    {* Как разбивать оставшуюся часть параграфа. }
   f_WaitChar: TddWaitChar;
   f_TransferMode: TddTransferMode;
   f_PrevTransferMode: TddTransferMode;
   f_EmptyParaCount: Integer;
    {* Число пустых строк. }
   f_InAddingCell: Boolean;
    {* Режим добавления ячейки. }
   f_SpacesCount: Integer;
    {* Количество пробелов. }
  private
   procedure AddColumn4Table(aRowIndex: Integer;
    aCurColumn: Integer);
   procedure FinishColumn(aState: TddRTFState);
   procedure CheckColumnTable;
   procedure AppyToColumn(aWhat: TIProp;
    aValue: LongInt;
    aState: TddRTFState);
   procedure SetCellProp(aCell: TddTableCell;
    anIndex: Integer);
   procedure AddNewRowWithColumn(aPAP: TddParagraphProperty);
   function CheckLeftIndent(aPAP: TddParagraphProperty): Boolean;
   function ColumnOffset(anIndex: Integer): Integer;
   function CheckNewColumn: Boolean;
   function NeedNewCell(aState: TddRTFState): Boolean;
   procedure AddNewCellByTab(aState: TddRTFState);
   procedure ClearTextPara4Table(aPara: TddTextParagraph);
   procedure AddNewRowByTab(aPAP: TddParagraphProperty);
   procedure CloseTable;
   procedure Try2CloseTabble(aPAP: TddParagraphProperty);
   procedure CheckCellWidth;
   function CurColID: Integer;
   procedure InitNewColumns;
   function NotInFirstColumn: Boolean;
   procedure TrySpaces2Tab(aState: TddRTFState);
   procedure Cells2Tabs(aState: TddRTFState);
   function Try2AddNewCell(aSymbol: Integer;
    aState: TddRTFState): Boolean;
   procedure ClosePara(aSymbol: Integer;
    aState: TddRTFState);
   procedure PopTransferMode(aMode: TddTransferMode);
   procedure PushTransferMode;
   function NeedNewRow(aPAP: TddParagraphProperty): Boolean;
   procedure Try2SplitNumbers(aState: TddRTFState);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ApplyToPAP(What: TIProp;
    aValue: Integer;
    aPAP: TddParagraphProperty); override;
   procedure ApplyToSep(aWhat: TIProp;
    aValue: LongInt); override;
   function pm_GetLastParagraph: TddTextParagraph; override;
   function InternalAddTextPara(aPAP: TddParagraphProperty): TddTextParagraph; override;
   procedure Try2ApplyParaProperty(aState: TddRTFState;
    aPara: TddTextParagraph;
    aWasPara: Boolean); override;
   procedure AddPageBreak(aSymbol: Integer); override;
   procedure CloseTextPara(aPAP: TddParagraphProperty;
    aPara: TddTextParagraph); override;
   function InTable(aPAP: TddParagraphProperty): Boolean; override;
    {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
   function Itap(aPAP: TddParagraphProperty): Integer; override;
    {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
   procedure DoAddTabStop(aPAP: TddParagraphProperty); override;
   procedure BeforeWriteBuffer(aText: Tl3String;
    aState: TddRTFState); override;
  public
   procedure Clear; override;
   procedure AddUnicodeChar(aText: Word;
    aState: TddRTFState); override;
   procedure ApplyProperty(propType: TPropType;
    What: TIProp;
    Value: LongInt;
    aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
   procedure ParseSymbol(Symbol: Integer;
    propType: TPropType;
    aState: TddRTFState); override;
 end;//TdestNormSpec

implementation

uses
 l3ImplUses
 , ddTab
 , SysUtils
 , l3String
 , ddDocumentAtom
 , l3Chars
 , ddTypes
 , ddCellProperty
 , ddConst
 , l3MinMax
;

procedure TdestNormSpec.AddColumn4Table(aRowIndex: Integer;
 aCurColumn: Integer);
//#UC START# *56BB3E570128_56BB14F503A0_var*
var
 l_Row : TddTableRow;
 l_Cell: TddTableCell;
//#UC END# *56BB3E570128_56BB14F503A0_var*
begin
//#UC START# *56BB3E570128_56BB14F503A0_impl*
 Assert(f_Table <> nil);
 if aRowIndex = -1 then
 begin
  f_Table.CheckLastRow(False);
  l_Row := f_Table.LastRow
 end // if aRowIndex = -1 then
 else
  l_Row := f_Table.Rows[aRowIndex];
 l_Cell := l_Row.GetLastNonClosedCellOrAddNew;
 f_LastCell := l_Cell;
 f_LastRow := l_Row;
 SetCellProp(l_Cell, f_CurColumn);
 f_TabIndex := 0;
//#UC END# *56BB3E570128_56BB14F503A0_impl*
end;//TdestNormSpec.AddColumn4Table

procedure TdestNormSpec.FinishColumn(aState: TddRTFState);
//#UC START# *56BB3E9801EA_56BB14F503A0_var*
var
 l_Row  : TddTableRow;
 l_Cell : TddTableCell;
//#UC END# *56BB3E9801EA_56BB14F503A0_var*
begin
//#UC START# *56BB3E9801EA_56BB14F503A0_impl*
 Assert(f_Table <> nil);
 l_Row := f_Table.LastRow;
 l_Cell := l_Row.LastCell;
 if l_Cell <> nil then
  l_Cell.Closed := True;
 Inc(f_CurColumn);
 AddColumn4Table(f_StartRow);
//#UC END# *56BB3E9801EA_56BB14F503A0_impl*
end;//TdestNormSpec.FinishColumn

procedure TdestNormSpec.CheckColumnTable;
//#UC START# *56BB3EE301F6_56BB14F503A0_var*
//#UC END# *56BB3EE301F6_56BB14F503A0_var*
begin
//#UC START# *56BB3EE301F6_56BB14F503A0_impl*
 if f_Table <> nil then
 begin
  f_CurColumn := -1;
  f_SaveInColumns := False;
  f_Table.CloseRow;
  f_StartRow := -1;
 end; // if l_Table <> nil then
//#UC END# *56BB3EE301F6_56BB14F503A0_impl*
end;//TdestNormSpec.CheckColumnTable

procedure TdestNormSpec.AppyToColumn(aWhat: TIProp;
 aValue: LongInt;
 aState: TddRTFState);
//#UC START# *56BD6FDC025E_56BB14F503A0_var*

 procedure lp_Try2AddNewTable;
 var
  l_Row  : TddTableRow;
  l_Cell : TddTableCell;
 begin
  f_Table := LastTable(False); // Вложенные колонки не поддерживаем...
  if f_Table = nil then
  begin
   Try2AddTable(1);
   f_Table := LastTable(False);
  end // if f_Table = nil then
  else
  begin
   l_Row := f_Table.LastRow;
   l_Cell := l_Row.LastCell;
   if (l_Cell <> nil) then
    if l_Cell.IsCellEmpty then
    begin
     SetCellProp(l_Cell, l_Row.CellCount - 1);
     Exit;
    end // if l_Cell.IsCellEmpty then
    else
    begin
     l_Cell.Closed := True;
     l_Row.Closed := True;
    end; // if l_Cell <> nil then
  end;
  f_StartRow := f_Table.RowCount;
  AddColumn4Table(-1);
 end;

 function lp_CalcColsWidth: Integer;
 var
  i: Integer;
 begin
  Result := 0;
  for i := 0 to f_ColWidths.Count - 1 do
   Inc(Result, f_ColWidths[i]);
 end;

var
 l_CurWidth: Integer;
//#UC END# *56BD6FDC025E_56BB14F503A0_var*
begin
//#UC START# *56BD6FDC025E_56BB14F503A0_impl*
 case aWhat of
  ipropColCount : begin
   if f_ColWidths.Count > 0 then
    f_ColWidths.Clear;
   f_SectProp.cCols := aValue;
   f_ColCount := aValue;
   f_ColIndex := 0;
  end;
  ipropColNum:
   begin
    f_ColIndex := aValue - 1;
    f_ColWidths.Add(0);
   end;
  ipropColumnRight:
   f_ColWidths[f_ColIndex] := f_ColWidths[f_ColIndex] + aValue;
  ipropColWidth: begin
   f_ColWidths[f_ColIndex] := f_ColWidths[f_ColIndex] + aValue;
   if f_ColIndex = (f_ColCount - 1) then
   begin
    if f_PrevColsWidth > 0 then
    begin
     l_CurWidth := lp_CalcColsWidth;
     if l_CurWidth < f_PrevColsWidth then
      f_ColWidths.Last := f_ColWidths.Last + f_PrevColsWidth - l_CurWidth;
    end // if f_PrevColsWidth > 0 then
    else
     f_PrevColsWidth := lp_CalcColsWidth;
    f_SaveInColumns := True;
    f_CurColumn := 0;
    lp_Try2AddNewTable;
   end; // if f_ColIndex = (f_ColCount - 1) then
  end;
 end; // case aWhat of
//#UC END# *56BD6FDC025E_56BB14F503A0_impl*
end;//TdestNormSpec.AppyToColumn

procedure TdestNormSpec.SetCellProp(aCell: TddTableCell;
 anIndex: Integer);
//#UC START# *56BD93A10343_56BB14F503A0_var*
//#UC END# *56BD93A10343_56BB14F503A0_var*
begin
//#UC START# *56BD93A10343_56BB14F503A0_impl*
 aCell.Props.CellOffset := ColumnOffset(anIndex);
//#UC END# *56BD93A10343_56BB14F503A0_impl*
end;//TdestNormSpec.SetCellProp

procedure TdestNormSpec.AddNewRowWithColumn(aPAP: TddParagraphProperty);
//#UC START# *56C5769301AC_56BB14F503A0_var*
var
 i         : Integer;
 l_Row     : TddTableRow;
 l_Cell    : TddTableCell;
 l_LastCol : Integer;
//#UC END# *56C5769301AC_56BB14F503A0_var*
begin
//#UC START# *56C5769301AC_56BB14F503A0_impl*
 if CheckNewColumn then Exit;
 Assert(f_Table <> nil);
 f_TabIndex := 0;
 l_Row := f_Table.LastRow;
 l_Cell := l_Row.LastCell;
 l_Cell.Closed := True;
 l_Row.Closed := True;
 l_LastCol := f_CurColumn;
 l_Row := nil;
 try
  for i := 0 to l_LastCol do
  begin
   f_CurColumn := i;
   AddColumn4Table(-1);
   if l_Row = nil then
    l_Row := f_Table.LastRow;
   if i < l_LastCol then
   begin
    l_Cell := l_Row.LastCell;
    l_Cell.Closed := True;
   end // if i < l_NewIndex then
   else
   begin
    f_LastRow := l_Row;
    f_LastCell := l_Row.LastCell;
   end;
  end; // for i := 0 to l_NewIndex do
 finally
  f_CurColumn := l_LastCol;
 end;
//#UC END# *56C5769301AC_56BB14F503A0_impl*
end;//TdestNormSpec.AddNewRowWithColumn

function TdestNormSpec.CheckLeftIndent(aPAP: TddParagraphProperty): Boolean;
//#UC START# *56C6FC91019C_56BB14F503A0_var*
const
 cnDelta = 10;
var
 i           : Integer;
 l_FoundIndex: Integer;
 l_LeftIndent: Integer;
//#UC END# *56C6FC91019C_56BB14F503A0_var*
begin
//#UC START# *56C6FC91019C_56BB14F503A0_impl*
 l_LeftIndent := aPAP.xaLeft;
 if (aPAP.xaFirst > -(l_LeftIndent div 2)) and (l_LeftIndent > 0) and (f_ColWidths.Count > 0) then
 begin
  l_FoundIndex := -1;
  for i := 0 to f_ColWidths.Count - 1 do
   if Abs(l_LeftIndent - f_ColWidths[i]) < cnDelta then
   begin
    l_FoundIndex := i;
    Break;
   end; // if Abs(l_LeftIndent - f_ColWidths[i]) < l3Epsilon then
  if l_FoundIndex > -1 then
   for i := 0 to l_FoundIndex do
   begin
    f_CurColumn := i;
    AddColumn4Table(-1);
    f_LastRow.LastCell.Closed := True;
   end; // for i := 0 to l_FoundIndex do
 end; // if l_LeftIndent > 0 then
//#UC END# *56C6FC91019C_56BB14F503A0_impl*
end;//TdestNormSpec.CheckLeftIndent

function TdestNormSpec.ColumnOffset(anIndex: Integer): Integer;
//#UC START# *56C6FCC401C7_56BB14F503A0_var*
var
 i: Integer;
//#UC END# *56C6FCC401C7_56BB14F503A0_var*
begin
//#UC START# *56C6FCC401C7_56BB14F503A0_impl*
 Result := 0;
 for i := 0 to anIndex do
  Inc(Result, f_ColWidths[i]);
//#UC END# *56C6FCC401C7_56BB14F503A0_impl*
end;//TdestNormSpec.ColumnOffset

function TdestNormSpec.CheckNewColumn: Boolean;
//#UC START# *56C6FCEF0347_56BB14F503A0_var*
var
 l_RowIndex: Integer;
//#UC END# *56C6FCEF0347_56BB14F503A0_var*
begin
//#UC START# *56C6FCEF0347_56BB14F503A0_impl*
 Result := False;
 Assert(f_Table <> nil);
 l_RowIndex := f_Table.RowIndex(f_LastRow);
 if l_RowIndex < (f_Table.RowCount - 1) then
 begin
  AddColumn4Table(l_RowIndex + 1);
  Result := True;
 end; // if l_RowIndex < (l_Table.RowCount - 1) then
//#UC END# *56C6FCEF0347_56BB14F503A0_impl*
end;//TdestNormSpec.CheckNewColumn

function TdestNormSpec.NeedNewCell(aState: TddRTFState): Boolean;
//#UC START# *56C6FD0C03C4_56BB14F503A0_var*
//#UC END# *56C6FD0C03C4_56BB14F503A0_var*
begin
//#UC START# *56C6FD0C03C4_56BB14F503A0_impl*
 Result := (f_LastCell <> nil) and (aState.PAP.TabList.Count > 0);
//#UC END# *56C6FD0C03C4_56BB14F503A0_impl*
end;//TdestNormSpec.NeedNewCell

procedure TdestNormSpec.AddNewCellByTab(aState: TddRTFState);
//#UC START# *56C6FD3B01A5_56BB14F503A0_var*

 function lp_AddCell(aRow: TddTableRow; aWidth: Integer): TddTableCell;
 begin
  Result := aRow.GetLastNonClosedCellOrAddNew;
  Result.Props.CellOffset := aWidth;
 end;

var
 l_Offset    : Integer;
 l_PrevOffset: Integer;
//#UC END# *56C6FD3B01A5_56BB14F503A0_var*
begin
//#UC START# *56C6FD3B01A5_56BB14F503A0_impl*
 if (f_LastCell <> nil) and (aState.PAP.TabList.Count > 0) then
  if (f_TabIndex >= aState.PAP.TabList.Count) then
  begin
   f_TabIndex := 0;
   AddNewRow(aState.PAP);
  end; // if (f_TabIndex >= aState.PAP.TabList.Count) then
  if f_SaveInColumns then
  begin
   l_Offset := TddTab(aState.PAP.TabList[f_TabIndex]).TabPos;
   f_LastCell.Closed := True;
   if f_CurColumn > 0 then
    Inc(l_Offset, ColumnOffset(f_CurColumn - 1));
   l_PrevOffset := f_LastCell.Props.CellOffset;
   f_LastCell.Props.CellOffset := l_Offset;
   f_LastCell := lp_AddCell(f_LastRow, l_PrevOffset);
   Inc(f_TabIndex);
  end // if f_SaveInColumns then
  else
   if f_Table <> nil then
   begin
    l_Offset := TddTab(aState.PAP.TabList[f_TabIndex]).TabPos;
    f_LastRow.LastCell.Props.CellOffset := l_Offset;
    f_LastCell.Closed := True;
    f_LastCell := lp_AddCell(f_LastRow, l_Offset);
    Inc(f_TabIndex);
    if f_TabIndex = aState.PAP.TabList.Count then
     f_LastRow.LastCell.Props.CellOffset := f_PrevColsWidth;
   end; // if (f_LastCell <> nil) and (aState.PAP.TabList.Count > 0) then
//#UC END# *56C6FD3B01A5_56BB14F503A0_impl*
end;//TdestNormSpec.AddNewCellByTab

procedure TdestNormSpec.ClearTextPara4Table(aPara: TddTextParagraph);
//#UC START# *56C846290255_56BB14F503A0_var*
//#UC END# *56C846290255_56BB14F503A0_var*
begin
//#UC START# *56C846290255_56BB14F503A0_impl*
 if aPara.PAP.TabList.Count > 0 then
  aPara.PAP.TabList.Clear;
 aPara.PAP.xaFirst := propUndefined;
 aPara.PAP.xaLeft := propUndefined;
 aPara.PAP.xaRight := propUndefined;
//#UC END# *56C846290255_56BB14F503A0_impl*
end;//TdestNormSpec.ClearTextPara4Table

procedure TdestNormSpec.AddNewRowByTab(aPAP: TddParagraphProperty);
//#UC START# *56D81BA40350_56BB14F503A0_var*
//#UC END# *56D81BA40350_56BB14F503A0_var*
begin
//#UC START# *56D81BA40350_56BB14F503A0_impl*
 if f_Table <> nil then
 begin
  f_Table.LastRow.Closed := True;
  f_Table.CheckLastRow(False);
  f_LastRow := nil;
  f_LastCell := nil;
  CheckLeftIndent(aPAP);
  if f_LastRow = nil then
   f_LastRow := f_Table.LastRow;
  f_LastCell := f_LastRow.GetLastNonClosedCellOrAddNew;
  f_TabIndex := 0;
 end; // if f_Table <> nil then
//#UC END# *56D81BA40350_56BB14F503A0_impl*
end;//TdestNormSpec.AddNewRowByTab

procedure TdestNormSpec.CloseTable;
//#UC START# *572C60C800BD_56BB14F503A0_var*
//#UC END# *572C60C800BD_56BB14F503A0_var*
begin
//#UC START# *572C60C800BD_56BB14F503A0_impl*
 f_EmptyParaCount := 0;
 if f_LastCell = nil then Exit;
 CheckCellWidth;
 f_LastCell := nil;
 f_Table.LastRow.Closed := True;
 f_Table.Closed := True;
 f_Table := nil;
 f_LastRow := nil;
 PopTransferMode(dd_tmNone);
//#UC END# *572C60C800BD_56BB14F503A0_impl*
end;//TdestNormSpec.CloseTable

procedure TdestNormSpec.Try2CloseTabble(aPAP: TddParagraphProperty);
//#UC START# *572C60F301A0_56BB14F503A0_var*
//#UC END# *572C60F301A0_56BB14F503A0_var*
begin
//#UC START# *572C60F301A0_56BB14F503A0_impl*
 if (TextBuffer.Len = 0) and (f_Table <> nil) then
  if (f_TransferMode <> dd_tmColumn) then
  begin
   if (aPAP.xaFirst = propUndefined) and (aPAP.xaLeft = propUndefined) then
    Inc(f_EmptyParaCount)
   else
    f_EmptyParaCount := 0;
   if (f_EmptyParaCount > 2) then
    CloseTable;
  end // if (f_Table <> nil) then
  else
   if (aPAP.xaFirst = propUndefined) and (aPAP.xaLeft = propUndefined) then
    Inc(f_EmptyParaCount);
//#UC END# *572C60F301A0_56BB14F503A0_impl*
end;//TdestNormSpec.Try2CloseTabble

procedure TdestNormSpec.CheckCellWidth;
//#UC START# *572C61230202_56BB14F503A0_var*
//#UC END# *572C61230202_56BB14F503A0_var*
begin
//#UC START# *572C61230202_56BB14F503A0_impl*
 if f_LastCell.Props.CellOffset = 0 then
 begin
  f_LastCell.Props.CellOffset := f_SectProp.xaPage - f_SectProp.xaLeft - f_SectProp.xaRight;
  f_LastCell.Props.OffsetType := dd_otByPage;
 end;
//#UC END# *572C61230202_56BB14F503A0_impl*
end;//TdestNormSpec.CheckCellWidth

function TdestNormSpec.CurColID: Integer;
//#UC START# *572C614401A8_56BB14F503A0_var*
//#UC END# *572C614401A8_56BB14F503A0_var*
begin
//#UC START# *572C614401A8_56BB14F503A0_impl*
 if f_StartRow > -1 then
  Result := f_Table.Rows[f_StartRow].CurColumn
 else
  Result := -1; 
//#UC END# *572C614401A8_56BB14F503A0_impl*
end;//TdestNormSpec.CurColID

procedure TdestNormSpec.InitNewColumns;
//#UC START# *572C617603AE_56BB14F503A0_var*
//#UC END# *572C617603AE_56BB14F503A0_var*
begin
//#UC START# *572C617603AE_56BB14F503A0_impl*
 f_TabIndex := 0;
 f_EmptyParaCount := 0;
 f_ClearColumnOffset := False;
//#UC END# *572C617603AE_56BB14F503A0_impl*
end;//TdestNormSpec.InitNewColumns

function TdestNormSpec.NotInFirstColumn: Boolean;
//#UC START# *572C61990328_56BB14F503A0_var*
var
 l_RowIndex: Integer;
//#UC END# *572C61990328_56BB14F503A0_var*
begin
//#UC START# *572C61990328_56BB14F503A0_impl*
 Result := False;
 l_RowIndex := f_Table.RowIndex(f_LastRow);
 if (l_RowIndex < (f_Table.RowCount - 1)) and (f_LastRow.CurColumn > 0) then
  Result := True;
//#UC END# *572C61990328_56BB14F503A0_impl*
end;//TdestNormSpec.NotInFirstColumn

procedure TdestNormSpec.TrySpaces2Tab(aState: TddRTFState);
//#UC START# *572C61C30037_56BB14F503A0_var*
const
 cnSpaces2Tab = 5;
//#UC END# *572C61C30037_56BB14F503A0_var*
begin
//#UC START# *572C61C30037_56BB14F503A0_impl*
 if not TextBuffer.Empty then
  if f_SpacesCount >= cnSpaces2Tab then
  begin
   Cells2Tabs(aState);
   TextBuffer.RTrim;
   ParseSymbol(Ord(cc_Tab), propCHP, aState);
  end; // if TextBuffer.RTrimLen > cnSpaces2Tab then
 f_SpacesCount := 0;
//#UC END# *572C61C30037_56BB14F503A0_impl*
end;//TdestNormSpec.TrySpaces2Tab

procedure TdestNormSpec.Cells2Tabs(aState: TddRTFState);
//#UC START# *572C61E90325_56BB14F503A0_var*

 procedure lp_AddTab(aTabPos: Integer);
 var
  l_Tab: TddTab;
 begin
  l_Tab := TddTab.Create;
  try
   l_Tab.TabPos := aTabPos;
   aState.PAP.TabList.Add(l_Tab);
  finally
   FreeAndNil(l_Tab);
  end;
 end;

var
 i          : Integer;
 l_Cell     : TddTableCell;
 l_Offset   : Integer;
 l_ColOffset: Integer;
//#UC END# *572C61E90325_56BB14F503A0_var*
begin
//#UC START# *572C61E90325_56BB14F503A0_impl*
 if (f_LastRow.CellCount > 1) and (f_LastRow.CurColumn = 0) and (aState.PAP.TabList.Count = 0) then
 begin
  l_ColOffset := ColumnOffset(0);
  if f_LastRow.LastCell.Props.CellOffset = l_ColOffset then
  begin
   l_Offset := 0;                             
   for i := 0 to f_LastRow.CellCount - 1 do
   begin
    l_Cell := f_LastRow.Cells[i];
    l_Offset := l_Cell.Props.CellOffset;
    if l_Offset = l_ColOffset then Break;
    lp_AddTab(l_Offset);
   end; // while l_Offset <> l_ColOffset do
  end; // if f_LastRow.LastCell.Props.CellOffset = l_ColOffset then
 end; // if (f_LastRow.CurColumn = 0) and (aState.PAP.TabList.Count = 0) then
//#UC END# *572C61E90325_56BB14F503A0_impl*
end;//TdestNormSpec.Cells2Tabs

function TdestNormSpec.Try2AddNewCell(aSymbol: Integer;
 aState: TddRTFState): Boolean;
//#UC START# *572C62180157_56BB14F503A0_var*
//#UC END# *572C62180157_56BB14F503A0_var*
begin
//#UC START# *572C62180157_56BB14F503A0_impl*
 Result := False;
 if NeedNewCell(aState) then
 begin
  Result := True;
  f_InAddingCell := True;
  try
   ClosePara(aSymbol, aState);
   AddNewCellByTab(aState);
  finally
   f_InAddingCell := False;
  end;
 end // if NeedNewCell then
//#UC END# *572C62180157_56BB14F503A0_impl*
end;//TdestNormSpec.Try2AddNewCell

procedure TdestNormSpec.ClosePara(aSymbol: Integer;
 aState: TddRTFState);
//#UC START# *572C624C03B4_56BB14F503A0_var*
//#UC END# *572C624C03B4_56BB14F503A0_var*
begin
//#UC START# *572C624C03B4_56BB14F503A0_impl*
 PushTransferMode;
 if f_TransferMode = dd_tmColumn then
  ParseSymbol(aSymbol, propPAP, aState); // Закрываем параграф.
//#UC END# *572C624C03B4_56BB14F503A0_impl*
end;//TdestNormSpec.ClosePara

procedure TdestNormSpec.PopTransferMode(aMode: TddTransferMode);
//#UC START# *572C627400F5_56BB14F503A0_var*
//#UC END# *572C627400F5_56BB14F503A0_var*
begin
//#UC START# *572C627400F5_56BB14F503A0_impl*
 f_PrevTransferMode := f_TransferMode;
 f_TransferMode := aMode;
//#UC END# *572C627400F5_56BB14F503A0_impl*
end;//TdestNormSpec.PopTransferMode

procedure TdestNormSpec.PushTransferMode;
//#UC START# *572C62B102DA_56BB14F503A0_var*
//#UC END# *572C62B102DA_56BB14F503A0_var*
begin
//#UC START# *572C62B102DA_56BB14F503A0_impl*
 if f_TransferMode = dd_tmBreak then
  f_TransferMode := f_PrevTransferMode;
 f_PrevTransferMode := dd_tmNone;
//#UC END# *572C62B102DA_56BB14F503A0_impl*
end;//TdestNormSpec.PushTransferMode

function TdestNormSpec.NeedNewRow(aPAP: TddParagraphProperty): Boolean;
//#UC START# *572C62D3018A_56BB14F503A0_var*

  function lp_OnlyColumns: Boolean;
  var
   i: Integer;
  begin
   Result := f_ColCount >= f_LastRow.CellCount;
   if Result then
    for i := 0 to f_LastRow.CellCount - 1 do
     if f_LastRow.Cells[i].Props.OffsetType <> dd_otByColumn then
     begin
      Result := False;
      Break;
     end; // if f_LastRow.Cells[i].Props.OffsetType <> dd_ByColumn then
  end;

  function lp_LastColumnEmpty: Boolean;
  var
   l_Offset    : Integer;
   l_PrevOffset: Integer;
  begin
   Result := f_LastRow.CellCount = 0;
   if not Result then
    if f_LastRow.CellCount = 1 then
     Result := f_LastCell.IsCellEmpty and (ColumnOffset(0) = f_LastCell.Props.CellOffset) and (aPAP.xaLeft <> propUndefined)
    else
     if f_LastRow.CellCount > 1 then
     begin
      Result := False;
      if (f_LastRow.CurColumn > 0) and (f_LastCell <> nil) then
      begin
       if lp_OnlyColumns then
        Result := f_LastCell.IsCellEmpty // И ячейка колонки пустая...
       else
       begin
        l_Offset := ColumnOffset(f_LastRow.CurColumn);
        l_PrevOffset := ColumnOffset(f_LastRow.CurColumn - 1);
        // В колонку не навставляли еще ячеек...
        if (l_Offset = f_LastCell.Props.CellOffset) and (l_PrevOffset = f_LastRow.Cells[f_LastRow.CellCount - 2].Props.CellOffset) then
         Result := f_LastCell.IsCellEmpty; // И ячейка колонки пустая...
       end;
      end; // if f_LastRow.CurColumn > 0 then
     end; // if Result then
  end;

//#UC END# *572C62D3018A_56BB14F503A0_var*
begin
//#UC START# *572C62D3018A_56BB14F503A0_impl*
 Result := (f_LastCell <> nil) and not f_LastCell.IsCellEmpty;
 if not Result then
  if (f_EmptyParaCount > 0) then
   Result := not lp_LastColumnEmpty;
//#UC END# *572C62D3018A_56BB14F503A0_impl*
end;//TdestNormSpec.NeedNewRow

procedure TdestNormSpec.Try2SplitNumbers(aState: TddRTFState);
//#UC START# *572C62FA035D_56BB14F503A0_var*
//#UC END# *572C62FA035D_56BB14F503A0_var*
begin
//#UC START# *572C62FA035D_56BB14F503A0_impl*
 if f_LastCell <> nil then
  if f_LastCell.LastTextPara.Text.Last in cc_Digits then
   ClosePara(Ord(cc_Tab), aState);
//#UC END# *572C62FA035D_56BB14F503A0_impl*
end;//TdestNormSpec.Try2SplitNumbers

procedure TdestNormSpec.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56BB14F503A0_var*
//#UC END# *479731C50290_56BB14F503A0_var*
begin
//#UC START# *479731C50290_56BB14F503A0_impl*
 f_LastCell := nil;
 f_LastRow := nil;
 FreeAndNil(f_ColWidths);
 FreeAndNil(f_SectProp);
 f_PrevColsWidth := 0;
 f_StartRow := -1;
 f_SaveInColumns := False;
 f_TabIndex := 0;
 f_SplitPara := dd_spNone;
 inherited;
//#UC END# *479731C50290_56BB14F503A0_impl*
end;//TdestNormSpec.Cleanup

procedure TdestNormSpec.Clear;
//#UC START# *51D27A48038E_56BB14F503A0_var*
//#UC END# *51D27A48038E_56BB14F503A0_var*
begin
//#UC START# *51D27A48038E_56BB14F503A0_impl*
 f_PrevColsWidth := 0;
 f_LastCell := nil;
 f_LastRow := nil;
 f_SaveInColumns := False;
 f_TabIndex := 0;
 f_SplitPara := dd_spNone;
 inherited;
//#UC END# *51D27A48038E_56BB14F503A0_impl*
end;//TdestNormSpec.Clear

procedure TdestNormSpec.AddUnicodeChar(aText: Word;
 aState: TddRTFState);
//#UC START# *51D27DFA0308_56BB14F503A0_var*
//#UC END# *51D27DFA0308_56BB14F503A0_var*
begin
//#UC START# *51D27DFA0308_56BB14F503A0_impl*

//#UC END# *51D27DFA0308_56BB14F503A0_impl*
end;//TdestNormSpec.AddUnicodeChar

procedure TdestNormSpec.ApplyProperty(propType: TPropType;
 What: TIProp;
 Value: LongInt;
 aState: TddRTFState);
//#UC START# *51D27EC50388_56BB14F503A0_var*
//#UC END# *51D27EC50388_56BB14F503A0_var*
begin
//#UC START# *51D27EC50388_56BB14F503A0_impl*
 inherited ApplyProperty(propType, What, Value, aState);
 case propType of
  propShape: if What = ipropsectd then
              f_SectProp.SBK := sbkNon;
  propColumn: AppyToColumn(What, Value, aState);              
 end;
//#UC END# *51D27EC50388_56BB14F503A0_impl*
end;//TdestNormSpec.ApplyProperty

constructor TdestNormSpec.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_56BB14F503A0_var*
//#UC END# *51E7C9DB0213_56BB14F503A0_var*
begin
//#UC START# *51E7C9DB0213_56BB14F503A0_impl*
 inherited Create(aRTFReader);
 f_ColWidths := Tl3LongintList.Make;
 f_SectProp :=  TddSectionProperty.Create;
 f_PrevColsWidth := 0;
 f_LastCell := nil;
 f_LastRow := nil;
 f_StartRow := -1;
 f_SaveInColumns := False;
 f_TabIndex := 0;
 f_SplitPara := dd_spNone;
//#UC END# *51E7C9DB0213_56BB14F503A0_impl*
end;//TdestNormSpec.Create

procedure TdestNormSpec.ParseSymbol(Symbol: Integer;
 propType: TPropType;
 aState: TddRTFState);
//#UC START# *51E8CFEF027A_56BB14F503A0_var*
//#UC END# *51E8CFEF027A_56BB14F503A0_var*
begin
//#UC START# *51E8CFEF027A_56BB14F503A0_impl*
 if (propType = propCHP) and (Symbol = Ord(cc_Tab)) then
 begin
  if NeedNewCell(aState) then
  begin
   if f_SaveInColumns then
    ParseSymbol(Symbol, propPAP, aState); // Закрываем параграф.
   AddNewCell(aState);
  end // if NeedNewCell then
  else
   AddAnsiChar(cc_HardSpace, aState);
 end // if (propType = propCHP) and (Symbol = Ord(cc_Tab)) then
 else
 begin
  inherited ParseSymbol(Symbol, propType, aState);
  if (propType = propDOP) and (Symbol = Ord(breakColumn)) then
   FinishColumn(aState)
 end;
//#UC END# *51E8CFEF027A_56BB14F503A0_impl*
end;//TdestNormSpec.ParseSymbol

procedure TdestNormSpec.ApplyToPAP(What: TIProp;
 aValue: Integer;
 aPAP: TddParagraphProperty);
//#UC START# *51E8D2F90025_56BB14F503A0_var*
//#UC END# *51E8D2F90025_56BB14F503A0_var*
begin
//#UC START# *51E8D2F90025_56BB14F503A0_impl*
 inherited ApplyToPAP(What, aValue, aPAP);
 if (What = ipropDefault) then
 begin
  if (f_SectProp.SBK = sbkNon) and (f_SectProp.cCols = 0) then
   CheckColumnTable;
  f_SectProp.Clear;
 end; // if (What = ipropDefault) then
//#UC END# *51E8D2F90025_56BB14F503A0_impl*
end;//TdestNormSpec.ApplyToPAP

procedure TdestNormSpec.ApplyToSep(aWhat: TIProp;
 aValue: LongInt);
//#UC START# *51E8D3A20193_56BB14F503A0_var*

 procedure lp_Appy2Sep(aSep: TddSectionProperty);
 begin
  with aSep do
   case aWhat of
    ipropLandscape: Landscape := True;
    ipropWidth: xaPage := aValue;
    ipropHeight: YaPage := aValue;
    ipropLeft: xaLeft := aValue;
    ipropRight: xaRight := aValue;
    ipropTop: yaTop := aValue;
    ipropBottom: yaBottom := aValue;
   end;
 end;
 
//#UC END# *51E8D3A20193_56BB14F503A0_var*
begin
//#UC START# *51E8D3A20193_56BB14F503A0_impl*
 lp_Appy2Sep(f_SectProp);
//#UC END# *51E8D3A20193_56BB14F503A0_impl*
end;//TdestNormSpec.ApplyToSep

function TdestNormSpec.pm_GetLastParagraph: TddTextParagraph;
//#UC START# *51E8D68F0379_56BB14F503A0get_var*
//#UC END# *51E8D68F0379_56BB14F503A0get_var*
begin
//#UC START# *51E8D68F0379_56BB14F503A0get_impl*
 if (f_LastCell = nil) then
  Result := inherited pm_GetLastParagraph
 else
  if f_LastCell.IsCellEmpty then
   Result := nil
  else
   Result := f_LastCell.LastTextPara;
//#UC END# *51E8D68F0379_56BB14F503A0get_impl*
end;//TdestNormSpec.pm_GetLastParagraph

function TdestNormSpec.InternalAddTextPara(aPAP: TddParagraphProperty): TddTextParagraph;
//#UC START# *51E8D7E60235_56BB14F503A0_var*
//#UC END# *51E8D7E60235_56BB14F503A0_var*
begin
//#UC START# *51E8D7E60235_56BB14F503A0_impl*
 if f_LastCell = nil then
  Result := inherited InternalAddTextPara(aPAP)
 else
  Result := f_LastCell.AddParagraph
//#UC END# *51E8D7E60235_56BB14F503A0_impl*
end;//TdestNormSpec.InternalAddTextPara

procedure TdestNormSpec.Try2ApplyParaProperty(aState: TddRTFState;
 aPara: TddTextParagraph;
 aWasPara: Boolean);
//#UC START# *521B22240197_56BB14F503A0_var*
//#UC END# *521B22240197_56BB14F503A0_var*
begin
//#UC START# *521B22240197_56BB14F503A0_impl*
 inherited;
 ClearTextPara4Table(aPara);
//#UC END# *521B22240197_56BB14F503A0_impl*
end;//TdestNormSpec.Try2ApplyParaProperty

procedure TdestNormSpec.AddPageBreak(aSymbol: Integer);
//#UC START# *5385C5C802D5_56BB14F503A0_var*
//#UC END# *5385C5C802D5_56BB14F503A0_var*
begin
//#UC START# *5385C5C802D5_56BB14F503A0_impl*

//#UC END# *5385C5C802D5_56BB14F503A0_impl*
end;//TdestNormSpec.AddPageBreak

procedure TdestNormSpec.CloseTextPara(aPAP: TddParagraphProperty;
 aPara: TddTextParagraph);
//#UC START# *56BC3011019B_56BB14F503A0_var*

 procedure lp_MoveLastPart;

  function lp_CheckNumber: Boolean;
  var
   l_Str         : Tl3String;
   l_SepPos      : PAnsiChar;
   l_ColIndex    : Integer;
   l_FinishNumber: Integer;
  begin
   Result := (f_SplitPara = dd_spNumber) or (f_SplitPara = dd_spHypen);
   if Result then
   begin
    l_SepPos := ev_lpRScan(cc_HardSpace, aPara.Text.St, aPara.Text.Len);
    if l_SepPos <> nil then
    begin
     l_FinishNumber := l_SepPos - aPara.Text.St;
     if (f_SplitPara = dd_spNumber) then
      l_ColIndex := f_CurColumn
     else
      l_ColIndex := f_CurColumn + 1;
     l_Str := Tl3String.Make(aPara.Text);
     try
      l_Str.Offset(l_FinishNumber);
      f_LastRow.Cells[l_ColIndex].LastTextPara.AddText(l_Str);
     finally
      FreeAndNil(l_Str);
     end;
     aPara.Text.Delete(l_FinishNumber, aPara.Text.Len - l_FinishNumber);
    end; // if l_SepPos <> nil then
    f_SplitPara := dd_spNone;
   end; // if (f_SplitPara = dd_spNumber) then
  end;

  procedure lp_CheckDigits;
  var
   l_Str         : Tl3String;
   l_ColumnIndex : Integer;
   l_FinishNumber: Integer;
  begin
   l_FinishNumber := ev_lpCharset2Indent(aPara.Text.St, aPara.Text.Len, cc_Digits + [cc_Dot, cc_Comma]);
   if l_FinishNumber > 0 then
   begin
    l_Str := Tl3String.Make(aPara.Text);
    try
     l_Str.Offset(l_FinishNumber);
     f_LastRow.Cells[f_CurColumn + 1].LastTextPara.AddText(l_Str);
    finally
     FreeAndNil(l_Str);
    end;
    aPara.Text.Delete(l_FinishNumber, aPara.Text.Len - l_FinishNumber);
   end; // if l_FinishNumber > 0 then 
  end;

 begin
  if (aPAP.TabList.Count = 0) and (f_TabIndex > 0) then
   lp_CheckDigits
  else
   if (aPAP.TabList.Count > 0) then
    if (aPAP.TabList.Count = f_TabIndex) then
    begin
     if not lp_CheckNumber then
      lp_CheckDigits;
     f_SplitPara := dd_spNone;
    end // if (aPara.PAP.TabList.Count > 0) and (aPara.PAP.TabList.Count = f_TabIndex) then
    else
     if (aPara.Text.Len = 1) then
     begin
      if (aPara.Text.AsChar = '№') then
       f_SplitPara := dd_spNumber;
     end // if (aPara.Text.Len = 1) then
     else
      if (aPara.Text.Len > 1) then
       if aPara.Text.Last = cc_Hyphen then
        f_SplitPara := dd_spHypen;
 end;

//#UC END# *56BC3011019B_56BB14F503A0_var*
begin
//#UC START# *56BC3011019B_56BB14F503A0_impl*
 inherited CloseTextPara(aPAP, aPara);
 if f_Table <> nil then
  lp_MoveLastPart;
 if not aPara.Text.Empty then
  if f_SaveInColumns and (f_LastCell <> nil) and not f_LastCell.IsCellEmpty then
  begin
   if (f_CurColumn > 0) then
   // Если колонка была, то добавляем выравнивающие ячейки...
    CheckNewColumn;
  end; // if f_SaveInColumns then
 ClearTextPara4Table(aPara);
//#UC END# *56BC3011019B_56BB14F503A0_impl*
end;//TdestNormSpec.CloseTextPara

function TdestNormSpec.InTable(aPAP: TddParagraphProperty): Boolean;
 {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
//#UC START# *56BC304D02E0_56BB14F503A0_var*
//#UC END# *56BC304D02E0_56BB14F503A0_var*
begin
//#UC START# *56BC304D02E0_56BB14F503A0_impl*
 Result := inherited InTable(aPAP);
 if not Result then
  Result := (f_LastCell <> nil);
//#UC END# *56BC304D02E0_56BB14F503A0_impl*
end;//TdestNormSpec.InTable

function TdestNormSpec.Itap(aPAP: TddParagraphProperty): Integer;
 {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
//#UC START# *56BDB2CD037F_56BB14F503A0_var*
//#UC END# *56BDB2CD037F_56BB14F503A0_var*
begin
//#UC START# *56BDB2CD037F_56BB14F503A0_impl*
 Result := inherited Itap(aPAP);
 if (Result = 0) and (f_LastCell <> nil) then
  Result := 1;
//#UC END# *56BDB2CD037F_56BB14F503A0_impl*
end;//TdestNormSpec.Itap

procedure TdestNormSpec.DoAddTabStop(aPAP: TddParagraphProperty);
//#UC START# *56C574EA022E_56BB14F503A0_var*
//#UC END# *56C574EA022E_56BB14F503A0_var*
begin
//#UC START# *56C574EA022E_56BB14F503A0_impl*
 if aPAP.TabList.Count = 1 then // Нам нужна реакция на первое добавление...
  if f_SaveInColumns then
  begin
   if (f_LastCell <> nil) and not f_LastCell.IsCellEmpty then
    AddNewRowWithColumn
  end // if f_SaveInColumns then
  else
   AddNewRow(aPAP);
//#UC END# *56C574EA022E_56BB14F503A0_impl*
end;//TdestNormSpec.DoAddTabStop

procedure TdestNormSpec.BeforeWriteBuffer(aText: Tl3String;
 aState: TddRTFState);
//#UC START# *572C58C602AF_56BB14F503A0_var*
//#UC END# *572C58C602AF_56BB14F503A0_var*
begin
//#UC START# *572C58C602AF_56BB14F503A0_impl*

//#UC END# *572C58C602AF_56BB14F503A0_impl*
end;//TdestNormSpec.BeforeWriteBuffer

end.
