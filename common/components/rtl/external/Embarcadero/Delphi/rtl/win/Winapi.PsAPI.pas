{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{      File: psapi.h                                    }
{      Copyright (c) 1994-1999 Microsoft Corporation    }
{      All Rights Reserved.                             }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       WinNT process API Interface Unit                }
{*******************************************************}

unit Winapi.PsAPI;

interface

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

uses Winapi.Windows;

{$HPPEMIT '#include <psapi.h>'}

type
  PPointer = ^Pointer;

  TEnumProcesses = function (lpidProcess: LPDWORD; cb: DWORD; var cbNeeded: DWORD): BOOL stdcall;
  TEnumProcessModules = function (hProcess: THandle; lphModule: PHMODULE; cb: DWORD;
    var lpcbNeeded: DWORD): BOOL stdcall;
  TGetModuleBaseNameA = function (hProcess: THandle; hModule: HMODULE;
    lpBaseName: LPCSTR; nSize: DWORD): DWORD stdcall;
  TGetModuleBaseNameW = function (hProcess: THandle; hModule: HMODULE;
    lpBaseName: LPCWSTR; nSize: DWORD): DWORD stdcall;
  TGetModuleBaseName = TGetModuleBaseNameW;
  TGetModuleFileNameExA = function (hProcess: THandle; hModule: HMODULE;
    lpFilename: LPCSTR; nSize: DWORD): DWORD stdcall;
  TGetModuleFileNameExW = function (hProcess: THandle; hModule: HMODULE;
    lpFilename: LPCWSTR; nSize: DWORD): DWORD stdcall;
  TGetModuleFileNameEx = TGetModuleFileNameExW;

  {$EXTERNALSYM _MODULEINFO}
  _MODULEINFO = record
    lpBaseOfDll: Pointer;
    SizeOfImage: DWORD;
    EntryPoint: Pointer;
  end;
  {$EXTERNALSYM MODULEINFO}
  MODULEINFO = _MODULEINFO;
  {$EXTERNALSYM LPMODULEINFO}
  LPMODULEINFO = ^_MODULEINFO;
  TModuleInfo = _MODULEINFO;
  PModuleInfo = LPMODULEINFO;

  TGetModuleInformation = function (hProcess: THandle; hModule: HMODULE;
    lpmodinfo: LPMODULEINFO; cb: DWORD): BOOL stdcall;
  TEmptyWorkingSet = function (hProcess: THandle): BOOL stdcall;
  TQueryWorkingSet = function (hProcess: THandle; pv: Pointer; cb: DWORD): BOOL stdcall;
  TInitializeProcessForWsWatch = function (hProcess: THandle): BOOL stdcall;

  {$EXTERNALSYM _PSAPI_WS_WATCH_INFORMATION}
  _PSAPI_WS_WATCH_INFORMATION = record
    FaultingPc: Pointer;
    FaultingVa: Pointer;
  end;
  {$EXTERNALSYM PSAPI_WS_WATCH_INFORMATION}
  PSAPI_WS_WATCH_INFORMATION = _PSAPI_WS_WATCH_INFORMATION;
  {$EXTERNALSYM PPSAPI_WS_WATCH_INFORMATION}
  PPSAPI_WS_WATCH_INFORMATION = ^_PSAPI_WS_WATCH_INFORMATION;
  TPSAPIWsWatchInformation = _PSAPI_WS_WATCH_INFORMATION;
  PPSAPIWsWatchInformation = PPSAPI_WS_WATCH_INFORMATION;

  TGetWsChanges = function (hProcess: THandle; lpWatchInfo: PPSAPI_WS_WATCH_INFORMATION;
    cb: DWORD): BOOL stdcall;

  TGetMappedFileNameA = function (hProcess: THandle; lpv: Pointer;
    lpFilename: LPCSTR; nSize: DWORD): DWORD stdcall;
  TGetMappedFileNameW = function (hProcess: THandle; lpv: Pointer;
    lpFilename: LPCWSTR; nSize: DWORD): DWORD stdcall;
  TGetMappedFileName = TGetMappedFileNameW;
  TGetDeviceDriverBaseNameA = function (ImageBase: Pointer; lpBaseName: LPCSTR;
    nSize: DWORD): DWORD stdcall;
  TGetDeviceDriverBaseNameW = function (ImageBase: Pointer; lpBaseName: LPCWSTR;
    nSize: DWORD): DWORD stdcall;
  TGetDeviceDriverBaseName = TGetDeviceDriverBaseNameW;
  TGetDeviceDriverFileNameA = function (ImageBase: Pointer; lpFileName: LPCSTR;
    nSize: DWORD): DWORD stdcall;
  TGetDeviceDriverFileNameW = function (ImageBase: Pointer; lpFileName: LPCWSTR;
    nSize: DWORD): DWORD stdcall;
  TGetDeviceDriverFileName = TGetDeviceDriverFileNameW;

  TEnumDeviceDrivers = function (lpImageBase: PPointer; cb: DWORD;
    var lpcbNeeded: DWORD): BOOL stdcall;

  {$EXTERNALSYM _PROCESS_MEMORY_COUNTERS}
  _PROCESS_MEMORY_COUNTERS = record
    cb: DWORD;
    PageFaultCount: DWORD;
    PeakWorkingSetSize: SIZE_T;
    WorkingSetSize: SIZE_T;
    QuotaPeakPagedPoolUsage: SIZE_T;
    QuotaPagedPoolUsage: SIZE_T;
    QuotaPeakNonPagedPoolUsage: SIZE_T;
    QuotaNonPagedPoolUsage: SIZE_T;
    PagefileUsage: SIZE_T;
    PeakPagefileUsage: SIZE_T;
  end;
  {$EXTERNALSYM PROCESS_MEMORY_COUNTERS}
  PROCESS_MEMORY_COUNTERS = _PROCESS_MEMORY_COUNTERS;
  {$EXTERNALSYM PPROCESS_MEMORY_COUNTERS}
  PPROCESS_MEMORY_COUNTERS = ^_PROCESS_MEMORY_COUNTERS;
  TProcessMemoryCounters = _PROCESS_MEMORY_COUNTERS;
  PProcessMemoryCounters = ^_PROCESS_MEMORY_COUNTERS;

  TGetProcessMemoryInfo = function (Process: THandle;
    ppsmemCounters: PPROCESS_MEMORY_COUNTERS; cb: DWORD): BOOL stdcall;

