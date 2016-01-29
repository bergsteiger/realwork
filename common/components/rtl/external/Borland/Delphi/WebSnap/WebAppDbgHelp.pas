{ ************************************************************ }
{                                                              }
{                Borland Web Application Debugger              }
{                                                              }
{  Copyright (c) 2001-2002 Borland Software Corporation        }
{                                                              }
{ ************************************************************ }

unit WebAppDbgHelp;

interface

{$IFDEF MSWINDOWS}
function GetHelpPath: String;
{$ENDIF}

implementation

uses Windows, SysUtils;

{$IFDEF MSWINDOWS}
const
  Software = 'Software';
  Borland = 'Borland';
  WinHelpPath = 'WinHelpPath';
  CurProductName = 'Delphi';
  Help = 'Help';
  VerNo = '7.0';

function RegOpenKey(Key: HKey; const SubKey: string): HKey;
begin
  if Windows.RegOpenKey(Key, PChar(SubKey), Result) <> 0 then Result := 0;
end;

function GetRegistryPath: String;
var
 SoftwareKey, BorlandKey, DelphiKey, VerNoKey, HelpKey: HKey;
 BufferSize: LongInt;
 Buffer: array[0..255] of Char;
begin
 Result := '';
 { this is intended to retrieve help path information
   from the Delphi install registry keys. }
 BufferSize := Sizeof(Buffer);
 SoftwareKey := RegOpenKey(HKEY_CURRENT_USER, Software);
 if SoftwareKey <> 0 then
 begin
  BorlandKey := RegOpenKey(SoftwareKey, Borland);
  if BorlandKey <> 0 then
  begin
   DelphiKey := RegOpenKey(BorlandKey, CurProductName);
   if DelphiKey <> 0 then
   begin
     VerNoKey := RegOpenKey(DelphiKey, VerNo);
     if VerNoKey <> 0 then
     begin
       HelpKey := RegOpenKey(VerNoKey, Help);
       if HelpKey <> 0 then
       begin
         if (RegQueryValueEx(HelpKey, PChar(WinHelpPath), nil, nil, @Buffer, @BufferSize) = 0) then
         begin
           Result := Buffer;
         end;
       RegCloseKey(HelpKey);
       end;
       RegCloseKey(VerNoKey);
     end;
     RegCloseKey(DelphiKey);
   end;
   RegCloseKey(BorlandKey);
  end;
  RegCloseKey(SoftwareKey);
 end;
end;

function GetHelpPath: String;
begin
  Result := '';
  Result := SysUtils.GetEnvironmentVariable('BORHELP');
  if Result = '' then Result := GetRegistryPath;
  if Result = '' then Result := GetCurrentDir;
  Result := Result + '\';
end;
{$ENDIF}

end.
