unit dd_lcDateNumberFormatter;
{ Форматирование текста постановлений судов }

{ $Id: dd_lcDateNumberFormatter.pas,v 1.41 2014/04/08 17:13:30 lulin Exp $ }

// $Log: dd_lcDateNumberFormatter.pas,v $
// Revision 1.41  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.40  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.39  2013/04/12 15:02:04  lulin
// - расставляем const.
//
// Revision 1.38  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.37  2013/04/03 09:34:33  narry
// Не проходили тесты
//
// Revision 1.36  2012/04/24 10:24:55  narry
// Подписи судей - попадает мусор (358982412)
//
// Revision 1.35  2012/03/15 07:46:38  narry
// Избавляемся от мусора в логе
//
// Revision 1.34  2012/03/14 08:52:08  narry
// Удаляется первая строка из текста (344142732)
//
// Revision 1.33  2012/03/11 13:01:11  narry
// В логе нет информации о том, что удален текст (344134014)
//
// Revision 1.32  2012/03/11 11:31:32  narry
// Липецкий арбитражный суд - изготовлено в полном объеме (344133631)
//
// Revision 1.31  2012/03/11 07:22:11  narry
// Липецкий суд номер дела плохо распознается (344132618)
//
// Revision 1.30  2012/03/02 10:15:42  narry
// Решения заливаются без текста (342860997)
//
// Revision 1.29  2011/12/07 07:12:41  narry
// Нестандартный вид номера в таблице дата-номер (309168209)
//
// Revision 1.28  2011/11/24 08:02:50  narry
// Ошибка в таблице дата-номер (303858401)
//
// Revision 1.27  2011/11/23 13:55:58  narry
// В таблицу с датой-номером попадает левая информация (300028178)
//
// Revision 1.26  2011/11/23 09:35:36  narry
// Неправильно формируется таблица дата-номер для ФАС МО (302744524)
//
// Revision 1.25  2011/11/22 15:06:21  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.24  2011/11/22 12:53:51  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.23  2011/11/21 13:00:53  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.22  2011/11/21 12:50:59  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.21  2011/11/18 12:47:54  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.20  2011/11/17 09:57:23  narry
// Таблица дата-номер для документов 5-го ААС (298682261)
//
// Revision 1.19  2011/11/17 06:20:49  narry
// Таблица дата-номер для документов 5-го ААС (298682261)
//
// Revision 1.18  2011/11/11 13:24:04  narry
// Пропадает текст из определений ВАС (297710781)
//
// Revision 1.17  2011/11/11 12:25:52  narry
// Формирование таблички с датой-номером в начале текста (297708674)
//
// Revision 1.16  2011/11/11 09:41:23  narry
// Формирование таблички с датой-номером в начале текста (297708674)
//
// Revision 1.15  2011/11/11 08:55:21  narry
// Формирование таблички с датой-номером в начале текста (297708674)
//
// Revision 1.14  2011/11/09 10:40:41  narry
// Терялись дата-номер
//
// Revision 1.13  2011/11/08 13:08:21  narry
// Судьи в одну строку (296630258)
//
// Revision 1.12  2011/11/03 07:41:11  narry
// Пробел в номере (296630248)
//
// Revision 1.11  2011/11/03 07:08:06  narry
// Неверно форматируется дата (296629110)
//
// Revision 1.10  2011/11/03 06:48:25  narry
// Неверно форматируется дата (296629110)
//
// Revision 1.9  2011/11/03 06:27:16  narry
// Неверно форматируется дата (296629110)
//
// Revision 1.8  2011/11/02 12:05:30  narry
// Уточнение информации об удаленных абзацах (296625489)
//
// Revision 1.7  2011/11/02 10:43:53  narry
// Уточнение информации об удаленных абзацах (296625489)
//
// Revision 1.6  2011/11/02 10:17:40  narry
// Сложная таблица в заголовке (296625499)
//
// Revision 1.5  2011/11/01 07:49:45  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.4  2011/10/28 13:13:35  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.3  2011/10/26 09:57:37  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.2  2011/10/25 13:16:26  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.1  2011/10/25 05:31:16  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//

interface

uses
  dd_lcTextFormatter2, k2Interfaces;

