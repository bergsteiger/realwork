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
unit proxy;

interface

uses
  orb_int,orb,Classes,orbtypes,SysUtils,giop_int,addr_int,mtmanager,mtmanager_int,
  code_int,comp_int,iiop_int,disp_int,req_int,map_int,env_int,iop,osthread,map,
  policy_int;

{$I dorb.inc}

{$IFNDEF USELIB}

type

  TIIOPProxy = class(TORBObject, IObjectAdaptor, IGIOPCallBack, IGIOPConnectionMgr)
  private
    FMaxMessageSize: _ulong;
    FConnections : IInterfaceInterfaceMap;
    FProfileConnMap: IInterfaceInterfaceMap;
    FConnMutex: TRecursiveMutex;
    FProfileMutex: TRecursiveMutex;
    FInvMutex: TMutex;
{$IFDEF USE_IOP_CACHE}
    FCacheUsed : Boolean;
    FCacheRecord : IIIOPProxyInvokeRecord;
{$ENDIF}
    FInvokes : ILongInterfaceMap;
    FGIOPVersion: _ushort;
{$IFDEF HAVE_THREADS}
    FDispatcher: IORBDispatcher;
{$ENDIF}
    procedure deref_connection(const conn: IGIOPConnection; all: boolean = false);
  protected
    function waitfor(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent; tmout: Longint = -1): boolean;
    procedure notify(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent);
    function input_giop_callback(const conn: IGIOPConnection;const buf: IBuffer{;event: TEventType}): Boolean;
{$IFDEF HAVE_THREADS}
    procedure send_orb_msg(const conn: IGIOPConnection;event: TORBMsgEvent);
{$ENDIF}
    procedure connection_error(const conn: IGIOPConnection; senderror : Boolean = true);
    procedure callback(const orb: IORB; mid: MessageID; event: TORBCallbackEvent);
    procedure answer_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
    function skeleton(const obj: IORBObject): IORBObject;
    function kill_connection(const conn: IGIOPConnection; redo: Boolean): Boolean;
    function make_connection(const addr: IAddress; version: _ulong = 0): IGIOPConnection; overload;
    function make_connection(const obj: IORBObject): IGIOPConnection; overload;
    function invoke(mid: ORBMessageID;const obj: IORBObject;const req: IORBRequest; const pr: IPrincipal; response_exp: Boolean): Boolean; stdcall;
    function has_object(const obj: IORBObject): Boolean;
    function get_codeset_ids(const obj: IORBObject;var csid,wcsid: CodesetID): Boolean;
    function handle_invoke_reply(const conn: IGIOPConnection; const incon: IGIOPInContext): Boolean;
    function handle_locate_reply(const conn: IGIOPConnection; const incon: IGIOPInContext): Boolean;
    function handle_input(const conn: IGIOPConnection; const inp: IBuffer): Boolean;
    function giop_callback(const conn: IGIOPConnection;event: TEventType): Boolean;
    function create_invoke(): IIIOPProxyInvokeRecord;
    procedure del_invoke(rec: IIIOPProxyInvokeRecord);
    procedure add_invoke(inv: IIIOPProxyInvokeRecord);
    function pull_invoke(mid: ORBMessageID): IIIOPProxyInvokeRecord;
    procedure exec_invoke_reply(ctx: IGIOPInContext;reqid : ORBMessageID; rtype: TReplyStatusType;
      obj: IORBObject; req: IORBRequest; ad: AddressingDisposition; conn: IGIOPConnection);
    function bind(mid: ORBMessageID; const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress): Boolean;
    function get_oaid(): ObjectID;
    function is_local(): Boolean;
    procedure abort_invoke(mid: ORBMessageID);
    procedure redo_invoke(mid: ORBMessageID);
    procedure shutdown(WaitForCompletion: Boolean);
    procedure cancel(id: ORBMessageID);
    function locate(mid: ORBMessageID; const obj : IORBObject): Boolean;
    { IGIOPConnectionMgr }
    function Dispatcher: IORBDispatcher;
    procedure add_connection(const conn: IGIOPConnection; const addr: IAddress);
    function find_connection(const addr: IAddress): IGIOPConnection;
    function get_current_connection(): IGIOPConnection;
  public
    constructor Create(orb: IORB; giop_version: _ushort = $0100; max_size: _ulong = 0);
    destructor Destroy(); override;
  end;

implementation

uses
  decoder,encoder,buffer,codeset_ref,iior_int,mcomp_int,codec,osnet,throw,
  ior,static,req,exceptions,except_int,utils,mtdebug,policy;

function CompareAddress(const Item1, Item2: IInterface): boolean;
begin
  result := (Item1 as IAddress).compare(Item2 as IAddress);
end;

