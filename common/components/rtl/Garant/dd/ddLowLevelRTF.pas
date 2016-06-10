unit ddLowLevelRTF;

{ $Id: ddLowLevelRTF.pas,v 1.86 2016/05/19 09:54:17 dinishev Exp $ }

// $Log: ddLowLevelRTF.pas,v $
// Revision 1.86  2016/05/19 09:54:17  dinishev
// {Requestlink:530818794}
//
// Revision 1.85  2015/10/15 11:13:12  dinishev
// {Requestlink:609602166}
//
// Revision 1.84  2015/09/08 07:30:18  dinishev
// {Requestlink:606634250}. Читаем картинки из \sv
//
// Revision 1.83  2015/09/04 14:17:42  dinishev
// {Requestlink:606634250}
//
// Revision 1.82  2015/08/28 09:27:42  dinishev
// {Requestlink:606138650}
//
// Revision 1.81  2015/08/28 08:45:21  dinishev
// Reformat
//
// Revision 1.80  2015/08/24 13:24:55  dinishev
// Reformat
//
// Revision 1.79  2015/08/24 13:18:25  dinishev
// Reformat
//
// Revision 1.78  2015/08/24 13:11:47  dinishev
// Reformat
//
// Revision 1.77  2015/03/26 09:11:48  dinishev
// Лишнее поле.
//
// Revision 1.76  2015/03/17 09:31:39  dinishev
// Перенес DoReadData на TddRTFReader.
//
// Revision 1.75  2014/05/28 08:01:46  dinishev
// Перевел проверку на константу.
//
// Revision 1.74  2014/05/27 11:17:50  lulin
// - чистим код.
//
// Revision 1.73  2014/04/17 08:05:42  dinishev
// Вычистил неиспользуемые события.
//
// Revision 1.72  2014/04/10 09:38:36  dinishev
// {Requestlink:526715670}. Ускорение для EMF-картинок. Можно будет потом развивать для других форматов, если понадобиться...
//
// Revision 1.71  2014/04/08 08:18:20  dinishev
// {Requestlink:526715670}
//
// Revision 1.69  2014/04/04 08:24:07  dinishev
// {Requestlink:526715670}. Чистка кода.
//
// Revision 1.68  2014/04/04 06:58:30  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.67  2014/04/03 10:35:36  dinishev
// {Requestlink:526715670}. Учимся читать формат картинки из RTF.
//
// Revision 1.66  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.65  2014/02/04 15:01:09  lulin
// - рефакторинг парсера.
//
// Revision 1.64  2013/10/29 11:21:32  dinishev
// {Requestlink:496995054}
//
// Revision 1.63  2013/08/26 09:37:34  dinishev
// {Requestlink:479402974}
//
// Revision 1.62  2013/08/20 10:58:01  dinishev
// {Requestlink:476837609}. Bug fix: проверка на переполнение была в неправильном месте.
//
// Revision 1.61  2013/08/20 07:56:09  dinishev
// {Requestlink:476837609}. Переписал без кеширования данный в строку + защита от переполнения.
//
// Revision 1.60  2013/08/19 13:38:43  dinishev
// Убрал лишние переменные.
//
// Revision 1.59  2013/08/19 13:29:21  dinishev
// Cleanup
//
// Revision 1.58  2013/08/19 10:45:45  dinishev
// Убрал ненужную виртуальность методов.
//
// Revision 1.57  2013/07/18 12:15:19  dinishev
// Вычищаем кучу неиспользованного кода.
//
// Revision 1.56  2013/07/10 11:55:44  dinishev
// Cleanup
//
// Revision 1.55  2013/07/10 11:53:48  dinishev
// Cleanup
//
// Revision 1.54  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.53  2013/04/05 12:04:29  lulin
// - портируем.
//
// Revision 1.52  2013/01/22 12:19:52  narry
// Рефакторинг RTFReader
//
// Revision 1.51  2011/09/21 12:30:06  narry
// Пропадают куски текста при форматировании (285510478)
//
// Revision 1.50  2011/05/10 17:14:47  lulin
// {RequestLink:236719181}.
// №24.
//
// Revision 1.49  2011/02/09 11:34:21  narry
// К253657673. Чтение картинок из RTF
//
// Revision 1.48  2010/03/15 18:08:41  lulin
// {RequestLink:196969151}.
//
// Revision 1.47  2010/02/24 18:16:27  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.46  2009/06/24 10:58:27  narry
// - русско-японские RTF от OpenOffice
//
// Revision 1.45  2008/10/20 07:52:45  narry
// - не накапливается картинка в режиме Lite
//
// Revision 1.44  2008/04/09 13:51:15  narry
// - рефакторинг
// - замена символов буллета на (*, о, #)
//
// Revision 1.43  2008/03/21 14:09:21  lulin
// - cleanup.
//
// Revision 1.42  2008/02/20 17:22:58  lulin
// - упрощаем строки.
//
// Revision 1.41  2008/02/14 09:40:33  lulin
// - удалён ненужный класс.
//
// Revision 1.40  2008/02/13 20:20:06  lulin
// - <TDN>: 73.
//
// Revision 1.39  2008/02/06 15:37:00  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.38  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.37  2008/02/01 15:14:44  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.36  2007/02/12 16:40:34  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.35  2007/01/19 14:35:22  oman
// - new: Локализация библиотек - dd (cq24078)
//
// Revision 1.34  2006/12/29 13:09:25  lulin
// - реализуем интерфейс расширенного списка строк.
//
// Revision 1.33  2006/04/24 12:58:41  lulin
// - выпиливаем из списков общую функциональность.
//
// Revision 1.32  2005/05/06 08:39:17  fireton
// - профайлинг и оптимизация по скорости
//
// Revision 1.31  2004/09/21 12:21:05  lulin
// - Release заменил на Cleanup.
//
// Revision 1.30  2004/06/01 16:51:23  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.29  2004/04/26 14:28:20  law
// - new behavior: Tl3Filer теперь при чтении посимвольно учитывает кодировку.
// - bug fix: в свойство TevMemo.Buffer теперь нормально присваиваются строки с кодировкой Unicode.
//
// Revision 1.28  2004/01/16 10:10:11  narry
// - update
//
// Revision 1.27  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.26  2002/09/19 13:09:15  narry
// - remove unit: ddHTML.
//
// Revision 1.25  2002/09/09 15:36:23  law
// - bug fix: не вызывался метод NextToken*.
//
// Revision 1.24  2002/09/09 13:52:19  narry
// - cleanup
//
// Revision 1.23  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.22  2001/06/28 15:02:42  law
// - cleanup: убраны связи с RX.
//
// Revision 1.21  2001/05/30 09:11:18  law
// - new behavior: пытаемся централизовать обработку ошибок чтения документов.
//
// Revision 1.20  2001/05/29 09:39:36  narry
// Bug fix - работа с текстом
//
// Revision 1.19  2001/05/28 15:35:39  narry
// Update - чтение уникодного текст
//
// Revision 1.18  2001/05/16 10:48:31  narry
// Update - установление Status в случае ошибки чтения
//
// Revision 1.17  2001/04/09 14:05:12  narry
// Bug Fix - исправление обработки уникодного текст
//
// Revision 1.16  2001/01/19 12:26:03  narry
// Fix trouble with broken documents
//
// Revision 1.15  2000/12/18 10:53:46  narry
// Fix Lost text and soft hyph
//
// Revision 1.14  2000/12/15 15:29:54  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

