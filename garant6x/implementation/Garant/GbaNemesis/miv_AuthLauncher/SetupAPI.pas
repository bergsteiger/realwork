{
  Setup API defines

  Отсутствуют в RTL Delphi, включая XE4

}

unit SetupAPI;

interface

uses Windows;

const
  CfgMgrDllName = 'cfgmgr32.dll';
  SetupApiModuleName = 'SETUPAPI.DLL';

type
  RETURN_TYPE = DWORD;
  CONFIGRET = RETURN_TYPE;
  HDEVINFO = THandle;
  ULONG_PTR = ^ULONG;
  PDEVINST = ^DEVINST;
  DEVINST = DWORD;
  DI_FUNCTION = UINT;
  DEVINSTID_A = PAnsiChar;
  PPNP_VETO_TYPE = ^PNP_VETO_TYPE;
  PNP_VETO_TYPE = DWORD;
               
const
  // Classes GUIDs
  GUID_DEVCLASS_NET: TGUID       = '{4D36E972-E325-11CE-BFC1-08002BE10318}';
  GUID_DEVCLASS_DISKDRIVE: TGUID = '{4D36E967-E325-11CE-BFC1-08002BE10318}';

const
  DIGCF_DEFAULT         = $00000001;
  DIGCF_PRESENT         = $00000002;
  DIGCF_ALLCLASSES      = $00000004;
  DIGCF_PROFILE         = $00000008;
  DIGCF_DEVICEINTERFACE = $00000010;

