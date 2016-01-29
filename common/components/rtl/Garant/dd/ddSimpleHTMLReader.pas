unit ddSimpleHTMLReader;
{ ������� ������ ������� HMTL }
{ $Id: ddSimpleHTMLReader.pas,v 1.60 2015/05/22 09:03:04 dinishev Exp $ }

// $Log: ddSimpleHTMLReader.pas,v $
// Revision 1.60  2015/05/22 09:03:04  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=484814734&focusedCommentId=600084607#comment-600084607
//
// Revision 1.59  2015/02/03 14:10:36  dinishev
// {Requestlink:522781827}. http://mdp.garant.ru/pages/viewpage.action?pageId=522781827&focusedCommentId=587164438#comment-587164438
//
// Revision 1.58  2015/01/27 10:40:08  dinishev
// {Requestlink:584178118}
//
// Revision 1.57  2015/01/26 14:31:07  dinishev
// {Requestlink:586173596}
//
// Revision 1.56  2015/01/13 12:49:15  dinishev
// {Requestlink:586173596}. ������ ����� � �������.
//
// Revision 1.55  2014/12/30 12:14:51  dinishev
// {Requestlink:570542913}. �������, ���� � ���������. �� ��� ����� ���� ����������. ��� ������������� - �����.
//
// Revision 1.54  2014/12/29 14:14:11  dinishev
// {Requestlink:585940693}. ������� �����������.
//
// Revision 1.53  2014/12/29 12:58:44  dinishev
// {Requestlink:585940693}
//
// Revision 1.52  2014/06/20 12:07:52  dinishev
// {Requestlink:543433648}
//
// Revision 1.51  2014/06/11 13:20:04  dinishev
// {Requestlink:541895041}
//
// Revision 1.50  2014/06/06 10:56:00  dinishev
// �������� AV.
//
// Revision 1.49  2014/05/27 07:53:00  dinishev
// {Requestlink:537768536}
//
// Revision 1.48  2014/03/03 10:17:30  dinishev
// {Requestlink:519774197}
//
// Revision 1.47  2014/02/18 13:34:33  lulin
// - ����������� �� ��������� ������.
//
// Revision 1.46  2014/02/04 18:07:31  lulin
// - ����������� �������.
//
// Revision 1.45  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. ������� TddCellProperty �� ������.
//
// Revision 1.44  2013/10/22 08:28:45  dinishev
// {Requestlink:494528807}. ������ �� ����������� ������.
//
// Revision 1.43  2013/10/22 07:35:44  dinishev
// {Requestlink:494528807}. ������ �� ����������� ������.
//
// Revision 1.42  2013/10/21 13:48:20  dinishev
// {Requestlink:494528807}
//
// Revision 1.41  2013/10/21 13:40:55  dinishev
// �������� ������� "�����������" �������� � Try2OpenNewPara.
//
// Revision 1.40  2013/10/21 09:46:21  dinishev
// Bug fix: ��������� ������ �������� � UTF-8. �������� ������ ������ �� ������ ����� �������. ���� ����������, ��� ��� �� ��������� ��������.
//
// Revision 1.39  2013/10/15 07:54:55  dinishev
// {Requestlink:482741433}. ��������� �������.
//
// Revision 1.38  2013/10/14 12:29:05  dinishev
// {Requestlink:485431108}
//
// Revision 1.37  2013/09/27 12:25:29  dinishev
// ����������� ����, ���������� � AV ��� ������.
//
// Revision 1.36  2013/09/26 10:22:32  dinishev
// {Requestlink:482741433}. ��������� Align, VAlign, Width, ColSpan, RowSpan, Charset, �������� HREF (��� �������), Style � Class
//
// Revision 1.35  2013/09/25 06:21:00  dinishev
// Bug fix: ������ �� ������.
//
// Revision 1.34  2013/09/24 13:16:00  dinishev
// {Requestlink:482741433}
//
// Revision 1.33  2013/09/23 12:01:33  dinishev
// Cleanup
//
// Revision 1.32  2013/09/23 11:32:49  dinishev
// ��� ���� �������� ��������.
//
// Revision 1.31  2013/09/23 11:21:27  dinishev
// �������� ��������� �������� ������.
//
// Revision 1.30  2013/09/23 11:15:53  dinishev
// Cleanup
//
// Revision 1.29  2013/09/17 11:15:41  dinishev
// {Requestlink:481806782}
//
// Revision 1.28  2013/09/17 09:08:11  dinishev
// {Requestlink:482749444}. ������� ���������. ���� ������ ������.
//
// Revision 1.27  2013/09/13 06:50:45  dinishev
// ����������������� ����������� ���������. �� ����� ��������.
//
// Revision 1.26  2013/09/12 12:54:11  dinishev
// {Requestlink:481806782}
//
// Revision 1.25  2013/09/12 12:53:23  dinishev
// ������ ����� �... ����� ������. :-)
//
// Revision 1.24  2013/09/12 12:37:46  dinishev
// �� ��������� - �������� ���.
//
// Revision 1.23  2013/08/30 07:47:17  dinishev
// Bug fix: ������������ - ����� ��������.
//
// Revision 1.22  2013/08/29 11:27:10  dinishev
// {Requestlink:480819960}
//
// Revision 1.21  2013/08/22 09:01:34  dinishev
// {Requestlink:460291228}
//
// Revision 1.20  2013/08/22 08:22:10  dinishev
// {Requestlink:460291228}. ��������� ���������.
//
// Revision 1.19  2013/08/21 13:46:46  dinishev
// {Requestlink:460291228}. �������� ���������� ���.
//
// Revision 1.18  2013/08/21 13:45:15  dinishev
// {Requestlink:460291228}
//
// Revision 1.17  2013/08/20 12:33:34  dinishev
// ����� ����� ���� �� ������� WorkupText.
//
// Revision 1.16  2013/08/16 12:13:37  dinishev
// {Requestlink:460291228}. Reformat.
//
// Revision 1.15  2013/07/25 09:53:16  dinishev
// {Requestlink:460279011}
//
// Revision 1.14  2013/06/03 08:51:47  dinishev
// Cleanup
//
// Revision 1.13  2013/04/16 09:06:05  narry
// ����������
//
// Revision 1.12  2013/04/11 16:46:29  lulin
// - ���������� ��� XE3.
//
// Revision 1.11  2011/10/13 12:02:55  narry
// ������ ��� ������ ������� � ������ ��������� ��������� ������� (290272742)
//
// Revision 1.10  2011/10/13 08:43:31  narry
// ������������ ���������
//
// Revision 1.9  2011/10/07 07:51:52  narry
// �������� ����������� �������� ����
//
// Revision 1.8  2011/10/06 11:53:20  narry
// ����������� ����� ��� ��������� StartKeywordChar
//
// Revision 1.7  2011/10/04 12:21:17  narry
// ����������� ������ HTML
//
// Revision 1.6  2011/09/01 08:05:24  narry
// 35. ��������� ������ ����� ������� (�������� �� ����� "��" � �����) (278839514)
//
// Revision 1.5  2011/08/12 07:19:53  narry
// 28. ������������ ���������� ����� ����� ��������� html (278839269)
//
// Revision 1.4  2011/07/15 09:38:07  narry
// ������ ������� ������ (274825348)
//
// Revision 1.3  2011/02/07 13:02:55  narry
// K253658756. �� ���������� ddHTML_r 2
//

