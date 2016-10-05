unit ddNativeSpell;

{ Библиотека ""           }
{ Автор: Люлин А.В. ©     }
{ Модуль: ddNativeSpell - }
{ Начат: 29.10.2002 13:11 }
{ $Id: ddNativeSpell.pas,v 1.37 2016/09/23 09:33:45 voba Exp $ }

// $Log: ddNativeSpell.pas,v $
// Revision 1.37  2016/09/23 09:33:45  voba
// no message
//
// Revision 1.36  2016/04/12 12:45:04  voba
// no message
//
// Revision 1.35  2016/02/16 10:17:41  voba
// no message
//
// Revision 1.34  2016/02/16 07:28:47  lukyanets
// Не собиралось
//
// Revision 1.33  2015/01/27 07:14:03  dinishev
// Bug fix: AV при проверки правописания.
//
// Revision 1.32  2014/05/27 12:03:57  lulin
// - чистка кода.
//
// Revision 1.31  2014/04/25 10:28:17  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.30  2014/04/08 14:16:18  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.29  2013/04/17 14:19:22  lulin
// - портируем.
//
// Revision 1.28  2013/01/29 11:25:17  fireton
// - передаём кодировку в проверку орфографии
//
// Revision 1.27  2011/05/18 13:40:50  fireton
// - опция "считать точку разделителем слов при проверке орфографии"
//
// Revision 1.26  2011/05/17 13:56:03  fireton
// - возможность отключения проверки орфографии в коротких словах
//
// Revision 1.25  2009/11/09 13:38:51  voba
// - избавляемся от старой библиотеки регулярных выражений
//
// Revision 1.24  2009/04/29 14:51:47  voba
// - cc
//
// Revision 1.23  2009/04/28 15:17:10  lulin
// - перегенерация документации и работа над ошибками за Вованом.
//
// Revision 1.22  2009/04/28 14:10:05  voba
// - замена лингвистического модуля на  l3LingLib
//
// Revision 1.21  2009/04/14 15:41:13  voba
// - use l3LingLib
//
// Revision 1.20  2008/05/04 12:03:38  voba
// - переделал m0REXDat
//
// Revision 1.19  2008/02/12 19:33:00  lulin
// - избавляемся от универсальности списков.
//
// Revision 1.18  2008/02/06 11:44:37  lulin
// - список строк переехал в отдельный файл.
//
// Revision 1.17  2007/08/30 19:41:21  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.16  2006/05/04 13:32:49  lulin
// - cleanup.
//
// Revision 1.15  2006/05/04 11:00:39  lulin
// - cleanup: поправлен тип длины строки.
//
// Revision 1.14  2005/05/17 09:32:27  lulin
// - cleanup.
//
// Revision 1.13  2005/04/12 07:57:24  fireton
// - bug fix: игнорируем символ "№"
//
// Revision 1.12  2005/04/12 07:41:39  fireton
// - bug fix: игнорируем инициалы при проверке правописания
//
// Revision 1.11  2005/04/04 09:17:15  fireton
// - bug fix: корректно проверяем правописание в фрагменте, если выделен параграф целиком
//
// Revision 1.10  2005/03/31 13:42:12  fireton
// - change: переводим парсер спеллчекера на l3ParseWords
//
// Revision 1.9  2005/03/29 12:27:23  fireton
// - переформатировал исходники
//
// Revision 1.8  2005/03/29 11:46:25  fireton
// - bug fix: AV при пустом блоке
// - bug fix: неосвобождение ресурсов
//
// Revision 1.7  2005/03/28 12:00:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.6  2005/03/11 16:28:58  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.5  2004/06/02 08:33:15  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.4  2003/12/02 18:05:16  law
// - bug fix.
//
// Revision 1.3  2003/12/02 13:47:19  law
// - buf fix: восстановил вызовы (через локальные процедуры).
//
// Revision 1.2  2003/12/02 08:13:57  voba
// no message
//
// Revision 1.1  2002/10/29 11:08:04  law
// - new directive: evDualSpell.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Interfaces,
  l3StringList,
  l3SimpleObject,
  l3RegEx,

  k2Interfaces,

  ddSpellInterfaces
  ;