//
// Values indicating a change in a device's state
//
  DICS_ENABLE     = $00000001;
  DICS_DISABLE    = $00000002;
  DICS_PROPCHANGE = $00000003;
  DICS_START      = $00000004;
  DICS_STOP       = $00000005;


  DN_ROOT_ENUMERATED = $00000001; // Was enumerated by ROOT
  DN_DRIVER_LOADED   = $00000002; // Has Register_Device_Driver
  DN_ENUM_LOADED     = $00000004; // Has Register_Enumerator
  DN_STARTED         = $00000008; // Is currently configured
  DN_MANUAL          = $00000010; // Manually installed
  DN_NEED_TO_ENUM    = $00000020; // May need reenumeration
  DN_NOT_FIRST_TIME  = $00000040; // Has received a config
  DN_HARDWARE_ENUM   = $00000080; // Enum generates hardware ID
  DN_LIAR            = $00000100; // Lied about can reconfig once
  DN_HAS_MARK        = $00000200; // Not CM_Create_DevInst lately
  DN_HAS_PROBLEM     = $00000400; // Need device installer
  DN_FILTERED        = $00000800; // Is filtered
  DN_MOVED           = $00001000; // Has been moved
  DN_DISABLEABLE     = $00002000; // Can be rebalanced
  DN_REMOVABLE       = $00004000; // Can be removed
  DN_PRIVATE_PROBLEM = $00008000; // Has a private problem
  DN_MF_PARENT       = $00010000; // Multi function parent
  DN_MF_CHILD        = $00020000; // Multi function child
  DN_WILL_BE_REMOVED = $00040000; // DevInst is being removed


  //
  // DevInst problem values, returned by call to CM_Get_DevInst_Status
  //
  CM_PROB_NOT_CONFIGURED             = $00000001;   // no config for device
  CM_PROB_DEVLOADER_FAILED           = $00000002;   // service load failed
  CM_PROB_OUT_OF_MEMORY              = $00000003;   // out of memory
  CM_PROB_ENTRY_IS_WRONG_TYPE        = $00000004;   //
  CM_PROB_LACKED_ARBITRATOR          = $00000005;   //
  CM_PROB_BOOT_CONFIG_CONFLICT       = $00000006;   // boot config conflict
  CM_PROB_FAILED_FILTER              = $00000007;   //
  CM_PROB_DEVLOADER_NOT_FOUND        = $00000008;   // Devloader not found
  CM_PROB_INVALID_DATA               = $00000009;   //
  CM_PROB_FAILED_START               = $0000000A;   //
  CM_PROB_LIAR                       = $0000000B;   //
  CM_PROB_NORMAL_CONFLICT            = $0000000C;   // config conflict
  CM_PROB_NOT_VERIFIED               = $0000000D;   //
  CM_PROB_NEED_RESTART               = $0000000E;   // requires restart
  CM_PROB_REENUMERATION              = $0000000F;   //
  CM_PROB_PARTIAL_LOG_CONF           = $00000010;   //
  CM_PROB_UNKNOWN_RESOURCE           = $00000011;   // unknown res type
  CM_PROB_REINSTALL                  = $00000012;   //
  CM_PROB_REGISTRY                   = $00000013;   //
  CM_PROB_VXDLDR                     = $00000014;   // WINDOWS 95 ONLY
  CM_PROB_WILL_BE_REMOVED            = $00000015;   // devinst will remove
  CM_PROB_DISABLED                   = $00000016;   // devinst is disabled
  CM_PROB_DEVLOADER_NOT_READY        = $00000017;   // Devloader not ready
  CM_PROB_DEVICE_NOT_THERE           = $00000018;   // device doesn't exist
  CM_PROB_MOVED                      = $00000019;   //
  CM_PROB_TOO_EARLY                  = $0000001A;   //
  CM_PROB_NO_VALID_LOG_CONF          = $0000001B;   // no valid log config
  CM_PROB_FAILED_INSTALL             = $0000001C;   // install failed
  CM_PROB_HARDWARE_DISABLED          = $0000001D;   // device disabled
  CM_PROB_CANT_SHARE_IRQ             = $0000001E;   // can't share IRQ
  CM_PROB_FAILED_ADD                 = $0000001F;   // driver failed add
  CM_PROB_DISABLED_SERVICE           = $00000020;   // service's Start = 4
  CM_PROB_TRANSLATION_FAILED         = $00000021;   // resource translation failed
  CM_PROB_NO_SOFTCONFIG              = $00000022;   // no soft config
  CM_PROB_BIOS_TABLE                 = $00000023;   // device missing in BIOS table
  CM_PROB_IRQ_TRANSLATION_FAILED     = $00000024;   // IRQ translator failed
  CM_PROB_FAILED_DRIVER_ENTRY        = $00000025;   // DriverEntry() failed.
  CM_PROB_DRIVER_FAILED_PRIOR_UNLOAD = $00000026;   // Driver should have unloaded.
  CM_PROB_DRIVER_FAILED_LOAD         = $00000027;   // Driver load unsuccessful.
  CM_PROB_DRIVER_SERVICE_KEY_INVALID = $00000028;   // Error accessing driver's service key
  CM_PROB_LEGACY_SERVICE_NO_DEVICES  = $00000029;   // Loaded legacy service created no devices
  CM_PROB_DUPLICATE_DEVICE           = $0000002A;   // Two devices were discovered with the same name
  CM_PROB_FAILED_POST_START          = $0000002B;   // The drivers set the device state to failed
  CM_PROB_HALTED                     = $0000002C;   // This device was failed post start via usermode
  CM_PROB_PHANTOM                    = $0000002D;   // The devinst currently exists only in the registry
  CM_PROB_SYSTEM_SHUTDOWN            = $0000002E;   // The system is shutting down
  CM_PROB_HELD_FOR_EJECT             = $0000002F;   // The device is offline awaiting removal
  CM_PROB_DRIVER_BLOCKED             = $00000030;   // One or more drivers is blocked from loading
  CM_PROB_REGISTRY_TOO_LARGE         = $00000031;   // System hive has grown too large

  SPDRP_FRIENDLYNAME          = $0000000C;
  SPDRP_DEVICEDESC            = $00000000;


  CR_SUCCESS                  = $00000000;
  CR_DEFAULT                  = $00000001;
  CR_OUT_OF_MEMORY            = $00000002;
  CR_INVALID_POINTER          = $00000003;
  CR_INVALID_FLAG             = $00000004;
  CR_INVALID_DEVNODE          = $00000005;
  CR_INVALID_DEVINST          = CR_INVALID_DEVNODE;
  CR_INVALID_RES_DES          = $00000006;
  CR_INVALID_LOG_CONF         = $00000007;
  CR_INVALID_ARBITRATOR       = $00000008;
  CR_INVALID_NODELIST         = $00000009;
  CR_DEVNODE_HAS_REQS         = $0000000A;
  CR_DEVINST_HAS_REQS         = CR_DEVNODE_HAS_REQS;
  CR_INVALID_RESOURCEID       = $0000000B;
  CR_DLVXD_NOT_FOUND          = $0000000C;   // WIN 95 ONLY
  CR_NO_SUCH_DEVNODE          = $0000000D;
  CR_NO_SUCH_DEVINST          = CR_NO_SUCH_DEVNODE;
  CR_NO_MORE_LOG_CONF         = $0000000E;
  CR_NO_MORE_RES_DES          = $0000000F;
  CR_ALREADY_SUCH_DEVNODE     = $00000010;
  CR_ALREADY_SUCH_DEVINST     = CR_ALREADY_SUCH_DEVNODE;
  CR_INVALID_RANGE_LIST       = $00000011;
  CR_INVALID_RANGE            = $00000012;
  CR_FAILURE                  = $00000013;
  CR_NO_SUCH_LOGICAL_DEV      = $00000014;
  CR_CREATE_BLOCKED           = $00000015;
  CR_NOT_SYSTEM_VM            = $00000016;   // WIN 95 ONLY
  CR_REMOVE_VETOED            = $00000017;
  CR_APM_VETOED               = $00000018;
  CR_INVALID_LOAD_TYPE        = $00000019;
  CR_BUFFER_SMALL             = $0000001A;
  CR_NO_ARBITRATOR            = $0000001B;
  CR_NO_REGISTRY_HANDLE       = $0000001C;
  CR_REGISTRY_ERROR           = $0000001D;
  CR_INVALID_DEVICE_ID        = $0000001E;
  CR_INVALID_DATA             = $0000001F;
  CR_INVALID_API              = $00000020;
  CR_DEVLOADER_NOT_READY      = $00000021;
  CR_NEED_RESTART             = $00000022;
  CR_NO_MORE_HW_PROFILES      = $00000023;
  CR_DEVICE_NOT_THERE         = $00000024;
  CR_NO_SUCH_VALUE            = $00000025;
  CR_WRONG_TYPE               = $00000026;
  CR_INVALID_PRIORITY         = $00000027;
  CR_NOT_DISABLEABLE          = $00000028;
  CR_FREE_RESOURCES           = $00000029;
  CR_QUERY_VETOED             = $0000002A;
  CR_CANT_SHARE_IRQ           = $0000002B;
  CR_NO_DEPENDENT             = $0000002C;
  CR_SAME_RESOURCES           = $0000002D;
  CR_NO_SUCH_REGISTRY_KEY     = $0000002E;
  CR_INVALID_MACHINENAME      = $0000002F;   // NT ONLY
  CR_REMOTE_COMM_FAILURE      = $00000030;   // NT ONLY
  CR_MACHINE_UNAVAILABLE      = $00000031;   // NT ONLY
  CR_NO_CM_SERVICES           = $00000032;   // NT ONLY
  CR_ACCESS_DENIED            = $00000033;   // NT ONLY
  CR_CALL_NOT_IMPLEMENTED     = $00000034;
  CR_INVALID_PROPERTY         = $00000035;
  CR_DEVICE_INTERFACE_ACTIVE  = $00000036;
  CR_NO_SUCH_DEVICE_INTERFACE = $00000037;
  CR_INVALID_REFERENCE_STRING = $00000038;
  CR_INVALID_CONFLICT_LIST    = $00000039;
  CR_INVALID_INDEX            = $0000003A;
  CR_INVALID_STRUCTURE_SIZE   = $0000003B;
  NUM_CR_RESULTS              = $0000003C;
  

  DICS_FLAG_CONFIGSPECIFIC    = 2;

