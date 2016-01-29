unit dd_lcTitleFormatter;
{ Форматирование заголовков постановлений судов }

{ $Id: dd_lcTitleFormatter.pas,v 1.20 2014/04/08 17:13:30 lulin Exp $ }

// $Log: dd_lcTitleFormatter.pas,v $
// Revision 1.20  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.19  2014/04/07 09:45:46  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.17  2014/04/03 17:10:43  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.16  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2013/04/12 15:02:04  lulin
// - расставляем const.
//
// Revision 1.14  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.13  2012/09/05 08:03:18  narry
// Заголовок и нейм в определениях ВАС (390570489)
//
// Revision 1.12  2011/12/07 07:12:41  narry
// Нестандартный вид номера в таблице дата-номер (309168209)
//
// Revision 1.11  2011/11/23 13:55:58  narry
// В таблицу с датой-номером попадает левая информация (300028178)
//
// Revision 1.10  2011/11/21 12:50:59  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.9  2011/11/17 09:57:23  narry
// Таблица дата-номер для документов 5-го ААС (298682261)
//
// Revision 1.8  2011/11/09 10:38:57  narry
// Не выводим мусор в заголовок
//
// Revision 1.7  2011/10/28 13:13:35  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.6  2011/10/28 08:57:41  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.5  2011/10/26 13:07:10  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.4  2011/10/26 12:25:14  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.3  2011/10/26 09:57:37  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.2  2011/10/25 07:01:00  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.1  2011/10/25 05:31:16  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//

interface

uses
  dd_lcTextFormatter2, k2Interfaces;

type
 Tdd_lcTitleFormatter = class(Tdd_lcBaseFormatter)
 private
  f_IsResolution: Boolean;
  f_Title: AnsiString;
  f_TitleFound: Boolean;
 protected
  procedure AddTitle;
  procedure CheckLostParameters; override;
  function CheckNumber(aPara: Tl3Variant): Boolean;
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 end;

implementation

uses
  dd_lcUtils, l3LingLib, SysUtils, dd_lcSourceUtils, l3Date, l3DateSt, ddUtils,
  TextPara_Const, k2tags, evdStyles, Math, StrUtils, l3Chars;

procedure Tdd_lcTitleFormatter.AddTitle;
var
 l_Text: AnsiString;
 l_Court, l_CourtR: AnsiString;
 l_Date, i: Integer;
 l_Number: AnsiString;
 l_DossierType: Tdd_lcDossierType;
begin
 if f_DocName.Empty then
 begin
  l_Court:= deBracketStr(f_Source);
  if AnsiSameText(l_Court, 'Высший Арбитражный Суд России') then
   l_CourtR:= 'Высшего Арбитражного Суда РФ'
  else
   l_CourtR:= mlmaRusDeclensionStr(l_Court, rdRodit);
  l_Date:= 0;
  l_Number:= '';
  i:= 0;
  if f_Numbers.Count > 0 then
   repeat
    l_Date:= StrToIntDef(f_Numbers.Names[i], 0);
    l_Number:= f_Numbers.ValueFromIndex[i];
    Inc(i)
   until (i = f_Numbers.Count) or ((l_Date = 0) and (l_Number = ''));

  // Есть вероятность, что тут могут оказаться неправильные номера...
  l_DossierType:= Source2DossierType(f_Source);
  if l_DossierType = lc_dtFirst then
   l_Text:= Format('%s %s от %s г.',
                  [f_Type, l_CourtR, l3DateToStr(l_Date, 'd mmmm yyyy')])
  else
   l_Text:= Format('%s %s от %s г. № %s',
                  [f_Type, l_CourtR, l3DateToStr(l_Date, 'd mmmm yyyy'), l_Number]);
  if l_DossierType in [lc_dtFAC, lc_dtFirst] then
   l_Text:= l_Text + ' по делу № ' + f_LawCaseNumber;
  if (l_DossierType = lc_dtVAC) and (f_Title <> '') then
  begin
   UpperCaseFirstLetter(f_Title);
   l_Text:= l_Text + #10'"' + f_Title + '"';
  end;

  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
   Generator.AddStringAtom(k2_tiText, l_Text);
  finally
   Generator.Finish;
  end;
 end
 else
 begin
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
   Generator.AddStringAtom(k2_tiText, f_DocName.AsWStr);
  finally
   Generator.Finish;
  end;
 end;
 AddEmptyPara;
 f_TitleFound:= True;
 (*
 if Assigned(f_OnHeaderFound) then
  f_OnHeaderFound(Self);
 *)
end;

procedure Tdd_lcTitleFormatter.CheckLostParameters;
begin
 if not f_TitleFound {or not f_IsResolution} then
 begin
  inherited;
  if not f_TitleFound then
   ReportMissing('Заголовок документа');
  //if not f_IsResolution {VAS} then
  // ReportMissing('Дата резолютивной части');
 end;
end;

function Tdd_lcTitleFormatter.CheckNumber(aPara: Tl3Variant): Boolean;
var
 l_S: AnsiString;
begin
 Result := False;
 l_S:= aPara.StrA[k2_tiText];
 if not isCourtName(aPara) and (InRange(Pos('№', l_S), 1, 15) or AnsiContainsText(l_S, f_Number)) then
  Result:= True;
end;

procedure Tdd_lcTitleFormatter.ClearParameters;
begin
 inherited;
 f_TitleFound:= False;
 f_Title:= '';
end;

function Tdd_lcTitleFormatter.EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction;
var
 i, l_Pos: Integer;
 l_CityName: ShortString;
 l_Text: AnsiString;
begin
 if f_TitleFound then
  Result:= lcWrite
 else
  Result:= lcDelete;
 if not f_TitleFound then
 begin
  if IsBodyStart(aPara, f_IsResolution) or
     IsCityName(aPara, l_CityName) or
     isCourtName(aPara) or
     IsNumber(aPara) or
     IsDate(aPara) then
  begin
   AddTitle;
   Result:= lcWrite;
  end
  else
  if not (IsNumber(aPara) or IsDate(aPara)) then
  begin
   l_Text:= Trim(aPara.StrA[k2_tiText]);
   if f_Title <> '' then
   begin
    if AnsiStartsStr('о', l_Text) then
     f_Title:= f_Title + ', '
    else
     f_Title:= f_Title + ' ';
   end; // f_Title <> ''
   f_Title:= f_Title + l_Text;
  end; // (f_FormatStyle = lc_fsDefinition) and not f_TitleFound
 end; // not f_TitleFound
end;

end.