interface

uses
 k2Reader,
 k2TagGen,

 l3Base,
 l3Types,
 l3SimpleObject,
 l3ObjectRefList,

 ddTypes,
 ddHTMLTag,
 ddDocument,
 ddRTFProperties,
 ddRegSeacherOwner,

 Classes,
 Graphics;

type
  TddHTMLAnalyzeEvent = procedure (var theBreakAnalyze: Boolean) of object;
  
  TddSimpleHTMLReader = class(TddRegSeacherOwner)
  private
    f_BreakAnalyze: Boolean;
    f_IsTag: Boolean;
    f_OnAnalyze: TddHTMLAnalyzeEvent;
    f_Text: AnsiString;
    f_TokenReaded: Boolean;
  private  
    procedure AddText;
    procedure ClearText(const aText: Tl3String);
    function DoHTMLEntity2Char(const anEntity: AnsiString; var aChar: AnsiChar): Boolean;
    procedure CheckTextWithUTF8;
    procedure HTMLEntity2Char(const anEntity: AnsiString; const aText: Tl3String);
    procedure Try2OpenNewPara;
    procedure WorkupKeyword;
    procedure WorkupSymbol;
    procedure ParseStyleTable(aStyleTable: AnsiString);
    function ParseStyle(const aStyle: Tl3PCharLen; IsLast: Bool): Boolean;
    procedure TranslateParam(const aStr : Tl3PCharLen; aStyle: TddStyleEntry);
    function ConvertFontSize(const aStr : Tl3PCharLen): Integer;
    function ConvertColor(const aStr : Tl3PCharLen): TColor;
    function ConvertMargin(const aStr : Tl3PCharLen): Integer;
    function ConvertJust(const aStr : Tl3PCharLen): TJust;
  protected
    f_IsPre        : Boolean;
    f_SpecText     : Boolean;
    f_IsBody       : Boolean;
    f_IsPara       : Boolean;
    f_IsHeader     : Boolean;
    f_InScript     : Boolean;
    f_IsStyle      : Boolean;
    f_CodePage     : LongInt;
    f_Document     : TddDocument;
    f_InitCodePage : Boolean;
  protected
    procedure CheckCodePage;
    function IsTextNotEmpty: Boolean;
    procedure AnalyzeProc(var theBreakAnalyze: Boolean);
    procedure CreateParser; virtual;
    procedure WorkupTag(aTag: TddHTMLTag); virtual; abstract;
    procedure OpenParagraph; virtual; abstract;
    procedure CleanUp; override;
  public
    constructor Create(aOwner: Tk2TagGeneratorOwner = nil); override;
    procedure BreakAnalyze;
    procedure Read; override;
    property IsTag: Boolean read f_IsTag write f_IsTag;
    property OnAnalyze: TddHTMLAnalyzeEvent read f_OnAnalyze write f_OnAnalyze;
  end;

