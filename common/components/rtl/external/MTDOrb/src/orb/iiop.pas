
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
   Implementation of IIOPServerInvokeRecord and IIOPServer.
 }
unit iiop;

interface

{$I dorb.inc}

{$IFNDEF USELIB}

uses
  iiop_int,orb_int,orbtypes,orb,giop_int,addr_int,Classes,req_int,map_int,
  env_int,code_int,osthread,mtmanager_int,iop,except_int,disp_int,stdstat;

type

  TIIOPServerInvokeRecord = class(TInterfacedObject,IIIOPServerInvokeRecord)
  private
    FConnection: IGIOPConnection;
    FORBId : ORBMessageID;
    FREQId : MessageID;
    FRequest : IORBRequest;
    FObject: IORBObject;
    FActive: boolean;
    FOrbMsgId: MessageID;
    FPrincipal: IPrincipal;
  protected
    procedure init_invoke (const conn: IGIOPConnection; reqid: MessageID;
      orbid: ORBMessageID; const req : IORBRequest; const obj: IORBObject;
      const pr: IPrincipal);
    procedure init_locate (const conn: IGIOPConnection; reqid: MessageID;
      orbid: ORBMessageID; const obj: IORBObject);
    function get_request(): IORBRequest;
    function orbmsgid(): MessageID;
    function orbid: ORBMessageID;
    function _reqid: MessageID;
    procedure set_orbid(oid: ORBMessageID);
    procedure set_reqid(reqid: MessageID);
    function connection : IGIOPConnection;
    procedure clean();
    function active(): boolean;
    procedure deactivate();
  public
  end;

  TIIOPServer = class(TORBObject, IIIOPServer, IObjectAdaptor, ITransportServerCallback, IGIOPCallBack, IORBCallback, IGIOPConnectionMgr)
  private
    FIIOPVersion: _ushort;
    FMaxMessageSize: _ulong;
    FTServers : IInterfaceList;
{$IFDEF USE_IOP_CACHE}
    FCacheRecord : IIIOPServerInvokeRecord;
    FCacheUsed: Boolean;
{$ENDIF}
    FConnections : IInterfaceList;
    FORBIds : ILongInterfaceMap;
    //FORBIdsLock: TMutex;
    FConnLock: TMutex;
    FMonitor: TThreadMonitor;
{$IFDEF HAVE_THREADS}
    FDispatcher: IORBDispatcher;
{$ENDIF}
    procedure deref_connection(const conn: IGIOPConnection; all: boolean = false);
    procedure connection_error(const conn: IGIOPConnection; send_error: boolean = true);
  protected
    function skeleton(const obj: IORBObject): IORBObject;
    function is_local(): Boolean;
    procedure add_invoke(rec: IIIOPServerInvokeRecord);
    procedure del_invoke_orbid(rec: IIIOPServerInvokeRecord);
    function pull_invoke_orbid(orbid: ORBMessageID): IIIOPServerInvokeRecord;
    function pull_invoke_reqid(req_id: MessageId; const conn: IGIOPConnection): IIIOPServerInvokeRecord;
    procedure del_invoke_reqid(orbid: MessageID;const conn: IGIOPConnection);
    procedure kill_connection(const conn: IGIOPConnection; redo: boolean = false);
    function handle_input(const conn: IGIOPConnection; const inp: IBuffer): Boolean;
    function exec_invoke_request(const inc: IGIOPInContext;obj : IORBObject;
      req: IORBRequest;  const pr: IPrincipal; resp_exp: Boolean;const conn: IGIOPConnection; id: ORBMessageID): ORBMessageID;
    function handle_invoke_request (const conn: IGIOPConnection;const inc: IGIOPInContext):Boolean;
    function handle_locate_request (const conn: IGIOPConnection;const inc: IGIOPInContext):Boolean;
    function handle_cancel_request (const conn: IGIOPConnection;const inc: IGIOPInContext):Boolean;
    procedure handle_invoke_reply (id: ORBMessageID);
    procedure handle_locate_reply (id: ORBMessageID);
    procedure handle_bind_reply (id: ORBMessageID);
    function listen(): Boolean;
    function listen_addr(addr: IAddress;addr2: IAddress):Boolean;
    function has_object(const obj: IORBObject):Boolean;
    function waitfor(const orb: IORB; id: ORBMessageID; event: TORBCallbackEvent; tmout: long = -1): boolean;
    procedure notify(const orb: IORB; id: ORBMessageID; evt : TORBCallbackEvent);
    procedure ts_callback(ts: ITransportServer; event: TTransportServerCallBackEvent);
    //procedure callback (const orb: IORB; mid: MessageID; evt : TORBCallbackEvent);
    function invoke(mid: ORBMessageID;const obj : IORBObject; const req : IORBRequest; const pr: IPrincipal; response_exp: Boolean): Boolean; stdcall;
    function bind(mid: ORBMessageID; const repoid: RepositoryId; const oid: IObjectTag; const addr: IAddress): Boolean;
    function get_oaid(): ObjectID;
    function giop_callback(const conn: IGIOPConnection;event: TEventType): Boolean;
    function input_giop_callback(const conn: IGIOPConnection;const buf: IBuffer{;event: TEventType}): Boolean;
    function create_invoke(): IIIOPServerInvokeRecord;
    procedure answer_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
    procedure shutdown(WaitForCompletion: Boolean);
    procedure conn_closed(const conn: IGIOPConnection);
    procedure cancel(mid: ORBMessageID);
    function locate(mid: ORBMessageID; const obj : IORBObject): Boolean;
    procedure abort_invoke_orbid(rec : IIIOPServerInvokeRecord);
{$IFDEF HAVE_THREADS}
    procedure send_orb_msg(const conn: IGIOPConnection;event: TORBMsgEvent);
{$ENDIF}
    { IGIOPConnectionMgr }
    function Dispatcher: IORBDispatcher;
    procedure add_connection(const conn: IGIOPConnection; const addr: IAddress);
    function find_connection(const addr: IAddress): IGIOPConnection;
    function get_current_connection(): IGIOPConnection;
  public
    constructor Create(dorb: IORB; iiop_version: _ushort = $0100; max_size: _ulong = 0);
    destructor Destroy(); override;
  end;

  TListenPoint_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TListenPoint_seq_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TBiDirIIOPServiceContext_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  function ListenPoint_to_any(const val: TListenPoint): IAny;
  function any_to_ListenPoint(const a: IAny; var val: TListenPoint): Boolean;

  function ListenPoint_seq_to_any(const val): IAny;
  function any_to_ListenPoint_seq(const a: IAny; var val): Boolean;

  function BiDirIIOPServiceContext_to_any(const val: TBiDirIIOPServiceContext): IAny;
  function any_to_BiDirIIOPServiceContext(const a: IAny; var val: TBiDirIIOPServiceContext): Boolean;