{$EXTERNALSYM EnumProcesses}
function EnumProcesses(lpidProcess: LPDWORD; cb: DWORD; var cbNeeded: DWORD): BOOL;
{$EXTERNALSYM EnumProcessModules}
function EnumProcessModules(hProcess: THandle; lphModule: PHMODULE; cb: DWORD;
  var lpcbNeeded: DWORD): BOOL;
{$EXTERNALSYM GetModuleBaseName}
function GetModuleBaseName(hProcess: THandle; hModule: HMODULE;
  lpBaseName: LPCWSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetModuleBaseNameA}
function GetModuleBaseNameA(hProcess: THandle; hModule: HMODULE;
  lpBaseName: LPCSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetModuleBaseNameW}
function GetModuleBaseNameW(hProcess: THandle; hModule: HMODULE;
  lpBaseName: LPCWSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetModuleFileNameEx}
function GetModuleFileNameEx(hProcess: THandle; hModule: HMODULE;
  lpFilename: LPCWSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetModuleFileNameExA}
function GetModuleFileNameExA(hProcess: THandle; hModule: HMODULE;
  lpFilename: LPCSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetModuleFileNameExW}
function GetModuleFileNameExW(hProcess: THandle; hModule: HMODULE;
  lpFilename: LPCWSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetModuleInformation}
function GetModuleInformation(hProcess: THandle; hModule: HMODULE;
  lpmodinfo: LPMODULEINFO; cb: DWORD): BOOL;
{$EXTERNALSYM EmptyWorkingSet}
function EmptyWorkingSet(hProcess: THandle): BOOL;
{$EXTERNALSYM QueryWorkingSet}
function QueryWorkingSet(hProcess: THandle; pv: Pointer; cb: DWORD): BOOL;
{$EXTERNALSYM InitializeProcessForWsWatch}
function InitializeProcessForWsWatch(hProcess: THandle): BOOL;
{$EXTERNALSYM GetMappedFileName}
function GetMappedFileName(hProcess: THandle; lpv: Pointer;
  lpFilename: LPCWSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetMappedFileNameA}
