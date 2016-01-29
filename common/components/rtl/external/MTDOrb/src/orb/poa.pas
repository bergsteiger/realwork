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
unit poa;

interface

{$I dorb.inc}

uses
  poa_int,orb_int,orb,orbtypes,Classes,req_int,addr_int,map_int,env_int,
  iior_int,except_int,exceptions,policy_int,code_int,osthread,ir_int,imr_int;

type

  TPOAStub = class(TORBObject,IPOAStub)
  protected
    FPOA: IPOA;
  protected
    function _preinvoke(): IServant;
    procedure _postinvoke();
  public
    constructor Create(const poa: IPOA; const obj : IORBObject);
  end;

  TServantBase = class(TInterfacedObject,IServant)
  protected
    FPOA: IPOA;
    function _default_POA(): IPOA;
    function _is_a(const repoid: RepositoryId): Boolean; virtual;
    function _get_interface(): IInterfaceDef;
    function _non_existent(): Boolean;
    function this(): IORBObject;
    function _primary_interface(const objid: ObjectID; const poa: IPOA): RepositoryId; virtual; abstract;
    function _make_stub(const poa: IPOA; const obj : IORBObject): IORBObject; virtual;
    function make_request(const req: IORBRequest; const obj : IORBObject;
      id: ORBMessageID; const p: IObjectAdaptor; const pr: IPrincipal): IServerRequestBase; virtual; abstract;
    procedure activated_in(const poa : IPOA); virtual;
    //procedure invoke(const req: IStaticServerRequest); virtual; abstract;
    procedure doinvoke(const req: IServerRequestBase); virtual; abstract;
    function narrow_helper(const repoid: RepositoryID): Pointer; virtual;
  end;

  TPOAStaticImplementation = class(TServantBase,IPOAStaticImplementation)
  protected
    procedure doinvoke(const req: IServerRequestBase); override;
    procedure invoke(const req: IStaticServerRequest); virtual;
    function narrow_helper(const repoid: RepositoryID): Pointer; override;
    function make_request(const req: IORBRequest; const obj : IORBObject;
      id: ORBMessageID; const p: IObjectAdaptor; const pr: IPrincipal): IServerRequestBase; override;
  end;

  TPOADynamicImplementation = class(TServantBase,IPOADynamicImplementation)
  protected
    function _is_a(const repoid: RepositoryId): Boolean; override;
    function _get_interface(): IInterfaceDef;
    function make_request(const req: IORBRequest; const obj : IORBObject;
      id: ORBMessageID; const p: IObjectAdaptor; const pr: IPrincipal): IServerRequestBase; override;
    procedure doinvoke(const req: IServerRequestBase); override;
    procedure invoke(const req: IServerRequest); virtual;
  end;

  TServantManager = class(TORBObject,IServantManager)
  protected
    function _repoid(): RepositoryId; override;
    function narrow_helper(const str: RepositoryId): Pointer; override;
  public
    class function _narrow(const obj : IORBObject): IServantManager;
  end;

  TServantActivator = class(TServantManager,IServantActivator)
  protected
    function incarnate(oid: ObjectID; adapter: IPOA): IServant; virtual; abstract;
    procedure etherealize(oid: ObjectID; adapter: IPOA; serv: IServant;
      cleanup_in_progress: Boolean; remaining_activations: Boolean); virtual;  abstract;
    // IORBOvbject
    function _repoid(): RepositoryId; override;
    function narrow_helper(const str: RepositoryId): Pointer; override;
  public
    class function _narrow(const obj : IORBObject): IServantActivator;
  end;

  TServantLocator = class(TServantManager,IServantLocator)
  protected
    function preinvoke(oid: ObjectID; adapter: IPOA; operation : Identifier;
      the_cookie: Cookie): IServant; virtual; abstract;
    procedure postinvoke(oid: ObjectID; adapter: IPOA; operation : Identifier;
      the_cookie: Cookie; servant: IServant); virtual; abstract;
    // IORBOvbject
    function _repoid(): RepositoryId; override;
    function narrow_helper(const str: RepositoryId): Pointer; override;
  public
    class function _narrow(const obj : IORBObject): IServantLocator;
  end;

