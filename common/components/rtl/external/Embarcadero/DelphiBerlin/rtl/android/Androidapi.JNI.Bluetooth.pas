{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Bluetooth;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util;

type
// ===== Forward declarations =====

  JBluetoothA2dp = interface;//android.bluetooth.BluetoothA2dp
  JBluetoothAdapter = interface;//android.bluetooth.BluetoothAdapter
  JBluetoothAdapter_LeScanCallback = interface;//android.bluetooth.BluetoothAdapter$LeScanCallback
  JBluetoothAssignedNumbers = interface;//android.bluetooth.BluetoothAssignedNumbers
  Jbluetooth_BluetoothClass = interface;//android.bluetooth.BluetoothClass
  JBluetoothClass_Device = interface;//android.bluetooth.BluetoothClass$Device
  JDevice_Major = interface;//android.bluetooth.BluetoothClass$Device$Major
  JBluetoothClass_Service = interface;//android.bluetooth.BluetoothClass$Service
  JBluetoothDevice = interface;//android.bluetooth.BluetoothDevice
  JBluetoothGatt = interface;//android.bluetooth.BluetoothGatt
  JBluetoothGattCallback = interface;//android.bluetooth.BluetoothGattCallback
  JBluetoothGattCharacteristic = interface;//android.bluetooth.BluetoothGattCharacteristic
  JBluetoothGattDescriptor = interface;//android.bluetooth.BluetoothGattDescriptor
  JBluetoothGattServer = interface;//android.bluetooth.BluetoothGattServer
  JBluetoothGattServerCallback = interface;//android.bluetooth.BluetoothGattServerCallback
  JBluetoothGattService = interface;//android.bluetooth.BluetoothGattService
  JBluetoothHeadset = interface;//android.bluetooth.BluetoothHeadset
  JBluetoothHealth = interface;//android.bluetooth.BluetoothHealth
  JBluetoothHealthAppConfiguration = interface;//android.bluetooth.BluetoothHealthAppConfiguration
  JBluetoothHealthCallback = interface;//android.bluetooth.BluetoothHealthCallback
  JBluetoothManager = interface;//android.bluetooth.BluetoothManager
  JBluetoothProfile = interface;//android.bluetooth.BluetoothProfile
  JBluetoothProfile_ServiceListener = interface;//android.bluetooth.BluetoothProfile$ServiceListener
  JBluetoothServerSocket = interface;//android.bluetooth.BluetoothServerSocket
  JBluetoothSocket = interface;//android.bluetooth.BluetoothSocket
  JRTLBluetoothGattCallback = interface;//android.bluetooth.RTLBluetoothGattCallback
  JRTLAdvertiseListener = interface;//android.bluetooth.le.RTLAdvertiseListener
  JRTLBluetoothGattListener = interface;//android.bluetooth.RTLBluetoothGattListener
  JRTLBluetoothGattServerCallback = interface;//android.bluetooth.RTLBluetoothGattServerCallback
  JRTLBluetoothGattServerListener = interface;//android.bluetooth.RTLBluetoothGattServerListener
  JAdvertiseCallback = interface;//android.bluetooth.le.AdvertiseCallback
  JRTLAdvertiseCallback = interface;//android.bluetooth.le.RTLAdvertiseCallback
  JAdvertiseData = interface;//android.bluetooth.le.AdvertiseData
  JAdvertiseData_Builder = interface;//android.bluetooth.le.AdvertiseData$Builder
  JAdvertiseSettings = interface;//android.bluetooth.le.AdvertiseSettings
  JAdvertiseSettings_Builder = interface;//android.bluetooth.le.AdvertiseSettings$Builder
  JBluetoothLeAdvertiser = interface;//android.bluetooth.le.BluetoothLeAdvertiser
  JBluetoothLeScanner = interface;//android.bluetooth.le.BluetoothLeScanner
  JScanCallback = interface;//android.bluetooth.le.ScanCallback
  JRTLScanListener = interface;//android.bluetooth.le.RTLScanListener
  JRTLScanCallback = interface;//android.bluetooth.le.RTLScanCallback
  JScanFilter = interface;//android.bluetooth.le.ScanFilter
  JScanFilter_Builder = interface;//android.bluetooth.le.ScanFilter$Builder
  JScanRecord = interface;//android.bluetooth.le.ScanRecord
  Jle_ScanResult = interface;//android.bluetooth.le.ScanResult
  JScanSettings = interface;//android.bluetooth.le.ScanSettings
  JScanSettings_Builder = interface;//android.bluetooth.le.ScanSettings$Builder

// ===== Interface declarations =====

  JBluetoothA2dpClass = interface(JObjectClass)
    ['{2B9E047D-CF63-4A9C-97A9-C4F372207C86}']
    {class} function _GetACTION_CONNECTION_STATE_CHANGED: JString; cdecl;
    {class} function _GetACTION_PLAYING_STATE_CHANGED: JString; cdecl;
    {class} function _GetSTATE_NOT_PLAYING: Integer; cdecl;
    {class} function _GetSTATE_PLAYING: Integer; cdecl;
    {class} property ACTION_CONNECTION_STATE_CHANGED: JString read _GetACTION_CONNECTION_STATE_CHANGED;
    {class} property ACTION_PLAYING_STATE_CHANGED: JString read _GetACTION_PLAYING_STATE_CHANGED;
    {class} property STATE_NOT_PLAYING: Integer read _GetSTATE_NOT_PLAYING;
    {class} property STATE_PLAYING: Integer read _GetSTATE_PLAYING;
  end;

  [JavaSignature('android/bluetooth/BluetoothA2dp')]
  JBluetoothA2dp = interface(JObject)
    ['{61C30A48-9578-4FDA-B2A4-B748DB7A55DE}']
    procedure finalize; cdecl;
    function getConnectedDevices: JList; cdecl;
    function getConnectionState(device: JBluetoothDevice): Integer; cdecl;
    function getDevicesMatchingConnectionStates(states: TJavaArray<Integer>): JList; cdecl;
    function isA2dpPlaying(device: JBluetoothDevice): Boolean; cdecl;
  end;
  TJBluetoothA2dp = class(TJavaGenericImport<JBluetoothA2dpClass, JBluetoothA2dp>) end;

  JBluetoothAdapterClass = interface(JObjectClass)
    ['{7C08F8A8-7F06-4797-BECA-F5C4564BAEEC}']
    {class} function _GetACTION_CONNECTION_STATE_CHANGED: JString; cdecl;
    {class} function _GetACTION_DISCOVERY_FINISHED: JString; cdecl;
    {class} function _GetACTION_DISCOVERY_STARTED: JString; cdecl;
    {class} function _GetACTION_LOCAL_NAME_CHANGED: JString; cdecl;
    {class} function _GetACTION_REQUEST_DISCOVERABLE: JString; cdecl;
    {class} function _GetACTION_REQUEST_ENABLE: JString; cdecl;
    {class} function _GetACTION_SCAN_MODE_CHANGED: JString; cdecl;
    {class} function _GetACTION_STATE_CHANGED: JString; cdecl;
    {class} function _GetERROR: Integer; cdecl;
    {class} function _GetEXTRA_CONNECTION_STATE: JString; cdecl;
    {class} function _GetEXTRA_DISCOVERABLE_DURATION: JString; cdecl;
    {class} function _GetEXTRA_LOCAL_NAME: JString; cdecl;
    {class} function _GetEXTRA_PREVIOUS_CONNECTION_STATE: JString; cdecl;
    {class} function _GetEXTRA_PREVIOUS_SCAN_MODE: JString; cdecl;
    {class} function _GetEXTRA_PREVIOUS_STATE: JString; cdecl;
    {class} function _GetEXTRA_SCAN_MODE: JString; cdecl;
    {class} function _GetEXTRA_STATE: JString; cdecl;
    {class} function _GetSCAN_MODE_CONNECTABLE: Integer; cdecl;
    {class} function _GetSCAN_MODE_CONNECTABLE_DISCOVERABLE: Integer; cdecl;
    {class} function _GetSCAN_MODE_NONE: Integer; cdecl;
    {class} function _GetSTATE_CONNECTED: Integer; cdecl;
    {class} function _GetSTATE_CONNECTING: Integer; cdecl;
    {class} function _GetSTATE_DISCONNECTED: Integer; cdecl;
    {class} function _GetSTATE_DISCONNECTING: Integer; cdecl;
    {class} function _GetSTATE_OFF: Integer; cdecl;
    {class} function _GetSTATE_ON: Integer; cdecl;
    {class} function _GetSTATE_TURNING_OFF: Integer; cdecl;
    {class} function _GetSTATE_TURNING_ON: Integer; cdecl;
    {class} function checkBluetoothAddress(address: JString): Boolean; cdecl;
    {class} function getDefaultAdapter: JBluetoothAdapter; cdecl;
    {class} property ACTION_CONNECTION_STATE_CHANGED: JString read _GetACTION_CONNECTION_STATE_CHANGED;
    {class} property ACTION_DISCOVERY_FINISHED: JString read _GetACTION_DISCOVERY_FINISHED;
    {class} property ACTION_DISCOVERY_STARTED: JString read _GetACTION_DISCOVERY_STARTED;
    {class} property ACTION_LOCAL_NAME_CHANGED: JString read _GetACTION_LOCAL_NAME_CHANGED;
    {class} property ACTION_REQUEST_DISCOVERABLE: JString read _GetACTION_REQUEST_DISCOVERABLE;
    {class} property ACTION_REQUEST_ENABLE: JString read _GetACTION_REQUEST_ENABLE;
    {class} property ACTION_SCAN_MODE_CHANGED: JString read _GetACTION_SCAN_MODE_CHANGED;
    {class} property ACTION_STATE_CHANGED: JString read _GetACTION_STATE_CHANGED;
    {class} property ERROR: Integer read _GetERROR;
    {class} property EXTRA_CONNECTION_STATE: JString read _GetEXTRA_CONNECTION_STATE;
    {class} property EXTRA_DISCOVERABLE_DURATION: JString read _GetEXTRA_DISCOVERABLE_DURATION;
    {class} property EXTRA_LOCAL_NAME: JString read _GetEXTRA_LOCAL_NAME;
    {class} property EXTRA_PREVIOUS_CONNECTION_STATE: JString read _GetEXTRA_PREVIOUS_CONNECTION_STATE;
    {class} property EXTRA_PREVIOUS_SCAN_MODE: JString read _GetEXTRA_PREVIOUS_SCAN_MODE;
    {class} property EXTRA_PREVIOUS_STATE: JString read _GetEXTRA_PREVIOUS_STATE;
    {class} property EXTRA_SCAN_MODE: JString read _GetEXTRA_SCAN_MODE;
    {class} property EXTRA_STATE: JString read _GetEXTRA_STATE;
    {class} property SCAN_MODE_CONNECTABLE: Integer read _GetSCAN_MODE_CONNECTABLE;
    {class} property SCAN_MODE_CONNECTABLE_DISCOVERABLE: Integer read _GetSCAN_MODE_CONNECTABLE_DISCOVERABLE;
    {class} property SCAN_MODE_NONE: Integer read _GetSCAN_MODE_NONE;
    {class} property STATE_CONNECTED: Integer read _GetSTATE_CONNECTED;
    {class} property STATE_CONNECTING: Integer read _GetSTATE_CONNECTING;
    {class} property STATE_DISCONNECTED: Integer read _GetSTATE_DISCONNECTED;
    {class} property STATE_DISCONNECTING: Integer read _GetSTATE_DISCONNECTING;
    {class} property STATE_OFF: Integer read _GetSTATE_OFF;
    {class} property STATE_ON: Integer read _GetSTATE_ON;
    {class} property STATE_TURNING_OFF: Integer read _GetSTATE_TURNING_OFF;
    {class} property STATE_TURNING_ON: Integer read _GetSTATE_TURNING_ON;
  end;

  [JavaSignature('android/bluetooth/BluetoothAdapter')]
  JBluetoothAdapter = interface(JObject)
    ['{3C62EC75-B2D5-4F6F-820C-02222EA05B54}']
    function cancelDiscovery: Boolean; cdecl;
    procedure closeProfileProxy(profile: Integer; proxy: JBluetoothProfile); cdecl;
    function disable: Boolean; cdecl;
    function enable: Boolean; cdecl;
    function getAddress: JString; cdecl;
    function getBluetoothLeAdvertiser: JBluetoothLeAdvertiser; cdecl;
    function getBluetoothLeScanner: JBluetoothLeScanner; cdecl;
    function getBondedDevices: JSet; cdecl;
    function getName: JString; cdecl;
    function getProfileConnectionState(profile: Integer): Integer; cdecl;
    function getProfileProxy(context: JContext; listener: JBluetoothProfile_ServiceListener; profile: Integer): Boolean; cdecl;
    function getRemoteDevice(address: JString): JBluetoothDevice; cdecl; overload;
    function getRemoteDevice(address: TJavaArray<Byte>): JBluetoothDevice; cdecl; overload;
    function getScanMode: Integer; cdecl;
    function getState: Integer; cdecl;
    function isDiscovering: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isMultipleAdvertisementSupported: Boolean; cdecl;
    function isOffloadedFilteringSupported: Boolean; cdecl;
    function isOffloadedScanBatchingSupported: Boolean; cdecl;
    function listenUsingInsecureRfcommWithServiceRecord(name: JString; uuid: JUUID): JBluetoothServerSocket; cdecl;
    function listenUsingRfcommWithServiceRecord(name: JString; uuid: JUUID): JBluetoothServerSocket; cdecl;
    function setName(name: JString): Boolean; cdecl;
    function startDiscovery: Boolean; cdecl;
    function startLeScan(callback: JBluetoothAdapter_LeScanCallback): Boolean; cdecl; overload;//Deprecated
    function startLeScan(serviceUuids: TJavaObjectArray<JUUID>; callback: JBluetoothAdapter_LeScanCallback): Boolean; cdecl; overload;//Deprecated
    procedure stopLeScan(callback: JBluetoothAdapter_LeScanCallback); cdecl;//Deprecated
  end;
  TJBluetoothAdapter = class(TJavaGenericImport<JBluetoothAdapterClass, JBluetoothAdapter>) end;

  JBluetoothAdapter_LeScanCallbackClass = interface(IJavaClass)
    ['{A774D140-5BD1-4EAC-98B8-1124178FFE47}']
  end;

  [JavaSignature('android/bluetooth/BluetoothAdapter$LeScanCallback')]
  JBluetoothAdapter_LeScanCallback = interface(IJavaInstance)
    ['{A520E11B-267D-4EA6-850B-3074F1C11D95}']
    procedure onLeScan(device: JBluetoothDevice; rssi: Integer; scanRecord: TJavaArray<Byte>); cdecl;
  end;
  TJBluetoothAdapter_LeScanCallback = class(TJavaGenericImport<JBluetoothAdapter_LeScanCallbackClass, JBluetoothAdapter_LeScanCallback>) end;

  JBluetoothAssignedNumbersClass = interface(JObjectClass)
    ['{C5F0EBA1-1D77-43F6-B645-EF5A5D248FE7}']
    {class} function _GetAAMP_OF_AMERICA: Integer; cdecl;
    {class} function _GetACCEL_SEMICONDUCTOR: Integer; cdecl;
    {class} function _GetACE_SENSOR: Integer; cdecl;
    {class} function _GetADIDAS: Integer; cdecl;
    {class} function _GetADVANCED_PANMOBIL_SYSTEMS: Integer; cdecl;
    {class} function _GetAIROHA_TECHNOLOGY: Integer; cdecl;
    {class} function _GetALCATEL: Integer; cdecl;
    {class} function _GetALPWISE: Integer; cdecl;
    {class} function _GetAMICCOM_ELECTRONICS: Integer; cdecl;
    {class} function _GetAPLIX: Integer; cdecl;
    {class} function _GetAPPLE: Integer; cdecl;
    {class} function _GetAPT_LICENSING: Integer; cdecl;
    {class} function _GetARCHOS: Integer; cdecl;
    {class} function _GetARP_DEVICES: Integer; cdecl;
    {class} function _GetATHEROS_COMMUNICATIONS: Integer; cdecl;
    {class} function _GetATMEL: Integer; cdecl;
    {class} function _GetAUSTCO_COMMUNICATION_SYSTEMS: Integer; cdecl;
    {class} function _GetAUTONET_MOBILE: Integer; cdecl;
    {class} function _GetAVAGO: Integer; cdecl;
    {class} function _GetAVM_BERLIN: Integer; cdecl;
    {class} function _GetA_AND_D_ENGINEERING: Integer; cdecl;
    {class} function _GetA_AND_R_CAMBRIDGE: Integer; cdecl;
    {class} function _GetBANDSPEED: Integer; cdecl;
    {class} function _GetBAND_XI_INTERNATIONAL: Integer; cdecl;
    {class} function _GetBDE_TECHNOLOGY: Integer; cdecl;
    {class} function _GetBEATS_ELECTRONICS: Integer; cdecl;
    {class} function _GetBEAUTIFUL_ENTERPRISE: Integer; cdecl;
    {class} function _GetBEKEY: Integer; cdecl;
    {class} function _GetBELKIN_INTERNATIONAL: Integer; cdecl;
    {class} function _GetBINAURIC: Integer; cdecl;
    {class} function _GetBIOSENTRONICS: Integer; cdecl;
    {class} function _GetBLUEGIGA: Integer; cdecl;
    {class} function _GetBLUERADIOS: Integer; cdecl;
    {class} function _GetBLUETOOTH_SIG: Integer; cdecl;
    {class} function _GetBLUETREK_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetBOSE: Integer; cdecl;
    {class} function _GetBRIARTEK: Integer; cdecl;
    {class} function _GetBROADCOM: Integer; cdecl;
    {class} function _GetCAEN_RFID: Integer; cdecl;
    {class} function _GetCAMBRIDGE_SILICON_RADIO: Integer; cdecl;
    {class} function _GetCATC: Integer; cdecl;
    {class} function _GetCINETIX: Integer; cdecl;
    {class} function _GetCLARINOX_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetCOLORFY: Integer; cdecl;
    {class} function _GetCOMMIL: Integer; cdecl;
    {class} function _GetCONEXANT_SYSTEMS: Integer; cdecl;
    {class} function _GetCONNECTBLUE: Integer; cdecl;
    {class} function _GetCONTINENTAL_AUTOMOTIVE: Integer; cdecl;
    {class} function _GetCONWISE_TECHNOLOGY: Integer; cdecl;
    {class} function _GetCREATIVE_TECHNOLOGY: Integer; cdecl;
    {class} function _GetC_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetDANLERS: Integer; cdecl;
    {class} function _GetDELORME_PUBLISHING_COMPANY: Integer; cdecl;
    {class} function _GetDEXCOM: Integer; cdecl;
    {class} function _GetDIALOG_SEMICONDUCTOR: Integer; cdecl;
    {class} function _GetDIGIANSWER: Integer; cdecl;
    {class} function _GetECLIPSE: Integer; cdecl;
    {class} function _GetECOTEST: Integer; cdecl;
    {class} function _GetELGATO_SYSTEMS: Integer; cdecl;
    {class} function _GetEM_MICROELECTRONIC_MARIN: Integer; cdecl;
    {class} function _GetEQUINOX_AG: Integer; cdecl;
    {class} function _GetERICSSON_TECHNOLOGY: Integer; cdecl;
    {class} function _GetEVLUMA: Integer; cdecl;
    {class} function _GetFREE2MOVE: Integer; cdecl;
    {class} function _GetFUNAI_ELECTRIC: Integer; cdecl;
    {class} function _GetGARMIN_INTERNATIONAL: Integer; cdecl;
    {class} function _GetGCT_SEMICONDUCTOR: Integer; cdecl;
    {class} function _GetGELO: Integer; cdecl;
    {class} function _GetGENEQ: Integer; cdecl;
    {class} function _GetGENERAL_MOTORS: Integer; cdecl;
    {class} function _GetGENNUM: Integer; cdecl;
    {class} function _GetGEOFORCE: Integer; cdecl;
    {class} function _GetGIBSON_GUITARS: Integer; cdecl;
    {class} function _GetGN_NETCOM: Integer; cdecl;
    {class} function _GetGN_RESOUND: Integer; cdecl;
    {class} function _GetGOOGLE: Integer; cdecl;
    {class} function _GetGREEN_THROTTLE_GAMES: Integer; cdecl;
    {class} function _GetGROUP_SENSE: Integer; cdecl;
    {class} function _GetHANLYNN_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetHARMAN_INTERNATIONAL: Integer; cdecl;
    {class} function _GetHEWLETT_PACKARD: Integer; cdecl;
    {class} function _GetHITACHI: Integer; cdecl;
    {class} function _GetHOSIDEN: Integer; cdecl;
    {class} function _GetIBM: Integer; cdecl;
    {class} function _GetINFINEON_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetINGENIEUR_SYSTEMGRUPPE_ZAHN: Integer; cdecl;
    {class} function _GetINTEGRATED_SILICON_SOLUTION: Integer; cdecl;
    {class} function _GetINTEGRATED_SYSTEM_SOLUTION: Integer; cdecl;
    {class} function _GetINTEL: Integer; cdecl;
    {class} function _GetINVENTEL: Integer; cdecl;
    {class} function _GetIPEXTREME: Integer; cdecl;
    {class} function _GetI_TECH_DYNAMIC_GLOBAL_DISTRIBUTION: Integer; cdecl;
    {class} function _GetJAWBONE: Integer; cdecl;
    {class} function _GetJIANGSU_TOPPOWER_AUTOMOTIVE_ELECTRONICS: Integer; cdecl;
    {class} function _GetJOHNSON_CONTROLS: Integer; cdecl;
    {class} function _GetJ_AND_M: Integer; cdecl;
    {class} function _GetKAWANTECH: Integer; cdecl;
    {class} function _GetKC_TECHNOLOGY: Integer; cdecl;
    {class} function _GetKENSINGTON_COMPUTER_PRODUCTS_GROUP: Integer; cdecl;
    {class} function _GetLAIRD_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetLESSWIRE: Integer; cdecl;
    {class} function _GetLG_ELECTRONICS: Integer; cdecl;
    {class} function _GetLINAK: Integer; cdecl;
    {class} function _GetLUCENT: Integer; cdecl;
    {class} function _GetLUDUS_HELSINKI: Integer; cdecl;
    {class} function _GetMACRONIX: Integer; cdecl;
    {class} function _GetMAGNETI_MARELLI: Integer; cdecl;
    {class} function _GetMANSELLA: Integer; cdecl;
    {class} function _GetMARVELL: Integer; cdecl;
    {class} function _GetMATSUSHITA_ELECTRIC: Integer; cdecl;
    {class} function _GetMC10: Integer; cdecl;
    {class} function _GetMEDIATEK: Integer; cdecl;
    {class} function _GetMESO_INTERNATIONAL: Integer; cdecl;
    {class} function _GetMETA_WATCH: Integer; cdecl;
    {class} function _GetMEWTEL_TECHNOLOGY: Integer; cdecl;
    {class} function _GetMICOMMAND: Integer; cdecl;
    {class} function _GetMICROCHIP_TECHNOLOGY: Integer; cdecl;
    {class} function _GetMICROSOFT: Integer; cdecl;
    {class} function _GetMINDTREE: Integer; cdecl;
    {class} function _GetMISFIT_WEARABLES: Integer; cdecl;
    {class} function _GetMITEL_SEMICONDUCTOR: Integer; cdecl;
    {class} function _GetMITSUBISHI_ELECTRIC: Integer; cdecl;
    {class} function _GetMOBILIAN_CORPORATION: Integer; cdecl;
    {class} function _GetMONSTER: Integer; cdecl;
    {class} function _GetMOTOROLA: Integer; cdecl;
    {class} function _GetMSTAR_SEMICONDUCTOR: Integer; cdecl;
    {class} function _GetMUZIK: Integer; cdecl;
    {class} function _GetNEC: Integer; cdecl;
    {class} function _GetNEC_LIGHTING: Integer; cdecl;
    {class} function _GetNEWLOGIC: Integer; cdecl;
    {class} function _GetNIKE: Integer; cdecl;
    {class} function _GetNINE_SOLUTIONS: Integer; cdecl;
    {class} function _GetNOKIA_MOBILE_PHONES: Integer; cdecl;
    {class} function _GetNORDIC_SEMICONDUCTOR: Integer; cdecl;
    {class} function _GetNORWOOD_SYSTEMS: Integer; cdecl;
    {class} function _GetODM_TECHNOLOGY: Integer; cdecl;
    {class} function _GetOMEGAWAVE: Integer; cdecl;
    {class} function _GetONSET_COMPUTER: Integer; cdecl;
    {class} function _GetOPEN_INTERFACE: Integer; cdecl;
    {class} function _GetOTL_DYNAMICS: Integer; cdecl;
    {class} function _GetPANDA_OCEAN: Integer; cdecl;
    {class} function _GetPARROT: Integer; cdecl;
    {class} function _GetPARTHUS_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetPASSIF_SEMICONDUCTOR: Integer; cdecl;
    {class} function _GetPETER_SYSTEMTECHNIK: Integer; cdecl;
    {class} function _GetPHILIPS_SEMICONDUCTORS: Integer; cdecl;
    {class} function _GetPLANTRONICS: Integer; cdecl;
    {class} function _GetPOLAR_ELECTRO: Integer; cdecl;
    {class} function _GetPOLAR_ELECTRO_EUROPE: Integer; cdecl;
    {class} function _GetPROCTER_AND_GAMBLE: Integer; cdecl;
    {class} function _GetQUALCOMM: Integer; cdecl;
    {class} function _GetQUALCOMM_CONNECTED_EXPERIENCES: Integer; cdecl;
    {class} function _GetQUALCOMM_INNOVATION_CENTER: Integer; cdecl;
    {class} function _GetQUALCOMM_LABS: Integer; cdecl;
    {class} function _GetQUALCOMM_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetQUINTIC: Integer; cdecl;
    {class} function _GetQUUPPA: Integer; cdecl;
    {class} function _GetRALINK_TECHNOLOGY: Integer; cdecl;
    {class} function _GetRDA_MICROELECTRONICS: Integer; cdecl;
    {class} function _GetREALTEK_SEMICONDUCTOR: Integer; cdecl;
    {class} function _GetRED_M: Integer; cdecl;
    {class} function _GetRENESAS_TECHNOLOGY: Integer; cdecl;
    {class} function _GetRESEARCH_IN_MOTION: Integer; cdecl;
    {class} function _GetRF_MICRO_DEVICES: Integer; cdecl;
    {class} function _GetRIVIERAWAVES: Integer; cdecl;
    {class} function _GetROHDE_AND_SCHWARZ: Integer; cdecl;
    {class} function _GetRTX_TELECOM: Integer; cdecl;
    {class} function _GetSAMSUNG_ELECTRONICS: Integer; cdecl;
    {class} function _GetSARIS_CYCLING_GROUP: Integer; cdecl;
    {class} function _GetSEERS_TECHNOLOGY: Integer; cdecl;
    {class} function _GetSEIKO_EPSON: Integer; cdecl;
    {class} function _GetSELFLY: Integer; cdecl;
    {class} function _GetSEMILINK: Integer; cdecl;
    {class} function _GetSENNHEISER_COMMUNICATIONS: Integer; cdecl;
    {class} function _GetSHANGHAI_SUPER_SMART_ELECTRONICS: Integer; cdecl;
    {class} function _GetSHENZHEN_EXCELSECU_DATA_TECHNOLOGY: Integer; cdecl;
    {class} function _GetSIGNIA_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetSILICON_WAVE: Integer; cdecl;
    {class} function _GetSIRF_TECHNOLOGY: Integer; cdecl;
    {class} function _GetSOCKET_MOBILE: Integer; cdecl;
    {class} function _GetSONY_ERICSSON: Integer; cdecl;
    {class} function _GetSOUND_ID: Integer; cdecl;
    {class} function _GetSPORTS_TRACKING_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetSR_MEDIZINELEKTRONIK: Integer; cdecl;
    {class} function _GetSTACCATO_COMMUNICATIONS: Integer; cdecl;
    {class} function _GetSTALMART_TECHNOLOGY: Integer; cdecl;
    {class} function _GetSTARKEY_LABORATORIES: Integer; cdecl;
    {class} function _GetSTOLLMAN_E_PLUS_V: Integer; cdecl;
    {class} function _GetSTONESTREET_ONE: Integer; cdecl;
    {class} function _GetST_MICROELECTRONICS: Integer; cdecl;
    {class} function _GetSUMMIT_DATA_COMMUNICATIONS: Integer; cdecl;
    {class} function _GetSUUNTO: Integer; cdecl;
    {class} function _GetSWIRL_NETWORKS: Integer; cdecl;
    {class} function _GetSYMBOL_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetSYNOPSYS: Integer; cdecl;
    {class} function _GetSYSTEMS_AND_CHIPS: Integer; cdecl;
    {class} function _GetS_POWER_ELECTRONICS: Integer; cdecl;
    {class} function _GetTAIXINGBANG_TECHNOLOGY: Integer; cdecl;
    {class} function _GetTENOVIS: Integer; cdecl;
    {class} function _GetTERAX: Integer; cdecl;
    {class} function _GetTEXAS_INSTRUMENTS: Integer; cdecl;
    {class} function _GetTHINKOPTICS: Integer; cdecl;
    {class} function _GetTHREECOM: Integer; cdecl;
    {class} function _GetTHREE_DIJOY: Integer; cdecl;
    {class} function _GetTHREE_DSP: Integer; cdecl;
    {class} function _GetTIMEKEEPING_SYSTEMS: Integer; cdecl;
    {class} function _GetTIMEX_GROUP_USA: Integer; cdecl;
    {class} function _GetTOPCORN_POSITIONING_SYSTEMS: Integer; cdecl;
    {class} function _GetTOSHIBA: Integer; cdecl;
    {class} function _GetTRANSILICA: Integer; cdecl;
    {class} function _GetTRELAB: Integer; cdecl;
    {class} function _GetTTPCOM: Integer; cdecl;
    {class} function _GetTXTR: Integer; cdecl;
    {class} function _GetTZERO_TECHNOLOGIES: Integer; cdecl;
    {class} function _GetUNIVERSAL_ELECTRONICS: Integer; cdecl;
    {class} function _GetVERTU: Integer; cdecl;
    {class} function _GetVISTEON: Integer; cdecl;
    {class} function _GetVIZIO: Integer; cdecl;
    {class} function _GetVOYETRA_TURTLE_BEACH: Integer; cdecl;
    {class} function _GetWAVEPLUS_TECHNOLOGY: Integer; cdecl;
    {class} function _GetWICENTRIC: Integer; cdecl;
    {class} function _GetWIDCOMM: Integer; cdecl;
    {class} function _GetWUXI_VIMICRO: Integer; cdecl;
    {class} function _GetZEEVO: Integer; cdecl;
    {class} function _GetZER01_TV: Integer; cdecl;
    {class} function _GetZOMM: Integer; cdecl;
    {class} function _GetZSCAN_SOFTWARE: Integer; cdecl;
    {class} property AAMP_OF_AMERICA: Integer read _GetAAMP_OF_AMERICA;
    {class} property ACCEL_SEMICONDUCTOR: Integer read _GetACCEL_SEMICONDUCTOR;
    {class} property ACE_SENSOR: Integer read _GetACE_SENSOR;
    {class} property ADIDAS: Integer read _GetADIDAS;
    {class} property ADVANCED_PANMOBIL_SYSTEMS: Integer read _GetADVANCED_PANMOBIL_SYSTEMS;
    {class} property AIROHA_TECHNOLOGY: Integer read _GetAIROHA_TECHNOLOGY;
    {class} property ALCATEL: Integer read _GetALCATEL;
    {class} property ALPWISE: Integer read _GetALPWISE;
    {class} property AMICCOM_ELECTRONICS: Integer read _GetAMICCOM_ELECTRONICS;
    {class} property APLIX: Integer read _GetAPLIX;
    {class} property APPLE: Integer read _GetAPPLE;
    {class} property APT_LICENSING: Integer read _GetAPT_LICENSING;
    {class} property ARCHOS: Integer read _GetARCHOS;
    {class} property ARP_DEVICES: Integer read _GetARP_DEVICES;
    {class} property ATHEROS_COMMUNICATIONS: Integer read _GetATHEROS_COMMUNICATIONS;
    {class} property ATMEL: Integer read _GetATMEL;
    {class} property AUSTCO_COMMUNICATION_SYSTEMS: Integer read _GetAUSTCO_COMMUNICATION_SYSTEMS;
    {class} property AUTONET_MOBILE: Integer read _GetAUTONET_MOBILE;
    {class} property AVAGO: Integer read _GetAVAGO;
    {class} property AVM_BERLIN: Integer read _GetAVM_BERLIN;
    {class} property A_AND_D_ENGINEERING: Integer read _GetA_AND_D_ENGINEERING;
    {class} property A_AND_R_CAMBRIDGE: Integer read _GetA_AND_R_CAMBRIDGE;
    {class} property BANDSPEED: Integer read _GetBANDSPEED;
    {class} property BAND_XI_INTERNATIONAL: Integer read _GetBAND_XI_INTERNATIONAL;
    {class} property BDE_TECHNOLOGY: Integer read _GetBDE_TECHNOLOGY;
    {class} property BEATS_ELECTRONICS: Integer read _GetBEATS_ELECTRONICS;
    {class} property BEAUTIFUL_ENTERPRISE: Integer read _GetBEAUTIFUL_ENTERPRISE;
    {class} property BEKEY: Integer read _GetBEKEY;
    {class} property BELKIN_INTERNATIONAL: Integer read _GetBELKIN_INTERNATIONAL;
    {class} property BINAURIC: Integer read _GetBINAURIC;
    {class} property BIOSENTRONICS: Integer read _GetBIOSENTRONICS;
    {class} property BLUEGIGA: Integer read _GetBLUEGIGA;
    {class} property BLUERADIOS: Integer read _GetBLUERADIOS;
    {class} property BLUETOOTH_SIG: Integer read _GetBLUETOOTH_SIG;
    {class} property BLUETREK_TECHNOLOGIES: Integer read _GetBLUETREK_TECHNOLOGIES;
    {class} property BOSE: Integer read _GetBOSE;
    {class} property BRIARTEK: Integer read _GetBRIARTEK;
    {class} property BROADCOM: Integer read _GetBROADCOM;
    {class} property CAEN_RFID: Integer read _GetCAEN_RFID;
    {class} property CAMBRIDGE_SILICON_RADIO: Integer read _GetCAMBRIDGE_SILICON_RADIO;
    {class} property CATC: Integer read _GetCATC;
    {class} property CINETIX: Integer read _GetCINETIX;
    {class} property CLARINOX_TECHNOLOGIES: Integer read _GetCLARINOX_TECHNOLOGIES;
    {class} property COLORFY: Integer read _GetCOLORFY;
    {class} property COMMIL: Integer read _GetCOMMIL;
    {class} property CONEXANT_SYSTEMS: Integer read _GetCONEXANT_SYSTEMS;
    {class} property CONNECTBLUE: Integer read _GetCONNECTBLUE;
    {class} property CONTINENTAL_AUTOMOTIVE: Integer read _GetCONTINENTAL_AUTOMOTIVE;
    {class} property CONWISE_TECHNOLOGY: Integer read _GetCONWISE_TECHNOLOGY;
    {class} property CREATIVE_TECHNOLOGY: Integer read _GetCREATIVE_TECHNOLOGY;
    {class} property C_TECHNOLOGIES: Integer read _GetC_TECHNOLOGIES;
    {class} property DANLERS: Integer read _GetDANLERS;
    {class} property DELORME_PUBLISHING_COMPANY: Integer read _GetDELORME_PUBLISHING_COMPANY;
    {class} property DEXCOM: Integer read _GetDEXCOM;
    {class} property DIALOG_SEMICONDUCTOR: Integer read _GetDIALOG_SEMICONDUCTOR;
    {class} property DIGIANSWER: Integer read _GetDIGIANSWER;
    {class} property ECLIPSE: Integer read _GetECLIPSE;
    {class} property ECOTEST: Integer read _GetECOTEST;
    {class} property ELGATO_SYSTEMS: Integer read _GetELGATO_SYSTEMS;
    {class} property EM_MICROELECTRONIC_MARIN: Integer read _GetEM_MICROELECTRONIC_MARIN;
    {class} property EQUINOX_AG: Integer read _GetEQUINOX_AG;
    {class} property ERICSSON_TECHNOLOGY: Integer read _GetERICSSON_TECHNOLOGY;
    {class} property EVLUMA: Integer read _GetEVLUMA;
    {class} property FREE2MOVE: Integer read _GetFREE2MOVE;
    {class} property FUNAI_ELECTRIC: Integer read _GetFUNAI_ELECTRIC;
    {class} property GARMIN_INTERNATIONAL: Integer read _GetGARMIN_INTERNATIONAL;
    {class} property GCT_SEMICONDUCTOR: Integer read _GetGCT_SEMICONDUCTOR;
    {class} property GELO: Integer read _GetGELO;
    {class} property GENEQ: Integer read _GetGENEQ;
    {class} property GENERAL_MOTORS: Integer read _GetGENERAL_MOTORS;
    {class} property GENNUM: Integer read _GetGENNUM;
    {class} property GEOFORCE: Integer read _GetGEOFORCE;
    {class} property GIBSON_GUITARS: Integer read _GetGIBSON_GUITARS;
    {class} property GN_NETCOM: Integer read _GetGN_NETCOM;
    {class} property GN_RESOUND: Integer read _GetGN_RESOUND;
    {class} property GOOGLE: Integer read _GetGOOGLE;
    {class} property GREEN_THROTTLE_GAMES: Integer read _GetGREEN_THROTTLE_GAMES;
    {class} property GROUP_SENSE: Integer read _GetGROUP_SENSE;
    {class} property HANLYNN_TECHNOLOGIES: Integer read _GetHANLYNN_TECHNOLOGIES;
    {class} property HARMAN_INTERNATIONAL: Integer read _GetHARMAN_INTERNATIONAL;
    {class} property HEWLETT_PACKARD: Integer read _GetHEWLETT_PACKARD;
    {class} property HITACHI: Integer read _GetHITACHI;
    {class} property HOSIDEN: Integer read _GetHOSIDEN;
    {class} property IBM: Integer read _GetIBM;
    {class} property INFINEON_TECHNOLOGIES: Integer read _GetINFINEON_TECHNOLOGIES;
    {class} property INGENIEUR_SYSTEMGRUPPE_ZAHN: Integer read _GetINGENIEUR_SYSTEMGRUPPE_ZAHN;
    {class} property INTEGRATED_SILICON_SOLUTION: Integer read _GetINTEGRATED_SILICON_SOLUTION;
    {class} property INTEGRATED_SYSTEM_SOLUTION: Integer read _GetINTEGRATED_SYSTEM_SOLUTION;
    {class} property INTEL: Integer read _GetINTEL;
    {class} property INVENTEL: Integer read _GetINVENTEL;
    {class} property IPEXTREME: Integer read _GetIPEXTREME;
    {class} property I_TECH_DYNAMIC_GLOBAL_DISTRIBUTION: Integer read _GetI_TECH_DYNAMIC_GLOBAL_DISTRIBUTION;
    {class} property JAWBONE: Integer read _GetJAWBONE;
    {class} property JIANGSU_TOPPOWER_AUTOMOTIVE_ELECTRONICS: Integer read _GetJIANGSU_TOPPOWER_AUTOMOTIVE_ELECTRONICS;
    {class} property JOHNSON_CONTROLS: Integer read _GetJOHNSON_CONTROLS;
    {class} property J_AND_M: Integer read _GetJ_AND_M;
    {class} property KAWANTECH: Integer read _GetKAWANTECH;
    {class} property KC_TECHNOLOGY: Integer read _GetKC_TECHNOLOGY;
    {class} property KENSINGTON_COMPUTER_PRODUCTS_GROUP: Integer read _GetKENSINGTON_COMPUTER_PRODUCTS_GROUP;
    {class} property LAIRD_TECHNOLOGIES: Integer read _GetLAIRD_TECHNOLOGIES;
    {class} property LESSWIRE: Integer read _GetLESSWIRE;
    {class} property LG_ELECTRONICS: Integer read _GetLG_ELECTRONICS;
    {class} property LINAK: Integer read _GetLINAK;
    {class} property LUCENT: Integer read _GetLUCENT;
    {class} property LUDUS_HELSINKI: Integer read _GetLUDUS_HELSINKI;
    {class} property MACRONIX: Integer read _GetMACRONIX;
    {class} property MAGNETI_MARELLI: Integer read _GetMAGNETI_MARELLI;
    {class} property MANSELLA: Integer read _GetMANSELLA;
    {class} property MARVELL: Integer read _GetMARVELL;
    {class} property MATSUSHITA_ELECTRIC: Integer read _GetMATSUSHITA_ELECTRIC;
    {class} property MC10: Integer read _GetMC10;
    {class} property MEDIATEK: Integer read _GetMEDIATEK;
    {class} property MESO_INTERNATIONAL: Integer read _GetMESO_INTERNATIONAL;
    {class} property META_WATCH: Integer read _GetMETA_WATCH;
    {class} property MEWTEL_TECHNOLOGY: Integer read _GetMEWTEL_TECHNOLOGY;
    {class} property MICOMMAND: Integer read _GetMICOMMAND;
    {class} property MICROCHIP_TECHNOLOGY: Integer read _GetMICROCHIP_TECHNOLOGY;
    {class} property MICROSOFT: Integer read _GetMICROSOFT;
    {class} property MINDTREE: Integer read _GetMINDTREE;
    {class} property MISFIT_WEARABLES: Integer read _GetMISFIT_WEARABLES;
    {class} property MITEL_SEMICONDUCTOR: Integer read _GetMITEL_SEMICONDUCTOR;
    {class} property MITSUBISHI_ELECTRIC: Integer read _GetMITSUBISHI_ELECTRIC;
    {class} property MOBILIAN_CORPORATION: Integer read _GetMOBILIAN_CORPORATION;
    {class} property MONSTER: Integer read _GetMONSTER;
    {class} property MOTOROLA: Integer read _GetMOTOROLA;
    {class} property MSTAR_SEMICONDUCTOR: Integer read _GetMSTAR_SEMICONDUCTOR;
    {class} property MUZIK: Integer read _GetMUZIK;
    {class} property NEC: Integer read _GetNEC;
    {class} property NEC_LIGHTING: Integer read _GetNEC_LIGHTING;
    {class} property NEWLOGIC: Integer read _GetNEWLOGIC;
    {class} property NIKE: Integer read _GetNIKE;
    {class} property NINE_SOLUTIONS: Integer read _GetNINE_SOLUTIONS;
    {class} property NOKIA_MOBILE_PHONES: Integer read _GetNOKIA_MOBILE_PHONES;
    {class} property NORDIC_SEMICONDUCTOR: Integer read _GetNORDIC_SEMICONDUCTOR;
    {class} property NORWOOD_SYSTEMS: Integer read _GetNORWOOD_SYSTEMS;
    {class} property ODM_TECHNOLOGY: Integer read _GetODM_TECHNOLOGY;
    {class} property OMEGAWAVE: Integer read _GetOMEGAWAVE;
    {class} property ONSET_COMPUTER: Integer read _GetONSET_COMPUTER;
    {class} property OPEN_INTERFACE: Integer read _GetOPEN_INTERFACE;
    {class} property OTL_DYNAMICS: Integer read _GetOTL_DYNAMICS;
    {class} property PANDA_OCEAN: Integer read _GetPANDA_OCEAN;
    {class} property PARROT: Integer read _GetPARROT;
    {class} property PARTHUS_TECHNOLOGIES: Integer read _GetPARTHUS_TECHNOLOGIES;
    {class} property PASSIF_SEMICONDUCTOR: Integer read _GetPASSIF_SEMICONDUCTOR;
    {class} property PETER_SYSTEMTECHNIK: Integer read _GetPETER_SYSTEMTECHNIK;
    {class} property PHILIPS_SEMICONDUCTORS: Integer read _GetPHILIPS_SEMICONDUCTORS;
    {class} property PLANTRONICS: Integer read _GetPLANTRONICS;
    {class} property POLAR_ELECTRO: Integer read _GetPOLAR_ELECTRO;
    {class} property POLAR_ELECTRO_EUROPE: Integer read _GetPOLAR_ELECTRO_EUROPE;
    {class} property PROCTER_AND_GAMBLE: Integer read _GetPROCTER_AND_GAMBLE;
    {class} property QUALCOMM: Integer read _GetQUALCOMM;
    {class} property QUALCOMM_CONNECTED_EXPERIENCES: Integer read _GetQUALCOMM_CONNECTED_EXPERIENCES;
    {class} property QUALCOMM_INNOVATION_CENTER: Integer read _GetQUALCOMM_INNOVATION_CENTER;
    {class} property QUALCOMM_LABS: Integer read _GetQUALCOMM_LABS;
    {class} property QUALCOMM_TECHNOLOGIES: Integer read _GetQUALCOMM_TECHNOLOGIES;
    {class} property QUINTIC: Integer read _GetQUINTIC;
    {class} property QUUPPA: Integer read _GetQUUPPA;
    {class} property RALINK_TECHNOLOGY: Integer read _GetRALINK_TECHNOLOGY;
    {class} property RDA_MICROELECTRONICS: Integer read _GetRDA_MICROELECTRONICS;
    {class} property REALTEK_SEMICONDUCTOR: Integer read _GetREALTEK_SEMICONDUCTOR;
    {class} property RED_M: Integer read _GetRED_M;
    {class} property RENESAS_TECHNOLOGY: Integer read _GetRENESAS_TECHNOLOGY;
    {class} property RESEARCH_IN_MOTION: Integer read _GetRESEARCH_IN_MOTION;
    {class} property RF_MICRO_DEVICES: Integer read _GetRF_MICRO_DEVICES;
    {class} property RIVIERAWAVES: Integer read _GetRIVIERAWAVES;
    {class} property ROHDE_AND_SCHWARZ: Integer read _GetROHDE_AND_SCHWARZ;
    {class} property RTX_TELECOM: Integer read _GetRTX_TELECOM;
    {class} property SAMSUNG_ELECTRONICS: Integer read _GetSAMSUNG_ELECTRONICS;
    {class} property SARIS_CYCLING_GROUP: Integer read _GetSARIS_CYCLING_GROUP;
    {class} property SEERS_TECHNOLOGY: Integer read _GetSEERS_TECHNOLOGY;
    {class} property SEIKO_EPSON: Integer read _GetSEIKO_EPSON;
    {class} property SELFLY: Integer read _GetSELFLY;
    {class} property SEMILINK: Integer read _GetSEMILINK;
    {class} property SENNHEISER_COMMUNICATIONS: Integer read _GetSENNHEISER_COMMUNICATIONS;
    {class} property SHANGHAI_SUPER_SMART_ELECTRONICS: Integer read _GetSHANGHAI_SUPER_SMART_ELECTRONICS;
    {class} property SHENZHEN_EXCELSECU_DATA_TECHNOLOGY: Integer read _GetSHENZHEN_EXCELSECU_DATA_TECHNOLOGY;
    {class} property SIGNIA_TECHNOLOGIES: Integer read _GetSIGNIA_TECHNOLOGIES;
    {class} property SILICON_WAVE: Integer read _GetSILICON_WAVE;
    {class} property SIRF_TECHNOLOGY: Integer read _GetSIRF_TECHNOLOGY;
    {class} property SOCKET_MOBILE: Integer read _GetSOCKET_MOBILE;
    {class} property SONY_ERICSSON: Integer read _GetSONY_ERICSSON;
    {class} property SOUND_ID: Integer read _GetSOUND_ID;
    {class} property SPORTS_TRACKING_TECHNOLOGIES: Integer read _GetSPORTS_TRACKING_TECHNOLOGIES;
    {class} property SR_MEDIZINELEKTRONIK: Integer read _GetSR_MEDIZINELEKTRONIK;
    {class} property STACCATO_COMMUNICATIONS: Integer read _GetSTACCATO_COMMUNICATIONS;
    {class} property STALMART_TECHNOLOGY: Integer read _GetSTALMART_TECHNOLOGY;
    {class} property STARKEY_LABORATORIES: Integer read _GetSTARKEY_LABORATORIES;
    {class} property STOLLMAN_E_PLUS_V: Integer read _GetSTOLLMAN_E_PLUS_V;
    {class} property STONESTREET_ONE: Integer read _GetSTONESTREET_ONE;
    {class} property ST_MICROELECTRONICS: Integer read _GetST_MICROELECTRONICS;
    {class} property SUMMIT_DATA_COMMUNICATIONS: Integer read _GetSUMMIT_DATA_COMMUNICATIONS;
    {class} property SUUNTO: Integer read _GetSUUNTO;
    {class} property SWIRL_NETWORKS: Integer read _GetSWIRL_NETWORKS;
    {class} property SYMBOL_TECHNOLOGIES: Integer read _GetSYMBOL_TECHNOLOGIES;
    {class} property SYNOPSYS: Integer read _GetSYNOPSYS;
    {class} property SYSTEMS_AND_CHIPS: Integer read _GetSYSTEMS_AND_CHIPS;
    {class} property S_POWER_ELECTRONICS: Integer read _GetS_POWER_ELECTRONICS;
    {class} property TAIXINGBANG_TECHNOLOGY: Integer read _GetTAIXINGBANG_TECHNOLOGY;
    {class} property TENOVIS: Integer read _GetTENOVIS;
    {class} property TERAX: Integer read _GetTERAX;
    {class} property TEXAS_INSTRUMENTS: Integer read _GetTEXAS_INSTRUMENTS;
    {class} property THINKOPTICS: Integer read _GetTHINKOPTICS;
    {class} property THREECOM: Integer read _GetTHREECOM;
    {class} property THREE_DIJOY: Integer read _GetTHREE_DIJOY;
    {class} property THREE_DSP: Integer read _GetTHREE_DSP;
    {class} property TIMEKEEPING_SYSTEMS: Integer read _GetTIMEKEEPING_SYSTEMS;
    {class} property TIMEX_GROUP_USA: Integer read _GetTIMEX_GROUP_USA;
    {class} property TOPCORN_POSITIONING_SYSTEMS: Integer read _GetTOPCORN_POSITIONING_SYSTEMS;
    {class} property TOSHIBA: Integer read _GetTOSHIBA;
    {class} property TRANSILICA: Integer read _GetTRANSILICA;
    {class} property TRELAB: Integer read _GetTRELAB;
    {class} property TTPCOM: Integer read _GetTTPCOM;
    {class} property TXTR: Integer read _GetTXTR;
    {class} property TZERO_TECHNOLOGIES: Integer read _GetTZERO_TECHNOLOGIES;
    {class} property UNIVERSAL_ELECTRONICS: Integer read _GetUNIVERSAL_ELECTRONICS;
    {class} property VERTU: Integer read _GetVERTU;
    {class} property VISTEON: Integer read _GetVISTEON;
    {class} property VIZIO: Integer read _GetVIZIO;
    {class} property VOYETRA_TURTLE_BEACH: Integer read _GetVOYETRA_TURTLE_BEACH;
    {class} property WAVEPLUS_TECHNOLOGY: Integer read _GetWAVEPLUS_TECHNOLOGY;
    {class} property WICENTRIC: Integer read _GetWICENTRIC;
    {class} property WIDCOMM: Integer read _GetWIDCOMM;
    {class} property WUXI_VIMICRO: Integer read _GetWUXI_VIMICRO;
    {class} property ZEEVO: Integer read _GetZEEVO;
    {class} property ZER01_TV: Integer read _GetZER01_TV;
    {class} property ZOMM: Integer read _GetZOMM;
    {class} property ZSCAN_SOFTWARE: Integer read _GetZSCAN_SOFTWARE;
  end;

  [JavaSignature('android/bluetooth/BluetoothAssignedNumbers')]
  JBluetoothAssignedNumbers = interface(JObject)
    ['{FD73BBEE-B1E1-4F52-AF25-AC98D94FA319}']
  end;
  TJBluetoothAssignedNumbers = class(TJavaGenericImport<JBluetoothAssignedNumbersClass, JBluetoothAssignedNumbers>) end;

  Jbluetooth_BluetoothClassClass = interface(JObjectClass)
    ['{FF258AE0-A7F8-4869-B4F6-F061D1AE1264}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/bluetooth/BluetoothClass')]
  Jbluetooth_BluetoothClass = interface(JObject)
    ['{5B43837A-0671-4D08-9885-EA58330D393E}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getDeviceClass: Integer; cdecl;
    function getMajorDeviceClass: Integer; cdecl;
    function hasService(service: Integer): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJbluetooth_BluetoothClass = class(TJavaGenericImport<Jbluetooth_BluetoothClassClass, Jbluetooth_BluetoothClass>) end;

  JBluetoothClass_DeviceClass = interface(JObjectClass)
    ['{38E343FC-1BF6-439D-96B5-C71B4B066930}']
    {class} function _GetAUDIO_VIDEO_CAMCORDER: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_CAR_AUDIO: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_HANDSFREE: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_HEADPHONES: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_HIFI_AUDIO: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_LOUDSPEAKER: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_MICROPHONE: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_PORTABLE_AUDIO: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_SET_TOP_BOX: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_UNCATEGORIZED: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_VCR: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_VIDEO_CAMERA: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_VIDEO_CONFERENCING: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_VIDEO_DISPLAY_AND_LOUDSPEAKER: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_VIDEO_GAMING_TOY: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_VIDEO_MONITOR: Integer; cdecl;
    {class} function _GetAUDIO_VIDEO_WEARABLE_HEADSET: Integer; cdecl;
    {class} function _GetCOMPUTER_DESKTOP: Integer; cdecl;
    {class} function _GetCOMPUTER_HANDHELD_PC_PDA: Integer; cdecl;
    {class} function _GetCOMPUTER_LAPTOP: Integer; cdecl;
    {class} function _GetCOMPUTER_PALM_SIZE_PC_PDA: Integer; cdecl;
    {class} function _GetCOMPUTER_SERVER: Integer; cdecl;
    {class} function _GetCOMPUTER_UNCATEGORIZED: Integer; cdecl;
    {class} function _GetCOMPUTER_WEARABLE: Integer; cdecl;
    {class} function _GetHEALTH_BLOOD_PRESSURE: Integer; cdecl;
    {class} function _GetHEALTH_DATA_DISPLAY: Integer; cdecl;
    {class} function _GetHEALTH_GLUCOSE: Integer; cdecl;
    {class} function _GetHEALTH_PULSE_OXIMETER: Integer; cdecl;
    {class} function _GetHEALTH_PULSE_RATE: Integer; cdecl;
    {class} function _GetHEALTH_THERMOMETER: Integer; cdecl;
    {class} function _GetHEALTH_UNCATEGORIZED: Integer; cdecl;
    {class} function _GetHEALTH_WEIGHING: Integer; cdecl;
    {class} function _GetPHONE_CELLULAR: Integer; cdecl;
    {class} function _GetPHONE_CORDLESS: Integer; cdecl;
    {class} function _GetPHONE_ISDN: Integer; cdecl;
    {class} function _GetPHONE_MODEM_OR_GATEWAY: Integer; cdecl;
    {class} function _GetPHONE_SMART: Integer; cdecl;
    {class} function _GetPHONE_UNCATEGORIZED: Integer; cdecl;
    {class} function _GetTOY_CONTROLLER: Integer; cdecl;
    {class} function _GetTOY_DOLL_ACTION_FIGURE: Integer; cdecl;
    {class} function _GetTOY_GAME: Integer; cdecl;
    {class} function _GetTOY_ROBOT: Integer; cdecl;
    {class} function _GetTOY_UNCATEGORIZED: Integer; cdecl;
    {class} function _GetTOY_VEHICLE: Integer; cdecl;
    {class} function _GetWEARABLE_GLASSES: Integer; cdecl;
    {class} function _GetWEARABLE_HELMET: Integer; cdecl;
    {class} function _GetWEARABLE_JACKET: Integer; cdecl;
    {class} function _GetWEARABLE_PAGER: Integer; cdecl;
    {class} function _GetWEARABLE_UNCATEGORIZED: Integer; cdecl;
    {class} function _GetWEARABLE_WRIST_WATCH: Integer; cdecl;
    {class} function init: JBluetoothClass_Device; cdecl;
    {class} property AUDIO_VIDEO_CAMCORDER: Integer read _GetAUDIO_VIDEO_CAMCORDER;
    {class} property AUDIO_VIDEO_CAR_AUDIO: Integer read _GetAUDIO_VIDEO_CAR_AUDIO;
    {class} property AUDIO_VIDEO_HANDSFREE: Integer read _GetAUDIO_VIDEO_HANDSFREE;
    {class} property AUDIO_VIDEO_HEADPHONES: Integer read _GetAUDIO_VIDEO_HEADPHONES;
    {class} property AUDIO_VIDEO_HIFI_AUDIO: Integer read _GetAUDIO_VIDEO_HIFI_AUDIO;
    {class} property AUDIO_VIDEO_LOUDSPEAKER: Integer read _GetAUDIO_VIDEO_LOUDSPEAKER;
    {class} property AUDIO_VIDEO_MICROPHONE: Integer read _GetAUDIO_VIDEO_MICROPHONE;
    {class} property AUDIO_VIDEO_PORTABLE_AUDIO: Integer read _GetAUDIO_VIDEO_PORTABLE_AUDIO;
    {class} property AUDIO_VIDEO_SET_TOP_BOX: Integer read _GetAUDIO_VIDEO_SET_TOP_BOX;
    {class} property AUDIO_VIDEO_UNCATEGORIZED: Integer read _GetAUDIO_VIDEO_UNCATEGORIZED;
    {class} property AUDIO_VIDEO_VCR: Integer read _GetAUDIO_VIDEO_VCR;
    {class} property AUDIO_VIDEO_VIDEO_CAMERA: Integer read _GetAUDIO_VIDEO_VIDEO_CAMERA;
    {class} property AUDIO_VIDEO_VIDEO_CONFERENCING: Integer read _GetAUDIO_VIDEO_VIDEO_CONFERENCING;
    {class} property AUDIO_VIDEO_VIDEO_DISPLAY_AND_LOUDSPEAKER: Integer read _GetAUDIO_VIDEO_VIDEO_DISPLAY_AND_LOUDSPEAKER;
    {class} property AUDIO_VIDEO_VIDEO_GAMING_TOY: Integer read _GetAUDIO_VIDEO_VIDEO_GAMING_TOY;
    {class} property AUDIO_VIDEO_VIDEO_MONITOR: Integer read _GetAUDIO_VIDEO_VIDEO_MONITOR;
    {class} property AUDIO_VIDEO_WEARABLE_HEADSET: Integer read _GetAUDIO_VIDEO_WEARABLE_HEADSET;
    {class} property COMPUTER_DESKTOP: Integer read _GetCOMPUTER_DESKTOP;
    {class} property COMPUTER_HANDHELD_PC_PDA: Integer read _GetCOMPUTER_HANDHELD_PC_PDA;
    {class} property COMPUTER_LAPTOP: Integer read _GetCOMPUTER_LAPTOP;
    {class} property COMPUTER_PALM_SIZE_PC_PDA: Integer read _GetCOMPUTER_PALM_SIZE_PC_PDA;
    {class} property COMPUTER_SERVER: Integer read _GetCOMPUTER_SERVER;
    {class} property COMPUTER_UNCATEGORIZED: Integer read _GetCOMPUTER_UNCATEGORIZED;
    {class} property COMPUTER_WEARABLE: Integer read _GetCOMPUTER_WEARABLE;
    {class} property HEALTH_BLOOD_PRESSURE: Integer read _GetHEALTH_BLOOD_PRESSURE;
    {class} property HEALTH_DATA_DISPLAY: Integer read _GetHEALTH_DATA_DISPLAY;
    {class} property HEALTH_GLUCOSE: Integer read _GetHEALTH_GLUCOSE;
    {class} property HEALTH_PULSE_OXIMETER: Integer read _GetHEALTH_PULSE_OXIMETER;
    {class} property HEALTH_PULSE_RATE: Integer read _GetHEALTH_PULSE_RATE;
    {class} property HEALTH_THERMOMETER: Integer read _GetHEALTH_THERMOMETER;
    {class} property HEALTH_UNCATEGORIZED: Integer read _GetHEALTH_UNCATEGORIZED;
    {class} property HEALTH_WEIGHING: Integer read _GetHEALTH_WEIGHING;
    {class} property PHONE_CELLULAR: Integer read _GetPHONE_CELLULAR;
    {class} property PHONE_CORDLESS: Integer read _GetPHONE_CORDLESS;
    {class} property PHONE_ISDN: Integer read _GetPHONE_ISDN;
    {class} property PHONE_MODEM_OR_GATEWAY: Integer read _GetPHONE_MODEM_OR_GATEWAY;
    {class} property PHONE_SMART: Integer read _GetPHONE_SMART;
    {class} property PHONE_UNCATEGORIZED: Integer read _GetPHONE_UNCATEGORIZED;
    {class} property TOY_CONTROLLER: Integer read _GetTOY_CONTROLLER;
    {class} property TOY_DOLL_ACTION_FIGURE: Integer read _GetTOY_DOLL_ACTION_FIGURE;
    {class} property TOY_GAME: Integer read _GetTOY_GAME;
    {class} property TOY_ROBOT: Integer read _GetTOY_ROBOT;
    {class} property TOY_UNCATEGORIZED: Integer read _GetTOY_UNCATEGORIZED;
    {class} property TOY_VEHICLE: Integer read _GetTOY_VEHICLE;
    {class} property WEARABLE_GLASSES: Integer read _GetWEARABLE_GLASSES;
    {class} property WEARABLE_HELMET: Integer read _GetWEARABLE_HELMET;
    {class} property WEARABLE_JACKET: Integer read _GetWEARABLE_JACKET;
    {class} property WEARABLE_PAGER: Integer read _GetWEARABLE_PAGER;
    {class} property WEARABLE_UNCATEGORIZED: Integer read _GetWEARABLE_UNCATEGORIZED;
    {class} property WEARABLE_WRIST_WATCH: Integer read _GetWEARABLE_WRIST_WATCH;
  end;

  [JavaSignature('android/bluetooth/BluetoothClass$Device')]
  JBluetoothClass_Device = interface(JObject)
    ['{075C1041-C493-488E-A668-5D470339A25B}']
  end;
  TJBluetoothClass_Device = class(TJavaGenericImport<JBluetoothClass_DeviceClass, JBluetoothClass_Device>) end;

  JDevice_MajorClass = interface(JObjectClass)
    ['{5C10CF59-50A2-4C87-B8D9-0BEC242F190C}']
    {class} function _GetAUDIO_VIDEO: Integer; cdecl;
    {class} function _GetCOMPUTER: Integer; cdecl;
    {class} function _GetHEALTH: Integer; cdecl;
    {class} function _GetIMAGING: Integer; cdecl;
    {class} function _GetMISC: Integer; cdecl;
    {class} function _GetNETWORKING: Integer; cdecl;
    {class} function _GetPERIPHERAL: Integer; cdecl;
    {class} function _GetPHONE: Integer; cdecl;
    {class} function _GetTOY: Integer; cdecl;
    {class} function _GetUNCATEGORIZED: Integer; cdecl;
    {class} function _GetWEARABLE: Integer; cdecl;
    {class} function init: JDevice_Major; cdecl;
    {class} property AUDIO_VIDEO: Integer read _GetAUDIO_VIDEO;
    {class} property COMPUTER: Integer read _GetCOMPUTER;
    {class} property HEALTH: Integer read _GetHEALTH;
    {class} property IMAGING: Integer read _GetIMAGING;
    {class} property MISC: Integer read _GetMISC;
    {class} property NETWORKING: Integer read _GetNETWORKING;
    {class} property PERIPHERAL: Integer read _GetPERIPHERAL;
    {class} property PHONE: Integer read _GetPHONE;
    {class} property TOY: Integer read _GetTOY;
    {class} property UNCATEGORIZED: Integer read _GetUNCATEGORIZED;
    {class} property WEARABLE: Integer read _GetWEARABLE;
  end;

  [JavaSignature('android/bluetooth/BluetoothClass$Device$Major')]
  JDevice_Major = interface(JObject)
    ['{3BF5E3F7-14A8-4940-AA15-4E41858E41CE}']
  end;
  TJDevice_Major = class(TJavaGenericImport<JDevice_MajorClass, JDevice_Major>) end;

  JBluetoothClass_ServiceClass = interface(JObjectClass)
    ['{119150F9-9A31-46EE-871B-8DB6BDD19F17}']
    {class} function _GetAUDIO: Integer; cdecl;
    {class} function _GetCAPTURE: Integer; cdecl;
    {class} function _GetINFORMATION: Integer; cdecl;
    {class} function _GetLIMITED_DISCOVERABILITY: Integer; cdecl;
    {class} function _GetNETWORKING: Integer; cdecl;
    {class} function _GetOBJECT_TRANSFER: Integer; cdecl;
    {class} function _GetPOSITIONING: Integer; cdecl;
    {class} function _GetRENDER: Integer; cdecl;
    {class} function _GetTELEPHONY: Integer; cdecl;
    {class} function init: JBluetoothClass_Service; cdecl;
    {class} property AUDIO: Integer read _GetAUDIO;
    {class} property CAPTURE: Integer read _GetCAPTURE;
    {class} property INFORMATION: Integer read _GetINFORMATION;
    {class} property LIMITED_DISCOVERABILITY: Integer read _GetLIMITED_DISCOVERABILITY;
    {class} property NETWORKING: Integer read _GetNETWORKING;
    {class} property OBJECT_TRANSFER: Integer read _GetOBJECT_TRANSFER;
    {class} property POSITIONING: Integer read _GetPOSITIONING;
    {class} property RENDER: Integer read _GetRENDER;
    {class} property TELEPHONY: Integer read _GetTELEPHONY;
  end;

  [JavaSignature('android/bluetooth/BluetoothClass$Service')]
  JBluetoothClass_Service = interface(JObject)
    ['{DD0314CB-EE35-4535-81CB-71F4D9E149E9}']
  end;
  TJBluetoothClass_Service = class(TJavaGenericImport<JBluetoothClass_ServiceClass, JBluetoothClass_Service>) end;

  JBluetoothDeviceClass = interface(JObjectClass)
    ['{E230F5F8-B398-45A4-8872-9157EBB23736}']
    {class} function _GetACTION_ACL_CONNECTED: JString; cdecl;
    {class} function _GetACTION_ACL_DISCONNECTED: JString; cdecl;
    {class} function _GetACTION_ACL_DISCONNECT_REQUESTED: JString; cdecl;
    {class} function _GetACTION_BOND_STATE_CHANGED: JString; cdecl;
    {class} function _GetACTION_CLASS_CHANGED: JString; cdecl;
    {class} function _GetACTION_FOUND: JString; cdecl;
    {class} function _GetACTION_NAME_CHANGED: JString; cdecl;
    {class} function _GetACTION_PAIRING_REQUEST: JString; cdecl;
    {class} function _GetACTION_UUID: JString; cdecl;
    {class} function _GetBOND_BONDED: Integer; cdecl;
    {class} function _GetBOND_BONDING: Integer; cdecl;
    {class} function _GetBOND_NONE: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetDEVICE_TYPE_CLASSIC: Integer; cdecl;
    {class} function _GetDEVICE_TYPE_DUAL: Integer; cdecl;
    {class} function _GetDEVICE_TYPE_LE: Integer; cdecl;
    {class} function _GetDEVICE_TYPE_UNKNOWN: Integer; cdecl;
    {class} function _GetERROR: Integer; cdecl;
    {class} function _GetEXTRA_BOND_STATE: JString; cdecl;
    {class} function _GetEXTRA_CLASS: JString; cdecl;
    {class} function _GetEXTRA_DEVICE: JString; cdecl;
    {class} function _GetEXTRA_NAME: JString; cdecl;
    {class} function _GetEXTRA_PAIRING_KEY: JString; cdecl;
    {class} function _GetEXTRA_PAIRING_VARIANT: JString; cdecl;
    {class} function _GetEXTRA_PREVIOUS_BOND_STATE: JString; cdecl;
    {class} function _GetEXTRA_RSSI: JString; cdecl;
    {class} function _GetEXTRA_UUID: JString; cdecl;
    {class} function _GetPAIRING_VARIANT_PASSKEY_CONFIRMATION: Integer; cdecl;
    {class} function _GetPAIRING_VARIANT_PIN: Integer; cdecl;
    {class} property ACTION_ACL_CONNECTED: JString read _GetACTION_ACL_CONNECTED;
    {class} property ACTION_ACL_DISCONNECTED: JString read _GetACTION_ACL_DISCONNECTED;
    {class} property ACTION_ACL_DISCONNECT_REQUESTED: JString read _GetACTION_ACL_DISCONNECT_REQUESTED;
    {class} property ACTION_BOND_STATE_CHANGED: JString read _GetACTION_BOND_STATE_CHANGED;
    {class} property ACTION_CLASS_CHANGED: JString read _GetACTION_CLASS_CHANGED;
    {class} property ACTION_FOUND: JString read _GetACTION_FOUND;
    {class} property ACTION_NAME_CHANGED: JString read _GetACTION_NAME_CHANGED;
    {class} property ACTION_PAIRING_REQUEST: JString read _GetACTION_PAIRING_REQUEST;
    {class} property ACTION_UUID: JString read _GetACTION_UUID;
    {class} property BOND_BONDED: Integer read _GetBOND_BONDED;
    {class} property BOND_BONDING: Integer read _GetBOND_BONDING;
    {class} property BOND_NONE: Integer read _GetBOND_NONE;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property DEVICE_TYPE_CLASSIC: Integer read _GetDEVICE_TYPE_CLASSIC;
    {class} property DEVICE_TYPE_DUAL: Integer read _GetDEVICE_TYPE_DUAL;
    {class} property DEVICE_TYPE_LE: Integer read _GetDEVICE_TYPE_LE;
    {class} property DEVICE_TYPE_UNKNOWN: Integer read _GetDEVICE_TYPE_UNKNOWN;
    {class} property ERROR: Integer read _GetERROR;
    {class} property EXTRA_BOND_STATE: JString read _GetEXTRA_BOND_STATE;
    {class} property EXTRA_CLASS: JString read _GetEXTRA_CLASS;
    {class} property EXTRA_DEVICE: JString read _GetEXTRA_DEVICE;
    {class} property EXTRA_NAME: JString read _GetEXTRA_NAME;
    {class} property EXTRA_PAIRING_KEY: JString read _GetEXTRA_PAIRING_KEY;
    {class} property EXTRA_PAIRING_VARIANT: JString read _GetEXTRA_PAIRING_VARIANT;
    {class} property EXTRA_PREVIOUS_BOND_STATE: JString read _GetEXTRA_PREVIOUS_BOND_STATE;
    {class} property EXTRA_RSSI: JString read _GetEXTRA_RSSI;
    {class} property EXTRA_UUID: JString read _GetEXTRA_UUID;
    {class} property PAIRING_VARIANT_PASSKEY_CONFIRMATION: Integer read _GetPAIRING_VARIANT_PASSKEY_CONFIRMATION;
    {class} property PAIRING_VARIANT_PIN: Integer read _GetPAIRING_VARIANT_PIN;
  end;

  [JavaSignature('android/bluetooth/BluetoothDevice')]
  JBluetoothDevice = interface(JObject)
    ['{1B2DF3AB-7AE0-4EC2-A9AC-94FCFB33FAEA}']
    function connectGatt(context: JContext; autoConnect: Boolean; callback: JBluetoothGattCallback): JBluetoothGatt; cdecl;
    function createBond: Boolean; cdecl;
    function createRfcommSocket(channel: Integer): JBluetoothSocket; cdecl;
    function createInsecureRfcommSocket(channel: Integer): JBluetoothSocket; cdecl;
    function createInsecureRfcommSocketToServiceRecord(uuid: JUUID): JBluetoothSocket; cdecl;
    function createRfcommSocketToServiceRecord(uuid: JUUID): JBluetoothSocket; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function fetchUuidsWithSdp: Boolean; cdecl;
    function getAddress: JString; cdecl;
    function getBluetoothClass: Jbluetooth_BluetoothClass; cdecl;
    function getBondState: Integer; cdecl;
    function getName: JString; cdecl;
    function getType: Integer; cdecl;
    function getUuids: TJavaObjectArray<JParcelUuid>; cdecl;
    function hashCode: Integer; cdecl;
    function setPairingConfirmation(confirm: Boolean): Boolean; cdecl;
    function setPin(pin: TJavaArray<Byte>): Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJBluetoothDevice = class(TJavaGenericImport<JBluetoothDeviceClass, JBluetoothDevice>) end;

  JBluetoothGattClass = interface(JObjectClass)
    ['{1AF3FF11-8E2B-4F62-9634-1027DF298C9C}']
    {class} function _GetCONNECTION_PRIORITY_BALANCED: Integer; cdecl;
    {class} function _GetCONNECTION_PRIORITY_HIGH: Integer; cdecl;
    {class} function _GetCONNECTION_PRIORITY_LOW_POWER: Integer; cdecl;
    {class} function _GetGATT_CONNECTION_CONGESTED: Integer; cdecl;
    {class} function _GetGATT_FAILURE: Integer; cdecl;
    {class} function _GetGATT_INSUFFICIENT_AUTHENTICATION: Integer; cdecl;
    {class} function _GetGATT_INSUFFICIENT_ENCRYPTION: Integer; cdecl;
    {class} function _GetGATT_INVALID_ATTRIBUTE_LENGTH: Integer; cdecl;
    {class} function _GetGATT_INVALID_OFFSET: Integer; cdecl;
    {class} function _GetGATT_READ_NOT_PERMITTED: Integer; cdecl;
    {class} function _GetGATT_REQUEST_NOT_SUPPORTED: Integer; cdecl;
    {class} function _GetGATT_SUCCESS: Integer; cdecl;
    {class} function _GetGATT_WRITE_NOT_PERMITTED: Integer; cdecl;
    {class} property CONNECTION_PRIORITY_BALANCED: Integer read _GetCONNECTION_PRIORITY_BALANCED;
    {class} property CONNECTION_PRIORITY_HIGH: Integer read _GetCONNECTION_PRIORITY_HIGH;
    {class} property CONNECTION_PRIORITY_LOW_POWER: Integer read _GetCONNECTION_PRIORITY_LOW_POWER;
    {class} property GATT_CONNECTION_CONGESTED: Integer read _GetGATT_CONNECTION_CONGESTED;
    {class} property GATT_FAILURE: Integer read _GetGATT_FAILURE;
    {class} property GATT_INSUFFICIENT_AUTHENTICATION: Integer read _GetGATT_INSUFFICIENT_AUTHENTICATION;
    {class} property GATT_INSUFFICIENT_ENCRYPTION: Integer read _GetGATT_INSUFFICIENT_ENCRYPTION;
    {class} property GATT_INVALID_ATTRIBUTE_LENGTH: Integer read _GetGATT_INVALID_ATTRIBUTE_LENGTH;
    {class} property GATT_INVALID_OFFSET: Integer read _GetGATT_INVALID_OFFSET;
    {class} property GATT_READ_NOT_PERMITTED: Integer read _GetGATT_READ_NOT_PERMITTED;
    {class} property GATT_REQUEST_NOT_SUPPORTED: Integer read _GetGATT_REQUEST_NOT_SUPPORTED;
    {class} property GATT_SUCCESS: Integer read _GetGATT_SUCCESS;
    {class} property GATT_WRITE_NOT_PERMITTED: Integer read _GetGATT_WRITE_NOT_PERMITTED;
  end;

  [JavaSignature('android/bluetooth/BluetoothGatt')]
  JBluetoothGatt = interface(JObject)
    ['{2219308F-B680-4E5A-BF4A-F0B25B3DB5F9}']
    procedure abortReliableWrite; cdecl; overload;
    procedure abortReliableWrite(mDevice: JBluetoothDevice); cdecl; overload;//Deprecated
    function beginReliableWrite: Boolean; cdecl;
    procedure close; cdecl;
    function connect: Boolean; cdecl;
    procedure disconnect; cdecl;
    function discoverServices: Boolean; cdecl;
    function executeReliableWrite: Boolean; cdecl;
    function getConnectedDevices: JList; cdecl;
    function getConnectionState(device: JBluetoothDevice): Integer; cdecl;
    function getDevice: JBluetoothDevice; cdecl;
    function getDevicesMatchingConnectionStates(states: TJavaArray<Integer>): JList; cdecl;
    function getService(uuid: JUUID): JBluetoothGattService; cdecl;
    function getServices: JList; cdecl;
    function readCharacteristic(characteristic: JBluetoothGattCharacteristic): Boolean; cdecl;
    function readDescriptor(descriptor: JBluetoothGattDescriptor): Boolean; cdecl;
    function readRemoteRssi: Boolean; cdecl;
    function requestConnectionPriority(connectionPriority: Integer): Boolean; cdecl;
    function requestMtu(mtu: Integer): Boolean; cdecl;
    function setCharacteristicNotification(characteristic: JBluetoothGattCharacteristic; enable: Boolean): Boolean; cdecl;
    function writeCharacteristic(characteristic: JBluetoothGattCharacteristic): Boolean; cdecl;
    function writeDescriptor(descriptor: JBluetoothGattDescriptor): Boolean; cdecl;
    // refresh method handy added, public but hidden api method.
    function refresh: Boolean; cdecl;
  end;
  TJBluetoothGatt = class(TJavaGenericImport<JBluetoothGattClass, JBluetoothGatt>) end;

  JBluetoothGattCallbackClass = interface(JObjectClass)
    ['{2E94E69F-765D-47FC-A45C-62182F73CF9B}']
    {class} function init: JBluetoothGattCallback; cdecl;
  end;

  [JavaSignature('android/bluetooth/BluetoothGattCallback')]
  JBluetoothGattCallback = interface(JObject)
    ['{E07848AC-B968-4C94-9F67-4DC5E62CB8D3}']
    procedure onCharacteristicChanged(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic); cdecl;
    procedure onCharacteristicRead(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic; status: Integer); cdecl;
    procedure onCharacteristicWrite(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic; status: Integer); cdecl;
    procedure onConnectionStateChange(gatt: JBluetoothGatt; status: Integer; newState: Integer); cdecl;
    procedure onDescriptorRead(gatt: JBluetoothGatt; descriptor: JBluetoothGattDescriptor; status: Integer); cdecl;
    procedure onDescriptorWrite(gatt: JBluetoothGatt; descriptor: JBluetoothGattDescriptor; status: Integer); cdecl;
    procedure onMtuChanged(gatt: JBluetoothGatt; mtu: Integer; status: Integer); cdecl;
    procedure onReadRemoteRssi(gatt: JBluetoothGatt; rssi: Integer; status: Integer); cdecl;
    procedure onReliableWriteCompleted(gatt: JBluetoothGatt; status: Integer); cdecl;
    procedure onServicesDiscovered(gatt: JBluetoothGatt; status: Integer); cdecl;
  end;
  TJBluetoothGattCallback = class(TJavaGenericImport<JBluetoothGattCallbackClass, JBluetoothGattCallback>) end;

  JBluetoothGattCharacteristicClass = interface(JObjectClass)
    ['{3BA3788A-A058-43CA-BFE1-BB06896EA7FD}']
    {class} function _GetFORMAT_FLOAT: Integer; cdecl;
    {class} function _GetFORMAT_SFLOAT: Integer; cdecl;
    {class} function _GetFORMAT_SINT16: Integer; cdecl;
    {class} function _GetFORMAT_SINT32: Integer; cdecl;
    {class} function _GetFORMAT_SINT8: Integer; cdecl;
    {class} function _GetFORMAT_UINT16: Integer; cdecl;
    {class} function _GetFORMAT_UINT32: Integer; cdecl;
    {class} function _GetFORMAT_UINT8: Integer; cdecl;
    {class} function _GetPERMISSION_READ: Integer; cdecl;
    {class} function _GetPERMISSION_READ_ENCRYPTED: Integer; cdecl;
    {class} function _GetPERMISSION_READ_ENCRYPTED_MITM: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE_ENCRYPTED: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE_ENCRYPTED_MITM: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE_SIGNED: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE_SIGNED_MITM: Integer; cdecl;
    {class} function _GetPROPERTY_BROADCAST: Integer; cdecl;
    {class} function _GetPROPERTY_EXTENDED_PROPS: Integer; cdecl;
    {class} function _GetPROPERTY_INDICATE: Integer; cdecl;
    {class} function _GetPROPERTY_NOTIFY: Integer; cdecl;
    {class} function _GetPROPERTY_READ: Integer; cdecl;
    {class} function _GetPROPERTY_SIGNED_WRITE: Integer; cdecl;
    {class} function _GetPROPERTY_WRITE: Integer; cdecl;
    {class} function _GetPROPERTY_WRITE_NO_RESPONSE: Integer; cdecl;
    {class} function _GetWRITE_TYPE_DEFAULT: Integer; cdecl;
    {class} function _GetWRITE_TYPE_NO_RESPONSE: Integer; cdecl;
    {class} function _GetWRITE_TYPE_SIGNED: Integer; cdecl;
    {class} function init(uuid: JUUID; properties: Integer; permissions: Integer): JBluetoothGattCharacteristic; cdecl;
    {class} property FORMAT_FLOAT: Integer read _GetFORMAT_FLOAT;
    {class} property FORMAT_SFLOAT: Integer read _GetFORMAT_SFLOAT;
    {class} property FORMAT_SINT16: Integer read _GetFORMAT_SINT16;
    {class} property FORMAT_SINT32: Integer read _GetFORMAT_SINT32;
    {class} property FORMAT_SINT8: Integer read _GetFORMAT_SINT8;
    {class} property FORMAT_UINT16: Integer read _GetFORMAT_UINT16;
    {class} property FORMAT_UINT32: Integer read _GetFORMAT_UINT32;
    {class} property FORMAT_UINT8: Integer read _GetFORMAT_UINT8;
    {class} property PERMISSION_READ: Integer read _GetPERMISSION_READ;
    {class} property PERMISSION_READ_ENCRYPTED: Integer read _GetPERMISSION_READ_ENCRYPTED;
    {class} property PERMISSION_READ_ENCRYPTED_MITM: Integer read _GetPERMISSION_READ_ENCRYPTED_MITM;
    {class} property PERMISSION_WRITE: Integer read _GetPERMISSION_WRITE;
    {class} property PERMISSION_WRITE_ENCRYPTED: Integer read _GetPERMISSION_WRITE_ENCRYPTED;
    {class} property PERMISSION_WRITE_ENCRYPTED_MITM: Integer read _GetPERMISSION_WRITE_ENCRYPTED_MITM;
    {class} property PERMISSION_WRITE_SIGNED: Integer read _GetPERMISSION_WRITE_SIGNED;
    {class} property PERMISSION_WRITE_SIGNED_MITM: Integer read _GetPERMISSION_WRITE_SIGNED_MITM;
    {class} property PROPERTY_BROADCAST: Integer read _GetPROPERTY_BROADCAST;
    {class} property PROPERTY_EXTENDED_PROPS: Integer read _GetPROPERTY_EXTENDED_PROPS;
    {class} property PROPERTY_INDICATE: Integer read _GetPROPERTY_INDICATE;
    {class} property PROPERTY_NOTIFY: Integer read _GetPROPERTY_NOTIFY;
    {class} property PROPERTY_READ: Integer read _GetPROPERTY_READ;
    {class} property PROPERTY_SIGNED_WRITE: Integer read _GetPROPERTY_SIGNED_WRITE;
    {class} property PROPERTY_WRITE: Integer read _GetPROPERTY_WRITE;
    {class} property PROPERTY_WRITE_NO_RESPONSE: Integer read _GetPROPERTY_WRITE_NO_RESPONSE;
    {class} property WRITE_TYPE_DEFAULT: Integer read _GetWRITE_TYPE_DEFAULT;
    {class} property WRITE_TYPE_NO_RESPONSE: Integer read _GetWRITE_TYPE_NO_RESPONSE;
    {class} property WRITE_TYPE_SIGNED: Integer read _GetWRITE_TYPE_SIGNED;
  end;

  [JavaSignature('android/bluetooth/BluetoothGattCharacteristic')]
  JBluetoothGattCharacteristic = interface(JObject)
    ['{BB707DD3-B74D-4B10-9BD0-C53E4D63FC37}']
    function addDescriptor(descriptor: JBluetoothGattDescriptor): Boolean; cdecl;
    function getDescriptor(uuid: JUUID): JBluetoothGattDescriptor; cdecl;
    function getDescriptors: JList; cdecl;
    function getFloatValue(formatType: Integer; offset: Integer): JFloat; cdecl;
    function getInstanceId: Integer; cdecl;
    function getIntValue(formatType: Integer; offset: Integer): JInteger; cdecl;
    function getPermissions: Integer; cdecl;
    function getProperties: Integer; cdecl;
    function getService: JBluetoothGattService; cdecl;
    function getStringValue(offset: Integer): JString; cdecl;
    function getUuid: JUUID; cdecl;
    function getValue: TJavaArray<Byte>; cdecl;
    function getWriteType: Integer; cdecl;
    function setValue(value: TJavaArray<Byte>): Boolean; cdecl; overload;
    function setValue(value: Integer; formatType: Integer; offset: Integer): Boolean; cdecl; overload;
    function setValue(mantissa: Integer; exponent: Integer; formatType: Integer; offset: Integer): Boolean; cdecl; overload;
    function setValue(value: JString): Boolean; cdecl; overload;
    procedure setWriteType(writeType: Integer); cdecl;
  end;
  TJBluetoothGattCharacteristic = class(TJavaGenericImport<JBluetoothGattCharacteristicClass, JBluetoothGattCharacteristic>) end;

  JBluetoothGattDescriptorClass = interface(JObjectClass)
    ['{28C0B7DC-35A2-4C0B-BF12-377AFB7D767C}']
    {class} function _GetDISABLE_NOTIFICATION_VALUE: TJavaArray<Byte>; cdecl;
    {class} function _GetENABLE_INDICATION_VALUE: TJavaArray<Byte>; cdecl;
    {class} function _GetENABLE_NOTIFICATION_VALUE: TJavaArray<Byte>; cdecl;
    {class} function _GetPERMISSION_READ: Integer; cdecl;
    {class} function _GetPERMISSION_READ_ENCRYPTED: Integer; cdecl;
    {class} function _GetPERMISSION_READ_ENCRYPTED_MITM: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE_ENCRYPTED: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE_ENCRYPTED_MITM: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE_SIGNED: Integer; cdecl;
    {class} function _GetPERMISSION_WRITE_SIGNED_MITM: Integer; cdecl;
    {class} function init(uuid: JUUID; permissions: Integer): JBluetoothGattDescriptor; cdecl;
    {class} property DISABLE_NOTIFICATION_VALUE: TJavaArray<Byte> read _GetDISABLE_NOTIFICATION_VALUE;
    {class} property ENABLE_INDICATION_VALUE: TJavaArray<Byte> read _GetENABLE_INDICATION_VALUE;
    {class} property ENABLE_NOTIFICATION_VALUE: TJavaArray<Byte> read _GetENABLE_NOTIFICATION_VALUE;
    {class} property PERMISSION_READ: Integer read _GetPERMISSION_READ;
    {class} property PERMISSION_READ_ENCRYPTED: Integer read _GetPERMISSION_READ_ENCRYPTED;
    {class} property PERMISSION_READ_ENCRYPTED_MITM: Integer read _GetPERMISSION_READ_ENCRYPTED_MITM;
    {class} property PERMISSION_WRITE: Integer read _GetPERMISSION_WRITE;
    {class} property PERMISSION_WRITE_ENCRYPTED: Integer read _GetPERMISSION_WRITE_ENCRYPTED;
    {class} property PERMISSION_WRITE_ENCRYPTED_MITM: Integer read _GetPERMISSION_WRITE_ENCRYPTED_MITM;
    {class} property PERMISSION_WRITE_SIGNED: Integer read _GetPERMISSION_WRITE_SIGNED;
    {class} property PERMISSION_WRITE_SIGNED_MITM: Integer read _GetPERMISSION_WRITE_SIGNED_MITM;
  end;

  [JavaSignature('android/bluetooth/BluetoothGattDescriptor')]
  JBluetoothGattDescriptor = interface(JObject)
    ['{E6B635CF-FA07-443D-A538-CD9EB22110BA}']
    function getCharacteristic: JBluetoothGattCharacteristic; cdecl;
    function getPermissions: Integer; cdecl;
    function getUuid: JUUID; cdecl;
    function getValue: TJavaArray<Byte>; cdecl;
    function setValue(value: TJavaArray<Byte>): Boolean; cdecl;
  end;
  TJBluetoothGattDescriptor = class(TJavaGenericImport<JBluetoothGattDescriptorClass, JBluetoothGattDescriptor>) end;

  JBluetoothGattServerClass = interface(JObjectClass)
    ['{FA3AE62C-030E-4325-BDE6-228CA519226A}']
  end;

  [JavaSignature('android/bluetooth/BluetoothGattServer')]
  JBluetoothGattServer = interface(JObject)
    ['{0C8EE0C3-F591-454A-B1AE-1F7A51CF0762}']
    function addService(service: JBluetoothGattService): Boolean; cdecl;
    procedure cancelConnection(device: JBluetoothDevice); cdecl;
    procedure clearServices; cdecl;
    procedure close; cdecl;
    function connect(device: JBluetoothDevice; autoConnect: Boolean): Boolean; cdecl;
    function getConnectedDevices: JList; cdecl;
    function getConnectionState(device: JBluetoothDevice): Integer; cdecl;
    function getDevicesMatchingConnectionStates(states: TJavaArray<Integer>): JList; cdecl;
    function getService(uuid: JUUID): JBluetoothGattService; cdecl;
    function getServices: JList; cdecl;
    function notifyCharacteristicChanged(device: JBluetoothDevice; characteristic: JBluetoothGattCharacteristic; confirm: Boolean): Boolean; cdecl;
    function removeService(service: JBluetoothGattService): Boolean; cdecl;
    function sendResponse(device: JBluetoothDevice; requestId: Integer; status: Integer; offset: Integer; value: TJavaArray<Byte>): Boolean; cdecl;
  end;
  TJBluetoothGattServer = class(TJavaGenericImport<JBluetoothGattServerClass, JBluetoothGattServer>) end;

  JBluetoothGattServerCallbackClass = interface(JObjectClass)
    ['{3AAB7F16-EAFB-42F1-AB0B-B69913D30828}']
    {class} function init: JBluetoothGattServerCallback; cdecl;
  end;

  [JavaSignature('android/bluetooth/BluetoothGattServerCallback')]
  JBluetoothGattServerCallback = interface(JObject)
    ['{0DAA40B9-3010-43B9-A8BC-38953BCE641E}']
    procedure onCharacteristicReadRequest(device: JBluetoothDevice; requestId: Integer; offset: Integer; characteristic: JBluetoothGattCharacteristic); cdecl;
    procedure onCharacteristicWriteRequest(device: JBluetoothDevice; requestId: Integer; characteristic: JBluetoothGattCharacteristic; preparedWrite: Boolean; responseNeeded: Boolean; offset: Integer; value: TJavaArray<Byte>); cdecl;
    procedure onConnectionStateChange(device: JBluetoothDevice; status: Integer; newState: Integer); cdecl;
    procedure onDescriptorReadRequest(device: JBluetoothDevice; requestId: Integer; offset: Integer; descriptor: JBluetoothGattDescriptor); cdecl;
    procedure onDescriptorWriteRequest(device: JBluetoothDevice; requestId: Integer; descriptor: JBluetoothGattDescriptor; preparedWrite: Boolean; responseNeeded: Boolean; offset: Integer; value: TJavaArray<Byte>); cdecl;
    procedure onExecuteWrite(device: JBluetoothDevice; requestId: Integer; execute: Boolean); cdecl;
    procedure onMtuChanged(device: JBluetoothDevice; mtu: Integer); cdecl;
    procedure onNotificationSent(device: JBluetoothDevice; status: Integer); cdecl;
    procedure onServiceAdded(status: Integer; service: JBluetoothGattService); cdecl;
  end;
  TJBluetoothGattServerCallback = class(TJavaGenericImport<JBluetoothGattServerCallbackClass, JBluetoothGattServerCallback>) end;

  JBluetoothGattServiceClass = interface(JObjectClass)
    ['{67244B78-B5BE-473E-B84C-EBE8898975B9}']
    {class} function _GetSERVICE_TYPE_PRIMARY: Integer; cdecl;
    {class} function _GetSERVICE_TYPE_SECONDARY: Integer; cdecl;
    {class} function init(uuid: JUUID; serviceType: Integer): JBluetoothGattService; cdecl;
    {class} property SERVICE_TYPE_PRIMARY: Integer read _GetSERVICE_TYPE_PRIMARY;
    {class} property SERVICE_TYPE_SECONDARY: Integer read _GetSERVICE_TYPE_SECONDARY;
  end;

  [JavaSignature('android/bluetooth/BluetoothGattService')]
  JBluetoothGattService = interface(JObject)
    ['{3EF3B4CF-735C-4DA5-A62B-8B7F3862DEA7}']
    function addCharacteristic(characteristic: JBluetoothGattCharacteristic): Boolean; cdecl;
    function addService(service: JBluetoothGattService): Boolean; cdecl;
    function getCharacteristic(uuid: JUUID): JBluetoothGattCharacteristic; cdecl;
    function getCharacteristics: JList; cdecl;
    function getIncludedServices: JList; cdecl;
    function getInstanceId: Integer; cdecl;
    function getType: Integer; cdecl;
    function getUuid: JUUID; cdecl;
  end;
  TJBluetoothGattService = class(TJavaGenericImport<JBluetoothGattServiceClass, JBluetoothGattService>) end;

  JBluetoothHeadsetClass = interface(JObjectClass)
    ['{1C02789A-AD09-44E2-B844-5AE59B74D108}']
    {class} function _GetACTION_AUDIO_STATE_CHANGED: JString; cdecl;
    {class} function _GetACTION_CONNECTION_STATE_CHANGED: JString; cdecl;
    {class} function _GetACTION_VENDOR_SPECIFIC_HEADSET_EVENT: JString; cdecl;
    {class} function _GetAT_CMD_TYPE_ACTION: Integer; cdecl;
    {class} function _GetAT_CMD_TYPE_BASIC: Integer; cdecl;
    {class} function _GetAT_CMD_TYPE_READ: Integer; cdecl;
    {class} function _GetAT_CMD_TYPE_SET: Integer; cdecl;
    {class} function _GetAT_CMD_TYPE_TEST: Integer; cdecl;
    {class} function _GetEXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_ARGS: JString; cdecl;
    {class} function _GetEXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_CMD: JString; cdecl;
    {class} function _GetEXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_CMD_TYPE: JString; cdecl;
    {class} function _GetSTATE_AUDIO_CONNECTED: Integer; cdecl;
    {class} function _GetSTATE_AUDIO_CONNECTING: Integer; cdecl;
    {class} function _GetSTATE_AUDIO_DISCONNECTED: Integer; cdecl;
    {class} function _GetVENDOR_RESULT_CODE_COMMAND_ANDROID: JString; cdecl;
    {class} function _GetVENDOR_SPECIFIC_HEADSET_EVENT_COMPANY_ID_CATEGORY: JString; cdecl;
    {class} property ACTION_AUDIO_STATE_CHANGED: JString read _GetACTION_AUDIO_STATE_CHANGED;
    {class} property ACTION_CONNECTION_STATE_CHANGED: JString read _GetACTION_CONNECTION_STATE_CHANGED;
    {class} property ACTION_VENDOR_SPECIFIC_HEADSET_EVENT: JString read _GetACTION_VENDOR_SPECIFIC_HEADSET_EVENT;
    {class} property AT_CMD_TYPE_ACTION: Integer read _GetAT_CMD_TYPE_ACTION;
    {class} property AT_CMD_TYPE_BASIC: Integer read _GetAT_CMD_TYPE_BASIC;
    {class} property AT_CMD_TYPE_READ: Integer read _GetAT_CMD_TYPE_READ;
    {class} property AT_CMD_TYPE_SET: Integer read _GetAT_CMD_TYPE_SET;
    {class} property AT_CMD_TYPE_TEST: Integer read _GetAT_CMD_TYPE_TEST;
    {class} property EXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_ARGS: JString read _GetEXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_ARGS;
    {class} property EXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_CMD: JString read _GetEXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_CMD;
    {class} property EXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_CMD_TYPE: JString read _GetEXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_CMD_TYPE;
    {class} property STATE_AUDIO_CONNECTED: Integer read _GetSTATE_AUDIO_CONNECTED;
    {class} property STATE_AUDIO_CONNECTING: Integer read _GetSTATE_AUDIO_CONNECTING;
    {class} property STATE_AUDIO_DISCONNECTED: Integer read _GetSTATE_AUDIO_DISCONNECTED;
    {class} property VENDOR_RESULT_CODE_COMMAND_ANDROID: JString read _GetVENDOR_RESULT_CODE_COMMAND_ANDROID;
    {class} property VENDOR_SPECIFIC_HEADSET_EVENT_COMPANY_ID_CATEGORY: JString read _GetVENDOR_SPECIFIC_HEADSET_EVENT_COMPANY_ID_CATEGORY;
  end;

  [JavaSignature('android/bluetooth/BluetoothHeadset')]
  JBluetoothHeadset = interface(JObject)
    ['{F5113343-8748-4A7C-AA6C-BD15197A0953}']
    function getConnectedDevices: JList; cdecl;
    function getConnectionState(device: JBluetoothDevice): Integer; cdecl;
    function getDevicesMatchingConnectionStates(states: TJavaArray<Integer>): JList; cdecl;
    function isAudioConnected(device: JBluetoothDevice): Boolean; cdecl;
    function sendVendorSpecificResultCode(device: JBluetoothDevice; command: JString; arg: JString): Boolean; cdecl;
    function startVoiceRecognition(device: JBluetoothDevice): Boolean; cdecl;
    function stopVoiceRecognition(device: JBluetoothDevice): Boolean; cdecl;
  end;
  TJBluetoothHeadset = class(TJavaGenericImport<JBluetoothHeadsetClass, JBluetoothHeadset>) end;

  JBluetoothHealthClass = interface(JObjectClass)
    ['{300F6FEB-972D-4E7B-A50C-A15F454008B4}']
    {class} function _GetAPP_CONFIG_REGISTRATION_FAILURE: Integer; cdecl;
    {class} function _GetAPP_CONFIG_REGISTRATION_SUCCESS: Integer; cdecl;
    {class} function _GetAPP_CONFIG_UNREGISTRATION_FAILURE: Integer; cdecl;
    {class} function _GetAPP_CONFIG_UNREGISTRATION_SUCCESS: Integer; cdecl;
    {class} function _GetCHANNEL_TYPE_RELIABLE: Integer; cdecl;
    {class} function _GetCHANNEL_TYPE_STREAMING: Integer; cdecl;
    {class} function _GetSINK_ROLE: Integer; cdecl;
    {class} function _GetSOURCE_ROLE: Integer; cdecl;
    {class} function _GetSTATE_CHANNEL_CONNECTED: Integer; cdecl;
    {class} function _GetSTATE_CHANNEL_CONNECTING: Integer; cdecl;
    {class} function _GetSTATE_CHANNEL_DISCONNECTED: Integer; cdecl;
    {class} function _GetSTATE_CHANNEL_DISCONNECTING: Integer; cdecl;
    {class} property APP_CONFIG_REGISTRATION_FAILURE: Integer read _GetAPP_CONFIG_REGISTRATION_FAILURE;
    {class} property APP_CONFIG_REGISTRATION_SUCCESS: Integer read _GetAPP_CONFIG_REGISTRATION_SUCCESS;
    {class} property APP_CONFIG_UNREGISTRATION_FAILURE: Integer read _GetAPP_CONFIG_UNREGISTRATION_FAILURE;
    {class} property APP_CONFIG_UNREGISTRATION_SUCCESS: Integer read _GetAPP_CONFIG_UNREGISTRATION_SUCCESS;
    {class} property CHANNEL_TYPE_RELIABLE: Integer read _GetCHANNEL_TYPE_RELIABLE;
    {class} property CHANNEL_TYPE_STREAMING: Integer read _GetCHANNEL_TYPE_STREAMING;
    {class} property SINK_ROLE: Integer read _GetSINK_ROLE;
    {class} property SOURCE_ROLE: Integer read _GetSOURCE_ROLE;
    {class} property STATE_CHANNEL_CONNECTED: Integer read _GetSTATE_CHANNEL_CONNECTED;
    {class} property STATE_CHANNEL_CONNECTING: Integer read _GetSTATE_CHANNEL_CONNECTING;
    {class} property STATE_CHANNEL_DISCONNECTED: Integer read _GetSTATE_CHANNEL_DISCONNECTED;
    {class} property STATE_CHANNEL_DISCONNECTING: Integer read _GetSTATE_CHANNEL_DISCONNECTING;
  end;

  [JavaSignature('android/bluetooth/BluetoothHealth')]
  JBluetoothHealth = interface(JObject)
    ['{2C7C401F-FDC8-4C14-B495-A888A7E63035}']
    function connectChannelToSource(device: JBluetoothDevice; config: JBluetoothHealthAppConfiguration): Boolean; cdecl;
    function disconnectChannel(device: JBluetoothDevice; config: JBluetoothHealthAppConfiguration; channelId: Integer): Boolean; cdecl;
    function getConnectedDevices: JList; cdecl;
    function getConnectionState(device: JBluetoothDevice): Integer; cdecl;
    function getDevicesMatchingConnectionStates(states: TJavaArray<Integer>): JList; cdecl;
    function getMainChannelFd(device: JBluetoothDevice; config: JBluetoothHealthAppConfiguration): JParcelFileDescriptor; cdecl;
    function registerSinkAppConfiguration(name: JString; dataType: Integer; callback: JBluetoothHealthCallback): Boolean; cdecl;
    function unregisterAppConfiguration(config: JBluetoothHealthAppConfiguration): Boolean; cdecl;
  end;
  TJBluetoothHealth = class(TJavaGenericImport<JBluetoothHealthClass, JBluetoothHealth>) end;

  JBluetoothHealthAppConfigurationClass = interface(JObjectClass)
    ['{D01FD0E1-8DDC-4F7C-9366-E557F7AA1E5A}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/bluetooth/BluetoothHealthAppConfiguration')]
  JBluetoothHealthAppConfiguration = interface(JObject)
    ['{795DED40-D984-43F1-BF05-48D979EE7E32}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getDataType: Integer; cdecl;
    function getName: JString; cdecl;
    function getRole: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJBluetoothHealthAppConfiguration = class(TJavaGenericImport<JBluetoothHealthAppConfigurationClass, JBluetoothHealthAppConfiguration>) end;

  JBluetoothHealthCallbackClass = interface(JObjectClass)
    ['{7B57EB4C-C41D-4E04-A684-7FA1F28947DE}']
    {class} function init: JBluetoothHealthCallback; cdecl;
  end;

  [JavaSignature('android/bluetooth/BluetoothHealthCallback')]
  JBluetoothHealthCallback = interface(JObject)
    ['{0B5BE0DB-6275-4F55-9E86-CF1074072A0A}']
    procedure onHealthAppConfigurationStatusChange(config: JBluetoothHealthAppConfiguration; status: Integer); cdecl;
    procedure onHealthChannelStateChange(config: JBluetoothHealthAppConfiguration; device: JBluetoothDevice; prevState: Integer; newState: Integer; fd: JParcelFileDescriptor; channelId: Integer); cdecl;
  end;
  TJBluetoothHealthCallback = class(TJavaGenericImport<JBluetoothHealthCallbackClass, JBluetoothHealthCallback>) end;

  JBluetoothManagerClass = interface(JObjectClass)
    ['{A44BF6BA-ED3D-4136-9C6B-1DF9DAA37178}']
  end;

  [JavaSignature('android/bluetooth/BluetoothManager')]
  JBluetoothManager = interface(JObject)
    ['{67B37813-B270-438B-A23C-F71C37660C75}']
    function getAdapter: JBluetoothAdapter; cdecl;
    function getConnectedDevices(profile: Integer): JList; cdecl;
    function getConnectionState(device: JBluetoothDevice; profile: Integer): Integer; cdecl;
    function getDevicesMatchingConnectionStates(profile: Integer; states: TJavaArray<Integer>): JList; cdecl;
    function openGattServer(context: JContext; callback: JBluetoothGattServerCallback): JBluetoothGattServer; cdecl;
  end;
  TJBluetoothManager = class(TJavaGenericImport<JBluetoothManagerClass, JBluetoothManager>) end;

  JBluetoothProfileClass = interface(IJavaClass)
    ['{D4C874B9-3002-41AB-AE93-FDD3E9A75A66}']
    {class} function _GetA2DP: Integer; cdecl;
    {class} function _GetEXTRA_PREVIOUS_STATE: JString; cdecl;
    {class} function _GetEXTRA_STATE: JString; cdecl;
    {class} function _GetGATT: Integer; cdecl;
    {class} function _GetGATT_SERVER: Integer; cdecl;
    {class} function _GetHEADSET: Integer; cdecl;
    {class} function _GetHEALTH: Integer; cdecl;
    {class} function _GetSTATE_CONNECTED: Integer; cdecl;
    {class} function _GetSTATE_CONNECTING: Integer; cdecl;
    {class} function _GetSTATE_DISCONNECTED: Integer; cdecl;
    {class} function _GetSTATE_DISCONNECTING: Integer; cdecl;
    {class} property A2DP: Integer read _GetA2DP;
    {class} property EXTRA_PREVIOUS_STATE: JString read _GetEXTRA_PREVIOUS_STATE;
    {class} property EXTRA_STATE: JString read _GetEXTRA_STATE;
    {class} property GATT: Integer read _GetGATT;
    {class} property GATT_SERVER: Integer read _GetGATT_SERVER;
    {class} property HEADSET: Integer read _GetHEADSET;
    {class} property HEALTH: Integer read _GetHEALTH;
    {class} property STATE_CONNECTED: Integer read _GetSTATE_CONNECTED;
    {class} property STATE_CONNECTING: Integer read _GetSTATE_CONNECTING;
    {class} property STATE_DISCONNECTED: Integer read _GetSTATE_DISCONNECTED;
    {class} property STATE_DISCONNECTING: Integer read _GetSTATE_DISCONNECTING;
  end;

  [JavaSignature('android/bluetooth/BluetoothProfile')]
  JBluetoothProfile = interface(IJavaInstance)
    ['{ED35C263-DCA1-4E11-8945-0950AD3EF7A6}']
    function getConnectedDevices: JList; cdecl;
    function getConnectionState(device: JBluetoothDevice): Integer; cdecl;
    function getDevicesMatchingConnectionStates(states: TJavaArray<Integer>): JList; cdecl;
  end;
  TJBluetoothProfile = class(TJavaGenericImport<JBluetoothProfileClass, JBluetoothProfile>) end;

  JBluetoothProfile_ServiceListenerClass = interface(IJavaClass)
    ['{2601CF0E-06F4-430C-9EAF-498D4CE00504}']
  end;

  [JavaSignature('android/bluetooth/BluetoothProfile$ServiceListener')]
  JBluetoothProfile_ServiceListener = interface(IJavaInstance)
    ['{545ECD2A-6684-4A8E-87BA-62FCA4DDFB73}']
    procedure onServiceConnected(profile: Integer; proxy: JBluetoothProfile); cdecl;
    procedure onServiceDisconnected(profile: Integer); cdecl;
  end;
  TJBluetoothProfile_ServiceListener = class(TJavaGenericImport<JBluetoothProfile_ServiceListenerClass, JBluetoothProfile_ServiceListener>) end;

  JBluetoothServerSocketClass = interface(JObjectClass)
    ['{0E4C4370-61A3-46AD-B79A-9818D6A86AD3}']
  end;

  [JavaSignature('android/bluetooth/BluetoothServerSocket')]
  JBluetoothServerSocket = interface(JObject)
    ['{CFA2FCE7-C9B5-4826-806D-5327363840DC}']
    function accept: JBluetoothSocket; cdecl; overload;
    function accept(timeout: Integer): JBluetoothSocket; cdecl; overload;
    procedure close; cdecl;
  end;
  TJBluetoothServerSocket = class(TJavaGenericImport<JBluetoothServerSocketClass, JBluetoothServerSocket>) end;

  JBluetoothSocketClass = interface(JObjectClass)
    ['{E282B24F-E194-4C88-A065-B84BEE426B4F}']
  end;

  [JavaSignature('android/bluetooth/BluetoothSocket')]
  JBluetoothSocket = interface(JObject)
    ['{FC81DB7D-A513-4D9D-8BDC-6D852A5BEB34}']
    procedure close; cdecl;
    procedure connect; cdecl;
    function getInputStream: JInputStream; cdecl;
    function getOutputStream: JOutputStream; cdecl;
    function getRemoteDevice: JBluetoothDevice; cdecl;
    function isConnected: Boolean; cdecl;
  end;
  TJBluetoothSocket = class(TJavaGenericImport<JBluetoothSocketClass, JBluetoothSocket>) end;

  JRTLBluetoothGattCallbackClass = interface(JBluetoothGattCallbackClass)
    ['{625DE747-1AC3-4C80-9344-84642E9C6CD1}']
    {class} function init(listener: JRTLBluetoothGattListener): JRTLBluetoothGattCallback; cdecl;
  end;

  [JavaSignature('android/bluetooth/RTLBluetoothGattCallback')]
  JRTLBluetoothGattCallback = interface(JBluetoothGattCallback)
    ['{F73E6A35-B789-441B-A99D-9B039976671A}']
    procedure onCharacteristicChanged(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic); cdecl;
    procedure onCharacteristicRead(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic; status: Integer); cdecl;
    procedure onCharacteristicWrite(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic; status: Integer); cdecl;
    procedure onConnectionStateChange(gatt: JBluetoothGatt; status: Integer; newState: Integer); cdecl;
    procedure onDescriptorRead(gatt: JBluetoothGatt; descriptor: JBluetoothGattDescriptor; status: Integer); cdecl;
    procedure onDescriptorWrite(gatt: JBluetoothGatt; descriptor: JBluetoothGattDescriptor; status: Integer); cdecl;
    procedure onMtuChanged(gatt: JBluetoothGatt; mtu: Integer; status: Integer); cdecl;
    procedure onReadRemoteRssi(gatt: JBluetoothGatt; rssi: Integer; status: Integer); cdecl;
    procedure onReliableWriteCompleted(gatt: JBluetoothGatt; status: Integer); cdecl;
    procedure onServicesDiscovered(gatt: JBluetoothGatt; status: Integer); cdecl;
  end;
  TJRTLBluetoothGattCallback = class(TJavaGenericImport<JRTLBluetoothGattCallbackClass, JRTLBluetoothGattCallback>) end;

  JRTLBluetoothGattListenerClass = interface(IJavaClass)
    ['{D15BDFD6-3017-47B1-9B54-5BDA5EEDA874}']
  end;

  [JavaSignature('android/bluetooth/RTLBluetoothGattListener')]
  JRTLBluetoothGattListener = interface(IJavaInstance)
    ['{EA9B991B-935B-4926-BD92-E8EFDB39ADAD}']
    procedure onCharacteristicChanged(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic); cdecl;
    procedure onCharacteristicRead(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic; status: Integer); cdecl;
    procedure onCharacteristicWrite(gatt: JBluetoothGatt; characteristic: JBluetoothGattCharacteristic; status: Integer); cdecl;
    procedure onConnectionStateChange(gatt: JBluetoothGatt; status: Integer; newState: Integer); cdecl;
    procedure onDescriptorRead(gatt: JBluetoothGatt; descriptor: JBluetoothGattDescriptor; status: Integer); cdecl;
    procedure onDescriptorWrite(gatt: JBluetoothGatt; descriptor: JBluetoothGattDescriptor; status: Integer); cdecl;
    procedure onReadRemoteRssi(gatt: JBluetoothGatt; rssi: Integer; status: Integer); cdecl;
    procedure onReliableWriteCompleted(gatt: JBluetoothGatt; status: Integer); cdecl;
    procedure onServicesDiscovered(gatt: JBluetoothGatt; status: Integer); cdecl;
  end;
  TJRTLBluetoothGattListener = class(TJavaGenericImport<JRTLBluetoothGattListenerClass, JRTLBluetoothGattListener>) end;

  JRTLBluetoothGattServerCallbackClass = interface(JBluetoothGattServerCallbackClass)
    ['{FF1E1FD4-CE1D-4B81-8CCB-BF672D420CB2}']
    {class} function init(listener: JRTLBluetoothGattServerListener): JRTLBluetoothGattServerCallback; cdecl;
  end;

  [JavaSignature('android/bluetooth/RTLBluetoothGattServerCallback')]
  JRTLBluetoothGattServerCallback = interface(JBluetoothGattServerCallback)
    ['{C7A6B714-4BBA-4877-BEC8-146C2B55BC81}']
    procedure onCharacteristicReadRequest(device: JBluetoothDevice; requestId: Integer; offset: Integer; characteristic: JBluetoothGattCharacteristic); cdecl;
    procedure onCharacteristicWriteRequest(device: JBluetoothDevice; requestId: Integer; characteristic: JBluetoothGattCharacteristic; preparedWrite: Boolean; responseNeeded: Boolean; offset: Integer; value: TJavaArray<Byte>); cdecl;
    procedure onConnectionStateChange(device: JBluetoothDevice; status: Integer; newState: Integer); cdecl;
    procedure onDescriptorReadRequest(device: JBluetoothDevice; requestId: Integer; offset: Integer; descriptor: JBluetoothGattDescriptor); cdecl;
    procedure onDescriptorWriteRequest(device: JBluetoothDevice; requestId: Integer; descriptor: JBluetoothGattDescriptor; preparedWrite: Boolean; responseNeeded: Boolean; offset: Integer; value: TJavaArray<Byte>); cdecl;
    procedure onExecuteWrite(device: JBluetoothDevice; requestId: Integer; execute: Boolean); cdecl;
    procedure onMtuChanged(device: JBluetoothDevice; mtu: Integer); cdecl;
    procedure onNotificationSent(device: JBluetoothDevice; status: Integer); cdecl;
    procedure onServiceAdded(status: Integer; service: JBluetoothGattService); cdecl;
  end;
  TJRTLBluetoothGattServerCallback = class(TJavaGenericImport<JRTLBluetoothGattServerCallbackClass, JRTLBluetoothGattServerCallback>) end;

  JRTLBluetoothGattServerListenerClass = interface(IJavaClass)
    ['{F666D469-D54E-4AD0-B294-8746F2D68822}']
  end;

  [JavaSignature('android/bluetooth/RTLBluetoothGattServerListener')]
  JRTLBluetoothGattServerListener = interface(IJavaInstance)
    ['{212A3844-B501-4A9E-A513-BA422AD4F48E}']
    procedure onCharacteristicReadRequest(device: JBluetoothDevice; requestId: Integer; offset: Integer; characteristic: JBluetoothGattCharacteristic); cdecl;
    procedure onCharacteristicWriteRequest(device: JBluetoothDevice; requestId: Integer; characteristic: JBluetoothGattCharacteristic; preparedWrite: Boolean; responseNeeded: Boolean; offset: Integer; value: TJavaArray<Byte>); cdecl;
    procedure onConnectionStateChange(device: JBluetoothDevice; status: Integer; newState: Integer); cdecl;
    procedure onDescriptorReadRequest(device: JBluetoothDevice; requestId: Integer; offset: Integer; descriptor: JBluetoothGattDescriptor); cdecl;
    procedure onDescriptorWriteRequest(device: JBluetoothDevice; requestId: Integer; descriptor: JBluetoothGattDescriptor; preparedWrite: Boolean; responseNeeded: Boolean; offset: Integer; value: TJavaArray<Byte>); cdecl;
    procedure onExecuteWrite(device: JBluetoothDevice; requestId: Integer; execute: Boolean); cdecl;
    procedure onServiceAdded(status: Integer; service: JBluetoothGattService); cdecl;
  end;
  TJRTLBluetoothGattServerListener = class(TJavaGenericImport<JRTLBluetoothGattServerListenerClass, JRTLBluetoothGattServerListener>) end;

  JAdvertiseCallbackClass = interface(JObjectClass)
    ['{C0E01FDC-4190-46E5-83D7-A6639511BC81}']
    {class} function _GetADVERTISE_FAILED_ALREADY_STARTED: Integer; cdecl;
    {class} function _GetADVERTISE_FAILED_DATA_TOO_LARGE: Integer; cdecl;
    {class} function _GetADVERTISE_FAILED_FEATURE_UNSUPPORTED: Integer; cdecl;
    {class} function _GetADVERTISE_FAILED_INTERNAL_ERROR: Integer; cdecl;
    {class} function _GetADVERTISE_FAILED_TOO_MANY_ADVERTISERS: Integer; cdecl;
    {class} function init: JAdvertiseCallback; cdecl;
    {class} property ADVERTISE_FAILED_ALREADY_STARTED: Integer read _GetADVERTISE_FAILED_ALREADY_STARTED;
    {class} property ADVERTISE_FAILED_DATA_TOO_LARGE: Integer read _GetADVERTISE_FAILED_DATA_TOO_LARGE;
    {class} property ADVERTISE_FAILED_FEATURE_UNSUPPORTED: Integer read _GetADVERTISE_FAILED_FEATURE_UNSUPPORTED;
    {class} property ADVERTISE_FAILED_INTERNAL_ERROR: Integer read _GetADVERTISE_FAILED_INTERNAL_ERROR;
    {class} property ADVERTISE_FAILED_TOO_MANY_ADVERTISERS: Integer read _GetADVERTISE_FAILED_TOO_MANY_ADVERTISERS;
  end;

  [JavaSignature('android/bluetooth/le/AdvertiseCallback')]
  JAdvertiseCallback = interface(JObject)
    ['{D4C9216C-7F9A-4CBF-8B2B-223023389F7F}']
    procedure onStartFailure(errorCode: Integer); cdecl;
    procedure onStartSuccess(settingsInEffect: JAdvertiseSettings); cdecl;
  end;
  TJAdvertiseCallback = class(TJavaGenericImport<JAdvertiseCallbackClass, JAdvertiseCallback>) end;

  //********** RTL **************

  JRTLAdvertiseCallbackClass = interface(JAdvertiseCallbackClass)
    ['{045C98C0-0048-4C5C-98B2-8623785277B1}']
    {class} function init(listener: JRTLAdvertiseListener): JRTLAdvertiseCallback; cdecl;
  end;

  [JavaSignature('android/bluetooth/le/RTLAdvertiseCallback')]
  JRTLAdvertiseCallback = interface(JAdvertiseCallback)
    ['{65D3084A-3121-4A97-B693-83122D1B1702}']
    procedure onStartFailure(errorCode: Integer); cdecl;
    procedure onStartSuccess(settingsInEffect: JAdvertiseSettings); cdecl;
  end;
  TJRTLAdvertiseCallback = class(TJavaGenericImport<JRTLAdvertiseCallbackClass, JRTLAdvertiseCallback>) end;

  JRTLAdvertiseListenerClass = interface(IJavaClass)
    ['{F4BB1C50-6C5C-43AD-9BED-578672E9F496}']
  end;

  [JavaSignature('android/bluetooth/le/RTLAdvertiseListener')]
  JRTLAdvertiseListener = interface(IJavaInstance)
    ['{2B3AE1FB-DF9C-42BD-9C4A-BFA601B8E74C}']
    procedure onStartFailure(errorCode: Integer); cdecl;
    procedure onStartSuccess(settingsInEffect: JAdvertiseSettings); cdecl;
  end;
  TJRTLAdvertiseListener = class(TJavaGenericImport<JRTLAdvertiseListenerClass, JRTLAdvertiseListener>) end;

  //************************

  JAdvertiseDataClass = interface(JObjectClass)
    ['{D904B990-967D-4B88-A845-A6D0A3AAB229}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/bluetooth/le/AdvertiseData')]
  JAdvertiseData = interface(JObject)
    ['{1A692105-2B87-4D48-AA87-AE3D4874D1A6}']
    function describeContents: Integer; cdecl;
    function getIncludeDeviceName: Boolean; cdecl;
    function getIncludeTxPowerLevel: Boolean; cdecl;
    function getManufacturerSpecificData: TJavaObjectArray<JSparseArray>; cdecl;
    function getServiceData: TJavaObjectArray<JMap>; cdecl;
    function getServiceUuids: JList; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJAdvertiseData = class(TJavaGenericImport<JAdvertiseDataClass, JAdvertiseData>) end;

  JAdvertiseData_BuilderClass = interface(JObjectClass)
    ['{04AD7CFA-5013-49D7-8714-866B66ABCABF}']
    {class} function init: JAdvertiseData_Builder; cdecl;
  end;

  [JavaSignature('android/bluetooth/le/AdvertiseData$Builder')]
  JAdvertiseData_Builder = interface(JObject)
    ['{1927C788-38E0-406B-886C-7939CBA10C6F}']
    function addManufacturerData(manufacturerId: Integer; manufacturerSpecificData: TJavaArray<Byte>): JAdvertiseData_Builder; cdecl;
    function addServiceData(serviceDataUuid: JParcelUuid; serviceData: TJavaArray<Byte>): JAdvertiseData_Builder; cdecl;
    function addServiceUuid(serviceUuid: JParcelUuid): JAdvertiseData_Builder; cdecl;
    function build: JAdvertiseData; cdecl;
    function setIncludeDeviceName(includeDeviceName: Boolean): JAdvertiseData_Builder; cdecl;
    function setIncludeTxPowerLevel(includeTxPowerLevel: Boolean): JAdvertiseData_Builder; cdecl;
  end;
  TJAdvertiseData_Builder = class(TJavaGenericImport<JAdvertiseData_BuilderClass, JAdvertiseData_Builder>) end;

  JAdvertiseSettingsClass = interface(JObjectClass)
    ['{5F84BBCE-073D-4CFE-AD88-51313256A925}']
    {class} function _GetADVERTISE_MODE_BALANCED: Integer; cdecl;
    {class} function _GetADVERTISE_MODE_LOW_LATENCY: Integer; cdecl;
    {class} function _GetADVERTISE_MODE_LOW_POWER: Integer; cdecl;
    {class} function _GetADVERTISE_TX_POWER_HIGH: Integer; cdecl;
    {class} function _GetADVERTISE_TX_POWER_LOW: Integer; cdecl;
    {class} function _GetADVERTISE_TX_POWER_MEDIUM: Integer; cdecl;
    {class} function _GetADVERTISE_TX_POWER_ULTRA_LOW: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property ADVERTISE_MODE_BALANCED: Integer read _GetADVERTISE_MODE_BALANCED;
    {class} property ADVERTISE_MODE_LOW_LATENCY: Integer read _GetADVERTISE_MODE_LOW_LATENCY;
    {class} property ADVERTISE_MODE_LOW_POWER: Integer read _GetADVERTISE_MODE_LOW_POWER;
    {class} property ADVERTISE_TX_POWER_HIGH: Integer read _GetADVERTISE_TX_POWER_HIGH;
    {class} property ADVERTISE_TX_POWER_LOW: Integer read _GetADVERTISE_TX_POWER_LOW;
    {class} property ADVERTISE_TX_POWER_MEDIUM: Integer read _GetADVERTISE_TX_POWER_MEDIUM;
    {class} property ADVERTISE_TX_POWER_ULTRA_LOW: Integer read _GetADVERTISE_TX_POWER_ULTRA_LOW;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/bluetooth/le/AdvertiseSettings')]
  JAdvertiseSettings = interface(JObject)
    ['{9959EE83-A90F-4A14-9722-F7D1F079621A}']
    function describeContents: Integer; cdecl;
    function getMode: Integer; cdecl;
    function getTimeout: Integer; cdecl;
    function getTxPowerLevel: Integer; cdecl;
    function isConnectable: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJAdvertiseSettings = class(TJavaGenericImport<JAdvertiseSettingsClass, JAdvertiseSettings>) end;

  JAdvertiseSettings_BuilderClass = interface(JObjectClass)
    ['{B83834DB-02C7-47F7-AFEC-D8454A69D8A5}']
    {class} function init: JAdvertiseSettings_Builder; cdecl;
  end;

  [JavaSignature('android/bluetooth/le/AdvertiseSettings$Builder')]
  JAdvertiseSettings_Builder = interface(JObject)
    ['{90BF25C9-3B6B-4859-8FA3-66CDB830089A}']
    function build: JAdvertiseSettings; cdecl;
    function setAdvertiseMode(advertiseMode: Integer): JAdvertiseSettings_Builder; cdecl;
    function setConnectable(connectable: Boolean): JAdvertiseSettings_Builder; cdecl;
    function setTimeout(timeoutMillis: Integer): JAdvertiseSettings_Builder; cdecl;
    function setTxPowerLevel(txPowerLevel: Integer): JAdvertiseSettings_Builder; cdecl;
  end;
  TJAdvertiseSettings_Builder = class(TJavaGenericImport<JAdvertiseSettings_BuilderClass, JAdvertiseSettings_Builder>) end;

  JBluetoothLeAdvertiserClass = interface(JObjectClass)
    ['{80721D97-DB54-461C-A1D0-A67526BCEF9C}']
  end;

  [JavaSignature('android/bluetooth/le/BluetoothLeAdvertiser')]
  JBluetoothLeAdvertiser = interface(JObject)
    ['{62DF5392-8FFA-4F1A-A801-2DB6DC44C9B3}']
    procedure startAdvertising(settings: JAdvertiseSettings; advertiseData: JAdvertiseData; callback: JAdvertiseCallback); cdecl; overload;
    procedure startAdvertising(settings: JAdvertiseSettings; advertiseData: JAdvertiseData; scanResponse: JAdvertiseData; callback: JAdvertiseCallback); cdecl; overload;
    procedure stopAdvertising(callback: JAdvertiseCallback); cdecl;
  end;
  TJBluetoothLeAdvertiser = class(TJavaGenericImport<JBluetoothLeAdvertiserClass, JBluetoothLeAdvertiser>) end;

  JBluetoothLeScannerClass = interface(JObjectClass)
    ['{037CB52E-670F-4EC0-8036-7B518C73D8D6}']
  end;

  [JavaSignature('android/bluetooth/le/BluetoothLeScanner')]
  JBluetoothLeScanner = interface(JObject)
    ['{D9746B62-4BD2-49A5-A756-954FC149B136}']
    procedure flushPendingScanResults(callback: JScanCallback); cdecl;
    procedure startScan(callback: JScanCallback); cdecl; overload;
    procedure startScan(filters: JList; settings: JScanSettings; callback: JScanCallback); cdecl; overload;
    procedure stopScan(callback: JScanCallback); cdecl;
  end;
  TJBluetoothLeScanner = class(TJavaGenericImport<JBluetoothLeScannerClass, JBluetoothLeScanner>) end;

  JScanCallbackClass = interface(JObjectClass)
    ['{54AC4025-A2D2-4F97-96A8-8B99C58C31C3}']
    {class} function _GetSCAN_FAILED_ALREADY_STARTED: Integer; cdecl;
    {class} function _GetSCAN_FAILED_APPLICATION_REGISTRATION_FAILED: Integer; cdecl;
    {class} function _GetSCAN_FAILED_FEATURE_UNSUPPORTED: Integer; cdecl;
    {class} function _GetSCAN_FAILED_INTERNAL_ERROR: Integer; cdecl;
    {class} function init: JScanCallback; cdecl;
    {class} property SCAN_FAILED_ALREADY_STARTED: Integer read _GetSCAN_FAILED_ALREADY_STARTED;
    {class} property SCAN_FAILED_APPLICATION_REGISTRATION_FAILED: Integer read _GetSCAN_FAILED_APPLICATION_REGISTRATION_FAILED;
    {class} property SCAN_FAILED_FEATURE_UNSUPPORTED: Integer read _GetSCAN_FAILED_FEATURE_UNSUPPORTED;
    {class} property SCAN_FAILED_INTERNAL_ERROR: Integer read _GetSCAN_FAILED_INTERNAL_ERROR;
  end;

  [JavaSignature('android/bluetooth/le/ScanCallback')]
  JScanCallback = interface(JObject)
    ['{7EFE6E06-FCDD-448F-92BA-D29B0AC06FF3}']
    procedure onBatchScanResults(results: JList); cdecl;
    procedure onScanFailed(errorCode: Integer); cdecl;
    procedure onScanResult(callbackType: Integer; result: Jle_ScanResult); cdecl;
  end;
  TJScanCallback = class(TJavaGenericImport<JScanCallbackClass, JScanCallback>) end;

  JScanFilterClass = interface(JObjectClass)
    ['{3F554F98-0D00-4364-8C99-0F69610E404E}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/bluetooth/le/ScanFilter')]
  JScanFilter = interface(JObject)
    ['{6A6D8301-C452-45DB-BE33-A23ABF3564E4}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getDeviceAddress: JString; cdecl;
    function getDeviceName: JString; cdecl;
    function getManufacturerData: TJavaArray<Byte>; cdecl;
    function getManufacturerDataMask: TJavaArray<Byte>; cdecl;
    function getManufacturerId: Integer; cdecl;
    function getServiceData: TJavaArray<Byte>; cdecl;
    function getServiceDataMask: TJavaArray<Byte>; cdecl;
    function getServiceDataUuid: JParcelUuid; cdecl;
    function getServiceUuid: JParcelUuid; cdecl;
    function getServiceUuidMask: JParcelUuid; cdecl;
    function hashCode: Integer; cdecl;
    function matches(scanResult: Jle_ScanResult): Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJScanFilter = class(TJavaGenericImport<JScanFilterClass, JScanFilter>) end;

  JScanFilter_BuilderClass = interface(JObjectClass)
    ['{CA942A72-9984-418B-9053-FCBFFAEF3C76}']
    {class} function init: JScanFilter_Builder; cdecl;
  end;

  [JavaSignature('android/bluetooth/le/ScanFilter$Builder')]
  JScanFilter_Builder = interface(JObject)
    ['{4A1C4430-A3A5-40D7-9C2D-827357F884DC}']
    function build: JScanFilter; cdecl;
    function setDeviceAddress(deviceAddress: JString): JScanFilter_Builder; cdecl;
    function setDeviceName(deviceName: JString): JScanFilter_Builder; cdecl;
    function setManufacturerData(manufacturerId: Integer; manufacturerData: TJavaArray<Byte>): JScanFilter_Builder; cdecl; overload;
    function setManufacturerData(manufacturerId: Integer; manufacturerData: TJavaArray<Byte>; manufacturerDataMask: TJavaArray<Byte>): JScanFilter_Builder; cdecl; overload;
    function setServiceData(serviceDataUuid: JParcelUuid; serviceData: TJavaArray<Byte>): JScanFilter_Builder; cdecl; overload;
    function setServiceData(serviceDataUuid: JParcelUuid; serviceData: TJavaArray<Byte>; serviceDataMask: TJavaArray<Byte>): JScanFilter_Builder; cdecl; overload;
    function setServiceUuid(serviceUuid: JParcelUuid): JScanFilter_Builder; cdecl; overload;
    function setServiceUuid(serviceUuid: JParcelUuid; uuidMask: JParcelUuid): JScanFilter_Builder; cdecl; overload;
  end;
  TJScanFilter_Builder = class(TJavaGenericImport<JScanFilter_BuilderClass, JScanFilter_Builder>) end;

  JScanRecordClass = interface(JObjectClass)
    ['{E8C389F7-8E29-44DD-A897-601E4AA601A1}']
  end;

  [JavaSignature('android/bluetooth/le/ScanRecord')]
  JScanRecord = interface(JObject)
    ['{8EE1B96E-AB84-499C-B9F1-1F656029FEE8}']
    function getAdvertiseFlags: Integer; cdecl;
    function getBytes: TJavaArray<Byte>; cdecl;
    function getDeviceName: JString; cdecl;
    function getManufacturerSpecificData: TJavaObjectArray<JSparseArray>; cdecl; overload;
    function getManufacturerSpecificData(manufacturerId: Integer): TJavaArray<Byte>; cdecl; overload;
    function getServiceData: TJavaObjectArray<JMap>; cdecl; overload;
    function getServiceData(serviceDataUuid: JParcelUuid): TJavaArray<Byte>; cdecl; overload;
    function getServiceUuids: JList; cdecl;
    function getTxPowerLevel: Integer; cdecl;
    function toString: JString; cdecl;
  end;
  TJScanRecord = class(TJavaGenericImport<JScanRecordClass, JScanRecord>) end;

  Jle_ScanResultClass = interface(JObjectClass)
    ['{C654A063-A05D-4E45-A116-59736A9EAFA9}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(device: JBluetoothDevice; scanRecord: JScanRecord; rssi: Integer; timestampNanos: Int64): Jle_ScanResult; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/bluetooth/le/ScanResult')]
  Jle_ScanResult = interface(JObject)
    ['{3277CDD4-F1F2-49A6-96FD-99F6C30C828F}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getDevice: JBluetoothDevice; cdecl;
    function getRssi: Integer; cdecl;
    function getScanRecord: JScanRecord; cdecl;
    function getTimestampNanos: Int64; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJle_ScanResult = class(TJavaGenericImport<Jle_ScanResultClass, Jle_ScanResult>) end;

  JScanSettingsClass = interface(JObjectClass)
    ['{71D2996A-A5B7-4EE7-961E-C6E939D3A98D}']
    {class} function _GetCALLBACK_TYPE_ALL_MATCHES: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetSCAN_MODE_BALANCED: Integer; cdecl;
    {class} function _GetSCAN_MODE_LOW_LATENCY: Integer; cdecl;
    {class} function _GetSCAN_MODE_LOW_POWER: Integer; cdecl;
    {class} property CALLBACK_TYPE_ALL_MATCHES: Integer read _GetCALLBACK_TYPE_ALL_MATCHES;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property SCAN_MODE_BALANCED: Integer read _GetSCAN_MODE_BALANCED;
    {class} property SCAN_MODE_LOW_LATENCY: Integer read _GetSCAN_MODE_LOW_LATENCY;
    {class} property SCAN_MODE_LOW_POWER: Integer read _GetSCAN_MODE_LOW_POWER;
  end;

  [JavaSignature('android/bluetooth/le/ScanSettings')]
  JScanSettings = interface(JObject)
    ['{6EFFF088-8CE9-46CB-80E6-6C44513B07BC}']
    function describeContents: Integer; cdecl;
    function getCallbackType: Integer; cdecl;
    function getReportDelayMillis: Int64; cdecl;
    function getScanMode: Integer; cdecl;
    function getScanResultType: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJScanSettings = class(TJavaGenericImport<JScanSettingsClass, JScanSettings>) end;

  JScanSettings_BuilderClass = interface(JObjectClass)
    ['{EAFEC592-65E5-48F5-98C1-C3FD2DC334CB}']
    {class} function init: JScanSettings_Builder; cdecl;
  end;

  [JavaSignature('android/bluetooth/le/ScanSettings$Builder')]
  JScanSettings_Builder = interface(JObject)
    ['{8AF38CAF-C3A9-4319-B138-7132DAF82175}']
    function build: JScanSettings; cdecl;
    function setReportDelay(reportDelayMillis: Int64): JScanSettings_Builder; cdecl;
    function setScanMode(scanMode: Integer): JScanSettings_Builder; cdecl;
  end;
  TJScanSettings_Builder = class(TJavaGenericImport<JScanSettings_BuilderClass, JScanSettings_Builder>) end;

//************* RTL *******************

  JRTLScanCallbackClass = interface(JScanCallbackClass)
    ['{3A14BBCE-97EF-46DA-9A13-0B5AF26A986A}']
    {class} function init(listener: JRTLScanListener): JRTLScanCallback; cdecl;
  end;

  [JavaSignature('android/bluetooth/le/RTLScanCallback')]
  JRTLScanCallback = interface(JScanCallback)
    ['{80A73669-9B5E-4B84-BB77-9AC8485E3F06}']
    procedure onBatchScanResults(results: JList); cdecl;
    procedure onScanFailed(errorCode: Integer); cdecl;
    procedure onScanResult(callbackType: Integer; result: Jle_ScanResult); cdecl;
  end;
  TJRTLScanCallback = class(TJavaGenericImport<JRTLScanCallbackClass, JRTLScanCallback>) end;

  JRTLScanListenerClass = interface(IJavaClass)
    ['{AA7E0D86-AC68-4A4B-9858-6C85666BB24B}']
  end;

  [JavaSignature('android/bluetooth/le/RTLScanListener')]
  JRTLScanListener = interface(IJavaInstance)
    ['{1607A08B-2DCF-4423-B1F7-CFC3C8DB2331}']
    procedure onBatchScanResults(results: JList); cdecl;
    procedure onScanFailed(errorCode: Integer); cdecl;
    procedure onScanResult(callbackType: Integer; result: Jle_ScanResult); cdecl;
  end;
  TJRTLScanListener = class(TJavaGenericImport<JRTLScanListenerClass, JRTLScanListener>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothA2dp', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothA2dp));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothAdapter', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothAdapter_LeScanCallback', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothAdapter_LeScanCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothAssignedNumbers', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothAssignedNumbers));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.Jbluetooth_BluetoothClass', TypeInfo(Androidapi.JNI.Bluetooth.Jbluetooth_BluetoothClass));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothClass_Device', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothClass_Device));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JDevice_Major', TypeInfo(Androidapi.JNI.Bluetooth.JDevice_Major));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothClass_Service', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothClass_Service));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothDevice', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothDevice));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothGatt', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothGatt));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothGattCallback', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothGattCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothGattCharacteristic', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothGattCharacteristic));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothGattDescriptor', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothGattDescriptor));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothGattServer', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothGattServer));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothGattServerCallback', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothGattServerCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothGattService', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothGattService));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothHeadset', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothHeadset));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothHealth', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothHealth));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothHealthAppConfiguration', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothHealthAppConfiguration));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothHealthCallback', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothHealthCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothManager', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothManager));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothProfile', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothProfile));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothProfile_ServiceListener', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothProfile_ServiceListener));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothServerSocket', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothServerSocket));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothSocket', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothSocket));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JRTLBluetoothGattCallback', TypeInfo(Androidapi.JNI.Bluetooth.JRTLBluetoothGattCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JRTLAdvertiseListener', TypeInfo(Androidapi.JNI.Bluetooth.JRTLAdvertiseListener));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JRTLBluetoothGattListener', TypeInfo(Androidapi.JNI.Bluetooth.JRTLBluetoothGattListener));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JRTLBluetoothGattServerCallback', TypeInfo(Androidapi.JNI.Bluetooth.JRTLBluetoothGattServerCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JRTLBluetoothGattServerListener', TypeInfo(Androidapi.JNI.Bluetooth.JRTLBluetoothGattServerListener));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JAdvertiseCallback', TypeInfo(Androidapi.JNI.Bluetooth.JAdvertiseCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JRTLAdvertiseCallback', TypeInfo(Androidapi.JNI.Bluetooth.JRTLAdvertiseCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JRTLScanCallback', TypeInfo(Androidapi.JNI.Bluetooth.JRTLScanCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JAdvertiseData', TypeInfo(Androidapi.JNI.Bluetooth.JAdvertiseData));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JAdvertiseData_Builder', TypeInfo(Androidapi.JNI.Bluetooth.JAdvertiseData_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JAdvertiseSettings', TypeInfo(Androidapi.JNI.Bluetooth.JAdvertiseSettings));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JAdvertiseSettings_Builder', TypeInfo(Androidapi.JNI.Bluetooth.JAdvertiseSettings_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothLeAdvertiser', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothLeAdvertiser));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JBluetoothLeScanner', TypeInfo(Androidapi.JNI.Bluetooth.JBluetoothLeScanner));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JScanCallback', TypeInfo(Androidapi.JNI.Bluetooth.JScanCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JScanFilter', TypeInfo(Androidapi.JNI.Bluetooth.JScanFilter));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JScanFilter_Builder', TypeInfo(Androidapi.JNI.Bluetooth.JScanFilter_Builder)); 
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JScanRecord', TypeInfo(Androidapi.JNI.Bluetooth.JScanRecord));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.Jle_ScanResult', TypeInfo(Androidapi.JNI.Bluetooth.Jle_ScanResult));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JScanSettings', TypeInfo(Androidapi.JNI.Bluetooth.JScanSettings));
  TRegTypes.RegisterType('Androidapi.JNI.Bluetooth.JScanSettings_Builder', TypeInfo(Androidapi.JNI.Bluetooth.JScanSettings_Builder));
end;

initialization
  RegisterTypes;
end.


