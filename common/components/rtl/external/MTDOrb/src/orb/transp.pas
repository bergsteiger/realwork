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
   Implementation of Transport and TransportServer.
 }
unit transp;

interface

{$I dorb.inc}

uses
  orbtypes,orb,Classes,addr_int,disp_int,{$IFDEF WIN32}winsock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF},
  code_int,orb_int,env_int,mtmanager_int,mtmanager;

{$IFNDEF USELIB}

type

  TPrincipal = class(TInterfacedObject,IPrincipal)
  private
    FTransport: ITransport;
    FInfo : OctetSeq;
  protected
    procedure encode(const enc: IEncoder);
    function decode(const dec: IDecoder): Boolean;
    function get_property(const prop_name: string): IAny; virtual;
  public
    constructor Create(transp: ITransport = nil);
    class procedure set_peer_info(info: OctetSeq);
  end;

  TTCPTransport = class(TInterfacedObject, ITransport, IORBDispCallBack)
  protected
    FSocket : longint;
    FIsBlocking : Boolean;
    FEOF : Boolean;
    FIsBuffering : Boolean;
    FReadDispatcher,FWriteDispatcher : IORBDispatcher;
    FReadCallBack,FWriteCallback : ITransportCallBack;
    FPeerAddress : IAddress;
    FLocalAddress : IAddress;
    FState: TTransportState;
  public
    procedure block(val: Boolean);
    function isblocking(): boolean;
    function connect(const addr: IAddress): Boolean; stdcall;
    procedure open(fd: Longint); stdcall;
    procedure close(); stdcall;
    function write(const buffer; size: _ulong): integer; stdcall;
    function eof(): Boolean; stdcall;
    function bad(): Boolean; stdcall;
    function read(var buffer; size: _ulong): integer; stdcall;
    procedure callback(const disp: IORBDispatcher;event: TDispEvent);
    procedure rselect(const disp: IORBDispatcher;const cb: ITransportCallback); stdcall;
    procedure wselect(const disp: IORBDispatcher;const cb: ITransportCallback); stdcall;
    function bufread(buf: IBuffer; size: _ulong): integer; stdcall;
    function bufwrite(buf: IBuffer; size: _ulong; eat: boolean = true): integer; stdcall;
    function peer(): IAddress;
    function get_principal(): IPrincipal;
    function get_address: IAddress;
  public
    constructor CreateSock(s : TSocket);
    constructor Create();
    destructor Destroy(); override;
  end;

{$IFDEF HAVE_THREADS}
  TTCPTransportServer = class;

  ITransportServerOperation = interface(IOperation)
  ['{CD4D63CB-8E4F-4CA1-A2AB-353349AB8628}']
    procedure set_server_callback(const AServCallback: ITransportServerCallback);
  end;

  TTransportServerOperationImpl = class(TOperation, ITransportServerOperation{IOperation})
  private
    FCb : ITransportServerCallback;
    FTranServ: ITransportServer;
  protected
    procedure init_shutdown(); override;
    procedure run(); override;
    function copy(): IOperation; override;
    procedure set_server_callback(const AServCallback: ITransportServerCallback);
  public
    constructor Create(const ATranServ: ITransportServer);
  end;
{$ENDIF}

  TTCPTransportServer = class(TInterfacedObject,ITransportServer,{$IFDEF HAVE_THREADS}IOperation,{$ENDIF}IORBDispCallBack)
  private
    FLocalAddress : IAddress;
    FSocket : longint;
    FIsBlocking : Boolean;
    FListening : Boolean;
    FDisp : IORBDispatcher;
    FCb : ITransportServerCallback;
    FTp : IThreadPool;
{$IFDEF HAVE_THREADS}
    FOperation: ITransportServerOperation;
{$ENDIF}
    FClosed: boolean;
    FLocalAddr: TSockAddr; //for ConnectSelf
    FInfo: IOperationInfoNode;
    FWThread: IWorkerThread;
    procedure ConnectSelf;
  protected
    function accept(): ITransport;
    procedure aselect(const disp: IORBDispatcher;const cb: ITransportServerCallback);
    function get_address: IAddress;
    function bind(const addr: IAddress): Boolean;
    procedure callback(const disp: IORBDispatcher;event: TDispEvent);
    procedure listen();
    procedure block(doblock: boolean);
    procedure close();
{$IFDEF HAVE_THREADS}
    procedure create_thread();
    procedure start();
    property Operation: ITransportServerOperation read FOperation;// implements IOperation;
    function get_info(): IOperationInfoNode;
    procedure set_info(value: IOperationInfoNode);
    function get_thread(): IWorkerThread;
    procedure set_thread(value: IWorkerThread);
