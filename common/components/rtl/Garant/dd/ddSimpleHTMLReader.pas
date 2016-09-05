unit ddSimpleHTMLReader;
{ Базовый предок читалки HMTL }
{ $Id: ddSimpleHTMLReader.pas,v 1.83 2016/08/15 12:04:28 dinishev Exp $ }

// $Log: ddSimpleHTMLReader.pas,v $
// Revision 1.83  2016/08/15 12:04:28  dinishev
// {Requestlink:628097544}
//
// Revision 1.82  2016/08/15 10:55:49  dinishev
// Reformat
//
// Revision 1.81  2016/06/22 10:57:19  dinishev
// {Requestlink:624853474}
//
// Revision 1.80  2016/06/21 11:05:10  dinishev
// http://mdp.garant.ru/pages/viewpage.action?pageId=624692225&focusedCommentId=624709697#comment-624709697
//
// Revision 1.79  2016/06/17 11:17:59  dinishev
// {Requestlink:624709249}. Тест.
//
// Revision 1.78  2016/06/16 10:22:53  dinishev
// {Requestlink:624692225}
//
// Revision 1.77  2016/06/15 11:37:52  dinishev
// Remove complier warnings.
//
// Revision 1.76  2016/02/12 11:42:59  dinishev
// {Requestlink:617316346}
//
// Revision 1.75  2016/02/11 12:13:08  dinishev
// {Requestlink:617312775}
//
// Revision 1.74  2016/02/10 06:48:44  dinishev
// Reformat.
//
// Revision 1.73  2016/01/29 06:32:17  dinishev
// Bug fix: подразнес чтение UTF-8 + AV при чтении HTML.
//
// Revision 1.72  2016/01/28 07:51:41  dinishev
// Cleanup
//
// Revision 1.71  2016/01/28 07:01:04  dinishev
// Более корректное вырезание &amp;
//
// Revision 1.70  2016/01/28 06:21:29  dinishev
// Вырезаем &amp; из URL. Пока наколенное решение.
//
// Revision 1.69  2016/01/27 13:47:10  dinishev
// Разборки с отъехавшими HTML-тестами после правок.
//
// Revision 1.68  2016/01/26 10:50:43  dinishev
// Лишний вызов.
//
// Revision 1.67  2016/01/25 14:23:00  dinishev
// {Requestlink:616227557}
//
// Revision 1.66  2016/01/21 05:50:44  dinishev
// {Requestlink:615706665}. Рамки из стилей.
//
// Revision 1.65  2016/01/19 07:50:35  dinishev
// Cleanup
//
// Revision 1.64  2016/01/15 12:02:14  dinishev
// Не добавил ссылку на паметр.
//
// Revision 1.63  2016/01/15 11:51:58  dinishev
// {Requestlink:615706665}. Не падаем из-за всякого мусора в стилях.
//
// Revision 1.62  2015/12/07 09:51:45  dinishev
// {Requestlink:612969234}
//
// Revision 1.61  2015/12/03 08:54:23  dinishev
// {Requestlink:609139066}
//
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
// {Requestlink:586173596}. Лишняя точка с запятой.
//
// Revision 1.55  2014/12/30 12:14:51  dinishev
// {Requestlink:570542913}. Залечил, хотя и кривовато. Но там много чего повылезало. Без рефайкторинга - никак.
//
// Revision 1.54  2014/12/29 14:14:11  dinishev
// {Requestlink:585940693}. Добавил комментарий.
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
// Пофиксил AV.
//
// Revision 1.49  2014/05/27 07:53:00  dinishev
// {Requestlink:537768536}
//
// Revision 1.48  2014/03/03 10:17:30  dinishev
// {Requestlink:519774197}
//
// Revision 1.47  2014/02/18 13:34:33  lulin
// - избавляемся от ненужного списка.
//
// Revision 1.46  2014/02/04 18:07:31  lulin
// - рефакторинг парсера.
//
// Revision 1.45  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. Перенес TddCellProperty на модель.
//
// Revision 1.44  2013/10/22 08:28:45  dinishev
// {Requestlink:494528807}. Правки по результатам тестов.
//
// Revision 1.43  2013/10/22 07:35:44  dinishev
// {Requestlink:494528807}. Правки по результатам тестов.
//
// Revision 1.42  2013/10/21 13:48:20  dinishev
// {Requestlink:494528807}
//
// Revision 1.41  2013/10/21 13:40:55  dinishev
// Пытаемся немного "очеловечить" проверку в Try2OpenNewPara.
//
// Revision 1.40  2013/10/21 09:46:21  dinishev
// Bug fix: отключаем замену символов в UTF-8. Заменяли символ номера на символ знака вопроса. Есть подозрение, что это не последняя проблема.
//
// Revision 1.39  2013/10/15 07:54:55  dinishev
// {Requestlink:482741433}. Финальные аккорды.
//
// Revision 1.38  2013/10/14 12:29:05  dinishev
// {Requestlink:485431108}
//
// Revision 1.37  2013/09/27 12:25:29  dinishev
// Дублирующие поля, приводящие к AV при чтении.
//
// Revision 1.36  2013/09/26 10:22:32  dinishev
// {Requestlink:482741433}. Поддержка Align, VAlign, Width, ColSpan, RowSpan, Charset, частично HREF (для Гаранта), Style и Class
//
// Revision 1.35  2013/09/25 06:21:00  dinishev
// Bug fix: падали на тестах.
//
// Revision 1.34  2013/09/24 13:16:00  dinishev
// {Requestlink:482741433}
//
// Revision 1.33  2013/09/23 12:01:33  dinishev
// Cleanup
//
// Revision 1.32  2013/09/23 11:32:49  dinishev
// Еще одно свойство вычистил.
//
// Revision 1.31  2013/09/23 11:21:27  dinishev
// Вычистил ненужного базового предка.
//
// Revision 1.30  2013/09/23 11:15:53  dinishev
// Cleanup
//
// Revision 1.29  2013/09/17 11:15:41  dinishev
// {Requestlink:481806782}
//
// Revision 1.28  2013/09/17 09:08:11  dinishev
// {Requestlink:482749444}. Откатил изменения. Буду думать дальше.
//
// Revision 1.27  2013/09/13 06:50:45  dinishev
// Экспериментальное определение кодировки. На тесте работает.
//
// Revision 1.26  2013/09/12 12:54:11  dinishev
// {Requestlink:481806782}
//
// Revision 1.25  2013/09/12 12:53:23  dinishev
// Правка своих и... чужих ошибок. :-)
//
// Revision 1.24  2013/09/12 12:37:46  dinishev
// Не удержался - причесал код.
//
// Revision 1.23  2013/08/30 07:47:17  dinishev
// Bug fix: Перестарался - тесты отъехали.
//
// Revision 1.22  2013/08/29 11:27:10  dinishev
// {Requestlink:480819960}
//
// Revision 1.21  2013/08/22 09:01:34  dinishev
// {Requestlink:460291228}
//
// Revision 1.20  2013/08/22 08:22:10  dinishev
// {Requestlink:460291228}. Небольшие переделки.
//
// Revision 1.19  2013/08/21 13:46:46  dinishev
// {Requestlink:460291228}. Вычистли устаревший код.
//
// Revision 1.18  2013/08/21 13:45:15  dinishev
// {Requestlink:460291228}
//
// Revision 1.17  2013/08/20 12:33:34  dinishev
// Вынос части кода за пределы WorkupText.
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
// Обновление
//
// Revision 1.12  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.11  2011/10/13 12:02:55  narry
// Сейчас при показе справки к списку срезаются начальные пробелы (290272742)
//
// Revision 1.10  2011/10/13 08:43:31  narry
// Накопившиеся изменения
//
// Revision 1.9  2011/10/07 07:51:52  narry
// Поддержа неизвестных ключевых слов
//
// Revision 1.8  2011/10/06 11:53:20  narry
// Виртуальный метод для обработки StartKeywordChar
//
// Revision 1.7  2011/10/04 12:21:17  narry
// Рефакторинг чтения HTML
//
// Revision 1.6  2011/09/01 08:05:24  narry
// 35. Стирается пробел перед ссылкой (внимание на между "от" и датой) (278839514)
//
// Revision 1.5  2011/08/12 07:19:53  narry
// 28. Игнорировать содержимое файла после окончания html (278839269)
//
// Revision 1.4  2011/07/15 09:38:07  narry
// Ссылки съедают пробел (274825348)
//
// Revision 1.3  2011/02/07 13:02:55  narry
// K253658756. Не собирается ddHTML_r 2
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
 ddHTMLParser,
 ddRTFProperties,
 ddRegSeacherOwner,

 Classes,
 Graphics;