{********************************************************************
  TIIOPProxy
********************************************************************}
constructor TIIOPProxy.Create(orb : IORB; giop_version: _ushort; max_size: _ulong);
begin
  FOrb := orb;
  FGIOPVersion := giop_version;
  FMaxMessageSize := max_size;
  FConnections := TInterfaceInterfaceMap.Create;//TStringList.Create;
  FConnections.SetCompareFunc(CompareAddress);
  FProfileConnMap := TInterfaceInterfaceMap.Create;
  FConnMutex := TRecursiveMutex.Create;
  FProfileMutex := TRecursiveMutex.Create;
  FInvMutex := TMutex.Create;
{$IFDEF HAVE_THREADS}
  FDispatcher := TDummyDispatcher.Create;
{$ENDIF}
{$IFDEF USE_IOP_CACHE}
  FCacheUsed := False;
  FCacheRecord := TIIOPProxyInvokeRecord.Create;
{$ENDIF}
  FInvokes := TLongInterfaceMap.Create;
  orb.register_oa(self,OAPriorityRemote);
end;

destructor TIIOPProxy.Destroy;
var
  i : integer;
begin
  FOrb.unregister_oa(Self);
  FConnMutex.lock();
  try
    for i := 0 to Pred(FConnections.Count) do
      //IGIOPConnection(Pointer(FConnections.Objects[i]))._release;
      FOrb.resource_manager().release_connection();
    FConnections := nil;
  finally
    FConnMutex.unlock();
  end; { try/finally }
  FInvMutex.lock();
  try
    FInvokes := nil;
  finally
    FInvMutex.unlock();
  end; { try/finally }
  //FConnections.Free;
  FreeAndNil(FConnMutex);
  FreeAndNil(FInvMutex);
  FInvokes := nil;
  FProfileConnMap := nil;
  FreeAndNil(FProfileMutex);
  inherited;
end;

procedure TIIOPProxy.callback(const orb: IORB; mid: MessageID; event: TORBCallbackEvent);
begin
  assert(false,'not implemented');
end;

procedure TIIOPProxy.answer_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
begin
  assert(false,'not implemented');
end;

function TIIOPProxy.is_local(): Boolean;
begin
  result := false;
end;

function TIIOPProxy.skeleton(const obj: IORBObject): IORBObject;
begin
  result := nil;
end;

function TIIOPProxy.get_oaid(): ObjectID;
begin
  result :=  'dorb-iiop-proxy';
end;

function TIIOPProxy.pull_invoke(mid: ORBMessageID): IIIOPProxyInvokeRecord;
var
  sync: ISynchronized;
begin
  if mid = nil then
    Exit;
  sync := TSynchronized.Create(FInvMutex);
{$IFDEF USE_IOP_CACHE}
  if FCacheUsed and (FCacheRecord.id = mid) then
    begin
      result := FCacheRecord;
      exit;
    end;
{$ENDIF}
  //result := IIIOPProxyInvokeRecord(FInvokes[mid]);
  result := IIIOPProxyInvokeRecord(FORB.get_invoke_hint(mid));
  //result._Release;
  if (result <> nil) and result.active() then begin
    result.deactivate();
  end;
end;

procedure TIIOPProxy.add_invoke(inv: IIIOPProxyInvokeRecord);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FInvMutex);
{$IFDEF USE_IOP_CACHE}
  if inv = FCacheRecord then Exit;
{$ENDIF}
  Assert(inv.active());
  FInvokes[FOrb.get_msgid(inv.id)] := inv;
  inv._AddRef;
  FOrb.set_invoke_hint(inv.id, Pointer(inv));
end;

procedure TIIOPProxy.del_invoke(rec: IIIOPProxyInvokeRecord);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FInvMutex);
  Assert(not rec.active());
{$IFDEF USE_IOP_CACHE}
  if FCacheUsed and (FCacheRecord.id = id) then
    begin
      FCacheRecord.reset;
      FCacheUsed := false;
      exit;
    end;
{$ENDIF}
  FInvokes.erase(rec.msgid());
  rec._Release;
end;

function TIIOPProxy.create_invoke(): IIIOPProxyInvokeRecord;
begin
{$IFDEF USE_IOP_CACHE}
  if FCacheUsed then
    result := TIIOPProxyInvokeRecord.Create
  else
    begin
      FCacheUsed := True;
      result := FCacheRecord;
    end;
{$ELSE}
  result := TIIOPProxyInvokeRecord.Create;
{$ENDIF}
end;

function TIIOPProxy.make_connection(const obj: IORBObject): IGIOPConnection;
var
  prof, tmp: IIORProfile;
  profIdx: cardinal;
  addr: IAddress;
  version: _ushort;
  i: integer;
  sync: ISynchronized;
  sysExc: ISystemException;
  tpp: ITransportPrefPolicy;
  prefs: TProfileTagSeq;
