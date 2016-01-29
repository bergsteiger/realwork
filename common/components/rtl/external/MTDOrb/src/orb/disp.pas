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
unit disp;

interface

{$I dorb.inc}

{$IFNDEF USELIB}

uses
  orbtypes,orb_int,orb,{$IFDEF WIN32}WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF},
  Classes,disp_int,SysUtils,osthread;

type
{$IFDEF WIN32}
  TSocketPair = packed array[0..1] of TSocket;
{$ENDIF}
  TSelectDispatcher = class(TInterfacedObject,ISelectDispatcher,IORBDispatcher)
  private
    {**  list of event records }
    FEventList : TList;
    FEventListMutex: TMutex;
    FLocks: integer;
    FModified : Boolean;
    FIntRead,
    FIntWrite: TSocket;
    FPendingRead,
    FInBlockingSelect,
    FInterrupt: boolean;
  private
    procedure createFdPair(var fds: TSocketPair);
    procedure clearInterruptFd();
    procedure setInterruptFd();
    function IsInterrupted(): boolean;
  protected
    procedure run(infinite: Boolean);
    procedure handle_fevents(rset,wset,xset: TFDSet);
    procedure update_fevents(var rset,wset,xset: TFDSet; var nfds: integer);
    procedure interrupt_dispatch();
    function dispatch_one_event(const timeout: long): boolean;
    procedure socketevent(const cb: IORBDispCallback; fd: TSocket;evt: TDispEvent);
    procedure timeevent(const cb: IORBDispCallback; timeout: longint);
    procedure move(const disp: IORBDispatcher);
    procedure remove(const cb: IORBDispCallback;evt: TDispEvent);
    function idle(): Boolean;
    procedure block(b: boolean);
    function isblocking: boolean;
  public
    constructor CreateEx();
    destructor Destroy(); override;
  end;

  PFileEvent = ^TFileEvent;
  TFileEvent = record
    EventType: TDispEvent;
    Desc : TSocket;
    Cb : IORBDispCallBack;
    Deleted : Boolean;
  end;


implementation

uses throw, except_int;

var
  selectDispatcherIsBlocking: boolean;

//**************************************************************
//  TSelectDispatcher
//**************************************************************
constructor TSelectDispatcher.CreateEx();
var
  fds: TSocketPair;
{$IFDEF WIN32}
  arg: integer;
{$ENDIF}
begin
  inherited Create();
  FLocks := 0;
  FModified := false;
  FEventList := TList.Create;
  FEventListMutex := TMutex.Create();
  FPendingRead := false;
  FInBlockingSelect := false;
  FInterrupt := false;
  CreateFdPair(fds);
  FIntRead := fds[0];
  // Set the fd to be non-blocking 
{$IFDEF WIN32}
  arg := 1;
  ioctlsocket(FIntRead, FIONBIO, arg);
{$ENDIF}
{$IFDEF LINUX}
  fcntl(FIntRead, F_SETFL, O_NONBLOCK);
{$ENDIF}
  FIntWrite := fds[1];
end;

destructor TSelectDispatcher.Destroy;
var
  i : integer;
begin
  for i := 0 to Pred(FEventList.count) do
    begin
      PFileEvent(FEventList[i])^.Cb := nil;
      FreeMem(PFileEvent(FEventList[i]));
    end;
  FreeAndNil(FEventList);
  FreeAndNil(FEventListMutex);
{$IFDEF WIN32}
  closesocket(FIntWrite);
  closesocket(FIntRead);
{$ENDIF}
{$IFDEF LINUX}
  __close(FIntWrite);
  __close(FIntRead);
{$ENDIF}
  inherited Destroy();
end;

{**
  Selects state of specified sockets and call handle_fevents
  on success.
**}
procedure TSelectDispatcher.run(infinite: Boolean);
var
  rset,wset,xset : TFDSet;
  res : longint;
  nfds: integer;