type
  TddHTMLAnalyzeEvent = procedure (var theBreakAnalyze: Boolean) of object;

  TddSimpleHTMLReader = class(TddRegSeacherOwner)
  private
    f_Text           : AnsiString;
    f_InDel          : Integer;
    f_IsData         : Boolean;
    f_ReadURL        : Boolean;
    f_ReadIns        : Boolean;
    f_OnAnalyze      : TddHTMLAnalyzeEvent;
    f_BreakAnalyze   : Boolean;
    f_PrevUnicodeChar: Integer;
    procedure pm_SetReadIns(const Value: Boolean);
  private
    procedure pm_SetData(const Value: Boolean);
    procedure AddText;
    procedure CheckEntity(const anEntity: AnsiString; const aText: Tl3String);
    function SkipUnicodeSymbol(aCode: Integer; const aText: Tl3String): Boolean;
    function DoHTMLEntity2Char(anEntity: AnsiString; var aChar: AnsiChar): Boolean;
    procedure CheckTextWithUTF8;
    procedure HTMLEntity2Char(anEntity: AnsiString; const aText: Tl3String);
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
    function GetHTMLParser: TddHTMLParser;
    procedure pm_SetReadURL(const Value: Boolean);
    procedure ClearText(const aOut: Tl3String);
  protected
    f_IsPre        : Boolean;
    f_IsBody       : Boolean;
    f_IsStyle      : Boolean;
    f_InScript     : Boolean;
    f_CodePage     : LongInt;
    f_Document     : TddDocument;
    f_InitCodePage : Boolean;
  protected
    procedure DelTagsFinished; virtual;
    procedure IncInDel;
    procedure DecInDel;
    procedure ReasolveEntity(anIn: AnsiString; const aOut: Tl3String);
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
    property ReadURL: Boolean read f_ReadURL write pm_SetReadURL;
    property ApplyTextCorrections: Boolean read f_ReadIns write pm_SetReadIns;
    property IsData: Boolean read f_IsData write pm_SetData;
     {* - Идет чтение данных, которые можно записывать в параграф. }
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
 l3StringEx, 
 l3Interfaces,
 l3PrimString,
 l3CustomString,
 l3ObjectRefList1,
 l3ParserInterfaces,

 RTFtypes,

 ddUtils,
 ddHTMLTags,
 ddDocumentAtom,
 ddTextParagraph,

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
 f_ReadURL := False;
 f_ReadIns := False;
 f_PrevUnicodeChar := 0;