begin
  profIdx := 0;
  prefs := nil;
  (*
   * See if we have already opened a conn for this profile
   *)
  prof := obj.fwd_ior.active_profile(profIdx);
  if prof <> nil then begin
    FProfileMutex.lock;
    try
      result := IGIOPConnection(FProfileConnMap.Item[prof]);
    finally
      FProfileMutex.unlock;
    end; { try/finally }
    if result <> nil then begin
      //result.activeRef();
      Exit;
    end;
    (*
     * There was an active (connected) profile, but the conn is gone.
     * Invalidate active profile; we might have to reconnect using an
     * alternate address
     *)
    obj.fwd_ior.active_profile(tmp);//send nil, bug in Kylix compiler  
  end;

  (*
   * FProfileConnMap could grow indefinitely if the same object is created
   * over and over again to perform operations on it.
   *
   * Because FProfileConnMap is nothing more than a cache really, we can
   * simply clear it before it grows beyond an arbitrary limit.
   *)
  FProfileMutex.lock;
  try
    if FProfileConnMap.Count > 100 then begin
      for i := Pred(FProfileConnMap.Count) downto 0 do
        FProfileConnMap.Delete(i);
      FProfileConnMap.clear();
    end;
  finally
    FProfileMutex.unlock;
  end; { try/finally }

  (*
   * Open a new connection, or select a profile that matches an open
   * connection.
   *)
  tpp := TTransportPrefPolicy._narrow(obj.get_policy(TRANSPORTPREF_POLICY_TYPE));
  Assert(tpp <> nil);
  prefs := tpp.preferences_nocopy;

  sync := TSynchronized.Create(FConnMutex);
  for i := 0 to Length(prefs) - 1 do begin
    prof := obj.fwd_ior.get_profile(prefs[i]);
    while (prof <> nil) do begin
      result := IGIOPConnection(FConnections.Find(prof.address()));
      if result <> nil then begin
        //if not result.activeRef() then begin
        if (result.state() <> esActive) then begin
          result := nil;
          Continue;
        end;
        obj.fwd_ior.active_profile(prof);
        FProfileMutex.lock;
        try
          FProfileConnMap.Item[prof] := result;
        finally
          FProfileMutex.unlock;
        end; { try/finally }
        sync := nil;
        Exit;
      end;
      prof := obj.fwd_ior.get_profile(prefs[i], false, prof);
    end;
  end;
  sync := nil;

  for i := 0 to Length(prefs) - 1 do begin
    prof := obj.fwd_ior.get_profile(prefs[i]);
    while (prof <> nil) do begin
      addr := prof.address();
      Assert(addr <> nil);
      version := 0;
      if prof.id = TAG_INTERNET_IOP then
        version := (prof as IIOPProfile).version();
      try
        result := make_connection(addr, version);
      except
        on E: SystemException do begin
          sysExc := SystemException.Create(E);
          //re-rasing exception if
          //we catch TRANSIENT or COMM_FAILURE exception and check last profile
          //we catch other exceptions
          if (sysExc.extype in [st_TRANSIENT, st_COMM_FAILURE]) and (i = High(prefs)) or
             not (sysExc.extype in [st_TRANSIENT, st_COMM_FAILURE]) and (i <= High(prefs)) then
            raise;
        end;
      end; { try/except }
      if result <> nil then begin
        obj.fwd_ior.active_profile(prof);
        FProfileMutex.lock;
        try
          FProfileConnMap.Item[prof] := result;
        finally
          FProfileMutex.unlock;
        end; { try/finally }
        Exit;
      end;
      prof := obj.fwd_ior.get_profile(prefs[i], false, prof);
    end;
  end;
  if sysExc <> nil then
    sysExc.throw();
end;

function TIIOPProxy.make_connection(const addr: IAddress; version: _ulong): IGIOPConnection;
var
  //i: integer;
  transport: ITransport;
  sync: ISynchronized;
begin
  //FOrb.register_oa(Self,OAPriorityRemote);
  sync := TSynchronized.Create(FConnMutex);
  result := nil;
  if addr = nil then exit;
  {i := FConnections.IndexOf(addr.toString);
  if i >= 0 then begin
    result := IGIOPConnection(Pointer(FConnections.Objects[i]));
    if not result.activeRef() then
      result := nil;
  end}
  result := IGIOPConnection(FConnections.Find(addr));
  if result <> nil then begin
{$IFDEF HAVE_THREADS}
    // The connection was created and I have it in FConnections map
    // so I don't need to increment active ref count
    // I'll only test if it's active
    // if not result.activeRef() then
    if (result.state() <> esActive) then
      result := nil;
    Exit;
{$ELSE}
    Exit;
{$ENDIF}
  end
  else begin
{$IFDEF HAVE_THREADS}
    if not FOrb.resource_manager().acquire_connection() then
      Exit;
{$ENDIF}
    if (version = 0) or (version > FGIOPVersion) then
      version := FGIOPVersion;