implementation

uses
 StrUtils,
 SysUtils,

 JclStringConversions,

 ElStrUtils,

 l3Chars,
 l3Const,
 l3String,
 l3Parser,
 l3Interfaces,
 l3PrimString,
 l3CustomString,
 l3ObjectRefList1,
 l3ParserInterfaces,

 ddHTMLTags,
 ddHTMLParser,
 ddDocumentAtom,

 latin1,

 TypInfo;

{
***************************** TddSimpleHTMLReader ******************************
}
constructor TddSimpleHTMLReader.Create(aOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(nil);
 CreateParser;
 f_CodePage := cp_ANSI;
 f_InitCodePage := False;
 f_InScript := False;
end;

procedure TddSimpleHTMLReader.AddText;
var
 l_Str     : Tl3String;
 l_LastPara: TddDocumentAtom;
begin
 if IsTextNotEmpty then
 begin                                    
  if f_IsBody and not f_InScript then
  begin
   Try2OpenNewPara;
   Assert(f_CodePage <> CP_Unicode);
   {!!! ������������� ������������� �������� ������ }
   if f_IsPara and not f_SpecText then
   begin
    CheckCodePage;
    l_Str := Tl3String.Create;
    try
     ClearText(l_Str);
     l_LastPara := f_Document.LastPara;
     if (l_LastPara <> nil) and IsTextNotEmpty then
     begin
      if f_CodePage = cp_koi8 then // http://mdp.garant.ru/pages/viewpage.action?pageId=584178118
      begin
       l_Str._CodePage := f_CodePage;
       l_Str.CodePage := cp_ANSI;
      end; // if f_CodePage = cp_koi8 then
      f_Document.LastPara.AddText(l_Str);
     end;
    finally
     l3Free(l_Str);
    end;
   end; // if f_IsPara and not f_SpecText then
  end // IsBody
  else
   if f_IsStyle then
    ParseStyleTable(f_Text);
 end; // if f_Text <> '' then
 f_Text := '';
end;

procedure TddSimpleHTMLReader.CheckTextWithUTF8;
var
 i      : Integer;
 l_WS   : Widestring;
 l_Char : LongWord;
begin
 // ������ ������� �� ��������� unicode �������
 if TryUTF8ToUTF16(f_Text, l_WS) then
 begin
  i := 0;
  while (i < Length(l_WS)) do
  begin
   Inc(i);
   l_Char := UCS4Char(l_WS[i]);
   // ������� ������
   if (l_Char = 8226) then
    Delete(l_WS, i, 1)
   // ������ �� �������� ������
   else
    if (l_Char = 61623) then
    begin
     Delete(l_WS, i, 1);
     Insert('&middot;', l_WS, i);
     Inc(i, Length('&middot;'));
    end
    // �������� �� ������
    else
     if (l_Char > 60000) then
      l_WS[i] := #32
    // ������ ��������
    (*else
     case l_Char of
      8211: l_WS[i] := '-'; // count: 58133
      8470: l_WS[i] := '�'; // count: 15808
      9679: l_WS[i] := '?'; // count: 4462
      8212: l_WS[i] := '-'; // count: 1283
      9472: l_WS[i] := '-'; // count: 449
      8221: l_WS[i] := '"'; // count: 324
      8220: l_WS[i] := '"'; // count: 315
      8230: l_WS[i] := ':'; // count: 320
    end; // case l_Char of*)
   end;
   f_Text := Utf8ToAnsi(UTF8Encode(l_WS));
 end; // if TryUTF8ToUTF16(f_Text, l_WS) then  
end;

function TddSimpleHTMLReader.DoHTMLEntity2Char(const anEntity: AnsiString; var aChar: AnsiChar): Boolean;
begin
 Result := False;
 if anEntity = '&times;' then
 begin
  Result := True;
  aChar := cc_Null;
 end; // if anEntity = '&times;' then
end;

procedure TddSimpleHTMLReader.HTMLEntity2Char(const anEntity: AnsiString; const aText: Tl3String);
var
 l_Code  : Integer;
 l_Char  : AnsiChar;
 l_Entity: AnsiString;

 procedure lp_CheckEntity;
 var
  l_ID    : Integer;
  l_WChar : WideChar;
  l_PWChar: PWideChar;
  l_EnLen : Integer;
 begin
  l_EnLen := Length(l_Entity);
  Delete(l_Entity, l_EnLen, 1); //delete the ;
  Delete(l_Entity, 1, 2); // delete the &#
  if Uppercase(l_Entity[1]) = 'X' then
   l_Entity[1] := '$'; // it's hex (but not supported!!!)
  Val(l_Entity, l_ID, l_Code);
  if (l_Code = 0) then
  begin
   l_WChar := WideChar(l_ID);
   l_PWChar := @l_WChar;
   aText.Append(l3PCharLen(l_PWChar, 1));
  end; // if (l_Code = 0) then
 end;

var
 i       : Integer;
 l_EnLen : Integer;
 l_CharID: Integer;
begin
 l_Code := Ord(cc_HardSpace);
 l_EnLen := Length(anEntity);
 // charset encoded entity
 if (l_EnLen > 2) and (anEntity[2] = '#') then
 begin
  l_Entity := anEntity;
  lp_CheckEntity;
 end // if (l_EnLen > 2) and (Entity[2] = '#') then
 else
  if DoHTMLEntity2Char(anEntity, l_Char) then
  begin
   if l_Char <> cc_Null then
    aText.Append(l_Char, 1, CP_ANSI);
  end // if DoHTMLEntity2Char(anEntity, Result) then
  else
  begin
   l_Entity := anEntity;
   l_Entity[l_EnLen] := cc_SemiColon;
   for i := 1 to cnEntityCount do
    if l_Entity = carEntities[i].rName then
    begin
     l_CharID := carEntities[i].rCharID;
     if l_CharID <= cnIsoCharMaxID then
     begin
      l_Char := IsoCharSet[l_CharID];
      aText.Append(l_Char, 1, CP_WesternWin);
     end; // if l_CharID <= cnIsoCharMaxID then
     Break;
    end; // if Entity = Entities[j,1] then
  end;
end;

procedure TddSimpleHTMLReader.ClearText(const aText: Tl3String);
var
 l_Pos     : Integer;
 l_Len     : Integer;
 l_Char    : AnsiChar;
 l_Code    : Integer;
 l_Entity  : AnsiString;
 l_EnStart : Integer;
 l_CodePage: Integer;
begin
 if f_CodePage = cp_UTF8 then
  CheckTextWithUTF8;
 l_Pos := 1;
 l_CodePage := CP_ANSI;
 l_Len := Length(f_Text);
 while l_Pos <= l_Len do
 begin
  l_Char := f_Text[l_Pos];
  case l_Char of
   cc_Tab: aText.Append(cc_HardSpace, 1, l_CodePage);
   cc_HardEnter: begin
    Inc(l_Pos);
    if (l_Pos > l_Len) or (f_Text[l_Pos] <> cc_SoftEnter) then
     Dec(l_Pos);
    aText.Append(cc_HardSpace, 1, l_CodePage);
   end;
   cc_Ampersand: begin
    if l_Len > 1 then // http://mdp.garant.ru/pages/viewpage.action?pageId=585940693
    begin
     l_EnStart := l_Pos;
     while (f_Text[l_Pos] <> cc_SemiColon) and (f_Text[l_Pos] <> cc_HardSpace) do
     begin
      Inc(l_Pos);
      if l_Pos > l_Len then
      begin
       Dec(l_Pos);
       Break;
      end; // if l_Pos > l_Len then
     end; // while (l_Char <> cc_SemiColon) or (l_Char <> cc_HardSpace) do
     l_Entity := Copy(f_Text, l_EnStart, l_Pos - l_EnStart + 1);
     HTMLEntity2Char(l_Entity, aText);
    end
    else
     if l_Char <> cc_Null then
      aText.Append(l_Char, 1, l_CodePage);
   end;
   else
    if l_Char <> cc_Null then
     aText.Append(l_Char, 1, l_CodePage);
  end; // case l_Char of
  Inc(l_Pos);
  if l3IsWhiteSpace(l_Char) then
   while (l_Pos <= l_Len) and l3IsWhiteSpace(f_Text[l_Pos]) do
    Inc(l_Pos);
 end; // while l_Pos <= l_Len do
end;

procedure TddSimpleHTMLReader.AnalyzeProc(var theBreakAnalyze: Boolean);
begin
 if Assigned(f_OnAnalyze) then f_OnAnalyze(theBreakAnalyze);
end;

procedure TddSimpleHTMLReader.BreakAnalyze;
begin
 f_BreakAnalyze:= True;
end;

procedure TddSimpleHTMLReader.CreateParser;
var
 l_Parser: TddHTMLParser;
begin
 l_Parser:= TddHTMLParser.Create;
 try
  Parser:= l_Parser;
 finally
  FreeAndNil(l_Parser);
 end;
end;

procedure TddSimpleHTMLReader.Read;
begin
 f_BreakAnalyze:= False;
 f_IsPre:= False;
 with Parser do
 begin
  f_TokenReaded:= False;
  while (not Parser.Filer.EOF) and (not f_BreakAnalyze) do
  begin
   if not f_TokenReaded then
    NextTokenSP
   else
    f_TokenReaded:= False;
   if TokenType = l3_ttKeyword then
    WorkupKeyword
   else
   if TokenType in [l3_ttSingleChar, l3_ttSymbol] then
    WorkupSymbol;
  end;
 end;
end;

procedure TddSimpleHTMLReader.WorkupKeyword;
var
 l_TagID        : Integer;
 l_Count        : Integer;
 l_Params       : AnsiString;
 l_NewTag       : TddHTMLTag;
 l_TempKey      : ShortString;
 l_IsParcingTag : Boolean;
begin
 AddText;
 // ����� ������ ��������� ����
 l_Params := '';
 l_TagID:= Parser.Keyword.StringID;
 l_IsParcingTag := l_TagID <> cUnknownKeyword;
 if l_IsParcingTag then
  if Abs(l_TagID) = tidH then
   l_TempKey := Parser.Keyword.AsString
  else
   if Abs(l_TagID) = tidPre then
    f_IsPre := l_TagID > 0;
 Parser.WhiteSpace := l3_DefaultParserWhiteSpace - [#13, #10, #32];
 Parser.WordChars  := l3_DefaultParserWordChars + cc_ANSIRussian + cc_Digits + [#13,#10] + ['[',']'] + [cc_Dot, cc_PercentSign];
 Parser.CheckKeyWords := False;
 if l_IsParcingTag then
  l_NewTag := TddHTMLTag.Create(l_TagID)
 else
  l_NewTag := nil;
 try
  try
   l_Count := 1;
   Parser.NextTokenSP;
   while (l_Count > 0) and (Parser.TokenType <> l3_ttEOF) do
   begin
    if (Parser.TokenType = l3_ttSingleChar) then
    begin
     if (Parser.TokenChar = '>') then
      Dec(l_Count)
     else
     if (Parser.TokenChar = '<') then
      Inc(l_Count)
     else
      if l_IsParcingTag then
      begin
       if (Abs(l_TagID) = tidH) and (Parser.TokenChar in cc_Digits) then
       begin
        l_TagID := Parser.Keywords.KeywordByName[l3CStr(l_TempKey + Parser.TokenChar)].StringID;
        Continue;
       end; // if (Abs(l_TagID) = tidH) and (Parser.TokenChar in cc_Digits) then
       if l_IsParcingTag then
        l_NewTag.AddChar(Parser.TokenChar, HREFSearcher);
      end; // if l_IsParcingTag then
    end; // if (Parser.TokenType = l3_ttSingleChar) then
    if l_Count > 0 then
    begin
     if l_IsParcingTag then
      if Parser.TokenType = l3_ttEOL then
       l_Params := l_Params + cc_EOL
      else
       l_Params := l_Params + Parser.TokenString;
     if l_IsParcingTag and (Parser.TokenType <> l3_ttSingleChar) then
      l_NewTag.AddString(Parser.TokenLongString, HREFSearcher);
     Parser.NextTokenSP;
    end; // l_Count > 0
   end; // while (l_Count > 0) and (Parser.TokenType <> l3_ttEOF) do
  finally
   Parser.WhiteSpace := htmlWhiteSpace;
   Parser.WordChars := htmlWordChars;
   Parser.CheckKeyWords := True;
  end;
  if l_IsParcingTag then
   WorkupTag(l_NewTag);
 finally
  FreeAndNil(l_NewTag);
 end;
end;

procedure TddSimpleHTMLReader.WorkupSymbol;
begin
 f_Text := f_Text + Parser.TokenString;
end;

function TddSimpleHTMLReader.IsTextNotEmpty: Boolean;
begin
 Result := f_Text <> '';
end;

procedure TddSimpleHTMLReader.Try2OpenNewPara;

 function lp_InTable: Boolean;
 begin
  Result := ((f_Document.Table <> nil) and (f_Document.Table.LastRow.CellCount > 0));
 end;

 function lp_InText: Boolean;
 begin
  Result := (f_Document.Table = nil) and (not f_SpecText or f_IsHeader);
 end;

 function lp_InHeadText: Boolean;
 var
  l_LastPara: TddDocumentAtom;
 begin
  Result := (f_Document.Table = nil) and (not f_SpecText and f_IsHeader);
  if Result then
  begin
   l_LastPara := f_Document.LastPara;
   if (l_LastPara <> nil) and (l_LastPara.Empty or l_LastPara.HasSoftEnter) then
    Result := False;
  end;
 end;

 function lp_NotEmpty: Boolean;
 begin
  Result := IsTextNotEmpty and (f_Text <> cc_HardSpace);
 end;

begin
 if f_IsPara and lp_InHeadText and lp_NotEmpty then
  OpenParagraph
 else
  if not f_IsPara and lp_NotEmpty and (lp_InText or lp_InTable) then
   OpenParagraph
end;

procedure TddSimpleHTMLReader.ParseStyleTable(aStyleTable: AnsiString);
begin
  (* ������� ������ �������� � ��������� ����
    ���_�����{������_�����}..
    ������_����� - ��������:��������;..
   *)
  if aStyleTable <> '' then
   l3ParseWordsEx(l3PCharLen(aStyleTable), ParseStyle, ['}']);
end;

function TddSimpleHTMLReader.ParseStyle(const aStyle: Tl3PCharLen; IsLast: Bool):
    Boolean;
var
 l_StyleEntry: TddStyleEntry;

 function l_TranslateParam(const aStr : Tl3PCharLen;
                           IsLast     : Bool): Bool;
 begin//l_TranslateParam
  Result := true;
  TranslateParam(aStr, l_StyleEntry);
 end;//l_TranslateParam

var
 l_Style     : AnsiString;
 l_StyleName : AnsiString;
begin
 Result := true;
 l_Style := Trim(l3PCharLen2String(aStyle));
 if (l_Style <> '') and (l_Style <> Parser.CloseComment) then
 begin
  l_StyleName := Trim(Copy(l_Style, 1, Pred(Pos('{', l_Style))));
  l_StyleEntry := f_Document.StyleByName(l_StyleName).Use;

  if l_StyleEntry = nil then
  begin
   l_StyleEntry := TddStyleEntry.Create;
   l_StyleEntry.AsString:= l_StyleName;
   if l_StyleEntry.AsWStr.S[0] = '.' then
    (l_StyleEntry As Tl3CustomString).Delete(0, 1);
  end
  else
   l_StyleEntry.Clear;
  try
   Delete(l_Style, 1, Pos('{', l_Style));
   l3ParseWordsExF(l3PCharLen(l_Style), l3L2WA(@l_TranslateParam), [';']);
   f_Document.AddStyle(l_StyleEntry);
  finally
   l3Free(l_StyleEntry);
  end;//try.finally
 end; 
end;

procedure TddSimpleHTMLReader.TranslateParam(const aStr : Tl3PCharLen; aStyle: TddStyleEntry);

 procedure lp_GetFirstPos(var anIndex: Integer);
 begin
  while aStr.S[anIndex] = cc_HardSpace do
   Inc(anIndex);
 end;

var
 l_Start     : Integer;
 l_SepPos    : Integer;
 l_Margin    : Integer;
 l_ParamName : Tl3PCharLen;
 l_ParamValue: Tl3PCharLen;
begin
   {��������:��������;}
  l_SepPos := ev_lpCharIndex(':', aStr);
  l_Start := 0;
  lp_GetFirstPos(l_Start);
  l_ParamName := l3PCharLenPart(aStr.S, l_Start, l_SepPos, aStr.SCodePage);
  Inc(l_SepPos);
  lp_GetFirstPos(l_SepPos);
  l_ParamValue := l3PCharLenPart(aStr.S, l_SepPos, aStr.SLen, aStr.SCodePage);
  if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssFontSize], l3_siCaseUnsensitive) = 0 then
   aStyle.CHP.FontSize := ConvertFontSize(l_ParamValue)
  else
  if l3Compare(l_ParamName, carCSSParamStrArray[dd_csTextAlign], l3_siCaseUnsensitive) = 0 then
   aStyle.PAP.JUST := ConvertJust(l_ParamValue)
  else
  if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssFontFamily], l3_siCaseUnsensitive) = 0 then
   (*
   font-family
   Value: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
   Initial: UA specific
   Applies to: all elements
   Inherited: yes
   Percentage values: N/A
   *)
  begin
   aStyle.CHP.FontNumber := f_Document.AddFont(l3PCharLen2String(l_ParamValue));
   aStyle.CHP.FontName := l3PCharLen2String(l_ParamValue);
  end
  else
  if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssFontWeight], l3_siCaseUnsensitive) = 0 then
   (*
   font-weight
   Value: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
   Initial: normal
   Applies to: all elements
   Inherited: yes
   Percentage values: N/A
   *)
  begin
   aStyle.CHP.Bold := l3Compare(l_ParamValue, casCSSNotBold) <> 0;
  end
  else
  if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssFontStyle], l3_siCaseUnsensitive) = 0 then
   (*
   font-style
   Value: normal | italic | oblique
   Initial: normal
   Applies to: all elements
   Inherited: yes
   Percentage values: N/A
   *)
   aStyle.CHP.Italic := l3Compare(l_ParamValue, casCSSNotBold) <> 0
  else
  if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssColor], l3_siCaseUnsensitive) = 0 then
   (*
   color
   Value: <color>
   Initial: UA specific
   Applies to: all elements
   Inherited: yes
   Percentage values: N/A
   *)
   aStyle.CHP.FColor := ConvertColor(l_ParamValue)
  else
  if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssBackgroundColor], l3_siCaseUnsensitive) = 0 then
   (*
   background-color
   Value: <color> | transparent
   Initial: transparent
   Applies to: all elements
   Inherited: no
   Percentage values: N/A
   *)
   aStyle.CHP.BColor := ConvertColor(l_ParamValue)
  (*
  text-decoration
  Value: none | [ underline || overline || line-through || blink ]
  Initial: none
  Applies to: all elements
  Inherited: no, but see clarification below
  Percentage values: N/A
  *)
  else
  if l3Pos(l_ParamName, carCSSParamStrArray[dd_cssMargin]) <> l3NotFound then
   (*
   margin-left, margin-right, margin-top, margin-bottom, margin
   Value: [ <length> | <percentage> | auto ]{1,4} (for 'margin' property)
   Initial: 0
   Applies to: all elements
   Inherited: no
   Percentage values: refer to parent's width
   *)
  begin
   l_Margin := ConvertMargin(l_ParamValue);
   if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssMarginLeft], l3_siCaseUnsensitive) = 0 then
    aStyle.PAP.xaLeft := l_Margin
   else
   if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssMarginRight], l3_siCaseUnsensitive) = 0 then
    aStyle.PAP.xaRight := l_Margin
   else
   if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssMarginTop], l3_siCaseUnsensitive) = 0 then
    aStyle.PAP.Before := l_Margin
   else
   if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssMarginBottom], l3_siCaseUnsensitive) = 0 then
    aStyle.PAP.After := l_Margin
   else
   if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssMargin], l3_siCaseUnsensitive) = 0 then
   begin
    aStyle.PAP.xaLeft := l_Margin;
    aStyle.PAP.xaRight := l_Margin;
    aStyle.PAP.Before := l_Margin;
    aStyle.PAP.After := l_Margin;
   end;
  end;
