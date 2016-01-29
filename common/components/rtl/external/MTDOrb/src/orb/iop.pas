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
unit iop;

interface

uses
  orb_int,orb,Classes,orbtypes,SysUtils,giop_int,addr_int,map_int,
  code_int,comp_int,iiop_int,disp_int,req_int,req,except_int,
  env_int,mtmanager,{$IFDEF WIN32}winsock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF},
  osthread,mtmanager_int;

{$I dorb.inc}

{$IFNDEF USELIB}

type
  TIIOPProxyInvokeRecord = class(TORBObject, IIIOPProxyInvokeRecord)
  private
    FConnection : IGIOPConnection;
    FRequest : IORBRequest;
    FMessageID : MessageID;
    FORBID : ORBMessageID;
    FActive: boolean;
  public
    destructor Destroy; override;
    procedure init(id: ORBMessageID;conn: IGIOPConnection;req : IORBRequest);
    function id(): ORBMessageID;
    function msgid(): MessageID;
    function request(): IORBRequest;
    procedure reset();
    function connection(): IGIOPConnection;
    function active(): boolean;
    procedure deactivate();
  end;

  TGIOPConnection = class(TORBObject, IGIOPConnection, ITransportCallback)
  private
    FIdleTimeout: long;
    FMaxMessageSize: _ulong;
    FTransport : ITransport;
    FCallBack : IGIOPCallBack;
    FCodec : IGIOPCodec;
    FDispatcher : IORBDispatcher;
    FInBuffer : IBuffer;
    FInBuffer2 : IBuffer;
    FInFrag : IBuffer;
    FInlen : integer;
    FInContext : IGIOPInContext;
{$IFDEF HAVE_THREADS}
    FWriter: IGIOPConnectionWriter;
    FReader: IOperation;
    FStateRef: TStateRefCount;
    FUseReaderThread: boolean;
    FUseWriterThread: boolean;
    FExclusive: TMutex;
    FRefCountLock: TMutex;
{$ENDIF}
    FRefCnt: long;
    FOutbufs: IInterfaceStack;
    FTotalFragSize: _ulong;
    FFragments: ILongInterfaceMap;
    function input_ready(): boolean;
    procedure close_connection();
    procedure output_handler(const buf : IBuffer);
{$IFDEF HAVE_THREADS}
    procedure get_exclusive();
    procedure release_exclusive();
{$ENDIF}
  protected
    { IGIOPConnection }
    procedure do_read(break_after_read: boolean = false);
    procedure do_write();
    function input(): IBuffer;
    function codec(): IGIOPCodec;
    function transport(): ITransport;
    procedure start();
{$IFDEF HAVE_THREADS}
    procedure output(const buf : IBuffer);
    procedure activeDeref();
    function activeRef(): boolean;
    procedure terminate();
    function state(): TExecState;
{$ENDIF}
    function deref(all: boolean = false): boolean;
    procedure ref();
    function input_ready_callback(const buf : IBuffer): boolean;
    procedure flush();
    { ITransportCallback }
    procedure callback(tr: ITransport;event :TTransportCallBackEvent);
  public
{$IFDEF HAVE_THREADS}
    constructor Create(disp: IORBDispatcher; orb: IORB; t : ITransport; oa: IGIOPCallBack;
      codec: IGIOPCodec; tmout: long = 0; max_size: _ulong = 0;
      reader_thread: boolean = false; writer_thread: boolean = false);
{$ELSE}
    constructor Create(disp: IORBDispatcher; orb: IORB; t : ITransport; oa: IGIOPCallBack;
      codec: IGIOPCodec; tmout: long = 0; max_size: _ulong = 0);
{$ENDIF}
    destructor Destroy; override;
  end;

  TGIOPOutContext = class(TORBObject, IGIOPOutContext)
  private
    FBuffer: IBuffer;
    FEncoder : IEncoder;
  protected
    function encoder(): IEncoder;
    function buffer(): IBuffer;
    function length(): _ulong;
    procedure set_converter(conv: ICodesetCoder);
  public
    constructor Create(codec: IGIOPCodec; con: ICodesetCoder = nil);
    constructor Create_enc(const enc: IEncoder);
  end;

  TGIOPInContext = class(TORBObject, IGIOPInContext)
  private
    FBuffer: IBuffer;
    FDecoder : IDecoder;
  protected
    function decoder(): IDecoder;
    procedure set_converter(conv: ICodesetCoder);
    procedure buffer(buf: IBuffer);
  public
    constructor Create(codec: IGIOPCodec; buf: IBuffer; con: ICodesetCoder);
  end;

  TGIOPRequest = class(TORBRequest, IGIOPRequest, IORBRequest)
  private
    FCodec: IGIOPCodec;
    FDecoder: IDecoder;
    FEncoder: IEncoder;
    FStart,FOStart : _ulong;
    FIS_Except: Boolean;
  protected
    procedure add_in_arg(const any: IStaticAny);
    procedure add_inout_arg(const any: IStaticAny);
    procedure add_out_arg(const any: IStaticAny);
    function copy_out_args(const req: IORBRequest): Boolean;
    function get_in_args(const enc: IEncoder): Boolean; overload;
    function get_in_args(const list : INVList; out ctx: IContext): Boolean; overload;
    function get_in_args(const list : IStaticAnyList; out ctx: IContext): Boolean; overload;
    function get_out_args(const enc: IEncoder; out is_except: Boolean): Boolean; overload;
    function get_out_args(const res: IStaticAny; const list: IStaticAnyList; out ex: IORBException): Boolean; overload;
    function get_out_args(const res: IAny; const list: INVList; out ex: IORBException): Boolean; overload;
    procedure invoke();
    procedure set_result(const any: IStaticAny);
    function set_out_args(const dec: IDecoder; const exception : Boolean): Boolean; overload;
    function set_out_args(const ex: IORBException): Boolean; overload;
    function set_out_args(const res: IStaticAny; const list: IStaticAnyList): Boolean; overload;
    function set_out_args(const res: IAny; const list: INVList): Boolean; overload;
    function req_type(): AnsiString;
    function input_byteorder: TByteOrder;
    function output_byteorder: TByteOrder;
  public
    constructor Create(operation: AnsiString;const dec: IDecoder; const codec: IGIOPCodec);
    destructor Destroy(); override;
  end;

  TGIOPConnectionWriter = class(TActiveOperation, IGIOPConnectionWriter)
  private
    FConn: IGIOPConnection;
  protected
    procedure _send_msg(msg: IMsgType);
    procedure process(msg: IMsgType); override;
    function copy(): IOperation; override;
  public
    constructor Create(conn: IGIOPConnection);
  end;

  TGIOPConnectionReader = class(TOperation, IOperation)
  private
    FConn: IGIOPConnection;
  protected
    procedure run(); override;
    function copy(): IOperation; override;
  public
    constructor Create(conn: IGIOPConnection);
  end;

  TInputHandler = class(TPassiveOperation{, IPassiveOperation})
  protected
    procedure process(msg: IMsgType); override;
    function copy(): IOperation; override;
  public
    constructor Create(); overload;
    destructor Destroy(); override;
  end;

  TDummyDispatcher = class(TInterfacedObject, IORBDispatcher)
  protected
    procedure socketevent(const cb: IORBDispCallback; fd: TSocket;evt: TDispEvent);
    procedure timeevent(const cb: IORBDispCallback; timeout: longint);
    procedure run(infinite :Boolean);
    procedure move(const disp: IORBDispatcher);
    procedure remove(const cb: IORBDispCallback;evt: TDispEvent);
    function idle(): Boolean;
    procedure block(b: boolean);
    function isblocking: boolean;
  end;

  TGIOPConnectionMsg = class(TInterfacedObject, IGIOPConnectionMsg)
  private
    FConn: IGIOPConnection;
    FBuffer: IBuffer;
    FEv: TEventType;
  protected
    function connection(): IGIOPConnection;
    function buffer(): IBuffer;
    function eventType(): TEventType;
  public
    constructor Create(const conn: IGIOPConnection; const buf: IBuffer; ev: TEventType);
  end;

  TORBMsg = class(TInterfacedObject, IOrbMsg)
  private
    FConn: IGIOPConnection;
    FCallback: IGIOPCallBack;
    FEv: TORBMsgEvent;
  protected
    function connection(): IGIOPConnection;
    function callback(): IGIOPCallBack;
    function orbEvent(): TORBMsgEvent;
  public
    constructor Create(const conn: IGIOPConnection; const cb: IGIOPCallBack; ev: TORBMsgEvent);
  end;