{$IFDEF HAVE_THREADS}
    try
{$ENDIF}
      transport := addr.make_transport();
      if transport.connect(addr) then begin
{$IFDEF HAVE_THREADS}
        result := TGIOPConnection.Create(Dispatcher(), FORB, transport, Self,
          TGIOPCodec.Create(TDecoder.Create(nil), TEncoder.Create(nil), version),
          0 { no tmout }, FMaxMessageSize, true, true{false});
{$ELSE}
        result := TGIOPConnection.Create(Dispatcher(), FORB, transport, Self,
          TGIOPCodec.Create(TDecoder.Create(nil), TEncoder.Create(nil), version),
          0 { no tmout }, FMaxMessageSize);
{$ENDIF}
        //result._AddRef;
        //FConnections.AddObject(transport.peer.toString,Pointer(result));
        FConnections.Item[transport.peer] := result;
{$IFDEF HAVE_THREADS}
        result.start();
        if not result.activeRef() then
          result := nil;
{$ENDIF}
      end
{$IFDEF HAVE_THREADS}
      else
        FOrb.resource_manager().release_connection();
    except
      FOrb.resource_manager().release_connection();
      raise;
    end; { try/except }
{$ENDIF}
  end;
end;

procedure TIIOPProxy.exec_invoke_reply(ctx: IGIOPInContext;reqid : ORBMessageID; rtype: TReplyStatusType;
      obj: IORBObject; req: IORBRequest; ad: AddressingDisposition; conn: IGIOPConnection);
var
  orb_stat : TInvokeStatus;
  bindobj : IORBObject;
  stat : TLocateStatusType;
begin
  case _orb.request_type(reqid) of
    RequestInvoke:  begin
        if rtype = orbtypes.NO_EXCEPTION then
          orb_stat := orbtypes.InvokeOk
        else if rtype = orbtypes.USER_EXCEPTION then
          orb_stat := orbtypes.InvokeUserEx
        else if rtype = orbtypes.SYSTEM_EXCEPTION then
          orb_stat := orbtypes.InvokeSysEx
        else if rtype = orbtypes.LOCATION_FORWARD then
          orb_stat := orbtypes.InvokeForward
        else if rtype = orbtypes.LOCATION_FORWARD_PERM then
          orb_stat := orbtypes.InvokeForward
        else if rtype = NEEDS_ADDRESSING_MODE then
          orb_stat := orbtypes.InvokeAddrDisp
        else
          orb_stat := orbtypes.InvokeOk;
        _orb.answer_invoke(reqid, orb_stat, obj, req, 0);
      end;
    RequestBind:  begin
        if (rtype <> orbtypes.NO_EXCEPTION) or
           (not conn.codec.get_bind_reply(ctx,stat,bindobj)) or
           (stat <> OBJECT_HERE) then
          _orb.answer_bind(reqid,orbtypes.LocateUnknown,nil)
        else
          _orb.answer_bind(reqid,orbtypes.LocateHere,bindobj)
      end;
    RequestUnknown: ;// request was canceled or reply contains invalid id
    else
      Assert(false);
  end;
end;

function TIIOPProxy.handle_invoke_reply(const conn: IGIOPConnection;const incon: IGIOPInContext): Boolean;
var
  reqid : _ulong;
  id: ORBMessageID;
  status : TReplyStatusType;
  rec : IIIOPProxyInvokeRecord;
  obj : IORBObject;
  ex: ISystemException;
  cd: IGIOPCodec;
  ctx: ServiceContextList;
  ad: AddressingDisposition;
begin
  result := false;
  if not conn.codec.get_invoke_reply1(incon,reqid,status,ctx) then
    begin
      connection_error(conn,true);
      exit;
    end;
  // turn the MsgId into somthing usefull
  id := FOrb.get_orbid(reqid);
  rec := pull_invoke(id);
{$IFDEF HAVE_THREADS}
  conn.activeDeref();
{$ENDIF}
  if rec = nil then 	// has been canceled;
    begin
      result := true;
      exit;
    end;

  incon.set_converter(conn.codec.converter());

  cd := conn.codec as IGIOPCodec;
  try
    if not cd.get_invoke_reply2(incon, reqid, status, obj, rec.request, ad, ctx) then begin
      if rec.request <> nil then begin
        ex := MARSHAL.Create(0, COMPLETED_MAYBE);
        rec.request.set_out_args(ex);
        status := SYSTEM_EXCEPTION;
      end;
    end;
  except
    on E: SystemException do
      if rec.request <> nil then begin
        rec.request.set_out_args(E);
        status := SYSTEM_EXCEPTION;
      end;
    on E: Exception do
      if rec.request <> nil then begin
        ex := INTERNAL.Create(E.Message, 0, COMPLETED_MAYBE);
        rec.request.set_out_args(ex);
        status := SYSTEM_EXCEPTION;
      end;
  end;

  // we have to delete IIOPProxyInvokeRec before notifying waiting
  // thread with reply, because client code might do another
  // invocation where old ORBInvokeRec is deleted and new one
  // created on the same address (might be). Then after switching
  // back to this code del_invoke would delete invocation hint on
  // this new ORBInvokeRec which belong to another invocation and so
  // after receiving reply for this invocation - it'll be w/o hint
  // and so will look like canceled invocation. This wrong behaviour
  // is fixed with moving del_invoke before exec_invoke_reply
  // NOTE: Don't delete req!
  del_invoke(rec);
  exec_invoke_reply(incon, id, status, obj, rec.request, ad, conn);

  deref_connection(conn);

  result := true;