//    procedure start();
    procedure init_shutdown();
    procedure finalize_shutdown();
    procedure send_msg(nextOpId: TOperationKind; msg: IMsgType);
    procedure process(msg: IMsgType);
    procedure run(); virtual; //abstract;
    function copy(): IOperation; virtual; //abstract;
    procedure set_thread_pool(tp: IThreadPool);
    function get_thread_pool: IThreadPool; overload;
    function check_msg(var kt: IWorkerThread): boolean;
    function get_msg(idType: TOperationKind): IMsgType;
    procedure put_msg(nextOpId: TOperationKind; msg: IMsgType);

{$ENDIF}
  public
    constructor Create();
    destructor Destroy; override;
  end;

procedure Principal_set_peer_info(info: OctetSeq);

implementation

uses
  SysUtils, address, any, osnet, throw, except_int, exceptions, mtdebug;

{$IFDEF WIN32}
const
  SHUT_RDWR = 2; { No more receptions or transmissions. }
{$ENDIF}

threadvar
  _peer_info: OctetSeq;

//********************************************************************
// TTCPTransport
//********************************************************************
constructor TTCPTransport.Create();
begin
  inherited Create();
  FPeerAddress := TInetAddress.Create('0.0.0.0',0,STREAM);
  FState := tsClosed;
end;

constructor TTCPTransport.CreateSock(s : TSocket);
var
  err: Integer;
begin
  Create();
  FSocket := s;
  if FSocket < 0 then
    FSocket := TOSNet.CreateSocket;
  if (FSocket = -1) then
    raise COMM_FAILURE.Create(TOSNet.LastError(), MinorSocket, COMPLETED_NO);
  TOSNet.sockblock(FSocket,true);
  if TOSNet.sockndelay(FSocket,true) = -1 then begin
    err := TOSNet.GetError;
    TOSNet.sockclose(FSocket);
    FSocket := -1;
    TOSNet.SetError(err);
    raise COMM_FAILURE.Create(TOSNet.LastError(), MinorSetsockopt, COMPLETED_NO);
  end;
  FIsBlocking := True;
  FIsBuffering := False;
  FEof := FALSE;
  FState := tsOpen;
end;

destructor TTCPTransport.Destroy();
begin
  if assigned(FReadDispatcher) and Assigned(FReadCallBack) then
    begin
      FReadDispatcher.remove(self,_Read);
      FReadDispatcher := nil;
      FReadCallBack.callback(self,tcRemove);
    end;
  if assigned(FWriteDispatcher) and Assigned(FWriteCallBack) then
    begin
      FWriteDispatcher.remove(self,_Write);
      FWriteDispatcher := nil;
      FWriteCallback.callback(self,tcRemove);
    end;
  if FSocket <> -1 then
    close();
  inherited Destroy();
end;

procedure TTCPTransport.wselect(const disp: IORBDispatcher;const cb: ITransportCallback); stdcall;
begin
  if (FWriteDispatcher <> nil) and (FWriteCallback <> nil) then
    begin
      FWriteDispatcher.remove(self,orbtypes._Write);
      FWriteDispatcher := nil;
      FWriteCallback := nil;
    end;
  if cb <> nil then
    begin
      disp.socketevent(self,FSocket,orbtypes._Write);
      FWriteDispatcher := disp;
      FWriteCallback := cb;
    end;
