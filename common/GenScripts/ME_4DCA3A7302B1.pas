unit evTableConverter;

// Модуль: "w:\archi\source\projects\Common\Utils\evTableConverter.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , evCustomEditor
 , k2CustomFileParser
 , ddTableConvTypes
 , l3Memory
 , l3StringList
 , ddTableConvParamDlg
 , ddVirtualTable
 , ddDocument
 , l3Base
 , ddBorder
 , Classes
 , ddTextToTableConverters
;

type
 TddTextAndTableConverterRow = array [TddCellSeparator] of TddAbstractTable;

 TddTextAndTableConverter = class(Tk2CustomFileParser)
  private
   f_CellCount: LongInt;
   f_MyStream: Tl3MemoryStream;
   f_Lines: Tl3StringList;
   f_GlueLines: Boolean;
   f_AbortConversion: Boolean;
   f_ColumnSeparator: AnsiString;
   f_Dialog: TTableConvParamDialog;
   f_Rows: TddTextAndTableConverterRow;
    {* "Эталонные" ячейки }
   f_Table: TddVirtualTable;
    {* Ячейки с текстом }
   f_DocGen: TddDocumentGenerator;
   f_PreviewEnabled: Boolean;
   f_Editor: TevCustomEditor;
    {* Поле для свойства Editor }
   f_CellSeparator: TddCellSeparator;
    {* Поле для свойства CellSeparator }
   f_TableWidth: LongInt;
    {* Поле для свойства TableWidth }
   f_CodePageIn: LongInt;
    {* Поле для свойства CodePageIn }
   f_CodePageOut: LongInt;
    {* Поле для свойства CodePageOut }
  protected
   procedure pm_SetEditor(aValue: TevCustomEditor); virtual;
   procedure pm_SetTableWidth(aValue: LongInt); virtual;
   procedure DialogShowPreview(Enable: Boolean);
    {* Начальное определение количества ячеек и строк для каждого типа разделителя }
   procedure AnalyzeStream;
    {* перерасчет количества СТРОК в зависимости от количества ячеек для каждого типа разделителя }
   procedure CorrectCellLen(aText: Tl3String;
    var CellLen: LongInt);
   procedure WriteBorders(aBorder: TddBorder);
   procedure WriteToPreview;
   procedure DialogCellCount(aCellCount: LongInt);
   procedure DialogCellSeparator(aCellSeparator: TddCellSeparator);
   procedure DialogAutoFit(aAutoFit: TddAutoFitBehavior);
   procedure DialogGlueLines(Enable: Boolean);
   procedure RecalcRows;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Read; override;
  public
   function GetTable: TddVirtualTable;
   procedure Tune;
   procedure Text2Table;
   constructor Create(anOwner: TComponent = nil); reintroduce;
  public
   property Editor: TevCustomEditor
    read f_Editor
    write pm_SetEditor;
   property CellSeparator: TddCellSeparator
    read f_CellSeparator
    write f_CellSeparator;
   property TableWidth: LongInt
    read f_TableWidth
    write pm_SetTableWidth;
   property CodePageIn: LongInt
    read f_CodePageIn
    write f_CodePageIn;
   property CodePageOut: LongInt
    read f_CodePageOut
    write f_CodePageOut;
 end;//TddTextAndTableConverter

procedure ConvertText2Table(anEditor: TevCustomEditor);

implementation

uses
 l3ImplUses
 , l3Chars
 , ddTableCell
 , ddTableRow
 , ddTextParagraph
 , ddTextSegment
 , RTFtypes
 , ddCellProperty
 , k2Tags
 , ddTypes
 , nevTools
 , l3Filer
 , l3Stream
 , l3Interfaces
 , evdInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nevInternalInterfaces
 , nevBase
 , evOp
 , evdEmptyRowFilter
 , evTableFilter
 , k2TagGen
 , Document_Const
 , Table_Const
 , TableRow_Const
 , TableCell_Const
 , evdTypes
 , l3UnitsTools
 , evdStyles
;

procedure ConvertText2Table(anEditor: TevCustomEditor);
//#UC START# *4DCA3AE202DB_4DCA3A7302B1_var*
var
 l_TableConv: TddTextAndTableConverter;
