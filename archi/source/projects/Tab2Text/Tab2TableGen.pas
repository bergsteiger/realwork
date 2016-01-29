unit Tab2TableGen;

interface
uses
 ddDocument, ddBase,
 evTextFormatter
 ;

type
 TddTab2TableGenerator = class(TddDocumentGenerator)
 private
  FCharPerLine: Integer;
  f_TableStarted: Boolean;
  procedure CheckPara(Para: TddTextParagraph);
  procedure Tab2Table(Para: TddTextParagraph);
  procedure AddCell(aWidth: Integer);
  procedure AddRow(Duplicate: Boolean = False);
 protected
  f_Table: TddTable;
  f_Formatter  : TevTextFormatter;
  f_TextGen    : TevPlainTextGenerator;
 public
  procedure Write2Filer; override;
  property CharPerLine: Integer read FCharPerLine write FCharPerLine;
 end;


implementation

Uses
 l3String, l3Base, l3InternalInterfaces, l3Chars,
 k2Tags,
 RTFTypes
 ;

const
 minBefore = 10;

{ TddTab2TableGenerator }

procedure TddTab2TableGenerator.Write2Filer;
var
 i: Integer;
 l_A: TddDocumentAtom;
 l_Skip: Integer;
begin
 f_Formatter:= TevTextFormatter.Create(nil);
 try
  f_Formatter.CharsInLine:= CharPerLine;
  f_Formatter.FormatOrdinalParas:= False;
  f_Formatter.CodePage:= cp_OEMLite;
  f_TextGen:= TevPlainTextGenerator.Create(nil);
  try
   f_Formatter.Generator:= f_TextGen;
   f_TextGen.Filer:= Filer;
   f_Table:= TddTable.Create(nil);
   try
    AddRow;
    f_Formatter.Start;
    try
     f_Formatter.StartChild(k2_idDocument);
     try
      l_Skip:= 0;
      f_TableStarted:= False;
      for i:= 0 to Document.Paragraphs.Hi do
      begin
       if l_Skip = 0 then
       begin
        l_A:= TddDocumentAtom(Document.Paragraphs.Items[i]);
        if l_A.AtomType = dd_docTextParagraph then
         CheckPara(TddTextParagraph(l_A))
        else
        if l_A.AtomType = dd_docBreak then
         l_Skip:= 3;
       end
       else
        Dec(l_Skip);
      end; // for i
      f_Table.Write2Generator(f_Formatter);
     finally
      f_Formatter.Finish;
     end;
    finally
     f_Formatter.Finish;
    end;
   finally
    l3Free(f_Table);
   end;
  finally
   l3Free(f_TextGen);
  end;
 finally
  l3Free(f_Formatter);
 end;
end;

procedure TddTab2TableGenerator.CheckPara(Para: TddTextParagraph);
var
 j: Integer;
begin
 if (f_TableStarted and (Para.PAP.TabList.Count > 0)) or ((Para.PAP.TabList.Count > 1) or
    ((Para.PAP.TabList.Count = 1) and (TddTab(Para.PAP.TabList.Items[0]).TabPos > 500))) then
 begin
  f_TableStarted:= True;
  for j:= 0 to Pred(Para.Text.Len) do
   if Para.Text.Ch[j] = #9 then
    begin
     Tab2Table(Para);
     break;
    end; //Text.Ch[i] = #9
 end
 else
 begin
  Para.Text.Insert(l3PCharLen('>'), 0, 1);
  f_Formatter.StartChild(k2_idTextPara);
  try
   f_Formatter.AddStringAtom(k2_tiText, Para.Text);
  finally
   f_Formatter.Finish;
  end;
 end;
end;

