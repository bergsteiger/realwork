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
   Implementations of Object, Tag, InvokeRecord and ORB.
 }
unit orb;

interface

{$I dorb.inc}

uses
  {$IFDEF WIN32}Windows,{$ENDIF}{$IFDEF LINUX}Libc,{$ENDIF}Classes,orb_int,orbtypes,
  SysUtils,disp_int,giop_int,addr_int,iior_int,iiop_int,req_int,value_int,map_int,
  env_int, code_int,utils,osthread,ir_int,comp_int,bootmanager_int,pi_int;

type
  TProperties = class(TInterfacedObject, IProperties)
  private
    FProps: TStringList;
    procedure LoadDefaultProperties;
  protected
    { IProperties }
    procedure set_Property(const key, value: string);
    function get_Property(const key: string): string;
  public
    constructor Create(); overload;
    constructor Create(props: TStrings); overload;
    destructor Destroy; override;
  end;


  {** implements org.omg/CORBA/Object }
  TORBObject = class(TInterfacedObject, IORBObject)
  protected
    FIOR,FFWD_IOR : IIOR;
    FORB : IORB;
    FPolicies: PolicyList;
    FManagers: DomainManagersList;
  protected
    function get_interface(): IInterfaceDef;
    function duplicate: IORBObject;
    procedure release;
    function _is_a(const repoid: RepositoryId): Boolean;
    function non_existent: Boolean;
    function is_equivalent(obj: IORBObject): Boolean;
    function hash(max: _ulong): _ulong;

    procedure create_request(const ctx: IContext;
      const operation: Identifier; const arg_list: INVList; const res: TNamedValue;
      out request: IRequest; const flags: _ulong);

    function get_policy(const policy_type: PolicyType): IPolicy;
    function get_client_policy(const policy_type: PolicyType): IPolicy;
    function get_domain_managers: DomainManagersList;
    procedure setup_domains (const parent: IORBObject);
    function set_policy_overrides(const policies: PolicyList;
      const set_add: SetOverrideType): IORBObject;
    function get_policy_overrides(const types: PolicyTypeSeq): PolicyList;

    // DORB extension
    procedure assign(const obj: IORBObject);
    function _ior(): IIOR;
    function fwd_ior(): IIOR;
    function _orb(): IORB;
    function narrow_helper(const repoid: RepositoryId): Pointer; virtual;
    function is_forwarded(): Boolean;
    function _is_a_remote(const repoid: RepositoryId): Boolean;
    procedure _unforward();
    procedure _forward(const obj :IORBObject);
    function _repoid(): RepositoryID; virtual;
    function _request(const operation: AnsiString): IRequest; virtual;
    function _policies(): PolicyList;
    function _managers(): DomainManagersList;
  public
    constructor Create(); overload;
    constructor Create(ior: IIOR); overload;
    constructor Create(obj: IORBObject); overload;
    destructor Destroy; override;
  end;

  {** implements org.omg/CORBA/Object }
  TLocalORBObject = class(TInterfacedObject, IORBObject)
  protected
    FIOR,FFWD_IOR : IIOR;
    FORB : IORB;
  protected
    { IORBObject }
    function get_interface(): IInterfaceDef;
    function duplicate: IORBObject;
    procedure release;
    function _is_a(const repoid: RepositoryId): Boolean;
    function non_existent: Boolean;
    function is_equivalent(obj: IORBObject): Boolean;
    function hash(max: _ulong): _ulong;
    procedure create_request(const ctx: IContext;
      const operation: Identifier; const arg_list: INVList; const res: TNamedValue;
      out request: IRequest; const flags: _ulong);
      
    function get_policy(const policy_type: PolicyType): IPolicy;
    function get_client_policy(const policy_type: PolicyType): IPolicy;
    function get_domain_managers: DomainManagersList;
    procedure setup_domains (const parent: IORBObject);
    function set_policy_overrides(const policies: PolicyList;
      const set_add: SetOverrideType): IORBObject;
    function get_policy_overrides(const types: PolicyTypeSeq): PolicyList;

    // DORB extension
    procedure assign(const obj: IORBObject);
    function _ior(): IIOR;
    function fwd_ior(): IIOR;
    function _orb(): IORB;
    function narrow_helper(const repoid: RepositoryId): Pointer; virtual;
    function is_forwarded(): Boolean;
    function _is_a_remote(const repoid: RepositoryId): Boolean;
    procedure _unforward();
    procedure _forward(const obj :IORBObject);
    function _repoid(): RepositoryID; virtual;
    function _request(const operation: Identifier): IRequest; virtual;
    function _policies(): PolicyList;
    function _managers(): DomainManagersList;
  public
    constructor Create(); overload;
    constructor Create(ior : IIOR); overload;
  end;

  TMixedBase = class(TORBObject,IAbstractBase)
  protected
    function _to_object: IORBObject; virtual;
    function _to_value: IValueBase; virtual;
  end;

  TStub = class(TORBObject)
  private
    FObject : IORBObject;
  protected
    function _object: IORBObject;
    function narrow_helper(const str: RepositoryId): Pointer; override;
  public
    constructor Create(const obj: IORBObject);
  end;

  TCORBA_Current = class(TLocalORBObject, ICORBA_Current);

{$IFNDEF USELIB}

  TORBState = (osNotRunning, osRunning, osServerShutdown, osClientShutdown, osDestroyed);

  {** implements org.omg/CORBA/ORB }
  TOrb = class(TORBObject,IORB)
  private
    FMessageCounter : MessageID;
//    test : TStringList;
    FAdapters : TStringList;
    FAdaptersLock: TRWLock;
    FShuttingdownAdapters: IInterfaceList;
    FInitRefs : TStringList;
{$IFDEF USE_ORB_CACHE}
    FCacheUsed: Boolean;
    FCacheRecord : IORBInvokeRecord;
{$ENDIF}
    FInvokes : ILongInterfaceMap;
    FInvokesLock: TRWLock;
    FDispatcher : ISelectDispatcher;
    FBindAddress : TStringlist;
    FIORTempl : IIOR;
    //FRunning : Boolean;
    //FStopped : Boolean;
    FShutdown: boolean;
    FDestroy: boolean;
    FWaitForCompletion : Boolean;
    FValueFactories : TStringList;
    FValueFactoriesLock: TRWLock;
    FTheIDLock: TMutex;
    FInitRefsLock: TRecursiveMutex;
    FShutdownComplete: TThreadMonitor;
    FMainThread: TThreadHandle;
    FProperties: IProperties;
    FState: TORBState;
    FDefaultManager: IDomainManager;
    FBiDirGIOP: Boolean;
{$IFDEF HAVE_THREADS}
    FResourceManager: IResourceManager;
{$ENDIF}
    function _get_invoke(id: ORBMessageID):IORBInvokeRecord;
    procedure validateState();
    procedure blockServerShutdownComplete();
  protected
    function object_to_string(const obj: IORBObject): AnsiString;
    function string_to_object(const str: AnsiString): IORBObject;
    // Dynamic Invocation related operations
    procedure create_list(const count: longint; out new_list: INVList);
    procedure create_operation_list(const oper: IOperationDef; out new_list: INVList);
    procedure get_default_context(out ctx: IContext);
    procedure send_multiple_requests_oneway(const req: RequestSeq);
    procedure send_multiple_requests_deferred(const req: RequestSeq);
    function poll_next_response: Boolean;
    procedure get_next_response(out req: IRequest);
    // Service information operations
    function get_service_information(const service_type: ServiceType;
      out service_information: ServiceInformation): Boolean;
    function list_initial_references: ObjectIDList;
    // Initial reference information
    function resolve_initial_reference(const id: ObjectID): IORBObject;
    // TypeCode creation operations
    function create_struct_tc(const id: RepositoryID; const name : Identifier;
      const members: StructMemberSeq): ITypeCode;
    function create_union_tc(const id: RepositoryID; const name : Identifier;
      const discriminator_type: ITypeCode; const members: UnionMemberSeq): ITypeCode;
    function create_enum_tc(const id: RepositoryID; const name : Identifier;
      const members: EnumMemberSeq): ITypeCode;
    function create_alias_tc(const id: RepositoryID; const name : Identifier;
      const original_type: ITypeCode): ITypeCode;
    function create_exception_tc(const id: RepositoryID; const name : Identifier;
      const members: StructMemberSeq): ITypeCode;
    function create_interface_tc(const id: RepositoryID; const name : Identifier): ITypeCode;
    function create_string_tc(const bound: _ulong): ITypeCode;
    function create_wstring_tc(const bound: _ulong): ITypeCode;
    function create_fixed_tc(const digits: _ushort; const scale: short): ITypeCode;
    function create_sequence_tc(const bound: _ulong; const element_type : ITypeCode): ITypeCode;
    function create_array_tc(const length: _ulong; const element_type : ITypeCode): ITypeCode;
    function create_value_tc(const id: RepositoryID; const name : Identifier;
      const type_modifier: TValueModifier; const concrete_base: ITypeCode;
      const members: ValueMemberSeq): ITypeCode;
    function create_value_box_tc(const id: RepositoryID; const name : Identifier;
      const boxed_type: ITypeCode): ITypeCode;
    function create_native_tc(const id: RepositoryID; const name : Identifier): ITypeCode;
    function create_recursive_tc(const id: RepositoryID): ITypeCode;
    function create_abstract_interface_tc(const id: RepositoryID; const name : Identifier): ITypeCode;
    // Thread related operations
    function work_pending: Boolean;
    procedure perform_work;
    procedure run;
    procedure shutdown(wait_for_completion: Boolean);
    procedure _destroy(); // CORBA::ORB:destroy()
    function resource_manager: IResourceManager;
    // Policy related operations
    function create_policy(_type: PolicyType; const val: IAny): IPolicy;
    procedure get_default_domain_manager (out dm: IDomainManager);
    // Value factory operations
    function register_value_factory(const id: RepositoryID;
      const factory: IValueFactory): IValueFactory;
    procedure unregister_value_factory(const id : RepositoryID);
    function lookup_value_factory(const id : RepositoryID): IValueFactory;
    // DORB extension
    procedure answer_bind(id: ORBMessageID;stat: TLocateStatus;obj : IORBObject);
    procedure answer_locate(id: ORBMessageID; stat: TLocateStatus; obj: IORBObject; ad: AddressingDisposition);
    procedure answer_invoke(id: ORBMessageID; stat: TInvokeStatus; obj: IORBObject; req: IORBRequest; ad: AddressingDisposition);
    procedure answer_shutdown(const oa: IObjectAdaptor);
    procedure bindaddrs(List : TStrings);
    function bind(const repoid: RepositoryId; const addr: AnsiString = ''): IORBObject; overload;
    function bind(const repoid: RepositoryId; const oid: IObjectTag; const addr: AnsiString = ''): IORBObject; overload;
    function bind_addr(const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress; out obj: IORBObject): TLocateStatus;
    function bind_async(const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress; const cb: IORBCallback; id : ORBMessageID): ORBMessageID;
    function BOA_Init(): IUnknown;
    function create_environment: IEnvironment;
    function dispatcher(): ISelectDispatcher;
    function get_bind_reply(id: ORBMessageID; out obj: IORBObject): TLocateStatus;
    function get_invoke_reply (id: ORBMessageID; out obj: IORBObject; out req: IORBRequest; out ad: AddressingDisposition): TInvokeStatus;
    function get_locate_reply(id: ORBMessageID; out obj: IORBObject; out ad: AddressingDisposition): TLocateStatus;
    function ior_to_object(const Ior: IIOR): IORBObject;
    function ior_template: IIOR;
    function invoke_async(const obj: IORBObject; const req: IORBRequest; const pr: IPrincipal; resp: Boolean = true; cb: IORBCallBack = nil; orbmesid: ORBMessageID = nil): ORBMessageID;
    function locate_async(const obj: IORBObject; cb: IORBCallback = nil; id: ORBMessageID = nil): ORBMessageID;
    function is_impl(const obj: IORBObject): Boolean;
    function new_MessageID(): MessageID;
    function _non_existent(obj: IORBObject): Boolean;
    procedure register_oa(const oa: IObjectAdaptor; prio: integer);
    function request_type(id: ORBMessageID): TRequestType;
    procedure redo_request(id: ORBMessageID);
    procedure register_initial_reference(const id: ObjectId; const obj: IORBObject);
    function string_to_tag(const str: AnsiString): IObjectTag;
    procedure unregister_oa(const oa: IObjectAdaptor);
    function wait(id: ORBMessageID; timeout : long = -1): Boolean;
    procedure cancel(id: ORBMessageID); overload;
    procedure cancel(mid: MessageID); overload;
    function invoke(var obj: IORBObject; const req: IORBRequest; const pr: IPrincipal; resp: Boolean = true): TInvokeStatus;
    function locate(var obj: IORBObject): TLocateStatus;
    function create_named_value: TNamedValue;
    function get_current_invoke_rec(): IORBInvokeRecord;
    procedure set_Properties(const props: IProperties);
    function get_Properties(): IProperties;
    procedure TurnOnBiDirGIOP();
    function UseBiDirGIOP(): Boolean;
  protected
    procedure do_shutdown();
    function get_invoke(mid: MessageID):IORBInvokeRecord;
    procedure del_invoke(id: MessageID);
    function builtin_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest):Boolean;
    function is_local(const obj: IORBObject): Boolean;
    function get_oa(const obj: IORBObject): IObjectAdaptor; overload;
    function get_oa(const objectId: ObjectId): IObjectAdaptor; overload;
    function create_invoke(msgid: MessageID): IORBInvokeRecord;
    procedure add_invoke(const inv: IORBInvokeRecord);
    function http_to_object(const str: AnsiString): IORBObject;
    function file_to_object(const str: AnsiString): IORBObject;
    function corbaloc_to_object(const str: AnsiString): IORBObject;
    function corbaname_to_object(const str: AnsiString): IORBObject;
    function _get_interface(const obj: IORBObject): IInterfaceDef;
    function get_msgid(rec: ORBMessageId): MessageID;
    function get_orbid(msgid: MessageId): ORBMessageID;
    function get_invoke_hint(id: ORBMessageId): Pointer;
    procedure set_invoke_hint(id: ORBMessageId; hint: Pointer);
    procedure set_request_hint(id: ORBMessageId; hint: Pointer);
    function get_request_hint(id: ORBMessageId): Pointer;
    function new_orbid(msgid: MessageId = 0): ORBMessageId;
    function is_a(const obj: IORBObject; const repo_id: RepositoryId): Boolean;
  public
    constructor Create();
    destructor Destroy(); override;
  end;

  TORBInvokeRecord = class(TORBObject,IORBInvokeRecord)
  private
