unit dd_lcResolutionFormatter;
{ Форматирование заголовков постановлений судов }

{ $Id: dd_lcResolutionFormatter.pas,v 1.30 2014/04/08 17:13:30 lulin Exp $ }

// $Log: dd_lcResolutionFormatter.pas,v $
// Revision 1.30  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.29  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.28  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.27  2013/04/12 15:02:04  lulin
// - расставляем const.
//
// Revision 1.26  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.25  2013/04/03 09:34:33  narry
// Не проходили тесты
//
// Revision 1.24  2013/03/29 12:58:02  narry
// Помоломались тесты
//
// Revision 1.23  2012/03/11 12:07:40  narry
// Липецкий суд еще про полный объем (344133716)
//
// Revision 1.22  2012/03/11 11:31:32  narry
// Липецкий арбитражный суд - изготовлено в полном объеме (344133631)
//
// Revision 1.21  2012/03/02 07:07:04  narry
// Дублируется информация о полном объеме дубль 2 (342858803)
//
// Revision 1.20  2012/02/29 11:54:40  narry
// Дублируется информация о полном объеме (342854672)
//
// Revision 1.19  2011/12/19 07:13:40  narry
// Убрать из лога заливки про не найденную дату резолютивной части (320743076)
//
// Revision 1.18  2011/11/23 13:55:58  narry
// В таблицу с датой-номером попадает левая информация (300028178)
//
// Revision 1.17  2011/11/22 12:53:51  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.16  2011/11/18 12:50:45  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.15  2011/11/18 12:47:54  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.14  2011/11/17 09:57:23  narry
// Таблица дата-номер для документов 5-го ААС (298682261)
//
// Revision 1.13  2011/11/11 13:24:04  narry
// Пропадает текст из определений ВАС (297710781)
//
// Revision 1.12  2011/11/11 12:25:52  narry
// Формирование таблички с датой-номером в начале текста (297708674)
//
// Revision 1.11  2011/11/11 07:38:28  narry
// Теряется абзац (297708704)
//
// Revision 1.10  2011/11/11 06:51:40  narry
// Теряется абзац (297708704)
//
// Revision 1.9  2011/11/09 11:54:57  narry
// Уточнение информации (296637424)
//
// Revision 1.8  2011/11/07 13:09:00  narry
// Разделять строки (296630524)
//
// Revision 1.7  2011/11/07 11:36:15  narry
// Не проверять город в тексте (296630444)
//
// Revision 1.6  2011/11/02 10:43:53  narry
// Уточнение информации об удаленных абзацах (296625489)
//
// Revision 1.5  2011/11/01 07:49:45  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.4  2011/10/31 11:05:03  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.3  2011/10/26 13:07:10  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//

interface

uses
  dd_lcTextFormatter2, k2Interfaces, Classes, k2tagGen;

type
 Tdd_lcResolutionFormatter = class(Tdd_lcBaseFormatter)
 private
  f_PostanovlenieFound: Boolean;
  f_ResolutionAdded: Boolean;
  f_CourtNameFound: Boolean;
  f_HeaderFound: Boolean;
  f_HeaderNotifyList: TList;
  f_PostanovlenieAdded: Boolean;
  f_ResolutionFound: Boolean;
  procedure AddPostanovlenie;
  procedure AddResolution;
  function CheckCourtName(aPara: Tl3Variant): Tdd_lcTextReaction;
  function CheckPostanovlenie(aPara: Tl3Variant; aWithResolution: Boolean; out
      thePostanovlenieFound: Boolean): Tdd_lcTextReaction;
  function CheckResolution(aPara: Tl3Variant): Tdd_lcTextReaction;
  procedure ConvertBrackedText;
  procedure DoHeaderFound;
  function FindPostanovlenie(aPara: Tl3Variant; aWithResolution: Boolean): Boolean;
  function MakePostanovlenie: AnsiString;
 protected
  procedure CheckLostParameters; override;
  procedure Cleanup; override;
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure AddBodyStartNotifier(aNotifier: Tdd_lcBaseFormatter);
 end;

implementation

