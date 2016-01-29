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
unit intercept;

interface

uses
  {$ifdef LINUX}dynlibs,{$endif} Classes, intercept_int, orb, orb_int, orbtypes, req_int, env_int, code_int, mcomp_int;

type
  TRoot = class(TORBObject, IRoot)
  private
    FPriority: TPriority;
    FIsActive: boolean;
  protected
    function prio(): TPriority;
    procedure activate(const p: TPriority); virtual;
    procedure deactivate(); virtual;
    function is_active(): boolean;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(); overload;
    constructor Create(Priority: TPriority); overload;
    class function _narrow(const obj : IRoot): IRoot;
  end;

  TBufMethod = (bmInputMessage, bmOutputMessage);
  TClientReqMethod = (crmInitReq, crmAfterMarshal, crmBeforeUnmarshal, crmFinishReq);

  InterceptorMethod1 = function(const req: ILWServerRequest; const env: IEnvironment): boolean of object;
  InterceptorMethod2 = function(const buf: IBuffer; const env: IEnvironment): boolean of object;

  TServerReqMethod = (srmInitReq, srmAfterUnmarshal, srmBeforeMarshal, srmFinishReq);

  TClientInterceptor = class(TRoot, IClientInterceptor)
  private
    class function isc(): IInterfaceList;
    class function _exec(req: ILWRequest; env: IEnvironment; m: TClientReqMethod): boolean; overload;
    class function _exec(buf: IBuffer; env: IEnvironment; m: TBufMethod): boolean; overload;
  protected
    function initialize_request(const req: ILWRequest; const env: IEnvironment): TStatus; virtual;
    function after_marshal(const req: ILWRequest; const env: IEnvironment): TStatus; virtual;
    function output_message(const buf: IBuffer; const env: IEnvironment): TStatus; virtual;
    function input_message(const buf: IBuffer; const env: IEnvironment): TStatus; virtual;
    function before_unmarshal(const req: ILWRequest; const env: IEnvironment): TStatus; virtual;
    function finish_request(const req: ILWRequest; const env: IEnvironment): TStatus; virtual;
    // override Root:: methods
    procedure deactivate(); override;
    procedure activate(const p: TPriority); override;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(); overload;
    constructor Create(Priority: TPriority); overload;
    destructor Destroy; override;
    class function _exec_input_message(buf: IBuffer; env: IEnvironment): boolean;
    class function _exec_initialize_request(req: ILWRequest; env: IEnvironment): boolean;
    class function _exec_after_marshal(req: ILWRequest; env: IEnvironment): boolean;
    class function _exec_before_unmarshal(req: ILWRequest; env: IEnvironment): boolean;
    class function _exec_finish_request(req: ILWRequest; env: IEnvironment): boolean;
    class function _exec_output_message(buf: IBuffer; env: IEnvironment): boolean;
    class function _create_request(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IRequest): ILWRequest;
    class function _idle: boolean;
    class function _narrow(const obj : IClientInterceptor): IClientInterceptor;
  end;

  TServerInterceptor = class(TRoot, IServerInterceptor)
  private
    class function isc(): IInterfaceList;
    class function _exec(req: ILWServerRequest; env: IEnvironment; m: TServerReqMethod): boolean; overload;
    class function _exec(buf: IBuffer; env: IEnvironment; m: TBufMethod): boolean; overload;
  protected
    function input_message(const buf: IBuffer; const env: IEnvironment): TStatus; virtual;
    function initialize_request(const req: ILWServerRequest; const env: IEnvironment): TStatus; virtual;
    function after_unmarshal(const req: ILWServerRequest; const env: IEnvironment): TStatus; virtual;
    function before_marshal(const req: ILWServerRequest; const env: IEnvironment): TStatus; virtual;
    function finish_request(const req: ILWServerRequest; const env: IEnvironment): TStatus; virtual;
    function output_message(const buf: IBuffer; const env: IEnvironment): TStatus; virtual;
    // override Root:: methods
    procedure deactivate(); override;
    procedure activate(const p: TPriority); override;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(); overload;
    constructor Create(Priority: TPriority); overload;
    destructor Destroy; override;
    class function _exec_input_message(buf: IBuffer; env: IEnvironment): boolean;
    class function _exec_initialize_request(req: ILWServerRequest; env: IEnvironment): boolean;
    class function _exec_after_unmarshal(req: ILWServerRequest; env: IEnvironment): boolean;
    class function _exec_before_marshal(req: ILWServerRequest; env: IEnvironment): boolean;
    class function _exec_finish_request(req: ILWServerRequest; env: IEnvironment): boolean;
    class function _exec_output_message(buf: IBuffer; env: IEnvironment): boolean;
    class function _create_request(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IServerRequest): ILWServerRequest;
    class function _idle: boolean;
    class function _narrow(const obj : IServerInterceptor): IServerInterceptor;
  end;

  TInitInterceptor = class(TRoot, IInitInterceptor)
  private
    class function isc(): IInterfaceList;
  protected
    function initialize(const orb: IORB; const id: ORBId; argv: TStrings): TStatus; virtual;
    // override Root:: methods
    procedure deactivate(); override;
    procedure activate(const p: TPriority); override;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(Priority: TPriority);
    destructor Destroy; override;
    class function _exec_initialize(const orb: IORB; const id: ORBId; argv: TStrings): boolean;
    class function _narrow(const obj : IInitInterceptor): IInitInterceptor;
