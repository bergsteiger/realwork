{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Mac.Devices;

interface

const
  sMacDesktopDevice = 'Macintosh'; // do not localize
  sMacRetinaDevice = 'Retina'; // do not localize

procedure AddDevices;

implementation

{$IFDEF MACOS}
uses Macapi.CocoaTypes, Macapi.Appkit, System.Types, System.SysUtils, System.Devices;

procedure AddDevices;
var
  Screen: NSScreen;
  Rect: NSRect;
  LogicalSize, PhysicalSize: TSize;
  Scale: CGFloat;
  DeviceID: string;
begin
  Screen := TNSScreen.Wrap(TNSScreen.OCClass.mainScreen);
  Rect := Screen.frame;
  Scale := Screen.backingScaleFactor;
  LogicalSize := TSize.Create(Trunc(Rect.size.width), Trunc(Rect.size.height));
  PhysicalSize := TSize.Create(Trunc(Rect.size.width * Scale), Trunc(Rect.size.height * Scale));
{  if Scale > 1.0 then
    DeviceID := sMacRetinaDevice
  else}
    DeviceID := sMacDesktopDevice;
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Desktop, DeviceID, PhysicalSize, LogicalSize,
    TOSVersion.TPlatform.pfMacOS, Trunc(110 * Scale));
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
uses Winapi.Windows, System.Types, System.SysUtils, System.Devices;

// Since the above code cannot work under Windows, we still need to simulate a "mac device" on Windows at design-time.
// We'll just synthesize a "mac" desktop device using the Windows metrics.
procedure AddDevices;
var
  LogicalSize, PhysicalSize: TSize;
begin
  LogicalSize := TSize.Create(GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN));
  PhysicalSize := TSize.Create(Trunc(LogicalSize.cx * 2.0), Trunc(LogicalSize.cy * 2.0));
  // For now use USER_DEFAULT_SCREEN_DPI - eventually this should be obtained from the OS, or if possible, calculated.
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Desktop, sMacDesktopDevice, LogicalSize, LogicalSize,
    TOSVersion.TPlatform.pfMacOS, USER_DEFAULT_SCREEN_DPI);
  // Simulate a retina display "device" by merely using a 2x scaling factor
//  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Desktop, sMacRetinaDevice, PhysicalSize, LogicalSize,
//    TOSVersion.TPlatform.pfMacOS, USER_DEFAULT_SCREEN_DPI * 2);
end;
{$ENDIF}

end.
