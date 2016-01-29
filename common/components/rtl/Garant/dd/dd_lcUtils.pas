unit dd_lcUtils;
{ Вспомогательные функции }

{ $Id: dd_lcUtils.pas,v 1.14 2014/04/29 14:06:17 lulin Exp $ }
// $Log: dd_lcUtils.pas,v $
// Revision 1.14  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.13  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.12  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.11  2011/11/17 09:57:23  narry
// Таблица дата-номер для документов 5-го ААС (298682261)
//
// Revision 1.10  2011/11/14 12:51:40  narry
// В справке остались Ключевые темы (297714202)
//
// Revision 1.9  2011/11/07 13:09:00  narry
// Разделять строки (296630524)
//
// Revision 1.8  2011/11/03 06:48:25  narry
// Неверно форматируется дата (296629110)
//
// Revision 1.7  2011/11/01 12:09:25  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.6  2011/10/31 13:22:19  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.5  2011/10/28 13:13:35  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.4  2011/10/26 12:25:14  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.3  2011/10/25 05:31:16  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.2  2011/09/13 05:27:37  narry
// Размноженные номера размножают хронологию (265410470)
//
// Revision 1.1  2011/04/01 12:15:54  narry
// 259885188 Справка для ФАС
//

interface

uses
  l3Variant,
  k2Interfaces
  ;

type
 Tdd_lcLookFor = (lc_lfNone,
                  lc_lfStart,
                  lc_lfTitle,
                  lc_lfDate,
                  lc_lfNumber,
                  lc_lfAddNumber,
                  lc_lfResolution,
                  lc_lfPostanovlenie,
                  lc_lfCourtName,
                  lc_lfUstanovil,
                  lc_lfMainJudge,
                  lc_lfAddMainJudge,
                  lc_lfJudge,
                  lc_lfAddJudge,
                  lc_lfOrder,
                  // ВАС
                  lc_lfDefinition,
                  lc_lfDefinitionTitle,
                  lc_lfStartText);

 Tdd_lcLookForSet = set of Tdd_lcLookFor;
 Tdd_lcFormatStyle = (lc_fsResolution, lc_fsDefinition, {lc_fsPrezidium,} lc_fsDecision);


