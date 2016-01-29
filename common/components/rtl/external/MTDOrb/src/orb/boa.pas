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
  Basic Object Adaptor implementation.
}
unit boa;

interface

{$I dorb.inc}

uses
  orb,orb_int,orbtypes,addr_int,imr_int,SysUtils,Classes,boa_int,
  req_int,code_int,any,ir_int,env_int;

{$IFNDEF USELIB}

type

  {**
     Implementation of BOA.
  }
  TBOAImpl = class(TORBObject,IObjectAdaptor,IBOA)
  private
    {** Pointer to current ORB  }
    FORB: IORB;
    FIDTemplate : Identifier;
    //    FActiveObject : IORBObject;
    FCurrentId: _ulong;
    FObjects : IInterfaceList;
    FImplName : Identifier;
    FRequestQueue : IInterfaceList;
    FQueueCount : longint;
  protected
    function is_builtin_invoke(const op: AnsiString): Boolean;
    function get_record(const obj: IORBObject): IObjectRecord;
    function skeleton(const obj: IORBObject): IORBObject;
    function is_local(): Boolean;
    function invoke(mid: ORBMessageID;const obj : IORBObject; const req : IORBRequest; const pr: IPrincipal; response_exp: Boolean): Boolean; stdcall;
    function has_object(const obj: IORBObject): Boolean;
    function bind(mid: ORBMessageID; const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress): Boolean;
    function get_oaid(): ObjectID;
    function unique_id(out buffer: AnsiString): _ulong;
    function impl_name: Identifier;
    function get_pricipal(const obj: IORBObject; const env: IEnvironment): IPrincipal;
    //function createrec(const id: string;const ImplBase: IUnknown;const repoid: string): IORBObject;
    function createrec(const id: Identifier; const intdef: IInterfaceDef;
      const impdef: IImplementationDef; const skel: IImplementationBase;
      const repoid: RepositoryId): IORBObject;
    procedure add_record(const rec: IObjectRecord);
    procedure answer_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
    procedure shutdown(WaitForCompletion: Boolean);
    procedure cancel(mid: ORBMessageID);
    function locate(mid: ORBMessageID; const obj : IORBObject): Boolean;
    procedure builtin_invoke(const obj : IORBObject; sreq: IServerRequest);
    function must_queue(mid: ORBMessageID): Boolean;
    procedure queue();
    procedure unqueue();
    function dobind(mid: ORBMessageID; repoid: RepositoryId; const tag: IObjectTag; const addr: IAddress): Boolean;
  public
    constructor Create(dorb: IORB);
    destructor Destroy(); override;
  end;

  TObjectRecord = class(TInterfacedObject,IObjectRecord)
  private
    FObject: IORBObject;
    FRemote : IORBObject;
    FSkel : IImplementationBase;
    FIntDef: IInterfaceDef;
    FImplDef: IImplementationDef;
  protected
    function local_obj: IORBObject;
    function remote_obj: IORBObject;
    function skel(): IORBObject;
    function id(): Identifier;
  public
    constructor Create(const obj : IORBObject;const id: Identifier; const intdef: IInterfaceDef;
      const impdef: IImplementationDef; const skel: IImplementationBase);
  end;

  TImplementationBase = class(TORBObject,IImplementationBase)
  protected
    FBOA : IBOA;
    procedure create_ref(const id: Identifier;const idef: IInterfaceDef; const implDef : IImplementationDef;const repoid: RepositoryId);
    function find_impl(const repid: RepositoryId; const name: Identifier): IImplementationDef;
    function impl_name(const name: Identifier): Identifier;
    function make_request(const req: IORBRequest;const obj: IORBObject; mid: ORBMessageID;
       const oa: IObjectAdaptor; pr: IPrincipal):IServerRequestBase; virtual;
    procedure doinvoke(const req: IServerRequestBase; const env: IEnvironment); virtual;
  public
    constructor Create();
  end;

  TStaticImplementation = class(TImplementationBase,IStaticImplementation)
  protected
    procedure doinvoke(const req: IServerRequestBase; const env: IEnvironment); override;
    procedure invoke(const req: IStaticServerRequest; const env: IEnvironment); virtual;
    function make_request(const req: IORBRequest;const obj: IORBObject; id: ORBMessageID;
       const oa: IObjectAdaptor; pr: IPrincipal):IServerRequestBase; override;
  end;

  TStaticMethodDispatcher = class(TStaticImplementation,IStaticMethodDispatcher)
  private
    FDispatchers : IInterfaceList;
  protected
    procedure register_dispatcher(const disp: IStaticInterfaceDispatcher);
    procedure invoke(const req: IStaticServerRequest; const env: IEnvironment); override;
  public
    constructor Create();
  end;