//#UC END# *4DCA3AE202DB_4DCA3A7302B1_var*
begin
//#UC START# *4DCA3AE202DB_4DCA3A7302B1_impl*
 if not anEditor.InSBS and not anEditor.InTable then
 begin
  l_TableConv := TddTextAndTableConverter.Create(nil);
  try
   l_TableConv.CodePageIn := cp_OEM;
   l_TableConv.CodePageOut := cp_ANSI;
   l_TableConv.Editor := anEditor;
   l_TableConv.Tune;
   l_TableConv.Text2Table;
  finally
   l3Free(l_TableConv);
  end;
 end; // if not anEditor.InSBS and not anEditor.InTable then
//#UC END# *4DCA3AE202DB_4DCA3A7302B1_impl*
end;//ConvertText2Table

procedure TddTextAndTableConverter.pm_SetEditor(aValue: TevCustomEditor);
//#UC START# *4F6834C40073_4DCA3AB8028Eset_var*
var
 l_Block     : InevDataObjectPrim2;
 l_Pack      : InevOp;
 i           : TddCellSeparator;
 l_Filer     : Tl3CustomFiler;
 l_MemStream : Tl3MemoryStream;
 l_SubStream : TStream;
 l_Size      : LongInt;
 l_S         : Tl3String;
//#UC END# *4F6834C40073_4DCA3AB8028Eset_var*
begin
//#UC START# *4F6834C40073_4DCA3AB8028Eset_impl*
 if Editor <> aValue then
 begin  
  f_Editor:= aValue;
  if not Editor.Selection.Collapsed then
  begin
   l_MemStream:= Tl3MemoryStream.Create;
   try                                                                  
    l_Pack := Editor.StartOp(0);
    try
     l_Block := InevSelection(Editor.Selection).GetBlock.AsStorable;
     try                                                                                         
      Editor.TextSource.DocumentContainer.TagReader.ReadTagEx(f_DocGen, nil, l_Block);       
      l_Size := Editor.TextSource.DocumentContainer.TagReader.ReadTag(cf_OEMText, l_MemStream, nil, l_Block, [evd_sfInternal]);
      l_MemStream.Seek(0, soBeginning);
      l_SubStream := Tl3SubStream.Create(l_MemStream, 0, l_Size);
      try
       l3Set(f_MyStream, l_SubStream);
       l_Filer:= Tl3CustomFiler.Create(nil);
       try
        l_Filer.Stream:= l_SubStream;
        l_Filer.CodePage:= f_CodePageIn;
        while not l_Filer.EOF do
        begin
         l_S:= Tl3String.Make(l_Filer.Readln);
         try
          f_Lines.Add(l_S);
         finally
          l3Free(l_S);
         end;//try..finally
        end;
       finally
        l3Free(l_Filer);
       end;
      finally
       l3Free(l_SubStream);
      end;{try..finally}
     finally
      l_Block := nil;
     end;//try..finally
    finally
     l_Pack:= nil;
    end;//try..finally
   finally
    l3Free(l_MemStream);
   end;{try..finally}

   with Editor.Document do
    f_Table.MaxWidth := IntA[k2_tiWidth]
                       - IntA[k2_tiLeftIndent]
                       - IntA[k2_tiRightIndent];
   TableWidth:= Pixel2Char(f_Table.MaxWidth);
   for i:= Low(TddCellSeparator) to High(TddCellSeparator) do
   begin
    f_Rows[i].Lines:= f_Lines;
    f_Rows[i].FormatBuffer:= f_DocGen.Document;
   end;

   AnalyzeStream;
   RecalcRows;
   f_GlueLines := not ((CellSeparator = csSpace) and (f_Table.RowCount = 1));
  end
  else
   l3Free(f_MyStream);
 end;
//#UC END# *4F6834C40073_4DCA3AB8028Eset_impl*
end;//TddTextAndTableConverter.pm_SetEditor

procedure TddTextAndTableConverter.pm_SetTableWidth(aValue: LongInt);
//#UC START# *4F6838BF03B2_4DCA3AB8028Eset_var*
var
 i: TddCellSeparator;
//#UC END# *4F6838BF03B2_4DCA3AB8028Eset_var*
begin
//#UC START# *4F6838BF03B2_4DCA3AB8028Eset_impl*
 if aValue <> f_TableWidth then
 begin
  f_TableWidth := aValue;
  for i := Low(TddCellSeparator) to High(TddCellSeparator) do
   f_Rows[i].TableWidth:= f_TableWidth;
 end; // if Value <> f_TableWidth
