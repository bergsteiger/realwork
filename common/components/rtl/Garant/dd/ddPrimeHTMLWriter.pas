unit ddPrimeHTMLWriter;

interface

uses
 Classes, ddBase, ddDocument, ddRTFProperties, l3LongintList, l3ObjectRefList, ddHTMLWriter,
 L3Base, l3Types, k2Types, ddParagraphProperty, ddDocumentAtom, ddTable, ddBreak,
 ddTableRow,
 ddTypes
 ;

type
 TddAnnoNameFound = procedure (aDocID: Integer; const aName: AnsiString) of object;
  TddPrimeHTMLWriter = class(TddHTMLGenerator)
  private
    FNeedStyleSheet: Boolean;
    f_DivPreOpened: Boolean;
    f_DocID: Integer;
    f_IsComplexTable: Boolean;
    f_IsEtalonRow: Boolean;
    f_isFirstHeader: Boolean;
    f_IsPrime: Boolean;
    f_Link: AnsiString;
    f_ListLevel: Integer;
    f_MLFileName: AnsiString;
    f_MLNumber: Integer;
    f_MultiLinks: TStrings;
    f_PictureNumber: Integer;
    f_ListIndents: Tl3LongintList;
    f_OnAnnoNameFound: TddAnnoNameFound;
    procedure CloseDivPre;
    procedure OpenDivPre;
    function pm_GetListLeftIndent: Integer;
    function pm_GetListOpened: Boolean;
    procedure pm_SetIsPrime(const Value: Boolean);
    procedure pm_SetListLeftIndent(const Value: Integer);
  protected
    procedure AnnoNameFound(aDocID: Integer; const aName: AnsiString);
    procedure Cleanup; override;
    procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
    function PAP2HTML(aPAP: TddPAragraphProperty; StopTag: Boolean; const aList: Tl3ObjectRefList =
        nil): AnsiString; override;
    function StyleName(StyleID: Integer; var IsSpecial: Boolean): AnsiString; override;
    procedure WriteBreak(const aBreak: TddBreak); override;
    procedure WriteColorTable(aDefault: Boolean = False); override;
    procedure WriteDocumentEnd; override;
    procedure WriteDocumentHeader; override;
    procedure WriteDocumentStart; override;
    procedure WriteFontTable(aDefault: Boolean = False); override;
    procedure WriteHeader(aDefault: Boolean = False); override;
    procedure WriteStyleTable(aDefault: Boolean = False); override;
    procedure WriteTable(const Table: TddTable; aOnlyPart: Boolean); override;
    procedure WriteTableRow(const aRow: TddTableRow; anIndex: Integer; const aRowType: TddRowType = dd_rtNone; aRowPos: TddRowPosition = dd_rpNone); override;
  public
    constructor Create;
    reintroduce;
    property IsPrime: Boolean read f_IsPrime write pm_SetIsPrime;
    property ListLeftIndent: Integer read pm_GetListLeftIndent write
        pm_SetListLeftIndent;
    property NeedStyleSheet: Boolean read FNeedStyleSheet write FNeedStyleSheet;
    property ListOpened: Boolean read pm_GetListOpened;
    property OnAnnoNameFound: TddAnnoNameFound read f_OnAnnoNameFound write
        f_OnAnnoNameFound;
  end;

implementation

uses StrUtils, SysUtils, evdStyles, RTFTypes, k2Base, k2Tags, AnnoTopic_Const,
 DocUment_Const, Math, ddTableCell, ddTextParagraph, ddCellProperty;

{
******************************* TddPrimeHTMLWriter *******************************
}
constructor TddPrimeHTMLWriter.Create;
begin
  inherited Create;
  f_ListIndents := Tl3LongintList.Make;
  f_MultiLinks:= TStringList.Create;
  FNeedStyleSheet := True;
end;

procedure TddPrimeHTMLWriter.AnnoNameFound(aDocID: Integer; const aName:
    String);
begin
 if Assigned(f_OnAnnoNameFound) then f_OnAnnoNameFound(aDocID, aName);
end;

function TddPrimeHTMLWriter.PAP2HTML(aPAP: TddPAragraphProperty; StopTag: Boolean; const aList:
    Tl3ObjectRefList = nil): AnsiString;
var
  l_List: Tl3ObjectRefList;
  l_StyleName: AnsiString;
  l_IsSpecial: Boolean;
  l_Left : Integer;
