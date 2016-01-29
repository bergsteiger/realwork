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
unit imr_impl;

interface

{$I dorb.inc}

uses
  imr_int,imr,Classes,req_int,orb_int,orbtypes,env_int,SysUtils,code_int,process_int,
  iior_int, addr_int, poa_int, orb, Contnrs, map_int, osthread;

{$IFNDEF USELIB}

type

  TImplRepository_impl = class(TImplRepository_serv)
  private
    FDefs : TImplDefSeq;
    FDefsLock: TRecursiveMutex;
  protected
    function restore(const asstring: string): IImplementationDef; override;
    function _create(const mode: TActivationMode; const objs: TObjectInfoList; const name: Identifier; const command: string): IImplementationDef; override;
    procedure _destroy(const impl_def: IImplementationDef); override;
    function find_by_name(const name: Identifier): TImplDefSeq; override;
    function find_by_repoid(const repoid: RepositoryId): TImplDefSeq; override;
    function find_by_repoid_tag(const repoid: RepositoryId; const tag: imr_int.TObjectTag): TImplDefSeq; override;
    function find_all: TImplDefSeq; override;
  public
    constructor Create();
    destructor Destroy; override;
  end;

  TImplementationDef_impl = class(TImplementationDef_serv)
  private
    FMode: TActivationMode;
    FObjs : TObjectInfoList;
    FName: Identifier;
    FCommand : string;
    procedure PutStr(var Dest: AnsiString; const Src: AnsiString);
    function GetStr(var Src: AnsiString): AnsiString;
  protected
    procedure _set_mode(const val: TActivationMode); override;
    function _get_mode: TActivationMode; override;
    procedure _set_objs(const val: TObjectInfoList); override;
    function _get_objs: TObjectInfoList; override;
    function _get_name: Identifier; override;
    procedure _set_command(const val: string); override;
    function _get_command: string; override;
    function _get_tostring: string; override;
  public
    constructor Create(mode: TActivationMode; const objs: TObjectInfoList; name: Identifier; command: string); overload;
    constructor Create(str: AnsiString); overload;
  end;

  (*
   * ----------------------------------------------------------------------
   * The POA Mediator
   *
   * Persistent POAs connect here using create_impl(). The POA tells us
   * its IOR Template, which contains its address. We return our IOR. The
   * POA then produces object references pointing to us on its own. The
   * Objectkey of such references starts with the unique identifier for
   * that server followed by ':'.
   * When we receive an invocation for such a reference, we construct a
   * new object reference by taking the POAs IOR template plus the object
   * key, and forward the invocation.
   * ----------------------------------------------------------------------
   *)
  TServerState = (ssInactive, ssStarted, ssActive, ssHolding, ssStopped, ssFailed);

  TServerInfo = class(TObject)
  private
    serverState: TServerState;
    ior: IIOR;
    process: IProcess;
    failed: long;
  end;

  TInvQueueItem = class(TObject)
  private
    FType: TRequestType;
    FId: ORBMessageID;
    FObj: IORBObject;
    FReq: IORBRequest;
    FPrincipal: IPrincipal;
    FResponseExp: boolean;
    FRepoId: RepositoryId;
    FTag: IObjectTag;
  public
    constructor Create(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest;
      const pr: IPrincipal; response_exp: Boolean); overload;
    constructor Create(mid: ORBMessageID; const repoid: RepositoryId; const tag: IObjectTag); overload;
    constructor Create(mid: ORBMessageID; const obj: IORBObject); overload;
    procedure Exec(OAdapter: IObjectAdaptor; orb: IORB);
  end;

  TInvocationQueue = class(TQueue)
  private
    FOAdapter: IObjectAdaptor;
    FORB: IORB;
  public
    constructor Create(oa: IObjectAdaptor; orb: IORB);
    procedure ExecNow;
    procedure Fail;
  end;

  IPOAMediatorImpl = interface(IInterface)
  ['{E707DEBA-A270-4CC2-9304-86024614CD73}']
    procedure ORBObject(obj: IORBObject);
  end;

  TPOAMediator_impl = class(TORBObject, IPOAMediator, IORBCallback, IObjectAdaptor, IProcessCallback, IPOAMediatorImpl)
  private
    FORB: IORB;
    FIOR: AnsiString;
    FObj: IORBObject;
    FIMR: IImplRepository;
    FForward: boolean;
    FServerMap: TStrings;
    FInvQueue: TInvocationQueue;
    FRequests: IInterfaceInterfaceMap;
    FServerMapLock: TRecursiveMutex;
    FInvQueueLock: TRecursiveMutex;
    FRequestLock: TRecursiveMutex;
    function CreateServer(const AServerId: Identifier): boolean;
  protected
    { IPOAMediator }
    function create_impl(const svid: AnsiString; const ior: AnsiString): AnsiString;
    procedure activate_impl(const svid: AnsiString);
    procedure deactivate_impl(const svid: AnsiString);
    function force_activation(const impl: IImplementationDef): boolean;
    function hold(const impl: IImplementationDef): boolean;
    function stop(const impl: IImplementationDef): boolean;
    function continue(const impl: IImplementationDef): boolean;
    { IObjectAdaptor }
    procedure answer_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
    function bind(mid: ORBMessageID; const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress): Boolean;
    function get_oaid(): ObjectID;
    function has_object(const obj: IORBObject): Boolean;
    function invoke(mid: ORBMessageID;const obj : IORBObject; const req : IORBRequest;const pr: IPrincipal; response_exp: Boolean): Boolean;  stdcall;
    function is_local: Boolean;
    function skeleton(const obj : IORBObject): IORBObject;
    procedure shutdown(WaitForCompletion: Boolean);
    procedure cancel(id: ORBMessageID);
    function locate(mid: ORBMessageID; const obj : IORBObject): Boolean;
    { IORBCallback }
    function waitfor(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent; tmout: long = -1): boolean;
    procedure notify(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent);
    { IProcessCallback }
    procedure ProcessCallback(const AProcess: IProcess; const AEvent: TProcessCallbackEvent);
    { IPOAMediatorImpl }
    procedure ORBObject(obj: IORBObject);
  public
    constructor Create(const AOrb: IORB; AForward: boolean = false);
    destructor Destroy; override;
  end;