//    function initialize({const} orb: IORB; const id: ORBId; argv: TStrings): TStatus;
  end;

  TConnInterceptor = class(TRoot, IConnInterceptor)
  private
    class function isc(): IInterfaceList;
  protected
    function client_connect(const addr: AnsiString): TStatus; virtual;
    function client_disconnect(const addr: AnsiString): TStatus; virtual;
    // override Root:: methods
    procedure deactivate(); override;
    procedure activate(const p: TPriority); override;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(); overload;
    constructor Create(Priority: TPriority); overload;
    destructor Destroy; override;
    class function _exec_client_connect(const addr: AnsiString): boolean;
    class function _exec_client_disconnect(const addr: AnsiString): boolean;
    class function _narrow(const obj : IConnInterceptor): IConnInterceptor;
  end;

{$IFNDEF USELIB}

  TIntercept_Context = class(TORBObject, IInterceptContext)
  protected
    procedure _destroy();
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    class function _narrow(const obj : IInterceptContext): IInterceptContext;
  end;

  PTContextMapItem = ^TContextMapItem;
  TContextMapItem = record
    interceptor: IRoot;
    ctx: IInterceptContext;
  end;

  TLWRootRequest = class(TORBObject, ILWRootRequest)
  private
    FObj: IORBObject;
    FOp: Identifier;
    FServCnts: PServiceContextList;
    FServContextList: TList;
    FContextList: TList;
  protected
    function get_target(): IORBObject;
    procedure set_target(obj: IORBObject);
    function get_operation(): Identifier;
    procedure set_operation(const ident: Identifier);
    procedure set_service_context(const id: ServiceID; const flags: long; const d: ContextData);
    function get_service_context (const id: ServiceID; const flags: long): ContextData;
    procedure remove_service_context (const id: ServiceID);
    function has_service_context(const id: ServiceID): boolean;
    procedure set_context(const interceptor: IRoot; const ctx: IInterceptContext);
    function get_context(const interceptor: IRoot): IInterceptContext;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(obj: IORBObject; const op: Identifier; svc: PServiceContextList);
    destructor Destroy; override;
    class function _narrow(const obj : ILWRootRequest): ILWRootRequest;
  end;

  TLWRequest = class(TLWRootRequest, ILWRequest)
  private
    FReq: IRequest;
  protected
    function request(): IRequest;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IRequest);
    class function _narrow(const obj : ILWRequest): ILWRequest;
  end;

  TILWServerRequest = class(TLWRootRequest, ILWServerRequest)
  private
    FReq: IServerRequest;
  protected
    function request(): IServerRequest;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IServerRequest);
    class function _narrow(const obj : ILWServerRequest): ILWServerRequest;
  end;

  TBOAInterceptor = class(TRoot, IBOAInterceptor)
  private
    class function isc(): IInterfaceList;
  protected
    function bind(const repoid: RepositoryId; const tag: IObjectTag): TStatus; virtual;
    function restore(const obj: IORBObject): TStatus; virtual;
    function _create(const obj: IORBObject): TStatus; virtual;
    // override Root:: methods
    procedure deactivate(); override;
    procedure activate(const p: TPriority); override;
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(Priority: TPriority);
    destructor Destroy; override;
    class function _exec_restore(obj: IORBObject): boolean;
    class function _exec_create(obj: IORBObject): boolean;
    class function _exec_bind(const repoid: RepositoryId; tag: IObjectTag): boolean;
    class function _narrow(const obj : IBOAInterceptor): IBOAInterceptor;
  end;

  function clientInterceptors: IInterfaceList;
  function serverInterceptors: IInterfaceList;
  function initInterceptors: IInterfaceList;
  function boaInterceptors: IInterfaceList;
  function connInterceptors: IInterfaceList;
  function CreateLWRequest(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IRequest): ILWREquest;
  function CreateLWServerRequest(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IServerRequest): ILWServerREquest;

