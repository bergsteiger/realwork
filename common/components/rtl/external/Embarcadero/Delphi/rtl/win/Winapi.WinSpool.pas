{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{    File: Winspool.h                                   }
{    Copyright (c) 1990-1998, Microsoft Corporation     }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       Win32 printer API Interface Unit                }
{*******************************************************}

unit Winapi.WinSpool;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses Winapi.Windows;

(*$HPPEMIT '' *)
(*$HPPEMIT '#include <winspool.h>' *)
(*$HPPEMIT '' *)

const
  {$EXTERNALSYM PRINTER_CONNECTION_MISMATCH}
  PRINTER_CONNECTION_MISMATCH = $00000020;
  {$EXTERNALSYM PRINTER_CONNECTION_NO_UI}
  PRINTER_CONNECTION_NO_UI = $00000040;

{ Possible values of data transferred in a bidi operation }

  {$EXTERNALSYM BIDI_NULL}
  BIDI_NULL   = 0;
  {$EXTERNALSYM BIDI_INT}
  BIDI_INT    = 1;
  {$EXTERNALSYM BIDI_FLOAT}
  BIDI_FLOAT  = 2;
  {$EXTERNALSYM BIDI_BOOL}
  BIDI_BOOL   = 3;
  {$EXTERNALSYM BIDI_STRING}
  BIDI_STRING = 4;
  {$EXTERNALSYM BIDI_TEXT}
  BIDI_TEXT   = 5;
  {$EXTERNALSYM BIDI_ENUM}
  BIDI_ENUM   = 6;
  {$EXTERNALSYM BIDI_BLOB}
  BIDI_BLOB   = 7;

type
  PPrinterConnectionInfo1A = ^TPrinterConnectionInfo1A;
  PPrinterConnectionInfo1W = ^TPrinterConnectionInfo1W;
  PPrinterConnectionInfo1 = PPrinterConnectionInfo1W;
  {$EXTERNALSYM _PRINTER_CONNECTION_INFO_1}
  _PRINTER_CONNECTION_INFO_1A = record
    dwFlags: DWORD;
    pszDriverName: LPSTR;
  end;
  {$EXTERNALSYM _PRINTER_CONNECTION_INFO_1}
  _PRINTER_CONNECTION_INFO_1W = record
    dwFlags: DWORD;
    pszDriverName: LPWSTR;
  end;
  {$EXTERNALSYM _PRINTER_CONNECTION_INFO_1}
  _PRINTER_CONNECTION_INFO_1 = _PRINTER_CONNECTION_INFO_1W;
  TPrinterConnectionInfo1A = _PRINTER_CONNECTION_INFO_1A;
  TPrinterConnectionInfo1W = _PRINTER_CONNECTION_INFO_1W;
  TPrinterConnectionInfo1 = TPrinterConnectionInfo1W;
  {$EXTERNALSYM PRINTER_CONNECTION_INFO_1A}
  PRINTER_CONNECTION_INFO_1A = _PRINTER_CONNECTION_INFO_1A;
  {$EXTERNALSYM PRINTER_CONNECTION_INFO_1W}
  PRINTER_CONNECTION_INFO_1W = _PRINTER_CONNECTION_INFO_1W;
  {$EXTERNALSYM PRINTER_CONNECTION_INFO_1}
  PRINTER_CONNECTION_INFO_1 = PRINTER_CONNECTION_INFO_1W;

  PPrinterEnumValuesA = ^TPrinterEnumValuesA;
  PPrinterEnumValuesW = ^TPrinterEnumValuesW;
  PPrinterEnumValues = PPrinterEnumValuesW;
  {$EXTERNALSYM _PRINTER_ENUM_VALUESA}
  _PRINTER_ENUM_VALUESA = record
    pValueName: LPSTR;
    cbValueName: DWORD;
    dwType: DWORD;
    pData: LPBYTE;
    cbData: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_ENUM_VALUESW}
  _PRINTER_ENUM_VALUESW = record
    pValueName: LPWSTR;
    cbValueName: DWORD;
    dwType: DWORD;
    pData: LPBYTE;
    cbData: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_ENUM_VALUES}
  _PRINTER_ENUM_VALUES = _PRINTER_ENUM_VALUESW;
  TPrinterEnumValuesA = _PRINTER_ENUM_VALUESA;
  TPrinterEnumValuesW = _PRINTER_ENUM_VALUESW;
  TPrinterEnumValues = TPrinterEnumValuesW;
  {$EXTERNALSYM PRINTER_ENUM_VALUESA}
  PRINTER_ENUM_VALUESA = _PRINTER_ENUM_VALUESA;
  {$EXTERNALSYM PRINTER_ENUM_VALUESW}
  PRINTER_ENUM_VALUESW = _PRINTER_ENUM_VALUESW;
  {$EXTERNALSYM PRINTER_ENUM_VALUES}
  PRINTER_ENUM_VALUES = PRINTER_ENUM_VALUESW;

  PBinaryContainer = ^TBinaryContainer;
  {$EXTERNALSYM _BINARY_CONTAINER}
  _BINARY_CONTAINER = record
    cbBuf: DWORD;
    pData: LPBYTE;
  end;
  TBinaryContainer = _BINARY_CONTAINER;
  {$EXTERNALSYM BINARY_CONTAINER}
  BINARY_CONTAINER = _BINARY_CONTAINER;

  PBidiData = ^TBidiData;
  {$EXTERNALSYM _BIDI_DATA}
  _BIDI_DATA = record
    case dwBidiType: DWORD of
      BIDI_BOOL: (bData: BOOL);
      BIDI_INT: (iData: Integer);
      BIDI_STRING, BIDI_TEXT: (sData: LPWSTR);
      BIDI_FLOAT: (fData: Single);
      BIDI_BLOB: (biData: BINARY_CONTAINER);
  end;
  TBidiData = _BIDI_DATA;
  {$EXTERNALSYM BIDI_DATA}
  BIDI_DATA = _BIDI_DATA;

  PBidiRequestData = ^TBidiRequestData;
  {$EXTERNALSYM _BIDI_REQUEST_DATA}
  _BIDI_REQUEST_DATA = record
    dwReqNumber: DWORD;
    pSchema: LPWSTR;
    data: BIDI_DATA;
  end;
  TBidiRequestData = _BIDI_REQUEST_DATA;
  {$EXTERNALSYM BIDI_REQUEST_DATA}
  BIDI_REQUEST_DATA = _BIDI_REQUEST_DATA;

  PBidiRequestContainer = ^TBidiRequestContainer;
  {$EXTERNALSYM _BIDI_REQUEST_CONTAINER}
  _BIDI_REQUEST_CONTAINER = record
    Version: DWORD;
    Flags: DWORD;
    Count: DWORD;
    aData: array [0..0] of BIDI_REQUEST_DATA;
  end;
  TBidiRequestContainer = _BIDI_REQUEST_CONTAINER;
  {$EXTERNALSYM BIDI_REQUEST_CONTAINER}
  BIDI_REQUEST_CONTAINER = _BIDI_REQUEST_CONTAINER;

  PBidiResponseData = ^TBidiResponseData;
  {$EXTERNALSYM _BIDI_RESPONSE_DATA}
  _BIDI_RESPONSE_DATA = record
    dwResult: DWORD;
    dwReqNumber: DWORD;
    pSchema: LPWSTR;
    data: BIDI_DATA;
  end;
  TBidiResponseData = _BIDI_RESPONSE_DATA;
  {$EXTERNALSYM BIDI_RESPONSE_DATA}
  BIDI_RESPONSE_DATA = _BIDI_RESPONSE_DATA;

  PBidiResponseContainer = ^TBidiResponseContainer;
  {$EXTERNALSYM _BIDI_RESPONSE_CONTAINER}
  _BIDI_RESPONSE_CONTAINER = record
    Version: DWORD;
    Flags: DWORD;
    Count: DWORD;
    aData: array [0..0] of BIDI_RESPONSE_DATA;
  end;
  TBidiResponseContainer = _BIDI_RESPONSE_CONTAINER;
  {$EXTERNALSYM BIDI_RESPONSE_CONTAINER}
  BIDI_RESPONSE_CONTAINER = _BIDI_RESPONSE_CONTAINER;

  PPrinterInfo1A = ^TPrinterInfo1A;
  PPrinterInfo1W = ^TPrinterInfo1W;
  PPrinterInfo1 = PPrinterInfo1W;
  {$EXTERNALSYM _PRINTER_INFO_1A}
  _PRINTER_INFO_1A = record
    Flags: DWORD;
    pDescription: LPSTR;
    pName: LPSTR;
    pComment: LPSTR;
  end;
  {$EXTERNALSYM _PRINTER_INFO_1W}
  _PRINTER_INFO_1W = record
    Flags: DWORD;
    pDescription: LPWSTR;
    pName: LPWSTR;
    pComment: LPWSTR;
  end;
  {$EXTERNALSYM _PRINTER_INFO_1}
  _PRINTER_INFO_1 = _PRINTER_INFO_1W;
  TPrinterInfo1A = _PRINTER_INFO_1A;
  TPrinterInfo1W = _PRINTER_INFO_1W;
  TPrinterInfo1 = TPrinterInfo1W;
  {$EXTERNALSYM PRINTER_INFO_1A}
  PRINTER_INFO_1A = _PRINTER_INFO_1A;
  {$EXTERNALSYM PRINTER_INFO_1W}
  PRINTER_INFO_1W = _PRINTER_INFO_1W;
  {$EXTERNALSYM PRINTER_INFO_1}
  PRINTER_INFO_1 = PRINTER_INFO_1W;

  PPrinterInfo2A = ^TPrinterInfo2A;
  PPrinterInfo2W = ^TPrinterInfo2W;
  PPrinterInfo2 = PPrinterInfo2W;
  {$EXTERNALSYM _PRINTER_INFO_2A}
  _PRINTER_INFO_2A = record
    pServerName: LPSTR;
    pPrinterName: LPSTR;
    pShareName: LPSTR;
    pPortName: LPSTR;
    pDriverName: LPSTR;
    pComment: LPSTR;
    pLocation: LPSTR;
    pDevMode: PDeviceModeA;
    pSepFile: LPSTR;
    pPrintProcessor: LPSTR;
    pDatatype: LPSTR;
    pParameters: LPSTR;
    pSecurityDescriptor: PSecurityDescriptor;
    Attributes: DWORD;
    Priority: DWORD;
    DefaultPriority: DWORD;
    StartTime: DWORD;
    UntilTime: DWORD;
    Status: DWORD;
    cJobs: DWORD;
    AveragePPM: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_INFO_2W}
  _PRINTER_INFO_2W = record
    pServerName: LPWSTR;
    pPrinterName: LPWSTR;
    pShareName: LPWSTR;
    pPortName: LPWSTR;
    pDriverName: LPWSTR;
    pComment: LPWSTR;
    pLocation: LPWSTR;
    pDevMode: PDeviceModeW;
    pSepFile: LPWSTR;
    pPrintProcessor: LPWSTR;
    pDatatype: LPWSTR;
    pParameters: LPWSTR;
    pSecurityDescriptor: PSecurityDescriptor;
    Attributes: DWORD;
    Priority: DWORD;
    DefaultPriority: DWORD;
    StartTime: DWORD;
    UntilTime: DWORD;
    Status: DWORD;
    cJobs: DWORD;
    AveragePPM: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_INFO_2}
  _PRINTER_INFO_2 = _PRINTER_INFO_2W;
  TPrinterInfo2A = _PRINTER_INFO_2A;
  TPrinterInfo2W = _PRINTER_INFO_2W;
  TPrinterInfo2 = TPrinterInfo2W;
  {$EXTERNALSYM PRINTER_INFO_2A}
  PRINTER_INFO_2A = _PRINTER_INFO_2A;
  {$EXTERNALSYM PRINTER_INFO_2W}
  PRINTER_INFO_2W = _PRINTER_INFO_2W;
  {$EXTERNALSYM PRINTER_INFO_2}
  PRINTER_INFO_2 = PRINTER_INFO_2W;

  PPrinterInfo3 = ^TPrinterInfo3;
  {$EXTERNALSYM _PRINTER_INFO_3}
  _PRINTER_INFO_3 = record
    pSecurityDescriptor: PSecurityDescriptor;
  end;
  TPrinterInfo3 = _PRINTER_INFO_3;
  {$EXTERNALSYM PRINTER_INFO_3}
  PRINTER_INFO_3 = _PRINTER_INFO_3;

  PPrinterInfo4A = ^TPrinterInfo4A;
  PPrinterInfo4W = ^TPrinterInfo4W;
  PPrinterInfo4 = PPrinterInfo4W;
  {$EXTERNALSYM _PRINTER_INFO_4A}
  _PRINTER_INFO_4A = record
    pPrinterName: LPSTR;
    pServerName: LPSTR;
    Attributes: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_INFO_4W}
  _PRINTER_INFO_4W = record
    pPrinterName: LPWSTR;
    pServerName: LPWSTR;
    Attributes: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_INFO_4}
  _PRINTER_INFO_4 = _PRINTER_INFO_4W;
  TPrinterInfo4A = _PRINTER_INFO_4A;
  TPrinterInfo4W = _PRINTER_INFO_4W;
  TPrinterInfo4 = TPrinterInfo4W;
  {$EXTERNALSYM PRINTER_INFO_4A}
  PRINTER_INFO_4A = _PRINTER_INFO_4A;
  {$EXTERNALSYM PRINTER_INFO_4W}
  PRINTER_INFO_4W = _PRINTER_INFO_4W;
  {$EXTERNALSYM PRINTER_INFO_4}
  PRINTER_INFO_4 = PRINTER_INFO_4W;

  PPrinterInfo5A = ^TPrinterInfo5A;
  PPrinterInfo5W = ^TPrinterInfo5W;
  PPrinterInfo5 = PPrinterInfo5W;
  {$EXTERNALSYM _PRINTER_INFO_5A}
  _PRINTER_INFO_5A = record
    pPrinterName: LPSTR;
    pPortName: LPSTR;
    Attributes: DWORD;
    DeviceNotSelectedTimeout: DWORD;
    TransmissionRetryTimeout: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_INFO_5W}
  _PRINTER_INFO_5W = record
    pPrinterName: LPWSTR;
    pPortName: LPWSTR;
    Attributes: DWORD;
    DeviceNotSelectedTimeout: DWORD;
    TransmissionRetryTimeout: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_INFO_5}
  _PRINTER_INFO_5 = _PRINTER_INFO_5W;
  TPrinterInfo5A = _PRINTER_INFO_5A;
  TPrinterInfo5W = _PRINTER_INFO_5W;
  TPrinterInfo5 = TPrinterInfo5W;
  {$EXTERNALSYM PRINTER_INFO_5A}
  PRINTER_INFO_5A = _PRINTER_INFO_5A;
  {$EXTERNALSYM PRINTER_INFO_5W}
  PRINTER_INFO_5W = _PRINTER_INFO_5W;
  {$EXTERNALSYM PRINTER_INFO_5}
  PRINTER_INFO_5 = PRINTER_INFO_5W;

  PPrinterInfo6 = ^TPrinterInfo6;
  {$EXTERNALSYM _PRINTER_INFO_6}
  _PRINTER_INFO_6 = record
    dwStatus: DWORD;
  end;
  TPrinterInfo6 = _PRINTER_INFO_6;
  {$EXTERNALSYM PRINTER_INFO_6}
  PRINTER_INFO_6 = _PRINTER_INFO_6;

  PPrinterInfo7A = ^TPrinterInfo7A;
  PPrinterInfo7W = ^TPrinterInfo7W;
  PPrinterInfo7 = PPrinterInfo7W;
  {$EXTERNALSYM _PRINTER_INFO_7A}
  _PRINTER_INFO_7A = record
    pszObjectGUID: LPSTR;
    dwAction: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_INFO_7W}
  _PRINTER_INFO_7W = record
    pszObjectGUID: LPWSTR;
    dwAction: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_INFO_7}
  _PRINTER_INFO_7 = _PRINTER_INFO_7W;
  TPrinterInfo7A = _PRINTER_INFO_7A;
  TPrinterInfo7W = _PRINTER_INFO_7W;
  TPrinterInfo7 = TPrinterInfo7W;
  {$EXTERNALSYM PRINTER_INFO_7A}
  PRINTER_INFO_7A = _PRINTER_INFO_7A;
  {$EXTERNALSYM PRINTER_INFO_7W}
  PRINTER_INFO_7W = _PRINTER_INFO_7W;
  {$EXTERNALSYM PRINTER_INFO_7}
  PRINTER_INFO_7 = PRINTER_INFO_7W;

  PPrinterInfo8A = ^TPrinterInfo8A;
  PPrinterInfo8W = ^TPrinterInfo8W;
  PPrinterInfo8 = PPrinterInfo8W;
  {$EXTERNALSYM _PRINTER_INFO_8A}
  _PRINTER_INFO_8A = record
    pDevMode: PDeviceModeA;
  end;
  {$EXTERNALSYM _PRINTER_INFO_8W}
  _PRINTER_INFO_8W = record
    pDevMode: PDeviceModeW;
  end;
  {$EXTERNALSYM _PRINTER_INFO_8}
  _PRINTER_INFO_8 = _PRINTER_INFO_8W;
  TPrinterInfo8A = _PRINTER_INFO_8A;
  TPrinterInfo8W = _PRINTER_INFO_8W;
  TPrinterInfo8 = TPrinterInfo8W;
  {$EXTERNALSYM PRINTER_INFO_8A}
  PRINTER_INFO_8A = _PRINTER_INFO_8A;
  {$EXTERNALSYM PRINTER_INFO_8W}
  PRINTER_INFO_8W = _PRINTER_INFO_8W;
  {$EXTERNALSYM PRINTER_INFO_8}
  PRINTER_INFO_8 = PRINTER_INFO_8W;

  PPrinterInfo9A = ^TPrinterInfo9A;
  PPrinterInfo9W = ^TPrinterInfo9W;
  PPrinterInfo9 = PPrinterInfo9W;
  {$EXTERNALSYM _PRINTER_INFO_9A}
  _PRINTER_INFO_9A = record
    pDevMode: PDeviceModeA;
  end;
  {$EXTERNALSYM _PRINTER_INFO_9W}
  _PRINTER_INFO_9W = record
    pDevMode: PDeviceModeW;
  end;
  {$EXTERNALSYM _PRINTER_INFO_9}
  _PRINTER_INFO_9 = _PRINTER_INFO_9W;
  TPrinterInfo9A = _PRINTER_INFO_9A;
  TPrinterInfo9W = _PRINTER_INFO_9W;
  TPrinterInfo9 = TPrinterInfo9W;
  {$EXTERNALSYM PRINTER_INFO_9A}
  PRINTER_INFO_9A = _PRINTER_INFO_9A;
  {$EXTERNALSYM PRINTER_INFO_9W}
  PRINTER_INFO_9W = _PRINTER_INFO_9W;
  {$EXTERNALSYM PRINTER_INFO_9}
  PRINTER_INFO_9 = PRINTER_INFO_9W;

