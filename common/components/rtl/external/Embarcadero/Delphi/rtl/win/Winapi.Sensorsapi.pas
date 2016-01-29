{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.Sensorsapi;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include "sensorsapi.h"'}
{$HPPEMIT ''}

interface

uses Winapi.ActiveX, Winapi.Portabledevicetypes, Winapi.Propsys, Winapi.Windows;


type
  SensorState = type Integer;
  {$EXTERNALSYM SensorState}
const
  SENSOR_STATE_MIN           = 0; 
  {$EXTERNALSYM SENSOR_STATE_MIN}
  SENSOR_STATE_READY         = SENSOR_STATE_MIN; 
  {$EXTERNALSYM SENSOR_STATE_READY}
  SENSOR_STATE_NOT_AVAILABLE = SENSOR_STATE_READY + 1; 
  {$EXTERNALSYM SENSOR_STATE_NOT_AVAILABLE}
  SENSOR_STATE_NO_DATA       = SENSOR_STATE_NOT_AVAILABLE + 1; 
  {$EXTERNALSYM SENSOR_STATE_NO_DATA}
  SENSOR_STATE_INITIALIZING  = SENSOR_STATE_NO_DATA + 1; 
  {$EXTERNALSYM SENSOR_STATE_INITIALIZING}
  SENSOR_STATE_ACCESS_DENIED = SENSOR_STATE_INITIALIZING + 1;
  {$EXTERNALSYM SENSOR_STATE_ACCESS_DENIED}
  SENSOR_STATE_ERROR         = SENSOR_STATE_ACCESS_DENIED + 1; 
  {$EXTERNALSYM SENSOR_STATE_ERROR}
  SENSOR_STATE_MAX           = SENSOR_STATE_ERROR; 
  {$EXTERNALSYM SENSOR_STATE_MAX}

type
  SensorConnectionType = type Integer; 
  {$EXTERNALSYM SensorConnectionType}
const
  SENSOR_CONNECTION_TYPE_PC_INTEGRATED = 0; 
  {$EXTERNALSYM SENSOR_CONNECTION_TYPE_PC_INTEGRATED}
  SENSOR_CONNECTION_TYPE_PC_ATTACHED   = SENSOR_CONNECTION_TYPE_PC_INTEGRATED + 1; 
  {$EXTERNALSYM SENSOR_CONNECTION_TYPE_PC_ATTACHED}
  SENSOR_CONNECTION_TYPE_PC_EXTERNAL   = SENSOR_CONNECTION_TYPE_PC_ATTACHED + 1; 
  {$EXTERNALSYM SENSOR_CONNECTION_TYPE_PC_EXTERNAL}

type
  LOCATION_DESIRED_ACCURACY = type Integer; 
  {$EXTERNALSYM LOCATION_DESIRED_ACCURACY}
const
  LOCATION_DESIRED_ACCURACY_DEFAULT = 0; 
  {$EXTERNALSYM LOCATION_DESIRED_ACCURACY_DEFAULT}
  LOCATION_DESIRED_ACCURACY_HIGH    = LOCATION_DESIRED_ACCURACY_DEFAULT + 1; 
  {$EXTERNALSYM LOCATION_DESIRED_ACCURACY_HIGH}

type
  SENSOR_CATEGORY_ID = TGuid;
  {$EXTERNALSYM SENSOR_CATEGORY_ID}
  REFSENSOR_CATEGORY_ID = TGuid;
  {$EXTERNALSYM REFSENSOR_CATEGORY_ID}
  SENSOR_TYPE_ID = TGuid;
  {$EXTERNALSYM SENSOR_TYPE_ID}
  REFSENSOR_TYPE_ID = TGuid;
  {$EXTERNALSYM REFSENSOR_TYPE_ID}
  SENSOR_ID = TGuid;
  {$EXTERNALSYM SENSOR_ID}
  REFSENSOR_ID = TGuid;
  {$EXTERNALSYM REFSENSOR_ID}

const
  SID_ISensorManager = '{BD77DB67-45A8-42DC-8D00-6DCF15F8377A}';
  {$EXTERNALSYM SID_ISensorManager}
  IID_ISensorManager: TGUID = '{BD77DB67-45A8-42DC-8D00-6DCF15F8377A}';
  {$EXTERNALSYM IID_ISensorManager}
  SID_ISensorCollection = '{23571E11-E545-4DD8-A337-B89BF44B10DF}';
  {$EXTERNALSYM SID_ISensorCollection}
  IID_ISensorCollection: TGUID = '{23571E11-E545-4DD8-A337-B89BF44B10DF}';
  {$EXTERNALSYM IID_ISensorCollection}
  SID_ISensor = '{5FA08F80-2657-458E-AF75-46F73FA6AC5C}';
  {$EXTERNALSYM SID_ISensor}
  IID_ISensor: TGUID = '{5FA08F80-2657-458E-AF75-46F73FA6AC5C}';
  {$EXTERNALSYM IID_ISensor}
  SID_ISensorDataReport = '{0AB9DF9B-C4B5-4796-8898-0470706A2E1D}';
  {$EXTERNALSYM SID_ISensorDataReport}
  IID_ISensorDataReport: TGUID = '{0AB9DF9B-C4B5-4796-8898-0470706A2E1D}';
  {$EXTERNALSYM IID_ISensorDataReport}
  SID_ISensorManagerEvents = '{9B3B0B86-266A-4AAD-B21F-FDE5501001B7}';
  {$EXTERNALSYM SID_ISensorManagerEvents}
  IID_ISensorManagerEvents = '{9B3B0B86-266A-4AAD-B21F-FDE5501001B7}';
  {$EXTERNALSYM IID_ISensorManagerEvents}
  SID_ISensorEvents = '{5D8DCC91-4641-47E7-B7C3-B74F48A6C391}';
  {$EXTERNALSYM SID_ISensorEvents}
  IID_ISensorEvents: TGUID = '{5D8DCC91-4641-47E7-B7C3-B74F48A6C391}';
  {$EXTERNALSYM IID_ISensorEvents}
  SID_ILogicalSensorManager = '{7490B4D4-1BE9-469A-9743-37A27C1D80AF}';
  {$EXTERNALSYM SID_ILogicalSensorManager}
  IID_ILogicalSensorManager: TGUID = '{7490B4D4-1BE9-469A-9743-37A27C1D80AF}';
  {$EXTERNALSYM IID_ILogicalSensorManager}

type
  ISensorManager = interface;
  ISensorCollection = interface;
  ISensor = interface;
  ISensorDataReport = interface;
  ISensorManagerEvents = interface;
  ISensorEvents = interface;
  ILogicalSensorManager = interface;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISensorManager);'}
  ISensorManager = interface(IUnknown)
    [SID_ISensorManager]
    function GetSensorsByCategory(const sensorCategory: SENSOR_CATEGORY_ID; out ppSensorsFound: ISensorCollection): HRESULT; stdcall;
    function GetSensorsByType(const sensorType: SENSOR_TYPE_ID; out ppSensorsFound: ISensorCollection): HRESULT; stdcall;
    function GetSensorByID(const sensorID: SENSOR_ID; out ppSensor: ISensor): HRESULT; stdcall;
    function SetEventSink(const pEvents: ISensorManagerEvents): HRESULT; stdcall;
    function RequestPermissions(hParent: HWND; const pSensors: ISensorCollection; fModal: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISensorManager}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISensorCollection);'}
  ISensorCollection = interface(IUnknown)
    [SID_ISensorCollection]
    function GetAt(ulIndex: Cardinal; out ppSensor: ISensor): HRESULT; stdcall;
    function GetCount(out pCount : Cardinal): HRESULT; stdcall;
    function Add(const pSensor : ISensor): HRESULT; stdcall;
    function Remove(const pSensor : ISensor): HRESULT; stdcall;
    function RemoveByID(sensorID : REFSENSOR_ID): HRESULT; stdcall;
    function Clear: HRESULT; stdcall; { [helpstring] }
  end;
  {$EXTERNALSYM ISensorCollection}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISensor);'}
  ISensor = interface(IUnknown) 
    [SID_ISensor]
    function GetID(out pID: SENSOR_ID): HRESULT; stdcall;
    function GetCategory(out pSensorCategory: SENSOR_CATEGORY_ID): HRESULT; stdcall;
    function GetType(out pSensorType: SENSOR_TYPE_ID): HRESULT; stdcall;
    function GetFriendlyName(out pFriendlyName: WideString): HRESULT; stdcall;
    function GetProperty(const key: PROPERTYKEY; out pProperty: PROPVARIANT): HRESULT; stdcall;
    function GetProperties(const pKeys: IPortableDeviceKeyCollection; out ppProperties: IPortableDeviceValues): HRESULT; stdcall;
    function GetSupportedDataFields(out ppDataFields: IPortableDeviceKeyCollection): HRESULT; stdcall;
    function SetProperties(const pProperties: IPortableDeviceValues; out ppResults: IPortableDeviceValues): HRESULT; stdcall;
    function SupportsDataField(const key: PROPERTYKEY; out pIsSupported: VARIANT_BOOL): HRESULT; stdcall;
    function GetState(out  pState: SensorState): HRESULT; stdcall;
    function GetData(out ppDataReport: ISensorDataReport): HRESULT; stdcall;
    function SupportsEvent(const eventGuid: TGuid; out pIsSupported: VARIANT_BOOL): HRESULT; stdcall;
    function GetEventInterest(out ppValues: PGUID; out pCount : Cardinal): HRESULT; stdcall;
    function SetEventInterest(pValues : PGUID; count : Cardinal): HRESULT; stdcall;
    function SetEventSink(const pEvents : ISensorEvents): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISensor}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISensorDataReport);'}
  ISensorDataReport = interface(IUnknown) 
    [SID_ISensorDataReport]
    function GetTimestamp(out pTimeStamp: SYSTEMTIME): HRESULT; stdcall;
    function GetSensorValue(const pKey: PROPERTYKEY; out pValue: PROPVARIANT): HRESULT; stdcall;
    function GetSensorValues(const pKeys: IPortableDeviceKeyCollection; out ppValues: IPortableDeviceValues): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISensorDataReport}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISensorManagerEvents);'}
  ISensorManagerEvents = interface(IUnknown)
    [SID_ISensorManagerEvents]
    function OnSensorEnter(const pSensor: ISensor; state : SensorState): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISensorManagerEvents}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ISensorEvents);'}
  ISensorEvents = interface(IUnknown)
    [SID_ISensorEvents]
    function OnStateChanged(const pSensor : ISensor; state : SensorState): HRESULT; stdcall;
    function OnDataUpdated(const pSensor : ISensor; const pNewData : ISensorDataReport): HRESULT; stdcall;
    function OnEvent(const pSensor : ISensor; const eventID : TGuid; const pEventData : IPortableDeviceValues): HRESULT; stdcall;
    function OnLeave(const ID : SENSOR_ID): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ISensorEvents}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ILogicalSensorManager);'}
  ILogicalSensorManager = interface(IUnknown) 
    [SID_ILogicalSensorManager]
    function Connect(const logicalID: TGuid; const pPropertyStore: IPropertyStore): HRESULT; stdcall;
    function Uninstall(const logicalID: TGuid): HRESULT; stdcall;
    function Disconnect(const logicalID: TGuid): HRESULT; stdcall;
  end;
  {$EXTERNALSYM ILogicalSensorManager}

const
  CLSID_SensorManager: TGUID = '{77A1C827-FCD2-4689-8915-9D613CC5FA3E}';
  {$EXTERNALSYM CLSID_SensorManager}
  CLSID_SensorCollection: TGUID = '{79C43ADB-A429-469F-AA39-2F2B74B75937}';
  {$EXTERNALSYM CLSID_SensorCollection}
  CLSID_Sensor: TGUID = '{E97CED00-523A-4133-BF6F-D3A2DAE7F6BA}';
  {$EXTERNALSYM CLSID_Sensor}
  CLSID_SensorDataReport: TGUID = '{4EA9D6EF-694B-4218-8816-CCDA8DA74BBA}';
  {$EXTERNALSYM CLSID_SensorDataReport}
  CLSID_LogicalSensorManager: TGUID = '{50A7B286-7D23-41E6-9440-4DAEE00DC5F0}';
  {$EXTERNALSYM CLSID_LogicalSensorManager}

implementation

end.