//#UC END# *4F6838BF03B2_4DCA3AB8028Eset_impl*
end;//TddTextAndTableConverter.pm_SetTableWidth

procedure TddTextAndTableConverter.DialogShowPreview(Enable: Boolean);
 {* Начальное определение количества ячеек и строк для каждого типа разделителя }
//#UC START# *4F683E3D003E_4DCA3AB8028E_var*
//#UC END# *4F683E3D003E_4DCA3AB8028E_var*
begin
//#UC START# *4F683E3D003E_4DCA3AB8028E_impl*
 f_PreviewEnabled := Enable;
 if f_PreviewEnabled then
  WriteToPreview;
//#UC END# *4F683E3D003E_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.DialogShowPreview

procedure TddTextAndTableConverter.AnalyzeStream;
 {* перерасчет количества СТРОК в зависимости от количества ячеек для каждого типа разделителя }
//#UC START# *4F683E6502E7_4DCA3AB8028E_var*
var
 l_ParaCount    : Integer;
 l_TabCount     : Integer;
 l_SemicolCount : Integer;
 l_SpaceCount   : Integer;
 l_GraphCount   : Integer;
 l_Index        : TddCellSeparator;
//#UC END# *4F683E6502E7_4DCA3AB8028E_var*
begin
//#UC START# *4F683E6502E7_4DCA3AB8028E_impl*
 CellSeparator := csOther;
 if f_Lines.Count > 0 then
 begin
  for l_Index := Low(TddCellSeparator) to High(TddCellSeparator) do
    f_Rows[l_Index].Analyze;
  l_GraphCount  := f_Rows[csGraphic].CellCount;
  l_SpaceCount  := f_Rows[csSpace].CellCount;
  l_TabCount    := f_Rows[csTab].CellCount;
  l_SemiColCount:= f_Rows[csSemicolon].CellCount;
  if (l_GraphCount > 1) and (f_Rows[csGraphic].RowCount > 0)then
  begin
   CellSeparator:= csGraphic;
   f_CellCount:= l_GraphCount;
  end
  else
  if (l_SpaceCount >= l_TabCount) and {(l_SpaceCount > l_ParaCount) and}
     (l_SpaceCount >= l_SemiColCount) and (l_SpaceCount >= l_GraphCount) then
  begin
   CellSeparator := csSpace;
   f_CellCount := l_SpaceCount;//TddTableRowEx(f_Rows[csSpace].Items[0]).CellCount;
  end
  else
  if (l_TabCount >= l_SpaceCount) and
     (l_TabCount >= l_SemiColCount) and (l_TabCount >= l_GraphCount) then
  begin
   CellSeparator := csTab;
   f_CellCount := l_TabCount;
  end
  else
  if {(l_SemiColCount > l_ParaCount) and} (l_SemiColCount >= l_SpaceCount) and
     (l_SemiColCount >= l_TabCount) and (l_SemiColCount >= l_GraphCount) then
  begin
   CellSeparator := csSemicolon;
   f_CellCount := l_SemiColCount;
  end
  else
  begin
   CellSeparator := csParagraph;
   f_CellCount := l_ParaCount
  end;
 end;
//#UC END# *4F683E6502E7_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.AnalyzeStream

procedure TddTextAndTableConverter.CorrectCellLen(aText: Tl3String;
 var CellLen: LongInt);
//#UC START# *4F683E990117_4DCA3AB8028E_var*
var
 i, k: Integer;
//#UC END# *4F683E990117_4DCA3AB8028E_var*
begin
//#UC START# *4F683E990117_4DCA3AB8028E_impl*
 i := CellLen;
 k := CellLen;
 while ((aText.Ch[i] <> ' ') or (aText.Ch[k] <> ' ')) and (i <> 0) and (k < aText.Len) do
 begin
  if i <> 0 then
   Dec(i);
  if k < aText.Len then
   Inc(k)
 end;                                                            
 if (i > 0) and (aText.Ch[i] = ' ') then
  CellLen := i
 else
  if (k < aText.Len) and (aText.Ch[k] = ' ') then
   CellLen := k;
//#UC END# *4F683E990117_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.CorrectCellLen