end;

procedure TddSimpleHTMLReader.AddText;
var
 l_Str     : Tl3String;
 l_LastPara: TddTextParagraph;
begin
 if IsTextNotEmpty then
 begin                                    
  if f_IsBody and not f_InScript then
  begin
   Try2OpenNewPara;
   Assert(f_CodePage <> CP_Unicode);
   {!!! Предусмотреть перекодировку русского текста }
   if IsData then
   begin
    CheckCodePage;
    l_Str := Tl3String.Create;
    try
     ClearText(l_Str);
     l_LastPara := f_Document.LastPara;
     if (l_LastPara <> nil) and IsTextNotEmpty then
     begin
      if f_CodePage = CP_KOI8 then // http://mdp.garant.ru/pages/viewpage.action?pageId=584178118
      begin
       l_Str._CodePage := f_CodePage;
       l_Str.CodePage := CP_ANSI;
      end; // if f_CodePage = CP_KOI8 then
      l_LastPara.AddText(l_Str);
     end; // if (l_LastPara <> nil) and IsTextNotEmpty then
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
 f_PrevUnicodeChar := 0;
end;

procedure TddSimpleHTMLReader.CheckTextWithUTF8;

 function lp_SkipChar(aCode: LongWord): Boolean;
 begin
  Result := (aCode = 8226) or
            (aCode = 173); // http://mdp.garant.ru/pages/viewpage.action?pageId=628097544
 end;