procedure TddTab2TableGenerator.Tab2Table(Para: TddTextParagraph);
var
 i: Integer;
 l_TabIndex: Integer;
 l_Text: String;
 l_Create: Boolean;
 l_Cell, l_PrevCell: TddtableCell;
 l_tab, l_PrevTab: TddTab;
 function _GetTextSize(aTabIndex: Integer): Integer;
 var
  IC          : Il3InfoCanvas;
  l_Seg       : TddTextSegment;
 begin
   IC:= evCrtIC;
   with IC.Font do
   begin
    l_Seg:= Para.AnySegmentByCharIndex(Pred(i));
    if (l_Seg = nil) or (l_Seg.CHP.FontName = '') then
    begin
     Name:= 'Arial';//'Courier New Cyr';
     Size:= 8; //CHP.FontSize div 2;
    end
    else
    begin
     Name:= l_Seg.CHP.FontName;
     Size:= l_Seg.CHP.FontSize div 2;
    end;
    Result:= IC.TextExtent(l3PCharLen(l_Text)).X;
   end; { with IC.Font }
   IC:= nil;
 end;

 function CellOverTab(aTabIndex: Integer): TddTableCell;
 var
  IC          : Il3InfoCanvas;
  l_Seg       : TddTextSegment;
  l_Pos       : Integer;
 begin
  if TddTab(Para.PAP.TabList.Items[aTabIndex]).Kind <> tkLeft then
  begin
   l_Pos:= _GetTextSize(aTabIndex);
  end
  else
   l_Pos:= TddTab(Para.PAP.TabList.Items[aTabIndex]).TabPos;
  Result:= f_Table.LastRow.CellByPos[l_Pos];
 end;
begin
 l_TabIndex:= 0;
 l_Text:= '';
 l_Create:= False;
 if (Para.PAP.Before <> propUndefined) and (Para.PAP.Before > MinBefore) then
  AddRow(True);
 AddRow;
 l_Create:= f_Table.LastRow.CellCount = 0;
 for i:= 0 to Pred(Para.Text.Len) do
 begin
  if Para.Text.Ch[i] = #9 then
  begin
   l_PrevCell:= f_Table.LastRow.LastCell;
   l_Tab:= TddTab(Para.PAP.TabList.Items[l_TabIndex]);
   if l_TabIndex > 0 then
    l_PrevTab:= TddTab(Para.PAP.TabList.Items[Pred(l_TabIndex)])
   else
    l_PrevTab:= nil;
   if l_Create{ and (l_Text <> '')} then
   begin
    if (l_PrevTab <> nil) and (l_PrevTab.Kind <> tkLeft) then
    begin
     l_prevCell.LastPara.AddText(l_Text);
     l_PrevCell.LastPara.PAP.JUST:= justR;
     l_Text:= ''
    end;
    if l_tab.Kind = tkLeft then
    begin
     AddCell(l_Tab.TabPos);
     f_Table.LastRow.LastCell.LastPara.AddText(l_Text);
     l_Text:= ''
    end
    else
    begin
     if l_PrevTab = nil then
      AddCell(_GetTextSize(l_TabIndex))
     else
     begin
      AddCell(l_PrevTab.TabPos + _GetTextSize(l_TabIndex));
      f_Table.LastRow.LastCell.LastPara.AddText(l_Text);
     l_Text:= ''
     end;
     AddCell(l_tab.TabPos);
    end;
   end;
   //if l_Text <> '' then
   begin
    if (l_PrevTab <> nil) and (l_PrevTab.Kind <> tkLeft) then
    begin
     l_prevCell.LastPara.AddText(l_Text);
     l_Text:= ''
    end
    else
    begin
     f_Table.LastRow.LastCell.LastPara.AddText(l_Text);
     l_Text:= ''
    end;

    (*
    if l_Tab.Kind = tkLeft then
    begin
     if l_Create then
     begin
      f_Table.LastRow.LastCell.LastPara.AddText(l_Text);
      l_Text:= '';
     end
     else
     begin
      l_Cell:= CellOverTab(l_TabIndex);
      if l_Cell <> nil then
       l_Cell.LastPara.AddText(l_Text);
     end
    end
    else
    begin
     if l_Create then
     begin
      if l_PrevCell <> nil then
      begin
       //l_PrevCell.LastPara.AddText(l_Text);
       f_Table.LastRow.LastCell.LastPara.AddText(l_Text);
       l_Text:= '';
      end;

     end
     else
     begin
      l_Cell:= CellOverTab(l_TabIndex);
      if l_Cell <> nil then
       l_Cell.LastPara.AddText(l_Text);
     end;
    end;
    *)
    (*
    l_Cell:= CellOverTab(l_TabIndex);
    if l_TabIndex > 0 then
     l_PrevCell:= CellOverTab(Pred(l_TabIndex))
    else
     l_PrevCell:= l_Cell;
    l_Cell.LastPara.AddText(l_Text);
    *)