procedure TddTextAndTableConverter.WriteBorders(aBorder: TddBorder);
//#UC START# *4F683EC70009_4DCA3AB8028E_var*
//#UC END# *4F683EC70009_4DCA3AB8028E_var*
begin
//#UC START# *4F683EC70009_4DCA3AB8028E_impl*
 if aBorder.IsFramed then
 begin
  Generator.StartTag(k2_tiFrame);  { рамка }
  try
   if aBorder.Frames[bpLeft].Enable then
   begin
    Generator.StartTag(k2_tiFrameLeft);
    try
     Generator.AddIntegerAtom(k2_tiLineType, 0);
     Generator.AddIntegerAtom(k2_tiWidth, 10);
     Generator.AddIntegerAtom(k2_tiForeColor, 0);
    finally
     Generator.Finish;
    end;
   end; // aBorder.FrameType[bpLeft] <> btNone
   if aBorder.Frames[bpRight].Enable then
   begin
    Generator.StartTag(k2_tiFrameRight);
    try
     Generator.AddIntegerAtom(k2_tiLineType, 0);
     Generator.AddIntegerAtom(k2_tiWidth, 10);
     Generator.AddIntegerAtom(k2_tiForeColor, 0);
    finally
     Generator.Finish;
    end;
   end; // aBorder.FrameType[bpRight] <> btNone
   if aBorder.Frames[bpTop].Enable then
   begin
    Generator.StartTag(k2_tiFrameUp);
    try
     Generator.AddIntegerAtom(k2_tiLineType, 0);
     Generator.AddIntegerAtom(k2_tiWidth, 10);
     Generator.AddIntegerAtom(k2_tiForeColor, 0);
    finally
     Generator.Finish;
    end;
   end; // aBorder.FrameType[bpTop] <> btNone
   if aBorder.Frames[bpBottom].Enable then
   begin
    Generator.StartTag(k2_tiFrameDown);
    try
     Generator.AddIntegerAtom(k2_tiLineType, 0);
     Generator.AddIntegerAtom(k2_tiWidth, 10);
     Generator.AddIntegerAtom(k2_tiForeColor, 0);
    finally
     Generator.Finish;
    end;{try..finally}
   end; // aBorder.FrameType[bpBottom] <> btNone
  finally
   Generator.Finish;
  end;{try..finally}
 end; // IsFramed
//#UC END# *4F683EC70009_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.WriteBorders

procedure TddTextAndTableConverter.WriteToPreview;
//#UC START# *4F683EE00365_4DCA3AB8028E_var*
//#UC END# *4F683EE00365_4DCA3AB8028E_var*
begin
//#UC START# *4F683EE00365_4DCA3AB8028E_impl*
 if f_PreviewEnabled then
 begin
  with f_Dialog.PreviewMemo, TextSource, Processor do begin
   ReadOnly := false;
   DocumentContainer.TagWriter.WriteTagEx(View, Self, nil);
   ReadOnly := True;
   Invalidate;
  end;//with f_Dialog.PreviewMemo.TextSource
 end; // PreviewEnabled
//#UC END# *4F683EE00365_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.WriteToPreview

function TddTextAndTableConverter.GetTable: TddVirtualTable;
//#UC START# *4F683F0E02D9_4DCA3AB8028E_var*
//#UC END# *4F683F0E02D9_4DCA3AB8028E_var*
begin
//#UC START# *4F683F0E02D9_4DCA3AB8028E_impl*
 Result := f_Table;
//#UC END# *4F683F0E02D9_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.GetTable

procedure TddTextAndTableConverter.DialogCellCount(aCellCount: LongInt);
//#UC START# *4F683FC4034D_4DCA3AB8028E_var*
var
 l_SaveCellCount: Integer;
//#UC END# *4F683FC4034D_4DCA3AB8028E_var*
begin
//#UC START# *4F683FC4034D_4DCA3AB8028E_impl*
 {Перерасчет количества строк в зависимости от числа ячеек}
 if aCellCount > 0 then
 begin
  RecalcRows;
  f_Table.Restructure(aCellCount);
  //RecalcRows;
  f_Dialog.RowCount:= f_Table.RowCount;
  WriteToPreview;
 end; // CellCount > 0
//#UC END# *4F683FC4034D_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.DialogCellCount