begin
  Result:= '';
  if aList <> nil then
   l_List:= aList
  else
   l_List:= Tl3ObjectRefList.Make;
  try
   with aPAP do
   begin
    if (Style <> 0) and (Style <> propUndefined) then
    begin
     if Style = ev_saNormalTable then
      l_StyleName := ''
     else
      l_StyleName:= StyleName(aPAP.Style, l_IsSpecial);

     if l_StyleName <> '' then
     begin
      if l_IsSpecial then
       AddTag(l_List, Format('%s', [l_StyleName]), '')
      else
      begin
       if (Just = justP) and not IsPrime then
        AddTag(l_List, 'pre', ''{'WIDTH=80'})
       else
       if Bullet = propUndefined then
        AddTag(l_List, 'p', Format('class="%s"', [l_StyleName]))
       else
        AddTag(l_List, 'li', '');
      end;
     end
     else
      AddTag(l_List, 'p', '');
    end //Style <> 0
    else
    begin
     if Bullet = propUndefined then
      AddTag(l_List, 'p', '')
     else
     if (Bullet <> propUndefined) then
     begin
      if StopTag then
       AddTag(l_List, '', '')
      else
       AddTag(l_List, 'li', '');
     end;
    end;
   end; // with aPAP
   Result:= GetFormat(l_List, StopTag);
  finally
   if aList = nil then
    L3Free(l_List);
  end; // try..finally
end;

procedure TddPrimeHTMLWriter.Cleanup;
begin
 l3Free(f_ListIndents);
 l3Free(f_MultiLinks);
 inherited;
end;

procedure TddPrimeHTMLWriter.CloseDivPre;
begin
 if f_DivPreOpened then
 begin
  f_DivPreOpened := False;
  OutStringLn('</pre>');
 end;
end;

procedure TddPrimeHTMLWriter.AddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  if AtomIndex = k2_tiExternalHandle then
   f_DocID:= Value.AsInteger
  else
  if AtomIndex = k2_tiName then
   AnnoNameFound(f_DocID, Value.AsString.AsString);
 end;
 inherited;
end;

procedure TddPrimeHTMLWriter.OpenDivPre;
begin
 if not f_DivPreOpened and IsPrime then
 begin
  f_DivPreOpened := True;
  OutStringLn('<pre>'); // условно
 end;
end;

function TddPrimeHTMLWriter.pm_GetListLeftIndent: Integer;
begin
 if f_ListIndents.Count > 0 then
  Result := f_ListIndents.Items[f_ListIndents.Hi]
 else
  Result := -1;
end;

function TddPrimeHTMLWriter.pm_GetListOpened: Boolean;
begin
 Result := f_ListLevel > 0;
end;

procedure TddPrimeHTMLWriter.pm_SetIsPrime(const Value: Boolean);
begin
 if f_IsPrime <> Value then
 begin
  f_IsPrime := Value;
  if IsPrime then
  begin
   NeedStyleSheet := False;
  end;
 end;
end;

procedure TddPrimeHTMLWriter.pm_SetListLeftIndent(const Value: Integer);
begin
 f_ListIndents.Add(Value);
end;

function TddPrimeHTMLWriter.StyleName(StyleID: Integer; var IsSpecial: Boolean): AnsiString;
begin
  IsSpecial:= False;
  case StyleID of
   ev_saTxtNormalANSI   :
    begin
     Result:= 'p'; {* - Нормальный. }
     IsSpecial:= True;
    end;
   ev_saTxtHeader1      :
    begin
      if f_isFirstHeader then
       Result := 'h2'
      else
       Result := 'h3';
     IsSpecial:= True;
    end;
   ev_saHyperLink       :
    begin
     Result:= 'a'; {* - Гипертекстовая ссылка. }
     IsSpecial:= True;
    end;
   ev_saToLeft          : Result:= 'ToLeft'; {* - Прижатый влево. }
   ev_saNormalSBSLeft   : Result:= 'ToLeft'; {* - Нормальный для левых частей SBS. }
   ev_saNormalSBSRight  : Result:= 'ToRight'; {* - Нормальный для правых частей SBS. }
   ev_saHFLeft          : Result:= 'ToLeft';   {* - колонтитул (левый). }
   ev_saHFRight         : Result:= 'ToRight'   {* - колонтитул (правый). }
  else
   Result:= '';
  end // case StyleID
end;

procedure TddPrimeHTMLWriter.WriteBreak(const aBreak: TddBreak);
begin
end;

procedure TddPrimeHTMLWriter.WriteColorTable(aDefault: Boolean = False);
begin
end;

procedure TddPrimeHTMLWriter.WriteDocumentEnd;
begin
   OutStringLn('</div>')
end;