type
 TmgSrcEvnSpellFlags = (CmgSrcEvnDate,
                        CmgSrcEvnDigital,
                        CmgSrcEvnEnglish,
                        CmgSrcEvnRussian,
                        CmgSrcEvnAllCapital,
                        CmgSrcEvnAllSmall,
                        CmgSrcEvnNumberChar
                       );

 TmgSrcEvnSpellIgnoreFlags = set of TmgSrcEvnSpellFlags;

 TmgSrcEvnSpellFilter = function(const aString: Tl3WString): Boolean of object;

 TmgSpellFormChecker = class(Tl3SimpleObject, IddSpeller)
 private
  fFilter         : TmgSrcEvnSpellFilter;
  fIgnoreFlags    : TmgSrcEvnSpellIgnoreFlags;
  f_NormFormFound : Boolean;
  fRegExMashine   : Tl3RegularSearch;
  fMinWordLength  : Integer;
  f_DotIsWordSeparator: Boolean;

  //procedure CheckNormForm(AStatus : LongInt;
  //                        aBuff   : PAnsiChar;
  //                        aSize   : Cardinal);

 protected
  procedure pm_SetFilter(aValue: TddFilterWordEvent);
  {-}
  procedure pm_SetIgnoreFlags(aValue : TmgSrcEvnSpellIgnoreFlags);
  function pm_GetMinWordLength: Integer;
  procedure pm_SetMinWordLength(const Value: Integer);
  function pm_GetDotIsWordSeparator: Boolean;
  procedure pm_SetDotIsWordSeparator(const Value: Boolean);

  procedure Cleanup;
   override;
  {-}

  function IsIgnoreForm(aStr : Tl3PCharLen): Boolean;
 public


  property Filter: TmgSrcEvnSpellFilter read FFilter write FFilter;
  {-}
  property IgnoreFlags: TmgSrcEvnSpellIgnoreFlags read FIgnoreFlags write pm_SetIgnoreFlags;
  {-}
  function SearchEvent(Sender : Tl3Variant;
                             AString: Tl3CustomString;
                             ABegPos: Long;
                             AEndPos: Long;
                         var ABegRes: Long;
                         var AEndRes: Long): Bool;
  {-}
  procedure CreateAltvForms(AList: Tl3StringList;
                            ABuff: PAnsiChar;
                            ASize: LongInt;
                            AOemCp: LongBool);
  {-}
  function AddWord(const aStr : Tl3PCharLen): Bool;
  {-}
 end;

implementation

uses
  l3Chars,
  l3String,
  l3MinMax,

  l3SpellMisc,
  l3Speller,
  l3LingLib

  //m0LngLib,
  //mgLngObj
  ;

// start class TmgSpellFormChecker

procedure TmgSpellFormChecker.Cleanup;
begin
 l3Free(fRegExMashine);
 inherited;
end;


procedure TmgSpellFormChecker.pm_SetFilter(aValue: TddFilterWordEvent);
  {-}
begin
 FFilter := aValue;
end;

procedure TmgSpellFormChecker.pm_SetIgnoreFlags(aValue : TmgSrcEvnSpellIgnoreFlags);
var
 lPattern  : String;
 I : TmgSrcEvnSpellFlags;

 procedure AddToPattern(const aPat : String);
 begin
  if lPattern ='' then
   lPattern := aPat
  else
   lPattern := lPattern + '|' + aPat;
 end;

begin
 if fIgnoreFlags = aValue then Exit;

 fIgnoreFlags := aValue;
 l3Free(fRegExMashine);

 if fIgnoreFlags = [] then Exit;
 fRegExMashine := Tl3RegularSearch.Create;

 for I := Low(TmgSrcEvnSpellFlags) to High(TmgSrcEvnSpellFlags) do
  if I in fIgnoreFlags then
   case I of
    CmgSrcEvnDate:
     AddToPattern('(\d\d?(\.|\/)(\d\d?)(\.|\/)\d\d(\d\d)?)');
    CmgSrcEvnDigital:
     AddToPattern('(\d+)');
    CmgSrcEvnEnglish:
     AddToPattern('([A-Za-z]+)');
    CmgSrcEvnRussian:
     AddToPattern('([А-Яа-я]+)');
    CmgSrcEvnAllCapital:
     AddToPattern('([A-ZА-Я]+)');
    CmgSrcEvnAllSmall:
     AddToPattern('([a-zа-я]+)');
    CmgSrcEvnNumberChar:
     AddToPattern('((N|№)(N|№)?)');
   end; //case

 fRegExMashine.SearchPattern := '^'+lPattern+'$';
end;

function TmgSpellFormChecker.IsIgnoreForm(aStr : Tl3PCharLen): Boolean;
var
 lPosition : Tl3MatchPosition;
begin
 Result := (fRegExMashine <> nil) and fRegExMashine.SearchInString(aStr, lPosition);
end;

//procedure TmgSpellFormChecker.CheckNormForm(AStatus : LongInt;
//                                            ABuff   : PAnsiChar;
//                                            ASize   : Cardinal);
//begin
// if AStatus = Cm0LNGLibStatusNORM_FORM then // ставим флажок, что слово удалось нормализовать
//  f_NormFormFound := True;
//end;

function TmgSpellFormChecker.SearchEvent(Sender : Tl3Variant;
                                               AString: Tl3CustomString;
                                               ABegPos: Long;
                                               AEndPos: Long;
                                         var   ABegRes: Long;
                                         var   AEndRes: Long): Bool;
var
 l_PCharLen: Tl3PCharLen;
