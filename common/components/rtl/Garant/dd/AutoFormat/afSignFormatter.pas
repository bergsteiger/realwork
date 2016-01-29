unit afSignFormatter;
{ Преобразует подпись в таблицу }
// $Id: afSignFormatter.pas,v 1.4 2014/04/29 14:06:19 lulin Exp $

// $Log: afSignFormatter.pas,v $
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
 TafSignFormatter = class(Tdd_lcBaseFormatter)

 private
  f_Sign: string;
  f_SignStarted: Boolean;
 protected
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 end;

implementation

uses
  StrUtils, k2Tags, SysUtils, l3Chars;

procedure TafSignFormatter.ClearParameters;
begin
 inherited ClearParameters;
 f_SignStarted:= False;
 f_Sign:= '';
end;

function TafSignFormatter.EnableWrite(aPara: Tl3Tag): Tdd_lcTextReaction;
begin
 Result:= lcWrite;
 if not f_SignStarted then
 begin
  { TODO : Тут нужен список должностей подписантов }
  if AnsiStartsText('Председатель Правительства', Trim(aPara.StrA[k2_tiText])) then
  begin
   f_Sign:= Trim(aPara.StrA[k2_tiText]);
   f_SignStarted:= True;
   Result:= lcSkip;
  end
 end
 else
 begin
   f_Sign:= f_Sign + cc_SoftEnter + Trim(aPara.StrA[k2_tiText]);
   f_SignStarted:= False;
   Result:= lcSkip;
  AddEmptyPara;
  AddSBSTable(Copy(f_Sign, 1, Pos(#9, f_Sign)-1), Copy(f_Sign, Pos(#9, f_Sign)+1, MaxInt), True);
  AddEmptyPara;
  f_Sign:= ''; 
 end;
end;

end.