procedure TddPrimeHTMLWriter.WriteDocumentHeader;
begin
  OutStringLn('<a name="0"></a>');
end;

procedure TddPrimeHTMLWriter.WriteDocumentStart;
begin
   OutStringLn('<div id="primeDocs">')
end;

procedure TddPrimeHTMLWriter.WriteFontTable(aDefault: Boolean = False);
begin
end;

procedure TddPrimeHTMLWriter.WriteHeader(aDefault: Boolean = False);
begin
end;

procedure TddPrimeHTMLWriter.WriteStyleTable(aDefault: Boolean = False);
begin
end;

procedure TddPrimeHTMLWriter.WriteTable(const Table: TddTable; aOnlyPart: Boolean);
var
 i, j: Integer;
 l_Row: TddTableRow;
 l_RowPos: TddRowPosition;
 l_EtalonRowIndex,
 l_MaxCellCount: Integer;
begin
  if not Table.IsSBS then
  begin
   if IsPrime then
    OutStringLn('<table class="primeTab">')
   else
    OutStringLn('<table border="1">')
  end
  else
   OutStringLn('<table>');

  l_EtalonRowIndex := -1;
  l_MaxCellCount:= 0;
  f_IsComplexTable := False;
  for i:= 0 to Pred(Table.RowCount) do
  begin
   l_Row:= Table[i];
   if l_Row.CellCount > l_MaxCellCount then
   begin
    l_EtalonRowIndex:= i;
    l_MaxCellCount:= l_Row.CellCount;
   end; // l_Row.CellCount > l_MaxCellCount
   if not f_IsComplexTable then
    for j:= 0 to Pred(l_Row.CellCount) do
     if l_Row.Cells[j].Props.VMerged or l_Row.Cells[j].Props.Merged or
        l_Row.Cells[j].Props.MergeFirst or l_Row.Cells[j].Props.VMergeFirst then
     begin
      f_IsComplexTable:= True;
      break;
     end;
  end; // for i
  f_IsComplexTable := f_IsComplexTable and (l_EtalonRowIndex > 0);
  for i:= 0 to Pred(Table.RowCount) do
  begin
   f_IsEtalonRow:= i = l_EtalonRowIndex;
   if i = 0 then
    l_RowPos := dd_rpFirst
   else
    l_RowPos := dd_rpNone;
   WriteTableRow(Table.Rows[i], i, TddRowType(Table.IsSBS), l_RowPos);
  end;
  OutStringLn('</table>')
end;

procedure TddPrimeHTMLWriter.WriteTableRow(const aRow: TddTableRow; anIndex: Integer; const aRowType: TddRowType = dd_rtNone;
    aRowPos: TddRowPosition = dd_rpNone);
var
 i, j: Integer;
 l_Cell: TddTableCell;
 l_CellProp: TddCellProperty;
 l_List: Tl3ObjectRefList;
 l_S: AnsiString;
begin
 l_List:= Tl3ObjectRefList.Make;
 try
  OutStringLn(' <tr>');
  for i:= 0 to Pred(aRow.CellCount) do
  begin
   l_List.Clear;
   l_CellProp:= aRow.Cells[i].Props;
   if not l_CellProp.VMerged then
   begin
    if {aIsSBS} (aRowType = dd_rtSBS) then
      AddTag(l_List, 'td', 'width="50%"')
    else
    if aRowPos = dd_rpFirst then
     l_s:= 'th'
    else
     l_S := 'td';
    AddTag(l_List, l_S, '');

    if l_CellProp.RowSpan > 1 then
     AddTag(l_List, l_S, Format('rowspan="%d"', [l_CellProp.RowSpan]));
    if l_CellProp.CellSpan > 1 then
     AddTag(l_List, l_S, Format('colspan="%d"', [l_CellProp.CellSpan]));
    if l_CellProp.PatternBackColor <> propUndefined then
     with Document.ColorTable[Pred(l_CellProp.PatternBackColor)] do
      AddTag(l_List, l_S, Format('bgcolor="#%s%s%s"', [IntToHex(Red, 2), IntToHex(Green, 2), IntToHex(Blue, 2)]));
    OutStringLn(GetFormat(l_List, False));

    l_Cell:= aRow.Cells[i];
    for j:= 0 to Pred(l_Cell.Count) do
     WriteTextParagraph(TddTextParagraph(l_Cell.Items[j]));

    OutStringLn(GetFormat(l_List, True));
   end; // if not l_CellProps.VMerged
  end; // for i
  OutStringLn('</tr>');
 finally
  l3Free(l_List);
 end; // l_List
end;

end.