const
{ Action flags for SetPrinter }

  {$EXTERNALSYM DSPRINT_PUBLISH}
  DSPRINT_PUBLISH   = $00000001;
  {$EXTERNALSYM DSPRINT_UPDATE}
  DSPRINT_UPDATE    = $00000002;
  {$EXTERNALSYM DSPRINT_UNPUBLISH}
  DSPRINT_UNPUBLISH = $00000004;
  {$EXTERNALSYM DSPRINT_REPUBLISH}
  DSPRINT_REPUBLISH = $00000008;
  {$EXTERNALSYM DSPRINT_PENDING}
  DSPRINT_PENDING   = $80000000;

  {$EXTERNALSYM PRINTER_CONTROL_PAUSE}
  PRINTER_CONTROL_PAUSE            = 1;
  {$EXTERNALSYM PRINTER_CONTROL_RESUME}
  PRINTER_CONTROL_RESUME           = 2;
  {$EXTERNALSYM PRINTER_CONTROL_PURGE}
  PRINTER_CONTROL_PURGE            = 3;
  {$EXTERNALSYM PRINTER_CONTROL_SET_STATUS}
  PRINTER_CONTROL_SET_STATUS       = 4;

  {$EXTERNALSYM PRINTER_STATUS_PAUSED}
  PRINTER_STATUS_PAUSED            = $00000001;
  {$EXTERNALSYM PRINTER_STATUS_ERROR}
  PRINTER_STATUS_ERROR             = $00000002;
  {$EXTERNALSYM PRINTER_STATUS_PENDING_DELETION}
  PRINTER_STATUS_PENDING_DELETION  = $00000004;
  {$EXTERNALSYM PRINTER_STATUS_PAPER_JAM}
  PRINTER_STATUS_PAPER_JAM         = $00000008;
  {$EXTERNALSYM PRINTER_STATUS_PAPER_OUT}
  PRINTER_STATUS_PAPER_OUT         = $00000010;
  {$EXTERNALSYM PRINTER_STATUS_MANUAL_FEED}
  PRINTER_STATUS_MANUAL_FEED       = $00000020;
  {$EXTERNALSYM PRINTER_STATUS_PAPER_PROBLEM}
  PRINTER_STATUS_PAPER_PROBLEM     = $00000040;
  {$EXTERNALSYM PRINTER_STATUS_OFFLINE}
  PRINTER_STATUS_OFFLINE           = $00000080;
  {$EXTERNALSYM PRINTER_STATUS_IO_ACTIVE}
  PRINTER_STATUS_IO_ACTIVE         = $00000100;
  {$EXTERNALSYM PRINTER_STATUS_BUSY}
  PRINTER_STATUS_BUSY              = $00000200;
  {$EXTERNALSYM PRINTER_STATUS_PRINTING}
  PRINTER_STATUS_PRINTING          = $00000400;
  {$EXTERNALSYM PRINTER_STATUS_OUTPUT_BIN_FULL}
  PRINTER_STATUS_OUTPUT_BIN_FULL   = $00000800;
  {$EXTERNALSYM PRINTER_STATUS_NOT_AVAILABLE}
  PRINTER_STATUS_NOT_AVAILABLE     = $00001000;
  {$EXTERNALSYM PRINTER_STATUS_WAITING}
  PRINTER_STATUS_WAITING           = $00002000;
  {$EXTERNALSYM PRINTER_STATUS_PROCESSING}
  PRINTER_STATUS_PROCESSING        = $00004000;
  {$EXTERNALSYM PRINTER_STATUS_INITIALIZING}
  PRINTER_STATUS_INITIALIZING      = $00008000;
  {$EXTERNALSYM PRINTER_STATUS_WARMING_UP}
  PRINTER_STATUS_WARMING_UP        = $00010000;
  {$EXTERNALSYM PRINTER_STATUS_TONER_LOW}
  PRINTER_STATUS_TONER_LOW         = $00020000;
  {$EXTERNALSYM PRINTER_STATUS_NO_TONER}
  PRINTER_STATUS_NO_TONER          = $00040000;
  {$EXTERNALSYM PRINTER_STATUS_PAGE_PUNT}
  PRINTER_STATUS_PAGE_PUNT         = $00080000;
  {$EXTERNALSYM PRINTER_STATUS_USER_INTERVENTION}
  PRINTER_STATUS_USER_INTERVENTION = $00100000;
  {$EXTERNALSYM PRINTER_STATUS_OUT_OF_MEMORY}
  PRINTER_STATUS_OUT_OF_MEMORY     = $00200000;
  {$EXTERNALSYM PRINTER_STATUS_DOOR_OPEN}
  PRINTER_STATUS_DOOR_OPEN         = $00400000;
  {$EXTERNALSYM PRINTER_STATUS_SERVER_UNKNOWN}
  PRINTER_STATUS_SERVER_UNKNOWN    = $00800000;
  {$EXTERNALSYM PRINTER_STATUS_POWER_SAVE}
  PRINTER_STATUS_POWER_SAVE        = $01000000;
  {$EXTERNALSYM PRINTER_STATUS_SERVER_OFFLINE}
  PRINTER_STATUS_SERVER_OFFLINE    = $02000000;
  {$EXTERNALSYM PRINTER_STATUS_DRIVER_UPDATE_NEEDED}
  PRINTER_STATUS_DRIVER_UPDATE_NEEDED = $04000000;

  {$EXTERNALSYM PRINTER_ATTRIBUTE_QUEUED}
  PRINTER_ATTRIBUTE_QUEUED            = $00000001;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_DIRECT}
  PRINTER_ATTRIBUTE_DIRECT            = $00000002;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_DEFAULT}
  PRINTER_ATTRIBUTE_DEFAULT           = $00000004;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_SHARED}
  PRINTER_ATTRIBUTE_SHARED            = $00000008;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_NETWORK}
  PRINTER_ATTRIBUTE_NETWORK           = $00000010;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_HIDDEN}
  PRINTER_ATTRIBUTE_HIDDEN            = $00000020;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_LOCAL}
  PRINTER_ATTRIBUTE_LOCAL             = $00000040;

  {$EXTERNALSYM PRINTER_ATTRIBUTE_ENABLE_DEVQ}
  PRINTER_ATTRIBUTE_ENABLE_DEVQ       = $00000080;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS}
  PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS   = $00000100;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST}
  PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST = $00000200;

  {$EXTERNALSYM PRINTER_ATTRIBUTE_WORK_OFFLINE}
  PRINTER_ATTRIBUTE_WORK_OFFLINE      = $00000400;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_ENABLE_BIDI}
  PRINTER_ATTRIBUTE_ENABLE_BIDI       = $00000800;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_RAW_ONLY}
  PRINTER_ATTRIBUTE_RAW_ONLY          = $00001000;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_PUBLISHED}
  PRINTER_ATTRIBUTE_PUBLISHED         = $00002000;

  {$EXTERNALSYM PRINTER_ATTRIBUTE_FAX}
  PRINTER_ATTRIBUTE_FAX               = $00004000;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_TS}
  PRINTER_ATTRIBUTE_TS                = $00008000;

  { if NTDDI_VERSION >= NTDDI_VISTA }
  // The printer attribute pushed xxx bits below are used by the
  // pushing printer connection code to keep track of the type
  // of printer connection.  These bits are per user resources
  // hence the local print provider has no knowledge about these
  // bit and will not accepts them.  The remote print provider
  // is responsible for storeing and persisting these bits.
  {$EXTERNALSYM PRINTER_ATTRIBUTE_PUSHED_USER}
  PRINTER_ATTRIBUTE_PUSHED_USER       = $00020000;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_PUSHED_MACHINE}
  PRINTER_ATTRIBUTE_PUSHED_MACHINE    = $00040000;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_MACHINE}
  PRINTER_ATTRIBUTE_MACHINE           = $00080000;
  {$EXTERNALSYM PRINTER_ATTRIBUTE_FRIENDLY_NAME}
  PRINTER_ATTRIBUTE_FRIENDLY_NAME     = $00100000;

  // If the redirected TS printer is installed with generic
  // TS printer driver (TSPRINT.dll) then this attribute is set
  // by the UMRDP service and passed on to the spooler
  {$EXTERNALSYM PRINTER_ATTRIBUTE_TS_GENERIC_DRIVER}
  PRINTER_ATTRIBUTE_TS_GENERIC_DRIVER = $00200000;
  { endif //NTDDI_VERSION >= NTDDI_VISTA }


  {$EXTERNALSYM NO_PRIORITY}
  NO_PRIORITY   = 0;
  {$EXTERNALSYM MAX_PRIORITY}
  MAX_PRIORITY = 99;
  {$EXTERNALSYM MIN_PRIORITY}
  MIN_PRIORITY  = 1;
  {$EXTERNALSYM DEF_PRIORITY}
  DEF_PRIORITY  = 1;

  {$EXTERNALSYM BIDI_ACTION_ENUM_SCHEMA}
  BIDI_ACTION_ENUM_SCHEMA = 'EnumSchema';
  {$EXTERNALSYM BIDI_ACTION_GET}
  BIDI_ACTION_GET         = 'Get';
  {$EXTERNALSYM BIDI_ACTION_SET}
  BIDI_ACTION_SET         = 'Set';
  {$EXTERNALSYM BIDI_ACTION_GET_ALL}
  BIDI_ACTION_GET_ALL     = 'GetAll';

  {$EXTERNALSYM BIDI_ACCESS_ADMINISTRATOR}
  BIDI_ACCESS_ADMINISTRATOR  = $1;
  {$EXTERNALSYM BIDI_ACCESS_USER}
  BIDI_ACCESS_USER           = $2;


{ Error code for bidi APIs }

  {$EXTERNALSYM ERROR_BIDI_STATUS_OK}
  ERROR_BIDI_STATUS_OK            = 0;
  {$EXTERNALSYM ERROR_BIDI_NOT_SUPPORTED}
  ERROR_BIDI_NOT_SUPPORTED        = ERROR_NOT_SUPPORTED;

  {$EXTERNALSYM ERROR_BIDI_ERROR_BASE}
  ERROR_BIDI_ERROR_BASE           = 13000;
  {$EXTERNALSYM ERROR_BIDI_STATUS_WARNING}
  ERROR_BIDI_STATUS_WARNING       = ERROR_BIDI_ERROR_BASE + 1;
  {$EXTERNALSYM ERROR_BIDI_SCHEMA_READ_ONLY}
  ERROR_BIDI_SCHEMA_READ_ONLY     = ERROR_BIDI_ERROR_BASE + 2;
  {$EXTERNALSYM ERROR_BIDI_SERVER_OFFLINE}
  ERROR_BIDI_SERVER_OFFLINE       = ERROR_BIDI_ERROR_BASE + 3;
  {$EXTERNALSYM ERROR_BIDI_DEVICE_OFFLINE}
  ERROR_BIDI_DEVICE_OFFLINE       = ERROR_BIDI_ERROR_BASE + 4;
  {$EXTERNALSYM ERROR_BIDI_SCHEMA_NOT_SUPPORTED}
  ERROR_BIDI_SCHEMA_NOT_SUPPORTED = ERROR_BIDI_ERROR_BASE + 5;

type
  PJobInfo1A = ^TJobInfo1A;
  PJobInfo1W = ^TJobInfo1W;
  PJobInfo1 = PJobInfo1W;
  {$EXTERNALSYM _JOB_INFO_1A}
  _JOB_INFO_1A = record
   JobId: DWORD;
   pPrinterName: LPSTR;
   pMachineName: LPSTR;
   pUserName: LPSTR;
   pDocument: LPSTR;
   pDatatype: LPSTR;
   pStatus: LPSTR;
   Status: DWORD;
   Priority: DWORD;
   Position: DWORD;
   TotalPages: DWORD;
   PagesPrinted: DWORD;
   Submitted: TSystemTime;
  end;
  {$EXTERNALSYM _JOB_INFO_1W}
  _JOB_INFO_1W = record
   JobId: DWORD;
   pPrinterName: LPWSTR;
   pMachineName: LPWSTR;
   pUserName: LPWSTR;
   pDocument: LPWSTR;
   pDatatype: LPWSTR;
   pStatus: LPWSTR;
   Status: DWORD;
   Priority: DWORD;
   Position: DWORD;
   TotalPages: DWORD;
   PagesPrinted: DWORD;
   Submitted: TSystemTime;
  end;
  {$EXTERNALSYM _JOB_INFO_1}
  _JOB_INFO_1 = _JOB_INFO_1W;
  TJobInfo1A = _JOB_INFO_1A;
  TJobInfo1W = _JOB_INFO_1W;
  TJobInfo1 = TJobInfo1W;
  {$EXTERNALSYM JOB_INFO_1A}
  JOB_INFO_1A = _JOB_INFO_1A;
  {$EXTERNALSYM JOB_INFO_1W}
  JOB_INFO_1W = _JOB_INFO_1W;
  {$EXTERNALSYM JOB_INFO_1}
  JOB_INFO_1 = JOB_INFO_1W;

  PJobInfo2A = ^TJobInfo2A;
  PJobInfo2W = ^TJobInfo2W;
  PJobInfo2 = PJobInfo2W;
  {$EXTERNALSYM _JOB_INFO_2A}
  _JOB_INFO_2A = record
   JobId: DWORD;
   pPrinterName: LPSTR;
   pMachineName: LPSTR;
   pUserName: LPSTR;
   pDocument: LPSTR;
   pNotifyName: LPSTR;
   pDatatype: LPSTR;
   pPrintProcessor: LPSTR;
   pParameters: LPSTR;
   pDriverName: LPSTR;
   pDevMode: PDeviceModeA;
   pStatus: LPSTR;
   pSecurityDescriptor: PSECURITY_DESCRIPTOR;
   Status: DWORD;
   Priority: DWORD;
   Position: DWORD;
   StartTime: DWORD;
   UntilTime: DWORD;
   TotalPages: DWORD;
   Size: DWORD;
   Submitted: TSystemTime;   { Time the job was spooled }
   Time: DWORD;              { How many seconds the job has been printing }
   PagesPrinted: DWORD;
  end;
  {$EXTERNALSYM _JOB_INFO_2W}
  _JOB_INFO_2W = record
   JobId: DWORD;
   pPrinterName: LPWSTR;
   pMachineName: LPWSTR;
   pUserName: LPWSTR;
   pDocument: LPWSTR;
   pNotifyName: LPWSTR;
   pDatatype: LPWSTR;
   pPrintProcessor: LPWSTR;
   pParameters: LPWSTR;
   pDriverName: LPWSTR;
   pDevMode: PDeviceModeW;
   pStatus: LPWSTR;
   pSecurityDescriptor: PSECURITY_DESCRIPTOR;
   Status: DWORD;
   Priority: DWORD;
   Position: DWORD;
   StartTime: DWORD;
   UntilTime: DWORD;
   TotalPages: DWORD;
   Size: DWORD;
   Submitted: TSystemTime;   { Time the job was spooled }
   Time: DWORD;              { How many seconds the job has been printing }
   PagesPrinted: DWORD;
  end;
  {$EXTERNALSYM _JOB_INFO_2}
  _JOB_INFO_2 = _JOB_INFO_2W;
  TJobInfo2A = _JOB_INFO_2A;
  TJobInfo2W = _JOB_INFO_2W;
  TJobInfo2 = TJobInfo2W;
  {$EXTERNALSYM JOB_INFO_2A}
  JOB_INFO_2A = _JOB_INFO_2A;
  {$EXTERNALSYM JOB_INFO_2W}
  JOB_INFO_2W = _JOB_INFO_2W;
  {$EXTERNALSYM JOB_INFO_2}
  JOB_INFO_2 = JOB_INFO_2W;

  PJobInfo3 = ^TJobInfo3;
  {$EXTERNALSYM _JOB_INFO_3}
  _JOB_INFO_3 = record
    JobId: DWORD;
    NextJobId: DWORD;
    Reserved: DWORD;
  end;
  TJobInfo3 = _JOB_INFO_3;
  {$EXTERNALSYM JOB_INFO_3}
  JOB_INFO_3 = _JOB_INFO_3;

const
  {$EXTERNALSYM JOB_CONTROL_PAUSE}
  JOB_CONTROL_PAUSE              = 1;
  {$EXTERNALSYM JOB_CONTROL_RESUME}
  JOB_CONTROL_RESUME             = 2;
  {$EXTERNALSYM JOB_CONTROL_CANCEL}
  JOB_CONTROL_CANCEL             = 3;
  {$EXTERNALSYM JOB_CONTROL_RESTART}
  JOB_CONTROL_RESTART            = 4;
  {$EXTERNALSYM JOB_CONTROL_DELETE}
  JOB_CONTROL_DELETE             = 5;
  {$EXTERNALSYM JOB_CONTROL_SENT_TO_PRINTER}
  JOB_CONTROL_SENT_TO_PRINTER    = 6;
  {$EXTERNALSYM JOB_CONTROL_LAST_PAGE_EJECTED}
  JOB_CONTROL_LAST_PAGE_EJECTED  = 7;

  { if NTDDI_VERSION >= NTDDI_VISTA }
  {$EXTERNALSYM JOB_CONTROL_RETAIN}
  JOB_CONTROL_RETAIN             = 8;
  {$EXTERNALSYM JOB_CONTROL_RELEASE}
  JOB_CONTROL_RELEASE            = 9;
  { endif //NTDDI_VERSION >= NTDDI_VISTA }

  {$EXTERNALSYM JOB_STATUS_PAUSED}
  JOB_STATUS_PAUSED                   = $00000001;
  {$EXTERNALSYM JOB_STATUS_ERROR}
  JOB_STATUS_ERROR                    = $00000002;
  {$EXTERNALSYM JOB_STATUS_DELETING}
  JOB_STATUS_DELETING                 = $00000004;
  {$EXTERNALSYM JOB_STATUS_SPOOLING}
  JOB_STATUS_SPOOLING                 = $00000008;
  {$EXTERNALSYM JOB_STATUS_PRINTING}
  JOB_STATUS_PRINTING                 = $00000010;
  {$EXTERNALSYM JOB_STATUS_OFFLINE}
  JOB_STATUS_OFFLINE                  = $00000020;
  {$EXTERNALSYM JOB_STATUS_PAPEROUT}
  JOB_STATUS_PAPEROUT                 = $00000040;
  {$EXTERNALSYM JOB_STATUS_PRINTED}
  JOB_STATUS_PRINTED                  = $00000080;
  {$EXTERNALSYM JOB_STATUS_DELETED}
  JOB_STATUS_DELETED                  = $00000100;
  {$EXTERNALSYM JOB_STATUS_BLOCKED_DEVQ}
  JOB_STATUS_BLOCKED_DEVQ             = $00000200;
  {$EXTERNALSYM JOB_STATUS_USER_INTERVENTION}
  JOB_STATUS_USER_INTERVENTION        = $00000400;
  {$EXTERNALSYM JOB_STATUS_RESTART}
  JOB_STATUS_RESTART                  = $00000800;

  {$EXTERNALSYM JOB_STATUS_COMPLETE}
  JOB_STATUS_COMPLETE                 = $00001000;

  {$EXTERNALSYM JOB_STATUS_RETAINED}
  JOB_STATUS_RETAINED                 = $00002000;
  {$EXTERNALSYM JOB_STATUS_RENDERING_LOCALLY}
  JOB_STATUS_RENDERING_LOCALLY        = $00004000;

  {$EXTERNALSYM JOB_POSITION_UNSPECIFIED}
  JOB_POSITION_UNSPECIFIED       = 0;

type
  PAddJobInfo1A = ^TAddJobInfo1A;
  PAddJobInfo1W = ^TAddJobInfo1W;
  PAddJobInfo1 = PAddJobInfo1W;
  {$EXTERNALSYM _ADDJOB_INFO_1A}
  _ADDJOB_INFO_1A = record
    Path: LPSTR;
    JobId: DWORD;
  end;
  {$EXTERNALSYM _ADDJOB_INFO_1W}
  _ADDJOB_INFO_1W = record
    Path: LPWSTR;
    JobId: DWORD;
  end;
  {$EXTERNALSYM _ADDJOB_INFO_1}
  _ADDJOB_INFO_1 = _ADDJOB_INFO_1W;
  TAddJobInfo1A = _ADDJOB_INFO_1A;
  TAddJobInfo1W = _ADDJOB_INFO_1W;
  TAddJobInfo1 = TAddJobInfo1W;
  {$EXTERNALSYM ADDJOB_INFO_1A}
  ADDJOB_INFO_1A = _ADDJOB_INFO_1A;
  {$EXTERNALSYM ADDJOB_INFO_1W}
  ADDJOB_INFO_1W = _ADDJOB_INFO_1W;
  {$EXTERNALSYM ADDJOB_INFO_1}
  ADDJOB_INFO_1 = ADDJOB_INFO_1W;

  PDriverInfo1A = ^TDriverInfo1A;
  PDriverInfo1W = ^TDriverInfo1W;
  PDriverInfo1 = PDriverInfo1W;
  {$EXTERNALSYM _DRIVER_INFO_1A}
  _DRIVER_INFO_1A = record
    pName: LPSTR;              { QMS 810 }
  end;
  {$EXTERNALSYM _DRIVER_INFO_1W}
  _DRIVER_INFO_1W = record
    pName: LPWSTR;              { QMS 810 }
  end;
  {$EXTERNALSYM _DRIVER_INFO_1}
  _DRIVER_INFO_1 = _DRIVER_INFO_1W;
  TDriverInfo1A = _DRIVER_INFO_1A;
  TDriverInfo1W = _DRIVER_INFO_1W;
  TDriverInfo1 = TDriverInfo1W;
  {$EXTERNALSYM DRIVER_INFO_1A}
  DRIVER_INFO_1A = _DRIVER_INFO_1A;
  {$EXTERNALSYM DRIVER_INFO_1W}
  DRIVER_INFO_1W = _DRIVER_INFO_1W;
  {$EXTERNALSYM DRIVER_INFO_1}
  DRIVER_INFO_1 = DRIVER_INFO_1W;

  PDriverInfo2A = ^TDriverInfo2A;
  PDriverInfo2W = ^TDriverInfo2W;
  PDriverInfo2 = PDriverInfo2W;
  {$EXTERNALSYM _DRIVER_INFO_2A}
  _DRIVER_INFO_2A = record
    cVersion: DWORD;
    pName: LPSTR;              { QMS 810 }
    pEnvironment: LPSTR;       { Win32 x86 }
    pDriverPath: LPSTR;        { c:\drivers\pscript.dll }
    pDataFile: LPSTR;          { c:\drivers\QMS810.PPD }
    pConfigFile: LPSTR;        { c:\drivers\PSCRPTUI.DLL }
  end;
  {$EXTERNALSYM _DRIVER_INFO_2W}
  _DRIVER_INFO_2W = record
    cVersion: DWORD;
    pName: LPWSTR;              { QMS 810 }
    pEnvironment: LPWSTR;       { Win32 x86 }
    pDriverPath: LPWSTR;        { c:\drivers\pscript.dll }
    pDataFile: LPWSTR;          { c:\drivers\QMS810.PPD }
    pConfigFile: LPWSTR;        { c:\drivers\PSCRPTUI.DLL }
  end;
  {$EXTERNALSYM _DRIVER_INFO_2}
  _DRIVER_INFO_2 = _DRIVER_INFO_2W;
  TDriverInfo2A = _DRIVER_INFO_2A;
  TDriverInfo2W = _DRIVER_INFO_2W;
  TDriverInfo2 = TDriverInfo2W;
  {$EXTERNALSYM DRIVER_INFO_2A}
  DRIVER_INFO_2A = _DRIVER_INFO_2A;
  {$EXTERNALSYM DRIVER_INFO_2W}
  DRIVER_INFO_2W = _DRIVER_INFO_2W;
  {$EXTERNALSYM DRIVER_INFO_2}
  DRIVER_INFO_2 = DRIVER_INFO_2W;

  PDriverInfo3A = ^TDriverInfo3A;
  PDriverInfo3W = ^TDriverInfo3W;
  PDriverInfo3 = PDriverInfo3W;
  {$EXTERNALSYM _DRIVER_INFO_3A}
  _DRIVER_INFO_3A = record
    cVersion: DWORD;
    pName: LPSTR;                    { QMS 810 }
    pEnvironment: LPSTR;             { Win32 x86 }
    pDriverPath: LPSTR;              { c:\drivers\pscript.dll }
    pDataFile: LPSTR;                { c:\drivers\QMS810.PPD }
    pConfigFile: LPSTR;              { c:\drivers\PSCRPTUI.DLL }
    pHelpFile: LPSTR;                { c:\drivers\PSCRPTUI.HLP }
    pDependentFiles: LPSTR;          { PSCRIPT.DLL\0QMS810.PPD\0PSCRIPTUI.DLL\0PSCRIPTUI.HLP\0PSTEST.TXT\0\0 }
    pMonitorName: LPSTR;             { "PJL monitor" }
    pDefaultDataType: LPSTR;         { "EMF" }
  end;
  {$EXTERNALSYM _DRIVER_INFO_3W}
  _DRIVER_INFO_3W = record
    cVersion: DWORD;
    pName: LPWSTR;                    { QMS 810 }
    pEnvironment: LPWSTR;             { Win32 x86 }
    pDriverPath: LPWSTR;              { c:\drivers\pscript.dll }
    pDataFile: LPWSTR;                { c:\drivers\QMS810.PPD }
    pConfigFile: LPWSTR;              { c:\drivers\PSCRPTUI.DLL }
    pHelpFile: LPWSTR;                { c:\drivers\PSCRPTUI.HLP }
    pDependentFiles: LPWSTR;          { PSCRIPT.DLL\0QMS810.PPD\0PSCRIPTUI.DLL\0PSCRIPTUI.HLP\0PSTEST.TXT\0\0 }
    pMonitorName: LPWSTR;             { "PJL monitor" }
    pDefaultDataType: LPWSTR;         { "EMF" }
  end;
  {$EXTERNALSYM _DRIVER_INFO_3}
  _DRIVER_INFO_3 = _DRIVER_INFO_3W;
  TDriverInfo3A = _DRIVER_INFO_3A;
  TDriverInfo3W = _DRIVER_INFO_3W;
  TDriverInfo3 = TDriverInfo3W;
  {$EXTERNALSYM DRIVER_INFO_3A}
  DRIVER_INFO_3A = _DRIVER_INFO_3A;
  {$EXTERNALSYM DRIVER_INFO_3W}
  DRIVER_INFO_3W = _DRIVER_INFO_3W;
  {$EXTERNALSYM DRIVER_INFO_3}
  DRIVER_INFO_3 = DRIVER_INFO_3W;

  PDriverInfo4A = ^TDriverInfo4A;
  PDriverInfo4W = ^TDriverInfo4W;
  PDriverInfo4 = PDriverInfo4W;
  {$EXTERNALSYM _DRIVER_INFO_4A}
  _DRIVER_INFO_4A = record
    cVersion: DWORD;
    pName: LPSTR;
    pEnvironment: LPSTR;
    pDriverPath: LPSTR;
    pDataFile: LPSTR;
    pConfigFile: LPSTR;
    pHelpFile: LPSTR;
    pDependentFiles: LPSTR;
    pMonitorName: LPSTR;
    pDefaultDataType: LPSTR;
    pszzPreviousNames: LPSTR;
  end;
  {$EXTERNALSYM _DRIVER_INFO_4W}
  _DRIVER_INFO_4W = record
    cVersion: DWORD;
    pName: LPWSTR;
    pEnvironment: LPWSTR;
    pDriverPath: LPWSTR;
    pDataFile: LPWSTR;
    pConfigFile: LPWSTR;
    pHelpFile: LPWSTR;
    pDependentFiles: LPWSTR;
    pMonitorName: LPWSTR;
    pDefaultDataType: LPWSTR;
    pszzPreviousNames: LPWSTR;
  end;
  {$EXTERNALSYM _DRIVER_INFO_4}
  _DRIVER_INFO_4 = _DRIVER_INFO_4W;
  TDriverInfo4A = _DRIVER_INFO_4A;
  TDriverInfo4W = _DRIVER_INFO_4W;
  TDriverInfo4 = TDriverInfo4W;
  {$EXTERNALSYM DRIVER_INFO_4A}
  DRIVER_INFO_4A = _DRIVER_INFO_4A;
  {$EXTERNALSYM DRIVER_INFO_4W}
  DRIVER_INFO_4W = _DRIVER_INFO_4W;
  {$EXTERNALSYM DRIVER_INFO_4}
  DRIVER_INFO_4 = DRIVER_INFO_4W;

  PDriverInfo5A = ^TDriverInfo5A;
  PDriverInfo5W = ^TDriverInfo5W;
  PDriverInfo5 = PDriverInfo5W;
  {$EXTERNALSYM _DRIVER_INFO_5A}
  _DRIVER_INFO_5A = record
    cVersion: DWORD;
    pName: LPSTR;
    pEnvironment: LPSTR;
    pDriverPath: LPSTR;
    pDataFile: LPSTR;
    pConfigFile: LPSTR;
    dwDriverAttributes: DWORD;
    dwConfigVersion: DWORD;
    dwDriverVersion: DWORD;
  end;
  {$EXTERNALSYM _DRIVER_INFO_5W}
  _DRIVER_INFO_5W = record
    cVersion: DWORD;
    pName: LPWSTR;
    pEnvironment: LPWSTR;
    pDriverPath: LPWSTR;
    pDataFile: LPWSTR;
    pConfigFile: LPWSTR;
    dwDriverAttributes: DWORD;
    dwConfigVersion: DWORD;
    dwDriverVersion: DWORD;
  end;
  {$EXTERNALSYM _DRIVER_INFO_5}
  _DRIVER_INFO_5 = _DRIVER_INFO_5W;
  TDriverInfo5A = _DRIVER_INFO_5A;
  TDriverInfo5W = _DRIVER_INFO_5W;
  TDriverInfo5 = TDriverInfo5W;
  {$EXTERNALSYM DRIVER_INFO_5A}
  DRIVER_INFO_5A = _DRIVER_INFO_5A;
  {$EXTERNALSYM DRIVER_INFO_5W}
  DRIVER_INFO_5W = _DRIVER_INFO_5W;
  {$EXTERNALSYM DRIVER_INFO_5}
  DRIVER_INFO_5 = DRIVER_INFO_5W;

  PDriverInfo6A = ^TDriverInfo6A;
  PDriverInfo6W = ^TDriverInfo6W;
  PDriverInfo6 = PDriverInfo6W;
  {$EXTERNALSYM _DRIVER_INFO_6A}
  _DRIVER_INFO_6A = record
    cVersion: DWORD;
    pName: LPSTR;
    pEnvironment: LPSTR;
    pDriverPath: LPSTR;
    pDataFile: LPSTR;
    pConfigFile: LPSTR;
    pHelpFile: LPSTR;
    pDependentFiles: LPSTR;
    pMonitorName: LPSTR;
    pDefaultDataType: LPSTR;
    pszzPreviousNames: LPSTR;
    ftDriverDate: FILETIME;
    dwlDriverVersion: DWORDLONG;
    pszMfgName: LPSTR;
    pszOEMUrl: LPSTR;
    pszHardwareID: LPSTR;
    pszProvider: LPSTR;
  end;
  {$EXTERNALSYM _DRIVER_INFO_6W}
  _DRIVER_INFO_6W = record
    cVersion: DWORD;
    pName: LPWSTR;
    pEnvironment: LPWSTR;
    pDriverPath: LPWSTR;
    pDataFile: LPWSTR;
    pConfigFile: LPWSTR;
    pHelpFile: LPWSTR;
    pDependentFiles: LPWSTR;
    pMonitorName: LPWSTR;
    pDefaultDataType: LPWSTR;
    pszzPreviousNames: LPWSTR;
    ftDriverDate: FILETIME;
    dwlDriverVersion: DWORDLONG;
    pszMfgName: LPWSTR;
    pszOEMUrl: LPWSTR;
    pszHardwareID: LPWSTR;
    pszProvider: LPWSTR;
  end;
  {$EXTERNALSYM _DRIVER_INFO_6}
  _DRIVER_INFO_6 = _DRIVER_INFO_6W;
  TDriverInfo6A = _DRIVER_INFO_6A;
  TDriverInfo6W = _DRIVER_INFO_6W;
  TDriverInfo6 = TDriverInfo6W;
  {$EXTERNALSYM DRIVER_INFO_6A}
  DRIVER_INFO_6A = _DRIVER_INFO_6A;
  {$EXTERNALSYM DRIVER_INFO_6W}
  DRIVER_INFO_6W = _DRIVER_INFO_6W;
  {$EXTERNALSYM DRIVER_INFO_6}
  DRIVER_INFO_6 = DRIVER_INFO_6W;

  PDriverInfo8A = ^TDriverInfo8A;
  PDriverInfo8W = ^TDriverInfo8W;
  PDriverInfo8 = PDriverInfo8W;
  {$EXTERNALSYM _DRIVER_INFO_8A}
  _DRIVER_INFO_8A = record
    cVersion: DWORD;
    pName: LPSTR;
    pEnvironment: LPSTR;
    pDriverPath: LPSTR;
    pDataFile: LPSTR;
    pConfigFile: LPSTR;
    pHelpFile: LPSTR;
    pDependentFiles: LPSTR;
    pMonitorName: LPSTR;
    pDefaultDataType: LPSTR;
    pszzPreviousNames: LPSTR;
    ftDriverDate: FILETIME;
    dwlDriverVersion: DWORDLONG;
    pszMfgName: LPSTR;
    pszOEMUrl: LPSTR;
    pszHardwareID: LPSTR;
    pszProvider: LPSTR;
    pszPrintProcessor: LPSTR;
    pszVendorSetup: LPSTR;
    pszzColorProfiles: LPSTR;
    pszInfPath: LPSTR;
    dwPrinterDriverAttributes: DWORD;
    pszzCodeDriverDependencies: LPSTR;
    ftMinInboxDriverVerDate: FILETIME;
    dwlMinInboxDriverVerVersion: DWORDLONG;
  end;
  {$EXTERNALSYM _DRIVER_INFO_8W}
  _DRIVER_INFO_8W = record
    cVersion: DWORD;
    pName: LPWSTR;
    pEnvironment: LPWSTR;
    pDriverPath: LPWSTR;
    pDataFile: LPWSTR;
    pConfigFile: LPWSTR;
    pHelpFile: LPWSTR;
    pDependentFiles: LPWSTR;
    pMonitorName: LPWSTR;
    pDefaultDataType: LPWSTR;
    pszzPreviousNames: LPWSTR;
    ftDriverDate: FILETIME;
    dwlDriverVersion: DWORDLONG;
    pszMfgName: LPWSTR;
    pszOEMUrl: LPWSTR;
    pszHardwareID: LPWSTR;
    pszProvider: LPWSTR;
    pszPrintProcessor: LPWSTR;
    pszVendorSetup: LPWSTR;
    pszzColorProfiles: LPWSTR;
    pszInfPath: LPWSTR;
    dwPrinterDriverAttributes: DWORD;
    pszzCodeDriverDependencies: LPWSTR;
    ftMinInboxDriverVerDate: FILETIME;
    dwlMinInboxDriverVerVersion: DWORDLONG;
  end;
  {$EXTERNALSYM _DRIVER_INFO_8}
  _DRIVER_INFO_8 = _DRIVER_INFO_8W;
  TDriverInfo8A = _DRIVER_INFO_8A;
  TDriverInfo8W = _DRIVER_INFO_8W;
  TDriverInfo8 = TDriverInfo8W;
  {$EXTERNALSYM DRIVER_INFO_8A}
  DRIVER_INFO_8A = _DRIVER_INFO_8A;
  {$EXTERNALSYM DRIVER_INFO_8W}
  DRIVER_INFO_8W = _DRIVER_INFO_8W;
  {$EXTERNALSYM DRIVER_INFO_8}
  DRIVER_INFO_8 = DRIVER_INFO_8W;

  PCorePrinterDriverA = ^TCorePrinterDriverA;
  PCorePrinterDriverW = ^TCorePrinterDriverW;
  PCorePrinterDriver = PCorePrinterDriverW;
  {$EXTERNALSYM _CORE_PRINTER_DRIVERA}
  _CORE_PRINTER_DRIVERA = record
    CoreDriverGUID: TGUID;
    ftDriverDate: FILETIME;
    dwlDriverVersion: DWORDLONG;
    szPackageID: array [0..MAX_PATH - 1] of AnsiChar;
  end;
  {$EXTERNALSYM _CORE_PRINTER_DRIVERW}
  _CORE_PRINTER_DRIVERW = record
    CoreDriverGUID: TGUID;
    ftDriverDate: FILETIME;
    dwlDriverVersion: DWORDLONG;
    szPackageID: array [0..MAX_PATH - 1] of WideChar;
  end;
  {$EXTERNALSYM _CORE_PRINTER_DRIVER}
  _CORE_PRINTER_DRIVER = _CORE_PRINTER_DRIVERW;
  TCorePrinterDriverA = _CORE_PRINTER_DRIVERA;
  TCorePrinterDriverW = _CORE_PRINTER_DRIVERW;
  TCorePrinterDriver = TCorePrinterDriverW;
  {$EXTERNALSYM CORE_PRINTER_DRIVERA}
  CORE_PRINTER_DRIVERA = _CORE_PRINTER_DRIVERA;
  {$EXTERNALSYM CORE_PRINTER_DRIVERW}
  CORE_PRINTER_DRIVERW = _CORE_PRINTER_DRIVERW;
  {$EXTERNALSYM CORE_PRINTER_DRIVER}
  CORE_PRINTER_DRIVER = CORE_PRINTER_DRIVERW;

  PDocInfo1A = ^TDocInfo1A;
  PDocInfo1W = ^TDocInfo1W;
  PDocInfo1 = PDocInfo1W;
  {$EXTERNALSYM _DOC_INFO_1A}
  _DOC_INFO_1A = record
    pDocName: LPSTR;
    pOutputFile: LPSTR;
    pDatatype: LPSTR;
  end;
  {$EXTERNALSYM _DOC_INFO_1W}
  _DOC_INFO_1W = record
    pDocName: LPWSTR;
    pOutputFile: LPWSTR;
    pDatatype: LPWSTR;
  end;
  {$EXTERNALSYM _DOC_INFO_1}
  _DOC_INFO_1 = _DOC_INFO_1W;
  TDocInfo1A = _DOC_INFO_1A;
  TDocInfo1W = _DOC_INFO_1W;
  TDocInfo1 = TDocInfo1W;
  {$EXTERNALSYM DOC_INFO_1A}
  DOC_INFO_1A = _DOC_INFO_1A;
  {$EXTERNALSYM DOC_INFO_1W}
  DOC_INFO_1W = _DOC_INFO_1W;
  {$EXTERNALSYM DOC_INFO_1}
  DOC_INFO_1 = DOC_INFO_1W;

  PFormInfo1A = ^TFormInfo1A;
  PFormInfo1W = ^TFormInfo1W;
  PFormInfo1 = PFormInfo1W;
  {$EXTERNALSYM _FORM_INFO_1A}
  _FORM_INFO_1A = record
    Flags: DWORD;
    pName: LPSTR;
    Size: TSize;
    ImageableArea: TRect;
  end;
  {$EXTERNALSYM _FORM_INFO_1W}
  _FORM_INFO_1W = record
    Flags: DWORD;
    pName: LPWSTR;
    Size: TSize;
    ImageableArea: TRect;
  end;
  {$EXTERNALSYM _FORM_INFO_1}
  _FORM_INFO_1 = _FORM_INFO_1W;
  TFormInfo1A = _FORM_INFO_1A;
  TFormInfo1W = _FORM_INFO_1W;
  TFormInfo1 = TFormInfo1W;
  {$EXTERNALSYM FORM_INFO_1A}
  FORM_INFO_1A = _FORM_INFO_1A;
  {$EXTERNALSYM FORM_INFO_1W}
  FORM_INFO_1W = _FORM_INFO_1W;
  {$EXTERNALSYM FORM_INFO_1}
  FORM_INFO_1 = FORM_INFO_1W;

  PDocInfo2A = ^TDocInfo2A;
  PDocInfo2W = ^TDocInfo2W;
  PDocInfo2 = PDocInfo2W;
  {$EXTERNALSYM _DOC_INFO_2A}
  _DOC_INFO_2A = record
    pDocName: LPSTR;
    pOutputFile: LPSTR;
    pDatatype: LPSTR;
    dwMode: DWORD;
    JobId: DWORD;
  end;
  {$EXTERNALSYM _DOC_INFO_2W}
  _DOC_INFO_2W = record
    pDocName: LPWSTR;
    pOutputFile: LPWSTR;
    pDatatype: LPWSTR;
    dwMode: DWORD;
    JobId: DWORD;
  end;
  {$EXTERNALSYM _DOC_INFO_2}
  _DOC_INFO_2 = _DOC_INFO_2W;
  TDocInfo2A = _DOC_INFO_2A;
  TDocInfo2W = _DOC_INFO_2W;
  TDocInfo2 = TDocInfo2W;
  {$EXTERNALSYM DOC_INFO_2A}
  DOC_INFO_2A = _DOC_INFO_2A;
  {$EXTERNALSYM DOC_INFO_2W}
  DOC_INFO_2W = _DOC_INFO_2W;
  {$EXTERNALSYM DOC_INFO_2}
  DOC_INFO_2 = DOC_INFO_2W;

  PDocInfo3A = ^TDocInfo3A;
  PDocInfo3W = ^TDocInfo3W;
  PDocInfo3 = PDocInfo3W;
  {$EXTERNALSYM _DOC_INFO_3A}
  _DOC_INFO_3A = record
    pDocName: LPSTR;
    pOutputFile: LPSTR;
    pDatatype: LPSTR;
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _DOC_INFO_3W}
  _DOC_INFO_3W = record
    pDocName: LPWSTR;
    pOutputFile: LPWSTR;
    pDatatype: LPWSTR;
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _DOC_INFO_3}
  _DOC_INFO_3 = _DOC_INFO_3W;
  TDocInfo3A = _DOC_INFO_3A;
  TDocInfo3W = _DOC_INFO_3W;
  TDocInfo3 = TDocInfo3W;
  {$EXTERNALSYM DOC_INFO_3A}
  DOC_INFO_3A = _DOC_INFO_3A;
  {$EXTERNALSYM DOC_INFO_3W}
  DOC_INFO_3W = _DOC_INFO_3W;
  {$EXTERNALSYM DOC_INFO_3}
  DOC_INFO_3 = DOC_INFO_3W;