//    _FORB: IORB;
    FMessageID : MessageID;
    FTarget: IORBObject;
    FObject: IORBObject;
    FRequest : IORBRequest;
    FResponse_req : Boolean;
    FCallBack : IORBCallBack;
    FAdapter : IObjectAdaptor;
    FType : TRequestType;
    FStat: TInvokeStatus;
    FLocateStatus: TLocateStatus;
    FHaveResult : Boolean;
    FActive: Boolean;
    FTag : IObjectTag;
    FAddress : IAddress;
    FReqHint,
    FInvHint: Pointer;
    FPrincipal: IPrincipal;
    FAd: AddressingDisposition;
    FLocationForwardPerm: Boolean;
    FRepoId: RepositoryId;
    FIceptReq: IServerRequestInfo;
  protected
    { IORBInvokeRecord }
    procedure init_invoke(const orb: IORB; const obj: IORBObject; const pr: IPrincipal; const req: IORBRequest; resp: Boolean; const cb: IORBCallBack; const oa: IObjectAdaptor = nil);
    procedure init_bind(const orb: IORB; const repoid: RepositoryId; const tag: IObjectTag; const addr: IAddress; const cb: IORBCallBack; const oa: IObjectAdaptor);
    procedure init_locate(const orb: IORB; const obj: IORBObject; const cb: IORBCallBack; const oa: IObjectAdaptor);
    procedure set_oa(const oa: IObjectAdaptor);
    function id: MessageID;
    function completed(): Boolean;
    function get_answer_invoke(out state: TInvokeStatus; out obj: IORBObject; out req: IORBRequest; out ad: AddressingDisposition): Boolean;
    function get_answer_locate(out state: TLocateStatus; out obj: IORBObject; out ad: AddressingDisposition): Boolean;
    function get_answer_bind(out state: TLocateStatus;out obj: IORBObject): Boolean;
    procedure set_answer_invoke(const state: TInvokeStatus; const obj: IORBObject; const req: IORBRequest; const ad: AddressingDisposition);
    procedure set_answer_bind(const state: TLocateStatus;const obj: IORBObject);
    procedure set_answer_locate(const state: TLocateStatus; const obj: IORBObject; ad: AddressingDisposition);
    procedure _oa(oa: IObjectAdaptor);
    function request_type: TRequestType;
    procedure clean();
    function callback(): IORBCallBack;
    function get_oa(): IObjectAdaptor;
    function active(): boolean;
    procedure deactivate();
    procedure set_request_hint(hint: Pointer);
    procedure set_invoke_hint(hint: Pointer);
    function get_request_hint(): Pointer;
    function get_invoke_hint(): Pointer;
    function get_principal(): IPrincipal;
    procedure redo();
    function responce(): boolean;
    procedure set_locationforward_perm(perm: boolean);
    function get_locationforward_perm(): boolean;
    function request_info: IInterface;
  public
    constructor Create(msgId: MessageID);
  end;

{$ENDIF}

  TObjectTag = class(TInterfacedObject,IObjectTag)
  private
    FName: AnsiString;
  protected
    function get_length: _ulong;
    function get_bytes: AnsiString;
    function equals(const val: AnsiString): Boolean;
  public
    constructor Create(Name: AnsiString);
  end;

{$IFDEF HAVE_THREADS}
  TORBAsyncCallback = class(TInterfacedObject, IORBCallBack, IORBasyncCallback)
  private
    FNotified: boolean;
    FCond: TCondVar;
    FCondMutex: TRecursiveMutex;
  protected
    function waitfor(const orb: IORB; mid: ORBMessageID; event: TORBCallbackEvent; tmout: Longint = -1): boolean;
    procedure notify(const orb: IORB; mid: ORBMessageID; event: TORBCallbackEvent);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TResourceManager = class(TInterfacedObject, IResourceManager)
  private
    FConnectionLimit,
    FRequestLimit,
    FConnectionCount: _ulong;
    FMutex: TMutex;
  protected
    { IResourceManager }
    procedure release_connection();
    function acquire_connection(): boolean;
    procedure connection_limit(value: integer); overload;
    procedure request_limit(value: integer); overload;
    function connection_limit: _ulong; overload;
    function request_limit: _ulong; overload;
  public
    constructor Create(ConnectionLimit: _ulong = 10; RequestLimit: _ulong = 10; ConnectionCount: _ulong = 0);
    destructor Destroy; override;
  end;
{$ENDIF}

  TPrincipalCurrent = class
  public
    class function _narrow(const obj : IORBObject): IPrincipalCurrent;
  end;

  TPrincipalCurrent_impl = class(TORBObject, IPrincipalCurrent)
  protected
    function narrow_helper(const repoid: RepositoryId): Pointer;  override;
    function get_principal(): IPrincipal;
  end;

{$IFDEF USELIB}
  function ORB_Init(props: TStrings): IOrb; external MTDORB_Library_Name;
  function ORB_Instance: IORB; external MTDORB_Library_Name;
{$ELSE}
  function ORB_Init(props: TStrings): IOrb;
  function ORB_Instance: IORB;
{$ENDIF}

implementation

uses
  static,ior,iop,address,disp,proxy,iiop,boa,imr,internalexceptions,
  mcomp_int,orbcomp,codeset,exceptions,except_int,map,pi_impl,pi,ssl_int,
  poa_int, poa,throw,imr_impl,poa_impl,env,intercept,mtmanager,mtmanager_int,
  tcode,policy,policy_int,req,ir,any,ssl,osnet,bootmanager,mtdebug,mtdebug_int,
  osprocess, value;

{$IFNDEF USELIB}
var
  ORBInstance : IORB;
threadvar
  currentMsgId: MessageID;
{$ENDIF}

{$IFNDEF USELIB}
function ORB_Instance: IORB;
begin
  result := ORBInstance;
end;

{**
  ORB initialization routine.
  Initializes sockets and creates instance of ORB.
}
function ORB_Init(props: TStrings): IOrb;
var
  i : integer;
  bindaddr,iiopaddr,initRefs: TStringList;
  pvalue,naming_addr,naming_ior: AnsiString;
  tag: IObjectTag;
  naming, iro, imr: IORBObject;
  iiopserv: Boolean;
  server: IIIOPServer;
  addr, fwproxyaddr: IAddress;
  retval: boolean;
  properties: IProperties;
  giopver,
  iiopver: _ushort;
  giopver_str: AnsiString;
  iiopver_str: AnsiString;
  max_message_size_str: string;
  max_message_size: long;
  imrIOR: AnsiString;
  imrAddr: AnsiString;
  connLimit: integer;
  requestLimit: integer;
  infoLogger: string;
  errorLogger: string;
  debugLevel: mtdebug_int.TMessageTypes;
  info: IORBInitInfo;
begin
  TOSNet.sockinit();
  iiopserv := true;
  naming_addr := '';
  naming_ior := '';
  giopver_str := '1.2';
  iiopver_str := '1.2';
  // Connection checking is disabled by default
  // for default thread-pool concurrency model
  // Other concurrency model have default connection limit
  // set to 10.
  ConnLimit := 0;
  if ORBInstance = nil then
    begin
      Codeset.CodesetInit;
{$IFDEF HAVE_SSL}
      Ssl.SslInit(props);
{$ENDIF}
      TProcess.Init();
      TPIManager.Init();
      iiopaddr := nil;
      initRefs := nil;
      bindaddr := TStringList.Create;
      try
        iiopaddr := TStringList.Create;
        initRefs := TStringList.Create;

        //setup logger
        debugLevel := [];
        i := 0;
        if (props <> nil) then
          while  i < props.count do begin

            pvalue := AnsiString(Uppercase(props[i]));
            if pvalue = '-ORBINFOLOGGER' then begin
              Inc(i);
              infoLogger := props[i];
            end
            else if pvalue = '-ORBERRORLOGGER' then begin
              Inc(i);
              errorLogger := props[i];
            end
            else if pvalue = '-ORBDEBUGLEVEL' then begin
              Inc(i);
              if UpperCase(props[i]) = 'INFO' then
                Include(debugLevel, mtInfo)
              else if UpperCase(props[i]) = 'ERROR' then
                Include(debugLevel, mtError)
              else if UpperCase(props[i]) = 'WARNING' then
                Include(debugLevel, mtWarning)
              else if UpperCase(props[i]) = 'TRACE' then
                Include(debugLevel, mtTrace);
            end;
            Inc(i);
          end; { while }
        CreateLogger(debugLevel, infoLogger, errorLogger);
        MTDORBLogger.Info('Info logger is created');
        MTDORBLogger.Error('Error logger is created');
        properties := TProperties.Create(props);
        ORBInstance := TORB.Create;
        ORBInstance.set_Properties(properties);
        retval := TInitInterceptor._exec_initialize(ORBInstance, 'dorb-local-orb', props);
        if not retval then
          dorb_throw(st_INITIALIZE);
        info := TORBInitInfoImpl.Create(ORBInstance, 'dorb-local-orb', props);
        for i := 0 to TPIManager.Initializers.Count - 1 do
          IORBInitializer(TPIManager.Initializers[i]).pre_init(info);
        //for i := 0 to TPIManager.Initializers.Count - 1 do
          //IORBInitializer(TPIManager.Initializers[i]).post_init(info);

        i := 0;
        if (props <> nil) then
          while i < props.count do
            begin
              pvalue := AnsiString(Uppercase(props[i]));
              if pvalue = '-ORBBINDADDR' then
                begin
                  inc(i);
                  bindaddr.Add(props[i]);
                end
              else if pvalue = '-ORBIIOPADDR' then
                begin
                  inc(i);
                  iiopaddr.Add(props[i]);
                end
              else if pvalue = '-ORBNOIIOPSERVER' then
                iiopserv := false
              else if pvalue = '-ORBNAMINGIOR' then
                begin
                  inc(i);
                  naming_ior := AnsiString(props[i]);
                end
              else if pvalue = '-ORBNAMINGADDR' then
                begin
                  inc(i);
                  naming_addr := AnsiString(props[i]);
                end
              else if pvalue = '-ORBGIOPVERSION' then
                begin
                  inc(i);
                  giopver_str := AnsiString(props[i]);
                end
              else if pvalue = '-ORBIIOPVERSION' then
                begin
                  inc(i);
                  iiopver_str := AnsiString(props[i]);
                end
              else if pvalue = '-ORBINITREF' then
                begin
                  inc(i);
                  initRefs.Add(props[i]);
                end
              else if pvalue = '-ORBGIOPMAXSIZE' then
                begin
                  inc(i);
                  max_message_size_str := props[i];
                end
              else if pvalue = '-POAIMPLNAME' then
                begin
                  inc(i);
                  poa_impl_name := AnsiString(props[i]);
                end
              else if pvalue = '-ORBIMPLREPOIOR' then
                begin
                  inc(i);
                  imrIOR := AnsiString(props[i]);
                end
              else if pvalue = '-ORBIMPLREPOADDR' then
                begin
                  inc(i);
                  imrAddr := AnsiString(props[i]);
                end
              else if pvalue = '-ORBIIOPPROXY' then
                begin
                  inc(i);
                  fwproxyaddr := TInetAddress.parse(AnsiString(props[i]));
                end;
              inc(i);
            end;

        if (Length(giopver_str) <> 3) or
           (giopver_str[1] <> '1') or
           (giopver_str[2] <> '.') or
           (giopver_str[3] < '0') or
           (giopver_str[3] > '2') then
          dorb_throw(st_INITIALIZE);
        giopver := ((Ord(giopver_str[1]) - Ord('0')) shl 8) or (Ord(giopver_str[3]) - Ord('0'));
        if (Length(iiopver_str) <> 3) or
           (iiopver_str[1] <> '1') or
           (iiopver_str[2] <> '.') or
           (iiopver_str[3] < '0') or
           (iiopver_str[3] > '2') then
          dorb_throw(st_INITIALIZE);
        iiopver := ((Ord(iiopver_str[1]) - Ord('0')) shl 8) or (Ord(iiopver_str[3]) - Ord('0'));

        // create IIOP client
        max_message_size := 0;
        if max_message_size_str <> '' then begin
          if not TryStrToInt(max_message_size_str, max_message_size) then
            dorb_throw(st_INITIALIZE);
        end;

{$IFDEF HAVE_THREADS}
        TryStrToInt(ORBInstance.get_properties.get_property('mtdorb.orb.connections_limit'), connLimit);
        TryStrToInt(ORBInstance.get_properties.get_property('mtdorb.orb.requests_limit'), requestLimit);
        if requestLimit = 0 then
          requestLimit := 4; // The most common servers have up to four CPUs
        ORBInstance.resource_manager().connection_limit(connLimit);
        ORBInstance.resource_manager().request_limit(requestLimit);
        pvalue := AnsiString(ORBInstance.get_properties.get_property('mtdorb.orb.conc_model'));
        if (pvalue = '') or (pvalue = 'thread_pool') then begin
          TMTManager.ConcurrencyModel(cmThreadPool);
          //ORBInstance.dispatcher.block(false);
        end
        else begin
          ORBInstance.dispatcher.block(true);
          if pvalue = 'thread_per_connection' then
            TMTManager.ConcurrencyModel(cmThreadPerConnection)
          else if pvalue = 'thread_per_request' then
            TMTManager.ConcurrencyModel(cmThreadPerRequest)
          else
            dorb_throw(st_INITIALIZE);
        end;
        TMTManager.ThreadSetup(connLimit, requestLimit);
{$ENDIF}

        // create IIOP client
        ORBInstance.dispatcher.block(false);
        TIIOPProxy.Create(ORBInstance, giopver, max_message_size);

        // create IIOP server
        ORBInstance.bindaddrs(bindaddr);
        if iiopserv then begin
          server := TIIOPServer.Create(ORB_Instance, iiopver, max_message_size);
          if iiopaddr.Count = 0 then
            server.listen()
          else
            for i := 0 to Pred(iiopaddr.count) do begin
              addr := TInetAddress.parse(AnsiString(iiopaddr[i]));
              if addr = nil then
                dorb_throw(st_BAD_PARAM, MinorBadAddress, COMPLETED_NO);
              if not server.listen_addr(addr, fwproxyaddr) then
                dorb_throw(st_INITIALIZE);
            end;
        end;

        // connect to / create implementation repository
        if imrIOR <> '' then
          imr := orb_instance.string_to_object(AnsiString(imrIOR))
        else if imrAddr <> '' then begin
          imr := orb_instance.bind('IDL:mg.org/CORBA/ImplRepository:1.0', imrAddr);
          { TODO -oOVS -cLogger : Warning }
        end;
        if imr <> nil then
          orb_instance.register_initial_reference('ImplementationRepository', imr);

        // connect to naming service
        if naming_addr <> '' then begin
          tag := ORB_Instance.string_to_tag('NameService');
          naming := orb_instance.bind('IDL:omg.org/CosNaming/NamingContext:1.0',tag,naming_addr);
          if naming <> nil then
            orb_instance.register_initial_reference('NameService',naming);
        end
        else if naming_ior <> '' then begin
          tag := ORB_Instance.string_to_tag('NameService');
          naming := orb_instance.string_to_object(naming_ior);
          if naming <> nil then
            orb_instance.register_initial_reference('NameService',naming);
        end;
        // Resolve -ORBInitRefs (must do that after connecting to NameService)
        for i := 0 to initRefs.Count - 1 do begin
          if Pos('=', initRefs.Strings[i]) = 0 then
            dorb_throw(st_INITIALIZE);
          iro := ORB_Instance.string_to_object(AnsiString(initRefs.Values[initRefs.Names[i]]));
          if iro <> nil then
            ORB_Instance.register_initial_reference(AnsiString(initRefs.Names[i]), iro);
        end;
        //set BootManager
        orb_instance.register_initial_reference('BootManager', TBootManager.Create as IORBObject);

        for i := 0 to TPIManager.Initializers.Count - 1 do
          IORBInitializer(TPIManager.Initializers[i]).post_init(info);
      finally
        FreeAndNil(bindaddr);
        FreeAndNil(iiopaddr);
        FreeAndNil(initRefs);
      end;
    end;
  ORBInstance.register_value_factory('IDL:omg.org/CORBA/StringValue:1.0', TStringValueFactory.Create());
  ORBInstance.register_value_factory('IDL:omg.org/CORBA/WStringValue:1.0', TWStringValueFactory.Create());
  result := ORBInstance;