{.$DEFINE SearchFor}
interface

uses
  SysUtils,
  Classes,
  Graphics,

  l3Types,
  l3Base,
  l3Chars,
  l3KeyWrd,
  l3Parser,

  l3Stream,
  l3Interfaces,

  k2TagGen,
  k2Reader,

  RTFTypes,

  ddRTFKeywords
  ;

const
  cc_HexDigitalCharSet = cc_Digits + ['a'..'f'] + ['A'..'F'];
  cc_HexDigitalCharSetWithEnters = cc_HexDigitalCharSet + [cc_HardEnter, cc_SoftEnter];

type
  TddRTFParser = class(Tk2CustomFileParser)
    private
    {internal fields}
     f_Status     : TRTFErrorCode;
     f_Param      : Tl3String;
     f_Text       : Tl3String;
     f_HasParam   : Boolean;
     f_SkipChars  : Integer;
     f_Hex        : Boolean;
     f_SkipUnknown: Boolean;
     f_LongParam  : Longint;
     f_LiteVersion: Boolean;
     f_SkipHexData: Boolean;
     f_ReadHexData: Boolean;
    private
     procedure SetLiteVersion(Value: Boolean);
     procedure pm_SetStatus(const Value: TRTFErrorCode);
     procedure SetParam(aParam: Tl3String);
    private
     function GetLongParam: Long;

     property Param: Tl3String
       read f_Param write SetParam;
    protected
    {internal methods}
      procedure ParseKeyword;
      procedure ParseUnknownKeyword;
      procedure ReadParam;
      procedure ReadText;
      procedure PushState; virtual;
      procedure PopState; virtual;
      procedure AddKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long; aText: Tl3String = nil);
          virtual;
      procedure AddText(aText: Tl3String); overload; virtual;
      procedure AddText(aText: AnsiChar); overload; virtual;
      procedure AddText(aText: Word); overload; virtual;
      procedure DoReadData; virtual;
      function SkipNext: Boolean;
      procedure DecSkipCount;
      procedure SkipChars(aCount: Integer);
      procedure Cleanup; override;
    public
    { public methods }
      constructor Create(anOwner: Tk2TagGeneratorOwner);
        override;
      procedure Read; override;
    public
    {public properties}
        {-}
      property LiteVersion: Boolean
        read f_LiteVersion write SetLiteVersion;
      property Status : TRTFErrorCode
        read f_Status write pm_SetStatus;
      property SkipHexData: Boolean
        read f_SkipHexData write f_SkipHexData;
      property SkipUnknown: Boolean
        read f_SkipUnknown write f_SkipUnknown;
      property ReadHexData: Boolean
        read f_ReadHexData write f_ReadHexData;
  end;{TddRTFParser}


