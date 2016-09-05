program Hash48;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

function H48(const S: AnsiString): UInt64;
var
 M : UInt64;
 l_Hash : UInt64;
 l_Index : Integer;
 a : UInt64;
 b : UInt64;
begin
 M := $FFFFFFFFFFFF;
 a := 31415;
 b := 27183;
 l_Hash := 0;
 for l_Index := 1 to Length(S) do
 begin
  l_Hash := (a*l_Hash + UInt64(Ord(S[l_Index]))) mod M;
  a := a*b mod (M - 1);
 end;//for l_Index
end;

begin
  try
    WriteLn(IntToHex(H48('5739908903BB_5739908903BB_46780DA40383_Word'), 6));
    WriteLn(IntToHex(H48('4F50313101D1_5510142301A5_get'), 6));
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