end;
{$ENDIF}

//***************************************************************
//  TORBObject
//***************************************************************
constructor TORBObject.Create();
begin
  FORB := ORB_Instance;
end;

constructor TORBObject.Create(ior : IIOR);
begin
  FIOR := ior;
  FORB := ORB_Instance;
  FFWD_IOR := nil;
end;

constructor TORBObject.Create(obj: IORBObject);
begin
  FIOR := obj._ior;
  FFWD_IOR := obj.fwd_ior;
  FORB := obj._orb;
  FManagers := obj._managers;
  FPolicies := obj._policies;
end;

destructor TORBObject.Destroy;
begin
  FIOR := nil;
  FORB := nil;
  FFWD_IOR := nil;
  inherited;
end;

{**  Returns Interoperable Object Reference }
function TORBObject._IOR(): IIOR;
begin
  result := FIOR;
end;

function TORBObject.fwd_ior(): IIOR;
begin
  if assigned(FFWD_IOR) then
    result := FFWD_IOR
  else
    result := FIOR;
end;

function TORBObject._request(const operation: AnsiString): IRequest;
begin
  result := CreateRequest(self,operation);
end;

function TORBObject._repoid(): RepositoryID;
begin
  result := FIOR.objid;
end;

function TORBObject._is_a(const repoid: RepositoryId): Boolean;
begin
  result := true;
  if strcomp(PAnsiChar(repoid), 'IDL:omg.org/CORBA/Object:1.0') = 0 then
    Exit;
  if (_ior() <> nil) and (strcomp(PAnsiChar(repoid), PAnsiChar(self._repoid)) = 0) then
    Exit;
  // try IDL compiler generated narrowing support
  if narrow_helper(repoid) <> nil then
    Exit;
  result := _is_a_remote(repoid);
end;

function TORBObject.non_existent: Boolean;
begin
  result := FORB._non_existent(self);
end;

function TORBObject._is_a_remote(const repoid: RepositoryId): Boolean;
begin
  if FORB.is_impl(self) then
    result := false
  else begin
    if _ior() = nil then
      result := false
    else
      result := FORB.is_a(Self, repoid);
  end;
end;

{**  Returns current ORB instance }
function TORBObject._ORB(): IORB;
begin
  result := FORB;
end;

function TORBObject.is_forwarded(): Boolean;
begin
  result := FFWD_IOR <> nil;
end;

procedure TORBObject._unforward();
begin
  FFWD_IOR := nil;
end;

procedure TORBObject._forward(const obj :IORBObject);
begin
  FFWD_IOR := CreateIOR_ior(obj._IOR);
end;

{**  Gets common properties from specified object}
procedure TORBObject.assign(const obj: IORBObject);
begin
  FIOR := CreateIOR_ior(obj._IOR);
  FORB := obj._ORB;
  FORB := obj._orb;
  FManagers := obj._managers;
  FPolicies := obj._policies;
end;

function TORBObject.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
end;

procedure TORBObject.create_request(const ctx: IContext;
  const operation: Identifier; const arg_list: INVList; const res: TNamedValue;
  out request: IRequest; const flags: _ulong);
begin
  request := CreateRequest_arg(Self, ctx, operation, arg_list, res, flags);
end;

function TORBObject.duplicate: IORBObject;
begin
  assert(false,'not imlplemented');
end;

function TORBObject.get_domain_managers: DomainManagersList;
begin
  result := Copy(FManagers);
end;

procedure TORBObject.setup_domains(const parent: IORBObject);
var
  def_manager: IDomainManager;
  p: IPolicy;
  cp: IConstructionPolicy;
  dml: DomainManagersList;
  i: Integer;
begin
  if parent = nil then begin
    dml := nil;
    FORB.get_default_domain_manager(def_manager);

    SetLength(FManagers, 1);

    p := def_manager.get_policy(SecConstruction);
    Assert(p <> nil);

    cp := TConstructionPolicy._narrow(p);

    if cp.constr_policy(Self) then
      FManagers[0] := def_manager.copy()
    else
      FManagers[0] := def_manager;
  end
  else begin
    dml := parent.get_domain_managers();
    SetLength(FManagers, Length(dml));

    for i := 0 to Length(dml) - 1 do begin
      p := dml[i].get_policy(SecConstruction);
      Assert(p <> nil);

      cp := TConstructionPolicy._narrow(p);

      if cp.constr_policy(Self) then
        FManagers[i] := dml[i]
      else
        FManagers[i] := dml[i].copy();
    end;
  end;
end;

function TORBObject.get_client_policy(
  const policy_type: PolicyType): IPolicy;
begin
  { TODO -oOVS -cPolicy : Implement }
  result := get_policy(policy_type);
end;

function TORBObject.get_policy_overrides(
  const types: PolicyTypeSeq): PolicyList;
var
  i, j, policiesLength: Integer;
begin
  for i := 0 to Length(types) - 1 do
    for j := 0 to Length(FPolicies) - 1 do
      if FPolicies[j].policy_type = types[i] then begin
        policiesLength := Length(result);
        SetLength(result, policiesLength + 1);
        result[policiesLength] := FPolicies[j];
      end;
end;

function TORBObject.get_interface: IInterfaceDef;
begin
  result := FORB._get_interface(self)
end;

function TORBObject.get_policy(const policy_type: PolicyType): IPolicy;
var
  i: Integer;
begin
  // look at this objects's policies
  for i := 0 to Length(FPolicies) - 1 do
    if (FPolicies[i].policy_type = policy_type) then begin
      result := FPolicies[i];
      Exit;
    end;
  // look at domain manager policies
  for i := 0 to Length(FManagers) - 1 do begin
    result := FManagers[i].get_policy(policy_type);
    if result <> nil then
      Exit;
  end;
  raise SystemException.Create_type(st_INV_POLICY);
end;

function TORBObject._managers: DomainManagersList;
begin
  result := FManagers;
end;

function TORBObject._policies: PolicyList;
begin
  result := FPolicies;
end;

function TORBObject.hash(max: _ulong): _ulong;
begin
  result := utils.string_hash(FIOR.stringify,max)
end;

function TORBObject.is_equivalent(obj: IORBObject): Boolean;
begin
  result := true;
  if obj = (self as IORBObject) then exit;
  result := false; // must be rewritten
end;

procedure TORBObject.release;
begin
  assert(false,'not imlplemented');
end;

function TORBObject.set_policy_overrides(const policies: PolicyList;
  const set_add: SetOverrideType): IORBObject;
var
  obj: TORBObject;
  i, j: Integer;
begin
  obj := TORBObject.Create(Self);
  case set_add of
    SET_OVERRIDE: obj.FPolicies := policies;
    ADD_OVERRIDE: begin
      for i := 0 to Length(policies) - 1 do begin
        j := 0;
        while j < Length(obj.FPolicies) do begin
          if (obj.FPolicies[j].policy_type = policies[i].policy_type) then begin
            obj.FPolicies[j] := policies[i];
            Break;
          end
          else
            Inc(j);
        end;
        if j = Length(obj.FPolicies) then begin
          SetLength(obj.FPolicies, j + 1);
          obj.FPolicies[j] := policies[i];
        end;
      end;
    end;
  else
    Assert(false);
  end;
  result := obj as IORBObject;
end;

//***********************************************************************
//  TLocalORBObject
//***********************************************************************
function TLocalORBObject._is_a(const repoid: RepositoryId): Boolean;
begin
  dorb_throw(st_NO_IMPLEMENT, MinorNotSupportedByLocalObject);
  result := false;
end;

procedure TLocalORBObject.create_request(const ctx: IContext;
  const operation: Identifier; const arg_list: INVList; const res: TNamedValue;
  out request: IRequest; const flags: _ulong);
begin
  dorb_throw(st_NO_IMPLEMENT, MinorDIINotSupportedByLocalObject);
end;

function TLocalORBObject.duplicate: IORBObject;
begin

end;

function TLocalORBObject.get_domain_managers: DomainManagersList;
begin
  dorb_throw(st_NO_IMPLEMENT, MinorNotSupportedByLocalObject);
end;

procedure TLocalORBObject.setup_domains(const parent: IORBObject);
begin
  dorb_throw(st_NO_IMPLEMENT, MinorNotSupportedByLocalObject);
end;

function TLocalORBObject.get_interface: IInterfaceDef;
begin
  dorb_throw(st_NO_IMPLEMENT, MinorNotSupportedByLocalObject);
end;

function TLocalORBObject.get_policy(
  const policy_type: PolicyType): IPolicy;
begin
  dorb_throw(st_NO_IMPLEMENT, MinorNotSupportedByLocalObject);
end;

function TLocalORBObject.get_client_policy(
  const policy_type: PolicyType): IPolicy;
begin
  dorb_throw(st_NO_IMPLEMENT, MinorNotSupportedByLocalObject);
end;

function TLocalORBObject.get_policy_overrides(
  const types: PolicyTypeSeq): PolicyList;
begin
  dorb_throw(st_NO_IMPLEMENT, MinorNotSupportedByLocalObject);
end;

function TLocalORBObject.hash(max: _ulong): _ulong;
begin
  result := utils.string_hash(FIOR.stringify,max)
end;

function TLocalORBObject.is_equivalent(obj: IORBObject): Boolean;
begin
  result := (obj <> nil) and (obj = Self as IORBObject);
end;

function TLocalORBObject.non_existent: Boolean;
begin
  result := false;
end;

procedure TLocalORBObject.release;
begin

end;

function TLocalORBObject.set_policy_overrides(const policies: PolicyList;
  const set_add: SetOverrideType): IORBObject;
begin
  dorb_throw(st_NO_IMPLEMENT, MinorNotSupportedByLocalObject);
end;

procedure TLocalORBObject._forward(const obj: IORBObject);
begin
  FFWD_IOR := CreateIOR_ior(obj._IOR);
end;

function TLocalORBObject._is_a_remote(const repoid: RepositoryId): Boolean;
begin
  if FORB.is_impl(self) then
    result := false
  else begin
    if _ior() = nil then
      result := false
    else
      { TODO -oOVS -cORB : is_a }
      result := true;
  end;
end;

function TLocalORBObject._request(const operation: Identifier): IRequest;
begin
  result := CreateRequest(self,operation);
end;

procedure TLocalORBObject._unforward;
begin
  FFWD_IOR := nil;
end;

procedure TLocalORBObject.assign(const obj: IORBObject);
begin
  FIOR := CreateIOR_ior(obj._IOR);
  FORB := obj._ORB;
end;

function TLocalORBObject.fwd_ior: IIOR;
begin
  if assigned(FFWD_IOR) then
    result := FFWD_IOR
  else
    result := FIOR;
end;

function TLocalORBObject._ior: IIOR;
begin
  result := FIOR;
end;

function TLocalORBObject.is_forwarded: Boolean;
begin
  result := FFWD_IOR <> nil;
end;

function TLocalORBObject.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/LocalObject:1.0' then
    result := Self
  else
    result := nil;
end;

function TLocalORBObject._orb: IORB;
begin
  result := FORB;
end;

function TLocalORBObject._repoid: RepositoryID;
begin
  result := FIOR.objid;
end;

constructor TLocalORBObject.Create;
begin
  FORB := ORB_Instance;
end;

constructor TLocalORBObject.Create(ior: IIOR);
begin
  FORB := ORB_Instance;
  FIOR := ior;
end;

function TLocalORBObject._managers: DomainManagersList;
begin

end;

function TLocalORBObject._policies: PolicyList;
begin

end;

//***********************************************************************
//  TMixedBase
//***********************************************************************
function TMixedBase._to_object: IORBObject;
begin
  result := nil;
end;

function TMixedBase._to_value: IValueBase;
begin
  result := nil;
end;

//***********************************************************************
//  TStub
//***********************************************************************
function TStub._object: IORBObject;
begin
  result := FObject
end;

function TStub.narrow_helper(const str: RepositoryId): Pointer;
begin
  result := nil;
  if assigned(FObject) then
    result := FObject.narrow_helper(str);
end;

constructor TStub.Create(const obj: IORBObject);
begin
  inherited Create();
  FObject := obj;
end;

{$IFNDEF USELIB}
//*************************************************************
//  TOrb
//**************************************************************
constructor TOrb.Create();
begin
  FORB := nil;
  FAdapters := TStringList.Create();
  FInitRefs := TStringList.Create();
{$IFDEF USE_ORB_CACHE}
  FCacheUsed := false;
  FCacheRecord := TORBInvokeRecord.Create();
{$ENDIF}
  FInvokes := TLongInterfaceMap.Create;
  FDispatcher := TSelectDispatcher.CreateEx;
  FBindAddress := TStringList.Create;
  FValueFactories := TStringList.Create;
  FIORTempl := TIOR.Create;
  //FRunning := False;
  //FStopped := False;
  FShutdown := false;
  FWaitForCompletion := false;
  FAdaptersLock := TRWLock.Create();
  FInvokesLock := TRWLock.Create();
  FValueFactoriesLock := TRWLock.Create();
  FTheIDLock := TMutex.Create();
  FInitRefsLock := TRecursiveMutex.Create();
  FShutdownComplete := TThreadMonitor.Create;
{$IFDEF HAVE_THREADS}
  FResourceManager := TResourceManager.Create;
{$ENDIF}
  FState := osNotRunning;
end;

destructor TOrb.Destroy();
begin
  FreeAndNil(FAdapters);
  FreeAndNil(FValueFactories);
  FreeAndNil(FInitRefs);
  {$IFDEF USE_RWLOCK}FInvokesLock.wrlock();{$ENDIF}
  try
    FInvokes := nil;
  finally
    {$IFDEF USE_RWLOCK}FInvokesLock.wrunlock();{$ENDIF}
  end; { try/finally }
  FreeAndNil(FBindAddress);
  FreeAndNil(FInitRefsLock);
  FreeAndNil(FTheIDLock);
{$IFDEF USE_RWLOCK}
  FreeAndNil(FValueFactoriesLock);
  FreeAndNil(FInvokesLock);
  FreeAndNil(FAdaptersLock);
{$ENDIF}
  FreeAndNil(FShutdownComplete);
  inherited Destroy();
end;

procedure TOrb.cancel(id: ORBMessageID);
var
  rec : IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  if rec <> nil then
    begin
      rec.deactivate();
      if rec.get_oa <> nil then
        rec.get_oa.cancel(rec);
{$IFNDEF HAVE_THREADS}
      del_invoke(rec.id());
{$ENDIF}      
    end;
end;

function TOrb.get_invoke_hint(id: ORBMessageId): Pointer;
var
  rec: IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  Assert(rec <> nil);
  //rec._AddRef;
  result := rec.get_invoke_hint;
end;

function TOrb.get_msgid(rec: ORBMessageId): MessageID;
begin
  if rec <> nil then
    result := rec.id()
  else
    result := 0;
end;

function TOrb.get_orbid(msgid: MessageId): ORBMessageID;
begin
  result := get_invoke(msgid);
end;

function TOrb.get_request_hint(id: ORBMessageId): Pointer;
var
  rec: IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  Assert(rec <> nil);
  result := rec.get_request_hint();