end;

function TddSimpleHTMLReader.ConvertFontSize(const aStr : Tl3PCharLen): Integer;
var
 l_TrimPos: Integer;
 l_TimeStr: Tl3PCharLen;
begin
  (*
  font-size
  Value: <absolute-size> | <relative-size> | <length> | <percentage>
  Initial: medium
  Applies to: all elements
  Inherited: yes
  Percentage values: relative to parent element's font size
  *)
  Result := 10;
  if l3Ends(carCSSValueTypeArray[css_vtPoint], aStr, True) then
  begin
   l_TrimPos := l3CharSetPresentEx(aStr.S, aStr.SLen, cc_WhiteSpaceExt, aStr.SCodePage);
   if l_TrimPos = -1 then
    l_TrimPos := l_TimeStr.SLen - carCSSValueTypeArray[css_vtPoint].SLen;
   l_TimeStr := aStr;
   l_TimeStr.SLen := l_TrimPos;
   Result := 2 * l3StrToIntDef(l_TimeStr, Result);
  end; // if l3Ends(casCSSPt, aStr, True) then
end;

function TddSimpleHTMLReader.ConvertColor(const aStr : Tl3PCharLen): TColor;
const
 csIgnoreInColor: TCharSet = ['!'] + cc_WhiteSpaceExt;
