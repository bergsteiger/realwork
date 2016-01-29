program KillIfWndExists;
{$APPTYPE CONSOLE}

uses
  Windows, Messages, SysUtils, Variants, ActiveX, ComObj;

type
  BytesReadWrite = packed record
    bytesRead: Int64;
    bytesWrite: Int64;
  end;

var
  w : HWND;
  res: BytesReadWrite;
  pclass, pcaption, pname: String;

function TerminateProcessByName(name: string): boolean;
const
  wbemFlagForwardOnly = $00000020;
var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
begin
  Result := false;
  try
    FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
    FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
    FWbemObjectSet:= FWMIService.ExecQuery('SELECT * FROM Win32_Process Where Name="' + name +'"','WQL',wbemFlagForwardOnly);
    oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
    while oEnum.Next(1, FWbemObject, iValue) = 0 do
    begin
      FWbemObject.Terminate();
      FWbemObject := Unassigned;
    end;
    Result := true;
  except
    Writeln('[!] Error in kill the process "' + name + '"');
  end;
end;

function GetReadWriteBytesOfProcessByName(name: string): BytesReadWrite;
const
  wbemFlagForwardOnly = $00000020;
var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
begin
  Result.bytesRead := -1;
  Result.bytesWrite := -1;
  try
    FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
    FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
    FWbemObjectSet:= FWMIService.ExecQuery('SELECT ReadTransferCount,WriteTransferCount FROM Win32_Process Where Name="' + name +'"','WQL',wbemFlagForwardOnly);
    oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
    // or if
    while oEnum.Next(1, FWbemObject, iValue) = 0 do
    begin
      Result.bytesRead := FWbemObject.ReadTransferCount;
      Result.bytesWrite := FWbemObject.WriteTransferCount;
      FWbemObject:=Unassigned;
    end;
  except
    Writeln('[!] Error when get read/write bytes info for process "' + name + '"');
  end;
end;

function FindNextWnd(startHWND: HWND; classStr, captionStr : PAnsiChar): HWND;
var
  Buffer : array [0..255] of Char;
begin
  Result := StartHWND;
  repeat
    Result := FindWindowEx(0, Result, classStr, nil);
    GetWindowText(Result, Buffer, SizeOf(Buffer));
    if StrPos(Buffer, captionStr) <> nil then
      Break;
  until (Result = 0);
end;

Begin
  CoInitialize(nil);

  ExitCode := 0;
  if ParamCount = 3 then
  begin
    pclass := ParamStr(1);
    pcaption := ParamStr(2);
    pname := ParamStr(3);

    if (pclass = '') or (pclass = '-')then
//      w := FindWindow(nil, PAnsiChar(pcaption))
      w := FindNextWnd(0, nil, PAnsiChar(pcaption))
    else
    if (pcaption = '') or (pcaption = '-') then
      w := FindWindow(PAnsiChar(pclass), nil)
    else
//      w := FindWindow(PAnsiChar(pclass), PAnsiChar(pcaption));
      w := FindNextWnd(0, PAnsiChar(pclass), PAnsiChar(pcaption));

    if w <> 0 then
    begin
      Writeln('Window found at ' + TimeToStr(Time));

      res := GetReadWriteBytesOfProcessByName(pname);
      if (res.bytesRead <> -1) and (res.bytesWrite <> -1) then
      begin
        Writeln(' Bytes read: ' + IntToStr(res.bytesRead div 1048576) + ' Mb (' + IntToStr(res.bytesRead) + ' bytes)');
        Writeln(' Bytes write: ' + IntToStr(res.bytesWrite div 1048576) + ' Mb (' + IntToStr(res.bytesWrite) + ' bytes)');
      end;

      if TerminateProcessByName(pname) then
        Writeln('Process "' + pname + '" was killed')
      else
        Writeln('Process "' + pname + '" was NOT killed');

      Writeln;

      ExitCode := 1;
    end
    else
//     Writeln('IsWndExists: window not found!');
  end
  else
  begin
    Writeln;
    Writeln('(C) 2014 Garant-Service. Detecting existing window and kill then');
    Writeln('Example: KillIfWndExists.exe [WNDCLASSNAME] [WNDNAME] [PROCNAME_FORKILL]');
  end;

  Sleep(100);

  CoUninitialize;
end.