uses
  StrUtils, ddUtils, dd_lcUtils, TextPara_Const, k2tags, dd_lcBaseFilter,
  evdStyles, dd_lcSourceUtils, SysUtils, l3DateSt, l3String, l3RegEx,
  l3PrimString, Math;

constructor Tdd_lcResolutionFormatter.Create(anOwner: Tk2TagGeneratorOwner =
    nil);
begin
 inherited Create(anOwner);
 f_HeaderNotifyList:= TList.Create;
end;

procedure Tdd_lcResolutionFormatter.AddBodyStartNotifier(aNotifier:
    Tdd_lcBaseFormatter);
begin
 if f_HeaderNotifyList.IndexOf(aNotifier) = -1 then
  f_HeaderNotifyList.Add(aNotifier);
end;

procedure Tdd_lcResolutionFormatter.AddPostanovlenie;
begin
 if length(f_Parameters[lc_lfPostanovlenie]) > 0 then
 begin
  f_PostanovlenieAdded:= True;
  ConvertBrackedText;
  UpperCaseFirstLetter(f_Parameters[lc_lfPostanovlenie]);
  Generator.StartChild(k2_typTextPara);
  try
   while f_Parameters[lc_lfPostanovlenie][length(f_Parameters[lc_lfPostanovlenie])] in [',', '.', ' '] do
    Delete(f_Parameters[lc_lfPostanovlenie], length(f_Parameters[lc_lfPostanovlenie]), 1);
   Generator.AddStringAtom(k2_tiText, f_Parameters[lc_lfPostanovlenie]+'.');
  finally
   Generator.Finish;
  end;
  AddEmptyPara;
 end;
end;

procedure Tdd_lcResolutionFormatter.AddResolution;
begin
 f_ResolutionAdded:= True;
 if f_Parameters[lc_lfResolution] <> '' then
 begin
  UpperCaseFirstLetter(f_Parameters[lc_lfResolution]);
  while f_Parameters[lc_lfResolution][length(f_Parameters[lc_lfResolution])] in [',', '.', ' '] do
   Delete(f_Parameters[lc_lfResolution], length(f_Parameters[lc_lfResolution]), 1);
  //f_PostanovlenieFound:= True;
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddStringAtom(k2_tiText, f_Parameters[lc_lfResolution]+'.');
  finally
   Generator.Finish;
  end;
 end; // if f_Parameters[lc_lfResolution] <> ''
 if f_Parameters[lc_lfPostanovlenie] <> '' then
  AddPostanovlenie;
 DoHeaderFound;
end;

function Tdd_lcResolutionFormatter.CheckCourtName(aPara: Tl3Variant):
    Tdd_lcTextReaction;
begin
 Result:= lcWrite;
 if CheckStartText(aPara) then
 begin
  if not f_ResolutionAdded then
   AddResolution;
  if (f_Parameters[lc_lfPostanovlenie] = '') and (f_Parameters[lc_lfResolution] <> '') then
  begin
   f_Parameters[lc_lfPostanovlenie]:= MakePostanovlenie;
   AddPostanovlenie;
   //AddEmptyPara;
  end;
  f_CourtNameFound:= True;
  DoHeaderFound;
 end;
end;

procedure Tdd_lcResolutionFormatter.CheckLostParameters;
begin
 if f_FormatStyle <> lc_fsDefinition then
  if (not f_ResolutionAdded) or (not f_ResolutionFound) then
  begin
   inherited;
   {K320743076}
   //if not f_ResolutionAdded or not f_ResolutionFound then
   // ReportMissing('Дата изготовления резолютивной части');
   //if not f_PostanovlenieAdded then
   // ReportMissing('Дата изготовления в полном объеме');
  end;
end;

function Tdd_lcResolutionFormatter.CheckPostanovlenie(aPara: Tl3Variant;
    aWithResolution: Boolean; out thePostanovlenieFound: Boolean):
    Tdd_lcTextReaction;
begin
 Result:= lcWrite;
 thePostanovlenieFound:= False;
 if FindPostanovlenie(aPara, aWithResolution) then
 begin
  if aPara.StrA[k2_tiText] = '' then
   Result:= lcSkip;
  if f_ResolutionAdded then
   AddPostanovlenie;
  thePostanovlenieFound:= True;
 end;