end;

function TIIOPProxy.handle_locate_reply(const conn: IGIOPConnection; const incon: IGIOPInContext): Boolean;
var
  req_id: _ulong;
  stat: TLocateStatusType;
  orb_stat: TLocateStatus;
  obj: IORBObject;
  ad: AddressingDisposition;
  id: ORBMessageID;
  rec: IIIOPProxyInvokeRecord;
begin
  stat := OBJECT_HERE;
  orb_stat := LocateHere;
  result := false;

  if not conn.codec().get_locate_reply(incon, req_id, stat, obj, ad) then begin
    connection_error(conn);
    Exit;
  end;

  id := FORB.get_orbid(req_id);
  rec := pull_invoke(id);
{$IFDEF HAVE_THREADS}
  conn.activeDeref();
{$ENDIF} // HAVE_THREADS
  if rec = nil then begin
    // has been canceled; cancel() did the deref() already
    result := true;
    Exit;
  end;

  case stat of
    UNKNOWN_OBJECT: orb_stat := LocateUnknown;
    OBJECT_HERE: orb_stat := LocateHere;
    OBJECT_FORWARD, OBJECT_FORWARD_PERM: orb_stat := LocateForward;
    LOC_NEEDS_ADDRESSING_MODE: orb_stat := LocateAddrDisp;
  else
    Assert(false);
  end;

  del_invoke(rec);

  FORB.answer_locate(id, orb_stat, obj, ad);
  obj := nil;

  deref_connection(conn);

  result := true;
end;

function TIIOPProxy.handle_input(const conn: IGIOPConnection; const inp: IBuffer): Boolean;
var
  ctx : IGIOPInContext;
  mt : TMessageType;
  size: _ulong;
  flags: byte;
  IIOPServ: IGIOPCallBack;
begin
  result := false;
  ctx := TGIOPInContext.Create(conn.codec,inp{conn.input},nil);
  if not conn.codec.get_header(ctx,mt,size,flags) then begin
{$IFDEF HAVE_THREADS}
    conn.activeDeref();
{$ENDIF}
    connection_error(conn);
    exit;
  end;
  case mt of
    orbtypes.Reply: result := handle_invoke_reply(conn, ctx);
    orbtypes.LocateReply: result := handle_locate_reply(conn, ctx);
    orbtypes.CloseConnection: begin
        if not conn.codec.get_close_msg(ctx) then begin
{$IFDEF HAVE_THREADS}
          conn.activeDeref();
{$ENDIF}
          connection_error(conn,true);
        end
        else begin
{$IFDEF HAVE_THREADS}
          conn.activeDeref();
{$ENDIF}
          kill_connection(conn,true); // restore
        end;
      end;
    orbtypes.MessageError : begin
        if not conn.codec.get_error_msg(ctx) then begin
{$IFDEF HAVE_THREADS}
          conn.activeDeref();
{$ENDIF}
          connection_error(conn,false);
          result := true;
        end
        else begin
{$IFDEF HAVE_THREADS}
          conn.activeDeref();
{$ENDIF}
          kill_connection(conn,false);
        end;
      end;
    orbtypes.Request, orbtypes.LocateRequest, orbtypes.CancelRequest: begin
        //check for BiDir connection
        IIOPServ := FORB.get_oa('dorb-iiop-server') as IGIOPCallBack;
        IIOPServ.input_giop_callback(conn, inp);
      end;
    else begin
{$IFDEF HAVE_THREADS}
      conn.activeDeref();
{$ENDIF}
      connection_error(conn,false);
      result := false;
    end;
  end;
end;

function TIIOPProxy.kill_connection(const conn: IGIOPConnection; redo: Boolean): Boolean;
var
  i : integer;
  found: boolean;
  again: boolean;