{$IFNDEF USELIB}

  TInvocationRecord = class(TInterfacedObject,IInvocationRecord)
  private
    FORBid: ORBMessageID;
    FPor: IPOAObjectReference;
    FReq: IORBRequest;
    FSrb : IServerRequestBase;
    FPrincipal : IPrincipal;
  protected
    function make_dyn_req(const poa: IPOA): IServerRequest;
    function get_por: IPOAObjectReference;
    function get_orequest: IORBRequest;
    function make_req(const poa: IPOA; const servant: IServant): IServerRequestBase;
    function id(): ORBMessageID;
    procedure exec(const poa : IPOA);
  public
    constructor Create(id: ORBMessageID; por: IPOAObjectReference; req: IORBRequest;pr : IPrincipal);
  end;

  TObjectMap = class(TInterfacedObject, IObjectMap)
  private
    FRecords : TStringList;
    FServants : IInterfaceInterfaceMap;
    procedure del_servant(const por: IPOAObjectRecord);
  protected
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
  public
    constructor Create();
    destructor Destroy(); override;
  end;

  TPOAObjectRecord = class(TInterfacedObject,IPOAObjectRecord)
  private
    FPor: IPOAObjectReference;
    FServ: IServant;
    FActive: boolean;
    FInvokeCnt: Longint;
    FDelRef: IDeletionRecord;
  protected
    function GetActive(): boolean;
    procedure SetActive(value: boolean);
    function GetInvokeCnt(): Longint;
    procedure SetInvokeCnt(value: Longint);
{$IFDEF HAVE_THREADS}
    function GetDelRef(): IDeletionRecord;
    procedure SetDelRef(value: IDeletionRecord);
{$ENDIF}
    function serv(): IServant;
    function por(): IPOAObjectReference;
    procedure _destroy();
  public
    constructor Create(const por: IPOAObjectReference; const serv: IServant);
    destructor Destroy; override;
  end;

  TUniqueIdGenerator = class(TInterfacedObject,IUniqueIdGenerator)
  private
    FPrefix: string;
    FCurrent: _ulong;
    FMutex: TMutex;
  public
    constructor Create(prefix: string);
    destructor Destroy; override;
    function new_id(): ObjectID;
  end;

  TPOAObjectReference = class(TInterfacedObject,IPOAObjectReference)
  private
    FPOA : IPOA;
    FObjid: ObjectID;
    FPOAName : AnsiString;
    FRepoid: RepositoryID;
    FServant : IServant;
    FObject : IORBObject;
    FIddirty : Boolean;
    FRefLock: TMutex;
  protected
    procedure make_ref();
    function id(): ObjectID;
    function ref(): IORBObject;
    function is_legal(): Boolean;
    function iddirty : Boolean;
    function obj: IORBObject;
    function poa: IPOA;
    function poa_name(): AnsiString;
    function repoid: RepositoryId;
    function servant: IServant;
    function decompose_ref(): Boolean;
    function in_poa(const pname: ObjectId): Boolean;
    function in_descendant_poa(const fqn, implname: PAnsiChar): Boolean;
    function next_descendant_poa(const fqn, implname: PAnsiChar): PAnsiChar;
    procedure set_ref(const obj: IORBObject);
    procedure _destroy();
  public
    constructor Create(const por: IPOAObjectReference); overload;
    constructor Create(const poa: IPOA; const objid : ObjectID; const repoid: RepositoryID; const serv: IServant=nil); overload;
    constructor Create(const poa: IPOA; const obj : IORBObject); overload;
    destructor Destroy; override;
  end;

  {**  Manages one or more POA objects}
  TPOAManager = class(TORBObject,IPOAManager)
  private
    FManaged: IInterfaceList;
    FState : POAManagerState;
    FManagedLock: TRecursiveMutex;
  protected
    procedure activate();
    procedure hold_requests(wait_for_completion: Boolean);
    procedure discard_requests(wait_for_completion: Boolean);
    procedure deactivate(etherealize_objectes,wait_for_completion: Boolean);
    function get_state(): POAManagerState;
    // DORB extension
    procedure add_managed_poa(const val: IPOA);
    procedure del_managed_poa(const val: IPOA);
    procedure change_state(state: POAManagerState;etherealize_objects: Boolean; wait_for_completion: Boolean);
  public
    constructor Create();
    destructor Destroy; override;
  end;

  {TPOAMediator = class(TORBObject,IPOAMediator)

  end;}

  TPOACurrentState = class(TInterfacedObject,IPOACurrentState)
  private
    FPoa: IPOA;
    FPor: IPOAObjectReference;
    FServant: IServant;
  protected
    function poa: IPOA;
    function por: IPOAObjectReference;
    function servant : IServant;
  public
    constructor Create(const poa: IPOA;const por: IPOAObjectReference;const servant : IServant);
  end;

{$IFDEF HAVE_THREADS}
  TDeletionRecord = class(TInterfacedObject, IDeletionRecord)
  private
    FCount: Integer;
    FSignal: Short;
    FCondition: TCondVar;
  protected
    { IDeletionRecord }
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
    function GetSignal: Short;
    procedure SetSignal(const Value: Short);
    function Condition: TCondVar;
  public
    constructor Create;
    destructor Destroy; override;
  end;
{$ENDIF}

  TPOACurrent = class(TORBObject,IPOACurrent)
  private
{$IFNDEF HAVE_THREADS}
    FCurrentStateStack : IInterfaceList;
{$ENDIF}
    FCurrentKey: TThreadKey;
  protected
    function get_POA: IPOA;
    function get_object_id: ObjectID;
    // DORB extention
    procedure _set(const p: IPOA; const por: IPOAObjectReference; const servant: IServant);
    procedure unset;
    //function inupcall(): boolean;
    function iscurrent(): Boolean;
    function get_serv: IServant;
    function make_ref(): IORBObject;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function getCurrent(): IInterfaceList;
    procedure setCurrent(cur: IInterfaceList);
  public
    constructor Create(orb: IORB);
    destructor Destroy(); override;
    class function _narrow(const obj : IORBObject): IPOACurrent;
  end;

  {TServantManager = class(TORBObject,IServantManager)
  protected
    function repoid(): string; override;
    function narrow_helper(const str: string): Pointer; override;
  public
    class function _narrow(const obj : IORBObject): IServantManager;
  end;

  TServantActivator = class(TServantManager,IServantActivator)
  protected
    function incarnate(oid: ObjectID; adapter: IPOA): IServant; virtual; abstract;
    procedure etherealize(oid: ObjectID; adapter: IPOA; serv: IServant;
      cleanup_in_progress: Boolean; remaining_activations: Boolean); virtual;  abstract;
    // IORBOvbject
    function repoid(): string; override;
    function narrow_helper(const str: string): Pointer; override;
  public
    class function _narrow(const obj : IORBObject): IServantActivator;
  end;

  TServantLocator = class(TServantManager,IServantLocator)
  protected
    function preinvoke(oid: ObjectID; adapter: IPOA; operation : Identifier;
      the_cookie: Cookie): IServant; virtual; abstract;
    procedure postinvoke(oid: ObjectID; adapter: IPOA; operation : Identifier;
      the_cookie: Cookie; servant: IServant); virtual; abstract;
    // IORBOvbject
    function repoid(): string; override;
    function narrow_helper(const str: string): Pointer; override;
  public
    class function _narrow(const obj : IORBObject): IServantLocator;
  end;}

  function the_root_poa : IPOA;
  function POA_Current : IPOACurrent;
  function POACurrent_narrow(const obj : IORBObject): IPOACurrent;
  function UniqueIDGenerator(const prefix: string): IUniqueIDGenerator;
  function String_to_ObjectId(const s: AnsiString): ObjectID;
  function ObjectId_to_string(const id: ObjectID): AnsiString;

var
  POACurrent : IPOACurrent;
  _the_root_poa: IPOA;
  poa_impl_name: AnsiString;

{$ELSE}
  function POACurrent_narrow(const obj : IORBObject): IPOACurrent; external MTDORB_Library_Name;
  function the_root_poa : IPOA; external MTDORB_Library_Name;
  function POA_Current : IPOACurrent; external MTDORB_Library_Name;
  function UniqueIDGenerator(const prefix: string): IUniqueIDGenerator; external MTDORB_Library_Name;
  function String_to_ObjectId(const s: string): ObjectID; external MTDORB_Library_Name;
  function ObjectId_to_string(const id: ObjectID): string; external MTDORB_Library_Name;
{$ENDIF}

implementation

uses
  address,{$IFDEF WIN32}windows,{$ENDIF}SysUtils,map,throw,ior,req,static,
  poa_except,utils,policy,poa_impl,ir;