end;

procedure TTCPTransport.rselect(const disp: IORBDispatcher;const cb: ITransportCallback); stdcall;
begin
  if (FReadDispatcher <> nil) and (FReadCallback <> nil) then
    begin
      FReadDispatcher.remove(self,orbtypes._Read);
      FReadDispatcher := nil;
      FReadCallback := nil;
    end;
  if cb <> nil then
    begin
      disp.socketevent(self,FSocket,orbtypes._Read);
      FReadDispatcher := disp;
      FReadCallback := cb;
    end;
end;

function TTCPTransport.peer(): IAddress;
var
  sa : TSockAddrIn;
  res: integer;
{$IFDEF WIN32}
  r: integer;
{$ENDIF}
{$IFDEF LINUX}
  r: cardinal;
{$ENDIF}
begin
  result := nil;
  r := sizeof(sa);
  res := getpeername(FSocket,sa,r);
  if res < 0 then
    //TOSNet.seterrno()
    //allow for peer() after disconnect ...
    //exit;
  else
    FPeerAddress.set_socketaddress(sa);
  result := FPeerAddress;
end;

procedure TTCPTransport.block(val: Boolean);
begin
  if FIsBlocking <> val then begin
    FIsBlocking := val;
    TOSNet.sockblock(FSocket,val);
  end;
end;

function TTCPTransport.isblocking: boolean;
begin
  result := FIsBlocking;
end;

procedure TTCPTransport.close(); stdcall;
var
  saveSocket: TSocket;
begin
  if FSocket >= 0 then begin
    saveSocket := FSocket;
    FSocket := -1;
    {$IFDEF WIN32}WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF}.shutdown(saveSocket, SHUT_RDWR);
    TOSNet.sockclose(saveSocket);
  end;
  if Assigned(FReadDispatcher) and Assigned(FReadCallBack) then
    FReadDispatcher.remove(self, _Read);
  if Assigned(FWriteDispatcher) and Assigned(FWriteCallBack) then
    FWriteDispatcher.remove(self, _Write);
  FIsBuffering := false;
  FIsBlocking := false;
  FReadDispatcher := nil;
  FWriteDispatcher := nil;
  FReadCallBack := nil;
  FWriteCallback := nil;
  FEOF := false;
  FState := tsClosed;
end;

procedure TTCPTransport.open(fd: Integer); stdcall;
{$IFDEF MSWINDOWS}
var
  bufsz: integer;
{$ENDIF}
begin
  Assert(FState = tsClosed);
  if fd < 0 then
    fd := socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  if (fd = -1) then
    dorb_throw(st_COMM_FAILURE, MinorSocket, COMPLETED_NO);
  if (TOSNet.sockndelay(fd,true) = -1) then begin
    TOSNet.sockclose(fd);
    dorb_throw(st_COMM_FAILURE, MinorSetsockopt, COMPLETED_NO);
  end;
  //TOSNet.sockblock(FSocket,true);
{$IFDEF MSWINDOWS}
  // Set a larger send buffer size to avoid a performance problem
  // on Win32.
  //
  // TODO: This is a total hack!
  // Thanks guys from OOC
  bufsz := 64 * 1024; // 64K
  if (setsockopt(fd, SOL_SOCKET, SO_SNDBUF, PAnsiChar(@bufsz), sizeof(integer)) = -1) then begin
    TOSNet.sockclose(fd);
    dorb_throw(st_COMM_FAILURE, MinorSetsockopt, COMPLETED_NO);
  end;
{$ENDIF}
  FSocket := fd;
{$IFDEF MSWINDOWS}
  FIsBlocking := False;
{$ENDIF}
{$IFDEF LINUX}
  FIsBlocking := True;
{$ENDIF}
  FIsBuffering := False;
  FEof := False;
  FState := tsOpen;