implementation

uses
  address,{$IFDEF WIN32}windows{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF},ior,iior_int,imr,static,req,
  utils,intercept,except_int,exceptions;

threadvar
  currencyEnvironmentVar: IEnvironment;

//********************************************************
// TBOA
//********************************************************
constructor TBOAImpl.Create(dorb: IORB);
var
  hostid : _ulong;
  pid : {$IFDEF WIN32}DWORD{$ENDIF}{$IFDEF LINUX}__pid_t{$ENDIF};
begin
  inherited Create();
  FObjects := TInterfaceList.Create;
  FRequestQueue := TInterfaceList.Create;
  FQueueCount := 0;
  FCurrentID := 0;
  FOrb := dorb;
  FImplName := '';
  FOrb.register_oa(self,OAPriorityLocal);
  hostid := TInetAddress.hostid();
{$IFDEF WIN32}
  pid := GetCurrentProcessID();
{$ENDIF}
{$IFDEF LINUX}
  pid := getpid();
{$ENDIF}
  SetLength(FIDTemplate,11);
  FIDTemplate[1] := 'B';
  FIDTemplate[2] := 'O';
  FIDTemplate[3] := 'A';
  FIDTemplate[4] := AnsiChar(hostid);
  FIDTemplate[5] := AnsiChar(hostid shr 8);
  FIDTemplate[6] := AnsiChar(hostid shr 16);
  FIDTemplate[7] := AnsiChar(hostid shr 24);
  FIDTemplate[8] := AnsiChar(pid shr 24);
  FIDTemplate[9] := AnsiChar(pid shr 16);
  FIDTemplate[10] := AnsiChar(pid shr 8);
  FIDTemplate[11] := AnsiChar(pid);
end;

destructor TBOAImpl.Destroy();
begin
  inherited Destroy();
end;

procedure TBOAImpl.cancel(mid: ORBMessageID);
begin
  // do nothing
end;

procedure TBOAImpl.shutdown(WaitForCompletion: Boolean);
begin
  FObjects.Clear;
  FORB.answer_shutdown(self);
end;

procedure TBOAImpl.answer_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
begin
  FORB.answer_invoke(mid, stat, obj, req, 0);
end;

function TBOAImpl.is_builtin_invoke(const op: AnsiString): Boolean;
begin
  result := (op[1] = '_') and (
    (strcomp(PAnsiChar(op),'_interface')=0) or
    (strcomp(PAnsiChar(op),'_implementation')=0) or
    (strcomp(PAnsiChar(op),'_is_a')=0) or
    (strcomp(PAnsiChar(op),'_non_existent')=0));
end;

procedure TBOAImpl.builtin_invoke(const obj : IORBObject; sreq: IServerRequest);
var
  a : IAny;
begin
  if sreq.operation = '_interface' then
    begin
      assert(false,'not implemented');
    end
  else if sreq.operation = '_implementation' then
    begin
      assert(false,'not implemented');
    end
  else if sreq.operation = '_is_a' then
    begin
      assert(false,'not implemented');
    end
  else if sreq.operation = '_non_existent' then
    begin
      a := TAny.Create();
      a.put_boolean(false);
      sreq.set_result(a);
    end
