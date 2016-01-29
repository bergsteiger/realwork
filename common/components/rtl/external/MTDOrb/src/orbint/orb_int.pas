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
unit orb_int;

interface

{$I dorb.inc}

uses
  orbtypes,SysUtils,Classes,{$IFDEF WIN32}winsock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF},
  comp_int,addr_int,disp_int,iior_int,req_int,env_int,value_int, code_int,ir_int;

type

  IORB = interface;
  IORBObject = interface;
  IObjectAdaptor = interface;
  IObjectTag = interface;
  IRequest = interface;
  IPolicy = interface;
  IDomainManager = interface;
  IORBInvokeRecord = interface;
  ORBMessageID = IORBInvokeRecord;

  DomainManagersList = array of IDomainManager;
  PolicyList = array of IPolicy;
  
  IORBCallBack = interface
  ['{61252F41-4D23-11d4-9D27-204C4F4F5020}']
    function waitfor(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent; tmout: long = -1): boolean;
    procedure notify(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent);
    //procedure callback(const orb: IORB; mid: MessageID; event: TORBCallbackEvent);
  end;

  IRequestCallback = interface
  ['{40A4D5A1-059C-4c79-8071-1A2A5619FFCE}']
    procedure callback(const req: IRequest);
  end;

  IORBasyncCallBack = interface(IORBCallBack)
  ['{1BB8EDEC-CE37-4708-9253-4EE844C19A22}']
  end;

  IRequest = interface(IORBCallback)
  ['{61252F42-4D23-11d4-9D27-204C4F4F5020}']
    function add_in_arg(const name: AnsiString): IAny;
    function add_inout_arg(const name: AnsiString): IAny;
    function add_out_arg(const name: AnsiString): IAny;
    procedure decode_user_exception();
    function get_arguments(): INVList;
    function get_environment(): IEnvironment;
    function get_exceptions(): IInterfaceList;
    function get_context(): IContext;
    function get_contexts(): IContextList;
    procedure get_response(block: Boolean = true);
    function get_result(): TNamedValue;
    function get_target(): IORBObject;
    procedure invoke();
    function operation(): AnsiString;
    function poll_response(): Boolean;
    function return_value: IAny;
    procedure send_oneway();
    procedure send_deferred(const cb: IRequestCallBack = nil);
    procedure set_context(const ctx: IContext);
    procedure set_result(const any: IStaticAny);
    procedure set_return_type(const tc: ITypeCode);
  end;

  RequestSeq = array of IRequest;

  IORBInvokeRecord = interface
  ['{61252F43-4D23-11d4-9D27-204C4F4F5020}']
    function callback(): IORBCallBack;
    function request_type: TRequestType;
    function id: MessageID;
    function completed(): Boolean;
    procedure _oa(oa: IObjectAdaptor);
    function get_answer_invoke(out state: TInvokeStatus; out obj: IORBObject; out req: IORBRequest; out ad: AddressingDisposition): Boolean;
    function get_answer_bind(out state: TLocateStatus; out obj: IORBObject): Boolean;
    function get_answer_locate(out state: TLocateStatus; out obj: IORBObject; out ad: AddressingDisposition): Boolean;
    function get_oa(): IObjectAdaptor;
    procedure set_answer_invoke(const state: TInvokeStatus; const obj: IORBObject; const req: IORBRequest; const ad: AddressingDisposition);
    procedure set_answer_bind(const state: TLocateStatus; const obj: IORBObject);
    procedure set_answer_locate(const state: TLocateStatus; const obj: IORBObject; ad: AddressingDisposition);
    procedure init_invoke(const orb: IORB; const obj: IORBObject; const pr: IPrincipal; const req: IORBRequest; resp: Boolean; const cb: IORBCallBack; const oa: IObjectAdaptor = nil);
    procedure init_bind(const orb: IORB; const repoid: RepositoryId; const tag: IObjectTag; const addr: IAddress; const cb: IORBCallBack; const oa: IObjectAdaptor);
    procedure init_locate(const orb: IORB; const obj: IORBObject; const cb: IORBCallBack; const oa: IObjectAdaptor);
    procedure clean();
    function active(): boolean;
    function responce(): boolean;
    procedure deactivate();
    procedure set_request_hint(hint: Pointer);
    procedure set_invoke_hint(hint: Pointer);
    function get_request_hint(): Pointer;
    function get_invoke_hint(): Pointer;
    function get_principal(): IPrincipal;
    procedure redo();
    procedure set_locationforward_perm(perm: boolean);
    function get_locationforward_perm(): boolean;
    function request_info: IInterface;
  end;

  IORBObject = interface(IUnknown)
  ['{61252F45-4D23-11d4-9D27-204C4F4F5020}']
    function get_interface(): IInterfaceDef;
    //function is_nil: Boolean;
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
    function narrow_helper(const repoid: RepositoryId): Pointer;
    function is_forwarded(): Boolean;
    function _is_a_remote(const repoid: RepositoryId): Boolean;
    procedure _unforward();
    procedure _forward(const obj: IORBObject);
    function _repoid(): RepositoryID;
    function _request(const operation: AnsiString): IRequest;
    function _policies(): PolicyList;
    function _managers(): DomainManagersList;
  end;


  ICORBA_Current = interface(IORBObject)
  ['{61252F46-4D23-11d4-9D27-204C4F4F5020}']
  end;

  IPrincipalCurrent = interface(ICORBA_Current)
  ['{4C0AB644-69FA-4032-96F7-790BD50E775A}']
    function get_principal(): IPrincipal;
  end;

  IObjectAdaptor = interface(IORBObject)
  ['{61252F47-4D23-11d4-9D27-204C4F4F5020}']
    procedure answer_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
    function bind(mid: ORBMessageID; const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress): Boolean;
    function get_oaid(): ObjectID;
    function has_object(const obj: IORBObject): Boolean;
    function invoke(mid: ORBMessageID;const obj : IORBObject; const req : IORBRequest;const pr: IPrincipal; response_exp: Boolean): Boolean;  stdcall;
    function is_local: Boolean;
    function skeleton(const obj: IORBObject): IORBObject;
    procedure shutdown(WaitForCompletion: Boolean);
    procedure cancel(id: ORBMessageID);
    function locate(mid: ORBMessageID; const obj : IORBObject): Boolean;
  end;

  IObjectTag = interface
  ['{61252F48-4D23-11d4-9D27-204C4F4F5020}']
    function get_length: _ulong;
    function get_bytes: AnsiString;
    function equals(const val: AnsiString): Boolean;
  end;

  IProperties = interface
  ['{182533CA-33B4-4F04-9898-58B878B8EBDF}']
    procedure set_Property(const key, value: string);
    function get_Property(const key: string): string;
    //procedure load(props: TStrings);
  end;

