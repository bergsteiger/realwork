unit Format5HTMLReader;

interface

uses
  ddSimpleHTMLReader, l3LongintList, l3ProtoPersistentRefList, ddHTMLParser,
  ddHTMLTags, ddHTML_r, l3ObjectRefList, k2TagGen, l3SimpleObject,
  l3ProtoObjectRefList;

type
 Tf5Edition = class(Tl3SimpleObject)

 private
  f_Deleted: Boolean;
  f_Number: Integer;
  f_Order: Tl3LongintList;
  procedure pm_SetDeleted(const Value: Boolean);
  procedure pm_SetNumber(const Value: Integer);
 protected
  procedure Cleanup; override;
 public
  constructor Create; reintroduce; override;
  property Deleted: Boolean read f_Deleted write pm_SetDeleted;
  property Number: Integer read f_Number write pm_SetNumber;
 end;


 TFormat5HTMLReader = class(TddHTMLReader)
 private
  f_CurTag: Integer;
  f_Editions: Tl3ProtoObjectRefList;
  f_ParaID: Integer;
 protected
  procedure BeforeCloseParagraph; override;
  procedure BeforeWrite; override;
  procedure Cleanup; override;
  procedure CreateParser; override;
  procedure WorkupTag(aTag: THTMLTag); override;
  procedure WorkupText(aText: THTMLText); override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner = nil); override;
 end;

 Tf5HTMLParser = class(TddHTMLParser)
 protected
  procedure FillKeywords; override;
 end;

const
 tnET_DATA     = 'ET_DATA';      tidET_DATA     = 1000;
 tnET_HISTORY  = 'ET_HISTORY';   tidET_HISTORY  = 1001;
 tnET_TEXT     = 'ET_TEXT';      tidET_TEXT     = 1002;
 tnET_EDITIONS = 'ET_EDITIONS';  tidET_EDITIONS = 1003;
 tnET_EDITION  = 'ET_EDITION';   tidET_EDITION  = 1004;
 tnIS_EDITION  = 'IS_EDITION';   tidIS_EDITION  = 1005;
 tnIS_DELETED  = 'IS_DELETED';   tidIS_DELETED  = 1006;
 tnEDIT_DATE   = 'EDIT_DATE';    tidEDIT_DATE   = 1007;
 tnSTART_DATE  = 'START_DATE';   tidSTART_DATE  = 1008;
 tnAUTHOR3     = 'AUTHOR3';      tidAUTHOR3     = 1009;
 tnORDER       = 'ORDER';        tidORDER       = 1010;
 tnID          = 'ID';           tidID          = 1011;


const
 cF5HTMLTags : array[0..11] of ThtmlTagRec =
  (
   (TagName: tnET_DATA;    TagID: tidET_DATA),
   (TagName: tnET_HISTORY; TagID: tidET_HISTORY),
   (TagName: tnET_TEXT;    TagID: tidET_TEXT),
   (TagName: tnET_EDITIONS;TagID: tidET_EDITIONS),
   (TagName: tnET_EDITION; TagID: tidET_EDITION),
   (TagName: tnIS_EDITION; TagID: tidIS_EDITION),
   (TagName: tnIS_DELETED; TagID: tidIS_DELETED),
   (TagName: tnEDIT_DATE;  TagID: tidEDIT_DATE),
   (TagName: tnSTART_DATE; TagID: tidSTART_DATE),
   (TagName: tnAUTHOR3;    TagID: tidAUTHOR3),
   (TagName: tnORDER;      TagID: tidORDER),
   (TagName: tnID;         TagID: tidID)
  );

implementation

uses
  SysUtils, l3Keywrd, ddDocumentAtom, ddTextParagraph, ddTable, EvdStyles;



constructor Tf5Edition.Create;
begin
 inherited Create;
 f_Order := Tl3LongintList.Make;
end;

procedure Tf5Edition.Cleanup;
begin
 inherited;
 FreeAndNil(f_Order);
end;

procedure Tf5Edition.pm_SetDeleted(const Value: Boolean);
begin
 f_Deleted := Value;
end;

procedure Tf5Edition.pm_SetNumber(const Value: Integer);
begin
 f_Number := Value;
end;