//****************************************************************
// TPOAStub
//****************************************************************
constructor TPOAStub.Create(const poa: IPOA; const obj: IORBObject);
begin
  FPOA := poa;
  if assigned(obj._ior) then
    FIOR := CreateIOR_ior(obj._ior);
  if assigned(obj.fwd_ior) then
    FFWD_IOR := CreateIOR_ior(obj.fwd_ior);
  FORB := obj._orb;
end;

procedure TPOAStub._postinvoke;
begin
  if FPOA <> nil then FPOA._postinvoke();
end;

function TPOAStub._preinvoke: IServant;
begin
  result := nil;
  if FPOA = nil then exit;
  result := FPOA._preinvoke(self);
  if result = nil then FPOA := nil;
end;

//*********************************************************************
//  TServantBase
//*********************************************************************
function TServantBase._default_POA: IPOA;
var
  orb: IORB;
  obj : IORBObject;
begin
  if the_root_poa <> nil then
    result := the_root_poa
  else
    begin
      orb := ORB_Instance;
      obj := orb.resolve_initial_reference('RootPOA');
      result := POA_narrow(obj);
    end;
end;

function TServantBase._is_a(const repoid: RepositoryId): Boolean;
begin
  result := false;
end;

function TServantBase._get_interface(): IInterfaceDef;
begin
  result := nil;
  assert(false,'must be implemented in descendant class');
end;

function TServantBase._non_existent(): Boolean;
begin
  result := false;
end;

function TServantBase._make_stub(const poa: IPOA;
  const obj: IORBObject): IORBObject;
begin
  result := nil;
  assert(false,'must be implemented in descendant class');
end;

function TServantBase.this: IORBObject;
var
  p : IPOA;
begin
  if (POA_Current <> nil) and (POA_Current.iscurrent) and
    (POA_Current.get_serv = (self as IServant)) then
    begin
      result := POA_Current.make_ref;
      exit;
    end;
  if FPOA <> nil then
    p := FPOA
  else
    p := _default_POA;
  result := p.activate_for_this(self);
end;

procedure TServantBase.activated_in(const poa: IPOA);
begin
  FPOA := poa;
end;

function TServantBase.narrow_helper(const repoid: RepositoryID): Pointer;
begin
  result := nil;
end;

//*********************************************************************
//  TPOAStaticImplementation
//*********************************************************************
function TPOAStaticImplementation.make_request(const req: IORBRequest; const obj : IORBObject;
  id: ORBMessageID; const p: IObjectAdaptor; const pr: IPrincipal): IServerRequestBase;
begin
  result := StaticServerRequest(req,obj,id,p,pr);
end;

procedure TPOAStaticImplementation.doinvoke(const req: IServerRequestBase);
begin
  try
    invoke(IStaticServerRequest(req));
  except
    on e : SystemException do
      begin
        IStaticServerRequest(req).set_exception(SystemException.Create(e) as IORBException);
        IStaticServerRequest(req).write_results();
      end;
    on e : EOutOfMemory do
      begin
        IStaticServerRequest(req).set_exception(SystemException.Create_type(st_NO_MEMORY) as IORBException);
        IStaticServerRequest(req).write_results();
      end;
{$IFNDEF VER130}
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
    on e : EStackOverflow do
{$IFNDEF VER130}
{$WARN SYMBOL_DEPRECATED ON}
{$ENDIF}
      begin
        IStaticServerRequest(req).set_exception(SystemException.Create_type(st_NO_RESOURCES) as IORBException);
        IStaticServerRequest(req).write_results();
      end;
    else
      begin
        IStaticServerRequest(req).set_exception(SystemException.Create_type(st_UNKNOWN,0,COMPLETED_NO) as IORBException);
        IStaticServerRequest(req).write_results();
      end;
  end;
end;

procedure TPOAStaticImplementation.invoke(const req: IStaticServerRequest);
begin
  assert(false, 'must be implemented in descendant class');
end;

function TPOAStaticImplementation.narrow_helper(const repoid: RepositoryID): Pointer;
begin
  result := nil;
end;

//*********************************************************************
// TPOADynamicImplementation }
//*********************************************************************
function TPOADynamicImplementation._get_interface: IInterfaceDef;
var
  oid: ObjectId;
  poa: IPOA;
  obj, irobj: IORBObject;
  pif: AnsiString;
  orb: IORB;
  ifr: IRepository;
  cv: IContained;
begin
  (*
   * To call _primary_interface, we need a POA and an ObjectId.
   * If called within the context of a method invocation, we use
   * the "Current" information. Else, we activate the Servant.
   *)

  if (POA_Current <> nil) and
     POA_Current.iscurrent() and
     (POA_Current.get_serv() = (Self as IServant)) then begin
    poa := POA_Current.get_POA();
    oid := POA_Current.get_object_id();
  end
  else begin
    if (FPOA <> nil) then
      poa := FPOA
    else
      poa := _default_POA();
    obj := poa.activate_for_this(Self);
    oid := poa.reference_to_id(obj);
  end;

  pif := _primary_interface(oid, poa);

  (*
   * Access IR
   *)

  orb := ORB_instance();
  irobj := orb.resolve_initial_reference('InterfaceRepository');
  ifr := TRepository._narrow(irobj);
  if ifr = nil then
    dorb_throw(OBJ_ADAPTER.Create(0, COMPLETED_NO));

  cv := ifr.locate_id(pif);
  result := TInterfaceDef._narrow(cv as IORBObject);

  if result = nil then
    dorb_throw(OBJ_ADAPTER.Create(0, COMPLETED_NO));
end;

function TPOADynamicImplementation._is_a(const repoid: RepositoryId): Boolean;
var
  oid: ObjectId;
  poa: IPOA;
  obj, irobj: IORBObject;
  pif: AnsiString;
  orb: IORB;
  ifr: IRepository;
  cv: IContained;
  ifd: IInterfaceDef;