end;

function TTCPTransport.connect(const addr: IAddress): Boolean; stdcall;
const
{$IFDEF MSWINDOWS}
  NilSockAddr: TSockAddrIn = (sin_family: 0; sa_data: (#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0));
{$ENDIF}
{$IFDEF LINUX}
  NilSockAddr: TSockAddrIn = (sin_family: 0; sa_data: (0,0,0,0,0,0,0,0,0,0,0,0,0,0));
{$ENDIF}
var
  sa : TSockAddrIn;
  r : longint;
begin
  sa := addr.socketaddress();
  if CompareMem(@sa, @NilSockAddr, SizeOf(NilSockAddr)) then
    raise COMM_FAILURE.Create(TOSNet.LastError, MinorConnect);
  result := false;
  while true do begin
{$IFDEF MSWINDOWS}
    r := WinSock.connect(FSocket, sa, sizeof (sa));
{$ENDIF}
{$IFDEF LINUX}
    r := Libc.connect(FSocket, @sa, sizeof (TSockAddr));
{$ENDIF}
    result := r >= 0;
    if not result then begin
      if TOSNet.IsInterrupted then
        Continue;

      if TOSNet.ConnectFailed() then
        raise TRANSIENT.Create(TOSNet.LastError, MinorConnectFailed)
      else
        raise COMM_FAILURE.Create(TOSNet.LastError, MinorConnect);
    end
    else
      Break;
  end;
end;

function TTCPTransport.write(const buffer; size: _ulong): integer;  stdcall;
var
  written : longint;
  temp : Pointer;
  sizeOfPacket: _ulong;
  bl: boolean;
begin
  result := 0;
  temp := @buffer;
  sizeOfPacket := size;
  bl := isblocking;
  try
    while size > 0 do begin
      written := TOSNet.sockwrite(FSocket, temp^, sizeOfPacket);
      if written <= 0 then begin
        if written = 0 then
          raise COMM_FAILURE.Create(MinorSendZero, COMPLETED_NO)
        else begin
          if TOSNet.NoBufs and (size > 1024) then begin
            sizeOfPacket := sizeOfPacket div 2;
            Continue;
          end;
          if TOSNet.IsInterrupted then
            Continue;
          if (FSocket = -1) and TOSNet.ConnectionDown then begin
            result := -1;
            Break;
          end;
          if TOSNet.WouldBlock then begin
            block(true);
            Continue;
          end;
          raise COMM_FAILURE.Create(TOSNet.LastError(), MinorSend, COMPLETED_NO);
        end;
      end
      else begin
        inc(result,written);
        temp := Pointer(Longint(@buffer)+result);
        dec(size,written);
        if size < sizeOfPacket then
          sizeOfPacket := size;
      end;
    end;
  finally
    block(bl);
  end; { try/finally }
end;

function TTCPTransport.eof(): Boolean; stdcall;
begin
  result := FEOF;
end;

function TTCPTransport.bad(): Boolean; stdcall;
begin
  result := false;
end;

procedure TTCPTransport.callback(const disp: IORBDispatcher;event: TDispEvent);
begin
  case event of
    orbtypes._Read : FReadCallback.callback(self,orbtypes.tcRead);
    orbtypes._Write : FWriteCallback.callback(self,orbtypes.tcWrite);
    orbtypes._Remove : begin
        FReadCallback := nil;
        FWriteCallback := nil;
        FReadDispatcher := nil;
        FWriteDispatcher := nil;
      end;
    orbtypes._Moved : begin
        FWriteDispatcher := disp;
        FReadDispatcher := disp;
      end;
    else
      assert(false,'not implemented');
  end;
end;

function TTCPTransport.read(var buffer; size: _ulong): integer; stdcall;
var
  r,todo : longint;
  buf : Pointer;
  sizeOfPacket: Integer;
begin
  todo := size;
  buf := @buffer;
  sizeOfPacket := todo;
  while todo > 0 do begin
    r := TOSNet.sockread(FSocket, buf^, sizeOfPacket);
    if r = SOCKET_ERROR then begin
      if TOSNet.NoBufs and (size > 1024) then begin
        sizeOfPacket := sizeOfPacket div 2;
        Continue;
      end;
      if TOSNet.IsInterrupted then
        Continue;
      if (FSocket = -1) or TOSNet.ConnectionDown then begin
        result := -1;
        Exit;
      end;
      if TOSNet.WouldBlock and not isblocking then begin
        //result := 0;
        Break;
      end
      else begin
        block(true);
        Continue;
      end;
      raise COMM_FAILURE.Create(TOSNet.LastError(), MinorRecv, COMPLETED_NO);
    end
    else if r = 0 then begin
      FEOF := true;
      Break;
    end
    else begin
      dec(todo,r);
      buf := Pointer(Integer(buf)+ r);
      if todo < sizeOfPacket then
        sizeOfPacket := todo;
    end;
  end;
  result := longint(size) - todo;
end;

function TTCPTransport.bufread(buf: IBuffer; size: _ulong): integer; stdcall;
var
  i : integer;
begin
  buf.resize(size);
  i := read(Pointer(_ulong(buf._buffer) + buf.WPosition)^, size);
  if i > 0 then
    buf.WseekFromCurrent(i);
  result := i;
end;

function TTCPTransport.bufwrite(buf: IBuffer; size: _ulong; eat: boolean): integer; stdcall;
begin
  Assert(size <= buf.length());
  result := write(Pointer(_ulong(buf._buffer) + buf.RPosition)^, size);
  if (result > 0) and eat then
    buf.RseekFromCurrent(result);
  //buf.RseekFromBegin(0);
  //FTransport.write(buf.Data^,buf.Length);
end;

function TTCPTransport.get_principal: IPrincipal;
begin
  result := TPrincipal.Create(self);
end;

function TTCPTransport.get_address: IAddress;
var
  sa : TSockAddrIn;
  r : longint;
{$IFDEF WIN32}
  len: integer;
{$ENDIF}
{$IFDEF LINUX}
  len: cardinal;
{$ENDIF}
begin
  result := nil;
  len := SizeOf(sa);
  r := {$IFDEF WIN32}WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF}.getsockname(FSocket,sa,len);
  if r < 0 then exit;
  FLocalAddress.set_socketaddress(sa);
  result := FLocalAddress;
end;

//********************************************************************
// TTCPTransportServer
//********************************************************************
constructor TTCPTransportServer.Create();
begin
  FLocalAddress := TInetAddress.Create('0.0.0.0',0,STREAM);
  FSocket := TOSNet.CreateSocket;
  if (FSocket = -1) then
    raise COMM_FAILURE.Create(TOSNet.LastError(), MinorSocket, COMPLETED_NO);
  TOSNet.sockreuse(FSocket,True);
  FIsBlocking := true;
  FListening := false;
  FDisp := nil;
  FCb := nil;
{$IFDEF HAVE_THREADS}
  FOperation := TTransportServerOperationImpl.Create(Self);
{$ENDIF}
end;

destructor TTCPTransportServer.Destroy;
var
  saveSocket: TSocket;
begin
  saveSocket := FSocket;
  FSocket := -1;
  {$IFDEF WIN32}WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF}.shutdown(saveSocket, SHUT_RDWR);
  TOSNet.sockclose(saveSocket);
  inherited;
