{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{                Files: ShellScalingApi.h               }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit Winapi.ShellScaling;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses
  Winapi.ShlObj, Winapi.Windows, Winapi.MultiMon;

{$HPPEMIT '#include <ShellScalingApi.h>'}
{$HPPEMIT '#pragma comment(lib, "shcore")'}

const
  Shcore = 'Shcore.dll';

type
  DISPLAY_DEVICE_TYPE = (DEVICE_PRIMARY = 0, DEVICE_IMMERSIVE = 1);
{$EXTERNALSYM DISPLAY_DEVICE_TYPE}
  TDisplayDeviceType = DISPLAY_DEVICE_TYPE;

  SCALE_CHANGE_FLAGS = (SCF_VALUE_NONE = $00, SCF_SCALE = $01, SCF_PHYSICAL = $02);
{$EXTERNALSYM SCALE_CHANGE_FLAGS}
  TScaleChangeFlags = SCALE_CHANGE_FLAGS;

// Given a display device, return the preferred DEVICE_SCALE_FACTOR to be used for scaling values.
// Default is SCALE_100_PERCENT
{$EXTERNALSYM GetScaleFactorForDevice}
function GetScaleFactorForDevice(deviceType: TDisplayDeviceType ): DEVICE_SCALE_FACTOR; stdcall;

// Register a window to receive callbacks when scaling information changes.  The uMsgNotify param specifies a message
// that will be posted to the requesting window.  The wParam for this message is a combination of SCALE_CHANGE_FLAGS
{$EXTERNALSYM RegisterScaleChangeNotifications}
function RegisterScaleChangeNotifications(displayDevice: TDisplayDeviceType; hwndNotify: HWND; uMsgNotify: UINT;
          out pdwCookie: DWORD): HRESULT; stdcall;
{$EXTERNALSYM RevokeScaleChangeNotifications}
function RevokeScaleChangeNotifications(displayDevice: TDisplayDeviceType; dwCookie: DWORD): HRESULT; stdcall;

{$EXTERNALSYM GetScaleFactorForMonitor}
function GetScaleFactorForMonitor(hMon: HMONITOR; out Scale: DEVICE_SCALE_FACTOR): HRESULT; stdcall;
{$EXTERNALSYM RegisterScaleChangeEvent}
function RegisterScaleChangeEvent(hEvent: THandle; out pdwCookie: DWORD_PTR): HRESULT; stdcall;
{$EXTERNALSYM UnregisterScaleChangeEvent}
function UnregisterScaleChangeEvent(dwCookie: DWORD_PTR): HRESULT; stdcall;

type
  PROCESS_DPI_AWARENESS = (
    PROCESS_DPI_UNAWARE = 0,
    PROCESS_SYSTEM_DPI_AWARE = 1,
    PROCESS_PER_MONITOR_DPI_AWARE = 2);
  {$EXTERNALSYM PROCESS_DPI_AWARENESS}
  TProcessDpiAwareness = PROCESS_DPI_AWARENESS;

  MONITOR_DPI_TYPE = (
    MDT_EFFECTIVE_DPI = 0,
    MDT_ANGULAR_DPI = 1,
    MDT_RAW_DPI = 2,
    MDT_DEFAULT = MDT_EFFECTIVE_DPI);
  {$EXTERNALSYM MONITOR_DPI_TYPE}
  TMonitorDpiType = MONITOR_DPI_TYPE;


{$EXTERNALSYM SetProcessDpiAwareness}
function SetProcessDpiAwareness(value: TProcessDpiAwareness): HRESULT; stdcall;
{$EXTERNALSYM GetProcessDpiAwareness}
function GetProcessDpiAwareness(hprocess: THandle; out value: TProcessDpiAwareness): HRESULT; stdcall;
{$EXTERNALSYM GetDpiForMonitor}
function GetDpiForMonitor(hmonitor: HMONITOR; dpiType: TMonitorDpiType; out dpiX: UINT; out dpiY: UINT): HRESULT; stdcall;

type
  SHELL_UI_COMPONENT = (
    SHELL_UI_COMPONENT_TASKBARS         = 0,
    SHELL_UI_COMPONENT_NOTIFICATIONAREA = 1,
    SHELL_UI_COMPONENT_DESKBAND         = 2);
{$EXTERNALSYM SHELL_UI_COMPONENT}
  TShellUiComponent = SHELL_UI_COMPONENT;

function GetDpiForShellUIComponent(Component: TShellUiComponent): UINT; stdcall;
{$EXTERNALSYM GetDpiForShellUIComponent}

implementation

function GetScaleFactorForDevice; external Shcore name 'GetScaleFactorForDevice' delayed;
function RegisterScaleChangeNotifications; external Shcore name 'RegisterScaleChangeNotifications' delayed;
function RevokeScaleChangeNotifications; external Shcore name 'RevokeScaleChangeNotifications' delayed;
function GetScaleFactorForMonitor; external Shcore name 'GetScaleFactorForMonitor' delayed;
function RegisterScaleChangeEvent; external Shcore name 'RegisterScaleChangeEvent' delayed;
function UnregisterScaleChangeEvent; external Shcore name 'UnregisterScaleChangeEvent' delayed;
function SetProcessDpiAwareness; external Shcore name 'SetProcessDpiAwareness' delayed;
function GetProcessDpiAwareness; external Shcore name 'GetProcessDpiAwareness' delayed;
function GetDpiForMonitor; external Shcore name 'GetDpiForMonitor' delayed;
function GetDpiForShellUIComponent; external Shcore name 'GetDpiForShellUIComponent' delayed;

end.