begin
  result := false; found := false;
  //FOrb.unregister_oa(Self);
  FConnMutex.lock();
  try
    repeat
      again := false;
      for i := 0 to Pred(FConnections.Count) do begin
        if FConnections.Second(i) = conn then begin
          FConnections.Delete(i);
          again := true;
          found := true;
          Break;
        end;
      end;
    until not again;
  finally
    FConnMutex.unlock();
  end; { try/finally }

  FProfileMutex.lock;
  try
    repeat
      again := false;
      for i := 0 to Pred(FProfileConnMap.Count) do begin
        if FProfileConnMap.Second(i) = conn then begin
          FProfileConnMap.Delete(i);
          again := true;
          Break;
        end;
      end; { for }
    until not again;
  finally
    FProfileMutex.unlock;
  end; { try/finally }

  if not found then Exit;

{$IFDEF HAVE_THREADS}
  conn.activeDeref();
  conn.terminate();
{$ENDIF}

{$IFDEF USE_IOP_CACHE}
  if FCacheUsed and (FCacheRecord.connection = conn) then
    begin
      if redo then
        assert(false,'not imlplemented')
      else
        abort_invoke(FCacheRecord.id);
    end;
{$ENDIF}
  repeat
    again := false;
    FInvMutex.lock();
    if FInvokes.Count = 0 then begin
      again := true;
      FInvMutex.unlock();
    end
    else
      for i := 0 to Pred(FInvokes.Count) do
        with IIIOPProxyInvokeRecord(FInvokes.Items(i)) do begin
          if (connection <> conn) or not active() then
            Continue;

          FInvMutex.unlock();

          if redo then
            redo_invoke(id)
          else
            abort_invoke(id);

          conn.deref();
          again := true;
          Break;
        end;
    if not again then
      FInvMutex.unlock();
  until again;
  deref_connection(conn);
end;

function TIIOPProxy.giop_callback(const conn: IGIOPConnection;event: TEventType): Boolean;
begin
  result := true;
  case event of
    InputReady: result:= handle_input(conn, conn.input);
    Closed,Idle : begin
      kill_connection(conn,false);
      result := true;
    end;
    else
      assert(false,'not implemented');
  end;
end;

function TIIOPProxy.get_codeset_ids(const obj: IORBObject;var csid,wcsid: CodesetID): Boolean;
var
 csc : ICodesetComponent;
 prof : IIORProfile;
 mc : IMultiComponent;
 comp : IORBComponent;
begin
  prof := obj._IOR.get_profile(TAG_MULTIPLE_COMPONENTS);
  if prof <> nil then
    begin
      mc := IMultiComponent(IMultiComponentProfile(prof).get_components());
      comp := ICodesetComponent(mc.get_component(TAG_CODE_SETS));
      if comp <> nil then
        csc := ICodesetComponent(comp);
    end;
  if csc <> nil then
    begin
      csid := csc.selected_cs;
      wcsid := csc.selected_wcs;
    end
  else
    begin
      csid := $00010001;
      wcsid := $00010109;
    end;
  result := true;
end;

function TIIOPProxy.bind(mid: ORBMessageID; const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress): Boolean;
var
  conn: IGIOPConnection;
  outc : IGIOPOutContext;
  rec: IIIOPProxyInvokeRecord;
begin
  result := false;
  if (addr = nil) then exit;
  try
    conn := make_connection(addr);
  except
    on E: TRANSIENT do ;
    on E: COMM_FAILURE do ;
  end; { try/except }
  if conn = nil then
    begin
      _orb.answer_bind(mid,LocateUnknown,nil);
      result := true;
      exit;
    end;
{$IFDEF HAVE_THREADS}
  Assert(conn.activeRef());
{$ENDIF}

  outc := TGIOPOutContext.Create(conn.codec,nil);
  conn.codec.put_bind_request(outc,FOrb.get_msgid(mid),repoid,oid);

  conn.ref();
  rec := create_invoke();
  rec.init(mid,conn,nil);
  add_invoke(rec);
  conn.output(outc.buffer);
{$IFDEF HAVE_THREADS}
  conn.activeDeref();
{$ENDIF}
  result := true;
end;

function TIIOPProxy.invoke(mid: ORBMessageID;const obj: IORBObject;const req: IORBRequest; const pr: IPrincipal; response_exp: Boolean): Boolean;
var
  connection : IGIOPConnection;
  ocnt : IGIOPOutContext;
  rec: IIIOPProxyInvokeRecord;
  id: MessageID;
  //ex: IORBException;
