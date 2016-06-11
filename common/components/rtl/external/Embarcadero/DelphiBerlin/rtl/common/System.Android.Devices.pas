{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Android.Devices;

interface

const
  sSmallLdpiPhone = 'SmLdpiPh';   // Small low-density phone
  sSmallMdpiPhone = 'SmMdpiPh';   // Small meduim-density phone
  sSmallHdpiPhone = 'SmHdpiPh';   // Small high-density phone
  sSmallXhdpiPhone = 'SmXhdpiPh'; // Small extra-high-density phone

  sNormalLdpiPhone = 'NmLdpiPh';   // Normal low-density phone
  sNormalMdpiPhone = 'NmMdpiPh';   // Normal medium-density phone
  sNormalHdpiPhone = 'NmHdpiPh';   // Normal high-density phone
  sNormalXhdpiPhone = 'NmXhdpiPh'; // Normal extra-high-density phone

  sSmallLdpiMedia = 'SmLdpiMd';   // Small low-density media device
  sSmallMdpiMedia = 'SmMdpiMd';   // Small meduim-density media device
  sSmallHdpiMedia = 'SmHdpiMd';   // Small high-density media device
  sSmallXhdpiMedia = 'SmXhdpiMd'; // Small extra-high-density media device

  sNormalLdpiMedia = 'NmLdpiMd';   // Normal low-density media device
  sNormalMdpiMedia = 'NmMdpiMd';   // Normal medium-density media device
  sNormalHdpiMedia = 'NmHdpiMd';   // Normal high-density media device
  sNormalXhdpiMedia = 'NmXhdpiMd'; // Normal extra-high-density media device

  sLargeMdpiPhone = 'LgMdpiPh';   // Large medium-density phone
  sLargeHdpiPhone = 'LgHdpiPh';   // Large high-density phone
  sLargeXhdpiPhone = 'LgXhdpiPh'; // Large extra-high-density phone

  sLargeMdpiTablet = 'LgMdpiTb';   // Large medium-density tablet
  sLargeHdpiTablet = 'LgHdpiTb';   // Large high-density tablet
  sLargeXhdpiTablet = 'LgXhdpiTb'; // Large extra-high-density tablet

  sXLargeMdpiTablet = 'XLgMdpiTb';   // Large medium-density tablet
  sXLargeHdpiTablet = 'XLgHdpiTb';   // Large high-density tablet
  sXLargeXhdpiTablet = 'XLgXhdpiTb'; // Large extra-high-density tablet

  sGoogleGlass = 'GGlass'; // Google Glass wearable device
  sMoto360 = 'Moto360'; // Moto 360 Smart Watch
  sSonySW3 = 'SSW3'; // Sony SmartWatch 3

procedure AddDevices;

implementation

uses System.Types, System.SysUtils, System.Devices;

type
  TDeviceRec = record
    ID: string;
    DevClass: TDeviceInfo.TDeviceClass;
    MinLogicalSize, MaxLogicalSize: TSize;
    MinPhysicalSize, MaxPhysicalSize: TSize;
    PPI: Integer;
    Exclusive: Boolean;
  end;

const
  DeviceCount = 8;
  Devices: array[0..DeviceCount - 1] of TDeviceRec = (
{    (ID: sSmallLdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 300; cy: 200); MaxLogicalSize: (cx: 340; cy: 280);
     MinPhysicalSize: (cx: 300; cy: 200); MaxPhysicalSize: (cx: 340; cy: 280); PPI: 120),
    (ID: sSmallMdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 300; cy: 200); MaxLogicalSize: (cx: 340; cy: 280);
     MinPhysicalSize: (cx: 400; cy: 260); MaxPhysicalSize: (cx: 450; cy: 370); PPI: 160),
    (ID: sSmallHdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 300; cy: 200); MaxLogicalSize: (cx: 340; cy: 280);
     MinPhysicalSize: (cx: 600; cy: 400); MaxPhysicalSize: (cx: 680; cy: 520); PPI: 240), }
    (ID: sSmallXhdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 400; cy: 250); MaxLogicalSize: (cx: 500; cy: 300);
     MinPhysicalSize: (cx: 800; cy: 500); MaxPhysicalSize: (cx: 1000; cy: 600); PPI: 320; Exclusive: False),