const
 c_Title : Array[0..2] of ShortString = ('город', 'гор', 'г.');
 c_MainJudge = 'Председательствующ';
 c_TypeNames: Array [Tdd_lcFormatStyle] of ShortString = (
   'Постановление', 'Определение', 'Решение'
   );
 c_OrderNames: Array [Tdd_lcFormatStyle] of ShortString = (
   'постановил:', 'определил:', 'решил:'
 );
 c_FirstSteps : Array[Tdd_lcFormatStyle] of Tdd_lcLookForSet = (
    {lc_fsResolution} [lc_lfTitle, lc_lfDate, lc_lfNumber, lc_lfResolution, lc_lfPostanovlenie, lc_lfCourtName, lc_lfOrder, lc_lfUstanovil],
    {lc_fsDefinition} [lc_lfTitle, lc_lfDate, lc_lfNumber, lc_lfCourtName, lc_lfOrder, lc_lfUstanovil],
    {lc_fsDecision}   [lc_lfTitle, lc_lfDate, lc_lfNumber, lc_lfResolution, lc_lfPostanovlenie, lc_lfCourtName, lc_lfOrder, lc_lfUstanovil]
    );
 c_SecondSteps: Array[Tdd_lcFormatStyle] of Tdd_lcLookForSet = (
    {lc_fsResolution} [lc_lfMainJudge, lc_lfAddMainJudge, lc_lfJudge, lc_lfAddJudge],
    {lc_fsDefinition} [lc_lfMainJudge, lc_lfAddMainJudge, lc_lfJudge, lc_lfAddJudge],
    {lc_fsDecision}   [lc_lfMainJudge, lc_lfAddMainJudge, lc_lfJudge, lc_lfAddJudge]
    );

 c_CityNames : Array[0..82] of ShortString = (
   'Абакан',
   'Анадырь',
   'Архангельск',
   'Астрахань',
   'Барнаул',
   'Белгород',
   'Биробиджан',
   'Благовещенск',
   'Брянск',
   'Великий Новгород',
   'Владивосток',
   'Владикавказ',
   'Владимир',
   'Волгоград',
   'Вологда',
   'Воронеж',
   'Горно-Алтайск',
   'Грозный',
   'Екатеринбург',
   'Ессентуки',
   'Иваново',
   'Ижевск',
   'Иркутск',
   'Йошкар-Ола',
   'Казань',
   'Калининград',
   'Калуга',
   'Кемерово',
   'Киров',
   'Кострома',
   'Краснодар',
   'Красноярск',
   'Кудымкар',
   'Курган',
   'Курск',
   'Кызыл',
   'Липецк',
   'Магадан',
   'Майкоп',
   'Махачкала',
   'Москва',
   'Мурманск',
   'Назрань',
   'Нальчик',
   'Нижний Новгород',
   'Новосибирск',
   'Омск',
   'Орел',
   'Оренбург',
   'Пенза',
   'Пермь',
   'Петрозаводск',
   'Петропавловск-Камчатский',
   'Псков',
   'Пятигорск',
   'Ростов-на-Дону',
   'Рязань',
   'Салехард',
   'Самара',
   'Санкт-Петербург',
   'Саранск',
   'Саратов',
   'Смоленск',
   'Ставрополь',
   'Сыктывкар',
   'Тамбов',
   'Тверь',
   'Томск',
   'Тула',
   'Тюмень',
   'Улан-Удэ',
   'Ульяновск',
   'Уфа',
   'Хабаровск',
   'Ханты-Мансийск',
   'Чебоксары',
   'Челябинск',
   'Черкесск',
   'Чита',
   'Элиста',
   'Южно-Сахалинск',
   'Якутск',
   'Ярославль'
                );

 c_DefinitionMax = 10;
 c_DefinitionStarts : Array[0..c_DefinitionMax] of ShortString = (
  'Коллегия судей Высшего Арбитражного Суда Российской Федерации в составе',
  'Коллегия судей Высшего Арбитражный Суд Российской Федерации в составе',
  'Судья Высшего Арбитражного Суда Российской Федерации',
  'Высший Арбитражный Суд Российской Федерации в составе',
  'Судебная коллегия Высшего Арбитражного Суда Российской Федерации в составе',
  'Председатель судебного состава',
  'Первый заместитель Председателя Высшего Арбитражного Суда Российской Федерации',
  'Заместитель Председателя Высшего Арбитражного Суда Российской Федерации',
  'Коллегия Высшего Арбитражного Суда Российской Федерации в составе',
  'Председатель второго судебного состава Высшего Арбитражного Суда Российской Федерации',
  'Президиум Высшего Арбитражного Суда'
  );

function lcAnsiPos(const Substr, S: AnsiString): Integer;

function AnsiStartsDate(const aStr: AnsiString; out theYear: AnsiString): Boolean;

function DeBracketStr(const aStr: AnsiString): AnsiString;

function IsTwoDigitsNumber(const aNumber: AnsiString): Boolean;

function MakeTwinNumber(const aNumber: AnsiString): AnsiString;

function LastNamePresent(aPara: Tl3Tag; out theFIO: ShortString): Boolean;

implementation

uses StrUtils, SysUtils, Math, k2tags, l3Chars, l3String;

function DeBracketStr(const aStr: AnsiString): AnsiString;
var
 l_Start, l_Finish: Integer;
begin
 Result:= aStr;
 l_Start:= LastDelimiter('(', Result);
 if l_Start > 0 then
 begin
  l_Finish:= LastDelimiter(')', Result);//PosEx(')', Result, l_Start);
  Delete(Result, l_Start, l_Finish - l_Start + 1);
  Result:= Trim(Result);
 end;
end;

function IsTwoDigitsNumber(const aNumber: AnsiString): Boolean;
var
 l_Pos: Integer;
 l_Int: Integer;