//    l_Text:= '';
   end;
   Inc(l_TabIndex);
  end
  else
  begin
   l_Text:= l_Text + Para.Text.Ch[i];
  end;
 end; // for i
 l_Tab:= TddTab(Para.PAP.TabList.Items[Pred(l_TabIndex)]);
 if l_Tab.Kind = tkLeft then
  AddCell(l_Tab.TabPos+_GetTextSize(l_TabIndex));
 f_Table.LastRow.LastCell.LastPara.AddText(l_Text);
 if l_Tab.Kind <> tkLeft then
  f_Table.LastRow.LastCell.LastPara.PAP.JUST:= justR;
end;

procedure TddTab2TableGenerator.AddCell(aWidth: Integer);
var
 l_R: TddTableRow;
begin
 l_R:= f_Table.LastRow;
 if l_R <> nil then
 begin
  l_R.AddCellAndPara;
  l_R.LastCellProperty.Width:= aWidth;
 end; // l_R <> nil
end;

procedure TddTab2TableGenerator.AddRow(Duplicate: Boolean = False);
var
 l_R, l_LR: TddTableRow;
 l_C: TddTableCell;
 i: Integer;
begin
 l_R:= TddTableRow.Create(nil);
 try
  if Duplicate then
  begin
   l_LR:= f_Table.LastRow;
   if l_LR <> nil then
   begin
    l_R.TAP:= l_LR.TAP;
    for i:= 0 to Pred(l_LR.CellCount) do
     l_R.AddCellAndPara;
   end; // f_Table.LastRow <> nil
  end; // Duplicate
  f_Table.AddRow(l_R);
 finally
  l3Free(l_R);
 end;
end;


end.
  procedure Tab2Table;

 l_TabIndex:= 0;
 l_PrevTabLen:= 0;
 l_PrevTextLen:= 0;

  var
    l_SegIndex  : Integer;
    l_ParaText  : Tl3String;
    l_CharIndex : Integer;
    l_Seg       : TddTextSegment;
    l_WidthDelta: Integer;
    l_Tab, l_NextTab : TddTab;
    IC          : Il3InfoCanvas;
    l_Spec      : Boolean;
    l_IsCell    : Boolean;

    procedure MakeColumn(Index: Integer);
    var
      l_CHP         : TddCharacterProperty;
      l_IC          : Il3InfoCanvas;
      l_MinWidth    : Longint;
    begin
    (*
      Generator.StartChild(k2_idTableCell);
      try
        Generator.AddIntegerAtom(k2_tiLeftIndent, 0);
        Generator.AddIntegerAtom(k2_tiRightIndent, 0);
       if Index <> -1 then
       begin
        if (l_ParaText.Ch[0] = #9) and (Index > 0) then
          l_CHP:= Segments[Pred(Index)].CHP
        else
          l_CHP:= Segments[Pred(Index)].CHP
       end
       else
        l_CHP:= nil;
        l_MinWidth:= 0;

        if l_PrevTabLen < 0 then
          l_PrevTabLen:= evChar2Inch(l_ParaText.Len+3) - l_PrevTabLen;

        if l_Spec then
         Generator.AddIntegerAtom(k2_tiWidth, l_Tab.TabPos - l_PrevTabLen)
        else
        begin
         if l_WidthDelta > l_PrevTabLen then
         begin
          IC:= evCrtIC;
          try
           with IC.Font do
           begin
            if (l_CHP = nil) or (l_CHP.FontName = '') then
             Name:= 'Courier New Cyr'
            else
             Name:= l_CHP.FontName;
            Size:= l_CHP.FontSize div 2;
            l_PrevTabLen:= IC.TextExtent(l3PCharLen(l_ParaText.St+l_Seg.Start,
                                                    l_Seg.Stop-l_Seg.Start)).X
                           +l_WidthDelta+30;
           end; // with IC.Font
          finally
           IC:= nil;
          end; // IC
         end; //if l_WidthDelta > l_PrevTabLen
         Generator.AddIntegerAtom(k2_tiWidth, l3MulDiv(l_PrevTabLen-l_WidthDelta, evInchMul, rtfTwip));
        end; // not l_Spec

        if (PAP.Before > 0) and (PAP.Before <> propUndefined) then
        begin
          Generator.StartChild(k2_idTextPara);
          Generator.Finish;
        end;

        Generator.StartChild(k2_idTextPara);
        try
         Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
         if l_Spec then
          Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itRight));
         if l_CHP <> nil then
          l_CHP.Write2Generator(Generator);

         l_ParaText.DeleteDoubleSpace;
         if PAP.TrimText then
          l_ParaText.Trim;
         Generator.AddStringAtom(k2_tiText, l_ParaText);
        finally
         Generator.Finish;
        end; // k2_idTextPara
        {
        if PAP.After > 100 then
        begin
         Generator.StartChild(k2_idTextPara);
         Generator.Finish;
        end; // PAP.After > 100
        }
      finally
        Generator.Finish;
      end;
      *)
    end; // MakeColumn