// Device Installation Function Codes

  DIF_PROPERTYCHANGE          = $12;
         
type

  PSPDevInfoData = ^TSPDevInfoData;
  SP_DEVINFO_DATA = packed record
    cbSize: DWORD;
    ClassGuid: TGUID;
    DevInst: DWORD; // DEVINST handle
    Reserved: ULONG_PTR;
  end;
  TSPDevInfoData = SP_DEVINFO_DATA;

  PSPDeviceInterfaceData = ^TSPDeviceInterfaceData;
  SP_DEVICE_INTERFACE_DATA = packed record
    cbSize: DWORD;
    InterfaceClassGuid: TGUID;
    Flags: DWORD;
    Reserved: ULONG_PTR;
  end;
  TSPDeviceInterfaceData = SP_DEVICE_INTERFACE_DATA;

  PSPClassInstallHeader = ^TSPClassInstallHeader;
  SP_CLASSINSTALL_HEADER = packed record
    cbSize: DWORD;
    InstallFunction: DI_FUNCTION;
  end;
  TSPClassInstallHeader = SP_CLASSINSTALL_HEADER;

  PSPPropChangeParams = ^TSPPropChangeParams;
  SP_PROPCHANGE_PARAMS = packed record
    ClassInstallHeader: TSPClassInstallHeader;
    StateChange: DWORD;
    Scope: DWORD;
    HwProfile: DWORD;
  end;
  TSPPropChangeParams = SP_PROPCHANGE_PARAMS;