const
{ Flags for dwDriverAttributes }

  {$EXTERNALSYM DRIVER_KERNELMODE}
  DRIVER_KERNELMODE = $00000001;
  {$EXTERNALSYM DRIVER_USERMODE}
  DRIVER_USERMODE   = $00000002;

{ FLAGS for DeletePrinterDriverEx. }

  {$EXTERNALSYM DPD_DELETE_UNUSED_FILES}
  DPD_DELETE_UNUSED_FILES = $00000001;
  {$EXTERNALSYM DPD_DELETE_SPECIFIC_VERSION}
  DPD_DELETE_SPECIFIC_VERSION = $00000002;
  {$EXTERNALSYM DPD_DELETE_ALL_FILES}
  DPD_DELETE_ALL_FILES = $00000004;

{ Flags for AddPrinterDriverEx }

  {$EXTERNALSYM APD_STRICT_UPGRADE}
  APD_STRICT_UPGRADE      = $00000001;
  {$EXTERNALSYM APD_STRICT_DOWNGRADE}
  APD_STRICT_DOWNGRADE    = $00000002;
  {$EXTERNALSYM APD_COPY_ALL_FILES}
  APD_COPY_ALL_FILES      = $00000004;
  {$EXTERNALSYM APD_COPY_NEW_FILES}
  APD_COPY_NEW_FILES      = $00000008;
  {$EXTERNALSYM APD_COPY_FROM_DIRECTORY}
  APD_COPY_FROM_DIRECTORY = $00000010;

  {$EXTERNALSYM DI_CHANNEL}
  DI_CHANNEL              = 1;    { start direct read/write channel, }
  {$EXTERNALSYM DI_READ_SPOOL_JOB}
  DI_READ_SPOOL_JOB       = 3;
  {$EXTERNALSYM DI_MEMORYMAP_WRITE}
  DI_MEMORYMAP_WRITE      = $00000001;

  {$EXTERNALSYM FORM_USER}
  FORM_USER           = $00000000;
  {$EXTERNALSYM FORM_BUILTIN}
  FORM_BUILTIN        = $00000001;
  {$EXTERNALSYM FORM_PRINTER}
  FORM_PRINTER        = $00000002;

  {$EXTERNALSYM NORMAL_PRINT}
  NORMAL_PRINT    = $00000000;
  {$EXTERNALSYM REVERSE_PRINT}
  REVERSE_PRINT   = $00000001;

type
  PPrintProcessorInfo1A = ^TPrintProcessorInfo1A;
  PPrintProcessorInfo1W = ^TPrintProcessorInfo1W;
  PPrintProcessorInfo1 = PPrintProcessorInfo1W;
  {$EXTERNALSYM _PRINTPROCESSOR_INFO_1A}
  _PRINTPROCESSOR_INFO_1A = record
    pName: LPSTR;
  end;
  {$EXTERNALSYM _PRINTPROCESSOR_INFO_1W}
  _PRINTPROCESSOR_INFO_1W = record
    pName: LPWSTR;
  end;
  {$EXTERNALSYM _PRINTPROCESSOR_INFO_1}
  _PRINTPROCESSOR_INFO_1 = _PRINTPROCESSOR_INFO_1W;
  TPrintProcessorInfo1A = _PRINTPROCESSOR_INFO_1A;
  TPrintProcessorInfo1W = _PRINTPROCESSOR_INFO_1W;
  TPrintProcessorInfo1 = TPrintProcessorInfo1W;
  {$EXTERNALSYM PRINTPROCESSOR_INFO_1A}
  PRINTPROCESSOR_INFO_1A = _PRINTPROCESSOR_INFO_1A;
  {$EXTERNALSYM PRINTPROCESSOR_INFO_1W}
  PRINTPROCESSOR_INFO_1W = _PRINTPROCESSOR_INFO_1W;
  {$EXTERNALSYM PRINTPROCESSOR_INFO_1}
  PRINTPROCESSOR_INFO_1 = PRINTPROCESSOR_INFO_1W;

  PPortInfo1A = ^TPortInfo1A;
  PPortInfo1W = ^TPortInfo1W;
  PPortInfo1 = PPortInfo1W;
  {$EXTERNALSYM _PORT_INFO_1A}
  _PORT_INFO_1A = record
    pName: LPSTR;
  end;
  {$EXTERNALSYM _PORT_INFO_1W}
  _PORT_INFO_1W = record
    pName: LPWSTR;
  end;
  {$EXTERNALSYM _PORT_INFO_1}
  _PORT_INFO_1 = _PORT_INFO_1W;
  TPortInfo1A = _PORT_INFO_1A;
  TPortInfo1W = _PORT_INFO_1W;
  TPortInfo1 = TPortInfo1W;
  {$EXTERNALSYM PORT_INFO_1A}
  PORT_INFO_1A = _PORT_INFO_1A;
  {$EXTERNALSYM PORT_INFO_1W}
  PORT_INFO_1W = _PORT_INFO_1W;
  {$EXTERNALSYM PORT_INFO_1}
  PORT_INFO_1 = PORT_INFO_1W;

  PPortInfo2A = ^TPortInfo2A;
  PPortInfo2W = ^TPortInfo2W;
  PPortInfo2 = PPortInfo2W;
  {$EXTERNALSYM _PORT_INFO_2A}
  _PORT_INFO_2A = record
    pPortName: LPSTR;
    pMonitorName: LPSTR;
    pDescription: LPSTR;
    fPortType: DWORD;
    Reserved: DWORD;
  end;
  {$EXTERNALSYM _PORT_INFO_2W}
  _PORT_INFO_2W = record
    pPortName: LPWSTR;
    pMonitorName: LPWSTR;
    pDescription: LPWSTR;
    fPortType: DWORD;
    Reserved: DWORD;
  end;
  {$EXTERNALSYM _PORT_INFO_2}
  _PORT_INFO_2 = _PORT_INFO_2W;
  TPortInfo2A = _PORT_INFO_2A;
  TPortInfo2W = _PORT_INFO_2W;
  TPortInfo2 = TPortInfo2W;
  {$EXTERNALSYM PORT_INFO_2A}
  PORT_INFO_2A = _PORT_INFO_2A;
  {$EXTERNALSYM PORT_INFO_2W}
  PORT_INFO_2W = _PORT_INFO_2W;
  {$EXTERNALSYM PORT_INFO_2}
  PORT_INFO_2 = PORT_INFO_2W;

