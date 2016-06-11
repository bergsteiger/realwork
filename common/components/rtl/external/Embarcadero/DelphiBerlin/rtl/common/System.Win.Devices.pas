{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Win.Devices;

interface

const
  sWinDesktopDevice = 'Windows'; // do not localize
  sWinSurfaceDevice = 'Surface'; // do not localize

procedure AddDevices;

implementation

uses Winapi.Windows, System.Types, System.SysUtils, System.Devices;

// For Windows there are only a couple of "unique" devices. Most are "desktop" class devices. Even Notebooks,
// NetBooks and the new Surface Pro are considered "desktop" devices for the purposes of the device registry.
// We will, however, acquire the system metrics and formulate a "device" that matches the physical hardware on which
// this application is running.
procedure AddDevices;
var
  ScreenSize: TSize;
begin
  // Use the dimensions of the primary screen monitor for determining the actual screen size
  ScreenSize := TSize.Create(GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN));
  // For now use USER_DEFAULT_SCREEN_DPI - eventually this should be obtained from the OS, or if possible, calculated.
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Desktop, sWinDesktopDevice, ScreenSize, ScreenSize,
    TOSVersion.TPlatform.pfWindows, USER_DEFAULT_SCREEN_DPI);
  // if GetSystemMetrics(SM_TABLETPC) > 0 then <system is a tablet PC edition of Windows>
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Tablet, sWinSurfaceDevice, ScreenSize, ScreenSize,
    TOSVersion.TPlatform.pfWindows, USER_DEFAULT_SCREEN_DPI, True);
end;

end.
