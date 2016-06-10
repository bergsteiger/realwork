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
    procedure pm_SetListLeftIndent(const Value: Integer);
  protected
    procedure AnnoNameFound(aDocID: Integer; const aName: AnsiString);
    procedure Cleanup; override;
    procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
    procedure WriteBreak(const aBreak: TddBreak); override;
    procedure WriteColorTable(aDefault: Boolean = False); override;
    procedure WriteDocumentEnd; override;
    procedure WriteDocumentHeader; override;
    procedure WriteDocumentStart; override;
    procedure WriteFontTable(aDefault: Boolean = False); override;
    procedure WriteHeader(aDefault: Boolean = False); override;
    procedure WriteStyleTable(aDefault: Boolean = False); override;
  public
    constructor Create;
    reintroduce;
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

procedure TddPrimeHTMLWriter.pm_SetListLeftIndent(const Value: Integer);
begin
 f_ListIndents.Add(Value);
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

end.
