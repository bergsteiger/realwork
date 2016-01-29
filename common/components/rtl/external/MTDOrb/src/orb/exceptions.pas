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
{**
  All types of ORB Exceptions.
}
unit exceptions;

{$I dorb.inc}

interface

uses
  except_int,code_int,Classes,orbtypes,SysUtils,orb_int;

type

  TInterfacedException = class(Exception, IInterface)
  protected
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function Describe: string; virtual; abstract;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;
  end;

  ORBException = class(TInterfacedException,IORBException)
  protected
    procedure encode(const enc: IEncoder); virtual;
    procedure encode_any(const a: IAny); virtual;
    procedure print(s: TStream);
    function repoid(): RepositoryId; virtual;
    function clone(): IORBException; virtual;
    procedure throw(); virtual;
    function ref_count(): integer;
    function Describe: string; override;
  public
    constructor Create;
    class function decode(dec: IDecoder): IORBException;
    class function decode_any(a: IAny): IORBException;
  end;

  SystemException = class(ORBException,IORBException,ISystemException)
  protected
    {** current exception state }
    FStatus : TCompletionStatus;
    FMinor : _ulong;
    FSysExceptionType : SYSEXC_TYPES;
    FReason: string; // MTDORB specific. Not transmitted in remote method calls.
    FRemote: boolean; // MTDORB specific. If true, exception has been received "over the wire". If false, exception has been generated locally.
    procedure encode(const enc: IEncoder); override;
    procedure encode_any(const a: IAny); override;
    procedure set_minor(val: _ulong);
    procedure set_completed(val: TCompletionStatus);
    procedure assign(const ex: ISystemException);
    function clone(): IORBException; override;
    procedure throw(); override;
    procedure set_reason(const reason: string);
    procedure set_remote(remote: boolean);
    function Describe: string; override;
  public
    constructor Create(ex: SystemException = nil);
    constructor Create_val(minor: _ulong; status: TCompletionStatus);
    constructor Create_type(extype: SYSEXC_TYPES; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
    function repoid(): RepositoryId; override;
    function extype(): SYSEXC_TYPES;
    function minor(): _ulong;
    function completed(): TCompletionStatus;
    function _reason(): string;
    function _remote(): boolean;
    class function decode(dec: IDecoder): IORBException;
    class function decode_any(a: IAny): IORBException;
    class function create_sysex(repoid: RepositoryId; minor: _ulong; stat: TCompletionStatus ): ISystemException; overload;
    class function create_sysex(extype: SYSEXC_TYPES; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO): SystemException; overload;
    class function create_sysex(const reason: string; extype: SYSEXC_TYPES; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO): SystemException; overload;
    class function is_sysex(repoid: RepositoryId): Boolean;
    class function EXCEPTION_DOWNCAST(const ex: IORBException): ISystemException;
  end;

  UNKNOWN = class(SystemException)
  protected
    function Describe: string; override;
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
    constructor Create(const reason: string; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
  end;

  BAD_PARAM = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  NO_MEMORY = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  IMP_LIMIT = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  COMM_FAILURE = class(SystemException)
  protected
    function Describe: string; override;
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
    constructor Create(const reason: string; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
  end;

  INV_OBJREF = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  NO_PERMISSION = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  INTERNAL = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
    constructor Create(const reason: string; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
  end;

  MARSHAL = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
    constructor Create(const reason: string; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
  end;

  INITIALIZE = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
    constructor Create(const reason: string; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
  end;

  NO_IMPLEMENT = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  BAD_TYPECODE = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  BAD_OPERATION = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  NO_RESOURCES = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  NO_RESPONSE = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  PERSIST_STORE = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  BAD_INV_ORDER = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  TRANSIENT = class(SystemException)
  protected
    function Describe: string; override;
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
    constructor Create(const reason: string; minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO); overload;
  end;

  FREE_MEM = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  INV_IDENT = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  INV_FLAG = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  INTF_REPOS = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  BAD_CONTEXT = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  OBJ_ADAPTER = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  DATA_CONVERSION = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  OBJECT_NOT_EXIST = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  TRANSACTION_REQUIRED = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  TRANSACTION_ROLLEDBACK = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  INVALID_TRANSACTION = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  INV_POLICY = class(SystemException)
  public
    constructor Create(minor: _ulong = 0; status: TCompletionStatus = COMPLETED_NO);
  end;

  UserException = class(ORBException,IUserException)
  protected
    function Describe: string; override;
  public
    class function decode(dec: IDecoder): IORBException;
    class function decode_any(a: IAny): IORBException;
    class function EXCEPTION_DOWNCAST(const ex: IORBException): IUserException;
    class function copy(ex: UserException): IORBException;
  end;

  UnknownUserException = class(UserException,IUnknownUserException)
  private
    FDecoder : IDecoder;
    FStaticException : IStaticAny;
    FException: IAny;
    FEx_repoid : RepositoryId;
  protected
    function exception(tc: ITypeCode): IAny; overload;
    function exception(sa: IStaticTypeInfo): IStaticAny; overload;
    function repoid(): RepositoryId; override;
    function except_repoid: RepositoryId;
  public
    constructor Create(dc: IDecoder); overload;
    constructor Create(a: IAny); overload;
    class function EXCEPTION_DOWNCAST(const ex: IORBException): IUnknownUserException;
  end;

  BadKind = class(UserException,IBadKind)
  protected
    function repoid(): RepositoryId; override;
  public
    class function EXCEPTION_DOWNCAST(const ex: IORBException): IBadKind;
  end;

  Bounds = class(UserException,IBounds)
  protected
    function repoid(): RepositoryId; override;
  public
    class function EXCEPTION_DOWNCAST(const ex: IORBException): IBounds;
  end;


implementation

uses
  static{$IFDEF MSWINDOWS}, Windows{$ENDIF}, encoder, decoder, any, tcode, stdstat;

//************************************************************************
// TInterfacedException
//************************************************************************
function TInterfacedException._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TInterfacedException._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

procedure TInterfacedException.AfterConstruction;
begin
  InterlockedDecrement(FRefCount);
  inherited;
end;

procedure TInterfacedException.BeforeDestruction;
begin
  if RefCount <> 0 then
    raise Exception.Create('Can''t destroy Interfaced exception while RefCount > 0');
  inherited;
end;

class function TInterfacedException.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TInterfacedException(Result).FRefCount := 1;
end;

function TInterfacedException.QueryInterface(const IID: TGUID;
  out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

//************************************************************************
// TORBException
//************************************************************************
class function ORBException.decode(dec: IDecoder): IORBException;
var
  e: IORBException;
  pos: _ulong;
begin
  result := nil;
  pos := dec._buffer.RPosition;
  e := SystemException.decode(dec);
  if e = nil then
    begin
      dec._Buffer.RseekFromBegin(pos);
      e := UserException.decode(dec);
      if e = nil then
        begin
          dec._Buffer.RseekFromBegin(pos);
          exit;
        end;
    end;
  result := e;
end;

class function ORBException.decode_any(a: IAny): IORBException;
begin
  result := SystemException.decode_any(a);
  if result <> nil then exit;
  result := UserException.decode_any(a);
end;

function ORBException.ref_count(): integer;
begin
  result := FRefcount;
end;

function ORBException.clone(): IORBException;
begin
  assert(false);
  result := ORBException.Create();
end;

procedure ORBException.throw;
begin
  raise ORBException.Create;
end;

procedure ORBException.encode(const enc: IEncoder);
begin
  assert(false);
end;

procedure ORBException.encode_any(const a: IAny);
begin
  assert(false);
end;

procedure ORBException.print(s: TStream);
var
  buf : PAnsiChar;
begin
  buf := PAnsiChar(repoid());
  s.Write(buf,length(repoid())+1);
end;

function ORBException.repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/Exception:1.0';
end;

constructor ORBException.Create;
begin
  inherited Create(Describe);
end;

function ORBException.Describe: string;
begin
  Result := 'CORBA exception ' + String(repoid);
end;

//*********************************************************************
// TSystemException
//*********************************************************************
constructor SystemException.Create(ex: SystemException);
begin
  FSysExceptionType := st_SYSTEM;
  if ex = nil then
    begin
      FStatus := COMPLETED_NO;
      FMinor := 0;
    end
  else
    begin
      FSysExceptionType := ex.extype;
      FStatus := ex.completed;
      FMinor := ex.minor;
      FReason := ex._reason;
      FRemote := ex._remote;
    end;
  inherited Create;
end;

constructor SystemException.Create_val(minor: _ulong;
  status: TCompletionStatus);
begin
  FSysExceptionType := st_SYSTEM;
  FMinor := minor;
  FStatus := status;
  inherited Create;
end;

constructor SystemException.Create_type(extype: SYSEXC_TYPES; minor: _ulong; status: TCompletionStatus);
begin
  FSysExceptionType := extype;
  FMinor := minor;
  FStatus := status;
  inherited Create;
end;

procedure SystemException.assign(const ex: ISystemException);
begin
  FStatus := ex.completed;
  FMinor := ex.minor;
end;

function SystemException.completed(): TCompletionStatus;
begin
  result := FStatus;
end;

procedure SystemException.encode(const enc: IEncoder);
begin
  enc.except_begin(repoid());
  enc.put_ulong(FMinor);
  enc.put_ulong(ord(FStatus));
  enc.except_end();
end;

procedure SystemException.encode_any(const a: IAny);
var
  sa: IStaticAny;
begin
  sa := StaticAny(stat_SystemException[FSysExceptionType], @Self);
  a.from_static_any(sa);
end;

function SystemException.repoid(): RepositoryId;
begin
  result := SYSEXC_REPOID[FSysExceptionType];
end;

function SystemException.clone(): IORBException;
begin
  result := SystemException.Create(self);
end;

class function SystemException.is_sysex(repoid: RepositoryId): Boolean;
var
  i : SYSEXC_TYPES;
begin
  result := true;
  for i := st_SYSTEM to High(SYSEXC_TYPES) do
    if strcomp(PAnsiChar(repoid), PAnsiChar(SYSEXC_REPOID[i])) = 0 then
      exit;
  result := false;
end;

class function SystemException.EXCEPTION_DOWNCAST(const ex: IORBException): ISystemException;
begin
  result := nil;
  if is_sysex(ex.repoid) then
    result := ISystemException(ex)
end;

function SystemException.minor: _ulong;
begin
  result := FMinor;
end;

procedure SystemException.set_completed(val: TCompletionStatus);
begin
  FStatus := val;
end;

procedure SystemException.set_minor(val: _ulong);
begin
  FMinor := val;
end;

class function SystemException.decode(dec: IDecoder): IORBException;
var
  minor,val: _ulong;
  stat : TCompletionStatus;
  repoid: RepositoryId;
begin
  result := nil;
  if not dec.except_begin(repoid) then
    Exit;
  if not SystemException.is_sysex(repoid) then begin
    dec.except_end();
    Exit;
  end;
  if not dec.get_ulong(minor) or
     not dec.get_ulong(val) or
     not dec.except_end() then exit;
  stat := TCompletionStatus(val);
  result := create_sysex(repoid,minor,stat);
end;

class function SystemException.decode_any(a: IAny): IORBException;
var
  minor,val: _ulong;
  stat : TCompletionStatus;
  repoid: RepositoryId;
begin
  result := nil;

  if not a.except_get_begin(repoid) then
    Exit;
  if not SystemException.is_sysex(repoid) then begin
    a.except_get_end();
    Exit;
  end;

  if not a.get_ulong(minor) or
     not a.get_ulong(val) or
     not a.except_get_end() then
    Exit;
  stat := TCompletionStatus(val);

  result := create_sysex(repoid, minor, stat);
end;

class function SystemException.create_sysex(repoid: RepositoryId; minor: _ulong; stat: TCompletionStatus ): ISystemException;
var
  i : SYSEXC_TYPES;
begin
  result := nil;
  for i := st_SYSTEM to High(SYSEXC_TYPES) do
    if strcomp(PAnsiChar(repoid),PAnsiChar(SYSEXC_REPOID[i])) = 0 then
      begin
        //result := SystemException.Create_type(i,minor,stat);
        result := SystemException.create_sysex(i, minor, stat) as ISystemException;
        break;
      end;
  //if result = nil then
    //result := UNKNOWN.Create(0, stat);
end;

class function SystemException.create_sysex(extype: SYSEXC_TYPES;
  minor: _ulong; status: TCompletionStatus): SystemException;
begin
  case extype of
    st_SYSTEM: result := SystemException.Create_val(minor, status);
    st_UNKNOWN: result := UNKNOWN.Create(minor, status);
    st_BAD_PARAM: result := BAD_PARAM.Create(minor, status);
    st_NO_MEMORY: result := NO_MEMORY.Create(minor, status);
    st_IMP_LIMIT: result := IMP_LIMIT.Create(minor, status);
    st_COMM_FAILURE: result := COMM_FAILURE.Create(minor, status);
    st_INV_OBJREF: result := INV_OBJREF.Create(minor, status);
    st_NO_PERMISSION: result := NO_PERMISSION.Create(minor, status);
    st_INTERNAL: result := INTERNAL.Create(minor, status);
    st_MARSHAL: result := MARSHAL.Create(minor, status);
    st_INITIALIZE: result := INITIALIZE.Create(minor, status);
    st_NO_IMPLEMENT: result := NO_IMPLEMENT.Create(minor, status);
    st_BAD_TYPECODE: result := BAD_TYPECODE.Create(minor, status);
    st_BAD_OPERATION: result := BAD_OPERATION.Create(minor, status);
    st_NO_RESOURCES: result := NO_RESOURCES.Create(minor, status);
    st_NO_RESPONSE: result := NO_RESPONSE.Create(minor, status);
    st_PERSIST_STORE: result := PERSIST_STORE.Create(minor, status);
    st_BAD_INV_ORDER: result := BAD_INV_ORDER.Create(minor, status);
    st_TRANSIENT: result := TRANSIENT.Create(minor, status);
    st_FREE_MEM: result := FREE_MEM.Create(minor, status);
    st_INV_IDENT: result := INV_IDENT.Create(minor, status);
    st_INV_FLAG: result := INV_FLAG.Create(minor, status);
    st_INTF_REPOS: result := INTF_REPOS.Create(minor, status);
    st_BAD_CONTEXT: result := BAD_CONTEXT.Create(minor, status);
    st_OBJ_ADAPTER: result := OBJ_ADAPTER.Create(minor, status);
    st_DATA_CONVERSION: result := DATA_CONVERSION.Create(minor, status);
    st_OBJECT_NOT_EXIST: result := OBJECT_NOT_EXIST.Create(minor, status);
    st_TRANSACTION_REQUIRED: result := TRANSACTION_REQUIRED.Create(minor, status);
    st_TRANSACTION_ROLLEDBACK: result := TRANSACTION_ROLLEDBACK.Create(minor, status);
    st_INVALID_TRANSACTION: result := INVALID_TRANSACTION.Create(minor, status);
    st_INV_POLICY: result := INV_POLICY.Create(minor, status);
    else begin
      result := UNKNOWN.Create(0, status);
    end;
  end;
end;

class function SystemException.create_sysex(const reason: string;
  extype: SYSEXC_TYPES; minor: _ulong;
  status: TCompletionStatus): SystemException;
begin
  result := create_sysex(extype, minor, status);
  result.set_reason(reason);
end;

function SystemException.extype(): SYSEXC_TYPES;
begin
  result := FSysExceptionType;
end;

procedure SystemException.throw;
var
  se: SystemException;
begin
  //raise SystemException.Create(Self);
  se := SystemException.create_sysex(FReason, FSysExceptionType, FMinor, FStatus);
  se.set_remote(FRemote);
  raise se;
end;

function SystemException.Describe: string;
begin
  result := Format('System exception: CORBA::%s%s', [SYSEXC_NAMES[FSysExceptionType], sLineBreak]);
  if FReason <> '' then
    result := Format('%sReason: %s%s', [result, FReason, sLineBreak]);
  if FRemote then
    result := Format('%sLocality: %s%s', [result, 'exception has been received "over the wire"', sLineBreak])
  else
    result := Format('%sLocality: %s%s', [result, 'exception has been generated locally', sLineBreak]);
  result := Format('%sCompleted: %s%s', [result, CompletionStatusCode[completed], sLineBreak]);
  result := Format('%sMinor code: %x', [result, FMinor]);
end;

function SystemException._reason: string;
begin
  result := FReason;
end;

function SystemException._remote: boolean;
begin
  result := FRemote;
end;

procedure SystemException.set_reason(const reason: string);
begin
  if FReason <> reason then begin
    FReason := reason;
    Message := Describe;
  end;
end;

procedure SystemException.set_remote(remote: boolean);
begin
  if FRemote <> remote then begin
    FRemote := remote;
    Message := Describe;
  end;
end;

//*********************************************************************
//  TUserException
//*********************************************************************
class function UserException.copy(ex: UserException): IORBException;
begin
  result := ex.clone();
end;

class function UserException.decode(dec: IDecoder): IORBException;
begin
  result := UnknownUserException.Create(dec);
end;

class function UserException.decode_any(a: IAny): IORBException;
begin
  result := UnknownUserException.Create(CreateAny_any(a));
end;

function UserException.Describe: string;
begin
  Result := 'CORBA user exception ' + String(repoid);
end;

class function UserException.EXCEPTION_DOWNCAST(
  const ex: IORBException): IUserException;
begin
  if SystemException.EXCEPTION_DOWNCAST(ex) = nil then
    result := ex as IUserException;
end;

//*********************************************************************
//  TUnknownUserException
//*********************************************************************
constructor UnknownUserException.Create(dc: IDecoder);
begin
  FStaticException := nil;
  FException := nil;
  FDecoder := dc;
  inherited Create;
end;

constructor UnknownUserException.Create(a: IAny);
begin
  FStaticException := nil;
  FException := a;
  FDecoder := nil;
  inherited Create;
end;

function UnknownUserException.except_repoid: RepositoryId;
var
  rpos : integer;
begin
  if FException <> nil then
    begin
      Assert(FException.except_get_begin(FEx_repoid));
      FException.rewind();
    end
  else
    begin
      rpos := FDecoder._buffer.RPosition;
      FDecoder.except_begin(FEx_repoid);
      FDecoder._buffer.RseekFromBegin(rpos);
    end;
  result := FEx_repoid;
end;

function UnknownUserException.repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/UnknownUserException:1.0';
end;

function UnknownUserException.exception(tc: ITypeCode): IAny;
begin
  if FException = nil then begin
    Assert(tc <> nil);
    Assert(FDecoder <> nil);
    FException := CreateAny;
    Assert(FException.demarshal(tc, FDecoder));
  end;
  result := FException;
end;

function UnknownUserException.exception(sa: IStaticTypeInfo): IStaticAny;
var
  rpos : integer;
  ret : Boolean;
  enc: IEncoder;
  dec: IDecoder;
begin
  if Assigned(FStaticException) then
    begin
      result := FStaticException;
      exit;
    end;
  FStaticException := StaticAny(sa);
  if assigned(FException) then
    begin
      enc := CreateEncoder();
      dec := CreateDecoder(enc.buffer);
      dec.byteorder(enc.byteorder);
      dec.set_converter(enc.get_converter);
      FException.marshal(enc);
      ret := FStaticException.demarshal(dec);
      if not ret then
        raise MARSHAL.Create(0, COMPLETED_NO);
    end
  else
    begin
      assert(assigned(FDecoder));
      rpos := FDecoder._buffer.RPosition;
      ret := FStaticException.demarshal(FDecoder);
      FDecoder._buffer.RseekFromBegin(rpos);
      if not ret then
        raise MARSHAL.Create(0, COMPLETED_NO);
    end;
  result := FStaticException;
end;

class function UnknownUserException.EXCEPTION_DOWNCAST(
  const ex: IORBException): IUnknownUserException;
begin
  result := nil;
  if not (ex = nil) and (strcomp(PAnsiChar(ex.repoid),'IDL:omg.org/CORBA/UnknownUserException:1.0')=0) then
    result := ex as IUnknownUserException;
end;

//*********************************************************************
//  BadKind
//*********************************************************************
class function BadKind.EXCEPTION_DOWNCAST(
  const ex: IORBException): IBadKind;
begin
  result := nil;
  if assigned(ex) and (ex.repoid = 'IDL:omg.org/CORBA/TypeCode/BadKind:1.0') then
    result := ex as IBadKind;
end;

function BadKind.repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/TypeCode/BadKind:1.0';
end;

//*********************************************************************
//  Bounds
//*********************************************************************
class function Bounds.EXCEPTION_DOWNCAST(const ex: IORBException): IBounds;
begin
  result := nil;
  if assigned(ex) and (ex.repoid = 'IDL:omg.org/CORBA/TypeCode/Bounds:1.0') then
    result := ex as IBounds;
end;

function Bounds.repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/TypeCode/Bounds:1.0'
end;

{ UNKNOWN }

constructor UNKNOWN.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_UNKNOWN, minor, status);
end;

constructor UNKNOWN.Create(const reason: string; minor: _ulong;
  status: TCompletionStatus);
begin
  FReason := reason;
  Create(minor, status);
end;

function UNKNOWN.Describe: string;
var
  s: string;
begin
  case FMinor of
    MinorUnknownUserException: s := ' (an unknown user exception was raised)';
    MinorSystemExceptionNotSupported: s := ' (an unsupported system exception was raised)';
  end;
  result := Format('%s%s', [inherited Describe, s]);
end;

{ BAD_PARAM }

constructor BAD_PARAM.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_BAD_PARAM, minor, status);
end;

{ NO_MEMORY }

constructor NO_MEMORY.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_NO_MEMORY, minor, status);
end;

{ IMP_LIMIT }

constructor IMP_LIMIT.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_IMP_LIMIT, minor, status);
end;

{ COMM_FAILURE }

constructor COMM_FAILURE.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_COMM_FAILURE, minor, status);
end;

constructor COMM_FAILURE.Create(const reason: string; minor: _ulong;
  status: TCompletionStatus);
begin
  FReason := reason;
  Create(minor, status);
end;

function COMM_FAILURE.Describe: string;
var
  s: string;
begin
  case FMinor of
    MinorRecv: s := ' (recv() failed)';
    MinorRecvZero: s := ' (recv() returned zero)';
    MinorSend: s := ' (send() failed)';
    MinorSendZero: s := ' (send() returned zero)';
    MinorSocket: s := ' (socket() failed)';
    MinorSetsockopt: s := ' (setsockopt() failed)';
    MinorGetsockopt: s := ' (getsockopt() failed)';
    MinorBind: s := ' (bind() failed)';
    MinorListen: s := ' (listen() failed)';
    MinorConnect: s := ' (connect() failed)';
    MinorAccept: s := ' (accept() failed)';
    MinorSelect: s := ' (select() failed)';
    MinorSetSoTimeout: s := ' (setSoTimeout() failed)';
    MinorGethostname: s := ' (gethostname() failed)';
    MinorGethostbyname: s := ' (gethostbyname() failed)';
    MinorWSAStartup: s := ' (WSAStartup() failed)';
    MinorWSACleanup: s := ' (WSACleanup() failed)';
    MinorNoGIOP: s := ' (not a GIOP message)';
    MinorUnknownMessage: s := ' (unknown GIOP message)';
    MinorWrongMessage: s := ' (wrong GIOP message)';
    MinorMessageError: s := ' (got a "MessageError" message)';
    MinorFragment: s := ' (invalid fragment message)';
    MinorUnknownReqId: s := ' (unknown request id)';
    MinorVersion: s := ' (unsupported GIOP version)';
    MinorPipe: s := ' (pipe() failed)';
  end;
  result := Format('%s%s', [inherited Describe, s]);
end;

{ INV_OBJREF }

constructor INV_OBJREF.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_INV_OBJREF, minor, status);
end;

{ NO_PERMISSION }

constructor NO_PERMISSION.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_NO_PERMISSION, minor, status);
end;

