unit Unicode;

{ $Id: Unicode.pas,v 1.10 2013/04/11 16:46:26 lulin Exp $ }

// $Log: Unicode.pas,v $
// Revision 1.10  2013/04/11 16:46:26  lulin
// - отлаживаем под XE3.
//
// Revision 1.9  2013/04/05 12:04:29  lulin
// - портируем.
//
// Revision 1.8  2007/08/14 19:31:52  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.7  2007/08/14 14:30:05  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.6  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.5  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }
{$Define Secret}

interface

function Unicode2Ansi(Alpha: word): AnsiChar;

function Ansi2Unicode(C: AnsiChar): Word;

implementation

uses
  l3Base
  ;

{$IFDEF WIN32}
function Unicode2Ansi(Alpha: Word): AnsiChar;
var
 i : array[0..2] of WideChar;
begin
 l3FillChar(i, SizeOf(i), 0);
 i[0] := WideChar(Alpha);
 Result := AnsiChar(WideCharToString(i)[1]);
end;

function Ansi2Unicode(C: AnsiChar): Word;
var
  Buffer: array[0..2] of WideChar;
  W: Word;
begin
  W:= Word(StringToWideChar(C, Buffer, 3));
  Result:= W;
end;

{$ELSE WIN32}
{$IFDEF Secret }
function UnicodeToAnsi(Unicode: PAnsiChar; Ansi: PAnsiChar): Word; far; external 'GDI' index 467;

function Unicode2Ansi(Alpha: Word): AnsiChar;
var
  i,o: array[0..10] of AnsiChar;
begin
  l3FillChar(i, 11, 0);
  l3FillChar(o, 11, 0);
  l3Move(Alpha, i, 2);
  UnicodeToAnsi(i, o);
  Result:= o[0];
end;


{$ELSE}

const
  UnicodeTable : Array[129..255] of word =
         ($0403, $201A, $0453, $201E, $2026, $2020, $2021,
          $20AC, $2030, $0409, $2039, $040A, $040C, $040B, $040F,
          $0452, $0027, $0027, $0022, $0022, $2022, $002D, $002D,
          $0098, $2122, $0459, $203A, $045A, $045C, $045B, $045F,
          $0020, $040E, $045E, $0408, $00A4, $0490, $00A6, $00A7,
          $0401, $00A9, $0404, $0022, $00AC, $00AD, $00AE, $0407,
          $00B0, $00B1, $0406, $0456, $0491, $00B5, $00B6, $00B7,
          $0451, $2116, $0454, $0022, $0458, $0405, $0455, $0457,
          $0410, $0411, $0412, $0413, $0414, $0415, $0416, $0417,
          $0418, $0419, $041A, $041B, $041C, $041D, $041E, $041F,
          $0420, $0421, $0422, $0423, $0424, $0425, $0426, $0427,
          $0428, $0429, $042A, $042B, $042C, $042D, $042E, $042F,
          $0430, $0431, $0432, $0433, $0434, $0435, $0436, $0437,
          $0438, $0439, $043A, $043B, $043C, $043D, $043E, $043F,
          $0440, $0441, $0442, $0443, $0444, $0445, $0446, $0447,
          $0448, $0449, $044A, $044B, $044C, $044D, $044E, $044F);

function Unicode2Ansi(Alpha: Word): AnsiChar;
var
  i: Integer;
begin

  i:= 129;
  while (i < 256) and (UnicodeTable[i] <> Alpha) do Inc(i);
  if i < 256 then
    result:= Chr(i)
  else
    result:= #0;
end;
{$ENDIF}

{$ENDIF WIN32}
end.