function GetMappedFileNameA(hProcess: THandle; lpv: Pointer;
  lpFilename: LPCSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetMappedFileNameW}
function GetMappedFileNameW(hProcess: THandle; lpv: Pointer;
  lpFilename: LPCWSTR; nSize: DWORD): DWORD;
{$EXTERNALSYM GetDeviceDriverBaseName}
function GetDeviceDriverBaseName(ImageBase: Pointer; lpBaseName: LPCWSTR;
  nSize: DWORD): DWORD;
{$EXTERNALSYM GetDeviceDriverBaseNameA}
function GetDeviceDriverBaseNameA(ImageBase: Pointer; lpBaseName: LPCSTR;
  nSize: DWORD): DWORD;
{$EXTERNALSYM GetDeviceDriverBaseNameW}
function GetDeviceDriverBaseNameW(ImageBase: Pointer; lpBaseName: LPCWSTR;
  nSize: DWORD): DWORD;
{$EXTERNALSYM GetDeviceDriverFileName}
function GetDeviceDriverFileName(ImageBase: Pointer; lpFileName: LPCWSTR;
  nSize: DWORD): DWORD;
{$EXTERNALSYM GetDeviceDriverFileNameA}
function GetDeviceDriverFileNameA(ImageBase: Pointer; lpFileName: LPCSTR;
  nSize: DWORD): DWORD;
{$EXTERNALSYM GetDeviceDriverFileNameW}
function GetDeviceDriverFileNameW(ImageBase: Pointer; lpFileName: LPCWSTR;
  nSize: DWORD): DWORD;
{$EXTERNALSYM EnumDeviceDrivers}
function EnumDeviceDrivers(lpImageBase: PPointer; cb: DWORD;
  var lpcbNeeded: DWORD): BOOL;
{$EXTERNALSYM GetProcessMemoryInfo}
function GetProcessMemoryInfo(Process: THandle;
  ppsmemCounters: PPROCESS_MEMORY_COUNTERS; cb: DWORD): BOOL;

implementation

var
  hPSAPI: THandle;
  _EnumProcesses: TEnumProcesses;
  _EnumProcessModules: TEnumProcessModules;
  {procedure}_GetModuleBaseName: TGetModuleBaseNameW;
  {procedure}_GetModuleFileNameEx: TGetModuleFileNameExW;
  {procedure}_GetModuleBaseNameA: TGetModuleBaseNameA;
  {procedure}_GetModuleFileNameExA: TGetModuleFileNameExA;
  {procedure}_GetModuleBaseNameW: TGetModuleBaseNameW;
  {procedure}_GetModuleFileNameExW: TGetModuleFileNameExW;
  _GetModuleInformation: TGetModuleInformation;
  _EmptyWorkingSet: TEmptyWorkingSet;
  _QueryWorkingSet: TQueryWorkingSet;
  _InitializeProcessForWsWatch: TInitializeProcessForWsWatch;
  {procedure}_GetMappedFileName: TGetMappedFileNameW;
  {procedure}_GetDeviceDriverBaseName: TGetDeviceDriverBaseNameW;
  {procedure}_GetDeviceDriverFileName: TGetDeviceDriverFileNameW;
  {procedure}_GetMappedFileNameA: TGetMappedFileNameA;
  {procedure}_GetDeviceDriverBaseNameA: TGetDeviceDriverBaseNameA;
  {procedure}_GetDeviceDriverFileNameA: TGetDeviceDriverFileNameA;
  {procedure}_GetMappedFileNameW: TGetMappedFileNameW;
  {procedure}_GetDeviceDriverBaseNameW: TGetDeviceDriverBaseNameW;
  {procedure}_GetDeviceDriverFileNameW: TGetDeviceDriverFileNameW;
  _EnumDeviceDrivers: TEnumDeviceDrivers;
  _GetProcessMemoryInfo: TGetProcessMemoryInfo;

