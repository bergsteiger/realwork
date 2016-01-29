// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit orbtypes;

interface

uses SysUtils;

type
{$IFDEF VER130}
  IInterface = IUnknown;
{$ENDIF}
{$IFDEF LINUX}
  wchar = WideChar;
  DWORD = Cardinal;
  LARGE_INTEGER = record
    case boolean of
    true: (LowPart: DWORD; HighPart: longint;);
    false: (QuadPart: int64);
  end;
{$ENDIF}
  PByteLargeArray = ^TByteLargeArray;
  TByteLargeArray = array [0..MaxLongint-1] of Byte;

  Identifier = AnsiString;

  ContextIdentifier = Identifier;

  RepositoryId = AnsiString;
  TRepositoryId = RepositoryId;

  ScopedName = AnsiString;

  VersionSpec = AnsiString;

  ProfileId = Cardinal;
  TProfileId = ProfileId;

  ComponentId = Cardinal;
  TComponentId = ComponentId;

  CodesetId = Cardinal;

  MessageId = Cardinal;

  CharsetId = WORD;

  _ushort = WORD;

  short = smallint;

  float = single;

  longlong = int64;

  _ulonglong = int64;

  long = longint;
  
  _ulong = Cardinal;

  longdouble = Extended;

  PolicyType = _ulong;
  TPolicyType = PolicyType;

  PolicyTypeSeq = array of PolicyType;

  Octet = Byte;

  Cookie = pointer;

  ObjectId = AnsiString;

  ObjectIDList = array of ObjectID;

  Flags = _ulong;

  AddressingDisposition = short;

  PNameComponent = ^TNameComponent;
  TNameComponent = record
    id : AnsiString;
    kind: AnsiString;
  end;

  RepositoryIDSeq = array of RepositoryID;

  ContextIdSeq = array of ContextIdentifier;

  octet_seq = array of Octet;
  OctetSeq = octet_seq;
  TOctetSeq = OctetSeq;

  char_seq = array of AnsiChar;
  CharSeq = char_seq;
  TCharSeq = CharSeq;

  boolean_seq = array of Boolean;
  BooleanSeq = boolean_seq;
  TBooleanSeq = BooleanSeq;

  string_seq = array of AnsiString;
  StringSeq = string_seq;
  TStringSeq = StringSeq;

  wchar_seq = array of WideChar;
  WCharSeq = wchar_seq;
  TWCharSeq = WCharSeq;

  wstring_seq = array of widestring;
  WStringSeq = wstring_seq;
  TWStringSeq = WStringSeq;

  long_seq = array of longint;
  LongSeq = long_seq;
  TLongSeq = LongSeq;

  longlong_seq = array of longlong;
  LongLongSeq = longlong_seq;
  TLongLongSeq = LongLongSeq;

  ulong_seq = array of _ulong;
  ULongSeq = ulong_seq;
  TULongSeq = ULongSeq;

  ulonglong_seq = array of _ulonglong;
  ULongLongSeq = ulonglong_seq;
  TULongLongSeq = ULongLongSeq;

  short_seq = array of short;
  ShortSeq = short_seq;
  TShortSeq = ShortSeq;

  ushort_seq = array of _ushort;
  UShortSeq = ushort_seq;
  TUShortSeq = UShortSeq;

  double_seq = array of double;
  DoubleSeq = double_seq;
  TDoubleSeq = DoubleSeq;

  longdouble_seq = array of longdouble;
  LongDoubleSeq = longdouble_seq;
  TLongDoubleSeq = LongDoubleSeq;

  float_seq = array of float;
  FloatSeq = float_seq;
  TFloatSeq = FloatSeq;

  TContextList = StringSeq;

  TRequestContext = StringSeq;

  TTaggedComponent = record
    tag: ComponentId;
    component_data: array of octet;
  end;

  TTaggedComponentSeq = array of TTaggedComponent;

  TTaggedProfile = record
    tag: ProfileId;
    profile_data: array of octet;
  end;

  TValueModifier = (
    VM_NONE,
    VM_CUSTOM,
    VM_ABSTRACT,
    VM_TRUNCATABLE
  );

  SetOverrideType = (
    SET_OVERRIDE,
    ADD_OVERRIDE
  );

  TCompletionStatus = (COMPLETED_YES,COMPLETED_NO,COMPLETED_MAYBE);

  TLocateStatus = (LocateUnknown,LocateHere,LocateForward,LocateAddrDisp);

  TLocateStatusType = (UNKNOWN_OBJECT,OBJECT_HERE,OBJECT_FORWARD,OBJECT_FORWARD_PERM,
    LOC_SYSTEM_EXCEPTION,LOC_NEEDS_ADDRESSING_MODE);
    
  TByteOrder = (BigEndian, LittleEndian, DefaultEndian);
  
  TMessageType = (Request,Reply,CancelRequest,LocateRequest,
    LocateReply,CloseConnection,MessageError,Fragment);

  TEventType = (InputReady, Closed, Idle);

  TDispEvent = (_Timer, _Read, _Write, _Except, _All, _Remove, _Moved);

  TORBCallbackEvent = (_Invoke, _Locate, _Bind, _Result);

  TReplyStatusType = (NO_EXCEPTION,USER_EXCEPTION,SYSTEM_EXCEPTION,
    LOCATION_FORWARD,LOCATION_FORWARD_PERM,NEEDS_ADDRESSING_MODE);

  TTransportCallBackEvent = (tcRead,tcWrite,tcRemove);

  TTransportServerCallBackEvent = (tsAccept,tsRemove);

  TFamily = (STREAM,DGRAM);

  TInvokeStatus = (InvokeOK, InvokeForward, InvokeSysEx, InvokeUserEx, InvokeAddrDisp);

  TRequestType = (RequestInvoke, RequestBind, RequestLocate, RequestUnknown);

  TSyncScope = (SYNC_NONE, SYNC_WITH_TRANSPORT, SYNC_WITH_SERVER, SYNC_WITH_TARGET);

  TEncapsState = record
    pos : _ulong;
    bo : TByteOrder;
    align: _ulong;
  end;

  PCodesetInfo = ^TCodesetInfo;
  TCodesetInfo = record
    id : CodesetId;
    codepoint_size: _ushort;
    max_codepoints: _ushort;
    charsets: array [0..4] of CharsetId;
    desc: AnsiString;
    name : AnsiString;
  end;

  ServiceType = _ushort;
  ServiceOption = _ulong;
  ServiceDetailType = _ulong;

  TServiceOptions = array of ServiceOption;

  ServiceDetail = record
    service_detail_type: ServiceDetailType;
    service_detail : OctetSeq;
  end;

  TServiceDetails = array of ServiceDetail;

  ServiceInformation = record
    service_options : TServiceOptions;
    service_details : TServiceDetails;
  end;

  TCKind = (
    tk_null,
    tk_void,
    tk_short,
    tk_long,
    tk_ushort,
    tk_ulong,
    tk_float,
    tk_double,
    tk_boolean,
    tk_char,
    tk_octet,
    tk_any,
    tk_TypeCode,
    tk_Principal,
    tk_objref,
    tk_struct,
    tk_union,
    tk_enum,
    tk_string,
    tk_sequence,
    tk_array,
    tk_alias,
    tk_except,
    tk_longlong,
    tk_ulonglong,
    tk_longdouble,
    tk_wchar,
    tk_wstring,
    tk_fixed,
    tk_value,
    tk_value_box,
    tk_native,
    tk_abstract_interface
  );

  TPrimitiveKind = (
    pk_null,
    pk_void,
    pk_short,
    pk_long,
    pk_ushort,
    pk_ulong,
    pk_float,
    pk_double,
    pk_boolean,
    pk_char,
    pk_octet,
    pk_any,
    pk_TypeCode,
    pk_Principal,
    pk_string,
    pk_objref,
    pk_longlong,
    pk_ulonglong,
    pk_longdouble,
    pk_wchar,
    pk_wstring,
    pk_value_base
  );

  TDefinitionKind = (
    dk_none,
    dk_all,
    dk_Attribute,
    dk_Constant,
    dk_Exception,
    dk_Interface,
    dk_Module,
    dk_Operation,
    dk_Typedef,
    dk_Alias,
    dk_Struct,
    dk_Union,
    dk_Enum,
    dk_Primitive,
    dk_String,
    dk_Sequence,
    dk_Array,
    dk_Repository,
    dk_Wstring,
    dk_Fixed,
    dk_Value,
    dk_ValueBox,
    dk_ValueMember,
    dk_Native
  );

  TOperationMode = (
    OP_NORMAL,
    OP_ONEWAY
  );

  ParameterMode = (
    PARAM_IN,
    PARAM_OUT,
    PARAM_INOUT
  );
  TParameterMode = ParameterMode;

  AttributeMode = (
    ATTR_NORMAL,
    ATTR_READONLY
  );
  TAttributeMode = AttributeMode;

  TVisibility = (
    PRIVATE_MEMBER,
    PUBLIC_MEMBER
  );

  SYSEXC_TYPES = (
    st_SYSTEM,
    st_UNKNOWN,
    st_BAD_PARAM,
    st_NO_MEMORY,
    st_IMP_LIMIT,
    st_COMM_FAILURE,
    st_INV_OBJREF,
    st_NO_PERMISSION,
    st_INTERNAL,
    st_MARSHAL,
    st_INITIALIZE,
    st_NO_IMPLEMENT,
    st_BAD_TYPECODE,
    st_BAD_OPERATION,
    st_NO_RESOURCES,
    st_NO_RESPONSE,
    st_PERSIST_STORE,
    st_BAD_INV_ORDER,
    st_TRANSIENT,
    st_FREE_MEM,
    st_INV_IDENT,
    st_INV_FLAG,
    st_INTF_REPOS,
    st_BAD_CONTEXT,
    st_OBJ_ADAPTER,
    st_DATA_CONVERSION,
    st_OBJECT_NOT_EXIST,
    st_TRANSACTION_REQUIRED,
    st_TRANSACTION_ROLLEDBACK,
    st_INVALID_TRANSACTION,
    st_INV_POLICY
    );

    ServiceId = _ulong;
    TServiceId = ServiceId;
    ContextData = array of octet;

    PServiceContext = ^ServiceContext;
    ServiceContext = record
      context_id : ServiceID;
      context_data : ContextData;
    end;
    TServiceContext = ServiceContext;

    ServiceContextList = array of ServiceContext;
    PServiceContextList = ^ServiceContextList;

