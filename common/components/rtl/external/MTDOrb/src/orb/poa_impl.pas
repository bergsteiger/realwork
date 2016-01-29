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
unit poa_impl;

interface

{$I dorb.inc}

uses
  poa_int,orb_int,orb,orbtypes,Classes,req_int,addr_int,map_int,env_int,
  iior_int,except_int,exceptions,policy_int,poa,code_int,osthread,
  tcode,ir_int;

{$IFNDEF USELIB}

type

  TPOA_impl = class(TORBObject,IPOA,IObjectAdaptor)
  private
    FParent : IPOA;
    FUnique_id : _ulong;
    //FDestructed: boolean;
    FManager : IPOAManager;
    FName : AnsiString;
    FOaid : ObjectID;
    FState : POAManagerState;
    //FEver_been_active: Boolean;
    FObjectMap : IObjectMap;
    FInvocationQueue : IInterfaceList;
    FChildList : TStrings;
    FChildrenLock: TRecursiveMutex;
    FDefaultServant : IServant;
    FServantManager : IServantManager;
    FAdapterActivator : IAdapterActivator;
    FObjectActivationLock: TRecursiveMutex;
    FDestroyStateMutex: TMutex;
    FDestroyState: TPOADestroyState;
    FThreadMonitor: TThreadMonitor;
    FRequestsCount: integer;// How many pending requests are there?
    FEtherealize: boolean;
    //FCurrentKey: TThreadKey;
    {** serialization}
    FSerializeInvoke: TMutex;
    {** Fully Qualified Name }
    FFQN : AnsiString;
    // policies
    id_assignment_policy : IIdAssignmentPolicy;
    thread_policy : IThreadPolicy;
    lifespan_policy : ILifespanPolicy;
    id_uniqueness_policy : IIdUniquenessPolicy;
    implicit_activation_policy : IImplicitActivationPolicy;
    servant_retention_policy : IServantRetentionPolicy;
    request_processing_policy : IRequestProcessingPolicy;
    bidirectional_policy : IBidirectionalPolicy;

    function GetDestroyed(): boolean;
    function MarkDestroyPending(etherealize_objects: Boolean; wait_for_completion: Boolean): boolean;
    function WaitPendingRequests(): boolean;
    function IncrementRequestCount(): boolean;
    function DecrementRequestCount(): boolean;
    procedure MarkDestroyCompleted();
    function HasPendingRequests(): boolean;
    procedure CompleteDestroy();
    {** private object activation and deactivation}
    procedure remove_object(const id: ObjectID);
  protected
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

    procedure builtin_is_a(const ir: IInvocationRecord; const servant: IServant);
    procedure builtin_non_existent(const ir: IInvocationRecord; const servant: IServant);
    procedure builtin_interface(const ir: IInvocationRecord; const servant: IServant);
    
  protected
    // DORB extention
    procedure etherealize();
    function _find_POA(adapter_name: AnsiString; activate_it: Boolean): IPOA;
    procedure answer_invoke(id: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
    function bind(id: ORBMessageID; const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress): Boolean;
    function has_object(const obj: IORBObject): Boolean;
    function invoke(id: ORBMessageID;const obj : IORBObject; const req : IORBRequest; const pr: IPrincipal; response_exp: Boolean): Boolean;  stdcall;
    function is_local: Boolean;
    function skeleton(const obj : IORBObject): IORBObject;
    procedure shutdown(WaitForCompletion: Boolean);
    procedure cancel(id: ORBMessageID);
    function locate(mid: ORBMessageID; const obj : IORBObject): Boolean;
    function narrow_helper(const str: RepositoryId): Pointer; override;
    procedure poa_manager_callback(state: POAManagerState;etherealize_objects: Boolean; wait_for_completion: Boolean);
    function ior_template(): IIOR;
    procedure local_invoke(const ir: IInvocationRecord);
    procedure perform_invoke(ir: IInvocationRecord);
    function builtin_invoke(const ir: IInvocationRecord; const servant: IServant): Boolean;
    procedure register_child(const cname : AnsiString; child: IPOA);
    procedure unregister_child(const cname : AnsiString);
    procedure set_policies(policies: PolicyList);
    function fqn: AnsiString;
    function get_oaid: ObjectID;
    function activate_for_this(p_servant: IServant): IORBObject;
    function _preinvoke(const obj: IORBObject): IServant;
    procedure _postinvoke();
    function ActiveObjectMap(): IObjectMap;
    function ObjectActivationLock: TRecursiveMutex;
    function _id_assignment_policy : IIdAssignmentPolicy;
    function _thread_policy : IThreadPolicy;
    function _lifespan_policy : ILifespanPolicy;
    function _id_uniqueness_policy : IIdUniquenessPolicy;
    function _implicit_activation_policy : IImplicitActivationPolicy;
    function _servant_retention_policy : IServantRetentionPolicy;
    function _request_processing_policy : IRequestProcessingPolicy;
  public
    {** Root_POA constructor}
    constructor Create1(orb: IORB); overload;
    constructor Create2(name: AnsiString; manager: IPOAManager; policies: PolicyList;
      parent: IPOA; orb: IORB); overload;
    destructor Destroy(); override;
    class function _narrow(const obj : IORBObject): IPOA;
  end;

  function POA_narrow(const obj : IORBObject) : IPOA;

implementation

uses
  address,{$IFDEF WIN32}windows,{$ENDIF}{$IFDEF LINUX}Libc,{$ENDIF}SysUtils,map,throw,ior,req,static,
  poa_except,utils,policy,env,any,imr_int,imr,mtdebug,internalexceptions,pi_impl;

var
  AllPOAs: TStrings;
  AllPOAsSync: TRWLock;
  OAPrefix: ObjectID;
  idfactory: TUniqueIdGenerator;
  poauid: TUniqueIdGenerator;
  POAMediator: IPOAMediator;
  POAMediatorIOR: IIOR;
  Ever_been_active: Boolean;
  ServantManagerLock: TMutex;
  GlobalInvokeLock: TMutex;

procedure unregister_poa(const name: string);
var
  p: IPOA;
  i : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(AllPOAsSync, false);
  i := ALLPOAs.IndexOf(name);
  if i >= 0 then
    begin
      p := IPOA(Pointer(ALLPOAs.Objects[i]));
      ALLPOAs.Delete(i);
      p._release;
    end;
end;

procedure register_poa(const name: ObjectId; const child: IPOA);
var
  sync: ISynchronized;
begin
{$IFDEF USE_RWLOCK}
  sync := TSynchronized.Create(AllPOAsSync, false);
{$ENDIF}
  assert(ALLPOAs.IndexOf(String(name))<0);
  ALLPOAs.AddObject(String(name),Pointer(child));
  child._AddRef;
end;

//*********************************************************************
//  TPOA_impl
//*********************************************************************
{** constructor for creating root POA }
constructor TPOA_impl.Create1(orb: IORB);
var
  pref, implname, myref, poamedRef: AnsiString;
  list: PolicyList;
  x : int64;
  obj: IORBObject;
{$IFDEF WIN32}
  t : TSystemTime;
{$ENDIF}
{$IFDEF LINUX}
  t: TTime_T;
  tv: TTimeVal;
  ut: TUnixTime;
{$ENDIF}
begin
  FFQN := '';
  FObjectMap := TObjectMap.Create;
  FChildList := TStringList.Create;
  FORB := orb;
  //FDestructed := false;
  FUnique_id := 0;
  FParent := nil;
  setLength(list,1);
  list[0] := create_implicit_activation_policy(IMPLICIT_ACTIVATION);
  set_policies(list);
  FManager := TPOAManager.Create;
  POACurrent := TPOACurrent.Create(orb);
  FInvocationQueue := TInterfaceList.Create;

  FDefaultServant := nil;
  FServantManager :=  nil;
  FAdapterActivator := nil;

  FName := 'RootPOA';
  FState := HOLDING;
  pref := AnsiString('/' + IntToStr({$IFDEF WIN32}GetCurrentProcessID(){$ENDIF}{$IFDEF LINUX}getpid(){$ENDIF}));
{$IFDEF WIN32}
  getSystemTime(t);
  with t do
    x := trunc(now())*MSecsPerDay + (wHour * 3600000 + wMinute * 60000 + wSecond * 1000 + wMilliseconds);
{$ENDIF}
{$IFDEF LINUX}
  gettimeofday(tv, nil);
  t := tv.tv_sec;
  gmtime_r(t, ut);
  with ut do
    x := trunc(now())*MSecsPerDay + (tm_hour * 3600000 + tm_min * 60000 + tm_sec * 1000 + tv.tv_usec div 1000);
{$ENDIF}
  pref := AnsiString(String(pref) + '/' + IntToStr(x));
  OAPrefix := ObjectId(pref);
  FOaid := OAPrefix;

  POAMediator := nil;
  Ever_been_active := false;

  implname := AnsiString(FORB.get_Properties.get_Property('mtdorb.orb.poa.implname'));
  if implname <> '' then
    poa_impl_name := implname;
  (*
   * If we have an ImplName, connect to the Mediator
   *)
  if implname <> '' then begin
    if FORB.get_Properties.get_Property('mtdorb.orb.poa.remote_ior') <> '' then
      obj := FORB.string_to_object(AnsiString(FORB.get_Properties.get_Property('mtdorb.orb.poa.remote_ior')))
    else if FORB.get_Properties.get_Property('mtdorb.orb.poa.remote_addr') <> '' then
      obj := FORB.bind('IDL:mg.org/CORBA/POAMediator:1.0', AnsiString(FORB.get_Properties.get_Property('mtdorb.orb.poa.remote_addr')));
    POAMediator := TPOAMediator._narrow(obj);
    if POAMediator <> nil then begin
      (*
       * register with mediator
       *)
      myref := FORB.ior_template().stringify();
      poamedRef := POAMediator.create_impl(poa_impl_name, myref);
      POAMediatorIOR := TIOR.Create(AnsiString(poamedRef));
    end;
  end;

  _the_root_poa := self;
  register_poa(FOaid,self);
  FManager.add_managed_poa(self);
  FORB.register_initial_reference('RootPOA',self);
  FORB.register_oa(self,OAPriorityLocal);
  FObjectActivationLock := TRecursiveMutex.Create;
  FSerializeInvoke := TMutex.Create;
  FDestroyStateMutex := TMutex.Create;
  FThreadMonitor := TThreadMonitor.Create;
  FChildrenLock := TRecursiveMutex.Create;
  FDestroyState := psDestroyNotCalled;
  // IOR interceptor
  TPIManager.PIManager.ExecEstablishComponents(TIORInfoImpl.Create(Self, ior_template()));
end;

{** constructor for child POAs }
constructor TPOA_impl.Create2(name: AnsiString; manager: IPOAManager;
  policies: PolicyList; parent: IPOA; orb: IORB);
var
  i, idx: integer;
  p: IPolicy;
begin
  FName := name;
  FParent := parent;
  FORB := orb;
  FChildList := TStringList.Create;
  FObjectMap := TObjectMap.Create;
  FInvocationQueue := TInterfaceList.Create;

  set_policies(policies);

  if manager = nil then manager := TPOAManager.Create;
  FManager := manager;

  FDefaultServant := nil;
  FServantManager :=  nil;
  FAdapterActivator := nil;

  if parent.fqn <> '' then  FFQN := parent.fqn + '/';

  for i := 1 to Length(name) do
    if CharInSet(name[i], ['/','\']) then   FFQN := FFQN + '\'
    else FFQN := FFQN + AnsiChar(name[i]);

  FState := manager.get_state;

  if lifespan_policy.value = TRANSIENT then
    FOaid := OAPrefix + '/' + poauid.new_id
  else begin
    if poa_impl_name = '' then begin
      idx := 0;
      for i := 0 to Length(policies) - 1 do begin
        p := TLifespanPolicy._narrow(policies[i]);
        if (p <> nil) and (ILifespanPolicy(p).value() = PERSISTENT) then
          idx := i;
      end;
      dorb_throw(InvalidPolicy.Create(idx) as IORBException);
    end;
    (*
     * Collapse if impl_name == fqn and no escaping is necessary
     *)
    if (poa_impl_name = FFQN) and (Pos('/', String(FFQN)) = 0) then
      FOaid := ObjectId(FFQN)
    else begin
      for i := 1 to Length(poa_impl_name) do
        if CharInSet(poa_impl_name[i], ['/','\']) then
          FOaid := FOaid + '\'
        else
          FOaid := FOaid + ObjectId(poa_impl_name[i]);

      FOaid := FOaid + '/';
      FOaid := FOaid + ObjectId(FFQN);
    end;
  end;

  register_poa(FOaid,self);
  FManager.add_managed_poa(self);
  FParent.register_child(FName,self);
  FObjectActivationLock := TRecursiveMutex.Create;
  FSerializeInvoke := TMutex.Create;
  FDestroyStateMutex := TMutex.Create;
  FThreadMonitor := TThreadMonitor.Create;
  FChildrenLock := TRecursiveMutex.Create;
  FDestroyState := psDestroyNotCalled;
  if (bidirectional_policy <> nil) and (bidirectional_policy.value = policy_int.BOTH) then
    FORB.TurnOnBiDirGIOP;
  // IOR interceptor
  TPIManager.PIManager.ExecEstablishComponents(TIORInfoImpl.Create(Self, ior_template()));
end;

function TPOA_impl.fqn: AnsiString;
begin
  result := FFQN
end;

procedure TPOA_impl.set_policies(policies: PolicyList);
var
  i, j, len: integer;
  plist: PolicyList;
begin
  id_assignment_policy := nil;
  thread_policy := nil;
  lifespan_policy := nil;
  id_assignment_policy := nil;
  id_uniqueness_policy := nil;
  implicit_activation_policy := nil;
  servant_retention_policy := nil;
  request_processing_policy := nil;
  bidirectional_policy := nil;
  for i := 0 to Pred(length(policies)) do
    case policies[i].policy_type of
      THREAD_POLICY_ID : thread_policy := TThreadPolicy._narrow(policies[i]);
      LIFESPAN_POLICY_ID : lifespan_policy := TLifespanPolicy._narrow(policies[i]);
      ID_UNIQUENESS_POLICY_ID : id_uniqueness_policy := TIdUniquenessPolicy._narrow(policies[i]);
      ID_ASSIGNMENT_POLICY_ID : id_assignment_policy := TIdAssignmentPolicy._narrow(policies[i]);
      IMPLICIT_ACTIVATION_POLICY_ID : implicit_activation_policy := TImplicitActivationPolicy._narrow(policies[i]);
      SERVANT_RETENTION_POLICY_ID : servant_retention_policy := TServantRetentionPolicy._narrow(policies[i]);
      REQUEST_PROCESSING_POLICY_ID : request_processing_policy := TRequestProcessingPolicy._narrow(policies[i]);
      BIDIRECTIONAL_POLICY_TYPE : bidirectional_policy := TBidirectionalPolicy._narrow(policies[i]);
      else begin
        if TPIManager.PIManager.PolicyFactoryMap.Item[policies[i].policy_type] <> nil then begin
          len := Length(plist);
          SetLength(plist, len + 1);
          plist[len] := policies[i];
        end
        else
          dorb_throw(InvalidPolicy.Create());
      end;
    end;
  if Length(plist) <> 0 then begin
    for i := 0 to Length(plist) - 1 do begin
      j := 0;
      while j < Length(FPolicies) do begin
        if FPolicies[j].policy_type = plist[i].policy_type then begin
          FPolicies[j] := plist[i];
          Break;
        end;
        Inc(j);
      end; { while }
      if j = Length(FPolicies) then begin
        len := Length(FPolicies);
        SetLength(FPolicies, len + 1);
        FPolicies[len] := plist[i];
      end;
    end;
  end;
  if thread_policy = nil then  thread_policy := create_thread_policy(ORB_CTRL_MODEL);
  if lifespan_policy = nil then lifespan_policy := create_lifespan_policy(TRANSIENT);
  if id_uniqueness_policy = nil then id_uniqueness_policy := create_id_uniqueness_policy(UNIQUE_ID);
  if implicit_activation_policy = nil then implicit_activation_policy := create_implicit_activation_policy(IMPLICIT_ACTIVATION);
  if servant_retention_policy = nil then servant_retention_policy := create_servant_retention_policy(RETAIN);
  if request_processing_policy = nil then request_processing_policy := create_request_processing_policy(USE_ACTIVE_OBJECT_MAP_ONLY);
  if id_assignment_policy = nil then id_assignment_policy := create_id_assignment_policy(SYSTEM_ID);
end;

procedure TPOA_impl.register_child(const cname: AnsiString; child: IPOA);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FChildrenLock);
  FChildList.AddObject(String(cname),TObject(Pointer(child)));
  child._addref;
end;

procedure TPOA_impl.unregister_child(const cname : AnsiString);
var
  i : integer;
  c : IPOA;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FChildrenLock);
  i := FChildList.IndexOf(String(cname));
  if i >= 0 then
    begin
      c := IPOA(Pointer(FChildList.objects[i]));
      FChildList.Delete(i);
      c._Release;
    end;
end;

procedure TPOA_impl.activate_object_with_id(id: ObjectID;
  p_servant: IServant);
var
  iface: AnsiString;
  por : IPOAObjectReference;
  orec: IPOAObjectRecord;
{$IFDEF HAVE_THREADS}
  delref: IDeletionRecord;
{$ENDIF}
  sync: ISynchronized;
begin
  (*
   * Requires RETAIN
   *)
  if servant_retention_policy.value <> RETAIN then
    dorb_throw(WrongPolicy.Create() as IORBException);

  sync := TSynchronized.Create(FObjectActivationLock);

  orec := FObjectMap.find(id);
{$IFDEF HAVE_THREADS}
  while (orec <> nil) and not orec.active do begin
    // object is being deactivated
    delref := orec.delref;
    if (delref = nil) then begin
      delref := TDeletionRecord.Create as IDeletionRecord;
      orec.delref := delref;
    end;
    delref.Count := Succ(delref.Count);
    repeat
      // wait unlocks the ObjectActivationLock
      delref.Condition.wait(FObjectActivationLock);
    until delref.Signal <> 0;
    delref.Count := Pred(delref.Count);
    if (delref.Count = 0) then begin
      delref := nil;
      orec.delref := nil;
    end;
    // orec is gone now and we hold the ObjectActivationLock again
    orec := FObjectMap.find(id);
  end;
{$ENDIF}
  if orec <> nil then
    dorb_throw(ObjectAlreadyActive.Create as IORBException);

  if (id_uniqueness_policy.value <> MULTIPLE_ID) and FObjectMap.exists(p_servant) then
    dorb_throw(ServantAlreadyActive.Create as IORBException);
    
  // generate object reference
  iface := p_servant._primary_interface(id,self);
  por := TPoaObjectReference.Create(self,id,iface,p_servant);

  // Tell the servant that we're the one to ask for _this references
  p_servant.activated_in(self);

  // Insert into active object map
  FObjectMap.add(por,p_servant);
end;

function TPOA_impl.create_id_assignment_policy(
  value: IdAssignmentPolicyValue): IIdAssignmentPolicy;
begin
  result := TIDAssignmentPolicy.Create(ID_ASSIGNMENT_POLICY_ID,value)
end;

function TPOA_impl.create_implicit_activation_policy(
  value: ImplicitActivationPolicyValue): IImplicitActivationPolicy;
begin
  result := TImplicitActivationPolicy.Create(IMPLICIT_ACTIVATION_POLICY_ID,value)
end;


function TPOA_impl.create_id_uniqueness_policy(
  value: IdUniquenessPolicyValue): IIdUniquenessPolicy;
begin
  result := TIdUniquenessPolicy.Create(ID_UNIQUENESS_POLICY_ID,value)
end;

function TPOA_impl.create_servant_retention_policy(
  value: ServantRetentionPolicyValue): IServantRetentionPolicy;
begin
  result := TServantRetentionPolicy.Create(SERVANT_RETENTION_POLICY_ID,value)
end;

function TPOA_impl.create_lifespan_policy(
  value: LifespanPolicyValue): ILifespanPolicy;
begin
  result := TLifespanPolicy.Create(LIFESPAN_POLICY_ID,value)
end;

function TPOA_impl.create_POA(adapter_name: AnsiString;
  a_POAManager: IPOAManager; policies: PolicyList): IPOA;
var
  i : integer;
  sync: ISynchronized;
begin
  if GetDestroyed() then
    dorb_throw(BAD_INV_ORDER.Create(MinorNoCreatePOA, COMPLETED_NO));
  sync := TSynchronized.Create(FChildrenLock);
  for i := 0 to Pred(FChildList.Count) do
    if FChildList[i] = String(adapter_name) then
      dorb_throw(AdapterAlreadyExists.Create as IORBException);
  result := TPOA_impl.Create2(adapter_name,a_POAManager,policies,self,FORB);
end;

function TPOA_impl.create_reference(intf: RepositoryID): IORBObject;
var
  uid, fullid: AnsiString;
  por : IPOAObjectReference;
begin
  if id_assignment_policy.value <> SYSTEM_ID then
    dorb_throw(WrongPolicy.Create as IORBException);
  uid := idfactory.new_id();
  if lifespan_policy.value = PERSISTENT then
    fullid := oaprefix + uid
  else
    fullid := uid;
  por := TPOAObjectReference.Create(self,fullid,intf);
  result := por.ref;
end;

function TPOA_impl.create_reference_with_id(id: ObjectID;
  intf: RepositoryID): IORBObject;
var
  por : IPOAObjectReference;
begin
  por := TPOAObjectReference.Create(self,id,intf);
  result := por.ref;
  if (id_assignment_policy.value() = SYSTEM_ID) and
     (result = nil) then
    // it seems that supplied object id
    // was not generated by this orb/poa
    dorb_throw(BAD_PARAM.Create(MinorInvalidObjectId, COMPLETED_NO));
end;

function TPOA_impl.create_request_processing_policy(
  value: RequestProcessingPolicyValue): IRequestProcessingPolicy;
begin
  result := TRequestProcessingPolicy.Create(REQUEST_PROCESSING_POLICY_ID,value)
end;

function TPOA_impl.create_thread_policy(
  value: ThreadPolicyValue): IThreadPolicy;
begin
  result := TThreadPolicy.Create(THREAD_POLICY_ID,value)
end;

procedure TPOA_impl.deactivate_object(id: ObjectID);
var
  rec: IPOAObjectRecord;
  sync: ISynchronized;
begin
  if servant_retention_policy.value <> RETAIN then
    dorb_throw(WrongPolicy.Create as IORBException);

  sync := TSynchronized.Create(FObjectActivationLock);

  if not FObjectMap.exists(id) then
    dorb_throw(ObjectNotActive.Create as IORBException);

  rec := FObjectMap.find(id);
  rec.active := false;
  // there are no outstanding invocations, so remove it finaly
  if rec.invoke_cnt = 0 then
    remove_object(id);
end;

function TPOA_impl._find_POA(adapter_name: AnsiString;
  activate_it: Boolean): IPOA;
var
  i : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FChildrenLock);
  result := nil;
  // search adapter
  for i := 0 to Pred(FChildList.Count) do
    if FChildList[i] = String(adapter_name) then
      begin
        result := IPOA(Pointer(FChildList.Objects[i]));
        exit;
      end;
  if not activate_it or Not assigned(FAdapterActivator) then exit;
  if FState <> ACTIVE then exit;
  // We need to test if this POA is being destructed
  if GetDestroyed() then
    dorb_throw(exceptions.TRANSIENT.Create(MinorPOADestroyed, COMPLETED_NO));
  if not FAdapterActivator.unknown_adapter(self,adapter_name) then exit;
  // search again
  for i := 0 to Pred(FChildList.Count) do
    if FChildList[i] = String(adapter_name) then
      begin
        result := IPOA(Pointer(FChildList.Objects[i]));
        exit;
      end;
end;

function TPOA_impl.find_POA(adapter_name: AnsiString;
  activate_it: Boolean): IPOA;
begin
  try
    result := _find_POA(adapter_name,activate_it);
  except
    on E: SystemException do
      dorb_throw(OBJ_ADAPTER.Create(MinorSystemExceptionInUnknownAdapter, COMPLETED_NO));
  end; { try/except }
  if result = nil then
    dorb_throw(AdapterNonExistent.Create as IORBException);
end;

function TPOA_impl.get_servant: IServant;
begin
  if request_processing_policy.value <> USE_DEFAULT_SERVANT then
    dorb_throw(WrongPolicy.Create as IORBException);
  if FDefaultServant = nil then
    dorb_throw(NoServant.Create as IORBException);
  result := FDefaultServant;
end;

function TPOA_impl.get_servant_manager: IServantManager;
begin
  if request_processing_policy.value <> USE_SERVANT_MANAGER then
    dorb_throw(WrongPolicy.Create as IORBException);
  result := FServantManager
end;

function TPOA_impl.id_to_reference(id: ObjectID): IORBObject;
var
  rec: IPOAObjectRecord;
  sync: ISynchronized;
begin
  if servant_retention_policy.value <> RETAIN then
    dorb_throw(WrongPolicy.Create as IORBException);

  sync := TSynchronized.Create(FObjectActivationLock);

  rec := FObjectMap.find(id);
  if rec = nil then
    dorb_throw(ObjectNotActive.Create as IORBException);
  result := rec.por.ref;
end;

function TPOA_impl.id_to_servant(id: ObjectID): IServant;
var
  rec: IPOAObjectRecord;
  sync: ISynchronized;
begin
  if servant_retention_policy.value <> RETAIN then
    dorb_throw(WrongPolicy.Create as IORBException);

  sync := TSynchronized.Create(FObjectActivationLock);

  rec := FObjectMap.find(id);
  if rec = nil then
    dorb_throw(ObjectNotActive.Create as IORBException);
  result := rec.por.servant;
end;

function TPOA_impl.reference_to_id(reference: IORBObject): ObjectID;
var
  por : IPOAObjectReference;
begin
  por := TPOAObjectReference.Create(self,reference);
  if not por.is_legal() or not por.in_poa(FOaid) then
    dorb_throw(WrongAdapter.Create() as IORBException);
  result := por.id;
end;

function TPOA_impl.reference_to_servant(reference: IORBObject): IServant;
var
  por : IPOAObjectReference;
begin
  por := TPOAObjectReference.Create(self,reference);
  if not por.is_legal() or not por.in_poa(FOaid) then
    dorb_throw(WrongAdapter.Create() as IORBException);
  result := por.servant;
end;

function TPOA_impl.servant_to_id(p_servant: IServant): ObjectID;
var
  rec: IPOAObjectRecord;
  sync: ISynchronized;
  inside: Boolean;
begin
  // Check if we are inside context of POA invocation
  // or if all required policies are presented
  inside := (POA_current <> nil) and POA_current.iscurrent();
  if not inside and
    (not ((request_processing_policy.value() = USE_DEFAULT_SERVANT) or
         ((servant_retention_policy.value() = RETAIN) and
         ((implicit_activation_policy.value() = IMPLICIT_ACTIVATION) or
         (id_uniqueness_policy.value() = UNIQUE_ID))))) then
    dorb_throw(WrongPolicy.Create());

  if (request_processing_policy.value = USE_DEFAULT_SERVANT) and
     (p_servant = FDefaultServant) and
     assigned(POACurrent) and
     POACurrent.iscurrent and
     (POACurrent.get_serv = p_servant) then
    begin
      result := POACurrent.get_object_id;
      exit;
    end;

  if servant_retention_policy.value = RETAIN then begin
    sync := TSynchronized.Create(FObjectActivationLock);

    // Search in active map
    rec := FObjectMap.find(p_servant);

    // If UNIQUE_ID and servant is active
    //
    if (rec <> nil) and rec.active and (id_uniqueness_policy.value() = UNIQUE_ID) then begin
      result := rec.por.id;
      exit;
    end;

    // If IMPLICIT_ACTIVATION && MULTIPLE_ID || servant is not active,
    // the servant is activated
    if (implicit_activation_policy.value() = IMPLICIT_ACTIVATION) and
       (not ((rec <> nil) and rec.active) or (id_uniqueness_policy.value() = MULTIPLE_ID)) then begin
      result := activate_object(p_servant);
      exit;
    end;
  end;
  dorb_throw(ServantNotActive.Create as IORBException);
end;

function TPOA_impl.servant_to_reference(p_servant: IServant): IORBObject;
var
  rec: IPOAObjectRecord;
  id: ObjectID;
  sync: ISynchronized;
begin
  id := '';
  result := nil;

  if assigned(POACurrent) and
     POACurrent.iscurrent and
     (POACurrent.get_serv = p_servant) then
    begin
      result := POACurrent.make_ref;
      exit;
    end;

  if (servant_retention_policy.value <> RETAIN) or
     ((implicit_activation_policy.value <> IMPLICIT_ACTIVATION) and
     (id_uniqueness_policy.value <> UNIQUE_ID))  then
     dorb_throw(WrongPolicy.Create as IORBException);

  sync := TSynchronized.Create(FObjectActivationLock);
  rec := FObjectMap.find(p_servant);

  if (implicit_activation_policy.value = IMPLICIT_ACTIVATION) and
    ((id_uniqueness_policy.value = MULTIPLE_ID) or not assigned(rec)) then
     begin
       id := activate_object(p_servant);
       rec := FObjectMap.find(id);
     end;

  if assigned(rec) then
    begin
      result := rec.por.ref;
      Exit;
    end;

  dorb_throw(ServantNotActive.Create as IORBException);

end;

procedure TPOA_impl.set_Activator(val: IAdapterActivator);
begin
  FAdapterActivator := val;
end;

{** Sets default Servant }
procedure TPOA_impl.set_servant(p_servant: IServant);
begin
  FDefaultServant := p_servant;
end;

procedure TPOA_impl.set_servant_manager(imgr: IServantManager);
begin
  if request_processing_policy.value <> USE_SERVANT_MANAGER then
    dorb_throw(WrongPolicy.Create as IORBException);

  if imgr = nil then
    dorb_throw(OBJ_ADAPTER.Create());

  if ((servant_retention_policy.value() = RETAIN) and
       not imgr._is_a('IDL:omg.org/PortableServer/ServantActivator:1.0')) or
     ((servant_retention_policy.value() = NON_RETAIN) and
       not imgr._is_a('IDL:omg.org/PortableServer/ServantLocator:1.0')) then
    dorb_throw(OBJ_ADAPTER.Create());

  if FServantManager <> nil then
    dorb_throw(BAD_INV_ORDER.Create(MinorServantManagerAlreadySet, COMPLETED_NO));

  FServantManager := imgr;
end;

function TPOA_impl.the_Activator: IAdapterActivator;
begin
  result := FAdapterActivator
end;

function TPOA_impl.the_children: POAList;
var
  i : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FChildrenLock);
  setLength(result,FChildList.count);
  for i := 0 to Pred(FChildList.count) do
    result[i] := IPOA(Pointer(FChildList.objects[i]));
end;

function TPOA_impl.the_name: AnsiString;
begin
  result := FName
end;

function TPOA_impl.the_parent: IPOA;
begin
  result := FParent
end;

destructor TPOA_impl.Destroy();
begin
  FObjectActivationLock.lock();
  try
    FObjectMap := nil;
  finally
    FObjectActivationLock.unlock();
  end; { try/finally }
  FreeAndNil(FChildList);
  FreeAndNil(FObjectActivationLock);
  FreeAndNil(FSerializeInvoke);
  FreeAndNil(FDestroyStateMutex);
  FreeAndNil(FThreadMonitor);
  FreeAndNil(FChildrenLock);
  inherited;
end;

procedure TPOA_impl.builtin_is_a(const ir: IInvocationRecord; const servant: IServant);
var
  req: IServerRequest;
  params : INVList;
  repoid : RepositoryId;
  val : Boolean;
  a : IAny;
begin
  req := ir.make_dyn_req(self);
  FORB.create_list(0,params);
  params.add(ARG_IN);
  params.item(0).argument.set_type(_tc_string);
  if req.arguments(params) then begin
    params.item(0).argument.to_string(repoid);
    try
      val := servant._is_a(repoid);
    except
      on e: SystemException do
        begin
          req.set_exception(e);
          exit;
        end;
    end;
    a := CreateAny;
    a.put_boolean(val);
    req.set_result(a);
  end;
end;

procedure TPOA_impl.builtin_non_existent(const ir: IInvocationRecord; const servant: IServant);
var
  req: IServerRequest;
  params : INVList;
  val : Boolean;
  a : IAny;
begin
  req := ir.make_dyn_req(self);
  params := TNVList.Create();
  if req.arguments(params) then begin
    try
      val := servant._non_existent();
    except
      on e: SystemException do
        begin
          req.set_exception(e);
          exit;
        end;
    end;
    a := TAny.Create;
    a.put_boolean(val);
    req.set_result(a);
  end
  else
    Assert(false);
end;

procedure TPOA_impl.builtin_interface(const ir: IInvocationRecord; const servant: IServant);
var
  req: IServerRequest;
  params : INVList;
  val : IInterfaceDef;
  a : IAny;
begin
  req := ir.make_dyn_req(self);
  params := TNVList.Create();
  if req.arguments(params) then begin
    try
      val := servant._get_interface();
    except
      on e: SystemException do
        begin
          req.set_exception(e);
          exit;
        end;
    end;
    if val = nil then
      begin
        req.set_exception(SystemException.Create_type(st_OBJ_ADAPTER,0,COMPLETED_NO) as IORBException);
        exit;
      end;
    a := TAny.Create;
    // it will be implemented after IR
    assert(false);
    req.set_result(a);
  end
  else
    Assert(false);
end;

function TPOA_impl.builtin_invoke(const ir: IInvocationRecord; const servant: IServant): Boolean;
var
  opname: AnsiString;
begin
  result := false;
  opname := ir.get_orequest.op_name;
  if strcomp(PAnsiChar(opname),'_is_a') = 0 then
    begin
      builtin_is_a(ir,servant);
      result := true;
    end
  else if strcomp(PAnsiChar(opname),'_non_existent') = 0 then
    begin
      builtin_non_existent(ir,servant);
      result := true;
    end
  else if strcomp(PAnsiChar(opname),'_interface') = 0 then
    begin
      builtin_interface(ir,servant);
      result := true;
    end;
end;

(*
 * This is a callback from POAObjectReference. When a new reference
 * is to be generated, we are asked for the IOR template to use. This
 * is either our own in a transient POA, or the POA Mediator's in a
 * persistent one.
 *)
function TPOA_impl.ior_template(): IIOR;
begin
  if (lifespan_policy.value = PERSISTENT) and (POAMediator <> nil) then
    result := POAMediatorIOR
  else
    result := FORB.ior_template();
end;

procedure TPOA_impl.poa_manager_callback(state: POAManagerState;etherealize_objects: Boolean; wait_for_completion: Boolean);
var
  rec: IInvocationRecord;
begin
  if GetDestroyed() then
    Exit;

  FState := state;

  (*
   * If any POA becomes active, we call back the mediator, which
   * may have started us up, and which may have invocations queued for
   * us.
   *)
  if (state = ACTIVE) and not Ever_been_active and (POAMediator <> nil) then begin
    Ever_been_active := true;
    POAMediator.activate_impl(poa_impl_name);
  end;
  
  case state of
    HOLDING: { nothing to do};
    ACTIVE: while FInvocationQueue.Count > 0 do
        begin
          rec := FInvocationQueue[0] as IInvocationRecord;
          FInvocationQueue.Delete(0);
          rec.exec(self);
        end;
    INACTIVE: if etherealize_objects then
      etherealize;
    DISCARDING: while FInvocationQueue.Count > 0 do
        begin
          rec := FInvocationQueue[0] as IInvocationRecord;
          FInvocationQueue.Delete(0);
          rec.exec(self);
        end;
    else
      assert(false,'not implemented');
  end;
end;

function TPOA_impl.narrow_helper(const str: RepositoryId): Pointer;
begin
  if strcomp(PAnsiChar(str),'IDL:omg.org/PortableServer/POA:1.0') = 0 then
    result := Pointer(self as IPOA)
  else
    result := nil;
end;

procedure TPOA_impl.perform_invoke(ir: IInvocationRecord);
var
  rec : IPOAObjectRecord;
  servant : IServant;
  svr : IServerRequest;
  svrb : IServerRequestBase;
  ex: IORBException;
  sav : IServantActivator;
  //ref: IPOAObjectReference;
  slo : IServantLocator;
  c : Cookie;
begin
  c := nil;

  FObjectActivationLock.lock();
  try
    if (servant_retention_policy.value = RETAIN) then begin
      rec := IPOAObjectRecord(FObjectMap.Find(ir.get_por));
      if assigned(rec) and rec.active then begin
        servant := rec.serv;
        assert(servant <> nil);
        ir.get_por.set_ref(rec.por.ref);
      end;
    end;
    // default servant
    if not assigned(servant) and (request_processing_policy.value = USE_DEFAULT_SERVANT) then begin
      if not assigned(FDefaultServant) then begin
        svr := ir.make_dyn_req(self);
        svr.set_exception(OBJ_ADAPTER.Create(MinorNoDefaultServant, COMPLETED_NO) as IORBException);
        exit;
      end;
      servant := FDefaultServant;
    end;

    // servant adapter
    if not assigned(servant) and (request_processing_policy.value = USE_SERVANT_MANAGER) then begin
      if servant_retention_policy.value = RETAIN then begin
        sav := TServantActivator._narrow(FServantManager);
        if not assigned(sav) then begin
          svr := ir.make_dyn_req(self);
          svr.set_exception(OBJ_ADAPTER.Create(MinorNoServantManager, COMPLETED_NO) as IORBException);
          exit;
        end;
        try
          if (thread_policy.value() = SINGLE_THREAD_MODEL) or
             (thread_policy.value() = MAIN_THREAD_MODEL) then begin
            // not optimal but reliable solution
            // for all POAs with single-thread policy
            // we will lock global servant manager lock
            // for main-thread policy this solution is optimal
            // and right
            ServantManagerLock.lock;
            try
              servant := sav.incarnate(ir.get_por.id,self);
            finally
              ServantManagerLock.unlock;
            end; { try/finally }
          end
          else
            servant := sav.incarnate(ir.get_por.id,self);
        except
          on e1: SystemException do begin
            svr := ir.make_dyn_req(self);
            svr.set_exception(SystemException.Create(e1));
            exit;
          end;
          on e2: ForwardRequest do begin
            FORB.answer_invoke(ir.id,InvokeForward,e2.forward_reference,ir.get_orequest,0);
            exit;
          end;
        end;
        if not assigned(servant) then begin
          svr := ir.make_dyn_req(self);
          svr.set_exception(OBJ_ADAPTER.Create(MinorServantNotFound, COMPLETED_NO) as IORBException);
          exit;
        end;
        if (id_uniqueness_policy.value() = UNIQUE_ID) and FObjectMap.exists(servant) then begin
          // Is servant already active? => error
          svr := ir.make_dyn_req(self);
          svr.set_exception(OBJ_ADAPTER.Create(0, COMPLETED_NO) as IORBException);
          exit;
        end;
        (*
         * Activate new servant and place in Active Object Map
         *)
        activate_object_with_id(ir.get_por.id, servant);
        rec := FObjectMap.find(ir.get_por);

        // The new servant is placed in the active map
        //ref := TPOAObjectReference.Create(ir.get_por);
        //rec := FObjectMap.add(ref,servant);
      end
      else begin
        // NON_RETAIN
        slo := TServantLocator._narrow(FServantManager);
        if not assigned(slo) then begin
          svr := ir.make_dyn_req(self);
          svr.set_exception(OBJ_ADAPTER.Create(MinorNoServantManager, COMPLETED_NO) as IORBException);
          exit;
        end;
        try
          if (thread_policy.value() = SINGLE_THREAD_MODEL) or
             (thread_policy.value() = MAIN_THREAD_MODEL) then begin
            // not optimal but reliable solution
            // for all POAs with single-thread policy
            // we will lock global servant manager lock
            // for main-thread policy this solution is optimal
            // and right
            ServantManagerLock.lock;
            try
              servant := slo.preinvoke(ir.get_por.id,self,AnsiString(ir.get_orequest.op_name),c);
            finally
              ServantManagerLock.unlock;
            end; { try/finally }
          end
          else
            servant := slo.preinvoke(ir.get_por.id,self,AnsiString(ir.get_orequest.op_name),c);
        except
          on e1: SystemException do begin
            svr := ir.make_dyn_req(self);
            svr.set_exception(SystemException.Create(e1));
            exit;
          end;
          on e2: ForwardRequest do begin
            FORB.answer_invoke(ir.id,InvokeForward,e2.forward_reference,ir.get_orequest,0);
            exit;
          end;
        end;
        if not assigned(servant) then begin
          svr := ir.make_dyn_req(self);
          svr.set_exception(OBJ_ADAPTER.Create(MinorServantNotFound, COMPLETED_NO) as IORBException);
          exit;
        end;
      end;
    end;

    if servant = nil then begin
      // cannot serve request
      svr := ir.make_dyn_req(self);
      ex := OBJECT_NOT_EXIST.Create(MinorCannotDispatch, COMPLETED_NO);
      svr.set_exception(ex);
      exit;
    end;
    // this make sure nobody is going to remove the object
    if (servant_retention_policy.value = RETAIN) then
      rec.invoke_cnt := Succ(rec.invoke_cnt);
  finally
    FObjectActivationLock.unlock();
  end; { try/finally }

  POACurrent._set(self,ir.get_por,servant);
  if IncrementRequestCount() then begin
    if not builtin_invoke(ir,servant) then begin
      svrb := ir.make_req(self, servant);
      // serialize invoke
      if thread_policy.value = SINGLE_THREAD_MODEL then begin
        FSerializeInvoke.lock();
        try
          servant.doinvoke(svrb);
        finally
          FSerializeInvoke.unlock();
        end; { try/finally }
      end
      else if thread_policy.value = MAIN_THREAD_MODEL then begin
        GlobalInvokeLock.lock;
        try
          servant.doinvoke(svrb);
        finally
          GlobalInvokeLock.unlock;
        end; { try/finally }
      end
      else
        servant.doinvoke(svrb);
    end;

    if DecrementRequestCount() then
      CompleteDestroy();
  end;
  if POACurrent <> nil then
    POACurrent.unset();

  if assigned(slo) then begin
    if (thread_policy.value() = SINGLE_THREAD_MODEL) or
       (thread_policy.value() = MAIN_THREAD_MODEL) then begin
      // not optimal but reliable solution
      // for all POAs with single-thread policy
      // we will lock global servant manager lock
      // for main-thread policy this solution is optimal
      // and right
      ServantManagerLock.lock;
      try
        slo.postinvoke(ir.get_por.id,self,AnsiString(ir.get_orequest.op_name),c,servant);
      finally
        ServantManagerLock.unlock;
      end; { try/finally }
    end
    else
      slo.postinvoke(ir.get_por.id,self,AnsiString(ir.get_orequest.op_name),c,servant);
  end;

  if (servant_retention_policy.value = RETAIN) then begin
    FObjectActivationLock.lock();
    try
      rec.invoke_cnt := Pred(rec.invoke_cnt);
      if (rec.invoke_cnt = 0) and not rec.active then
        remove_object(ir.get_por.id);
    finally
      FObjectActivationLock.unlock();
    end; { try/finally }
  end;
end;

procedure TPOA_impl.local_invoke(const ir: IInvocationRecord);
var
  svr: IServerRequest;
  exc: IORBException;
  obj, localRef: IORBObject;
  key: ObjectID;
  len: _ulong;
  theior: IIOR;
  cname: AnsiString;
  poa: IPOA;
begin
  (*
   * If we are in a persistent POA that is being destructed, reply
   * with a LocationForward to myself, which will eventually cause
   * the poa to be reactivated.
   *)

  if ((lifespan_policy.value = PERSISTENT) or not ir.get_por.in_poa(FOaid)) and GetDestroyed() then begin
    if POAMediator = nil then begin
      svr := ir.make_dyn_req(Self);
      svr.set_exception(SystemException.Create_type(st_OBJECT_NOT_EXIST, 0, COMPLETED_NO) as IORBException);
    end
    else begin
      obj := ir.get_por().ref();
      theior := TIOR.Create(POAMediatorIOR);
      key := obj._ior().get_profile().objkey(len);
      theior.set_objectkey(key, len);
      // XXX obj.repoid() is empty ...
      theior.set_objectid(obj._ior().objid());
      localRef := TORBObject.Create(theior);
      FORB.answer_invoke(ir.id(), InvokeForward, localRef, ir.get_orequest(), 0);
    end;
    Exit;
  end;

  case FState of
    ACTIVE: ;
    HOLDING: begin
        FInvocationQueue.Add(ir);
        exit;
      end;
    DISCARDING: begin
        svr := ir.make_dyn_req(self);
        exc := exceptions.TRANSIENT.Create(MinorRequestDiscarded, COMPLETED_NO);
        svr.set_exception(exc);
        exit;
      end;
    INACTIVE: begin
        (*
         * The Inactive state is not a temporary state. In a transient POA,
         * we can safely return an OBJECT_NOT_EXIST exception. In a persistent
         * POA, we queue the request. After POA destruction, the special
         * rule above sends a LocationForward to ourselves, eventually
         * causing server reactivation.
         * However, we might be here because we want to call an Adapter
         * Activator, which might be supposed to activate a persistent
         * POA, so we also queue the request if it is not for us.
         *)
        if (lifespan_policy.value() = PERSISTENT) or
            not ir.get_por().in_poa(FOaid) then
          FInvocationQueue.Add(ir)
        else begin
          svr := ir.make_dyn_req(self);
          exc := OBJ_ADAPTER.Create(MinorSystemExceptionInUnknownAdapter, COMPLETED_NO);
          svr.set_exception(exc);
        end;
        Exit;
      end;
    else
      assert(false);
  end;

  // if request is not for us but for descendant, try to call adaptor activator
  if not ir.get_por.in_poa(FOaid) then begin
    cname := ir.get_por.next_descendant_poa(PAnsiChar(AnsiString(fqn)), PAnsiChar(AnsiString(poa_impl_name)));
    try
      poa := _find_POA(cname, true);
    except
      on E: SystemException do begin
        svr := ir.make_dyn_req(self);
        exc := OBJ_ADAPTER.Create(MinorSystemExceptionInUnknownAdapter, COMPLETED_NO);
        svr.set_exception(exc);
        Exit;
      end;
    end; { try/except }
  end;

  if poa <> nil then
    // Okay, next POA in chain successfully activated
    poa.perform_invoke(ir)
  else
    // Request for an object in this POA -- Fire away!
    perform_invoke(ir);
end;

function TPOA_impl.activate_object(p_servant: IServant): ObjectID;
var
  iface : RepositoryID;
  uid,fulluid: ObjectID;
  por : IPOAObjectReference;
  sync: ISynchronized;
begin
  Assert(p_servant <> nil);
  sync := TSynchronized.Create(FObjectActivationLock);

  if (id_assignment_policy.value <> SYSTEM_ID) or
     (servant_retention_policy.value <> RETAIN) then
    dorb_throw(WrongPolicy.Create as IORBException);

  if (id_uniqueness_policy.value <> MULTIPLE_ID) and
     FObjectMap.exists(p_servant) then
    dorb_throw(ServantAlreadyActive.Create as IORBException);

  uid := idfactory.new_id;

  if lifespan_policy.value = PERSISTENT then
    fulluid := OAPrefix + uid
  else
    fulluid := uid;

  iface := p_servant._primary_interface(fulluid,self);
  por := TPOAObjectReference.Create(self,fulluid,iface,p_servant);
  p_servant.activated_in(self);
  FObjectMap.add(por,p_servant);
  result := fulluid;
end;

class function TPOA_impl._narrow(const obj : IORBObject): IPOA;
var
  ptr: Pointer;
begin
  result := nil;
  if (obj <> nil) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/PortableServer/POA:1.0');
      if ptr <> nil then
        result := IPOA(ptr);
    end;
end;

function TPOA_impl.get_oaid(): ObjectID;
begin
  result := FOaid;
end;

procedure TPOA_impl._destroy(etherealize_objects, wait_for_completion: Boolean);
var
  i, childCount: integer;
  tmpPOA: IPOA;
begin
  if GetDestroyed() then
    dorb_throw(st_OBJECT_NOT_EXIST);
  // If wait_for_completion is TRUE and the current thread is in an
  // invocation context dispatched from some POA belonging to the
  // same ORB as this POA, the BAD_INV_ORDER exception is raised and
  // POA destruction does not occur.
  if wait_for_completion and POA_Current.iscurrent() then
    dorb_throw(st_BAD_INV_ORDER);

  // Mark the POA as destroy pending. Only one thread will continue.
  // All others will wait (if waitForCompletion is true) until the
  // POA destruction is complete.
  if MarkDestroyPending(etherealize_objects, wait_for_completion) then begin

    (*
     * Destroy child POAs
     *)
    FChildrenLock.lock;
    try
      childCount := FChildList.Count - 1;
      (*while FChildList.Count <> 0 do
          IPOA(Pointer(FChildList.Objects[0]))._destroy(etherealize_objects, wait_for_completion);*)
      for i := childCount downto 0 do begin
        try
          tmpPOA := IPOA(Pointer(FChildList.Objects[i]));
          tmpPOA._destroy(etherealize_objects, wait_for_completion);
          tmpPOA := nil;
        except
          on E: OBJECT_NOT_EXIST do ;
            // This indicates that destroy has already been called
            // on the child POA. Since we want the child POA to be
            // destroyed anyway we can ignore the exception and
            // proceed with the rest of the children.
        end; { try/except }
      end; { for }
    finally
      FChildrenLock.unlock;
    end;

    // If wait_for_completion is FALSE, the destroy operation
    // destroys the POA and its children but waits neither for
    // active requests to complete nor for etherealization to
    // occur. If destroy is called multiple times before
    // destruction is complete (because there are active
    // requests), the etherealize_objects parameter applies only
    // to the first call of destroy. Subsequent calls with
    // conflicting etherealize_objects settings use the value of
    // etherealize_objects from the first call. The
    // wait_for_completion parameter is handled as defined above for
    // each individual call (some callers may choose to block,
    // while others may not).
    //
    // We only return if there are outstanding requests. In this
    // case when the last outstanding request is completed then
    // destruction of the the POA will complete.
    if not wait_for_completion and HasPendingRequests() then
      Exit;

    CompleteDestroy();
  end;
end;

function TPOA_impl.the_POAManager: IPOAManager;
begin
  result := FManager;
end;

procedure TPOA_impl.answer_invoke(id: ORBMessageID; const obj: IORBObject;
  const req: IORBRequest; stat: TInvokeStatus);
begin
  FORB.answer_invoke(id, stat, nil, req, 0);
end;

function TPOA_impl.bind(id: ORBMessageID; const repoid: RepositoryId;
  const oid: IObjectTag; const addr: IAddress): Boolean;
var
  i : integer;
  rec : IPOAObjectRecord;
  pif : AnsiString;
begin
  result := false;
  if (addr <> nil) and (addr.is_local) then exit;
  if servant_retention_policy.value = RETAIN then begin
    FObjectActivationLock.lock();
    try
      for i := 0 to Pred(FObjectMap.Count) do
        begin
          rec := FObjectMap.item(i);
          if not rec.serv._is_a(repoid) then
            begin
              pif := rec.serv._primary_interface(rec.por.id,self);
              if strcomp(PAnsiChar(repoid),PAnsiChar(pif)) <> 0 then
                continue;
            end;
          if (oid.get_length = 0) or (strlcomp(PAnsiChar(oid.get_bytes),PAnsiChar(rec.por.id),oid.get_length)=0) then
            begin
              FORB.answer_bind(id,LocateHere,rec.por.ref);
              result := true;
              exit;
            end;
        end;
    finally
      FObjectActivationLock.unlock();
    end; { try/finally }
  end;
  // ask children ...
  result := true;
  FChildrenLock.lock;
  try
    for i := 0 to pred(FChildList.Count) do
      if (IPOA(Pointer(FChildList.Objects[i]))).bind(id,repoid,oid,addr) then
        exit;
  finally
    FChildrenLock.unlock;
  end;
  result := false;
end;

procedure TPOA_impl.cancel(id: ORBMessageID);
var
  rec: IInvocationRecord;
  i : integer;
  sync: ISynchronized;
begin
  for i := 0 to Pred(FInvocationQueue.Count) do
    begin
      rec := FInvocationQueue[i] as IInvocationRecord;
      if ORB_Instance.get_msgid(rec.id) = ORB_Instance.get_msgid(id) then
        FInvocationQueue.Remove(rec);
    end;
  sync := TSynchronized.Create(FChildrenLock);
  for i := 0 to Pred(FChildList.Count) do
    IPOA(Pointer(FChildList.objects[i])).cancel(id);
end;

function TPOA_impl.has_object(const obj: IORBObject): Boolean;
var
  l, tmpLen: _ulong;
  key: AnsiString;
begin
  result := false;
  if (obj = nil) or (obj._IOR = nil) or (obj._IOR.get_profile(TAG_ANY) = nil) then
    Exit;

  key := obj._IOR.get_profile(TAG_ANY).objkey(l);
  if (key = '') or (l < 1) then
    Exit;

  tmpLen := _ulong(Length(OAPrefix));
  if (tmpLen > 0) and (l >= tmpLen) then begin
    if StrLComp(PAnsiChar(key), PAnsiChar(OAPrefix), tmpLen) = 0 then begin
      result := true;
      Exit;
    end;
  end;

  tmpLen := _ulong(Length(poa_impl_name));
  if (tmpLen > 0) and (l >= tmpLen) then begin
    if (StrLComp(PAnsiChar(key), PAnsiChar(poa_impl_name), tmpLen) = 0) and
      ((l = tmpLen) or (key[tmpLen + 1] = '/')) then begin
      result := true;
      Exit;
    end;
  end;
end;

function TPOA_impl.invoke(id: ORBMessageID; const obj: IORBObject;
  const req: IORBRequest; const pr: IPrincipal; response_exp: Boolean): Boolean;
var
  por: IPOAObjectReference;
  i : integer;
  p,iter : IPOA;
  exc : ISystemException;
  ir : IInvocationRecord;
  svr: IServerRequest;
  cname: PAnsiChar;
begin
  result := false;
  assert(IPOA(self) = _the_root_poa);
  por := TPOAObjectReference.Create(self,obj);
  assert(por.is_legal);

  if GetDestroyed() then
    begin
      ir := TInvocationRecord.Create(id,por,req,pr);
      FInvocationQueue.Add(ir);
      exit;
    end;

  p := nil;
  AllPOAsSync.rdlock();
  try
    i := ALLPOAs.IndexOf(String(por.poa_name));
    if i >= 0 then
      p := IPOA(Pointer(ALLPOAs.Objects[i]))
  finally
    AllPOAsSync.unlock();
  end; { try/finally }

  if p = nil then begin
    // only for persistent objects
    if (poa_impl_name = '') or (por.poa_name = '/') then begin
      ir := TInvocationRecord.Create(id,por,req,pr);
      svr := ir.make_dyn_req(self);
      exc := OBJECT_NOT_EXIST.Create(MinorCannotDispatch, COMPLETED_NO);
      svr.set_exception(exc);
      result := true;
      exit;
    end;
    // search in child POAs
    p := self;
    while true do begin
      if por.in_poa(p.get_oaid()) then
        Break;
      cname := por.next_descendant_poa(PAnsiChar(AnsiString(p.fqn)),PAnsiChar(poa_impl_name));
      try
        iter := p.find_POA(cname,false);
      except
        on e: SystemException do begin
          ir := TInvocationRecord.Create(id,por,req,pr);
          svr := ir.make_dyn_req(self);
          exc := OBJ_ADAPTER.Create(MinorSystemExceptionInUnknownAdapter, COMPLETED_NO);
          svr.set_exception(exc);
          result := true;
          exit;
        end;
        on E: AdapterNonExistent do begin
          ir := TInvocationRecord.Create(id,por,req,pr);
          svr := ir.make_dyn_req(self);
          exc := OBJECT_NOT_EXIST.Create();
          svr.set_exception(exc);
          result := true;
          exit;
        end;
      end;
      if iter = nil then
        Break;
      p := iter;
    end;
  end;
  // found
  ir := TInvocationRecord.Create(id,por,req,pr);
  p.local_invoke(ir);
  result := true;
end;

function TPOA_impl.is_local: Boolean;
begin
  result := true;
end;

procedure TPOA_impl.shutdown(WaitForCompletion: Boolean);
begin
  MTDORBLogger.Info('TPOA_impl.shutdown');
  _destroy(true, WaitForCompletion);
  FORB.answer_shutdown(Self);
  MTDORBLogger.Info('TPOA_impl.shutdown complete');
end;

{**
 * skeleton() calls the servant's generated _make_stub method which
 * returns a POA-specific skeleton that invokes the servant directly
 * after asking the POA whether the invocation may proceed
}
function TPOA_impl.skeleton(const obj: IORBObject): IORBObject;
var
  por: IPOAObjectReference;
  i : integer;
  p : IPOA;
  rec: IPOAObjectRecord;
begin
  result := nil;
  assert((self as IPOA) = _the_root_poa);
  por := TPOAObjectReference.Create(Self, obj);
  Assert(por.is_legal());

  AllPOAsSync.rdlock();
  try
    i := ALLPOAs.IndexOf(String(por.poa_name));
    if i >= 0 then
      p := IPOA(Pointer(ALLPOAs.Objects[i]));
  finally
    AllPOAsSync.unlock();
  end; { try/finally }
  if p = nil then
    Exit;

  p.ObjectActivationLock.lock();
  try
    rec := p.ActiveObjectMap.find(p,obj);
    if rec <> nil then
      result := rec.serv._make_stub(p, obj)
    else if (p._request_processing_policy.value = USE_DEFAULT_SERVANT) and assigned(p.get_servant) then
      result := p.get_servant._make_stub(p,obj);
  finally
    p.ObjectActivationLock.unlock();
  end; { try/finally }
end;

procedure TPOA_impl.etherealize();
var
  sav: IServantActivator;
  rec : IPOAObjectRecord;
  serv: IServant;
  por: IPOAObjectReference;
  other : Boolean;
begin
 (*
  * Clean up the Active Object Map. If RETAIN and USE_SERVANT_MANAGER,
  * call etherealize() on the Servant Activator.
  *)
  if (servant_retention_policy.value = RETAIN) and
     (request_processing_policy.value = USE_SERVANT_MANAGER) then
    sav := TServantActivator._narrow(FServantManager);

  FObjectActivationLock.lock();
  try
    while FObjectMap.count > 0 do
      begin
        rec := FObjectMap.pop;
        if sav <> nil then
          begin
            serv := rec.serv;
            por := rec.por;
            other := FObjectMap.exists(serv);
            try
              if (thread_policy.value() = SINGLE_THREAD_MODEL) or
                 (thread_policy.value() = MAIN_THREAD_MODEL) then begin
                // not optimal but reliable solution
                // for all POAs with single-thread policy
                // we will lock global servant manager lock
                // for main-thread policy this solution is optimal
                // and right
                ServantManagerLock.lock;
                try
                  sav.etherealize(por.id,self,serv,true,other);
                finally
                  ServantManagerLock.unlock;
                end; { try/finally }
              end
              else
                sav.etherealize(por.id,self,serv,true,other);
            except
            end;
          end;
        // remove references
        rec.serv.activated_in(nil);
        rec.por._destroy();
        rec._destroy();
      end;
  finally
    FObjectActivationLock.unlock();
  end; { try/finally }
end;

function TPOA_impl.activate_for_this(p_servant: IServant): IORBObject;
var
  rec: IPOAObjectRecord;
  id : ObjectID;
  sync: ISynchronized;
begin
  if (servant_retention_policy.value <> RETAIN) or
     (id_uniqueness_policy.value <> UNIQUE_ID) then
    dorb_throw(WrongPolicy.Create() as IORBException);

  sync := TSynchronized.Create(FObjectActivationLock);
  
  rec := FObjectMap.find(p_servant);
  if rec = nil then
    begin
      if implicit_activation_policy.value <> IMPLICIT_ACTIVATION then
        dorb_throw(WrongPolicy.Create() as IORBException);
      id := activate_object(p_servant);
      rec := FObjectMap.find(id);
      assert(rec<>nil);
    end;
  result := rec.por.ref
end;

procedure TPOA_impl._postinvoke;
begin
  POACurrent.unset;
end;

function TPOA_impl._preinvoke(const obj: IORBObject): IServant;
var
  rec : IPOAObjectRecord;
  por: IPOAObjectReference;
  serv: IServant;
  sync: ISynchronized;
begin
  result := nil;
  sync := TSynchronized.Create(FObjectActivationLock);
  case FState of
    HOLDING,DISCARDING: dorb_throw(SystemException.Create_type(st_TRANSIENT) as IORBException);
    INACTIVE : exit;
  end;
  rec := FObjectMap.find(self,obj);
  if assigned(rec) and rec.active then
    begin
      serv := rec.serv;
      por := rec.por;
    end
  else if (request_processing_policy.value = USE_DEFAULT_SERVANT) and assigned(FDefaultServant) then
    begin
      serv := FDefaultServant;
      por := TPOAObjectReference.Create(self,obj);
    end
  else
    exit;
  POACurrent._set(self,por,serv);
  result := serv;
end;

{** this methode has always to be called with the ObjectActivationLock held}
procedure TPOA_impl.remove_object(const id: ObjectID);
var
  rec: IPOAObjectRecord;
  delref: IDeletionRecord;
  other: boolean;
  sav: IServantActivator;
  serv: IServant;
  por: IPOAObjectReference;
begin
  // we made a mistake somewhere is this should ever happen
  Assert(FObjectMap.exists(id));
  rec := FObjectMap.del(id);
  delref := rec.delref;
  other := FObjectMap.exists(rec.serv());
  // Etherealize object
  if FServantManager <> nil then begin
    sav := TServantActivator._narrow(FServantManager);
    Assert(sav <> nil);
    serv := rec.serv();
    por := rec.por();
    rec := nil;
    if (thread_policy.value() = SINGLE_THREAD_MODEL) or
       (thread_policy.value() = MAIN_THREAD_MODEL) then begin
      // not optimal but reliable solution
      // for all POAs with single-thread policy
      // we will lock global servant manager lock
      // for main-thread policy this solution is optimal
      // and right
      ServantManagerLock.lock;
      try
        sav.etherealize(por.id(), Self, serv, false, other);
      finally
        ServantManagerLock.unlock;
      end; { try/finally }
    end
    else
      sav.etherealize(por.id(), Self, serv, false, other);
    por := nil;
  end
  else
    rec := nil;
{$IFDEF HAVE_THREADS}
  if delref <> nil then begin
    delref.signal := 1;
    delref.condition.broadcast();
  end;
{$ENDIF}
end;

function POA_narrow(const obj : IORBObject) : IPOA;
begin
  result := TPOA_impl._narrow(obj)
end;

function TPOA_impl.ActiveObjectMap: IObjectMap;
begin
  result := FObjectMap;
end;

function TPOA_impl.ObjectActivationLock: TRecursiveMutex;
begin
  result := FObjectActivationLock;
end;

function TPOA_impl._id_assignment_policy : IIdAssignmentPolicy;
begin
  result := id_assignment_policy
end;

function TPOA_impl._thread_policy : IThreadPolicy;
begin
  result := thread_policy
end;

function TPOA_impl._lifespan_policy : ILifespanPolicy;
begin
  result := lifespan_policy
end;

function TPOA_impl._id_uniqueness_policy : IIdUniquenessPolicy;
begin
  result := id_uniqueness_policy
end;

function TPOA_impl._implicit_activation_policy : IImplicitActivationPolicy;
begin
  result := implicit_activation_policy
end;

function TPOA_impl._servant_retention_policy : IServantRetentionPolicy;
begin
  result := servant_retention_policy
end;

function TPOA_impl._request_processing_policy : IRequestProcessingPolicy;
begin
  result := request_processing_policy
end;

function TPOA_impl.GetDestroyed(): boolean;
begin
  FDestroyStateMutex.lock;
  try
    result := FDestroyState = psDestroyCompleted;
  finally
    FDestroyStateMutex.unlock;
  end; { try/finally }
end;

function TPOA_impl.MarkDestroyPending(etherealize_objects: Boolean; wait_for_completion: Boolean): boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FThreadMonitor);
  // If the POA is in the middle of a destroy and waitForCompletion
  // is true then wait for the destroy to complete.
  if FDestroyState <> psDestroyNotCalled then begin
    while wait_for_completion and (FDestroyState <> psDestroyCompleted) do begin
      // wait for the destroy to complete
      try
        FThreadMonitor.wait();
      except
        on E: EInterruptedException do
      end; { try/except }
    end; { while }
    result := false;
  end
  else begin
    FEtherealize := etherealize_objects;
    FDestroyState := psDestroyPending;
    result := true;
  end;