constructor TFormat5HTMLReader.Create(aOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(aOwner);
 f_Editions := Tl3ProtoObjectRefList.Create;
end;

procedure TFormat5HTMLReader.BeforeCloseParagraph;
begin
 if not Document.LastPara.PAP.InTable then
 begin
  Document.LastPara.ID:= f_ParaID;
  Inc(f_ParaID);
 end;
end;

procedure TFormat5HTMLReader.BeforeWrite;
var
 i, j: Integer;
 l_A, l_ANext: TddDocumentAtom;
 function lp_GetAtom(aIndex: Integer; out theNext: TddDocumentAtom): TddDocumentAtom;
 var
  k: Integer;
 begin
  result:= nil;
  // Наверное, можно начинать перебор с переданного индекса
  for k:= 0 to Document.Paragraphs.Hi do
   if Document.Paragraphs[k] is TddTextParagraph then
    if TddTextParagraph(Document.Paragraphs[k]).ID = aIndex then
    begin
     Result:= TddDocumentAtom(Document.Paragraphs[k]);
     if k < Document.Paragraphs.Hi then
      theNext:= TddDocumentAtom(Document.Paragraphs[Succ(k)])
     else
      theNext:= nil;
     break; 
    end;
 end;
begin
 // TODO -cMM: TFormat5HTMLReader.BeforeWrite default body inserted
 // вылить в соответствии с номерами абзацев, документ занулить
 i:= f_Editions.Hi;
 while (i>=0) and Tf5Edition(f_Editions[i]).Deleted do Dec(i);
 if i <> -1 then
 begin
  for j:= 0 to Tf5Edition(f_Editions[i]).f_Order.Hi do
  begin
   l_A:= lp_GetAtom(Tf5Edition(f_Editions[i]).f_Order[j], l_ANext);
   if l_A <> nil then
   begin
    l_A.Write2Generator(Generator);
    if l_ANext is TddTable then
     l_ANext.Write2Generator(Generator);
   end;
  end;
  Document.Paragraphs.Clear;
 end;
end;

procedure TFormat5HTMLReader.Cleanup;
begin
 inherited;
 FreeAndNil(f_Editions);
end;

procedure TFormat5HTMLReader.CreateParser;
var
 l_Parser: Tf5HTMLParser;
begin
 l_Parser:= Tf5HTMLParser.Create;
 try
  Parser:= l_Parser;
 finally
  FreeAndNil(l_Parser);
 end;
end;

procedure TFormat5HTMLReader.WorkupTag(aTag: THTMLTag);
var
 l_E: Tf5edition;
 j: Integer;
 l_Param: THTMLParam;
begin
 f_CurTag:= aTag.TagID;
 case aTag.TagID of
  tidET_EDITION:
   if not aTag.IsClosed then
   begin
    l_E:= Tf5Edition.Create;
    try
     f_Editions.Add(l_E);
    finally
     FreeAndNil(l_E);
    end;
   end;
  tidIS_EDITION: ;
  tidIS_DELETED: ;
  tidORDER: ;
  tidID: ;
  tidP, tidPre:
   begin
    inherited;
    for j:= 0 to Pred(aTag.ParamCount) do
    begin
     l_Param:= aTag.Params[j];
     if AnsiSameText(l_Param.Key, 'id') then
      Document.LastPara.ID:= l_Param.IntValue
     else
     if AnsiSameText(l_Param.Key, 'st') and (l_Param.IntValue = -31) then
     // Можно дополнительно переключить коодвую страницу файлера
      Document.LastPara.PAP.Style:= ev_saTxtNormalOEM;
    end;
   end;
 else
  inherited;
 end;
end;

procedure TFormat5HTMLReader.WorkupText(aText: THTMLText);
begin
 case f_CurTag of
  tidID :Tf5Edition(f_Editions.Last).f_Order.Add(StrToIntDef(aText.Line, -1));
  tidIS_DELETED: Tf5Edition(f_Editions.Last).Deleted:= aText.Line = '1';
  tidIS_EDITION: Tf5Edition(f_Editions.Last).Number:= StrToIntDef(aText.Line, 0);
  tidAuthor3: ;
  tidEDIT_DATE: ;
  tidSTART_DATE: ;
 else
  inherited
 end;
end;

procedure Tf5HTMLParser.FillKeywords;
var
 l_Keywords: Tl3Keywords;
 i: Integer;
begin
 l_Keywords:= Tl3Keywords.Create;
 try
  with l_KeyWords do
  begin
   for i:= 0 to cMaxHTMLTag do
   begin
    AddKeyword({'<'+}cHTMLTags[i].TagName, cHTMLTags[i].TagID);
    AddKeyword({'</'}'/'+cHTMLTags[i].TagName, -cHTMLTags[i].TagID);
   end;
   // Добавляем специфические теги
   for i:= 0 to 11 do
   begin
    AddKeyword({'<'+}cf5HTMLTags[i].TagName, cf5HTMLTags[i].TagID);
    AddKeyword({'</'}'/'+cf5HTMLTags[i].TagName, -cf5HTMLTags[i].TagID);
   end;
  end;
  Keywords:= l_Keywords;
 finally
  FreeAndNil(l_Keywords);
 end;
end;

end.