begin
  (*
   * To call _primary_interface, we need a POA and an ObjectId.
   * If called within the context of a method invocation, we use
   * the "Current" information. Else, we activate the Servant.
   *)

  if (POA_Current <> nil) and
     POA_Current.iscurrent() and
     (POA_Current.get_serv() = (Self as IServant)) then begin
    poa := POA_Current.get_POA();
    oid := POA_Current.get_object_id();
  end
  else begin
    if (FPOA <> nil) then
      poa := FPOA
    else
      poa := _default_POA();
    obj := poa.activate_for_this(Self);
    oid := poa.reference_to_id(obj);
  end;

  pif := _primary_interface(oid, poa);

  if (pif = repoid) then begin
    result := true;
    Exit;
  end;

  (*
   * Access IR
   *)

  orb := ORB_Instance();
  irobj := orb.resolve_initial_reference('InterfaceRepository');
  ifr := TRepository._narrow(irobj);
  if ifr = nil then
    dorb_throw(OBJ_ADAPTER.Create(0, COMPLETED_NO));

  cv := ifr.locate_id(pif);
  ifd := TInterfaceDef._narrow(cv as IORBObject);

  if ifd = nil then
    dorb_throw(OBJ_ADAPTER.Create(0, COMPLETED_NO));

  result := (ifd as IORBObject)._is_a(repoid);
end;

procedure TPOADynamicImplementation.doinvoke(
  const req: IServerRequestBase);
begin
  invoke(req as IServerRequest);
end;

function TPOADynamicImplementation.make_request(const req: IORBRequest;
  const obj: IORBObject; id: ORBMessageID; const p: IObjectAdaptor;
  const pr: IPrincipal): IServerRequestBase;
begin
  result := ServerRequest(req,obj,id,p,pr) as IServerRequestBase;
end;

procedure TPOADynamicImplementation.invoke(const req: IServerRequest);
begin

end;

//*********************************************************************
//  TServantActivator
//*********************************************************************
class function TServantActivator._narrow(
  const obj: IORBObject): IServantActivator;
begin
  result := nil;
  if assigned(obj) then
    result := IServantActivator(obj.narrow_helper('IDL:omg.org/PortableServer/ServantActivator:1.0'));
end;

function TServantActivator.narrow_helper(const str: RepositoryId): Pointer;
begin
  if str = 'IDL:omg.org/PortableServer/ServantActivator:1.0' then
    result := Pointer(self as IServantActivator)
  else
    result := inherited narrow_helper(str)
end;

function TServantActivator._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/PortableServer/ServantActivator:1.0'
end;

//*********************************************************************
//  TServantManager
//*********************************************************************
class function TServantManager._narrow(
  const obj: IORBObject): IServantManager;
begin
  result := nil;
  if assigned(obj) then
    result := IServantManager(obj.narrow_helper('IDL:omg.org/PortableServer/ServantManager:1.0'));
end;

function TServantManager.narrow_helper(const str: RepositoryId): Pointer;
begin
  if str = 'IDL:omg.org/PortableServer/ServantManager:1.0' then
    result := Pointer(self as IServantActivator)
  else
    result := nil;
end;

function TServantManager._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/PortableServer/ServantManager:1.0'
end;

//*********************************************************************
//  TServantLocator
//*********************************************************************
class function TServantLocator._narrow(
  const obj: IORBObject): IServantLocator;
begin
  result := nil;
  if assigned(obj) then
    result := IServantLocator(obj.narrow_helper('IDL:omg.org/PortableServer/ServantLocator:1.0'));
end;

function TServantLocator.narrow_helper(const str: RepositoryId): Pointer;
begin
  if str = 'IDL:omg.org/PortableServer/ServantLocator:1.0' then
    result := Pointer(self as IServantLocator)
  else
    result := inherited narrow_helper(str)
end;

function TServantLocator._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/PortableServer/ServantLocator:1.0'
end;

{$IFNDEF USELIB}

//*********************************************************************
//  TPOACurrent
//*********************************************************************
procedure CurrentCleanup(css: Pointer);
var
  cur: IInterfaceList;
begin
  if css <> nil then begin
    cur := IInterfaceList(css);
    cur._Release;
  end;
end;

constructor TPOACurrent.Create(orb: IORB);
begin
{$IFDEF HAVE_THREADS}
  TORBThread.createKey(FCurrentKey, @CurrentCleanup);
{$ELSE}
  FCurrentStateStack := TInterfaceList.Create;
{$ENDIF}
  FORB := orb;
  orb.register_initial_reference('POACurrent',self);
end;

destructor TPOACurrent.Destroy;
{$IFDEF HAVE_THREADS}
var
  cur: IInterfaceList;
{$ENDIF}
begin
{$IFDEF HAVE_THREADS}
  cur := getCurrent();
  if cur <> nil then
    cur._Release;
  TORBThread.deleteKey(FCurrentKey);
{$ENDIF}
  inherited;
end;

function TPOACurrent.get_object_id: ObjectID;
begin
  if not iscurrent() then
    dorb_throw(NoContext.Create as IORBException);
  result := (getCurrent().Last as IPOACurrentState).por.id;
end;

function TPOACurrent.get_POA: IPOA;
begin
  if not iscurrent() then
    dorb_throw(NoContext.Create as IORBException);
  result := (getCurrent().Last as IPOACurrentState).poa;
end;

function TPOACurrent.make_ref(): IORBObject;
begin
  if not iscurrent() then
    dorb_throw(NoContext.Create as IORBException);
  result := (getCurrent().Last as IPOACurrentState).por.ref;
end;

function TPOACurrent.get_serv: IServant;
begin
  if not iscurrent() then
    dorb_throw(NoContext.Create as IORBException);
  result := (getCurrent().Last as IPOACurrentState).servant;
end;

function TPOACurrent.getCurrent: IInterfaceList;
begin
  result := IInterfaceList(TORBThread.getSpecific(FCurrentKey));
end;

procedure TPOACurrent.setCurrent(cur: IInterfaceList);
begin
  cur._AddRef;
  TORBThread.setSpecific(FCurrentKey, Pointer(cur));
end;

(*function TPOACurrent.inupcall: boolean;
{$IFDEF HAVE_THREADS}
var
  cur: IInterfaceList;
{$ENDIF}
begin
{$IFDEF HAVE_THREADS}
  cur := getCurrent();
  result := cur <> nil;
{$ELSE}
  result := FCurrentStateStack <> nil;
{$ENDIF}
end;*)

function TPOACurrent.iscurrent(): Boolean;
{$IFDEF HAVE_THREADS}
var
  cur: IInterfaceList;
{$ENDIF}
begin
{$IFDEF HAVE_THREADS}
  cur := getCurrent();
  result := (cur <> nil) and (cur.Count > 0);
{$ELSE}
  result := FCurrentStateStack.Count > 0;
{$ENDIF}
end;

