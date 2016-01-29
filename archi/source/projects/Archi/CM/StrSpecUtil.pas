unit StrSpecUtil;

{ $Id: StrSpecUtil.pas,v 1.12 2012/01/31 11:59:15 narry Exp $ }
// $Log: StrSpecUtil.pas,v $
// Revision 1.12  2012/01/31 11:59:15  narry
// ѕропадают даты при создании редакций документов (332567200)
//
// Revision 1.11  2007/12/03 09:51:19  dinishev
// »спользуем редактор из ветки
//
// Revision 1.10  2007/04/11 07:56:50  narry
// - перенос строки приводил к потере даты
//
// Revision 1.9  2005/09/20 12:19:25  narry
// - изменение: если в исходной строке есть сокращенное название мес€ца, все названи€ сокращаютс€
//
// Revision 1.8  2005/09/20 11:31:48  narry
// - исправление: сокращенное написание мес€ца приводило к ошибке
//

interface

Uses
 l3DateSt, l3Date;

 function InsertDate2Str(const aText: String; aDate: TstDate): String;
 { * - добавл€ет дату в хитрую строку вида "24, 25 апрел€, 27 декабр€ 2002 г."}

implementation

Uses
 SysUtils, Classes, StrUtils,
 l3Base, l3Chars;

type
 TDatePart = (dpDay, dpMonth, dpYear);

const
 ShortMonthNames : array[1..12] of String[5] =
     ('€нв.', 'фев.', 'марта', 'апр.', 'ма€', 'июн€',
      'июл€', 'авг.', 'сен.', 'окт.', 'но€б.', 'дек.');

function InsertDate2Str(const aText: string; aDate: TstDate): string;

 procedure AddMonth(const aMonth: ShortString; anList: TStrings);
 var
  j: Integer;
 begin
  for j:= 0 to Pred(anList.Count) do
   if anList.Strings[j][1] = '-' then
    anList.Strings[j]:= '='+aMonth+anList.Strings[j];
 end;  // AddMonth

 procedure AddYear(const aYear: ShortString; anList: TStrings);
 var
  j: Integer;
 begin
  for j:= 0 to Pred(anList.Count) do
   if anList.Strings[j][1] = '=' then
    anList.Strings[j]:= '+'+aYear+anList.Strings[j];
 end; // AddYesr

 procedure ParseText(anText: String; anList: TStrings; out theShortNames: Boolean);
 var
  l_Str : ShortString;
  l_What: TDatePart;
  j, k : Integer;
 begin
   l_Str:='';
   l_What:= dpDay;
   theShortNames := False;
   for j:= 1 to Length(anText) do
   begin
    if anText[j] in [cc_HardSpace, ',', cc_SoftSpace, cc_SoftEnter, #29] then
    begin
     if l_Str <> '' then
     begin
      if (Length(l_Str) = 4) and (l_What <> dpMonth) then
       l_What:= dpYear;
      case l_What of
       dpDay: // day
        begin
         if Length(l_Str) < 2 then
          l_Str:= ' '+ l_Str;
         anList.Add('-'+l_Str);
        end;
       dpMonth: // month
        begin
         if Length(l_Str) > 2 then
         begin
          if AnsiEndsText('.', l_Str) then
           Delete(l_Str, Length(l_Str), 1);

          for k:= 1 to 12 do
           if AnsiStartsText(l_Str, GetMonthNameR(k)) then
           begin
            if not theShortNames then
             theShortNames := AnsiCompareText(l_Str, GetMonthNameR(k)) <> 0;
            l_Str:= Format('%2d',[k]);
            break;
           end; // AnsiStartsText(l_Str, GetMonthNameR(k))
          AddMonth(l_Str, anList);
         end;
         l_What:= dpDay;
        end;
       dpYear: // year
        begin
         AddYear(l_Str, anList);
         l_What:= dpDay;
        end;
      end; //case
      l_Str:= '';
     end; // l_S <> ' '
    end
    else
    begin
     l_Str:= l_Str + anText[j];
     if not (aText[j] in cc_Digits) then
      l_What:= dpMonth;
    end;
   end; // for j
 end;

 procedure InsertDate(anDate: TstDate; anList: TStrings);
 var
  l_D, l_M, l_Y: Integer;
  l_S : ShortString;
  i: Integer;
 begin
   stDateToDMY(anDate, l_D, l_M, l_Y);
   l_S:= Format('+%d=%2d-%2d', [l_Y, l_M, l_D]);
   for i:= 0 to Pred(anList.Count) do
   begin
    if l_S < anList.Strings[i] then
    begin
     anList.Insert(i, l_S);
     l_S:= '';
     break
    end
    else
    if l_S = anList.Strings[i] then
    begin
     l_S:= '';
     break;
    end;
   end; // for i
   if l_S <> '' then
    anList.Add(l_S);
 end;

 function ConstructText(anList: TStrings; anShortNames: Boolean): String;
 var
  i, k: Integer;
  l_Day, l_Month, l_Year: Word;
  l_D, l_M, l_Y: Integer;
  l_S, l_MName: ShortString;

 begin
   l_Y:= 0;
   for i:= 0 to Pred(anList.Count) do
   begin
    l_S:= anList.Strings[i];
    Delete(l_S, 1, 1);
    for k:= 1 to Length(l_S) do
    begin
     if l_S[k] in ['=', '-'] then
      l_S[k]:= '/'
    end;
    try
     DecodeDate(StrToDateFmt('yyyy/mm/dd', l_S), l_Year, l_Month, l_Day);
    except
     l3System.Msg2Log('ƒобавление даты в строку '+aText);
     raise;
    end;
    if l_Y = 0 then
    begin
     l_Y:= l_Year;
     l_M:= l_Month;
     Result:= IntToStr(l_Day);
    end
    else
    begin
     if l_Year > l_Y then
     begin
      if anShortNames then
       l_MName := ShortMonthNames[l_M]
      else
       l_MName := GetMonthNameR(l_M);
      Result:= Result + ' ' + AnsiLowerCase(l_MName) + ' '
               + IntToStr(l_Y) + ' г.';
      l_Y:= l_Year;
      l_M:= l_Month;
     end
     else
     if l_Month > l_M then
     begin
      if anShortNames then
       l_MName := ShortMonthNames[l_M]
      else
       l_MName := GetMonthNameR(l_M);
      Result:= Result + ' ' + AnsiLowerCase(l_MName);
      l_M:= l_Month;
     end;
     Result:= Result + ', ' + IntToStr(l_Day);
    end;
   end; // for i
   if anShortNames then
    l_MName := ShortMonthNames[l_Month]
   else
    l_MName := GetMonthNameR(l_Month);

   Result:= Result + ' ' + AnsiLowerCase(l_MName) + ' '
            + IntToStr(l_Year) + ' г.';
 end;

 var
 l_ShortNames : Boolean;
 l_List: TStrings;
begin
  l_List:= TStringList.Create;
  try
   ParseText(aText, l_List, l_ShortNames);
   InsertDate(aDate, l_List);
   Result := ConstructText(l_List, l_ShortNames);
  finally
   l_List.Free;
  end;
end;





end.