end;

function Tdd_lcResolutionFormatter.CheckResolution(aPara: Tl3Variant):
    Tdd_lcTextReaction;
var
 l_S: AnsiString;
 l_Found, l_IsRes: Boolean;
begin
 Result:= lcWrite;
  l_S:= aPara.StrA[k2_tiText];
  if AnsiContainsText(l_S, 'Резолютивн') then
  begin
   f_ResolutionFound:= True;
   // Нужно проверить не состоит ли этот абзац из двух - про резолюцию и полный текст
   //if aPara.StrA[k2_tiText] = '' then
   // Result:= lcSkip;
   //Нужен более внятный ответ от функции - нашли резолюцию или нет
   Result:= CheckPostanovlenie(aPara, True, l_Found);
   if not l_Found then
   begin
    f_Parameters[lc_lfResolution]:= l_S;
    Result:= lcSkip;
   end;
   AddResolution;
  end
  else
  if IsBodyStart(aPara, l_IsRes) then
  begin
   f_ResolutionAdded:= True;
   DoHeaderFound;
  end;
end;

procedure Tdd_lcResolutionFormatter.Cleanup;
begin
 inherited;
 FreeAndNil(f_HeaderNotifyList);
end;

procedure Tdd_lcResolutionFormatter.ClearParameters;
begin
 inherited;
 f_ResolutionAdded:= False;
 f_PostanovlenieAdded:= False;
 f_PostanovlenieFound:= False;
 f_CourtnameFound:= False;
 f_HeaderFound:= False;
 f_ResolutionFound:= False;
end;

procedure Tdd_lcResolutionFormatter.ConvertBrackedText;
begin
 // заменяем текст в скобках на насильно сформированный
 if AnsiStartsStr('(', f_Parameters[lc_lfPostanovlenie]) and
    AnsiEndsStr(')', f_Parameters[lc_lfPostanovlenie]) then
  f_Parameters[lc_lfPostanovlenie]:= MakePostanovlenie;
end;

procedure Tdd_lcResolutionFormatter.DoHeaderFound;
var
 i: integer;
begin
 if not f_HeaderFound then
 begin
  for i:= 0 to Pred(f_HeaderNotifyList.Count) do
   if Assigned(f_HeaderNotifyList[i]) then
    Tdd_lcBaseFormatter(f_HeaderNotifyList[i]).BodyStart;
  f_HeaderFound:= True;
 end;
end;

function Tdd_lcResolutionFormatter.EnableWrite(aPara: Tl3Variant):
    Tdd_lcTextReaction;
var
 l_IsRes, l_Found: Boolean;
begin
 Result:= lcWrite;
 if{ not f_ResolutionAdded and }(aPara.IntA[k2_tiStyle] = ev_saTxtNormalANSI) then
 begin
  if Source2DossierType(f_Source) = lc_dtVAC then
  begin
   if not f_ResolutionAdded then
    if IsBodyStart(aPara, l_isRes) then
    begin
     f_ResolutionAdded:= True;
     DoHeaderFound;
    end
  end
  else
  begin
   if not f_ResolutionAdded then
    Result:= CheckResolution(aPara);
   if (Result = lcWrite) and not f_PostanovlenieFound then
    Result:= CheckPostanovlenie(aPara, False, l_Found);
   if (Result = lcWrite) and not f_CourtNameFound then
    Result:= CheckCourtName(aPara);
  end;
 end;
end;

function Tdd_lcResolutionFormatter.FindPostanovlenie(aPara: Tl3Variant; aWithResolution: Boolean):
    Boolean;
var
 l_DatePos,
 l_Pos: Tl3MatchPosition;
 l_DateStarts: Boolean;
 l_ResultEnd, l_DateEnd: Integer;
 l_ReplaceText: Boolean;
const
 cAllText   = '((Полный)|(в полном объ[её]ме))\s{те[к]?ст}(\s(постановления)|(определения)|(решения))?\sизготовлен';
 cAllValue1 = 'в полном объ[её]ме (((постановление)|(определение)|(решение))\s+(суда\s+)?)?(изготовл\w+)|(постановление)|(определение)|(решение)';
 cAllValue2 = 'изготовлено в полном объ';
 cMotive    = 'Мотивированн';
 cFinalForm = '(в окончательной форме)|(в окончательном виде)';
 cMakeAllValue = 'изготовления ((постановления)|(решения)|(определения))? в полном объ';