end;


function TBOAImpl.createrec(const id: Identifier; const intdef: IInterfaceDef;
      const impdef: IImplementationDef; const skel: IImplementationBase;
      const repoid: RepositoryId): IORBObject;
var
  key : AnsiString;
  nior : IIOR;
  obj : IORBObject;
  rec : IObjectRecord;
  len: integer;
  retval: boolean;
begin
  len := unique_id(key);
  nior := TIOR.Create(FORB.ior_template);
  nior.set_objectkey(key,len);
  nior.set_objectid(repoid);
  obj := TORBObject.Create(nior);
  //BOAInterceptor
  retval := TBOAInterceptor._exec_create(obj);
  Assert(retval);
  rec := TObjectRecord.Create(obj,id,intdef,impdef,skel);
  add_record(rec);
  result := rec.remote_obj;
end;

function TBOAImpl.is_local(): Boolean;
begin
  result := true;
end;

procedure TBOAImpl.add_record(const rec: IObjectRecord);
begin
  FObjects.Add(rec);
end;

function TBOAImpl.get_record(const obj: IORBObject): IObjectRecord;
var
  i : integer;
  key,ckey : AnsiString;
  len,clen: _ulong;
begin
  result := nil;
  key := obj._IOR.get_profile.objkey(len);
  for i := 0 to Pred(FObjects.Count) do
    begin
      ckey := IObjectRecord(FObjects[i]).local_obj._IOR.get_profile(TAG_ANY).objkey(clen);
      if (clen = len) and Comparemem(PAnsiChar(ckey),PAnsiChar(key),len) then
        begin
          result := IObjectRecord(FObjects[i]);
          break;
        end;
    end;
end;

function TBOAImpl.skeleton(const obj: IORBObject): IORBObject;
var
  orec: IObjectRecord;
begin
  result := nil;
  orec := get_record(obj);
  if orec = nil then exit;
  result := orec.skel;
end;

function TBOAImpl.impl_name: Identifier;
begin
  if FImplName = '' then
    begin
      FImplName := AnsiString(TInetAddress.hostname);
{$IFDEF WIN32}
      FImplName := AnsiString(String(FImplName) + ':' + IntToStr(GetCurrentProcessID()));
{$ENDIF}
{$IFDEF LINUX}
      FImplName := FImplName + ':' + IntToStr(getpid());
{$ENDIF}
    end;
  result := FImplName;
end;

{**
  Returns BOA unique identifier
**}
function TBOAImpl.unique_id(out buffer: AnsiString): _ulong;
var
  val,len : integer;
begin
  Inc(FCurrentID);
  if FCurrentID = 0 then FCurrentID := 1;
  val := FCurrentID;
  len := 11;
  buffer := FIDTemplate;
  while val <> 0 do
    begin
      buffer := buffer + AnsiChar(val);
      val := val shr 8;
      inc(len);
    end;
  result := len;
end;

function TBOAImpl.invoke(mid: ORBMessageID; const obj: IORBObject;
  const req: IORBRequest; const pr: IPrincipal; response_exp: Boolean): Boolean;
var
  rec: IObjectRecord;
  ibase: IImplementationBase;
  srbase: IServerRequestBase;
  sreq : IServerRequest;
begin
  result := false;
  rec := get_record(obj);
  if rec = nil then
    begin
      assert(false,'not implemented');
      result := true;
      exit;
    end;
  if is_builtin_invoke(PAnsiChar(req.op_name)) then
    begin
      sreq := TServerRequest.Create(req,obj,mid,self,pr);
      builtin_invoke(obj,sreq);
    end
  else
    begin
      ibase := rec.skel as IImplementationBase;
      assert(ibase <> nil);
      srbase := ibase.make_request(req,obj,mid,self,pr);
      currencyEnvironmentVar := srbase.environment;
      ibase.doinvoke(srbase,srbase.environment);
      currencyEnvironmentVar := nil;
      result := true;
    end;
