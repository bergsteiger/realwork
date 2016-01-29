unit alcuPrimeHTMLWriter;

interface

uses
 Classes, ddBase, ddDocument, ddRTFProperties, l3LongintList, l3ObjectRefList, ddHTMLWriter,
 L3Base, l3Types;

type
  TalcuPrimeHTMLWriter = class(TddHTMLGenerator)
  private
    FNeedStyleSheet: Boolean;
    f_DivPreOpened: Boolean;
    f_IsComplexTable: Boolean;
    f_IsEtalonRow: Boolean;
    f_isFirstHeader: Boolean;
    f_IsPrime: Boolean;
    f_Link: string;
    f_ListLevel: Integer;
    f_MLFileName: string;
    f_MLNumber: Integer;
    f_MultiLinks: TStrings;
    f_PictureNumber: Integer;
    f_ListIndents: Tl3LongintList;
    procedure CloseDivPre;
    procedure OpenDivPre;
    function pm_GetListLeftIndent: Integer;
    function pm_GetListOpened: Boolean;
    procedure pm_SetIsPrime(const Value: Boolean);
    procedure pm_SetListLeftIndent(const Value: Integer);
  protected
    procedure Cleanup; override;
    function PAP2HTML(aPAP: TddPAragraphProperty; StopTag: Boolean; const aList: Tl3ObjectRefList =
        nil): string; override;
    function StyleName(StyleID: Integer; var IsSpecial: Boolean): string; override;
    procedure WriteBreak(const aBreak: TddBreak); override;
    procedure WriteColorTable(aDefault: Boolean = False); override;
    procedure WriteDocumentEnd; override;
    procedure WriteDocumentHeader; override;
    procedure WriteDocumentStart; override;
    procedure WriteFontTable(aDefault: Boolean = False); override;
    procedure WriteHeader(aDefault: Boolean = False); override;
    procedure WriteStyleTable(aDefault: Boolean = False); override;
    procedure WriteTable(const Table: TddTable); override;
    procedure WriteTableRow(const Row: TddTableRow; const aIsSBS: Boolean = False; const IsFirstRow:
        Boolean = False; const IsNested: Boolean = False); override;
  public
    constructor Create;
    reintroduce;
    property IsPrime: Boolean read f_IsPrime write pm_SetIsPrime;
    property ListLeftIndent: Integer read pm_GetListLeftIndent write
        pm_SetListLeftIndent;
    property NeedStyleSheet: Boolean read FNeedStyleSheet write FNeedStyleSheet;
    property ListOpened: Boolean read pm_GetListOpened;
  end;

implementation

uses StrUtils, SysUtils, evdStyles, RTFTypes, k2Base, k2Tags, AnnoTopic_Const, DocUment_Const, Math;

{
******************************* TalcuPrimeHTMLWriter *******************************
}
constructor TalcuPrimeHTMLWriter.Create;
begin
  inherited Create;
  f_ListIndents := Tl3LongintList.Make;
  f_MultiLinks:= TStringList.Create;
  FNeedStyleSheet := True;
end;

function TalcuPrimeHTMLWriter.PAP2HTML(aPAP: TddPAragraphProperty; StopTag: Boolean; const aList:
    Tl3ObjectRefList = nil): string;
var
  l_List: Tl3ObjectRefList;
  l_StyleName: string;
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

procedure TalcuPrimeHTMLWriter.Cleanup;
begin
 l3Free(f_ListIndents);
 l3Free(f_MultiLinks);
 inherited;
end;

procedure TalcuPrimeHTMLWriter.CloseDivPre;
begin
 if f_DivPreOpened then
 begin
  f_DivPreOpened := False;
  OutStringLn('</pre>');
 end;
end;

procedure TalcuPrimeHTMLWriter.OpenDivPre;
begin
 if not f_DivPreOpened and IsPrime then
 begin
  f_DivPreOpened := True;
  OutStringLn('<pre>'); // условно
 end;
end;

function TalcuPrimeHTMLWriter.pm_GetListLeftIndent: Integer;
begin
 if f_ListIndents.Count > 0 then
  Result := f_ListIndents.Items[f_ListIndents.Hi]
 else
  Result := -1;
end;

function TalcuPrimeHTMLWriter.pm_GetListOpened: Boolean;
begin
 Result := f_ListLevel > 0;
end;

procedure TalcuPrimeHTMLWriter.pm_SetIsPrime(const Value: Boolean);
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

procedure TalcuPrimeHTMLWriter.pm_SetListLeftIndent(const Value: Integer);
begin
 f_ListIndents.Add(Value);
end;

function TalcuPrimeHTMLWriter.StyleName(StyleID: Integer; var IsSpecial: Boolean): string;
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

procedure TalcuPrimeHTMLWriter.WriteBreak(const aBreak: TddBreak);
begin
end;

procedure TalcuPrimeHTMLWriter.WriteColorTable(aDefault: Boolean = False);
begin
end;

procedure TalcuPrimeHTMLWriter.WriteDocumentEnd;
begin
   OutStringLn('</div>')
end;

procedure TalcuPrimeHTMLWriter.WriteDocumentHeader;
begin
  OutStringLn('<a name="0"></a>');
end;

procedure TalcuPrimeHTMLWriter.WriteDocumentStart;
begin
   OutStringLn('<div id="primeDocs">')
end;

procedure TalcuPrimeHTMLWriter.WriteFontTable(aDefault: Boolean = False);
begin
end;

procedure TalcuPrimeHTMLWriter.WriteHeader(aDefault: Boolean = False);
begin
end;

procedure TalcuPrimeHTMLWriter.WriteStyleTable(aDefault: Boolean = False);
begin
end;

procedure TalcuPrimeHTMLWriter.WriteTable(const Table: TddTable);
var
 i, j: Integer;
 l_Row: TddTableRow;
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
     if l_Row.TAP.CellsProps[j].VMerged or l_Row.TAP.CellsProps[j].Merged or
        l_Row.TAP.CellsProps[j].MergeFirst or l_Row.TAP.CellsProps[j].VMergeFirst then
     begin
      f_IsComplexTable:= True;
      break;
     end;
  end; // for i
  f_IsComplexTable := f_IsComplexTable and (l_EtalonRowIndex > 0);
  for i:= 0 to Pred(Table.RowCount) do
  begin
   f_IsEtalonRow:= i = l_EtalonRowIndex;
   WriteTableRow(Table[i], Table.IsSBS, i=0);
  end;
  OutStringLn('</table>')
end;

procedure TalcuPrimeHTMLWriter.WriteTableRow(const Row: TddTableRow; const aIsSBS: Boolean = False;
    const IsFirstRow: Boolean = False; const IsNested: Boolean = False);
var
  i, j: Integer;
  l_Cell: TddTableCell;
  l_CellProp: TddCellProperty;
  l_List: Tl3ObjectRefList;
  l_S: String;
begin
  l_List:= Tl3ObjectRefList.Make;
  try
   OutStringLn(' <tr>');
   for i:= 0 to Pred(Row.CellCount) do
   begin
    l_List.Clear;
    l_CellProp:= Row.TAP.CellsProps[i];
    if not l_CellProp.VMerged then
    begin
     if aIsSBS then
       AddTag(l_List, 'td', 'width="50%"')
     else
     if IsFirstRow then
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

     l_Cell:= Row.Cells[i];
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
