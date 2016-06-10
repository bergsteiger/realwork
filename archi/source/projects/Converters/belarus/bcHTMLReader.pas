unit bcHTMLReader;

interface
uses
 l3Interfaces,
 ddHTML_r,
 k2TagGen,
 ddDocumentAtom,
 ddHTMLTag;

type
 TbcHTMLReader = class(TddHTMLReader)
 private
  f_IsComment: Boolean;
  function IsStyle(const aStr: Tl3WString; const anStyleArr: array of Tl3WString): Boolean;
 protected
  procedure BeforeCloseParagraph(const anAtom: TddDocumentAtom; aTag: TddHTMLTag; var theDelete: Boolean); override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner = nil); override;
 end;


implementation
uses
 l3String,
 l3Variant,

 evdStyles,

 ddTypes,
 ddHTMLTags,
 ddTextParagraph;

const
 cs_CorComment : Tl3WString = (S:'NCPICOMMENT';    SLen:11; SCodePage:0);
 cs_ContentWord: Tl3WString = (S:'CONTENTWORD';    SLen:11; SCodePage:0);
 cs_ContentText: Tl3WString = (S:'CONTENTTEXT';    SLen:11; SCodePage:0);
 cs_Comment    : Tl3WString = (S:'COMMENT';        SLen:7;  SCodePage:0);
 cs_Article    : Tl3WString = (S:'ARTICLE';        SLen:7;  SCodePage:0);
 cs_Prinyat    : Tl3WString = (S:'PRINODOBREN';    SLen:11; SCodePage:0);
 cs_ChangeAdd  : Tl3WString = (S:'CHANGEADD';      SLen:9; SCodePage:0);

 cs_TitleList : array [1..11] of Tl3WString = (
  (S:'TITLEK';         SLen:6;  SCodePage:0),
  (S:'TITLEU';         SLen:6;  SCodePage:0),
  (S:'TITLE';          SLen:5;  SCodePage:0),
  (S:'ZAGRAZDEL';      SLen:9;  SCodePage:0),
  (S:'CHAPTER';        SLen:7;  SCodePage:0),
  (S:'PART';           SLen:4;  SCodePage:0),
  (S:'PROMULGATOR';    SLen:11; SCodePage:0),
  (S:'NAME';           SLen:4;  SCodePage:0),
  (S:'NONUMHEADER';    SLen:11; SCodePage:0),
  (S:'TITLENCPI';      SLen:9;  SCodePage:0),
  (S:'ARTICLECT';      SLen:9;  SCodePage:0)
 );

 cs_AppendixList : array [1..4] of Tl3WString = (
  (S:'APPEND1';        SLen:7;  SCodePage:0),
  (S:'APPEND';         SLen:6;  SCodePage:0),
  (S:'CAPU1';          SLen:5;  SCodePage:0),
  (S:'CAP1';           SLen:4;  SCodePage:0)
 );

{
******************************** TbcHTMLReader *********************************
}
constructor TbcHTMLReader.Create(aOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(aOwner);
 ReadURL := True;
 ApplyTextCorrections := True;
 Lite := False;
 f_IsComment := False;
end;

procedure TbcHTMLReader.BeforeCloseParagraph(const anAtom: TddDocumentAtom; aTag: TddHTMLTag; var theDelete: Boolean);
var
 l_Param: TddHTMLParam;
 l_ClassName : Tl3WString;
 l_Para: TddTextParagraph;
 l_Text: Tl3WString;
 I : Integer;
begin
 if (aTag <> nil) and anAtom.IsTextPara then
 begin
  l_Para := anAtom as TddTextParagraph;

  if aTag.HasKey(dd_paridCLASS, l_Param) then
  begin
   l_ClassName := l3Trim(aTag.Param2PCharLen(l_Param));

   {if l3Same(cs_ContentWord, l_ClassName, True) or l3Same(cs_ContentText, l_ClassName, True) then
    theDelete := True
   else}

   if l3Same(cs_CorComment, l_ClassName, True) then
   begin
    l_Text := l3Trim(l_Para.Text.AsWStr);
    if l3AllCharsInCharSet(l_Text, ['Ч']) or l3AllCharsInCharSet(l_Text, ['-']) or l3AllCharsInCharSet(l_Text, ['_']) then
     theDelete := True
    else
    begin
     if not f_IsComment then
     begin
      l_Para.PAP.Style := ev_saVersionInfo; // первый комментарий пропускаем
      f_IsComment := True;
     end
     else
      theDelete := True;  // остальные (идущие за первым) удал€ем
    end;
   end
   else
   begin
    if IsStyle(l_ClassName, cs_TitleList) then
     l_Para.PAP.Style := ev_saTxtHeader1
    else

    if IsStyle(l_ClassName, cs_AppendixList) then
    begin
     l_Para.PAP.Style := ev_saEnclosureHeader;
     l_Para.PAP.JUST := justR;
    end
    else

    if l3Same(cs_Article, l_ClassName, True) then
    begin
     if l_Para.PAP.JUST = justC then
      l_Para.PAP.Style := ev_saTxtHeader1
     else
      l_Para.PAP.Style := ev_saArticleHeader;
    end
    else

    if l3Same(cs_Prinyat, l_ClassName, True) then
     l_Para.PAP.Style := ev_saToLeft
    else

    if l3Same(cs_ChangeAdd, l_ClassName, True) then
    begin
     if not l_Para.HaveHyperlinks then
      l_Para.ClearSegments
     else
     begin
      for I := l_Para.SegmentCount-1 downto 0 do
       if not l_Para.Segments[I].IsHyperlink then
        l_Para.RemoveSegment(l_Para.Segments[I]); // удал€ем всЄ оформление, оставл€ем гиперссылки
     end;
    end
    else

    ;
    if not theDelete then
     f_IsComment := False;
   end;
  end
  else
   if not theDelete then
    f_IsComment := False;
 end;
end;

function TbcHTMLReader.IsStyle(const aStr: Tl3WString; const anStyleArr: array of Tl3WString): Boolean;
var
 I: Integer;
begin
 Result := False;
 for I := Low(anStyleArr) to High(anStyleArr) do
  if l3Same(anStyleArr[I], aStr, True) then
  begin
   Result := True;
   Break;
  end;
end;

end.