implementation

uses
  decoder,encoder,buffer,codeset_ref,iior_int,mcomp_int,codec,map,mtdebug;

{**********************************************************
  TIIOPProxyInvokeRecord
**********************************************************}
procedure TIIOPProxyInvokeRecord.init(id: ORBMessageID;conn: IGIOPConnection;req : IORBRequest);
begin
  FORBID := id;
  FMessageID := ORB_Instance.get_msgid(id);
  FConnection := conn;
  FRequest := req;
  FActive := true;
end;

function TIIOPProxyInvokeRecord.connection(): IGIOPConnection;
begin
  result := FConnection;
end;

procedure TIIOPProxyInvokeRecord.reset();
begin
  FConnection := nil;
  FMessageID := 0;
  FRequest := nil;
end;

function TIIOPProxyInvokeRecord.id(): ORBMessageID;
begin
  result := FORBID;
end;

function TIIOPProxyInvokeRecord.msgid(): MessageID;
begin
  result := FMessageID;
end;

function TIIOPProxyInvokeRecord.request(): IORBRequest;
begin
  result := FRequest;
end;

function TIIOPProxyInvokeRecord.active: boolean;
begin
  result := FActive;
end;

procedure TIIOPProxyInvokeRecord.deactivate;
begin
  FActive := false;