procedure TddTextAndTableConverter.DialogCellSeparator(aCellSeparator: TddCellSeparator);
//#UC START# *4F683FE50015_4DCA3AB8028E_var*
//#UC END# *4F683FE50015_4DCA3AB8028E_var*
begin
//#UC START# *4F683FE50015_4DCA3AB8028E_impl*
 CellSeparator := aCellSeparator;
 if CellSeparator = csOther then
  f_ColumnSeparator := f_Dialog.OtherSeparator;

 RecalcRows;
 f_Dialog.SetParams := True;
 f_Dialog.SpinCellCount.MaxValue := f_Table.TotalCellCount;
 f_Dialog.RowCount := f_Table.RowCount;
 if f_Table.RowCount > 0 then
  f_Dialog.CellCount:= f_Table.TotalCellCount div f_Table.RowCount
 else
  f_Dialog.CellCount:= 0;
 f_Dialog.SetParams:= False;

 WriteToPreview;
//#UC END# *4F683FE50015_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.DialogCellSeparator

procedure TddTextAndTableConverter.DialogAutoFit(aAutoFit: TddAutoFitBehavior);
//#UC START# *4F683FFE02F4_4DCA3AB8028E_var*
var
 i: TddCellSeparator;
//#UC END# *4F683FFE02F4_4DCA3AB8028E_var*
begin
//#UC START# *4F683FFE02F4_4DCA3AB8028E_impl*
 for i := Low(TddCellSeparator) to High(TddCellSeparator) do
  f_Rows[i].AutoFit := aAutoFit;
 f_Table.CellAdjust := aAutoFit;
 //RecalcRows;
 f_Table.Restructure(f_Dialog.CellCount);
 WriteToPreview;
//#UC END# *4F683FFE02F4_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.DialogAutoFit

procedure TddTextAndTableConverter.DialogGlueLines(Enable: Boolean);
//#UC START# *4F6840220354_4DCA3AB8028E_var*
var
 i: TddCellSeparator;
//#UC END# *4F6840220354_4DCA3AB8028E_var*
begin
//#UC START# *4F6840220354_4DCA3AB8028E_impl*
 f_GlueLines := Enable;
 for i := Low(TddCellSeparator) to High(TddCellSeparator) do
   f_Rows[i].GlueLines := f_GlueLines;
 RecalcRows;
 if f_PreviewEnabled then
  WriteToPreview;
//#UC END# *4F6840220354_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.DialogGlueLines

procedure TddTextAndTableConverter.RecalcRows;
//#UC START# *4F68404500E9_4DCA3AB8028E_var*
//#UC END# *4F68404500E9_4DCA3AB8028E_var*
begin
//#UC START# *4F68404500E9_4DCA3AB8028E_impl*
 f_Table.Clear;
 if CellSeparator in [csGraphic, csSpace] then
  f_Rows[CellSeparator].CopyToVirtualTable(f_Table)
 else
 begin
  if CellSeparator = csOther then
  begin
   if f_ColumnSeparator <> '' then
    TddSeparatorTable(f_Rows[CellSeparator]).Separator := f_ColumnSeparator[1]
  end
  else
   f_Rows[CellSeparator].Analyze;
  f_Rows[CellSeparator].CopyToVirtualTable(f_Table);
 end;
//#UC END# *4F68404500E9_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.RecalcRows

procedure TddTextAndTableConverter.Tune;
//#UC START# *4F68405D0117_4DCA3AB8028E_var*
//#UC END# *4F68405D0117_4DCA3AB8028E_var*
begin
//#UC START# *4F68405D0117_4DCA3AB8028E_impl*
 { показ окошка и реакция на изменения параметров }
 f_Dialog := TTableConvParamDialog.Create(Application);
 try
   f_Dialog.SetParams := True;
   f_Dialog.OnCellCount := DialogCellCount;
   f_Dialog.OnCellSeparator := DialogCellSeparator;
   f_Dialog.OnShowPreview := DialogShowPreview;
   f_Dialog.OnAutoFitChanged := DialogAutoFit;
   f_Dialog.OnGlueLInes := DialogGlueLines;
   f_Dialog.CellCount := f_CellCount;
   f_Dialog.RowCount := f_Table.RowCount;
   f_Dialog.CellSeparator := CellSeparator;
   f_Dialog.Otherseparator := f_ColumnSeparator;
   f_Dialog.cbGlueLines.Checked := f_GlueLines;
   f_Dialog.SpinCellCount.MaxValue := f_Table.TotalCellCount;
   WriteToPreview;

   f_Dialog.SetParams:= False;
   f_AbortConversion:= not f_Dialog.Execute;
   if not f_AbortConversion then
   begin
    if f_Dialog.rbFitContent.Checked then
     f_Table.CellAdjust := afContent
    else
     f_Table.CellAdjust := afEqual;
   end;
 finally
   f_Dialog.Free;
 end;