const
{$IFDEF WIN32}
{$IFDEF STANDART_MEMORY_MANAGER}
  MTDORB_Library_Name = 'mtdorb_bpl.dll';
{$ELSE}
  MTDORB_Library_Name = 'mtdorb.dll';
{$ENDIF}
{$ENDIF}
{$IFDEF LINUX}
  MTDORB_Library_Name = 'libmtdorb.so';
{$ENDIF}
{$IFDEF VER130}
  sLineBreak = #13#10;
{$ENDIF}

  Security : ServiceType = 1;

  CompletionStatusCode: array [TCompletionStatus] of AnsiString = (
    'YES',
    'NO',
    'MAYBE'
  );

  SYSEXC_NAMES : array [SYSEXC_TYPES] of AnsiString = (
    'SystemException',
    'UNKNOWN',
    'BAD_PARAM',
    'NO_MEMORY',
    'IMP_LIMIT',
    'COMM_FAILURE',
    'INV_OBJREF',
    'NO_PERMISSION',
    'INTERNAL',
    'MARSHAL',
    'INITIALIZE',
    'NO_IMPLEMENT',
    'BAD_TYPECODE',
    'BAD_OPERATION',
    'NO_RESOURCES',
    'NO_RESPONSE',
    'PERSIST_STORE',
    'BAD_INV_ORDER',
    'TRANSIENT',
    'FREE_MEM',
    'INV_IDENT',
    'INV_FLAG',
    'INTF_REPOS',
    'BAD_CONTEXT',
    'OBJ_ADAPTER',
    'DATA_CONVERSION',
    'OBJECT_NOT_EXIST',
    'TRANSACTION_REQUIRED',
    'TRANSACTION_ROLLEDBACK',
    'INVALID_TRANSACTION',
    'INV_POLICY'
  );

  SYSEXC_REPOID : array [SYSEXC_TYPES] of AnsiString = (
    'IDL:omg.org/CORBA/SystemException:1.0',
    'IDL:omg.org/CORBA/UNKNOWN:1.0',
    'IDL:omg.org/CORBA/BAD_PARAM:1.0',
    'IDL:omg.org/CORBA/NO_MEMORY:1.0',
    'IDL:omg.org/CORBA/IMP_LIMIT:1.0',
    'IDL:omg.org/CORBA/COMM_FAILURE:1.0',
    'IDL:omg.org/CORBA/INV_OBJREF:1.0',
    'IDL:omg.org/CORBA/NO_PERMISSION:1.0',
    'IDL:omg.org/CORBA/INTERNAL:1.0',
    'IDL:omg.org/CORBA/MARSHAL:1.0',
    'IDL:omg.org/CORBA/INITIALIZE:1.0',
    'IDL:omg.org/CORBA/NO_IMPLEMENT:1.0',
    'IDL:omg.org/CORBA/BAD_TYPECODE:1.0',
    'IDL:omg.org/CORBA/BAD_OPERATION:1.0',
    'IDL:omg.org/CORBA/NO_RESOURCES:1.0',
    'IDL:omg.org/CORBA/NO_RESPONSE:1.0',
    'IDL:omg.org/CORBA/PERSIST_STORE:1.0',
    'IDL:omg.org/CORBA/BAD_INV_ORDER:1.0',
    'IDL:omg.org/CORBA/TRANSIENT:1.0',
    'IDL:omg.org/CORBA/FREE_MEM:1.0',
    'IDL:omg.org/CORBA/INV_IDENT:1.0',
    'IDL:omg.org/CORBA/INV_FLAG:1.0',
    'IDL:omg.org/CORBA/INTF_REPOS:1.0',
    'IDL:omg.org/CORBA/BAD_CONTEXT:1.0',
    'IDL:omg.org/CORBA/OBJ_ADAPTER:1.0',
    'IDL:omg.org/CORBA/DATA_CONVERSION:1.0',
    'IDL:omg.org/CORBA/OBJECT_NOT_EXIST:1.0',
    'IDL:omg.org/CORBA/TRANSACTION_REQUIRED:1.0',
    'IDL:omg.org/CORBA/TRANSACTION_ROLLEDBACK:1.0',
    'IDL:omg.org/CORBA/INVALID_TRANSACTION:1.0',
    'IDL:omg.org/CORBA/INV_POLICY:1.0'
  );

  IOP_TransactionService: ServiceID = 0;
  IOP_CodeSets: ServiceID = 1;
  IOP_BI_DIR_IIOP: ServiceID = 5;

  TAG_INTERNET_IOP = 0;
  TAG_MULTIPLE_COMPONENTS = 1;
  TAG_CODE_SETS = 1;
  TAG_SSL_SEC_TRANS = 20;
  TAG_LOCAL = 20000;
  TAG_ANY = 20001;
  TAG_SSL_INTERNET_IOP = 20002;

  GIOP_KEYADDR = 0;
  GIOP_PROFILEADDR = 1;
  GIOP_REFERENCEADDR = 2;
  GIOP_BYTEORDER_BIT = 1;
  GIOP_FRAGMENT_BIT = 2;

  ARG_IN = $0001;
  ARG_OUT = $0002;
  ARG_INOUT = $0004;

  OAPriorityMin = 0;
  OAPriorityRemote = 1;
  OAPriorityLocal = 2;
  OAPriorityMax = 3;

  ENCODING_CDR_ENCAPS = 0;
  
  // Error Codes
  EPERM  =         1;
  ENOENT =         2;
  ESRCH  =         3;
  EINTR  =         4;
  EIO    =         5;
  ENXIO  =         6;
  E2BIG  =         7;
  ENOEXEC=         8;
  EBADF  =         9;
  ECHILD =         10;
  EAGAIN =         11;
  ENOMEM =         12;
  EACCES =         13;
  EFAULT =         14;
  EBUSY  =         16;
  EEXIST =         17;
  EXDEV  =         18;
  ENODEV =         19;
  ENOTDIR=         20;
  EISDIR  =        21;
  EINVAL =         22;
  ENFILE =         23;
  EMFILE =         24;
  ENOTTY =         25;
  EFBIG   =        27;
  ENOSPC  =        28;
  ESPIPE  =        29;
  EROFS   =        30;
  EMLINK  =        31;
  EPIPE   =        32;
  EDOM    =        33;
  ERANGE  =        34;
  EDEADLK =        36;
  ENAMETOOLONG =   38;
  ENOLCK      =    39;
  ENOSYS      =    40;
  ENOTEMPTY   =    41;
  EILSEQ      =    42;

  VALID_PROFILES: array [0..1] of integer = (TAG_INTERNET_IOP, TAG_SSL_INTERNET_IOP);

  CTX_DELETE_DESCENDENTS = 1;
  CTX_RESTRICT_SCOPE = 2;

  SecConstruction: PolicyType = 11;

implementation

end.

