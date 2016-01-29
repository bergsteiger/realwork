unit vtShockwaveFix; {$IOCHECKS OFF}

// Данный модуль "лечит" проблему "черных" квадратов, появляющихся на месте флешей в IE (см. http://mdp.garant.ru/x/KIbBC).

interface

implementation

uses
  Windows,
  ImageHlp,
  
  SysUtils
  ;

type
 TRegOpenKeyACall = function(a_Key: HKEY; a_SubKey: PAnsiChar; var a_Result: HKEY): Longint; stdcall;
 TRegOpenKeyExACall = function(a_Key: HKEY; a_SubKey: PAnsiChar; a_Options: DWORD; a_Desired: REGSAM; var a_Result: HKEY): Longint; stdcall;
 TRegOpenKeyWCall = function(a_Key: HKEY; a_SubKey: PWideChar; var a_Result: HKEY): Longint; stdcall;
 TRegOpenKeyExWCall = function(a_Key: HKEY; a_SubKey: PWideChar; a_Options: DWORD; a_Desired: REGSAM; var a_Result: HKEY): Longint; stdcall;

var
 g_MaxApplicationAddress: Pointer = nil;
 //
 g_RegOpenKeyACall: TRegOpenKeyACall;
 g_RegOpenKeyAProc: TFarProc absolute g_RegOpenKeyACall;
 //
 g_RegOpenKeyExACall: TRegOpenKeyExACall;
 g_RegOpenKeyExAProc: TFarProc absolute g_RegOpenKeyExACall;
 //
 g_RegOpenKeyWCall: TRegOpenKeyWCall;
 g_RegOpenKeyWProc: TFarProc absolute g_RegOpenKeyWCall;
 //
 g_RegOpenKeyExWCall: TRegOpenKeyExWCall;
 g_RegOpenKeyExWProc: TFarProc absolute g_RegOpenKeyExWCall;


function IsRegistryAccessBlocked(const a_Key: HKEY; const a_SubKey: string): Boolean;
 const
  c_BlockedCLSID: string = 'CLSID\{D27CDB6E-AE6D-11CF-96B8-444553540000}';
 var
  l_SubKey: string; 
begin
 l_SubKey := UpperCase(a_SubKey);
 //
 Result := (Pos(c_BlockedCLSID, l_SubKey) > 0);
 //
 if (Result) then
  WriteLN(Format('IsRegistryAccessBlocked: key "0x%.8x/%s" blocked', [a_Key, l_SubKey]));
end;

procedure ReplaceIATEntryInOneMod(const a_ModuleName: PChar; a_CurProc: TFarProc; a_NewProc: TFarProc; a_HModule: HModule);
 type
  PDebugData = ^TDebugData;
  TDebugData = packed record
   r_OpCode: Byte;
   r_Address: Pointer;
  end;
  //
  PImageImportDescriptor = ^TImageImportDescriptor;
  TImageImportDescriptor = record
   r_Characteristics: DWORD;
   r_TimeDateStamp: DWORD;
   r_ForwarderChain: DWORD;
   r_Name: DWORD;
   r_FirstThunk: DWORD;
  end;
  //
  PImageThunkData = ^TImageThunkData;
  TImageThunkData = record
   case Integer of
    0: (r_ForwarderString: DWORD);
    1: (r_Function: DWORD);
    2: (r_Ordinal: DWORD);
    3: (r_AddressOfData: DWORD);
  end;
 var
  l_ImageImportDescriptor: PImageImportDescriptor;
  l_ImageThunkData: PImageThunkData;
  //
  l_Found: Boolean;
  l_FoundProc: ^TFarProc;
  //
  l_DummyResult: DWORD;
  //
  l_SystemInfo: TSystemInfo;
begin
 l_ImageImportDescriptor := PImageImportDescriptor(ImageDirectoryEntryToData(Pointer(a_HModule), True, IMAGE_DIRECTORY_ENTRY_IMPORT, l_DummyResult));
 //
 if (l_ImageImportDescriptor <> nil) then begin
  while (l_ImageImportDescriptor^.r_Name <> 0) do begin
   if (StrIComp(PChar(DWORD(a_HModule)+ l_ImageImportDescriptor^.r_Name), a_ModuleName) = 0) then
    Break;
   //
   Inc(l_ImageImportDescriptor);
  end;
  //
  if (l_ImageImportDescriptor^.r_Name <> 0) then begin
   l_ImageThunkData := PImageThunkData(DWORD(a_HModule)+ l_ImageImportDescriptor^.r_FirstThunk);
   //
   while (l_ImageThunkData^.r_Function <> 0) do begin
    l_FoundProc := @l_ImageThunkData^.r_Function;
    l_Found := (l_FoundProc^ = a_CurProc);
    //
    if not (l_Found) then begin
     if (g_MaxApplicationAddress = nil) then begin
      GetSystemInfo (l_SystemInfo);
      //
      g_MaxApplicationAddress := l_SystemInfo.lpMaximumApplicationAddress;
     end;
     //
     if ((Cardinal(l_FoundProc^) > Cardinal(g_MaxApplicationAddress)) and (PDebugData(l_FoundProc^)^.r_OpCode = $68)) then begin
      l_FoundProc := @PDebugData(l_FoundProc^)^.r_Address;
      l_Found := (l_FoundProc^ = a_CurProc);
     end;
    end;
    //
    if (l_Found) then begin
     if not(WriteProcessMemory(GetCurrentProcess, l_FoundProc, @a_NewProc, SizeOf(a_NewProc), l_DummyResult)) then
      WriteLN(Format('ReplaceIATEntryInOneMod: set hook "0x%p -> 0x%p" FAILED', [a_CurProc, a_NewProc]));
     //
     Break;
    end;
    //
    Inc(l_ImageThunkData);
   end;
  end;
 end;