function CM_Enumerate_Classes(ulClassIndex: ULONG; var ClassGuid: TGUID;
 ulFlags: ULONG): CONFIGRET; stdcall; external CfgMgrDllName name 'CM_Enumerate_Classes';
 
function SetupDiGetClassDescriptionA(var ClassGuid: TGUID; ClassDescription: PAnsiChar;
 ClassDescriptionSize: DWORD; var RequiredSize: DWORD): BOOL; stdcall;
  external SetupApiModuleName name 'SetupDiGetClassDescriptionA';

function SetupDiGetClassDescription(var ClassGuid: TGUID; ClassDescription: PAnsiChar;
 ClassDescriptionSize: DWORD; var RequiredSize: DWORD): BOOL; stdcall;
  external SetupApiModuleName name 'SetupDiGetClassDescriptionA';

function SetupDiGetClassDevs(ClassGuid: PGUID; const Enumerator: PAnsiChar;
  hwndParent: HWND; Flags: DWORD): HDEVINFO; stdcall; external SetupApiModuleName
   name 'SetupDiGetClassDevsA';

function SetupDiGetClassDevsA(ClassGuid: PGUID; const Enumerator: PAnsiChar;
  hwndParent: HWND; Flags: DWORD): HDEVINFO; stdcall; external SetupApiModuleName
   name 'SetupDiGetClassDevsA';

function SetupDiEnumDeviceInfo(DeviceInfoSet: HDEVINFO; MemberIndex: DWORD;
 var DeviceInfoData: TSPDevInfoData): BOOL; stdcall; external SetupApiModuleName name 'SetupDiEnumDeviceInfo';

 function SetupDiGetDeviceRegistryProperty(DeviceInfoSet: HDEVINFO;
 const DeviceInfoData: TSPDevInfoData; Property_: DWORD;
  var PropertyRegDataType: DWORD; PropertyBuffer: PBYTE; PropertyBufferSize: DWORD;
   var RequiredSize: DWORD): BOOL; stdcall; external SetupApiModuleName name 'SetupDiGetDeviceRegistryPropertyA';

function SetupDiGetDeviceRegistryPropertyA(DeviceInfoSet: HDEVINFO;
 const DeviceInfoData: TSPDevInfoData; Property_: DWORD;
  var PropertyRegDataType: DWORD; PropertyBuffer: PBYTE; PropertyBufferSize: DWORD;
   var RequiredSize: DWORD): BOOL; stdcall; external SetupApiModuleName name 'SetupDiGetDeviceRegistryPropertyA';

function SetupDiDestroyDeviceInfoList(DeviceInfoSet: HDEVINFO): BOOL; stdcall;
 external SetupApiModuleName name 'SetupDiDestroyDeviceInfoList';

function CM_Get_DevNode_Status(var ulStatus: ULONG; var ulProblemNumber: ULONG;
  dnDevInst: DEVINST; ulFlags: ULONG): CONFIGRET; stdcall; external CfgMgrDllName
   name 'CM_Get_DevNode_Status';