end;

{**
  Returns object identifier
**}
function TBOAImpl.get_oaid(): ObjectID;
begin
  result :=  'dorb-local-boa';
end;

function TBOAImpl.dobind(mid: ORBMessageID; repoid: RepositoryId; const tag: IObjectTag; const addr: IAddress): Boolean;
var
  i : integer;
begin
  result := false;
  for i := 0 to Pred(FObjects.Count) do
    if (IObjectRecord(FObjects[i]).local_obj._repoid = repoid) and
      ((tag.get_length = 0) or  tag.equals(IObjectRecord(FObjects[i]).id)) then
      begin
        FORB.answer_bind(mid,LocateHere,IObjectRecord(FObjects[i]).skel);
        result := true;
        exit;
      end;

end;

function TBOAImpl.bind(mid: ORBMessageID; const repoid: RepositoryId;
  const oid: IObjectTag; const addr: IAddress): Boolean;
begin
  result := false;
  if assigned(addr) and not addr.is_local then
    exit;
  if must_queue(mid) then
    begin
      assert(false,'not implemented');
      result := true;
      exit;
    end;
  queue();
  if dobind(mid,repoid,oid,addr) then
    begin
      unqueue();
      result := true;
      exit;
    end;

  // activation of shared objects is not implemented

  //BOAInterceptor
  result := TBOAInterceptor._exec_bind(repoid, oid);

  unqueue();
end;

function TBOAImpl.has_object(const obj: IORBObject): Boolean;
var
  prof : IIORProfile;
  len: _ulong;
  bar : AnsiString;
begin
  result := false;
  if (obj = nil) or (obj._IOR = nil) then exit;
  prof := obj._IOR.get_profile;
  bar := prof.objkey(len);
  if (len < 11) or not comparemem(PAnsiChar(FIDTemplate),PAnsiChar(bar),11) then exit;
  result := true;
end;

function TBOAImpl.must_queue(mid: ORBMessageID): Boolean;
begin
  result := false;
  if FQueueCount > 0 then
    result := true
  else if FRequestQueue.Count = 0 then
    result := false
  else
    assert(false,'not implemented');
end;

procedure TBOAImpl.queue();
begin
  inc(FQueueCount)
end;

procedure TBOAImpl.unqueue();
begin
  dec(FQueueCount)
end;

function TBOAImpl.get_pricipal(const obj: IORBObject; const env: IEnvironment): IPrincipal;
begin
  if env <> nil then
    result := env.principal
  else if currencyEnvironmentVar <> nil then
    result := currencyEnvironmentVar.principal
  else
    result := nil;
end;

function TBOAImpl.locate(mid: ORBMessageID;
  const obj: IORBObject): Boolean;
begin
  result := false;
end;

//***************************************************************
// TObjectRecord
//***************************************************************

constructor TObjectRecord.Create(const obj : IORBObject;const id: Identifier; const intdef: IInterfaceDef;
      const impdef: IImplementationDef; const skel: IImplementationBase);
begin
  FObject := obj;
  FRemote := obj;
  FIntDef := intdef;
  FImplDef := impdef;
  FSkel := skel;
end;

function TObjectRecord.local_obj: IORBObject;
begin
  result := FObject;
end;

function TObjectRecord.remote_obj: IORBObject;
begin
  Result := FRemote;
end;

function TObjectRecord.skel(): IORBObject;
begin
  result := FSkel as IORBObject;
end;

function TObjectRecord.id(): Identifier;
begin
  assert(false,'not implemented');
end;

//***************************************************************************
//  TImplementationBase
//***************************************************************************
constructor TImplementationBase.Create();
begin
  inherited Create();
  FBOA := FORB.BOA_Init as IBOA;
end;