end;

function RegOpenKeyAProc(a_Key: HKEY; a_SubKey: PAnsiChar; var a_Result: HKEY): Longint; stdcall;
begin
 if IsRegistryAccessBlocked(a_Key, a_SubKey) then
  Result := Longint(ERROR_PATH_NOT_FOUND)
 else
  Result := g_RegOpenKeyACall(a_Key, a_SubKey, a_Result);
end;

function RegOpenKeyExAProc(a_Key: HKEY; a_SubKey: PAnsiChar; a_Options: DWORD; a_Desired: REGSAM; var a_Result: HKEY): Longint; stdcall;
begin
 if IsRegistryAccessBlocked(a_Key, a_SubKey) then
  Result := Longint(ERROR_PATH_NOT_FOUND)
 else
  Result := g_RegOpenKeyExACall(a_Key, a_SubKey, a_Options, a_Desired, a_Result);
end;

function RegOpenKeyWProc(a_Key: HKEY; a_SubKey: PWideChar; var a_Result: HKEY): Longint; stdcall;
begin
 if IsRegistryAccessBlocked(a_Key, a_SubKey) then
  Result := Longint(ERROR_PATH_NOT_FOUND)
 else
  Result := g_RegOpenKeyWCall(a_Key, a_SubKey, a_Result);
end;

function RegOpenKeyExWProc(a_Key: HKEY; a_SubKey: PWideChar; a_Options: DWORD; a_Desired: REGSAM; var a_Result: HKEY): Longint; stdcall;
begin
 if IsRegistryAccessBlocked(a_Key, a_SubKey) then
  Result := Longint(ERROR_PATH_NOT_FOUND)
 else
  Result := g_RegOpenKeyExWCall(a_Key, a_SubKey, a_Options, a_Desired, a_Result);
end;

const
 c_HModule: string = 'ole32.dll';
var
 l_HModule: HModule;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtShockwaveFix.pas initialization enter'); {$EndIf}
 g_RegOpenKeyAProc := GetProcAddress(GetModuleHandle(advapi32), 'RegOpenKeyA');
 g_RegOpenKeyExAProc := GetProcAddress(GetModuleHandle(advapi32), 'RegOpenKeyExA');
 //
 g_RegOpenKeyWProc := GetProcAddress(GetModuleHandle(advapi32), 'RegOpenKeyW');
 g_RegOpenKeyExWProc := GetProcAddress(GetModuleHandle(advapi32), 'RegOpenKeyExW');
 //
 Assert((g_RegOpenKeyAProc <> nil) and (g_RegOpenKeyExAProc <> nil) and (g_RegOpenKeyWProc <> nil) and (g_RegOpenKeyExWProc <> nil));
 //
 l_HModule := GetModuleHandle(PChar(c_HModule));
 if (l_HModule <> HModule(0)) then begin
  ReplaceIATEntryInOneMod(advapi32, g_RegOpenKeyAProc, @RegOpenKeyAProc, l_HModule);
  ReplaceIATEntryInOneMod(advapi32, g_RegOpenKeyExAProc, @RegOpenKeyExAProc, l_HModule);
  //
  ReplaceIATEntryInOneMod(advapi32, g_RegOpenKeyWProc, @RegOpenKeyWProc, l_HModule);
  ReplaceIATEntryInOneMod(advapi32, g_RegOpenKeyExWProc, @RegOpenKeyExWProc, l_HModule);
 end else
  WriteLN(Format('Warning: module "%s" not found in memory (hooks not set)', [c_HModule]));
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtShockwaveFix.pas initialization leave'); {$EndIf}
finalization
 l_HModule := GetModuleHandle(PChar(c_HModule));
 if (l_HModule <> HModule(0)) then begin
  ReplaceIATEntryInOneMod(advapi32, @RegOpenKeyExWProc, g_RegOpenKeyExWProc, l_HModule);
  ReplaceIATEntryInOneMod(advapi32, @RegOpenKeyWProc, g_RegOpenKeyWProc, l_HModule);
  //
  ReplaceIATEntryInOneMod(advapi32, @RegOpenKeyExAProc, g_RegOpenKeyExAProc, l_HModule);
  ReplaceIATEntryInOneMod(advapi32, @RegOpenKeyAProc, g_RegOpenKeyAProc, l_HModule);
 end;
end.