type
 Tdd_lcDateNumberFormatter = class(Tdd_lcBaseFormatter)
 private
  f_DateNumberAdded: Boolean;
  f_FoundDate: Boolean;
  f_FoundNumber: Boolean;
  f_IsRes: Boolean;
  procedure AddDateNumber;
  function CheckDate(aPara: Tl3Variant): Tdd_lcTextReaction;
  function CheckNumber(aPara: Tl3Variant): Tdd_lcTextReaction;
  procedure CheckParameters;
  function WriteDateNumber(aPara: Tl3Variant): Tdd_lcTextReaction;
 protected
  procedure CheckLostParameters; override;
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 end;

implementation

uses
  k2tags, StrUtils, Math, dd_lcUtils, evdStyles, Classes, SysUtils, l3DateSt,
  k2TagFilter, l3Chars, dd_lcBaseFilter, dd_lcSourceUtils, l3String, l3RegEx,
  l3PrimString, l3Interfaces;

procedure Tdd_lcDateNumberFormatter.AddDateNumber;
var
 l_Pos: Integer;
 l_Date: Integer;
begin
 f_DateNumberAdded:= True;
 if (Source2DossierType(f_Source) <> lc_dtVAC) and
    not IsPrezidium then
 begin
  CheckParameters;
  if (f_Parameters[lc_lfDate] <> '') or (f_Parameters[lc_LfNumber] <> '') then
  begin
   if Length(f_Parameters[lc_LfNumber]) > 10 then
   begin
    l_Pos:= Pos('№', f_Parameters[lc_LfNumber]);
    while l_Pos > 0 do
    begin
     if (Succ(l_Pos) <= Length(f_Parameters[lc_LfNumber])) and
        not (f_Parameters[lc_LfNumber][Succ(l_pos)] in [cc_HardSpace, cc_SoftSpace]) then
     begin
      Insert(cc_SoftSpace, f_Parameters[lc_LfNumber], Succ(l_pos));
      l_Pos:= PosEx('№', f_Parameters[lc_LfNumber], Succ(l_pos));
     end // (Succ(l_Pos) <= Length(l_Str)) and not (l_Str[Succ(l_pos)] in [cc_Space, cc_SoftSpace])
     else
      break
    end; // while l_Pos
   end
   else
    ErrorReaction('Слишком короткий номер дела "%s"', [f_Parameters[lc_LfNumber]]);

   AddSBSTable(f_Parameters[lc_lfDate], f_Parameters[lc_LfNumber], False);
  end
  else
  if (f_Parameters[lc_lfDate] = '') and (f_Parameters[lc_LfNumber] = '') then
   f_DateNumberAdded:= False;

  AddEmptyPara;
 end; // (f_FormatStyle = lc_fsResolution)
end;

function Tdd_lcDateNumberFormatter.CheckDate(aPara: Tl3Variant): Tdd_lcTextReaction;
var
 l_S, l_Year: AnsiString;
 l_Pos, i, l_NumberCount: Integer;
 l_Start, l_len: Integer;
begin
 Result:= lcWrite;
 l_S:= aPara.StrA[k2_tiText];
 // Ищем вхождение г. или года. А еще бывают даты, которые не заканчиваются на г. :(
 //if not AnsiContainsText(l_S, 'постанов') then
 // if AnsiStartsDate(l_S, l_Year) then
  if CheckExtractDate(aPara, l_S, l_Start, l_Len) then
  begin
   //l_Pos:= Pos(l_Year, l_S);
   //if l_Pos = 0 then
   // l_Pos:= MaxInt;
   f_Parameters[lc_lfDate]:= l_S; //Copy(l_S, 1, Pred(l_Pos)) + ' г.';
   f_FoundDate:= True;
   Result:= lcSkip;
   l_S:= aPara.StrA[k2_tiText];
   Delete(l_S, Succ(l_Start), l_Len);
   aPara.StrW[k2_tiText, nil]:= l_S;
   if (Length(l_S) > 0) then
    Result:= CheckNumber(aPara);
   if l3AllCharsInCharSet(aPara.PCharLenA[k2_tiText], cc_WhiteSpace) then
    Result:= lcDelete;
  end; // not AnsiStartsStr('г.', l_S)
end;

procedure Tdd_lcDateNumberFormatter.CheckLostParameters;
begin
 if Source2DossierType(f_Source) <> lc_dtVAC then
  if (not f_BodyStarted) or (not f_IsRes and (f_FormatStyle <> lc_fsDefinition)) or not f_DateNumberAdded or (not f_FoundDate) or (not f_FoundNumber) then
  begin
   if not f_BodyStarted and (LostParaCount > 0) then
    ReportMissing('Начало текста');
   inherited;
   if not f_FoundDate then
    ReportMissing('Дата опубликования')
   else
   if not f_DateNumberAdded then
    ErrorReaction('Дата опубликования "%s" не добавлена', [f_Parameters[lc_lfDate]]);
   if not f_FoundNumber then
    ReportMissing('Номер дела')
   else
   if not f_DateNumberAdded then
    ErrorReaction('Номер дела "%s" не добавлен', [f_Parameters[lc_lfNumber]]);
  end; // not f_DateNumberAdded