{$IFDEF HAVE_THREADS}
  IResourceManager = interface
  ['{41709E6D-128A-493B-81BD-435772FCCE72}']
    procedure release_connection();
    function acquire_connection(): boolean;
    procedure connection_limit(value: integer); overload;
    procedure request_limit(value: integer); overload;
    function connection_limit: _ulong; overload;
    function request_limit: _ulong; overload;
  end;
{$ENDIF}

  IORB = interface(IORBObject)
  ['{61252F49-4D23-11d4-9D27-204C4F4F5020}']
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
    procedure _destroy();
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
    procedure answer_bind(id: ORBMessageID; stat: TLocateStatus; obj: IORBObject);
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
    function get_invoke_reply(id: ORBMessageID; out obj: IORBObject; out req: IORBRequest; out ad: AddressingDisposition): TInvokeStatus;
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
    function _get_interface(const obj: IORBObject): IInterfaceDef;
    function create_named_value: TNamedValue;
    procedure TurnOnBiDirGIOP();
    function UseBiDirGIOP(): Boolean;

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
    function get_msgid(rec: ORBMessageId): MessageID;
    function get_orbid(msgid: MessageId): ORBMessageID;
    function get_invoke_hint(id: ORBMessageId): Pointer;
    procedure set_invoke_hint(id: ORBMessageId; hint: Pointer);
    procedure set_request_hint(id: ORBMessageId; hint: Pointer);
    function get_request_hint(id: ORBMessageId): Pointer;
    function new_orbid(msgid: MessageId = 0): ORBMessageId;
    function get_current_invoke_rec(): IORBInvokeRecord;
    procedure set_Properties(const props: IProperties);
    function get_Properties(): IProperties;
    function is_a(const obj: IORBObject; const repo_id: RepositoryId): Boolean;
  end;

  IPolicy = interface(IORBObject)
  ['{AF662CD0-4D2E-11d4-9D27-204C4F4F5020}']
    function copy: IPolicy;
    procedure _destroy;
    function _get_policy_type: PolicyType;
    property policy_type: PolicyType read _get_policy_type;
  end;

  IDomainManager = interface(IORBObject)
  ['{AF662CD1-4D2E-11d4-9D27-204C4F4F5020}']
    function get_domain_policy(const policy_type: PolicyType ): IPolicy;
    procedure set_domain_policy(const policy : IPolicy );
    function copy(): IDomainManager;
  end;

  IAbstractBase = interface
  ['{345BA578-87FF-4039-A685-83011223A504}']
    function _to_object: IORBObject;
    function _to_value: IValueBase;
    function narrow_helper(const repoid: RepositoryId): Pointer;
  end;

  ObjSeq = array of IORBObject;
  IObj_seq = ObjSeq;

implementation

end.
