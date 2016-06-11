{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Win.Bluetooth;

interface

uses
  System.SysUtils, System.Bluetooth;

{$SCOPEDENUMS ON}

{$DEFINE BLUETOOTH_CLASSIC}
{$DEFINE BLUETOOTH_LE}

type
{$IFDEF BLUETOOTH_CLASSIC}
  TPlatformBluetoothClassicManager = class(TBluetoothManager)
  protected
    class function GetBluetoothManager: TBluetoothManager; override;
  end;
{$ENDIF BLUETOOTH_CLASSIC}

{$IFDEF BLUETOOTH_LE}
  TPlatformBluetoothLEManager = class(TBluetoothLEManager)
  protected
    class function GetBluetoothManager: TBluetoothLEManager; override;
  end;
{$ENDIF BLUETOOTH_LE}


implementation

uses
  Winapi.Windows, Winapi.Winsock2, System.Types, System.Generics.Collections,
   System.SyncObjs, WinApi.Bluetooth,
{$IFDEF BLUETOOTH_LE}
  WinApi.BluetoothLE,
{$ENDIF BLUETOOTH_LE}
  System.Win.BluetoothWinRT,
  System.NetConsts, System.Classes, Winapi.Messages;

const
  SBluetoothMACAddressFormat = '%0.2X:%0.2X:%0.2X:%0.2X:%0.2X:%0.2X'; // Do not translate

type

{$IFDEF BLUETOOTH_CLASSIC}
  // --------------------------------------------------------------------- //
  //    Bluetooth Classic
  // --------------------------------------------------------------------- //
  TWinBluetoothAdapter = class;

  TWinBluetoothManager = class(TPlatformBluetoothClassicManager)
  private
    FClassicAdapter: TBluetoothAdapter;

  protected
    function GetAdapterState: TBluetoothAdapterState;
    function GetConnectionState: TBluetoothConnectionState; override;
    function DoGetClassicAdapter: TBluetoothAdapter; override;
    function DoEnableBluetooth: Boolean; override;
  public
    destructor Destroy; override;
  end;


  TWinBluetoothAdapter = class(TBluetoothAdapter)
  private type
    TThreadTimer = class(TThread)
    private
      FTimeout: Cardinal;
      FOnTimer: TDiscoverableEndEvent;
      FEvent: TEvent;
      procedure Cancel;
    public
      constructor Create(const AEvent: TDiscoverableEndEvent; Timeout: Cardinal); overload;
      destructor Destroy; override;
      procedure Execute; override;
    end;

    TDiscoverThread = class(TThread)
    private
      FAdapter: TWinBluetoothAdapter;
      FTimeout: Cardinal;
      Cancelled: Boolean;
    protected
      procedure Execute; override;
    public
      constructor Create(const AnAdapter: TWinBluetoothAdapter; Timeout: Cardinal);
      procedure Cancel;
    end;


  private
    FTimer: TThreadTimer;
    FState: TBluetoothAdapterState;
    FDiscoverThread: TDiscoverThread;
    FPairedDevices: TBluetoothDeviceList;

    function GetBthAddress: TBluetoothAddress;
    procedure GetDevicesByParam(const AList:TBluetoothDeviceList; AType: string; Timeout: Cardinal = 0);
  protected
    FRadioHandle: THandle;
    function GetAdapterName: string; override;
    procedure SetAdapterName(const Value: string); override;
    function GetAddress: System.Bluetooth.TBluetoothMacAddress; override;
    function GetPairedDevices: TBluetoothDeviceList; override;
    procedure DoDiscoverableEnd(const Sender: TObject); override;
    procedure DoStartDiscoverable(Timeout: Cardinal); override;

    procedure DoStartDiscovery(Timeout: Cardinal); override;
    procedure DoCancelDiscovery; override;

    function DoPair(const ADevice: TBluetoothDevice): Boolean; override;
    function DoUnPair(const ADevice: TBluetoothDevice): Boolean; override;

    function GetScanMode: TBluetoothScanMode; override;
    function GetState: TBluetoothAdapterState; override;

    function DoCreateServerSocket(const AName: string; const AUUID: TGUID; Secure: Boolean): TBluetoothServerSocket; override;

  public
    constructor Create(const AManager: TBluetoothManager; const ARadioHandle: THandle);
    destructor Destroy; override;

  end;

  TWinBluetoothDevice = class(TBluetoothDevice)
  protected
    FDeviceInfo: TBluetoothDeviceInfo;
    FAdapter: TWinBluetoothAdapter;
    FType: TBluetoothType;
    function GetAddress: TBluetoothMacAddress; override;
    function GetDeviceName: string; override;
    function GetPaired: Boolean; override;
    function GetState: TBluetoothDeviceState; override;
    function GetBluetoothType: TBluetoothType; override;
    function GetClassDevice: Integer; override;
    function GetClassDeviceMajor: Integer; override;
    function DoGetServices: TBluetoothServiceList; override;
    function DoCreateClientSocket(const AUUID: TGUID; Secure: Boolean): TBluetoothSocket; override;
  public
    constructor Create(const AnAdapter: TWinBluetoothAdapter; const ADeviceInfo: TBluetoothDeviceInfo);
  end;

  TWinBluetoothServerSocket = class(TBluetoothServerSocket)
  protected
    FListenSocket: TSocket;
    FWSAService: TWsaQuerySet;
    FCsAddr: TCsAddrInfo;
    FAddressBth: TSockAddrBth;
    FSecured: Boolean;

    function DoAccept(Timeout: Cardinal = 0): TBluetoothSocket; override;
    procedure DoClose; override;
  public
    constructor Create(const AName: string; const AUUID: TGUID; Secure: Boolean; const MACAddress: string);
    destructor Destroy; override;
  end;

  TWinBluetoothSocket = class(TBluetoothSocket)
  private
    FClientSocket: TSocket;
    FGUIDService: TGUID;
    FAddress: TBluetoothAddress;
    FConnected: Boolean;
    FSecure: Boolean;
    FLastReadTimeout: Cardinal;

    class constructor Create;
    class destructor Destroy;
  protected
    function GetConnected: Boolean; override;
    procedure DoClose; override;
    procedure DoConnect; override;
    function DoReceiveData(ATimeout: Cardinal): TBytes; override;
    procedure DoSendData(const AData: TBytes); override;
    constructor Create(const ASocket: TSocket; const AnAddress: TBluetoothAddress; const AUUID: TGUID; Secure: Boolean);
    destructor Destroy; override;
  end;
{$ENDIF BLUETOOTH_CLASSIC}

{$IFDEF BLUETOOTH_LE}
  // --------------------------------------------------------------------- //
  //    Bluetooth LE
  // --------------------------------------------------------------------- //

  // --------------------------------------------------------------------- //
  //  Required API from SetupAPI.h for LE
  // --------------------------------------------------------------------- //

{$IFDEF WIN32}
{$ALIGN OFF}
{$ENDIF}
type
  HDEVINFO = Pointer;
  {$EXTERNALSYM HDEVINFO}

  SP_DEVICE_INTERFACE_DATA = record
    cbSize: Cardinal;
    InterfaceClassGuid: TGUID;
    Flags: Cardinal;
    Reserved: ULONG_PTR;
  end;
  _SP_DEVICE_INTERFACE_DATA = SP_DEVICE_INTERFACE_DATA;
  {$EXTERNALSYM SP_DEVICE_INTERFACE_DATA}
  PSP_DEVICE_INTERFACE_DATA = ^SP_DEVICE_INTERFACE_DATA;
  {$EXTERNALSYM PSP_DEVICE_INTERFACE_DATA}

  SP_DEVICE_INTERFACE_DETAIL_DATA = record
      cbSize: Cardinal;
      DevicePath: array [0..0] of Char;
  end;
  _SP_DEVICE_INTERFACE_DETAIL_DATA = SP_DEVICE_INTERFACE_DETAIL_DATA;
  {$EXTERNALSYM SP_DEVICE_INTERFACE_DETAIL_DATA}
  PSP_DEVICE_INTERFACE_DETAIL_DATA = ^SP_DEVICE_INTERFACE_DETAIL_DATA;
  {$EXTERNALSYM PSP_DEVICE_INTERFACE_DETAIL_DATA}

  SP_DEVINFO_DATA = record
    cbSize: Cardinal;
    ClassGuid: TGUID;
    DevInst: Cardinal;
    Reserved: ULONG_PTR;
  end;
  {$EXTERNALSYM SP_DEVINFO_DATA}
  PSP_DEVINFO_DATA = ^SP_DEVINFO_DATA;
  {$EXTERNALSYM PSP_DEVINFO_DATA}

  DEVPROPTYPE = ULONG;
  {$EXTERNALSYM DEVPROPTYPE}
  PDEVPROPTYPE = ^DEVPROPTYPE;

  DEVPROPKEY = record
    fmtid: TGUID;
    pid: ULONG;
  end;
  {$EXTERNALSYM DEVPROPKEY}
  PDEVPROPKEY = ^DEVPROPKEY;

{$IFDEF WIN32}
{$ALIGN ON}
{$ENDIF}

  TCancelConnectionFunction = function (hDevice: THandle; Flags: Cardinal): HRESULT; stdcall;

const
  DIGCF_DEFAULT         = $00000001; // only valid with DIGCF_DEVICEINTERFACE
  {$EXTERNALSYM DIGCF_DEFAULT}
  DIGCF_PRESENT         = $00000002;
  {$EXTERNALSYM DIGCF_PRESENT}
  DIGCF_ALLCLASSES      = $00000004;
  {$EXTERNALSYM DIGCF_ALLCLASSES}
  DIGCF_PROFILE         = $00000008;
  {$EXTERNALSYM DIGCF_PROFILE}
  DIGCF_DEVICEINTERFACE = $00000010;
  {$EXTERNALSYM DIGCF_DEVICEINTERFACE}

  SetupApiModuleName = 'SetupApi.dll';

  DN_DEVICE_DISCONNECTED = $02;

  DEVPKEY_Device_FriendlyName: DEVPROPKEY = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 14);
  {$EXTERNALSYM DEVPKEY_Device_FriendlyName}

  DEVPKEY_Device_LocationInfo: DEVPROPKEY = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 15);
  {$EXTERNALSYM DEVPKEY_Device_LocationInfo}

  DEVPKEY_Device_LocationPaths: DEVPROPKEY = (
    fmtid: '{A45C254E-DF1C-4EFD-8020-67D146A850E0}'; pid: 37);
  {$EXTERNALSYM DEVPKEY_Device_LocationPaths}

  DEVPKEY_Device_DevNodeStatus: DEVPROPKEY = (
    fmtid:'{4340A6C5-93FA-4706-972C-7B648008A5A7}'; pid: 2);

{$WARN SYMBOL_PLATFORM OFF}
function SetupDiGetClassDevs(ClassGuid: PGUID; const Enumerator: PWideChar;
  hwndParent: HWND; Flags: Cardinal): HDEVINFO; stdcall; external SetupApiModuleName name 'SetupDiGetClassDevsW' delayed;
{$EXTERNALSYM SetupDiGetClassDevs}
function SetupDiEnumDeviceInterfaces(DeviceInfoSet: HDEVINFO; DeviceInfoData: Pointer; const InterfaceClassGuid: PGUID;
  MemberIndex: Cardinal;
  var DeviceInterfaceData: SP_DEVICE_INTERFACE_DATA): BOOL; stdcall; external SetupApiModuleName name 'SetupDiEnumDeviceInterfaces' delayed;
{$EXTERNALSYM SetupDiEnumDeviceInterfaces}

function SetupDiGetDeviceInterfaceDetail(DeviceInfoSet: HDEVINFO;
  var DeviceInterfaceData: SP_DEVICE_INTERFACE_DATA;
  DeviceInterfaceDetailData: PSP_DEVICE_INTERFACE_DETAIL_DATA;
  DeviceInterfaceDetailDataSize: Cardinal; RequiredSize: PCardinal;
  Device: PSP_DEVINFO_DATA): BOOL; stdcall; external SetupApiModuleName name 'SetupDiGetDeviceInterfaceDetailW' delayed;
{$EXTERNALSYM SetupDiGetDeviceInterfaceDetail}

function SetupDiDestroyDeviceInfoList(
  DeviceInfoSet: HDEVINFO): BOOL; stdcall; external SetupApiModuleName name 'SetupDiDestroyDeviceInfoList' delayed;
{$EXTERNALSYM SetupDiDestroyDeviceInfoList}

function SetupDiGetDeviceInterfaceProperty(
    DeviceInfoSet: HDEVINFO;
    var DeviceInterfaceData: SP_DEVICE_INTERFACE_DATA;
    PropertyKey: PDEVPROPKEY;
    PropertyType: PDEVPROPTYPE;
    PropertyBuffer: PByte;
    PropertyBufferSize: LongWord;
    RequiredSize: PLongWord;
    Flags: LongWord
): BOOL; stdcall; external SetupApiModuleName name 'SetupDiGetDeviceInterfacePropertyW' delayed;
{$EXTERNALSYM SetupDiGetDeviceInterfaceProperty}