begin
  while true do
    begin
      // The filedescriptor sets parameter for select()
      update_fevents(rset, wset, xset, nfds);

      FInBlockingSelect := true;
      res := select(nfds, @rset, nil, nil, nil);
      FInBlockingSelect := false;
      if res = -1 then begin
        if IsInterrupted() then Continue;
      end;
      // Evaluate file descriptor sets if not interrupted
      if (res > 0) and not FInterrupt then
        handle_fevents(rset,wset,xset);
      if not infinite then break;
    end;
end;

procedure TSelectDispatcher.remove(const cb: IORBDispCallback;evt: TDispEvent);
var
  i : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FEventListMutex);
  setInterruptFd();
  for i := Pred(FEventList.Count) downto 0 do
    if ((PFileEvent(FEventList[i])^.EventType = evt) or (evt = _All)) and (PFileEvent(FEventList[i])^.cb = cb) then begin
      PFileEvent(FEventList[i])^.Cb := nil;
      FreeMem(PFileEvent(FEventList[i]));
      FEventList.Delete(i);
    end;
end;

procedure TSelectDispatcher.socketevent(const cb: IORBDispCallback; fd: TSocket; evt: TDispEvent);
var
  event : PFileEvent;
  sync: ISynchronized;
begin
  event := AllocMem(sizeof(TFileEvent));
  event^.EventType := evt;
  event^.Desc := fd;
  event^.cb := cb;
  event^.deleted := false;
  
  sync := TSynchronized.Create(FEventListMutex);
  setInterruptFd();
  FEventList.add(event);
end;


function TSelectDispatcher.idle: Boolean;
var
  rset,wset,xset : TFDSet;
  res : longint;
  nfds: integer;
  time : TimeVal;
begin
  result := false;
  if FEventList.Count > 0 then begin
    // The filedescriptor sets parameter for select()
    update_fevents(rset, wset, xset, nfds);
    time.tv_sec := 0;
    time.tv_usec := 0;
    res := select(nfds, @rset, @wset, @xset, @time);
    if res > 0 then  exit;
  end;
  result := true;
end;

procedure TSelectDispatcher.move(const disp: IORBDispatcher);
var
  sync: ISynchronized;
  i : integer;
begin
  sync := TSynchronized.Create(FEventListMutex);
  for i := 0 to Pred(FEventList.Count) do
    with PFileEvent(FEventList[i])^ do
      if not deleted then begin
        Cb.callback(disp,_Moved);
        disp.socketevent(Cb,Desc,EventType);
      end;
  for i := 0 to Pred(FEventList.count) do begin
    PFileEvent(FEventList[i])^.Cb := nil;
    FreeMem(PFileEvent(FEventList[i]));
  end;
end;

procedure TSelectDispatcher.timeevent(const cb: IORBDispCallback;
  timeout: longint);
begin
  assert(false,'not implemented');
end;

procedure TSelectDispatcher.update_fevents(var rset,wset,xset: TFDSet; var nfds: integer);
var
  i : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FEventListMutex);

  FModified := true;
  FD_ZERO(rset);
  FD_ZERO(wset);
  FD_ZERO(xset);

  nfds := FIntRead + 1;

  // Clear any pending interrupts
  clearInterruptFd();
  // Add the interrupt read file descriptor
  FD_SET(FIntRead, rset);

  // Add all event handlers
  for i := 0 to Pred(FEventList.Count) do
    with PFileEvent(FEventList[i])^ do
      if not deleted then begin
        case EventType of
          _Read: FD_SET(Desc,rset);
          _Write: FD_SET(Desc,wset);
          _Except: FD_SET(Desc,xset);
          else
            assert(false,'not implemented');
        end;
        if Desc >= nfds then
          nfds := Desc + 1;
      end;
end;

{**
  Passes trough event list and executes callback procedures for
  specified sockets
**}
procedure TSelectDispatcher.handle_fevents(rset,wset,xset: TFDSet);
var
  i : integer;
  sync: ISynchronized;
  tmpEventList: TList;
  event : PFileEvent;