var
 l_CreateTable: Boolean;
 l_TabIndex: Integer;
 l_PrevTabLen: Integer;
  begin // Tab2Table
   l_CreateTable:= f_Table.LastRow = nil;
   l_WidthDelta:= 0;
   l_Spec:= False;

   l_ParaText:= Tl3String.Create(nil);
   try
    try
     l_tab:= TddTab(Para.PAP.TabList.Items[l_TabIndex]);
     l_PrevTabLen:= l_Tab.TabPos
    except
     l_PrevTabLen:= 720;
    end; // try..except
    if Para.PAP.TabList.Hi > l_TabIndex then
     l_NextTab:= TddTab(Para.PAP.TabList.Items[Succ(l_TabIndex)])
    else
     l_NextTab:= nil;
    { ѕеребор сегментов и текста, дл€ определени€ границ €чеек таблицы }
    for l_CharIndex:= 0 to Pred(Para.Text.Len) do
    begin
     if Para.Text.Ch[l_CharIndex] = #9 then
     begin
      l_Seg:= Para.AnySegmentByCharIndex(l_CharIndex);
      l_SegIndex:= Para.SegmentList.IndexOf(l_Seg);
      if not l_Spec then
      begin
       if (l_Tab.Kind <> tkLeft) then // было - = tkRight
       begin
        l_Spec:= True;
        //if l_TabIndex > 0 then
        // l_PrevTabLen:= TddTab(Para.PAP.TabList.Items[Pred(l_TabIndex)]).TabPos
        //else
        begin
         IC:= evCrtIC;
         with IC.Font do
         begin
          if (l_Seg = nil) or (l_Seg.CHP.FontName = '') then
          begin
           Name:= 'Arial';//'Courier New Cyr';
           Size:= 8; //CHP.FontSize div 2;
          end
          else
          begin
           Name:= l_Seg.CHP.FontName;
           Size:= l_Seg.CHP.FontSize div 2;
          end;
          l_PrevTabLen:= (IC.TextExtent(l_ParaText.AsPCharLen).X+l_WidthDelta);
         end; { with IC.Font }
         IC:= nil;
        end;
       end; // (l_Tab.Kind <> tkLeft)
       if l_CreateTable then
        MakeColumn(l_SegIndex);
       l_WidthDelta:= l_PrevTabLen;
       l_Spec:= l_Tab.Kind <> tkLeft;//= tkRight;
      end
      else { l_Spec = True}
      begin
       if l_CreateTable then
        MakeColumn(l_SegIndex);
       if l_TabIndex = 0 then
        l_WidthDelta:= l_Tab.TabPos-l_PrevTabLen
       else
        l_WidthDelta:= l_Tab.TabPos;
       l3Free(l_ParaText);                 // - ???
       l_ParaText:= Tl3String.Create(nil); // - ????
       l_Spec:= False;
       Inc(l_TabIndex);
       try
        l_tab:= TddTab(Para.PAP.TabList.Items[l_TabIndex]);
        l_PrevTabLen:= l_Tab.TabPos
       except
        l_PrevTabLen:= 720;
       end; // try..except
       //MakeColumn(l_SegIndex); - ???
      end; // l_Spec
      l3Free(l_ParaText);                // ???
      l_ParaText:= Tl3String.Create(nil);// ???
      l_WidthDelta:= l_PrevTabLen;
      if not l_Spec then
      begin
       Inc(l_TabIndex);
       if (l_TabIndex >=0) and (l_TabIndex < Para.PAP.TabList.Count) then
       begin
        l_tab:= TddTab(Para.PAP.TabList.Items[l_TabIndex]);
        l_PrevTabLen:= l_Tab.TabPos;
       end
       else
        l_PrevTabLen:= -l_PrevTabLen;
      end; // not l_Spec
     end { l_Seg.Ch = #9 }
     else
      l_ParaText.Append(Text.Ch[l_CharIndex]);
    end; // for l_CharIndex
    if not l_ParaText.Empty and l_CreateTable then
     MakeColumn(SegmentList.Hi);
   finally
    l3Free(l_ParaText);
   end; // l_ParaText
  end; // Tab2Table