function SetupDiEnumDeviceInfo(DeviceInfoSet: HDEVINFO;
  MemberIndex: Cardinal; var DeviceInfoData: SP_DEVINFO_DATA): BOOL; stdcall; external SetupApiModuleName name 'SetupDiEnumDeviceInfo' delayed;
{$EXTERNALSYM SetupDiEnumDeviceInfo}

function SetupDiGetDeviceProperty(
    DeviceInfoSet: HDEVINFO;
    var DeviceInfoData: SP_DEVINFO_DATA;
    PropertyKey: PDEVPROPKEY;
    var PropertyType: DEVPROPTYPE;
    PropertyBuffer: PByte;
    PropertyBufferSize: Cardinal;
    RequiredSize: PCardinal;
    Flags: Cardinal
): BOOL; stdcall; external SetupApiModuleName name 'SetupDiGetDevicePropertyW' delayed;
{$EXTERNALSYM SetupDiGetDeviceProperty}
{$WARN SYMBOL_PLATFORM DEFAULT}

function GetApiFunction(const DLLName: string; const FunctionName: string): FARPROC;
var
  Handle: THandle;
begin
  Handle := SafeLoadLibrary(DLLName);
  if Handle <= HINSTANCE_ERROR then
    raise Exception.CreateFmt('%s: %s', [SysErrorMessage(GetLastError), DLLName]);
  try
    Result := GetProcAddress(Handle, PChar(FunctionName));
  finally
    FreeLibrary(Handle);
  end;
end;

  // --------------------------------------------------------------------- //
  //  End API from SetupAPI.h
  // --------------------------------------------------------------------- //
  // --------------------------------------------------------------------- //

  // --------------------------------------------------------------------- //
  //  Required from Dbt.h for LE
  // --------------------------------------------------------------------- //
type
  PDevBroadcastHandle  = ^DEV_BROADCAST_HANDLE;
  DEV_BROADCAST_HANDLE = record
    dbch_size: DWORD;
    dbch_devicetype: DWORD;
    dbch_reserved: DWORD;
    dbch_handle: THandle;
    dbch_hdevnotify: Pointer;
    dbch_eventguid: TGUID;
    dbch_nameoffset: Long;
    dbch_data: array [0..0] of Byte;
    dbcc_name: Char;
  end;
  TDevBroadcastHandle = DEV_BROADCAST_HANDLE;

const
  DBT_DEVTYP_HANDLE          = $00000006;
  DBT_CUSTOMEVENT            = $8006;

  // --------------------------------------------------------------------- //
  //  End from Dbt.h
  // --------------------------------------------------------------------- //
  // --------------------------------------------------------------------- //


