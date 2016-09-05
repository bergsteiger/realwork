unit ddHTMLParser;
{* Разборщик HTML на теги }

{ $Id: ddHTMLParser.pas,v 1.22 2016/07/14 12:06:45 dinishev Exp $ }

// $Log: ddHTMLParser.pas,v $
// Revision 1.22  2016/07/14 12:06:45  dinishev
// {Requestlink:627006470}
//
// Revision 1.20  2016/07/14 10:30:50  dinishev
// Reformat
//
// Revision 1.19  2016/04/11 12:25:29  dinishev
// {Requestlink:621258431}
//
// Revision 1.18  2016/01/26 15:01:22  dinishev
// Bug fix: падали с Assert'ом.
//
// Revision 1.17  2015/12/03 08:54:23  dinishev
// {Requestlink:609139066}
//
// Revision 1.16  2015/02/03 14:10:36  dinishev
// {Requestlink:522781827}. http://mdp.garant.ru/pages/viewpage.action?pageId=522781827&focusedCommentId=587164438#comment-587164438
//
// Revision 1.15  2015/01/29 13:37:01  dinishev
// {Requestlink:522781827}
//
// Revision 1.14  2014/02/04 18:06:49  lulin
// - рефакторинг парсера.
//
// Revision 1.13  2013/09/13 06:49:02  dinishev
// Cleanup
//
// Revision 1.12  2013/06/06 11:03:17  dinishev
// Фактичски правки для {Requestlink:459284359}
//
// Revision 1.11  2013/06/03 13:21:49  dinishev
// {Requestlink:459284359}. Считаем <!doctype... > однострочным комментарием, т.к. все равно его не анализируем.
//
// Revision 1.10  2013/04/16 09:07:28  narry
// Обновление
//
// Revision 1.9  2013/04/05 12:04:29  lulin
// - портируем.
//
// Revision 1.8  2012/02/20 19:11:18  lulin
// - первый шаг к использованию родных стереотипов с модели.
//
// Revision 1.7  2012/02/20 16:14:31  lulin
// - более правильная сигнатура метода.
//
// Revision 1.6  2012/02/17 07:39:24  narry
// Обработка ссылок на гарантовские документы в html (288786476)
//
// Revision 1.5  2011/10/07 07:51:52  narry
// Поддержа неизвестных ключевых слов
//
// Revision 1.4  2011/10/06 12:36:05  narry
// Забыли раскомментировать присвоение StartKeywordChar
//
// Revision 1.3  2011/10/06 11:53:20  narry
// Виртуальный метод для обработки StartKeywordChar
//
// Revision 1.2  2011/10/05 15:13:09  lulin
// - откатываем изменения Гарри.
//
// Revision 1.1  2011/10/04 12:21:18  narry
// Рефакторинг чтения HTML
//


interface

uses
  l3Parser, l3Keywrd, l3Base,

  l3Filer
  ;

type
 TddIgnoreComment = (dd_icNone, dd_icHTML, dd_icAll);
 
const
 csIgnoreHTML = [dd_icHTML, dd_icAll];

type
 TddHTMLParser = class(Tl3CustomParser)
 private
  f_KeywordStartChar: AnsiChar;
  f_IgnoreHTMLComment: TddIgnoreComment;
  f_UnknownKeyword: Tl3KeyWord;
  f_PrevSourceLine: Integer;
 protected
  function IsCommentBracket(anOpen: Boolean): Boolean; override;
    {* - чтение комментария из нескольких символов. }
  procedure CheckKeyWord; override;
  function CheckSingleChar(aChar: AnsiChar; aString: Tl3String; aNTF: Tl3NextTokenFlags): Tl3TokenType; override;
    {-}
  procedure Cleanup; override;
  procedure FillKeywords; virtual;
  function CheckOherComment(aChar: AnsiChar; anOpen: Boolean): Boolean; override;
    {-}
 public
    {public methods}
  constructor Create;
  property IgnoreHTMLComment: TddIgnoreComment read f_IgnoreHTMLComment write f_IgnoreHTMLComment;
  property KeywordStartChar: AnsiChar read f_KeywordStartChar write
      f_KeywordStartChar;
  property PrevSourceLine: Integer read f_PrevSourceLine write f_PrevSourceLine;
 end;

 RddHTMLParser = class of TddHTMLParser;

const
 cUnknownKeyword = MaxInt;

implementation

uses
  SysUtils, ddHTMLTags, l3Types, l3Chars;

const
 casCSSComment: array [Boolean] of AnsiString = ('*/', '/*');

{ start class TddHTMLParser }

constructor TddHTMLParser.Create;
  {override;}
  {-}
begin
 inherited Create;
 LineComment := ''; 
 OpenComment := '<!--';
 CloseComment := '-->';
 WhiteSpace := htmlWhiteSpace;
 WordChars := htmlWordChars;

 CheckFloat := False;
 CheckInt := False;
 CheckHex := False;
 AddDigits2WordChars := True;
 KeywordStartChar:= '<';
 FillKeywords;
 f_UnknownKeyword := Tl3KeyWord.Create('unknown', cUnknownKeyword);
 f_PrevSourceLine := SourceLine;
 f_IgnoreHTMLComment := dd_icNone;