end;

function TTCPTransportServer.accept(): ITransport;
var
  sock : TSocket;
  addr: sockaddr_in;
{$IFDEF MSWINDOWS}
  addrlen: integer;
{$ENDIF}
{$IFDEF LINUX}
  addrlen: socklen_t;
{$ENDIF}
begin
  listen();
  addrlen := SizeOf(sockaddr_in);
  sock := -1;
  while true do begin
    sock := {$IFDEF MSWINDOWS}WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF}.accept(FSocket, @addr, @addrlen);
    if sock <> -1 then begin
      if FClosed then begin
        //stop server
        TOSNet.sockclose(sock);
        Exit;
      end
      else
        Break;
    end;
    // Here we have special handling for this case, since
    // accept can generate other loop-and-retry errors on some
    // platforms.
    if TOSNet.AcceptRetry then begin
      if FClosed then
        Exit
      else
        Continue;
    end;
    if TOSNet.WouldBlock then begin
      block(true);
      Continue;
    end;
    raise COMM_FAILURE.Create(TOSNet.LastError(), MinorAccept, COMPLETED_NO);
  end;
{$IFDEF LINUX}
{$ENDIF}
  if sock >= 0 then begin
    result := TTCPTransport.Create();
    result.open(sock);
  end;
end;

procedure TTCPTransportServer.callback(const disp: IORBDispatcher;event: TDispEvent);
begin
  case event of
    _Read:
       fcb.ts_callback(self,orbtypes.tsAccept);
    _Remove: begin
        FDisp := nil;
        FCb := nil;
      end;
    _Moved: FDisp := disp;
    else
      assert(false,'not implemented');
  end;