{$ELSE}

  function clientInterceptors: IInterfaceList; external MTDORB_Library_Name;
  function serverInterceptors: IInterfaceList; external MTDORB_Library_Name;
  function initInterceptors: IInterfaceList; external MTDORB_Library_Name;
  function boaInterceptors: IInterfaceList; external MTDORB_Library_Name;
  function connInterceptors: IInterfaceList; external MTDORB_Library_Name;
  function CreateLWRequest(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IRequest): ILWREquest; external MTDORB_Library_Name;
  function CreateLWServerRequest(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IServerRequest): ILWServerREquest; external MTDORB_Library_Name;

{$ENDIF}

implementation

uses 
  throw, codeset;

{$IFNDEF USELIB}

var
  _clientInterceptors,
  _serverInterceptors,
  _initInterceptors,
  _boaInterceptors,
  _connInterceptors: IInterfaceList;

{$ENDIF}

//*********************************************************************
//  TRoot
//*********************************************************************
procedure TRoot.activate(const p: TPriority);
begin
  FPriority := p;
  FIsActive := true;
end;

constructor TRoot.Create;
begin
  inherited Create();
  FPriority := 0;
  FIsActive := false;
end;

constructor TRoot.Create(Priority: TPriority);
begin
  inherited Create();
  FPriority := Priority;
  FIsActive := true;
end;

procedure TRoot.deactivate;
begin
  FIsActive := false;
end;

function TRoot.is_active: boolean;
begin
  result := FIsActive;
end;

function TRoot.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/Root:1.0' then
    result := Pointer(self as IRoot);
end;

function TRoot.prio: TPriority;
begin
  result := FPriority;
end;

class function TRoot._narrow(const obj: IRoot): IRoot;
begin
  result := obj;
end;

function TRoot._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/Root:1.0';
end;

procedure insert_interceptor(intfList: IInterfaceList; interceptor: IRoot);
var
  i: integer;
begin
  i := intfList.Count;
  if intfList.Count > 0 then
    repeat
      dec(i);
      if interceptor.prio() < IRoot(intfList.Items[i]).prio() then begin
        inc(i);
        Break;
      end;
    until (i = 0);
  intfList.Insert(i, interceptor);
end;

procedure remove_interceptor(intfList: IInterfaceList; interceptor: IRoot);
{var
  i: integer;}
begin
  {repeat
    i := intfList.IndexOf(interceptor);
    if i <> -1 then intfList.Delete(i);
  until i = -1;}
  repeat
  until intfList.Remove(interceptor) = -1;
end;