const
  {$EXTERNALSYM PORT_TYPE_WRITE}
  PORT_TYPE_WRITE         = $0001;
  {$EXTERNALSYM PORT_TYPE_READ}
  PORT_TYPE_READ          = $0002;
  {$EXTERNALSYM PORT_TYPE_REDIRECTED}
  PORT_TYPE_REDIRECTED    = $0004;
  {$EXTERNALSYM PORT_TYPE_NET_ATTACHED}
  PORT_TYPE_NET_ATTACHED  = $0008;

type
  PPortInfo3A = ^TPortInfo3A;
  PPortInfo3W = ^TPortInfo3W;
  PPortInfo3 = PPortInfo3W;
  {$EXTERNALSYM _PORT_INFO_3A}
  _PORT_INFO_3A = record
    dwStatus: DWORD;
    pszStatus: LPSTR;
    dwSeverity: DWORD;
  end;
  {$EXTERNALSYM _PORT_INFO_3W}
  _PORT_INFO_3W = record
    dwStatus: DWORD;
    pszStatus: LPWSTR;
    dwSeverity: DWORD;
  end;
  {$EXTERNALSYM _PORT_INFO_3}
  _PORT_INFO_3 = _PORT_INFO_3W;
  TPortInfo3A = _PORT_INFO_3A;
  TPortInfo3W = _PORT_INFO_3W;
  TPortInfo3 = TPortInfo3W;
  {$EXTERNALSYM PORT_INFO_3A}
  PORT_INFO_3A = _PORT_INFO_3A;
  {$EXTERNALSYM PORT_INFO_3W}
  PORT_INFO_3W = _PORT_INFO_3W;
  {$EXTERNALSYM PORT_INFO_3}
  PORT_INFO_3 = PORT_INFO_3W;

const
  {$EXTERNALSYM PORT_STATUS_TYPE_ERROR}
  PORT_STATUS_TYPE_ERROR          = 1;
  {$EXTERNALSYM PORT_STATUS_TYPE_WARNING}
  PORT_STATUS_TYPE_WARNING        = 2;
  {$EXTERNALSYM PORT_STATUS_TYPE_INFO}
  PORT_STATUS_TYPE_INFO           = 3;

  {$EXTERNALSYM PORT_STATUS_OFFLINE}
  PORT_STATUS_OFFLINE             = 1;
  {$EXTERNALSYM PORT_STATUS_PAPER_JAM}
  PORT_STATUS_PAPER_JAM           = 2;
  {$EXTERNALSYM PORT_STATUS_PAPER_OUT}
  PORT_STATUS_PAPER_OUT           = 3;
  {$EXTERNALSYM PORT_STATUS_OUTPUT_BIN_FULL}
  PORT_STATUS_OUTPUT_BIN_FULL     = 4;
  {$EXTERNALSYM PORT_STATUS_PAPER_PROBLEM}
  PORT_STATUS_PAPER_PROBLEM       = 5;
  {$EXTERNALSYM PORT_STATUS_NO_TONER}
  PORT_STATUS_NO_TONER            = 6;
  {$EXTERNALSYM PORT_STATUS_DOOR_OPEN}
  PORT_STATUS_DOOR_OPEN           = 7;
  {$EXTERNALSYM PORT_STATUS_USER_INTERVENTION}
  PORT_STATUS_USER_INTERVENTION   = 8;
  {$EXTERNALSYM PORT_STATUS_OUT_OF_MEMORY}
  PORT_STATUS_OUT_OF_MEMORY       = 9;

  {$EXTERNALSYM PORT_STATUS_TONER_LOW}
  PORT_STATUS_TONER_LOW           = 10;

  {$EXTERNALSYM PORT_STATUS_WARMING_UP}
  PORT_STATUS_WARMING_UP          = 11;
  {$EXTERNALSYM PORT_STATUS_POWER_SAVE}
  PORT_STATUS_POWER_SAVE          = 12;

type
  PMonitorInfo1A = ^TMonitorInfo1A;
  PMonitorInfo1W = ^TMonitorInfo1W;
  PMonitorInfo1 = PMonitorInfo1W;
  {$EXTERNALSYM _MONITOR_INFO_1A}
  _MONITOR_INFO_1A = record
    pName: LPSTR;
  end;
  {$EXTERNALSYM _MONITOR_INFO_1W}
  _MONITOR_INFO_1W = record
    pName: LPWSTR;
  end;
  {$EXTERNALSYM _MONITOR_INFO_1}
  _MONITOR_INFO_1 = _MONITOR_INFO_1W;
  TMonitorInfo1A = _MONITOR_INFO_1A;
  TMonitorInfo1W = _MONITOR_INFO_1W;
  TMonitorInfo1 = TMonitorInfo1W;
  {$EXTERNALSYM MONITOR_INFO_1A}
  MONITOR_INFO_1A = _MONITOR_INFO_1A;
  {$EXTERNALSYM MONITOR_INFO_1W}
  MONITOR_INFO_1W = _MONITOR_INFO_1W;
  {$EXTERNALSYM MONITOR_INFO_1}
  MONITOR_INFO_1 = MONITOR_INFO_1W;

  PMonitorInfo2A = ^TMonitorInfo2A;
  PMonitorInfo2W = ^TMonitorInfo2W;
  PMonitorInfo2 = PMonitorInfo2W;
  {$EXTERNALSYM _MONITOR_INFO_2A}
  _MONITOR_INFO_2A = record
    pName: LPSTR;
    pEnvironment: LPSTR;
    pDLLName: LPSTR;
  end;
  {$EXTERNALSYM _MONITOR_INFO_2W}
  _MONITOR_INFO_2W = record
    pName: LPWSTR;
    pEnvironment: LPWSTR;
    pDLLName: LPWSTR;
  end;
  {$EXTERNALSYM _MONITOR_INFO_2}
  _MONITOR_INFO_2 = _MONITOR_INFO_2W;
  TMonitorInfo2A = _MONITOR_INFO_2A;
  TMonitorInfo2W = _MONITOR_INFO_2W;
  TMonitorInfo2 = TMonitorInfo2W;
  {$EXTERNALSYM MONITOR_INFO_2A}
  MONITOR_INFO_2A = _MONITOR_INFO_2A;
  {$EXTERNALSYM MONITOR_INFO_2W}
  MONITOR_INFO_2W = _MONITOR_INFO_2W;
  {$EXTERNALSYM MONITOR_INFO_2}
  MONITOR_INFO_2 = MONITOR_INFO_2W;

  PDatatypesInfo1A = ^TDatatypesInfo1A;
  PDatatypesInfo1W = ^TDatatypesInfo1W;
  PDatatypesInfo1 = PDatatypesInfo1W;
  {$EXTERNALSYM _DATATYPES_INFO_1A}
  _DATATYPES_INFO_1A = record
    pName: LPSTR;
  end;
  {$EXTERNALSYM _DATATYPES_INFO_1W}
  _DATATYPES_INFO_1W = record
    pName: LPWSTR;
  end;
  {$EXTERNALSYM _DATATYPES_INFO_1}
  _DATATYPES_INFO_1 = _DATATYPES_INFO_1W;
  TDatatypesInfo1A = _DATATYPES_INFO_1A;
  TDatatypesInfo1W = _DATATYPES_INFO_1W;
  TDatatypesInfo1 = TDatatypesInfo1W;
  {$EXTERNALSYM DATATYPES_INFO_1A}
  DATATYPES_INFO_1A = _DATATYPES_INFO_1A;
  {$EXTERNALSYM DATATYPES_INFO_1W}
  DATATYPES_INFO_1W = _DATATYPES_INFO_1W;
  {$EXTERNALSYM DATATYPES_INFO_1}
  DATATYPES_INFO_1 = DATATYPES_INFO_1W;

  PPrinterDefaultsA = ^TPrinterDefaultsA;
  PPrinterDefaultsW = ^TPrinterDefaultsW;
  PPrinterDefaults = PPrinterDefaultsW;
  {$EXTERNALSYM _PRINTER_DEFAULTSA}
  _PRINTER_DEFAULTSA = record
    pDatatype: LPSTR;
    pDevMode: PDeviceModeA;
    DesiredAccess: ACCESS_MASK;
  end;
  {$EXTERNALSYM _PRINTER_DEFAULTSW}
  _PRINTER_DEFAULTSW = record
    pDatatype: LPWSTR;
    pDevMode: PDeviceModeW;
    DesiredAccess: ACCESS_MASK;
  end;
  {$EXTERNALSYM _PRINTER_DEFAULTS}
  _PRINTER_DEFAULTS = _PRINTER_DEFAULTSW;
  TPrinterDefaultsA = _PRINTER_DEFAULTSA;
  TPrinterDefaultsW = _PRINTER_DEFAULTSW;
  TPrinterDefaults = TPrinterDefaultsW;
  {$EXTERNALSYM PRINTER_DEFAULTSA}
  PRINTER_DEFAULTSA = _PRINTER_DEFAULTSA;
  {$EXTERNALSYM PRINTER_DEFAULTSW}
  PRINTER_DEFAULTSW = _PRINTER_DEFAULTSW;
  {$EXTERNALSYM PRINTER_DEFAULTS}
  PRINTER_DEFAULTS = PRINTER_DEFAULTSW;

  PPrinterOptionsA = ^TPrinterOptionsA;
  PPrinterOptionsW = ^TPrinterOptionsW;
  PPrinterOptions = PPrinterOptionsW;
  {$EXTERNALSYM _PRINTER_OPTIONSA}
  _PRINTER_OPTIONSA = record
    cbSize: Cardinal;
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_OPTIONSW}
  _PRINTER_OPTIONSW = record
    cbSize: Cardinal;
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _PRINTER_OPTIONS}
  _PRINTER_OPTIONS = _PRINTER_OPTIONSW;
  TPrinterOptionsA = _PRINTER_OPTIONSA;
  TPrinterOptionsW = _PRINTER_OPTIONSW;
  TPrinterOptions = TPrinterOptionsW;
  {$EXTERNALSYM PRINTER_OPTIONSA}
  PRINTER_OPTIONSA = _PRINTER_OPTIONSA;
  {$EXTERNALSYM PRINTER_OPTIONSW}
  PRINTER_OPTIONSW = _PRINTER_OPTIONSW;
  {$EXTERNALSYM PRINTER_OPTIONS}
  PRINTER_OPTIONS = PRINTER_OPTIONSW;

  PPrintProcessorCaps1 = ^TPrintProcessorCaps1;
  {$EXTERNALSYM _PRINTPROCESSOR_CAPS_1}
  _PRINTPROCESSOR_CAPS_1 = record
    dwLevel: DWORD;
    dwNupOptions: DWORD;
    dwPageOrderFlags: DWORD;
    dwNumberOfCopies: DWORD;
  end;
  TPrintProcessorCaps1 = _PRINTPROCESSOR_CAPS_1;
  {$EXTERNALSYM PRINTPROCESSOR_CAPS_1}
  PRINTPROCESSOR_CAPS_1 = _PRINTPROCESSOR_CAPS_1;

  PPrintProcessorCaps2 = ^TPrintProcessorCaps2;
  {$EXTERNALSYM _PRINTPROCESSOR_CAPS_2}
  _PRINTPROCESSOR_CAPS_2 = record
    dwLevel: DWORD;
    dwNupOptions: DWORD;
    dwPageOrderFlags: DWORD;
    dwNumberOfCopies: DWORD;
    dwDuplexHandlingCaps: DWORD;
    dwNupDirectionCaps: DWORD;
    dwNupBorderCaps: DWORD;
    dwBookletHandlingCaps: DWORD;
    dwScalingCaps: DWORD;
  end;
  TPrintProcessorCaps2 = _PRINTPROCESSOR_CAPS_2;
  {$EXTERNALSYM PRINTPROCESSOR_CAPS_2}
  PRINTPROCESSOR_CAPS_2 = _PRINTPROCESSOR_CAPS_2;

{$EXTERNALSYM EnumPrinters}
function EnumPrinters(Flags: DWORD; Name: LPWSTR; Level: DWORD;
  pPrinterEnum: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrintersA}
function EnumPrintersA(Flags: DWORD; Name: LPSTR; Level: DWORD;
  pPrinterEnum: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrintersW}
function EnumPrintersW(Flags: DWORD; Name: LPWSTR; Level: DWORD;
  pPrinterEnum: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;

const
  {$EXTERNALSYM PRINTER_ENUM_DEFAULT}
  PRINTER_ENUM_DEFAULT     = $00000001;
  {$EXTERNALSYM PRINTER_ENUM_LOCAL}
  PRINTER_ENUM_LOCAL       = $00000002;
  {$EXTERNALSYM PRINTER_ENUM_CONNECTIONS}
  PRINTER_ENUM_CONNECTIONS = $00000004;
  {$EXTERNALSYM PRINTER_ENUM_FAVORITE}
  PRINTER_ENUM_FAVORITE    = $00000004;
  {$EXTERNALSYM PRINTER_ENUM_NAME}
  PRINTER_ENUM_NAME        = $00000008;
  {$EXTERNALSYM PRINTER_ENUM_REMOTE}
  PRINTER_ENUM_REMOTE      = $00000010;
  {$EXTERNALSYM PRINTER_ENUM_SHARED}
  PRINTER_ENUM_SHARED      = $00000020;
  {$EXTERNALSYM PRINTER_ENUM_NETWORK}
  PRINTER_ENUM_NETWORK     = $00000040;

  {$EXTERNALSYM PRINTER_ENUM_EXPAND}
  PRINTER_ENUM_EXPAND      = $00004000;
  {$EXTERNALSYM PRINTER_ENUM_CONTAINER}
  PRINTER_ENUM_CONTAINER   = $00008000;

  {$EXTERNALSYM PRINTER_ENUM_ICONMASK}
  PRINTER_ENUM_ICONMASK    = $00ff0000;
  {$EXTERNALSYM PRINTER_ENUM_ICON1}
  PRINTER_ENUM_ICON1       = $00010000;
  {$EXTERNALSYM PRINTER_ENUM_ICON2}
  PRINTER_ENUM_ICON2       = $00020000;
  {$EXTERNALSYM PRINTER_ENUM_ICON3}
  PRINTER_ENUM_ICON3       = $00040000;
  {$EXTERNALSYM PRINTER_ENUM_ICON4}
  PRINTER_ENUM_ICON4       = $00080000;
  {$EXTERNALSYM PRINTER_ENUM_ICON5}
  PRINTER_ENUM_ICON5       = $00100000;
  {$EXTERNALSYM PRINTER_ENUM_ICON6}
  PRINTER_ENUM_ICON6       = $00200000;
  {$EXTERNALSYM PRINTER_ENUM_ICON7}
  PRINTER_ENUM_ICON7       = $00400000;
  {$EXTERNALSYM PRINTER_ENUM_ICON8}
  PRINTER_ENUM_ICON8       = $00800000;
  {$EXTERNALSYM PRINTER_ENUM_HIDE}
  PRINTER_ENUM_HIDE        = $01000000;

  {$EXTERNALSYM SPOOL_FILE_PERSISTENT}
  SPOOL_FILE_PERSISTENT = $00000001;
  {$EXTERNALSYM SPOOL_FILE_TEMPORARY}
  SPOOL_FILE_TEMPORARY  = $00000002;

  //{$EXTERNALSYM DPD_DELETE_UNUSED_FILES}
  //DPD_DELETE_UNUSED_FILES     = $00000001;
  //{$EXTERNALSYM DPD_DELETE_SPECIFIC_VERSION}
  //DPD_DELETE_SPECIFIC_VERSION = $00000002;
  //{$EXTERNALSYM DPD_DELETE_ALL_FILES}
  //DPD_DELETE_ALL_FILES        = $00000004;

{$EXTERNALSYM OpenPrinter}
function OpenPrinter(pPrinterName: LPWSTR; var phPrinter: THandle; pDefault: PPrinterDefaults): BOOL; stdcall;
{$EXTERNALSYM OpenPrinterA}
function OpenPrinterA(pPrinterName: LPSTR; var phPrinter: THandle; pDefault: PPrinterDefaultsA): BOOL; stdcall;
{$EXTERNALSYM OpenPrinterW}
function OpenPrinterW(pPrinterName: LPWSTR; var phPrinter: THandle; pDefault: PPrinterDefaultsW): BOOL; stdcall;
{$EXTERNALSYM ResetPrinter}
function ResetPrinter(hPrinter: THandle; pDefault: PPrinterDefaults): BOOL; stdcall;
{$EXTERNALSYM ResetPrinterA}
function ResetPrinterA(hPrinter: THandle; pDefault: PPrinterDefaultsA): BOOL; stdcall;
{$EXTERNALSYM ResetPrinterW}
function ResetPrinterW(hPrinter: THandle; pDefault: PPrinterDefaultsW): BOOL; stdcall;
{$EXTERNALSYM SetJob}
function SetJob(hPrinter: THandle; JobId: DWORD; Level: DWORD; pJob: Pointer; Command: DWORD): BOOL; stdcall;
{$EXTERNALSYM SetJobA}
function SetJobA(hPrinter: THandle; JobId: DWORD; Level: DWORD; pJob: Pointer; Command: DWORD): BOOL; stdcall;
{$EXTERNALSYM SetJobW}
function SetJobW(hPrinter: THandle; JobId: DWORD; Level: DWORD; pJob: Pointer; Command: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetJob}
function GetJob(hPrinter: THandle; JobId: DWORD; Level: DWORD; pJob: Pointer; cbBuf: DWORD; pcbNeeded: PDWORD): BOOL; stdcall;
{$EXTERNALSYM GetJobA}
function GetJobA(hPrinter: THandle; JobId: DWORD; Level: DWORD; pJob: Pointer; cbBuf: DWORD; pcbNeeded: PDWORD): BOOL; stdcall;
{$EXTERNALSYM GetJobW}
function GetJobW(hPrinter: THandle; JobId: DWORD; Level: DWORD; pJob: Pointer; cbBuf: DWORD; pcbNeeded: PDWORD): BOOL; stdcall;
{$EXTERNALSYM EnumJobs}
function EnumJobs(hPrinter: THandle; FirstJob, NoJobs, Level: DWORD; pJob: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumJobsA}
function EnumJobsA(hPrinter: THandle; FirstJob, NoJobs, Level: DWORD; pJob: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumJobsW}
function EnumJobsW(hPrinter: THandle; FirstJob, NoJobs, Level: DWORD; pJob: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM AddPrinter}
function AddPrinter(pName: LPWSTR; Level: DWORD; pPrinter: Pointer): THandle; stdcall;
{$EXTERNALSYM AddPrinterA}
function AddPrinterA(pName: LPSTR; Level: DWORD; pPrinter: Pointer): THandle; stdcall;
{$EXTERNALSYM AddPrinterW}
function AddPrinterW(pName: LPWSTR; Level: DWORD; pPrinter: Pointer): THandle; stdcall;
{$EXTERNALSYM DeletePrinter}
function DeletePrinter(hPrinter: THandle): BOOL; stdcall;
{$EXTERNALSYM SetPrinter}
function SetPrinter(hPrinter: THandle; Level: DWORD; pPrinter: Pointer; Command: DWORD): BOOL; stdcall;
{$EXTERNALSYM SetPrinterA}
function SetPrinterA(hPrinter: THandle; Level: DWORD; pPrinter: Pointer; Command: DWORD): BOOL; stdcall;
{$EXTERNALSYM SetPrinterW}
function SetPrinterW(hPrinter: THandle; Level: DWORD; pPrinter: Pointer; Command: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinter}
function GetPrinter(hPrinter: THandle; Level: DWORD; pPrinter: Pointer; cbBuf: DWORD; pcbNeeded: PDWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterA}
function GetPrinterA(hPrinter: THandle; Level: DWORD; pPrinter: Pointer; cbBuf: DWORD; pcbNeeded: PDWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterW}
function GetPrinterW(hPrinter: THandle; Level: DWORD; pPrinter: Pointer; cbBuf: DWORD; pcbNeeded: PDWORD): BOOL; stdcall;
{$EXTERNALSYM AddPrinterDriver}
function AddPrinterDriver(pName: LPWSTR; Level: DWORD; pDriverInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddPrinterDriverA}
function AddPrinterDriverA(pName: LPSTR; Level: DWORD; pDriverInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddPrinterDriverW}
function AddPrinterDriverW(pName: LPWSTR; Level: DWORD; pDriverInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddPrinterDriverEx}
function AddPrinterDriverEx(pName: LPWSTR; Level: DWORD; pDriverInfo: Pointer;
  dwFileCopyFlags: DWORD): BOOL; stdcall;
{$EXTERNALSYM AddPrinterDriverExA}
function AddPrinterDriverExA(pName: LPSTR; Level: DWORD; pDriverInfo: Pointer;
  dwFileCopyFlags: DWORD): BOOL; stdcall;
{$EXTERNALSYM AddPrinterDriverExW}
function AddPrinterDriverExW(pName: LPWSTR; Level: DWORD; pDriverInfo: Pointer;
  dwFileCopyFlags: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrinterDrivers}
function EnumPrinterDrivers(pName, pEnvironment: LPWSTR; Level: DWORD;
  pDriverInfo: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrinterDriversA}
function EnumPrinterDriversA(pName, pEnvironment: LPSTR; Level: DWORD;
  pDriverInfo: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrinterDriversW}
function EnumPrinterDriversW(pName, pEnvironment: LPWSTR; Level: DWORD;
  pDriverInfo: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrinterKey}
function EnumPrinterKey(hPrinter: THandle; pKeyName: LPCWSTR; pSubKey: LPWSTR;
  cbSubkey: DWORD; pcbSubkey: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM EnumPrinterKeyA}
function EnumPrinterKeyA(hPrinter: THandle; pKeyName: LPCSTR; pSubKey: LPSTR;
  cbSubkey: DWORD; pcbSubkey: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM EnumPrinterKeyW}
function EnumPrinterKeyW(hPrinter: THandle; pKeyName: LPCWSTR; pSubKey: LPWSTR;
  cbSubkey: DWORD; pcbSubkey: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM GetPrinterDriver}
function GetPrinterDriver(hPrinter: THandle; pEnvironment: LPWSTR; Level: DWORD;
  pDriverInfo: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterDriverA}
function GetPrinterDriverA(hPrinter: THandle; pEnvironment: LPSTR; Level: DWORD;
  pDriverInfo: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterDriverW}
function GetPrinterDriverW(hPrinter: THandle; pEnvironment: LPWSTR; Level: DWORD;
  pDriverInfo: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterDriverDirectory}
function GetPrinterDriverDirectory(pName, pEnvironment: LPWSTR; Level: DWORD;
  pDriverDirectory: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterDriverDirectoryA}
function GetPrinterDriverDirectoryA(pName, pEnvironment: LPSTR; Level: DWORD;
  pDriverDirectory: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterDriverDirectoryW}
function GetPrinterDriverDirectoryW(pName, pEnvironment: LPWSTR; Level: DWORD;
  pDriverDirectory: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterDriver}
function DeletePrinterDriver(pName, pEnvironment, pDriverName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterDriverA}
function DeletePrinterDriverA(pName, pEnvironment, pDriverName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterDriverW}
function DeletePrinterDriverW(pName, pEnvironment, pDriverName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterDriverEx}
function DeletePrinterDriverEx(pName: LPWSTR; pEnvironment: LPWSTR;
  pDriverName: LPWSTR; dwDeleteFlag, dwVersionFlag: DWORD): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterDriverExA}
