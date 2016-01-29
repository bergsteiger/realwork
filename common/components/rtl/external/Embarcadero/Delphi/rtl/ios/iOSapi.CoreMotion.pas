{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework CoreMotion                }
{                                                          }
{ Copyright (c) 2010, Apple Inc. All rights reserved.      }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{   Copyright(c) 2012-2013 Embarcadero Technologies, Inc.  }
{                                                          }
{**********************************************************}

unit iOSapi.CoreMotion;

interface

uses Macapi.ObjectiveC,
  iOSapi.CocoaTypes;

const
  CMAttitudeReferenceFrameXArbitraryCorrectedZVertical = 2;
  CMAttitudeReferenceFrameXArbitraryZVertical = 1;
  CMAttitudeReferenceFrameXMagneticNorthZVertical = 4;
  CMAttitudeReferenceFrameXTrueNorthZVertical = 8;
  CMErrorDeviceRequiresMovement = 101;
  CMErrorNULL = 100;
  CMErrorTrueNorthNotAvailable = 102;
  CMMagneticFieldCalibrationAccuracyHigh = 2;
  CMMagneticFieldCalibrationAccuracyLow = 0;
  CMMagneticFieldCalibrationAccuracyMedium = 1;
  CMMagneticFieldCalibrationAccuracyUncalibrated = -1;

// ===== Typedefs and structs =====
{$M+}
type
  CMAttitudeReferenceFrame = NSUInteger;
  CMMagneticFieldCalibrationAccuracy = NSInteger;

  CMAcceleration = record
    x: Double;
    y: Double;
    z: Double;
  end;

  CMMagneticField = record
    x: Double;
    y: Double;
    z: Double;
  end;

  CMCalibratedMagneticField = record
    field: CMMagneticField;
    accuracy: CMMagneticFieldCalibrationAccuracy;
  end;

  CMRotationMatrix = record
    m11, m12, m13: Double;
    m21, m22, m23: Double;
    m31, m32, m33: Double;
  end;

  CMRotationRate = record
    x: Double;
    y: Double;
    z: Double;
  end;

  CMQuaternion = record
    x: Double;
    y: Double;
    z: Double;
    w: Double;
  end;

// ===== External functions =====

const
  libCoreMotion = '/System/Library/Frameworks/CoreMotion.framework/CoreMotion';


type
{$M+}
// ===== Forward declarations =====

  CMLogItem = interface;
  CMAttitude = interface;
  CMMotionManager = interface;
  CMMagnetometerData = interface;
  CMAccelerometerData = interface;
  CMDeviceMotion = interface;
  CMGyroData = interface;

