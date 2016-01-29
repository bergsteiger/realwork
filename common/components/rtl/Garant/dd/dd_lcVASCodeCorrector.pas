unit dd_lcVASCodeCorrector;
{ Добавляет недостающий номер документам ВАС }

{ $Id: dd_lcVASCodeCorrector.pas,v 1.8 2014/04/07 09:34:04 lulin Exp $ }

// $Log: dd_lcVASCodeCorrector.pas,v $
// Revision 1.8  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.7  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.6  2011/09/13 05:33:39  narry
// Размноженные номера размножают хронологию (265410470)
//
// Revision 1.5  2011/05/04 07:33:55  narry
// Не хватает одного номера для определений и решений ВАС (265405144)
//
// Revision 1.4  2011/04/11 13:20:10  narry
// Команда CODE для документов Высшего Арбитражного Суда (259893042)
//
// Revision 1.3  2011/04/11 07:51:05  narry
// Размножение номера (259893511)
//
// Revision 1.2  2011/03/30 10:49:59  narry
// К259178030 .Дополнить новый номер датой
//
// Revision 1.1  2011/03/25 09:39:37  narry
// K259162137. Команда CODE для Определений и Решений ВАС
//

interface

uses
 ddHeaderFilter, k2Interfaces, dd_lcCodeCorrector;

type
 Tdd_lcVASCodeCorrector = class(Tdd_lcCodeCorrector)
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
 end;

implementation

uses
 StrUtils, k2Tags, dt_types, NumAndDate_Const, k2Base, SysUtils,
 dd_lcSourceUtils, dd_lcUtils;

procedure Tdd_lcVASCodeCorrector.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_Sources, l_Numbers: Tl3Variant;
 i, j{, l_Pos}: Integer;
 l_VASNumber: AnsiString;
 l_NonVASNumber: AnsiString;
 l_Number: AnsiString;
// l_2DigitNumber: AnsiString;
 l_Date: Integer;

begin
 l_Sources:= aHeaderRoot.Attr[k2_tiSources];
 if l_Sources.IsValid then
 begin
  for i:= 0 to Pred(l_Sources.ChildrenCount) do
  begin
   if Source2DossierType(l_Sources.Child[i].StrA[k2_tiName]) = lc_dtVAC  then
   begin // Наш случай, ищем номера
    l_Numbers:= aHeaderRoot.Attr[k2_tiNumANDDates];
    if l_Numbers.IsValid then
    begin
     l_VASNumber:= ''; l_NonVASNumber:= '';
     j:= 0;
     while j < l_Numbers.ChildrenCount do
     begin
      if l_Numbers.Child[j].IntA[k2_tiType] = Ord(dnPublish) then
      begin
       l_Number:= l_Numbers.Child[j].StrA[k2_tiNumber];
       l_Date:= l_Numbers.Child[j].IntA[k2_tiStart];
       if AnsiContainsText(l_Number, 'ВАС') then
        l_VASNumber:= l_Number
       else
        l_NonVASNumber:= l_Number;
      end; // l_Numbers.Child[j].IntA[k2_tiType] = Ord(dnPublish)
      Inc(j);
     end; // for j
     AddNumber(l_Numbers, MakeTwinNumber(l_Number), l_Date);
     if l_Number <> l_NonVASNumber then
      AddNumber(l_Numbers, MakeTwinNumber(l_NonVASNumber), l_Date);
     if (l_VASNumber <> '') and (l_NonVASNumber = '') then
     begin
      AddNumber(l_Numbers, MakeTwinNumber(Copy(l_VASNumber, 5, 255)), l_Date);
      AddNumber(l_Numbers, Copy(l_VASNumber, 5, 255), l_Date)
     end
     else
     if (l_VASNumber = '') and (l_NonVASNumber <> '') then
     begin
      AddNumber(l_Numbers, MakeTwinNumber('ВАС-'+l_NonVASNumber), l_Date);
      AddNumber(l_Numbers, 'ВАС-'+l_NonVASNumber, l_Date);
     end
    end;
    break
   end; // AnsiContainsText(l_Sources.Child[i].StrA[k2_tiName], 'ВАС')
  end;
 end;
end;


end.