function DeletePrinterDriverExA(pName: LPSTR; pEnvironment: LPSTR;
  pDriverName: LPSTR; dwDeleteFlag, dwVersionFlag: DWORD): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterDriverExW}
function DeletePrinterDriverExW(pName: LPWSTR; pEnvironment: LPWSTR;
  pDriverName: LPWSTR; dwDeleteFlag, dwVersionFlag: DWORD): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterKey}
function DeletePrinterKey(hPrinter: THandle; pKeyName: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM DeletePrinterKeyA}
function DeletePrinterKeyA(hPrinter: THandle; pKeyName: LPCSTR): DWORD; stdcall;
{$EXTERNALSYM DeletePrinterKeyW}
function DeletePrinterKeyW(hPrinter: THandle; pKeyName: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM AddPrintProcessor}
function AddPrintProcessor(pName, pEnvironment, pPathName, pPrintProcessorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM AddPrintProcessorA}
function AddPrintProcessorA(pName, pEnvironment, pPathName, pPrintProcessorName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM AddPrintProcessorW}
function AddPrintProcessorW(pName, pEnvironment, pPathName, pPrintProcessorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM EnumPrintProcessors}
function EnumPrintProcessors(pName, pEnvironment: LPWSTR; Level: DWORD; pPrintProcessorInfo: Pointer;
  cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrintProcessorsA}
function EnumPrintProcessorsA(pName, pEnvironment: LPSTR; Level: DWORD; pPrintProcessorInfo: Pointer;
  cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrintProcessorsW}
function EnumPrintProcessorsW(pName, pEnvironment: LPWSTR; Level: DWORD; pPrintProcessorInfo: Pointer;
  cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrintProcessorDirectory}
function GetPrintProcessorDirectory(pName, pEnvironment: LPWSTR; Level: DWORD;
  pPrintProcessorInfo: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrintProcessorDirectoryA}
function GetPrintProcessorDirectoryA(pName, pEnvironment: LPSTR; Level: DWORD;
  pPrintProcessorInfo: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrintProcessorDirectoryW}
function GetPrintProcessorDirectoryW(pName, pEnvironment: LPWSTR; Level: DWORD;
  pPrintProcessorInfo: Pointer; cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrintProcessorDatatypes}
function EnumPrintProcessorDatatypes(pName, pPrintProcessorName: LPWSTR; Level: DWORD;
  pDatatypes: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrintProcessorDatatypesA}
function EnumPrintProcessorDatatypesA(pName, pPrintProcessorName: LPSTR; Level: DWORD;
  pDatatypes: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPrintProcessorDatatypesW}
function EnumPrintProcessorDatatypesW(pName, pPrintProcessorName: LPWSTR; Level: DWORD;
  pDatatypes: Pointer; cbBuf: DWORD; var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM DeletePrintProcessor}
function DeletePrintProcessor(pName, pEnvironment, pPrintProcessorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrintProcessorA}
function DeletePrintProcessorA(pName, pEnvironment, pPrintProcessorName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrintProcessorW}
function DeletePrintProcessorW(pName, pEnvironment, pPrintProcessorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM StartDocPrinter}
function StartDocPrinter(hPrinter: THandle; Level: DWORD; pDocInfo: Pointer): DWORD; stdcall;
{$EXTERNALSYM StartDocPrinterA}
function StartDocPrinterA(hPrinter: THandle; Level: DWORD; pDocInfo: Pointer): DWORD; stdcall;
{$EXTERNALSYM StartDocPrinterW}
function StartDocPrinterW(hPrinter: THandle; Level: DWORD; pDocInfo: Pointer): DWORD; stdcall;
{$EXTERNALSYM StartPagePrinter}
function StartPagePrinter(hPrinter: THandle): BOOL; stdcall;
{$EXTERNALSYM WritePrinter}
function WritePrinter(hPrinter: THandle; pBuf: Pointer; cbBuf: DWORD;
  var pcWritten: DWORD): BOOL; stdcall;
{$EXTERNALSYM EndPagePrinter}
function EndPagePrinter(hPrinter: THandle): BOOL; stdcall;
{$EXTERNALSYM AbortPrinter}
function AbortPrinter(hPrinter: THandle): BOOL; stdcall;
{$EXTERNALSYM ReadPrinter}
function ReadPrinter(hPrinter: THandle; pBuf: Pointer; cbBuf: DWORD;
  var pNoBytesRead: DWORD): BOOL; stdcall;
{$EXTERNALSYM EndDocPrinter}
function EndDocPrinter(hPrinter: THandle): BOOL; stdcall;
{$EXTERNALSYM AddJob}
function AddJob(hPrinter: THandle; Level: DWORD; pData: Pointer; cbBuf: DWORD;
  var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM AddJobA}
function AddJobA(hPrinter: THandle; Level: DWORD; pData: Pointer; cbBuf: DWORD;
  var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM AddJobW}
function AddJobW(hPrinter: THandle; Level: DWORD; pData: Pointer; cbBuf: DWORD;
  var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM ScheduleJob}
function ScheduleJob(hPrinter: THandle; JobId: DWORD): BOOL; stdcall;
{$EXTERNALSYM PrinterProperties}
function PrinterProperties(hWnd: HWND; hPrinter: THandle): BOOL; stdcall;
{$EXTERNALSYM DocumentProperties}
function DocumentProperties(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  const pDevModeOutput: TDeviceMode; var pDevModeInput: TDeviceMode;
  fMode: DWORD): Longint; stdcall; overload;
{$EXTERNALSYM DocumentProperties}
function DocumentProperties(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  pDevModeOutput: PDeviceMode; pDevModeInput: PDeviceMode;
  fMode: DWORD): Longint; stdcall; overload;
{$EXTERNALSYM DocumentPropertiesA}
function DocumentPropertiesA(hWnd: HWND; hPrinter: THandle; pDeviceName: LPSTR;
  const pDevModeOutput: TDeviceModeA; var pDevModeInput: TDeviceModeA;
  fMode: DWORD): Longint; stdcall; overload;
{$EXTERNALSYM DocumentPropertiesA}
function DocumentPropertiesA(hWnd: HWND; hPrinter: THandle; pDeviceName: LPSTR;
  pDevModeOutput: PDeviceModeA; pDevModeInput: PDeviceModeA;
  fMode: DWORD): Longint; stdcall; overload;
{$EXTERNALSYM DocumentPropertiesW}
function DocumentPropertiesW(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  const pDevModeOutput: TDeviceModeW; var pDevModeInput: TDeviceModeW;
  fMode: DWORD): Longint; stdcall; overload;
{$EXTERNALSYM DocumentPropertiesW}
function DocumentPropertiesW(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  pDevModeOutput: PDeviceModeW; pDevModeInput: PDeviceModeW;
  fMode: DWORD): Longint; stdcall; overload;
{$EXTERNALSYM AdvancedDocumentProperties}
function AdvancedDocumentProperties(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  pDevModeOutput, pDevModeInput: PDeviceMode): Longint; stdcall;
{$EXTERNALSYM AdvancedDocumentPropertiesA}
function AdvancedDocumentPropertiesA(hWnd: HWND; hPrinter: THandle; pDeviceName: LPSTR;
  pDevModeOutput, pDevModeInput: PDeviceModeA): Longint; stdcall;
{$EXTERNALSYM AdvancedDocumentPropertiesW}
function AdvancedDocumentPropertiesW(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  pDevModeOutput, pDevModeInput: PDeviceModeW): Longint; stdcall;
{$EXTERNALSYM GetPrinterData}
function GetPrinterData(hPrinter: THandle; pValueName: LPWSTR; pType: PDWORD;
  pData: Pointer; nSize: DWORD; var pcbNeeded: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetPrinterDataA}
function GetPrinterDataA(hPrinter: THandle; pValueName: LPSTR; pType: PDWORD;
  pData: Pointer; nSize: DWORD; var pcbNeeded: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetPrinterDataW}
function GetPrinterDataW(hPrinter: THandle; pValueName: LPWSTR; pType: PDWORD;
  pData: Pointer; nSize: DWORD; var pcbNeeded: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetPrinterDataEx}
function GetPrinterDataEx(hPrinter: THandle; pKeyName, pValueName: LPCWSTR;
  pType: LPDWORD; pData: LPBYTE; nSize: DWORD; pcbNeeded: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM GetPrinterDataExA}
function GetPrinterDataExA(hPrinter: THandle; pKeyName, pValueName: LPCSTR;
  pType: LPDWORD; pData: LPBYTE; nSize: DWORD; pcbNeeded: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM GetPrinterDataExW}
function GetPrinterDataExW(hPrinter: THandle; pKeyName, pValueName: LPCWSTR;
  pType: LPDWORD; pData: LPBYTE; nSize: DWORD; pcbNeeded: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM EnumPrinterData}
function EnumPrinterData(hPrinter: THandle; dwIndex: DWORD; pValueName: LPWSTR;
  cbValueName: DWORD; var pcbValueName, pType: DWORD; pData: PByte;
  cbData: DWORD; pcbData: PDWORD): DWORD; stdcall;
{$EXTERNALSYM EnumPrinterDataA}
function EnumPrinterDataA(hPrinter: THandle; dwIndex: DWORD; pValueName: LPSTR;
  cbValueName: DWORD; var pcbValueName, pType: DWORD; pData: PByte;
  cbData: DWORD; pcbData: PDWORD): DWORD; stdcall;
{$EXTERNALSYM EnumPrinterDataW}
function EnumPrinterDataW(hPrinter: THandle; dwIndex: DWORD; pValueName: LPWSTR;
  cbValueName: DWORD; var pcbValueName, pType: DWORD; pData: PByte;
  cbData: DWORD; pcbData: PDWORD): DWORD; stdcall;
{$EXTERNALSYM EnumPrinterDataEx}
function EnumPrinterDataEx(hPrinter: THandle; pKeyName: LPCWSTR;
  pEnumValues: LPBYTE; cbEnumValues: DWORD; pcbEnumValues: LPDWORD;
  pnEnumValues: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM EnumPrinterDataExA}
function EnumPrinterDataExA(hPrinter: THandle; pKeyName: LPCSTR;
  pEnumValues: LPBYTE; cbEnumValues: DWORD; pcbEnumValues: LPDWORD;
  pnEnumValues: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM EnumPrinterDataExW}
function EnumPrinterDataExW(hPrinter: THandle; pKeyName: LPCWSTR;
  pEnumValues: LPBYTE; cbEnumValues: DWORD; pcbEnumValues: LPDWORD;
  pnEnumValues: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM SetPrinterData}
function SetPrinterData(hPrinter: THandle; pValueName: LPWSTR; dwType: DWORD;
  pData: Pointer; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SetPrinterDataA}
function SetPrinterDataA(hPrinter: THandle; pValueName: LPSTR; dwType: DWORD;
  pData: Pointer; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SetPrinterDataW}
function SetPrinterDataW(hPrinter: THandle; pValueName: LPWSTR; dwType: DWORD;
  pData: Pointer; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SetPrinterDataEx}
function SetPrinterDataEx(hPrinter: THandle; pKeyName, pValueName: LPCWSTR;
  AType: DWORD; pData: LPBYTE; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SetPrinterDataExA}
function SetPrinterDataExA(hPrinter: THandle; pKeyName, pValueName: LPCSTR;
  AType: DWORD; pData: LPBYTE; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM SetPrinterDataExW}
function SetPrinterDataExW(hPrinter: THandle; pKeyName, pValueName: LPCWSTR;
  AType: DWORD; pData: LPBYTE; cbData: DWORD): DWORD; stdcall;
{$EXTERNALSYM DeletePrinterData}
function DeletePrinterData(hPrinter: THandle; pValueName: LPWSTR): DWORD; stdcall;
{$EXTERNALSYM DeletePrinterDataA}
function DeletePrinterDataA(hPrinter: THandle; pValueName: LPSTR): DWORD; stdcall;
{$EXTERNALSYM DeletePrinterDataW}
function DeletePrinterDataW(hPrinter: THandle; pValueName: LPWSTR): DWORD; stdcall;
{$EXTERNALSYM DeletePrinterDataEx}
function DeletePrinterDataEx(hPrinter: THandle; pKeyName: LPCWSTR;
  pValueName: LPCWSTR): DWORD; stdcall;
{$EXTERNALSYM DeletePrinterDataExA}
function DeletePrinterDataExA(hPrinter: THandle; pKeyName: LPCSTR;
  pValueName: LPCSTR): DWORD; stdcall;
{$EXTERNALSYM DeletePrinterDataExW}
function DeletePrinterDataExW(hPrinter: THandle; pKeyName: LPCWSTR;
  pValueName: LPCWSTR): DWORD; stdcall;

const
  {$EXTERNALSYM PRINTER_NOTIFY_TYPE}
  PRINTER_NOTIFY_TYPE = $00;
  {$EXTERNALSYM JOB_NOTIFY_TYPE}
  JOB_NOTIFY_TYPE     = $01;
  {$EXTERNALSYM SERVER_NOTIFY_TYPE}
  SERVER_NOTIFY_TYPE  = $02;

  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_SERVER_NAME}
  PRINTER_NOTIFY_FIELD_SERVER_NAME             = $00;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_PRINTER_NAME}
  PRINTER_NOTIFY_FIELD_PRINTER_NAME            = $01;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_SHARE_NAME}
  PRINTER_NOTIFY_FIELD_SHARE_NAME              = $02;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_PORT_NAME}
  PRINTER_NOTIFY_FIELD_PORT_NAME               = $03;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_DRIVER_NAME}
  PRINTER_NOTIFY_FIELD_DRIVER_NAME             = $04;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_COMMENT}
  PRINTER_NOTIFY_FIELD_COMMENT                 = $05;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_LOCATION}
  PRINTER_NOTIFY_FIELD_LOCATION                = $06;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_DEVMODE}
  PRINTER_NOTIFY_FIELD_DEVMODE                 = $07;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_SEPFILE}
  PRINTER_NOTIFY_FIELD_SEPFILE                 = $08;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_PRINT_PROCESSOR}
  PRINTER_NOTIFY_FIELD_PRINT_PROCESSOR         = $09;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_PARAMETERS}
  PRINTER_NOTIFY_FIELD_PARAMETERS              = $0A;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_DATATYPE}
  PRINTER_NOTIFY_FIELD_DATATYPE                = $0B;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_SECURITY_DESCRIPTOR}
  PRINTER_NOTIFY_FIELD_SECURITY_DESCRIPTOR     = $0C;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_ATTRIBUTES}
  PRINTER_NOTIFY_FIELD_ATTRIBUTES              = $0D;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_PRIORITY}
  PRINTER_NOTIFY_FIELD_PRIORITY                = $0E;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_DEFAULT_PRIORITY}
  PRINTER_NOTIFY_FIELD_DEFAULT_PRIORITY        = $0F;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_START_TIME}
  PRINTER_NOTIFY_FIELD_START_TIME              = $10;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_UNTIL_TIME}
  PRINTER_NOTIFY_FIELD_UNTIL_TIME              = $11;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_STATUS}
  PRINTER_NOTIFY_FIELD_STATUS                  = $12;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_STATUS_STRING}
  PRINTER_NOTIFY_FIELD_STATUS_STRING           = $13;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_CJOBS}
  PRINTER_NOTIFY_FIELD_CJOBS                   = $14;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_AVERAGE_PPM}
  PRINTER_NOTIFY_FIELD_AVERAGE_PPM             = $15;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_TOTAL_PAGES}
  PRINTER_NOTIFY_FIELD_TOTAL_PAGES             = $16;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_PAGES_PRINTED}
  PRINTER_NOTIFY_FIELD_PAGES_PRINTED           = $17;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_TOTAL_BYTES}
  PRINTER_NOTIFY_FIELD_TOTAL_BYTES             = $18;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_BYTES_PRINTED}
  PRINTER_NOTIFY_FIELD_BYTES_PRINTED           = $19;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_OBJECT_GUID}
  PRINTER_NOTIFY_FIELD_OBJECT_GUID             = $1A;
  {$EXTERNALSYM PRINTER_NOTIFY_FIELD_FRIENDLY_NAME}
  PRINTER_NOTIFY_FIELD_FRIENDLY_NAME           = $1B;

  {$EXTERNALSYM JOB_NOTIFY_FIELD_PRINTER_NAME}
  JOB_NOTIFY_FIELD_PRINTER_NAME                = $00;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_MACHINE_NAME}
  JOB_NOTIFY_FIELD_MACHINE_NAME                = $01;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_PORT_NAME}
  JOB_NOTIFY_FIELD_PORT_NAME                   = $02;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_USER_NAME}
  JOB_NOTIFY_FIELD_USER_NAME                   = $03;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_NOTIFY_NAME}
  JOB_NOTIFY_FIELD_NOTIFY_NAME                 = $04;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_DATATYPE}
  JOB_NOTIFY_FIELD_DATATYPE                    = $05;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_PRINT_PROCESSOR}
  JOB_NOTIFY_FIELD_PRINT_PROCESSOR             = $06;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_PARAMETERS}
  JOB_NOTIFY_FIELD_PARAMETERS                  = $07;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_DRIVER_NAME}
  JOB_NOTIFY_FIELD_DRIVER_NAME                 = $08;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_DEVMODE}
  JOB_NOTIFY_FIELD_DEVMODE                     = $09;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_STATUS}
  JOB_NOTIFY_FIELD_STATUS                      = $0A;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_STATUS_STRING}
  JOB_NOTIFY_FIELD_STATUS_STRING               = $0B;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_SECURITY_DESCRIPTOR}
  JOB_NOTIFY_FIELD_SECURITY_DESCRIPTOR         = $0C;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_DOCUMENT}
  JOB_NOTIFY_FIELD_DOCUMENT                    = $0D;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_PRIORITY}
  JOB_NOTIFY_FIELD_PRIORITY                    = $0E;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_POSITION}
  JOB_NOTIFY_FIELD_POSITION                    = $0F;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_SUBMITTED}
  JOB_NOTIFY_FIELD_SUBMITTED                   = $10;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_START_TIME}
  JOB_NOTIFY_FIELD_START_TIME                  = $11;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_UNTIL_TIME}
  JOB_NOTIFY_FIELD_UNTIL_TIME                  = $12;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_TIME}
  JOB_NOTIFY_FIELD_TIME                        = $13;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_TOTAL_PAGES}
  JOB_NOTIFY_FIELD_TOTAL_PAGES                 = $14;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_PAGES_PRINTED}
  JOB_NOTIFY_FIELD_PAGES_PRINTED               = $15;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_TOTAL_BYTES}
  JOB_NOTIFY_FIELD_TOTAL_BYTES                 = $16;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_BYTES_PRINTED}
  JOB_NOTIFY_FIELD_BYTES_PRINTED               = $17;
  {$EXTERNALSYM JOB_NOTIFY_FIELD_REMOTE_JOB_ID}
  JOB_NOTIFY_FIELD_REMOTE_JOB_ID               = $18;

  {$EXTERNALSYM SERVER_NOTIFY_FIELD_PRINT_DRIVER_ISOLATION_GROUP}
  SERVER_NOTIFY_FIELD_PRINT_DRIVER_ISOLATION_GROUP = $00;

type
  PPrinterNotifyOptionsType = ^TPrinterNotifyOptionsType;
  {$EXTERNALSYM _PRINTER_NOTIFY_OPTIONS_TYPE}
  _PRINTER_NOTIFY_OPTIONS_TYPE = record
    wType: Word;
    Reserved0: Word;
    Reserved1: DWORD;
    Reserved2: DWORD;
    Count: DWORD;
    pFields: PWord;
  end;
  TPrinterNotifyOptionsType = _PRINTER_NOTIFY_OPTIONS_TYPE;
  {$EXTERNALSYM PRINTER_NOTIFY_OPTIONS_TYPE}
  PRINTER_NOTIFY_OPTIONS_TYPE = _PRINTER_NOTIFY_OPTIONS_TYPE;

