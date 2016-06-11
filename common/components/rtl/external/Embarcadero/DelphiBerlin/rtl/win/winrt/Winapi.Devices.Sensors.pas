{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Devices.Sensors;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Devices.Sensors Class Names
  // Windows.Devices.Sensors.Accelerometer
  // DualAPI
  SAccelerometer = 'Windows.Devices.Sensors.Accelerometer';
  // Windows.Devices.Sensors.AccelerometerReading
  // DualAPI
  SAccelerometerReading = 'Windows.Devices.Sensors.AccelerometerReading';
  // Windows.Devices.Sensors.AccelerometerReadingChangedEventArgs
  // DualAPI
  SAccelerometerReadingChangedEventArgs = 'Windows.Devices.Sensors.AccelerometerReadingChangedEventArgs';
  // Windows.Devices.Sensors.AccelerometerShakenEventArgs
  // DualAPI
  SAccelerometerShakenEventArgs = 'Windows.Devices.Sensors.AccelerometerShakenEventArgs';
  // Windows.Devices.Sensors.Inclinometer
  // DualAPI
  SInclinometer = 'Windows.Devices.Sensors.Inclinometer';
  // Windows.Devices.Sensors.InclinometerReading
  // DualAPI
  SInclinometerReading = 'Windows.Devices.Sensors.InclinometerReading';
  // Windows.Devices.Sensors.InclinometerReadingChangedEventArgs
  // DualAPI
  SInclinometerReadingChangedEventArgs = 'Windows.Devices.Sensors.InclinometerReadingChangedEventArgs';
  // Windows.Devices.Sensors.Gyrometer
  // DualAPI
  SGyrometer = 'Windows.Devices.Sensors.Gyrometer';
  // Windows.Devices.Sensors.GyrometerReading
  // DualAPI
  SGyrometerReading = 'Windows.Devices.Sensors.GyrometerReading';
  // Windows.Devices.Sensors.GyrometerReadingChangedEventArgs
  // DualAPI
  SGyrometerReadingChangedEventArgs = 'Windows.Devices.Sensors.GyrometerReadingChangedEventArgs';
  // Windows.Devices.Sensors.Compass
  // DualAPI
  SCompass = 'Windows.Devices.Sensors.Compass';
  // Windows.Devices.Sensors.CompassReading
  // DualAPI
  SCompassReading = 'Windows.Devices.Sensors.CompassReading';
  // Windows.Devices.Sensors.CompassReadingChangedEventArgs
  // DualAPI
  SCompassReadingChangedEventArgs = 'Windows.Devices.Sensors.CompassReadingChangedEventArgs';
  // Windows.Devices.Sensors.LightSensor
  // DualAPI
  SLightSensor = 'Windows.Devices.Sensors.LightSensor';
  // Windows.Devices.Sensors.LightSensorReading
  // DualAPI
  SLightSensorReading = 'Windows.Devices.Sensors.LightSensorReading';
  // Windows.Devices.Sensors.LightSensorReadingChangedEventArgs
  // DualAPI
  SLightSensorReadingChangedEventArgs = 'Windows.Devices.Sensors.LightSensorReadingChangedEventArgs';
  // Windows.Devices.Sensors.SensorRotationMatrix
  // DualAPI
  SSensorRotationMatrix = 'Windows.Devices.Sensors.SensorRotationMatrix';
  // Windows.Devices.Sensors.SensorQuaternion
  // DualAPI
  SSensorQuaternion = 'Windows.Devices.Sensors.SensorQuaternion';
  // Windows.Devices.Sensors.OrientationSensor
  // DualAPI
  SOrientationSensor = 'Windows.Devices.Sensors.OrientationSensor';
  // Windows.Devices.Sensors.OrientationSensorReading
  // DualAPI
  SOrientationSensorReading = 'Windows.Devices.Sensors.OrientationSensorReading';
  // Windows.Devices.Sensors.OrientationSensorReadingChangedEventArgs
  // DualAPI
  SOrientationSensorReadingChangedEventArgs = 'Windows.Devices.Sensors.OrientationSensorReadingChangedEventArgs';
  // Windows.Devices.Sensors.SimpleOrientationSensor
  // DualAPI
  SSimpleOrientationSensor = 'Windows.Devices.Sensors.SimpleOrientationSensor';
  // Windows.Devices.Sensors.SimpleOrientationSensorOrientationChangedEventArgs
  // DualAPI
  SSimpleOrientationSensorOrientationChangedEventArgs = 'Windows.Devices.Sensors.SimpleOrientationSensorOrientationChangedEventArgs';
  // Windows.Devices.Sensors.Magnetometer
  // DualAPI
  SMagnetometer = 'Windows.Devices.Sensors.Magnetometer';
  // Windows.Devices.Sensors.MagnetometerReading
  // DualAPI
  SMagnetometerReading = 'Windows.Devices.Sensors.MagnetometerReading';
  // Windows.Devices.Sensors.MagnetometerReadingChangedEventArgs
  // DualAPI
  SMagnetometerReadingChangedEventArgs = 'Windows.Devices.Sensors.MagnetometerReadingChangedEventArgs';
  // Windows.Devices.Sensors.ActivitySensor
  // DualAPI
  SActivitySensor = 'Windows.Devices.Sensors.ActivitySensor';
  // Windows.Devices.Sensors.ActivitySensorReading
  // DualAPI
  SActivitySensorReading = 'Windows.Devices.Sensors.ActivitySensorReading';
  // Windows.Devices.Sensors.ActivitySensorReadingChangedEventArgs
  // DualAPI
  SActivitySensorReadingChangedEventArgs = 'Windows.Devices.Sensors.ActivitySensorReadingChangedEventArgs';
  // Windows.Devices.Sensors.ActivitySensorReadingChangeReport
  // DualAPI
  SActivitySensorReadingChangeReport = 'Windows.Devices.Sensors.ActivitySensorReadingChangeReport';
  // Windows.Devices.Sensors.Barometer
  // DualAPI
  SBarometer = 'Windows.Devices.Sensors.Barometer';
  // Windows.Devices.Sensors.BarometerReading
  // DualAPI
  SBarometerReading = 'Windows.Devices.Sensors.BarometerReading';
  // Windows.Devices.Sensors.BarometerReadingChangedEventArgs
  // DualAPI
  SBarometerReadingChangedEventArgs = 'Windows.Devices.Sensors.BarometerReadingChangedEventArgs';
  // Windows.Devices.Sensors.PedometerReading
  // DualAPI
  SPedometerReading = 'Windows.Devices.Sensors.PedometerReading';
  // Windows.Devices.Sensors.Pedometer
  // DualAPI
  SPedometer = 'Windows.Devices.Sensors.Pedometer';
  // Windows.Devices.Sensors.PedometerReadingChangedEventArgs
  // DualAPI
  SPedometerReadingChangedEventArgs = 'Windows.Devices.Sensors.PedometerReadingChangedEventArgs';
  // Windows.Devices.Sensors.ProximitySensor
  // DualAPI
  SProximitySensor = 'Windows.Devices.Sensors.ProximitySensor';
  // Windows.Devices.Sensors.ProximitySensorReading
  // DualAPI
  SProximitySensorReading = 'Windows.Devices.Sensors.ProximitySensorReading';
  // Windows.Devices.Sensors.ProximitySensorReadingChangedEventArgs
  // DualAPI
  SProximitySensorReadingChangedEventArgs = 'Windows.Devices.Sensors.ProximitySensorReadingChangedEventArgs';
  // Windows.Devices.Sensors.ProximitySensorDisplayOnOffController
  // DualAPI
  SProximitySensorDisplayOnOffController = 'Windows.Devices.Sensors.ProximitySensorDisplayOnOffController';
  // Windows.Devices.Sensors.Altimeter
  // DualAPI
  SAltimeter = 'Windows.Devices.Sensors.Altimeter';
  // Windows.Devices.Sensors.AltimeterReading
  // DualAPI
  SAltimeterReading = 'Windows.Devices.Sensors.AltimeterReading';
  // Windows.Devices.Sensors.AltimeterReadingChangedEventArgs
  // DualAPI
  SAltimeterReadingChangedEventArgs = 'Windows.Devices.Sensors.AltimeterReadingChangedEventArgs';
  // Windows.Devices.Sensors.Custom.CustomSensor
  // DualAPI
  SCustom_CustomSensor = 'Windows.Devices.Sensors.Custom.CustomSensor';
  // Windows.Devices.Sensors.Custom.CustomSensorReading
  // DualAPI
  SCustom_CustomSensorReading = 'Windows.Devices.Sensors.Custom.CustomSensorReading';
  // Windows.Devices.Sensors.Custom.CustomSensorReadingChangedEventArgs
  // DualAPI
  SCustom_CustomSensorReadingChangedEventArgs = 'Windows.Devices.Sensors.Custom.CustomSensorReadingChangedEventArgs';


type
  // Forward declare interfaces
  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Sensors.ActivityType>
  IIterator_1__ActivityType = interface;
  PIIterator_1__ActivityType = ^IIterator_1__ActivityType;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.ActivityType>
  IIterable_1__ActivityType = interface;
  PIIterable_1__ActivityType = ^IIterable_1__ActivityType;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.ActivityType>
  IVectorView_1__ActivityType = interface;
  PIVectorView_1__ActivityType = ^IVectorView_1__ActivityType;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Sensors.ActivityType>
  IVector_1__ActivityType = interface;
  PIVector_1__ActivityType = ^IVector_1__ActivityType;

  // Windows.Devices.Sensors.IAccelerometerDeviceId
  IAccelerometerDeviceId = interface;
  PIAccelerometerDeviceId = ^IAccelerometerDeviceId;

  // Windows.Devices.Sensors.IAccelerometerReading
  IAccelerometerReading = interface;
  PIAccelerometerReading = ^IAccelerometerReading;

  // Windows.Devices.Sensors.IAccelerometerReadingChangedEventArgs
  IAccelerometerReadingChangedEventArgs = interface;
  PIAccelerometerReadingChangedEventArgs = ^IAccelerometerReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAccelerometer,Windows.Devices.Sensors.IAccelerometerReadingChangedEventArgs>
  TypedEventHandler_2__IAccelerometer__IAccelerometerReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IAccelerometer__IAccelerometerReadingChangedEventArgs = ^TypedEventHandler_2__IAccelerometer__IAccelerometerReadingChangedEventArgs;

  // Windows.Devices.Sensors.IAccelerometerShakenEventArgs
  IAccelerometerShakenEventArgs = interface;
  PIAccelerometerShakenEventArgs = ^IAccelerometerShakenEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAccelerometer,Windows.Devices.Sensors.IAccelerometerShakenEventArgs>
  TypedEventHandler_2__IAccelerometer__IAccelerometerShakenEventArgs = interface;
  PTypedEventHandler_2__IAccelerometer__IAccelerometerShakenEventArgs = ^TypedEventHandler_2__IAccelerometer__IAccelerometerShakenEventArgs;

  // Windows.Devices.Sensors.IAccelerometer
  IAccelerometer = interface;
  PIAccelerometer = ^IAccelerometer;

  // Windows.Devices.Sensors.IAccelerometerStatics
  IAccelerometerStatics = interface;
  PIAccelerometerStatics = ^IAccelerometerStatics;

  // Windows.Devices.Sensors.IAccelerometer2
  IAccelerometer2 = interface;
  PIAccelerometer2 = ^IAccelerometer2;

  // Windows.Devices.Sensors.IAccelerometer3
  IAccelerometer3 = interface;
  PIAccelerometer3 = ^IAccelerometer3;

  // Windows.Devices.Sensors.IInclinometerDeviceId
  IInclinometerDeviceId = interface;
  PIInclinometerDeviceId = ^IInclinometerDeviceId;

  // Windows.Devices.Sensors.IInclinometerReading
  IInclinometerReading = interface;
  PIInclinometerReading = ^IInclinometerReading;

  // Windows.Devices.Sensors.IInclinometerReadingChangedEventArgs
  IInclinometerReadingChangedEventArgs = interface;
  PIInclinometerReadingChangedEventArgs = ^IInclinometerReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IInclinometer,Windows.Devices.Sensors.IInclinometerReadingChangedEventArgs>
  TypedEventHandler_2__IInclinometer__IInclinometerReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IInclinometer__IInclinometerReadingChangedEventArgs = ^TypedEventHandler_2__IInclinometer__IInclinometerReadingChangedEventArgs;

  // Windows.Devices.Sensors.IInclinometer
  IInclinometer = interface;
  PIInclinometer = ^IInclinometer;

  // Windows.Devices.Sensors.IInclinometerStatics
  IInclinometerStatics = interface;
  PIInclinometerStatics = ^IInclinometerStatics;

  // Windows.Devices.Sensors.IInclinometerStatics2
  IInclinometerStatics2 = interface;
  PIInclinometerStatics2 = ^IInclinometerStatics2;

  // Windows.Devices.Sensors.IInclinometer2
  IInclinometer2 = interface;
  PIInclinometer2 = ^IInclinometer2;

  // Windows.Devices.Sensors.IInclinometerReadingYawAccuracy
  IInclinometerReadingYawAccuracy = interface;
  PIInclinometerReadingYawAccuracy = ^IInclinometerReadingYawAccuracy;

  // Windows.Devices.Sensors.IGyrometerDeviceId
  IGyrometerDeviceId = interface;
  PIGyrometerDeviceId = ^IGyrometerDeviceId;

  // Windows.Devices.Sensors.IGyrometerReading
  IGyrometerReading = interface;
  PIGyrometerReading = ^IGyrometerReading;

  // Windows.Devices.Sensors.IGyrometerReadingChangedEventArgs
  IGyrometerReadingChangedEventArgs = interface;
  PIGyrometerReadingChangedEventArgs = ^IGyrometerReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IGyrometer,Windows.Devices.Sensors.IGyrometerReadingChangedEventArgs>
  TypedEventHandler_2__IGyrometer__IGyrometerReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IGyrometer__IGyrometerReadingChangedEventArgs = ^TypedEventHandler_2__IGyrometer__IGyrometerReadingChangedEventArgs;

  // Windows.Devices.Sensors.IGyrometer
  IGyrometer = interface;
  PIGyrometer = ^IGyrometer;

  // Windows.Devices.Sensors.IGyrometerStatics
  IGyrometerStatics = interface;
  PIGyrometerStatics = ^IGyrometerStatics;

  // Windows.Devices.Sensors.IGyrometer2
  IGyrometer2 = interface;
  PIGyrometer2 = ^IGyrometer2;

  // Windows.Devices.Sensors.ICompassDeviceId
  ICompassDeviceId = interface;
  PICompassDeviceId = ^ICompassDeviceId;

  // Windows.Devices.Sensors.ICompassReading
  ICompassReading = interface;
  PICompassReading = ^ICompassReading;

  // Windows.Devices.Sensors.ICompassReadingChangedEventArgs
  ICompassReadingChangedEventArgs = interface;
  PICompassReadingChangedEventArgs = ^ICompassReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ICompass,Windows.Devices.Sensors.ICompassReadingChangedEventArgs>
  TypedEventHandler_2__ICompass__ICompassReadingChangedEventArgs = interface;
  PTypedEventHandler_2__ICompass__ICompassReadingChangedEventArgs = ^TypedEventHandler_2__ICompass__ICompassReadingChangedEventArgs;

  // Windows.Devices.Sensors.ICompass
  ICompass = interface;
  PICompass = ^ICompass;

  // Windows.Devices.Sensors.ICompassStatics
  ICompassStatics = interface;
  PICompassStatics = ^ICompassStatics;

  // Windows.Devices.Sensors.ICompass2
  ICompass2 = interface;
  PICompass2 = ^ICompass2;

  // Windows.Devices.Sensors.ICompassReadingHeadingAccuracy
  ICompassReadingHeadingAccuracy = interface;
  PICompassReadingHeadingAccuracy = ^ICompassReadingHeadingAccuracy;

  // Windows.Devices.Sensors.ILightSensorDeviceId
  ILightSensorDeviceId = interface;
  PILightSensorDeviceId = ^ILightSensorDeviceId;

  // Windows.Devices.Sensors.ILightSensorReading
  ILightSensorReading = interface;
  PILightSensorReading = ^ILightSensorReading;

  // Windows.Devices.Sensors.ILightSensorReadingChangedEventArgs
  ILightSensorReadingChangedEventArgs = interface;
  PILightSensorReadingChangedEventArgs = ^ILightSensorReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ILightSensor,Windows.Devices.Sensors.ILightSensorReadingChangedEventArgs>
  TypedEventHandler_2__ILightSensor__ILightSensorReadingChangedEventArgs = interface;
  PTypedEventHandler_2__ILightSensor__ILightSensorReadingChangedEventArgs = ^TypedEventHandler_2__ILightSensor__ILightSensorReadingChangedEventArgs;

  // Windows.Devices.Sensors.ILightSensor
  ILightSensor = interface;
  PILightSensor = ^ILightSensor;

  // Windows.Devices.Sensors.ILightSensorStatics
  ILightSensorStatics = interface;
  PILightSensorStatics = ^ILightSensorStatics;

  // Windows.Devices.Sensors.ISensorRotationMatrix
  ISensorRotationMatrix = interface;
  PISensorRotationMatrix = ^ISensorRotationMatrix;

  // Windows.Devices.Sensors.ISensorQuaternion
  ISensorQuaternion = interface;
  PISensorQuaternion = ^ISensorQuaternion;

  // Windows.Devices.Sensors.IOrientationSensorDeviceId
  IOrientationSensorDeviceId = interface;
  PIOrientationSensorDeviceId = ^IOrientationSensorDeviceId;

  // Windows.Devices.Sensors.IOrientationSensorReading
  IOrientationSensorReading = interface;
  PIOrientationSensorReading = ^IOrientationSensorReading;

  // Windows.Devices.Sensors.IOrientationSensorReadingChangedEventArgs
  IOrientationSensorReadingChangedEventArgs = interface;
  PIOrientationSensorReadingChangedEventArgs = ^IOrientationSensorReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IOrientationSensor,Windows.Devices.Sensors.IOrientationSensorReadingChangedEventArgs>
  TypedEventHandler_2__IOrientationSensor__IOrientationSensorReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IOrientationSensor__IOrientationSensorReadingChangedEventArgs = ^TypedEventHandler_2__IOrientationSensor__IOrientationSensorReadingChangedEventArgs;

  // Windows.Devices.Sensors.IOrientationSensor
  IOrientationSensor = interface;
  PIOrientationSensor = ^IOrientationSensor;

  // Windows.Devices.Sensors.IOrientationSensorStatics
  IOrientationSensorStatics = interface;
  PIOrientationSensorStatics = ^IOrientationSensorStatics;

  // Windows.Devices.Sensors.IOrientationSensorStatics2
  IOrientationSensorStatics2 = interface;
  PIOrientationSensorStatics2 = ^IOrientationSensorStatics2;

  // Windows.Devices.Sensors.IOrientationSensor2
  IOrientationSensor2 = interface;
  PIOrientationSensor2 = ^IOrientationSensor2;

  // Windows.Devices.Sensors.IOrientationSensorReadingYawAccuracy
  IOrientationSensorReadingYawAccuracy = interface;
  PIOrientationSensorReadingYawAccuracy = ^IOrientationSensorReadingYawAccuracy;

  // Windows.Devices.Sensors.ISimpleOrientationSensorDeviceId
  ISimpleOrientationSensorDeviceId = interface;
  PISimpleOrientationSensorDeviceId = ^ISimpleOrientationSensorDeviceId;

  // Windows.Devices.Sensors.ISimpleOrientationSensorOrientationChangedEventArgs
  ISimpleOrientationSensorOrientationChangedEventArgs = interface;
  PISimpleOrientationSensorOrientationChangedEventArgs = ^ISimpleOrientationSensorOrientationChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ISimpleOrientationSensor,Windows.Devices.Sensors.ISimpleOrientationSensorOrientationChangedEventArgs>
  TypedEventHandler_2__ISimpleOrientationSensor__ISimpleOrientationSensorOrientationChangedEventArgs = interface;
  PTypedEventHandler_2__ISimpleOrientationSensor__ISimpleOrientationSensorOrientationChangedEventArgs = ^TypedEventHandler_2__ISimpleOrientationSensor__ISimpleOrientationSensorOrientationChangedEventArgs;

  // Windows.Devices.Sensors.ISimpleOrientationSensor
  ISimpleOrientationSensor = interface;
  PISimpleOrientationSensor = ^ISimpleOrientationSensor;

  // Windows.Devices.Sensors.ISimpleOrientationSensorStatics
  ISimpleOrientationSensorStatics = interface;
  PISimpleOrientationSensorStatics = ^ISimpleOrientationSensorStatics;

  // Windows.Devices.Sensors.ISimpleOrientationSensor2
  ISimpleOrientationSensor2 = interface;
  PISimpleOrientationSensor2 = ^ISimpleOrientationSensor2;

  // Windows.Devices.Sensors.IMagnetometerDeviceId
  IMagnetometerDeviceId = interface;
  PIMagnetometerDeviceId = ^IMagnetometerDeviceId;

  // Windows.Devices.Sensors.IMagnetometerReading
  IMagnetometerReading = interface;
  PIMagnetometerReading = ^IMagnetometerReading;

  // Windows.Devices.Sensors.IMagnetometerReadingChangedEventArgs
  IMagnetometerReadingChangedEventArgs = interface;
  PIMagnetometerReadingChangedEventArgs = ^IMagnetometerReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IMagnetometer,Windows.Devices.Sensors.IMagnetometerReadingChangedEventArgs>
  TypedEventHandler_2__IMagnetometer__IMagnetometerReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IMagnetometer__IMagnetometerReadingChangedEventArgs = ^TypedEventHandler_2__IMagnetometer__IMagnetometerReadingChangedEventArgs;

  // Windows.Devices.Sensors.IMagnetometer
  IMagnetometer = interface;
  PIMagnetometer = ^IMagnetometer;

  // Windows.Devices.Sensors.IMagnetometerStatics
  IMagnetometerStatics = interface;
  PIMagnetometerStatics = ^IMagnetometerStatics;

  // Windows.Devices.Sensors.IMagnetometer2
  IMagnetometer2 = interface;
  PIMagnetometer2 = ^IMagnetometer2;

  // Windows.Devices.Sensors.IActivitySensorReading
  IActivitySensorReading = interface;
  PIActivitySensorReading = ^IActivitySensorReading;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IActivitySensorReading>
  AsyncOperationCompletedHandler_1__IActivitySensorReading = interface;
  PAsyncOperationCompletedHandler_1__IActivitySensorReading = ^AsyncOperationCompletedHandler_1__IActivitySensorReading;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IActivitySensorReading>
  IAsyncOperation_1__IActivitySensorReading = interface;
  PIAsyncOperation_1__IActivitySensorReading = ^IAsyncOperation_1__IActivitySensorReading;

  // Windows.Devices.Sensors.IActivitySensorReadingChangedEventArgs
  IActivitySensorReadingChangedEventArgs = interface;
  PIActivitySensorReadingChangedEventArgs = ^IActivitySensorReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IActivitySensor,Windows.Devices.Sensors.IActivitySensorReadingChangedEventArgs>
  TypedEventHandler_2__IActivitySensor__IActivitySensorReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IActivitySensor__IActivitySensorReadingChangedEventArgs = ^TypedEventHandler_2__IActivitySensor__IActivitySensorReadingChangedEventArgs;

  // Windows.Devices.Sensors.IActivitySensor
  IActivitySensor = interface;
  PIActivitySensor = ^IActivitySensor;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IActivitySensor>
  AsyncOperationCompletedHandler_1__IActivitySensor = interface;
  PAsyncOperationCompletedHandler_1__IActivitySensor = ^AsyncOperationCompletedHandler_1__IActivitySensor;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IActivitySensor>
  IAsyncOperation_1__IActivitySensor = interface;
  PIAsyncOperation_1__IActivitySensor = ^IAsyncOperation_1__IActivitySensor;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Sensors.IActivitySensorReading>
  IIterator_1__IActivitySensorReading = interface;
  PIIterator_1__IActivitySensorReading = ^IIterator_1__IActivitySensorReading;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IActivitySensorReading>
  IIterable_1__IActivitySensorReading = interface;
  PIIterable_1__IActivitySensorReading = ^IIterable_1__IActivitySensorReading;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReading>
  IVectorView_1__IActivitySensorReading = interface;
  PIVectorView_1__IActivitySensorReading = ^IVectorView_1__IActivitySensorReading;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReading>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading = ^AsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReading>>
  IAsyncOperation_1__IVectorView_1__IActivitySensorReading = interface;
  PIAsyncOperation_1__IVectorView_1__IActivitySensorReading = ^IAsyncOperation_1__IVectorView_1__IActivitySensorReading;

  // Windows.Devices.Sensors.IActivitySensorStatics
  IActivitySensorStatics = interface;
  PIActivitySensorStatics = ^IActivitySensorStatics;

  // Windows.Devices.Sensors.IActivitySensorReadingChangeReport
  IActivitySensorReadingChangeReport = interface;
  PIActivitySensorReadingChangeReport = ^IActivitySensorReadingChangeReport;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Sensors.IActivitySensorReadingChangeReport>
  IIterator_1__IActivitySensorReadingChangeReport = interface;
  PIIterator_1__IActivitySensorReadingChangeReport = ^IIterator_1__IActivitySensorReadingChangeReport;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IActivitySensorReadingChangeReport>
  IIterable_1__IActivitySensorReadingChangeReport = interface;
  PIIterable_1__IActivitySensorReadingChangeReport = ^IIterable_1__IActivitySensorReadingChangeReport;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReadingChangeReport>
  IVectorView_1__IActivitySensorReadingChangeReport = interface;
  PIVectorView_1__IActivitySensorReadingChangeReport = ^IVectorView_1__IActivitySensorReadingChangeReport;

  // Windows.Devices.Sensors.IBarometerReading
  IBarometerReading = interface;
  PIBarometerReading = ^IBarometerReading;

  // Windows.Devices.Sensors.IBarometerReadingChangedEventArgs
  IBarometerReadingChangedEventArgs = interface;
  PIBarometerReadingChangedEventArgs = ^IBarometerReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IBarometer,Windows.Devices.Sensors.IBarometerReadingChangedEventArgs>
  TypedEventHandler_2__IBarometer__IBarometerReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IBarometer__IBarometerReadingChangedEventArgs = ^TypedEventHandler_2__IBarometer__IBarometerReadingChangedEventArgs;

  // Windows.Devices.Sensors.IBarometer
  IBarometer = interface;
  PIBarometer = ^IBarometer;

  // Windows.Devices.Sensors.IBarometerStatics
  IBarometerStatics = interface;
  PIBarometerStatics = ^IBarometerStatics;

  // Windows.Devices.Sensors.IPedometerReading
  IPedometerReading = interface;
  PIPedometerReading = ^IPedometerReading;

  // Windows.Devices.Sensors.IPedometerReadingChangedEventArgs
  IPedometerReadingChangedEventArgs = interface;
  PIPedometerReadingChangedEventArgs = ^IPedometerReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IPedometer,Windows.Devices.Sensors.IPedometerReadingChangedEventArgs>
  TypedEventHandler_2__IPedometer__IPedometerReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IPedometer__IPedometerReadingChangedEventArgs = ^TypedEventHandler_2__IPedometer__IPedometerReadingChangedEventArgs;

  // Windows.Devices.Sensors.IPedometer
  IPedometer = interface;
  PIPedometer = ^IPedometer;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IPedometer>
  AsyncOperationCompletedHandler_1__IPedometer = interface;
  PAsyncOperationCompletedHandler_1__IPedometer = ^AsyncOperationCompletedHandler_1__IPedometer;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IPedometer>
  IAsyncOperation_1__IPedometer = interface;
  PIAsyncOperation_1__IPedometer = ^IAsyncOperation_1__IPedometer;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Sensors.IPedometerReading>
  IIterator_1__IPedometerReading = interface;
  PIIterator_1__IPedometerReading = ^IIterator_1__IPedometerReading;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IPedometerReading>
  IIterable_1__IPedometerReading = interface;
  PIIterable_1__IPedometerReading = ^IIterable_1__IPedometerReading;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IPedometerReading>
  IVectorView_1__IPedometerReading = interface;
  PIVectorView_1__IPedometerReading = ^IVectorView_1__IPedometerReading;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IPedometerReading>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading = ^AsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IPedometerReading>>
  IAsyncOperation_1__IVectorView_1__IPedometerReading = interface;
  PIAsyncOperation_1__IVectorView_1__IPedometerReading = ^IAsyncOperation_1__IVectorView_1__IPedometerReading;

  // Windows.Devices.Sensors.IPedometerStatics
  IPedometerStatics = interface;
  PIPedometerStatics = ^IPedometerStatics;

  // Windows.Devices.Sensors.IProximitySensorReading
  IProximitySensorReading = interface;
  PIProximitySensorReading = ^IProximitySensorReading;

  // Windows.Devices.Sensors.IProximitySensorReadingChangedEventArgs
  IProximitySensorReadingChangedEventArgs = interface;
  PIProximitySensorReadingChangedEventArgs = ^IProximitySensorReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IProximitySensor,Windows.Devices.Sensors.IProximitySensorReadingChangedEventArgs>
  TypedEventHandler_2__IProximitySensor__IProximitySensorReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IProximitySensor__IProximitySensorReadingChangedEventArgs = ^TypedEventHandler_2__IProximitySensor__IProximitySensorReadingChangedEventArgs;

  // Windows.Devices.Sensors.IProximitySensor
  IProximitySensor = interface;
  PIProximitySensor = ^IProximitySensor;

  // Windows.Devices.Sensors.IProximitySensorStatics
  IProximitySensorStatics = interface;
  PIProximitySensorStatics = ^IProximitySensorStatics;

  // Windows.Devices.Sensors.IAltimeterReading
  IAltimeterReading = interface;
  PIAltimeterReading = ^IAltimeterReading;

  // Windows.Devices.Sensors.IAltimeterReadingChangedEventArgs
  IAltimeterReadingChangedEventArgs = interface;
  PIAltimeterReadingChangedEventArgs = ^IAltimeterReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAltimeter,Windows.Devices.Sensors.IAltimeterReadingChangedEventArgs>
  TypedEventHandler_2__IAltimeter__IAltimeterReadingChangedEventArgs = interface;
  PTypedEventHandler_2__IAltimeter__IAltimeterReadingChangedEventArgs = ^TypedEventHandler_2__IAltimeter__IAltimeterReadingChangedEventArgs;

  // Windows.Devices.Sensors.IAltimeter
  IAltimeter = interface;
  PIAltimeter = ^IAltimeter;

  // Windows.Devices.Sensors.IAltimeterStatics
  IAltimeterStatics = interface;
  PIAltimeterStatics = ^IAltimeterStatics;

  // Windows.Devices.Sensors.Custom.ICustomSensorReading
  Custom_ICustomSensorReading = interface;
  PCustom_ICustomSensorReading = ^Custom_ICustomSensorReading;

  // Windows.Devices.Sensors.Custom.ICustomSensorReadingChangedEventArgs
  Custom_ICustomSensorReadingChangedEventArgs = interface;
  PCustom_ICustomSensorReadingChangedEventArgs = ^Custom_ICustomSensorReadingChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.Custom.ICustomSensor,Windows.Devices.Sensors.Custom.ICustomSensorReadingChangedEventArgs>
  TypedEventHandler_2__Custom_ICustomSensor__Custom_ICustomSensorReadingChangedEventArgs = interface;
  PTypedEventHandler_2__Custom_ICustomSensor__Custom_ICustomSensorReadingChangedEventArgs = ^TypedEventHandler_2__Custom_ICustomSensor__Custom_ICustomSensorReadingChangedEventArgs;

  // Windows.Devices.Sensors.Custom.ICustomSensor
  Custom_ICustomSensor = interface;
  PCustom_ICustomSensor = ^Custom_ICustomSensor;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.Custom.ICustomSensor>
  AsyncOperationCompletedHandler_1__Custom_ICustomSensor = interface;
  PAsyncOperationCompletedHandler_1__Custom_ICustomSensor = ^AsyncOperationCompletedHandler_1__Custom_ICustomSensor;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.Custom.ICustomSensor>
  IAsyncOperation_1__Custom_ICustomSensor = interface;
  PIAsyncOperation_1__Custom_ICustomSensor = ^IAsyncOperation_1__Custom_ICustomSensor;

  // Windows.Devices.Sensors.Custom.ICustomSensorStatics
  Custom_ICustomSensorStatics = interface;
  PCustom_ICustomSensorStatics = ^Custom_ICustomSensorStatics;


  // Emit Forwarded interfaces
  // Windows.Devices.Sensors Interfaces
  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Sensors.ActivityType>
  IIterator_1__ActivityType = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: ActivityType; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PActivityType): Cardinal; safecall;
    property Current: ActivityType read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.ActivityType>
  IIterable_1__ActivityType_Base = interface(IInspectable)
  ['{2A04CDFA-5DFD-5178-8731-ADE998E4A7F6}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.ActivityType>
  IIterable_1__ActivityType = interface(IIterable_1__ActivityType_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__ActivityType; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.ActivityType>
  IVectorView_1__ActivityType = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): ActivityType; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: ActivityType; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PActivityType): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Devices.Sensors.ActivityType>
  IVector_1__ActivityType = interface(IInspectable)
  ['{A4739064-B54E-55D4-8012-317E2B6A807B}']
    function GetAt(index: Cardinal): ActivityType; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__ActivityType; safecall;
    function IndexOf(value: ActivityType; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: ActivityType); safecall;
    procedure InsertAt(index: Cardinal; value: ActivityType); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: ActivityType); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PActivityType): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PActivityType); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAccelerometerDeviceId
  IAccelerometerDeviceId = interface(IInspectable)
  ['{7EAC64A9-97D5-446D-AB5A-917DF9B96A2C}']
    function get_DeviceId: HSTRING; safecall;
    property DeviceId: HSTRING read get_DeviceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAccelerometerReading
  [WinRTClassNameAttribute(SAccelerometerReading)]
  IAccelerometerReading = interface(IInspectable)
  ['{B9FE7ACB-D351-40AF-8BB6-7AA9AE641FB7}']
    function get_Timestamp: DateTime; safecall;
    function get_AccelerationX: Double; safecall;
    function get_AccelerationY: Double; safecall;
    function get_AccelerationZ: Double; safecall;
    property AccelerationX: Double read get_AccelerationX;
    property AccelerationY: Double read get_AccelerationY;
    property AccelerationZ: Double read get_AccelerationZ;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAccelerometerReadingChangedEventArgs
  [WinRTClassNameAttribute(SAccelerometerReadingChangedEventArgs)]
  IAccelerometerReadingChangedEventArgs = interface(IInspectable)
  ['{0095C65B-B6AC-475A-9F44-8B32D35A3F25}']
    function get_Reading: IAccelerometerReading; safecall;
    property Reading: IAccelerometerReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAccelerometer,Windows.Devices.Sensors.IAccelerometerReadingChangedEventArgs>
  TypedEventHandler_2__IAccelerometer__IAccelerometerReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{A5E83E40-B597-5B83-92F5-5BED3926CA80}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAccelerometer,Windows.Devices.Sensors.IAccelerometerReadingChangedEventArgs>
  TypedEventHandler_2__IAccelerometer__IAccelerometerReadingChangedEventArgs = interface(TypedEventHandler_2__IAccelerometer__IAccelerometerReadingChangedEventArgs_Delegate_Base)
  ['{9D20AAA1-647B-56D4-B668-0B6002475AB4}']
    procedure Invoke(sender: IAccelerometer; args: IAccelerometerReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAccelerometerShakenEventArgs
  [WinRTClassNameAttribute(SAccelerometerShakenEventArgs)]
  IAccelerometerShakenEventArgs = interface(IInspectable)
  ['{95FF01D1-4A28-4F35-98E8-8178AAE4084A}']
    function get_Timestamp: DateTime; safecall;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAccelerometer,Windows.Devices.Sensors.IAccelerometerShakenEventArgs>
  TypedEventHandler_2__IAccelerometer__IAccelerometerShakenEventArgs_Delegate_Base = interface(IUnknown)
  ['{3E5D6EAF-F169-5D60-92B0-98CD6BD8F808}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAccelerometer,Windows.Devices.Sensors.IAccelerometerShakenEventArgs>
  TypedEventHandler_2__IAccelerometer__IAccelerometerShakenEventArgs = interface(TypedEventHandler_2__IAccelerometer__IAccelerometerShakenEventArgs_Delegate_Base)
  ['{ED8C9EE8-1DB6-55E3-BE0B-25B5B8476431}']
    procedure Invoke(sender: IAccelerometer; args: IAccelerometerShakenEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAccelerometer
  [WinRTClassNameAttribute(SAccelerometer)]
  IAccelerometer = interface(IInspectable)
  ['{DF184548-2711-4DA7-8098-4B82205D3C7D}']
    function GetCurrentReading: IAccelerometerReading; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IAccelerometer__IAccelerometerReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    function add_Shaken(handler: TypedEventHandler_2__IAccelerometer__IAccelerometerShakenEventArgs): EventRegistrationToken; safecall;
    procedure remove_Shaken(token: EventRegistrationToken); safecall;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAccelerometerStatics
  [WinRTClassNameAttribute(SAccelerometer)]
  IAccelerometerStatics = interface(IInspectable)
  ['{A5E28B74-5A87-4A2D-BECC-0F906EA061DD}']
    function GetDefault: IAccelerometer; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAccelerometer2
  IAccelerometer2 = interface(IInspectable)
  ['{E8F092EE-4964-401A-B602-220D7153C60A}']
    procedure put_ReadingTransform(value: Display_DisplayOrientations); safecall;
    function get_ReadingTransform: Display_DisplayOrientations; safecall;
    property ReadingTransform: Display_DisplayOrientations read get_ReadingTransform write put_ReadingTransform;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAccelerometer3
  IAccelerometer3 = interface(IInspectable)
  ['{87E0022A-ED80-49EB-BF8A-A4EA31E5CD84}']
    procedure put_ReportLatency(value: Cardinal); safecall;
    function get_ReportLatency: Cardinal; safecall;
    function get_MaxBatchSize: Cardinal; safecall;
    property MaxBatchSize: Cardinal read get_MaxBatchSize;
    property ReportLatency: Cardinal read get_ReportLatency write put_ReportLatency;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IInclinometerDeviceId
  IInclinometerDeviceId = interface(IInspectable)
  ['{01E91982-41FF-4406-AE83-62210FF16FE3}']
    function get_DeviceId: HSTRING; safecall;
    property DeviceId: HSTRING read get_DeviceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IInclinometerReading
  [WinRTClassNameAttribute(SInclinometerReading)]
  IInclinometerReading = interface(IInspectable)
  ['{9F44F055-B6F6-497F-B127-1A775E501458}']
    function get_Timestamp: DateTime; safecall;
    function get_PitchDegrees: Single; safecall;
    function get_RollDegrees: Single; safecall;
    function get_YawDegrees: Single; safecall;
    property PitchDegrees: Single read get_PitchDegrees;
    property RollDegrees: Single read get_RollDegrees;
    property Timestamp: DateTime read get_Timestamp;
    property YawDegrees: Single read get_YawDegrees;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IInclinometerReadingChangedEventArgs
  [WinRTClassNameAttribute(SInclinometerReadingChangedEventArgs)]
  IInclinometerReadingChangedEventArgs = interface(IInspectable)
  ['{4AE91DC1-E7EB-4938-8511-AE0D6B440438}']
    function get_Reading: IInclinometerReading; safecall;
    property Reading: IInclinometerReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IInclinometer,Windows.Devices.Sensors.IInclinometerReadingChangedEventArgs>
  TypedEventHandler_2__IInclinometer__IInclinometerReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{6F3B411F-D147-59F1-BBE4-7BEC396C7B6E}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IInclinometer,Windows.Devices.Sensors.IInclinometerReadingChangedEventArgs>
  TypedEventHandler_2__IInclinometer__IInclinometerReadingChangedEventArgs = interface(TypedEventHandler_2__IInclinometer__IInclinometerReadingChangedEventArgs_Delegate_Base)
  ['{6A75A7D0-5CCB-5331-9437-3D202A95EC6D}']
    procedure Invoke(sender: IInclinometer; args: IInclinometerReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IInclinometer
  [WinRTClassNameAttribute(SInclinometer)]
  IInclinometer = interface(IInspectable)
  ['{2648CA6F-2286-406F-9161-F0C4BD806EBF}']
    function GetCurrentReading: IInclinometerReading; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IInclinometer__IInclinometerReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IInclinometerStatics
  [WinRTClassNameAttribute(SInclinometer)]
  IInclinometerStatics = interface(IInspectable)
  ['{F22EC551-9C30-453A-8B49-3C3EEB33CB61}']
    function GetDefault: IInclinometer; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IInclinometerStatics2
  [WinRTClassNameAttribute(SInclinometer)]
  IInclinometerStatics2 = interface(IInspectable)
  ['{043F9775-6A1E-499C-86E0-638C1A864B00}']
    function GetDefaultForRelativeReadings: IInclinometer; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IInclinometer2
  IInclinometer2 = interface(IInspectable)
  ['{029F3393-28B2-45F8-BB16-61E86A7FAE6E}']
    procedure put_ReadingTransform(value: Display_DisplayOrientations); safecall;
    function get_ReadingTransform: Display_DisplayOrientations; safecall;
    function get_ReadingType: SensorReadingType; safecall;
    property ReadingTransform: Display_DisplayOrientations read get_ReadingTransform write put_ReadingTransform;
    property ReadingType: SensorReadingType read get_ReadingType;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IInclinometerReadingYawAccuracy
  IInclinometerReadingYawAccuracy = interface(IInspectable)
  ['{B453E880-1FE3-4986-A257-E6ECE2723949}']
    function get_YawAccuracy: MagnetometerAccuracy; safecall;
    property YawAccuracy: MagnetometerAccuracy read get_YawAccuracy;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IGyrometerDeviceId
  IGyrometerDeviceId = interface(IInspectable)
  ['{1EE5E978-89A2-4275-9E95-7126F4708760}']
    function get_DeviceId: HSTRING; safecall;
    property DeviceId: HSTRING read get_DeviceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IGyrometerReading
  [WinRTClassNameAttribute(SGyrometerReading)]
  IGyrometerReading = interface(IInspectable)
  ['{B3D6DE5C-1EE4-456F-9DE7-E2493B5C8E03}']
    function get_Timestamp: DateTime; safecall;
    function get_AngularVelocityX: Double; safecall;
    function get_AngularVelocityY: Double; safecall;
    function get_AngularVelocityZ: Double; safecall;
    property AngularVelocityX: Double read get_AngularVelocityX;
    property AngularVelocityY: Double read get_AngularVelocityY;
    property AngularVelocityZ: Double read get_AngularVelocityZ;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IGyrometerReadingChangedEventArgs
  [WinRTClassNameAttribute(SGyrometerReadingChangedEventArgs)]
  IGyrometerReadingChangedEventArgs = interface(IInspectable)
  ['{0FDF1895-6F9E-42CE-8D58-388C0AB8356D}']
    function get_Reading: IGyrometerReading; safecall;
    property Reading: IGyrometerReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IGyrometer,Windows.Devices.Sensors.IGyrometerReadingChangedEventArgs>
  TypedEventHandler_2__IGyrometer__IGyrometerReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{15171524-5786-59A5-AF5B-A01245726C44}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IGyrometer,Windows.Devices.Sensors.IGyrometerReadingChangedEventArgs>
  TypedEventHandler_2__IGyrometer__IGyrometerReadingChangedEventArgs = interface(TypedEventHandler_2__IGyrometer__IGyrometerReadingChangedEventArgs_Delegate_Base)
  ['{2AA7CF2F-D411-5180-B557-8B5DFE728B7B}']
    procedure Invoke(sender: IGyrometer; args: IGyrometerReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IGyrometer
  [WinRTClassNameAttribute(SGyrometer)]
  IGyrometer = interface(IInspectable)
  ['{FDB9A9C4-84B1-4CA2-9763-9B589506C70C}']
    function GetCurrentReading: IGyrometerReading; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IGyrometer__IGyrometerReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IGyrometerStatics
  [WinRTClassNameAttribute(SGyrometer)]
  IGyrometerStatics = interface(IInspectable)
  ['{83B6E7C9-E49D-4B39-86E6-CD554BE4C5C1}']
    function GetDefault: IGyrometer; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IGyrometer2
  IGyrometer2 = interface(IInspectable)
  ['{63DF2443-8CE8-41C3-AC44-8698810B557F}']
    procedure put_ReadingTransform(value: Display_DisplayOrientations); safecall;
    function get_ReadingTransform: Display_DisplayOrientations; safecall;
    property ReadingTransform: Display_DisplayOrientations read get_ReadingTransform write put_ReadingTransform;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ICompassDeviceId
  ICompassDeviceId = interface(IInspectable)
  ['{D181CA29-B085-4B1D-870A-4FF57BA74FD4}']
    function get_DeviceId: HSTRING; safecall;
    property DeviceId: HSTRING read get_DeviceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ICompassReading
  [WinRTClassNameAttribute(SCompassReading)]
  ICompassReading = interface(IInspectable)
  ['{82911128-513D-4DC9-B781-5EEDFBF02D0C}']
    function get_Timestamp: DateTime; safecall;
    function get_HeadingMagneticNorth: Double; safecall;
    function get_HeadingTrueNorth: IReference_1__Double; safecall;
    property HeadingMagneticNorth: Double read get_HeadingMagneticNorth;
    property HeadingTrueNorth: IReference_1__Double read get_HeadingTrueNorth;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ICompassReadingChangedEventArgs
  [WinRTClassNameAttribute(SCompassReadingChangedEventArgs)]
  ICompassReadingChangedEventArgs = interface(IInspectable)
  ['{8F1549B0-E8BC-4C7E-B009-4E41DF137072}']
    function get_Reading: ICompassReading; safecall;
    property Reading: ICompassReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ICompass,Windows.Devices.Sensors.ICompassReadingChangedEventArgs>
  TypedEventHandler_2__ICompass__ICompassReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{E787D73D-A121-5AE6-B497-AB934837E57F}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ICompass,Windows.Devices.Sensors.ICompassReadingChangedEventArgs>
  TypedEventHandler_2__ICompass__ICompassReadingChangedEventArgs = interface(TypedEventHandler_2__ICompass__ICompassReadingChangedEventArgs_Delegate_Base)
  ['{E918EC6B-CC83-5428-A983-F23DB6D211C3}']
    procedure Invoke(sender: ICompass; args: ICompassReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ICompass
  [WinRTClassNameAttribute(SCompass)]
  ICompass = interface(IInspectable)
  ['{292FFA94-1B45-403C-BA06-B106DBA69A64}']
    function GetCurrentReading: ICompassReading; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__ICompass__ICompassReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ICompassStatics
  [WinRTClassNameAttribute(SCompass)]
  ICompassStatics = interface(IInspectable)
  ['{9ABC97DF-56EC-4C25-B54D-40A68BB5B269}']
    function GetDefault: ICompass; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ICompass2
  ICompass2 = interface(IInspectable)
  ['{36F26D09-C7D7-434F-B461-979DDFC2322F}']
    procedure put_ReadingTransform(value: Display_DisplayOrientations); safecall;
    function get_ReadingTransform: Display_DisplayOrientations; safecall;
    property ReadingTransform: Display_DisplayOrientations read get_ReadingTransform write put_ReadingTransform;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ICompassReadingHeadingAccuracy
  ICompassReadingHeadingAccuracy = interface(IInspectable)
  ['{E761354E-8911-40F7-9E16-6ECC7DAEC5DE}']
    function get_HeadingAccuracy: MagnetometerAccuracy; safecall;
    property HeadingAccuracy: MagnetometerAccuracy read get_HeadingAccuracy;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ILightSensorDeviceId
  ILightSensorDeviceId = interface(IInspectable)
  ['{7FEE49F8-0AFB-4F51-87F0-6C26375CE94F}']
    function get_DeviceId: HSTRING; safecall;
    property DeviceId: HSTRING read get_DeviceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ILightSensorReading
  [WinRTClassNameAttribute(SLightSensorReading)]
  ILightSensorReading = interface(IInspectable)
  ['{FFDF6300-227C-4D2B-B302-FC0142485C68}']
    function get_Timestamp: DateTime; safecall;
    function get_IlluminanceInLux: Single; safecall;
    property IlluminanceInLux: Single read get_IlluminanceInLux;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ILightSensorReadingChangedEventArgs
  [WinRTClassNameAttribute(SLightSensorReadingChangedEventArgs)]
  ILightSensorReadingChangedEventArgs = interface(IInspectable)
  ['{A3A2F4CF-258B-420C-B8AB-8EDD601ECF50}']
    function get_Reading: ILightSensorReading; safecall;
    property Reading: ILightSensorReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ILightSensor,Windows.Devices.Sensors.ILightSensorReadingChangedEventArgs>
  TypedEventHandler_2__ILightSensor__ILightSensorReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{1ECF183A-9F0A-5F73-9225-5A33EAB5594F}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ILightSensor,Windows.Devices.Sensors.ILightSensorReadingChangedEventArgs>
  TypedEventHandler_2__ILightSensor__ILightSensorReadingChangedEventArgs = interface(TypedEventHandler_2__ILightSensor__ILightSensorReadingChangedEventArgs_Delegate_Base)
  ['{7356B947-E0F6-5A86-9EF8-17ACFB9B1DE7}']
    procedure Invoke(sender: ILightSensor; args: ILightSensorReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ILightSensor
  [WinRTClassNameAttribute(SLightSensor)]
  ILightSensor = interface(IInspectable)
  ['{F84C0718-0C54-47AE-922E-789F57FB03A0}']
    function GetCurrentReading: ILightSensorReading; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__ILightSensor__ILightSensorReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ILightSensorStatics
  [WinRTClassNameAttribute(SLightSensor)]
  ILightSensorStatics = interface(IInspectable)
  ['{45DB8C84-C3A8-471E-9A53-6457FAD87C0E}']
    function GetDefault: ILightSensor; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ISensorRotationMatrix
  [WinRTClassNameAttribute(SSensorRotationMatrix)]
  ISensorRotationMatrix = interface(IInspectable)
  ['{0A3D5A67-22F4-4392-9538-65D0BD064AA6}']
    function get_M11: Single; safecall;
    function get_M12: Single; safecall;
    function get_M13: Single; safecall;
    function get_M21: Single; safecall;
    function get_M22: Single; safecall;
    function get_M23: Single; safecall;
    function get_M31: Single; safecall;
    function get_M32: Single; safecall;
    function get_M33: Single; safecall;
    property M11: Single read get_M11;
    property M12: Single read get_M12;
    property M13: Single read get_M13;
    property M21: Single read get_M21;
    property M22: Single read get_M22;
    property M23: Single read get_M23;
    property M31: Single read get_M31;
    property M32: Single read get_M32;
    property M33: Single read get_M33;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ISensorQuaternion
  [WinRTClassNameAttribute(SSensorQuaternion)]
  ISensorQuaternion = interface(IInspectable)
  ['{C9C5C827-C71C-46E7-9DA3-36A193B232BC}']
    function get_W: Single; safecall;
    function get_X: Single; safecall;
    function get_Y: Single; safecall;
    function get_Z: Single; safecall;
    property W: Single read get_W;
    property X: Single read get_X;
    property Y: Single read get_Y;
    property Z: Single read get_Z;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IOrientationSensorDeviceId
  IOrientationSensorDeviceId = interface(IInspectable)
  ['{5A69B648-4C29-49EC-B28F-EA1D117B66F0}']
    function get_DeviceId: HSTRING; safecall;
    property DeviceId: HSTRING read get_DeviceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IOrientationSensorReading
  [WinRTClassNameAttribute(SOrientationSensorReading)]
  IOrientationSensorReading = interface(IInspectable)
  ['{4756C993-6595-4897-BCC6-D537EE757564}']
    function get_Timestamp: DateTime; safecall;
    function get_RotationMatrix: ISensorRotationMatrix; safecall;
    function get_Quaternion: ISensorQuaternion; safecall;
    property Quaternion: ISensorQuaternion read get_Quaternion;
    property RotationMatrix: ISensorRotationMatrix read get_RotationMatrix;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IOrientationSensorReadingChangedEventArgs
  [WinRTClassNameAttribute(SOrientationSensorReadingChangedEventArgs)]
  IOrientationSensorReadingChangedEventArgs = interface(IInspectable)
  ['{012C1186-C3BA-46BC-AE65-7A98996CBFB8}']
    function get_Reading: IOrientationSensorReading; safecall;
    property Reading: IOrientationSensorReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IOrientationSensor,Windows.Devices.Sensors.IOrientationSensorReadingChangedEventArgs>
  TypedEventHandler_2__IOrientationSensor__IOrientationSensorReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{91AE0C43-E1F7-577D-A161-8AAF275EB927}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IOrientationSensor,Windows.Devices.Sensors.IOrientationSensorReadingChangedEventArgs>
  TypedEventHandler_2__IOrientationSensor__IOrientationSensorReadingChangedEventArgs = interface(TypedEventHandler_2__IOrientationSensor__IOrientationSensorReadingChangedEventArgs_Delegate_Base)
  ['{DCCA4324-96EB-5315-9D53-6EF61E4C8750}']
    procedure Invoke(sender: IOrientationSensor; args: IOrientationSensorReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IOrientationSensor
  [WinRTClassNameAttribute(SOrientationSensor)]
  IOrientationSensor = interface(IInspectable)
  ['{5E354635-CF6B-4C63-ABD8-10252B0BF6EC}']
    function GetCurrentReading: IOrientationSensorReading; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IOrientationSensor__IOrientationSensorReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IOrientationSensorStatics
  [WinRTClassNameAttribute(SOrientationSensor)]
  IOrientationSensorStatics = interface(IInspectable)
  ['{10EF8712-FB4C-428A-898B-2765E409E669}']
    function GetDefault: IOrientationSensor; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IOrientationSensorStatics2
  [WinRTClassNameAttribute(SOrientationSensor)]
  IOrientationSensorStatics2 = interface(IInspectable)
  ['{59DA0D0B-D40A-4C71-9276-8A272A0A6619}']
    function GetDefaultForRelativeReadings: IOrientationSensor; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IOrientationSensor2
  IOrientationSensor2 = interface(IInspectable)
  ['{0D924CF9-2F1F-49C9-8042-4A1813D67760}']
    procedure put_ReadingTransform(value: Display_DisplayOrientations); safecall;
    function get_ReadingTransform: Display_DisplayOrientations; safecall;
    function get_ReadingType: SensorReadingType; safecall;
    property ReadingTransform: Display_DisplayOrientations read get_ReadingTransform write put_ReadingTransform;
    property ReadingType: SensorReadingType read get_ReadingType;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IOrientationSensorReadingYawAccuracy
  IOrientationSensorReadingYawAccuracy = interface(IInspectable)
  ['{D1AC9824-3F5A-49A2-BC7B-1180BC38CD2B}']
    function get_YawAccuracy: MagnetometerAccuracy; safecall;
    property YawAccuracy: MagnetometerAccuracy read get_YawAccuracy;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ISimpleOrientationSensorDeviceId
  ISimpleOrientationSensorDeviceId = interface(IInspectable)
  ['{FBC00ACB-3B76-41F6-8091-30EFE646D3CF}']
    function get_DeviceId: HSTRING; safecall;
    property DeviceId: HSTRING read get_DeviceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ISimpleOrientationSensorOrientationChangedEventArgs
  [WinRTClassNameAttribute(SSimpleOrientationSensorOrientationChangedEventArgs)]
  ISimpleOrientationSensorOrientationChangedEventArgs = interface(IInspectable)
  ['{BCD5C660-23D4-4B4C-A22E-BA81ADE0C601}']
    function get_Timestamp: DateTime; safecall;
    function get_Orientation: SimpleOrientation; safecall;
    property Orientation: SimpleOrientation read get_Orientation;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ISimpleOrientationSensor,Windows.Devices.Sensors.ISimpleOrientationSensorOrientationChangedEventArgs>
  TypedEventHandler_2__ISimpleOrientationSensor__ISimpleOrientationSensorOrientationChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{92437FA7-EA7B-5FC5-8ECF-1B911BEA2BFC}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.ISimpleOrientationSensor,Windows.Devices.Sensors.ISimpleOrientationSensorOrientationChangedEventArgs>
  TypedEventHandler_2__ISimpleOrientationSensor__ISimpleOrientationSensorOrientationChangedEventArgs = interface(TypedEventHandler_2__ISimpleOrientationSensor__ISimpleOrientationSensorOrientationChangedEventArgs_Delegate_Base)
  ['{EC8B4336-878E-597A-ACE4-659581E77F5B}']
    procedure Invoke(sender: ISimpleOrientationSensor; args: ISimpleOrientationSensorOrientationChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ISimpleOrientationSensor
  [WinRTClassNameAttribute(SSimpleOrientationSensor)]
  ISimpleOrientationSensor = interface(IInspectable)
  ['{5FF53856-214A-4DEE-A3F9-616F1AB06FFD}']
    function GetCurrentOrientation: SimpleOrientation; safecall;
    function add_OrientationChanged(handler: TypedEventHandler_2__ISimpleOrientationSensor__ISimpleOrientationSensorOrientationChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_OrientationChanged(token: EventRegistrationToken); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ISimpleOrientationSensorStatics
  [WinRTClassNameAttribute(SSimpleOrientationSensor)]
  ISimpleOrientationSensorStatics = interface(IInspectable)
  ['{72ED066F-70AA-40C6-9B1B-3433F7459B4E}']
    function GetDefault: ISimpleOrientationSensor; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.ISimpleOrientationSensor2
  ISimpleOrientationSensor2 = interface(IInspectable)
  ['{A277A798-8870-453E-8BD6-B8F5D8D7941B}']
    procedure put_ReadingTransform(value: Display_DisplayOrientations); safecall;
    function get_ReadingTransform: Display_DisplayOrientations; safecall;
    property ReadingTransform: Display_DisplayOrientations read get_ReadingTransform write put_ReadingTransform;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IMagnetometerDeviceId
  IMagnetometerDeviceId = interface(IInspectable)
  ['{58B498C2-7E4B-404C-9FC5-5DE8B40EBAE3}']
    function get_DeviceId: HSTRING; safecall;
    property DeviceId: HSTRING read get_DeviceId;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IMagnetometerReading
  [WinRTClassNameAttribute(SMagnetometerReading)]
  IMagnetometerReading = interface(IInspectable)
  ['{0C2CC40D-EBFD-4E5C-BB11-AFC29B3CAE61}']
    function get_Timestamp: DateTime; safecall;
    function get_MagneticFieldX: Single; safecall;
    function get_MagneticFieldY: Single; safecall;
    function get_MagneticFieldZ: Single; safecall;
    function get_DirectionalAccuracy: MagnetometerAccuracy; safecall;
    property DirectionalAccuracy: MagnetometerAccuracy read get_DirectionalAccuracy;
    property MagneticFieldX: Single read get_MagneticFieldX;
    property MagneticFieldY: Single read get_MagneticFieldY;
    property MagneticFieldZ: Single read get_MagneticFieldZ;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IMagnetometerReadingChangedEventArgs
  [WinRTClassNameAttribute(SMagnetometerReadingChangedEventArgs)]
  IMagnetometerReadingChangedEventArgs = interface(IInspectable)
  ['{17EAE872-2EB9-4EE7-8AD0-3127537D949B}']
    function get_Reading: IMagnetometerReading; safecall;
    property Reading: IMagnetometerReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IMagnetometer,Windows.Devices.Sensors.IMagnetometerReadingChangedEventArgs>
  TypedEventHandler_2__IMagnetometer__IMagnetometerReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{F9A0DA76-C4FD-50AB-98B6-BFD26D6D3D82}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IMagnetometer,Windows.Devices.Sensors.IMagnetometerReadingChangedEventArgs>
  TypedEventHandler_2__IMagnetometer__IMagnetometerReadingChangedEventArgs = interface(TypedEventHandler_2__IMagnetometer__IMagnetometerReadingChangedEventArgs_Delegate_Base)
  ['{C594359D-2616-5095-832B-CC3935C3A9D9}']
    procedure Invoke(sender: IMagnetometer; args: IMagnetometerReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IMagnetometer
  [WinRTClassNameAttribute(SMagnetometer)]
  IMagnetometer = interface(IInspectable)
  ['{484F626E-D3C9-4111-B3F6-2CF1FAA418D5}']
    function GetCurrentReading: IMagnetometerReading; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IMagnetometer__IMagnetometerReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IMagnetometerStatics
  [WinRTClassNameAttribute(SMagnetometer)]
  IMagnetometerStatics = interface(IInspectable)
  ['{853C64CC-0698-4DDA-A6DF-9CB9CC4AB40A}']
    function GetDefault: IMagnetometer; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IMagnetometer2
  IMagnetometer2 = interface(IInspectable)
  ['{B4656C85-26F6-444B-A9E2-A23F966CD368}']
    procedure put_ReadingTransform(value: Display_DisplayOrientations); safecall;
    function get_ReadingTransform: Display_DisplayOrientations; safecall;
    property ReadingTransform: Display_DisplayOrientations read get_ReadingTransform write put_ReadingTransform;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IActivitySensorReading
  [WinRTClassNameAttribute(SActivitySensorReading)]
  IActivitySensorReading = interface(IInspectable)
  ['{85125A96-1472-40A2-B2AE-E1EF29226C78}']
    function get_Timestamp: DateTime; safecall;
    function get_Activity: ActivityType; safecall;
    function get_Confidence: ActivitySensorReadingConfidence; safecall;
    property Activity: ActivityType read get_Activity;
    property Confidence: ActivitySensorReadingConfidence read get_Confidence;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IActivitySensorReading>
  AsyncOperationCompletedHandler_1__IActivitySensorReading_Delegate_Base = interface(IUnknown)
  ['{ADC48D5D-B343-5A58-8454-6E2BC2E0475C}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IActivitySensorReading>
  AsyncOperationCompletedHandler_1__IActivitySensorReading = interface(AsyncOperationCompletedHandler_1__IActivitySensorReading_Delegate_Base)
  ['{856A17A1-6B88-5986-ACBE-600B21971EBC}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IActivitySensorReading; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IActivitySensorReading>
  IAsyncOperation_1__IActivitySensorReading_Base = interface(IInspectable)
  ['{79A87969-327F-5B7A-A0D3-73EAB16DE21C}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IActivitySensorReading>
  IAsyncOperation_1__IActivitySensorReading = interface(IAsyncOperation_1__IActivitySensorReading_Base)
  ['{8553FAE3-FE1A-5952-84C0-30C817E9E597}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IActivitySensorReading); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IActivitySensorReading; safecall;
    function GetResults: IActivitySensorReading; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IActivitySensorReading read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IActivitySensorReadingChangedEventArgs
  [WinRTClassNameAttribute(SActivitySensorReadingChangedEventArgs)]
  IActivitySensorReadingChangedEventArgs = interface(IInspectable)
  ['{DE386717-AEB6-4EC7-946A-D9CC19B951EC}']
    function get_Reading: IActivitySensorReading; safecall;
    property Reading: IActivitySensorReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IActivitySensor,Windows.Devices.Sensors.IActivitySensorReadingChangedEventArgs>
  TypedEventHandler_2__IActivitySensor__IActivitySensorReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{D296B29A-C224-5432-952B-AEDA96CDCD16}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IActivitySensor,Windows.Devices.Sensors.IActivitySensorReadingChangedEventArgs>
  TypedEventHandler_2__IActivitySensor__IActivitySensorReadingChangedEventArgs = interface(TypedEventHandler_2__IActivitySensor__IActivitySensorReadingChangedEventArgs_Delegate_Base)
  ['{BDA69EDC-1056-5BFA-8955-E4618E29C9C9}']
    procedure Invoke(sender: IActivitySensor; args: IActivitySensorReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IActivitySensor
  [WinRTClassNameAttribute(SActivitySensor)]
  IActivitySensor = interface(IInspectable)
  ['{CD7A630C-FB5F-48EB-B09B-A2708D1C61EF}']
    function GetCurrentReadingAsync: IAsyncOperation_1__IActivitySensorReading; safecall;
    function get_SubscribedActivities: IVector_1__ActivityType; safecall;
    function get_PowerInMilliwatts: Double; safecall;
    function get_DeviceId: HSTRING; safecall;
    function get_SupportedActivities: IVectorView_1__ActivityType; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IActivitySensor__IActivitySensorReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property PowerInMilliwatts: Double read get_PowerInMilliwatts;
    property SubscribedActivities: IVector_1__ActivityType read get_SubscribedActivities;
    property SupportedActivities: IVectorView_1__ActivityType read get_SupportedActivities;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IActivitySensor>
  AsyncOperationCompletedHandler_1__IActivitySensor_Delegate_Base = interface(IUnknown)
  ['{1339F7F3-DA62-52B9-9961-772A53DC4C4E}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IActivitySensor>
  AsyncOperationCompletedHandler_1__IActivitySensor = interface(AsyncOperationCompletedHandler_1__IActivitySensor_Delegate_Base)
  ['{6CC7625C-29FF-5A56-BCE3-806CDE6AB524}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IActivitySensor; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IActivitySensor>
  IAsyncOperation_1__IActivitySensor_Base = interface(IInspectable)
  ['{5018B6FD-A764-529D-9A25-0A6B31774A21}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IActivitySensor>
  IAsyncOperation_1__IActivitySensor = interface(IAsyncOperation_1__IActivitySensor_Base)
  ['{73ADA693-ABC7-509B-8093-5BC4A5809253}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IActivitySensor); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IActivitySensor; safecall;
    function GetResults: IActivitySensor; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IActivitySensor read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Sensors.IActivitySensorReading>
  IIterator_1__IActivitySensorReading = interface(IInspectable)
  ['{8E90F3DC-B93D-51A4-85B2-AFD31EA67A7B}']
    function get_Current: IActivitySensorReading; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIActivitySensorReading): Cardinal; safecall;
    property Current: IActivitySensorReading read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IActivitySensorReading>
  IIterable_1__IActivitySensorReading_Base = interface(IInspectable)
  ['{9A34CE03-8C6D-5994-907F-D5C2D19148CB}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IActivitySensorReading>
  IIterable_1__IActivitySensorReading = interface(IIterable_1__IActivitySensorReading_Base)
  ['{2EBBCB05-1A40-5DB4-9245-95E5FBBF9C98}']
    function First: IIterator_1__IActivitySensorReading; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReading>
  IVectorView_1__IActivitySensorReading = interface(IInspectable)
  ['{780FDF9E-4215-50AA-B2FC-9643492B7E6C}']
    function GetAt(index: Cardinal): IActivitySensorReading; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IActivitySensorReading; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIActivitySensorReading): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReading>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading_Delegate_Base = interface(IUnknown)
  ['{179FB953-2D58-5991-8F5B-AC64219A1101}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReading>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading_Delegate_Base)
  ['{731CBCE6-E265-58D6-93EE-E23E4B29FF68}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IActivitySensorReading; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReading>>
  IAsyncOperation_1__IVectorView_1__IActivitySensorReading_Base = interface(IInspectable)
  ['{CD781B82-7900-51A3-80CE-903E2E0A4F0E}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReading>>
  IAsyncOperation_1__IVectorView_1__IActivitySensorReading = interface(IAsyncOperation_1__IVectorView_1__IActivitySensorReading_Base)
  ['{22BF6528-41D4-5F6B-BC5C-0B29C82FBD5A}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading; safecall;
    function GetResults: IVectorView_1__IActivitySensorReading; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IActivitySensorReading read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IActivitySensorStatics
  [WinRTClassNameAttribute(SActivitySensor)]
  IActivitySensorStatics = interface(IInspectable)
  ['{A71E0E9D-EE8B-45D1-B25B-08CC0DF92AB6}']
    function GetDefaultAsync: IAsyncOperation_1__IActivitySensor; safecall;
    function GetDeviceSelector: HSTRING; safecall;
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IActivitySensor; safecall;
    function GetSystemHistoryAsync(fromTime: DateTime): IAsyncOperation_1__IVectorView_1__IActivitySensorReading; overload; safecall;
    function GetSystemHistoryAsync(fromTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IActivitySensorReading; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IActivitySensorReadingChangeReport
  [WinRTClassNameAttribute(SActivitySensorReadingChangeReport)]
  IActivitySensorReadingChangeReport = interface(IInspectable)
  ['{4F3C2915-D93B-47BD-960A-F20FB2F322B9}']
    function get_Reading: IActivitySensorReading; safecall;
    property Reading: IActivitySensorReading read get_Reading;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Sensors.IActivitySensorReadingChangeReport>
  IIterator_1__IActivitySensorReadingChangeReport = interface(IInspectable)
  ['{F01A64E7-E3E3-5D94-9F3A-EA63C9C4495E}']
    function get_Current: IActivitySensorReadingChangeReport; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIActivitySensorReadingChangeReport): Cardinal; safecall;
    property Current: IActivitySensorReadingChangeReport read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IActivitySensorReadingChangeReport>
  IIterable_1__IActivitySensorReadingChangeReport_Base = interface(IInspectable)
  ['{551A4962-9E96-5E6B-8B8A-65EE3D0046F3}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IActivitySensorReadingChangeReport>
  IIterable_1__IActivitySensorReadingChangeReport = interface(IIterable_1__IActivitySensorReadingChangeReport_Base)
  ['{2960EDAE-C062-5C20-ACA2-0EFF1A2EBEF0}']
    function First: IIterator_1__IActivitySensorReadingChangeReport; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IActivitySensorReadingChangeReport>
  IVectorView_1__IActivitySensorReadingChangeReport = interface(IInspectable)
  ['{50767C75-433E-5527-8CE5-7D61ED23BC9E}']
    function GetAt(index: Cardinal): IActivitySensorReadingChangeReport; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IActivitySensorReadingChangeReport; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIActivitySensorReadingChangeReport): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IBarometerReading
  [WinRTClassNameAttribute(SBarometerReading)]
  IBarometerReading = interface(IInspectable)
  ['{F5B9D2E6-1DF6-4A1A-A7AD-321D4F5DB247}']
    function get_Timestamp: DateTime; safecall;
    function get_StationPressureInHectopascals: Double; safecall;
    property StationPressureInHectopascals: Double read get_StationPressureInHectopascals;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IBarometerReadingChangedEventArgs
  [WinRTClassNameAttribute(SBarometerReadingChangedEventArgs)]
  IBarometerReadingChangedEventArgs = interface(IInspectable)
  ['{3D84945F-037B-404F-9BBB-6232D69543C3}']
    function get_Reading: IBarometerReading; safecall;
    property Reading: IBarometerReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IBarometer,Windows.Devices.Sensors.IBarometerReadingChangedEventArgs>
  TypedEventHandler_2__IBarometer__IBarometerReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{E4CAF459-D101-5CA5-A4EA-DEB0917AE27E}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IBarometer,Windows.Devices.Sensors.IBarometerReadingChangedEventArgs>
  TypedEventHandler_2__IBarometer__IBarometerReadingChangedEventArgs = interface(TypedEventHandler_2__IBarometer__IBarometerReadingChangedEventArgs_Delegate_Base)
  ['{A55A1B34-4A10-5FBC-BDA2-3B1BA63C9620}']
    procedure Invoke(sender: IBarometer; args: IBarometerReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IBarometer
  [WinRTClassNameAttribute(SBarometer)]
  IBarometer = interface(IInspectable)
  ['{934475A8-78BF-452F-B017-F0209CE6DAB4}']
    function GetCurrentReading: IBarometerReading; safecall;
    function get_DeviceId: HSTRING; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IBarometer__IBarometerReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IBarometerStatics
  [WinRTClassNameAttribute(SBarometer)]
  IBarometerStatics = interface(IInspectable)
  ['{286B270A-02E3-4F86-84FC-FDD892B5940F}']
    function GetDefault: IBarometer; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IPedometerReading
  [WinRTClassNameAttribute(SPedometerReading)]
  IPedometerReading = interface(IInspectable)
  ['{2245DCF4-A8E1-432F-896A-BE0DD9B02D24}']
    function get_StepKind: PedometerStepKind; safecall;
    function get_CumulativeSteps: Integer; safecall;
    function get_Timestamp: DateTime; safecall;
    function get_CumulativeStepsDuration: TimeSpan; safecall;
    property CumulativeSteps: Integer read get_CumulativeSteps;
    property CumulativeStepsDuration: TimeSpan read get_CumulativeStepsDuration;
    property StepKind: PedometerStepKind read get_StepKind;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IPedometerReadingChangedEventArgs
  [WinRTClassNameAttribute(SPedometerReadingChangedEventArgs)]
  IPedometerReadingChangedEventArgs = interface(IInspectable)
  ['{F855E47E-ABBC-4456-86A8-25CF2B333742}']
    function get_Reading: IPedometerReading; safecall;
    property Reading: IPedometerReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IPedometer,Windows.Devices.Sensors.IPedometerReadingChangedEventArgs>
  TypedEventHandler_2__IPedometer__IPedometerReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{8CFBEC71-8B49-55F1-8601-BE318BB3F660}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IPedometer,Windows.Devices.Sensors.IPedometerReadingChangedEventArgs>
  TypedEventHandler_2__IPedometer__IPedometerReadingChangedEventArgs = interface(TypedEventHandler_2__IPedometer__IPedometerReadingChangedEventArgs_Delegate_Base)
  ['{AA04307E-B7E8-5AE2-99CB-3C75CD084E48}']
    procedure Invoke(sender: IPedometer; args: IPedometerReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IPedometer
  [WinRTClassNameAttribute(SPedometer)]
  IPedometer = interface(IInspectable)
  ['{9A1E013D-3D98-45F8-8920-8E4ECACA5F97}']
    function get_DeviceId: HSTRING; safecall;
    function get_PowerInMilliwatts: Double; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IPedometer__IPedometerReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property PowerInMilliwatts: Double read get_PowerInMilliwatts;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IPedometer>
  AsyncOperationCompletedHandler_1__IPedometer_Delegate_Base = interface(IUnknown)
  ['{C323F54F-3004-510D-9DD8-FB487B6F74F5}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.IPedometer>
  AsyncOperationCompletedHandler_1__IPedometer = interface(AsyncOperationCompletedHandler_1__IPedometer_Delegate_Base)
  ['{6F524164-28F7-55AF-803E-57BEFA8E348B}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IPedometer; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IPedometer>
  IAsyncOperation_1__IPedometer_Base = interface(IInspectable)
  ['{0F42D8BA-554A-5719-AB1B-26D2C97AD471}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.IPedometer>
  IAsyncOperation_1__IPedometer = interface(IAsyncOperation_1__IPedometer_Base)
  ['{EC8C42C2-06A0-5A6A-9A0D-F9D87516604D}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IPedometer); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IPedometer; safecall;
    function GetResults: IPedometer; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IPedometer read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Sensors.IPedometerReading>
  IIterator_1__IPedometerReading = interface(IInspectable)
  ['{5DE1D135-53ED-5540-BB3A-974D4734E763}']
    function get_Current: IPedometerReading; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIPedometerReading): Cardinal; safecall;
    property Current: IPedometerReading read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IPedometerReading>
  IIterable_1__IPedometerReading_Base = interface(IInspectable)
  ['{BBB61A5C-98C3-5718-88FE-5392A7451E2D}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Sensors.IPedometerReading>
  IIterable_1__IPedometerReading = interface(IIterable_1__IPedometerReading_Base)
  ['{A2C8ABEB-1922-5560-9DC3-07BEAC496D61}']
    function First: IIterator_1__IPedometerReading; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IPedometerReading>
  IVectorView_1__IPedometerReading = interface(IInspectable)
  ['{44BEB693-AA66-5003-886B-1BF273FA5750}']
    function GetAt(index: Cardinal): IPedometerReading; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IPedometerReading; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIPedometerReading): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IPedometerReading>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading_Delegate_Base = interface(IUnknown)
  ['{5BBFF840-59F2-5108-9205-A0BBF8F9BA68}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IPedometerReading>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading_Delegate_Base)
  ['{9981AC9E-9B71-5AB7-A104-B9896CCF5BC9}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IPedometerReading; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IPedometerReading>>
  IAsyncOperation_1__IVectorView_1__IPedometerReading_Base = interface(IInspectable)
  ['{2AEAC503-A3A8-57B3-A8A9-E16B0CD4C0A4}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Sensors.IPedometerReading>>
  IAsyncOperation_1__IVectorView_1__IPedometerReading = interface(IAsyncOperation_1__IVectorView_1__IPedometerReading_Base)
  ['{F29A8A7A-BB35-53C8-B794-C7A235320EF5}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading; safecall;
    function GetResults: IVectorView_1__IPedometerReading; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IPedometerReading read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IPedometerStatics
  [WinRTClassNameAttribute(SPedometer)]
  IPedometerStatics = interface(IInspectable)
  ['{82980A2F-4083-4DFB-B411-938EA0F4B946}']
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IPedometer; safecall;
    function GetDefaultAsync: IAsyncOperation_1__IPedometer; safecall;
    function GetDeviceSelector: HSTRING; safecall;
    function GetSystemHistoryAsync(fromTime: DateTime): IAsyncOperation_1__IVectorView_1__IPedometerReading; overload; safecall;
    function GetSystemHistoryAsync(fromTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IPedometerReading; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IProximitySensorReading
  [WinRTClassNameAttribute(SProximitySensorReading)]
  IProximitySensorReading = interface(IInspectable)
  ['{71228D59-132D-4D5F-8FF9-2F0DB8751CED}']
    function get_Timestamp: DateTime; safecall;
    function get_IsDetected: Boolean; safecall;
    function get_DistanceInMillimeters: IReference_1__Cardinal; safecall;
    property DistanceInMillimeters: IReference_1__Cardinal read get_DistanceInMillimeters;
    property IsDetected: Boolean read get_IsDetected;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IProximitySensorReadingChangedEventArgs
  [WinRTClassNameAttribute(SProximitySensorReadingChangedEventArgs)]
  IProximitySensorReadingChangedEventArgs = interface(IInspectable)
  ['{CFC2F366-C3E8-40FD-8CC3-67E289004938}']
    function get_Reading: IProximitySensorReading; safecall;
    property Reading: IProximitySensorReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IProximitySensor,Windows.Devices.Sensors.IProximitySensorReadingChangedEventArgs>
  TypedEventHandler_2__IProximitySensor__IProximitySensorReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{9F7E222B-892A-5E68-B08A-10384B5F92B9}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IProximitySensor,Windows.Devices.Sensors.IProximitySensorReadingChangedEventArgs>
  TypedEventHandler_2__IProximitySensor__IProximitySensorReadingChangedEventArgs = interface(TypedEventHandler_2__IProximitySensor__IProximitySensorReadingChangedEventArgs_Delegate_Base)
  ['{26EF705D-2550-54A0-B0D7-82B21D59B6E1}']
    procedure Invoke(sender: IProximitySensor; args: IProximitySensorReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IProximitySensor
  [WinRTClassNameAttribute(SProximitySensor)]
  IProximitySensor = interface(IInspectable)
  ['{54C076B8-ECFB-4944-B928-74FC504D47EE}']
    function get_DeviceId: HSTRING; safecall;
    function get_MaxDistanceInMillimeters: IReference_1__Cardinal; safecall;
    function get_MinDistanceInMillimeters: IReference_1__Cardinal; safecall;
    function GetCurrentReading: IProximitySensorReading; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IProximitySensor__IProximitySensorReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    function CreateDisplayOnOffController: IClosable; safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property MaxDistanceInMillimeters: IReference_1__Cardinal read get_MaxDistanceInMillimeters;
    property MinDistanceInMillimeters: IReference_1__Cardinal read get_MinDistanceInMillimeters;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IProximitySensorStatics
  [WinRTClassNameAttribute(SProximitySensor)]
  IProximitySensorStatics = interface(IInspectable)
  ['{29186649-6269-4E57-A5AD-82BE80813392}']
    function GetDeviceSelector: HSTRING; safecall;
    function FromId(sensorId: HSTRING): IProximitySensor; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAltimeterReading
  [WinRTClassNameAttribute(SAltimeterReading)]
  IAltimeterReading = interface(IInspectable)
  ['{FBE8EF73-7F5E-48C8-AA1A-F1F3BEFC1144}']
    function get_Timestamp: DateTime; safecall;
    function get_AltitudeChangeInMeters: Double; safecall;
    property AltitudeChangeInMeters: Double read get_AltitudeChangeInMeters;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAltimeterReadingChangedEventArgs
  [WinRTClassNameAttribute(SAltimeterReadingChangedEventArgs)]
  IAltimeterReadingChangedEventArgs = interface(IInspectable)
  ['{7069D077-446D-47F7-998C-EBC23B45E4A2}']
    function get_Reading: IAltimeterReading; safecall;
    property Reading: IAltimeterReading read get_Reading;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAltimeter,Windows.Devices.Sensors.IAltimeterReadingChangedEventArgs>
  TypedEventHandler_2__IAltimeter__IAltimeterReadingChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{D775D699-9D74-5473-9C1B-D51A89DB6642}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.IAltimeter,Windows.Devices.Sensors.IAltimeterReadingChangedEventArgs>
  TypedEventHandler_2__IAltimeter__IAltimeterReadingChangedEventArgs = interface(TypedEventHandler_2__IAltimeter__IAltimeterReadingChangedEventArgs_Delegate_Base)
  ['{1564E105-0FCE-54DB-BEFC-EA3A8A698F3D}']
    procedure Invoke(sender: IAltimeter; args: IAltimeterReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAltimeter
  [WinRTClassNameAttribute(SAltimeter)]
  IAltimeter = interface(IInspectable)
  ['{72F057FD-8F04-49F1-B4A7-F4E363B701A2}']
    function GetCurrentReading: IAltimeterReading; safecall;
    function get_DeviceId: HSTRING; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__IAltimeter__IAltimeterReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.IAltimeterStatics
  [WinRTClassNameAttribute(SAltimeter)]
  IAltimeterStatics = interface(IInspectable)
  ['{9EB4D7C3-E5AC-47CE-8EEF-D3718168C01F}']
    function GetDefault: IAltimeter; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.Custom.ICustomSensorReading
  [WinRTClassNameAttribute(SCustom_CustomSensorReading)]
  Custom_ICustomSensorReading = interface(IInspectable)
  ['{64004F4D-446A-4366-A87A-5F963268EC53}']
    function get_Timestamp: DateTime; safecall;
    function get_Properties: IMapView_2__HSTRING__IInspectable; safecall;
    property Properties: IMapView_2__HSTRING__IInspectable read get_Properties;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.Custom.ICustomSensorReadingChangedEventArgs
  [WinRTClassNameAttribute(SCustom_CustomSensorReadingChangedEventArgs)]
  Custom_ICustomSensorReadingChangedEventArgs = interface(IInspectable)
  ['{6B202023-CFFD-4CC1-8FF0-E21823D76FCC}']
    function get_Reading: Custom_ICustomSensorReading; safecall;
    property Reading: Custom_ICustomSensorReading read get_Reading;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Sensors.Custom.ICustomSensor,Windows.Devices.Sensors.Custom.ICustomSensorReadingChangedEventArgs>
  TypedEventHandler_2__Custom_ICustomSensor__Custom_ICustomSensorReadingChangedEventArgs = interface(IUnknown)
  ['{A0D2F048-CAC9-5841-927F-5B5A19B6B0B1}']
    procedure Invoke(sender: Custom_ICustomSensor; args: Custom_ICustomSensorReadingChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.Custom.ICustomSensor
  [WinRTClassNameAttribute(SCustom_CustomSensor)]
  Custom_ICustomSensor = interface(IInspectable)
  ['{A136F9AD-4034-4B4D-99DD-531AAC649C09}']
    function GetCurrentReading: Custom_ICustomSensorReading; safecall;
    function get_MinimumReportInterval: Cardinal; safecall;
    procedure put_ReportInterval(value: Cardinal); safecall;
    function get_ReportInterval: Cardinal; safecall;
    function get_DeviceId: HSTRING; safecall;
    function add_ReadingChanged(handler: TypedEventHandler_2__Custom_ICustomSensor__Custom_ICustomSensorReadingChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReadingChanged(token: EventRegistrationToken); safecall;
    property DeviceId: HSTRING read get_DeviceId;
    property MinimumReportInterval: Cardinal read get_MinimumReportInterval;
    property ReportInterval: Cardinal read get_ReportInterval write put_ReportInterval;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Sensors.Custom.ICustomSensor>
  AsyncOperationCompletedHandler_1__Custom_ICustomSensor = interface(IUnknown)
  ['{AA01C1BB-91C4-54DB-9838-F10719591E16}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Custom_ICustomSensor; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Sensors.Custom.ICustomSensor>
  IAsyncOperation_1__Custom_ICustomSensor = interface(IInspectable)
  ['{0E389148-2046-5C91-B993-D30929949BF8}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Custom_ICustomSensor); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Custom_ICustomSensor; safecall;
    function GetResults: Custom_ICustomSensor; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Custom_ICustomSensor read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Sensors.Custom.ICustomSensorStatics
  [WinRTClassNameAttribute(SCustom_CustomSensor)]
  Custom_ICustomSensorStatics = interface(IInspectable)
  ['{992052CF-F422-4C7D-836B-E7DC74A7124B}']
    function GetDeviceSelector(interfaceId: TGuid): HSTRING; safecall;
    function FromIdAsync(sensorId: HSTRING): IAsyncOperation_1__Custom_ICustomSensor; safecall;
  end;


  // Emit Forwarded classes
  // Windows.Devices.Sensors.Accelerometer
  // DualAPI
  TAccelerometer = class(TWinRTGenericImportS<IAccelerometerStatics>)
  public
    // -> IAccelerometerStatics
    class function GetDefault: IAccelerometer; static; inline;
  end;

  // Windows.Devices.Sensors.AccelerometerReading
  // DualAPI

  // Windows.Devices.Sensors.AccelerometerReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.AccelerometerShakenEventArgs
  // DualAPI

  // Windows.Devices.Sensors.Inclinometer
  // DualAPI
  TInclinometer = class(TWinRTGenericImportS2<IInclinometerStatics, IInclinometerStatics2>)
  public
    // -> IInclinometerStatics2
    class function GetDefaultForRelativeReadings: IInclinometer; static; inline;

    // -> IInclinometerStatics
    class function GetDefault: IInclinometer; static; inline;
  end;

  // Windows.Devices.Sensors.InclinometerReading
  // DualAPI

  // Windows.Devices.Sensors.InclinometerReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.Gyrometer
  // DualAPI
  TGyrometer = class(TWinRTGenericImportS<IGyrometerStatics>)
  public
    // -> IGyrometerStatics
    class function GetDefault: IGyrometer; static; inline;
  end;

  // Windows.Devices.Sensors.GyrometerReading
  // DualAPI

  // Windows.Devices.Sensors.GyrometerReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.Compass
  // DualAPI
  TCompass = class(TWinRTGenericImportS<ICompassStatics>)
  public
    // -> ICompassStatics
    class function GetDefault: ICompass; static; inline;
  end;

  // Windows.Devices.Sensors.CompassReading
  // DualAPI

  // Windows.Devices.Sensors.CompassReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.LightSensor
  // DualAPI
  TLightSensor = class(TWinRTGenericImportS<ILightSensorStatics>)
  public
    // -> ILightSensorStatics
    class function GetDefault: ILightSensor; static; inline;
  end;

  // Windows.Devices.Sensors.LightSensorReading
  // DualAPI

  // Windows.Devices.Sensors.LightSensorReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.SensorRotationMatrix
  // DualAPI

  // Windows.Devices.Sensors.SensorQuaternion
  // DualAPI

  // Windows.Devices.Sensors.OrientationSensor
  // DualAPI
  TOrientationSensor = class(TWinRTGenericImportS2<IOrientationSensorStatics, IOrientationSensorStatics2>)
  public
    // -> IOrientationSensorStatics2
    class function GetDefaultForRelativeReadings: IOrientationSensor; static; inline;

    // -> IOrientationSensorStatics
    class function GetDefault: IOrientationSensor; static; inline;
  end;

  // Windows.Devices.Sensors.OrientationSensorReading
  // DualAPI

  // Windows.Devices.Sensors.OrientationSensorReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.SimpleOrientationSensor
  // DualAPI
  TSimpleOrientationSensor = class(TWinRTGenericImportS<ISimpleOrientationSensorStatics>)
  public
    // -> ISimpleOrientationSensorStatics
    class function GetDefault: ISimpleOrientationSensor; static; inline;
  end;

  // Windows.Devices.Sensors.SimpleOrientationSensorOrientationChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.Magnetometer
  // DualAPI
  TMagnetometer = class(TWinRTGenericImportS<IMagnetometerStatics>)
  public
    // -> IMagnetometerStatics
    class function GetDefault: IMagnetometer; static; inline;
  end;

  // Windows.Devices.Sensors.MagnetometerReading
  // DualAPI

  // Windows.Devices.Sensors.MagnetometerReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.ActivitySensor
  // DualAPI
  TActivitySensor = class(TWinRTGenericImportS<IActivitySensorStatics>)
  public
    // -> IActivitySensorStatics
    class function GetDefaultAsync: IAsyncOperation_1__IActivitySensor; static; inline;
    class function GetDeviceSelector: HSTRING; static; inline;
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IActivitySensor; static; inline;
    class function GetSystemHistoryAsync(fromTime: DateTime): IAsyncOperation_1__IVectorView_1__IActivitySensorReading; overload; static; inline;
    class function GetSystemHistoryAsync(fromTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IActivitySensorReading; overload; static; inline;
  end;

  // Windows.Devices.Sensors.ActivitySensorReading
  // DualAPI

  // Windows.Devices.Sensors.ActivitySensorReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.ActivitySensorReadingChangeReport
  // DualAPI

  // Windows.Devices.Sensors.Barometer
  // DualAPI
  TBarometer = class(TWinRTGenericImportS<IBarometerStatics>)
  public
    // -> IBarometerStatics
    class function GetDefault: IBarometer; static; inline;
  end;

  // Windows.Devices.Sensors.BarometerReading
  // DualAPI

  // Windows.Devices.Sensors.BarometerReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.PedometerReading
  // DualAPI

  // Windows.Devices.Sensors.Pedometer
  // DualAPI
  TPedometer = class(TWinRTGenericImportS<IPedometerStatics>)
  public
    // -> IPedometerStatics
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IPedometer; static; inline;
    class function GetDefaultAsync: IAsyncOperation_1__IPedometer; static; inline;
    class function GetDeviceSelector: HSTRING; static; inline;
    class function GetSystemHistoryAsync(fromTime: DateTime): IAsyncOperation_1__IVectorView_1__IPedometerReading; overload; static; inline;
    class function GetSystemHistoryAsync(fromTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IPedometerReading; overload; static; inline;
  end;

  // Windows.Devices.Sensors.PedometerReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.ProximitySensor
  // DualAPI
  TProximitySensor = class(TWinRTGenericImportS<IProximitySensorStatics>)
  public
    // -> IProximitySensorStatics
    class function GetDeviceSelector: HSTRING; static; inline;
    class function FromId(sensorId: HSTRING): IProximitySensor; static; inline;
  end;

  // Windows.Devices.Sensors.ProximitySensorReading
  // DualAPI

  // Windows.Devices.Sensors.ProximitySensorReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.ProximitySensorDisplayOnOffController
  // DualAPI

  // Windows.Devices.Sensors.Altimeter
  // DualAPI
  TAltimeter = class(TWinRTGenericImportS<IAltimeterStatics>)
  public
    // -> IAltimeterStatics
    class function GetDefault: IAltimeter; static; inline;
  end;

  // Windows.Devices.Sensors.AltimeterReading
  // DualAPI

  // Windows.Devices.Sensors.AltimeterReadingChangedEventArgs
  // DualAPI

  // Windows.Devices.Sensors.Custom.CustomSensor
  // DualAPI
  TCustom_CustomSensor = class(TWinRTGenericImportS<Custom_ICustomSensorStatics>)
  public
    // -> Custom_ICustomSensorStatics
    class function GetDeviceSelector(interfaceId: TGuid): HSTRING; static; inline;
    class function FromIdAsync(sensorId: HSTRING): IAsyncOperation_1__Custom_ICustomSensor; static; inline;
  end;

  // Windows.Devices.Sensors.Custom.CustomSensorReading
  // DualAPI

  // Windows.Devices.Sensors.Custom.CustomSensorReadingChangedEventArgs
  // DualAPI


implementation

  // Emit Classes Implementation
 { TAccelerometer }

class function TAccelerometer.GetDefault: IAccelerometer;
begin
  Result := Statics.GetDefault;
end;


 { TInclinometer }

class function TInclinometer.GetDefault: IInclinometer;
begin
  Result := Statics.GetDefault;
end;


class function TInclinometer.GetDefaultForRelativeReadings: IInclinometer;
begin
  Result := Statics2.GetDefaultForRelativeReadings;
end;


 { TGyrometer }

class function TGyrometer.GetDefault: IGyrometer;
begin
  Result := Statics.GetDefault;
end;


 { TCompass }

class function TCompass.GetDefault: ICompass;
begin
  Result := Statics.GetDefault;
end;


 { TLightSensor }

class function TLightSensor.GetDefault: ILightSensor;
begin
  Result := Statics.GetDefault;
end;


 { TOrientationSensor }

class function TOrientationSensor.GetDefault: IOrientationSensor;
begin
  Result := Statics.GetDefault;
end;


class function TOrientationSensor.GetDefaultForRelativeReadings: IOrientationSensor;
begin
  Result := Statics2.GetDefaultForRelativeReadings;
end;


 { TSimpleOrientationSensor }

class function TSimpleOrientationSensor.GetDefault: ISimpleOrientationSensor;
begin
  Result := Statics.GetDefault;
end;


 { TMagnetometer }

class function TMagnetometer.GetDefault: IMagnetometer;
begin
  Result := Statics.GetDefault;
end;


 { TActivitySensor }

class function TActivitySensor.GetDefaultAsync: IAsyncOperation_1__IActivitySensor;
begin
  Result := Statics.GetDefaultAsync;
end;

class function TActivitySensor.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;

class function TActivitySensor.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IActivitySensor;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TActivitySensor.GetSystemHistoryAsync(fromTime: DateTime): IAsyncOperation_1__IVectorView_1__IActivitySensorReading;
begin
  Result := Statics.GetSystemHistoryAsync(fromTime);
end;

class function TActivitySensor.GetSystemHistoryAsync(fromTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IActivitySensorReading;
begin
  Result := Statics.GetSystemHistoryAsync(fromTime, duration);
end;


 { TBarometer }

class function TBarometer.GetDefault: IBarometer;
begin
  Result := Statics.GetDefault;
end;


 { TPedometer }

class function TPedometer.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IPedometer;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TPedometer.GetDefaultAsync: IAsyncOperation_1__IPedometer;
begin
  Result := Statics.GetDefaultAsync;
end;

class function TPedometer.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;

class function TPedometer.GetSystemHistoryAsync(fromTime: DateTime): IAsyncOperation_1__IVectorView_1__IPedometerReading;
begin
  Result := Statics.GetSystemHistoryAsync(fromTime);
end;

class function TPedometer.GetSystemHistoryAsync(fromTime: DateTime; duration: TimeSpan): IAsyncOperation_1__IVectorView_1__IPedometerReading;
begin
  Result := Statics.GetSystemHistoryAsync(fromTime, duration);
end;


 { TProximitySensor }

class function TProximitySensor.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;

class function TProximitySensor.FromId(sensorId: HSTRING): IProximitySensor;
begin
  Result := Statics.FromId(sensorId);
end;


 { TAltimeter }

class function TAltimeter.GetDefault: IAltimeter;
begin
  Result := Statics.GetDefault;
end;


 { TCustom_CustomSensor }

class function TCustom_CustomSensor.GetDeviceSelector(interfaceId: TGuid): HSTRING;
begin
  Result := Statics.GetDeviceSelector(interfaceId);
end;

class function TCustom_CustomSensor.FromIdAsync(sensorId: HSTRING): IAsyncOperation_1__Custom_ICustomSensor;
begin
  Result := Statics.FromIdAsync(sensorId);
end;



end.