function SetupDiSetClassInstallParamsA(DeviceInfoSet: HDEVINFO;
 DeviceInfoData: PSPDevInfoData; ClassInstallParams: PSPClassInstallHeader;
  ClassInstallParamsSize: DWORD): BOOL; stdcall; external SetupApiModuleName
   name 'SetupDiSetClassInstallParamsA';

function SetupDiSetClassInstallParams(DeviceInfoSet: HDEVINFO;
 DeviceInfoData: PSPDevInfoData; ClassInstallParams: PSPClassInstallHeader;
  ClassInstallParamsSize: DWORD): BOOL; stdcall; external SetupApiModuleName
   name 'SetupDiSetClassInstallParamsA';

function SetupDiSetClassRegistryProperty(const ClassGuid: TGUID;
 Property_: DWORD; const PropertyBuffer: PBYTE; PropertyBufferSize: DWORD;
  const MachineName: PAnsiChar; Reserved: Pointer): BOOL; stdcall;
   external SetupApiModuleName name 'SetupDiSetClassRegistryPropertyA';

function SetupDiSetClassRegistryPropertyA(const ClassGuid: TGUID;
 Property_: DWORD; const PropertyBuffer: PBYTE; PropertyBufferSize: DWORD;
  const MachineName: PAnsiChar; Reserved: Pointer): BOOL; stdcall;
   external SetupApiModuleName name 'SetupDiSetClassRegistryPropertyA';

function SetupDiCallClassInstaller(InstallFunction: DI_FUNCTION;
 DeviceInfoSet: HDEVINFO; DeviceInfoData: PSPDevInfoData): BOOL; stdcall;
  external SetupApiModuleName name 'SetupDiCallClassInstaller';

function CM_Get_Device_ID_Size(var ulLen: ULONG; dnDevInst: DEVINST;
 ulFlags: ULONG): CONFIGRET; stdcall; external CfgMgrDllName name 'CM_Get_Device_ID_Size';

function CM_Get_Device_ID(dnDevInst: DEVINST; Buffer: PAnsiChar;
 BufferLen: ULONG; ulFlags: ULONG): CONFIGRET; stdcall; external CfgMgrDllName
  name 'CM_Get_Device_IDA';

function CM_Get_Device_IDA(dnDevInst: DEVINST; Buffer: PAnsiChar;
 BufferLen: ULONG; ulFlags: ULONG): CONFIGRET; stdcall; external CfgMgrDllName
  name 'CM_Get_Device_IDA';

function CM_Get_Parent(var dnDevInstParent: DEVINST; dnDevInst: DEVINST;
 ulFlags: ULONG): CONFIGRET; stdcall; external CfgMgrDllName name 'CM_Get_Parent';

function CM_Request_Device_Eject(dnDevInst: DEVINST; pVetoType: PPNP_VETO_TYPE;
 pszVetoName: PAnsiChar; ulNameLength: ULONG; ulFlags: ULONG): CONFIGRET; stdcall;
  external SetupApiModuleName name 'CM_Request_Device_EjectA';

function CM_Request_Device_EjectA(dnDevInst: DEVINST; pVetoType: PPNP_VETO_TYPE;
 pszVetoName: PAnsiChar; ulNameLength: ULONG; ulFlags: ULONG): CONFIGRET; stdcall;
  external SetupApiModuleName name 'CM_Request_Device_EjectA';

function CM_Locate_DevNode(var dnDevInst: DEVINST; pDeviceID: DEVINSTID_A;
 ulFlags: ULONG): CONFIGRET; stdcall; external CfgMgrDllName name 'CM_Locate_DevNodeA';  

function CM_Locate_DevNodeA(var dnDevInst: DEVINST; pDeviceID: DEVINSTID_A;
 ulFlags: ULONG): CONFIGRET; stdcall; external CfgMgrDllName name 'CM_Locate_DevNodeA';

function SetupDiGetDeviceInstanceId(DeviceInfoSet: HDEVINFO; DeviceInfoData: PSPDevInfoData;
 DeviceInstanceId: PAnsiChar; DeviceInstanceIDSize: DWORD; var RequiredSize: DWORD): BOOL; stdcall;
  external SetupApiModuleName name 'SetupDiGetDeviceInstanceIdA';