var
  ListenPoint_marshaller : IStaticTypeInfo;
  ListenPoint_seq_marshaller : IStaticTypeInfo;
  BiDirIIOPServiceContext_marshaller : IStaticTypeInfo;

implementation

uses
  address,iior_int,orbcomp,mcomp_int,codec,decoder,encoder,exceptions,static,
  ior,map,utils,intercept,mtmanager,SysUtils,mtdebug,any,tcode;

var
  _tc_ListenPoint : ITypeCodeConst;
  _tc_ListenPoint_seq : ITypeCodeConst;
  _tc_BiDirIIOPServiceContext : ITypeCodeConst;

threadvar
  currentConnectionVar: IGIOPConnection;

//**************************************************************************
//  TIIOPServer
//**************************************************************************
constructor TIIOPServer.Create(dorb: IORB; iiop_version: _ushort; max_size: _ulong);
begin
  inherited Create();
  //FORBIdsLock := TMutex.Create(false, maRecursive);
  FConnLock := TMutex.Create;
  FTServers := TInterfaceList.Create;
  FConnections := TInterfaceList.Create;
  FORBIds := TLongInterfaceMap.Create;
{$IFDEF HAVE_THREADS}
  FDispatcher := TDummyDispatcher.Create;
{$ENDIF}
{$IFDEF USE_IOP_CACHE}
  FCacheUsed := false;
  FCacheRecord := TIIOPServerInvokeRecord.Create;
{$ENDIF}
  FIIOPVersion := iiop_version;
  FMaxMessageSize := max_size;
  FMonitor := TThreadMonitor.Create;
  FORB.register_oa(self as IObjectAdaptor, OAPriorityRemote);
end;

destructor TIIOPServer.Destroy();
var
  sync: ISynchronized;
begin
  FConnLock.lock();
  try
    FConnections := nil;
  finally
    FConnLock.unlock();
  end; { try/finally }

  FTServers := nil;

  sync := TSynchronized.Create(FMonitor);
  try
    FORBIDs := nil;
  finally
    sync := nil;
  end; { try/finally }
  //FORBIdsLock.Free;
  FreeAndNil(FConnLock);
  FreeAndNil(FMonitor);
  inherited Destroy();
end;

procedure TIIOPServer.conn_closed(const conn: IGIOPConnection);
var
  outc : IGIOPOutContext;
begin
  outc := TGIOPOutContext.Create(conn.codec,nil);
  conn.codec.put_close_msg(outc);
  conn.output_handler(outc.buffer());
  
  conn.flush();
{$IFNDEF HAVE_THREADS}
  deref_connection(conn, true);
{$ELSE}
  conn.terminate();
{$ENDIF}
end;

procedure TIIOPServer.shutdown(WaitForCompletion: Boolean);
var
  i : integer;
  trans: ITransportServer;
  sync: ISynchronized;
begin
  MTDORBLogger.Info('TIIOPServer.shutdown');
  sync := TSynchronized.Create(FMonitor);
  while FORBIDs.Count > 0 do
    FMonitor.wait();
  sync := nil;
  
  FConnLock.lock();
  try
    for i := 0 to Pred(FConnections.Count) do begin
      try
        conn_closed(IGIOPConnection(FConnections[i]));
      except
        //client maybe shutdowning
      end; { try/except }
{$IFDEF HAVE_THREADS}
      deref_connection(IGIOPConnection(FConnections[i]));
{$ENDIF}
    end;
    FConnections.Clear;
  finally
    FConnLock.unlock();
  end; { try/finally }

  for i := 0 to Pred(FTServers.Count) do begin
    trans := ITransportServer(FTServers[i]);
    try
      trans.close();
    except
      // Ignore all system exceptions
      on E: SystemException do ;
    end; { try/except }
    trans.aselect(FORB.dispatcher,nil);
  end;
  FTServers.Clear;

{$IFDEF USE_IOP_CACHE}
  if FCacheUsed then
    FORB.cancel(FCacheRecord.orbid);
{$ENDIF}
  //FORBIdsLock.lock();
  sync := TSynchronized.Create(FMonitor);
  try
    for i := Pred(FORBIDs.Count) downto 0 do
      //FORB.cancel(IIIOPServerInvokeRecord(FORBIDs[i]).orbid);
      FORB.cancel(IIIOPServerInvokeRecord(FORBIDs.Items(i)).orbid);
    FORBIDs.Clear;
  finally
    sync := nil;
    //FORBIdsLock.unlock();
  end; { try/finally }
{$IFDEF USE_IOP_CACHE}
  FCacheUsed := false;
{$ENDIF}
  FORB.answer_shutdown(self);
  MTDORBLogger.Info('TIIOPServer.shutdown complete');