begin
  result := false;
  try
    connection := make_connection(obj);
  except
    on E: SystemException do begin
      //ex := SystemException.Create(E) as IORBException;
{
2008.08.14
WJ: Moved from below
If NameService works, but has entry pointing to nonworking service (ie: dummy IP address)
information about exception has been missing here (after Exit).
It gives infinite loop, because TRequest.get_responce will try connect again and again.

Closes error 800832.
}
      req.set_out_args(E);
      _orb.answer_invoke(mid, InvokeSysEx, nil, req, 0);
      raise;
    end;
  end; { try/except }
{  if ex <> nil then begin
    req.set_out_args(ex);
    _orb.answer_invoke(mid, InvokeSysEx, nil, req, 0);
    Exit;
  end;}
  if connection <> nil then begin
{$IFDEF HAVE_THREADS}
    Assert(connection.activeRef());
{$ENDIF}
    if connection.codec.converter = nil then begin
      connection.get_exclusive();
      try
        if not connection.codec.setup_codeset_ids(obj) then begin
          req.set_out_args(SystemException.Create_type(st_DATA_CONVERSION) as IORBException);
          _orb.answer_invoke(mid, InvokeSysEx, nil, req, 0);
          connection.activeDeref();
          Exit;
        end;
      finally
        connection.release_exclusive();
      end; { try/finally }
    end;
    // I think that we can allocate for oneway call yet another msgid
    // so in case of using oneway calls the msgids are scaled after two not after
    // one because we've already allocated it in ORB::invoke_async and now here
    id := FORB.get_msgid(mid);
    if id = 0 then
      id := obj._orb().new_MessageID();
    ocnt := TGIOPOutContext.Create(connection.codec, connection.codec.converter);
    if connection.codec.put_invoke_request(ocnt, id, response_exp, obj, req, pr) then begin
      if response_exp then
        begin
          connection.ref();
          rec := create_invoke();
          rec.init(mid, connection, req);
          add_invoke(rec);
        end;
      connection.output(ocnt.buffer);
{$IFDEF HAVE_THREADS}
      connection.activeDeref();
{$ENDIF}
      result := true;
{$IFNDEF HAVE_THREADS}
      if response_exp and Dispatcher().isblocking() then
        connection.do_read(Dispatcher().isblocking());
{$ENDIF}
    end
    else begin
      req.set_out_args(SystemException.Create_type(st_MARSHAL) as IORBException);
      _orb.answer_invoke(mid, InvokeSysEx, nil, req, 0);
{$IFDEF HAVE_THREADS}
      connection.activeDeref();
{$ENDIF}
    end;
  end
  else begin
    req.set_out_args(SystemException.Create_type(st_COMM_FAILURE) as IORBException);
    _orb.answer_invoke(mid, InvokeSysEx, nil, req, 0);
  end;
end;

function TIIOPProxy.has_object(const obj: IORBObject): Boolean;
var
  temp: IIOR;
  p1, p2: IIORProfile;
  i: integer;
begin
  result := false;
  temp := FOrb.ior_template();
  for i := 0 to High(VALID_PROFILES) do begin
    p1 := obj.fwd_ior.get_profile(VALID_PROFILES[i]);
    if p1 <> nil then begin
      p2 := temp.get_profile(VALID_PROFILES[i]);
      result := (p2 = nil) or (not (p1 = p2));
      Break;
    end;
  end;
end;

{**  send ansower with exception }
procedure TIIOPProxy.abort_invoke(mid: ORBMessageID);
var
  obj : IORBObject;
  req : IRequest;
  local : IORBRequest;
begin
  del_invoke(pull_invoke(mid));
  case FORB.request_type(mid) of
    RequestInvoke: begin
        obj := TORBObject.Create(TIOR.Create as IIOR);
        req := TRequest.Create(obj,'someop');
        local := TLocalRequest.Create_req(req);
        local.set_out_args(SystemException.Create_type(st_TRANSIENT, 0, COMPLETED_MAYBE) as IORBException);
        FORB.answer_invoke(mid, InvokeSysEx, nil, local, 0);
      end;
    RequestLocate:
        FORB.answer_locate(mid, LocateUnknown, nil, 0);
    RequestBind:
        FORB.answer_bind(mid,LocateUnknown,nil);
    else
      assert(false);
  end;
  //del_invoke(mid);
end;

procedure TIIOPProxy.redo_invoke(mid: ORBMessageID);
begin
  // redo invocation ...
  del_invoke(pull_invoke(mid));
  FORB.redo_request(mid);
end;

procedure TIIOPProxy.shutdown(WaitForCompletion: Boolean);
var
//  i : integer;
  conn: IGIOPConnection;
begin
  MTDORBLogger.Info('TIIOPProxy.shutdown');
  FConnMutex.lock();
  try
  //  i := 0;
    while FConnections.Count > 0 do begin
      conn := IGIOPConnection(FConnections.Second(0));
      kill_connection(conn, false);
    end; { while }
  finally
    FConnMutex.unlock();
  end; { try/finally }
  FORB.answer_shutdown(self);
  MTDORBLogger.Info('TIIOPProxy.shutdown complete');
end;

