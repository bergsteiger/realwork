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
unit poa_int;

interface

{$I dorb.inc}

uses
  orb_int,orbtypes,req_int,env_int,iior_int,policy_int,code_int,ir_int,osthread;

const
  THREAD_POLICY_ID  = 16;
  LIFESPAN_POLICY_ID   = 17;
  ID_UNIQUENESS_POLICY_ID   = 18;
  ID_ASSIGNMENT_POLICY_ID   = 19;
  IMPLICIT_ACTIVATION_POLICY_ID   = 20;
  SERVANT_RETENTION_POLICY_ID   = 21;
  REQUEST_PROCESSING_POLICY_ID   = 22;

type
  IPOA = interface;
  IPOAObjectReference = interface;
  IServant = interface;

  POAManagerState = (HOLDING,ACTIVE,DISCARDING,INACTIVE);

  TPOADestroyState = (psDestroyNotCalled, psDestroyPending, psDestroyInProgress, psDestroyCompleted);

  POAList = array of IPOA;

  IPOAManager = interface
  ['{AF662CC6-4D2E-11d4-9D27-204C4F4F5020}']
    procedure activate();
    procedure hold_requests(wait_for_completion: Boolean);
    procedure discard_requests(wait_for_completion: Boolean);
    procedure deactivate(etherealize_objectes,wait_for_completion: Boolean);
    function get_state(): POAManagerState;
    // DORB extension
    procedure add_managed_poa(const val: IPOA);
    procedure del_managed_poa(const val: IPOA);
  end;

  IAdapterActivator = interface
  ['{54D5BA67-6B76-11d4-9D3E-204C4F4F5020}']
    function unknown_adapter(parent: IPOA; name: AnsiString): Boolean;
  end;

  {** Base interface for servant managers }
  IServantManager = interface(IORBObject)
  ['{54D5BA68-6B76-11d4-9D3E-204C4F4F5020}']
  end;

  IServantActivator = interface(IServantManager)
  ['{54D5BA69-6B76-11d4-9D3E-204C4F4F5020}']
    function incarnate(oid: ObjectID; adapter: IPOA): IServant;
    procedure etherealize(oid: ObjectID; adapter: IPOA; serv: IServant;
      cleanup_in_progress: Boolean; remaining_activations: Boolean);
  end;

  IServantLocator = interface(IServantManager)
  ['{54D5BA6A-6B76-11d4-9D3E-204C4F4F5020}']
    function preinvoke(oid: ObjectID; adapter: IPOA; operation : Identifier;
      the_cookie: Cookie): IServant;
    procedure postinvoke(oid: ObjectID; adapter: IPOA; operation : Identifier;
      the_cookie: Cookie; servant: IServant);
  end;

  IInvocationRecord = interface
  ['{AF662CC3-4D2E-11d4-9D27-204C4F4F5020}']
    function make_dyn_req(const poa: IPOA): IServerRequest;
    function make_req(const poa: IPOA; const servant: IServant): IServerRequestBase;
    function get_por: IPOAObjectReference;
    function get_orequest: IORBRequest;
    function id(): ORBMessageID;
    procedure exec(const poa : IPOA);
  end;

  IPOACurrent = interface(ICORBA_Current)
  ['{AF662CC4-4D2E-11d4-9D27-204C4F4F5020}']
    function get_POA: IPOA;
    function get_object_id: ObjectID;
    // DORB extention
    //function inupcall(): boolean;
    function iscurrent: Boolean;
    function get_serv: IServant;
    function make_ref(): IORBObject;
    procedure _set(const p: IPOA; const por: IPOAObjectReference; const servant: IServant);
    procedure unset;
  end;

  IPOACurrentState = interface
  ['{AF662CC5-4D2E-11d4-9D27-204C4F4F5020}']
    function poa: IPOA;
    function por: IPOAObjectReference;
    function servant : IServant;
  end;

  IServant = interface
  ['{AF662CC8-4D2E-11d4-9D27-204C4F4F5020}']
    procedure activated_in(const poa : IPOA);
    procedure doinvoke(const srv: IServerRequestBase);
    //procedure invoke(const srv: IStaticServerRequest);
    function _is_a(const repoid: RepositoryId): Boolean;
    function _get_interface(): IInterfaceDef;
    function _non_existent(): Boolean;
    function _make_stub(const poa: IPOA; const obj : IORBObject): IORBObject;
    function make_request(const req: IORBRequest; const obj : IORBObject;
      id: ORBMessageID; const p: IObjectAdaptor; const pr: IPrincipal): IServerRequestBase;
    function _primary_interface(const objid: ObjectID; const poa: IPOA): RepositoryId;
    function narrow_helper(const repoid: RepositoryID): Pointer;
  end;

  IPOAStub = interface(IORBObject)
  ['{AF662CC9-4D2E-11d4-9D27-204C4F4F5020}']
    function _preinvoke(): IServant;
    procedure _postinvoke();
  end;

  IPOAObjectReference = interface
  ['{AF662CCA-4D2E-11d4-9D27-204C4F4F5020}']
    function id(): ObjectID;
    function ref(): IORBObject;
    function is_legal(): Boolean;
    function iddirty : Boolean;
    function in_poa(const pname: ObjectId): Boolean;
    function in_descendant_poa(const fqn, implname: PAnsiChar): Boolean;
    function next_descendant_poa(const fqn, implname: PAnsiChar): PAnsiChar;
    function obj: IORBObject;
    function poa: IPOA;
    function poa_name(): AnsiString;
    function repoid: RepositoryID;
    function servant: IServant;
    procedure set_ref(const obj: IORBObject);
    procedure _destroy();
  end;

  IDeletionRecord = interface(IInterface)
  ['{9826F70F-D4D4-4625-9041-BE8CF580FC17}']
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
    function GetSignal: Short;
    procedure SetSignal(const Value: Short);

    function Condition: TCondVar;
    property Count: Integer read GetCount write SetCount;
    property Signal: Short read GetSignal write SetSignal;
  end;

  IPOAObjectRecord = interface
  ['{AF662CCB-4D2E-11d4-9D27-204C4F4F5020}']
    function GetActive(): boolean;
    procedure SetActive(value: boolean);
    function GetInvokeCnt(): Longint;
    procedure SetInvokeCnt(value: Longint);
{$IFDEF HAVE_THREADS}
    function GetDelRef(): IDeletionRecord;
    procedure SetDelRef(Value: IDeletionRecord);
{$ENDIF}
    function serv(): IServant;
    function por(): IPOAObjectReference;
    procedure _destroy();
    property active: boolean read GetActive write SetActive;
    property invoke_cnt: Longint read GetInvokeCnt write SetInvokeCnt;
{$IFDEF HAVE_THREADS}
    property delref: IDeletionRecord read GetDelRef write SetDelRef;
{$ENDIF}
  end;

  IPOAStaticImplementation = interface(IServant)
  ['{AF662CCC-4D2E-11d4-9D27-204C4F4F5020}']
    //procedure doinvoke(const req: IServerRequestBase; const env: IEnvironment);
    procedure doinvoke(const req: IServerRequestBase);
    //procedure invoke(const req: IStaticServerRequest; const env: IEnvironment);
    procedure invoke(const req: IStaticServerRequest);
  end;

  IPOADynamicImplementation = interface(IServant)
  ['{79BD59B9-C3FC-49DC-BEFE-B1FEB92EBF2E}']
  end;

  IObjectMap = interface
  ['{27368271-E25B-11d3-9E70-00C0DFF797C8}']
    function exists(const serv: IServant): Boolean; overload;
    function exists(objid: ObjectID): Boolean; overload;
    function add(const por: IPOAObjectReference; const serv: IServant): IPOAObjectRecord;
    function find(const por: IPOAObjectReference) : IPOAObjectRecord; overload;
    function find(objid: ObjectID) : IPOAObjectRecord; overload;
    function find(serv: IServant) : IPOAObjectRecord; overload;
    function find(const p: IPOA; const obj : IORBObject) : IPOAObjectRecord; overload;
    function del(objid: ObjectID): IPOAObjectRecord;
    function count: integer;
    function item(index: integer): IPOAObjectRecord;
    function pop(): IPOAObjectRecord;
  end;

  IPOA = interface(IObjectAdaptor)
  ['{AF662CCD-4D2E-11d4-9D27-204C4F4F5020}']
    function create_POA(adapter_name: AnsiString; a_POAManager: IPOAManager; policies: PolicyList): IPOA;
    function find_POA(adapter_name: AnsiString; activate_it: Boolean): IPOA;
    procedure _destroy(etherealize_objects: Boolean; wait_for_completion: Boolean);

    // factories for policies
    function create_thread_policy(value: ThreadPolicyValue): IThreadPolicy;
    function create_lifespan_policy(value: LifespanPolicyValue): ILifespanPolicy;
    function create_id_assignment_policy(value: IdAssignmentPolicyValue): IIdAssignmentPolicy;
    function create_id_uniqueness_policy(value: IdUniquenessPolicyValue): IIdUniquenessPolicy;
    function create_implicit_activation_policy(value: ImplicitActivationPolicyValue): IImplicitActivationPolicy;
    function create_servant_retention_policy(value: ServantRetentionPolicyValue): IServantRetentionPolicy;
    function create_request_processing_policy(value: RequestProcessingPolicyValue): IRequestProcessingPolicy;

    // Attributes
    function the_name: AnsiString;
    function the_parent: IPOA;
    function the_children: POAList;
    function the_POAManager: IPOAManager;
    function the_Activator: IAdapterActivator;
    procedure set_Activator(val: IAdapterActivator);

    // Servant Manager registration
    function get_servant_manager: IServantManager;
    procedure set_servant_manager(imgr: IServantManager);

    // operations for the USE_DEFAULT_SERVANT policy
    function get_servant: IServant;
    procedure set_servant(p_servant: IServant);

    // object activation and deactivation
    function activate_object(p_servant: IServant): ObjectID;
    function activate_for_this(p_servant: IServant): IORBObject;
    procedure activate_object_with_id(id: ObjectID; p_servant: IServant);
    procedure deactivate_object(id: ObjectID);

    // reference creation operations
    function create_reference(intf: RepositoryID): IORBObject;
    function create_reference_with_id(id: ObjectID; intf: RepositoryID): IORBObject;

    // identity mapping operations
    function servant_to_id(p_servant: IServant): ObjectID;
    function servant_to_reference(p_servant: IServant): IORBObject;
    function reference_to_servant(reference: IORBObject): IServant;
    function reference_to_id(reference: IORBObject): ObjectID;
    function id_to_servant(id: ObjectID): IServant;
    function id_to_reference(id: ObjectID): IORBObject;

    // DORB extention
    function builtin_invoke(const ir: IInvocationRecord; const servant: IServant): Boolean;
    function ior_template(): IIOR;
    procedure register_child(const cname : AnsiString; child: IPOA);
    procedure unregister_child(const cname : AnsiString);
    procedure poa_manager_callback(state: POAManagerState;etherealize_objects: Boolean; wait_for_completion: Boolean);
    procedure local_invoke(const ir: IInvocationRecord);
    function fqn: AnsiString;
    function get_oaid: ObjectID;
    function _preinvoke(const obj: IORBObject): IServant;
    procedure _postinvoke();
    function ActiveObjectMap: IObjectMap;
    function ObjectActivationLock: TRecursiveMutex;
    procedure perform_invoke(ir: IInvocationRecord);

    function _id_assignment_policy : IIdAssignmentPolicy;
    function _thread_policy : IThreadPolicy;
    function _lifespan_policy : ILifespanPolicy;
    function _id_uniqueness_policy : IIdUniquenessPolicy;
    function _implicit_activation_policy : IImplicitActivationPolicy;
    function _servant_retention_policy : IServantRetentionPolicy;
    function _request_processing_policy : IRequestProcessingPolicy;
  end;

  IUniqueIdGenerator = interface
  ['{15B85D01-E2E7-11d4-9E61-00C0DFF797C8}']
    function new_id(): ObjectID;
  end;

implementation

end.
