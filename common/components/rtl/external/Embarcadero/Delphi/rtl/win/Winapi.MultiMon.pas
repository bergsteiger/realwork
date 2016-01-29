{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: multimon.h                             }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{*******************************************************}
{       Win32 Multi-monitor support Unit                }
{*******************************************************}

unit Winapi.MultiMon;

{$ALIGN ON}
{$MINENUMSIZE 4}

interface

uses Winapi.Windows;

const
  { additional GetSystemMetrics() codes }
  SM_XVIRTUALSCREEN = 76;
  {$EXTERNALSYM SM_XVIRTUALSCREEN}
  SM_YVIRTUALSCREEN = 77;
  {$EXTERNALSYM SM_YVIRTUALSCREEN}
  SM_CXVIRTUALSCREEN = 78;
  {$EXTERNALSYM SM_CXVIRTUALSCREEN}
  SM_CYVIRTUALSCREEN = 79;
  {$EXTERNALSYM SM_CYVIRTUALSCREEN}
  SM_CMONITORS = 80;
  {$EXTERNALSYM SM_CMONITORS}
  SM_SAMEDISPLAYFORMAT = 81;
  {$EXTERNALSYM SM_SAMEDISPLAYFORMAT}




  { if WINVER < 0x0500 && !defined(_WIN32_WINNT || _WIN32_WINNT < 0x0400) }
  // SM_CMETRICS = 76;
  { else if  WINVER == 0x500 }
  // SM_CMETRICS = 83;
  { else if WINVER == 0x501 }
  // SM_CMETRICS = 91;
  { else if WINVER == 0x600 }
  //SM_CMETRICS = 93;
  { else }
  SM_CMETRICS = 97;
  { endif }
  {$EXTERNALSYM SM_CMETRICS}

type







  HMONITOR = type THandle;
  {$EXTERNALSYM HMONITOR}


const
  MONITOR_DEFAULTTONULL = $0;
  {$EXTERNALSYM MONITOR_DEFAULTTONULL}
  MONITOR_DEFAULTTOPRIMARY = $1;
  {$EXTERNALSYM MONITOR_DEFAULTTOPRIMARY}
  MONITOR_DEFAULTTONEAREST = $2;
  {$EXTERNALSYM MONITOR_DEFAULTTONEAREST}
  MONITORINFOF_PRIMARY = $1;
  {$EXTERNALSYM MONITORINFOF_PRIMARY}

const
  CCHDEVICENAME = 32;
  {$EXTERNALSYM CCHDEVICENAME}