function CheckPSAPILoaded: Boolean;
begin
  if hPSAPI = 0 then
  begin
{$IFDEF MSWINDOWS}
    hPSAPI := LoadLibrary('PSAPI.dll');
    if hPSAPI < 32 then
    begin
      hPSAPI := 0;
      Result := False;
      Exit;
    end;
{$ENDIF}
    @_EnumProcesses := GetProcAddress(hPSAPI, 'EnumProcesses');
    @_EnumProcessModules := GetProcAddress(hPSAPI, 'EnumProcessModules');
    {procedure}@_GetModuleBaseName := GetProcAddress(hPSAPI, 'GetModuleBaseNameW');
    {procedure}@_GetModuleFileNameEx := GetProcAddress(hPSAPI, 'GetModuleFileNameExW');
    {procedure}@_GetModuleBaseNameA := GetProcAddress(hPSAPI, 'GetModuleBaseNameA');
    {procedure}@_GetModuleFileNameExA := GetProcAddress(hPSAPI, 'GetModuleFileNameExA');
    {procedure}@_GetModuleBaseNameW := GetProcAddress(hPSAPI, 'GetModuleBaseNameW');
    {procedure}@_GetModuleFileNameExW := GetProcAddress(hPSAPI, 'GetModuleFileNameExW');
    @_GetModuleInformation := GetProcAddress(hPSAPI, 'GetModuleInformation');
    @_EmptyWorkingSet := GetProcAddress(hPSAPI, 'EmptyWorkingSet');
    @_QueryWorkingSet := GetProcAddress(hPSAPI, 'QueryWorkingSet');
    @_InitializeProcessForWsWatch := GetProcAddress(hPSAPI, 'InitializeProcessForWsWatch');
    {procedure}@_GetMappedFileName := GetProcAddress(hPSAPI, 'GetMappedFileNameW');
    {procedure}@_GetDeviceDriverBaseName := GetProcAddress(hPSAPI, 'GetDeviceDriverBaseNameW');
    {procedure}@_GetDeviceDriverFileName := GetProcAddress(hPSAPI, 'GetDeviceDriverFileNameW');
    {procedure}@_GetMappedFileNameA := GetProcAddress(hPSAPI, 'GetMappedFileNameA');
    {procedure}@_GetDeviceDriverBaseNameA := GetProcAddress(hPSAPI, 'GetDeviceDriverBaseNameA');
    {procedure}@_GetDeviceDriverFileNameA := GetProcAddress(hPSAPI, 'GetDeviceDriverFileNameA');
    {procedure}@_GetMappedFileNameW := GetProcAddress(hPSAPI, 'GetMappedFileNameW');
    {procedure}@_GetDeviceDriverBaseNameW := GetProcAddress(hPSAPI, 'GetDeviceDriverBaseNameW');
    {procedure}@_GetDeviceDriverFileNameW := GetProcAddress(hPSAPI, 'GetDeviceDriverFileNameW');
    @_EnumDeviceDrivers := GetProcAddress(hPSAPI, 'EnumDeviceDrivers');
    @_GetProcessMemoryInfo := GetProcAddress(hPSAPI, 'GetProcessMemoryInfo');
  end;
  Result := True;
end;

function EnumProcesses(lpidProcess: LPDWORD; cb: DWORD; var cbNeeded: DWORD): BOOL;
begin
  if CheckPSAPILoaded then
    Result := _EnumProcesses(lpidProcess, cb, cbNeeded)
  else Result := False;
end;

function EnumProcessModules(hProcess: THandle; lphModule: PHMODULE; cb: DWORD;
  var lpcbNeeded: DWORD): BOOL;
begin
  if CheckPSAPILoaded then
    Result := _EnumProcessModules(hProcess, lphModule, cb, lpcbNeeded)
  else Result := False;
end;