procedure TPOACurrent._set(const p: IPOA; const por: IPOAObjectReference; const servant: IServant);
{$IFDEF HAVE_THREADS}
var
  cur: IInterfaceList;
{$ENDIF}
begin
{$IFDEF HAVE_THREADS}
  cur := getCurrent();
  if cur = nil then begin
    cur := TInterfaceList.Create;
    setCurrent(cur);
  end;
  cur.Add(TPOACurrentState.Create(p,por,servant) as IUnknown);
{$ELSE}
  FCurrentStateStack.Add(TPOACurrentState.Create(p,por,servant) as IUnknown);
{$ENDIF}
end;

procedure TPOACurrent.unset;
{$IFDEF HAVE_THREADS}
var
  cur: IInterfaceList;
{$ENDIF}
begin
{$IFDEF HAVE_THREADS}
  cur := getCurrent();
  if cur.Count > 0 then
    cur.Delete(cur.Count-1);
{$ELSE}
  if FCurrentStateStack.Count > 0 then
    FCurrentStateStack.Delete(FCurrentStateStack.Count-1);
{$ENDIF}
end;

function TPOACurrent.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/PortableServer/Current:1.0' then
    result := Pointer(self as IPOACurrent)
  else
    result := nil;
end;

class function TPOACurrent._narrow(const obj: IORBObject): IPOACurrent;
var
  ptr : Pointer;
begin
  result := nil;
  ptr := obj.narrow_helper('IDL:omg.org/PortableServer/Current:1.0');
  if ptr <> nil then
    result := IPOACurrent(ptr);
end;

//*********************************************************************
// TPOAManager
//*********************************************************************
constructor TPOAManager.Create;
begin
  FState := HOLDING;
  FManaged:= TInterfaceList.Create;
  FManagedLock := TRecursiveMutex.Create();
end;

destructor TPOAManager.Destroy;
begin
  FreeAndNil(FManagedLock);
  inherited;
end;

procedure TPOAManager.activate();
begin
  change_state(ACTIVE,false,false);
end;

procedure TPOAManager.deactivate(etherealize_objectes,
  wait_for_completion: Boolean);
begin
  change_state(INACTIVE,etherealize_objectes,wait_for_completion);
end;

procedure TPOAManager.discard_requests(wait_for_completion: Boolean);
begin
  change_state(DISCARDING,FALSE,wait_for_completion);
end;

function TPOAManager.get_state: POAManagerState;
begin
  result := FState
end;

procedure TPOAManager.hold_requests(wait_for_completion: Boolean);
begin
  change_state(HOLDING,FALSE,wait_for_completion);
end;

procedure TPOAManager.change_state(state: POAManagerState;etherealize_objects: Boolean; wait_for_completion: Boolean);
var
  i : integer;
begin
  if FState = INACTIVE then begin
    if state <> INACTIVE then
      dorb_throw(AdapterInactive.Create() as IORBException);
    Exit; // Manager is already in inactive state
  end;
  if FState = state then exit;
  FState := state;
  FManagedLock.lock();
  try
    for i := 0 to Pred(FManaged.Count) do
      IPOA(FManaged[i]).poa_manager_callback(state,etherealize_objects,wait_for_completion);
  finally
    FManagedLock.unlock();
  end; { try/finally }
end;

procedure TPOAManager.add_managed_poa(const val: IPOA);
begin
  FManagedLock.lock();
  try
    FManaged.Add(val);
  finally
    FManagedLock.unlock();
  end; { try/finally }
end;

procedure TPOAManager.del_managed_poa(const val: IPOA);
begin
  FManagedLock.lock();
  try
    FManaged.Remove(val);
  finally
    FManagedLock.unlock();
  end; { try/finally }
end;

//*********************************************************************
//  TObjectMap
//*********************************************************************
constructor TObjectMap.Create();
begin
  FRecords := TStringList.Create();
  FServants := interface_interface_map;
end;

destructor TObjectMap.Destroy();
begin
  FreeAndNil(FRecords);
  FServants := nil;
end;

function TObjectMap.count: integer;
begin
  result := FRecords.count;
end;

function TObjectMap.exists(objid: ObjectID): Boolean;
begin
  result := find(objid) <> nil;
end;

function TObjectMap.exists(const serv: IServant): Boolean;
begin
  result := FServants.IndexOf(serv) >= 0;
end;

function TObjectMap.find(const p: IPOA; const obj : IORBObject) : IPOAObjectRecord;
var
  key : AnsiString;
  len: longint;
  i : integer;