end;

procedure TddHTMLParser.CheckKeyWord;
  {-}
begin
 if (TokenType = l3_ttSymbol) OR
    ((TokenType = l3_ttDoubleQuotedString) AND
     (cc_DoubleQuote in WordChars)) then
 begin
  if (KeyWords <> nil) then
  begin
   KeyWord := KeyWords.KeyWordByName[l3CStr(TokenLongString)] As Tl3KeyWord;
   if (KeyWord <> nil) or (KeywordStartChar <> #0) then
   begin
    f_TokenType := l3_ttKeyWord;
    if (Keyword = nil) then // неизвестное ключевое слово
     Keyword:= f_UnknownKeyword;
   end;  
  end;//KW <> nil
 end;//TokenType = l3_ttSymbol
end;

function TddHTMLParser.CheckSingleChar(aChar: AnsiChar; aString: Tl3String; aNTF: Tl3NextTokenFlags): Tl3TokenType;
var
 l_C: AnsiChar;
 l_EnableKeyword: Boolean;
begin//CheckSingleChar
 l_EnableKeyword := KeywordStartChar = #0;
 l_C := aChar;
 if (l_C in WordChars) then
 begin
  if not CheckKeywords or (CheckKeywords and (l_C <> KeywordStartChar)) then
   aString.Append(l_C, 1, Filer.CodePage)
  else
  if l_C = KeywordStartChar then
   l_EnableKeyword := True;
  while not Filer.EOF do
  begin
   l_C := Filer.GetC.rAC;
   if CheckKeywords and (l_C = KeywordStartChar) then
   begin
    Filer.UngetC;
    Break;
   end
   else
    if (l_C in WordChars) then
     aString.Append(l_C, 1, Filer.CodePage)
    else
    if AddDigits2WordChars AND (l_C in cc_Digits) then
     aString.Append(l_C, 1, Filer.CodePage)
    else
    begin
     Filer.UngetC;
     Break;
    end;//AddDigits2WordChars AND (l_C in cc_Digits)
  end;//while true
  Result := l3_ttSymbol;
  f_TokenType := Result;
  if CheckKeyWords and l_EnableKeyword then
  begin
   CheckKeyWord;
   Result := f_TokenType;
  end;//CheckKeyWords
 end//l_C in Word Chars
 else
 begin
  aString.AsChar := l_C;
  Result := l3_ttSingleChar;
 end;//l_C in Word Chars
end;//CheckSingleChar

procedure TddHTMLParser.Cleanup;
begin
 inherited;
 FreeAndNil(f_UnknownKeyword);
 f_IgnoreHTMLComment := dd_icNone;
end;

procedure TddHTMLParser.FillKeywords;
var
 i          : Integer;
 l_Keywords : Tl3Keywords;
begin
 l_Keywords := Tl3Keywords.Create;
 try
  with l_KeyWords do
   for i := 0 to cMaxHTMLTag do
   begin
    AddKeyword(cHTMLTags[i].TagName, cHTMLTags[i].TagID);
    if cHTMLTags[i].TagID = cnSingleTag then
     AddKeyword(cHTMLTags[i].TagName + '/', -cHTMLTags[i].TagID)
    else
     AddKeyword('/' + cHTMLTags[i].TagName, -cHTMLTags[i].TagID);
   end;
  Keywords := l_Keywords;
 finally
  FreeAndNil(l_Keywords);
 end;
end;

function TddHTMLParser.IsCommentBracket(anOpen: Boolean): Boolean;
var
 i       : Integer;
 l_Char  : AnsiChar;
 l_Count : Integer;
begin
 Result := False;
 if Filer.EOF then Exit;
 // Вычитываем весь комментарий, чтобы его ошметки при дальшейнем парсинге не мешались!
 if anOpen then
  l_Count := Length(OpenComment)
 else
  l_Count := Length(CloseComment);
 for i := 2 to l_Count do
 begin
  l_Char := Filer.GetC.rAC;
  if anOpen then
   Result := l_Char = OpenComment[i]
  else
   Result := l_Char = CloseComment[i];
  if not Result then Break;
 end; // for i := 2 to l_Count do
 if (f_IgnoreHTMLComment in csIgnoreHTML) and Result then
 begin
  l_Char := Filer.GetC.rAC;
  Result := False;
 end // if f_IgnoreHTMLComment and Result then
 else
  if not Result then
   Filer.UngetChars(i - 1);
end;

function TddHTMLParser.CheckOherComment(aChar: AnsiChar;
  anOpen: Boolean): Boolean;
var
 l_Char : AnsiChar;
begin
 Result := inherited CheckOherComment(aChar, anOpen);
 if not Result then
  if (aChar = casCSSComment[anOpen][1]) then
  begin
   l_Char := Filer.GetC.rAC;
   Result := l_Char = casCSSComment[anOpen][2];
   if (f_IgnoreHTMLComment = dd_icAll) and Result then
    Result := False;
   if not Result then
    Filer.UngetC;
  end; // if (aChar = casCSSComment[anOpen][1]) then
end;

end.