end;

function TOrb.new_orbid(msgid: MessageId): ORBMessageId;
begin
  if msgid = 0 then msgid := new_MessageID;
  result := create_invoke(msgid);
end;

procedure TOrb.set_invoke_hint(id: ORBMessageId; hint: Pointer);
var
  rec: IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  Assert(rec <> nil);
  rec.set_invoke_hint(hint);
end;

procedure TOrb.set_request_hint(id: ORBMessageId; hint: Pointer);
var
  rec: IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  Assert(rec <> nil);
  rec.set_request_hint(hint);
end;

procedure TORB.do_shutdown();
var
  i : integer;
  OAList : IInterfaceList;
  oa: IObjectAdaptor;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FShutdownComplete);
  // If the FShutdown is false, or the server side has already
  // shutdown then do nothing
  if not FShutdown or (FState = osServerShutdown) then
    Exit;
  Assert((FState <> osClientShutdown) and (FState <> osDestroyed));
  // If run was called then only the main thread may complete the
  // shutdown
  Assert((FState = osNotRunning) or (FMainThread = TORBThread.CurrentThread()));

  // Shutdown Root POA before shutdown other adaptors
  if Assigned(the_root_poa()) then
    the_root_poa.shutdown(true);

  FShuttingDownAdapters := TInterfaceList.Create;
  OAList := TInterfaceList.Create;
  {$IFDEF USE_RWLOCK}FAdaptersLock.rdlock();{$ENDIF}
  try
    for i := Pred(FAdapters.count) downto 0 do
      begin
        oa := IObjectAdaptor(Pointer(FAdapters.Objects[i]));
        FShuttingDownAdapters.Add(oa);
        OAList.Add(oa);
        FAdapters.Delete(i);
        oa._Release;
        oa := nil;
      end;
  finally
    {$IFDEF USE_RWLOCK}FAdaptersLock.rdunlock();{$ENDIF}
  end; { try/finally }
  for i := 0 to Pred(OAList.count) do begin
      IObjectAdaptor(OAList.Items[i]).shutdown(FWaitForCompletion);
  end;
  if FWaitForCompletion then
    while FShuttingDownAdapters.Count > 0 do
      FDispatcher.run(false);
  OAList := nil;
  FShuttingDownAdapters := nil;
  // terminate ORB threads
  TMTManager.ThreadShutdown();

  // Mark the server side state as shutdown and notify any waiting
  // threads
  FState := osServerShutdown;

  FShutdownComplete.notifyAll();
end;

procedure TORB.cancel(mid: MessageID);
var
  rec : IORBInvokeRecord;
begin
  rec := get_invoke(mid);
  if rec <> nil then
    begin
      rec.deactivate();
      if rec.get_oa <> nil then
        rec.get_oa.cancel(rec);
{$IFDEF HAVE_THREADS}
      del_invoke(rec.id());
{$ENDIF}
      currentMsgId := 0;
    end;
end;

function TOrb.invoke(var obj: IORBObject; const req: IORBRequest;
  const pr: IPrincipal; resp: Boolean): TInvokeStatus;
var
  id: ORBMessageId;
  res: Boolean;
  adummy: AddressingDisposition;
  dummy: IORBRequest;
begin
  id := invoke_async(obj, req, pr, resp);
  if not resp then begin
    result := InvokeOk;
    Exit;
  end;
  Assert(id <> nil);
  res := wait(id);
  Assert(res);
  result := get_invoke_reply(id, obj, dummy, adummy);
end;

function TOrb.locate(var obj: IORBObject): TLocateStatus;
var
  id: ORBMessageId;
  res: Boolean;
  adummy: AddressingDisposition;
begin
  id := locate_async(obj);
  res := wait(id);
  Assert(res);
  result := get_locate_reply(id, obj, adummy);
end;

function TORB._non_existent(obj: IORBObject): Boolean;
var
  req : IRequest;
begin
  result := true;
  req := obj._request('_non_existent');
  req.get_result.argument.set_type(_tc_boolean);
  try
    req.invoke;
  except
  end;
  if req.get_environment.get_exception <> nil then exit;
  assert(req.get_result.argument.to_boolean(result));
end;

procedure TORB.answer_shutdown(const oa: IObjectAdaptor);
var
  i : integer;
begin
  if FShuttingDownAdapters = nil then
    Exit;
  for i := 0 to Pred(FShuttingDownAdapters.count) do
    if IObjectAdaptor(FShuttingDownAdapters[i]) = oa then
      begin
        FShuttingDownAdapters.Delete(i);
        break;
      end;
end;

procedure TORB.shutdown(wait_for_completion: Boolean);
var
  obj: IORBObject;
  pc: IPOACurrent;
  inInvocation: boolean;
begin
  if FDestroy then
    raise OBJECT_NOT_EXIST.Create();

  // If wait_for_completion is true then find out whether we're inside
  // a method invocation -- if so throw a BAD_INV_ORDER exception
  if wait_for_completion then begin
    inInvocation := false;
    try
      obj := resolve_initial_reference('POACurrent');
      pc := TPOACurrent._narrow(obj);
      inInvocation := (pc <> nil) and {pc.inupcall()}pc.iscurrent();
    except
    end; { try/except }
    pc := nil;
    obj := nil;
    if inInvocation then
      raise BAD_INV_ORDER.Create(MinorDestroyWouldBlock);
  end;
  FWaitForCompletion := wait_for_completion;
  FShutdown := true;
  FDispatcher.interrupt_dispatch();

  // waitForCompletion false? We're done.
  if not FWaitForCompletion then
    Exit;
  // If run was called and this is not the main thread and
  // waitForCompletion is true then wait for the shutdown to
  // complete.
  if (FState = osRunning) and (FMainThread <> TORBThread.CurrentThread()) then begin
    blockServerShutdownComplete();
    Exit;
  end;

  // This is the main thread -- complete the shutdown process
  do_shutdown();
end;

function TORB.builtin_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest):Boolean;
var
  res: IAny;
  nv: INVList;
  ex: IORBException;
begin
  result := false;
  (*
   * _non_existent is the only special one, _implementation, _interface,
   * and _is_a are just passed through to the OA.
   *)
  if req.op_name() = '_non_existent' then begin
    if get_oa(obj) = nil then begin
      res := CreateAny();
      res.put_boolean(true);
      nv := TNVList.Create();
      if not req.set_out_args(res, nv) then begin
        ex := SystemException.Create_type(st_MARSHAL);
        req.set_out_args(ex);
        answer_invoke(mid, InvokeSysEx, nil, req, 0);
      end
      else
        answer_invoke(mid, InvokeOk, nil, req, 0);
      result := true;
    end;
  end;
end;

function TORB.is_local(const obj: IORBObject): Boolean;
var
  p1,p2 : IIORProfile;
  i, j: integer;
begin
  result := true;
  if obj._ior = nil then
    exit;

  p1 := obj._ior.profile(0);
  p2 := FIORTempl.profile(0);
  (*
   * If the object does not have any profiles, it must be local
   *)
  if p1 = nil then
    Exit;
  (*
   * If we don't have any profiles for this process, any other object
   * must be remote.
   *)
  if p2 = nil then begin
    result := false;
    Exit;
  end;

  (*
   * If p1 is a GIOPSimpleProf, then the object reference is incoming
   * from a IIOPServer. Well, if it's delivered here, then it better be
   * local.
   *)
  if p1.id = 10000 then
    Exit;

  i := 0;
  while (p1 <> nil) do begin
    if not p1.reachable then begin
      i := Succ(i);
      p1 := obj._ior.profile(i);
      Continue;
    end;
    j := 0;
    while p2 <> nil do begin
      if not p2.reachable then begin
        j := Succ(j);
        p2 := FIORTempl.profile(j);
        Continue;
      end;
      if p1.address.compare(p2.address) then
        exit;
      j := Succ(j);
      p2 := FIORTempl.profile(j);
    end; { while }
    i := Succ(i);
    p1 := obj._ior.profile(i);
    { TODO -oOVS : compare profile }
  end; { while }
  result := false;
end;

function TORB.is_impl(const obj: IORBObject): Boolean;
var
  oa : IObjectAdaptor;
begin
  result := false;
  if obj = nil then exit;
  oa := get_oa(obj);
  result := (oa <> nil) and oa.is_local and (oa.skeleton(obj) = obj);
end;

function TORB.BOA_Init(): IUnknown;
var
  i : integer;
begin
  {$IFDEF USE_RWLOCK}FAdaptersLock.rdlock();{$ENDIF}
  try
    for i := 0 to Pred(FAdapters.Count) do
      begin
        if strcomp('dorb-local-boa',PAnsiChar(IObjectAdaptor(Pointer(FAdapters.Objects[i])).get_oaid))=0 then
          begin
            result := IObjectAdaptor(Pointer(FAdapters.Objects[i]));
            exit;
          end;
      end;
  finally
    {$IFDEF USE_RWLOCK}FAdaptersLock.rdunlock();{$ENDIF}
  end; { try/finally }
  result := TBOAImpl.Create(self);
end;

function TORB.ior_template: IIOR;
begin
  result := FIORTempl;
end;

procedure TORB.register_initial_reference(const id: ObjectId; const obj: IORBObject);
var
  i : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FInitRefsLock);
  i := FInitRefs.IndexOf(String(id));
  if i >= 0 then
    begin
      IORBObject(Pointer(FInitRefs.Objects[i]))._Release;
      FInitRefs.Delete(i);
    end;
  if obj <> nil then
    begin
      obj._AddRef;
      FInitRefs.AddObject(String(id),TObject(obj));
    end;
end;

{**
  Adds bind addresses into address list
}
procedure TORB.bindaddrs(List : TStrings);
begin
  FBindAddress.AddStrings(List);
end;

function TORB.string_to_tag(const str: AnsiString): IObjectTag;
begin
  result := TObjectTag.Create(str);
end;

function TORB.get_bind_reply(id: ORBMessageID; out obj: IORBObject): TLocateStatus;
var
  rec : IORBInvokeRecord;
  state : TLocateStatus;
begin
  result := orbtypes.LocateUnknown;
  rec := _get_invoke(id);
  if rec = nil then exit;
  rec.get_answer_bind(state,obj);
  del_invoke(rec.id());
  result := state;
end;


function TORB.bind_async(const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress;
  const cb: IORBCallback; id : ORBMessageID): ORBMessageID;
var
  rec: IORBInvokeRecord;
  i : integer;
  cback: IORBCallback;
begin
  rec := _get_invoke(id);
  if rec = nil then
    rec := new_orbid();
  cback := cb;
{$IFDEF HAVE_THREADS}
  if cback = nil then
    cback := TORBAsyncCallback.Create();
{$ENDIF}
  rec.init_bind(self,repoid,oid,addr,cback,nil);
  add_invoke(rec);
  {$IFDEF USE_RWLOCK}FAdaptersLock.rdlock();{$ENDIF}
  try
    for i := 0 to Pred(FAdapters.Count) do
      begin
        rec._oa(IObjectAdaptor(Pointer(FAdapters.Objects[i])));
        if IObjectAdaptor(Pointer(FAdapters.Objects[i])).bind(rec,repoid,oid,addr) then
          begin
            result := rec;
            exit;
          end;
      end;
  finally
    {$IFDEF USE_RWLOCK}FAdaptersLock.rdunlock();{$ENDIF}
  end; { try/finally }
  answer_bind(rec,LocateUnknown,nil);
  result := rec;
end;


function TORB.bind_addr(const repoid: RepositoryId; const oid: IObjectTag;
  const addr: IAddress; out obj: IORBObject): TLocateStatus;
var
  id: ORBMessageID;
begin
  result := orbtypes.LocateHere;
  id := bind_async(repoid,oid,addr,nil,nil);
  if id = nil then
    begin
      result := orbtypes.LocateUnknown;
      exit;
    end;
  if wait(id) then
    result := get_bind_reply(id,obj);
end;

function TORB.bind(const repoid: RepositoryId; const addr: AnsiString): IORBObject;
begin
  result := bind(repoid,TObjectTag.Create('') as IObjectTag,addr);
end;

function TORB.bind(const repoid: RepositoryId; const oid: IObjectTag; const addr: AnsiString): IORBObject;
var
  addrs: TStrings;
  address: IAddress;
  i : integer;
  stat : TLocateStatus;
  obj : IORBObject;
begin
  result := nil;
  addrs := TStringList.Create;
  try
    if addr = '' then
      addrs.AddStrings(FBindAddress)
    else
      addrs.Add(String(addr));
    for i := 0 to pred(addrs.count) do
      begin
        address := TInetAddress.parse(AnsiString(addrs[i]));
        if address <> nil then
          begin
            stat := bind_addr(repoid,oid,address,obj);
            if stat = orbtypes.LocateHere then
              begin
                result := obj;
                exit;
              end;
          end;
      end;
  finally
    FreeAndNil(addrs);
  end;
end;

procedure TORB.answer_bind(id: ORBMessageID;stat: TLocateStatus;obj : IORBObject);
var
  rec : IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  if rec <> nil then
    begin
      rec.set_answer_bind(stat,obj);
      if assigned(rec.callback()) then
        rec.callback.notify(self, rec, _Bind);
    end;
end;

procedure TOrb.answer_locate(id: ORBMessageID; stat: TLocateStatus;
  obj: IORBObject; ad: AddressingDisposition);
var
  rec : IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  if rec <> nil then begin
    rec.set_answer_locate(stat, obj, ad);
      if assigned(rec.callback()) then
        rec.callback().notify(Self, rec, _Locate);
  end;
end;

{**
  Sets answer to record with specified message id
**}
procedure TORB.answer_invoke(id: ORBMessageID; stat: TInvokeStatus; obj: IORBObject; req: IORBRequest; ad: AddressingDisposition);
var
  rec : IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  if rec <> nil then
    begin
      rec.set_answer_invoke(stat, obj, req, ad);
      if rec.callback <> nil then
        rec.callback.notify(self, rec, _Invoke);
    end;
end;

{**
  Returns request type of invokation record with
  specified message id;
}
function TORB.request_type(id: ORBMessageID): TRequestType;
var
  rec : IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  if rec <> nil then
    result := rec.request_type
  else
    result := orbtypes.RequestUnknown;
end;

procedure TOrb.redo_request(id: ORBMessageID);
var
  rec: IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  if (rec <> nil) and rec.active() then
    rec.redo();
end;

{$IFDEF WIN32}
function ConsoleCtrlHandler(ctrlType: DWORD): BOOL; stdcall;
begin
  case ctrlType of
    CTRL_BREAK_EVENT,
    CTRL_C_EVENT,
    CTRL_CLOSE_EVENT: begin
      if ORBInstance <> nil then
        ORBInstance.shutdown(false{true});
      result := true;
    end;
    else result := false;
  end;
end;
{$ENDIF}
{$IFDEF LINUX}
  //Signal(SIGHUP, SIGINT, SIGTERM, SIGQUIT);
procedure ConsoleCtrlHandler(sig: integer); cdecl;
begin
  if ORBInstance <> nil then
    ORBInstance.shutdown(false);
end;
{$ENDIF}