begin
  result := nil;
  if not assigned(obj) or not assigned(obj._ior) or not assigned(obj._ior.get_profile()) then exit;
  key := obj._ior.get_profile.objkey(Cardinal(len));
  if len = 0 then exit;
  for i := len downto 1 do
    if key[i] = '/' then break;
  if (i = 0) or (key[i-1] <> '\') then
    result := find(copy(key,i+1,1000))
  else
    result := find(TPoaObjectReference.Create(p,obj) as IPOAObjectReference);
end;

function TObjectMap.find(serv: IServant) : IPOAObjectRecord;
var
  lst : IInterfaceList;
begin
  result := nil;
  lst := IInterfaceList(FServants[serv]);
  if not assigned(lst) or (lst.count = 0) then exit;
  result := lst[0] as IPOAObjectRecord;
end;

function TObjectMap.find(const por: IPOAObjectReference) : IPOAObjectRecord;
begin
  result := find(por.id);
end;

procedure TObjectMap.del_servant(const por: IPOAObjectRecord);
var
  lst: IInterfaceList;
begin
  lst := IInterfaceList(FServants[por.serv]);
  if lst <> nil then begin
    while lst.Remove(por) <> -1 do;
    //maybe MULTIPLE_ID object ID Uniqueness policy
    if lst.Count = 0 then
      FServants.erase(por.serv);
  end;
end;

function TObjectMap.pop(): IPOAObjectRecord;
{var
  lst : IInterfaceList;}
begin
  result := IPOAObjectRecord(Pointer(FRecords.Objects[FRecords.Count-1]));
  FRecords.Delete(FRecords.Count-1);
  del_servant(result);
  result._Release;
  {lst := IInterfaceList(FServants[result.serv]);
  lst.Remove(result);
  if lst.count = 0 then
    FServants.erase(result.serv);}
end;

function TObjectMap.del(objid: ObjectID): IPOAObjectRecord;
(*var
  i : integer;
begin
  result := nil;
  i := FRecords.IndexOf(string(objid));
  if i >= 0 then
    begin
      result := IPOAObjectRecord(Pointer(FRecords.Objects[i]));
      result._Release;
      FRecords.Delete(i);
      del_servant(result);
    end;*)
var
  i : integer;
  //lst : IInterfaceList;
begin
  result := nil;
  i := FRecords.IndexOf(string(objid));
  assert(i>=0);

  result := IPOAObjectRecord(Pointer(FRecords.Objects[i]));
  result._Release;
  FRecords.Delete(i);
  del_servant(result);
  {lst := IInterfaceList(FServants[result.serv]);
  lst.Remove(result);
  if lst.count = 0 then
    FServants.erase(result.serv);}
end;

function TObjectMap.find(objid: ObjectID) : IPOAObjectRecord;
var
  i : integer;
begin
  result := nil;
  if FRecords.count = 0 then exit;
  i := FRecords.IndexOf(String(objid));
  if i >= 0 then
    result := IPOAObjectRecord(Pointer(FRecords.Objects[i]))
end;

function TObjectMap.item(index: integer): IPOAObjectRecord;
begin
  result := IPOAObjectRecord(Pointer(FRecords.Objects[index]));
end;

function TObjectMap.add(const por: IPOAObjectReference; const serv: IServant): IPOAObjectRecord;
(*var
  lst : IInterfaceList;
begin
  result := TPOAObjectRecord.Create(por,serv);
  result._AddRef;
  FRecords.AddObject(string(por.id),Pointer(result));
  lst := IInterfaceList(FServants[serv]);
  if lst = nil then
    begin
      lst := TInterfaceList.Create;
      FServants[serv] := lst;
    end;
  lst.Add(result);*)
var
  lst : IInterfaceList;
begin
  result := TPOAObjectRecord.Create(por,serv);
  result._AddRef;
  FRecords.AddObject(string(por.id),Pointer(result));
  lst := IInterfaceList(FServants[serv]);
  if lst = nil then
    begin
      lst := TInterfaceList.Create;
      FServants[serv] := lst;
    end;
  lst.Add(result);
end;

//*********************************************************************
//  TUniqueIdGenerator
//*********************************************************************
constructor TUniqueIdGenerator.Create(prefix: string);
begin
  FCurrent := 0;
  FPrefix := prefix;
  FMutex := TMutex.Create;
end;

destructor TUniqueIdGenerator.Destroy;
begin
  FreeAndNil(FMutex);
  inherited;
end;

function TUniqueIdGenerator.new_id: ObjectID;
var
  str: string;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  str := inttostr(FCurrent);
  if FPrefix <> '' then
    str := FPrefix + str;
  result := AnsiString(str);
  FCurrent := FCurrent + 1;
end;

//*********************************************************************
//  TPOAObjectReference
//*********************************************************************
constructor TPOAObjectReference.Create(const por: IPOAObjectReference);
begin
  FPOA := por.poa;
  FObjid := por.id;
  FPoaname := por.poa_name;
  FRepoid := por.repoid;
  FObject := por.obj;
  FIdDirty := por.iddirty;
  FServant := por.servant;
  FRefLock := TMutex.Create;
end;

constructor TPOAObjectReference.Create(const poa: IPOA; const obj : IORBObject);
begin
  FPOA := poa;
  FObject := obj;
  FIddirty := true;
  FServant := nil;
  FRefLock := TMutex.Create;
end;

constructor TPOAObjectReference.Create(const poa: IPOA; const objid: ObjectID;
  const repoid: RepositoryID; const serv: IServant);
begin
  FPOA := poa;
  FObjid := objid;
  FPoaname := FPOA.get_oaid;
  FRepoid := repoid;
  FIddirty := false;
  FServant := serv;
  FRefLock := TMutex.Create;
end;

destructor TPOAObjectReference.Destroy;
begin
  FreeAndNil(FRefLock);
  inherited;
end;

procedure TPOAObjectReference._destroy;
begin
  FPOA := nil;
  FServant := nil;
  FObject := nil;
end;

function TPOAObjectReference.iddirty: Boolean;
begin
  result := FIddirty;
end;

function TPOAObjectReference.in_descendant_poa(const fqn, implname: PAnsiChar): Boolean;
var
  str: PAnsiChar;
begin
  result := false;
  if not decompose_ref then
    exit;
  str := PAnsiChar(FPOAName);
  if (implname[0] <> #0) and (strlcomp(str,implname,strlen(implname)) = 0) then
    begin
      str := PAnsiChar(DWORD(str)+strlen(implname));
      if byte(str[0]) = 0 then
        str := PAnsiChar(FPOAName)
      else if str[0] <> '/' then
        exit
      else
        inc(integer(str));
    end
  else
    exit;
  result := (strlcomp(str,fqn,strlen(fqn)) = 0) or
    ( not (fqn[0] <> #0) or (str[strlen(fqn)] = '/'));
end;

function TPOAObjectReference.next_descendant_poa(const fqn,
  implname: PAnsiChar): PAnsiChar;
var
  str : PAnsiChar;
  res: AnsiString;
  i: integer;
begin
  result := nil;
  assert(decompose_ref);
  assert(in_descendant_poa(fqn,implname));
  str := PAnsiChar(FPOAName);
  if (implname[0] <> #0) and (strlcomp(str,implname,strlen(implname)) = 0) then
    begin
      str := PAnsiChar(DWORD(str)+strlen(implname));
      if str^ = #0 then
        str := PAnsiChar(FPOAName)
      else
        begin
          assert(str[0] = '/');
          inc(integer(str));
        end;
    end
  else
    assert(false);

  if fqn^ <> #0 then
    begin
      str := PAnsiChar(DWORD(str)+strlen(fqn));
      assert(str^ = '/');
      inc(integer(str));
    end;

  i := 0;
  while true do
    begin
      if (str[i] = #0) or (str[i] = '/') then break;
      if str[i] = '\' then inc(i);
      inc(i);
    end;
  if i = 0 then exit;
  res := '';
  i := 0;
  while true do
    begin
      if (str[i] = #0) or (str[i] = '/') then break;
      if str[i] = '\' then inc(i);
      res := res + str[i];
      inc(i);
    end;
  result := PAnsiChar(res);
end;


function TPOAObjectReference.in_poa(const pname: ObjectId): Boolean;
begin
  result := false;
  if not decompose_ref() then exit;
  result := strcomp(PAnsiChar(FPoaname),PAnsiChar(pname))=0;
end;

function TPOAObjectReference.obj: IORBObject;
begin
  result := FObject;
end;

function TPOAObjectReference.poa: IPOA;
begin
  result := FPOA;
end;

function TPOAObjectReference.repoid: RepositoryId;
begin
  result := FRepoid;
end;

function TPOAObjectReference.servant: IServant;
begin
  result := FServant;
end;


function TPOAObjectReference.poa_name(): AnsiString;
begin
  assert(decompose_ref());
  result := FPoaname;
end;

function TPOAObjectReference.is_legal(): Boolean;
begin
  result := true;
  if not FIdDirty then exit;
  if not (FObject = nil) then
    begin
      if decompose_ref() then
        exit;
    end;
  result := false;
end;

function TPOAObjectReference.decompose_ref(): Boolean;
var
  key: PByteArray;
  l: integer;
  i,j,idlength : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FRefLock);
  result := false;
  if not FIdDirty then
    // nothing to do
    begin
      result := true;
      exit;
    end;
  if not assigned(FObject) or not assigned(FObject._ior) or
    not assigned(FObject._ior.get_profile) then
      exit;
  key := PByteArray(PAnsiChar(FObject._ior.get_profile.objkey(_ulong(l))));
  if key = nil then exit;
  // the poaname is up to unescaped slash
  i := l - 1;
  while i > 0 do begin
    if key^[i] = Byte('/') then begin
      for j := 0 to i -1 do
        if key^[i - j - 1] <> byte('\') then break;
      if (j mod 2) = 0 then break;
    end;
    Dec(i);
  end; { while }
  // collapsed poaname/id
  if key^[i] <> byte('/') then
    i := l;
  SetLength(FPoaname,i);
  j := 0;
  while j < i do
    begin
      if key^[j] = 0 then
        exit
      else
        FPoaname[j+1] := AnsiChar(Key^[j]);
      inc(j);
    end;
  if j = l then
    // object id is the same as poaname
    FObjID := FPoaname
  else
    begin
      inc(j);
      idlength := l - j;
      i := j;
      while i < l do begin
        if key^[i] = byte('\') then begin
          dec(idlength);
          inc(i);
        end;
        inc(i);
      end;
      SetLength(FObjid,idlength);
      i := 1;
      //while j <= l do
      while j < l do begin
        if key^[j] = byte('\') then
          inc(j);
        FObjid[i] := AnsiChar(key^[j]);
        inc(j);
        inc(i);
      end;
    end;
  FIdDirty := false;
  FRepoid := FObject._repoid;
  result := true;
end;

function TPOAObjectReference.id(): ObjectID;
begin
  if FIdDirty then decompose_ref();
  result := FObjid;
end;

procedure TPOAObjectReference.set_ref(const obj: IORBObject);
begin
  FRefLock.lock();
  try
    FObject := obj;
  finally
    FRefLock.unlock();
  end; { try/finally }
end;

function TPOAObjectReference.ref(): IORBObject;
begin
  FRefLock.lock();
  try
    make_ref();
    result := FObject;
  finally
    FRefLock.unlock();
  end; { try/finally }
end;

procedure TPOAObjectReference.make_ref();
var
  key: AnsiString;
  keystr : AnsiString;
  l : _ulong;
  ior : IIOR;
  tmp : IORBObject;
  i,j,idlength : integer;
  samename : Boolean;
begin
  if FObject <> nil then
    begin
      if assigned(FObject._IOR) and assigned(FObject._ior.get_profile()) and
        // GIOPSimpleProfile
        (FObject._ior.get_profile().id = 10000) then
        begin
          key := FObject._ior.get_profile().objkey(l);
          ior := TIOR.Create(FPOA.ior_template());
          ior.set_objectkey(key,l);
          ior.set_objectid(FObject._ior.objid);
          // OVS: two _Release in succession, see _IntfCopy
          //FObject._Release;
          FObject := TORBObject.Create(ior);
          // setup domains
          FObject.setup_domains(nil);
        end;
      exit;
    end;
  if FIddirty then
    exit;
  l := Length(FPoaName);
  j := l+1;
  idlength := Length(FObjId);
  samename := false;
  if longint(l) = idlength then
    begin
      for i := 1 to idlength do
        if FObjId[i] <> FPOAName[i] then break;
      samename := i = idlength;
    end;
  // place backslash before all slashes & backslashes
  if not samename then
    begin
      for i := 1 to idlength do
        begin
          if (FObjId[i] = '/') or (FObjId[i] = '\') then
            inc(l);
          inc(l);
        end;
      inc(l);
    end;
  keystr := FPOANAme;
  SetLength(keystr,l);
  if not samename then
    begin
      keystr[j] := '/';
      inc(j);
      for i := 1 to idlength  do
        begin
          if (FObjId[i] = '/') or (FObjId[i] = '\') then
            begin
              keystr[j] := '\';
              inc(j);
            end;
          keystr[j] := FObjId[i];
          inc(j);
        end;
    end;
  ior := TIOR.Create(FPOA.ior_template());
  ior.set_objectkey(keystr,l);
  ior.set_objectid(Frepoid);
  FObject := TORBObject.Create(ior);
  FObject.setup_domains(nil);
  if assigned(FServant) then
    begin
      tmp := FServant._make_stub(FPOA,FObject);
      if tmp <> nil then
        FObject := tmp;
    end;
end;

//**************************************************************
// TPOAObjectRecord
//**************************************************************
constructor TPOAObjectRecord.Create(const por: IPOAObjectReference;
  const serv: IServant);
begin
  FPor := por;
  FServ := serv;
  FActive := true;
end;

destructor TPOAObjectRecord.Destroy;
begin
  inherited;
end;

procedure TPOAObjectRecord._destroy;
begin
  FPor := nil;
  FServ := nil;
end;

function TPOAObjectRecord.serv(): IServant;
begin
  result := FServ;
end;

function TPOAObjectRecord.por(): IPOAObjectReference;
begin
  result := FPor;
end;

function TPOAObjectRecord.GetActive: boolean;
begin
  result := FActive;
end;

function TPOAObjectRecord.GetInvokeCnt: Longint;
begin
  result := FInvokeCnt;
end;

procedure TPOAObjectRecord.SetActive(value: boolean);
begin
  FActive := value;
end;

procedure TPOAObjectRecord.SetInvokeCnt(value: Integer);
begin
  FInvokeCnt := value;
end;

{$IFDEF HAVE_THREADS}
function TPOAObjectRecord.GetDelRef: IDeletionRecord;
begin
  result := FDelRef;
end;

procedure TPOAObjectRecord.SetDelRef(Value: IDeletionRecord);
begin
  FDelRef := value;
end;
{$ENDIF}

//*********************************************************************
//  TInvocationRecord
//*********************************************************************
constructor TInvocationRecord.Create(id: ORBMessageID;
  por: IPOAObjectReference; req: IORBRequest;pr : IPrincipal);
begin
  FORBid := id;
  FPrincipal := pr;
  FPor := TPOAObjectReference.Create(por);
  FReq := req;
end;

procedure TInvocationRecord.exec(const poa : IPOA);
begin
  poa.local_invoke(self);
end;

function TInvocationRecord.get_orequest: IORBRequest;
begin
  result := FReq;
end;

function TInvocationRecord.make_req(const poa: IPOA; const servant: IServant): IServerRequestBase;
begin
  if FSrb = nil then
    begin
      FSrb := servant.make_request(FReq,FPor.ref,FORBid,IObjectAdaptor(poa),FPrincipal);
      assert(FSrb<>nil);
    end;
  result := FSrb;
end;

function TInvocationRecord.make_dyn_req(const poa: IPOA): IServerRequest;
var
  sr: IServerRequest;
begin
  sr := TServerRequest.Create(FReq,FPor.ref,FORBid,poa,FPrincipal);
  FSrb := sr;
  result := sr;
end;

function TInvocationRecord.get_por: IPOAObjectReference;
begin
  result := FPor;
end;

function TInvocationRecord.id: ORBMessageID;
begin
  result := FORBid
end;

//*********************************************************************
//  TPOACurrentState
//*********************************************************************
constructor TPOACurrentState.Create(const poa: IPOA;
  const por: IPOAObjectReference; const servant: IServant);
begin
  FPoa := poa;
  FPor := por;
  FServant := servant;
end;

function TPOACurrentState.poa: IPOA;
begin
 result := FPoa;
end;

function TPOACurrentState.por: IPOAObjectReference;
begin
  result := FPor;
end;

function TPOACurrentState.servant: IServant;
begin
  result := FServant;
end;

//*********************************************************************
//  TServantActivator
//*********************************************************************
(*class function TServantActivator._narrow(
  const obj: IORBObject): IServantActivator;
begin
  result := nil;
  if assigned(obj) then
    result := IServantActivator(obj.narrow_helper('IDL:omg.org/PortableServer/ServantActivator:1.0'));
end;

function TServantActivator.narrow_helper(const str: string): Pointer;
begin
  if str = 'IDL:omg.org/PortableServer/ServantActivator:1.0' then
    result := Pointer(self as IServantActivator)
  else
    result := inherited narrow_helper(str)
end;

function TServantActivator.repoid: string;
begin
  result := 'IDL:omg.org/PortableServer/ServantActivator:1.0'
end;

//*********************************************************************
//  TServantManager
//*********************************************************************
class function TServantManager._narrow(
  const obj: IORBObject): IServantManager;
begin
  result := nil;
  if assigned(obj) then
    result := IServantManager(obj.narrow_helper('IDL:omg.org/PortableServer/ServantManager:1.0'));
end;

function TServantManager.narrow_helper(const str: string): Pointer;
begin
  if str = 'IDL:omg.org/PortableServer/ServantManager:1.0' then
    result := Pointer(self as IServantActivator)
  else
    result := nil;
end;

function TServantManager.repoid: string;
begin
  result := 'IDL:omg.org/PortableServer/ServantManager:1.0'
end;

//*********************************************************************
//  TServantLocator
//*********************************************************************
class function TServantLocator._narrow(
  const obj: IORBObject): IServantLocator;
begin
  result := nil;
  if assigned(obj) then
    result := IServantLocator(obj.narrow_helper('IDL:omg.org/PortableServer/ServantLocator:1.0'));
end;

function TServantLocator.narrow_helper(const str: string): Pointer;
begin
  if str = 'IDL:omg.org/PortableServer/ServantLocator:1.0' then
    result := Pointer(self as IServantLocator)
  else
    result := inherited narrow_helper(str)
end;

function TServantLocator.repoid: string;
begin
  result := 'IDL:omg.org/PortableServer/ServantLocator:1.0'
end;*)

{$IFDEF HAVE_THREADS}

{ TDeletionRecord }

function TDeletionRecord.Condition: TCondVar;
begin
  result := FCondition;
end;

constructor TDeletionRecord.Create;
begin
  FCondition := TCondVar.Create;
end;

destructor TDeletionRecord.Destroy;
begin
  FreeAndNil(FCondition);
  inherited;
end;

function TDeletionRecord.GetCount: Integer;
begin
  result := FCount;
end;

function TDeletionRecord.GetSignal: Short;
begin
  result := FSignal;
end;

procedure TDeletionRecord.SetCount(const Value: Integer);
begin
  FCount := Value;
end;

procedure TDeletionRecord.SetSignal(const Value: Short);
begin
  FSignal := Value;
end;
{$ENDIF}

//*********************************************************************
function the_root_poa : IPOA;
begin
  result := _the_root_poa;
end;

function POA_Current : IPOACurrent;
begin
  result := POACurrent;
end;

function POACurrent_narrow(const obj : IORBObject): IPOACurrent;
begin
  result := TPOACurrent._narrow(obj)
end;

function UniqueIDGenerator(const prefix: string): IUniqueIDGenerator;
begin
  result := TUniqueIDGenerator.Create(prefix);
end;

function String_to_ObjectId(const s: AnsiString): ObjectID;
begin
  if Length(s) = 0 then
    dorb_throw(st_BAD_PARAM);
  result := Copy(s, 0, Length(s));
end;

function ObjectId_to_string(const id: ObjectID): AnsiString;
begin
  result := Copy(id, 0, Length(id));
end;

{$IFDEF LIBRARY}
exports
  the_root_poa,
  POACurrent_narrow,
  POA_Current,
  UniqueIDGenerator,
  String_to_ObjectId,
  ObjectId_to_string;
{$ENDIF}
initialization
  poa_impl_name := 'Default';
{$ENDIF}
end.