end;

procedure TTCPTransportServer.listen();
var
  res, err: Integer;
begin
  if not FListening then begin
    res := -1;
    while true do begin
      res := {$IFDEF WIN32}WinSock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF}.listen(FSocket,10);
      if res <> -1 then
        Break;
      if TOSNet.IsInterrupted then
        Continue;
      err := TOSNet.GetError;
      TOSNet.sockclose(FSocket);
      FSocket := -1;
      TOSNet.SetError(err);
      raise COMM_FAILURE.Create(TOSNet.LastError(), MinorListen, COMPLETED_NO);
    end;
    if res = 0 then FListening := true;
  end;
end;

procedure TTCPTransportServer.block(doblock: boolean);
begin
  if doblock <> FIsBlocking then begin
    FIsBlocking := doblock;
    TOSNet.sockblock(FSocket, doblock);
  end;
end;

procedure TTCPTransportServer.close;
begin
{$IFDEF HAVE_THREADS}
  if FOperation <> nil then
    FOperation.init_shutdown();
{$ENDIF}
  FClosed := True;
  ConnectSelf;
  FIsBlocking := false;
  FListening := false;
{$IFDEF HAVE_THREADS}
  if FOperation <> nil then
    FOperation.finalize_shutdown();
{$ENDIF}
end;

procedure TTCPTransportServer.aselect(const disp: IORBDispatcher;
  const cb: ITransportServerCallback);
{var
  op: IOperation;}
begin
  if (FDisp <> nil) and (FCb <> nil) then
    begin
      FDisp.remove(self,orbtypes._Read);
      FDisp := nil;
      FCb := nil;
      //FOperationObj.FCb := nil;
      //FOperationObj.FTranServ := nil;
      //-------
      //op := Self as IOperation;
      //FOperation.init_shutdown();
      //sockclose(FSocket);
      //close();
      //FOperation.finalize_shutdown();
      //-------
    end;
  if cb <> nil then
    begin
      listen();
      disp.socketevent(self,FSocket,orbtypes._Read);
      FDisp := disp;
      FCb := cb;
      //FOperationObj.FCb := FCb;
      FOperation.set_server_callback(FCb);
    end;
end;