procedure TORB.run();
begin
  validateState;
  if FMainThread <> TORBThread.CurrentThread() then begin
    // If this is not the main thread then block until the ORB is
    // shutdown
    blockServerShutdownComplete();
    Exit;
  end;
{$IFDEF WIN32}
  //SetConsoleCtrlHandler(@ConsoleCtrlHandler, true);
{$ENDIF}
{$IFDEF LINUX}
  //signal(SIGHUP, ConsoleCtrlHandler);
  //signal(SIGINT, ConsoleCtrlHandler);
{$ENDIF}
  repeat
    FDispatcher.run(false);
    // After this call state is either ShutdownClient, or Running
    do_shutdown();
  until FState <> osRunning;
end;

{**
  Waits for answer to request with specified message id
}
function TORB.wait(id: ORBMessageID; timeout : long): Boolean;
var
  rec : IORBInvokeRecord;
begin
  result := False;
  rec := _get_invoke(id);
  //FIXME: this is still not right - but OK for the moment
  //       we have to behave the old way, when the ORB thread calls us !!!
{$IFDEF HAVE_THREADS}
  if (rec <> nil) and rec.active then begin
    Assert(rec.callback() <> nil);
    result := rec.callback().waitfor(Self, id, _Result, timeout);
  end;
{$ELSE}
  if (rec = nil) or (rec.completed) then
    result := true
  else
    begin
      while not result do
        begin
          if (rec = nil) or (rec.completed) then
            begin
              result := true;
              break;
            end;
          FDispatcher.run(false);
          rec := get_invoke(id);
        end;
    end;
{$ENDIF}
end;

{**  Returns dispatcher}
function TORB.dispatcher(): ISelectDispatcher;
begin
  result := FDispatcher;
end;

{**  Removes invoke record from record list.}
procedure TORB.del_invoke(id: MessageID);
begin
{$IFDEF USE_ORB_CACHE}
  if FCacheRecord.id = id then begin
    FCacheUsed := false;
    FCacheRecord.clean;
  end;
{$ENDIF}
  {$IFDEF USE_RWLOCK}FInvokesLock.wrlock();{$ENDIF}
  try
    FInvokes.erase(id);
  finally
    {$IFDEF USE_RWLOCK}FInvokesLock.wrunlock();{$ENDIF}
  end; { try/finally }
end;

{**  Adds new invoke record}
procedure TORB.add_invoke(const inv: IORBInvokeRecord);
begin
{$IFDEF USE_ORB_CACHE}
  if inv <> FCacheRecord then
    FInvokes[inv.id] := inv;
{$ELSE}
  {$IFDEF USE_RWLOCK}FInvokesLock.wrlock();{$ENDIF}
  try
    FInvokes[inv.id] := inv;
  finally
    {$IFDEF USE_RWLOCK}FInvokesLock.wrunlock();{$ENDIF}
  end; { try/finally }
{$ENDIF}
end;

{**
  Return invoke record with specified message id
}
function TORB.get_invoke(mid: MessageID): IORBInvokeRecord;
begin
  result := nil;
{$IFDEF USE_ORB_CACHE}
  if FCacheRecord.id = mid then
    begin
      result := FCacheRecord;
      exit;
    end;
{$ENDIF}
  {$IFDEF USE_RWLOCK}FInvokesLock.rdlock;{$ENDIF}
  try
    result := IORBInvokeRecord(FInvokes[mid]);
  finally
    {$IFDEF USE_RWLOCK}FInvokesLock.unlock;{$ENDIF}
  end;
end;

function TOrb._get_invoke(id: ORBMessageID): IORBInvokeRecord;
begin
  result := id;
end;

{**
  Creates new invoke record. Returns cache record
  if it not used.
}
function TORB.create_invoke(msgid: MessageID): IORBInvokeRecord;
begin
{$IFDEF USE_ORB_CACHE}
  if FCacheUsed then
    result := TORBInvokeRecord.Create(msgid)
  else
    begin
      FCacheUsed := true;
      result := FCacheRecord;
    end;
{$ELSE}
  result := TORBInvokeRecord.Create(msgid);
{$ENDIF}
end;

{**
  Retrieves IOR and creates object with one
}
function TORB.string_to_object(const str: AnsiString): IORBObject;
var
  ior : IIOR;
begin
  if str = '' then
    dorb_throw(st_BAD_PARAM, MinorBadSchemeName, COMPLETED_NO);

  if Pos('IOR:',String(Str))> 0 then
    begin
      ior := TIOR.Create;
      if not ior.from_string(str) then begin
        ior := nil;
        dorb_throw(st_BAD_PARAM, MinorBadSchemeSpecificPart, COMPLETED_NO);
      end
      else
        result := Ior_To_Object(ior);
    end
  else if Pos('corbaname:', String(str)) > 0 then
    result := corbaname_to_object(str)
  else if Pos('corbaloc:', String(str)) > 0 then
    result := corbaloc_to_object(str)
  else if Pos('http:',String(Str)) > 0  then
    result := http_to_object(str)
  else if Pos('file:',String(str)) > 0 then
    result := file_to_object(str)
  else
    dorb_throw(st_BAD_PARAM, MinorBadSchemeName, COMPLETED_NO);
end;

function TORB._get_interface(const obj: IORBObject): IInterfaceDef;
var
  req: IRequest;
  int : IUnknown;
begin
  result := nil;
  req := obj._request('_interface');
  req.get_result.argument.set_type(_tc_InterfaceDef);
  try
    req.invoke;
  except
  end;
  if req.get_environment.get_exception <> nil then
    dorb_throw(req.get_environment.get_exception);
  if not req.get_result.argument.to_object(int) then exit;
  result := TInterfaceDef._narrow(int as IORBObject);
end;

{**
  Creates object with specified IOR
}
function TORB.ior_to_object(const Ior: IIOR): IORBObject;
var
  oa: IObjectAdaptor;
  temp : IORBObject;
begin
  result := nil;
  if ior.get_profile() = nil then exit;;
  temp := TORBObject.Create(ior);
  temp.setup_domains(nil);
  oa := get_oa(temp);
  if assigned(oa) and oa.is_local then begin
    result :=  oa.skeleton(temp);
    if result = nil then
      result := temp;
  end
  else
    result := temp;
end;

function TORB.invoke_async(const obj: IORBObject; const req: IORBRequest; const pr: IPrincipal;
  resp: Boolean; cb: IORBCallBack; orbmesid: ORBMessageID): ORBMessageID;
var
  oa: IObjectAdaptor;
  ex: IORBException;//ISystemException;
  msgid: MessageID;
  id: ORBMessageID;
  objId: ObjectID;
  locateObj: IORBObject;
  bootManager: IBootManager;
  idLen: _ulong;
begin
  id := orbmesid;
  if id = nil then
    msgid := new_MessageID()
  else
    msgid := get_msgid(id);
  //set current msgid
  currentMsgId := msgid;

  // we need to know OA before calling
  // receive_request_service_context start point
  // - it's called from init_invoke
  if not builtin_invoke(id,obj,req) then
    oa := get_oa(obj);

  if id = nil then
    id := create_invoke(msgid);
{$IFDEF HAVE_THREADS}
  if (cb = nil) and resp then
    cb := TORBAsyncCallback.Create();
{$ENDIF}
  try
    id.init_invoke(self,obj,pr,req,resp,cb,oa);
  except
    result := id;
    Exit;
  end; { try/except }
  if resp then
    add_invoke(id);
    
  if not builtin_invoke(id,obj,req) then begin
    if oa <> nil then begin
      if resp then
        id._oa(oa);
      try
        oa.invoke(id,obj,req,pr,resp);
      except
        on E: SystemException do begin
          if resp then begin
            ex := SystemException.Create(E);
            req.set_out_args(ex);
            answer_invoke(id, InvokeSysEx, obj, req, 0);
            result := id;
          end;
        end
        else begin
          if resp then begin
            ex := INTERNAL.Create(0, COMPLETED_NO);
            req.set_out_args(ex);
            answer_invoke(id, InvokeSysEx, obj, req, 0);
            result := id;
          end;
        end;
      end;
      if resp then
        result := id
      else
        result := nil;
    end
    else begin
      // Check to see if the BootManager knows of a reference
      // for the ObjectKey. If so, forward the request.
      objId := obj._IOR.get_profile(TAG_ANY).objkey(idLen);
      bootManager := TBootManager._narrow(resolve_initial_reference('BootManager'));
      if bootManager <> nil then begin
        try
          locateObj := bootManager.locate(objId);
        except

        end; { try/except }
        if locateObj <> nil then begin
          id.set_locationforward_perm(false);
          answer_invoke(id, InvokeForward, locateObj, req, 0);
          result := id;
          Exit;
        end;
      end;

      ex := OBJECT_NOT_EXIST.Create();
      req.set_out_args(ex);
      answer_invoke(id, InvokeSysEx, obj, req, 0);
      result := id;
    end;
  end;
end;

{**
  Returns new session unique id
**}
function TORB.new_MessageID(): MessageID;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FTheIDLock);
  {$IFDEF USE_RWLOCK}FInvokesLock.rdlock;{$ENDIF}
  try
    //prevent msgid colision
    repeat
      InterlockedIncrement(Integer(FMessageCounter));
    until FInvokes[FMessageCounter] = nil;
  finally
    {$IFDEF USE_RWLOCK}FInvokesLock.unlock;{$ENDIF}
  end;
  result := FMessageCounter;
end;

{**
  Adds Object Adaptor into list of adaptors
}
procedure TORB.register_oa(const oa: IObjectAdaptor; prio: integer);
begin
  {$IFDEF USE_RWLOCK}FAdaptersLock.wrlock();{$ENDIF}
  try
    oa._AddRef;
    FAdapters.AddObject(IntToStr(prio), TObject(oa));
    FAdapters.Sort;
  finally
    {$IFDEF USE_RWLOCK}FAdaptersLock.wrunlock();{$ENDIF;}
  end; { try/finally }
end;

{**
  Removes Object Adaptor from list of adaptors
}
procedure TORB.unregister_oa(const oa: IObjectAdaptor);
var
  i : integer;
  found : Boolean;
begin
  found := False;
  {$IFDEF USE_RWLOCK}FAdaptersLock.wrlock();{$ENDIF}
  try
    i := FAdapters.IndexOfObject(TObject(oa));
    if i >= 0 then
      begin
        FAdapters.Delete(i);
        found := True;
      end;
  finally
    {$IFDEF USE_RWLOCK}FAdaptersLock.wrunlock();{$ENDIF}
  end; { try/finally }
  //WJ: moved here, because of deadlock
  if found then
    oa._Release;
end;

{**
  Retrieves IOR using HTTP protocol and creates new object
}
function TORB.http_to_object(const str: AnsiString): IORBObject;
var
  i,total,allocated : longint;
  host,abspath : AnsiString;
  port : integer;
  addr : IInetAddress;
  trans : ITransport;
  buffer,bufptr : PAnsiChar;
  lstr : AnsiString;
const
  endblock : array[0..3] of byte = (13,10,13,10);
  blocksize = 256;
begin
  result := nil;
  if Pos('//',String(str)) = 6 then
    begin
      lstr := copy(str,8,100);
      i := Pos('/',String(lstr));
      if i > 0 then
        begin
          abspath := str;//PChar(Copy(lstr,i,100));
          host := PAnsiChar(Copy(lstr,1,i-1));
        end
      else
        begin
          abspath := '/';
          host := lstr;
        end;
      if Pos(':',String(host)) > 0 then
        begin
          i := Pos(':',String(host));
          port := StrToInt(Copy(String(host),i+1,100));
          host := PAnsiChar(AnsiString(Copy(String(host),0,i-1)));
        end
      else
        port := 80;
      addr := TInetAddress.Create(host, port, STREAM);
      if addr.resolve_ip() then
        begin
          trans := addr.make_transport;
          if trans.connect(addr) then
            begin
              if (trans.write(PAnsiChar('GET ')^, 4) <> 4) or
                (trans.write(PAnsiChar(abspath)^, Length(abspath)) <> Integer(length(abspath))) or
                (trans.write(endblock, 4) <> 4) then
                dorb_throw(st_BAD_PARAM, MinorOther, COMPLETED_NO)
              else
                begin
                  allocated := blocksize;
                  GetMem(Buffer,allocated);
                  try
                    bufptr := buffer;
                    total := 0;
                    while not trans.eof and not trans.bad do
                      begin
                        i := trans.read(bufptr^, blocksize);
                        if i > 0 then
                          begin
                            inc(total,i);
                            if i = blocksize then
                              begin
                                reallocmem(Buffer,allocated+blocksize);
                                inc(allocated,blocksize);
                                bufptr := Pointer(Integer(buffer)+total);
                              end
                            else
                              break;
                          end;
                      end;
                    if trans.bad then
                      dorb_throw(st_BAD_PARAM, MinorOther, COMPLETED_NO);
                    trans := nil;  
                    if Total > 0 then
                      begin
                        if allocated < total then
                          begin
                            reallocmem(Buffer,total);
                            allocated := total;
                          end;
                        Buffer[total] := Chr(0);
                        result := string_to_object(PAnsiChar(Buffer));
                      end;
                    { TODO -oOVS -cORB : http 0.9 }
                  finally
                    freemem(buffer,allocated);
                  end;
                end;
            end
          else
            dorb_throw(st_BAD_PARAM, MinorBadAddress, COMPLETED_NO);
        end
      else
        dorb_throw(st_BAD_PARAM, MinorBadAddress, COMPLETED_NO);
    end
  else
    dorb_throw(st_BAD_PARAM, MinorBadSchemeSpecificPart, COMPLETED_NO);
end;

{**  Gets IOR from file and creates new object}
function TORB.file_to_object(const str: AnsiString): IORBObject;
var
  fl,l : integer;
  Buffer : PAnsiChar;
  lstr: AnsiString;
begin
  result := nil;
  if pos('//',String(str)) > 0 then
    lstr := PAnsiChar(Integer(str)+Pos('//',String(str))+1)
  else
    lstr := str;
  fl := FileOpen(String(lstr),fmShareDenyNone);
  if fl >= 0 then
    try
      l := FileSeek(fl,0,2);
      FileSeek(fl,0,0);
      Buffer := PAnsiChar(AllocMem(l + 1));
      if FileRead(fl, Buffer^, l) = l then
        result := string_to_object(Buffer);
    finally
      FileClose(fl);
    end;
end;