end;

destructor TIIOPProxyInvokeRecord.Destroy;
begin
  if id() <> nil then
    id().set_invoke_hint(nil);
  inherited;
end;

{**********************************************************
  TGIOPInContext
**********************************************************}
constructor TGIOPInContext.Create(codec: IGIOPCodec; buf: IBuffer; con: ICodesetCoder);
begin
  FBuffer := buf;
{$IFDEF HAVE_THREADS}
  FDecoder := TDecoder.Create(FBuffer);
{$ELSE}
  FDecoder := codec.get_decoder;
  FDecoder._buffer(FBuffer);
{$ENDIF}
  if con <> nil then
    FDecoder.set_converter(con);
end;

function TGIOPInContext.decoder(): IDecoder;
begin
  result := FDecoder;
end;

procedure TGIOPInContext.buffer(buf: IBuffer);
begin
  FBuffer := buf;
  Fdecoder._buffer(buf);
end;

procedure TGIOPInContext.set_converter(conv: ICodesetCoder);
begin
  FDecoder.set_converter(conv);
end;

{************************************************************
  TGIOPOutContext
************************************************************}
constructor TGIOPOutContext.Create(codec: IGIOPCodec; con: ICodesetCoder);
begin
  FBuffer := TBuffer.Create(100);
{$IFDEF HAVE_THREADS}
  FEncoder := TEncoder.Create(FBuffer);
{$ELSE}
  FEncoder := codec.get_encoder;
  FEncoder.buffer(FBuffer);
{$ENDIF}
  if con <> nil then
    FEncoder.set_converter(con);
end;

constructor TGIOPOutContext.Create_enc(const enc: IEncoder);
begin
  FBuffer := enc.buffer;
  FEncoder := enc;
end;

function TGIOPOutContext.buffer(): IBuffer;
begin
  result := FBuffer;
end;

function TGIOPOutContext.length(): _ulong;
begin
  // must return contextdata count
  result := 0;
end;

function TGIOPOutContext.encoder(): IEncoder;
begin
  result := FEncoder;
end;

procedure TGIOPOutContext.set_converter(conv: ICodesetCoder);
begin
  FEncoder.set_converter(conv);
end;

{************************************************************
  TGIOPConnection
************************************************************}
{$IFDEF HAVE_THREADS}
constructor TGIOPConnection.Create(disp: IORBDispatcher; orb: IORB; t : ITransport; oa: IGIOPCallBack;
  codec: IGIOPCodec; tmout: long = 0; max_size: _ulong = 0;
  reader_thread: boolean = false; writer_thread: boolean = false);
{$ELSE}
constructor TGIOPConnection.Create(disp: IORBDispatcher; orb: IORB; t : ITransport;
  oa: IGIOPCallBack; codec: IGIOPCodec; tmout: long; max_size: _ulong);
{$ENDIF}
var
  prop: string;
begin
  FORB := orb;
  prop := FORB.get_Properties.get_Property('mtdorb.orb.conc_model');
{$IFDEF HAVE_THREADS}
  FUseReaderThread := reader_thread;
  FUseWriterThread := writer_thread;
{$ENDIF}
  FTransport := t;
  FCallBack := oa;
  FCodec := codec;
  FInlen := codec.header_len;
  FIdleTimeout := tmout;
  FMaxMessageSize := max_size;
  //FDispatcher := orb.dispatcher();
  FDispatcher := disp;
  FInBuffer := TBuffer.Create(100);
  FInBuffer2 := nil;
  FInContext := TGIOPInContext.Create(codec,TBuffer.Create(10) as IBuffer,nil);
  FTransport.block(FDispatcher.isblocking());
  t.rselect(FDispatcher,self);
{$IFDEF HAVE_THREADS}
  if FUseReaderThread then
    FReader := TGIOPConnectionReader.Create(Self);
  if FUseWriterThread then
    FWriter := TGIOPConnectionWriter.Create(Self);
  FExclusive := TMutex.Create;
  FRefCountLock := TMutex.Create;
{$ENDIF}
  FStateRef := TStateRefCount.Create;
  FOutBufs := interface_stack();
  FFragments := long_interface_map();
end;

destructor TGIOPConnection.Destroy;
begin
  Assert(FRefCnt <= 0);
{$IFDEF HAVE_THREADS}
  FreeAndNil(FStateRef);
  FreeAndNil(FExclusive);
  FreeAndNil(FRefCountLock);
{$ENDIF}
  inherited;
end;