function TTCPTransportServer.bind(const addr: IAddress): Boolean;
var
  sa : TSockAddrIn;
  r : longint;
  err: Integer;
{$IFDEF MSWINDOWS}
  len: Integer;
{$ENDIF}
{$IFDEF LINUX}
  len: socklen_t;
{$ENDIF}
begin
  sa := addr.socketaddress();
  {$IFDEF WIN32}
  r := WinSock.bind(FSocket, sa, sizeof (sa));
  {$ENDIF}
  {$IFDEF LINUX}
  r := Libc.bind(FSocket, sa, sizeof (sa));
  {$ENDIF}
  result :=  r >= 0;
  if not result then begin
    err := TOSNet.GetError;
    TOSNet.sockclose(FSocket);
    FSocket := -1;
    TOSNet.SetError(err);
    raise COMM_FAILURE.Create(TOSNet.LastError(), MinorBind, COMPLETED_NO);
  end;
  // Read back the port. This is needed if the port was selected by
  // the operating system.
  len := SizeOf(sa);
  getsockname(FSocket, sa, len);
  // Get the local address for use by ConnectSelf
  FLocalAddr.sin_family := AF_INET;
  FLocalAddr.sin_port := sa.sin_port;
  if sa.sin_addr.S_addr = INADDR_ANY then
    FLocalAddr.sin_addr.S_addr := htonl(INADDR_LOOPBACK)
  else
    TOSNet.GetInAddr((addr as IInetAddress).Host, FLocalAddr);
end;

function TTCPTransportServer.get_address: IAddress;
var
  sa : TSockAddrIn;
  r : longint;
{$IFDEF WIN32}
  len: integer;
{$ENDIF}
{$IFDEF LINUX}
  len: cardinal;
{$ENDIF}
begin
  result := nil;
  len := SizeOf(sa);
  r := {$IFDEF WIN32}WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF}.getsockname(FSocket,sa,len);
  if r < 0 then exit;
  FLocalAddress.set_socketaddress(sa);
  result := FLocalAddress;
end;

procedure TTCPTransportServer.ConnectSelf;
var
  fd: TSocket;
  err: Integer;
begin
  // Create socket
  fd := TOSNet.CreateSocket;
  if (fd = -1) then
    raise COMM_FAILURE.Create(TOSNet.LastError(), MinorSocket, COMPLETED_NO);

  // Set TCP_NODELAY option
  if TOSNet.sockndelay(fd, True) = -1 then begin
    err := TOSNet.GetError();
    TOSNet.sockclose(fd);
    TOSNet.SetError(err);
    raise COMM_FAILURE.Create(TOSNet.LastError(), MinorSetsockopt, COMPLETED_NO);
  end;

  // Connect to local address
  while True do begin
    if Connect(fd, FLocalAddr, SizeOf(FLocalAddr)) = -1 then begin
      if TOSNet.IsInterrupted then
        Continue;

      err := TOSNet.GetError();
      TOSNet.sockclose(fd);
      TOSNet.SetError(err);
      if TOSNet.ConnectFailed() then
        raise TRANSIENT.Create(TOSNet.LastError, MinorConnectFailed)
      else
        raise COMM_FAILURE.Create(TOSNet.LastError, MinorConnect);
    end;
    Break;
  end;
  TOSNet.sockclose(fd);
end;

{$IFDEF HAVE_THREADS}
procedure TTCPTransportServer.create_thread;
var
  kt: IWorkerThread;
begin
  // create a new thread
  // there is no limit on how much TransportServer we can have
  // each on runs in its own thread !!
  kt := TMTManager.ThreadPoolManager().get_thread_pool(odAccept).get_idle_thread();
  kt.register_operation(FOperation as IOperation);
  kt.mark_busy();
end;

procedure TTCPTransportServer.start;
begin
  FOperation.get_thread().post_state_change();
end;
{$ENDIF}

//*********************************************************************
//  TPrincipal
//*********************************************************************
constructor TPrincipal.Create(transp: ITransport);
begin
  FInfo := Copy(_peer_info);
  FTransport := transp;
end;

class procedure TPrincipal.set_peer_info(info: OctetSeq);
begin
  _peer_info := copy(info);
end;

function TPrincipal.decode(const dec: IDecoder): Boolean;
var
  u : _ulong;
begin
  result := false;
  if not dec.seq_begin(u) then exit;
  setLength(FInfo,u);
  if u > 0 then
    begin
      if dec._buffer.length < u then exit;
      dec.get_octets(Pointer(FInfo)^,u);
    end;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TPrincipal.encode(const enc: IEncoder);