var
 l_TimeStr: Tl3PCharLen;
 l_TrimPos: Integer;
begin
 if aStr.S[0] = '#' then
 begin
  l_TimeStr := aStr;
  l_TimeStr.S[0] := '$';
  l_TrimPos := l3CharSetPresentEx(aStr.S, aStr.SLen, csIgnoreInColor, aStr.SCodePage);
  if l_TrimPos > -1 then
   l_TimeStr.SLen := l_TrimPos;
  Result := StringToColor(l3PCharLen2String(l_TimeStr));
 end // if aStr.S[0] = '#' then
 else
  Result := clDefault;
end;

function TddSimpleHTMLReader.ConvertMargin(const aStr : Tl3PCharLen): Integer;
var
 l_SepPos : Integer;
 l_TimeStr: Tl3PCharLen;
begin
 if l3Ends(carCSSValueTypeArray[css_vtPixel], aStr, True) then
 begin
  l_TimeStr := aStr;
  l_SepPos := ev_lpCharIndex(cc_HardSpace, aStr);
  if l_SepPos > 0 then
   l_TimeStr.SLen := l_SepPos;
  Dec(l_TimeStr.SLen, carCSSValueTypeArray[css_vtPixel].SLen);
  Result := l3StrToIntDef(l_TimeStr, propUndefined);
 end // if l3Ends(casCSSPx, aStr) then
 else
  Result := propUndefined; 
end;

procedure TddSimpleHTMLReader.CleanUp;
begin
 f_InitCodePage := False;
 f_CodePage := cp_ANSI;
 inherited;
end;

procedure TddSimpleHTMLReader.CheckCodePage;
var
 l_Len: Integer;
begin
 if not f_InitCodePage and not IsEmptyStr(f_Text, cc_WhiteSpaceExt) then
 begin
  l_Len := Length(f_Text);
  if IsLegalUTF8Sequence(f_Text, l_Len) then
   f_CodePage := cp_UTF8
  else
   f_CodePage := l3AnalizeCodePageBuf(PAnsiChar(f_Text), l_Len);
  f_InitCodePage := True;
 end; // if not f_InitCodePage then
end;

function TddSimpleHTMLReader.ConvertJust(const aStr: Tl3PCharLen): TJust;
var
 i: TJust;
begin
 Result := justL;
 for i := Low(carHTMLAign) to High(carHTMLAign) do
  if l3Compare(carHTMLAign[i], aStr, l3_siCaseUnsensitive) = 0 then
  begin
   Result := i;
   Break;
  end;
end;

end.