begin
 Result:= False;
 if not f_PostanovlenieFound then
 begin
  RegSearcher.SearchPattern:= '('+cAllText+')|('+cAllValue1+')|('+cAllValue2+')|('+cMotive+')|('+cFinalForm+')|('+cMakeAllValue+')';
  RegSearcher.IgnoreCase:= True;

  if RegSearcher.SearchInString(aPara.PCharLenA[k2_tiText], l_pos) then
  begin
   if aWithResolution or (not aWithResolution  and (l_pos.StartPos < 50)) then
   begin
    Result:= True;
    l_ReplaceText:= False;
    if Regsearcher.TagParts.Count > 0 then
     l_ReplaceText:= AnsiSameText(RegSearcher.TagParts.Items[0].AsString, 'тест');

    l_DateStarts:= CheckStartsDate(aPara);
    if aWithResolution then
    begin
     l_ResultEnd:= IfThen(l_DateStarts, CheckDateStart(aPara, 12), l_Pos.StartPos);

     if f_Parameters[lc_lfResolution] = '' then
      f_Parameters[lc_lfResolution]:= Copy(aPara.StrA[k2_tiText], 1, l_ResultEnd);
     // Конец постановления не обязательно конец абзаца
     FindDatePos(aPara, l_DatePos, l_ResultEnd);
     if InRange(l_DatePos.StartPos, l_ResultEnd, l_ResultEnd+3) then
      l_DateEnd:= Length(aPara.StrA[k2_tiText])
     else
      l_DateEnd:= l_DatePos.EndPos;
     if f_Parameters[lc_lfPostanovlenie] = '' then
      f_Parameters[lc_lfPostanovlenie]:= Copy(aPara.StrA[k2_tiText], l_ResultEnd, l_DateEnd-l_ResultEnd+2);
     if l_DateEnd <> Length(aPara.StrA[k2_tiText]) then
      aPara.StrW[k2_tiText, nil]:= Trim(Copy(aPara.StrA[k2_tiText], l_DateEnd+2, Length(aPara.StrA[k2_tiText])))
     else
      aPara.StrW[k2_tiText, nil]:= '';
    end
    else
    begin
     f_Parameters[lc_lfPostanovlenie]:= aPara.StrA[k2_tiText];
     aPara.StrW[k2_tiText, nil]:= '';
    end;
    if l_ReplaceText then
      f_Parameters[lc_lfPostanovlenie]:= AnsiReplaceText(f_Parameters[lc_lfPostanovlenie], 'тест', 'текст');
   end;
  end;
 end; // not f_PostanovlenieFound
 f_PostanovlenieFound:= Result;
end;

function Tdd_lcResolutionFormatter.MakePostanovlenie: AnsiString;
var
 l_Pos: Tl3MatchPosition;
 l_Year: AnsiString;
begin
 //(января|февраля|марта|апреля|мая|июня|июля|августа|сентября|октября|ноября|декабря)
 RegSearcher.SearchPattern:= '>\d\d?\s+(январ[ья])|(феврал[ья])|(марта?)|(апрел[ья])|(ма[йя])|(июн[ья])|(июл[ья])|(августа?)|(сентябр[ья])|(октябр[ья])|(ноябр[ья])|(декабр[ья])\s+\d\d\d\d(\s?{(года)|(г\.?)})?<';
 if RegSearcher.SearchInString(l3PCharLen(f_Parameters[lc_lfResolution]), l_pos) then
 begin
  if RegSearcher.TagParts.Count > 0 then
   l_Year:= ' ' + RegSearcher.TagParts[0].AsString
  else
   l_Year:= '';
  Result := f_Type +' изготовлено в полном объеме ' + l3DateToStr(f_Date, 'DD mmmm YYYY') + l_Year;
 end
 else
  Result := f_Type + ' изготовлено в полном объеме ' + l3DateToStr(f_Date, 'DD.MM.YYYY.');
end;

end.