// connection shutdown is very complicated for mt
// we cannot delete the GIOPConn object before
// all running invocations have been terminated
{$IFDEF HAVE_THREADS}
procedure TGIOPConnection.terminate;
begin
  Assert(FRefCnt >= 0);
  if not FStateRef.StateChange(esShutdown) then Exit;
  { TODO -oOVS : remove not called, but for what? }
  //FDispatcher.remove(Self, _Timer);
  // REMEMBER: terminate tells the thread to exit
  // it does NOT cancel the thread
  if FUseWriterThread then
    FWriter.init_shutdown();
  if FUseReaderThread then
    FReader.init_shutdown();
  FTransport.close();
  FTransport.rselect(FDispatcher, nil);
  FTransport.wselect(FDispatcher, nil);
  if FUseWriterThread then begin
    FWriter.finalize_shutdown();
    FWriter := nil;
  end;
  if FUseReaderThread then begin
    FReader.finalize_shutdown();
    FReader := nil;
  end;
  // do not delete: disp
  FStateRef.StateChange(esTerminated);
  //WJ: remove reference to transport (memory leak)
  FTransport := nil;
end;
{$ENDIF}

procedure TGIOPConnection.close_connection;
var
  msg: IMsgType;
  orbMsg: IOrbMsg;
begin
{$IFDEF HAVE_THREADS}
  if not FStateRef.InitShutdown() then
    Exit;
  orbMsg := TORBMsg.Create(Self, FCallback, omeCloseConn);
  orbMsg._AddRef();
  msg := TMsgType.Create(Pointer(orbMsg));
  TMTManager.ThreadPoolManager.put_msg(odORB, msg);
{$ELSE}
  FCallBack.giop_callback(Self, Closed);
{$ENDIF}
end;

function TGIOPConnection.input_ready: boolean;
var
  msg: IMsgType;
  msgRec: IGIOPConnectionMsg;
begin
{$IFDEF HAVE_THREADS}
  // connection is being terminated
  result := activeRef();
  if not result then
    Exit;

  if TMTManager.ThreadPool then begin
    msgRec := TGIOPConnectionMsg.Create(Self, Input(), InputReady);
    msgRec._AddRef();
    msg := TMsgType.Create(Pointer(msgRec));
    TMTManager.ThreadPoolManager.get_thread_pool(odDecode).put_msg(odAccept, msg);
    result := true;
    Exit;
  end;

  if TMTManager.ThreadPerRequest then begin
    msgRec := TGIOPConnectionMsg.Create(Self, Input(), InputReady);
    msgRec._AddRef();
    msg := TMsgType.Create(Pointer(msgRec));
    FReader.send_msg(odDeCode, msg);
    result := true;
    Exit;
  end;

  if TMTManager.ThreadPerConnection then begin
    input_ready_callback(Input());
    result := true;
  end;
{$ELSE}
  input_ready_callback(Input());
  result := true;
{$ENDIF}
end;

procedure TGIOPConnection.output_handler(const buf: IBuffer);
begin
  // try to write as much as possible immediatly
  if (FOutBufs.Count() = 0) then begin
      FTransport.bufwrite(buf, buf.length());
      if (buf.length() = 0) then
        Exit;
      FOutBufs.Push(buf);
  end
  else begin
    FOutBufs.Push(buf);
    do_write();
  end;
  { TODO -oOVS : check_busy }
end;

function TGIOPConnection.deref(all: boolean): boolean;
begin
{$IFNDEF HAVE_THREADS}
  if all then FRefCnt := 0
  else FRefCnt := Pred(FRefCnt);
  check_idle();
  result := FRefCnt <= 0;
{$ELSE}
  FRefCountLock.lock();
  try
    FRefCnt := Pred(FRefCnt);
    result := FRefCnt = 0;
  finally
    FRefCountLock.unlock();
  end;
{$ENDIF}
end;

procedure TGIOPConnection.ref;
begin
{$IFDEF HAVE_THREADS}
  FRefCountLock.lock();
  try
{$ENDIF}
    FRefCnt := Succ(FRefCnt);
{$IFDEF HAVE_THREADS}
  finally
    FRefCountLock.unlock();
  end;
{$ENDIF}
end;

function TGIOPConnection.state: TExecState;
begin
  result := FStateRef.State();
end;

function TGIOPConnection.input_ready_callback(
  const buf: IBuffer): boolean;
begin
  result := FCallBack.input_giop_callback(Self, buf);
end;

procedure TGIOPConnection.start;
begin
{$IFDEF HAVE_THREADS}
  ref();
  FStateRef.StateChange(esActive);
  if FUseWriterThread then
    FWriter.start();
  if FUseReaderThread then
    FReader.start();
{$ENDIF}
end;

{$IFDEF HAVE_THREADS}
procedure TGIOPConnection.activeDeref;
begin
  FStateRef.activeDeref();
end;

function TGIOPConnection.activeRef: boolean;
begin
  result := FStateRef.activeRef();
end;
{$ENDIF}

function TGIOPConnection.input(): IBuffer;
begin
  result := FInBuffer2;
  FInBuffer2 := nil;
end;

