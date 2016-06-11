{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.iOS.Devices;

interface

{  The identifiers below should never contain a device generation or version number within the name.
   Device selection is based on the physical size of the display and not the generation or version
   of the device. }

const
  siPhone = 'iPhone'; // iPhone with non retina display
  siPhoneRet = 'iPhoneRet'; // iPhone with retina display
  siPhone4in = 'iPhone4in'; // iPhone with 4 inch retina display
  siPhone47in = 'iPhone47in'; // iPhone with 4.7 inch retina display
  siPhone55in = 'iPhone55in'; // iPhone with 5.5 inch retina display
  siPod = 'iPod'; // iPod
  siPodRet = 'iPodRet'; // iPod with retina display
  siPod4in = 'iPod4in'; // iPod with 4in retina display
  siPad = 'iPad'; // iPad 1 & 2
  siPadMini = 'iPadMini'; // iPad Mini
  siPadRet = 'iPadRet'; // iPad 3 & 4, iPad Mini with retina display

procedure AddDevices;

implementation

uses System.Types, System.SysUtils, System.Devices;

// Unlike the desktop "devices" which vary in near infinite proportions, mobile devices are relatively more limited.
// Because of this, we can predefine the possible devices here without any "platform specific" input.
// NOTE: This code must be able to run on Windows, so never, ever put platform specific code or references into this
// unit.
procedure AddDevices;
begin
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Phone, siPhone, TSize.Create(480, 320),
    TSize.Create(480, 320), TOSVersion.TPlatform.pfiOS, 163 { Apple spec });
(*  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Phone, siPhoneRet, TSize.Create(960, 640),
    TSize.Create(480, 320), TOSVersion.TPlatform.pfiOS, 326 { Apple spec }); *)
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Phone, siPhone4in, TSize.Create(1136, 640),
    TSize.Create(568, 320), TOSVersion.TPlatform.pfiOS, 326 { Apple spec });
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Phone, siPhone47in, TSize.Create(1334, 750),
    TSize.Create(667, 375), TOSVersion.TPlatform.pfiOS, 326 { Apple spec });
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Phone, siPhone55in, TSize.Create(2208, 1242),
    TSize.Create(736, 414), TOSVersion.TPlatform.pfiOS, 489);
(*  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.MediaPlayer, siPod, TSize.Create(480, 320),
    TSize.Create(480, 320), TOSVersion.TPlatform.pfiOS, 163 { Apple spec });
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.MediaPlayer, siPodRet, TSize.Create(960, 640),
    TSize.Create(480, 320), TOSVersion.TPlatform.pfiOS, 326 { Apple spec });
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.MediaPlayer, siPod4in, TSize.Create(1136, 640),
    TSize.Create(568, 320), TOSVersion.TPlatform.pfiOS, 326 { Apple spec });
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Tablet, siPadMini, TSize.Create(2048, 1536),
    TSize.Create(1024, 768), TOSVersion.TPlatform.pfiOS, 326 { Apple spec });*)
  TDeviceInfo.AddDevice(TDeviceInfo.TDeviceClass.Tablet, siPad, TSize.Create(2048, 1536),
    TSize.Create(1024, 768), TOSVersion.TPlatform.pfiOS, 326 { Apple spec });
end;

end.