const
  {$EXTERNALSYM PRINTER_NOTIFY_OPTIONS_REFRESH}
  PRINTER_NOTIFY_OPTIONS_REFRESH  = $01;

type
  PPrinterNotifyOptions = ^TPrinterNotifyOptions;
  {$EXTERNALSYM _PRINTER_NOTIFY_OPTIONS}
  _PRINTER_NOTIFY_OPTIONS = record
    Version: DWORD;
    Flags: DWORD;
    Count: DWORD;
    pTypes: PPrinterNotifyOptionsType;
  end;
  TPrinterNotifyOptions = _PRINTER_NOTIFY_OPTIONS;
  {$EXTERNALSYM PRINTER_NOTIFY_OPTIONS}
  PRINTER_NOTIFY_OPTIONS = _PRINTER_NOTIFY_OPTIONS;

const
  {$EXTERNALSYM PRINTER_NOTIFY_INFO_DISCARDED}
  PRINTER_NOTIFY_INFO_DISCARDED       = $01;

type
  PPrinterNotifyInfoData = ^TPrinterNotifyInfoData;
  {$EXTERNALSYM _PRINTER_NOTIFY_INFO_DATA}
  _PRINTER_NOTIFY_INFO_DATA = record
    wType: Word;
    Field: Word;
    Reserved: DWORD;
    Id: DWORD;
    NotifyData: record
      case Integer of
        0: (adwData: array[0..1] of DWORD);
        1: (Data: record
              cbBuf: DWORD;
              pBuf: Pointer;
            end);
    end;
  end;
  TPrinterNotifyInfoData = _PRINTER_NOTIFY_INFO_DATA;
  {$EXTERNALSYM PRINTER_NOTIFY_INFO_DATA}
  PRINTER_NOTIFY_INFO_DATA = _PRINTER_NOTIFY_INFO_DATA;

  PPrinterNotifyInfo = ^TPrinterNotifyInfo;
  {$EXTERNALSYM _PRINTER_NOTIFY_INFO}
  _PRINTER_NOTIFY_INFO = record
    Version: DWORD;
    Flags: DWORD;
    Count: DWORD;
    aData: array[0..0] of TPrinterNotifyInfoData;
  end;
  TPrinterNotifyInfo = _PRINTER_NOTIFY_INFO;
  {$EXTERNALSYM PRINTER_NOTIFY_INFO}
  PRINTER_NOTIFY_INFO = _PRINTER_NOTIFY_INFO;

{$EXTERNALSYM WaitForPrinterChange}
function WaitForPrinterChange(hPrinter: THandle; Flags: DWORD): DWORD; stdcall;
{$EXTERNALSYM FindFirstPrinterChangeNotification}
function FindFirstPrinterChangeNotification(hPrinter: THandle; fdwFlags: DWORD;
  fdwOptions: DWORD; pPrinterNotifyOptions: Pointer): THandle; stdcall;
{$EXTERNALSYM FindNextPrinterChangeNotification}
function FindNextPrinterChangeNotification(hChange: THandle; var pdwChange: DWORD;
  pvReserved: Pointer; var ppPrinterNotifyInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM FlushPrinter}
function FlushPrinter(hPrinter: THandle; pBuf: Pointer; cbBuf: DWORD;
  var pcWritten: DWORD; cSleep: DWORD): BOOL; stdcall;
{$EXTERNALSYM FreePrinterNotifyInfo}
function FreePrinterNotifyInfo(pPrinterNotifyInfo: PPrinterNotifyInfo): BOOL; stdcall;
{$EXTERNALSYM GetDefaultPrinter}
function GetDefaultPrinter(pszBuffer: LPWSTR; pcchBuffer: LPDWORD): BOOL; stdcall;
{$EXTERNALSYM GetDefaultPrinterA}
function GetDefaultPrinterA(pszBuffer: LPSTR; pcchBuffer: LPDWORD): BOOL; stdcall;
{$EXTERNALSYM GetDefaultPrinterW}
function GetDefaultPrinterW(pszBuffer: LPWSTR; pcchBuffer: LPDWORD): BOOL; stdcall;
{$EXTERNALSYM FindClosePrinterChangeNotification}
function FindClosePrinterChangeNotification(hChange: THandle): BOOL; stdcall;

const
  {$EXTERNALSYM PRINTER_CHANGE_ADD_PRINTER}
  PRINTER_CHANGE_ADD_PRINTER              = $00000001;
  {$EXTERNALSYM PRINTER_CHANGE_SET_PRINTER}
  PRINTER_CHANGE_SET_PRINTER              = $00000002;
  {$EXTERNALSYM PRINTER_CHANGE_DELETE_PRINTER}
  PRINTER_CHANGE_DELETE_PRINTER           = $00000004;
  {$EXTERNALSYM PRINTER_CHANGE_FAILED_CONNECTION_PRINTER}
  PRINTER_CHANGE_FAILED_CONNECTION_PRINTER    = $00000008;
  {$EXTERNALSYM PRINTER_CHANGE_PRINTER}
  PRINTER_CHANGE_PRINTER                  = $000000FF;
  {$EXTERNALSYM PRINTER_CHANGE_ADD_JOB}
  PRINTER_CHANGE_ADD_JOB                  = $00000100;
  {$EXTERNALSYM PRINTER_CHANGE_SET_JOB}
  PRINTER_CHANGE_SET_JOB                  = $00000200;
  {$EXTERNALSYM PRINTER_CHANGE_DELETE_JOB}
  PRINTER_CHANGE_DELETE_JOB               = $00000400;
  {$EXTERNALSYM PRINTER_CHANGE_WRITE_JOB}
  PRINTER_CHANGE_WRITE_JOB                = $00000800;
  {$EXTERNALSYM PRINTER_CHANGE_JOB}
  PRINTER_CHANGE_JOB                      = $0000FF00;
  {$EXTERNALSYM PRINTER_CHANGE_ADD_FORM}
  PRINTER_CHANGE_ADD_FORM                 = $00010000;
  {$EXTERNALSYM PRINTER_CHANGE_SET_FORM}
  PRINTER_CHANGE_SET_FORM                 = $00020000;
  {$EXTERNALSYM PRINTER_CHANGE_DELETE_FORM}
  PRINTER_CHANGE_DELETE_FORM              = $00040000;
  {$EXTERNALSYM PRINTER_CHANGE_FORM}
  PRINTER_CHANGE_FORM                     = $00070000;
  {$EXTERNALSYM PRINTER_CHANGE_ADD_PORT}
  PRINTER_CHANGE_ADD_PORT                 = $00100000;
  {$EXTERNALSYM PRINTER_CHANGE_CONFIGURE_PORT}
  PRINTER_CHANGE_CONFIGURE_PORT           = $00200000;
  {$EXTERNALSYM PRINTER_CHANGE_DELETE_PORT}
  PRINTER_CHANGE_DELETE_PORT              = $00400000;
  {$EXTERNALSYM PRINTER_CHANGE_PORT}
  PRINTER_CHANGE_PORT                     = $00700000;
  {$EXTERNALSYM PRINTER_CHANGE_ADD_PRINT_PROCESSOR}
  PRINTER_CHANGE_ADD_PRINT_PROCESSOR      = $01000000;
  {$EXTERNALSYM PRINTER_CHANGE_DELETE_PRINT_PROCESSOR}
  PRINTER_CHANGE_DELETE_PRINT_PROCESSOR   = $04000000;
  {$EXTERNALSYM PRINTER_CHANGE_PRINT_PROCESSOR}
  PRINTER_CHANGE_PRINT_PROCESSOR          = $07000000;
  {$EXTERNALSYM PRINTER_CHANGE_ADD_PRINTER_DRIVER}
  PRINTER_CHANGE_ADD_PRINTER_DRIVER       = $10000000;
  {$EXTERNALSYM PRINTER_CHANGE_SET_PRINTER_DRIVER}
  PRINTER_CHANGE_SET_PRINTER_DRIVER       = $20000000;
  {$EXTERNALSYM PRINTER_CHANGE_DELETE_PRINTER_DRIVER}
  PRINTER_CHANGE_DELETE_PRINTER_DRIVER    = $40000000;
  {$EXTERNALSYM PRINTER_CHANGE_PRINTER_DRIVER}
  PRINTER_CHANGE_PRINTER_DRIVER           = $70000000;
  {$EXTERNALSYM PRINTER_CHANGE_TIMEOUT}
  PRINTER_CHANGE_TIMEOUT                  = $80000000;
  {$EXTERNALSYM PRINTER_CHANGE_ALL}
  PRINTER_CHANGE_ALL                      = $7777FFFF;

{$EXTERNALSYM PrinterMessageBox}
function PrinterMessageBox(hPrinter: THandle; Error: DWORD; hWnd: HWND;
  pText, pCaption: LPWSTR; dwType: DWORD): DWORD; stdcall;
{$EXTERNALSYM PrinterMessageBoxA}
function PrinterMessageBoxA(hPrinter: THandle; Error: DWORD; hWnd: HWND;
  pText, pCaption: LPSTR; dwType: DWORD): DWORD; stdcall;
{$EXTERNALSYM PrinterMessageBoxW}
function PrinterMessageBoxW(hPrinter: THandle; Error: DWORD; hWnd: HWND;
  pText, pCaption: LPWSTR; dwType: DWORD): DWORD; stdcall;

const
  {$EXTERNALSYM PRINTER_ERROR_INFORMATION}
  PRINTER_ERROR_INFORMATION   = $80000000;
  {$EXTERNALSYM PRINTER_ERROR_WARNING}
  PRINTER_ERROR_WARNING       = $40000000;
  {$EXTERNALSYM PRINTER_ERROR_SEVERE}
  PRINTER_ERROR_SEVERE        = $20000000;

  {$EXTERNALSYM PRINTER_ERROR_OUTOFPAPER}
  PRINTER_ERROR_OUTOFPAPER    = $00000001;
  {$EXTERNALSYM PRINTER_ERROR_JAM}
  PRINTER_ERROR_JAM           = $00000002;
  {$EXTERNALSYM PRINTER_ERROR_OUTOFTONER}
  PRINTER_ERROR_OUTOFTONER    = $00000004;

{$EXTERNALSYM ClosePrinter}
function ClosePrinter(hPrinter: THandle): BOOL; stdcall;
{$EXTERNALSYM AddForm}
function AddForm(hPrinter: THandle; Level: DWORD; pForm: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddFormA}
function AddFormA(hPrinter: THandle; Level: DWORD; pForm: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddFormW}
function AddFormW(hPrinter: THandle; Level: DWORD; pForm: Pointer): BOOL; stdcall;
{$EXTERNALSYM DeleteForm}
function DeleteForm(hPrinter: THandle; pFormName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeleteFormA}
function DeleteFormA(hPrinter: THandle; pFormName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM DeleteFormW}
function DeleteFormW(hPrinter: THandle; pFormName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM GetForm}
function GetForm(hPrinter: THandle; pFormName: LPWSTR; Level: DWORD; pForm: Pointer;
  cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetFormA}
function GetFormA(hPrinter: THandle; pFormName: LPSTR; Level: DWORD; pForm: Pointer;
  cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetFormW}
function GetFormW(hPrinter: THandle; pFormName: LPWSTR; Level: DWORD; pForm: Pointer;
  cbBuf: DWORD; var pcbNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM SetForm}
function SetForm(hPrinter: THandle; pFormName: LPWSTR; Level: DWORD; pForm: Pointer): BOOL; stdcall;
{$EXTERNALSYM SetFormA}
function SetFormA(hPrinter: THandle; pFormName: LPSTR; Level: DWORD; pForm: Pointer): BOOL; stdcall;
{$EXTERNALSYM SetFormW}
function SetFormW(hPrinter: THandle; pFormName: LPWSTR; Level: DWORD; pForm: Pointer): BOOL; stdcall;
{$EXTERNALSYM EnumForms}
function EnumForms(hPrinter: THandle; Level: DWORD; pForm: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumFormsA}
function EnumFormsA(hPrinter: THandle; Level: DWORD; pForm: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumFormsW}
function EnumFormsW(hPrinter: THandle; Level: DWORD; pForm: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumMonitors}
function EnumMonitors(pName: LPWSTR; Level: DWORD; pMonitors: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumMonitorsA}
function EnumMonitorsA(pName: LPSTR; Level: DWORD; pMonitors: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumMonitorsW}
function EnumMonitorsW(pName: LPWSTR; Level: DWORD; pMonitors: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM AddMonitor}
function AddMonitor(pName: LPWSTR; Level: DWORD; pMonitors: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddMonitorA}
function AddMonitorA(pName: LPSTR; Level: DWORD; pMonitors: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddMonitorW}
function AddMonitorW(pName: LPWSTR; Level: DWORD; pMonitors: Pointer): BOOL; stdcall;
{$EXTERNALSYM DeleteMonitor}
function DeleteMonitor(pName, pEnvironment, pMonitorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeleteMonitorA}
function DeleteMonitorA(pName, pEnvironment, pMonitorName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM DeleteMonitorW}
function DeleteMonitorW(pName, pEnvironment, pMonitorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM EnumPorts}
function EnumPorts(pName: LPWSTR; Level: DWORD; pPorts: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPortsA}
function EnumPortsA(pName: LPSTR; Level: DWORD; pPorts: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM EnumPortsW}
function EnumPortsW(pName: LPWSTR; Level: DWORD; pPorts: Pointer; cbBuf: DWORD;
  var pcbNeeded, pcReturned: DWORD): BOOL; stdcall;
{$EXTERNALSYM AddPort}
function AddPort(pName: LPWSTR; hWnd: HWND; pMonitorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM AddPortA}
function AddPortA(pName: LPSTR; hWnd: HWND; pMonitorName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM AddPortW}
function AddPortW(pName: LPWSTR; hWnd: HWND; pMonitorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM ConfigurePort}
function ConfigurePort(pName: LPWSTR; hWnd: HWND; pPortName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM ConfigurePortA}
function ConfigurePortA(pName: LPSTR; hWnd: HWND; pPortName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM ConfigurePortW}
function ConfigurePortW(pName: LPWSTR; hWnd: HWND; pPortName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePort}
function DeletePort(pName: LPWSTR; hWnd: HWND; pPortName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePortA}
function DeletePortA(pName: LPSTR; hWnd: HWND; pPortName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePortW}
function DeletePortW(pName: LPWSTR; hWnd: HWND; pPortName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM SetPort}
function SetPort(pName, pPortName: LPWSTR; dwLevel: DWORD; pPortInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM SetPortA}
function SetPortA(pName, pPortName: LPSTR; dwLevel: DWORD; pPortInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM SetPortW}
function SetPortW(pName, pPortName: LPWSTR; dwLevel: DWORD; pPortInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddPrinterConnection}
function AddPrinterConnection(pName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM AddPrinterConnectionA}
function AddPrinterConnectionA(pName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM AddPrinterConnectionW}
function AddPrinterConnectionW(pName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterConnection}
function DeletePrinterConnection(pName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterConnectionA}
function DeletePrinterConnectionA(pName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrinterConnectionW}
function DeletePrinterConnectionW(pName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM ConnectToPrinterDlg}
function ConnectToPrinterDlg(hwnd: HWND; Flags: DWORD): THandle; stdcall;

type
  PProvidorInfo1A = ^TProvidorInfo1A;
  PProvidorInfo1W = ^TProvidorInfo1W;
  PProvidorInfo1 = PProvidorInfo1W;
  {$EXTERNALSYM _PROVIDOR_INFO_1A}
  _PROVIDOR_INFO_1A = record
    pName: LPSTR;
    pEnvironment: LPSTR;
    pDLLName: LPSTR;
  end;
  {$EXTERNALSYM _PROVIDOR_INFO_1W}
  _PROVIDOR_INFO_1W = record
    pName: LPWSTR;
    pEnvironment: LPWSTR;
    pDLLName: LPWSTR;
  end;
  {$EXTERNALSYM _PROVIDOR_INFO_1}
  _PROVIDOR_INFO_1 = _PROVIDOR_INFO_1W;
  TProvidorInfo1A = _PROVIDOR_INFO_1A;
  TProvidorInfo1W = _PROVIDOR_INFO_1W;
  TProvidorInfo1 = TProvidorInfo1W;
  {$EXTERNALSYM PROVIDOR_INFO_1A}
  PROVIDOR_INFO_1A = _PROVIDOR_INFO_1A;
  {$EXTERNALSYM PROVIDOR_INFO_1W}
  PROVIDOR_INFO_1W = _PROVIDOR_INFO_1W;
  {$EXTERNALSYM PROVIDOR_INFO_1}
  PROVIDOR_INFO_1 = PROVIDOR_INFO_1W;

  PProvidorInfo2A = ^TProvidorInfo2A;
  PProvidorInfo2W = ^TProvidorInfo2W;
  PProvidorInfo2 = PProvidorInfo2W;
  {$EXTERNALSYM _PROVIDOR_INFO_2A}
  _PROVIDOR_INFO_2A = record
    pOrder: LPSTR;
  end;
  {$EXTERNALSYM _PROVIDOR_INFO_2W}
  _PROVIDOR_INFO_2W = record
    pOrder: LPWSTR;
  end;
  {$EXTERNALSYM _PROVIDOR_INFO_2}
  _PROVIDOR_INFO_2 = _PROVIDOR_INFO_2W;
  TProvidorInfo2A = _PROVIDOR_INFO_2A;
  TProvidorInfo2W = _PROVIDOR_INFO_2W;
  TProvidorInfo2 = TProvidorInfo2W;
  PROVIDOR_INFO_2A = _PROVIDOR_INFO_2A;
  PROVIDOR_INFO_2W = _PROVIDOR_INFO_2W;
  PROVIDOR_INFO_2 = PROVIDOR_INFO_2W;

{$EXTERNALSYM AddPrintProvidor}
function AddPrintProvidor(pName: LPWSTR; level: DWORD; pProvidorInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddPrintProvidorA}
function AddPrintProvidorA(pName: LPSTR; level: DWORD; pProvidorInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM AddPrintProvidorW}
function AddPrintProvidorW(pName: LPWSTR; level: DWORD; pProvidorInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM DeletePrintProvidor}
function DeletePrintProvidor(pName, pEnvironment, pPrintProvidorName: LPWSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrintProvidorA}
function DeletePrintProvidorA(pName, pEnvironment, pPrintProvidorName: LPSTR): BOOL; stdcall;
{$EXTERNALSYM DeletePrintProvidorW}
function DeletePrintProvidorW(pName, pEnvironment, pPrintProvidorName: LPWSTR): BOOL; stdcall;

{ SetPrinterData and GetPrinterData Server Handle Key values }

const
  {$EXTERNALSYM SPLREG_ALLOW_USER_MANAGEFORMS}
  SPLREG_ALLOW_USER_MANAGEFORMS                     = 'AllowUserManageForms';
  {$EXTERNALSYM SPLREG_ARCHITECTURE}
  SPLREG_ARCHITECTURE                               = 'Architecture';
  {$EXTERNALSYM SPLREG_BEEP_ENABLED}
  SPLREG_BEEP_ENABLED                               = 'BeepEnabled';
  {$EXTERNALSYM SPLREG_DEFAULT_SPOOL_DIRECTORY}
  SPLREG_DEFAULT_SPOOL_DIRECTORY                    = 'DefaultSpoolDirectory';
  {$EXTERNALSYM SPLREG_DNS_MACHINE_NAME}
  SPLREG_DNS_MACHINE_NAME                           = 'DNSMachineName';
  {$EXTERNALSYM SPLREG_DS_PRESENT}
  SPLREG_DS_PRESENT                                 = 'DsPresent';
  {$EXTERNALSYM SPLREG_DS_PRESENT_FOR_USER}
  SPLREG_DS_PRESENT_FOR_USER                        = 'DsPresentForUser';
  {$EXTERNALSYM SPLREG_EVENT_LOG}
  SPLREG_EVENT_LOG                                  = 'EventLog';
  {$EXTERNALSYM SPLREG_MAJOR_VERSION}
  SPLREG_MAJOR_VERSION                              = 'MajorVersion';
  {$EXTERNALSYM SPLREG_MINOR_VERSION}
  SPLREG_MINOR_VERSION                              = 'MinorVersion';
  {$EXTERNALSYM SPLREG_NET_POPUP}
  SPLREG_NET_POPUP                                  = 'NetPopup';
  {$EXTERNALSYM SPLREG_NET_POPUP_TO_COMPUTER}
  SPLREG_NET_POPUP_TO_COMPUTER                      = 'NetPopupToComputer';
  {$EXTERNALSYM SPLREG_OS_VERSION}
  SPLREG_OS_VERSION                                 = 'OSVersion';
  {$EXTERNALSYM SPLREG_OS_VERSION_EX}
  SPLREG_OS_VERSION_EX                              = 'OSVersionEx';
  {$EXTERNALSYM SPLREG_PORT_THREAD_PRIORITY_DEFAULT}
  SPLREG_PORT_THREAD_PRIORITY_DEFAULT               = 'PortThreadPriorityDefault';
  {$EXTERNALSYM SPLREG_PORT_THREAD_PRIORITY}
  SPLREG_PORT_THREAD_PRIORITY                       = 'PortThreadPriority';
  {$EXTERNALSYM SPLREG_PRINT_DRIVER_ISOLATION_GROUPS_SEPARATOR}
  SPLREG_PRINT_DRIVER_ISOLATION_GROUPS_SEPARATOR    = '\';
  {$EXTERNALSYM SPLREG_PRINT_DRIVER_ISOLATION_GROUPS}
  SPLREG_PRINT_DRIVER_ISOLATION_GROUPS              = 'PrintDriverIsolationGroups';
  {$EXTERNALSYM SPLREG_PRINT_DRIVER_ISOLATION_TIME_BEFORE_RECYCLE}
  SPLREG_PRINT_DRIVER_ISOLATION_TIME_BEFORE_RECYCLE = 'PrintDriverIsolationTimeBeforeRecycle';
  {$EXTERNALSYM SPLREG_PRINT_DRIVER_ISOLATION_MAX_OBJECTS_BEFORE_RECYCLE}
  SPLREG_PRINT_DRIVER_ISOLATION_MAX_OBJECTS_BEFORE_RECYCLE = 'PrintDriverIsolationMaxobjsBeforeRecycle';
  {$EXTERNALSYM SPLREG_PRINT_DRIVER_ISOLATION_IDLE_TIMEOUT}
  SPLREG_PRINT_DRIVER_ISOLATION_IDLE_TIMEOUT        = 'PrintDriverIsolationIdleTimeout';
  {$EXTERNALSYM SPLREG_PRINT_DRIVER_ISOLATION_EXECUTION_POLICY}
  SPLREG_PRINT_DRIVER_ISOLATION_EXECUTION_POLICY    = 'PrintDriverIsolationExecutionPolicy';
  {$EXTERNALSYM SPLREG_PRINT_DRIVER_ISOLATION_OVERRIDE_POLICY}
  SPLREG_PRINT_DRIVER_ISOLATION_OVERRIDE_POLICY     = 'PrintDriverIsolationOverrideCompat';
  {$EXTERNALSYM SPLREG_REMOTE_FAX}
  SPLREG_REMOTE_FAX                                 = 'RemoteFax';
  {$EXTERNALSYM SPLREG_RETRY_POPUP}
  SPLREG_RETRY_POPUP                                = 'RetryPopup';
  {$EXTERNALSYM SPLREG_SCHEDULER_THREAD_PRIORITY}
  SPLREG_SCHEDULER_THREAD_PRIORITY                  = 'SchedulerThreadPriority';
  {$EXTERNALSYM SPLREG_SCHEDULER_THREAD_PRIORITY_DEFAULT}
  SPLREG_SCHEDULER_THREAD_PRIORITY_DEFAULT          = 'SchedulerThreadPriorityDefault';
  {$EXTERNALSYM SPLREG_WEBSHAREMGMT}
  SPLREG_WEBSHAREMGMT                               = 'WebShareMgmt';