(*
 * 13.6.10 Object URLs
 *
 * `corbaloc:' <obj_addr_list> [ / <url_encoded_key_string> ]
 *
 * <obj_addr_list>  = [ <obj_addr> `,' ]* <obj_addr>
 * <obj_addr>       = <rir_prot_addr> | <iiop_prot_addr> | <future_prot_addr>
 *
 * <rir_prot_addr>  = `rir:'
 *
 * <iiop_prot_addr> = `:' <iiop_addr> | `iiop:' <iiop_addr>
 * <iiop_addr>      = [ <version> ] <host> [ `:' <port> ]
 * <version>        = <major> `.' <minor> `@'
 *)
function TOrb.corbaloc_to_object(const str: AnsiString): IORBObject;
var
  p, keyLen, strLen, {profiles,} portno, major, minor: integer;
  objAddrList, keyStr, urlEncodedKeyStr, rir, objAddr, iiopAddr: AnsiString;
  version, host, port: AnsiString;
  ior: IIOR;
  addr: IAddress;
  prof: IIORProfile;
{$IFDEF HAVE_SSL}
  ssliop: boolean;
{$ENDIF}
begin
  if Pos('corbaloc:', String(str)) = 0 then
    dorb_throw(st_BAD_PARAM, MinorBadSchemeSpecificPart, COMPLETED_NO);

  strLen := Length(str);
  p := Pos('/', String(str));
  if p = 0 then begin
    objAddrList := AnsiString(Copy(String(str), 10, strLen - 9));
    keyLen := 0;
  end
  else begin
    objAddrList := AnsiString(Copy(String(str), 10, p - 10));
    urlEncodedKeyStr := AnsiString(Copy(String(str), p + 1, strLen - p));
    keyStr := url_decode(urlEncodedKeyStr, keyLen);
  end;

  (*
   * The rir protocol can not be used with any other protocol in a URL.
   *)
  if (Pos('rir:', String(objAddrList)) <> 0) then begin
    (*
     * Hmm, can we have multiple rir: addresses in a URL? I don't think so.
     *)
    if Pos(',', String(objAddrList)) <> 0 then
      dorb_throw(st_BAD_PARAM, MinorBadSchemeSpecificPart, COMPLETED_NO);

    rir := keyStr;

    (*
     * An empty <key_string> is interpreted as the default "NameService"
     *)
    if (keyLen = 0) then
      rir := 'NameService';

    (*
     * Pass key string to resolve_initial_references
     *)
    result := resolve_initial_reference(rir);
    Exit;
  end;

  (*
   * Generate new IOR, and add a profile for each <obj_addr>
   *)
  ior := TIOR.Create;
  //profiles := 0;
  while Length(objAddrList) > 0 do begin
    p := Pos(',', String(objAddrList));
    if (p = 0) then begin
      objAddr := objAddrList;
      objAddrList := '';
    end
    else begin
      objAddr := Copy(objAddrList, 0, p);
      objAddrList := Copy(objAddrList, p + 1, Length(objAddrList) - p);
    end;

    (*
     * Expecting only <iiop_prot_addr> here
     *)
{$IFDEF HAVE_SSL}
    ssliop := false;
{$ENDIF}
    if Pos(':', String(objAddr)) = 1 then
      iiopAddr := Copy(objAddr, 2, Length(objAddr) - 1)
    else if Pos('iiop:', String(objAddr)) = 1 then
      iiopAddr := Copy(objAddr, 6, Length(objAddr) - 5)
{$IFDEF HAVE_SSL}
    else if Pos('ssliop:', objAddr) = 1 then begin
      iiopAddr := Copy(objAddr, 8, Length(objAddr) - 7);
      ssliop := true;
    end
{$ENDIF}
    else
      dorb_throw(st_BAD_PARAM, MinorBadSchemeSpecificPart, COMPLETED_NO);

    (*
     * <iiop_addr> = [ <version> `@' ] <host> [ `:' <port> ]
     *)
    p := Pos('@', String(iiopAddr));
    if (p <> 0) then begin
      version := Copy(iiopAddr, 1, p - 1);
      iiopAddr := Copy(iiopAddr, p + 1, Length(iiopAddr) - p);
    end
    else
      version := '1.0';

    p := Pos(':', String(iiopAddr));
    if (p <> 0) then begin
      port := Copy(iiopAddr, p + 1, Length(iiopAddr) - p);
      iiopAddr := Copy(iiopAddr, 1, p - 1);
    end
    else
      port := '2809';

    host := iiopAddr;

    (*
     * Convert version and port to numbers
     *)
    p := Pos('.', String(version));
    if (p = 0) then
      dorb_throw(st_BAD_PARAM, MinorBadSchemeSpecificPart, COMPLETED_NO);

    portno := StrToInt(String(port));
    major := StrToInt(Copy(String(version), 1, p - 1));
    minor := StrToInt(Copy(String(version), p + 1, Length(version) - p));

    (*
     * add profile
     *)

    addr := TInetAddress.Create(host, portno);
{$IFDEF HAVE_SSL}
    if ssliop then
      addr := TSSLAddress.Create(addr);
{$ENDIF}

    if not addr.valid then
      dorb_throw(st_BAD_PARAM, MinorBadAddress, COMPLETED_NO);

{$IFDEF HAVE_SSL}
    if ssliop then
      prof := TSSLProfile.Create(keyStr, keyLen, addr as ISSLAddress, TMultiComponent.Create() as IMultiComponent, major * 256 + minor)
    else
{$ENDIF}
    prof := TIIOPProfile.Create(keyStr, keyLen, addr as IInetAddress, TMultiComponent.Create() as IMultiComponent, major * 256 + minor);

    ior.add_profile(prof);
    //profiles := Succ(profiles);
  end;
  result := ior_to_object(ior);
end;

function TOrb.corbaname_to_object(const str: AnsiString): IORBObject;
var
  p, strLen, stringLength: integer;
  corbalocObj, urlName, corbaloc, stringName: string;
  req: IRequest;
  obj: IInterface;
begin
  if Pos('corbaname:', String(str)) = 0 then
    dorb_throw(st_BAD_PARAM, MinorBadSchemeSpecificPart, COMPLETED_NO);

  strLen := Length(str);
  p := Pos('#', String(str));

  (*
   * First construct a corbaloc URL of the form
   * corbaname:<corbaloc_obj>#<url_name>
   *)
  if p = 0 then
    corbalocObj := Copy(String(str), 11, strLen - 10)
  else begin
    corbalocObj := Copy(String(str), 11, p - 11);
    urlName := Copy(String(str), p + 1, strLen - p);
  end;

  corbaloc := 'corbaloc:' + corbalocObj;

  (*
   * If the <corbaloc_obj> does not contain a key string, a default key of
   * NameService is used.
   *)
  if Pos('/', corbalocObj) = 0 then
    corbaloc := corbaloc + '/NameService';

  (*
   * This is converted to a naming context object reference with
   *)
  result := string_to_object(AnsiString(corbaloc));

  (*
   * Empty <string_name> represents the root NamingContext itself
   *)
  if Length(urlName) = 0 then
    Exit;

  (*
   * The <string_name> is converted to a CosNaming::Name
   * The resulting name is passed to a resolve operation on the naming context
   *)
  stringName := String(url_decode(AnsiString(urlName), stringLength));

  (*
   * Ask Naming Service by DII. That saves a couple of kBs
   * by not needing to compile in the stubs
   *)
  req := result._request('resolve_str');
  req.get_arguments.add(ARG_IN).argument.put_string(AnsiString(stringName));
  req.set_return_type(_tc_Objref);
  try
    req.invoke();
  except

  end; { try/except }

  if req.get_environment().get_exception() <> nil then
    dorb_throw(st_BAD_PARAM, MinorOther, COMPLETED_NO);

  if not req.return_value.to_object(obj) then
    dorb_throw(st_BAD_PARAM, MinorOther, COMPLETED_NO);

  result := obj as IORBObject;
end;

{**  Returns first adaptor what service specified object}
function TORB.get_oa(const obj: IORBObject): IObjectAdaptor;
var
  i : integer;
  local : Boolean;
begin
  local := is_local(obj);
  {$IFDEF USE_RWLOCK}FAdaptersLock.rdlock();{$ENDIF}
  try
    for i := Pred(FAdapters.Count) downto 0 do
      with IObjectAdaptor(Pointer(FAdapters.Objects[i])) do
      if (is_local = local) and  has_object(obj) then
        begin
          result := IObjectAdaptor(Pointer(FAdapters.Objects[i]));
          break;
        end;
  finally
    {$IFDEF USE_RWLOCK}FAdaptersLock.rdunlock();{$ENDIF}
  end; { try/finally }
end;

function TOrb.get_oa(const objectId: ObjectId): IObjectAdaptor;
var
  i : integer;
begin
  FAdaptersLock.rdlock();
  try
    for i := Pred(FAdapters.Count) downto 0 do
      with IObjectAdaptor(Pointer(FAdapters.Objects[i])) do
      if get_oaid() = objectId then
        begin
          result := IObjectAdaptor(Pointer(FAdapters.Objects[i]));
          Break;
        end;
  finally
    FAdaptersLock.rdunlock();
  end; { try/finally }
end;

{**  Gets reply on request with specified message id}
function TORB.get_invoke_reply (id: ORBMessageID; out obj: IORBObject; out req: IORBRequest;
  out ad: AddressingDisposition): TInvokeStatus;
var
  irec : IORBInvokeRecord;
  res: Boolean;
begin
  result := orbtypes.InvokeOK;
  irec := _get_invoke(id);
  assert(irec<>nil);
  res := irec.get_answer_invoke(result, obj, req, ad);
  assert(res);
  del_invoke(irec.id());
  currentMsgId := 0;
end;

function TOrb.get_locate_reply(id: ORBMessageID; out obj: IORBObject;
  out ad: AddressingDisposition): TLocateStatus;
var
  rec: IORBInvokeRecord;
begin
  rec := _get_invoke(id);
  Assert(rec <> nil);

  Assert(rec.get_answer_locate(result, obj, ad));
  del_invoke(rec.id());
end;

function TOrb.locate_async(const obj: IORBObject; cb: IORBCallback;
  id: ORBMessageID): ORBMessageID;
var
  oa: IObjectAdaptor;
  rec: IORBInvokeRecord;
begin
  oa := get_oa(obj);
  rec := _get_invoke(id);
  if rec = nil then
    rec := new_orbid();
{$IFDEF HAVE_THREADS}
  if cb = nil then
    cb := TORBasyncCallback.Create;
{$ENDIF}
  rec.init_locate(Self, obj, cb, oa);
  add_invoke(rec);

  if oa = nil then
    answer_locate (rec, LocateUnknown, nil, 0)
  else
    oa.locate(rec, obj);

  result := rec;
end;

function TORB.resolve_initial_reference(const id: ObjectID): IORBObject;
var
  i : integer;
  tmp : IORBObject;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FInitRefsLock);
  result := nil;
  i := FInitRefs.IndexOf(String(id));
  if i < 0 then
    begin
      if (id = 'RootPOA') or (id = 'POACurrent') then begin // RootPOA initializes POACurrent
        if the_root_poa = nil then begin
          FInitRefsLock.unlock;
          try
            TPOA_impl.Create1(self);
          finally
            FInitRefsLock.lock;
          end; { try/finally }
        end;
      end
      else if id = 'PrincipalCurrent' then begin
        tmp := TPrincipalCurrent_impl.Create;
        tmp._AddRef;
        FInitRefs.AddObject(String(id),TObject(tmp));
      end
      else if id = 'CodecFactory' then begin
        tmp := pi_impl.TCodecFactoryImpl.Create;
        tmp._AddRef;
        FInitRefs.AddObject(String(id),TObject(tmp));
      end
      else if id = 'PICurrent' then begin
        tmp := pi_impl.TCurrentImpl.Create;
        tmp._AddRef;
        FInitRefs.AddObject(String(id),TObject(tmp));
      end;
      i := FInitRefs.IndexOf(String(id));
    end;
  if i >= 0 then
    result := IORBObject(Pointer(FInitRefs.Objects[i]));
end;

function TORB.register_value_factory(const id: RepositoryID; const factory: IValueFactory): IValueFactory;
begin
  result := lookup_value_factory(id);
  factory._AddRef;
  if result <> nil then
    begin
      result._Release;
      FValueFactories.Delete(FValueFactories.IndexOf(String(id)));
    end;
  FValueFactories.AddObject(String(id),TObject(factory));
end;

function TORB.lookup_value_factory(const id: RepositoryID): IValueFactory;
var
  i : integer;
begin
  result := nil;
  i := FValueFactories.IndexOf(String(id));
  if i>=0 then
    result := IValueFactory(Pointer(FValueFactories.Objects[i]))
end;

procedure TORB.unregister_value_factory(const id: RepositoryID);
var
  i : integer;
begin
  i := FValueFactories.IndexOf(String(id));
  if i < 0 then exit;
  IValueFactory(Pointer(FValueFactories.Objects[i]))._Release;
  FValueFactories.Delete(i);
end;

function TOrb.create_environment: IEnvironment;
begin
  result := TEnvironment.Create();
end;

function TOrb.object_to_string(const obj: IORBObject): AnsiString;
var
  ior : IIOR;
begin
  if obj = nil then
    begin
      ior := TIOR.Create();
      result := ior.stringify;
    end;
  if obj._ior = nil then
    dorb_throw(SystemException.Create_type(st_MARSHAL));
  result := obj._ior.stringify;
end;

procedure TOrb._destroy;
var
  i: integer;
  sync: ISynchronized;
begin
  if FDestroy then
    dorb_throw(st_OBJECT_NOT_EXIST);

  if FState = osRunning then
    shutdown(true);
  // remove all profile
  FIORTempl.clean();
  FIORTempl := nil;
  // remove references
  sync := TSynchronized.Create(FInitRefsLock);
  for i := 0 to FInitRefs.Count - 1 do
    IORBObject(Pointer(FInitRefs.Objects[i]))._Release;
  FInitRefs.Clear;
  FDefaultManager := nil;
  FDestroy := true;
  // destroy all registered PIs
  TPIManager.DestroyAllInterceptors();
  ORBInstance := nil;
  TOSNet.sockfinal();
  TProcess.Shutdown();
  // WJ: ValFactories should be unregistered (memoryleak)
  while FValueFactories.Count > 0 do
      unregister_value_factory(AnsiString(FValueFactories[0]));
  // WJ: Closing logger
  DestroyLogger;
end;

function TOrb.is_a(const obj: IORBObject;
  const repo_id: RepositoryId): Boolean;
var
  req: IRequest;
  res: Boolean;
begin
  { TODO -oOVS : implement isa cach }
  // [12-17]
  req := CreateRequest(obj, '_is_a');
  req.add_in_arg('logical_type_id').put_string(repo_id);
  req.get_result.argument.set_type(_tc_boolean);
  try
    req.invoke;
  except
  end; { try/except }
  if req.get_environment.get_exception <> nil then
    dorb_throw(req.get_environment.get_exception);
  res := req.get_result.argument.to_boolean(result);
  if not res then
    raise MARSHAL.Create(0, COMPLETED_NO);
end;

function TOrb.create_abstract_interface_tc(const id: RepositoryID;
  const name: Identifier): ITypeCode;
begin
  result := nil;
  assert(false,'not imlplemented');
end;

function TOrb.create_alias_tc(const id: RepositoryID;
  const name: Identifier; const original_type: ITypeCode): ITypeCode;
begin
  result := TTypeCode.create_alias_tc(id,name,original_type)
end;

function TOrb.create_array_tc(const length: _ulong;
  const element_type: ITypeCode): ITypeCode;
begin
  result := TTypeCode.create_array_tc(element_type,length)
end;

function TOrb.create_enum_tc(const id: RepositoryID;
  const name: Identifier; const members: EnumMemberSeq): ITypeCode;
begin
  result := TTypeCode.create_enum_tc(id,name,members)
end;

function TOrb.create_exception_tc(const id: RepositoryID;
  const name: Identifier; const members: StructMemberSeq): ITypeCode;
begin
  result := TTypeCode.create_exception_tc(id,name,members)
end;

function TOrb.create_fixed_tc(const digits: _ushort;
  const scale: short): ITypeCode;
begin
  result := nil;
  assert(false,'not imlplemented');
end;

function TOrb.create_interface_tc(const id: RepositoryID;
  const name: Identifier): ITypeCode;
begin
  result := TTypeCode.create_interface_tc(id,name)
end;

procedure TOrb.create_list(const count: Integer; out new_list: INVList);
begin
  if count < 0 then
    dorb_throw(SystemException.Create_type(st_BAD_PARAM) as IORBException);
  new_list := TNVList.Create(count);
end;

function TOrb.create_native_tc(const id: RepositoryID;
  const name: Identifier): ITypeCode;
begin
  result := TTypeCode.create_native_tc(id, name);
end;

procedure TOrb.create_operation_list(const oper: IOperationDef;
  out new_list: INVList);
var
  params: ParDescriptionSeq;
  i : integer;
begin
  new_list := TNVList.Create();
  params := oper.get_params();
  for i := 0 to Pred(Length(params)) do
    case params[i].mode of
      PARAM_IN: new_list.add(ARG_IN).argument.set_type(params[i]._type);
      PARAM_OUT: new_list.add(ARG_OUT).argument.set_type(params[i]._type);
      PARAM_INOUT: new_list.add(ARG_INOUT).argument.set_type(params[i]._type);
    end;
end;

function TOrb.create_policy(_type: PolicyType; const val: IAny): IPolicy;
var
  v : _ushort;
  pts: TProfileTagSeq;
  valThreadPol: ThreadPolicyValue;
  valLifespanPol: LifespanPolicyValue;
  valIdUniqPol: IdUniquenessPolicyValue;
  valIdAssignPol: IdAssignmentPolicyValue;
  valImplActPol: ImplicitActivationPolicyValue;
  valServRetPol: ServantRetentionPolicyValue;
  valReqProcPol: RequestProcessingPolicyValue;
begin
  case _type of
    THREAD_POLICY_ID: begin
      if not any_to_ThreadPolicyValue(val, valThreadPol) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TThreadPolicy.Create(_type, valThreadPol);
    end;
    LIFESPAN_POLICY_ID: begin
      if not any_to_LifespanPolicyValue(val, valLifespanPol) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TLifespanPolicy.Create(_type, valLifespanPol);
    end;
    ID_UNIQUENESS_POLICY_ID: begin
      if not any_to_IdUniquenessPolicyValue(val, valIdUniqPol) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TIdUniquenessPolicy.Create(_type, valIdUniqPol);
    end;
    ID_ASSIGNMENT_POLICY_ID: begin
      if not any_to_IdAssignmentPolicyValue(val, valIdAssignPol) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TIdAssignmentPolicy.Create(_type, valIdAssignPol);
    end;
    IMPLICIT_ACTIVATION_POLICY_ID: begin
      if not any_to_ImplicitActivationPolicyValue(val, valImplActPol) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TImplicitActivationPolicy.Create(_type, valImplActPol);
    end;
    SERVANT_RETENTION_POLICY_ID: begin
      if not any_to_ServantRetentionPolicyValue(val, valServRetPol) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TServantRetentionPolicy.Create(_type, valServRetPol);
    end;
    REQUEST_PROCESSING_POLICY_ID: begin
      if not any_to_RequestProcessingPolicyValue(val, valReqProcPol) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TRequestProcessingPolicy.Create(_type, valReqProcPol);
    end;
    TRANSPORTPREF_POLICY_TYPE: begin
      if not any_to_ProfileTagSeq(val, pts) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TTransportPrefPolicy.Create(pts);
    end;
    BIDIRECTIONAL_POLICY_TYPE: begin
      if not val.to_ushort(v) then
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
      result := TBidirectionalPolicy.Create(v);
    end;
    else begin
      if TPIManager.PIManager.PolicyFactoryMap.Item[_type] <> nil then
        result := IPolicyFactory(TPIManager.PIManager.PolicyFactoryMap.Item[_type]).create_policy(_type, val)
      else
        dorb_throw(TPolicyError.Create(BAD_POLICY_TYPE));
    end;
  end;
end;

procedure TOrb.get_default_domain_manager(out dm: IDomainManager);
var
  prefs: TProfileTagSeq;
  tpp: ITransportPrefPolicy;
begin
  if FDefaultManager = nil then begin
    FDefaultManager := TDomainManager.Create;

    // install default policies ...
    SetLength(prefs, 2);

    prefs[0] := TAG_INTERNET_IOP;
    //prefs[1] := TAG_UNIX_IOP;
    //prefs[2] := TAG_UDP_IOP;
    prefs[1] := TAG_SSL_INTERNET_IOP;
    //prefs[4] := TAG_SSL_UNIX_IOP;
    //prefs[5] := TAG_SSL_UDP_IOP;

    tpp := TTransportPrefPolicy.Create(prefs);

    FDefaultManager.set_domain_policy(tpp);
  end;
  dm := FDefaultManager;
end;

function TOrb.create_recursive_tc(const id: RepositoryID): ITypeCode;
begin
  result := TTypeCode.create_recursive_tc(id);
end;

function TOrb.create_sequence_tc(const bound: _ulong;
  const element_type: ITypeCode): ITypeCode;
begin
  result := TTypeCode.create_sequence_tc(element_type,bound)
end;

function TOrb.create_string_tc(const bound: _ulong): ITypeCode;
begin
  result := nil;
  assert(false,'not imlplemented');
end;

function TOrb.create_struct_tc(const id: RepositoryID;
  const name: Identifier; const members: StructMemberSeq): ITypeCode;
begin
  result := TTypeCode.create_struct_tc(id,name,members)
end;

function TOrb.create_union_tc(const id: RepositoryID;
  const name: Identifier; const discriminator_type: ITypeCode;
  const members: UnionMemberSeq): ITypeCode;
begin
  result := TTypeCode.create_union_tc(id,name,discriminator_type,members)
end;

function TOrb.create_value_box_tc(const id: RepositoryID;
  const name: Identifier; const boxed_type: ITypeCode): ITypeCode;
begin
  result := TTypeCode.create_value_box_tc(id,name,boxed_type);
end;

function TOrb.create_value_tc(const id: RepositoryID;
  const name: Identifier; const type_modifier: TValueModifier;
  const concrete_base: ITypeCode;
  const members: ValueMemberSeq): ITypeCode;
begin
  result := TTypeCode.create_value_tc(id,name,type_modifier,
    concrete_base,members)
end;

function TOrb.create_wstring_tc(const bound: _ulong): ITypeCode;
begin
  assert(false,'not imlplemented');
  result := nil;
end;

procedure TOrb.get_default_context(out ctx: IContext);
begin
  
end;

procedure TOrb.get_next_response(out req: IRequest);
begin
  assert(false,'not imlplemented');
end;

function TOrb.get_service_information(const service_type: ServiceType;
  out service_information: ServiceInformation): Boolean;
begin
  result := false;
  assert(false,'not imlplemented');
end;

function TOrb.list_initial_references: ObjectIDList;
var
  i: Integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FInitRefsLock);

  SetLength(result, FInitRefs.Count);

  for i := 0 to FInitRefs.Count - 1 do
    result[i] := ObjectId(FInitRefs[i]);

  if FInitRefs.IndexOf('RootPOA') = -1 then begin
    i := Length(result);
    SetLength(result, i + 1);
    result[i] := 'RootPOA';
  end;
  if FInitRefs.IndexOf('POACurrent') = -1 then begin
    i := Length(result);
    SetLength(result, i + 1);
    result[i] := 'POACurrent';
  end;
  if FInitRefs.IndexOf('DynAnyFactory') = -1 then begin
    i := Length(result);
    SetLength(result, i + 1);
    result[i] := 'DynAnyFactory';
  end;
  if FInitRefs.IndexOf('PrincipalCurrent') = -1 then begin
    i := Length(result);
    SetLength(result, i + 1);
    result[i] := 'PrincipalCurrent';
  end;
  if FInitRefs.IndexOf('CodecFactory') = -1 then begin
    i := Length(result);
    SetLength(result, i + 1);
    result[i] := 'CodecFactory';
  end;
  if FInitRefs.IndexOf('PICurrent') = -1 then begin
    i := Length(result);
    SetLength(result, i + 1);
    result[i] := 'PICurrent';
  end;