// ===== Interface declarations =====

  CMLogItemClass = interface(NSObjectClass)
    ['{94AD5408-5C36-4438-B4D3-94D0548AD773}']
  end;
  CMLogItem = interface(NSObject)
    ['{5C9C9161-A569-4099-80AA-B3E13FA3FCB2}']
    function timestamp: NSTimeInterval; cdecl;
  end;
  TCMLogItem = class(TOCGenericImport<CMLogItemClass, CMLogItem>)  end;

  CMAttitudeClass = interface(NSObjectClass)
    ['{276D225F-4487-4726-87E2-DDC32747EC6E}']
  end;
  CMAttitude = interface(NSObject)
    ['{6C5DC6B9-02B2-45FE-842A-D21FAA09BABD}']
    procedure multiplyByInverseOfAttitude(attitude: CMAttitude); cdecl;
    function pitch: double; cdecl;
    function quaternion: CMQuaternion; cdecl;
    function roll: double; cdecl;
    function rotationMatrix: CMRotationMatrix; cdecl;
    function yaw: double; cdecl;
  end;
  TCMAttitude = class(TOCGenericImport<CMAttitudeClass, CMAttitude>)  end;

  CMMotionManagerClass = interface(NSObjectClass)
    ['{F7099C0F-3410-48CD-B18E-5C8A98DBACD4}']
    {class} function availableAttitudeReferenceFrames: NSUInteger; cdecl;
  end;
  CMMotionManager = interface(NSObject)
    ['{28BF5961-841D-40F8-91B5-D6B386D45E2E}']
    function accelerometerData: CMAccelerometerData; cdecl;
    function accelerometerUpdateInterval: NSTimeInterval; cdecl;
    function attitudeReferenceFrame: CMAttitudeReferenceFrame; cdecl;
    function deviceMotion: CMDeviceMotion; cdecl;
    function deviceMotionUpdateInterval: NSTimeInterval; cdecl;
    function gyroData: CMGyroData; cdecl;
    function gyroUpdateInterval: NSTimeInterval; cdecl;
    function isAccelerometerActive: Boolean; cdecl;
    function isAccelerometerAvailable: Boolean; cdecl;
    function isDeviceMotionActive: Boolean; cdecl;
    function isDeviceMotionAvailable: Boolean; cdecl;
    function isGyroActive: Boolean; cdecl;
    function isGyroAvailable: Boolean; cdecl;
    function isMagnetometerActive: Boolean; cdecl;
    function isMagnetometerAvailable: Boolean; cdecl;
    function magnetometerData: CMMagnetometerData; cdecl;
    function magnetometerUpdateInterval: NSTimeInterval; cdecl;
    procedure setAccelerometerUpdateInterval(accelerometerUpdateInterval: NSTimeInterval); cdecl;
    procedure setDeviceMotionUpdateInterval(deviceMotionUpdateInterval: NSTimeInterval); cdecl;
    procedure setGyroUpdateInterval(gyroUpdateInterval: NSTimeInterval); cdecl;
    procedure setMagnetometerUpdateInterval(magnetometerUpdateInterval: NSTimeInterval); cdecl;
    procedure setShowsDeviceMovementDisplay(showsDeviceMovementDisplay: Boolean); cdecl;
    function showsDeviceMovementDisplay: Boolean; cdecl;
    procedure startAccelerometerUpdates; cdecl;
    procedure startDeviceMotionUpdates; cdecl;
    procedure startDeviceMotionUpdatesUsingReferenceFrame(referenceFrame: CMAttitudeReferenceFrame); cdecl; overload;
    procedure startGyroUpdates; cdecl;
    procedure startMagnetometerUpdates; cdecl;
    procedure stopAccelerometerUpdates; cdecl;
    procedure stopDeviceMotionUpdates; cdecl;
    procedure stopGyroUpdates; cdecl;
    procedure stopMagnetometerUpdates; cdecl;
  end;
  TCMMotionManager = class(TOCGenericImport<CMMotionManagerClass, CMMotionManager>)  end;

  CMMagnetometerDataClass = interface(CMLogItemClass)
    ['{69ED80AF-51B9-417C-827C-101023DF3527}']
  end;
  CMMagnetometerData = interface(CMLogItem)
    ['{77FB8624-B966-4553-9F4E-947D0FC1867F}']
    function magneticField: CMMagneticField; cdecl;
  end;
  TCMMagnetometerData = class(TOCGenericImport<CMMagnetometerDataClass, CMMagnetometerData>)  end;

  CMAccelerometerDataClass = interface(CMLogItemClass)
    ['{F1210D8D-7700-4E5E-A87E-C53DC7A3C34E}']
  end;
  CMAccelerometerData = interface(CMLogItem)
    ['{FF6C3080-F946-42CD-82C0-F07617F2272A}']
    function acceleration: CMAcceleration; cdecl;
  end;
  TCMAccelerometerData = class(TOCGenericImport<CMAccelerometerDataClass, CMAccelerometerData>)  end;

  CMDeviceMotionClass = interface(CMLogItemClass)
    ['{66DC7DC9-E96D-407C-869E-6D28D63C4846}']
  end;
  CMDeviceMotion = interface(CMLogItem)
    ['{CFB6B9D3-EF36-4CCE-B0B4-8BFA18AA684B}']
    function attitude: CMAttitude; cdecl;
    function gravity: CMAcceleration; cdecl;
    function magneticField: CMCalibratedMagneticField; cdecl;
    function rotationRate: CMRotationRate; cdecl;
    function userAcceleration: CMAcceleration; cdecl;
  end;
  TCMDeviceMotion = class(TOCGenericImport<CMDeviceMotionClass, CMDeviceMotion>)  end;

  CMGyroDataClass = interface(CMLogItemClass)
    ['{2F4702BE-ED8E-4D10-9AA5-421D950FED0C}']
  end;
  CMGyroData = interface(CMLogItem)
    ['{3CB41300-E395-437C-81A1-950CABD4F410}']
    function rotationRate: CMRotationRate; cdecl;
  end;
  TCMGyroData = class(TOCGenericImport<CMGyroDataClass, CMGyroData>)  end;



implementation

end.