//*********************************************************************
//  TClientInterceptor
//*********************************************************************
function TClientInterceptor.after_marshal(const req: ILWRequest;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

function TClientInterceptor.before_unmarshal(const req: ILWRequest;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

procedure TClientInterceptor.deactivate;
begin
  inherited;
  remove_interceptor(isc, Self);
end;

function TClientInterceptor.finish_request(const req: ILWRequest;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

function TClientInterceptor.initialize_request(const req: ILWRequest;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

function TClientInterceptor.input_message(const buf: IBuffer;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

procedure TClientInterceptor.activate(const p: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

function TClientInterceptor.output_message(const buf: IBuffer;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

class function TClientInterceptor.isc: IInterfaceList;
begin
  result := clientInterceptors;
end;

constructor TClientInterceptor.Create;
begin
  inherited;
end;

constructor TClientInterceptor.Create(Priority: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

destructor TClientInterceptor.Destroy;
begin
  //Self._AddRef;
  //remove_interceptor(isc, Self);
  inherited;
end;

class function TClientInterceptor._create_request(obj: IORBObject;
  const op: Identifier; svc: PServiceContextList;
  req: IRequest): ILWRequest;
begin
  if isc.Count <> 0 then result := CreateLWRequest(obj, op, svc, req)
  else result := nil;
end;

class function TClientInterceptor._idle: boolean;
begin
  result := isc.Count = 0;
end;

class function TClientInterceptor._exec(req: ILWRequest; env: IEnvironment;
  m: TClientReqMethod): boolean;
var
  i: integer;
  icpt: IClientInterceptor;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    icpt := isc.Items[i] as IClientInterceptor;
    case m of
      crmInitReq: s := icpt.initialize_request(req, env);
      crmAfterMarshal: s := icpt.after_marshal(req, env);
      crmBeforeUnmarshal: s := icpt.before_unmarshal(req, env);
      crmFinishReq: s := icpt.finish_request(req, env);
      else s := INVOKE_CONTINUE;
    end;
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TClientInterceptor._exec(buf: IBuffer; env: IEnvironment;
  m: TBufMethod): boolean;
var
  i: integer;
  icpt: IClientInterceptor;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    icpt := isc.Items[i] as IClientInterceptor;
    case m of
      bmInputMessage: s := icpt.input_message(buf, env);
      bmOutputMessage: s := icpt.output_message(buf, env);
      else s := INVOKE_CONTINUE;
    end;
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TClientInterceptor._exec_after_marshal(req: ILWRequest;
  env: IEnvironment): boolean;
begin
  result := _exec(req, env, crmAfterMarshal);
end;

class function TClientInterceptor._exec_before_unmarshal(req: ILWRequest;
  env: IEnvironment): boolean;
begin
  result := _exec(req, env, crmBeforeUnmarshal);
end;

class function TClientInterceptor._exec_finish_request(req: ILWRequest;
  env: IEnvironment): boolean;
begin
  result := _exec(req, env, crmFinishReq);
end;

class function TClientInterceptor._exec_initialize_request(req: ILWRequest;
  env: IEnvironment): boolean;
begin
  result := _exec(req, env, crmInitReq);
end;

class function TClientInterceptor._exec_input_message(buf: IBuffer;
  env: IEnvironment): boolean;
begin
  result := _exec(buf, env, bmInputMessage);
end;

class function TClientInterceptor._exec_output_message(buf: IBuffer;
  env: IEnvironment): boolean;
begin
  result := _exec(buf, env, bmOutputMessage);
end;

class function TClientInterceptor._narrow(
  const obj: IClientInterceptor): IClientInterceptor;
begin

end;

function TClientInterceptor.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/ClientInterceptor:1.0' then
    result := Pointer(self as IClientInterceptor);
end;

function TClientInterceptor._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/ClientInterceptor:1.0';
end;

//*********************************************************************
//  TServerInterceptor
//*********************************************************************
procedure TServerInterceptor.activate(const p: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

function TServerInterceptor.after_unmarshal(const req: ILWServerRequest;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

function TServerInterceptor.before_marshal(const req: ILWServerRequest;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

constructor TServerInterceptor.Create;
begin
  inherited;
end;

constructor TServerInterceptor.Create(Priority: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

procedure TServerInterceptor.deactivate;
begin
  inherited;
  remove_interceptor(isc, Self);
end;

destructor TServerInterceptor.Destroy;
begin
  //Self._AddRef;
  //remove_interceptor(isc, Self);
  inherited;
end;

function TServerInterceptor.finish_request(const req: ILWServerRequest;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

function TServerInterceptor.initialize_request(const req: ILWServerRequest;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

function TServerInterceptor.input_message(const buf: IBuffer;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

class function TServerInterceptor.isc: IInterfaceList;
begin
  result := serverInterceptors;
end;

function TServerInterceptor.output_message(const buf: IBuffer;
  const env: IEnvironment): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

class function TServerInterceptor._exec(req: ILWServerRequest;
  env: IEnvironment; m: TServerReqMethod): boolean;
var
  i: integer;
  icpt: IServerInterceptor;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    icpt := isc.Items[i] as IServerInterceptor;
    case m of
      srmInitReq: s := icpt.initialize_request(req, env);
      srmAfterUnmarshal: s := icpt.after_unmarshal(req, env);
      srmBeforeMarshal: s := icpt.before_marshal(req, env);
      srmFinishReq: s := icpt.finish_request(req, env);
      else s := INVOKE_CONTINUE;
    end;
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TServerInterceptor._create_request(obj: IORBObject;
  const op: Identifier; svc: PServiceContextList;
  req: IServerRequest): ILWServerRequest;
begin
  if isc.Count <> 0 then result := CreateLWServerRequest(obj, op, svc, req)
  else result := nil;
end;

class function TServerInterceptor._exec(buf: IBuffer; env: IEnvironment;
  m: TBufMethod): boolean;
var
  i: integer;
  icpt: IServerInterceptor;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    icpt := isc.Items[i] as IServerInterceptor;
    case m of
      bmInputMessage: s := icpt.input_message(buf, env);
      bmOutputMessage: s := icpt.output_message(buf, env);
      else s := INVOKE_CONTINUE;
    end;
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TServerInterceptor._exec_after_unmarshal(
  req: ILWServerRequest; env: IEnvironment): boolean;
begin
  result := _exec(req, env, srmAfterUnmarshal);
end;

class function TServerInterceptor._exec_before_marshal(
  req: ILWServerRequest; env: IEnvironment): boolean;
begin
  result := _exec(req, env, srmBeforeMarshal);
end;

class function TServerInterceptor._exec_finish_request(
  req: ILWServerRequest; env: IEnvironment): boolean;
begin
  result := _exec(req, env, srmFinishReq);
end;

class function TServerInterceptor._exec_initialize_request(
  req: ILWServerRequest; env: IEnvironment): boolean;
begin
  result := _exec(req, env, srmInitReq);
end;

class function TServerInterceptor._exec_input_message(buf: IBuffer;
  env: IEnvironment): boolean;
begin
  result := _exec(buf, env, bmInputMessage);
end;

class function TServerInterceptor._exec_output_message(buf: IBuffer;
  env: IEnvironment): boolean;
begin
  result := _exec(buf, env, bmOutputMessage);
end;

class function TServerInterceptor._idle: boolean;
begin
  result := isc.Count = 0;
end;

class function TServerInterceptor._narrow(
  const obj: IServerInterceptor): IServerInterceptor;
begin
  result := obj;
end;

function TServerInterceptor.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/ServerInterceptor:1.0' then
    result := Pointer(self as IServerInterceptor);
end;

function TServerInterceptor._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/ServerInterceptor:1.0';
end;

//*********************************************************************
//  TInitInterceptor
//*********************************************************************
procedure TInitInterceptor.activate(const p: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

constructor TInitInterceptor.Create(Priority: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

procedure TInitInterceptor.deactivate;
begin
  inherited;
  remove_interceptor(isc, Self);
end;

destructor TInitInterceptor.Destroy;
begin
  //Self._AddRef;
  //remove_interceptor(isc, Self);
  inherited;
end;

function TInitInterceptor.initialize(const orb: IORB; const id: ORBId;
  argv: TStrings): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

class function TInitInterceptor.isc: IInterfaceList;
begin
  result := initInterceptors;
end;

function TInitInterceptor.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/InitInterceptor:1.0' then
    result := Pointer(self as IInitInterceptor);
end;

function TInitInterceptor._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/InitInterceptor:1.0';
end;

class function TInitInterceptor._exec_initialize(const orb: IORB;
  const id: ORBId; argv: TStrings): boolean;
var
  i: integer;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    s := (isc.Items[i] as IInitInterceptor).initialize(orb, id, argv);
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TInitInterceptor._narrow(
  const obj: IInitInterceptor): IInitInterceptor;
begin
  result := obj;
end;

//*********************************************************************
//  TConnInterceptor
//*********************************************************************
procedure TConnInterceptor.activate(const p: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

function TConnInterceptor.client_connect(const addr: AnsiString): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

function TConnInterceptor.client_disconnect(const addr: AnsiString): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

constructor TConnInterceptor.Create;
begin
  inherited;
end;

constructor TConnInterceptor.Create(Priority: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

procedure TConnInterceptor.deactivate;
begin
  inherited;
  remove_interceptor(isc, Self);
end;

destructor TConnInterceptor.Destroy;
begin
  //Self._AddRef;
  //remove_interceptor(isc, Self);
  inherited;
end;

class function TConnInterceptor.isc: IInterfaceList;
begin
  result := connInterceptors;
end;

function TConnInterceptor.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/ConnInterceptor:1.0' then
    result := Pointer(self as IConnInterceptor);
end;

function TConnInterceptor._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/ConnInterceptor:1.0';
end;

class function TConnInterceptor._exec_client_connect(
  const addr: AnsiString): boolean;
var
  i: integer;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    s := (isc.Items[i] as IConnInterceptor).client_connect(addr);
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TConnInterceptor._exec_client_disconnect(
  const addr: AnsiString): boolean;
var
  i: integer;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    s := (isc.Items[i] as IConnInterceptor).client_disconnect(addr);
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TConnInterceptor._narrow(
  const obj: IConnInterceptor): IConnInterceptor;
begin
  result := obj;
end;

{$IFNDEF USELIB}

//*********************************************************************
//  TLWRootRequest
//*********************************************************************
constructor TLWRootRequest.Create(obj: IORBObject; const op: Identifier; svc: PServiceContextList);
begin
  inherited;
  FObj := obj;
  FOp := op;
  FServCnts := svc;
  FServContextList := TList.Create;
  FContextList := TList.Create;
end;

destructor TLWRootRequest.Destroy;
begin
  FContextList.Free;
  FServContextList.Free;
  inherited;
end;

function TLWRootRequest.get_context(const interceptor: IRoot): IInterceptContext;
var
  i: integer;
begin
  i := 0;
  while (i < FContextList.Count) and (PTContextMapItem(FContextList.Items[i])^.interceptor <> interceptor) do inc(i);
  if i < FContextList.Count then result := PTContextMapItem(FContextList.Items[i])^.ctx;
end;

function TLWRootRequest.get_operation: Identifier;
begin
  result := FOp;
end;

function TLWRootRequest.get_service_context(const id: ServiceID;
  const flags: Integer): ContextData;
var
  i, len: integer;
begin
  i := 0;
  len := Length(FServCnts^);
  while (i < len) and (FServCnts^[i].context_id <> id) do inc(i);
  if i = len then
    dorb_throw(st_BAD_PARAM)
  else begin
    result := FServCnts^[i].context_data;
  end;
end;

function TLWRootRequest.get_target: IORBObject;
begin
  result := FObj;
end;

function TLWRootRequest.has_service_context(const id: ServiceID): boolean;
var
  i, len: integer;
begin
  i := 0;
  len := Length(FServCnts^);
  while (i < len) and (FServCnts^[i].context_id <> id) do inc(i);
  result := i < len;
end;

function TLWRootRequest.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/LWRootRequest:1.0' then
    result := Pointer(self as ILWRootRequest);
end;

procedure TLWRootRequest.remove_service_context(const id: ServiceID);
var
  i, len: integer;
  svc: ServiceContextList;
begin
  i := 0; svc := nil;
  len := Length(FServCnts^);
  while (i < len) and (FServCnts^[i].context_id <> id) do inc(i);
  if i < len then begin
    svc := Copy(FServCnts^, 0, len);
    FServCnts^ := Copy(svc, 0, i - 1);
    FServCnts^ := Copy(svc, i + 1, len - i);
  end;
end;

function TLWRootRequest._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/LWRootRequest:1.0';
end;

procedure TLWRootRequest.set_context(const interceptor: IRoot;
  const ctx: IInterceptContext);
var
  i: integer;
  item: PTContextMapItem;
begin
  i := 0;
  while (i < FContextList.Count) and (PTContextMapItem(FContextList.Items[i])^.interceptor <> interceptor) do inc(i);
  if i < FContextList.Count then PTContextMapItem(FContextList.Items[i])^.ctx := ctx
  else begin
    New(item);
    item^.interceptor := interceptor;
    item^.ctx := ctx;
    FContextList.Add(item);
  end;
end;

procedure TLWRootRequest.set_operation(const ident: Identifier);
begin
  FOp := ident;
end;

procedure TLWRootRequest.set_service_context(const id: ServiceID;
  const flags: Integer; const d: ContextData);
var
  i, len: integer;
begin
  i := 0;
  len := Length(FServCnts^);
  while (i < len) and (FServCnts^[i].context_id <> id) do inc(i);
  if i < len then begin
    //find
    if flags <> 0 then
      dorb_throw(st_NO_PERMISSION);
    FServCnts^[i].context_data := d;
  end
  else begin
    SetLength(FServCnts^, len + 1);
    FServCnts^[i].context_id := id;
    FServCnts^[i].context_data := d;
  end;
end;

procedure TLWRootRequest.set_target(obj: IORBObject);
begin
  FObj := obj;
end;

class function TLWRootRequest._narrow(
  const obj: ILWRootRequest): ILWRootRequest;
begin
  result := obj;
end;

//*********************************************************************
//  TLWRequest
//*********************************************************************
constructor TLWRequest.Create(obj: IORBObject; const op: Identifier;
  svc: PServiceContextList; req: IRequest);
begin
  inherited Create(obj, op, svc);
  FReq := req;
end;

function TLWRequest.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/LWRequest:1.0' then
    result := Pointer(self as ILWRequest);
end;

function TLWRequest._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/LWRequest:1.0';
end;

function TLWRequest.request: IRequest;
begin
  result := FReq;
end;

class function TLWRequest._narrow(const obj: ILWRequest): ILWRequest;
begin
  result := obj;
end;

//*********************************************************************
//  TILWServerRequest
//*********************************************************************
constructor TILWServerRequest.Create(obj: IORBObject; const op: Identifier;
  svc: PServiceContextList; req: IServerRequest);
begin
  inherited Create(obj, op, svc);
  FReq := req;
end;

function TILWServerRequest.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/LWServerRequest:1.0' then
    result := Pointer(self as ILWServerRequest);
end;

function TILWServerRequest._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/LWServerRequest:1.0';
end;

function TILWServerRequest.request: IServerRequest;
begin
  result := FReq;
end;

class function TILWServerRequest._narrow(
  const obj: ILWServerRequest): ILWServerRequest;
begin
  result := obj;
end;

//*********************************************************************
//  TBOAInterceptor
//*********************************************************************
function TBOAInterceptor._create(const obj: IORBObject): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

procedure TBOAInterceptor.activate(const p: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

function TBOAInterceptor.bind(const repoid: RepositoryId;
  const tag: IObjectTag): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

procedure TBOAInterceptor.deactivate;
begin
  inherited;
  remove_interceptor(isc, Self);
end;

function TBOAInterceptor.restore(const obj: IORBObject): TStatus;
begin
  result := INVOKE_CONTINUE;
end;

class function TBOAInterceptor.isc: IInterfaceList;
begin
  result := boaInterceptors;
end;

class function TBOAInterceptor._exec_bind(const repoid: RepositoryId;
  tag: IObjectTag): boolean;
var
  i: integer;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    s := (isc.Items[i] as IBOAInterceptor).bind(repoid, tag);
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TBOAInterceptor._exec_create(obj: IORBObject): boolean;
var
  i: integer;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    s := (isc.Items[i] as IBOAInterceptor)._create(obj);
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

class function TBOAInterceptor._exec_restore(obj: IORBObject): boolean;
var
  i: integer;
  s: TStatus;
begin
  result := true;
  if isc.Count = 0 then Exit;
  for i := 0 to isc.Count - 1 do begin
    s := (isc.Items[i] as IBOAInterceptor).restore(obj);
    case s of
      INVOKE_ABORT:
      begin
        result := false;
        Break;
      end;
      INVOKE_RETRY: Assert(false); // XXX what to do ???
      INVOKE_BREAK: Break;
    end;
  end;
end;

constructor TBOAInterceptor.Create(Priority: TPriority);
begin
  inherited;
  insert_interceptor(isc, Self);
end;

destructor TBOAInterceptor.Destroy;
begin
  //Self._AddRef;
  //remove_interceptor(isc, Self);
  inherited;
end;

class function TBOAInterceptor._narrow(
  const obj: IBOAInterceptor): IBOAInterceptor;
begin
  result := obj;
end;

function TBOAInterceptor.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/BOAInterceptor:1.0' then
    result := Pointer(self as IBOAInterceptor);
end;

function TBOAInterceptor._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/BOAInterceptor:1.0';
end;

//*********************************************************************
//  TIntercept_Context
//*********************************************************************
function TIntercept_Context.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/Interceptor/Context:1.0' then
    result := Pointer(self as IInterceptContext);
end;

function TIntercept_Context._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/Interceptor/Context:1.0';
end;

procedure TIntercept_Context._destroy;
begin
  Self._Release;
end;

class function TIntercept_Context._narrow(
  const obj: IInterceptContext): IInterceptContext;
begin
  result := obj;
end;

function clientInterceptors: IInterfaceList;
begin
  if _clientInterceptors = nil then
    _clientInterceptors := TInterfaceList.Create;
  result := _clientInterceptors;
end;

function serverInterceptors: IInterfaceList;
begin
  if _serverInterceptors = nil then
    _serverInterceptors := TInterfaceList.Create;
  result := _serverInterceptors
end;

function initInterceptors: IInterfaceList;
begin
  if _initInterceptors = nil then
    _initInterceptors := TInterfaceList.Create;
  result := _initInterceptors
end;

function boaInterceptors: IInterfaceList;
begin
  if _boaInterceptors = nil then
    _boaInterceptors := TInterfaceList.Create;
  result := _boaInterceptors
end;

function connInterceptors: IInterfaceList;
begin
  if _connInterceptors = nil then
    _connInterceptors := TInterfaceList.Create;
  result := _connInterceptors
end;

function CreateLWRequest(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IRequest): ILWREquest;
begin
  result := TLWRequest.Create(obj,op,svc,req)
end;

function CreateLWServerRequest(obj: IORBObject; const op: Identifier; svc: PServiceContextList; req: IServerRequest): ILWServerREquest;
begin
  result := TILWServerRequest.Create(obj,op,svc,req)
end;

{$IFDEF LIBRARY}
exports
  clientInterceptors,
  serverInterceptors,
  initInterceptors,
  boaInterceptors,
  connInterceptors,
  CreateLWRequest,
  CreateLWServerRequest;
initialization
finalization
  _clientInterceptors := nil;
  _serverInterceptors := nil;
  _initInterceptors := nil;
  _boaInterceptors := nil;
  _connInterceptors := nil;
{$ENDIF}
{$ENDIF}
end.