begin
  // Work on a partial copy of FEventList, so that other
  // threads can register or unregister event handler while this
  // operation is running. This also ensures that the event handler
  // is not released while handle_fEvents() is executing.
  tmpEventList := TList.Create;
  try
    // SYNCHRONIZED
    sync := TSynchronized.Create(FEventListMutex);
    for i := 0 to FEventList.count-1 do
      if not PFileEvent(FEventList[i])^.Deleted then begin
        event := AllocMem(sizeof(TFileEvent));
        TFileEvent(event^) := TFileEvent(PFileEvent(FEventList[i])^);
        tmpEventList.Add(event);
      end;
    sync := nil;

    for i := 0 to tmpEventList.count-1 do
      with PFileEvent(tmpEventList[i])^ do
        case EventType of
          _Read : if FD_ISSET(Desc,rset) then begin
            CB.callback(self,_Read);
          end;
          _Write : if FD_ISSET(Desc,wset) then
            CB.callback(self,_Write);
          _Except : if FD_ISSET(Desc,xset) then
            CB.callback(self,_Except);
          else
            assert(false,'not implemented');
        end;
  finally
    for i := 0 to tmpEventList.count-1 do begin
      PFileEvent(tmpEventList[i])^.Cb := nil;
      FreeMem(PFileEvent(tmpEventList[i]), sizeof(TFileEvent));
    end;
    FreeAndNil(tmpEventList);
  end; { try/finally }
end;

procedure TSelectDispatcher.block(b: boolean);
begin
  selectDispatcherIsBlocking := b;
end;

function TSelectDispatcher.isblocking: boolean;
begin
  result := selectDispatcherIsBlocking;
end;

procedure TSelectDispatcher.createFdPair(var fds: TSocketPair);
{$IFDEF WIN32}
var
  s: TSocket;
  no, len, res: integer;
  addr: TSockAddrIn;

  function CreateSocket(): TSocket;
  begin
    result := socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  end;
{$ENDIF}
begin
{$IFDEF WIN32}
  s := -1; fds[0] := -1; fds[1] := -1;
  try
    // Create a server socket
    s := CreateSocket();
    if s = -1 then
      dorb_throw(st_COMM_FAILURE, MinorSocket, COMPLETED_NO);
    // Set TCP_NODELAY option
    no := 1;
    if setsockopt(s, IPPROTO_TCP, TCP_NODELAY, PAnsiChar(@no), SizeOf(no)) = -1 then
      dorb_throw(st_COMM_FAILURE, MinorSetsockopt, COMPLETED_NO);
    // Get the address
    FillChar(addr, SizeOf(TSockAddrIn), 0);
    with addr do begin
      sin_family := AF_INET;
      sin_addr.s_addr := inet_addr('127.0.0.1');
      sin_port := 0;
    end; { with }
    // Bind
    if bind(s, addr, sizeof(addr)) = -1 then
      dorb_throw(st_COMM_FAILURE, MinorBind, COMPLETED_NO);
    // Listen on socket
    if listen(s, 1) = -1 then
      dorb_throw(st_COMM_FAILURE, MinorListen, COMPLETED_NO);
    // Find out the port to which this socket is connected to
    len := SizeOf(addr);
    res := getsockname(s, addr, len);
    assert(res <> -1);
    // Create the client socket
    fds[0] := CreateSocket();
    if fds[0] = -1 then
      dorb_throw(st_COMM_FAILURE, MinorSocket, COMPLETED_NO);
    // Set TCP_NODELAY option
    no := 1;
    if setsockopt(fds[0], IPPROTO_TCP, TCP_NODELAY, PAnsiChar(@no), SizeOf(no)) = -1 then
      dorb_throw(st_COMM_FAILURE, MinorSetsockopt, COMPLETED_NO);
    // Connect to the server socket
    if connect(fds[0], addr, sizeof(addr)) = -1 then
      dorb_throw(st_COMM_FAILURE, MinorConnect, COMPLETED_NO);
    // Accept the connection
    FillChar(addr, SizeOf(TSockAddrIn), 0);
    repeat
      len := SizeOf(addr);
      fds[1] := accept(s, @addr, @len);
      if fds[1] = -1 then begin
        if IsInterrupted() then
          continue;

        dorb_throw(st_COMM_FAILURE, MinorAccept, COMPLETED_NO);
      end;
    until fds[1] <> -1;
    // Set TCP_NODELAY option
    no := 1;
    if setsockopt(fds[1], IPPROTO_TCP, TCP_NODELAY, PAnsiChar(@no), SizeOf(no)) = -1 then
      dorb_throw(st_COMM_FAILURE, MinorSetsockopt, COMPLETED_NO);
  except
    if s <> -1 then closesocket(s);
    if fds[0] <> -1 then closesocket(fds[0]);
    if fds[1] <> -1 then closesocket(fds[1]);
    raise;
  end; { try/except }
  closesocket(s);
{$ENDIF}
{$IFDEF LINUX}
  if pipe(@fds) <> 0 then
    dorb_throw(st_COMM_FAILURE, MinorPipe, COMPLETED_NO);
{$ENDIF}
end;