procedure TGIOPConnection.do_write();
var
  b: IBuffer;
  result: integer;
begin
  while true do begin
    Assert(FOutBufs.Count > 0);
    b := IBuffer(FOutBufs.Peek);
    result := FTransport.bufwrite(b, b.length());
    if result > 0 then begin
      // message completely sent
      if b.length() = 0 then begin
        b := IBuffer(FOutBufs.Pop);
        b := nil;
        if FOutBufs.Count = 0 then begin
          { TODO -oOVS : check_idle }
          Break;
        end;
      end
    end
    else if result < 0 then begin
      // connection broken
      FTransport.rselect(FDispatcher, nil);
      FTransport.wselect(FDispatcher, nil);
      close_connection();
      Break;
    end
    else // result = 0
      Break;
  end; { while }
end;

function TGIOPConnection.transport: ITransport;
begin
  result := FTransport;
end;

procedure TGIOPConnection.do_read(break_after_read: boolean);
var
  len : integer;
  mt: TMessageType;
  flags: Byte;
  mtInt: Byte;
  reqid: _ulong;
  fragbuf: IBuffer;
begin
  while true do begin
    len := FTransport.bufread(FInBuffer,FInLen);
    if (len < 0) or ((len = 0) and (FTransport.eof)) then  begin
      // connection broken or EOF
      // WJ: Sometimes here throws AV at orb destroy
      // todo: track it down
      try
          if Assigned(FTransport) then
          begin
            FTransport.rselect(FDispatcher,nil);
            FTransport.wselect(FDispatcher,nil);
          end;
      except on ex: Exception do
          MTDORBLogger.Error('Error in reading GIOP: ' + AnsiString(ex.Message));
      end;
      close_connection();
      Break;
    end
    else if len = 0 then
      Break
    else if len > 0 then begin
      FInLen := FInlen - len;
      if FInBuffer.Length = FCodec.header_len then begin
        // header completely received
        Assert(FInLen = 0);
        FInContext.buffer(FInBuffer);
        if not codec.check_header(FInContext, mt, _ulong(FInLen), flags) then begin
          // garbled message, send it to input handler ...
          FInBuffer2 := FInBuffer;
          FInBuffer := TBuffer.Create(100);
          FInLen := codec.header_len;
          FTransport.rselect(FDispatcher,nil);
          FTransport.wselect(FDispatcher,nil);
          input_ready();
          Break;
        end;
        if (FMaxMessageSize > 0) and (FInLen > long(FMaxMessageSize)) then begin
          FTransport.rselect(FDispatcher,nil);
          FTransport.wselect(FDispatcher,nil);
          close_connection();
          Break;
        end;
        if (mt = Fragment) or ((flags and GIOP_FRAGMENT_BIT) <> 0) then begin
          if (FMaxMessageSize > 0) and ((_ulong(FInLen) + FTotalFragSize) > FMaxMessageSize) then begin
            FTransport.rselect(FDispatcher,nil);
            FTransport.wselect(FDispatcher,nil);
            close_connection();
            Break;
          end;
        end;
        if mt = Fragment then begin
          if (codec.version() = $0101) then begin
            // a fragment, append contents to infrag ...
            if (FInFrag = nil) then begin
              FTransport.rselect(FDispatcher,nil);
              FTransport.wselect(FDispatcher,nil);
              close_connection();
              Break;
            end;
            FInBuffer := FInFrag;
            FInFrag := nil;
          end;
        end;
      end;
      if FInlen = 0 then begin
        // message completely received
        // check if it is a fragment message
        FInBuffer.RseekFromBegin(7);
        FInBuffer.get1(mtInt);
        FInBuffer.RseekFromBegin(0);

        if (TMessageType(mtInt) = Fragment) and (codec.version() = $0102) then begin
          if (FInBuffer.length() < 16) then begin
            FTransport.rselect(FDispatcher,nil);
            FTransport.wselect(FDispatcher,nil);
            close_connection();
            Break;
          end;
          // we don't really need the correct byte order here
          FInBuffer.RseekFromBegin(12); // request id
          FInBuffer.get4(reqid);
          fragbuf := IBuffer(FFragments.Item[reqid]);
          if (FFragments.Item[reqid] = nil) then begin
            FTransport.rselect(FDispatcher,nil);
            FTransport.wselect(FDispatcher,nil);
            close_connection();
            Break;
          end;
          // add contents of _inbuf (after the request id) to the
          // stored buffer
          fragbuf.put(FInBuffer.data()^, FInBuffer.length());
          FTotalFragSize := FTotalFragSize + FInBuffer.length();
          // reset input buffer
          FInBuffer.reset();
          FInLen := FCodec.header_len();
          // do more fragments follow? then continue
          if (flags and GIOP_FRAGMENT_BIT) <> 0 then
            Continue;
          // pass data to input handler
          Assert(FInBuffer2 = nil);
          FFragments.erase(reqid);
          FInBuffer2 := fragbuf;
          Assert(FInBuffer.length() < FTotalFragSize);
          FTotalFragSize := FTotalFragSize - FInBuffer.length();
          if (not input_ready() or break_after_read) then
            Break;
          Continue;
        end;

        if (flags and GIOP_FRAGMENT_BIT) <> 0 then begin
          // more fragments follow ...
          if (codec.version() >= $0102) then begin
            // determine request id
            if (FInBuffer.length() < 16) then begin
              // can't handle GIOP 1.2 fragments yet
              FTransport.rselect(FDispatcher,nil);
              FTransport.wselect(FDispatcher,nil);
              close_connection();
              Break;
            end;
            if (FMaxMessageSize <> 0) and ((FInBuffer.length() + FTotalFragSize) > FMaxMessageSize) then begin
              FTransport.rselect(FDispatcher,nil);
              FTransport.wselect(FDispatcher,nil);
              close_connection();
              Break;
            end;
            // we don't really need the correct byte order here
            FInBuffer.RseekFromBegin(12); // request id
            FInBuffer.get4(reqid);
            if (FFragments.Item[reqid] <> nil) then begin
              FTransport.rselect(FDispatcher,nil);
              FTransport.wselect(FDispatcher,nil);
              close_connection();
              Break;
            end;
            FInBuffer.RseekFromBegin(0);
            FFragments.Item[reqid] := FInBuffer;
            FTotalFragSize := FTotalFragSize + FInBuffer.length();
            FInBuffer := TBuffer.Create(100);
            FInLen := FCodec.header_len();
          end
          else begin
            // handle GIOP 1.1 fragments
            if (FInFrag <> nil) then begin
              FTransport.rselect(FDispatcher,nil);
              FTransport.wselect(FDispatcher,nil);
              close_connection();
              Break;
            end;
          end;
          FInFrag := FInBuffer;
          FInBuffer := TBuffer.Create(100);
          FInlen := codec.header_len();
        end
        else begin
          FInBuffer2 := FInBuffer;
          FInBuffer := TBuffer.Create(100);
          FInLen := codec.header_len;
          if not input_ready() or break_after_read then
            Break;
        end;
      end;
    end
    else
      assert(false,'???????');
  end;