end;

// Wait for any pending requests to terminate. Return true if
// the destroy should complete, false otherwise.
function TPOA_impl.WaitPendingRequests(): boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FThreadMonitor);
  while FRequestsCount > 0 do begin
    // wait for the destroy to complete
    try
      FThreadMonitor.wait();
    except
      on E: EInterruptedException do
    end; { try/except }
  end; { while }
  // If the state is not DestroyPending then some other thread
  // is in the progress of completing destroying the POA
  result := FDestroyState = psDestroyPending;
  if result then
    FDestroyState := psDestroyInProgress;
end;

// Increment the outstanding request count. Return true if the POA
// is not destroyed, false otherwise.
function TPOA_impl.IncrementRequestCount(): boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FThreadMonitor);
  if FDestroyState <> psDestroyNotCalled then begin
    while FDestroyState <> psDestroyCompleted do begin
      // wait for the destroy to complete
      try
        FThreadMonitor.wait();
      except
        on E: EInterruptedException do
      end; { try/except }
    end; { while }
    result := false;
  end
  else begin
    FRequestsCount := Succ(FRequestsCount);
    result := true;
  end;
end;

// Decrement the outstanding request count. If the state is
// DestroyPending then wake any waiting threads and return true.
function TPOA_impl.DecrementRequestCount(): boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FThreadMonitor);
  Assert(FRequestsCount > 0);
  FRequestsCount := Pred(FRequestsCount);
  // If we have no more outstanding requests notify anyone
  // waiting for this state
  if (FRequestsCount = 0) and (FDestroyState = psDestroyPending) then begin
    FThreadMonitor.notifyAll();
    result := true;
  end
  else
    result := false;
