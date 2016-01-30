unit ddTextToTableConverters;
 {* Набор классов для преобразования различных текстов в таблицы }

// Модуль: "w:\common\components\rtl\Garant\dd\ddTextToTableConverters.pas"
// Стереотип: "UtilityPack"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3Base
 , ddTextParagraph
 , l3StringList
 , ddTableConvTypes
 , ddDocument
 , ddRowList
 , ddTableRow
 , ddVirtualTable
 , evdTypes
 , ddTableCell
 , l3Parser
;

type
 TddAbstractTable = {abstract} class(Tl3Base)
  private
   f_CurLine: Integer;
   f_RowList: TddRowList;
   f_Row: TddTableRow;
   f_Lines: Tl3StringList;
    {* Поле для свойства Lines }
   f_AutoFit: TddAutoFitBehavior;
    {* Поле для свойства AutoFit }
   f_CellCount: Integer;
    {* Поле для свойства CellCount }
   f_ComplexTable: Boolean;
    {* Поле для свойства ComplexTable }
   f_FormatBuffer: TddDocument;
    {* Поле для свойства FormatBuffer }
   f_RowCount: Integer;
    {* Поле для свойства RowCount }
   f_GlueLines: Boolean;
    {* Поле для свойства GlueLines }
   f_TableWidth: Integer;
    {* Поле для свойства TableWidth }
  protected
   procedure pm_SetLines(aValue: Tl3StringList);
   procedure pm_SetAutoFit(aValue: TddAutoFitBehavior);
   procedure pm_SetCellCount(aValue: Integer);
   procedure pm_SetFormatBuffer(aValue: TddDocument);
   procedure pm_SetRowCount(aValue: Integer);
   procedure RecalcRows; virtual;
   function ApplyFormatting(aP: TddTextParagraph;
    const aCell: TddTableCell): Boolean;
   function GetPrevCell(aCell: TddTableCell): TddTableCell;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent); virtual;
   procedure CopyToVirtualTable(aTable: TddVirtualTable); virtual;
   function CheckJustification(aText: Tl3String;
    aCellWidth: Integer): TevIndentType;
   procedure AddParagraph(aText: Tl3String = nil;
    aCell: TddTableCell = nil);
   procedure AddText(aCell: TddTableCell;
    aText: Tl3String); overload;
   procedure AddText(aCell: TddTableCell;
    aText: Tl3String;
    aStart: Integer;
    aLen: Integer); overload;
   constructor Create; override;
    {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
  public
   property Lines: Tl3StringList
    read f_Lines
    write pm_SetLines;
   property AutoFit: TddAutoFitBehavior
    read f_AutoFit
    write pm_SetAutoFit;
   property CellCount: Integer
    read f_CellCount
    write pm_SetCellCount;
   property ComplexTable: Boolean
    read f_ComplexTable;
   property FormatBuffer: TddDocument
    read f_FormatBuffer
    write pm_SetFormatBuffer;
   property RowCount: Integer
    read f_RowCount
    write pm_SetRowCount;
   property GlueLines: Boolean
    read f_GlueLines
    write f_GlueLines;
   property TableWidth: Integer
    read f_TableWidth
    write f_TableWidth;
 end;//TddAbstractTable

 TddGraphicTable = class(TddAbstractTable)
  private
   f_LineParser: Tl3CustomParser;
   f_Text: Tl3String;
   f_LogicalTable: Boolean;
    {* Флаг несоответствия количества ячеек в текущей строке и следующей. }
  protected
   function CheckRowEnd: Boolean;
   procedure CheckMixed(const OnlySpaces: Boolean = False);
   procedure CheckOnlyGraphic;
   procedure CheckGraphicAndSpace(const CloseTable: Boolean = False);
   procedure WriteRow;
   procedure ScanForCols;
   procedure CorrectRow;
   function ConvertCellToRow(aBottomBorder: Boolean): Boolean;
   function GetPrevVMergeCell(aPos: Integer;
    aNeedCheckVMerge: Boolean): TddTableCell;
   procedure RecalcRows; override;
  public
   procedure Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent); override;
 end;//TddGraphicTable

 TddSpaceTable = class(TddAbstractTable)
  protected
   procedure Map2Row(aMap: Tl3String);
  public
   procedure Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent); override;
 end;//TddSpaceTable

 TddSeparatorTable = class(TddAbstractTable)
  private
   f_Separator: AnsiChar;
    {* Поле для свойства Separator }
  protected
   procedure pm_SetSeparator(aValue: AnsiChar); virtual;
   procedure RecalcRows; override;
  public
   constructor Create(aSeparator: AnsiChar); reintroduce;
   procedure Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent); override;
  public
   property Separator: AnsiChar
    read f_Separator
    write pm_SetSeparator;
 end;//TddSeparatorTable

 TddParagraphTable = class(TddAbstractTable)
  {* TddParagraphTable }
  protected
   function CalcTextLen(aText: Tl3String): Integer;
  public
   procedure Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent); override;
 end;//TddParagraphTable

implementation

uses
 l3ImplUses
 , l3Chars
 , ddTextSegment
 , ddDocumentAtom
 , ddBase
 , ddDocumentAtomList
 , ddTextParaString
 , l3MinMax
 , l3String
 , SysUtils
 , RTFtypes
 , ddCellProperty
 , Classes
 , l3Interfaces
 , l3Memory
 , l3Filer
 , l3Types
;

const
 cc_CellChar = 'X';
 cc_BreakChar = '|';
 CellStartChars = [cc_RightCross, cc_LeftCross, cc_Cross, cc_UpCross, cc_TopLeft, cc_TopRight];
 CellStopChars = [cc_RightCross, cc_Cross, cc_UpCross, cc_BottomRight, cc_TopRight];
 CellBreakChars = [cc_LeftCross, cc_RightCross];
 CellWhiteSpace = [cc_HLine];
 CellAdvStartChars = CellStartChars + CellBreakChars;
 CellOverChars = [cc_Cross, cc_DownCross];
 CellCLoseTable = [cc_BottomLeft, cc_BottomRight];

function OnlyGraphic(aText: Tl3String): Boolean;
 {* Строка содержит только псевдографику или пуста }
