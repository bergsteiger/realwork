unit evConv;

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В.     }
{ Модуль: evConv - описание функций преобразования текста}
{ Начат: 04.06.97 11:49 }
{ $Id: evConv.pas,v 1.3 2000/12/15 15:10:34 law Exp $ }

// $Log: evConv.pas,v $
// Revision 1.3  2000/12/15 15:10:34  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  evConst
  ;

procedure evLo2Up(B: PChar; L: Long; CharSet: Byte);
procedure evUp2Lo(B: PChar; L: Long; CharSet: Byte);
procedure evSwapLoUp(B: PChar; L: Long; CharSet: Byte);

implementation

uses
  WinProcs
  ;

procedure evLo2Up(B: PChar; L: Long; CharSet: Byte);
begin
 AnsiUpperBuff(B, L);
end;

procedure evUp2Lo(B: PChar; L: Long; CharSet: Byte);
begin
 AnsiLowerBuff(B, L);
end;

procedure evSwapLoUp(B: PChar; L: Long; CharSet: Byte);
var
 i : Long;
begin
 for i := 0 to Pred(L) do begin
  if IsCharUpper(B[i]) then
   AnsiLowerBuff(@B[i], 1)
  else
   AnsiUpperBuff(@B[i], 1);
 end;{for i ..}
end;

end.