implementation

uses
  l3String,
  ddRTFConst
  , l3Memory;

const
  ParamDelims = [cc_OpenBrace, cc_CloseBrace, cc_Slash];
  AdditionalWords = [cc_SingleQuote, cc_Austerisk, cc_Minus, cc_Colon, cc_Slash, cc_Underline, cc_OpenBrace, '|', cc_CloseBrace, cc_Tilda];
  cc_FinishParamCharSet = [cc_CloseBrace] + cc_WhiteSpaceExt + [cc_HardEnter, cc_SoftEnter]; // Символы, при которых параметр считается законченным.

{ start class TddRTFParser }

constructor TddRTFParser.Create(anOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(anOwner);
 f_Status:= ecOk;

 with Parser do
 begin
  WordChars:= ['A'..'Z','a'..'z'];
  LineComment := '';
  OpenComment := '';
  CloseComment := '';
  WhiteSpace := [cc_Null .. Pred(cc_HardSpace)] - [#10,#13];
  CheckFloat := False;
  CheckInt := False;
  CheckHex := False;
  AddDigits2WordChars := False;
 end;
 f_LiteVersion := False;
 f_Param := Tl3String.Create;
 f_Text := Tl3String.Create;
 f_SkipUnknown := True;
end;

procedure TddRTFParser.SetLiteVersion(Value: Boolean);
begin
 if Value <> f_LiteVersion then
 begin
  f_LiteVersion := Value;
  if Parser.Keywords <> nil then
  begin
   if f_LiteVersion then
    Parser.Keywords := RTFKeywordsLite
   else
    Parser.Keywords := RTFKeywords;
  end;
 end;
end;

procedure TddRTFParser.Cleanup;
begin
  l3Free(f_Param);
  l3Free(f_Text);
  inherited;
end;

procedure TddRTFParser.Read;
begin  { Read }
 if Parser.Keywords = nil then
 begin
  if f_LiteVersion then
   Parser.Keywords := RTFKeywordsLite
  else
   Parser.Keywords := RTFKeywords;
 end;
 f_ReadHexData := False;
 Parser.CheckKeywords := False;
 Parser.NextTokenSp;
 while (Parser.TokenType <> l3_ttEOF) do
 begin
  if f_ReadHexData and (Parser.TokenChar in cc_HexDigitalCharSetWithEnters) then
   DoReadData
  else // f_ReadHexData
  begin
   case Parser.TokenType of
    l3_ttEOL       : ;
    l3_ttSingleChar: ReadText; {-единичный (управляющий) символ}
    l3_ttSymbol    : ReadText;     {-идентификатор}
    l3_ttKeyWord   : ParseKeyWord;     {-ключевое слово}
    l3_ttString    : ;     {-строка (в кавычках)}
    l3_ttInteger   : ;    {-целое число}
    l3_ttFloat     : ;     {-вещественное число}
   end;
   Parser.NextTokenSp;
  end; // not f_ReadHexData
 end; { while not Filer.EOF }
end; { Read }

procedure TddRTFParser.ReadText;
const
 ccIgrnoringSingleChar = [cc_HardEnter, cc_SoftEnter];
var
 l_KW       : TSYM;
 l_TokenChar: AnsiChar;
begin
 if Parser.TokenType = l3_ttSingleChar then
 begin
  l_TokenChar := Parser.TokenChar;
  if (l_TokenChar in ParamDelims) and not Parser.CheckKeywords then
  begin
   if not f_Text.Empty then
    AddText(f_Text);
   case l_TokenChar of
    cc_Slash: begin
          Parser.CheckKeywords := True;
          f_Hex := False;
        end;
    cc_OpenBrace: PushState;
    cc_CloseBrace: PopState;
   end; // case
   f_Text.Clear;
  end // if (l_TokenChar in ParamDelims) and not Parser.CheckKeywords then
  else
  if Parser.CheckKeywords and (l_TokenChar in AdditionalWords) then
  begin
   l_KW := TSYM(Parser.Keywords.KeyWordByName[l3CStr(l_TokenChar)]);
   if l_KW <> nil then
   begin
    f_Hex := l_KW.StringID = valu_Hex;
    if l_KW.Kwd = kwdValu then
     ReadParam;
    AddKeyword(l_KW, f_HasParam, f_LongParam);
   end;
   Parser.CheckKeywords := False;
  end // if Parser.CheckKeywords and (l_TokenChar in AdditionalWords) then
  else
  if not (l_TokenChar in ccIgrnoringSingleChar) then
  begin
   if SkipNext then
    DecSkipCount
   else
    AddText(l_TokenChar);
  end // if not (l_TokenChar in ccIgrnoringSingleChar) then
 end // if Parser.TokenType = l3_ttSingleChar then
 else { l3_ttSingleChar }
 if Parser.TokenType = l3_ttSymbol then
 begin
  if Parser.CheckKeywords then
   ParseUnknownKeyword { Насколько я понимаю, сюда мы попадаем лишь в случае неизвестного ключевого слова }
  else
  begin
   if SkipNext then
    DecSkipCount
   else
    AddText(Parser.TokenLongString);
  end;
 end; // if Parser.TokenType = l3_ttSymbol then
end;

procedure TddRTFParser.ReadParam;
var
 l_Char     : AnsiChar;
 l_IncDelta : Integer;
 l_HexCount : Integer;
 l_Negative : Boolean;
begin
 f_HasParam := False;
 f_LongParam := 0;
 l_Negative := False;
 l_Char := Filer.GetC.rAC;
 if (l_Char = cc_Minus) then
 begin
  l_Negative := True;
  l_Char := Filer.GetC.rAC;
 end; // if (l_Char = cc_Minus) then
 l_HexCount := 0;
 while not Filer.EOF and (l_Char in cc_HexDigits) do              
 begin
  if f_Hex then
  begin
   case l_Char of
    '0'..'9': f_LongParam := f_LongParam * 16 + Ord(l_Char) - Ord('0');
    'a'..'f': f_LongParam := f_LongParam * 16 + Ord(l_Char) - Ord('a') + 10;
    'A'..'F': f_LongParam := f_LongParam * 16 + Ord(l_Char) - Ord('A') + 10;
   end; // case l_Char of
   Inc(l_HexCount);
   if (l_HexCount = 2) then Break;
  end // if f_Hex then
  else
  begin
   if f_LongParam > cnHighDiv10 then // Проверка для 10-го представления, т.к. 16-е - всего две цифры.
    Break;
   l_IncDelta := Ord(l_Char) - Ord('0');
   if l_Negative then
    f_LongParam := f_LongParam * 10 - l_IncDelta
   else
    f_LongParam := f_LongParam * 10 + l_IncDelta;
  end;
  f_HasParam := True; { a digit after the control means we have a parameter }
  l_Char := Filer.GetC.rAC;
 end; // while Ch in (cc_Digits + ['A'..'F','a'..'f']) do
 if l_Negative and (f_LongParam > 0) then
  f_LongParam := -f_LongParam;
 if Filer.EOF then
 begin
  if (l_Char in cc_FinishParamCharSet) then // Дадим ридеру шанс спокойно дочитать файл...
   Filer.UngetC
  else
   f_Status := ecEndOfFile
 end
 else
  if not f_Hex and (l_Char <> cc_HardSpace) then
   Filer.UngetC;
end;

procedure TddRTFParser.SetParam(aParam: Tl3String);
begin
 f_Param.Assign(aParam);
 f_LongParam := GetLongParam;
end;

function TddRTFParser.GetLongParam: Long;
begin
 try
  if f_HasParam then
   Result := StrToInt(Param.AsString)
  else
   Result := 0;
 except
  on EConvertError do
    try
     Result := l3Hex2Dec(Param.AsString);
    except
     Result := 0;
    end;
 end;
end;

procedure TddRTFParser.ParseUnknownKeyword;
var
 l_Text: Tl3String;
begin
 l_Text := Tl3String.Create;
 try
  l_Text.Assign(Parser.TokenLongString);
  ReadParam;
  Parser.CheckKeywords := False;
 finally
  l3Free(l_Text);
 end;
end;

procedure TddRTFParser.ParseKeyword;
  {-}
begin
 ReadParam;
 Parser.CheckKeywords := False;
 AddKeyword(TSYM(Parser.Keyword), f_HasParam, f_LongParam);
end;

procedure TddRTFParser.PushState;
begin

end;

procedure TddRTFParser.AddKeyword(aKeyword: TSYM; aHasParam: Boolean; aParam: Long; aText:
    Tl3String = nil);
begin

end;

procedure TddRTFParser.AddText(aText: Tl3String);
begin

end;

procedure TddRTFParser.AddText(aText: AnsiChar);
begin

end;

procedure TddRTFParser.AddText(aText: Word);
begin
end;

procedure TddRTFParser.PopState;
begin

end;

procedure TddRTFParser.DoReadData;
begin

end;

procedure TddRTFParser.pm_SetStatus(const Value: TRTFErrorCode);
begin
 f_Status := Value;
end;

function TddRTFParser.SkipNext: Boolean;
begin
 Result := f_SkipChars > 0;
end;

procedure TddRTFParser.DecSkipCount;
begin
 Dec(f_SkipChars);
end;

procedure TddRTFParser.SkipChars(aCount: Integer);
begin
 f_SkipChars := aCount;
end;

end.
