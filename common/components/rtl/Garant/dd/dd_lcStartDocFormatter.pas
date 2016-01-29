unit dd_lcStartDocFormatter;
{ Форматирование текста постановлений судов }

{ $Id: dd_lcStartDocFormatter.pas,v 1.9 2014/04/08 17:13:30 lulin Exp $ }

// $Log: dd_lcStartDocFormatter.pas,v $
// Revision 1.9  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.8  2014/04/07 09:45:46  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.7  2013/04/12 15:02:04  lulin
// - расставляем const.
//
// Revision 1.6  2012/09/04 10:11:34  narry
// Заголовок и нейм в определениях ВАС (390570489)
//
// Revision 1.5  2012/05/11 13:04:33  narry
// Не форматируются документы Югры (363566409)
//
// Revision 1.4  2012/04/27 06:05:18  narry
// Забытые коммиты
//
// Revision 1.3  2011/11/23 13:55:58  narry
// В таблицу с датой-номером попадает левая информация (300028178)
//
// Revision 1.2  2011/10/26 09:57:37  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//
// Revision 1.1  2011/10/25 05:31:16  narry
// Рефакторинг процедуры форматирования текстов (294595287)
//

interface

uses
  dd_lcTextFormatter2, k2Interfaces, k2TagGen;

type
 Tdd_lcStartDocFormatter = class(Tdd_lcBaseFormatter)
 private
  f_DocStartFound: Boolean;
 protected
  procedure CheckLostParameters; override;
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
 end;

implementation

uses
  SysUtils, dd_lcUtils, StrUtils, k2Tags;

constructor Tdd_lcStartDocFormatter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 EnableRestoreText := True;
end;

procedure Tdd_lcStartDocFormatter.CheckLostParameters;
begin
 if not f_DocStartFound then
 begin
  inherited;
  ReportMissing(Format('Начало документа (%s)', [c_TypeNames[f_FormatStyle]]));
 end;
end;

procedure Tdd_lcStartDocFormatter.ClearParameters;
begin
 inherited;
 f_DocStartFound:= False;
end;

function Tdd_lcStartDocFormatter.EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction;
var
 l_Text, l_AltOrder: ShortString;
 l_Pos: Integer;
 i: Tdd_lcFormatStyle;
begin
 if not f_DocStartFound then
 begin
  Result:= lcDelete;
  l_text:= aPara.StrA[k2_tiText];
  if (l_Text <> '') and (ParaCount < 10) then
  begin
   if AnsiStartsText(c_TypeNames[f_FormatStyle], l_Text) then
   begin
    f_DocStartFound:= true;
    // Видимо, нужно отрезать c_TypeNames[f_FormatStyle]
    Delete(l_text, 1, Length(c_TypeNames[f_FormatStyle]));
    if l_Text <> '' then
    begin
     aPara.StrW[k2_tiText, nil]:= l_text;
     Result:= lcWrite;
    end; 
    exit
   end
   else
    l_Text:= NormalizeText(aPara);
   if AnsiEndsText(c_TypeNames[f_FormatStyle], l_Text){ or (AnsiEndsText(c_TypeNames[f_FormatStyle]+'е', l_Text))} then
    f_DocStartFound:= true
   else
   for i:= Low(Tdd_lcFormatStyle) to High(Tdd_lcFormatStyle) do
   begin
    if AnsiSameText(c_TypeNames[i], l_Text) then
    begin
     ErrorReaction('Вместо "%s" найдено "%s"', [c_TypeNames[f_FormatStyle], c_TypeNames[i]]);
     f_DocStartFound:= true;
     break;
    end
   end;
  end; // l_text <> ''
 end
 else
  Result:= lcWrite;
end;

end.