{    (ID: sNormalLdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 350; cy: 200); MaxLogicalSize: (cx: 400; cy: 320);
     MinPhysicalSize: (cx: 350; cy: 200); MaxPhysicalSize: (cx: 400; cy: 320); PPI: 120),
    (ID: sNormalMdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 350; cy: 200); MaxLogicalSize: (cx: 400; cy: 320);
     MinPhysicalSize: (cx: 466; cy: 266); MaxPhysicalSize: (cx: 533; cy: 426); PPI: 160),
    (ID: sNormalHdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 350; cy: 200); MaxLogicalSize: (cx: 400; cy: 320);
     MinPhysicalSize: (cx: 700; cy: 400); MaxPhysicalSize: (cx: 800; cy: 640); PPI: 240), }
    (ID: sNormalXhdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 640; cy: 400); MaxLogicalSize: (cx: 680; cy: 425);
     MinPhysicalSize: (cx: 1168; cy: 730); MaxPhysicalSize: (cx: 1360; cy: 850); PPI: 320; Exclusive: False),

{    (ID: sSmallLdpiMedia; DevClass: TDeviceInfo.TDeviceClass.MediaPlayer;
     MinLogicalSize: (cx: 300; cy: 200); MaxLogicalSize: (cx: 340; cy: 280);
     MinPhysicalSize: (cx: 300; cy: 200); MaxPhysicalSize: (cx: 340; cy: 280); PPI: 120),
    (ID: sSmallMdpiMedia; DevClass: TDeviceInfo.TDeviceClass.MediaPlayer;
     MinLogicalSize: (cx: 300; cy: 200); MaxLogicalSize: (cx: 340; cy: 280);
     MinPhysicalSize: (cx: 400; cy: 260); MaxPhysicalSize: (cx: 450; cy: 370); PPI: 160),
    (ID: sSmallHdpiMedia; DevClass: TDeviceInfo.TDeviceClass.MediaPlayer;
     MinLogicalSize: (cx: 300; cy: 200); MaxLogicalSize: (cx: 340; cy: 280);
     MinPhysicalSize: (cx: 600; cy: 400); MaxPhysicalSize: (cx: 680; cy: 520); PPI: 240),
    (ID: sSmallXhdpiMedia; DevClass: TDeviceInfo.TDeviceClass.MediaPlayer;
     MinLogicalSize: (cx: 300; cy: 200); MaxLogicalSize: (cx: 340; cy: 280);
     MinPhysicalSize: (cx: 800; cy: 530); MaxPhysicalSize: (cx: 906; cy: 746); PPI: 320),

    (ID: sNormalLdpiMedia; DevClass: TDeviceInfo.TDeviceClass.MediaPlayer;
     MinLogicalSize: (cx: 350; cy: 200); MaxLogicalSize: (cx: 400; cy: 320);
     MinPhysicalSize: (cx: 350; cy: 200); MaxPhysicalSize: (cx: 400; cy: 320); PPI: 120),
    (ID: sNormalMdpiMedia; DevClass: TDeviceInfo.TDeviceClass.MediaPlayer;
     MinLogicalSize: (cx: 350; cy: 200); MaxLogicalSize: (cx: 400; cy: 320);
     MinPhysicalSize: (cx: 466; cy: 266); MaxPhysicalSize: (cx: 533; cy: 426); PPI: 160),
    (ID: sNormalHdpiMedia; DevClass: TDeviceInfo.TDeviceClass.MediaPlayer;
     MinLogicalSize: (cx: 350; cy: 200); MaxLogicalSize: (cx: 400; cy: 320);
     MinPhysicalSize: (cx: 700; cy: 400); MaxPhysicalSize: (cx: 800; cy: 640); PPI: 240),
    (ID: sNormalXhdpiMedia; DevClass: TDeviceInfo.TDeviceClass.MediaPlayer;
     MinLogicalSize: (cx: 350; cy: 200); MaxLogicalSize: (cx: 400; cy: 320);
     MinPhysicalSize: (cx: 933; cy: 530); MaxPhysicalSize: (cx: 1066; cy: 853); PPI: 320),

    (ID: sLargeMdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 800; cy: 480); MaxLogicalSize: (cx: 854; cy: 480);
     MinPhysicalSize: (cx: 800; cy: 480); MaxPhysicalSize: (cx: 854; cy: 480); PPI: 160),
    (ID: sLargeHdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 800; cy: 480); MaxLogicalSize: (cx: 854; cy: 480);
     MinPhysicalSize: (cx: 1200; cy: 720); MaxPhysicalSize: (cx: 1280; cy: 720); PPI: 240),}
    (ID: sLargeXhdpiPhone; DevClass: TDeviceInfo.TDeviceClass.Phone;
     MinLogicalSize: (cx: 720; cy: 450); MaxLogicalSize: (cx: 854; cy: 480);
     MinPhysicalSize: (cx: 1440; cy: 900); MaxPhysicalSize: (cx: 1708; cy: 960); PPI: 320; Exclusive: False),