procedure TImplementationBase.doinvoke(const req: IServerRequestBase; const env: IEnvironment);
begin
  assert(false,'must be implemented in descendants');
end;

function TImplementationBase.make_request(const req: IORBRequest;const obj: IORBObject; mid: ORBMessageID;
       const oa: IObjectAdaptor; pr: IPrincipal):IServerRequestBase;
begin
  assert(false,'must be implemented in descendants');
  result := nil;
end;

procedure TImplementationBase.create_ref(const id: Identifier;const idef: IInterfaceDef; const implDef : IImplementationDef;const repoid: RepositoryId);
var
  obj : IORBObject;
begin
  obj := FBOA.createrec(id,idef,impldef,IImplementationBase(self),repoid);
  Assign(obj);
end;

function TImplementationBase.find_impl(const repid: RepositoryId; const name: Identifier): IImplementationDef;
{var
  obj: IORBObject;
  local_imr,_imr : IImplRepository;
  _name : string;
  lst : IInterfaceList;
  impl : IImplementationDef;
  oi: IObjectInfo;}
begin
  result := nil;
  {_name := impl_name(name);
  obj := FORB.resolve_initial_reference('ImplementationRepository');
  assert(obj <> nil);
  _imr := TImplRepository_skel.narrow(obj);
  assert(_imr<> nil);
  obj := FORB.resolve_initial_reference('LocalImplementationRepository');
  assert(obj <> nil);
  local_imr := TImplRepository_skel.narrow(obj);
  lst := _imr.find_by_name(_name);
  if lst.Count = 0 then
    lst := local_imr.find_by_name(_name);
  if lst.Count > 0 then
    begin
      assert(false,'not implemented');
    end
  else
    begin
      oi := TObjectInfo.Create(repid);
      lst.Add(oi);
      impl := local_imr._create(ActivatePersistent,lst,name,'');
      result := impl;
    end;}
end;

function TImplementationBase.impl_name(const name: Identifier): Identifier;
begin
  result := FBOA.impl_name
end;

//*************************************************
//  TStaticImplementation
//*************************************************
procedure TStaticImplementation.doinvoke(const req: IServerRequestBase;
  const env: IEnvironment);
begin
  invoke(IStaticServerRequest(req),env);
end;

procedure TStaticImplementation.invoke(const req: IStaticServerRequest;
  const env: IEnvironment);
begin
  assert(false,'must be implemented in descendant Classes');
end;

function TStaticImplementation.make_request(const req: IORBRequest;const obj: IORBObject; id: ORBMessageID;
       const oa: IObjectAdaptor; pr: IPrincipal):IServerRequestBase;
begin
  result := StaticServerRequest(req,obj,id,oa,pr)
end;

//*************************************************
//  TStaticMethodDispatcher
//*************************************************
constructor TStaticMethodDispatcher.Create;
begin
  inherited Create();
  FDispatchers := TInterfaceList.Create;
end;

procedure TStaticMethodDispatcher.invoke(const req: IStaticServerRequest;
  const env: IEnvironment);
var
  i : integer;
begin
  try
    for i := 0 to Pred(FDispatchers.Count) do
      if IStaticInterfaceDispatcher(FDispatchers[i])._dispatch(req,env) then
        exit;
  except
    on e : SystemException do
      begin
        req.set_exception(SystemException.Create(e) as IORBException);
        req.write_results();
      end
    else
      begin
        req.set_exception(SystemException.Create_type(st_UNKNOWN, 0, COMPLETED_NO) as IORBException);
        req.write_results();
      end;
  end;
  req.set_exception(SystemException.Create_type(st_BAD_OPERATION) as IORBException);
  req.write_results;
end;

procedure TStaticMethodDispatcher.register_dispatcher(
  const disp: IStaticInterfaceDispatcher);
begin
  FDispatchers.Add(disp);
end;

{$ELSE}
implementation
{$ENDIF}
end.