{ INTERNAL }

constructor INTERNAL.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_INTERNAL, minor, status);
end;

constructor INTERNAL.Create(const reason: string; minor: _ulong;
  status: TCompletionStatus);
begin
  FReason := reason;
  Create(minor, status);
end;

{ MARSHAL }

constructor MARSHAL.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_MARSHAL, minor, status);
end;

constructor MARSHAL.Create(const reason: string; minor: _ulong;
  status: TCompletionStatus);
begin
  FReason := reason;
  Create(minor, status);
end;

{ INITIALIZE }

constructor INITIALIZE.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_INITIALIZE, minor, status);
end;

constructor INITIALIZE.Create(const reason: string; minor: _ulong;
  status: TCompletionStatus);
begin
  FReason := reason;
  Create(minor, status);
end;

{ NO_IMPLEMENT }

constructor NO_IMPLEMENT.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_NO_IMPLEMENT, minor, status);
end;

{ BAD_TYPECODE }

constructor BAD_TYPECODE.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_BAD_TYPECODE, minor, status);
end;

{ BAD_OPERATION }

constructor BAD_OPERATION.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_BAD_OPERATION, minor, status);
end;

{ NO_RESOURCES }

constructor NO_RESOURCES.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_NO_RESOURCES, minor, status);
end;

