{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Sensor;

interface

uses Posix.SysTypes, Androidapi.Looper;

(*$HPPEMIT '#include <android/sensor.h>' *)

{$I Androidapi.inc}


const
  ASENSOR_TYPE_ACCELEROMETER       = 1;
  {$EXTERNALSYM ASENSOR_TYPE_ACCELEROMETER}

  ASENSOR_TYPE_MAGNETIC_FIELD      = 2;
  {$EXTERNALSYM ASENSOR_TYPE_MAGNETIC_FIELD}

  ASENSOR_TYPE_GYROSCOPE           = 4;
  {$EXTERNALSYM ASENSOR_TYPE_GYROSCOPE}

  ASENSOR_TYPE_LIGHT               = 5;
  {$EXTERNALSYM ASENSOR_TYPE_LIGHT}

  ASENSOR_TYPE_PRESSURE            = 6;

  ASENSOR_TYPE_PROXIMITY           = 8;
  {$EXTERNALSYM ASENSOR_TYPE_PROXIMITY}

  ASENSOR_TYPE_GRAVITY             = 9;

  ASENSOR_TYPE_LINEAR_ACCELERATION = 10;

  ASENSOR_TYPE_ROTATION_VECTOR     = 11;

  ASENSOR_TYPE_RELATIVE_HUMIDITY   = 12;

  ASENSOR_TYPE_AMBIENT_TEMPERATURE = 13;


{ Sensor accuracy measure }
const
  ASENSOR_STATUS_UNRELIABLE       = 0;
  {$EXTERNALSYM ASENSOR_STATUS_UNRELIABLE}
  
  ASENSOR_STATUS_ACCURACY_LOW     = 1;
  {$EXTERNALSYM ASENSOR_STATUS_ACCURACY_LOW}
  
  ASENSOR_STATUS_ACCURACY_MEDIUM  = 2;
  {$EXTERNALSYM ASENSOR_STATUS_ACCURACY_MEDIUM}
  
  ASENSOR_STATUS_ACCURACY_HIGH    = 3;
  {$EXTERNALSYM ASENSOR_STATUS_ACCURACY_HIGH}

  
{ A few useful constants }
const
{ Earth's gravity in m/s^2 }
  ASENSOR_STANDARD_GRAVITY         = 9.80665;
  {$EXTERNALSYM ASENSOR_STANDARD_GRAVITY}
  
{ Maximum magnetic field on Earth's surface in uT }
  ASENSOR_MAGNETIC_FIELD_EARTH_MAX = 60.0;
  {$EXTERNALSYM ASENSOR_MAGNETIC_FIELD_EARTH_MAX}
  
{ Minimum magnetic field on Earth's surface in uT }
  ASENSOR_MAGNETIC_FIELD_EARTH_MIN = 30.0;
  {$EXTERNALSYM ASENSOR_MAGNETIC_FIELD_EARTH_MIN}
  
type
{ A sensor event.
  NOTE: Must match hardware/sensors.h
 }
  ASensorVector = record
    case Integer of
      0: (v: array[0..2] of Single;
          status: ShortInt;
          reserved: array[0..2] of ShortInt);
      1: (x, y, z: Single);
      2: (azimuth, pitch, roll: Single);
  end;
  {$EXTERNALSYM ASensorVector}
  
  PASensorVector = ^ASensorVector;

  { NOTE: Must match hardware/sensors.h }
  ASensorEvent = record
    version: Int32; { sizeof(struct ASensorEvent) }
    sensor: Int32;
    __type: Int32;
    reserved0: Int32;
    timestamp: Int64;

    case Integer of
      0:(data: array[0..15] of Single;
         reserved1: array[0..3] of Int32);
      1:(vector: ASensorVector);
      2:(acceleration: ASensorVector);
      3:(magnetic: ASensorVector);
      4:(temperature: Single);
      5:(distance: Single);
      6:(light: Single);
      7:(pressure: Single);
      8:(proximity: Single);
  end;
  {$EXTERNALSYM ASensorEvent}
  PASensorEvent = ^ASensorEvent;


  ASensorManager = record end;
  {$EXTERNALSYM ASensorManager}
  PASensorManager = ^ASensorManager;

  ASensorEventQueue = record end;
  {$EXTERNALSYM ASensorEventQueue}
  PASensorEventQueue = ^ASensorEventQueue;

  ASensor = record end;
  {$EXTERNALSYM ASensor}
  PASensor = ^ASensor;
  
  ASensorRef = ^ASensor;
  {$EXTERNALSYM ASensorRef}
  
  ASensorList = ^ASensorRef;
  {$EXTERNALSYM ASensorList}
  

{ Get a reference to the sensor manager. ASensorManager is a singleton.
  Example: ASensorManager* sensorManager = ASensorManager_getInstance();
}
function ASensorManager_getInstance: PASensorManager; cdecl;
  external AndroidLib name 'ASensorManager_getInstance';
{$EXTERNALSYM ASensorManager_getInstance}

{ Returns the list of available sensors.}
function ASensorManager_getSensorList(SensorManager: PASensorManager; List: ASensorList): Integer; cdecl;
  external AndroidLib name 'ASensorManager_getSensorList';
{$EXTERNALSYM ASensorManager_getSensorList}

{ Returns the default sensor for the given type, or NULL if no sensor
  of that type exist.
}
function ASensorManager_getDefaultSensor(SensorManager: PASensorManager; SensorType: Integer): PASensor; cdecl;
  external AndroidLib name 'ASensorManager_getDefaultSensor';
{$EXTERNALSYM ASensorManager_getDefaultSensor}

{ Creates a new sensor event queue and associate it with a looper. }
function ASensorManager_createEventQueue(SensorManager: PASensorManager; Looper: PALooper; Ident: Integer; Callback: ALooper_callbackFunc; Data: Pointer): PASensorEventQueue; cdecl;
  external AndroidLib name 'ASensorManager_createEventQueue';
{$EXTERNALSYM ASensorManager_createEventQueue}

{ Destroys the event queue and free all resources associated to it. }
function ASensorManager_destroyEventQueue(SensorManager: PASensorManager;Queue: PASensorEventQueue): Integer; cdecl;
  external AndroidLib name 'ASensorManager_destroyEventQueue';
{$EXTERNALSYM ASensorManager_destroyEventQueue}


{ Enable the selected sensor. Returns a negative error code on failure. }
function ASensorEventQueue_enableSensor(SensorEventQueue: PASensorEventQueue; const Sensor: PASensor): Integer; cdecl;
  external AndroidLib name 'ASensorEventQueue_enableSensor';
{$EXTERNALSYM ASensorEventQueue_enableSensor}

{ Disable the selected sensor. Returns a negative error code on failure.}
function ASensorEventQueue_disableSensor(SensorEventQueue: PASensorEventQueue; const Sensor: PASensor): Integer; cdecl;
  external AndroidLib name 'ASensorEventQueue_disableSensor';
{$EXTERNALSYM ASensorEventQueue_disableSensor}

{ Sets the delivery rate of events in microseconds for the given sensor.
  Note that this is a hint only, generally event will arrive at a higher
  rate. It is an error to set a rate inferior to the value returned by
  ASensor_getMinDelay().
  Returns a negative error code on failure.
}
function ASensorEventQueue_setEventRate(SensorEventQueue: PASensorEventQueue; const Sensor: PASensor; USeconds: Int32): Integer; cdecl;
  external AndroidLib name 'ASensorEventQueue_setEventRate';
{$EXTERNALSYM ASensorEventQueue_setEventRate}

{ Returns true if there are one or more events available in the
  sensor queue.  Returns 1 if the queue has events; 0 if
  it does not have events; and a negative value if there is an error.
}
function ASensorEventQueue_hasEvents(SensorManager: PASensorManager): Integer; cdecl;
  external AndroidLib name 'ASensorEventQueue_hasEvents';
{$EXTERNALSYM ASensorEventQueue_hasEvents}

{ Returns the next available events from the queue.  Returns a negative
  value if no events are available or an error has occurred, otherwise
  the number of events returned.

  Examples:
    ASensorEvent event;
    ssize_t numEvent = ASensorEventQueue_getEvents(queue, &event, 1);

    ASensorEvent eventBuffer[8];
    ssize_t numEvent = ASensorEventQueue_getEvents(queue, eventBuffer, 8);

}
function ASensorEventQueue_getEvents(SensorEventQueue: PASensorEventQueue; SensorEvent: PASensorEvent; Count: size_t): ssize_t; cdecl;
  external AndroidLib name 'ASensorEventQueue_getEvents';
{$EXTERNALSYM ASensorEventQueue_getEvents}


{ Returns this sensor's name (non localized) }
function ASensor_getName(const Sensor: PASensor): MarshaledAString; cdecl;
  external AndroidLib name 'ASensor_getName';
{$EXTERNALSYM ASensor_getName}

{ Returns this sensor's vendor's name (non localized) }
function ASensor_getVendor(const Sensor: PASensor): MarshaledAString; cdecl;
  external AndroidLib name 'ASensor_getVendor';
{$EXTERNALSYM ASensor_getVendor}

{ Return this sensor's type }
function ASensor_getType(const Sensor: PASensor): Integer; cdecl;
  external AndroidLib name 'ASensor_getType';
{$EXTERNALSYM ASensor_getType}

{ Returns this sensors's resolution }
function ASensor_getResolution(const Sensor: PASensor): Single; cdecl;
  external AndroidLib name 'ASensor_getResolution';
{$EXTERNALSYM ASensor_getResolution}

{ Returns the minimum delay allowed between events in microseconds.
  A value of zero means that this sensor doesn't report events at a
  constant rate, but rather only when a new data is available.
}
function ASensor_getMinDelay(const Sensor: PASensor): Integer; cdecl;
  external AndroidLib name 'ASensor_getMinDelay';
{$EXTERNALSYM ASensor_getMinDelay}


implementation

end.