//WM_DEVICECHANGE defines

type

  PDEV_BROADCAST_HDR = ^  TDEV_BROADCAST_HDR;
  _DEV_BROADCAST_HDR = record
    dbch_size, dbch_devicetype, dbch_reserved:DWORD;
   end;
  TDEV_BROADCAST_HDR = _DEV_BROADCAST_HDR;

  PDEV_BROADCAST_DEVICEINTERFACE = ^ TDEV_BROADCAST_DEVICEINTERFACE;
  _DEV_BROADCAST_DEVICEINTERFACE = record
    dbcc_size:DWORD;
    dbcc_devicetype:DWORD;
    dbcc_reserved:DWORD;
    dbcc_classguid:TGUID;
    dbcc_name:array[0..0] of char;
   end;
   TDEV_BROADCAST_DEVICEINTERFACE = _DEV_BROADCAST_DEVICEINTERFACE;

  PDEV_BROADCAST_HANDLE = ^ TDEV_BROADCAST_HANDLE; 
  _DEV_BROADCAST_HANDLE = record
    dbch_size: DWORD;
    dbch_devicetype: DWORD;
    dbch_reserved: DWORD;
    dbch_handle: THandle;
    dbch_hdevnotify:HDEVNOTIFY;
    dbch_eventguid: TGUID;
    dbch_nameoffset:Integer;
    dbch_data:array[0..0] of BYTE; 
   end;
  TDEV_BROADCAST_HANDLE = _DEV_BROADCAST_HANDLE;

  PDEV_BROADCAST_OEM = ^ TDEV_BROADCAST_OEM;
  _DEV_BROADCAST_OEM = record
    dbco_size,
    dbco_devicetype,
    dbco_reserved,
    dbco_identifier,
    dbco_suppfunc:DWORD;
   end;
  TDEV_BROADCAST_OEM =_DEV_BROADCAST_OEM;

  PDEV_BROADCAST_PORT = ^ TDEV_BROADCAST_PORT;
  _DEV_BROADCAST_PORT = record
    dbcp_size,
    dbcp_devicetype,
    dbcp_reserved: DWORD;
    dbcp_name:array[0..0] of char;
   end;
  TDEV_BROADCAST_PORT = _DEV_BROADCAST_PORT;

  PDEV_BROADCAST_VOLUME = ^ TDEV_BROADCAST_VOLUME;
  _DEV_BROADCAST_VOLUME = record
    dbcv_size,
    dbcv_devicetype,
    dbcv_reserved,
    dbcv_unitmask:DWORD;
    dbcv_flags:WORD;
   end;
  TDEV_BROADCAST_VOLUME = _DEV_BROADCAST_VOLUME; 

const
  DBT_CONFIGCHANGECANCELED    = $0019;
  DBT_CONFIGCHANGED           = $0018;
  
  DBT_DEVICEARRIVAL           = $8000; // system detected a new device
  DBT_DEVICEQUERYREMOVE       = $8001; // wants to remove, may fail
  DBT_DEVICEQUERYREMOVEFAILED = $8002; // removal aborted
  DBT_DEVICEREMOVECOMPLETE    = $8004; // device is gone
  DBT_DEVICEREMOVEPENDING     = $8003; // about to remove, still avail.
  DBT_DEVICETYPESPECIFIC      = $8005; // type specific event
  DBT_QUERYCHANGECONFIG       = $0017;

  DBT_DEVNODES_CHANGED        = $0007;

  DBT_DEVTYP_OEM       = 0;
  DBT_DEVTYP_DEVNODE	 = 1;
  DBT_DEVTYP_VOLUME    = 2;
  DBT_DEVTYP_PORT	     = 3;
  DBT_DEVTYP_NET	     = 4;
  DBT_DEVTYP_DEVICEINTERFACE = 5;
  DBT_DEVTYP_HANDLE    = 6;

  DBTF_MEDIA = $0001;
  DBTF_NET   = $0002;

  DEVICE_NOTIFY_ALL_INTERFACE_CLASSES =  4;   

implementation

end.