begin
  enc.seq_begin(Length(FInfo));
  if Length(FInfo) > 0 then
    enc.put_octets(Pointer(FInfo)^,Length(FInfo));
  enc.seq_end;
end;

function TPrincipal.get_property(const prop_name: string): IAny;
begin
  result := CreateAny();
  if CompareStr(prop_name, 'peer-info') = 0 then begin
    //result.set_
  end
  else if CompareStr(prop_name, 'auth-method') = 0 then
    result.put_string('basic')
  else if CompareStr(prop_name, 'local-address') = 0 then
    result.put_string(AnsiString(FTransport.get_address.toString))
  else if CompareStr(prop_name, 'peer-address') = 0 then
    result.put_string(AnsiString(FTransport.peer.toString));
end;

procedure Principal_set_peer_info(info: OctetSeq);
begin
  TPrincipal.set_peer_info(info)
end;

{ TTransportServerOperationImpl }
procedure TTransportServerOperationImpl.run;
begin
  while FCb <> nil do
    FCb.ts_callback(FTranServ, tsAccept);
end;

constructor TTransportServerOperationImpl.Create(const ATranServ: ITransportServer);
begin
  inherited Create();
  FTranServ := ATranServ;
end;

function TTransportServerOperationImpl.copy: IOperation;
begin

end;

procedure TTransportServerOperationImpl.init_shutdown;
begin
  FCb := nil;
  FTranServ := nil;
end;

procedure TTransportServerOperationImpl.set_server_callback(const AServCallback: ITransportServerCallback);
begin
  FCb := AServCallback;
end;
{$ENDIF}

{COPIED FROM mtmanager.pas}
procedure TTCPTransportServer.set_info(value: IOperationInfoNode);
begin
  FInfo := value;
end;

function TTCPTransportServer.get_info():IOperationInfoNode;
begin
  result := FInfo;
end;

procedure TTCPTransportServer.set_thread(value: IWorkerThread);
begin
  FWThread := value;
end;

function TTCPTransportServer.get_thread(): IWorkerThread;
begin
  result := FWThread;
end;

procedure TTCPTransportServer.init_shutdown;
begin

end;

procedure TTCPTransportServer.finalize_shutdown;
begin
  // make sure the thread has left the context of
  // this OP, deregisterOP will take care of that !
  if FWThread <> nil then FWThread.deregister_operation(Self as IOperation);
end;

procedure TTCPTransportServer.send_msg(nextOpId: TOperationKind; msg: IMsgType);
begin
  FInfo.get_nextOP().put_msg(nextOpId, msg);
end;

procedure TTCPTransportServer.process(msg: IMsgType);
begin
  Assert(false, 'Implementation error - this should never happen');
end;

procedure TTCPTransportServer.put_msg(nextOpId: TOperationKind; msg: IMsgType);
begin
  Assert(false, 'not implemented');
end;

procedure TTCPTransportServer.set_thread_pool(tp: IThreadPool);
begin
  FTp := tp;
end;

function TTCPTransportServer.get_thread_pool(): IThreadPool;
begin
  result := FTp;
end;

function TTCPTransportServer.check_msg(var kt: IWorkerThread): boolean;
begin
  result := false;
end;

function TTCPTransportServer.get_msg(idType: TOperationKind): IMsgType;
begin
  Assert(false, 'Not implemented');
  result := nil;
end;

procedure TTCPTransportServer.run;
begin
//TODO:
//add implementation
end;

function TTCPTransportServer.copy : IOperation;
begin
//TODO:
//create implementation
    Result := TTCPTransportServer.Create;
end;
{COPIED FROM mtmanager.pas}

{$IFDEF HAVE_THREADS}
{$IFDEF LIBRARY}
exports
  Principal_set_peer_info;
{$ENDIF}
{$ELSE}
procedure Principal_set_peer_info(info: OctetSeq); external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
