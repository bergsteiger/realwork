unit destNormSpec;
 {* Специализированная dest, для колонок, например. }

// Модуль: "w:\common\components\rtl\Garant\dd\destNormSpec.pas"
// Стереотип: "SimpleClass"

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
;

type
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
   f_CurColumn: Integer;
    {* Номер текущей колонки (в которую будет добавляться текст). }
   f_StartRow: Integer;
    {* Номер строки, с которой начинается колонка. }
   f_LastCell: TddTableCell;
    {* Ячейка для добавления текста. }
   f_LastRow: TddTableRow;
    {* Строка для добавления текста. }
   f_SaveInColumns: Boolean;
    {* Сохраняем в колонки. }
   f_TabIndex: Integer;
    {* Текущий индекс табуляции параграфа. }
   f_Table: TddTable;
    {* Таблица, в которую пишем, даже если колонки кончились... }
  private
   procedure AddColumn4Table(aRowIndex: Integer);
   procedure FinishColumn(aState: TddRTFState);
   procedure CheckColumnRow;
   procedure CheckColumnTable;
   procedure AppyToColumn(aWhat: TIProp;
    aValue: LongInt;
    aState: TddRTFState);
   procedure SetCellProp(aCell: TddTableCell;
    anIndex: Integer);
   procedure AddNewRowWithColumn;
   procedure CheckLeftIndent(aPAP: TddParagraphProperty);
   function ColumnOffset(anIndex: Integer): Integer;
   function CheckNewColumn: Boolean;
   function NeedNewCell(aState: TddRTFState): Boolean;
   procedure AddNewCell(aState: TddRTFState);
   procedure ClearTextPara4Table(aPara: TddTextParagraph);
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
  public
   procedure Clear; override;
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
 , l3Base
;

procedure TdestNormSpec.AddColumn4Table(aRowIndex: Integer);
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

procedure TdestNormSpec.CheckColumnRow;
//#UC START# *56BB3EC800A3_56BB14F503A0_var*
var
 l_Row: TddTableRow;
//#UC END# *56BB3EC800A3_56BB14F503A0_var*
begin
//#UC START# *56BB3EC800A3_56BB14F503A0_impl*
 if f_Table <> nil then
 begin
  l_Row := f_Table.LastRow;
  l_Row.Closed := True;
  if (l_Row.CellCount = 1) and l_Row[0].IsCellEmpty then Exit;
  l_Row.Closed := True;
 end; // if l_Table <> nil then
//#UC END# *56BB3EC800A3_56BB14F503A0_impl*
end;//TdestNormSpec.CheckColumnRow

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
   f_ColIndex := aValue - 1;
  ipropColumnRight:
   f_ColWidths[f_ColIndex] := f_ColWidths[f_ColIndex] + aValue;
  ipropColWidth: begin
   f_ColWidths.Add(aValue);
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

procedure TdestNormSpec.AddNewRowWithColumn;
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

procedure TdestNormSpec.CheckLeftIndent(aPAP: TddParagraphProperty);
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
 if (l_LeftIndent > 0) and (f_ColWidths.Count > 0) then
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

procedure TdestNormSpec.AddNewCell(aState: TddRTFState);
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
 if (f_LastCell <> nil) and (aState.PAP.TabList.Count > 0) and (f_TabIndex < aState.PAP.TabList.Count) then
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
    //if f_CurColumn > -1 then
    // Inc(l_Offset, ColumnOffset(f_CurColumn));
    f_LastRow.LastCell.Props.CellOffset := l_Offset;
    f_LastCell.Closed := True;
    f_LastCell := lp_AddCell(f_LastRow, l_Offset);
    Inc(f_TabIndex);
    if f_TabIndex = aState.PAP.TabList.Count then
     f_LastRow.LastCell.Props.CellOffset := f_PrevColsWidth;
   end; // if (f_LastCell <> nil) and (aState.PAP.TabList.Count > 0) then
//#UC END# *56C6FD3B01A5_56BB14F503A0_impl*
end;//TdestNormSpec.AddNewCell

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
 inherited;
//#UC END# *51D27A48038E_56BB14F503A0_impl*
end;//TdestNormSpec.Clear

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
 var
  l_Str         : Tl3String;
  l_FinishNumber: Integer;
 begin
  if (aPAP.TabList.Count > 0) and (aPAP.TabList.Count = f_TabIndex) then
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
   end; //if l_FinishNumber > 0 then
  end; // if (aPara.PAP.TabList.Count > 0) and (aPara.PAP.TabList.Count = f_TabIndex) then
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
   end; // if f_Table <> nil then
//#UC END# *56C574EA022E_56BB14F503A0_impl*
end;//TdestNormSpec.DoAddTabStop

end.