end;

procedure TOrb.perform_work;
begin
  if FDestroy then
    dorb_throw(st_OBJECT_NOT_EXIST);

  validateState();

  // If this is not the main thread then do nothing
  if FMainThread <> TORBThread.CurrentThread() then
    Exit;

  FDispatcher.dispatch_one_event(0);
  do_shutdown();
end;

function TOrb.resource_manager: IResourceManager;
begin
  result := FResourceManager;
end;

function TOrb.poll_next_response: Boolean;
begin
  result := false;
  assert(false,'not imlplemented');
end;

procedure TOrb.send_multiple_requests_deferred(const req: RequestSeq);
begin
  assert(false,'not imlplemented');
end;

procedure TOrb.send_multiple_requests_oneway(const req: RequestSeq);
begin
  assert(false,'not imlplemented');
end;

function TOrb.work_pending: Boolean;
begin
  result := false;
  assert(false,'not imlplemented');
end;

function TOrb.create_named_value: TNamedValue;
begin
  result.name := '';
  result.argument := TAny.Create;
  result.len := 0;
  result.flags := 0;
end;

function TOrb.get_current_invoke_rec: IORBInvokeRecord;
begin
  if currentMsgId <> 0 then
    result := get_invoke(currentMsgId);
end;

function TOrb.get_Properties: IProperties;
begin
  result := FProperties;
end;

procedure TOrb.set_Properties(const props: IProperties);
begin
  FProperties := props;
end;

procedure TOrb.TurnOnBiDirGIOP;
begin
  FBiDirGIOP := True;
end;

function TOrb.UseBiDirGIOP: Boolean;
begin
  Result := FBiDirGIOP;
end;

procedure TOrb.validateState;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FShutdownComplete);
  // The ORB destroys this object, so it's an initialization error
  // if the this operation is called after ORB destruction
  if FState = osDestroyed then
    dorb_throw(st_INITIALIZE, MinorORBDestroyed, COMPLETED_NO);
  if (FState = osServerShutdown) or (FState = osClientShutdown) then
    dorb_throw(st_BAD_INV_ORDER, MinorShutdownCalled, COMPLETED_NO);
  if FState = osNotRunning then begin
    // Remember the main thread id
    FMainThread := TORBThread.CurrentThread();
    // Set the state to StateRunning
    FState := osRunning;
  end;
end;

procedure TOrb.blockServerShutdownComplete;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FShutdownComplete);
  // Wait for the server side to shutdown. Note that the client side
  // shutting down or the state being destroyed also implies that
  // the server side has shutdown
  while FState = osRunning do
    try
      FShutdownComplete.wait();
    except
      on E: EInterruptedException do
    end; { try/except }
end;

//********************************************************************
//  TORBInvokeRecord
//********************************************************************
constructor TORBInvokeRecord.Create(msgId: MessageID);
begin
  inherited Create();
  FMessageID := msgId;
  FActive := true;
end;

function TORBInvokeRecord.active: boolean;
begin
  result := FActive;
end;

procedure TORBInvokeRecord.deactivate;
begin
  FActive := false;
end;

function TORBInvokeRecord.get_invoke_hint: Pointer;
begin
  result := FInvHint;
end;

function TORBInvokeRecord.get_request_hint: Pointer;
begin
  result := FReqHint;
end;

procedure TORBInvokeRecord.set_invoke_hint(hint: Pointer);
begin
  FInvHint := hint;
end;

procedure TORBInvokeRecord.set_request_hint(hint: Pointer);
begin
  FReqHint := hint;
end;

procedure TORBInvokeRecord.init_invoke(const orb: IORB; const obj: IORBObject;
  const pr: IPrincipal; const req: IORBRequest; resp: Boolean; const cb: IORBCallBack;
  const oa: IObjectAdaptor);
begin
  FORB:= orb;
  FObject := obj;
  FRequest := req;
  FResponse_req := resp;
  FCallBack := cb;
  FAdapter := oa;
  FType := RequestInvoke;
  FHaveResult := False;
  FTag := nil;
  FAddress := nil;
  FActive := true;
  FPrincipal := pr;
  if (oa <> nil) and oa.is_local then begin
    FIceptReq := TPIManager.CreateSRI(obj, req.op_name, FMessageID, resp, req.context);
    // we need already initialized reply service context list here
    // because we can call add_reply_service_context from interceptor's
    // receive_request_service_context
    // put receive_request_service_contexts here
    try
      TPIManager.PIManager.ReceiveRequestServiceContextsIp(FIceptReq, req.context(), oa);
    except
      on E: SystemException do begin
        req.set_out_args(SystemException.Create(E));
        FORB.answer_invoke(Self, InvokeSysEx, FObject, req, 0);
        raise;
      end;
      on E: TForwardRequest do begin
        FORB.answer_invoke(Self, InvokeForward, E.forward(), req, 0);
        raise;
      end;
      on E: UserException do begin
        req.set_out_args(UserException.copy(E));
        FORB.answer_invoke(Self, InvokeUserEx, FObject, req, 0);
        raise;
      end;
      else begin
        req.set_out_args(UNKNOWN.Create(0, COMPLETED_NO));
        FORB.answer_invoke(Self, InvokeSysEx, FObject, req, 0);
        raise;
      end;
    end; { try/except }
  end
  else
    FIceptReq := nil;
end;

procedure TORBInvokeRecord.init_bind(const orb: IORB; const repoid: RepositoryId;
  const tag: IObjectTag; const addr: IAddress; const cb: IORBCallBack;
  const oa: IObjectAdaptor);
begin
  FORB:= orb;
  FObject := nil;
  FRequest := nil;
  FResponse_req := TRUE;
  FCallBack := cb;
  FAdapter := oa;
  FTag := tag;
  FAddress := addr;
  FHaveResult := False;
  FType := RequestBind;
  FActive := true;
  FRepoId := repoid;
end;

function TORBInvokeRecord.callback(): IORBCallBack;
begin
  result := FCallBack;
end;

function TORBInvokeRecord.get_principal: IPrincipal;
begin
  result := FPrincipal;
end;

procedure TORBInvokeRecord.redo;
begin
  Assert(FAdapter <> nil);
  Assert(not FHaveResult);

  case FType of
    RequestInvoke: begin
      // fallback to initial location ...
      FTarget._unforward();
      FAdapter.invoke(Self, FTarget, FRequest, FPrincipal, FResponse_req);
    end;
    RequestLocate: FAdapter.locate(Self, FTarget);
    RequestBind: FAdapter.bind(Self, FRepoId, FTag, FAddress);
  else
    Assert(false);
  end;
end;

function TORBInvokeRecord.responce: boolean;
begin
  result := FResponse_req;
end;

{**
  Returns record to uninitialized state
**}
procedure TORBInvokeRecord.clean();
begin
  FMessageID := 0;
  FObject := nil;
  FRequest := nil;
  FCallback := nil;
  FAdapter := nil;
  FHaveResult := false;
  FORB := nil;
  FStat := InvokeOK;
  FTag := nil;
  FAddress := nil;
  FActive := false;
end;

procedure TORBInvokeRecord.set_answer_bind(const state: TLocateStatus;const obj: IORBObject);
begin
  FLocateStatus := state;
  if state = LocateHere then
    FObject := obj;
  FHaveResult := true;
  //Assert(FCallback <> nil);
  //FCallback.notify(FORB, Self, _Bind);
end;

{**  Sets answer on invoke}
procedure TORBInvokeRecord.set_answer_invoke(const state: TInvokeStatus; const obj: IORBObject;
  const req: IORBRequest; const ad: AddressingDisposition);