{    (ID: sLargeMdpiTablet; DevClass: TDeviceInfo.TDeviceClass.Tablet;
     MinLogicalSize: (cx: 800; cy: 480); MaxLogicalSize: (cx: 854; cy: 480);
     MinPhysicalSize: (cx: 800; cy: 480); MaxPhysicalSize: (cx: 854; cy: 480); PPI: 160),
    (ID: sLargeHdpiTablet; DevClass: TDeviceInfo.TDeviceClass.Tablet;
     MinLogicalSize: (cx: 800; cy: 480); MaxLogicalSize: (cx: 854; cy: 480);
     MinPhysicalSize: (cx: 1200; cy: 720); MaxPhysicalSize: (cx: 1280; cy: 720); PPI: 240), }
    (ID: sLargeXhdpiTablet; DevClass: TDeviceInfo.TDeviceClass.Tablet;
     MinLogicalSize: (cx: 854; cy: 480); MaxLogicalSize: (cx: 960; cy: 600);
     MinPhysicalSize: (cx: 1708; cy: 960); MaxPhysicalSize: (cx: 1920; cy: 1200); PPI: 320; Exclusive: False),

{    (ID: sXLargeMdpiTablet; DevClass: TDeviceInfo.TDeviceClass.Tablet;
     MinLogicalSize: (cx: 1200; cy: 720); MaxLogicalSize: (cx: 1280; cy: 800);
     MinPhysicalSize: (cx: 1200; cy: 720); MaxPhysicalSize: (cx: 1280; cy: 800); PPI: 160),
    (ID: sXLargeHdpiTablet; DevClass: TDeviceInfo.TDeviceClass.Tablet;
     MinLogicalSize: (cx: 1200; cy: 720); MaxLogicalSize: (cx: 1280; cy: 800);
     MinPhysicalSize: (cx: 1800; cy: 1080); MaxPhysicalSize: (cx: 1920; cy: 1200); PPI: 240), }
    (ID: sXLargeXhdpiTablet; DevClass: TDeviceInfo.TDeviceClass.Tablet;
     MinLogicalSize: (cx: 1200; cy: 750); MaxLogicalSize: (cx: 1280; cy: 800);
     MinPhysicalSize: (cx: 2400; cy: 1500); MaxPhysicalSize: (cx: 2560; cy: 1600); PPI: 320; Exclusive: False),

    (ID: sGoogleGlass; DevClass: TDeviceInfo.TDeviceClass.Glasses;
     MinLogicalSize: (cx: 427; cy: 240); MaxLogicalSize: (cx: 427; cy: 240);
     MinPhysicalSize: (cx: 640; cy: 360); MaxPhysicalSize: (cx: 640; cy: 360); PPI: 240; Exclusive: True),

    (ID: sSonySW3; DevClass: TDeviceInfo.TDeviceClass.Watch;
     MinLogicalSize: (cx: 240; cy: 240); MaxLogicalSize: (cx: 240; cy: 240);
     MinPhysicalSize: (cx: 320; cy: 320); MaxPhysicalSize: (cx: 320; cy: 320); PPI: 283; Exclusive: True),

    (ID: sMoto360; DevClass: TDeviceInfo.TDeviceClass.Watch;
     MinLogicalSize: (cx: 240; cy: 218); MaxLogicalSize: (cx: 240; cy: 218);
     MinPhysicalSize: (cx: 320; cy: 290); MaxPhysicalSize: (cx: 320; cy: 290); PPI: 205; Exclusive: True));

procedure AddDevices;
var
  I: Integer;
begin
  for I := Low(Devices) to High(Devices) do
    with Devices[I] do
      TDeviceInfo.AddDevice(DevClass, ID, MinPhysicalSize, MinLogicalSize, MaxPhysicalSize, MaxLogicalSize, TOSVersion.TPlatform.pfAndroid, PPI, Exclusive);
end;

end.