{ NO_RESPONSE }

constructor NO_RESPONSE.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_NO_RESPONSE, minor, status);
end;

{ PERSIST_STORE }

constructor PERSIST_STORE.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_PERSIST_STORE, minor, status);
end;

{ BAD_INV_ORDER }

constructor BAD_INV_ORDER.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_BAD_INV_ORDER, minor, status);
end;

{ TRANSIENT }

constructor TRANSIENT.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_TRANSIENT, minor, status);
end;

constructor TRANSIENT.Create(const reason: string; minor: _ulong;
  status: TCompletionStatus);
begin
  FReason := reason;
  Create(minor, status);
end;

function TRANSIENT.Describe: string;
var
  s: string;
begin
  case FMinor of
    MinorRequestDiscarded: s := ' (request has been discarded)';
    MinorNoUsableProfileInIOR: s := ' (no usable profile in IOR)';
    MinorRequestCancelled: s := ' (request has been cancelled)';
    MinorPOADestroyed: s := ' (POA has been destroyed)';
    MinorConnectFailed: s := ' (attempt to establish connection failed)';
    MinorCloseConnection: s := ' (got a "CloseConnection" message)';
    MinorActiveConnectionManagement: s := ' (active connection management closed connection)';
    MinorForcedShutdown: s := ' (forced connection shutdown because of timeout)';
    MinorLocationForwardHopCountExceeded: s := ' (maximum forwarding count (10) exceeded)';
  end;
  result := Format('%s%s', [inherited Describe, s]);