procedure TSelectDispatcher.clearInterruptFd;
var
  c: char;
begin
  if FPendingRead then begin
    // This should be set to false before reading the data
    FPendingRead := false;
    // Read all the data off the read fd, Note under UNIX
    // since a pipe is used recv cannot be used.
{$IFDEF MSWINDOWS}
    while recv(FIntRead, c, 1, 0) = 1 do;
{$ELSE}
    while __read(FIntRead, c, 1) = 1 do;
{$ENDIF}
  end;
end;

procedure TSelectDispatcher.setInterruptFd;
var
  c: char;
begin
  // Only set the interrupt file descriptor if the reactor is in a
  // blocking select call.
  if FInBlockingSelect then begin
    // Write one byte down the interrupt fd. Note under UNIX since
    // a pipe is used send cannot be used.
    c := chr(0);
{$IFDEF MSWINDOWS}
    send(FIntWrite, c, 1, 0);
{$ELSE}
    __write(FIntWrite, c, 1);
{$ENDIF}
    // The FPendingRead flag should be set to true after writing
    // the data
    FPendingRead := true;
  end;
end;

procedure TSelectDispatcher.interrupt_dispatch;
begin
  // Don't interrupt twice
  if FInterrupt then Exit;
  // Set the interrupt flag
  FInterrupt := true;
  setInterruptFd();
end;

function TSelectDispatcher.IsInterrupted: boolean;
begin
{$IFDEF WIN32}
  result := WSAGetLastError() = WSAEINTR;
{$ENDIF}
{$IFDEF LINUX}
  result := errno() = EINTR;
{$ENDIF}
end;

function TSelectDispatcher.dispatch_one_event(
  const timeout: long): boolean;
var
  rset,wset,xset : TFDSet;
  nfds, res: integer;
  tout: TTimeVal;
begin
  // The filedescriptor sets and the nfds parameter for select()
  update_fevents(rset, wset, xset, nfds);

  // Do select
  while true do begin
      if timeout >= 0 then begin
        tout.tv_sec := timeout div 1000;
        tout.tv_usec := (timeout - tout.tv_sec * 1000) * 1000;
        FInBlockingSelect := true;
        res := select(nfds, @rset, @wset, nil, @tout);
        FInBlockingSelect := false;
      end
      else
        res := select(nfds, @rset, @wset, nil, nil);

      if (res = 0) then begin
        Assert(timeout >= 0);
        result := false;
        Exit;
      end;

      // Select error?
      if (res = -1) then begin
        // If select was interrupted as a result of a signal then
        // continue
        if IsInterrupted() then
          Continue;

        dorb_throw(st_COMM_FAILURE, MinorSelect, COMPLETED_NO);
      end;

      Break;
  end;

  // Evaluate file descriptor sets
  handle_fevents(rset, wset, xset);
  result := true;
end;

initialization
{$IFDEF HAVE_THREADS}
selectDispatcherIsBlocking := false;
{$ELSE}
selectDispatcherIsBlocking := false;
{$ENDIF}

{$ELSE}
implementation
{$ENDIF}  
end.
