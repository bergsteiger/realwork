unit nsIntegration;

interface

uses
 Windows;

function IsGarantInstalled: integer; stdcall;

function GarantProcessCommand(aCommand: DWORD; OpenInNewWindow: Bool;
 aTimeOut: DWORD):integer; stdcall;

function GarantDemoProcessCommand(aPath: PChar; anIntegrationKey: PChar;
 aCommand: DWORD; OpenInNewWindow: Bool; aTimeOut: DWORD):integer; stdcall;

function GarantShowLink(aRef:PChar; OpenInNewWindow: Bool; aTimeOut: DWORD):integer; stdcall;

function GarantDemoShowLink(aPath: PChar; anIntegrationKey: PChar; aRef:PChar;
 OpenInNewWindow: Bool; aTimeOut: DWORD):integer; stdcall;

implementation

uses
 Classes,
 Registry,
 SysUtils,
 Messages,

 l3Base,

 nsLauncherSupport,
 nsIntegrationSupport,
 nsIntegrationModelPart
 ;

const
 {$Include RegPath.inc}
 CDefaultIniValue = 'ApplicationAdapterOptions';
 CDefaultIniParamName = '-GCMConfigFile';
 CLauncher = 'garant.exe';
 CMainWindowClass = 'TnsMainWindow';
 CPrimeWindowClass = 'TnsEmptyMainForm';
 CStartupSupportClass = 'TnsStartupSupport:{65591D5E-77E5-4699-BF40-E7B1FB186037}';


procedure FillFixCommaText(AList: TStrings; const Value: String; Separator: Char = ',');
var
  P, P1: PChar;
  S: string;
  QUoteCnt: Integer;