function GetModuleBaseName(hProcess: THandle; hModule: HMODULE;
  lpBaseName: LPCWSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetModuleBaseName(hProcess, hModule, lpBaseName, nSize)
  else Result := 0;
end;

function GetModuleBaseNameA(hProcess: THandle; hModule: HMODULE;
  lpBaseName: LPCSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetModuleBaseNameA(hProcess, hModule, lpBaseName, nSize)
  else Result := 0;
end;

function GetModuleBaseNameW(hProcess: THandle; hModule: HMODULE;
  lpBaseName: LPCWSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetModuleBaseNameW(hProcess, hModule, lpBaseName, nSize)
  else Result := 0;
end;

function GetModuleFileNameEx(hProcess: THandle; hModule: HMODULE;
  lpFilename: LPCWSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetModuleFileNameEx(hProcess, hModule, lpFileName, nSize)
  else Result := 0;
end;

function GetModuleFileNameExA(hProcess: THandle; hModule: HMODULE;
  lpFilename: LPCSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetModuleFileNameExA(hProcess, hModule, lpFileName, nSize)
  else Result := 0;
end;

function GetModuleFileNameExW(hProcess: THandle; hModule: HMODULE;
  lpFilename: LPCWSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetModuleFileNameExW(hProcess, hModule, lpFileName, nSize)
  else Result := 0;
end;

function GetModuleInformation(hProcess: THandle; hModule: HMODULE;
  lpmodinfo: LPMODULEINFO; cb: DWORD): BOOL;
begin
  if CheckPSAPILoaded then
    Result := _GetModuleInformation(hProcess, hModule, lpmodinfo, cb)
  else Result := False;
end;

function EmptyWorkingSet(hProcess: THandle): BOOL;
begin
  if CheckPSAPILoaded then
    Result := _EmptyWorkingSet(hProcess)
  else Result := False;
end;

function QueryWorkingSet(hProcess: THandle; pv: Pointer; cb: DWORD): BOOL;
begin
  if CheckPSAPILoaded then
    Result := _QueryWorkingSet(hProcess, pv, cb)
  else Result := False;
end;

function InitializeProcessForWsWatch(hProcess: THandle): BOOL;
begin
  if CheckPSAPILoaded then
    Result := _InitializeProcessForWsWatch(hProcess)
  else Result := False;
end;

function GetMappedFileName(hProcess: THandle; lpv: Pointer;
  lpFilename: LPCWSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetMappedFileName(hProcess, lpv, lpFileName, nSize)
  else Result := 0;
end;

function GetMappedFileNameA(hProcess: THandle; lpv: Pointer;
  lpFilename: LPCSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetMappedFileNameA(hProcess, lpv, lpFileName, nSize)
  else Result := 0;
end;

function GetMappedFileNameW(hProcess: THandle; lpv: Pointer;
  lpFilename: LPCWSTR; nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetMappedFileNameW(hProcess, lpv, lpFileName, nSize)
  else Result := 0;
end;

function GetDeviceDriverBaseName(ImageBase: Pointer; lpBaseName: LPCWSTR;
  nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetDeviceDriverBasename(ImageBase, lpBaseName, nSize)
  else Result := 0;
end;

function GetDeviceDriverBaseNameA(ImageBase: Pointer; lpBaseName: LPCSTR;
  nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetDeviceDriverBasenameA(ImageBase, lpBaseName, nSize)
  else Result := 0;
end;

function GetDeviceDriverBaseNameW(ImageBase: Pointer; lpBaseName: LPCWSTR;
  nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetDeviceDriverBasenameW(ImageBase, lpBaseName, nSize)
  else Result := 0;
end;

function GetDeviceDriverFileName(ImageBase: Pointer; lpFileName: LPCWSTR;
  nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetDeviceDriverFileName(ImageBase, lpFileName, nSize)
  else Result := 0;
end;

function GetDeviceDriverFileNameA(ImageBase: Pointer; lpFileName: LPCSTR;
  nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetDeviceDriverFileNameA(ImageBase, lpFileName, nSize)
  else Result := 0;
end;

function GetDeviceDriverFileNameW(ImageBase: Pointer; lpFileName: LPCWSTR;
  nSize: DWORD): DWORD;
begin
  if CheckPSAPILoaded then
    Result := _GetDeviceDriverFileNameW(ImageBase, lpFileName, nSize)
  else Result := 0;
end;

function EnumDeviceDrivers(lpImageBase: PPointer; cb: DWORD;
  var lpcbNeeded: DWORD): BOOL;
begin
  if CheckPSAPILoaded then
    Result := _EnumDeviceDrivers(lpImageBase, cb, lpcbNeeded)
  else Result := False;
end;

function GetProcessMemoryInfo(Process: THandle;
  ppsmemCounters: PPROCESS_MEMORY_COUNTERS; cb: DWORD): BOOL;
begin
  if CheckPSAPILoaded then
    Result := _GetProcessMemoryInfo(Process, ppsmemCounters, cb)
  else Result := False;
end;

end.
