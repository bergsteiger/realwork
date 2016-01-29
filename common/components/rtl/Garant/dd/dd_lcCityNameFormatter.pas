unit dd_lcCityNameFormatter;
{ Форматирование названия города }

{ $Id: dd_lcCityNameFormatter.pas,v 1.9 2014/04/08 17:13:30 lulin Exp $ }

// $Log: dd_lcCityNameFormatter.pas,v $
// Revision 1.9  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.8  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.7  2013/04/12 15:02:04  lulin
// - расставляем const.
//
// Revision 1.6  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.5  2011/11/23 13:55:58  narry
// В таблицу с датой-номером попадает левая информация (300028178)
//
// Revision 1.4  2011/11/17 12:54:59  narry
// В таблице дата-номер город попал не в ту ячейку (299140417)
//
// Revision 1.3  2011/11/07 11:36:15  narry
// Не проверять город в тексте (296630444)
//
// Revision 1.2  2011/11/02 12:05:30  narry
// Уточнение информации об удаленных абзацах (296625489)
//
// Revision 1.1  2011/11/01 11:47:14  narry
// Не собиралось
//

interface

uses
  dd_lcTextFormatter2, k2Interfaces;

type
 Tdd_lcCityFormatter = class(Tdd_lcBaseFormatter)
 private
  f_CityFound: Boolean;
  function CheckCityName(aPara: Tl3Variant): Boolean;
 protected
  procedure CheckLostParameters; override;
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 end;

implementation

uses
  k2tags, evdStyles, dd_lcUtils, dd_lcSourceUtils, SysUtils;

function Tdd_lcCityFormatter.CheckCityName(aPara: Tl3Variant): Boolean;
var
 l_CityName: ShortString;
 l_Text: AnsiString;
 l_CityPos: Integer;
begin
 Result:= True;
 if (not f_BodyStarted) and (not f_CityFound) and IsCityName(aPara, l_CityName) then
 begin
  Result:= False;
  f_CityFound:= True;
  if Source2DossierType(f_Source) <> lc_dtVAC then
  begin
   // Нужно проверить нет ли в строке номера дела
   l_CityPos:= Pos(l_CityName, aPara.StrA[k2_tiText]);
   l_Text:= aPara.StrA[k2_tiText];
   Delete(l_Text, l_CityPos, Length(l_CityName));
   l_Text:= Trim(l_Text);
   if Length(l_Text) > 0 then
   begin
    Result:= True;
    aPara.StrW[k2_tiText, nil]:= l_Text;
   end;
   AddSBSTable(l_CityName, '', False);
  end;
 end;
end;

procedure Tdd_lcCityFormatter.CheckLostParameters;
begin
(*
 if not f_CityFound then
 begin
  inherited;
  ReportMissing('Название города')
 end;
*) 
end;

procedure Tdd_lcCityFormatter.ClearParameters;
begin
 inherited;
 f_CityFound:= False;
end;

function Tdd_lcCityFormatter.EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction;
begin
 if CheckCityName(aPara) then
  Result:= lcWrite
 else
  Result:= lcSkip;
end;

end.