implementation

uses ior, utils,{$IFDEF MSWINDOWS}WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF},
  osprocess, exceptions, map;

//**************************************************************************
// TImplRepository_impl
//**************************************************************************
constructor TImplRepository_impl.Create;
begin
  inherited Create();
  FDefsLock := TRecursiveMutex.Create;
end;

destructor TImplRepository_impl.Destroy;
begin
  FreeAndNil(FDefsLock);
  inherited;
end;

function TImplRepository_impl._create(const mode: TActivationMode; const objs: TObjectInfoList; const name: Identifier; const command: string): IImplementationDef;
var
  len: integer;
  ref: IORBObject;
  serv: IServant;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FDefsLock);
  serv := TImplementationDef_impl.Create(mode,objs,name,command);
  len := Length(FDefs);
  SetLength(FDefs, len + 1);
  ref := FPOA.servant_to_reference(serv);
  result := TImplementationDef._narrow(ref);
  FDefs[len] :=  result;
end;

procedure TImplRepository_impl._destroy(
  const impl_def: IImplementationDef);
var
  sync: ISynchronized;
  i: integer;
  tmp: TImplDefSeq;
begin
  tmp := nil;
  sync := TSynchronized.Create(FDefsLock);
  for i := 0 to Length(FDefs) - 1 do
    if (FDefs[i] as IORBObject).is_equivalent(impl_def as IORBObject) then begin
      FDefs[i] := nil;
      tmp := Copy(FDefs, i + 1, Length(FDefs) - i - 1);
      FDefs := Copy(FDefs, 0, i);
      Break;
    end;

  for i := 0 to Length(tmp) - 1 do begin
    SetLength(FDefs, Length(FDefs) + 1);
    FDefs[Length(FDefs) - 1] := tmp[i];
  end;
end;

function TImplRepository_impl.find_all: TImplDefSeq;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FDefsLock);
  result := Copy(FDefs, 0, Length(FDefs));
end;

function TImplRepository_impl.find_by_name(
  const name: Identifier): TImplDefSeq;
var
  i, idx : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FDefsLock);
  idx := 0;
  for i := 0 to Pred(Length(FDefs)) do
    if StrComp(PAnsiChar(name), PAnsiChar(FDefs[i].name)) = 0 then begin
      idx := Succ(idx);
      SetLength(result, idx);
      result[idx - 1] := FDefs[i];
    end;
end;

function TImplRepository_impl.find_by_repoid(
  const repoid: RepositoryId): TImplDefSeq;
var
  i, idx : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FDefsLock);
  idx := 0;
  for i := 0 to Pred(Length(FDefs)) do
    if StrComp(PAnsiChar(repoid), PAnsiChar((FDefs[i] as IORBObject)._repoid())) = 0 then begin
      idx := Succ(idx);
      SetLength(result, idx);
      result[idx - 1] := FDefs[i];
    end;
end;

function TImplRepository_impl.find_by_repoid_tag(const repoid: RepositoryId;
  const tag: imr_int.TObjectTag): TImplDefSeq;
var
  i, j, count: integer;
  objs: TObjectInfoList;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FDefsLock);
  count := 0; objs := nil;
  for i := 0  to Length(FDefs) - 1 do begin
    objs := FDefs[i].objs;
    for j := 0 to Length(objs) - 1 do begin
      if (repoid = objs[j].repoid) and ((Length(tag) = 0) or (tag = objs[j].tag)) then begin
        SetLength(result, count + 1);
        result[count] := FDefs[i];
        Inc(count);
        Break;
      end;
    end;
  end;
end;

function TImplRepository_impl.restore(
  const asstring: string): IImplementationDef;