//#UC END# *4F68405D0117_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.Tune

procedure TddTextAndTableConverter.Text2Table;
//#UC START# *4F68407C003D_4DCA3AB8028E_var*
var
 l_Gen  : Tk2TagGenerator;
 l_Pack : InevOp;
//#UC END# *4F68407C003D_4DCA3AB8028E_var*
begin
//#UC START# *4F68407C003D_4DCA3AB8028E_impl*
 if not f_AbortConversion then
 begin
  l_Pack := Editor.StartOp(ev_ocUser + 100);
  try
   Editor.Range.Delete;
   l_Gen := nil;
   TevdEmptyRowFilter.SetTo(l_Gen);
   TevTableFilter.SetTo(l_Gen);
   try
    (Self As Ik2TagGeneratorChainEnd).Link(l_Gen);
   finally
    l3Free(l_Gen);
   end;
   Editor.TextSource.DocumentContainer.TagWriter.WriteTagEx(Editor.View, Self, Editor.Selection.Cursor);
  finally
   l_Pack:= nil;
  end;
 end;
//#UC END# *4F68407C003D_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.Text2Table

constructor TddTextAndTableConverter.Create(anOwner: TComponent = nil);
//#UC START# *4F6852880115_4DCA3AB8028E_var*
var
 i: TddCellSeparator;
