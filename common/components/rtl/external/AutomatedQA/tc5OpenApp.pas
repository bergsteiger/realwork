unit tc5OpenApp;

{$I tc5_ver.inc}

// GARANT {
{$IFNDEF NOT_HIDE_TC_CLIENT_ERROR}
  {$DEFINE HIDE_TC_CLIENT_ERROR}
{$ENDIF NOT_HIDE_TC_CLIENT_ERROR}

{$IFNDEF NOT_USE_TC_CLIENT_COMMAND_LINE}
  {$DEFINE USE_TC_CLIENT_COMMAND_LINE}
{$ENDIF USE_TC_CLIENT_COMMAND_LINE}
// } GARANT

interface

uses
  ActiveX, TypInfo, tc5OpenAppClasses;

procedure RegisterTestClasses(const Classes: array of TClass);

implementation

uses
  Windows, Classes, Controls, Forms, SysUtils, OleCtrls;

var
  DllHandle: THandle;
  ModuleKey: TGUID;
  ModuleInfoProvider: ItcModuleInfoProvider;

const
  c_tcOpenAppsDLL = 'tcOpenAppHook.dll';
  c_AddModule = 'AddDelphiModule';
  c_RemoveModule = 'RemoveDelphiModule';

const
  CMakeAsTCClient = 'MakeAsTCClient';

procedure ShowError(const Message: string);
begin
  {$IFNDEF HIDE_TC_CLIENT_ERROR}
  MessageBox(Application.Handle, PChar(Message), 'Error', MB_OK or MB_ICONSTOP);
  {$ENDIF}
end;

function GetRegStringValue(const Key, ValueName: string): string;
var
  Size: DWORD;
  Buffer: array[0..MAX_PATH] of Char;
  RegKey: HKEY;
begin
  Result := '';
  if RegOpenKeyEx(HKEY_LOCAL_MACHINE, PChar(Key), 0, KEY_READ, RegKey) = ERROR_SUCCESS then
  try
    Size := MAX_PATH;
    if RegQueryValueEx(RegKey, PChar(ValueName), nil, nil, PByte(PChar(@Buffer[0])), @Size) = ERROR_SUCCESS then
      Result := String(PChar(@Buffer[0]));
  finally
    RegCloseKey(RegKey);
  end;
end;

function GetPath_tcOpenApps: string;
const
  TCKey = 'SOFTWARE\Automated QA\Test Complete\5.0\Setup';
  TEKey = 'SOFTWARE\Automated QA\Test Execute\5.0\Setup';
begin
  Result := GetRegStringValue(TCKey, 'RootDir');
  if Result = '' then
    Result := GetRegStringValue(TEKey, 'RootDir');
  if Result <> '' then
    Result := Result + '\Bin\Extensions\' + c_tcOpenAppsDLL;

  if Result = '' then
    Result := ExtractFilePath(ParamStr(0)) + c_tcOpenAppsDLL;
end;

procedure InitOpenModule;
type
  TAddDelphiModule = function(const Module: ItcModuleInfoProvider; out ModuleKey: TGUID): WordBool; stdcall;
var
  AddDelphiModule: TAddDelphiModule;
begin
  {$IFDEF USE_TC_CLIENT_COMMAND_LINE}
  if not FindCmdLineSwitch(CMakeAsTCClient, ['-', '/', '\'], False) then
    exit;
  {$ENDIF USE_TC_CLIENT_COMMAND_LINE}

  if DllHandle = 0 then
  begin
    DllHandle := LoadLibrary(PChar(GetPath_tcOpenApps));
    if DllHandle <> 0 then
    begin
      AddDelphiModule := GetProcAddress(DllHandle, c_AddModule);
      Assert(@AddDelphiModule <> nil);
      ModuleInfoProvider := CreateModuleInfoProvider;
      if not AddDelphiModule(ModuleInfoProvider, ModuleKey) then
      begin
        FreeLibrary(DllHandle);
        DllHandle := 0;
        ShowError(Format('Cannot initialize the %s module as an Open Application.', [GetModuleName(HInstance)]));
      end;
    end
    else
      ShowError(Format('Cannot load the %s library.', [c_tcOpenAppsDLL]));
  end;
end;

procedure RemoveOpenModule;
type
  TRemoveDelphiModule = procedure(const ModuleKey: TGUID); stdcall;
var
  RemoveDelphiModule: TRemoveDelphiModule;
begin
  if DllHandle <> 0 then
  try
    RemoveDelphiModule := GetProcAddress(DllHandle, c_RemoveModule);
    Assert(@RemoveDelphiModule <> nil);
    RemoveDelphiModule(ModuleKey);
  finally
    FreeLibrary(DllHandle);
    DllHandle := 0;
    ModuleInfoProvider := nil;
  end;
end;

procedure RegisterTestClasses(const Classes: array of TClass);
var
  I: Integer;
  TestClassProviderInternal: ItcTestClassProviderInternal;
begin
  if ModuleInfoProvider <> nil then
  begin
    TestClassProviderInternal := ModuleInfoProvider.TestClassProvider as ItcTestClassProviderInternal;
    for I := Low(Classes) to High(Classes) do
      TestClassProviderInternal.RegisterClass(Classes[I]);
  end;
end;

initialization
  IsMultiThread := True;
  InitOpenModule;

finalization
  RemoveOpenModule;

end.