var
  len: integer;
  ref: IORBObject;
  serv: IServant;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FDefsLock);
  serv := TImplementationDef_impl.Create(AnsiString(asstring));
  len := Length(FDefs);                  
  SetLength(FDefs, len + 1);
  ref := FPOA.servant_to_reference(serv);
  result := TImplementationDef._narrow(ref);
  FDefs[len] :=  result;
end;

//*********************************************************************
//  TImplementationDef_impl
//*********************************************************************
constructor TImplementationDef_impl.Create(mode: TActivationMode;
  const objs: TObjectInfoList; name: Identifier; command : String);
begin
  FMode := mode;
  FObjs := Copy(objs, 0, Length(objs));
  FName := name;
  FCommand := command;
end;

constructor TImplementationDef_impl.Create(str: AnsiString);
var
  mode: AnsiString;
  rid, tmp: AnsiString;
  len, pos: integer;
begin
  FName := GetStr(str);
  Assert(FName <> '');

  mode := GetStr(str);
  if (mode = 'persistent') then
      FMode := ActivatePersistent
  else if (mode = 'shared') then
      FMode := ActivateShared
  else if (mode = 'unshared') then
      FMode := ActivateUnshared
  else if (mode = 'permethod') then
      FMode := ActivatePerMethod
  else if (mode = 'library') then
      FMode := ActivateLibrary
  else if (mode = 'poa') then
      FMode := ActivatePOA
  else
    Assert(false);

  FCommand := String(GetStr(str));
  Assert(FCommand <> '');

  rid := GetStr(str);
  while rid <> '' do begin
    len := Length(FObjs);
    SetLength(FObjs, len + 1);

    pos := System.Pos('#', String(rid));
    if (pos > 0) then begin
      FObjs[len].repoid := Copy(rid, 1, pos);
      tmp := Copy(rid, pos + 1, Length(rid) - pos - 1);
      SetLength(FObjs[len].tag, Length(tmp));
      Move(Pointer(tmp)^, Pointer(FObjs[len].tag)^, Length(tmp));
    end
    else
      FObjs[len].repoid := rid;
    rid := '';
    rid := GetStr(str);
  end; { while }
  Assert(Length(FObjs) > 0);
end;

function TImplementationDef_impl.GetStr(var Src: AnsiString): AnsiString;
var
  p: integer;
  havequotes: boolean;
  esc: boolean;