end;

procedure TGIOPConnection.callback(tr: ITransport;event :TTransportCallBackEvent);
begin
  case event of
    tcRead: do_read(FDispatcher.isblocking());
    tcWrite : do_write();
    else
      assert(false);
  end;
end;

function TGIOPConnection.codec(): IGIOPCodec;
begin
  result := FCodec;
end;

procedure TGIOPConnection.flush;
var
  block: boolean;
  buf: IBuffer;
begin
  block := FTransport.isblocking();
  FTransport.block(true);
  try
    while FOutBufs.Count > 0 do begin
      buf := IBuffer(FOutBufs.Pop);
      FTransport.bufwrite(buf, buf.length());
    end; { while }
  finally
    FTransport.block(block);
  end; { try/finally }
end;

{$IFDEF HAVE_THREADS}
procedure TGIOPConnection.output(const buf : IBuffer);
var
  msg: IMsgType;
begin
  // post the Buffer to the write thread
  if FStateRef.State = esActive then begin
    {if TMTManager.ThreadPool then begin
      output_handler(buf);
    end
    else begin}
      if FWriter <> nil then begin
        buf._AddRef;
        msg := TMsgType.Create(Pointer(buf));
        FWriter._send_msg(msg);
      end
      else
        output_handler(buf);
    //end;
  end;
end;
{$ENDIF}

{$IFDEF HAVE_THREADS}
procedure TGIOPConnection.get_exclusive;
begin
  FExclusive.lock;
end;

procedure TGIOPConnection.release_exclusive;
begin
  FExclusive.unlock;
end;
{$ENDIF}

//***************************************************************
// TGIOPRequest
//***************************************************************
constructor TGIOPRequest.Create(operation: AnsiString;
  const dec: IDecoder; const codec: IGIOPCodec);
begin
  FOperation := operation;
  FDecoder := dec;
  FEncoder := TEncoder.Create(dec._Buffer);
  FEncoder.set_converter(dec.get_converter());
  FCodec := codec;
  FStart := FDecoder._Buffer.RPosition;
  FOStart := 0;
  FIs_Except := false;
end;

destructor TGIOPRequest.Destroy();
begin
  FDecoder := nil;
  FCodec := nil;
end;

function TGIOPRequest.get_out_args(const res: IStaticAny; const list: IStaticAnyList; out ex: IORBException): Boolean;
begin
  result := false;
  assert(false,'not implemented');
end;

function TGIOPRequest.get_out_args(const res: IAny; const list: INVList; out ex: IORBException): Boolean;
begin
  result := false;
  assert(false,'not implemented');
end;

procedure TGIOPRequest.add_in_arg(const any: IStaticAny);
begin
  assert(false,'not implemented');