end;

procedure TIIOPServer.answer_invoke(mid: ORBMessageID; const obj: IORBObject; const req: IORBRequest; stat: TInvokeStatus);
begin
  assert(false);
end;

function TIIOPServer.skeleton(const obj: IORBObject): IORBObject;
begin
  result := nil;
end;

procedure TIIOPServer.deref_connection(const conn: IGIOPConnection;
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

procedure TIIOPServer.connection_error(const conn: IGIOPConnection;
  send_error: boolean);
var
  outCon: IGIOPOutContext;
begin
  if not send_error then begin
    kill_connection(conn);
  end
  else begin
    outCon := TGIOPOutContext.Create(conn.codec);
    conn.codec.put_error_msg(outCon);
    conn.output(outCon.buffer());

    conn.flush();
    //deref_connection(conn, true);
    kill_connection(conn);
  end;
end;

procedure TIIOPServer.abort_invoke_orbid(rec : IIIOPServerInvokeRecord);
begin
  FORB.cancel(rec.orbmsgid());
  //del_invoke_orbid(mid);
end;

{$IFDEF HAVE_THREADS}
procedure TIIOPServer.send_orb_msg(const conn: IGIOPConnection;
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

function TIIOPServer.is_local(): Boolean;
begin
  result := false;
end;

function TIIOPServer.get_oaid(): ObjectID;
begin
  result := 'dorb-iiop-server';
end;

function TIIOPServer.giop_callback(const conn: IGIOPConnection;event: TEventType): Boolean;
var
  addr : IAddress;
begin
  result := false;
  case event of
    orbtypes.InputReady:
      result := handle_input(conn, conn.input);
    orbtypes.Idle: begin
      conn_closed(conn);
      kill_connection(conn);
    end;
    orbtypes.Closed: begin
      //conninterceptor
      addr := conn.transport().peer();
      Assert(addr <> nil);
      TConnInterceptor._exec_client_disconnect(addr.toString);
      kill_connection(conn);
    end;
    else
      assert(false);
  end;
end;

function TIIOPServer.input_giop_callback(const conn: IGIOPConnection;
  const buf: IBuffer{; event: TEventType}): Boolean;
begin
  try
    currentConnectionVar := conn;
    try
      result := handle_input(conn, buf);
    finally
      currentConnectionVar := nil;
    end;
  except
    on E: Exception do begin
      MTDORBLogger.Error(AnsiString(Format('UncaughtException: %s.%s %s', [E.Message, sLineBreak, CallStackTextualRepresentation()])));
      //I haven't any idea how hanler exception here
      //otherwise client hang on this request, server hang on shutdown
      conn.activeDeref();
      kill_connection(conn);
      raise;
    end;
  end; { try/except }
end;

procedure TIIOPServer.ts_callback(ts: ITransportServer; event: TTransportServerCallBackEvent);
var
  transp : ITransport;
  addr : IAddress;
  conn : IGIOPConnection;
  res: boolean;
begin
  case event of
    orbtypes.tsAccept: begin
      try
        transp := ts.accept;
        if transp <> nil then begin
{$IFDEF HAVE_THREADS}
          if not FOrb.resource_manager().acquire_connection() then
            Exit;
{$ENDIF}
          if transp.bad then begin
{$IFDEF HAVE_THREADS}
            FOrb.resource_manager().release_connection();
{$ENDIF}
            Exit;
          end;
          addr := transp.peer;
          //conninterceptor
          Assert(addr <> nil);
          res := TConnInterceptor._exec_client_connect(addr.toString);
          if not res then begin
            transp := nil;
{$IFDEF HAVE_THREADS}
            FOrb.resource_manager().release_connection();
{$ENDIF}
          end
          else begin
{$IFDEF HAVE_THREADS}
            conn := TGIOPConnection.Create(Dispatcher(), FORB, transp, self,
              TGIOPCodec.Create(TDecoder.Create(nil) as IDecoder, TEncoder.Create(nil) as IEncoder, FIIOPVersion) as IGIOPCodec,
              0, FMaxMessageSize, not TMTManager.ThreadPool, not TMTManager.ThreadPool{false});
{$ELSE}
            conn := TGIOPConnection.Create(Dispatcher(), FORB, transp, self,
              TGIOPCodec.Create(TDecoder.Create(nil) as IDecoder, TEncoder.Create(nil) as IEncoder, FIIOPVersion) as IGIOPCodec,
              0, FMaxMessageSize);
{$ENDIF}
            FConnLock.lock();
            try
              FConnections.Add(conn);
            finally
              FConnLock.unlock();
            end; { try/finally }
{$IFDEF HAVE_THREADS}
            conn.start();
{$ENDIF}
          end;
        end;
      except
        FOrb.resource_manager().release_connection();
        //consume
      end; { try/except }
    end;
  else
    //FIXME: temp solution - a OA should have states like init, init_shutdown, shutdown, etc.
    //       geting Event::Remove during shutdown is perfectly OK (actualy it is also OK during normal
    //       operation, although its a sign that something went horrible wrong)
    //       - we should do the _tservs.remove here !
    //         - this would acctualy work since _tservers is a FastArray and not an STL type !!
  end;
end;

function TIIOPServer.create_invoke(): IIIOPServerInvokeRecord;
begin
{$IFDEF USE_IOP_CACHE}
  if FCacheUsed then
    result := TIIOPServerInvokeRecord.Create
  else
    begin
      FCacheUsed := True;
      result := FCacheRecord;
    end;
{$ELSE}
  result := TIIOPServerInvokeRecord.Create;
{$ENDIF}
end;

procedure TIIOPServer.add_invoke(rec: IIIOPServerInvokeRecord);
var
  //al: IAuto_Lock;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  //al := TAuto_Lock.Create(FORBIdsLock);
{$IFDEF USE_IOP_CACHE}
  if rec <> FCacheRecord then
    FORBIDs[rec.orbmsgid] := rec;
{$ELSE}
  FORBIDs[rec.orbmsgid] := rec;
  rec._AddRef;
  FORB.set_request_hint(rec.orbid(), Pointer(rec));
{$ENDIF}
end;

procedure TIIOPServer.notify(const orb: IORB; id: ORBMessageID;
  evt: TORBCallbackEvent);
begin
  case evt of
    _Invoke: handle_invoke_reply(id);
    _Locate: handle_locate_reply(id);
    _Bind: handle_bind_reply(id);
    else
      assert(false);
  end;
end;

function TIIOPServer.waitfor(const orb: IORB; id: ORBMessageID;
  event: TORBCallbackEvent; tmout: Integer): boolean;
begin
  Assert(false);
  result := true;
end;

function TIIOPServer.pull_invoke_orbid(orbid: ORBMessageID):IIIOPServerInvokeRecord;
var
  //al: IAuto_Lock;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  result := nil;
{$IFDEF USE_IOP_CACHE}
  if FCacheUsed and (FCacheRecord.orbid = orbid) then
    result := FCacheRecord
  else
    result := FORBIDs[orbid] as IIIOPServerInvokeRecord;
{$ENDIF}
  //al := TAuto_Lock.Create(FORBIdsLock);
  result := IIIOPServerInvokeRecord(FORB.get_request_hint(orbid));
  if (result <> nil) then begin
    result._Release;
    if result.active() then begin
      result.deactivate();
      Exit;
    end;
    del_invoke_orbid(result);
    result := nil;
  end;
end;

function TIIOPServer.pull_invoke_reqid(req_id: MessageId;
  const conn: IGIOPConnection): IIIOPServerInvokeRecord;
var
  sync: ISynchronized;
  i: Integer;
begin
  sync := TSynchronized.Create(FMonitor);

{$IFDEF USE_IOP_CACHE}
  if FCacheUsed and (FCacheRecord.reqid = req_id) and (FCacheRecord.connection = conn) then begin
    FCacheRecord.deactivate;
    result := FCacheRecord;
    Exit;
  end;
{$ENDIF}
  // XXX slow, but only needed for cancel
  for i := 0 to FORBIDs.count - 1 do begin
    result := IIIOPServerInvokeRecord(FORBIDs.Items(i));
    if (result._reqid = req_id) and (result.connection = conn) and result.active then begin
      result.deactivate;
      Exit;
    end;
  end;

  result := nil;
end;

procedure TIIOPServer.del_invoke_orbid(rec : IIIOPServerInvokeRecord);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMonitor);
  Assert(not rec.active());
{$IFDEF USE_IOP_CACHE}
  if FCacheUsed and (FCacheRecord.orbid = orbid) then
    begin
      FCacheRecord.clean;
      FCacheUsed := false;
      exit;
    end;
{$ELSE}
  deref_connection(rec.connection());
  if rec <> nil then
    begin
      FORBIDs.erase(rec.orbmsgid());
      rec.clean;
    end;
{$ENDIF}
  FMonitor.notifyAll();
end;

procedure TIIOPServer.del_invoke_reqid(orbid: MessageID;
  const conn: IGIOPConnection);
var
  sync: ISynchronized;
  rec: IIIOPServerInvokeRecord;
  i: Integer;
begin
  sync := TSynchronized.Create(FMonitor);

{$IFDEF USE_IOP_CACHE}
  if FCacheUsed and (FCacheRecord.reqid = req_id) and (FCacheRecord.connection = conn) then begin
    Assert(not FCacheRecord.active);
    FCacheRecord := nil;
    FCacheUsed := false;
    Exit;
  end;
{$ENDIF}

  // XXX slow, but rarely used
  deref_connection(conn);

//  for (MapIdConn::iterator i = _orbids.begin(); i != _orbids.end(); ++i) {
//      rec = (*i).second;
//      if (rec->reqid() == msgid && rec->conn() == conn) {
//          assert( !rec->active() );
//          delete rec;
//          _orbids.erase (i);
//          break;
//      }
//  }
  for i := 0 to FORBIDs.count - 1 do begin
    rec := IIIOPServerInvokeRecord(FORBIDs.Items(i));
    if (rec._reqid = orbid) and (rec.connection = conn) then begin
      Assert(not rec.active);
      rec := nil;
      FORBIDs.Delete(i);
      Exit;
    end;
  end;
end;

function TIIOPServer.exec_invoke_request(const inc: IGIOPInContext;
  obj: IORBObject; req: IORBRequest;  const pr: IPrincipal; resp_exp: Boolean;
  const conn: IGIOPConnection; id: ORBMessageID): ORBMessageID;
var
  rep : RepositoryId;
  tag : IObjectTag;
begin
  if req.op_name = '_bind' then
    begin
      conn.codec.get_bind_request(inc,rep,tag);
      result := Forb.bind_async(rep,tag,nil,self,id);
    end
  else
    result := Forb.invoke_async(obj,req,pr,resp_exp,self,id);
end;

procedure TIIOPServer.handle_bind_reply(id: ORBMessageID);
var
  obj : IORBObject;
  stat: TLocateStatus;
  rec : IIIOPServerInvokeRecord;
  giop_stat : TLocateStatusType;
  outc: IGIOPOutContext;
begin
  rec := pull_invoke_orbid(id);
  stat := forb.get_bind_reply(id,obj);
  if rec = nil then exit;
  giop_stat := OBJECT_HERE;
  case stat of
    LocateUnknown: giop_stat := UNKNOWN_OBJECT;
    LocateHere : giop_stat := OBJECT_HERE;
    LocateForward : giop_stat := OBJECT_FORWARD;
  end;
  outc := TGIOPOutContext.Create(rec.connection.codec);
  rec.connection.codec.put_bind_reply(outc,rec._reqid,giop_stat,obj);
  rec.connection.output(outc.buffer);
  del_invoke_orbid(rec);
end;

function TIIOPServer.handle_cancel_request(const conn: IGIOPConnection;
  const inc: IGIOPInContext): Boolean;
var
  req_id: _ulong;
  rec: IIIOPServerInvokeRecord;
  orbid: MessageId;
begin
  result := false;

  if not conn.codec().get_cancel_request(inc, req_id) then begin
{$IFDEF HAVE_THREADS}
    conn.activeDeref();
{$ENDIF} // HAVE_THREADS
    connection_error(conn);
    Exit;
  end;

  //conn.cancel(req_id);

  rec := pull_invoke_reqid(req_id, conn);
{$IFDEF HAVE_THREADS}
  conn.activeDeref();
{$ENDIF} // HAVE_THREADS
  // request already finished or no such id
  if rec = nil then
    Exit;

  orbid := rec.orbmsgid();

  // maybe rec->conn() != conn ...
  // connection might be deleted during call to orb->cancel() ...

  //FIXME: should we realy delete it here ????????????
  del_invoke_orbid(rec);

  FORB.cancel(orbid);

  // maybe the connection was closed inbetween: make do_read() break
  result := false;
end;

function TIIOPServer.handle_input(const conn: IGIOPConnection; const inp: IBuffer): Boolean;
var
  inc : IGIOPInContext;
  size: _ulong;
  flags: byte;
  mt: TMessageType;
  IIOPProxy: IGIOPCallBack;
begin
  result := false;
  inc := TGIOPInContext.Create(conn.codec,inp,nil);
  inc.set_converter(conn.codec().converter());
  if not conn.codec.get_header(inc,mt,size,flags) then begin
{$IFDEF HAVE_THREADS}
    conn.activeDeref();
{$ENDIF}
    connection_error(conn);
    Exit;
  end;
  case mt of
    orbtypes.Request: result := handle_invoke_request(conn,inc);
    orbtypes.LocateRequest: result := handle_locate_request(conn, inc);
    orbtypes.MessageError: begin
{$IFDEF HAVE_THREADS}
      conn.activeDeref();
{$ENDIF}
      if not conn.codec.get_error_msg(inc) then
        connection_error(conn, false)
      else
        kill_connection(conn);
    end;
    orbtypes.CancelRequest: result := handle_cancel_request(conn, inc);
    // for some strange reason Orbacus 4 clients send CloseConnection
    // upon exit ...
    orbtypes.CloseConnection: begin
{$IFDEF HAVE_THREADS}
      conn.activeDeref();
{$ENDIF}
      result := true;
    end;
    orbtypes.Reply, orbtypes.LocateReply: begin
      //check for BiDir connection
      IIOPProxy := FORB.get_oa('dorb-iiop-proxy') as IGIOPCallBack;
      IIOPProxy.input_giop_callback(conn, inp);
    end;
    else begin
{$IFDEF HAVE_THREADS}
      conn.activeDeref();
{$ENDIF}
      result := true;
    end;
  end;
end;

procedure TIIOPServer.handle_invoke_reply(id: ORBMessageID);
var
  obj : IORBObject;
  stat : TInvokeStatus;
  req: IORBRequest;
  rec: IIIOPServerInvokeRecord;
  gstat : TReplyStatusType;
  outc: IGIOPOutContext;
  ad: AddressingDisposition;
begin
  rec := pull_invoke_orbid(id);
  // invocation canceled (perhaps connection to client broken)
  if rec = nil then
    Exit;
  if rec.orbid <> nil then
    if not rec.orbid.responce then begin
	    del_invoke_orbid(rec);
      Exit;
    end;
  rec.set_orbid(nil);
  stat := FOrb.get_invoke_reply(id, obj, req, ad);
  gstat := orbtypes.NO_EXCEPTION;
  case stat of
    InvokeOk : gstat := orbtypes.NO_EXCEPTION;
    InvokeSysEx: gstat := orbtypes.SYSTEM_EXCEPTION;
    InvokeUserEx: gstat := orbtypes.USER_EXCEPTION;
    InvokeForward: begin
      if id.get_locationforward_perm then
        gstat := orbtypes.LOCATION_FORWARD_PERM
      else
        gstat := orbtypes.LOCATION_FORWARD;
    end;
    InvokeAddrDisp: gstat := orbtypes.NEEDS_ADDRESSING_MODE;
  end;
  outc := TGIOPOutContext.Create(rec.connection.codec, nil);
  if not rec.connection.codec.put_invoke_reply(outc, rec._reqid, gstat, obj, req, ad) then begin
    //outc.reset();
    req.set_out_args(SystemException.Create_type(st_MARSHAL) as IORBException);
    rec.connection.codec.put_invoke_reply(outc, rec._reqid, orbtypes.SYSTEM_EXCEPTION, obj, req, ad);
  end;
  rec.connection.output(outc.buffer);
  del_invoke_orbid(rec);
end;

function TIIOPServer.handle_invoke_request(const conn: IGIOPConnection;
  const inc: IGIOPInContext): Boolean;
var
  obj : IORBObject;
  reqid: _ulong;
  resp_exp : Byte;
  req: IORBRequest;
  msgid: MessageID;
  orbid, orbid2: ORBMessageID;
  rec : IIIOPServerInvokeRecord;
  pr : IPrincipal;
begin
  result := false;
  obj := TORBObject.Create(TIOR.Create as IIOR);
  pr := conn.transport().get_principal;
  if not conn.codec.get_invoke_request(inc,reqid,resp_exp,obj,req,pr) then begin
{$IFDEF HAVE_THREADS}
    conn.activeDeref();
{$ENDIF}
    conn.deref();
    connection_error(conn{, false});
    exit;
  end;
  //if Boolean(resp_exp) then
    //begin
      msgid := FORB.new_messageid;
      orbid := FORB.new_orbid(msgid);
      conn.ref();
      rec := create_invoke();
      rec.init_invoke(conn,reqid,orbid,req,obj,pr);
      add_invoke(rec);
    //end;
{$IFDEF HAVE_THREADS}
  conn.activeDeref();
{$ENDIF}
  orbid2 := exec_invoke_request(inc,obj,req,pr,Boolean(resp_exp),conn,orbid);
  Assert((orbid = orbid2) or ((orbid2 = nil) and not Boolean(resp_exp)));
end;

procedure TIIOPServer.handle_locate_reply(id: ORBMessageID);
var
  obj: IORBObject;
  ad: AddressingDisposition;
  rec: IIIOPServerInvokeRecord;
  stat: TLocateStatus;
  giop_stat: TLocateStatusType;
  outCtx: IGIOPOutContext;
begin
  rec := pull_invoke_orbid(id);
  stat := FORB.get_locate_reply(id, obj, ad);

  // invocation canceled (perhaps connection to client broken)
  if rec = nil then
    Exit;

  giop_stat := OBJECT_HERE;
  case stat of
    LocateHere: giop_stat := OBJECT_HERE;
    LocateUnknown: giop_stat := UNKNOWN_OBJECT;
    LocateForward: giop_stat := OBJECT_FORWARD;
    LocateAddrDisp: giop_stat := LOC_NEEDS_ADDRESSING_MODE;
  end;

  outCtx := TGIOPOutContext.Create(rec.connection().codec());
  rec.connection().codec().put_locate_reply(outCtx, rec._reqid(), giop_stat, obj, ad);
  obj := nil;

  rec.connection().output(outCtx.buffer);
  del_invoke_orbid(rec);
end;

function TIIOPServer.handle_locate_request(const conn: IGIOPConnection;
  const inc: IGIOPInContext): Boolean;
var
  req_id: MessageId;
  obj: IORBObject;
  orbid, orbid2: ORBMessageID;
  rec: IIIOPServerInvokeRecord;
begin
  obj := TORBObject.Create(TIOR.Create() as IIOR);

  if not conn.codec().get_locate_request(inc, req_id, obj) then begin
    obj := nil;
{$IFDEF HAVE_THREADS}
    conn.activeDeref();
{$ENDIF} // HAVE_THREADS
    connection_error(conn);
    result := false;
    Exit;
  end;
  // XXX obj is incomplete, see IOR::operator== ...

  (*
   * must install the invocation record before we call the ORB, because
   * may invoke callback before returning from invoke_async ...
   *)
  orbid := FORB.new_orbid();
  conn.ref();
  rec := create_invoke();
  rec.init_locate(conn, req_id, orbid, obj);
  add_invoke (rec);
{$IFDEF HAVE_THREADS}
  conn.activeDeref();
{$ENDIF} // HAVE_THREADS
  orbid2 := FORB.locate_async(obj, Self, orbid);
  Assert(orbid = orbid2);

  // maybe the connection was closed inbetween: make do_read() break
  result := false;
end;

function TIIOPServer.has_object(const obj: IORBObject): Boolean;
begin
  result := false;
end;

procedure TIIOPServer.kill_connection(const conn: IGIOPConnection; redo: boolean);
var
  i : integer;
  rec: IIIOPServerInvokeRecord;
  again : Boolean;
  sync: ISynchronized;
begin
  FConnLock.lock();
  try
    conn._AddRef;
    i := FConnections.IndexOf(conn);
    while i >= 0 do
      begin
        FConnections.Delete(i);
        i := FConnections.IndexOf(conn)
      end;
    conn._Release;
  finally
    FConnLock.unlock();
  end; { try/finally }
{$IFDEF HAVE_THREADS}
  conn.terminate();
{$ENDIF}
{$IFDEF USE_IOP_CACHE}
  if FCacheUsed and (FCacheRecord.connection = conn) then
    begin
      FORB.cancel(FCacheRecord.orbid);
      FCacheUsed := false;
    end;
{$ELSE}
  again := true;
  while again do
    begin
      sync := TSynchronized.Create(FMonitor);
      //FORBIdsLock.lock();
      try
        again := False;
        for i := 0 to FORBIds.count - 1 do
          begin
            rec := IIIOPServerInvokeRecord(FORBIds.Items(i));
            if rec.active and (rec.connection = conn) then
              begin
                rec.deactivate();
                abort_invoke_orbid(rec);
                again := True;
                break;
              end;
          end;
      finally
        //FORBIdsLock.unlock();
        sync := nil;
      end; { try/finally }
    end;
  deref_connection(conn);
{$ENDIF}
end;

function TIIOPServer.listen: Boolean;
var
  addr : IInetAddress;
begin
  addr := TInetAddress.Create('0.0.0.0',0,STREAM);
  result := listen_addr(addr,nil);
end;

function TIIOPServer.listen_addr(addr, addr2: IAddress): Boolean;
var
  tserv: ITransportServer;
  prof : IIORProfile;
  mc : IMultiComponent;
begin
  result := false;
  tserv := addr.make_transport_server();
{$IFDEF HAVE_THREADS}
  if not TMTManager.ThreadPool then
    tserv.create_thread();
{$ENDIF}
  if not tserv.bind(addr) then
    Exit;
  tserv.block(Dispatcher().isblocking());
  tserv.aselect(Dispatcher(), self);
  mc := TMultiComponent.Create;
  if addr2 = nil then
    prof := tserv.get_address.make_ior_profile('', 1, mc, FIIOPVersion) as IIORProfile
  else
    prof := addr2.make_ior_profile('', 1, mc, FIIOPVersion) as IIORProfile;
  FOrb.ior_template.add_profile(prof);
  FTServers.Add(tserv);
{$IFDEF HAVE_THREADS}
  if not TMTManager.ThreadPool then
    tserv.start();
{$ENDIF}
  prof := nil; tserv := nil; mc := nil;
  result := true;
end;

function TIIOPServer.bind(mid: ORBMessageID; const repoid: RepositoryId;
  const oid: IObjectTag; const addr: IAddress): Boolean;
begin
  result := false;
end;

function TIIOPServer.invoke(mid: ORBMessageID; const obj: IORBObject;
  const req: IORBRequest; const pr: IPrincipal; response_exp: Boolean): Boolean;
begin
  result := false;
  assert(false);
end;

procedure TIIOPServer.cancel(mid: ORBMessageID);
begin
  assert(false);
end;

function TIIOPServer.locate(mid: ORBMessageID;
  const obj: IORBObject): Boolean;
begin
  Assert(false);
  result := false;
end;

function TIIOPServer.Dispatcher: IORBDispatcher;
begin
{$IFDEF HAVE_THREADS}
  if TMTManager.ThreadPool then
    result := FOrb.dispatcher()
  else
    result := FDispatcher;
{$ELSE}
  FOrb.dispatcher();
{$ENDIF}
end;

procedure TIIOPServer.add_connection(const conn: IGIOPConnection; const addr: IAddress);
begin
end;

function TIIOPServer.find_connection(
  const addr: IAddress): IGIOPConnection;
var
  i: Integer;
begin
  FConnLock.lock();
  try
    for i := 0 to Pred(FConnections.Count) do begin
      if IGIOPConnection(FConnections[i]).transport.peer.compare(addr) then begin
        result := IGIOPConnection(FConnections[i]);
        Break;
      end;
    end;
  finally
    FConnLock.unlock();
  end; { try/finally }
end;

function TIIOPServer.get_current_connection(): IGIOPConnection;
begin
  Result := currentConnectionVar;
end;

//**************************************************************************
// TIIOPServerInvokeRecord
//**************************************************************************
function TIIOPServerInvokeRecord.connection: IGIOPConnection;
begin
  result := FConnection;
end;

procedure TIIOPServerInvokeRecord.clean();
begin
 FConnection := nil;
 FRequest := nil;
 FObject := nil;
 FORBId := nil;
 FREQId := 0;
 FActive := true;
end;

function TIIOPServerInvokeRecord.get_request: IORBRequest;
begin
  result := FRequest;
end;

procedure TIIOPServerInvokeRecord.init_invoke(const conn: IGIOPConnection;
  reqid: MessageID; orbid: ORBMessageID; const req: IORBRequest; const obj: IORBObject;
  const pr: IPrincipal);
begin
  FConnection:= conn;
  FORBId := orbid;
  FREQId := reqid;
  FRequest := req;
  FObject:= obj;
  FOrbMsgId := ORB_Instance.get_msgid(orbid);
  FActive := true;
  FPrincipal := pr;
end;

procedure TIIOPServerInvokeRecord.init_locate(const conn: IGIOPConnection; reqid: MessageID;
  orbid: ORBMessageID; const obj: IORBObject);
begin
  FConnection:= conn;
  FORBId := orbid;
  FREQId := reqid;
  FRequest := nil;
  FObject:= obj;
  FOrbMsgId := ORB_Instance.get_msgid(orbid);
  FActive := true;
  FPrincipal := nil;
end;

function TIIOPServerInvokeRecord.orbid: ORBMessageID;
begin
  result := FORBId;
end;

function TIIOPServerInvokeRecord._reqid: MessageID;
begin
  result := FReqID;
end;

procedure TIIOPServerInvokeRecord.set_orbid(oid: ORBMessageID);
begin
  FORBId := oid;
end;

procedure TIIOPServerInvokeRecord.set_reqid(reqid: MessageID);
begin
  FREQId := reqid;
end;

function TIIOPServerInvokeRecord.orbmsgid: MessageID;
begin
  result := FOrbMsgId;
end;

function TIIOPServerInvokeRecord.active: boolean;
begin
  result := FActive;
end;

procedure TIIOPServerInvokeRecord.deactivate;
begin
  FActive := false;
end;

//***********************************************************
// TListenPoint_marshaller
//***********************************************************
function TListenPoint_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
var
  struct: TListenPoint;
begin
  result := false;
  if not stat_string.demarshal(dec,@struct.host) then exit;
  if not stat_ushort.demarshal(dec,@struct.port) then exit;
  TListenPoint(addr^) := struct;
  result := true;
end;

procedure TListenPoint_marshaller.marshal(enc: IEncoder;const addr : Pointer);
var
  struct: TListenPoint;
begin
  struct := TListenPoint(addr^);
  stat_string.marshal(enc,@struct.host);
  stat_ushort.marshal(enc,@struct.port);
end;

procedure TListenPoint_marshaller._free(var addr: Pointer);
begin
{$HINTS OFF}
  System.Finalize(TListenPoint(addr^));
{$HINTS ON}
  FreeMem(addr);
end;

procedure TListenPoint_marshaller._create(var addr: Pointer);
begin
  addr := AllocMem(SizeOf(TListenPoint));
{$HINTS OFF}
  System.Initialize(TListenPoint(addr^));
{$HINTS ON}
end;

procedure TListenPoint_marshaller._assign(dst, src: Pointer);
begin
  TListenPoint(dst^) := TListenPoint(src^);
end;

function TListenPoint_marshaller.typecode: ITypeCode;
begin
  result := _tc_ListenPoint.typecode;
end;

//***********************************************************
// TListenPoint_seq_marshaller
//***********************************************************
type 
  ListenPoint_seq = array of TListenPoint;
  PListenPoint_seq = ^ListenPoint_seq;

function TListenPoint_seq_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
var
  len: _ulong;
  i: integer;
  val: TListenPoint;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  SetLength(ListenPoint_seq(addr^),len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      begin
        if not ListenPoint_marshaller.demarshal(dec,@val) then exit;
        ListenPoint_seq(addr^)[i] := val; 
      end;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TListenPoint_seq_marshaller.marshal(enc: IEncoder;const addr : Pointer);
var
  len: _ulong;
  i: integer;
begin
  len := Length(ListenPoint_seq(addr^));
  enc.seq_begin(len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      ListenPoint_marshaller.marshal(enc,@ListenPoint_seq(addr^)[i]);
  enc.seq_end;
end;

procedure TListenPoint_seq_marshaller._free(var addr: Pointer);
begin
  setLength(ListenPoint_seq(addr^),0);
  freemem(addr);
end;

procedure TListenPoint_seq_marshaller._create(var addr: Pointer);
begin
  addr := allocmem(sizeOf(_ulong));
end;

procedure TListenPoint_seq_marshaller._assign(dst, src: Pointer);
begin
  _ulong(dst^) := _ulong(src^);
end;

function TListenPoint_seq_marshaller.typecode: ITypeCode;
begin
  result := _tc_ListenPoint_seq.typecode;
end;

//***********************************************************
// TBiDirIIOPServiceContext_marshaller
//***********************************************************
function TBiDirIIOPServiceContext_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
var
  struct: TBiDirIIOPServiceContext;
begin
  result := false;
  if not ListenPoint_seq_marshaller.demarshal(dec,@struct.listen_points) then exit;
  TBiDirIIOPServiceContext(addr^) := struct;
  result := true;
end;

procedure TBiDirIIOPServiceContext_marshaller.marshal(enc: IEncoder;const addr : Pointer);
var
  struct: TBiDirIIOPServiceContext;
begin
  struct := TBiDirIIOPServiceContext(addr^);
  ListenPoint_seq_marshaller.marshal(enc,@struct.listen_points);
end;

procedure TBiDirIIOPServiceContext_marshaller._free(var addr: Pointer);
begin
{$HINTS OFF}
  System.Finalize(TBiDirIIOPServiceContext(addr^));
{$HINTS ON}
  FreeMem(addr);
end;

procedure TBiDirIIOPServiceContext_marshaller._create(var addr: Pointer);
begin
  addr := AllocMem(SizeOf(TBiDirIIOPServiceContext));
{$HINTS OFF}
  System.Initialize(TBiDirIIOPServiceContext(addr^));
{$HINTS ON}
end;

procedure TBiDirIIOPServiceContext_marshaller._assign(dst, src: Pointer);
begin
  TBiDirIIOPServiceContext(dst^) := TBiDirIIOPServiceContext(src^);
end;

function TBiDirIIOPServiceContext_marshaller.typecode: ITypeCode;
begin
  result := _tc_BiDirIIOPServiceContext.typecode;
end;

function any_to_ListenPoint(const a: IAny; var val: TListenPoint): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ListenPoint_marshaller,@val);
  result := a.to_static_any(stat);
end;

function ListenPoint_to_any(const val: TListenPoint): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ListenPoint_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_ListenPoint_seq(const a: IAny; var val): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ListenPoint_seq_marshaller,@val);
  result := a.to_static_any(stat);
end;

function ListenPoint_seq_to_any(const val): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ListenPoint_seq_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_BiDirIIOPServiceContext(const a: IAny; var val: TBiDirIIOPServiceContext): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(BiDirIIOPServiceContext_marshaller,@val);
  result := a.to_static_any(stat);
end;

function BiDirIIOPServiceContext_to_any(const val: TBiDirIIOPServiceContext): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(BiDirIIOPServiceContext_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

initialization
  ListenPoint_marshaller := TListenPoint_marshaller.Create();
  ListenPoint_seq_marshaller := TListenPoint_seq_marshaller.Create();
  BiDirIIOPServiceContext_marshaller := TBiDirIIOPServiceContext_marshaller.Create();
  _tc_ListenPoint := CreateTypeCodeConst('010000000f00000064000000010000002100000049444c3a6f6d672e6f72672f49494f502f4c697374656e506f696e743a312e30000000'+
    '000c0000004c697374656e506f696e74000200000005000000686f737400000000120000000000000005000000706f72740000000004000000');
  _tc_ListenPoint_seq := CreateTypeCodeConst('010000001300000074000000010000000f00000064000000010000002100000049444c3a6f6d672e6f72672f49494f502f4c697374656e'+
    '506f696e743a312e30000000000c0000004c697374656e506f696e74000200000005000000686f73740000000012000000000000000500'+
    '0000706f7274000000000400000000000000');
  _tc_BiDirIIOPServiceContext := CreateTypeCodeConst('010000000f00000034010000010000002d00000049444c3a6f6d672e6f72672f49494f502f426944697249494f5053657276696365436f'+
    '6e746578743a312e300000000018000000426944697249494f5053657276696365436f6e7465787400010000000e0000006c697374656e'+
    '5f706f696e747300000015000000c0000000010000002500000049444c3a6f6d672e6f72672f49494f502f4c697374656e506f696e744c'+
    '6973743a312e3000000000100000004c697374656e506f696e744c697374001300000074000000010000000f0000006400000001000000'+
    '2100000049444c3a6f6d672e6f72672f49494f502f4c697374656e506f696e743a312e30000000000c0000004c697374656e506f696e74'+
    '000200000005000000686f737400000000120000000000000005000000706f7274000000000400000000000000');
{$ELSE}
implementation
{$ENDIF}
end.