var
 i      : Integer;
 l_WS   : Widestring;
 l_Char : LongWord;
begin
 // Делаем очистку от служебных unicode симвлов
 if TryUTF8ToUTF16(f_Text, l_WS) then
 begin
  i := 0;
  while (i < Length(l_WS)) do
  begin
   Inc(i);
   l_Char := UCS4Char(l_WS[i]);
   // Удаляем символ
   if lp_SkipChar(l_Char) then
    Delete(l_WS, i, 1)
   // Замена на читаемый символ
   else
    if (l_Char = 61623) then
    begin
     Delete(l_WS, i, 1);
     Insert('&middot;', l_WS, i);
     Inc(i, Length('&middot;'));
    end // if (l_Char = 61623) then
    // Заменяем на пробел
    else
     if (l_Char > 60000) then
      l_WS[i] := cc_HardSpace
  end; // while (i < Length(l_WS)) do
  f_Text := Utf8ToAnsi(UTF8Encode(l_WS));
 end; // if TryUTF8ToUTF16(f_Text, l_WS) then
end;                                            

function TddSimpleHTMLReader.DoHTMLEntity2Char(anEntity: AnsiString; var aChar: AnsiChar): Boolean;
begin
 Result := False;
 if anEntity = '&times;' then
 begin
  Result := True;
  aChar := cc_Null;
 end; // if anEntity = '&times;' then
end;

procedure TddSimpleHTMLReader.HTMLEntity2Char(anEntity: AnsiString; const aText: Tl3String);
var
 i       : Integer;
 l_Code  : Integer;
 l_Char  : AnsiChar;
 l_EnLen : Integer;
 l_Entity: AnsiString;
 l_CharID: Integer;
begin
 l_Code := Ord(cc_HardSpace);
 l_EnLen := Length(anEntity);
 // charset encoded entity
 if (l_EnLen > 2) and (anEntity[2] = '#') then
  CheckEntity(anEntity, aText)
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

procedure TddSimpleHTMLReader.ClearText(const aOut: Tl3String);
var
 l_Str : Tl3Str;
begin
 if f_CodePage = cp_UTF8 then
  CheckTextWithUTF8;
 ReasolveEntity(f_Text, aOut);
 l_Str.Init(aOut.AsWStr, CP_OEM); // - здесь CP_то что надо
 try
  if l3CharSetPresent(l_Str.S, l_Str.SLen, cc_Graph_Criteria) then
  // Преобразовываем в строку
    aOut.AsPCharLen := l_Str;
 finally
  l_Str.Clear;
 end;{try..finally}
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
 l_Parser := TddHTMLParser.Create;
 try
  Parser := l_Parser;
 finally
  FreeAndNil(l_Parser);
 end;
end;

procedure TddSimpleHTMLReader.Read;
begin
 f_BreakAnalyze := False;
 f_IsPre := False;
 f_InDel := 0;
 with Parser do
 begin
  while (not Parser.Filer.EOF) and (not f_BreakAnalyze) do
  begin
   NextTokenSP;
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
 // нужно искать параметры тэга
 l_Params := '';
 l_TagID:= Parser.Keyword.StringID;
 l_IsParcingTag := l_TagID <> cUnknownKeyword;
 if l_IsParcingTag then
  if Abs(l_TagID) = tidH then
   l_TempKey := Parser.Keyword.AsString
  else
   if Abs(l_TagID) = tidPre then
    f_IsPre := l_TagID > 0;
 Parser.WhiteSpace := l3_DefaultParserWhiteSpace - [cc_HardEnter, cc_SoftEnter, cc_HardSpace];
 Parser.WordChars  := l3_DefaultParserWordChars + cc_ANSIRussian + cc_Digits + [cc_HardEnter, cc_SoftEnter] + ['[',']'] + [cc_Dot, cc_PercentSign, cc_Hyphen];
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
 if (GetHTMLParser.PrevSourceLine < GetHTMLParser.SourceLine) then
 begin
  if (f_Text <> '') then
   f_Text := f_Text + cc_HardSpace;
  GetHTMLParser.PrevSourceLine := GetHTMLParser.SourceLine;
 end; // if Parser.PrevSourceLine < Parser.SourceLine then
 f_Text := f_Text + Parser.TokenString;