begin
 l_Pos:= Pos('/', aNumber);
 l_Int:= StrToIntDef(Copy(aNumber, Succ(l_pos), 255), -1);
 Result:= l_Int < 1000;
end;

function MakeTwinNumber(const aNumber: AnsiString): AnsiString;
var
 l_Pos: Integer;
 l_Int: Integer;
begin
 Result:= aNumber;
 l_Pos:= Pos('/', aNumber);
 l_Int:= StrToIntDef(Copy(aNumber, Succ(l_pos), 255), -1);
 if l_Int > 1000 then
  Delete(Result, Succ(l_Pos), 2)
 else
 if InRange(l_Int, 0, 30) then
  Insert('20', Result, Succ(l_pos))
 else
 if InRange(l_Int, 31, 99) then
  Insert('19', Result, Succ(l_pos));
end;

function lcAnsiPos(const Substr, S: AnsiString): Integer;
var
  P: PAnsiChar;
 l_S, l_Substr: AnsiString;
begin
  Result := 0;
 l_S:= AnsiUpperCase(S);
 l_SubStr:= AnsiUpperCase(SubStr);
  P := AnsiStrPos(PAnsiChar(l_S), PAnsiChar(l_SubStr));
  if P <> nil then
    Result := Integer(P) - Integer(PAnsiChar(l_S)) + 1;
end;

function AnsiStartsDate(const aStr: AnsiString; out theYear: AnsiString): Boolean;
var
 l_NC, i, j, l_Pos: Integer;
begin
 Result := False;
 theYear:= '';
 if Length(aStr) > 5{dd.mm.yy} then
  if (aStr[1] in ['0'..'9']) or (aStr[2] in ['0'..'9']) then
  begin // Дальше обязательно должен быть год (четыре цифры)
   l_NC:= 0;
   for i:= 2 to length(aStr) do
    if aStr[i] in ['0'..'9'] then
     Inc(l_NC)
    else
    begin
     if (l_NC = 4) and (i > 6) {Длина индекса} and (aStr[i] in [' ', 'г', 'Г']) then
     begin
      Result:= True;
      theYear:= aStr[i];
      j:= Succ(i);
      while (j<= Length(aStr)) and (aStr[j] <> ' ') do
      begin
       theYear:= theYear + aStr[j];
       Inc(j);
      end;
      break;
     end
     else
      l_NC:= 0;
    end;
   if (l_NC = 4) and (theYear = '') then
    Result:= True;
  end
end;

function LastNamePresent(aPara: Tl3Tag; out theFIO: ShortString): Boolean;
var
 i: Integer;
 l_InitialsStart,
 l_InitialsFinish: Integer;
begin
 // признаком фамилии считается точка после заглавной буквы
 Result := False;
 theFIO:= '';
 l_InitialsStart:= 0;
 for i:= 1 to Length(aPara.StrA[k2_tiText]) do
  if (aPara.StrA[k2_tiText][i] in cc_UpRussian) and
     (i <> Length(aPara.StrA[k2_tiText])) and (aPara.StrA[k2_tiText][Succ(i)] = '.') then
  begin
   l_InitialsStart:= i;
   break;
  end;
 if l_InitialsStart > 0 then
 begin
  l_InitialsFinish:= 0;
  for i:= l_InitialsStart + 2{'. '} to Length(aPara.StrA[k2_tiText]) do
   if (aPara.StrA[k2_tiText][i] in cc_UpRussian) and
      (i <> Length(aPara.StrA[k2_tiText])) and (aPara.StrA[k2_tiText][Succ(i)] = '.') then
   begin
    l_InitialsFinish:= i;
    break;
   end;
  if l_InitialsFinish > 0 then
  begin
   Result:= True;
   theFIO:= aPara.StrA[k2_tiText];
   if l_InitialsFinish <> Pred(Length(aPara.StrA[k2_tiText])) then // Фамилия после инициалов
   begin
    Delete(theFIO, 1, Pred(l_InitialsStart));
   end;
  end; // l_InitialsFinish > 0
 end; // l_InitialsStart > 0
end;

end.