begin
  if Src = '' then
    Exit;
  p := 1;
  while Src[p] = ' ' do
    Inc(p);
  if (p = Length(Src)) then
    Exit;

  havequotes := CharInSet(Src[p], [{'\',} '"']);
  if havequotes then
    Inc(p);

  esc := false;
  while (p <= Length(Src)) do begin
    if esc then begin
      result := result + Src[p];
      esc := false;
    end
    //else if Src[p] = '\' then
      //esc := true
    else if havequotes and CharInSet(Src[p], [{'\',} '"']) then begin
      Inc(p);
      Break;
    end
    else if not havequotes and ((Src[p] = ' ') or (Src[p] = Chr($09))) then begin
      Inc(p);
      Break;
    end
    else
      result := result + Src[p];
    Inc(p);
  end; { while }
  Src := Copy(Src, p, Length(Src) - p + 1);
end;

procedure TImplementationDef_impl.PutStr(var Dest: AnsiString;
  const Src: AnsiString);
var
  needquotes: boolean;
  //i: integer;
begin
  needquotes := (Pos(Chr($09), String(Src)) > 0) or (Pos(' ', String(Src)) > 0);

  if Length(Dest) > 0 then
    Dest := Dest + ' ';
  if needquotes then
    Dest := Dest + '"';
  {for i := 1 to Length(Src) do begin
    case Src[i] of
    case '\'':
    case '\\':
        s += "\\";
        break;
    s += c;
  end;}
  Dest := Dest + Src;
  if needquotes then
    Dest := Dest + '"';
end;

function TImplementationDef_impl._get_name: Identifier;
begin
  result := FName;
end;

function TImplementationDef_impl._get_command: string;
begin
  result := FCommand;
end;

procedure TImplementationDef_impl._set_command(const val: string);
begin
  FCommand := val;
end;

function TImplementationDef_impl._get_mode: TActivationMode;
begin
  result := FMode;
end;

function TImplementationDef_impl._get_objs: TObjectInfoList;
begin
  result := FObjs;
end;

function TImplementationDef_impl._get_tostring: string;
var
  i: integer;
  tag: AnsiString;
  rv : AnsiString;
begin
  PutStr(rv, FName);
  case FMode of
    ActivatePersistent:
      PutStr(rv, 'persistent');
    ActivateShared:
      PutStr(rv, 'shared');
    ActivateUnshared:
      PutStr(rv, 'unshared');
    ActivatePerMethod:
      PutStr(rv, 'permethod');
    ActivateLibrary:
      PutStr(rv, 'library');
    ActivatePOA:
      PutStr(rv, 'poa');
    else
      Assert(false);
  end;
  PutStr(rv, AnsiString(FCommand));
  for i := 0 to Length(FObjs) - 1 do begin
    if Length(FObjs[i].tag) > 0 then begin
      SetLength(tag, Length(FObjs[i].tag));
      System.Move(Pointer(FObjs[i].tag)^, Pointer(tag)^, Length(FObjs[i].tag));
      PutStr(rv, AnsiString(Format('%s#%s', [FObjs[i].repoid, tag])));
    end
    else
      PutStr(rv, FObjs[i].repoid);
  end;
  Result := String(rv);
end;

procedure TImplementationDef_impl._set_mode(const val: TActivationMode);
begin
  FMode := val;
end;

procedure TImplementationDef_impl._set_objs(const val: TObjectInfoList);
begin
  FObjs := val;
end;

//*********************************************************************
// TPOAMediator_impl }
//*********************************************************************
procedure TPOAMediator_impl.activate_impl(const svid: AnsiString);
var
  info: TServerInfo;
  idx: integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FServerMapLock);
  idx := FServerMap.IndexOf(String(svid));
  if idx = -1 then
    Exit;
  info := TServerInfo(FServerMap.Objects[idx]);

  if (info.serverState = ssStopped) or (info.serverState = ssHolding) then
    Exit;

  info.serverState := ssActive;

  //perform pending invocations
  FInvQueueLock.lock;
  try
    FInvQueue.ExecNow();
  finally
    FInvQueueLock.unlock;
  end; { try/finally }
end;

procedure TPOAMediator_impl.ProcessCallback(const AProcess: IProcess;
  const AEvent: TProcessCallbackEvent);
var
  i: integer;
  info: TServerInfo;
  ct: TTimeVal;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FServerMapLock);
  (*
   * Find appropriate server
   *)
  info := nil;
  for i := 0 to FServerMap.Count - 1 do begin
    info := TServerInfo(FServerMap.Objects[i]);
    if info.process = AProcess then
      Break;
    info := nil;
  end;

  Assert(info <> nil);

  (*
   * What's happened?
   *)

  case AEvent of
    pceExited: begin
      if info.serverState = ssActive then begin
        info.serverState := ssInactive;
        info.process := nil;
      end
      else if info.serverState = ssStarted then begin
        ct := TimeNow();
        info.serverState := ssFailed;
        info.failed := ct.tv_sec;

        (*
         * Fail pending requests
         *)
        FInvQueueLock.lock;
        try
          FInvQueue.ExecNow();
        finally
          FInvQueueLock.unlock;
        end; { try/finally }
      end
      else if info.serverState = ssStopped then begin
        info.process := nil;
      end
      else if info.serverState = ssHolding then begin
        info.process := nil;
        info.serverState := ssStopped;
      end
      else
        Assert(false);
      end;
    else
      Assert(false);
  end;
end;

function TPOAMediator_impl.continue(
  const impl: IImplementationDef): boolean;
var
  idx: integer;
  info: TServerInfo;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FServerMapLock);

  result := false;
  idx := FServerMap.IndexOf(String(impl.name));
  if idx = -1 then
    Exit;
  info := TServerInfo(FServerMap.Objects[idx]);
  case info.serverState of
    ssInactive, ssStarted, ssActive: begin
      result := true;
      Exit;
    end;
    ssFailed, ssStopped, ssHolding: ;
    else
      Assert(False);
  end;

  info.serverState := ssInactive;
  result := true;
end;

constructor TPOAMediator_impl.Create(const AOrb: IORB; AForward: boolean);
var
  obj: IORBObject;
begin
  inherited Create;
  FORB := AOrb;
  FForward := AForward;
  FIOR := FORB.ior_template().stringify();

  obj := FORB.resolve_initial_reference('ImplementationRepository');
  FIMR := TImplRepository._narrow(obj);

  FServerMap := TStringList.Create;
  FRequests := TInterfaceInterfaceMap.Create;
  FInvQueue := TInvocationQueue.Create(Self as IObjectAdaptor, FORB);
  FServerMapLock := TRecursiveMutex.Create;
  FInvQueueLock := TRecursiveMutex.Create;
  FRequestLock := TRecursiveMutex.Create;

  FORB.register_oa(Self as IObjectAdaptor, 100);
end;

function TPOAMediator_impl.CreateServer(const AServerId: Identifier): boolean;
var
  idx: integer;
  info: TServerInfo;
  curTime: TTimeVal;
  impls: TImplDefSeq;
  idv: IImplementationDef;
  command: string;
  obj: IORBObject;
begin
  impls := nil;
  result := false;
  idx := FServerMap.IndexOf(String(AServerId));
  if idx = -1 then
    Exit;
  info := TServerInfo(FServerMap.Objects[idx]);
  if (info.serverState = ssStarted) or (info.serverState = ssActive) then begin
    result := true;
    Exit;
  end;

  (*
   * If the server is in the Failed state, we employ a similar strategy
   * as init does. We refuse to restart a server within 30 seconds after
   * its failure. Note that the Failed state is only entered if the server
   * crashes prior to its activation.
   * Without this 30 sec pause, the request that started the server would
   * be a ping of death, causing permanent restart.
   * We assume that the server has been fixed after the pause.
   * This can be overridden (i.e. restart a server before 30 secs have
   * elapsed) by using `imr activate'
   *)

  if (info.serverState = ssFailed) then begin
    curTime := TimeNow();
    if ((curTime.tv_sec - info.failed) < 30) then
      // less than 30 secs elapsed since first failure
      Exit;
    info.serverState := ssInactive;
  end;

  Assert(info.serverState = ssInactive);

  (*
   * Look up entry in Implementation Repository
   *)
  if FIMR = nil then
    Exit;

  impls := FIMR.find_by_name(AServerId);
  if (Length(impls) = 0) then
    Exit;

  idv := impls[0];

  (*
   * Construct command line
   *)
  command := idv.command;

  if Length(command) = 0 then
    Exit;

  command := command + ' -POAImplName ' + String(AServerId);

  command := command + ' -ORBImplRepoIOR ' + String(FORB.object_to_string(FIMR as IORBObject));

  obj := FORB.resolve_initial_reference('InterfaceRepository');

  if obj <> nil then
    command := command + ' -ORBIfaceRepoIOR ' + String(FORB.object_to_string(obj));

  command := command + ' -POARemoteIOR ' + String(FORB.object_to_string(FObj));

  info.serverState := ssStarted;

  info.process := ProcessFactory.CreateProcess(command, Self as IProcessCallback);

  result := info.process.Run();
end;

function TPOAMediator_impl.create_impl(const svid, ior: AnsiString): AnsiString;
var
  ids: TImplDefSeq;
  id: IImplementationDef;
  idx: integer;
  sync: ISynchronized;
begin
  ids := FIMR.find_by_name(svid);
  if Length(ids) = 0 then
    id := FIMR._create(ActivatePOA, nil, svid, '');

  sync := TSynchronized.Create(FServerMapLock);
  idx := FServerMap.IndexOf(String(svid));
  if idx = -1 then
    idx := FServerMap.AddObject(String(svid), TServerInfo.Create);
  TServerInfo(FServerMap.Objects[idx]).ior := TIOR.Create(ior);

  result := FIOR;
end;

procedure TPOAMediator_impl.deactivate_impl(const svid: AnsiString);
var
  idx: integer;
  info: TServerInfo;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FServerMapLock);
  idx := FServerMap.IndexOf(String(svid));
  if idx = -1 then
    Exit;
  info := TServerInfo(FServerMap.Objects[idx]);
  //Assert((info.serverState = ssStopped) or (info.process <> nil));
  case info.serverState of
    ssInactive, ssStarted, ssFailed: Assert(false);
    ssActive: info.serverState := ssInactive;
    ssHolding: info.serverState := ssStopped;
    ssStopped: ;
  end;
  if info.process <> nil then begin
    info.process.Detach();
    info.process := nil;
  end;
end;

destructor TPOAMediator_impl.Destroy;
var
  i: integer;
begin
  FORB.unregister_oa(Self as IObjectAdaptor);

  FServerMapLock.lock;
  try
    for i := 0 to FServerMap.Count - 1 do
      FServerMap.Objects[i].Free;
  finally
    FServerMapLock.unlock;
  end; { try/finally }

  FreeAndNil(FServerMap);
  FreeAndNil(FInvQueue);
  FreeAndNil(FServerMapLock);
  FreeAndNil(FInvQueueLock);
  FreeAndNil(FRequestLock);
  inherited;
end;

function TPOAMediator_impl.force_activation(
  const impl: IImplementationDef): boolean;
var
  idx: integer;
  info: TServerInfo;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FServerMapLock);
  idx := FServerMap.IndexOf(String(impl.name));
  if idx = -1 then begin
    info := TServerInfo.Create;
    FServerMap.AddObject(String(impl.name), info);
  end
  else
    info := TServerInfo(FServerMap.Objects[idx]);
  case info.serverState of
    ssInactive: ;
    ssStarted, ssActive: begin
      result := true;
      Exit;
    end;
    ssHolding: begin
      info.serverState := ssActive;
      result := true;
      Exit;
    end;
    ssStopped: begin
      if info.process <> nil then begin
        result := false;
        Exit;
      end;
      info.serverState := ssInactive;
    end;
    ssFailed: info.serverState := ssInactive;
  end;
  result := CreateServer(impl.name);                     
end;

function TPOAMediator_impl.hold(const impl: IImplementationDef): boolean;
begin
  result := false;
end;

procedure TPOAMediator_impl.notify(const orb: IORB; id: ORBMessageID;
  event: TORBCallbackEvent);
var
  obj: IORBObject;
  req: IORBRequest;
  id2: ORBMessageID;
  ad: AddressingDisposition;
  iStat: TInvokeStatus;
  lStat: TLocateStatus;
  i: integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FRequestLock);
  case event of
    _Invoke: begin
      iStat := orb.get_invoke_reply(id, obj, req, ad);

      id2 := ORBMessageID(FRequests.Item[id]);
      Assert(id2 <> nil);

      orb.answer_invoke(id2, iStat, obj, req, ad);
      FRequests.erase(id);
    end;
  _Bind: begin
      // a bind completed ...
      lStat := orb.get_bind_reply(id, obj);

      id2 := ORBMessageID(FRequests.Item[id]);
      Assert(id2 <> nil);

      FRequests.erase(id);

      if (lStat = LocateHere) then begin
	// found matching object ...
	orb.answer_bind(id2, lStat, obj);
	// cancel all binds resulting from the same bind "broadcast"
	cancel(id2);
      end
      else begin
	(*
	 * not found, see if there are more outstanding requests
	 * from the same bind "broadcast" ...
	 *)
        i := 0;
        while i < FRequests.Count do begin
          if FRequests.Second(i) = id2 then
            Break;
          i := Succ(i);
        end;

	if (i = FRequests.Count) then
	  // ... its the last bind request; answer anyway
	  orb.answer_bind(id2, lStat, obj);

	// ignore, there are more outstanding bind requests ...
      end;
    end;
    else
      Assert(false);
  end;
end;

procedure TPOAMediator_impl.ORBObject(obj: IORBObject);
begin
  FObj := obj;
end;

function TPOAMediator_impl.stop(const impl: IImplementationDef): boolean;
var
  idx: integer;
  info: TServerInfo;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FServerMapLock);
  result := false;
  idx := FServerMap.IndexOf(String(impl.name));
  if idx = -1 then
    Exit;
  info := TServerInfo(FServerMap.Objects[idx]);
  case info.serverState of
    ssInactive, ssStopped, ssFailed: begin
      info.serverState := ssStopped;
      result := true;
      Exit;
    end;
    ssActive, ssStarted, ssHolding: Assert(info.process <> nil);
  end;
  (*
   * Signal the server to exit and wait for confirmation
   *)
  info.serverState := ssStopped;
  info.process.Terminate();

  { TODO -oOVS : implement wait }

  result := true;
end;

function TPOAMediator_impl.waitfor(const orb: IORB; id: ORBMessageID;
  event: TORBCallbackEvent; tmout: long): boolean;
begin
  Assert(false);
  result := false;
end;

procedure TPOAMediator_impl.answer_invoke(mid: ORBMessageID;
  const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
begin
  Assert(false);
end;

function TPOAMediator_impl.bind(mid: ORBMessageID; const repoid: AnsiString;
  const oid: IObjectTag; const addr: IAddress): Boolean;
var
  ims: TImplDefSeq;
  tag: imr_int.TObjectTag;
  queue: boolean;
  count: integer;
  info: TServerInfo;
  msgids: IInterfaceList;
  i: integer;
  orbId: ORBMessageID;
  ad: IAddress;
  sync: ISynchronized;
begin
  ims := nil;
  result := false;
  if (addr <> nil) and not addr.is_local() then
    Exit;

  (*
   * Search the Implementation Repository for a POA entry that serves
   * the given Repository Id
   *)
  SetLength(tag, Length(oid.get_bytes));
  Move(Pointer(oid.get_bytes)^, Pointer(tag)^, Length(oid.get_bytes));
  ims := FIMR.find_by_repoid_tag(repoid, tag);

  (*
   * Make sure that all available servers are active. Start them if
   * necessary. Queue request until all servers are up.
   *)
  queue := false;
  count := 0;
  
  sync := TSynchronized.Create(FServerMapLock);
  
  for i := 0 to Length(ims) - 1 do begin
    if (ims[i].mode <> ActivatePOA) then
      System.Continue;

    count := Succ(count);

    if FServerMap.IndexOf(String(ims[i].name)) = -1 then begin
      info := TServerInfo.Create;
      FServerMap.AddObject(String(ims[i].name), info);
    end
    else
      info := TServerInfo(FServerMap.Objects[FServerMap.IndexOf(String(ims[i].name))]);

    if (info.serverState <> ssActive) and (info.serverState <> ssStopped) and (info.serverState <> ssHolding) then begin
      if not CreateServer(ims[i].name) then begin
	FORB.answer_bind(mid, LocateUnknown, nil);
	result := true;
        Exit;
      end;

      queue := true;
    end;
  end;

  if count = 0 then begin
    (*
     * No servers available
     *)
    result := false;
    Exit;
  end;

  if queue then begin
    FInvQueueLock.lock;
    try
      FInvQueue.Push(TInvQueueItem.Create(mid, repoid, oid));
    finally
      FInvQueueLock.unlock;
    end; { try/finally }
    result := true;
    Exit;
  end;

  (*
   * Try all active servers in our map
   *)

  (*
   * allocate slots for all bind requests, so that we can decide in
   * the callback() whether there are more outstanding requests or
   * not.
   *)
  msgids := TInterfaceList.Create; 
  FRequestLock.lock;
  try
    for i := 0 to FServerMap.Count - 1 do begin
      info := TServerInfo(FServerMap.Objects[i]);
      if info.serverState <> ssActive then
        System.Continue;
      orbId := FORB.new_orbid();
      msgids.Add(orbId);
      FRequests.Item[orbId] := mid;
    end;
  finally
    FRequestLock.unlock;
  end; { try/finally }

  (*
   * now send the requests
   *)
  for i := 0 to FServerMap.Count - 1 do begin
    info := TServerInfo(FServerMap.Objects[i]);
    if info.serverState <> ssActive then
      System.Continue;

    ad := info.ior.get_profile.address();
    Assert(ad <> nil);

    Assert(msgids.Count > 0);
    orbid := FORB.bind_async(repoid, oid, ad, Self as IORBCallback, ORBMessageID(msgids.Items[msgids.Count - 1]));
    msgids.Remove(msgids.Items[msgids.Count - 1]);
    Assert(orbid <> nil);
  end;

  result := true;
end;

procedure TPOAMediator_impl.cancel(id: ORBMessageID);
var
  again: boolean;
  i: integer;
  orbId: ORBMessageID;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FRequestLock);
  again := true;
  while again do begin
    again := false;
    for i := 0 to FRequests.Count - 1 do begin
      orbId := ORBMessageID(FRequests.Second(i));
      if orbId = id then begin
	FORB.cancel(orbId);
	FRequests.Delete(i);
	again := true;
	Break;
      end;
    end;
  end;
end;

function TPOAMediator_impl.locate(mid: ORBMessageID;
  const obj: IORBObject): Boolean;
begin
  FORB.answer_locate(mid, LocateHere, nil, 0);
  result := true;
end;

function TPOAMediator_impl.get_oaid: ObjectID;
begin
  result := 'mtdorb-poa-mediator';
end;

function TPOAMediator_impl.has_object(const obj: IORBObject): Boolean;
var
  key: ObjectId;
  len: _ulong;
  i, j: integer;
  svid: AnsiString;
  ids: TImplDefSeq;
  info: TServerInfo;
  sync: ISynchronized;
begin
  (*
   * Extract Objectkey from IOR. It starts with the POAImplName.
   * Take care of escaped slashes.
   *)
  ids := nil;
  result := false;
  if (obj = nil) or (obj._ior() = nil) or (obj._ior().get_profile() = nil) then
    Exit;

  key := obj._ior().get_profile().objkey(len);

  if (key = '') then
    Exit;

  j := 1; i := 1;
  while i < integer(len) do begin
    if (key[i] = '\') then
      j := Succ(j)
    else if (key[i] = '/') and ((j mod 2) = 0) then begin
      i := Pred(i);
      Break
    end
    else
      j := 0;
    i := Succ(i);
  end;

  j := 1;
  while j <= i do begin
    if (key[j] = '\') then
      j := Succ(j);
    svid := svid + key[j];
    j := Succ(j);
  end;

  (*
   * Look up ServerId in Map
   *
   * If it isn't in the map, but in the Implementation Repository, recreate
   * an svmap entry so that the server will be restarted upon invoke().
   *)
  sync := TSynchronized.Create(FServerMapLock);
  if FServerMap.IndexOf(String(svid)) = -1 then begin
    ids := FIMR.find_by_name(svid);
    if Length(ids) = 0 then
      Exit;
    info := TServerInfo.Create();
    FServerMap.AddObject(String(svid), info);
    info.serverState := ssInactive;
  end;

  result := true;
end;

function TPOAMediator_impl.invoke(mid: ORBMessageID; const obj: IORBObject;
  const req: IORBRequest; const pr: IPrincipal;
  response_exp: Boolean): Boolean;
var
  key: ObjectId;
  len: _ulong;
  i, j: integer;
  svid: AnsiString;
  ids: TImplDefSeq;
  info: TServerInfo;
  ior: IIOR;
  remoteRef: IORBObject;
  orbId: ORBMessageID;
  sync: ISynchronized;
begin
  (*
   * Extract Objectkey from IOR. It starts with the POAImplName.
   *)
  ids := nil;
  Assert((obj <> nil) and (obj._ior() <> nil) and (obj._ior().get_profile() <> nil));

  key := obj._ior().get_profile().objkey(len);
  Assert(key <> '');

  j := 1; i := 1;
  while i < integer(len) do begin
    if (key[i] = '\') then
      j := Succ(j)
    else if (key[i] = '/') and ((j mod 2) = 0) then begin
      i := Pred(i);
      Break;
    end
    else
      j := 0;
    i := Succ(i);
  end;

  j := 1;
  while j <= i do begin
    if (key[j] = '\') then
      j := Succ(j);
    svid := svid + key[j];
    j := Succ(j);
  end;

  (*
   * Look up ServerId in Map
   *)
  sync := TSynchronized.Create(FServerMapLock);
  i := FServerMap.IndexOf(String(svid));
  if i = -1 then begin
    (*
     * Server has disappeared? Oh well.
     *)
    req.set_out_args(SystemException.Create_type(st_OBJECT_NOT_EXIST));
    FORB.answer_invoke(mid, InvokeSysEx, nil, req, 0);
    result := true;
    Exit;
  end;

  (*
   * If the Server is stopped, queue the request
   *)
  info := TServerInfo(FServerMap.Objects[i]);
  if (info.serverState = ssStopped) or (info.serverState = ssHolding) then begin
    FInvQueueLock.lock;
    try
      FInvQueue.Push(TInvQueueItem.Create(mid, obj, req, pr, response_exp));
    finally
      FInvQueueLock.unlock;
    end; { try/finally }
    result := true;
    Exit;
  end;

  (*
   * Is Server active?
   *)
  if (info.serverState <> ssActive) then begin
    (*
     * No? Restart it.
     *)
    if not CreateServer(svid) then begin
      (*
       * failed.
       *)
      req.set_out_args(SystemException.Create_type(st_OBJECT_NOT_EXIST));
      FORB.answer_invoke(mid, InvokeSysEx, nil, req, 0);
      result := true;
      Exit;
    end;

    (*
     * Server has been started, but is not active yet. We must queue
     * the request until the server announces its readiness by calling
     * activate_impl().
     *)
    FInvQueueLock.lock;
    try
      FInvQueue.Push(TInvQueueItem.Create(mid, obj, req, pr, response_exp));
    finally
      FInvQueueLock.unlock;
    end; { try/finally }
    result := true;
    Exit;
  end;

  (*
   * Construct remote object reference
   *)

  ior := TIOR.Create(info.ior);
  ior.set_objectkey(key, len);
  ior.set_objectid(obj._ior().objid());

  remoteRef := TORBObject.Create(ior);

  if response_exp and FForward then begin
    // forward to server ...
    FORB.answer_invoke(mid, InvokeForward, remoteRef, req, 0);
    result := true;
    Exit;
  end;
  (*
   * do the invocation (on the remote object)
   *)
  orbId := FORB.new_orbid();

  if response_exp then begin
    FRequestLock.lock;
    try
      FRequests.Item[orbId] := mid;
    finally
      FRequestLock.unlock;
    end; { try/finally }
  end;

  FORB.invoke_async(remoteRef, req, pr, response_exp, Self as IORBCallback, orbId);
  result := true;
end;

function TPOAMediator_impl.is_local: Boolean;
begin
  result := true;
end;

procedure TPOAMediator_impl.shutdown(WaitForCompletion: Boolean);
begin
  FInvQueueLock.lock;
  try
    FInvQueue.Fail();
  finally
    FInvQueueLock.unlock;
  end; { try/finally }
  FORB.answer_shutdown(Self);
end;

function TPOAMediator_impl.skeleton(const obj: IORBObject): IORBObject;
begin
  result := nil;
end;

{ TInvQueueItem }

constructor TInvQueueItem.Create(mid: ORBMessageID; const obj: IORBObject;
  const req: IORBRequest; const pr: IPrincipal; response_exp: Boolean);
begin
  FType := RequestInvoke;
  FId := mid;
  FObj := obj;
  FReq := req;
  FPrincipal := pr;
  FResponseExp := response_exp;
end;

constructor TInvQueueItem.Create(mid: ORBMessageID;
  const repoid: RepositoryId; const tag: IObjectTag);
begin
  FType := RequestBind;
  FId := mid;
  FRepoId := repoid;
  FTag := tag;
end;

constructor TInvQueueItem.Create(mid: ORBMessageID; const obj: IORBObject);
begin
  FType := RequestLocate;
  FId := mid;
  FObj := obj;
end;

procedure TInvQueueItem.Exec(OAdapter: IObjectAdaptor; orb: IORB);
begin
  case FType of
    RequestInvoke:
      OAdapter.invoke(FId, FObj, FReq, FPrincipal, FResponseExp);
    RequestBind:
      if not OAdapter.bind(FId, FRepoId, FTag, nil) then
          orb.answer_bind(FId, LocateUnknown, nil);
    RequestLocate:
      //OAdapter.locate(FId, FObj);
    else
      Assert(false);
  end;
end;

{ TInvocationQueue }

constructor TInvocationQueue.Create(oa: IObjectAdaptor; orb: IORB);
begin
  inherited Create;
  FOAdapter := oa;
  FORB := orb;
end;

procedure TInvocationQueue.ExecNow;
var
  inv: TInvQueueItem;
  list: TQueue;
begin
  list := TQueue.Create;
  try
    //copy to temporary list
    while Count > 0 do
      list.Push(Pop());

    while list.Count > 0 do begin

      inv := list.Pop();
      (*
       * if invoke cannot be executed yet mediator will install
       * new ReqQueueRec ...
       *)
      inv.Exec(FOAdapter, FORB);
      FreeAndNil(inv);
    end; { while }
  finally
    list.Free;
  end; { try/finally }
end;

procedure TInvocationQueue.Fail;
begin
end;

{$ELSE}
implementation
{$ENDIF}
end.