end;

function TddSimpleHTMLReader.IsTextNotEmpty: Boolean;
begin
 Result := (f_Text <> '') and (f_InDel = 0);
end;

procedure TddSimpleHTMLReader.Try2OpenNewPara;

 function lp_InHeadText: Boolean;
 var
  l_LastPara: TddDocumentAtom;
 begin
  Result := True;
  l_LastPara := f_Document.LastPara;
  if (l_LastPara <> nil) then
   Result := False;
 end;

 function lp_NotEmpty: Boolean;
 begin
  Result := IsTextNotEmpty and (f_Text <> cc_HardSpace);
 end;

begin
 if IsData and lp_InHeadText and lp_NotEmpty then
  OpenParagraph;
end;

procedure TddSimpleHTMLReader.ParseStyleTable(aStyleTable: AnsiString);
begin
  (* таблица стилей приходит в следующем виде
    имя_стиля{формат_стиля}..
    формат_стиля - параметр:значение;..
   *)
  if aStyleTable <> '' then
   l3ParseWordsEx(l3PCharLen(aStyleTable), ParseStyle, [cc_CloseBrace]);
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
  l_StyleName := Trim(Copy(l_Style, 1, Pred(Pos(cc_OpenBrace, l_Style))));
  if l_StyleName <> '' then
  begin
   l_StyleEntry := f_Document.StyleByName(l_StyleName).Use;

   if l_StyleEntry = nil then
   begin
    l_StyleEntry := TddStyleEntry.Create;
    l_StyleEntry.AsString:= l_StyleName;
    if l_StyleEntry.AsWStr.S[0] = cc_Dot then
     (l_StyleEntry As Tl3CustomString).Delete(0, 1);
   end // if l_StyleEntry = nil then
   else
    l_StyleEntry.Clear;
   try
    Delete(l_Style, 1, Pos(cc_OpenBrace, l_Style));
    l3ParseWordsExF(l3PCharLen(l_Style), l3L2WA(@l_TranslateParam), [cc_SemiColon]);
    f_Document.AddStyle(l_StyleEntry);
   finally
    l3Free(l_StyleEntry);
   end;//try.finally
  end; // if l_StyleName <> '' then
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
 {параметр:значение;}
 l_SepPos := ev_lpCharIndex(cc_Colon, aStr);
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
  end; // if l3Compare(l_ParamName, carCSSParamStrArray[dd_cssMargin], l3_siCaseUnsensitive) = 0 then
 end; // if l3Pos(l_ParamName, carCSSParamStrArray[dd_cssMargin]) <> l3NotFound then
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
 f_ReadURL := False;
 f_ReadIns := False;
 f_PrevUnicodeChar := 0;
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

function TddSimpleHTMLReader.GetHTMLParser: TddHTMLParser;
begin
 Result := TddHTMLParser(Parser);
end;

procedure TddSimpleHTMLReader.pm_SetReadURL(const Value: Boolean);
begin
 f_ReadURL := Value;
end;

procedure TddSimpleHTMLReader.pm_SetData(const Value: Boolean);
begin
 f_IsData := Value;
end;

procedure TddSimpleHTMLReader.ReasolveEntity(anIn: AnsiString;
  const aOut: Tl3String);
var
 l_Pos     : Integer;
 l_Len     : Integer;
 l_Char    : AnsiChar;
 l_Code    : Integer;
 l_Entity  : AnsiString;
 l_EnStart : Integer;
 l_CodePage: Integer;