end;

{ FREE_MEM }

constructor FREE_MEM.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_FREE_MEM, minor, status);
end;

{ INV_IDENT }

constructor INV_IDENT.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_INV_IDENT, minor, status);
end;

{ INV_FLAG }

constructor INV_FLAG.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_INV_FLAG, minor, status);
end;

{ INTF_REPOS }

constructor INTF_REPOS.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_INTF_REPOS, minor, status);
end;

{ BAD_CONTEXT }

constructor BAD_CONTEXT.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_BAD_CONTEXT, minor, status);
end;

{ OBJ_ADAPTER }

constructor OBJ_ADAPTER.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_OBJ_ADAPTER, minor, status);
end;

{ DATA_CONVERSION }

constructor DATA_CONVERSION.Create(minor: _ulong;
  status: TCompletionStatus);
begin
  inherited Create_type(st_DATA_CONVERSION, minor, status);
end;

{ OBJECT_NOT_EXIST }

constructor OBJECT_NOT_EXIST.Create(minor: _ulong;
  status: TCompletionStatus);
begin
  inherited Create_type(st_OBJECT_NOT_EXIST, minor, status);
end;

{ TRANSACTION_REQUIRED }

constructor TRANSACTION_REQUIRED.Create(minor: _ulong;
  status: TCompletionStatus);
begin
  inherited Create_type(st_TRANSACTION_REQUIRED, minor, status);
end;

{ TRANSACTION_ROLLEDBACK }

constructor TRANSACTION_ROLLEDBACK.Create(minor: _ulong;
  status: TCompletionStatus);
begin
  inherited Create_type(st_TRANSACTION_ROLLEDBACK, minor, status);
end;

{ INVALID_TRANSACTION }

constructor INVALID_TRANSACTION.Create(minor: _ulong;
  status: TCompletionStatus);
begin
  inherited Create_type(st_INVALID_TRANSACTION, minor, status);
end;

{ INV_POLICY }

constructor INV_POLICY.Create(minor: _ulong; status: TCompletionStatus);
begin
  inherited Create_type(st_INV_POLICY, minor, status);
end;

end.