{ Pool printing behaviour when an error occurs }

  {$EXTERNALSYM SPLREG_RESTART_JOB_ON_POOL_ERROR}
  SPLREG_RESTART_JOB_ON_POOL_ERROR                  = 'RestartJobOnPoolError';
  {$EXTERNALSYM SPLREG_RESTART_JOB_ON_POOL_ENABLED}
  SPLREG_RESTART_JOB_ON_POOL_ENABLED                = 'RestartJobOnPoolEnabled';

{ Predefined registry keys used by SetPrinterDataEx and GetPrinterDataEx}

  {$EXTERNALSYM SPLDS_SPOOLER_KEY}
  SPLDS_SPOOLER_KEY = 'DsSpooler';
  {$EXTERNALSYM SPLDS_DRIVER_KEY}
  SPLDS_DRIVER_KEY  = 'DsDriver';
  {$EXTERNALSYM SPLDS_USER_KEY}
  SPLDS_USER_KEY    = 'DsUser';

  // DS Print-Queue properties

  {$EXTERNALSYM SPLDS_ASSET_NUMBER}
  SPLDS_ASSET_NUMBER                   = 'assetNumber';
  {$EXTERNALSYM SPLDS_BYTES_PER_MINUTE}
  SPLDS_BYTES_PER_MINUTE               = 'bytesPerMinute';
  {$EXTERNALSYM SPLDS_DESCRIPTION}
  SPLDS_DESCRIPTION                    = 'description';
  {$EXTERNALSYM SPLDS_DRIVER_NAME}
  SPLDS_DRIVER_NAME                    = 'driverName';
  {$EXTERNALSYM SPLDS_DRIVER_VERSION}
  SPLDS_DRIVER_VERSION                 = 'driverVersion';
  {$EXTERNALSYM SPLDS_LOCATION}
  SPLDS_LOCATION                       = 'location';
  {$EXTERNALSYM SPLDS_PORT_NAME}
  SPLDS_PORT_NAME                      = 'portName';
  {$EXTERNALSYM SPLDS_PRINT_ATTRIBUTES}
  SPLDS_PRINT_ATTRIBUTES               = 'printAttributes';
  {$EXTERNALSYM SPLDS_PRINT_BIN_NAMES}
  SPLDS_PRINT_BIN_NAMES                = 'printBinNames';
  {$EXTERNALSYM SPLDS_PRINT_COLLATE}
  SPLDS_PRINT_COLLATE                  = 'printCollate';
  {$EXTERNALSYM SPLDS_PRINT_COLOR}
  SPLDS_PRINT_COLOR                    = 'printColor';
  {$EXTERNALSYM SPLDS_PRINT_DUPLEX_SUPPORTED}
  SPLDS_PRINT_DUPLEX_SUPPORTED         = 'printDuplexSupported';
  {$EXTERNALSYM SPLDS_PRINT_END_TIME}
  SPLDS_PRINT_END_TIME                 = 'printEndTime';
  {$EXTERNALSYM SPLDS_PRINTER_CLASS}
  SPLDS_PRINTER_CLASS                  = 'printQueue';
  {$EXTERNALSYM SPLDS_PRINTER_NAME}
  SPLDS_PRINTER_NAME                   = 'printerName';
  {$EXTERNALSYM SPLDS_PRINT_KEEP_PRINTED_JOBS}
  SPLDS_PRINT_KEEP_PRINTED_JOBS        = 'printKeepPrintedJobs';
  {$EXTERNALSYM SPLDS_PRINT_LANGUAGE}
  SPLDS_PRINT_LANGUAGE                 = 'printLanguage';
  {$EXTERNALSYM SPLDS_PRINT_MAC_ADDRESS}
  SPLDS_PRINT_MAC_ADDRESS              = 'printMACAddress';
  {$EXTERNALSYM SPLDS_PRINT_MAX_X_EXTENT}
  SPLDS_PRINT_MAX_X_EXTENT             = 'printMaxXExtent';
  {$EXTERNALSYM SPLDS_PRINT_MAX_Y_EXTENT}
  SPLDS_PRINT_MAX_Y_EXTENT             = 'printMaxYExtent';
  {$EXTERNALSYM SPLDS_PRINT_MAX_RESOLUTION_SUPPORTED}
  SPLDS_PRINT_MAX_RESOLUTION_SUPPORTED = 'printMaxResolutionSupported';
  {$EXTERNALSYM SPLDS_PRINT_MEDIA_READY}
  SPLDS_PRINT_MEDIA_READY              = 'printMediaReady';
  {$EXTERNALSYM SPLDS_PRINT_MEDIA_SUPPORTED}
  SPLDS_PRINT_MEDIA_SUPPORTED          = 'printMediaSupported';
  {$EXTERNALSYM SPLDS_PRINT_MEMORY}
  SPLDS_PRINT_MEMORY                   = 'printMemory';
  {$EXTERNALSYM SPLDS_PRINT_MIN_X_EXTENT}
  SPLDS_PRINT_MIN_X_EXTENT             = 'printMinXExtent';
  {$EXTERNALSYM SPLDS_PRINT_MIN_Y_EXTENT}
  SPLDS_PRINT_MIN_Y_EXTENT             = 'printMinYExtent';
  {$EXTERNALSYM SPLDS_PRINT_NETWORK_ADDRESS}
  SPLDS_PRINT_NETWORK_ADDRESS          = 'printNetworkAddress';
  {$EXTERNALSYM SPLDS_PRINT_NOTIFY}
  SPLDS_PRINT_NOTIFY                   = 'printNotify';
  {$EXTERNALSYM SPLDS_PRINT_NUMBER_UP}
  SPLDS_PRINT_NUMBER_UP                = 'printNumberUp';
  {$EXTERNALSYM SPLDS_PRINT_ORIENTATIONS_SUPPORTED}
  SPLDS_PRINT_ORIENTATIONS_SUPPORTED   = 'printOrientationsSupported';
  {$EXTERNALSYM SPLDS_PRINT_OWNER}
  SPLDS_PRINT_OWNER                    = 'printOwner';
  {$EXTERNALSYM SPLDS_PRINT_PAGES_PER_MINUTE}
  SPLDS_PRINT_PAGES_PER_MINUTE         = 'printPagesPerMinute';
  {$EXTERNALSYM SPLDS_PRINT_RATE}
  SPLDS_PRINT_RATE                     = 'printRate';
  {$EXTERNALSYM SPLDS_PRINT_RATE_UNIT}
  SPLDS_PRINT_RATE_UNIT                = 'printRateUnit';
  {$EXTERNALSYM SPLDS_PRINT_SEPARATOR_FILE}
  SPLDS_PRINT_SEPARATOR_FILE           = 'printSeparatorFile';
  {$EXTERNALSYM SPLDS_PRINT_SHARE_NAME}
  SPLDS_PRINT_SHARE_NAME               = 'printShareName';
  {$EXTERNALSYM SPLDS_PRINT_SPOOLING}
  SPLDS_PRINT_SPOOLING                 = 'printSpooling';
  {$EXTERNALSYM SPLDS_PRINT_STAPLING_SUPPORTED}
  SPLDS_PRINT_STAPLING_SUPPORTED       = 'printStaplingSupported';
  {$EXTERNALSYM SPLDS_PRINT_START_TIME}
  SPLDS_PRINT_START_TIME               = 'printStartTime';
  {$EXTERNALSYM SPLDS_PRINT_STATUS}
  SPLDS_PRINT_STATUS                   = 'printStatus';
  {$EXTERNALSYM SPLDS_PRIORITY}
  SPLDS_PRIORITY                       = 'priority';
  {$EXTERNALSYM SPLDS_SERVER_NAME}
  SPLDS_SERVER_NAME                    = 'serverName';
  {$EXTERNALSYM SPLDS_SHORT_SERVER_NAME}
  SPLDS_SHORT_SERVER_NAME              = 'shortServerName';
  {$EXTERNALSYM SPLDS_UNC_NAME}
  SPLDS_UNC_NAME                       = 'uNCName';
  {$EXTERNALSYM SPLDS_URL}
  SPLDS_URL                            = 'url';
  {$EXTERNALSYM SPLDS_FLAGS}
  SPLDS_FLAGS                          = 'flags';
  {$EXTERNALSYM SPLDS_VERSION_NUMBER}
  SPLDS_VERSION_NUMBER                 = 'versionNumber';

{ Additional Print-Queue properties }

  {$EXTERNALSYM SPLDS_PRINTER_NAME_ALIASES}
  SPLDS_PRINTER_NAME_ALIASES           = 'printerNameAliases';
  {$EXTERNALSYM SPLDS_PRINTER_LOCATIONS}
  SPLDS_PRINTER_LOCATIONS              = 'printerLocations';
  {$EXTERNALSYM SPLDS_PRINTER_MODEL}
  SPLDS_PRINTER_MODEL                  = 'printerModel';

  {$EXTERNALSYM SERVER_ACCESS_ADMINISTER}
  SERVER_ACCESS_ADMINISTER    = $00000001;
  {$EXTERNALSYM SERVER_ACCESS_ENUMERATE}
  SERVER_ACCESS_ENUMERATE     = $00000002;
  {$EXTERNALSYM PRINTER_ACCESS_ADMINISTER}
  PRINTER_ACCESS_ADMINISTER   = $00000004;
  {$EXTERNALSYM PRINTER_ACCESS_USE}
  PRINTER_ACCESS_USE          = $00000008;
  {$EXTERNALSYM JOB_ACCESS_ADMINISTER}
  JOB_ACCESS_ADMINISTER       = $00000010;
  { if NTDDI_VERSION >= NTDDI_WINXPSP1 || OSVER(NTDDI_VERSION) == NTDDI_WIN2K... }
  {$EXTERNALSYM JOB_ACCESS_READ}
  JOB_ACCESS_READ             = $00000020;
  { endif }

{ Access rights for print servers }

  {$EXTERNALSYM SERVER_ALL_ACCESS}
  SERVER_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or
    SERVER_ACCESS_ADMINISTER or SERVER_ACCESS_ENUMERATE);
  {$EXTERNALSYM SERVER_READ}
  SERVER_READ = (STANDARD_RIGHTS_READ or SERVER_ACCESS_ENUMERATE);
  {$EXTERNALSYM SERVER_WRITE}
  SERVER_WRITE = (STANDARD_RIGHTS_WRITE or
    SERVER_ACCESS_ADMINISTER or SERVER_ACCESS_ENUMERATE);
  {$EXTERNALSYM SERVER_EXECUTE}
  SERVER_EXECUTE = (STANDARD_RIGHTS_EXECUTE or SERVER_ACCESS_ENUMERATE);

{ Access rights for printers }

  {$EXTERNALSYM PRINTER_ALL_ACCESS}
  PRINTER_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or
    PRINTER_ACCESS_ADMINISTER or PRINTER_ACCESS_USE);
  {$EXTERNALSYM PRINTER_READ}
  PRINTER_READ = (STANDARD_RIGHTS_READ or PRINTER_ACCESS_USE);
  {$EXTERNALSYM PRINTER_WRITE}
  PRINTER_WRITE = (STANDARD_RIGHTS_WRITE or PRINTER_ACCESS_USE);
  {$EXTERNALSYM PRINTER_EXECUTE}
  PRINTER_EXECUTE = (STANDARD_RIGHTS_EXECUTE or PRINTER_ACCESS_USE);

{ Access rights for jobs }

  {$EXTERNALSYM JOB_ALL_ACCESS}
  JOB_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or JOB_ACCESS_ADMINISTER or JOB_ACCESS_READ);
  {$EXTERNALSYM JOB_READ}
  JOB_READ = (STANDARD_RIGHTS_READ or JOB_ACCESS_READ);
  {$EXTERNALSYM JOB_WRITE}
  JOB_WRITE = (STANDARD_RIGHTS_WRITE or JOB_ACCESS_ADMINISTER);
  {$EXTERNALSYM JOB_EXECUTE}
  JOB_EXECUTE = (STANDARD_RIGHTS_EXECUTE or JOB_ACCESS_ADMINISTER);

{ Flags used by UploadPrinterDriverPackage }

  {$EXTERNALSYM UPDP_SILENT_UPLOAD}
  UPDP_SILENT_UPLOAD     = $00000001;
  {$EXTERNALSYM UPDP_UPLOAD_ALWAYS}
  UPDP_UPLOAD_ALWAYS     = $00000002;
  {$EXTERNALSYM UPDP_CHECK_DRIVERSTORE}
  UPDP_CHECK_DRIVERSTORE = $00000004;

type
  {$EXTERNALSYM TEPrintXPSJobOperation}
  TEPrintXPSJobOperation = (kJobProduction = 1, kJobConsumption);

  {$EXTERNALSYM TEPrintXPSJobProgress}
  TEPrintXPSJobProgress = (
    kAddingDocumentSequence = 0,
    kDocumentSequenceAdded  = 1,
    kAddingFixedDocument    = 2,
    kFixedDocumentAdded     = 3,
    kAddingFixedPage        = 4,
    kFixedPageAdded         = 5,
    kResourceAdded          = 6,
    kFontAdded              = 7,
    kImageAdded             = 8,
    kXpsDocumentCommitted   = 9);

{$EXTERNALSYM DeviceCapabilities}
function DeviceCapabilities(pDevice, pPort: LPCWSTR; fwCapability: Word;
  pOutput: LPWSTR; DevMode: PDeviceMode): Integer; stdcall;
{$EXTERNALSYM DeviceCapabilitiesA}
function DeviceCapabilitiesA(pDevice, pPort: LPCSTR; fwCapability: Word;
  pOutput: LPSTR; DevMode: PDeviceModeA): Integer; stdcall;
{$EXTERNALSYM DeviceCapabilitiesW}
function DeviceCapabilitiesW(pDevice, pPort: LPCWSTR; fwCapability: Word;
  pOutput: LPWSTR; DevMode: PDeviceModeW): Integer; stdcall;

{$EXTERNALSYM AddPrinterConnection2}
function AddPrinterConnection2(hWnd: HWND; pszName: LPCWSTR; dwLevel: DWORD;
  pConnectionInfo: PPrinterConnectionInfo1): BOOL; stdcall;
{$EXTERNALSYM AddPrinterConnection2A}
function AddPrinterConnection2A(hWnd: HWND; pszName: LPCSTR; dwLevel: DWORD;
  pConnectionInfo: PPrinterConnectionInfo1): BOOL; stdcall;
{$EXTERNALSYM AddPrinterConnection2W}
function AddPrinterConnection2W(hWnd: HWND; pszName: LPCWSTR; dwLevel: DWORD;
  pConnectionInfo: PPrinterConnectionInfo1): BOOL; stdcall;
{$EXTERNALSYM CloseSpoolFileHandle}
function CloseSpoolFileHandle(hPrinter, hSpoolFile: THandle): BOOL; stdcall;
{$EXTERNALSYM CommitSpoolData}
function CommitSpoolData(hPrinter, hSpoolFile: THandle; cbCommit: DWORD): THandle; stdcall;
{$EXTERNALSYM CorePrinterDriverInstalled}
function CorePrinterDriverInstalled(pszServer: LPCWSTR; pszEnvironment: LPCWSTR;
  CoreDriverGUID: TGUID; ftDriverDate: FILETIME; dwlDriverVersion: DWORDLONG;
  pbDriverInstalled: PBOOL): HRESULT; stdcall;
{$EXTERNALSYM CorePrinterDriverInstalledA}
function CorePrinterDriverInstalledA(pszServer: LPCSTR; pszEnvironment: LPCSTR;
  CoreDriverGUID: TGUID; ftDriverDate: FILETIME; dwlDriverVersion: DWORDLONG;
  pbDriverInstalled: PBOOL): HRESULT; stdcall;
{$EXTERNALSYM CorePrinterDriverInstalledW}
function CorePrinterDriverInstalledW(pszServer: LPCWSTR; pszEnvironment: LPCWSTR;
  CoreDriverGUID: TGUID; ftDriverDate: FILETIME; dwlDriverVersion: DWORDLONG;
  pbDriverInstalled: PBOOL): HRESULT; stdcall;
{$EXTERNALSYM DeletePrinterDriverPackage}
function DeletePrinterDriverPackage(pszServer: LPCWSTR; pszInfPath: LPCWSTR;
  pszEnvironment: LPCWSTR): HRESULT; stdcall;
{$EXTERNALSYM DeletePrinterDriverPackageA}
function DeletePrinterDriverPackageA(pszServer: LPCSTR; pszInfPath: LPCSTR;
  pszEnvironment: LPCSTR): HRESULT; stdcall;
{$EXTERNALSYM DeletePrinterDriverPackageW}
function DeletePrinterDriverPackageW(pszServer: LPCWSTR; pszInfPath: LPCWSTR;
  pszEnvironment: LPCWSTR): HRESULT; stdcall;
{$EXTERNALSYM ExtDeviceMode}
function ExtDeviceMode(hWnd: HWND; hInst: THandle; pDevModeOutput: PDeviceModeA;
  pDeviceName, pPort: LPSTR; pDevModeInput: PDeviceModeA; pProfile: LPSTR;
  fMode: DWORD): Integer; stdcall;
{$EXTERNALSYM GetCorePrinterDrivers}
function GetCorePrinterDrivers(pszServer: LPCWSTR; pszEnvironment: LPCWSTR;
  pszzCoreDriverDependencies: LPCWSTR; cCorePrinterDrivers: DWORD;
  pCorePrinterDrivers: PCorePrinterDriver): HRESULT; stdcall;
{$EXTERNALSYM GetCorePrinterDriversA}
function GetCorePrinterDriversA(pszServer: LPCSTR; pszEnvironment: LPCSTR;
  pszzCoreDriverDependencies: LPCSTR; cCorePrinterDrivers: DWORD;
  pCorePrinterDrivers: PCorePrinterDriverA): HRESULT; stdcall;
{$EXTERNALSYM GetCorePrinterDriversW}
function GetCorePrinterDriversW(pszServer: LPCWSTR; pszEnvironment: LPCWSTR;
  pszzCoreDriverDependencies: LPCWSTR; cCorePrinterDrivers: DWORD;
  pCorePrinterDrivers: PCorePrinterDriverW): HRESULT; stdcall;
{$EXTERNALSYM GetPrinterDriver2}
function GetPrinterDriver2(hWnd: HWND; hPrinter: THandle;
  pEnvironment: LPWSTR; Level: DWORD; pDriverInfo: LPBYTE; cbBuf: DWORD;
  pcbNeeded: LPDWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterDriver2A}
function GetPrinterDriver2A(hWnd: HWND; hPrinter: THandle;
  pEnvironment: LPSTR; Level: DWORD; pDriverInfo: LPBYTE; cbBuf: DWORD;
  pcbNeeded: LPDWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterDriver2W}
function GetPrinterDriver2W(hWnd: HWND; hPrinter: THandle;
  pEnvironment: LPWSTR; Level: DWORD; pDriverInfo: LPBYTE; cbBuf: DWORD;
  pcbNeeded: LPDWORD): BOOL; stdcall;
{$EXTERNALSYM GetPrinterDriverPackagePath}
function GetPrinterDriverPackagePath(pszServer, pszEnvironment, pszLanguage,
  pszPackageID: LPCWSTR; pszDriverPackageCab: LPWSTR; cchDriverPackageCab: DWORD;
  pcchRequiredSize: LPDWORD): HRESULT; stdcall;
{$EXTERNALSYM GetPrinterDriverPackagePathA}
function GetPrinterDriverPackagePathA(pszServer, pszEnvironment, pszLanguage,
  pszPackageID: LPCSTR; pszDriverPackageCab: LPSTR; cchDriverPackageCab: DWORD;
  pcchRequiredSize: LPDWORD): HRESULT; stdcall;
{$EXTERNALSYM GetPrinterDriverPackagePathW}
function GetPrinterDriverPackagePathW(pszServer, pszEnvironment, pszLanguage,
  pszPackageID: LPCWSTR; pszDriverPackageCab: LPWSTR; cchDriverPackageCab: DWORD;
  pcchRequiredSize: LPDWORD): HRESULT; stdcall;
{$EXTERNALSYM GetSpoolFileHandle}
function GetSpoolFileHandle(hPrinter: THandle): THandle; stdcall;
{$EXTERNALSYM InstallPrinterDriverFromPackage}
function InstallPrinterDriverFromPackage(pszServer, pszInfPath, pszDriverName,
  pszEnvironment: LPCWSTR; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM InstallPrinterDriverFromPackageA}
