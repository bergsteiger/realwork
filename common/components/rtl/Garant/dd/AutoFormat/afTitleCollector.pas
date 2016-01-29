unit afTitleCollector;
{ Собирает заголовок документа }
// $Id: afTitleCollector.pas,v 1.4 2014/04/29 14:06:19 lulin Exp $

// $Log: afTitleCollector.pas,v $
// Revision 1.4  2014/04/29 14:06:19  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.3  2014/04/11 15:30:52  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.2  2013/04/16 09:30:55  fireton
// - не собиралось
//
// Revision 1.1  2013/04/16 08:09:55  narry
// Автоматические форматировщики
//

interface

uses
  dd_lcTextFormatter2, k2Interfaces;

type
 TafTitleCollector = class(Tdd_lcBaseFormatter)
 private
  f_Title: string;
  f_TitleFound: Boolean;
  procedure AddTitle;
 protected
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 end;

implementation

uses
  k2Tags, evdtypes, StrUtils, SysUtils, TextPara_Const, evdStyles, l3Chars;

procedure TafTitleCollector.AddTitle;
begin
  Generator.StartChild(k2_idTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
   Generator.AddStringAtom(k2_tiText, f_Title+cc_RDoubleQuote);
  finally
   Generator.Finish;
  end;
  AddEmptyPara;
  f_TitleFound:= True;
end;

procedure TafTitleCollector.ClearParameters;
begin
 inherited;
 CheckEmptyPara:= True;
 f_TitleFound:= False;
 f_Title:= '';
end;

function TafTitleCollector.EnableWrite(aPara: Tl3Tag): Tdd_lcTextReaction;
var
 i, l_Pos: Integer;
 l_CityName: ShortString;
 l_Text: String;
begin
 if f_TitleFound then
  Result:= lcWrite
 else
  Result:= lcDelete;

 if not f_TitleFound then
 begin
  if aPara.Attr[k2_tiFont].BoolA[k2_tiBold] and (aPara.IntA[k2_tiJustification] = ord(ev_itCenter)) then
  begin
   // Накапливаем
   l_Text:= aPara.StrA[k2_tiText];
   if (f_Title <> '') and not (AnsiEndsText(' ',  f_Title) or AnsiEndsText(cc_SoftEnter,  f_Title) or AnsiEndsText(cc_LDoubleQuote,  f_Title))then
    f_Title:= f_Title + ' ';
   f_Title:= f_Title + l_Text;
   if aPara.IntA[k2_tiStyle] = ev_saTxtHeader1 then
    f_Title:= f_Title + cc_SoftEnter + cc_LDoubleQuote;
  end
  else
  if aPara.IntA[k2_tiJustification] <> ord(ev_itCenter) then
  begin
   AddTitle;
   Result:= lcWrite;
  end
 end; // not f_TitleFound

end;

end.