//const
// CFlags = Cm0LNGLibFlagORIG_FORM or Cm0LNGLibFlagNORM_FORM;
var
 LBuff:   PAnsiChar;
 LIndex1: LongInt;
 LIndex2: LongInt;
 LLength: LongInt;
 LSize:   LongInt;
 l_BadWordFound: Boolean;
 l_IsInitials: Boolean;

 function HasSymbolOnly(const aStr: Tl3PCharLen) : boolean; // в строке только всякий мусор вроде _ и .
 //Большинство спецсимволов убили когда на слова резали, поэтому на них не проверяем

 var
   I : integer;
 begin
  for I := 0 to pred(aStr.SLen) do
   if not (aStr.S[I] in [cc_Dot, cc_Underline, cc_Apostrophe, cc_RSingleQuote]) then
   begin
    Result := False;
    Exit;
   end;
  Result := True;
 end;

 function CheckOneWord(aStr: Tl3PCharLen; IsLast: Bool): Bool;
 begin
  Result := True;
  if HasSymbolOnly(aStr) then Exit;

  if (aStr.S[0] = cc_Dot) or // Проверка на строку из одной точки и инициалы
     ((aStr.SLen = 2) and (aStr.S[1] = cc_Dot)) or
     ((aStr.SLen = 4) and (aStr.S[1] = cc_Dot) and (aStr.S[3] = cc_Dot)) then
   Exit;
  if (aStr.S[0] = '№') then // Проверка на номер
   Exit;
  if (fMinWordLength > 0) and (aStr.SLen < fMinWordLength) then // проверка на длину слова
   Exit;

  f_NormFormFound := False;
  // Если на конце точка, то надо об этом сказать движку спеллчекера
  if aStr.S[aStr.SLen-1] in [cc_Dot, cc_Apostrophe, cc_RSingleQuote] then
   aStr.SLen := aStr.SLen -1;

  // собственно, проверка правописания
  l3Replace(aStr, [cc_RSingleQuote], cc_Apostrophe);

  f_NormFormFound := gSpeller.CheckSpell(aStr);
  if (not f_NormFormFound) and
     not ((IsIgnoreForm(aStr) or (Assigned(FFilter) and FFilter(aStr)))) then
  begin
   l_BadWordFound := True;
   ABegRes := aStr.S - l_PCharLen.S + ABegPos;
   AEndRes := ABegRes + aStr.SLen;
   Result := False;
  end;
 end;

const
 cExceptChars: array [Boolean] of TCharSet = ([cc_Dot, cc_Apostrophe, cc_RSingleQuote], [cc_Apostrophe, cc_RSingleQuote]);
begin
 Result:=False;
 if AString = nil then
  LLength := 0
 else
  LLength:= Min(AEndPos-ABegPos, AString.Len-ABegPos);
 if LLength > 0 then
 begin
  l_PCharLen := l3PCharLen(@(AString.St[ABegPos]), LLength, l3_bCodePage[AString.IsOEM]);
  l_BadWordFound := False;
  l3ParseWordsF(l_PCharLen, l3L2WA(@CheckOneWord), cExceptChars[f_DotIsWordSeparator]);
  Result := l_BadWordFound;
 end;
end;

function TmgSpellFormChecker.AddWord(const aStr : Tl3PCharLen): Bool;
  {-}
begin
 Result := false;
end;

procedure TmgSpellFormChecker.CreateAltvForms(AList: Tl3StringList;
                                              ABuff: PAnsiChar;
                                              ASize: LongInt;
                                              AOemCp: LongBool);

 procedure lAddStrFunc(aWord : PAnsiChar; aWordLen : integer);
 var
  lStr : Tl3String;
 begin
  lStr := Tl3String.Make(l3PcharLen(aWord, aWordLen));
  try
   AList.Add(lStr);
  finally
   l3Free(lStr);
  end;
 end;

var
 lAddFunc : TllAddStrProc;
begin
 AList.Clear;

 lAddFunc := L2llAddStrProc(@lAddStrFunc);
 try
  gSpeller.GetSuggestions(l3PCharLen(ABuff, aSize), lAddFunc);
  //mlmaSpellCheck(aBuff, aSize, lAddFunc);
 finally
  FreellAddStrProc(lAddFunc);
 end;
end;

function TmgSpellFormChecker.pm_GetDotIsWordSeparator: Boolean;
begin
 Result := f_DotIsWordSeparator;
end;

function TmgSpellFormChecker.pm_GetMinWordLength: Integer;
begin
 Result := fMinWordLength;
end;

procedure TmgSpellFormChecker.pm_SetDotIsWordSeparator(const Value: Boolean);
begin
 f_DotIsWordSeparator := Value;
end;

procedure TmgSpellFormChecker.pm_SetMinWordLength(const Value: Integer);
begin
 fMinWordLength := Value;
end;

end.