type
  TWinBluetoothLEManager = class(TPlatformBluetoothLEManager)
  private
    FLEAdapter: TBluetoothLEAdapter;

  protected
    function GetAdapterState: TBluetoothAdapterState;
    function GetConnectionState: TBluetoothConnectionState; override;
    function DoGetAdapter: TBluetoothLEAdapter; override;

    // LE Fucntionality
    function DoGetGattServer: TBluetoothGattServer; override;
    function DoGetSupportsGattClient: Boolean; override;
    function DoGetSupportsGattServer: Boolean; override;
    function DoEnableBluetooth: Boolean; override;
  public
    destructor Destroy; override;
  end;

  TWinBluetoothLEAdapter = class(TBluetoothLEAdapter)
  private
    FRadioInfo: TBluetoothRadioInfo;
    FHardwareDeviceInfo: HDEVINFO;
    FCancelConnectionFunction: TCancelConnectionFunction;
    FWinHandle: HWND;
    FNotificationHandle: Pointer;
    procedure WndProc(var Msg: TMessage);
    procedure RegisterBTChangeNotification;
    procedure UnregisterBTChangeNotification;
    procedure ChangeBTDeviceConnectionStatus(ABthAddress: BTH_ADDR; AConnected: Boolean);
    function GetRadioInfo: TBluetoothRadioInfo;
    procedure GetBLEDevices;
  protected
    function GetAdapterName: string; override;
    procedure SetAdapterName(const Value: string); override;
    function GetAddress: System.Bluetooth.TBluetoothMacAddress; override;

    function DoStartDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList = nil;
      const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil): Boolean; override;
    function DoStartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList = nil; Refresh: Boolean = True): Boolean; override;
    procedure DoCancelDiscovery; override;

    function GetScanMode: TBluetoothScanMode; override;
    function GetState: TBluetoothAdapterState; override;
  public
    constructor Create(const AManager: TBluetoothLEManager);
    destructor Destroy; override;
  end;

  TWinBluetoothLEDevice = class(TBluetoothLEDevice)
  private
    FLEAdapter: TWinBluetoothLEAdapter;
    function ExtractMacAddres(const APath: string): TBluetoothMacAddress;
  protected
    FLEDeviceHandle: THandle;
    FDeviceName: string;
    FDevicePath: string;
    FMacAddress: TBluetoothMacAddress;
    FReliableWriteContext: TBthLeGattReliableWriteContext;
    FDeviceInfo: SP_DEVINFO_DATA;

    function DoCreateAdvertiseData: TBluetoothLEAdvertiseData; override;

    function RegisterNotification(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
    function UnregisterNotification(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;

    function GetAddress: TBluetoothMacAddress; override;
    function GetDeviceName: string; override;
    function GetBluetoothType: TBluetoothType; override;
    function GetIdentifier: string; override;
    function GetIsConnected: Boolean; override;

    procedure DoAbortReliableWrite; override;
    function DoBeginReliableWrite: Boolean; override;
    function DoExecuteReliableWrite: Boolean; override;

    function DoDiscoverServices: Boolean; override;

    function DoReadCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; override;
    function DoReadDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; override;
    function DoWriteCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; override;
    function DoWriteDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; override;

    function DoReadRemoteRSSI: Boolean; override;
    function DoSetCharacteristicNotification(const ACharacteristic: TBluetoothGattCharacteristic;
      Enable: Boolean): Boolean; override;
    function DoDisconnect: Boolean; override;
    function DoConnect: Boolean; override;
  public
    constructor Create(const AName, APath: string; const ALEAdapter: TWinBluetoothLEAdapter; AutoConnect: Boolean);
    destructor Destroy; override;
  end;

  TWinBluetoothGattService = class(TBluetoothGattService)
  private
    function GetServiceHandle: THandle;
    function GetHandle: THandle;
    property ServiceHandle: THandle read GetHandle;
  protected
    FDevice: TWinBluetoothLEDevice;
    FLEDeviceHandle: THandle;
    FServiceHandle: THandle;
    FGattService: TBthLeGattService;
    FType: TBluetoothServiceType;

    function GetServiceUUID: TBluetoothUUID; override;
    function GetServiceType: TBluetoothServiceType; override;

    function DoGetCharacteristics: TBluetoothGattCharacteristicList; override;

    function DoGetIncludedServices: TBluetoothGattServiceList; override;

    function DoCreateCharacteristic(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags;
      const ADescription: string): TBluetoothGattCharacteristic; override;
    function DoCreateIncludedService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService; override;

    // Add the previously created Services and characteristics...
    function DoAddIncludedService(const AService: TBluetoothGattService): Boolean; override;
    function DoAddCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean; override;

  public

    constructor Create(const ADevice: TWinBluetoothLEDevice; const AGattService: TBthLeGattService; AType: TBluetoothServiceType);
    destructor Destroy; override;
  end;

  TWinBluetoothGattCharacteristic = class(TBluetoothGattCharacteristic)
  private
    function UpdateValueFromDevice: TBluetoothGattStatus;
    function SetValueToDevice: TBluetoothGattStatus;
    procedure ValueChangeEvent(EventOutParameter: Pointer);
  protected
    FLEDeviceHandle: THandle;
    FGattService: TBthLeGattService;
    FGattCharacteristic: TBthLeGattCharacteristic;
    PValue: PBthLeGattCharacteristicValue;
    FValueChangeEventHandle: TBluetoothGattEventHandle;

    function ServiceHandle: THandle; inline;
    function GetUUID: TBluetoothUUID; override;

    function GetProperties: TBluetoothPropertyFlags; override;

    function DoAddDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean; override;
    function DoGetDescriptors: TBluetoothGattDescriptorList; override;

    function DoCreateDescriptor(const AUUID: TBluetoothUUID): TBluetoothGattDescriptor; override;

    function DoGetValue: TBytes; override;
    procedure DoSetValue(const AValue: TBytes); override;
  public
    constructor Create(const AService: TWinBluetoothGattService; const AGattCharacteristic: TBthLeGattCharacteristic);
    destructor Destroy; override;
  end;

  TWinBluetoothGattDescriptor = class(TBluetoothGattDescriptor)
  private
    function UpdateValueFromDevice: TBluetoothGattStatus;
    function SetValueToDevice: TBluetoothGattStatus;
    procedure CheckCreateValue;
  protected
    PValue: PBthLeGattDescriptorValue;
    FGattDescriptor: TBthLeGattDescriptor;

    // Characteristic Extended Properties
    function DoGetReliableWrite: Boolean; override;
    function DoGetWritableAuxiliaries: Boolean; override;

    // Characteristic User Description
    function DoGetUserDescription: string; override;
    procedure DoSetUserDescription(const Value: string); override;

    // Client Characteristic Configuration
    procedure DoSetNotification(const Value: Boolean); override;
    function DoGetNotification: Boolean; override;
    procedure DoSetIndication(const Value: Boolean); override;
    function DoGetIndication: Boolean; override;

    // Server Characteristic Configuration
    function DoGetBroadcasts: Boolean; override;
    procedure DoSetBroadcasts(const Value: Boolean); override;

    //Characteristic Presentation Format
    function DoGetFormat: TBluetoothGattFormatType; override;
    function DoGetExponent: ShortInt; override;
    function DoGetFormatUnit: TBluetoothUUID; override;

    function DoGetValue: TBytes; override;
    procedure DoSetValue(const AValue: TBytes); override;
    function GetUUID: TBluetoothUUID; override;
  public
    constructor Create(const ACharacteristic: TWinBluetoothGattCharacteristic; const AGattDescriptor: TBthLeGattDescriptor);
    destructor Destroy; override;
  end;


function TBthLeUuidToUUID(const Uuid: TBthLeUuid): TBluetoothUUID; inline;
var
  TempGuuid: TBluetoothUUID;
begin
  if Uuid.IsShortUuid then
  begin
    TempGuuid := BTH_LE_ATT_BLUETOOTH_BASE_GUID;
    Inc(TempGuuid.D1, Uuid.ShortUuid);
    Result := TempGuuid;
  end
  else
    Result := Uuid.LongUuid;
end;

function BLEUuidToString(Uuid: TBthLeUuid): string; inline;
begin
  Result := TBthLeUuidToUUID(Uuid).ToString;
end;

function ErrorToStatus(AnError: HRESULT): TBluetoothGattStatus;
begin
  case Cardinal(AnError) of
    S_OK:
      Result := TBluetoothGattStatus.Success;
    E_BLUETOOTH_ATT_READ_NOT_PERMITTED:
      Result := TBluetoothGattStatus.ReadNotPermitted;
    E_BLUETOOTH_ATT_WRITE_NOT_PERMITTED:
      Result := TBluetoothGattStatus.WriteNotPermitted;
    E_BLUETOOTH_ATT_INSUFFICIENT_AUTHENTICATION:
      Result := TBluetoothGattStatus.InsufficientAutentication;
    E_BLUETOOTH_ATT_ATTRIBUTE_NOT_FOUND:
      Result := TBluetoothGattStatus.RequestNotSupported;
    E_BLUETOOTH_ATT_INVALID_OFFSET:
      Result := TBluetoothGattStatus.InvalidOffset;
    E_BLUETOOTH_ATT_INVALID_ATTRIBUTE_VALUE_LENGTH:
      Result := TBluetoothGattStatus.InvalidAttributeLength;
    E_BLUETOOTH_ATT_INSUFFICIENT_ENCRYPTION:
      Result := TBluetoothGattStatus.InsufficientEncryption;
  else
    Result := TBluetoothGattStatus.Failure;
  end;
end;

function CheckOSVersionForGattClient: Boolean;
begin
  Result := TOSVersion.Check(6, 2);
end;

function CheckOSVersionForGattServer: Boolean;
begin
  Result := False;
end;

{$ENDIF BLUETOOTH_LE}

function BthAddressToString(const AnAddress: TBluetoothAddress): string; inline;
begin
  Result := Format(SBluetoothMACAddressFormat, [AnAddress.rgBytes[5], AnAddress.rgBytes[4],
    AnAddress.rgBytes[3], AnAddress.rgBytes[2], AnAddress.rgBytes[1], AnAddress.rgBytes[0]]);
end;

{$IFDEF BLUETOOTH_CLASSIC}
{ TPlatformBluetoothClassicManager }

class function TPlatformBluetoothClassicManager.GetBluetoothManager: TBluetoothManager;
begin
  Result := TWinBluetoothManager.Create;
end;

{ TWinBluetoothManager }

function TWinBluetoothManager.GetAdapterState: TBluetoothAdapterState;
var
  btfrp: TBlueToothFindRadioParams;
  hRadio: THandle;
  hFind: HBLUETOOTH_RADIO_FIND;
begin
  FillChar(btfrp, SizeOf(btfrp), 0);
  btfrp.dwSize := SizeOf(btfrp);
  hFind := BluetoothFindFirstRadio(btfrp, hRadio);

  if hFind <> 0 then
  begin
    Result := TBluetoothAdapterState.&On;
    if FClassicAdapter = nil then
      FClassicAdapter := TWinBluetoothAdapter.Create(Self, hRadio);
    BluetoothFindRadioClose(hFind);
  end
  else
    Result := TBluetoothAdapterState.Off;
end;

function TWinBluetoothManager.DoGetClassicAdapter: TBluetoothAdapter;
begin
  if GetAdapterState = TBluetoothAdapterState.Off then
  begin
    FClassicAdapter.Free;
    FClassicAdapter := nil;
  end;
  Result := FClassicAdapter;
end;

function TWinBluetoothManager.GetConnectionState: TBluetoothConnectionState;
begin
  if GetAdapterState = TBluetoothAdapterState.&On then
    Result := TBluetoothConnectionState.Connected
  else
    Result := TBluetoothConnectionState.Disconnected;
end;

destructor TWinBluetoothManager.Destroy;
begin
  FClassicAdapter.Free;
  inherited;
end;

function TWinBluetoothManager.DoEnableBluetooth: Boolean;
begin
  Result := False;
end;

{ TWinBluetoothAdapter }

constructor TWinBluetoothAdapter.Create(const AManager: TBluetoothManager; const ARadioHandle: THandle);
begin
  inherited Create(AManager);
  FPairedDevices := TBluetoothDeviceList.Create;
  FRadioHandle := ARadioHandle;
  FState := TBluetoothAdapterState.&On;
end;

destructor TWinBluetoothAdapter.Destroy;
begin
  if FRadioHandle <> 0 then
    CloseHandle(FRadioHandle);
  FPairedDevices.Free;
  FDiscoverThread.Free;
  inherited;
end;

function TWinBluetoothAdapter.GetAdapterName: string;
var
  LRadioInfo: TBluetoothRadioInfo;
  Res: DWORD;
begin
  Result := '';
  FillChar(LRadioInfo, SizeOf(LRadioInfo), 0);
  LRadioInfo.dwSize := SizeOf(LRadioInfo);
  Res := BluetoothGetRadioInfo(FRadioHandle, LRadioInfo);
  if Res = ERROR_SUCCESS then
    Result := LRadioInfo.szName;
end;

function TWinBluetoothAdapter.GetAddress: System.Bluetooth.TBluetoothMacAddress;
var
  LAddress: TBluetoothAddress;
begin
  Result := '00:00:00:00:00:00';
  LAddress := GetBthAddress;
  if LAddress.ullLong <> BLUETOOTH_NULL_ADDRESS.ullLong then
    Result := BthAddressToString(LAddress);
end;

function TWinBluetoothAdapter.GetBthAddress: TBluetoothAddress;
var
  LRadioInfo: TBluetoothRadioInfo;
begin
  Result := BLUETOOTH_NULL_ADDRESS;
  LRadioInfo.dwSize := SizeOf(LRadioInfo);
  if BluetoothGetRadioInfo(FRadioHandle, LRadioInfo) = ERROR_SUCCESS then
    Result := LRadioInfo.address;
end;

procedure TWinBluetoothAdapter.GetDevicesByParam(const AList: TBluetoothDeviceList; AType: string; Timeout: Cardinal);
var
  LSearchParams: TBluetoothDeviceSearchParams;
  LDeviceInfo: TBluetoothDeviceInfo;
  LBluetoothDevice: TBluetoothDeviceFind;
begin
  inherited;
  FillChar(LSearchParams, SizeOf(LSearchParams), 0);
  LSearchParams.dwSize := SizeOf(LSearchParams);
  LSearchParams.hRadio := FRadioHandle;

  if AType = 'PairedDevices' then // do not translate
  begin
    LSearchParams.fReturnAuthenticated := True;
    LSearchParams.fReturnRemembered := False;
    LSearchParams.fReturnUnknown := False;
    LSearchParams.fReturnConnected := False;
    LSearchParams.fIssueInquiry := False;
    LSearchParams.cTimeoutMultiplier := 0;
  end
  else if AType = 'DiscoverDevices' then // do not translate
  begin
    LSearchParams.fReturnAuthenticated := False;
    LSearchParams.fReturnRemembered := False;
    LSearchParams.fReturnUnknown := True;
    LSearchParams.fReturnConnected := False;
    LSearchParams.fIssueInquiry := True;
    LSearchParams.cTimeoutMultiplier := Trunc((Timeout div 1000) / 1.28);
  end;

  AList.Clear;

  FillChar(LDeviceInfo, SizeOf(LDeviceInfo), 0);
  LDeviceInfo.dwSize := SizeOf(LDeviceInfo);

  LBluetoothDevice := BluetoothFindFirstDevice(LSearchParams, LDeviceInfo);

  while LBluetoothDevice <> 0 do
  begin
    if BluetoothGetDeviceInfo(FRadioHandle, LDeviceInfo) <> ERROR_SUCCESS then
      raise EBluetoothSocketException.CreateFmt(SBluetoothDeviceInfoError, [GetLastError, SysErrorMessage(GetLastError)]);
    AList.Add(TWinBluetoothDevice.Create(Self, LDeviceInfo));
    FillChar(LDeviceInfo, SizeOf(LDeviceInfo), 0);
    LDeviceInfo.dwSize := SizeOf(LDeviceInfo);
    if BluetoothFindNextDevice(LBluetoothDevice, LDeviceInfo) = BOOL(False) then
      Break;
  end;
  if LBluetoothDevice <> 0 then
    BluetoothFindDeviceClose(LBluetoothDevice);
end;

function TWinBluetoothAdapter.GetPairedDevices: TBluetoothDeviceList;
begin
  Result := FPairedDevices;
  GetDevicesByParam(FPairedDevices, 'PairedDevices'); // Do not translate
end;

function TWinBluetoothAdapter.GetScanMode: TBluetoothScanMode;
begin
  if BluetoothIsDiscoverable(FRadioHandle) then
    Result := TBluetoothScanMode.Discoverable
  else if BluetoothIsConnectable(FRadioHandle) then
    Result := TBluetoothScanMode.Connectable
  else
    Result := TBluetoothScanMode.None;
end;

function TWinBluetoothAdapter.GetState: TBluetoothAdapterState;
begin
  Result := FState;
end;

function TWinBluetoothAdapter.DoPair(const ADevice: TBluetoothDevice): Boolean;
begin
  Result := BluetoothAuthenticateDeviceEx(0 , FRadioHandle, TWinBluetoothDevice(ADevice).FDeviceInfo, nil,
     MITMProtectionRequiredGeneralBonding) = ERROR_SUCCESS;
end;

procedure TWinBluetoothAdapter.SetAdapterName(const Value: string);
begin
  inherited;
  raise EBluetoothAdapterException.Create(SBluetoothNotImplemented);
end;

procedure TWinBluetoothAdapter.DoStartDiscoverable(Timeout: Cardinal);
begin
  inherited;
  BluetoothEnableDiscovery(FRadioHandle, TRUE);
  FTimer := TThreadTimer.Create(DoDiscoverableEnd, Timeout);
  FTimer.Start;
end;

procedure TWinBluetoothAdapter.DoStartDiscovery(Timeout: Cardinal);
begin
  inherited;
  if FState = TBluetoothAdapterState.&On then
  begin
    FState := TBluetoothAdapterState.Discovering;
    if FDiscoverThread <> nil then
      FreeAndNil(FDiscoverThread);
    if FDiscoverThread = nil then
    begin
      FDiscoverThread := TDiscoverThread.Create(Self, Timeout);
      FDiscoverThread.Start;
    end;
  end;
end;

function TWinBluetoothAdapter.DoUnPair(const ADevice: TBluetoothDevice): Boolean;
begin
  Result := BluetoothRemoveDevice(TWinBluetoothDevice(ADevice).FDeviceInfo.Address) = ERROR_SUCCESS;
end;

procedure TWinBluetoothAdapter.DoCancelDiscovery;
begin
  inherited;
  if FDiscoverThread <> nil then
    FDiscoverThread.Cancel;
end;

function TWinBluetoothAdapter.DoCreateServerSocket(const AName: string; const AUUID: TGUID;
  Secure: Boolean): TBluetoothServerSocket;
begin
  Result := TWinBluetoothServerSocket.Create(AName, AUUID, Secure, BthAddressToString(GetBthAddress));
end;

procedure TWinBluetoothAdapter.DoDiscoverableEnd(const Sender: TObject);
begin
  BluetoothEnableDiscovery(FRadioHandle, FALSE);
  inherited DoDiscoverableEnd(Self);
end;

{ TWinBluetoothDevice }

constructor TWinBluetoothDevice.Create(const AnAdapter: TWinBluetoothAdapter; const ADeviceInfo: TBluetoothDeviceInfo);
begin
  inherited Create;
  FType := TBluetoothType.Classic;
  FDeviceInfo := ADeviceInfo;
  FAdapter := AnAdapter;
end;

function TWinBluetoothDevice.DoCreateClientSocket(const AUUID: TGUID; Secure: Boolean): TBluetoothSocket;
begin
  Result := TWinBluetoothSocket.Create(INVALID_SOCKET, FDeviceInfo.Address, AUUID, Secure);
end;

function SdpCallBack(uAttribId: ULONG; pValueStream: LPBYTE; cbStreamSize: ULONG; pvParam: LPVOID): BOOL; stdcall;

  procedure CreateGUID16(var Guuid: TBluetoothUUID; PData: PByte); inline;
  begin
    Guuid := Bluetooth_Base_UUID;
    Guuid.D1 := (PData[0] shl 8) or PData[1];
  end;

  procedure CreateGUID128(var Guuid: TBluetoothUUID; PData: PByte); inline;
  begin
    Guuid := TGUID.Create(PData^, TEndian.Big);
  end;

  function GetSDPName(element: TSdpElementData): string;
  var
    Buffer: TBytes;
  begin
    SetLength(Buffer, element.&string.length);
    if element.&string.length > 0 then
      Move(element.&string.value^, Buffer[0], element.&string.length);
    Result := TEncoding.UTF8.GetString(Buffer);
  end;

type
  PBluetoothService = ^TBluetoothService;
const  // constants from bluetooth/sdp.h in android
  SDP_UUID16 = $19;
  SDP_UUID128 = $1C;
var
  LPService: PBluetoothService;
  element: TSdpElementData;
  PData: PByteArray;
begin
  LPService := pvParam;
  // uAttribId 1 -> Service GUUID
  if (uAttribId = 1) and (BluetoothSdpGetElementData(pValueStream, cbStreamSize, element) = ERROR_SUCCESS) and
    (element.&type = SDP_TYPE_SEQUENCE) then
  begin
    PData := PByteArray(element.sequence.value + 2);
    case PData[0] of
      SDP_UUID16: CreateGUID16(LPService.UUID, @PData[1]);
      SDP_UUID128: CreateGUID128(LPService.UUID, @PData[1]);
    end;
  end // uAttribId 256 -> Service Name
  else if (uAttribId = 256) and (BluetoothSdpGetElementData(pValueStream, cbStreamSize, element) = ERROR_SUCCESS) and
          (element.&type = SDP_TYPE_STRING) then
              LPService.Name := GetSDPName(element);
  Result := True;
end;

function TWinBluetoothDevice.DoGetServices: TBluetoothServiceList;
var
  QuerySet: WSAQUERYSET;
  PResults: LPWSAQUERYSET;
  Flags: DWORD;
  HLookup: THandle;
  Buffer: TBytes;
  BufferLen: DWORD;
  Res: Integer;
  LService: TBluetoothService;
begin
  FServiceList.Clear;
  Result := FServiceList;
  FillChar(QuerySet, SizeOf(QuerySet), 0);
  QuerySet.dwSize := SizeOf(QuerySet);
  QuerySet.lpServiceClassId := @L2CAP_PROTOCOL_UUID;
  QuerySet.dwNameSpace := NS_BTH;
  QuerySet.lpszContext := LPWSTR(Address);
  Flags := LUP_FLUSHCACHE or LUP_RETURN_ALL;

  if WSALookupServiceBegin(@QuerySet, Flags, HLookup) = 0 then
  begin
    SetLength(Buffer, 2048);
    PResults := @Buffer[0];
    Res := 0;
    while Res = 0 do
    begin
      BufferLen := 2048;
      Res := WSALookupServiceNext(HLookup, Flags, BufferLen, PResults);
      if Res <> 0 then
        if WSAGetLastError = WSA_E_NO_MORE then
          Break
        else
          raise EBluetoothDeviceException.CreateFmt(SBluetoothServiceListError, [WSAGetLastError, SysErrorMessage(WSAGetLastError)]);
      if PResults.lpBlob <> nil then
      begin
        LService.UUID := GUID_NULL;
        BluetoothSdpEnumAttributes(PResults.lpBlob.pBlobData, PResults.lpBlob.cbSize, SdpCallBack, @LService);
        if LService.UUID <> GUID_NULL then
          if LService.Name = '' then
            LService.Name := TPlatformBluetoothClassicManager.GetKnownServiceName(LService.UUID);
          FServiceList.Add(LService);
      end;
    end;
    WSALookupServiceEnd(HLookup);
  end;
end;

function TWinBluetoothDevice.GetAddress: TBluetoothMacAddress;
begin
  Result := Format(SBluetoothMACAddressFormat, [FDeviceInfo.address.rgBytes[5], FDeviceInfo.address.rgBytes[4],
    FDeviceInfo.address.rgBytes[3], FDeviceInfo.address.rgBytes[2], FDeviceInfo.address.rgBytes[1], FDeviceInfo.address.rgBytes[0]]);
end;

function TWinBluetoothDevice.GetBluetoothType: TBluetoothType;
begin
  Result := TBluetoothType.Classic;
end;

function TWinBluetoothDevice.GetClassDevice: Integer;
begin
  Result := 256 * GET_COD_MAJOR(FDeviceInfo.ulClassofDevice) + 4 * GET_COD_MINOR(FDeviceInfo.ulClassofDevice);
end;

function TWinBluetoothDevice.GetClassDeviceMajor: Integer;
begin
  Result := 256 * GET_COD_MAJOR(FDeviceInfo.ulClassofDevice);
end;

function TWinBluetoothDevice.GetDeviceName: string;
begin
  Result := FDeviceInfo.szName;
  if Result = '' then
    if BluetoothGetDeviceInfo(FAdapter.FRadioHandle, FDeviceInfo) <> ERROR_SUCCESS then
        raise EBluetoothDeviceException.CreateFmt(SBluetoothDeviceInfoError, [GetLastError, SysErrorMessage(GetLastError)]);
  Result := FDeviceInfo.szName;
end;

function TWinBluetoothDevice.GetPaired: Boolean;
begin
  Result := FDeviceInfo.fAuthenticated = True;
end;

function TWinBluetoothDevice.GetState: TBluetoothDeviceState;
begin
  if FDeviceInfo.fConnected then
    Result := TBluetoothDeviceState.Connected
  else if FDeviceInfo.fAuthenticated then
    Result := TBluetoothDeviceState.Paired
  else
    Result := TBluetoothDeviceState.None;
end;

{ TWinBluetoothAdapter.TThreadTimer }

procedure TWinBluetoothAdapter.TThreadTimer.Cancel;
begin
  Terminate;
  if Assigned(FOnTimer) then
  begin
    FOnTimer := nil;
    FEvent.SetEvent;
  end;
end;

constructor TWinBluetoothAdapter.TThreadTimer.Create(const AEvent: TDiscoverableEndEvent; Timeout: Cardinal);
begin
  inherited Create(True);
  FOnTimer := AEvent;
  FTimeout := Timeout;
  FEvent := TEvent.Create;
end;

destructor TWinBluetoothAdapter.TThreadTimer.Destroy;
begin
  Cancel;
  FEvent.Free;
  inherited;
end;

procedure TWinBluetoothAdapter.TThreadTimer.Execute;
begin
  inherited;
  FEvent.WaitFor(FTimeout);
  if not Terminated and Assigned(FOnTimer) then
    try
     FOnTimer(nil);
    except
      Synchronize(procedure
      begin
        if Assigned(System.Classes.ApplicationHandleException) then
          System.Classes.ApplicationHandleException(Self)
        else
          raise;
      end);
    end;
end;

{ TWinBluetoothAdapter.TDiscoverThread }

procedure TWinBluetoothAdapter.TDiscoverThread.Cancel;
begin
  Cancelled := True;
end;

constructor TWinBluetoothAdapter.TDiscoverThread.Create(const AnAdapter: TWinBluetoothAdapter; Timeout: Cardinal);
begin
  inherited Create(True);
  FAdapter := AnAdapter;
  Cancelled := False;
  FTimeout := Timeout;
end;

procedure TWinBluetoothAdapter.TDiscoverThread.Execute;
begin
  inherited;
  FAdapter.GetDevicesByParam(FAdapter.FManager.LastDiscoveredDevices, 'DiscoverDevices', FTimeout);
  FAdapter.FState := TBluetoothAdapterState.&On;
  if not Cancelled and not Terminated then
    try
      FAdapter.DoDiscoveryEnd(FAdapter, FAdapter.FManager.LastDiscoveredDevices);
    except
      Synchronize(procedure
      begin
        if Assigned(System.Classes.ApplicationHandleException) then
          System.Classes.ApplicationHandleException(Self)
        else
          raise;
      end);
    end;
end;

{ TWinBluetoothServerSocket }

destructor TWinBluetoothServerSocket.Destroy;
begin
  Close;
  inherited;
end;

function TWinBluetoothServerSocket.DoAccept(Timeout: Cardinal): TBluetoothSocket;
var
  ClientSocket: TSocket;
  fds: fd_set;
  tv: timeval;
  res: Integer;
begin
  inherited;

  if Timeout = 0 then
  begin
    ClientSocket := Winapi.Winsock2.accept(FListenSocket, nil, nil);
    if ClientSocket = INVALID_SOCKET then
    begin
      closesocket(FListenSocket);
      raise EBluetoothSocketException.Create(SBluetoothAcceptError);
    end;
    Result := TWinBluetoothSocket.Create(ClientSocket, BLUETOOTH_NULL_ADDRESS, GUID_NULL, FSecured);
  end
  else
  begin
    FD_ZERO(fds);
    _FD_SET(FListenSocket, fds);
    tv.tv_sec := Timeout div 1000;
    tv.tv_usec := (Timeout mod 1000) * 1000;
    res := select(FListenSocket+1, @fds, nil, nil, @tv);
    if res <> SOCKET_ERROR then
    begin
      if FD_ISSET(FListenSocket, fds) then
      begin
        ClientSocket := Winapi.Winsock2.accept(FListenSocket, nil, nil);
        if ClientSocket = INVALID_SOCKET then
        begin
          closesocket(FListenSocket);
          raise EBluetoothSocketException.Create(SBluetoothAcceptError);
        end;
        Result := TWinBluetoothSocket.Create(ClientSocket, BLUETOOTH_NULL_ADDRESS, GUID_NULL, FSecured);
      end
      else
        Result := nil; { Timeout }
    end
    else
    begin
      closesocket(FListenSocket);
      raise EBluetoothSocketException.Create(SBluetoothAcceptError);
    end;
  end;
end;

procedure TWinBluetoothServerSocket.DoClose;
begin
  inherited;
  closesocket(FListenSocket);
  WSASetService(@FWSAService, RNRSERVICE_DELETE, 0);
end;

constructor TWinBluetoothServerSocket.Create(const AName: string; const AUUID: TGUID; Secure: Boolean; const MACAddress: string);

  function FindWSAService(const MACAddress: string; const AGUID: TGUID): Boolean;
  var
    QuerySet: WSAQUERYSET;
    PResults: LPWSAQUERYSET;
    Flags: DWORD;
    HLookup: THandle;
    Buffer: TBytes;
    BufferLen: DWORD;
    Res: Integer;
    LService: TBluetoothService;
  begin
    Result := False;
    FillChar(QuerySet, SizeOf(QuerySet), 0);
    QuerySet.dwSize := SizeOf(QuerySet);
    QuerySet.lpServiceClassId := @L2CAP_PROTOCOL_UUID;
    QuerySet.dwNameSpace := NS_BTH;
    QuerySet.lpszContext := LPWSTR(MACAddress);
    Flags := LUP_FLUSHCACHE or LUP_RETURN_ALL;

    if WSALookupServiceBegin(@QuerySet, Flags, HLookup) = 0 then
    begin
      SetLength(Buffer, 2048);
      PResults := @Buffer[0];
      Res := 0;
      while Res = 0 do
      begin
        BufferLen := 2048;
        Res := WSALookupServiceNext(HLookup, Flags, BufferLen, PResults);
        if Res <> 0 then
          if WSAGetLastError = WSA_E_NO_MORE then
            Break
          else
            raise EBluetoothSocketException.CreateFmt(SBluetoothWSALookupError, [WSAGetLastError, SysErrorMessage(WSAGetLastError)]);
        if PResults.lpBlob <> nil then
        begin
          LService.UUID := GUID_NULL;
          BluetoothSdpEnumAttributes(PResults.lpBlob.pBlobData, PResults.lpBlob.cbSize, SdpCallBack, @LService);
          if LService.UUID = AGUID then
          begin
            Result := True;
            Break;
          end;
        end;
      end;
      WSALookupServiceEnd(HLookup);
    end
    else
      raise EBluetoothSocketException.CreateFmt(SBluetoothWSALookupError, [WSAGetLastError, SysErrorMessage(WSAGetLastError)]);
  end;

var
  PAddress: PSockAddr;
  AddrLen: Integer;
  Value: Cardinal;
begin
  inherited Create;
  FSecured := Secure;

  if FindWSAService(MACAddress, AUUID) then
    raise EBluetoothSocketException.Create(SBluetoothUsedGUIDError);

  FListenSocket := socket(AF_BTH, SOCK_STREAM, BTHPROTO_RFCOMM);
  if FListenSocket = INVALID_SOCKET then
    raise EBluetoothSocketException.Create(SBluetoothCreateSocketError);

  FillChar(FAddressBth, SizeOf(FAddressBth), 0);
  FAddressBth.addressFamily := AF_BTH;
  FAddressBth.port := BT_PORT_ANY;
  FAddressBth.serviceClassId := GUID_NULL;
  PAddress := @FAddressBth;

  if bind(FListenSocket, PAddress^, Sizeof(TSockAddrBth)) <> 0 then
    raise EBluetoothSocketException.CreateFmt(SBluetoothServerSocket, [SysErrorMessage(WSAGetLastError)]);

  AddrLen := SizeOf(TSockAddrBth);
  if getsockname(FListenSocket, PAddress^, AddrLen) = SOCKET_ERROR then
    raise EBluetoothSocketException.CreateFmt(SBluetoothServerSocket, [SysErrorMessage(WSAGetLastError)]);

  if Secure then
  begin
    Value := 1;
    AddrLen := SizeOf(Value);
    if setsockopt(FListenSocket, SOL_RFCOMM, Integer(SO_BTH_AUTHENTICATE), MarshaledAString(@Value), AddrLen) = SOCKET_ERROR then
      raise EBluetoothSocketException.CreateFmt(SBluetoothServerSocket, [SysErrorMessage(WSAGetLastError)]);

    AddrLen := SizeOf(Value);
    if setsockopt(FListenSocket, SOL_RFCOMM, SO_BTH_ENCRYPT, MarshaledAString(@Value), AddrLen) = SOCKET_ERROR then
      raise EBluetoothSocketException.CreateFmt(SBluetoothServerSocket, [SysErrorMessage(WSAGetLastError)]);
  end;

  FillChar(FCsAddr, SizeOf(FCsAddr), 0);
  FCsAddr.LocalAddr.iSockaddrLength := SizeOf(TSockAddrBth);
  FCsAddr.LocalAddr.lpSockaddr := LPSOCKADDR(PAddress);
  FCsAddr.RemoteAddr.iSockaddrLength := SizeOf(TSockAddrBth);
  FCsAddr.RemoteAddr.lpSockaddr := LPSOCKADDR(PAddress);
  FCsAddr.iSocketType := SOCK_STREAM;
  FCsAddr.iProtocol := BTHPROTO_RFCOMM;

  FillChar(FWSAService, SizeOf(FWSAService), 0);
  FWSAService.dwSize := SizeOf(FWSAService);
  FWSAService.lpServiceClassId := @AUUID;
  FWSAService.lpszServiceInstanceName := PWideChar(AName);
  FWSAService.dwNumberOfCsAddrs := 1;
  FWSAService.dwNameSpace := NS_BTH;
  FWSAService.lpcsaBuffer := @FCsAddr;

  if WSASetService(@FWSAService, RNRSERVICE_REGISTER, 0) = SOCKET_ERROR then
    raise EBluetoothSocketException.CreateFmt(SBluetoothServiceError, [WSAGetLastError, SysErrorMessage(WSAGetLastError)]);

  if listen(FListenSocket, 4) = SOCKET_ERROR then
    raise EBluetoothSocketException.CreateFmt(SBluetoothServerSocket, [SysErrorMessage(WSAGetLastError)]);
end;

{ TWinBluetoothSocket }

constructor TWinBluetoothSocket.Create(const ASocket: TSocket; const AnAddress: TBluetoothAddress; const AUUID: TGUID; Secure: Boolean);
var
  time: Cardinal;
begin
  inherited Create;
  FGUIDService := AUUID;
  FClientSocket := ASocket;
  FConnected := False;
  FSecure := Secure;
  FAddress := AnAddress;
  FLastReadTimeout := 0;
  if FGUIDService = GUID_NULL then
    FConnected := True;

  if FClientSocket <> INVALID_SOCKET then
  begin
    Case TBluetoothManager.SocketTimeout of
      0: time := 1;
      INFINITE: time := 0;
    else
      time := TBluetoothManager.SocketTimeout;
    end;
    if setsockopt(FClientSocket, SOL_SOCKET, SO_RCVTIMEO, MarshaledAString(@time), SizeOf(time)) = SOCKET_ERROR then
      raise EBluetoothSocketException.CreateFmt(SBluetoothRCVTIMEOError, [SysErrorMessage(WSAGetLastError)]);
    FConnected := True;
    FLastReadTimeout := TBluetoothManager.SocketTimeout;
  end;
end;

class constructor TWinBluetoothSocket.Create;
var
  LWsData: TWSAData;
begin
  if WSAStartup(MAKEWORD(2, 2), LWsData) <> 0 then
    raise EBluetoothSocketException.Create(SBluetoothWisockInitError);
end;

destructor TWinBluetoothSocket.Destroy;
begin
  Close;
  inherited;
end;

class destructor TWinBluetoothSocket.Destroy;
begin
  if WSACleanup <> 0 then
    raise EBluetoothSocketException.Create(SBluetoothWisockCleanupError);
end;

procedure TWinBluetoothSocket.DoClose;
begin
  inherited;
  if FConnected then
  begin
    closesocket(FClientSocket);
    FConnected := False;
    FClientSocket := INVALID_SOCKET;
  end;
end;

procedure TWinBluetoothSocket.DoConnect;
var
  LClientService: TSockAddrBth;
  PService: PSockAddr;
  AddrLen: Integer;
  Value: Cardinal;
  Error: Integer;
  time: Cardinal;
begin
  inherited;
  if not FConnected and (FGUIDService <> GUID_NULL) then
  begin
    FLastReadTimeout := 0;
    if FClientSocket <> INVALID_SOCKET then
      closesocket(FClientSocket);

    FClientSocket := socket(AF_BTH, SOCK_STREAM, BTHPROTO_RFCOMM);
    if FClientSocket = INVALID_SOCKET then
      raise EBluetoothSocketException.Create(SBluetoothClientsocketError);

    Case TBluetoothManager.SocketTimeout of
      0: time := 1;
      INFINITE: time := 0;
    else
      time := TBluetoothManager.SocketTimeout;
    end;
    if setsockopt(FClientSocket, SOL_SOCKET, SO_RCVTIMEO, MarshaledAString(@time), SizeOf(time)) = SOCKET_ERROR then
      raise EBluetoothSocketException.CreateFmt(SBluetoothRCVTIMEOError, [SysErrorMessage(WSAGetLastError)]);

    if FSecure then
    begin
      Value := 1;
      AddrLen := SizeOf(Value);
      if setsockopt(FClientSocket, SOL_RFCOMM, Integer(SO_BTH_AUTHENTICATE), MarshaledAString(@Value), AddrLen) = SOCKET_ERROR then
        raise EBluetoothSocketException.CreateFmt(SBluetoothSetSockOptError, [SysErrorMessage(WSAGetLastError)]);

      AddrLen := SizeOf(Value);
      if setsockopt(FClientSocket, SOL_RFCOMM, SO_BTH_ENCRYPT, MarshaledAString(@Value), AddrLen) = SOCKET_ERROR then
        raise EBluetoothSocketException.CreateFmt(SBluetoothSetSockOptError, [SysErrorMessage(WSAGetLastError)]);
    end;

    FillChar(LClientService, SizeOf(LClientService), 0);
    LClientService.addressFamily := AF_BTH;
    LClientService.btAddr := FAddress.ullLong;
    LClientService.serviceClassId := FGUIDService;
    PService := @LClientService;
    if Winapi.Winsock2.connect(FClientSocket, PService^, SizeOf(LClientService)) = SOCKET_ERROR then
    begin
      Error := WSAGetLastError;
      Close;
      raise EBluetoothSocketException.CreateFmt(SBluetoothClientConnectError, [Error, SysErrorMessage(Error)]);
    end;
    FConnected := True;
    FLastReadTimeout := TBluetoothManager.SocketTimeout;
  end;
end;

function TWinBluetoothSocket.DoReceiveData(ATimeout: Cardinal): TBytes;
const
  BuffLen = 4096;
var
  Received: Integer;
  Readed: Integer;
  Error: Integer;
  time: Cardinal;
begin
  if not FConnected then
    raise EBluetoothSocketException.Create(SBluetoothRFChannelClosed);

  if FLastReadTimeout <> ATimeout then
  begin
    Case ATimeout of
      0: time := 1;
      INFINITE: time := 0;
    else
      time := ATimeout;
    end;
    if setsockopt(FClientSocket, SOL_SOCKET, SO_RCVTIMEO, MarshaledAString(@time), SizeOf(time)) = SOCKET_ERROR then
      raise EBluetoothSocketException.CreateFmt(SBluetoothRCVTIMEOError, [SysErrorMessage(WSAGetLastError)]);
    FLastReadTimeout := ATimeout;
  end;

  Readed := 0;
  repeat
    SetLength(Result, Readed + BuffLen);
    Received := Winapi.Winsock2.recv(FClientSocket, Result[Readed], BuffLen, 0);
    if Received = SOCKET_ERROR then
    begin
      Error := WSAGetLastError;
      if Error = WSAETIMEDOUT then
        Break
      else
      begin
        Close;
        raise EBluetoothSocketException.Create(SBluetoothRFChannelClosed);
      end;
    end;
    Readed := Readed + Received;
  until Received < BuffLen;
  if (Readed = 0) and (Received = 0) then
  begin
    DoClose;
    raise EBluetoothSocketException.Create(SBluetoothRFChannelClosed);
  end;

  SetLength(Result, Readed);
end;

procedure TWinBluetoothSocket.DoSendData(const AData: TBytes);
var
  Error: Integer;
  DataLen: Integer;
  Sent: Integer;
begin
  inherited;
  if not FConnected then
    raise EBluetoothSocketException.Create(SBluetoothCanNotSendData);

  Sent := 0;
  DataLen := Length(AData);
  repeat
    Sent := Sent + Winapi.Winsock2.send(FClientSocket, AData[Sent], DataLen - Sent, 0);
    if Sent = SOCKET_ERROR then
    begin
      Error := WSAGetLastError;
      Close;
      raise EBluetoothSocketException.CreateFmt(SBluetoothSendDataError, [Error, SysErrorMessage(Error)]);
    end;
  until Sent >= DataLen;
end;

function TWinBluetoothSocket.GetConnected: Boolean;
begin
  Result := FConnected;
end;
{$ENDIF BLUETOOTH_CLASSIC}

{$IFDEF BLUETOOTH_LE}
{ TPlatformBluetoothLEManager }

class function TPlatformBluetoothLEManager.GetBluetoothManager: TBluetoothLEManager;
begin
  if TOSVersion.Check(10) then
    Result := TPlatformWinRTBluetoothLEManager.GetBluetoothManager
  else
    Result := TWinBluetoothLEManager.Create;
end;

{ TWinBluetoothLEManager }

function TWinBluetoothLEManager.DoGetGattServer: TBluetoothGattServer;
begin
  { Gatt Server not supported on Windows Platform }
  raise EBluetoothManagerException.Create(SBluetoothNotImplemented);
  Result := nil;
end;

function TWinBluetoothLEManager.GetAdapterState: TBluetoothAdapterState;
var
  btfrp: TBlueToothFindRadioParams;
  hRadio: THandle;
  hFind: HBLUETOOTH_RADIO_FIND;
begin
  FillChar(btfrp, SizeOf(btfrp), 0);
  btfrp.dwSize := SizeOf(btfrp);
  hFind := BluetoothFindFirstRadio(btfrp, hRadio);

  if hFind <> 0 then
  begin
    Result := TBluetoothAdapterState.&On;
    if FLEAdapter = nil then
      FLEAdapter := TWinBluetoothLEAdapter.Create(Self);
    BluetoothFindRadioClose(hFind);
  end
  else
    Result := TBluetoothAdapterState.Off;
end;

function TWinBluetoothLEManager.DoGetAdapter: TBluetoothLEAdapter;
begin
  if GetAdapterState = TBluetoothAdapterState.Off then
    FLEAdapter := nil;
  Result := FLEAdapter;
end;

function TWinBluetoothLEManager.DoGetSupportsGattClient: Boolean;
begin
  Result := CheckOSVersionForGattClient;
end;

function TWinBluetoothLEManager.DoGetSupportsGattServer: Boolean;
begin
  Result := CheckOSVersionForGattServer;
end;

function TWinBluetoothLEManager.GetConnectionState: TBluetoothConnectionState;
begin
  if GetAdapterState = TBluetoothAdapterState.&On then
    Result := TBluetoothConnectionState.Connected
  else
    Result := TBluetoothConnectionState.Disconnected;
end;

destructor TWinBluetoothLEManager.Destroy;
begin
  FLEAdapter.Free;
  inherited;
end;

function TWinBluetoothLEManager.DoEnableBluetooth: Boolean;
begin
  Result := False;
end;

{ TWinBluetoothLEAdapter }

procedure TWinBluetoothLEAdapter.ChangeBTDeviceConnectionStatus(ABthAddress: BTH_ADDR; AConnected: Boolean);
var
  I: Integer;
  ADevAddress: string;
  ADevice: TBluetoothLEDevice;
begin
  ADevAddress :=  BthAddressToString(TBluetoothAddress(ABthAddress));
  for I := 0 to FManager.LastDiscoveredDevices.Count - 1 do
  begin
    if FManager.LastDiscoveredDevices[I].Address = ADevAddress then
    begin
      ADevice := FManager.LastDiscoveredDevices[I];
      if AConnected and Assigned(ADevice.OnConnect) then
        ADevice.OnConnect(ADevice)
      else if (not AConnected) and Assigned(ADevice.OnDisconnect) then
        ADevice.OnDisconnect(ADevice);
      Exit;
    end;
  end;
end;

constructor TWinBluetoothLEAdapter.Create(const AManager: TBluetoothLEManager);
begin
  inherited;
  FRadioInfo := GetRadioInfo;
  FCancelConnectionFunction := GetApiFunction(bthapile, 'BthpGATTCloseSession');
  FWinHandle := AllocateHWnd(WndProc);
  RegisterBTChangeNotification;
end;

destructor TWinBluetoothLEAdapter.Destroy;
begin
  if FHardwareDeviceInfo <> nil then
    SetupDiDestroyDeviceInfoList(FHardwareDeviceInfo);
  UnregisterBTChangeNotification;
  DeallocateHWnd(FWinHandle);
  inherited;
end;

procedure TWinBluetoothLEAdapter.GetBLEDevices;
var
  deviceInterfaceData: SP_DEVICE_INTERFACE_DATA;
  deviceInterfaceDetailData: PSP_DEVICE_INTERFACE_DETAIL_DATA;
  DeviceInfo: SP_DEVINFO_DATA;
  requiredLength: Cardinal;
  err: Cardinal;
  I: Integer;
  Path: string;
  PropertyBuffer: TBytes;
  PropertyType: DEVPROPTYPE;
  DeviceName: string;
  LTWinBluetoothLEDevice: TWinBluetoothLEDevice;
begin
  TWinBluetoothLEManager(FManager).FDiscoveredLEDevices.Clear;
  if FHardwareDeviceInfo <> nil then
    SetupDiDestroyDeviceInfoList(FHardwareDeviceInfo);

  deviceInterfaceDetailData := PSP_DEVICE_INTERFACE_DETAIL_DATA(GetMemory(1024));
  try
    FHardwareDeviceInfo := SetupDiGetClassDevs(@GUID_BLUETOOTHLE_DEVICE_INTERFACE, nil, 0, DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
    if THandle(FHardwareDeviceInfo) = INVALID_HANDLE_VALUE then
      raise EBluetoothLEAdapterException.CreateFmt(SBluetoothLEGetDevicesError, [GetLastError, SysErrorMessage(GetLastError)]);

    SetLength(PropertyBuffer, 1024);

    I := 0;
    while True do
    begin
      DeviceInfo.cbSize := SizeOf(SP_DEVINFO_DATA);
      if SetupDiEnumDeviceInfo(FHardwareDeviceInfo, I, DeviceInfo) = FALSE then
      begin
        err := GetLastError;
        if err <> ERROR_NO_MORE_ITEMS then
          raise EBluetoothLEAdapterException.CreateFmt(SBluetoothLEGetDevicesError, [GetLastError, SysErrorMessage(GetLastError)]);
        Break;
      end;

      if SetupDiGetDeviceProperty(FHardwareDeviceInfo, DeviceInfo, @DEVPKEY_Device_FriendlyName,
        PropertyType, @PropertyBuffer[0], 1024, @requiredLength, 0)  = FALSE then
        raise EBluetoothLEAdapterException.CreateFmt(SBluetoothLEGetDevicesError, [GetLastError, SysErrorMessage(GetLastError)]);
      DeviceName := TEncoding.Unicode.GetString(PropertyBuffer, 0, requiredLength - 1);


      FillChar(deviceInterfaceData, SizeOf(deviceInterfaceData), 0);
      deviceInterfaceData.cbSize := SizeOf(deviceInterfaceData);
      if SetupDiEnumDeviceInterfaces(FHardwareDeviceInfo, nil,
          @GUID_BLUETOOTHLE_DEVICE_INTERFACE, I, deviceInterfaceData) = FALSE then
      begin
        err := GetLastError;
        if err <> ERROR_NO_MORE_ITEMS then
          raise EBluetoothLEAdapterException.CreateFmt(SBluetoothLEGetDevicesError, [GetLastError, SysErrorMessage(GetLastError)]);
        Break;
      end;

      FillChar(deviceInterfaceDetailData^, 1024, 0);
      deviceInterfaceDetailData.cbSize := SizeOf(SP_DEVICE_INTERFACE_DETAIL_DATA) ;
      if SetupDiGetDeviceInterfaceDetail (FHardwareDeviceInfo, deviceInterfaceData,
        deviceInterfaceDetailData, 1024, @requiredLength, nil) = FALSE then
        raise EBluetoothLEAdapterException.CreateFmt(SBluetoothLEGetDevicesError, [GetLastError, SysErrorMessage(GetLastError)]);

      Path := PChar(@deviceInterfaceDetailData.DevicePath[0]);
      LTWinBluetoothLEDevice := TWinBluetoothLEDevice.Create(DeviceName, Path, Self, False);
      LTWinBluetoothLEDevice.FDeviceInfo := DeviceInfo;

      { RSSI not supported on windows }
      { Advertise Data not supported on windows }
      TWinBluetoothLEManager(FManager).FDiscoveredLEDevices.Add(LTWinBluetoothLEDevice);
      TWinBluetoothLEManager(FManager).DoDiscoverDevice(Self, LTWinBluetoothLEDevice, 0, nil);

      Inc(I);
    end;
  finally
    FreeMemory(deviceInterfaceDetailData);
  end;
end;

function TWinBluetoothLEAdapter.DoStartDiscovery(Timeout: Cardinal; const AFilterUUIDList: TBluetoothUUIDsList;
  const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList): Boolean;
begin                                    
  TWinBluetoothLEManager.ClearDevicesFromList(FManager.LastDiscoveredDevices);
  GetBLEDevices;
  TWinBluetoothLEManager(FManager).DoDiscoveryEnd(Self, TWinBluetoothLEManager(FManager).FDiscoveredLEDevices);
  Result := True;
end;

function TWinBluetoothLEAdapter.DoStartDiscoveryRaw(const ABluetoothLEScanFilterList: TBluetoothLEScanFilterList; Refresh: Boolean): Boolean;
begin
	raise EBluetoothAdapterException.Create(SBluetoothNotImplemented);
end;

function TWinBluetoothLEAdapter.GetAdapterName: string;
begin
  Result := FRadioInfo.szName;
end;

function TWinBluetoothLEAdapter.GetAddress: System.Bluetooth.TBluetoothMacAddress;
var
  LAddress: TBluetoothAddress;
begin
  Result := '00:00:00:00:00:00'; // Do not translate
  LAddress := FRadioInfo.address;
  if LAddress.ullLong <> BLUETOOTH_NULL_ADDRESS.ullLong then
    Result := BthAddressToString(LAddress);
end;

function TWinBluetoothLEAdapter.GetRadioInfo: TBluetoothRadioInfo;
var
  btfrp: TBlueToothFindRadioParams;
  hRadio: THandle;
  hFind: HBLUETOOTH_RADIO_FIND;
begin
  FillChar(btfrp, SizeOf(btfrp), 0);
  btfrp.dwSize := SizeOf(btfrp);

  hFind := BluetoothFindFirstRadio(btfrp, hRadio);
  if hFind <> 0 then
  begin
    Result.dwSize := SizeOf(TBluetoothRadioInfo);
    BluetoothGetRadioInfo(hRadio, Result);
    BluetoothFindRadioClose(hFind);
  end;
end;

function TWinBluetoothLEAdapter.GetScanMode: TBluetoothScanMode;
begin
  Result := Default(TBluetoothScanMode);
end;

function TWinBluetoothLEAdapter.GetState: TBluetoothAdapterState;
begin
  Result := Default(TBluetoothAdapterState);
end;

procedure TWinBluetoothLEAdapter.RegisterBTChangeNotification;
var
  btfrp: TBlueToothFindRadioParams;
  hRadio: THandle;
  hFind: HBLUETOOTH_RADIO_FIND;
  LNotificationFilter: TDevBroadcastHandle;
begin
  FillChar(btfrp, SizeOf(btfrp), 0);
  btfrp.dwSize := SizeOf(btfrp);
  hFind := BluetoothFindFirstRadio(btfrp, hRadio);
  if (hFind <> 0) and (FWinHandle <> INVALID_HANDLE_VALUE) then
  begin
    BluetoothFindRadioClose(hFind);
    ZeroMemory(@LNotificationFilter, SizeOf(LNotificationFilter));
    LNotificationFilter.dbch_size:= SizeOf(LNotificationFilter);
    LNotificationFilter.dbch_devicetype := DBT_DEVTYP_HANDLE;
    LNotificationFilter.dbch_handle := hRadio;
    FNotificationHandle := RegisterDeviceNotification(FWinHandle, @LNotificationFilter, DEVICE_NOTIFY_WINDOW_HANDLE);
  end
end;

procedure TWinBluetoothLEAdapter.SetAdapterName(const Value: string);
begin
  raise EBluetoothAdapterException.Create(SBluetoothNotImplemented);
end;

procedure TWinBluetoothLEAdapter.UnregisterBTChangeNotification;
begin
  if Assigned(FNotificationHandle) then
    UnregisterDeviceNotification(FNotificationHandle);
end;

procedure TWinBluetoothLEAdapter.WndProc(var Msg: TMessage);
var
  pHciEventInfo: PBTH_HCI_EVENT_INFO;
begin
  if (Msg.Msg = WM_DEVICECHANGE) and (Msg.WParam = DBT_CUSTOMEVENT) and
  (PDevBroadcastHandle(Msg.LParam).dbch_eventguid = GUID_BLUETOOTH_HCI_EVENT) then
  begin
    pHciEventInfo := PBTH_HCI_EVENT_INFO(@PDevBroadcastHandle(Msg.LParam).dbch_data);
    if (pHciEventInfo.connectionType = HCI_CONNECTION_TYPE_LE) then
      ChangeBTDeviceConnectionStatus(pHciEventInfo.bthAddress, pHciEventInfo.connected <> 0);
  end
  else
    Msg.Result := DefWindowProc(FWinHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

procedure TWinBluetoothLEAdapter.DoCancelDiscovery;
begin
  inherited;
  { Makes no sense in windows }
end;

{ TWinBluetoothGattClient }

constructor TWinBluetoothLEDevice.Create(const AName, APath: string; const ALEAdapter: TWinBluetoothLEAdapter; AutoConnect: Boolean);
begin
  inherited Create(AutoConnect);
  FDeviceName := AName;
  FDevicePath := APath;
  FMacAddress := ExtractMacAddres(APath);
  FLEAdapter := ALEAdapter;

  FLEDeviceHandle := CreateFile(PWideChar(FDevicePath), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, 0, 0);
  if FLEDeviceHandle = INVALID_HANDLE_VALUE then
    FLEDeviceHandle := CreateFile(PWideChar(FDevicePath), GENERIC_READ, 0, nil, OPEN_EXISTING, 0, 0);
  if FLEDeviceHandle = INVALID_HANDLE_VALUE then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLEDeviceHandleError, [Error, SysErrorMessage(Error)]);
end;

destructor TWinBluetoothLEDevice.Destroy;
begin
  if FReliableWriteContext <> 0 then
    BluetoothGATTAbortReliableWrite(FLEDeviceHandle, FReliableWriteContext, BLUETOOTH_GATT_FLAG_NONE);
  DoDisconnect;
  CloseHandle(FLEDeviceHandle);
  inherited;
end;

procedure TWinBluetoothLEDevice.DoAbortReliableWrite;
begin
  BluetoothGATTAbortReliableWrite(FLEDeviceHandle, FReliableWriteContext, BLUETOOTH_GATT_FLAG_NONE);
  FReliableWriteContext := 0;
end;

function TWinBluetoothLEDevice.DoBeginReliableWrite: Boolean;
var
  Res: HRESULT;
begin
  Res := BluetoothGATTBeginReliableWrite(FLEDeviceHandle, FReliableWriteContext, BLUETOOTH_GATT_FLAG_NONE);
  Result := S_OK = HResultCode(res);
end;

function TWinBluetoothLEDevice.DoDiscoverServices: Boolean;
var
  Res: HRESULT;
  ServiceBufferCount: Word;
  Services: array of TBthLeGattService;
  I: Integer;
begin
  Result := True;
  FServices.Clear;

  Res := BluetoothGATTGetServices(FLEDeviceHandle, 0, nil, ServiceBufferCount, BLUETOOTH_GATT_FLAG_NONE);
  if HResultCode(res) <> ERROR_MORE_DATA then
    raise EBluetoothLEServiceException.CreateFmt(SBluetoothLEGattServiceError, [res,res, GetLastError, SysErrorMessage(GetLastError)]);

  SetLength(Services, ServiceBufferCount);
  Fillchar(Services[0], ServiceBufferCount * SizeOf(TBthLeGattService), 0);

  Res := BluetoothGATTGetServices(FLEDeviceHandle, serviceBufferCount, @Services[0], serviceBufferCount, BLUETOOTH_GATT_FLAG_NONE);
  if S_OK <>  HResultCode(res) then
    raise EBluetoothLEServiceException.CreateFmt(SBluetoothLEGattServiceError, [GetLastError, SysErrorMessage(GetLastError)]);

  for I := 0 to serviceBufferCount - 1 do
    FServices.Add(TWinBluetoothGattService.Create(Self, Services[I], TBluetoothServiceType.Primary));

  DoOnServicesDiscovered(Self, FServices);
end;

function TWinBluetoothLEDevice.DoExecuteReliableWrite: Boolean;
var
  Res: HRESULT;
begin
  Res := BluetoothGATTEndReliableWrite(FLEDeviceHandle, FReliableWriteContext, BLUETOOTH_GATT_FLAG_NONE);
  Result := S_OK = HResultCode(res);
  FReliableWriteContext := 0;
end;

function TWinBluetoothLEDevice.DoReadCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  TThread.CreateAnonymousThread(procedure
    begin
      DoOnCharacteristicRead(ACharacteristic, TWinBluetoothGattCharacteristic(ACharacteristic).UpdateValueFromDevice);
    end).Start;
  Result := True;
end;

function TWinBluetoothLEDevice.DoReadDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  TThread.CreateAnonymousThread(procedure
    begin
      DoOnDescriptorRead(ADescriptor,
        TWinBluetoothGattDescriptor(ADescriptor).UpdateValueFromDevice);
    end).Start;
  Result := True;
end;

function TWinBluetoothLEDevice.DoReadRemoteRSSI: Boolean;
begin
  { Not supported on windows }
  Result := False;
end;


procedure NotificationCallback(EventType: TBthLeGattEventType; EventOutParameter: Pointer; Context: Pointer); stdcall;
begin
  TWinBluetoothGattCharacteristic(Context).ValueChangeEvent(EventOutParameter);
end;

function TWinBluetoothLEDevice.DoConnect: Boolean;
begin
  { Not supported on windows }
  Result := False;
end;

function TWinBluetoothLEDevice.DoCreateAdvertiseData: TBluetoothLEAdvertiseData;
begin
  { BluetoothLEAdvertiseData not supported on Windows Platform }
  Result := nil;
end;

function TWinBluetoothLEDevice.RegisterNotification(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
var
  Reg: TBluetoothGattValueChangedEventRegistration;
  Res: HRESULT;
begin
  Result := False;
  if ACharacteristic.Properties * [TBluetoothProperty.Notify, TBluetoothProperty.Indicate] <> [] then
  begin
    Reg.NumCharacteristics := 1;
    Reg.Characteristics[0] := TWinBluetoothGattCharacteristic(ACharacteristic).FGattCharacteristic;
    Res := BluetoothGATTRegisterEvent(TWinBluetoothGattCharacteristic(ACharacteristic).ServiceHandle,
        TBthLeGattEventType.CharacteristicValueChangedEvent, @Reg, @NotificationCallback, Pointer(ACharacteristic),
        TWinBluetoothGattCharacteristic(ACharacteristic).FValueChangeEventHandle, BLUETOOTH_GATT_FLAG_NONE);
    Result := S_OK = HResultCode(Res);
{$IFDEF AUTOREFCOUNT}
    if Result then
      ACharacteristic.__ObjAddRef;
{$ENDIF}
  end;
end;

function TWinBluetoothLEDevice.UnregisterNotification(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
var
  Res: HRESULT;
  LHandle: TBluetoothGattEventHandle;
begin
  Result := False;
  LHandle := TWinBluetoothGattCharacteristic(ACharacteristic).FValueChangeEventHandle;
  if LHandle <> 0 then
  begin
    Res := BluetoothGATTUnregisterEvent(LHandle, BLUETOOTH_GATT_FLAG_NONE);
    Result := S_OK = HResultCode(Res);
    TWinBluetoothGattCharacteristic(ACharacteristic).FValueChangeEventHandle := 0;
{$IFDEF AUTOREFCOUNT}
    ACharacteristic.__ObjRelease;
{$ENDIF}
  end;
end;

function TWinBluetoothLEDevice.DoSetCharacteristicNotification(const ACharacteristic: TBluetoothGattCharacteristic;
  Enable: Boolean): Boolean;
const
  Desc_Configuration: TBluetoothUUID = '{00002902-0000-1000-8000-00805F9B34FB}';
var
  LDesc: TBluetoothGattDescriptor;
begin
  if Enable then
    Result := RegisterNotification(ACharacteristic)
  else
    Result := UnregisterNotification(ACharacteristic);

  if Result then
  begin
    LDesc := ACharacteristic.GetDescriptor(Desc_Configuration);
    if LDesc <> nil then
    begin
      if TBluetoothProperty.Notify in ACharacteristic.Properties then
        LDesc.Notification := Enable
      else
        LDesc.Indication := Enable;
      WriteDescriptor(LDesc);
    end;
  end;
end;

function TWinBluetoothLEDevice.DoWriteCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  TThread.CreateAnonymousThread(procedure
    begin
      DoOnCharacteristicWrite(ACharacteristic, TWinBluetoothGattCharacteristic(ACharacteristic).SetValueToDevice);
    end).Start;
  Result := True;
end;

function TWinBluetoothLEDevice.DoWriteDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  TThread.CreateAnonymousThread(procedure
    begin
      DoOnDescriptorWrite(ADescriptor, TWinBluetoothGattDescriptor(ADescriptor).SetValueToDevice);
    end).Start;
  Result := True;
end;

function TWinBluetoothLEDevice.ExtractMacAddres(const APath: string): TBluetoothMacAddress;
var
  Temp: string;
begin
  Temp := APath.ToUpper;
  Result := Temp.Substring(Temp.IndexOf('#DEV_') + 5, 12); // Do not translate
  Result.Insert(2,':');
  Result.Insert(5,':');
  Result.Insert(8,':');
  Result.Insert(11,':');
  Result.Insert(14,':');
end;

function TWinBluetoothLEDevice.GetAddress: TBluetoothMacAddress;
begin
  Result := FMacAddress;
end;

function TWinBluetoothLEDevice.GetBluetoothType: TBluetoothType;
begin
  Result := TBluetoothType.LE;
end;

function TWinBluetoothLEDevice.GetDeviceName: string;
begin
  Result := FDeviceName;
end;

function TWinBluetoothLEDevice.GetIdentifier: string;
begin
  Result := GetAddress;
end;

function TWinBluetoothLEDevice.GetIsConnected: Boolean;
var
  PropertyBuffer: TBytes;
  PropertyType: DEVPROPTYPE;
begin
  Result := False;
  SetLength(PropertyBuffer, 4);
  if SetupDiGetDeviceProperty(FLEAdapter.FHardwareDeviceInfo, FDeviceInfo, @DEVPKEY_Device_DevNodeStatus,
    PropertyType, @PropertyBuffer[0], 4, nil, 0) = FALSE then
    raise EBluetoothLEDeviceException.CreateFmt(SBluetoothLEGetDevicesError, [GetLastError, SysErrorMessage(GetLastError)]);
  if (PropertyBuffer[3] and DN_DEVICE_DISCONNECTED) = 0 then
    Result := True;
end;

function TWinBluetoothLEDevice.DoDisconnect: Boolean;
begin
  if Assigned(FLEAdapter.FCancelConnectionFunction) then
    Result := S_OK = FLEAdapter.FCancelConnectionFunction(FLEDeviceHandle, BLUETOOTH_GATT_FLAG_NONE)
  else
    Result := False;
end;

{ TWinBluetoothGattCharacteristic }

constructor TWinBluetoothGattCharacteristic.Create(const AService: TWinBluetoothGattService;
  const AGattCharacteristic: TBthLeGattCharacteristic);
begin
  inherited Create(AService);

  FLEDeviceHandle := AService.FLEDeviceHandle;
  FGattService := AService.FGattService;
  FGattCharacteristic := AGattCharacteristic;
end;

destructor TWinBluetoothGattCharacteristic.Destroy;
begin
  if PValue <> nil then
    FreeMemory(PValue);
  if FValueChangeEventHandle <> 0 then
    BluetoothGATTUnregisterEvent(FValueChangeEventHandle, BLUETOOTH_GATT_FLAG_NONE);
  inherited;
end;

function TWinBluetoothGattCharacteristic.DoAddDescriptor(const ADescriptor: TBluetoothGattDescriptor): Boolean;
begin
  Result := False;
end;

function TWinBluetoothGattCharacteristic.DoCreateDescriptor(const AUUID: TBluetoothUUID): TBluetoothGattDescriptor;
begin
  raise EBluetoothLECharacteristicException.Create(SBluetoothNotImplemented);
  Result := nil;
end;

function TWinBluetoothGattCharacteristic.DoGetDescriptors: TBluetoothGattDescriptorList;
var
  res: HRESULT;
  DescriptorBufferCount: Word;
  Descriptors: array of TBthLeGattDescriptor;
  I: Integer;
begin
  Result := FDescriptors;
  FDescriptors.Clear;

  BluetoothGATTGetDescriptors(FLEDeviceHandle, FGattCharacteristic, 0, nil, DescriptorBufferCount, BLUETOOTH_GATT_FLAG_NONE);

  if DescriptorBufferCount > 0 then
  begin
    SetLength(Descriptors, DescriptorBufferCount);
    Fillchar(Descriptors[0], DescriptorBufferCount * SizeOf(TBthLeGattDescriptor), 0);
    res := BluetoothGATTGetDescriptors(FLEDeviceHandle, FGattCharacteristic, DescriptorBufferCount, @Descriptors[0],
      DescriptorBufferCount, BLUETOOTH_GATT_FLAG_NONE);
    if S_OK <>  HResultCode(res) then
      raise EBluetoothLECharacteristicException.CreateFmt(SBluetoothLEGattServiceError, [GetLastError, SysErrorMessage(GetLastError)]);

    for I := 0 to DescriptorBufferCount - 1 do
      FDescriptors.Add(TWinBluetoothGattDescriptor.Create(Self, Descriptors[I]));
  end;
end;


procedure TWinBluetoothGattDescriptor.CheckCreateValue;
begin
  if PValue = nil then
  begin
    PValue := GetMemory(SizeOf(TBthLeGattDescriptorValue));
    FillChar(PValue^, SizeOf(TBthLeGattDescriptorValue), 0);
    PValue.DescriptorType := TBthLeGattDescriptorType(Ord(Kind) - 1);
    PValue.DescriptorUuid := FGattDescriptor.DescriptorUuid;
  end;
end;

function TWinBluetoothGattCharacteristic.DoGetValue: TBytes;
begin
  if (PValue = nil) or (PValue.DataSize = 0) then
    SetLength(Result, 0)
  else
  begin
    SetLength(Result, PValue.DataSize);
    Move(PValue.Data, Result[0], PValue.DataSize);
  end;
end;

function TWinBluetoothGattCharacteristic.ServiceHandle: THandle;
begin
  Result := TWinBluetoothGattService(FService).ServiceHandle;
end;

procedure TWinBluetoothGattCharacteristic.DoSetValue(const AValue: TBytes);
begin
  if (PValue <> nil) and (Length(AValue) <> Integer(PValue.DataSize)) then
  begin
    FreeMemory(PValue);
    PValue := nil;
  end;
  if PValue = nil then
  begin
    PValue := GetMemory(SizeOf(TBthLeGattCharacteristicValue) + Length(AValue));
    PValue.DataSize := Length(AValue);
  end;
  if Length(AValue) > 0 then
    Move(AValue[0], PValue.Data, Length(AValue));
end;

function TWinBluetoothGattCharacteristic.GetProperties: TBluetoothPropertyFlags;
begin
  Result := [];
  if FGattCharacteristic.IsBroadcastable then
    Include(Result, TBluetoothProperty.Broadcast);
  if FGattCharacteristic.IsReadable then
    Include(Result, TBluetoothProperty.Read);
  if FGattCharacteristic.IsWritable then
    Include(Result, TBluetoothProperty.Write);
  if FGattCharacteristic.IsWritableWithoutResponse then
    Include(Result, TBluetoothProperty.WriteNoResponse);
  if FGattCharacteristic.IsSignedWritable then
    Include(Result, TBluetoothProperty.SignedWrite);
  if FGattCharacteristic.IsNotifiable then
    Include(Result, TBluetoothProperty.Notify);
  if FGattCharacteristic.IsIndicatable then
    Include(Result, TBluetoothProperty.Indicate);
end;

function TWinBluetoothGattCharacteristic.GetUUID: TBluetoothUUID;
begin
  Result := TBthLeUuidToUUID(FGattCharacteristic.CharacteristicUuid);
end;

function TWinBluetoothGattCharacteristic.SetValueToDevice: TBluetoothGattStatus;
var
  Flags: Cardinal;
begin
  if FGattCharacteristic.IsWritableWithoutResponse then
    Flags := BLUETOOTH_GATT_FLAG_WRITE_WITHOUT_RESPONSE
  else
    Flags := BLUETOOTH_GATT_FLAG_NONE;
  Result := ErrorToStatus(BluetoothGATTSetCharacteristicValue(TWinBluetoothGattService(FService).ServiceHandle,
              FGattCharacteristic, PValue, TWinBluetoothGattService(FService).FDevice.FReliableWriteContext, Flags));
end;

function TWinBluetoothGattCharacteristic.UpdateValueFromDevice: TBluetoothGattStatus;
var
  Res: HRESULT;
  Buffer: PBthLeGattCharacteristicValue;

  function GetCharacteristicValue(out ABuffer: PBthLeGattCharacteristicValue): HRESULT;
  var
    LBufferSize: Word;
  begin
    Result := BluetoothGATTGetCharacteristicValue(TWinBluetoothGattService(FService).ServiceHandle, FGattCharacteristic, 0, nil, @LBufferSize, BLUETOOTH_GATT_FLAG_NONE);
    if LBufferSize > 0 then
    begin
      ABuffer := GetMemory(LBufferSize);
      try
        Result := BluetoothGATTGetCharacteristicValue(TWinBluetoothGattService(FService).ServiceHandle, FGattCharacteristic, LBufferSize, ABuffer, nil, BLUETOOTH_GATT_FLAG_FORCE_READ_FROM_DEVICE);
        if S_OK = HResultCode(Result) then
        begin
          if PValue <> nil then
            FreeMemory(PValue);
          PValue := ABuffer;
        end
        else
          FreeMemory(ABuffer);
      except
        FreeMemory(ABuffer);
        raise
      end;
    end;
  end;

begin
  Result := TBluetoothGattStatus.Success;
  Res := GetCharacteristicValue(Buffer);
  if HResultCode(Res) = ERROR_INVALID_USER_BUFFER then
    Res := GetCharacteristicValue(Buffer);
  if S_OK <> HResultCode(Res) then
    Result := ErrorToStatus(Res)
end;

procedure TWinBluetoothGattCharacteristic.ValueChangeEvent(EventOutParameter: Pointer);
var
  ValueChanged: PBluetoothGattValueChangedEvent;
  Buffer: TBytes;
begin
  TMonitor.Enter(Self);
  try
    ValueChanged := PBluetoothGattValueChangedEvent(EventOutParameter);

    SetLength(Buffer, ValueChanged.CharacteristicValue.DataSize);
    if ValueChanged.CharacteristicValue.DataSize > 0 then
      Move(ValueChanged.CharacteristicValue.Data, Buffer[0], ValueChanged.CharacteristicValue.DataSize);

    SetValue(Buffer);
    TWinBluetoothGattService(FService).FDevice.DoOnCharacteristicRead(Self, TBluetoothGattStatus.Success);
  finally
    TMonitor.Exit(Self);
  end;
end;

{ TWinBluetoothGattService }

constructor TWinBluetoothGattService.Create(const ADevice: TWinBluetoothLEDevice;const AGattService: TBthLeGattService;
  AType: TBluetoothServiceType);
begin
  inherited Create(TGUID.Empty, AType);
  FDevice := ADevice;
  FLEDeviceHandle := ADevice.FLEDeviceHandle;
  FGattService := AGattService;
  FType := AType;
  FServiceHandle := INVALID_HANDLE_VALUE;
end;

destructor TWinBluetoothGattService.Destroy;
begin
  CloseHandle(FServiceHandle);
  inherited;
end;

function TWinBluetoothGattService.DoGetCharacteristics: TBluetoothGattCharacteristicList;
var
  res: HRESULT;
  CharacteristicsBufferCount: Word;
  Characteristics: array of TBthLeGattCharacteristic;
  I: Integer;
begin
  Result := FCharacteristics;
  FCharacteristics.Clear;

  BluetoothGATTGetCharacteristics(FLEDeviceHandle, @FGattService, 0, nil, CharacteristicsBufferCount, BLUETOOTH_GATT_FLAG_NONE);

  if CharacteristicsBufferCount > 0 then
  begin
    SetLength(Characteristics, CharacteristicsBufferCount);
    Fillchar(Characteristics[0], CharacteristicsBufferCount * SizeOf(TBthLeGattService), 0);

    res := BluetoothGATTGetCharacteristics(FLEDeviceHandle, @FGattService, CharacteristicsBufferCount, @Characteristics[0],
      CharacteristicsBufferCount, BLUETOOTH_GATT_FLAG_NONE);
    if S_OK <>  HResultCode(res) then
      raise EBluetoothServiceException.CreateFmt(SBluetoothLEGattIncludedServicesError, [GetLastError, SysErrorMessage(GetLastError)]);

    for I := 0 to CharacteristicsBufferCount - 1 do
      FCharacteristics.Add(TWinBluetoothGattCharacteristic.Create(Self, Characteristics[I]));
  end;
end;

function TWinBluetoothGattService.DoGetIncludedServices: TBluetoothGattServiceList;
var
  res: HRESULT;
  serviceBufferCount: Word;
  Services: array of TBthLeGattService;
  I: Integer;
begin
  Result := FIncludedServices;
  FIncludedServices.Clear;
  BluetoothGATTGetIncludedServices(FLEDeviceHandle, @FGattService, 0, nil, serviceBufferCount, BLUETOOTH_GATT_FLAG_NONE);
  if serviceBufferCount > 0 then
  begin
    SetLength(Services, serviceBufferCount);
    Fillchar(Services[0], serviceBufferCount * SizeOf(TBthLeGattService), 0);

    res := BluetoothGATTGetIncludedServices(FLEDeviceHandle, @FGattService, serviceBufferCount, @Services[0],
      serviceBufferCount, BLUETOOTH_GATT_FLAG_NONE);
    if S_OK <>  HResultCode(res) then
      raise EBluetoothServiceException.CreateFmt(SBluetoothLEGattIncludedServicesError, [GetLastError, SysErrorMessage(GetLastError)]);

    for I := 0 to serviceBufferCount - 1 do
      FIncludedServices.Add(TWinBluetoothGattService.Create(FDevice, Services[I], TBluetoothServiceType.Primary));
  end;
end;

function TWinBluetoothGattService.DoAddIncludedService(const AService: TBluetoothGattService): Boolean;
begin
  raise EBluetoothServiceException.Create(SBluetoothNotImplemented);
  Result := False;
end;

function TWinBluetoothGattService.DoAddCharacteristic(const ACharacteristic: TBluetoothGattCharacteristic): Boolean;
begin
  raise EBluetoothServiceException.Create(SBluetoothNotImplemented);
  Result := False;
end;

function TWinBluetoothGattService.DoCreateCharacteristic(const AUuid: TBluetoothUUID; APropertyFlags: TBluetoothPropertyFlags;
  const ADescription: string): TBluetoothGattCharacteristic;
begin
  raise EBluetoothServiceException.Create(SBluetoothNotImplemented);
  Result := nil;
end;

function TWinBluetoothGattService.DoCreateIncludedService(const AnUUID: TBluetoothUUID; AType: TBluetoothServiceType): TBluetoothGattService;
begin
  raise EBluetoothServiceException.Create(SBluetoothNotImplemented);
  Result := nil;
end;

function TWinBluetoothGattService.GetHandle: THandle;
begin
  if FServiceHandle = INVALID_HANDLE_VALUE then
    FServiceHandle := GetServiceHandle;

  Result := FServiceHandle;
end;

function TWinBluetoothGattService.GetServiceHandle: THandle;
var
  hardwareDeviceInfo: HDEVINFO;
  deviceInterfaceData: SP_DEVICE_INTERFACE_DATA;
  deviceInterfaceDetailData: PSP_DEVICE_INTERFACE_DETAIL_DATA;
  requiredLength: Cardinal;
  err: Cardinal;
  I: Integer;
  Path: string;
  LGUID: TGUID;
  LMac: string;
begin
  LMac := FDevice.FMacAddress;
  LMac := LMac.Replace(':', '');

  Result := INVALID_HANDLE_VALUE;

  deviceInterfaceDetailData := PSP_DEVICE_INTERFACE_DETAIL_DATA(GetMemory(1024));
  try
    LGUID := UUID;

    hardwareDeviceInfo := SetupDiGetClassDevs(@LGUID, nil, 0, DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
    if THandle(hardwareDeviceInfo) = INVALID_HANDLE_VALUE then
      raise Exception.CreateFmt(SBluetoothLEGetServicesHandle, [GetLastError, SysErrorMessage(GetLastError)]);

    I := 0;
    while True do
    begin
      FillChar(deviceInterfaceData, SizeOf(deviceInterfaceData), 0);
      deviceInterfaceData.cbSize := SizeOf(deviceInterfaceData);
      if SetupDiEnumDeviceInterfaces(hardwareDeviceInfo, nil,
          @LGUID, I, deviceInterfaceData) = FALSE then
      begin
        err := GetLastError;
        if err <> ERROR_NO_MORE_ITEMS then
          raise Exception.CreateFmt(SBluetoothLEGetServicesHandle, [GetLastError, SysErrorMessage(GetLastError)]);
        Break;
      end;

      FillChar(deviceInterfaceDetailData^, 1024, 0);
      deviceInterfaceDetailData.cbSize := SizeOf(SP_DEVICE_INTERFACE_DETAIL_DATA) ;
      if SetupDiGetDeviceInterfaceDetail (hardwareDeviceInfo, deviceInterfaceData,
        deviceInterfaceDetailData, 1024, @requiredLength, nil) = FALSE then
        raise Exception.CreateFmt(SBluetoothLEGetServicesHandle, [GetLastError, SysErrorMessage(GetLastError)]);

      Path := PChar(@deviceInterfaceDetailData.DevicePath[0]);
      if Path.ToUpper.Contains(LMac) then
      begin
        Result := CreateFile(PWideChar(Path), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                    OPEN_EXISTING, 0, 0);
        if Result = INVALID_HANDLE_VALUE then
          Result := CreateFile(PWideChar(Path), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
        Break;
      end;
      Inc(I);
    end;
  finally
    FreeMemory(deviceInterfaceDetailData);
  end;
  SetupDiDestroyDeviceInfoList(hardwareDeviceInfo);
end;

function TWinBluetoothGattService.GetServiceType: TBluetoothServiceType;
begin
  Result := FType;
end;

function TWinBluetoothGattService.GetServiceUUID: TBluetoothUUID;
begin
  Result := TBthLeUuidToUUID(FGattService.ServiceUuid);
end;

{ TWinBluetoothGattDescriptor }

constructor TWinBluetoothGattDescriptor.Create(const ACharacteristic: TWinBluetoothGattCharacteristic; const AGattDescriptor: TBthLeGattDescriptor);
begin
  inherited Create(ACharacteristic);
  FGattDescriptor := AGattDescriptor;
end;

destructor TWinBluetoothGattDescriptor.Destroy;
begin
  if PValue <> nil then
    FreeMemory(PValue);

  inherited;
end;

function TWinBluetoothGattDescriptor.DoGetBroadcasts: Boolean;
begin
  if PValue = nil then
    Result := False
  else
    Result := PValue.DescriptorInfo.IsBroadcast;
end;

function TWinBluetoothGattDescriptor.DoGetExponent: ShortInt;
begin
  if PValue = nil then
    Result := 0
  else
  Result := PValue.DescriptorInfo.Exponent;
end;

function TWinBluetoothGattDescriptor.DoGetFormat: TBluetoothGattFormatType;
begin
  if PValue = nil then
    Result := TBluetoothGattFormatType.Reserved
  else
    Result := TBluetoothGattFormatType(PValue.DescriptorInfo.Format);
end;

function TWinBluetoothGattDescriptor.DoGetFormatUnit: TBluetoothUUID;
begin
  if PValue = nil then
    Result := TGUID.Empty
  else
    Result := TBthLeUuidToUUID(PValue.DescriptorInfo.&Unit);
end;

function TWinBluetoothGattDescriptor.DoGetIndication: Boolean;
begin
  if PValue = nil then
    Result := False
  else
    Result := PValue.DescriptorInfo.IsSubscribeToIndication;
end;

function TWinBluetoothGattDescriptor.DoGetNotification: Boolean;
begin
  if PValue = nil then
    Result := False
  else
    Result := PValue.DescriptorInfo.IsSubscribeToNotification;
end;

function TWinBluetoothGattDescriptor.DoGetReliableWrite: Boolean;
begin
  if PValue = nil then
    Result := False
  else
    Result := PValue.DescriptorInfo.IsReliableWriteEnabled;
end;

function TWinBluetoothGattDescriptor.DoGetUserDescription: string;
var
  B: TBytes;
begin
  if (PValue = nil) or (PValue.DataSize = 0) then
    Result := ''
  else
  begin
    SetLength(B, PValue.DataSize);
    Move(PValue.Data, B[0], PValue.DataSize);
    Result := TEncoding.UTF8.GetString(B);
  end;
end;

function TWinBluetoothGattDescriptor.DoGetValue: TBytes;
begin
  if (PValue = nil) or (PValue.DataSize = 0) then
    SetLength(Result, 0)
  else
  begin
    SetLength(Result, PValue.DataSize);
    Move(PValue.Data, Result[0], PValue.DataSize);
  end;
end;

function TWinBluetoothGattDescriptor.DoGetWritableAuxiliaries: Boolean;
begin
  if PValue = nil then
    Result := False
  else
    Result := PValue.DescriptorInfo.IsAuxiliariesWritable;
end;

procedure TWinBluetoothGattDescriptor.DoSetBroadcasts(const Value: Boolean);
begin
  inherited;
  CheckCreateValue;
  PValue.DescriptorInfo.IsBroadcast := Value;
end;

procedure TWinBluetoothGattDescriptor.DoSetIndication(const Value: Boolean);
begin
  inherited;
  CheckCreateValue;
  PValue.DescriptorInfo.IsSubscribeToIndication := Value;
end;

procedure TWinBluetoothGattDescriptor.DoSetNotification(const Value: Boolean);
begin
  inherited;
  CheckCreateValue;
  PValue.DescriptorInfo.IsSubscribeToNotification := Value;
end;

procedure TWinBluetoothGattDescriptor.DoSetUserDescription(const Value: string);
begin
  inherited;
  CheckCreateValue;
  DoSetValue(TEncoding.UTF8.GetBytes(Value));
end;

procedure TWinBluetoothGattDescriptor.DoSetValue(const AValue: TBytes);
begin
  CheckCreateValue;
  PValue := ReallocMemory(PValue, SizeOf(TBthLeGattDescriptorValue) + Length(AValue));
  PValue.DataSize := Length(AValue);
  if PValue.DataSize > 0 then
    Move(AValue[0], PValue.Data, Length(AValue));
end;

function TWinBluetoothGattDescriptor.GetUUID: TBluetoothUUID;
begin
  Result := TBthLeUuidToUUID(FGattDescriptor.DescriptorUuid);
end;

function TWinBluetoothGattDescriptor.SetValueToDevice: TBluetoothGattStatus;
var
  res: HRESULT;
begin
  Result := TBluetoothGattStatus.Success;
  res := BluetoothGATTSetDescriptorValue(TWinBluetoothGattCharacteristic(FCharacteristic).ServiceHandle, FGattDescriptor, PValue, BLUETOOTH_GATT_FLAG_NONE);
  if S_OK <>  HResultCode(res) then
    Result := ErrorToStatus(res);
end;

function TWinBluetoothGattDescriptor.UpdateValueFromDevice: TBluetoothGattStatus;
var
  res: HRESULT;
  BufferSize: Word;
  Buffer: PBthLeGattDescriptorValue;
begin
  Result := TBluetoothGattStatus.Success;
  res := BluetoothGATTGetDescriptorValue(TWinBluetoothGattCharacteristic(FCharacteristic).ServiceHandle, FGattDescriptor, 0, nil, @BufferSize, BLUETOOTH_GATT_FLAG_NONE);
  if HResultCode(res) <> ERROR_MORE_DATA then
    Result := ErrorToStatus(res);

  if BufferSize > 0 then
  begin
    Buffer := GetMemory(BufferSize);
    try
      res := BluetoothGATTGetDescriptorValue(TWinBluetoothGattCharacteristic(FCharacteristic).ServiceHandle, FGattDescriptor, BufferSize, Buffer, nil, BLUETOOTH_GATT_FLAG_FORCE_READ_FROM_DEVICE);
      if S_OK <>  HResultCode(res) then
        Result := ErrorToStatus(res)
      else
      begin
        if PValue <> nil then
          FreeMemory(PValue);
        PValue := Buffer;
      end;
    except
      FreeMemory(Buffer);
      raise;
    end;
  end;
end;
{$ENDIF BLUETOOTH_LE}

end.
