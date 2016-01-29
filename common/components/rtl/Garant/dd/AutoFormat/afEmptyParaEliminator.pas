unit afEmptyParaEliminator;
{ Удаляет пустые абзацы из текста }
// $Id: afEmptyParaEliminator.pas,v 1.4 2014/04/29 14:06:19 lulin Exp $

// $Log: afEmptyParaEliminator.pas,v $
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
 TafEmptyParaEliminator = class(Tdd_lcBaseFormatter)
 protected
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 end;

implementation

uses
  k2Tags;

procedure TafEmptyParaEliminator.ClearParameters;
begin
 inherited ClearParameters;
 CheckEmptyPara:= True;
end;

function TafEmptyParaEliminator.EnableWrite(aPara: Tl3Tag): Tdd_lcTextReaction;
begin
 Result:= lcWrite;
 if not InTable and (aPara.StrA[k2_tiText] = '') then
   Result:= lcSkip;
end;

end.