type
  {$EXTERNALSYM tagMONITORINFO}
  tagMONITORINFO = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
  end;

  {$EXTERNALSYM MONITORINFOA}
  MONITORINFOA = tagMONITORINFO;
  {$EXTERNALSYM MONITORINFOW}
  MONITORINFOW = tagMONITORINFO;
  {$EXTERNALSYM MONITORINFO}
  MONITORINFO = MONITORINFOW;
  {$EXTERNALSYM LPMONITORINFOA}
  LPMONITORINFOA = ^tagMONITORINFO;
  {$EXTERNALSYM LPMONITORINFOW}
  LPMONITORINFOW = ^tagMONITORINFO;
  {$EXTERNALSYM LPMONITORINFO}
  LPMONITORINFO = LPMONITORINFOW;
  {$EXTERNALSYM PMonitorInfoA}
  PMonitorInfoA = ^tagMONITORINFO;
  {$EXTERNALSYM PMonitorInfoW}
  PMonitorInfoW = ^tagMONITORINFO;
  {$EXTERNALSYM PMonitorInfo}
  PMonitorInfo = PMonitorInfoW;
  {$EXTERNALSYM TMonitorInfoA}
  TMonitorInfoA = tagMONITORINFO;
  {$EXTERNALSYM TMonitorInfoW}
  TMonitorInfoW = tagMONITORINFO;
  {$EXTERNALSYM TMonitorInfo}
  TMonitorInfo = TMonitorInfoW;

  {$EXTERNALSYM tagMONITORINFOEXA}
  tagMONITORINFOEXA = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
    szDevice: array[0..CCHDEVICENAME - 1] of AnsiChar;
  end;
  {$EXTERNALSYM tagMONITORINFOEXW}
  tagMONITORINFOEXW = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
    szDevice: array[0..CCHDEVICENAME - 1] of WideChar;
  end;
  {$EXTERNALSYM tagMONITORINFOEX}
  tagMONITORINFOEX = tagMONITORINFOEXW;
  {$EXTERNALSYM MONITORINFOEXA}
  MONITORINFOEXA = tagMONITORINFOEXA;
  {$EXTERNALSYM MONITORINFOEXW}
  MONITORINFOEXW = tagMONITORINFOEXW;
  {$EXTERNALSYM MONITORINFOEX}
  MONITORINFOEX = MONITORINFOEXW;
  {$EXTERNALSYM LPMONITORINFOEXA}
  LPMONITORINFOEXA = ^tagMONITORINFOEXA;
  {$EXTERNALSYM LPMONITORINFOEXW}
  LPMONITORINFOEXW = ^tagMONITORINFOEXW;
  {$EXTERNALSYM LPMONITORINFOEX}
  LPMONITORINFOEX = LPMONITORINFOEXW;
  {$EXTERNALSYM PMonitorInfoExA}
  PMonitorInfoExA = ^tagMONITORINFOEX;
  {$EXTERNALSYM PMonitorInfoExW}
  PMonitorInfoExW = ^tagMONITORINFOEX;
  {$EXTERNALSYM PMonitorInfoEx}
  PMonitorInfoEx = PMonitorInfoExW;
  {$EXTERNALSYM TMonitorInfoExA}
  TMonitorInfoExA = tagMONITORINFOEX;
  {$EXTERNALSYM TMonitorInfoExW}
  TMonitorInfoExW = tagMONITORINFOEX;
  {$EXTERNALSYM TMonitorInfoEx}
  TMonitorInfoEx = TMonitorInfoExW;

{$EXTERNALSYM TMonitorEnumProc}
  TMonitorEnumProc = function(hm: HMONITOR; dc: HDC; r: PRect; l: LPARAM): Boolean; stdcall;

{$EXTERNALSYM MonitorFromWindow}
function MonitorFromWindow(hWnd: HWND; dwFlags: DWORD): HMONITOR; stdcall;
{$EXTERNALSYM MonitorFromRect}
function MonitorFromRect(lprcScreenCoords: PRect; dwFlags: DWORD): HMONITOR; stdcall;
{$EXTERNALSYM MonitorFromPoint}
function MonitorFromPoint(ptScreenCoords: TPoint; dwFlags: DWORD): HMONITOR; stdcall;
{$EXTERNALSYM GetMonitorInfo}
function GetMonitorInfo(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfo): Boolean; stdcall;
{$EXTERNALSYM GetMonitorInfoA}
function GetMonitorInfoA(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfoA): Boolean; stdcall;
{$EXTERNALSYM GetMonitorInfoW}
function GetMonitorInfoW(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfoW): Boolean; stdcall;
{$EXTERNALSYM EnumDisplayMonitors}
function EnumDisplayMonitors(hdc: HDC; lprcIntersect: PRect; lpfnEnumProc: TMonitorEnumProc;
  lData: LPARAM): Boolean; stdcall;

implementation

function MonitorFromWindow; external user32 name 'MonitorFromWindow';
function MonitorFromRect; external user32 name 'MonitorFromRect';
function MonitorFromPoint; external user32 name 'MonitorFromPoint';
function GetMonitorInfo; external user32 name 'GetMonitorInfoW';
function GetMonitorInfoA; external user32 name 'GetMonitorInfoA';
function GetMonitorInfoW; external user32 name 'GetMonitorInfoW';
function EnumDisplayMonitors; external user32 name 'EnumDisplayMonitors';

end.