var
  ex: ISystemException;
  sri: IServerRequestImpl;
  piCur: IInterface;
begin
  FStat := state;
  if FIceptReq = nil then begin
    case state of
      InvokeForward: FObject := obj;
      InvokeOk, InvokeUserEx, InvokeSysEx: begin
        if not FRequest.copy_out_args(req) then begin
          ex := SystemException.Create_type(st_MARSHAL);
          FRequest.set_out_args(ex);
          FStat := InvokeSysEx;
        end;
      end;
      InvokeAddrDisp: FAd := ad;
      else
        Assert(false);
    end;
    FHaveResult := true;
    Exit;
  end;

  ex := MARSHAL.Create(0, COMPLETED_NO);
  piCur := FObject._orb.resolve_initial_reference('PICurrent');
  sri := FIceptReq as IServerRequestImpl;
  // I've commented it out because we need initialized reply service
  // context more early in init_invoke, where we call
  // receive_request_service_context on interceptor PI spec said that
  // in receive_request_service_context is add_reply_service_context valid
  // operation so we need service context list already initialized
  // before calling any receive_request_service_context
  // such that I've done this change
  //     	sri->set_reply_service_context_list(r->context());
  if (state = InvokeOk) or (state = InvokeUserEx) or (state = InvokeSysEx) then begin
    if not FRequest.copy_out_args(req) then begin
        FRequest.set_out_args(ex);
        FStat := InvokeSysEx;
        sri.Exception(ex);
    end;
  end;
  case state of
    InvokeOk: begin
      sri.ReplyStatus(SUCCESSFUL);
      sri.IceptOper(SEND_REPLY);
      sri.Slots((piCur as IPICurrentImpl).Slots());
      // send_reply
      try
        TPIManager.PIManager.ExecSendReply(FIceptReq);
      except
        on E: SystemException do begin
          req.set_out_args(SystemException.Create(E));
          FStat := InvokeSysEx;
        end;
        on E: UserException do begin
          req.set_out_args(UserException.copy(E));
          FStat := InvokeUserEx;
        end;
        else begin
          req.set_out_args(UNKNOWN.Create(0, COMPLETED_NO));
          FStat := InvokeSysEx;
        end;
      end; { try/except }
    end;
    InvokeUserEx: begin
      sri.ReplyStatus(USER_EXCEPTION);
      sri.IceptOper(SEND_EXCEPTION);
      sri.Slots((piCur as IPICurrentImpl).Slots());
      if not sri.OwnException then begin
        // send_exception
        try
          TPIManager.PIManager.ExecSendException(FIceptReq);
        except
          on E: SystemException do begin
            req.set_out_args(SystemException.Create(E));
            FStat := InvokeSysEx;
          end;
          on E: TForwardRequest do begin
            FObject := E.forward();
            FStat := InvokeForward;
          end;
          on E: UserException do begin
            req.set_out_args(UserException.copy(E));
            FStat := InvokeUserEx;
          end;
          else begin
            req.set_out_args(UNKNOWN.Create(0, COMPLETED_NO));
            FStat := InvokeSysEx;
          end;
        end; { try/except }
      end;
    end;
    InvokeSysEx: begin
      sri.ReplyStatus(SYSTEM_EXCEPTION);
      sri.IceptOper(SEND_EXCEPTION);
      sri.Slots((piCur as IPICurrentImpl).Slots());
      // send_exception
      if not sri.OwnException then begin
        try
          TPIManager.PIManager.ExecSendException(FIceptReq);
        except
          on E: SystemException do begin
            req.set_out_args(SystemException.Create(E));
            FStat := InvokeSysEx;
          end;
          on E: TForwardRequest do begin
            FObject := E.forward();
            FStat := InvokeForward;
          end;
          on E: UserException do begin
            req.set_out_args(UserException.copy(E));
            FStat := InvokeUserEx;
          end;
          else begin
            req.set_out_args(UNKNOWN.Create(0, COMPLETED_NO));
            FStat := InvokeSysEx;
          end;
        end; { try/except }
      end;
    end;
    InvokeForward: begin
      FObject := obj;
      sri.EffectiveTarget(FObject);
      sri.ReplyStatus(LOCATION_FORWARD);
      sri.IceptOper(SEND_OTHER);
      sri.Slots((piCur as IPICurrentImpl).Slots());
      // send_other
      if not sri.OwnException then
        try
          TPIManager.PIManager.ExecSendOther(FIceptReq);
        except
          on E: SystemException do begin
            req.set_out_args(SystemException.Create(E));
            FStat := InvokeSysEx;
          end;
          on E: TForwardRequest do begin
            FObject := E.forward();
            FStat := InvokeForward;
          end;
          on E: UserException do begin
            req.set_out_args(UserException.copy(E));
            FStat := InvokeUserEx;
          end;
          else begin
            req.set_out_args(UNKNOWN.Create(0, COMPLETED_NO));
            FStat := InvokeSysEx;
          end;
        end; { try/except }
    end;
    InvokeAddrDisp: begin
      FAd := ad;
      sri.ReplyStatus(TRANSPORT_RETRY);
      sri.IceptOper(SEND_OTHER);
      sri.Slots((piCur as IPICurrentImpl).Slots());
      // send_other
      try
        TPIManager.PIManager.ExecSendOther(FIceptReq);
      except
        on E: SystemException do begin
          req.set_out_args(SystemException.Create(E));
          FStat := InvokeSysEx;
        end;
        on E: TForwardRequest do begin
          FObject := E.forward();
          FStat := InvokeForward;
        end;
        on E: UserException do begin
          req.set_out_args(UserException.copy(E));
          FStat := InvokeUserEx;
        end;
        else begin
          req.set_out_args(UNKNOWN.Create(0, COMPLETED_NO));
          FStat := InvokeSysEx;
        end;
      end; { try/except }
    end;
    else
      Assert(false);
  end;
  FHaveResult := true;
end;

{**  Returns request type of record}
function TORBInvokeRecord.request_type: TRequestType;
begin
  result := FType;
end;

{**  Sets Object Adaptor}
procedure TORBInvokeRecord.set_oa(const oa: IObjectAdaptor);
begin
  FAdapter := oa;
end;

{**
  Returns message id of record
**}
function TORBInvokeRecord.id: MessageID;
begin
  result := FMessageID;
end;

{**  TRUE if record contains answer on request}
function TORBInvokeRecord.completed(): Boolean;
begin
  result := FHaveResult;
end;

function TORBInvokeRecord.get_answer_bind(out state: TLocateStatus;out obj: IORBObject): Boolean;
begin
  result := false;
  if not self.FHaveResult then exit;
  obj := FObject;
  state := FLocateStatus;
  result := true;
end;

{**  Returns answer on request}
function TORBInvokeRecord.get_answer_invoke(out state: TInvokeStatus; out obj: IORBObject;
  out req: IORBRequest; out ad: AddressingDisposition): Boolean;
begin
  result := false;
  if not FHaveResult then exit;
  obj := FObject;
  state := FStat;
  req := FRequest;
  ad := FAd;
  result := true;
end;

function TORBInvokeRecord.get_answer_locate(out state: TLocateStatus;
  out obj: IORBObject; out ad: AddressingDisposition): Boolean;
begin
  Assert(FType = RequestLocate);
  if not FHaveResult then begin
    result := false;
    Exit;
  end;

  obj := FObject;
  state := FLocateStatus;
  ad := FAd;
  result := true;
end;

procedure TORBInvokeRecord.init_locate(const orb: IORB;
  const obj: IORBObject; const cb: IORBCallBack; const oa: IObjectAdaptor);
begin
  FORB:= orb;
  FObject := nil;
  FTarget := obj;
  FRequest := nil;
  FPrincipal := nil;
  FResponse_req := true;
  FCallBack := cb;
  FAdapter := oa;
  FAddress := nil;
  FHaveResult := False;
  FType := RequestLocate;
  FActive := true;
end;

procedure TORBInvokeRecord.set_answer_locate(const state: TLocateStatus;
  const obj: IORBObject; ad: AddressingDisposition);
begin
  Assert(FType = RequestLocate);
  Assert(not FHaveResult);

  FLocateStatus := state;

  case state of
    LocateHere, LocateUnknown: ;
    LocateForward: FObject := obj;
    LocateAddrDisp: FAd := ad;
  else
    Assert(false);
  end;
  FHaveResult := true;
end;

{**  Returns Object Adaptor}
procedure TORBInvokeRecord._oa(oa: IObjectAdaptor);
begin
  FAdapter := oa;
end;

function TORBInvokeRecord.get_oa(): IObjectAdaptor;
begin
  result := FAdapter;
end;

function TORBInvokeRecord.get_locationforward_perm: boolean;
begin
  result := FLocationForwardPerm;
end;

procedure TORBInvokeRecord.set_locationforward_perm(perm: boolean);
begin
  FLocationForwardPerm := perm;
end;

function TORBInvokeRecord.request_info: IInterface;
begin
  result := FIceptReq;
end;

{$ENDIF}

//***************************************************************
//  TObjectTag
//***************************************************************
constructor TObjectTag.Create(Name: AnsiString);
begin
  FName := Name;
end;

function TObjectTag.get_length: _ulong;
begin
  result := Length(FName);
end;

function TObjectTag.get_bytes: AnsiString;
begin
  result := FName;
end;

function TObjectTag.equals(const val: AnsiString): Boolean;
begin
  result := val = FName;
end;

{ TORBAsyncCallback }

{$IFDEF HAVE_THREADS}
constructor TORBAsyncCallback.Create;
begin
  inherited;
  FNotified := false;
  FCondMutex := TRecursiveMutex.Create;
  FCond := TCondVar.Create();
end;

destructor TORBAsyncCallback.Destroy;
begin
  FreeAndNil(FCond);
  FreeAndNil(FCondMutex);
  inherited;
end;

procedure TORBAsyncCallback.notify(const orb: IORB; mid: ORBMessageID;
  event: TORBCallbackEvent);
begin
  FCondMutex.lock();
  try
    FNotified := true;
    FCond.broadcast();
  finally
    FCondMutex.unlock();
  end; { try/finally }
end;

function TORBAsyncCallback.waitfor(const orb: IORB; mid: ORBMessageID;
  event: TORBCallbackEvent; tmout: Integer): boolean;
begin
  FCondMutex.lock();
  try
    if FNotified then begin
      result := true;
      Exit;
    end;
    try
      if tmout <> -1 then
        FCond.wait(FCondMutex, tmout)
      else
        FCond.wait(FCondMutex);
      result := FNotified;
    except
      on E: EInterruptedException do
        result := false;
    end; { try/except }
  finally
    FCondMutex.unlock();
  end; { try/finally }
end;
{$ENDIF}

{ TPrincipalCurrent }

class function TPrincipalCurrent._narrow(
  const obj: IORBObject): IPrincipalCurrent;
var
  p: Pointer;
begin
  if obj = nil then exit;
  p := obj.narrow_helper('IDL:omg.org/PrincipalCurrent:1.0');
  if p <> nil then
    result := IPrincipalCurrent(p);
end;

{ TPrincipalCurrent_impl }

function TPrincipalCurrent_impl.get_principal: IPrincipal;
var
  rec: IORBInvokeRecord;
begin
  rec := ORB_Instance.get_current_invoke_rec();
  if rec <> nil then
    result := rec.get_principal();
end;

function TPrincipalCurrent_impl.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/PrincipalCurrent:1.0' then
    begin
      result := Pointer(self as IPrincipalCurrent);
      exit;
    end;
  result := inherited narrow_helper(repoid);
end;

{ TProperties }

const
  cPropertyPrefix = 'mtdorb';

constructor TProperties.Create; {$ifdef fpc}overload;{$endif}
begin
  FProps := TStringList.Create;
end;

constructor TProperties.Create(props: TStrings); {$ifdef fpc}overload;{$endif}
var
  i: integer;
  str: string;

  procedure SetProperty(const AProp: string; var idx: integer);
  begin
    Inc(idx);
    if idx >= props.Count then Exit;
    set_property(cPropertyPrefix + AProp, props.Strings[idx]);
  end;

begin
  FProps := TStringList.Create;
  LoadDefaultProperties();
  if props = nil then Exit;
  i := 0;
  while i < props.Count do begin
    str := props.Strings[i];
    if str = '-ORBProperty' then begin
      if i + 1 < props.Count then
        FProps.Add(props.Strings[i + 1]);
      Inc(i);
    end
    else if str = '-ORBConnectionsLimit' then
      SetProperty('.orb.connections_limit', i)
    else if str = '-ORBRequestsLimit' then
      SetProperty('.orb.requests_limit', i)
    else if str = '-ORBThreadPoolTimeout' then
      SetProperty('.orb.thread_pool_timeout', i)
    else if str = '-ORBConcModel' then
      SetProperty('.orb.conc_model', i)
    else if str = '-POAImplName' then
      SetProperty('.orb.poa.implname', i)
    else if str = '-POARemoteIOR' then
      SetProperty('.orb.poa.remote_ior', i)
    else if str = '-POARemoteAddr' then
      SetProperty('.orb.poa.remote_addr', i);
    Inc(i);
  end; { while }
  if FProps.Values[cPropertyPrefix + '.orb.security.support_ssl'] = '' then
    set_property(cPropertyPrefix + '.orb.security.support_ssl', 'off');
end;

destructor TProperties.Destroy;
begin
  FreeAndNil(FProps);
  inherited;
end;

function TProperties.get_Property(const key: string): string;
begin
  result := FProps.Values[key]
end;

procedure TProperties.set_Property(const key, value: string);
begin
  FProps.Values[key] := value;
end;

procedure TProperties.LoadDefaultProperties;
begin
  //Not implemented
end;

{ TResourceManager }

{$IFDEF HAVE_THREADS}
function TResourceManager.acquire_connection: boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  if FConnectionLimit > 0 then begin
    if FConnectionCount < FConnectionLimit then begin
      FConnectionCount := Succ(FConnectionCount);
      result := true;
    end
    else
      result := false;
  end
  else begin
    // connection checking disabled by -ORBConnLimit 0
    FConnectionCount := Succ(FConnectionCount);
    result := true;
  end;
end;

procedure TResourceManager.connection_limit(value: integer);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  FConnectionLimit := value;
end;

function TResourceManager.connection_limit: _ulong;
begin
  result := FConnectionLimit;
end;

constructor TResourceManager.Create(ConnectionLimit, RequestLimit,
  ConnectionCount: _ulong);
begin
  inherited Create;
  FMutex := TMutex.Create;
  FConnectionLimit := ConnectionLimit;
  FRequestLimit := RequestLimit;
  FConnectionCount := ConnectionCount;
end;

destructor TResourceManager.Destroy;
begin
  FreeAndNil(FMutex);
  inherited;
end;

procedure TResourceManager.release_connection;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  FConnectionCount := Pred(FConnectionCount);
end;

procedure TResourceManager.request_limit(value: integer);
begin
  FRequestLimit := value;
end;

function TResourceManager.request_limit: _ulong;
begin
  result := FRequestLimit;
end;
{$ENDIF}

{$IFDEF LIBRARY}
exports
  ORB_Init,
  ORB_Instance;
{$ENDIF}
initialization
finalization
{$IFNDEF USELIB}
  ORBInstance := nil;
{$ENDIF}
end.
