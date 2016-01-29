program testGetVersion;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils;

function LCIDToCodePage(ALcid: LongWord): Integer;
const
  CP_ACP = 0;                                // system default code page
  LOCALE_IDEFAULTANSICODEPAGE = $00001004;   // default ansi code page
var
  ResultCode: Integer;
  Buffer: array [0..6] of Char;
begin
  GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, SizeOf(Buffer));
  Val(Buffer, Result, ResultCode);
  if ResultCode <> 0 then
    Result := CP_ACP;
end;

begin
 Writeln('Version:', IntToHex(GetVersion, 8));
 Writeln('Codepage:', LCIDToCodePage(GetThreadLocale));
  { TODO -oUser -cConsole Main : Insert code here }
end.
 