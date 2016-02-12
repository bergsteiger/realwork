unit destNormSpec;
 {* Специализированная dest, для колонок, например. }

// Модуль: "w:\common\components\rtl\Garant\dd\destNormSpec.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , destNorm
 , l3LongintList
 , ddSectionProperty
 , ddTable
 , ddRTFState
 , RTFtypes
 , ddTableCell
 , ddCustomRTFReader
 , ddParagraphProperty
 , ddTextParagraph
;

type
 TdestNormSpec = class(TdestNorm)
  {* Специализированная dest, для колонок, например. }
  private
   f_PrevColsWidth: Integer;
   f_ColIndex: Integer;
   f_ColCount: Integer;
   f_ColWidths: Tl3LongintList;
   f_SectProp: TddSectionProperty;
  private
   procedure AddColumn4Table(aTable: TddTable;
    aUsePrevWith: Boolean);
   procedure FinishColumn(aState: TddRTFState);
   procedure CheckColumnRow;
   procedure CheckColumnTable;
   procedure AppyToColumn(aWhat: TIProp;
    aValue: LongInt;
    aState: TddRTFState);
   procedure SetCellProp(aCell: TddTableCell;
    anIndex: Integer);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ApplyToPAP(What: TIProp;
    aValue: Integer;
    aPAP: TddParagraphProperty); override;
   procedure ApplyToSep(aWhat: TIProp;
    aValue: LongInt); override;
   procedure AddPageBreak(aSymbol: Integer); override;
   procedure CloseTextPara(aPara: TddTextParagraph); override;
   function InTable(aPAP: TddParagraphProperty): Boolean; override;
    {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
   function Itap(aPAP: TddParagraphProperty): Integer; override;
    {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
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
 , ddTableRow
 , SysUtils
 , l3String
 , ddDocumentAtom
 , l3Chars
;

procedure TdestNormSpec.AddColumn4Table(aTable: TddTable;
 aUsePrevWith: Boolean);
//#UC START# *56BB3E570128_56BB14F503A0_var*
var
 l_Row  : TddTableRow;
 l_Cell : TddTableCell;
//#UC END# *56BB3E570128_56BB14F503A0_var*
begin
//#UC START# *56BB3E570128_56BB14F503A0_impl*
 aTable.CheckLastRow(False);
 l_Row := aTable.LastRow;;
 l_Cell := l_Row.GetLastNonClosedCellOrAddNew;
 if aUsePrevWith then
  SetCellProp(l_Cell, -1)
 else
  SetCellProp(l_Cell, l_Row.CellCount - 1)
//#UC END# *56BB3E570128_56BB14F503A0_impl*
end;//TdestNormSpec.AddColumn4Table

procedure TdestNormSpec.FinishColumn(aState: TddRTFState);
//#UC START# *56BB3E9801EA_56BB14F503A0_var*
var
 l_Row  : TddTableRow;
 l_Cell : TddTableCell;
 l_Table: TddTable;
//#UC END# *56BB3E9801EA_56BB14F503A0_var*
begin
//#UC START# *56BB3E9801EA_56BB14F503A0_impl*
 l_Table := LastTable(False); // Вложенные колонки не поддерживаем...
 Assert(l_Table <> nil);
 l_Row := l_Table.LastRow;
 l_Cell := l_Row.LastCell;
 l_Cell.Closed := True;
 AddColumn4Table(l_Table, False);
//#UC END# *56BB3E9801EA_56BB14F503A0_impl*
end;//TdestNormSpec.FinishColumn

procedure TdestNormSpec.CheckColumnRow;
//#UC START# *56BB3EC800A3_56BB14F503A0_var*
var
 l_Row  : TddTableRow;
 l_Table: TddTable;
//#UC END# *56BB3EC800A3_56BB14F503A0_var*
begin
//#UC START# *56BB3EC800A3_56BB14F503A0_impl*
 l_Table := LastTable(False); // Вложенные колонки не поддерживаем...
 if l_Table <> nil then
 begin
  l_Row := l_Table.LastRow;
  l_Row.Closed := True;
  if (l_Row.CellCount = 1) and l_Row[0].IsCellEmpty then Exit;
  l_Row.Closed := True;
  if f_PrevColsWidth > 0 then
   AddColumn4Table(l_Table, True);
 end; // if l_Table <> nil then
//#UC END# *56BB3EC800A3_56BB14F503A0_impl*
end;//TdestNormSpec.CheckColumnRow

procedure TdestNormSpec.CheckColumnTable;
//#UC START# *56BB3EE301F6_56BB14F503A0_var*
var
 l_Table: TddTable;
//#UC END# *56BB3EE301F6_56BB14F503A0_var*
begin
//#UC START# *56BB3EE301F6_56BB14F503A0_impl*
 l_Table := LastTable(False);
 if l_Table <> nil then
 begin
  f_ColWidths.Clear;
  l_Table.CloseRow;
  l_Table.Closed := True;
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
  l_Table: TddTable;
 begin
  l_Table := LastTable(False); // Вложенные колонки не поддерживаем...
  if l_Table = nil then
  begin
   Try2AddTable(1);
   l_Table := LastTable(False);
  end // if l_Table = nil then
  else
  begin
   l_Row := l_Table.LastRow;
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
  AddColumn4Table(l_Table, False);
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
   begin
    if f_PrevColsWidth = 0 then
     f_PrevColsWidth := lp_CalcColsWidth;
    f_ColWidths.Clear;
   end; // if f_ColWidths.Count > 0 then
   f_SectProp.cCols := aValue;
   f_ColCount := aValue;
   f_ColIndex := 0;
  end;
  ipropColNum:
   f_ColIndex := aValue - 1;
  ipropColWidth: begin
   f_ColWidths.Add(aValue);
   if f_ColIndex = (f_ColCount - 1) then
   begin
    if f_PrevColsWidth > 0 then
    begin
     l_CurWidth := lp_CalcColsWidth;
     if l_CurWidth < f_PrevColsWidth then
      f_ColWidths.Last := f_ColWidths.Last + f_PrevColsWidth - l_CurWidth;
    end; // if f_PrevColsWidth > 0 then
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
 aCell.Props.CellOffset := -1;
 if anIndex = -1 then
  aCell.Props.CellWidth := f_PrevColsWidth
 else
  aCell.Props.CellWidth := f_ColWidths[anIndex];
//#UC END# *56BD93A10343_56BB14F503A0_impl*
end;//TdestNormSpec.SetCellProp

procedure TdestNormSpec.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56BB14F503A0_var*
//#UC END# *479731C50290_56BB14F503A0_var*
begin
//#UC START# *479731C50290_56BB14F503A0_impl*
 FreeAndNil(f_ColWidths);
 FreeAndNil(f_SectProp);
 f_PrevColsWidth := 0;
 inherited;
//#UC END# *479731C50290_56BB14F503A0_impl*
end;//TdestNormSpec.Cleanup

procedure TdestNormSpec.Clear;
//#UC START# *51D27A48038E_56BB14F503A0_var*
//#UC END# *51D27A48038E_56BB14F503A0_var*
begin
//#UC START# *51D27A48038E_56BB14F503A0_impl*
 f_PrevColsWidth := 0;
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
//#UC END# *51E7C9DB0213_56BB14F503A0_impl*
end;//TdestNormSpec.Create

procedure TdestNormSpec.ParseSymbol(Symbol: Integer;
 propType: TPropType;
 aState: TddRTFState);
//#UC START# *51E8CFEF027A_56BB14F503A0_var*
//#UC END# *51E8CFEF027A_56BB14F503A0_var*
begin
//#UC START# *51E8CFEF027A_56BB14F503A0_impl*
 inherited ParseSymbol(Symbol, propType, aState);
 if (propType = propDOP) and (Symbol = Ord(breakColumn)) then
  FinishColumn(aState)
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
 end;
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

procedure TdestNormSpec.AddPageBreak(aSymbol: Integer);
//#UC START# *5385C5C802D5_56BB14F503A0_var*
//#UC END# *5385C5C802D5_56BB14F503A0_var*
begin
//#UC START# *5385C5C802D5_56BB14F503A0_impl*

//#UC END# *5385C5C802D5_56BB14F503A0_impl*
end;//TdestNormSpec.AddPageBreak

procedure TdestNormSpec.CloseTextPara(aPara: TddTextParagraph);
//#UC START# *56BC3011019B_56BB14F503A0_var*

 function lp_AddCell(aRow: TddTableRow; anInTable: Boolean; anIndex: Integer): TddTableCell;
 begin
  if anInTable then
   Result := aRow.InsertCell(anIndex)
  else
   Result := aRow.GetLastNonClosedCellOrAddNew
 end;

 procedure lp_AddText2Cell(aCell: TddTableCell; aStart, aFinish, aWidth: Integer);
 var
  l_TextPara: TddTextParagraph;
 begin
  aCell.Props.CellOffset := aWidth;
  l_TextPara := aCell.AddParagraph;
  l_TextPara.Text.AsPCharLen := l3PCharLenPart(aPara.Text.St, aStart, aFinish, aPara.Text.CodePage);
  l_TextPara.Closed := True;
  aCell.Closed := True;
 end;

var
 i        : Integer;
 l_Row    : TddTableRow;
 l_Para   : TddDocumentAtom;
 l_Table  : TddTable;
 l_Start  : Integer;
 l_Offset : Integer;
 l_Indent : Integer;
 l_TabPos : Integer;
 l_NewCell: TddTableCell;
 l_OldCell: TddTableCell;
 l_InTable: Boolean;
//#UC END# *56BC3011019B_56BB14F503A0_var*
begin
//#UC START# *56BC3011019B_56BB14F503A0_impl*
 inherited CloseTextPara(aPara);
 if (aPara.PAP.TabList.Count > 0) then
 begin
  l_Table := nil;
  l_Para := nil;
  l_OldCell := nil;
  l_InTable := InTable(aPara.PAP);
  if l_InTable then
  begin
   l_Table := LastTable(False);
   l_Row := l_Table.LastRow;
   l_OldCell := l_Row.LastCell;
  end // if l_InTable then
  else
  begin
   if GetParagraphsCount > 1 then
   begin
    l_Para := Paragraph[GetParagraphsCount - 2];
    if l_Para.IsTable then
     l_Table := TddTable(l_Para)
    else
     l_Para := nil;
   end; // if f_Paragraph.Count > 1 then
   if l_Table = nil then
   begin
    Try2AddTable(1);
    l_Table := LastTable(False);
   end; // if l_Para = nil then
   l_Table.CheckLastRow(False);
   l_Row := l_Table.LastRow;
  end;
  Assert(l_Table <> nil);
  l_Start := 0;
  l_TabPos := 0;
  l_Indent := 0;
  l_Offset := 0;
  for i := 0 to aPara.Text.Len - 1 do
  begin
   if aPara.Text.Ch[i] = cc_Tab then
   begin
    l_TabPos := i;
    l_Offset := TddTab(aPara.PAP.TabList[l_Indent]).TabPos;
    l_NewCell := lp_AddCell(l_Row, l_InTable, l_OldCell.anIndex);
    lp_AddText2Cell(l_NewCell, l_Start, l_TabPos, l_Offset);
    l_Start := l_TabPos + 1;
    Inc(l_Indent);
   end; // if aPara.Text.Ch[i] in cc_Tab then
   if l_Indent >= aPara.PAP.TabList.Count then Break;
  end; // for i := 0 to l_TextPara.Text.Len - 1 do
  if l_InTable then
  begin
   l_OldCell.Props.CellOffset := l_OldCell.Props.CellOffset - l_Offset;
   // Текст "обрубить"...
  end // if l_InTable then
  else
  begin
   Inc(l_Offset, 2000);
   l_NewCell := lp_AddCell(l_Row, l_InTable, 0);
   lp_AddText2Cell(l_NewCell, l_Start, aPara.Text.Len - 1, l_Offset);
   DeleteLastAtom(l_Para = nil);
   l_Row.Closed := True;
   l_Table.Closed := True;
  end; // if l_InTable then
  if (l_Para <> nil) or l_InTable then
   aPara.PAP.TabList.Clear; // Чтобы дальше что-нибудь не сработало.
 end; // if not aPara.PAP.InTable and (aPara.TablList.Count > 0) then
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
  Result := f_ColWidths.Count > 0;
//#UC END# *56BC304D02E0_56BB14F503A0_impl*
end;//TdestNormSpec.InTable

function TdestNormSpec.Itap(aPAP: TddParagraphProperty): Integer;
 {* Хак того, чтобы параграф при добавлении помещался в таблицу, а не в основной текст. }
//#UC START# *56BDB2CD037F_56BB14F503A0_var*
//#UC END# *56BDB2CD037F_56BB14F503A0_var*
begin
//#UC START# *56BDB2CD037F_56BB14F503A0_impl*
 Result := inherited Itap(aPAP);
 if (Result = 0) and (f_ColWidths.Count > 0) then
  Result := 1;
//#UC END# *56BDB2CD037F_56BB14F503A0_impl*
end;//TdestNormSpec.Itap

end.