procedure TIIOPProxy.cancel(id: ORBMessageID);
var
  rec: IIIOPProxyInvokeRecord;
  outc : IGIOPOutContext;
begin
  rec := pull_invoke(id);
  if rec = nil then exit;
  outc := TGIOPOutContext.Create(rec.connection().codec,nil);
  rec.connection.codec.put_cancel_request(outc,ORB_Instance.get_msgid(id));
  rec.connection.output(outc.buffer);
  deref_connection(rec.connection);
  del_invoke(rec);
end;

procedure TIIOPProxy.connection_error(const conn: IGIOPConnection;
  senderror: Boolean);
var
  outc : IGIOPOutContext;
begin
  if not senderror then
    kill_connection(conn,false)
  else begin
    outc := TGIOPOutContext.Create(conn.codec,nil);
    conn.codec.put_error_msg(outc);
    conn.output(outc.buffer);
    // prepare shutdown (i.e. wait until MessageError has been sent)
    deref_connection(conn, true);
  end;
end;


function TIIOPProxy.input_giop_callback(const conn: IGIOPConnection;
  const buf: IBuffer{; event: TEventType}): Boolean;
begin
  result := handle_input(conn, buf);
end;

procedure TIIOPProxy.notify(const orb: IORB; id: ORBMessageID;
  event: TORBCallbackEvent);
begin

end;

{$IFDEF HAVE_THREADS}
procedure TIIOPProxy.send_orb_msg(const conn: IGIOPConnection;
  event: TORBMsgEvent);
var
  msg: IMsgType;
  orbmsg: IOrbMsg;
begin
  orbmsg := TORBMsg.Create(conn, nil, event);
  orbmsg._AddRef();
  msg := TMsgType.Create(Pointer(orbmsg));
  if TMTManager.ThreadPool then
    TMTManager.ThreadPoolManager.put_msg(odORB, msg)
  else
    TMTManager.ThreadPoolManager.get_operation(odORB).process(msg);
end;
{$ENDIF}

function TIIOPProxy.waitfor(const orb: IORB; id: ORBMessageID;
  event: TORBCallbackEvent; tmout: Integer): boolean;
begin
  result := false;
end;

procedure TIIOPProxy.deref_connection(const conn: IGIOPConnection;
  all: boolean);
begin
{$IFDEF HAVE_THREADS}
  if conn.deref() then begin
    send_orb_msg(conn, omeKillConn);
    FOrb.resource_manager().release_connection();
  end;
{$ELSE}
  conn.deref(all);
{$ENDIF}
end;

function TIIOPProxy.Dispatcher: IORBDispatcher;
begin
{$IFDEF HAVE_THREADS}
  result := FDispatcher;
{$ELSE}
  FOrb.dispatcher();
{$ENDIF}
end;

function TIIOPProxy.locate(mid: ORBMessageID; const obj : IORBObject): Boolean;
var
  conn: IGIOPConnection;
  outCtx: IGIOPOutContext;
  rec: IIIOPProxyInvokeRecord;
begin
  result := false;
  try
    conn := make_connection(obj);
  except
    on E: TRANSIENT do ;
    on E: COMM_FAILURE do ;
  end; { try/except }
  if conn = nil then begin
    FORB.answer_locate(mid, LocateUnknown, nil, 0);
    Exit;
  end;

  if conn.codec().converter() = nil then begin
{$IFDEF HAVE_THREADS}
    conn.get_exclusive();
    if conn.codec().converter() = nil then begin
{$ENDIF}
      if not conn.codec().setup_codeset_ids(obj) then begin
        FORB.answer_locate(mid, LocateUnknown, nil, 0);
        Exit;
      end;
{$IFDEF HAVE_THREADS}
    end;
    conn.release_exclusive();
{$ENDIF}
  end;

  outCtx := TGIOPOutContext.Create(conn.codec());
  conn.codec().put_locate_request(outCtx, ORB_Instance.get_msgid(mid), obj);

  conn.ref();
  rec := create_invoke();
  rec.init(mid, conn, nil);
  add_invoke(rec);

  conn.output(outCtx.buffer);
{$IFDEF HAVE_THREADS}
  conn.activeDeref();
{$ENDIF}
  result := true;
end;

procedure TIIOPProxy.add_connection(const conn: IGIOPConnection; const addr: IAddress);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FConnMutex);
  if (conn <> nil) and (FConnections.Find(addr) = nil) then
    FConnections.Item[addr] := conn;
end;

function TIIOPProxy.find_connection(const addr: IAddress): IGIOPConnection;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FConnMutex);
  result := IGIOPConnection(FConnections.Find(addr));
end;

function TIIOPProxy.get_current_connection(): IGIOPConnection;
begin
  //nothing
end;

{$ELSE}
implementation
{$ENDIF}
end.