end;

// Mark the state as DestroyCompleted, wake any waiting threads
procedure TPOA_impl.MarkDestroyCompleted();
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FThreadMonitor);
  FDestroyState := psDestroyCompleted;
  FThreadMonitor.notifyAll();
end;

function TPOA_impl.HasPendingRequests(): boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FThreadMonitor);
  result := FRequestsCount > 0;
end;

procedure TPOA_impl.CompleteDestroy();
var
  rec: IInvocationRecord;
  ex: ISystemException;
begin
  // Wait for all pending requests to terminate. If the POA has
  // destruction has already completed waitPendingRequests returns
  // false.
  if WaitPendingRequests() then begin
    //if FDestructed then exit;
    //FDestructed := true;
    // unregister globally, from parent and from manager
    unregister_poa(string(FOaid));

    if Assigned(FParent) then
      FParent.unregister_child(FName);

    FManager.del_managed_poa(self);

    (*
     * The RootPOA says goodbye to the POAMediator
     *)
    if not Assigned(FParent) and Assigned(POAMediator) then begin
      //ignore OBJECT_NOT_EXIST exception. This object adapter is destroyed.
      try
        POAMediator.deactivate_impl(poa_impl_name);
      except
        on E: SystemException do
          ex := SystemException.Create(E);
      end; { try/except }
      if (ex <> nil) and (ex.extype <> st_OBJECT_NOT_EXIST) then
        ex.throw();
    end;

    // Root POA must unregister from the ORB
    if not Assigned(FParent) then //rootPOA
      FORB.unregister_oa(self);

    FState := INACTIVE;

    while FInvocationQueue.count > 0 do
      begin
        rec := FInvocationQueue[0] as IInvocationRecord;
        rec.exec(self);
        FInvocationQueue.Delete(0);
      end;

    if FEtherealize then
      etherealize();

    if not Assigned(FParent) then begin//rootPOA
      _the_root_poa := nil;
      POACurrent := nil;
    end;

    MarkDestroyCompleted();
  end;
end;

function TPOA_impl.locate(mid: ORBMessageID; const obj : IORBObject): Boolean;
begin
  FORB.answer_locate(mid, LocateHere, nil, 0);
  result := true;
end;

{$IFDEF LIBRARY}
exports
  POA_narrow;
{$ENDIF}
initialization
  poa_impl_name:= '';
  {$IFDEF USE_RWLOCK}AllPOAsSync := TRWLock.Create;{$ENDIF}
  AllPOAs := TStringList.Create;
  idfactory := TUniqueIdGenerator.Create('_');
  poauid := TUniqueIdGenerator.Create('');
  ServantManagerLock := TMutex.Create;
  GlobalInvokeLock := TMutex.Create;
finalization
  FreeAndNil(AllPOAs);
  {$IFDEF USE_RWLOCK}FreeAndNil(AllPOAsSync);{$ENDIF}
  FreeAndNil(idfactory);
  FreeAndNil(poauid);
  FreeAndNil(ServantManagerLock);
  FreeAndNil(GlobalInvokeLock);
{$ELSE}
  function POA_narrow(const obj : IORBObject): IPOA; external MTDORB_Library_Name
implementation
{$ENDIF}
end.