end;

procedure TGIOPRequest.add_inout_arg(const any: IStaticAny);
begin
  assert(false,'not implemented');
end;

procedure TGIOPRequest.add_out_arg(const any: IStaticAny);
begin
  assert(false,'not implemented');
end;

function TGIOPRequest.copy_out_args(const req: IORBRequest): Boolean;
begin
  result := false;
  if IORBRequest(self) = req then
    begin
      result := true;
      exit;
    end
  else begin
    copy_servcntx(req);
    assert(false,'not implemented');
  end;
end;

function TGIOPRequest.input_byteorder: TByteOrder;
begin
  result := FDecoder.byteorder
end;

function TGIOPRequest.output_byteorder: TByteOrder;
begin
  result := FEncoder.byteorder
end;

function TGIOPRequest.set_out_args(const res: IAny; const list: INVList): Boolean;
var
  outc: IGIOPOutContext;
  i : integer;
begin
  FIS_Except := false;
  FEncoder.buffer.reset;
  result := false;
  if (res = nil) and (list.Count = 0) then
    begin
      result := true;
      exit;
    end;
  if FCodec.version < $0102 then
    begin
      outc := TGIOPOutContext.Create_enc(FEncoder);
      FCodec.put_invoke_reply_offset(outc,self);
      FOStart := FEncoder.buffer.WPosition;
    end;
  FEncoder.buffer.RseekFromBegin(FOStart);
  if (res<>nil) and not res.marshal(FEncoder) then exit;
  for i := 0 to Pred(list.Count) do
    if list.item(i).flags in [ARG_OUT,ARG_INOUT] then
      if not list.item(i).argument.marshal(FEncoder) then exit;
  result := true;
end;

function TGIOPRequest.set_out_args(const res: IStaticAny; const list: IStaticAnyList): Boolean;
var
  outc: IGIOPOutContext;
  i : integer;
begin
  result := false;
  FEncoder.buffer.reset;
  if (res = nil) and (list.Count = 0) then
    begin
      result := true;
      exit;
    end;
  if FCodec.version < $0102 then
    begin
      outc := TGIOPOutContext.Create_enc(FEncoder);
      FCodec.put_invoke_reply_offset(outc,self);
      FOStart := FEncoder.buffer.WPosition;
    end;
  FEncoder.buffer.RseekFromBegin(FOStart);
  if (res<>nil) and not res.marshal(FEncoder) then exit;
  for i := 0 to Pred(list.Count) do
    if list[i].get_flags in [ARG_OUT,ARG_INOUT] then
      if not list[i].marshal(FEncoder) then exit;
  result := true;
end;

function TGIOPRequest.get_in_args(const list : INVList; out ctx: IContext): Boolean;
var
  i : integer;
  a : IAny;
begin
  result := false;
  FDecoder._Buffer.RseekFromBegin(FStart);
  if (list.Count = 0) and (FDecoder._Buffer.Length = 0) then
    begin
      result := true;
      exit;
    end;
  for i := 0 to Pred(list.count) do
    if list.item(i).flags in [ARG_IN,ARG_INOUT] then
      begin
        a := list.item(i).argument;
        if not a.demarshal(a.__tc,FDecoder) then
           exit;
      end;
  if FDecoder._buffer.Length > 0 then
    begin
      // restoring context
      assert(false,'not implemented');
    end;
  result := true;
end;

function TGIOPRequest.get_in_args(const list : IStaticAnyList; out ctx: IContext): Boolean;
var
  i : integer;
begin
  result := false;
  FDecoder._Buffer.RseekFromBegin(FStart);
  if (list.Count = 0) and (FDecoder._Buffer.Length = 0) then
    begin
      result := true;
      exit;
    end;
  for i := 0 to Pred(list.count) do
    if list[i].get_flags in [ARG_IN,ARG_INOUT] then
       if not list[i].demarshal(FDecoder) then
         exit;
  if FDecoder._buffer.Length > 0 then
    begin
      // restoring context
      assert(false,'not implemented');
    end;
  result := true;
end;

function TGIOPRequest.get_in_args(const enc: IEncoder): Boolean;
begin
  result := false;
  assert(false,'not implemented');
end;

function TGIOPRequest.get_out_args(const enc: IEncoder; out is_except: Boolean): Boolean;
begin
  FEncoder.buffer.RseekFromBegin(FOStart);
  enc.put_octets(PAnsiChar(FEncoder.buffer.Data)^,FEncoder.buffer.Length);
  is_except := FIS_Except;
  result := true;
end;

function TGIOPRequest.req_type(): AnsiString;
begin
  result := 'giop';
end;

procedure TGIOPRequest.invoke;
begin
  assert(false,'not implemented');
end;

function TGIOPRequest.set_out_args(const dec: IDecoder;
  const exception: Boolean): Boolean;
begin
  result := false;
  assert(false,'not implemented');
end;