//#UC END# *4F6852880115_4DCA3AB8028E_var*
begin
//#UC START# *4F6852880115_4DCA3AB8028E_impl*
 inherited Create(anOwner);
 f_ColumnSeparator := cc_EOL;
 CodePageOut := cp_ANSI;
 f_CodePageIn := cp_OEM;
 f_CellCount := 1;

 f_MyStream := nil;
 f_PreviewEnabled := False;

 // Формируем список таблиц...
 for i := Low(TddCellSeparator) to High(TddCellSeparator) do
  case i of
   csGraphic   : f_Rows[i] := TddGraphicTable.Create; 
   csParagraph : f_Rows[i] := TddParagraphTable.Create;
   csTab       : f_Rows[i] := TddSeparatorTable.Create(#9);
   csSemicolon : f_Rows[i] := TddSeparatorTable.Create(';');
   csSpace     : f_Rows[i] := TddSpaceTable.Create;
   csOther     : f_Rows[i] := TddSeparatorTable.Create(' ');
  end;
 { TODO -oДмитрий Дудко -cОшибка : Ширину таблицы нужно получать изходя из текущей ширины страницы }
 TableWidth := 8000;

 f_Table := TddVirtualTable.Create(nil);
 f_DocGen := TddDocumentGenerator.Create;
 f_DocGen.UseExternalLinks := True;
 f_DocGen.OneStep := False;
 f_Lines := Tl3StringList.Make;
 f_GlueLines := True;
//#UC END# *4F6852880115_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.Create

procedure TddTextAndTableConverter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DCA3AB8028E_var*
var
 i: TddCellSeparator;
//#UC END# *479731C50290_4DCA3AB8028E_var*
begin
//#UC START# *479731C50290_4DCA3AB8028E_impl*
 l3Free(f_DocGen);
 l3Free(f_MyStream);
 l3Free(f_Lines);
 for i := Low(TddCellSeparator) to High(TddCellSeparator) do
  l3Free(f_Rows[i]);
 l3Free(f_Table);
 inherited
//#UC END# *479731C50290_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.Cleanup

procedure TddTextAndTableConverter.Read;
//#UC START# *4F68343D038D_4DCA3AB8028E_var*
var
 i           : Integer;
 j           : Integer;
 k           : Integer;
 l           : Integer;
 l_Row       : TddTableRow;
 l_Cell      : TddTableCell;
 l_CellProp  : TddCellProperty;
 l_Text      : Tl3String;
 l_TextPara  : TddTextParagraph;
 l_Seg       : TddTextSegment;
 l_Hyperlink : TddTextSegment;
//#UC END# *4F68343D038D_4DCA3AB8028E_var*
begin
//#UC START# *4F68343D038D_4DCA3AB8028E_impl*
  { выливка соответствующего списка в генератор }
//  if CellSeparator <> csGraphic then
//    f_Table.Prepare2Write;
{ TODO -oДмитрий Дудко -cОшибка : перед выводом таблицы перерассчитать ширину ячеек }
 if f_Table.RowCount > 0 then
 begin
  Generator.StartChild(k2_typDocument);
  try
    Generator.StartChild(k2_typTable);
    try
      for i := 0 to Pred(f_Table.RowCount) do
      begin
        l_Row := f_Table.Rows[i];
        Generator.StartChild(k2_typTableRow);
        try
          for j := 0 to Pred(l_Row.CellCount) do
          begin
            l_Cell := l_Row.Cells[j];
            l_CellProp := l_Row.Cells[j].Props;

            Generator.StartChild(k2_typTableCell);
            if l_CellProp.VMergeFirst then
             Generator.AddIntegerAtom(k2_tiMergeStatus, Ord(ev_msHead))
            else
             if l_CellProp.VMerged then
              Generator.AddIntegerAtom(k2_tiMergeStatus, Ord(ev_msContinue));

            if not (CellSeparator in [csGraphic, csSpace]) then
             Generator.AddIntegerAtom(k2_tiWidth, evChar2Inch(l_CellProp.CellOffset + 1))
            else
            begin
             if j > 0 then
              Generator.AddIntegerAtom(k2_tiWidth, evChar2Inch(l_CellProp.CellOffset - l_Row.Cells[j-1].Props.CellOffset))
             else
              Generator.AddIntegerAtom(k2_tiWidth, evChar2Inch(l_CellProp.CellOffset));
            end;
            if (CellSeparator <> csSpace) then
             WriteBorders(l_CellProp.Border);
            try
             if f_GlueLines then
             begin
              while l_Cell.Count > 1 do
              begin
               TddTextParagraph(l_Cell.Items[0]).JoinWith(l_Cell.Items[1], f_CellSeparator = csSpace);
               l_Cell.Delete(1);
              end; // while l_Cell.Count > 1
              l_TextPara := TddTextParagraph(l_Cell.Items[0]);
              if l_TextPara.HaveHyperlinks and l_TextPara.HaveSegments then
              begin
               // искать нужно по тексту, а не по списку
               k := Succ(l_TextPara.Text.Len);
               while k > 0 do
               begin
                l_Seg := l_TextPara.SegmentByCharIndex(k, True);
                while (l_Seg = nil) and (k > 0) do
                begin
                 Dec(k);
                 l_Seg := l_TextPara.SegmentByCharIndex(k, True);
                end;
                if l_Seg <> nil then
                begin
                 if l_Seg.CHP.Style = ev_saHyperLinkCont then
                 begin
                  l := Succ(l_Seg.Start);
                  repeat
                   Dec(l);
                   l_Hyperlink := l_TextPara.HyperLinkByCharIndex(l, True);
                  until (l = 0) or (l_Hyperlink <> nil);
                  if l > 0 then
                  begin
                   l_HyperLink.Stop := l_Seg.Stop;
                   l_TextPara.RemoveSegment(l_Seg);
                   k := l_HyperLink.Start;
                  end // l > 0
                  else
                   Dec(k);
                 end
                 else
                  Dec(k);
                end // l_Seg <> nil
               end; // while i > 0
              end; // if l_TextPara.SegmentList.Count > 0
             end; // GlueLines
             for k := 0 to Pred(l_Cell.Count) do
             begin
              l_TextPara:= TddTextParagraph(l_Cell.Items[k]);
              l_Text := l_TextPara.Text;
              l_TextPara.PAP.InTable := True;
              l_TextPara.Write2Generator(Generator, False, False);
             end; // for k
            finally
             Generator.Finish;
            end; { try..finally TableColumn }
          end; // for j
        finally
         Generator.Finish;
        end; { try..finally TableRow }
      end;
    finally
     Generator.Finish;
    end; { try..finally Table }
  finally
   Generator.Finish;
  end; { try..finally Document }
 end; // f_Table.RowList.Count > 0
//#UC END# *4F68343D038D_4DCA3AB8028E_impl*
end;//TddTextAndTableConverter.Read

end.