begin
  AList.BeginUpdate;
  try
    AList.Clear;
    P := PChar(Value);
    while P^ in [#1..#31] do P := CharNext(P);
    while P^ <> #0 do
    begin
      if P^ = '"' then
        Begin
          QUoteCnt:=1;
          P1 := P;
          Repeat
            P:=CharNext(P);
            If P^ = '"' Then Inc(QUoteCnt);
          Until (((QUoteCnt mod 2) = 0) and (P^ = Separator)) or (P^ = #0);
          Inc(P1);
          SetString(S, P1, P - P1 - 1);
        End
      else
      begin
        P1 := P;
        while (P^ > ' ') and (P^ <> Separator) do P := CharNext(P);
        SetString(S, P1, P - P1);
      end;
      AList.Add(S);
      while P^ in [#1..#31] do P := CharNext(P);
      if P^ = Separator then
        repeat
          P := CharNext(P);
        until not (P^ in [#1..#31]);
    end;
  finally
    AList.EndUpdate;
    Finalize(S);
  end;
end;

function IsGarantInstalled: integer;
begin
 If AquireLauncher = '' then
  Result := GI_NOTFOUND
 else
  Result := GI_OK;
end;

function BuildCommand(aCommand: DWORD; aOpenInNewWindow: Bool; out aSize: Integer): Pointer;
begin
 aSize := SizeOf(TIntegrationData);
 GetMem(Result, aSize);
 with TIntegrationData(Result^) do
 begin
  Kind := idkCommand;
  OpenInNewWindow := aOpenInNewWindow;
  Command := aCommand;
 end;
end;

function BuildKey(aKey: PCHar; out aSize: Integer): Pointer;
begin
 aSize := SizeOf(TIntegrationData)+StrLen(aKey)+1;
 GetMem(Result, aSize);
 with TIntegrationData(Result^) do
 begin
  Kind := idkCheckIntegrationKey;
  KeyLength := StrLen(aKey);
  l3Move(aKey^,Key, KeyLength);
  PLongArray(@Key)^[KeyLength] := 0;
  OpenInNewWindow := False;
 end;
end;

function GarantProcessCommand(aCommand: DWORD; OpenInNewWindow: Bool;
 aTimeOut: DWORD):integer;
var
 l_Wnd: HWND;
 l_Data: Pointer;
 l_Size: Integer;
 l_Launched: Boolean;
 l_Handle: THandle;
begin
  l_Handle := CreateMutex(nil,False,c_IntergationMutexName);
  try
   Result := AquireGarant(l_Wnd, aTimeOut, l_Launched);
   if Result = GI_OK then
   begin
    EnterCriticalSection(g_QueueLock);
    try
     l_Data := BuildCommand(aCommand, OpenInNewWindow and not l_Launched, l_Size);
     try
      Result := TrySend(l_Wnd, l_Data, l_Size);
     finally
      FreeMem(l_Data, l_Size);
     end;
    finally
     LeaveCriticalSection(g_QueueLock);
    end;
   end;
  finally
   CloseHandle(l_Handle);
  end;
end;

function GarantDemoProcessCommand(aPath: PChar; anIntegrationKey: PChar;
 aCommand: DWORD; OpenInNewWindow: Bool; aTimeOut: DWORD):integer;
var
 l_Wnd: HWND;
 l_Data: Pointer;
 l_Size: Integer;
 l_Launched: Boolean;
 l_Handle: THandle;
begin
  l_Handle := CreateMutex(nil,False,c_IntergationMutexName);
  try
   Result := AquireGarant(l_Wnd, aTimeOut, l_Launched, StrPas(aPath));
   if Result = GI_OK then
   begin
    EnterCriticalSection(g_QueueLock);
    try
     l_Data := BuildKey(anIntegrationKey, l_Size);
     try
      Result := TrySend(l_Wnd, l_Data, l_Size);
     finally
      FreeMem(l_Data, l_Size);
     end;
     if Result = GI_OK then
     begin
      l_Data := BuildCommand(aCommand, OpenInNewWindow and not l_Launched, l_Size);
      try
       Result := TrySend(l_Wnd, l_Data, l_Size);
      finally
       FreeMem(l_Data, l_Size);
      end;
     end;
    finally
     LeaveCriticalSection(g_QueueLock);
    end;
   end;
  finally
   CloseHandle(l_Handle);
  end;
end;

function GarantShowLink(aRef:PChar; OpenInNewWindow: Bool; aTimeOut: DWORD):integer;
var
 l_Wnd: HWND;
 l_Data: Pointer;
 l_Size: Integer;
 l_Launched: Boolean;
 l_Handle: THandle;
begin
  l_Handle := CreateMutex(nil,False,c_IntergationMutexName);
  try
   Result := AquireGarant(l_Wnd, aTimeOut, l_Launched);
   if Result = GI_OK then
   begin
    EnterCriticalSection(g_QueueLock);
    try
     l_Data := BuildLink(aRef, OpenInNewWindow and not l_Launched, l_Size);
     try
      Result := TrySend(l_Wnd, l_Data, l_Size);
     finally
      FreeMem(l_Data, l_Size);
     end;
    finally
     LeaveCriticalSection(g_QueueLock);
    end;
   end;
  finally
   CloseHandle(l_Handle);
  end;
end;


function GarantDemoShowLink(aPath: PChar; anIntegrationKey: PChar; aRef:PChar;
 OpenInNewWindow: Bool; aTimeOut: DWORD):integer; stdcall;
var
 l_Wnd: HWND;
 l_Data: Pointer;
 l_Size: Integer;
 l_Launched: Boolean;
 l_Handle: THandle;
begin
  l_Handle := CreateMutex(nil,False,c_IntergationMutexName);
  try
   Result := AquireGarant(l_Wnd, aTimeOut, l_Launched, StrPas(aPath));
   if Result = GI_OK then
   begin
    EnterCriticalSection(g_QueueLock);
    try
     l_Data := BuildKey(anIntegrationKey, l_Size);
     try
      Result := TrySend(l_Wnd, l_Data, l_Size);
     finally
      FreeMem(l_Data, l_Size);
     end;
     if Result = GI_OK then
     begin
      l_Data := BuildLink(aRef, OpenInNewWindow and not l_Launched, l_Size);
      try
       Result := TrySend(l_Wnd, l_Data, l_Size);
      finally
       FreeMem(l_Data, l_Size);
      end;
     end;
    finally
     LeaveCriticalSection(g_QueueLock);
    end;
   end;
  finally
   CloseHandle(l_Handle);
  end;
end;

end.