//#UC START# *4FACF2810235_4DCA38890051_var*
//#UC END# *4FACF2810235_4DCA38890051_var*
begin
//#UC START# *4FACF2810235_4DCA38890051_impl*
 Result := aText.Empty or
           not l3CharSetPresent(aText.St, aText.Len, [#0..#255] - cc_Frames);
//#UC END# *4FACF2810235_4DCA38890051_impl*
end;//OnlyGraphic

function OnlyGraphicAndSpace(aText: Tl3String): Boolean;
//#UC START# *4FACF2C700BE_4DCA38890051_var*
//#UC END# *4FACF2C700BE_4DCA38890051_var*
begin
//#UC START# *4FACF2C700BE_4DCA38890051_impl*
 Result:= aText.Empty or
          not l3CharSetPresent(aText.St, aText.Len, [#0..#255] - [#32] - cc_Frames);
//#UC END# *4FACF2C700BE_4DCA38890051_impl*
end;//OnlyGraphicAndSpace

procedure AdjustSegments(Index: Integer;
 aPara: TddTextParagraph);
//#UC START# *4FACF2E00126_4DCA38890051_var*
var
 i: Integer;
 l_S: TddTextSegment;
//#UC END# *4FACF2E00126_4DCA38890051_var*
begin
//#UC START# *4FACF2E00126_4DCA38890051_impl*
 for i := 0 to Pred(aPara.SegmentCount) do
 begin
  l_S:= aPara.Segments[i];
  if l_S.Start > Index then
   l_S.Start:= Pred(l_S.Start);
  if l_S.Stop > Index then
   l_S.Stop:= Pred(l_S.Stop);
 end;
//#UC END# *4FACF2E00126_4DCA38890051_impl*
end;//AdjustSegments

procedure AdjustTrimAll(aPara: TddTextParagraph;
 aText: Tl3String);
//#UC START# *4FACF3110346_4DCA38890051_var*
var
 i: Integer;
//#UC END# *4FACF3110346_4DCA38890051_var*
begin
//#UC START# *4FACF3110346_4DCA38890051_impl*
 if not aText.Empty then
 begin
  // Отрезаем пробелы слева
  i := 0;
  while aText.Ch[i] = ' ' do
  begin
   AdjustSegments(i, aPara);
   aText.Delete(0, 1);
  end; // while aText.Ch[i] = ' ' do
  // Отрезаем пробелы справа
  while aText.Ch[Pred(aText.Len)] = ' ' do
  begin
   AdjustSegments(Pred(aText.Len), aPara);
   aText.Delete(Pred(aText.Len), 1);
  end; // if aText <> nil then
  //Удаляем двойные пробелы внутри
  i := 0;
  while  i < Pred(aText.Len) do
  begin
   if (aText.Ch[i] = ' ') and (aText.Ch[Succ(i)] = ' ') then
   begin
    AdjustSegments(i, aPara);
    aText.Delete(i, 1);
   end // if (aText.Ch[i] = ' ') and (aText.Ch[Succ(i)] = ' ') then
   else
    Inc(i);
  end; // while  i < Pred(aText.Len) do
 end; // if not aText.Empty then
//#UC END# *4FACF3110346_4DCA38890051_impl*
end;//AdjustTrimAll

procedure TddAbstractTable.pm_SetLines(aValue: Tl3StringList);
//#UC START# *4FACDCB300D7_4DCA38AF0022set_var*
//#UC END# *4FACDCB300D7_4DCA38AF0022set_var*
begin
//#UC START# *4FACDCB300D7_4DCA38AF0022set_impl*
 f_Lines.Assign(aValue);
//#UC END# *4FACDCB300D7_4DCA38AF0022set_impl*
end;//TddAbstractTable.pm_SetLines

procedure TddAbstractTable.pm_SetAutoFit(aValue: TddAutoFitBehavior);
//#UC START# *4FACDD0C02C4_4DCA38AF0022set_var*
//#UC END# *4FACDD0C02C4_4DCA38AF0022set_var*
begin
//#UC START# *4FACDD0C02C4_4DCA38AF0022set_impl*
 f_AutoFit:= aValue;
//#UC END# *4FACDD0C02C4_4DCA38AF0022set_impl*
end;//TddAbstractTable.pm_SetAutoFit

procedure TddAbstractTable.pm_SetCellCount(aValue: Integer);
//#UC START# *4FACDD520175_4DCA38AF0022set_var*
//#UC END# *4FACDD520175_4DCA38AF0022set_var*
begin
//#UC START# *4FACDD520175_4DCA38AF0022set_impl*
 if CellCount <> aValue then
 begin
  f_CellCount:= aValue;
  RecalcRows;
 end;
//#UC END# *4FACDD520175_4DCA38AF0022set_impl*
end;//TddAbstractTable.pm_SetCellCount

procedure TddAbstractTable.pm_SetFormatBuffer(aValue: TddDocument);
//#UC START# *4FACDED5010D_4DCA38AF0022set_var*
//#UC END# *4FACDED5010D_4DCA38AF0022set_var*
begin
//#UC START# *4FACDED5010D_4DCA38AF0022set_impl*
 f_FormatBuffer.Assign(aValue);
//#UC END# *4FACDED5010D_4DCA38AF0022set_impl*
end;//TddAbstractTable.pm_SetFormatBuffer

procedure TddAbstractTable.pm_SetRowCount(aValue: Integer);
//#UC START# *4FACDF1401DC_4DCA38AF0022set_var*
//#UC END# *4FACDF1401DC_4DCA38AF0022set_var*
begin
//#UC START# *4FACDF1401DC_4DCA38AF0022set_impl*
 if RowCount <> aValue then
 begin
  f_RowCount:= aValue;
  RecalcRows;
 end;
//#UC END# *4FACDF1401DC_4DCA38AF0022set_impl*
end;//TddAbstractTable.pm_SetRowCount

procedure TddAbstractTable.Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent);
//#UC START# *4FACDFA2002E_4DCA38AF0022_var*
//#UC END# *4FACDFA2002E_4DCA38AF0022_var*
begin
//#UC START# *4FACDFA2002E_4DCA38AF0022_impl*
 f_CellCount:= 0;
 f_RowCount:= 0;
 f_CurLine:= 0;
//#UC END# *4FACDFA2002E_4DCA38AF0022_impl*
end;//TddAbstractTable.Analyze

procedure TddAbstractTable.RecalcRows;
//#UC START# *4FACDFDE03BB_4DCA38AF0022_var*
//#UC END# *4FACDFDE03BB_4DCA38AF0022_var*
begin
//#UC START# *4FACDFDE03BB_4DCA38AF0022_impl*
 f_CellCount:= 0;
 f_RowCount:= 0;
//#UC END# *4FACDFDE03BB_4DCA38AF0022_impl*
end;//TddAbstractTable.RecalcRows

procedure TddAbstractTable.CopyToVirtualTable(aTable: TddVirtualTable);
//#UC START# *4FACE0030183_4DCA38AF0022_var*
var
  j: Integer;
//#UC END# *4FACE0030183_4DCA38AF0022_var*
begin
//#UC START# *4FACE0030183_4DCA38AF0022_impl*
 for j := 0 to f_RowList.Hi do
  aTable.AddRow(TddTableRow(f_RowList.Items[j]));
//#UC END# *4FACE0030183_4DCA38AF0022_impl*
end;//TddAbstractTable.CopyToVirtualTable

function TddAbstractTable.CheckJustification(aText: Tl3String;
 aCellWidth: Integer): TevIndentType;
//#UC START# *4FACE6BE00D9_4DCA38AF0022_var*
var
 l_Left  : Integer;
 l_Right : Integer;
//#UC END# *4FACE6BE00D9_4DCA38AF0022_var*
begin
//#UC START# *4FACE6BE00D9_4DCA38AF0022_impl*
 if (aText.Len > 0) and not l3AllCharsInCharSet(aText.AsWStr, [' ']) then
 begin
  l_Left := aText.Len - aText.LTrimLen;
  l_Right := aText.Len - aText.RTrimLen;
  if (l_Right = 0) and (aText.Len < aCellWidth) then
   l_Right := aCellWidth - aText.Len;
  if (l_Left > 0) and (l_Right > 0) and
     (Abs(l_Right - l_Left) < Min(l_Left, l_Right)) then
   Result := ev_itCenter
  else
  if (l_Left > l_Right) and (l_Left > 1) and (l_Right > 1) then
   Result := ev_itRight
  else
  if (l_Right > l_Left) and (l_Left > 1) and (l_Right > 1) then
   Result := ev_itLeft
  else
   Result := ev_itWidth;
 end // if (aText.Len > 0) and not IsEmptyStr(aText, [' ']) then
 else
  Result := ev_itLeft;
//#UC END# *4FACE6BE00D9_4DCA38AF0022_impl*
end;//TddAbstractTable.CheckJustification

procedure TddAbstractTable.AddParagraph(aText: Tl3String = nil;
 aCell: TddTableCell = nil);
//#UC START# *4FACE73000CE_4DCA38AF0022_var*
var
 l_Para : TddTextParagraph;
 l_New  : Boolean;
 l_Len  : Integer;
 l_Cell : TddTableCell;
//#UC END# *4FACE73000CE_4DCA38AF0022_var*
begin
//#UC START# *4FACE73000CE_4DCA38AF0022_impl*
 if aCell <> nil then
  l_Cell := aCell
 else
  l_Cell := f_Row.LastCell;
 l_Para := TddTextParagraph.Create(nil);
 try
  if aText <> nil then
  begin
   l_Len := aCell.Props.CellOffset;
   if aCell.anIndex > 0 then
    Dec(l_Len, f_Row.Cells[aCell.anIndex - 1].Props.CellOffset);
   l_Para.PAP.Just := k2JustToJust(CheckJustification(aText, l_Len));
  end; // if aText <> nil then
  if ApplyFormatting(l_Para, l_Cell) and (aText <> nil) then
  begin
   AdjustTrimAll(l_Para, aText);
   l_Para.Text := aText;
  end; // if ApplyFormatting(l_Para, l_Cell) and (aText <> nil) then
  l_Cell.Add(l_Para);
 finally
  l3Free(l_Para);
 end; // try.. finally
//#UC END# *4FACE73000CE_4DCA38AF0022_impl*
end;//TddAbstractTable.AddParagraph

procedure TddAbstractTable.AddText(aCell: TddTableCell;
 aText: Tl3String);
//#UC START# *4FACE8BC035B_4DCA38AF0022_var*
var
 l_Len  : Integer;
 l_Cell : TddTableCell;
//#UC END# *4FACE8BC035B_4DCA38AF0022_var*
begin
//#UC START# *4FACE8BC035B_4DCA38AF0022_impl*
 with aCell.LastTextPara do
 begin
  if not Empty then
   AddParagraph(aText, aCell)
  else
  begin
   l_Len := aCell.Props.CellOffset;
   l_Cell := GetPrevCell(aCell);
   if l_Cell <> nil then
    Dec(l_Len, l_Cell.Props.CellOffset);

   PAP.Just := k2JustToJust(CheckJustification(aText, l_Len));
   if ApplyFormatting(aCell.LastTextPara, aCell) then
   begin
    AdjustTrimAll(aCell.LastTextPara, aText);
    AddText(aText);
   end // if ApplyFormatting(aCell.LastPara, aCell) then
  end;
 end; // with
//#UC END# *4FACE8BC035B_4DCA38AF0022_impl*
end;//TddAbstractTable.AddText

procedure TddAbstractTable.AddText(aCell: TddTableCell;
 aText: Tl3String;
 aStart: Integer;
 aLen: Integer);
//#UC START# *4FACE8DF0349_4DCA38AF0022_var*
var
 l_Len     : Integer;
 l_Para    : TddTextParagraph;
 l_Cell    : TddTableCell;
 l_Start   : Integer;
 l_NewPara : Boolean;
 l_TextStr : TddTextParaString;
//#UC END# *4FACE8DF0349_4DCA38AF0022_var*
begin
//#UC START# *4FACE8DF0349_4DCA38AF0022_impl*
 l_NewPara := not aCell.LastTextPara.Empty;
 l_Start := aStart;
 if l_NewPara then
  l_Para := TddTextParagraph.Create(nil)
 else
 begin
  l_Para := aCell.LastTextPara;
  Inc(l_Start);
 end;
 try
  if l_NewPara and (aText <> nil) then
   l_Para.Text.CodePage := aText.CodePage;
  with l_Para do
  begin
   l_Len := aCell.Props.CellOffset;
   l_Cell := GetPrevCell(aCell);
   if l_Cell <> nil then
    Dec(l_Len, l_Cell.Props.CellOffset);
   l_TextStr := TddTextParaString.Create(l_Para);
   try
    l_TextStr.AsString := Copy(aText.AsString, l_Start, aLen);
    PAP.Just := k2JustToJust(CheckJustification(l_TextStr, l_Len));
    if ApplyFormatting(l_Para, aCell) then
    begin
     l_TextStr.LTrim;
     l_TextStr.DeleteDoubleSpace;
     AddText(l_TextStr.AsString, aText.CodePage);
    end; // if ApplyFormatting(l_Para, aCell) then
   finally
    l3Free(l_TextStr);
   end;
   if l_NewPara then
    aCell.Add(l_Para);
  end; // with
 finally
  if l_NewPara then
   l3Free(l_Para);
 end; // try.. finally
//#UC END# *4FACE8DF0349_4DCA38AF0022_impl*
end;//TddAbstractTable.AddText

function TddAbstractTable.ApplyFormatting(aP: TddTextParagraph;
 const aCell: TddTableCell): Boolean;
//#UC START# *4FACFE6F02DF_4DCA38AF0022_var*
var
 l_A      : TddDocumentAtom;
 i, j     : Integer;
 l_Cell   : TddTableCell;
 l_Len    : Integer;
 l_Text   : TddTextParagraph;
 l_Stop   : Integer;
 l_Trim   : Integer;
 l_Delta  : Integer;
 l_Start  : Integer;
 l_SegLen : Integer;
 l_OldSeg : TddTextSegment;
 l_NewSeg : TddTextSegment;
//#UC END# *4FACFE6F02DF_4DCA38AF0022_var*
begin
//#UC START# *4FACFE6F02DF_4DCA38AF0022_impl*
 Result := True;
 if f_CurLine >= f_FormatBuffer.Paragraphs.Count then Exit;
 // Stub
 l_A := f_FormatBuffer.Paragraphs[f_CurLine];
 if l_A.IsTextPara then
 begin
  l_Text := l_A as TddTextParagraph;
  if aCell.anIndex = 0 then // Добавляем метки
   if l_Text.SubList.Count > 0 then
    aP.SubList.JoinWith(l_Text.SubList);

  l_Cell := GetPrevCell(aCell);
  if l_Cell = nil then
   l_Delta := 0
  else
   l_Delta := l_Cell.Props.CellOffset;
  l_Len := aCell.Props.CellOffset;
  l_Trim := 0;
  // Добавляем оформление
  if l_Text.SegmentCount > 0 then
  begin
   aP.ClearSegments;
   for i := 0 to l_Text.SegmentCount - 1 do
   begin
    if (l_Text.Segments[i].Start >= l_Delta) and (l_Text.Segments[i].Stop <= l_Len) then
    begin
     l_OldSeg := l_Text.Segments[i];
     l_NewSeg := l_OldSeg.Clone;
     try
      l_Start := l_Delta + l_Trim;
      l_Stop := l_Len - l_Trim + 1;
      l_SegLen := l_NewSeg.Stop - l_NewSeg.Start + 1;

      for j := l_Start to l_Stop do
       if (j <= l_NewSeg.Start) and (l_Text.Text.Ch[j] in cc_Frames) then
        Inc(l_Trim)
       else
        Break;
      Dec(l_Trim);
      if l_Delta > 0 then
       l_NewSeg.Start := Max(0, l_NewSeg.Start - l_Trim) - l_Delta;

      { TODO -oNarry -cОшибка : Почему-то сегмент получается на один символ меньше }
      for j := l_Stop downto l_Start do
       if (j <= l_NewSeg.Stop) and (l_Text.Text.Ch[j] in cc_Frames) then
       begin
        Inc(l_Trim);
        Dec(l_SegLen);
       end // if (j <= l_NewSeg.Stop) and (l_Text.Text.Ch[j] in cc_Frames) then
       else
        Break;
      l_NewSeg.Stop := l_NewSeg.Start + l_SegLen;
      if l_NewSeg.Start >= 0 then
       aP.AddSegment(l_NewSeg);
     finally
      l3Free(l_NewSeg);
     end;
    end; // if (l_Text.Segments[i].Start >= l_Delta) and
   end; // for i
   //Result:= False;
  end;
 end; // l_A.AtomType = dd_docTextParagraph
//#UC END# *4FACFE6F02DF_4DCA38AF0022_impl*
end;//TddAbstractTable.ApplyFormatting

function TddAbstractTable.GetPrevCell(aCell: TddTableCell): TddTableCell;
//#UC START# *528CA17D0210_4DCA38AF0022_var*
//#UC END# *528CA17D0210_4DCA38AF0022_var*
begin
//#UC START# *528CA17D0210_4DCA38AF0022_impl*
 if aCell.anIndex > 0 then
  Result := f_Row[aCell.anIndex - 1]
 else
  Result := nil;
//#UC END# *528CA17D0210_4DCA38AF0022_impl*
end;//TddAbstractTable.GetPrevCell

constructor TddAbstractTable.Create;
 {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
//#UC START# *47914F960008_4DCA38AF0022_var*
//#UC END# *47914F960008_4DCA38AF0022_var*
begin
//#UC START# *47914F960008_4DCA38AF0022_impl*
 inherited;
 f_Lines:= Tl3StringList.Make;
 f_FormatBuffer := TddDocument.Create(nil);
 f_RowList:= TddRowList.Make;
 f_CellCount:= 0;
 f_RowCount:= 0;
 f_AutoFit:= afContent;
//#UC END# *47914F960008_4DCA38AF0022_impl*
end;//TddAbstractTable.Create

procedure TddAbstractTable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DCA38AF0022_var*
//#UC END# *479731C50290_4DCA38AF0022_var*
begin
//#UC START# *479731C50290_4DCA38AF0022_impl*
 l3Free(f_FormatBuffer);
 l3Free(f_RowList);
 l3Free(f_Lines);
 inherited;
//#UC END# *479731C50290_4DCA38AF0022_impl*
end;//TddAbstractTable.Cleanup

function TddGraphicTable.CheckRowEnd: Boolean;
//#UC START# *4FACEB5D0335_4DCA38C7030D_var*
//#UC END# *4FACEB5D0335_4DCA38C7030D_var*
begin
//#UC START# *4FACEB5D0335_4DCA38C7030D_impl*
 if not OnlyGraphic(f_Text) then
 begin
  Result := True;
 // Кроме псевдографики есть еще и другие символы
 // Дополнительная проверка на случай объед. верт. ячеек     
  if l3CharSetPresent(l3CStr(f_Text), CellStopChars) then
   CheckMixed
  else
   if OnlyGraphicAndSpace(f_Text) then
    CheckGraphicAndSpace
    //CheckMixed(True)
   else
    Result := False;
 end // if not OnlyGraphic(f_Text) then
 else
 begin
  if l3CharSetPresent(l3CStr(f_Text), CellCloseTable) and f_LogicalTable then
   CheckGraphicAndSpace(True)
  else
   CheckOnlyGraphic;
  Result := True;
 end;
//#UC END# *4FACEB5D0335_4DCA38C7030D_impl*
end;//TddGraphicTable.CheckRowEnd

procedure TddGraphicTable.CheckMixed(const OnlySpaces: Boolean = False);
//#UC START# *4FACEBB6021F_4DCA38C7030D_var*
var
 l_Cell       : TddTableCell;
 i, j         : Integer;
 l_Length     : Integer;
 l_ColText    : Tl3String;
 l_LineStream : TStream;
 l_AddCell    : Boolean;
 l_TokenStr   : Tl3String;
 l_TokenStr1  : Tl3String;
 l_PrevStr    : Il3CString;
 l_FilterPos  : Integer;
 l_PrevFPos   : Integer;
 l_OldCell    : TddTableCell;
//#UC END# *4FACEBB6021F_4DCA38C7030D_var*
begin
//#UC START# *4FACEBB6021F_4DCA38C7030D_impl*
 // Нужно вычленить оставшиеся ячейки и вылить их, закрыв строку
 //  и перерассчитав количество ячеек.
 l_LineStream := Tl3StringStream.Create(f_Text);
 try
  with f_LineParser do
  begin
   CheckFiler.Stream := l_LineStream;
   try
    f_LineParser.WhiteSpace := CellWhiteSpace;
    f_LineParser.WordChars := [#0 .. #255] - cc_Frames;
    // - Концом ключевого слова является псевдографика
    f_LineParser.CheckInt := False;
    while not f_LineParser.Filer.EOF do
    begin
     f_LineParser.NextTokenSp;
     l_PrevStr := l3CStr(f_LineParser.TokenLongString);
     l_PrevFPos := f_LineParser.Filer.Pos;
     f_LineParser.NextTokenPrim(l3NextTokenAllFlags - [l3_ntfCheckString]);
     l_TokenStr := f_LineParser.TokenLongString;
     //!!! НЕ ПИСАТЬ l3CStr(TokenLongString) - грохнете строку !!!
     if (l_TokenStr.Len > 0)
        and not l3CharSetPresent(l3CStr(l_TokenStr), cc_Frames) then
     try
      // - Прежде чем вносить текст, нужно найти ячейку
      l_FilterPos := f_LineParser.Filer.Pos;
      l_Cell := GetPrevVMergeCell(l_FilterPos, False);
      if (l_Cell = nil) or l_Cell.Props.Border.Frames[bpBottom].Enable then
      begin
       l_OldCell := l_Cell;
       l_Cell := f_Row.CellByPos[l_FilterPos];
       if (l_OldCell <> nil) and ((l_Cell = nil) or l_Cell.Props.VMerged) then
        l_Cell := l_OldCell;
      end;//if l_Cell.Props.Border.Frames[bpBottom].Enable then
      if l_Cell <> nil then
      begin
       l_Cell.Props.VMergeFirst := True;
       if l_TokenStr.RTrimLen <> 0 then
        AddParagraph(l_TokenStr, l_Cell);
      end; // if l_Cell <> nil then
     except
      on E: Exception do
      begin
       l3System.Msg2Log('Ошибка разбора строки ' + f_Text.AsString);
       l3System.Exception2Log(E);
       {$IFDEF nsTest}
         raise E;
       {$ENDIF nsTest}
      end; // on E
     end // try..except
     else
      if (l3Len(l_PrevStr) > 0)
         and not l3CharSetPresent(l_PrevStr, cc_Frames) then
       try
        l_Cell := GetPrevVMergeCell(l_PrevFPos, False);
        if (l_Cell = nil) or l_Cell.Props.Border.Frames[bpBottom].Enable then
        begin
         l_OldCell := l_Cell;
         l_Cell := f_Row.CellByPos[l_PrevFPos];
         if (l_Cell = nil) or l_Cell.Props.VMerged then
          l_Cell := l_OldCell;
        end;//if l_Cell.Props.Border.Frames[bpBottom].Enable then
        if l_Cell <> nil then
         l_Cell.Props.VMergeFirst := True;
        if l3Len(l3Trim(l_PrevStr)) > 0 then
        begin
         l_TokenStr1 := Tl3String.Make(l_PrevStr.AsWStr);
         try
          AddParagraph(l_TokenStr1, l_Cell);
         finally
          l3Free(l_TokenStr1);
         end;
        end;//if l3Len(l3Trim(l_PrevStr)) > 0 then
       except
        on E: Exception do
        begin
         l3System.Msg2Log('Ошибка разбора строки ' + f_Text.AsString);
         l3System.Exception2Log(E);
       {$IFDEF nsTest}
         raise E;
       {$ENDIF nsTest}
        end; // on E
       end;//if l_NeedCheck then
    end; { while not EOF}
    WriteRow;
   finally
    f_LineParser.Filer.Stream := nil;
   end;{try..finally}
  end;{with l_LineParser}
 finally
  l3Free(l_LineStream);
 end;{try..finally}
 l_AddCell := False;
 for i := 1 to f_Text.Len - 1 do
 begin
  if f_Text.Ch[i] in (CellAdvStartChars + [cc_VLine]) then
  begin
   f_Row.AddCellAndPara;
   f_Row.LastCell.Props := f_Row.LastCell.Props;
   with f_Row.LastCell.Props do
   begin
    CellOffset := i;
    IsBorder := True;
   end; // f_Row.LastCell.Props
   if f_Text.Ch[i] in [cc_VLine, cc_LeftCross] then
    with f_Row.LastCell.Props do
    begin
     Border.Frames[bpTop].Enable := False;
     VMerged := True;
    end; // f_Text.Ch[i] in [cc_VLine, cc_LeftCross]
  end // f_Text.Ch[i] in (CellAdvStartChars + [cc_VLine])
 end; // for i
//#UC END# *4FACEBB6021F_4DCA38C7030D_impl*
end;//TddGraphicTable.CheckMixed

procedure TddGraphicTable.CheckOnlyGraphic;
//#UC START# *4FACEBD701C8_4DCA38C7030D_var*
var
 i, j   : Integer;
 l_Len  : Integer;
 l_Row  : TddTableRow;
 l_Text : Tl3String;
 l_CP   : TddCellProperty;
//#UC END# *4FACEBD701C8_4DCA38C7030D_var*
begin
//#UC START# *4FACEBD701C8_4DCA38C7030D_impl*
 if not f_LogicalTable then
 begin
  // Проверить предыдущую строку на количесто ячеек, если есть ячейки "сверху".
  if (f_RowList.Count > 0) then
  begin
   // Здесь ищем ячейки которые не были объедены по вертикали и устанавливаем им нижнюю границу
   l_Row := TddTableRow(f_RowList.Last);
   for i := 0 to l_Row.CellCount - 1 do
   begin
    if l_Row.Cells[i].Props.VMerged then
    begin
     //Если такущая ячейка относится к объединенной, то пытаемся найти ячейку до объединенной и выставить ей границу снизу
     j := f_RowList.Hi;
     while (j >= 0) and (i < TddTableRow(f_RowList.Items[j]).CellCount) do
     begin
      if TddTableRow(f_RowList.Items[j]).Cells[i].Props.VMergeFirst then
      begin
       TddTableRow(f_RowList.Items[j]).Cells[i].Props.Border.Frames[bpBottom].Enable := True;
       Break;
      end // TddTableRow(f_RowList.Items[j]).TAP.CellsProps[i].VMergeFirst
      else
       Dec(j);
     end; // while J >= 0
    end // l_Row.TAP.CellsProps[i].VMerged
    else
     l_Row.Cells[i].Props.Border.Frames[bpBottom].Enable := True;
   end; // for i
  end; // l_Row.CellCount = 1) and l3CharSetPresent(f_Text.St, f_Text.Len, CellOverChars)
 end;//if not f_LogicalTable then

 for i := 0 to f_Row.CellCount - 1 do
  f_Row.Cells[i].Props.Border.Frames[bpBottom].Enable := True;

 if (f_Row.CellCount > 0) then
  WriteRow;

  // Искать ли здесь колонки? Видимо, да.
 if l3CharSetPresent(f_Text.St, f_Text.Len, CellStartChars) then
 begin
  f_LogicalTable := False;
  l_Len := 1;
  for i := 1 to f_Text.Len - 1 do
  begin
   if f_Text.Ch[i] in CellStartChars then
   begin
    f_Row.AddCellAndPara;
    f_Row.LastCell.Props := f_Row.LastCell.Props;
    with f_Row.LastCell.Props do
     if f_Row.CellCount > 1 then
      CellOffset := f_Row.Cells[f_Row.CellCount - 2].Props.CellOffset + l_Len
     else
      CellOffset := l_Len;
    f_Row.LastCell.Props.IsBorder := f_Text.Ch[i] <> cc_RightCross;
    l_Len := 1;
   end // if f_Text.Ch[i] in CellStartChars then
   else
    Inc(l_Len);
  end; // i:= 1
 end // l3CharSetPresent(f_Text, f_Text.Len, CellStartChars)
 else
  if f_LogicalTable and ConvertCellToRow(True) then
   WriteRow;
//#UC END# *4FACEBD701C8_4DCA38C7030D_impl*
end;//TddGraphicTable.CheckOnlyGraphic

procedure TddGraphicTable.CheckGraphicAndSpace(const CloseTable: Boolean = False);
//#UC START# *4FACEC1B0129_4DCA38C7030D_var*
var
 i           : Integer;
 l_EtalonRow : TddTableRow;
//#UC END# *4FACEC1B0129_4DCA38C7030D_var*
begin
//#UC START# *4FACEC1B0129_4DCA38C7030D_impl*
 if ConvertCellToRow(CloseTable) then
 begin
  WriteRow;
  if f_Row.CellCount > 0 then
  begin
   // Синхронизируем количество ячеек
   l_EtalonRow := TddTableRow(f_RowList.Last);
   f_Row.TAP.AssignFrom(l_EtalonRow.TAP);
   for i := 0 to l_EtalonRow.CellCount - 1 do
   begin
    f_Row.AddCellAndPara(True);
    with f_Row.LastCell do
    begin
     Props := f_Row.Cells[i].Props;
     Props.IsBorder := False;
    end; // with f_Row.LastCell do
   end; // for i
  end; // if f_Row.CellCount > 0 then
 end;
//#UC END# *4FACEC1B0129_4DCA38C7030D_impl*
end;//TddGraphicTable.CheckGraphicAndSpace

procedure TddGraphicTable.WriteRow;
//#UC START# *4FACEC3C023E_4DCA38C7030D_var*
//#UC END# *4FACEC3C023E_4DCA38C7030D_var*
begin
//#UC START# *4FACEC3C023E_4DCA38C7030D_impl*
 if f_Row.CellCount > 0 then
 begin
  CorrectRow;
  f_RowList.Add(f_Row);
  l3Free(f_Row);
  f_Row := TddTableRow.Create(nil);
 end; // f_Row.CellCount > 0
//#UC END# *4FACEC3C023E_4DCA38C7030D_impl*
end;//TddGraphicTable.WriteRow

procedure TddGraphicTable.ScanForCols;
//#UC START# *4FACEC5A00BB_4DCA38C7030D_var*
var
 k, i         : Integer;
 l_LineStream : TStream;
 l_Cell       : TddTableCell;
 l_CellProp   : TddCellProperty;
 l_TextList   : TddDocumentAtomList;
 l_CellCount  : Integer;
//#UC END# *4FACEC5A00BB_4DCA38C7030D_var*
begin
//#UC START# *4FACEC5A00BB_4DCA38C7030D_impl*
 if f_Row.CellCount = 0 then
 begin
  f_Row.AddCellAndPara;
  f_Row.LastCell.Props.CellOffset := f_Text.Len - 1;
 end; // Row.CellCount = 0
 l_LineStream := Tl3StringStream.Create(f_Text);
 try
  with f_LineParser do
  begin
   CheckFiler.Stream := l_LineStream;
   try
    f_LineParser.WhiteSpace := [];
    f_LineParser.WordChars := [#0 .. #255] - cc_Frames;
    // - Концом ключевого слова является псевдографика
    // В следующем куске считаем число ячеек 
    f_LineParser.CheckInt := False;
    l_CellCount := 0;
    while not Filer.EOF do
    begin
     NextTokenSp;
     while (TokenType <> l3_ttSingleChar) and not Filer.EOF do
      NextTokenSp;
     if (TokenLongString.Len > 0) and not Filer.EOF then
      Inc(l_CellCount);
    end; // while not Filer.EOF
    if l_CellCount <> 0 then
    begin
     // Количество, насчитанных ячеек больше, чем в предыдущей строке...
     if l_CellCount > f_Row.CellCount then
     begin
      f_LogicalTable := True;
      l_TextList := TddDocumentAtomList.Make;
      try
       //Сохраняем текст ячеек
       for i := 0 to f_Row.Cells[0].Hi do
        l_TextList.Add(f_Row.Cells[0].Items[i]);

       // И начинаем анализировать поток заново 
       f_Row.Clear;
       Filer.Seek(0, soBeginning);
       while not Filer.EOF do
       begin
         NextTokenSp;
         if TokenType <> l3_ttSymbol then
          NextTokenSp;
         if TokenLongString.Len > 0 then
         begin
          f_Row.AddCellAndPara;
          if f_Row.CellCount > 1 then
           f_Row.LastCell.Props.CellOffset := TokenLongString.Len + 1 +
                                   f_Row.Cells[f_Row.CellCount - 2].Props.CellOffset
          else
          begin
           f_Row.LastCell.Props.CellOffset := TokenLongString.Len;
           if f_Text.First in cc_Frames then
            f_Row.LastCell.Props.CellOffset := f_Row.LastCell.Props.CellOffset + 1;

           for i := 0 to l_TextList.Hi do
           begin
            if f_Row.LastCell.LastTextPara.Empty then
             f_Row.LastCell.LastTextPara.Assign(l_TextList.Items[i])
            else
             f_Row.LastCell.Add(l_TextList.Items[i]);
           end; // for i
          end; //f_Row.CellCount > 1
          if f_Row.CellCount = 1 then
           f_Row.LastCell.Props.Border.Frames[bpLeft].Enable := f_Text.First in cc_Frames
          else
           f_Row.LastCell.Props.Border.Frames[bpLeft].Enable := True;
          f_Row.LastCell.Props.Border.Frames[bpRight].Enable := True;
         end; //TokenLongString.Len > 0
       end; // while not Filer.EOF
      finally
       l3Free(l_TextList);
      end;
     end; // if l_CellCount > f_Row.CellCount

     k := 0;
     Filer.Seek(0, soBeginning);
     // Проверяем еще раз поток...
     while not Filer.EOF do
     begin
       NextTokenSp;
       if TokenType <> l3_ttSymbol then
        NextTokenSp;
       if (TokenLongString.Len > 0) and not OnlyGraphic(TokenLongString) then { DONE -oДмитрий Дудко -cРазвитие : Добавить проверку на символ псевдографики }
       begin
        if (k = 0) and not (f_Text.First in cc_Frames) then
         Dec(k);
        Inc(k, Succ(TokenLongString.Len));
        l_Cell := f_Row.CellByPos[k];
        if l_Cell <> nil then
        begin
         l_CellProp := l_Cell.Props;
         if l_CellProp <> nil then
         begin
         // Здесь пытаемся рамку накалякать...
          if l_Cell.anIndex = 0 then
           l_CellProp.Border.Frames[bpLeft].Enable := f_Text.First in cc_Frames
          else
           l_CellProp.Border.Frames[bpLeft].Enable := True;
          if l_Cell.anIndex = Pred(f_Row.CellCount) then
           l_CellProp.Border.Frames[bpRight].Enable := f_Text.Last in cc_Frames
          else
           l_CellProp.Border.Frames[bpRight].Enable := True;
          // Здесь находим ячейку, объединенную по вертикали
          if l_CellProp.VMerged then
           l_Cell := GetPrevVMergeCell(k, False);
         end; //if l_CellProp <> nil then
        end; // l_Cell <> nil
        // Добавляем текст к ячейке (если нашли для объединения).
        if l_Cell <> nil then
        begin
         if not l_Cell.LastTextPara.Empty then //В каждой ячейке много абзацев
          AddParagraph(TokenLongString, l_Cell)
         else
          AddText(l_Cell, TokenLongString);
        end; // l_Cell <> nil
      end; // if (TokenLongString.Len > 0) and not OnlyGraphic(TokenLongString) then
     end; { while not}
    end; // l_CellCount <> 0
   finally
    Filer.Stream := nil;
   end;{try..finally}
  end;{with l_LineParser}
 finally
  l3Free(l_LineStream);
 end;{try..finally}
//#UC END# *4FACEC5A00BB_4DCA38C7030D_impl*
end;//TddGraphicTable.ScanForCols

procedure TddGraphicTable.CorrectRow;
//#UC START# *4FACEC7801A0_4DCA38C7030D_var*
var
 i, j     : Integer;
 l_Cell   : TddTableCell;
 l_UpCell : TddTableCell;
 l_Row    : TddTableRow;
//#UC END# *4FACEC7801A0_4DCA38C7030D_var*
begin
//#UC START# *4FACEC7801A0_4DCA38C7030D_impl*
 for i := 0 to Pred(f_Row.CellCount) do
 begin
  l_Cell := f_Row.Cells[i];
  j := l_Cell.Hi;
  while (j > 0) and GlueLines do
  begin
   if TddTextParagraph(l_Cell.Items[j]).Empty and TddTextParagraph(l_Cell.Items[j - 1]).Empty then
    l_Cell.Delete(j);
   Dec(j);
  end; // while J > 0
 end; //for i:= 0

 if f_Row.CellCount > 0 then
 begin
  i := 0;
  while (i <= Pred(f_Row.CellCount)) and (f_Row.CellCount > 1) do
  begin
   l_Cell := f_Row.Cells[i];
   if (l_Cell.Count = 1) and l_Cell.LastTextPara.Empty and f_LogicalTable and
      not (l_Cell.Props.VMerged or l_Cell.Props.VMergeFirst) then
    f_Row.DeleteCell(i)
   else
    Inc(i);
  end; // while i:= 0

  if f_RowList.Count > 0 then
  begin
   l_Row := TddTableRow(f_RowList.Last);
   for i := 0 to f_Row.CellCount - 1 do
   begin
    l_Cell := f_Row.Cells[i];
    if l_Row <> nil then
     for j := 0 to l_Row.CellCount - 1 do
     begin
      l_UpCell := l_Row.Cells[j];
      if (l_UpCell.Props.CellOffset = l_Cell.Props.CellOffset) then
      begin
       if l_UpCell.Props.VMerged and not l_Cell.Props.VMerged then
        l_Cell.Props.Border.Frames[bpTop].Enable := True;
       if not l_UpCell.Props.VMergeFirst and l_Cell.Props.VMerged then
       begin
        l_Cell.Props.Border.Frames[bpTop].Enable := False;
        l_UpCell.Props.Border.Frames[bpBottom].Enable := False;
       end;
      end; //if (l_UpCell..Width = l_Cell..Width) then
     end; //for j := 0 to l_Row.CellCount - 1 do
    l_Cell.Props.Border.Frames[bpBottom].Enable := True;
   end; //for i := 0 to f_Row.CellCount - 1 do
  end; //if f_RowList.Count > 0 then
 end; //if f_Row.CellCount > 0 then
//#UC END# *4FACEC7801A0_4DCA38C7030D_impl*
end;//TddGraphicTable.CorrectRow

function TddGraphicTable.ConvertCellToRow(aBottomBorder: Boolean): Boolean;
//#UC START# *4FACEC8D03A8_4DCA38C7030D_var*
var
 l_TextList  : Tl3StringList;
 l_EtalonRow : TddTableRow;
 l_Text      : Tl3String;
 l_CellText  : Tl3String;
 i, j        : Integer;
 l_Length    : Integer;
 l_Delta     : Integer;
 l_TextStr   : AnsiString;
//#UC END# *4FACEC8D03A8_4DCA38C7030D_var*
begin
//#UC START# *4FACEC8D03A8_4DCA38C7030D_impl*
 i := f_Text.FindChar(1, cc_VLine);
 if (i > 0) and (i <= (f_Text.Len - 1)) then
 begin
  // Проверить на совпадение cc_VLine на соответствие границам ячейки
  if f_RowList.Count > 0 then
  begin
   l_EtalonRow := TddTableRow(f_RowList.First);
   for j := 0 to l_EtalonRow.CellCount - 1 do
   begin
    Result := f_Text.Ch[l_EtalonRow.Cells[j].Props.CellOffset] = cc_VLine;
    if Result then
     Break;
   end; // for j := 0 to l_EtalonRow.CellCount - 1 do
   if Result then
    //Здесь сбрасываем рамку у объединенных ячеек и "синхронизируем" правые границы.
    for j := 0 to f_Row.CellCount - 1 do
    begin
     if not f_Row.Cells[j].Props.VMergeFirst then
      f_Row.Cells[j].Props.Border.Frames[bpBottom].Enable := False;
     if (j < l_EtalonRow.CellCount) and (f_Row.Cells[j].Props.CellOffset = l_EtalonRow.Cells[j].Props.CellOffset) then
      f_Row.Cells[j].Props.Border.Frames[bpRight].Enable := l_EtalonRow.Cells[j].Props.Border.Frames[bpRight].Enable;
    end; // for j := 0 to f_Row.CellCount - 1 do
    if (f_Row.CellCount > l_EtalonRow.CellCount) and (l_EtalonRow.LastCellProperty.CellOffset = f_Row.LastCellProperty.CellOffset) then
     f_Row.LastCellProperty.Border.Frames[bpRight].Enable := l_EtalonRow.LastCellProperty.Border.Frames[bpRight].Enable;
   Result := False or f_LogicalTable;
  end  // if f_RowList.Count > 0 then
  else
   Result := False or f_LogicalTable;
  Exit;
 end;

 if (f_Row.CellCount > 0) and (f_RowList.Count > 0) then
 begin
  if aBottomBorder and (f_Row.CellCount > 1) then
   for i := 0 to f_Row.CellCount - 1 do
   begin
    f_Row.Cells[i].Props.Border.Frames[bpBottom].Enable := True;
   end // for i := 0 to f_Row.CellCount - 1 do
  else
  begin
   f_LogicalTable := True;
   l_TextList := Tl3StringList.Make;
   try
    // Cохраняем текст по строкам первой ячейки
    { TODO -oNarry -cРазвитие : Нужно сохранять не только текст, но и его оформление }
    for i := 0 to f_Row.Cells[0].Hi do
    begin
     l_Text := Tl3String.Create;
     try
      l_Text.Assign(TddTextParagraph(f_Row.Cells[0].Items[i]).Text);
      l_TextList.Add(l_Text);
     finally
      l3Free(l_Text);
     end; // l_Text
    end; // for i
    f_Row.Clear;
    // Cинхронизируем количество ячеек
    l_EtalonRow := TddTableRow(f_RowList.Items[0]);
    f_Row.TAP.AssignFrom(l_EtalonRow.TAP);
    for i := 0 to l_EtalonRow.CellCount - 1 do
    begin
     f_Row.AddCellAndPara(True);
     f_Row.LastCell.Props := f_Row.Cells[i].Props;
     with f_Row.LastCell.Props do
     begin
      IsBorder := False;
      if (i = 0) then
       Border.Frames[bpLeft].Enable := True
      else
      if (i = l_EtalonRow.CellCount - 1) then
       Border.Frames[bpRight].Enable := True;
      if aBottomBorder then
       Border.Frames[bpBottom].Enable := True;
     end; // with f_Row.LastCell.Props do
    end; // for i

    // распихиваем сохраненный текст
    { TODO -oNarry -cРазвитие : Нужно распихивать не только текст, но и его оформление }
    for j := 0 to l_TextList.Hi do
    begin
     l_Length := 1;
     l_Text := Tl3String(l_TextList.Items[j]);
     for i := 0 to f_Row.CellCount-1 do
     begin 
      if i > 0 then
       l_Delta := f_Row.Cells[i].Props.CellOffset - f_Row.Cells[i - 1].Props.CellOffset
      else
       l_Delta := f_Row.Cells[i].Props.CellOffset;
      l_TextStr := Copy(l_Text.AsString, l_Length, l_Delta);
      if (l_Text.Ch[l_Length + l_Delta - 2] <> ' ') and (i <> f_Row.CellCount - 1) then
       AddText(f_Row.Cells[i + 1], l_Text, l_Length, l_Delta)
      else
       AddText(f_Row.Cells[i], l_Text, l_Length, l_Delta);
      Inc(l_Length, l_Delta);
     end; // for i
    end; // for j                              
   finally
    l3Free(l_TextList);
   end; // l_TextList
  end;
 end; // f_Row.CellCount > 0
 Result := True;
//#UC END# *4FACEC8D03A8_4DCA38C7030D_impl*
end;//TddGraphicTable.ConvertCellToRow

function TddGraphicTable.GetPrevVMergeCell(aPos: Integer;
 aNeedCheckVMerge: Boolean): TddTableCell;
//#UC START# *4FACECAA0043_4DCA38C7030D_var*
var
 i : Integer;
//#UC END# *4FACECAA0043_4DCA38C7030D_var*
begin
//#UC START# *4FACECAA0043_4DCA38C7030D_impl*
 Result := nil;
 for i := f_RowList.Hi downto 0 do
 begin
  Result := TddTableRow(f_RowList.Items[i]).CellByPos[aPos];
  if (Result <> nil) then
  begin
   if not Result.Props.VMerged then
   begin
    if aNeedCheckVMerge and not Result.Props.VMergeFirst then
     Result.Props.VMergeFirst := True;
    Break;
   end; // if not Result.Props.VMerged then
  end // if (Result <> nil) then
  else
   Break;
 end; // while i >= 0
//#UC END# *4FACECAA0043_4DCA38C7030D_impl*
end;//TddGraphicTable.GetPrevVMergeCell

procedure TddGraphicTable.Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent);
//#UC START# *4FACDFA2002E_4DCA38C7030D_var*
var
 i              : Integer;
 l_Line         : Integer;
 l_MaxCellCount : Integer;
//#UC END# *4FACDFA2002E_4DCA38C7030D_var*
begin
//#UC START# *4FACDFA2002E_4DCA38C7030D_impl*
 // - Вначале заводим табличку 
 f_Row := TddTableRow.Create(nil);
 try
  f_LineParser := Tl3CustomParser.Create{(nil)};
  try
   f_Text := Tl3String.Create;
   try
    f_Text.CodePage := cp_OEM;
    f_LogicalTable := False;
    for l_Line := 0 to f_Lines.Hi do
    begin
     f_CurLine := l_Line;
     f_Text.Assign(Tl3String(f_Lines.Items[l_Line]));
     if not f_Text.Empty then
      if not CheckRowEnd then
       ScanForCols;
     f_Text.Clear;
    end; { for l_Line}
   finally
    l3Free(f_Text);
   end;
  finally
   l3Free(f_LineParser);
  end;
 finally
  if f_Row.CellCount > 0 then
   f_RowList.Add(f_Row);
  l3Free(f_Row);
 end;
 l_MaxCellCount := 0;
 for i := 0 to f_RowList.Count - 1 do
  l_MaxCellCount := Max(l_MaxCellCount, TddTableRow(f_RowList.Items[i]).CellCount);
 f_CellCount := l_MaxCellCount;
 f_RowCount := f_RowList.Count;
//#UC END# *4FACDFA2002E_4DCA38C7030D_impl*
end;//TddGraphicTable.Analyze

procedure TddGraphicTable.RecalcRows;
//#UC START# *4FACDFDE03BB_4DCA38C7030D_var*
//#UC END# *4FACDFDE03BB_4DCA38C7030D_var*
begin
//#UC START# *4FACDFDE03BB_4DCA38C7030D_impl*
 f_CellCount:= 0;
 f_RowCount:= 0;
//#UC END# *4FACDFDE03BB_4DCA38C7030D_impl*
end;//TddGraphicTable.RecalcRows

procedure TddSpaceTable.Map2Row(aMap: Tl3String);
//#UC START# *4FACED7B0253_4DCA38EB0022_var*
var
 l_Pos: Integer;
//#UC END# *4FACED7B0253_4DCA38EB0022_var*
begin
//#UC START# *4FACED7B0253_4DCA38EB0022_impl*
 f_Row := TddTableRow.Create(nil);
 l_Pos := aMap.FindChar(1, cc_BreakChar);
 while l_Pos <> -1 do
 begin
  f_Row.AddCellAndPara;
  with f_Row.LastCell do
   Props.CellOffset := l_Pos + 1;
  l_Pos := aMap.FindChar(l_Pos + 1, cc_BreakChar);
 end; // while l_Pos <> -1 do
 f_Row.AddCellAndPara;
 with f_Row.LastCell do
  Props.CellOffset := aMap.Len;
//#UC END# *4FACED7B0253_4DCA38EB0022_impl*
end;//TddSpaceTable.Map2Row

procedure TddSpaceTable.Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent);
//#UC START# *4FACDFA2002E_4DCA38EB0022_var*
var
 i, j      : Integer;
 l_Line    : Integer;
 l_Found   : Boolean;
 l_Map     : Tl3String;
 l_SepS    : Tl3String;
 l_Text    : Tl3String;
 l_Pos     : Integer;
 l_PrevPos : Integer;
 l_Pos2    : Cardinal;
 l_BT      : Tl3BMTable;
 l_Cell    : TddTableCell;
 l_WasEmpty: Boolean;

 procedure _StartNewRow;
 begin
  f_RowList.Add(f_Row);
  l3Free(f_Row);                             
  Map2Row(l_Map);
 end;

var
 l_SpaceAbsent: Boolean;
//#UC END# *4FACDFA2002E_4DCA38EB0022_var*
begin
//#UC START# *4FACDFA2002E_4DCA38EB0022_impl*
 l_Map := Tl3String.Create;
 try
  // 1. Построение карты столбцов
  l_SepS := TL3String.Create;
  try
   l_Seps.AsString := cc_HardSpace;
   l_Seps.MakeBMTable(l_BT);
   l_Found := False;
   l_Text := nil;
   for l_Line := 0 to f_Lines.Count - 1 do
   begin
    l_Text := Tl3String(f_Lines.Items[l_Line]);
    if OnlyGraphicAndSpace(l_Text) then Continue;
    l_SpaceAbsent := False;
    l_Found := l_SepS.BMSearchUC(l_Text, l_BT, l_Pos2);
    if not l_Found then // Если есть текст, но без пробела, то это одна ячейка. // http://mdp.garant.ru/pages/viewpage.action?pageId=585429117
     if l_Text.Empty then
      Exit
     else
     begin
      l_Found := True;
      l_SpaceAbsent := True;
     end;
    if l_Found then
    begin
     if l_Map.Len < l_Text.Len then
      l_Map.Append(cc_HardSpace, l_Text.Len - l_Map.Len);
      for i := 0 to l_Text.Len - 1 do
       if l_Text.Ch[i] <> cc_HardSpace then
        l_Map.Ch[i] := cc_CellChar;
      if l_SpaceAbsent then
       l_Map.Ch[l_Text.Len] := cc_BreakChar;
    end; // l_Found
   end; // for l_Line
   (* Нужно преобразовать последовательности Х_____ХХХ
                                          в Х_ХХХХХХХ   *)
   l_Seps.AsString:= cc_HardSpace + cc_CellChar;
   l_Seps.MakeBMTable(l_BT);
   l_Pos2 := 0;
   repeat
    l_Found := l_SepS.BMSearchUC(l_Map, l_BT, l_Pos2);
    if l_Found then
    begin
     if (l_Pos2 = 0) or (l_Map.Ch[l_Pos2 - 1] = cc_HardSpace) then
      l_Map.Ch[l_Pos2] := cc_CellChar
     else
      l_Map.Ch[l_Pos2] := cc_BreakChar;
    end; // l_Found
   until not l_Found;
  finally
   l3Free(l_Seps);
  end; // l_Seps
  // 2. Создание таблицы
  Map2Row(l_Map);
  f_CellCount := f_Row.CellCount;
  l_WasEmpty := True;
  for l_Line := 0 to f_Lines.Count - 1 do
  begin
   f_CurLine := l_Line;
   l_Text := Tl3String(f_Lines.Items[l_Line]);
   if OnlyGraphicAndSpace(l_Text) and (l_Line < Pred(f_Lines.Count)) then
   begin
    if not l_WasEmpty then _StartNewRow;
    l_WasEmpty := True;
   end
   else
   begin
    l_WasEmpty := False;
    if l_Map[1] = cc_BreakChar then
     l_PrevPos := 1
    else
     l_PrevPos := 0;
    repeat
     l_Pos := l_Map.FindChar(l_PrevPos, cc_BreakChar);
     if l_Pos = -1 then
     begin
      l_Cell := f_Row.LastCell;
      AddText(l_Cell, l_Text, l_PrevPos, l_Text.Len - l_PrevPos + 1);
     end // if l_Pos = -1 then
     else
     begin
      l_Cell := f_Row.CellByPos[l_Pos];
      if l_Cell <> nil then
       AddText(l_Cell, l_Text, l_PrevPos, l_Pos - l_PrevPos + 1);
     end;
     if (l_Cell <> nil) and l_Cell.LastTextPara.Empty then
      l_Cell.LastTextPara.AddText(cc_SoftSpace, CP_ANSI);

     l_PrevPos := l_Pos + 1;
    until (l_Pos = -1) or (l_Pos > l_Text.Len); // repeat..until
    if l_Pos <> -1 then
     for i := f_Row.CellByPos[l_Pos].anIndex + 1 to f_Row.CellCount - 1 do
     begin
      with f_Row.Cells[i] do
      begin
       AddParagraph;
       LastTextPara.AddText(cc_SoftSpace, CP_ANSI);
      end; // with f_Row.Cells[i] do
     end; // for i := f_Row.CellByPos[l_Pos].anIndex + 1 to f_Row.CellCount - 1 do
   end; // l_Text.Empty
  end; // for l_Line
  f_RowList.Add(f_Row);
  l3Free(f_Row);
 finally
  l3Free(l_Map);
 end; // l_Map
//#UC END# *4FACDFA2002E_4DCA38EB0022_impl*
end;//TddSpaceTable.Analyze

procedure TddSeparatorTable.pm_SetSeparator(aValue: AnsiChar);
//#UC START# *4FACEE7E0008_4DCA38F901D7set_var*
//#UC END# *4FACEE7E0008_4DCA38F901D7set_var*
begin
//#UC START# *4FACEE7E0008_4DCA38F901D7set_impl*
 if f_Separator <> aValue then
 begin
  f_Separator:= aValue;
  Analyze;
 end;
//#UC END# *4FACEE7E0008_4DCA38F901D7set_impl*
end;//TddSeparatorTable.pm_SetSeparator

constructor TddSeparatorTable.Create(aSeparator: AnsiChar);
//#UC START# *4FACEE4703D3_4DCA38F901D7_var*
//#UC END# *4FACEE4703D3_4DCA38F901D7_var*
begin
//#UC START# *4FACEE4703D3_4DCA38F901D7_impl*
 inherited Create;
 f_Separator := aSeparator;
//#UC END# *4FACEE4703D3_4DCA38F901D7_impl*
end;//TddSeparatorTable.Create

procedure TddSeparatorTable.Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent);
//#UC START# *4FACDFA2002E_4DCA38F901D7_var*
var
 i, j, C: Integer;
 B: Boolean;
 l_Map, SepS, Text, l_Txt: Tl3String;
 l_Pos: Cardinal;
 l_BT: Tl3BMTable;
 l_HasText, l_First: Boolean;
 l_Line, l_RowLen,
 l_DefWidth: Integer;
 l_Row: TddTableRow;
//#UC END# *4FACDFA2002E_4DCA38F901D7_var*
begin
//#UC START# *4FACDFA2002E_4DCA38F901D7_impl*
  C := 0;
  SepS := TL3String.Create;
  try
   SepS.AsString := Separator;  
   f_RowList.Clear;
   Seps.MakeBMTable(l_BT);
   for l_Line:= 0 to f_Lines.Count - 1 do
   begin
    f_CurLine := l_Line;
    Text := Tl3String.Make(Tl3String(f_Lines.Items[l_Line]));
    try
     if not Text.Empty then
     begin
      f_Row := TddTableRow.Create(nil);
      l_RowLen := 0;
      try
       l_Txt := Tl3String.Make(Text);
       try
        while SepS.BMSearchUC(l_Txt, l_BT, l_Pos) do
        begin
         f_Row.AddCellAndPara;
         f_Row.LastCell.Props.CellOffset:= l_Pos;
         Inc(l_RowLen, f_Row.LastCell.Props.CellOffset);
         f_Row.LastCell.LastTextPara.AddText(Copy(l_Txt.AsString, 0, l_Pos), l_Txt.CodePage);
         l_Txt.Delete(0, l_Pos+1);
        end; // while SepS.BMSearchUC(l_Txt, l_BT, l_Pos) do
        f_Row.AddCellAndPara;
        f_Row.LastCell.Props.CellOffset := l_Txt.Len;
        Inc(l_RowLen, f_Row.LastCell.Props.CellOffset);
        f_Row.LastCell.LastTextPara.AddText(l_Txt);
       finally
        l3Free(l_Txt);
       end; // l_Txt
       f_RowList.Add(f_Row);
      finally
       l3Free(f_Row);
      end; // f_Row
     end; // if not Text.Empty
    finally
     l3Free(Text);
    end; // Text
   end; // for l_Line:= 0 to f_Lines.Count - 1 do
  finally
   l3Free(SepS);
  end;
  C := 0;
  for i := 0 to f_RowList.Count - 1 do
   C := Max(C, TddTableRow(f_RowList.Items[i]).CellCount);
  f_CellCount := C;
  if AutoFit = afEqual then
  begin
   l_DefWidth := TableWidth div C;
   for i := 0 to f_RowList.Count - 1 do
   begin
    l_Row := TddTableRow(f_RowList.Items[i]);
    for j := 0 to l_Row.CellCount - 1 do
     if l_Row.CellCount = C then
      l_Row.Cells[j].Props.CellOffset := l_DefWidth
     else
      l_Row.Cells[j].Props.CellOffset := TableWidth div l_Row.CellCount;
   end; //for i:= 0
  end; //if AutoFit = afEqual
//#UC END# *4FACDFA2002E_4DCA38F901D7_impl*
end;//TddSeparatorTable.Analyze

procedure TddSeparatorTable.RecalcRows;
//#UC START# *4FACDFDE03BB_4DCA38F901D7_var*
//#UC END# *4FACDFDE03BB_4DCA38F901D7_var*
begin
//#UC START# *4FACDFDE03BB_4DCA38F901D7_impl*
//#UC END# *4FACDFDE03BB_4DCA38F901D7_impl*
end;//TddSeparatorTable.RecalcRows

function TddParagraphTable.CalcTextLen(aText: Tl3String): Integer;
//#UC START# *4FACEEC102E8_4DCA391B015A_var*
var
 l_Pos, l_OldPos: Integer;
//#UC END# *4FACEEC102E8_4DCA391B015A_var*
begin
//#UC START# *4FACEEC102E8_4DCA391B015A_impl*
 Result := 0;
 l_Pos := 0;
 l_OldPos := 0;
 while l_Pos <> -1 do
 begin
  l_Pos := aText.FindChar(l_OldPos, cc_SoftEnter);
  if l_Pos <> -1 then
  begin
   Result := Max(Result, l_Pos - l_OldPos);
   l_OldPos := l_Pos+1;
  end // if l_Pos <> -1 then
  else
   Result := Max(Result, aText.Len-l_OldPos);
 end; // while l_Pos <> -1 do
//#UC END# *4FACEEC102E8_4DCA391B015A_impl*
end;//TddParagraphTable.CalcTextLen

procedure TddParagraphTable.Analyze(const aAutoFit: TddAutoFitBehavior = ddTableConvTypes.afContent);
//#UC START# *4FACDFA2002E_4DCA391B015A_var*
var
 i           : Integer;
 l_Text      : Tl3String;
 l_Line      : Integer;
 l_CellCount : Integer;
//#UC END# *4FACDFA2002E_4DCA391B015A_var*
begin
//#UC START# *4FACDFA2002E_4DCA391B015A_impl*
 f_RowList.Clear;
 f_Row := TddTableRow.Create(nil);
 try
  for l_Line := 0 to Pred(f_Lines.Count) do
  begin
   f_CurLine := l_Line;
   l_Text := Tl3String(f_Lines.Items[l_Line]);
   if l_Text.Empty then
   begin
    { может быть по пустой строке добавлять новую строку в таблицу? }
   end
   else
   begin
    f_Row.AddCellAndPara;
    with f_Row.LastCell do
    begin
     Props.CellOffset := CalcTextLen(l_Text);
     LastTextPara.AddText(l_Text);
    end; // with f_Row.LastCell do
   end;
  end; // for l_Line
  f_RowList.Add(f_Row);
 finally
  l3Free(f_Row);
 end; // try..finally
 l_CellCount := 0;
 for i := 0 to Pred(f_RowList.Count) do
  l_CellCount := Max(l_CellCount, TddTableRow(f_RowList.Items[i]).CellCount);
 f_CellCount := l_CellCount;
//#UC END# *4FACDFA2002E_4DCA391B015A_impl*
end;//TddParagraphTable.Analyze

end.