function TGIOPRequest.set_out_args(const ex: IORBException): Boolean;
var
  outc: IGIOPOutContext;
begin
  FEncoder.buffer.reset;
  if FCodec.version < $0102 then
    begin
      outc := TGIOPOutContext.Create_enc(FEncoder); //  Create(IEncoder)
      FCodec.put_invoke_reply_offset(outc,self);
      FOStart := FEncoder.Buffer.WPosition;
    end;
  FEncoder.buffer.RseekFromBegin(FOStart);
  FIS_Except := TRUE;
  ex.encode(FEncoder);
  result := true;
end;

procedure TGIOPRequest.set_result(const any: IStaticAny);
begin
  assert(false,'not implemented');
end;


{ TGIOPConnectionReader }

procedure TGIOPConnectionReader.run;
begin
  FConn.do_read();
  if FWThread <> nil then
    FWThread.deregister_operation(Self);
end;

function TGIOPConnectionReader.copy: IOperation;
begin

end;

constructor TGIOPConnectionReader.Create(conn: IGIOPConnection);
var
  kt: IWorkerThread;
begin
  inherited Create();
  FConn := conn;
  kt := TMTManager.ThreadPoolManager.get_idle_thread(odReader);
  Assert(kt <> nil);
  kt.register_operation(Self);
  FInfo.set_nextOP(TMTManager.ThreadPoolManager.get_thread_pool(odDeCode));
  kt.mark_busy();
end;

{ TGIOPConnectionWriter }

function TGIOPConnectionWriter.copy: IOperation;
begin

end;

constructor TGIOPConnectionWriter.Create(conn: IGIOPConnection);
var
  kt: IWorkerThread;
begin
  inherited Create();
  FConn := conn;
  FInputMC := TPassiveMsgQueue.Create();
  kt := TMTManager.ThreadPoolManager.get_idle_thread(odWriter);
  Assert(kt <> nil);
  kt.register_operation(Self);
  kt.mark_busy();
end;

procedure TGIOPConnectionWriter.process(msg: IMsgType);
var
  b: IBuffer;
begin
  b := IBuffer(msg.data());
  b._Release;
  FConn.output_handler(b);
end;

procedure TGIOPConnectionWriter._send_msg(msg: IMsgType);
begin
  get_input_mc().put_msg(odWriter, msg);
end;

{ TInputHandler }

function TInputHandler.copy: IOperation;
begin
  result := TInputHandler.Create(Self);
end;

constructor TInputHandler.Create;
begin
  inherited;
  FInfo.set_OP_ID(odDeCode);
end;

destructor TInputHandler.Destroy;
begin
  inherited;
end;

procedure TInputHandler.process(msg: IMsgType);
var
  m: IGIOPConnectionMsg;
begin
  m := IGIOPConnectionMsg(msg.data());
  m.connection().input_ready_callback(m.buffer());
  m._Release();
end;

{ TDummyDispatcher }

procedure TDummyDispatcher.block(b: boolean);
begin

end;

function TDummyDispatcher.idle: Boolean;
begin
  result := true;
end;

function TDummyDispatcher.isblocking: boolean;
begin
  result := true;
end;

procedure TDummyDispatcher.move(const disp: IORBDispatcher);
begin

end;

procedure TDummyDispatcher.remove(const cb: IORBDispCallback;
  evt: TDispEvent);
begin

end;

procedure TDummyDispatcher.run(infinite: Boolean);
begin

end;

procedure TDummyDispatcher.socketevent(const cb: IORBDispCallback;
  fd: TSocket; evt: TDispEvent);
begin

end;

procedure TDummyDispatcher.timeevent(const cb: IORBDispCallback;
  timeout: Integer);
begin

end;

{ TGIOPConnectionMsg }

function TGIOPConnectionMsg.buffer: IBuffer;
begin
  result := FBuffer;
end;

function TGIOPConnectionMsg.connection: IGIOPConnection;
begin
  result := FConn;
end;

constructor TGIOPConnectionMsg.Create(const conn: IGIOPConnection;
  const buf: IBuffer; ev: TEventType);
begin
  inherited Create();
  FConn := conn;
  FBuffer := buf;
  FEv := ev;
end;

function TGIOPConnectionMsg.eventType: TEventType;
begin
  result := FEv;
end;

{ TORBMsg }

function TORBMsg.callback: IGIOPCallBack;
begin
  result := FCallback;
end;

function TORBMsg.connection: IGIOPConnection;
begin
  result := FConn;
end;

constructor TORBMsg.Create(const conn: IGIOPConnection;
  const cb: IGIOPCallBack; ev: TORBMsgEvent);
begin
  inherited Create();
  FConn := conn;
  FCallback := cb;
  FEv := ev;
end;

function TORBMsg.orbEvent: TORBMsgEvent;
begin
  result := FEv;
end;

{$ELSE}
implementation
{$ENDIF}
end.