begin
 l_Pos := 1;
 l_CodePage := CP_ANSI;
 l_Len := Length(anIn);
 while l_Pos <= l_Len do
 begin
  l_Char := anIn[l_Pos];
  case l_Char of
   cc_Tab: aOut.Append(cc_HardSpace, 1, l_CodePage);
   cc_HardEnter: begin
    Inc(l_Pos);
    if (l_Pos > l_Len) or (anIn[l_Pos] <> cc_SoftEnter) then
     Dec(l_Pos);
    aOut.Append(cc_HardSpace, 1, l_CodePage);
   end;
   cc_Ampersand: begin
    if l_Len > 1 then // http://mdp.garant.ru/pages/viewpage.action?pageId=585940693
    begin
     l_EnStart := l_Pos;
     while (anIn[l_Pos] <> cc_SemiColon) and (anIn[l_Pos] <> cc_HardSpace) do
     begin
      Inc(l_Pos);
      if l_Pos > l_Len then
      begin
       Dec(l_Pos);
       Break;
      end; // if l_Pos > l_Len then
     end; // while (l_Char <> cc_SemiColon) or (l_Char <> cc_HardSpace) do
     l_Entity := Copy(anIn, l_EnStart, l_Pos - l_EnStart + 1);
     HTMLEntity2Char(l_Entity, aOut);
    end // if l_Len > 1 then
    else
     if l_Char <> cc_Null then
     aOut.Append(l_Char, 1, l_CodePage);
   end;
   else
    if l_Char <> cc_Null then
     aOut.Append(l_Char, 1, l_CodePage);
  end; // case l_Char of
  Inc(l_Pos);
  if l3IsWhiteSpace(l_Char) then
   while (l_Pos <= l_Len) and l3IsWhiteSpace(anIn[l_Pos]) do
    Inc(l_Pos);
 end; // while l_Pos <= l_Len do
end;

procedure TddSimpleHTMLReader.pm_SetReadIns(const Value: Boolean);
begin
 f_ReadIns := Value;
end;

procedure TddSimpleHTMLReader.DecInDel;
begin
 Dec(f_InDel);
 if f_InDel = 0 then
  DelTagsFinished;
end;

procedure TddSimpleHTMLReader.IncInDel;
begin
 Inc(f_InDel);
end;

procedure TddSimpleHTMLReader.DelTagsFinished;
begin

end;

procedure TddSimpleHTMLReader.CheckEntity(const anEntity: AnsiString; const aText: Tl3String);
var
 l_ID    : Integer;
 l_Code  : Integer;
 l_EnLen : Integer;
 l_WChar : WideChar;
 l_PWChar: PWideChar;
 l_Entity: AnsiString;
begin
 l_Entity := anEntity;  
 l_EnLen := Length(l_Entity);
 Delete(l_Entity, l_EnLen, 1); //delete the ;
 Delete(l_Entity, 1, 2); // delete the &#
 if Uppercase(l_Entity[1]) = 'X' then
  l_Entity[1] := '$'; // it's hex (but not supported!!!)
 Val(l_Entity, l_ID, l_Code);
 if (l_Code = 0) and not SkipUnicodeSymbol(l_ID, aText) then
 begin
  l_WChar := WideChar(l_ID);
  l_PWChar := @l_WChar;
  aText.Append(l3PCharLen(l_PWChar, 1));
 end; // if (l_Code = 0) then
end;

function TddSimpleHTMLReader.SkipUnicodeSymbol(aCode: Integer; const aText: Tl3String): Boolean;
var
 l_Char: AnsiChar;
begin
 l_Char := ddUnicode2Char(aCode);
 Result := l_Char <> #0;
 if not Result and (aCode = 9472) and (f_PrevUnicodeChar = 0) then
 begin
  l_Char := cc_Minus;
  Result := True;
 end; // if not Result and (aCode = 9472) then
 if Result then
  aText.Append(l_Char)
 else
  f_PrevUnicodeChar := aCode; 
end;

end.