end;

function Tdd_lcDateNumberFormatter.CheckNumber(aPara: Tl3Variant):
    Tdd_lcTextReaction;
var
 l_S: AnsiString;
 l_MayBeDate, l_IsCaseCode: Boolean;
 l_Pos: Tl3MatchPosition;
 l_StartPos, l_Length: Integer;
begin
 Result := lcWrite;
 if not isCourtName(aPara) and CheckExtractNumber(aPara, l_S, l_StartPos, l_Length, l_IsCaseCode) then
 begin
  if l_IsCaseCode then
  begin
   Result:= lcSkip;
   f_FoundNumber:= True;
   //l_S:= DeBracketStr(ExtractNumber(aPara, l_MayBeDate));
   if l_S <> '' then
   begin
    if f_Parameters[lc_lfNumber] <> '' then
    begin
     RegSearcher.SearchPattern:= '(([А-Я]\s?\d\d)|(ВАС)\s?(\-[А-Я]+\s?)?\-\s?\d+(\s?\/|\-\s?)[А-Я\-0-9\\\/]+)';
     if RegSearcher.SearchInString(l3PCharLen(f_Parameters[lc_lfNumber]), l_Pos) then
      f_Parameters[lc_lfNumber]:= f_Parameters[lc_lfNumber] + #10
     else
      f_Parameters[lc_lfNumber]:= f_Parameters[lc_lfNumber] + #32;
    end; // f_Parameters[lc_lfNumber] <> ''
    f_Parameters[lc_lfNumber]:= f_Parameters[lc_lfNumber] + l_S;
   end; // l_S <> ''
   l_S:= aPara.StrA[k2_tiText];
   Delete(l_S, Succ(l_StartPos), l_Length);
   aPara.StrW[k2_tiText, nil]:= l_S;
   if l_S <> '' then
    Result:= CheckDate(aPara);
  end; // l_IsCaseCode
 end; // not isCourtName(aPara) and IsNumber(aPara, l_IsCaseCode)
end;

procedure Tdd_lcDateNumberFormatter.CheckParameters;
var
 i: Integer;
 l_Date: Integer;
begin
 if f_Parameters[lc_lfNumber] = '' then
 begin
  f_Parameters[lc_lfNumber]:= f_LawCaseNumber;
  f_FoundNumber:= True;
 end;

 if f_Parameters[lc_lfDate] = '' then
 begin // нужно придумать дату
  f_Parameters[lc_lfDate] := l3DateToStr(f_Date, 'd mmmm yyyy г.');
  f_FoundDate:= True;
 end;
end;

function Tdd_lcDateNumberFormatter.WriteDateNumber(aPara: Tl3Variant): Tdd_lcTextReaction;
begin
  if IsBodyStart(aPara, f_IsRes) or
     ((f_FormatStyle = lc_fsDecision) and f_FoundDate and f_FoundNumber) then
  begin
   Result:= lcWrite;
   AddDateNumber;
  end
  else
   Result:= lcDelete
end;

procedure Tdd_lcDateNumberFormatter.ClearParameters;
begin
 inherited;
 f_FoundDate:= False;
 f_FoundNumber:= False;
 f_DateNumberAdded:= False;
 f_IsRes:= False;
end;

function Tdd_lcDateNumberFormatter.EnableWrite(aPara: Tl3Variant):
    Tdd_lcTextReaction;
begin
 Result:= lcWrite;
 if not f_DateNumberAdded then
 // Гарантированно должны проскочить таблицы и заголовки
  if (aPara.IntA[k2_tiStyle] = ev_saTxtNormalANSI) and not InTable then
  begin
   if not f_FoundDate then
    Result:= CheckDate(aPara);
   if Result = lcWrite then
    Result:= CheckNumber(aPara);
   if (Result = lcWrite) and not f_DateNumberAdded then
    Result:= WriteDateNumber(aPara);
  end; // aPara.IntA[k2_tiStyle] <> ev_saTxtHeader1
end;

end.