function InstallPrinterDriverFromPackageA(pszServer, pszInfPath, pszDriverName,
  pszEnvironment: LPCSTR; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM InstallPrinterDriverFromPackageW}
function InstallPrinterDriverFromPackageW(pszServer, pszInfPath, pszDriverName,
  pszEnvironment: LPCWSTR; dwFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM IsValidDevMode}
function IsValidDevMode(pDevmode: PDeviceModeW; DevmodeSize: UIntPtr): BOOL; stdcall;
{$EXTERNALSYM IsValidDevModeA}
function IsValidDevModeA(pDevmode: PDeviceModeA; DevmodeSize: UIntPtr): BOOL; stdcall;
{$EXTERNALSYM IsValidDevModeW}
function IsValidDevModeW(pDevmode: PDeviceModeW; DevmodeSize: UIntPtr): BOOL; stdcall;
{$EXTERNALSYM OpenPrinter2}
function OpenPrinter2(pPrinterName: LPCWSTR; phPrinter: PHANDLE;
  pDefault: PPrinterDefaultsW; pOptions: PPrinterOptionsW): BOOL; stdcall;
{$EXTERNALSYM OpenPrinter2A}
function OpenPrinter2A(pPrinterName: LPCSTR; phPrinter: PHANDLE;
  pDefault: PPrinterDefaultsA; pOptions: PPrinterOptionsA): BOOL; stdcall;
{$EXTERNALSYM OpenPrinter2W}
function OpenPrinter2W(pPrinterName: LPCWSTR; phPrinter: PHANDLE;
  pDefault: PPrinterDefaultsW; pOptions: PPrinterOptionsW): BOOL; stdcall;
{$EXTERNALSYM PrintWindow}
function PrintWindow(hWnd: HWND; hdcBlt: HDC; nFlags: UINT): BOOL; stdcall;
{$EXTERNALSYM ReportJobProcessingProgress}
function ReportJobProcessingProgress(printerHandle: THandle; jobId: ULONG;
  jobOperation: TEPrintXPSJobOperation; jobProgress: TEPrintXPSJobProgress): HRESULT; stdcall;
{$EXTERNALSYM SetDefaultPrinter}
function SetDefaultPrinter(pszPrinter: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM SetDefaultPrinterA}
function SetDefaultPrinterA(pszPrinter: LPCSTR): BOOL; stdcall;
{$EXTERNALSYM SetDefaultPrinterW}
function SetDefaultPrinterW(pszPrinter: LPCWSTR): BOOL; stdcall;
{$EXTERNALSYM UploadPrinterDriverPackage}
function UploadPrinterDriverPackage(pszServer, pszInfPath, pszEnvironment: LPCWSTR;
  dwFlags: DWORD; hwnd: HWND; pszDestInfPath: LPWSTR;
  pcchDestInfPath: PULONG): HRESULT; stdcall;
{$EXTERNALSYM UploadPrinterDriverPackageA}
function UploadPrinterDriverPackageA(pszServer, pszInfPath, pszEnvironment: LPCSTR;
  dwFlags: DWORD; hwnd: HWND; pszDestInfPath: LPSTR;
  pcchDestInfPath: PULONG): HRESULT; stdcall;
{$EXTERNALSYM UploadPrinterDriverPackageW}
function UploadPrinterDriverPackageW(pszServer, pszInfPath, pszEnvironment: LPCWSTR;
  dwFlags: DWORD; hwnd: HWND; pszDestInfPath: LPWSTR;
  pcchDestInfPath: PULONG): HRESULT; stdcall;
{$EXTERNALSYM XcvData}
function XcvData(hXcv: THandle; pszDataName: LPCWSTR; pInputData: PBYTE;
  cbInputData: DWORD; pOutputData: PBYTE; cbOutputData: DWORD;
  pcbOutputNeeded, pdwStatus: PDWORD): BOOL; stdcall;

const
   winspl = 'winspool.drv';

implementation

function AbortPrinter; external winspl name 'AbortPrinter';
function AddForm; external winspl name 'AddFormW';
function AddFormA; external winspl name 'AddFormA';
function AddFormW; external winspl name 'AddFormW';
function AddJob; external winspl name 'AddJobW';
function AddJobA; external winspl name 'AddJobA';
function AddJobW; external winspl name 'AddJobW';
function AddMonitor; external winspl name 'AddMonitorW';
function AddMonitorA; external winspl name 'AddMonitorA';
function AddMonitorW; external winspl name 'AddMonitorW';
function AddPort; external winspl name 'AddPortW';
function AddPortA; external winspl name 'AddPortA';
function AddPortW; external winspl name 'AddPortW';
function AddPrinter; external winspl name 'AddPrinterW';
function AddPrinterA; external winspl name 'AddPrinterA';
function AddPrinterW; external winspl name 'AddPrinterW';
function AddPrinterConnection; external winspl name 'AddPrinterConnectionW';
function AddPrinterConnectionA; external winspl name 'AddPrinterConnectionA';
function AddPrinterConnectionW; external winspl name 'AddPrinterConnectionW';
function AddPrinterDriver; external winspl name 'AddPrinterDriverW';
function AddPrinterDriverA; external winspl name 'AddPrinterDriverA';
function AddPrinterDriverW; external winspl name 'AddPrinterDriverW';
function AddPrinterDriverEx; external winspl name 'AddPrinterDriverExW';
function AddPrinterDriverExA; external winspl name 'AddPrinterDriverExA';
function AddPrinterDriverExW; external winspl name 'AddPrinterDriverExW';
function AddPrintProcessor; external winspl name 'AddPrintProcessorW';
function AddPrintProcessorA; external winspl name 'AddPrintProcessorA';
function AddPrintProcessorW; external winspl name 'AddPrintProcessorW';
function AddPrintProvidor; external winspl name 'AddPrintProvidorW';
function AddPrintProvidorA; external winspl name 'AddPrintProvidorA';
function AddPrintProvidorW; external winspl name 'AddPrintProvidorW';
function AdvancedDocumentProperties; external winspl name 'AdvancedDocumentPropertiesW';
function AdvancedDocumentPropertiesA; external winspl name 'AdvancedDocumentPropertiesA';
function AdvancedDocumentPropertiesW; external winspl name 'AdvancedDocumentPropertiesW';
function ClosePrinter; external winspl name 'ClosePrinter';
function ConfigurePort; external winspl name 'ConfigurePortW';
function ConfigurePortA; external winspl name 'ConfigurePortA';
function ConfigurePortW; external winspl name 'ConfigurePortW';
function ConnectToPrinterDlg; external winspl name 'ConnectToPrinterDlg';
function DeleteForm; external winspl name 'DeleteFormW';
function DeleteFormA; external winspl name 'DeleteFormA';
function DeleteFormW; external winspl name 'DeleteFormW';
function DeleteMonitor; external winspl name 'DeleteMonitorW';
function DeleteMonitorA; external winspl name 'DeleteMonitorA';
function DeleteMonitorW; external winspl name 'DeleteMonitorW';
function DeletePort; external winspl name 'DeletePortW';
function DeletePortA; external winspl name 'DeletePortA';
function DeletePortW; external winspl name 'DeletePortW';
function DeletePrinter; external winspl name 'DeletePrinter';
function DeletePrinterConnection; external winspl name 'DeletePrinterConnectionW';
function DeletePrinterConnectionA; external winspl name 'DeletePrinterConnectionA';
function DeletePrinterConnectionW; external winspl name 'DeletePrinterConnectionW';
function DeletePrinterData; external winspl name 'DeletePrinterDataW';
function DeletePrinterDataA; external winspl name 'DeletePrinterDataA';
function DeletePrinterDataW; external winspl name 'DeletePrinterDataW';
function DeletePrinterDataEx; external winspl name 'DeletePrinterDataExW';
function DeletePrinterDataExA; external winspl name 'DeletePrinterDataExA';
function DeletePrinterDataExW; external winspl name 'DeletePrinterDataExW';
function DeletePrinterDriver; external winspl name 'DeletePrinterDriverW';
function DeletePrinterDriverA; external winspl name 'DeletePrinterDriverA';
function DeletePrinterDriverW; external winspl name 'DeletePrinterDriverW';
function DeletePrinterDriverEx; external winspl name 'DeletePrinterDriverExW';
function DeletePrinterDriverExA; external winspl name 'DeletePrinterDriverExA';
function DeletePrinterDriverExW; external winspl name 'DeletePrinterDriverExW';
function DeletePrinterKey; external winspl name 'DeletePrinterKey';
function DeletePrinterKeyA; external winspl name 'DeletePrinterKeyA';
function DeletePrinterKeyW; external winspl name 'DeletePrinterKeyW';
function DeletePrintProcessor; external winspl name 'DeletePrintProcessorW';
function DeletePrintProcessorA; external winspl name 'DeletePrintProcessorA';
function DeletePrintProcessorW; external winspl name 'DeletePrintProcessorW';
function DeletePrintProvidor; external winspl name 'DeletePrintProvidorW';
function DeletePrintProvidorA; external winspl name 'DeletePrintProvidorA';
function DeletePrintProvidorW; external winspl name 'DeletePrintProvidorW';
function DeviceCapabilities; external winspl name 'DeviceCapabilitiesW';
function DeviceCapabilitiesA; external winspl name 'DeviceCapabilitiesA';
function DeviceCapabilitiesW; external winspl name 'DeviceCapabilitiesW';
function DocumentProperties(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  const pDevModeOutput: TDeviceMode; var pDevModeInput: TDeviceMode;
  fMode: DWORD): Longint;  external winspl name 'DocumentPropertiesW'; overload;
{$EXTERNALSYM DocumentProperties}
function DocumentProperties(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  pDevModeOutput: PDeviceMode; pDevModeInput: PDeviceMode;
  fMode: DWORD): Longint;  external winspl name 'DocumentPropertiesW'; overload;
function DocumentPropertiesA(hWnd: HWND; hPrinter: THandle; pDeviceName: LPSTR;
  const pDevModeOutput: TDeviceModeA; var pDevModeInput: TDeviceModeA;
  fMode: DWORD): Longint;  external winspl name 'DocumentPropertiesA'; overload;
{$EXTERNALSYM DocumentPropertiesA}
function DocumentPropertiesA(hWnd: HWND; hPrinter: THandle; pDeviceName: LPSTR;
  pDevModeOutput: PDeviceModeA; pDevModeInput: PDeviceModeA;
  fMode: DWORD): Longint;  external winspl name 'DocumentPropertiesA'; overload;
function DocumentPropertiesW(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  const pDevModeOutput: TDeviceModeW; var pDevModeInput: TDeviceModeW;
  fMode: DWORD): Longint;  external winspl name 'DocumentPropertiesW'; overload;
{$EXTERNALSYM DocumentPropertiesW}
function DocumentPropertiesW(hWnd: HWND; hPrinter: THandle; pDeviceName: LPWSTR;
  pDevModeOutput: PDeviceModeW; pDevModeInput: PDeviceModeW;
  fMode: DWORD): Longint;  external winspl name 'DocumentPropertiesW'; overload;
function EndDocPrinter; external winspl name 'EndDocPrinter';
function EndPagePrinter; external winspl name 'EndPagePrinter';
function EnumForms; external winspl name 'EnumFormsW';
function EnumFormsA; external winspl name 'EnumFormsA';
function EnumFormsW; external winspl name 'EnumFormsW';
function EnumJobs; external winspl name 'EnumJobsW';
function EnumJobsA; external winspl name 'EnumJobsA';
function EnumJobsW; external winspl name 'EnumJobsW';
function EnumMonitors; external winspl name 'EnumMonitorsW';
function EnumMonitorsA; external winspl name 'EnumMonitorsA';
function EnumMonitorsW; external winspl name 'EnumMonitorsW';
function EnumPorts; external winspl name 'EnumPortsW';
function EnumPortsA; external winspl name 'EnumPortsA';
function EnumPortsW; external winspl name 'EnumPortsW';
function EnumPrinterData; external winspl name 'EnumPrinterDataW';
function EnumPrinterDataA; external winspl name 'EnumPrinterDataA';
function EnumPrinterDataW; external winspl name 'EnumPrinterDataW';
function EnumPrinterDataEx; external winspl name 'EnumPrinterDataExW';
function EnumPrinterDataExA; external winspl name 'EnumPrinterDataExA';
function EnumPrinterDataExW; external winspl name 'EnumPrinterDataExW';
function EnumPrinterDrivers; external winspl name 'EnumPrinterDriversW';
function EnumPrinterDriversA; external winspl name 'EnumPrinterDriversA';
function EnumPrinterDriversW; external winspl name 'EnumPrinterDriversW';
function EnumPrinterKey; external winspl name 'EnumPrinterKeyW';
function EnumPrinterKeyA; external winspl name 'EnumPrinterKeyA';
function EnumPrinterKeyW; external winspl name 'EnumPrinterKeyW';
function EnumPrinters; external winspl name 'EnumPrintersW';
function EnumPrintersA; external winspl name 'EnumPrintersA';
function EnumPrintersW; external winspl name 'EnumPrintersW';
function EnumPrintProcessorDatatypes; external winspl name 'EnumPrintProcessorDatatypesW';
function EnumPrintProcessorDatatypesA; external winspl name 'EnumPrintProcessorDatatypesA';
function EnumPrintProcessorDatatypesW; external winspl name 'EnumPrintProcessorDatatypesW';
function EnumPrintProcessors; external winspl name 'EnumPrintProcessorsW';
function EnumPrintProcessorsA; external winspl name 'EnumPrintProcessorsA';
function EnumPrintProcessorsW; external winspl name 'EnumPrintProcessorsW';
function FindClosePrinterChangeNotification; external winspl name 'FindClosePrinterChangeNotification';
function FindFirstPrinterChangeNotification; external winspl name 'FindFirstPrinterChangeNotification';
function FindNextPrinterChangeNotification; external winspl name 'FindNextPrinterChangeNotification';
function FlushPrinter; external winspl name 'FlushPrinter';
function FreePrinterNotifyInfo; external winspl name 'FreePrinterNotifyInfo';
function GetDefaultPrinter; external winspl name 'GetDefaultPrinterW';
function GetDefaultPrinterA; external winspl name 'GetDefaultPrinterA';
function GetDefaultPrinterW; external winspl name 'GetDefaultPrinterW';
function GetForm; external winspl name 'GetFormW';
function GetFormA; external winspl name 'GetFormA';
function GetFormW; external winspl name 'GetFormW';
function GetJob; external winspl name 'GetJobW';
function GetJobA; external winspl name 'GetJobA';
function GetJobW; external winspl name 'GetJobW';
function GetPrinter; external winspl name 'GetPrinterW';
function GetPrinterA; external winspl name 'GetPrinterA';
function GetPrinterW; external winspl name 'GetPrinterW';
function GetPrinterData; external winspl name 'GetPrinterDataW';
function GetPrinterDataA; external winspl name 'GetPrinterDataA';
function GetPrinterDataW; external winspl name 'GetPrinterDataW';
function GetPrinterDataEx; external winspl name 'GetPrinterDataExW';
function GetPrinterDataExA; external winspl name 'GetPrinterDataExA';
function GetPrinterDataExW; external winspl name 'GetPrinterDataExW';
function GetPrinterDriver; external winspl name 'GetPrinterDriverW';
function GetPrinterDriverA; external winspl name 'GetPrinterDriverA';
function GetPrinterDriverW; external winspl name 'GetPrinterDriverW';
function GetPrinterDriverDirectory; external winspl name 'GetPrinterDriverDirectoryW';
function GetPrinterDriverDirectoryA; external winspl name 'GetPrinterDriverDirectoryA';
function GetPrinterDriverDirectoryW; external winspl name 'GetPrinterDriverDirectoryW';
function GetPrintProcessorDirectory; external winspl name 'GetPrintProcessorDirectoryW';
function GetPrintProcessorDirectoryA; external winspl name 'GetPrintProcessorDirectoryA';
function GetPrintProcessorDirectoryW; external winspl name 'GetPrintProcessorDirectoryW';
function OpenPrinter; external winspl name 'OpenPrinterW';
function OpenPrinterA; external winspl name 'OpenPrinterA';
function OpenPrinterW; external winspl name 'OpenPrinterW';
function PrinterMessageBox; external winspl name 'PrinterMessageBoxW';
function PrinterMessageBoxA; external winspl name 'PrinterMessageBoxA';
function PrinterMessageBoxW; external winspl name 'PrinterMessageBoxW';
function PrinterProperties; external winspl name 'PrinterProperties';
function ReadPrinter; external winspl name 'ReadPrinter';
function ResetPrinter; external winspl name 'ResetPrinterW';
function ResetPrinterA; external winspl name 'ResetPrinterA';
function ResetPrinterW; external winspl name 'ResetPrinterW';
function ScheduleJob; external winspl name 'ScheduleJob';
function SetForm; external winspl name 'SetFormW';
function SetFormA; external winspl name 'SetFormA';
function SetFormW; external winspl name 'SetFormW';
function SetJob; external winspl name 'SetJobW';
function SetJobA; external winspl name 'SetJobA';
function SetJobW; external winspl name 'SetJobW';
function SetPort; external winspl name 'SetPortW';
function SetPortA; external winspl name 'SetPortA';
function SetPortW; external winspl name 'SetPortW';
function SetPrinter; external winspl name 'SetPrinterW';
function SetPrinterA; external winspl name 'SetPrinterA';
function SetPrinterW; external winspl name 'SetPrinterW';
function SetPrinterData; external winspl name 'SetPrinterDataW';
function SetPrinterDataA; external winspl name 'SetPrinterDataA';
function SetPrinterDataW; external winspl name 'SetPrinterDataW';
function SetPrinterDataEx; external winspl name 'SetPrinterDataExW';
function SetPrinterDataExA; external winspl name 'SetPrinterDataExA';
function SetPrinterDataExW; external winspl name 'SetPrinterDataExW';
function StartDocPrinter; external winspl name 'StartDocPrinterW';
function StartDocPrinterA; external winspl name 'StartDocPrinterA';
function StartDocPrinterW; external winspl name 'StartDocPrinterW';
function StartPagePrinter; external winspl name 'StartPagePrinter';
function WaitForPrinterChange; external winspl name 'WaitForPrinterChange';
function WritePrinter; external winspl name 'WritePrinter';

function AddPrinterConnection2; external winspl name 'AddPrinterConnection2W' delayed;
function AddPrinterConnection2A; external winspl name 'AddPrinterConnection2A' delayed;
function AddPrinterConnection2W; external winspl name 'AddPrinterConnection2W' delayed;
function CloseSpoolFileHandle; external winspl name 'CloseSpoolFileHandle' delayed;
function CommitSpoolData; external winspl name 'CommitSpoolData' delayed;
function CorePrinterDriverInstalled; external winspl name 'CorePrinterDriverInstalledW' delayed;
function CorePrinterDriverInstalledA; external winspl name 'CorePrinterDriverInstalledA' delayed;
function CorePrinterDriverInstalledW; external winspl name 'CorePrinterDriverInstalledW' delayed;
function DeletePrinterDriverPackage; external winspl name 'DeletePrinterDriverPackageW' delayed;
function DeletePrinterDriverPackageA; external winspl name 'DeletePrinterDriverPackageA' delayed;
function DeletePrinterDriverPackageW; external winspl name 'DeletePrinterDriverPackageW' delayed;
function ExtDeviceMode; external winspl name 'ExtDeviceMode' delayed;
function GetCorePrinterDrivers; external winspl name 'GetCorePrinterDriversW' delayed;
function GetCorePrinterDriversA; external winspl name 'GetCorePrinterDriversA' delayed;
function GetCorePrinterDriversW; external winspl name 'GetCorePrinterDriversW' delayed;
function GetPrinterDriver2; external winspl name 'GetPrinterDriver2W' delayed;
function GetPrinterDriver2A; external winspl name 'GetPrinterDriver2A' delayed;
function GetPrinterDriver2W; external winspl name 'GetPrinterDriver2W' delayed;
function GetPrinterDriverPackagePath; external winspl name 'GetPrinterDriverPackagePathW' delayed;
function GetPrinterDriverPackagePathA; external winspl name 'GetPrinterDriverPackagePathA' delayed;
function GetPrinterDriverPackagePathW; external winspl name 'GetPrinterDriverPackagePathW' delayed;
function GetSpoolFileHandle; external winspl name 'GetSpoolFileHandle' delayed;
function InstallPrinterDriverFromPackage; external winspl name 'InstallPrinterDriverFromPackageW' delayed;
function InstallPrinterDriverFromPackageA; external winspl name 'InstallPrinterDriverFromPackageA' delayed;
function InstallPrinterDriverFromPackageW; external winspl name 'InstallPrinterDriverFromPackageW' delayed;
function IsValidDevMode; external winspl name 'IsValidDevModeW' delayed;
function IsValidDevModeA; external winspl name 'IsValidDevModeA' delayed;
function IsValidDevModeW; external winspl name 'IsValidDevModeW' delayed;
function OpenPrinter2; external winspl name 'OpenPrinter2W' delayed;
function OpenPrinter2A; external winspl name 'OpenPrinter2A' delayed;
function OpenPrinter2W; external winspl name 'OpenPrinter2W' delayed;
function PrintWindow; external user32 name 'PrintWindow' delayed;
function ReportJobProcessingProgress; external winspl name 'ReportJobProcessingProgress' delayed;
function SetDefaultPrinter; external winspl name 'SetDefaultPrinterW' delayed;
function SetDefaultPrinterA; external winspl name 'SetDefaultPrinterA' delayed;
function SetDefaultPrinterW; external winspl name 'SetDefaultPrinterW' delayed;
function UploadPrinterDriverPackage; external winspl name 'UploadPrinterDriverPackageW' delayed;
function UploadPrinterDriverPackageA; external winspl name 'UploadPrinterDriverPackageA' delayed;
function UploadPrinterDriverPackageW; external winspl name 'UploadPrinterDriverPackageW' delayed;
function XcvData; external winspl name 'XcvDataW' delayed;

end.
