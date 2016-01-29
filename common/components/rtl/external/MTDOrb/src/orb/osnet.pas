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
unit osnet;

interface

{$I dorb.inc}

uses SysUtils, orbtypes, {$IFDEF MSWINDOWS}WinSock, Windows{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF};

{$DEFINE TCP_NODELAY}

const
  MT_GETHOSTBYNAME_RETRY = 3;

type
  TOSNet = class(TObject)
  public
    class procedure sockinit();
    class procedure sockfinal();
    //class procedure seterrno();
    class function CreateSocket(): TSocket;
    class procedure sockblock(s: TSocket; val: Boolean);
    class function sockndelay(s: TSocket; val: Boolean): integer;
    class function sockclose(s: TSocket): long;
    class function sockwrite(s: TSocket; var Buffer; len: _ulong): integer;
    class function sockread(s: TSocket; var Buffer; len: _ulong): integer;
    class procedure sockreuse(s: TSocket; val: Boolean);
    class function GetError(): integer;
    class procedure SetError(err: integer);
    class function ConnectFailed(): boolean;
    class function ConnectionDown(): boolean;
    class function WouldBlock(): boolean;
    class function LastError(): string;
    class function NoBufs(): boolean;
    class function IsInterrupted(): boolean;
    class function AcceptRetry(): boolean;
    class procedure GetInAddr(const host: AnsiString; var addr: TSockAddr);
  end;

implementation

uses throw, except_int, osthread, exceptions, mtdebug;

{ TOSNet }

class function TOSNet.AcceptRetry: boolean;
begin
{$IFDEF MSWINDOWS}
  result := (GetError() = WSAEINTR);
{$ENDIF}
{$IFDEF LINUX}
  result := false;
  case GetError() of
    EINTR
{$IFDEF EPROTO}
    , EPROTO
{$ENDIF}
{$IFDEF ECONNABORTED}
    , ECONNABORTED
{$ENDIF}
{$IFDEF ECONNRESET}
    , ECONNRESET
{$ENDIF}
{$IFDEF ETIMEDOUT}
    , ETIMEDOUT:
{$ENDIF}
    : result := true;
  end;
{$ENDIF}
end;

class function TOSNet.ConnectFailed: boolean;
begin
{$IFDEF MSWINDOWS}
  result := (GetError() = WSAECONNREFUSED) or
            (GetError() = WSAETIMEDOUT) or
            (GetError() = WSAENETUNREACH) or
            ConnectionDown();
{$ENDIF}
{$IFDEF LINUX}
  result := (GetError() = ECONNREFUSED) or
            (GetError() = ETIMEDOUT) or
            (GetError() = ENETUNREACH) or
            ConnectionDown();
{$ENDIF}
end;

class function TOSNet.ConnectionDown: boolean;
begin
{$IFDEF MSWINDOWS}
  result := (GetError() = WSAECONNRESET) or
            (GetError() = WSAESHUTDOWN) or
            (GetError() = WSAECONNABORTED);
{$ENDIF}
{$IFDEF LINUX}
  result := (GetError() = ECONNRESET) or
            (GetError() = ESHUTDOWN) or
            (GetError() = ECONNABORTED) or
            (GetError() = EPIPE) or
            (GetError() = EINVAL);
{$ENDIF}
end;

class function TOSNet.CreateSocket: TSocket;
begin
  result := socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
end;

class function TOSNet.GetError: integer;
begin
{$IFDEF MSWINDOWS}
  result := WSAGetLastError();
{$ENDIF}
{$IFDEF LINUX}
  result := errno();
{$ENDIF}
end;

// We don't use gethostbyname_r here, since there are different
// implementations in different Unix versions. Instead, we use a
// mutex.
//
var
  GethostbynameMutex: TMutex;

class procedure TOSNet.GetInAddr(const host: AnsiString; var addr: TSockAddr);
var
  ent: PHostEnt;
  retry: integer;
begin
  addr.sin_addr.s_addr := inet_addr(PAnsiChar(host));

  if(Cardinal(addr.sin_addr.s_addr) = INADDR_NONE) then begin
    GethostbynameMutex.lock;
    try
      retry := MT_GETHOSTBYNAME_RETRY;
      repeat
        ent := gethostbyname(PAnsiChar(host));
        Dec(retry);
{$IFDEF MSWINDOWS}
      until not ((ent = nil) and (WSAGetLastError() = WSATRY_AGAIN) and (retry > 0));
{$ENDIF}
{$IFDEF LINUX}
      until not ((ent = nil) and (errno() = TRY_AGAIN) and (retry > 0));
{$ENDIF}
      if (ent = nil) then
        raise COMM_FAILURE.Create(LastError(), MinorGethostbyname, COMPLETED_NO);

      Move(ent.h_addr, addr.sin_addr, ent.h_length);
    finally
      GethostbynameMutex.unlock;
    end; { try/finally }
  end;
end;

class function TOSNet.IsInterrupted: boolean;
begin
{$IFDEF MSWINDOWS}
  result := (GetError() = WSAEINTR);
{$ENDIF}
{$IFDEF LINUX}
  result := false;
  case GetError() of
    EINTR{$IFDEF EPROTO}, EPROTO {$ENDIF}: result := true;
  end;
{$ENDIF}
end;

class function TOSNet.LastError: string;
begin
{$IFDEF MSWINDOWS}
  case GetError() of
    WSAEINTR: result := 'error number WSAEINTR';
    WSAEBADF: result := 'error number WSAEBADF';
    WSAEACCES: result := 'error number WSAEACCES';
    WSAEFAULT: result := 'error number WSAEFAULT';
    WSAEINVAL: result := 'error number WSAEINVAL';
    WSAEMFILE: result := 'error number WSAEMFILE';
    WSAEWOULDBLOCK: result := 'error number WSAEWOULDBLOCK';
    WSAEINPROGRESS: result := 'error number WSAEINPROGRESS';
    WSAEALREADY: result := 'error number WSAEALREADY';
    WSAENOTSOCK: result := 'error number WSAENOTSOCK';
    WSAEDESTADDRREQ: result := 'error number WSAEDESTADDRREQ';
    WSAEMSGSIZE: result := 'error number WSAEMSGSIZE';
    WSAEPROTOTYPE: result := 'error number WSAEPROTOTYPE';
    WSAENOPROTOOPT: result := 'error number WSAENOPROTOOPT';
    WSAEPROTONOSUPPORT: result := 'error number WSAEPROTONOSUPPORT';
    WSAESOCKTNOSUPPORT: result := 'error number WSAESOCKTNOSUPPORT';
    WSAEOPNOTSUPP: result := 'error number WSAEOPNOTSUPP';
    WSAEPFNOSUPPORT: result := 'error number WSAEPFNOSUPPORT';
    WSAEAFNOSUPPORT: result := 'error number WSAEAFNOSUPPORT';
    WSAEADDRINUSE: result := 'error number WSAEADDRINUSE';
    WSAEADDRNOTAVAIL: result := 'error number WSAEADDRNOTAVAIL';
    WSAENETDOWN: result := 'error number WSAENETDOWN';
    WSAENETUNREACH: result := 'error number WSAENETUNREACH';
    WSAENETRESET: result := 'error number WSAENETRESET';
    WSAECONNABORTED: result := 'error number WSAECONNABORTED';
    WSAECONNRESET: result := 'error number WSAECONNRESET';
    WSAENOBUFS: result := 'error number WSAENOBUFS';
    WSAEISCONN: result := 'error number WSAEISCONN';
    WSAENOTCONN: result := 'error number WSAENOTCONN';
    WSAESHUTDOWN: result := 'error number WSAESHUTDOWN';
    WSAETOOMANYREFS: result := 'error number WSAETOOMANYREFS';
    WSAETIMEDOUT: result := 'error number WSAETIMEDOUT';
    WSAECONNREFUSED: result := 'error number WSAECONNREFUSED';
    WSAELOOP: result := 'error number WSAELOOP';
    WSAENAMETOOLONG: result := 'error number WSAENAMETOOLONG';
    WSAEHOSTDOWN: result := 'error number WSAEHOSTDOWN';
    WSAEHOSTUNREACH: result := 'error number WSAEHOSTUNREACH';
    WSAENOTEMPTY: result := 'error number WSAENOTEMPTY';
    WSAEPROCLIM: result := 'error number WSAEPROCLIM';
    WSAEUSERS: result := 'error number WSAEUSERS';
    WSAEDQUOT: result := 'error number WSAEDQUOT';
    WSAESTALE: result := 'error number WSAESTALE';
    WSAEREMOTE: result := 'error number WSAEREMOTE';
    WSAEDISCON: result := 'error number WSAEDISCON';
    WSASYSNOTREADY: result := 'error number WSASYSNOTREADY';
    WSAVERNOTSUPPORTED: result := 'error number WSAVERNOTSUPPORTED';
    WSANOTINITIALISED: result := 'error number WSANOTINITIALISED';
    WSAHOST_NOT_FOUND: result := 'error number WSAHOST_NOT_FOUND';
    WSATRY_AGAIN: result := 'error number WSATRY_AGAIN';
    WSANO_RECOVERY: result := 'error number WSANO_RECOVERY';
    WSANO_DATA: result := 'error number WSANO_DATA';
    else
      result := 'unknown error!';
  end;
{$ENDIF}
{$IFDEF LINUX}
  result := strerror(errno());
{$ENDIF}
end;

class function TOSNet.NoBufs: boolean;
begin
{$IFDEF MSWINDOWS}
  result := (GetError() = WSAENOBUFS) or (GetError() = WSAEFAULT);
{$ENDIF}
{$IFDEF LINUX}
  result := GetError() = ENOBUFS;
{$ENDIF}
end;

(*class procedure TOSNet.seterrno;
{$IFDEF MSWINDOWS}
var
  e: longint;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  e := WSAGetLastError();
  case e of
    WSAEINTR: errno_var := EINTR;
    WSAEWOULDBLOCK: errno_var := EWOULDBLOCK;
    WSAECONNRESET: errno_var := ECONNRESET;
    WSAESHUTDOWN: errno_var := ESHUTDOWN;
    WSAECONNABORTED: errno_var := ECONNABORTED;
    else
      errno_var := -1;
  end;
  WSASetLastError(e);
{$ENDIF}
end;*)

class procedure TOSNet.SetError(err: integer);
begin
{$IFDEF MSWINDOWS}
  WSASetLastError(err);
{$ENDIF}
{$IFDEF LINUX}
  //errno := err;
{$ENDIF}
end;

class procedure TOSNet.sockblock(s: TSocket; val: Boolean);
var
{$IFDEF MSWINDOWS}
  tmp: integer;
{$ENDIF}
{$IFDEF LINUX}
  flags: long;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if val then
    tmp := 0
  else
    tmp := 1;
  WinSock.ioctlsocket(s, FIONBIO, tmp);
{$ENDIF}
{$IFDEF LINUX}
  flags := fcntl(s, F_GETFL, 0);
  Assert(flags <> -1);
  if val then
    flags := flags and not O_NONBLOCK
  else
    flags := flags or O_NONBLOCK;
  fcntl(s, F_SETFL, flags);
{$ENDIF}
end;

class function TOSNet.sockclose(s: TSocket): long;
begin
{$IFDEF MSWINDOWS}
  WSASetLastError(0);
  result := winsock.closesocket(s);
  if result = 0 then exit;
  //seterrno();
  result := -1;
{$ENDIF}
{$IFDEF LINUX}
  result := __close(s);
{$ENDIF}
end;

class procedure TOSNet.sockfinal;
{$IFDEF LINUX}
var
  actPIPE: TSigAction;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  WSACleanup();
{$ENDIF}
{$IFDEF LINUX}
  actPIPE.__sigaction_handler := TSignalHandler(SIG_DFL);
  sigemptyset(actPIPE.sa_mask);
  actPIPE.sa_flags := 0;
  sigaction(SIGPIPE, @actPIPE, nil);
{$ENDIF}
end;

class procedure TOSNet.sockinit;
var
{$IFDEF MSWINDOWS}
  ver: WORD;
  err: integer;
  dat: TWSADATA;
{$ENDIF}
{$IFDEF LINUX}
  actPIPE: TSigAction;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ver := MakeWord(2,0);
  err := WSAStartup(ver, dat);
  if err <> 0 then
    dorb_throw(st_COMM_FAILURE, MinorWSAStartup, COMPLETED_NO);
{$ENDIF}
{$IFDEF LINUX}
  //when peer closes a unix socket we receive SIGPIPE
  actPIPE.__sigaction_handler := TSignalHandler(SIG_IGN);
  sigemptyset(actPIPE.sa_mask);
  actPIPE.sa_flags := 0;
  sigaction(SIGPIPE, @actPIPE, nil);
  //signal(SIGPIPE, TSignalHandler(SIG_IGN));
{$ENDIF}
end;

class function TOSNet.sockndelay(s: TSocket; val: Boolean): integer;
{$IFDEF TCP_NODELAY}
var
  tmp: integer;
{$ENDIF}
begin
{$IFDEF TCP_NODELAY}
  tmp := Integer(val);
  result := setsockopt(s, IPPROTO_TCP, TCP_NODELAY, PAnsiChar(@tmp), sizeof(tmp));
  if result = 0 then exit;
  //seterrno();
{$ELSE}
  result := 0;
{$ENDIF}
end;

class function TOSNet.sockread(s: TSocket; var Buffer; len: _ulong): integer;
begin
{$IFDEF MSWINDOWS}
  WSASetLastError(0);
  result := winsock.recv(s,buffer,len,0);
  if result <> SOCKET_ERROR then
    exit;
  //seterrno();
{$ENDIF}
{$IFDEF LINUX}
  result := recv(s,buffer,len,0);
{$ENDIF}
end;

class procedure TOSNet.sockreuse(s: TSocket; val: Boolean);
var
  _val : longint;
begin
  if val then
    _val := 1
  else
    _val := 0;
  assert(setsockopt (s, SOL_SOCKET, SO_REUSEADDR, PAnsiChar(@_val), sizeof(_val))=0);
end;

class function TOSNet.sockwrite(s: TSocket; var Buffer; len: _ulong): integer;
begin
{$IFDEF MSWINDOWS}
  WSASetLastError(0);
  // Limit the maximum size of a message, in order to avoid
  // a performance problem on Win32.
  //
  // Note: The maximum size must be less than the socket's
  // send buffer size set by the constructor.
  //
  // TODO: This is a total hack!
  // Thanks guys from OOC
  if (len > 65535) then
    len := 65535;

  result := winsock.send(s, buffer, len, 0);
  if result <> SOCKET_ERROR then
    exit;
  //seterrno();
{$ENDIF}
{$IFDEF LINUX}
  result := send(s, buffer, len, 0);
{$ENDIF}
end;

class function TOSNet.WouldBlock: boolean;
begin
{$IFDEF MSWINDOWS}
  result := GetError() = WSAEWOULDBLOCK;
{$ENDIF}
{$IFDEF LINUX}
  result := (GetError() = EAGAIN) or (GetError() = EWOULDBLOCK);
{$ENDIF}
end;

initialization
  GethostbynameMutex := TMutex.Create;
finalization
  FreeAndNil(GethostbynameMutex);
end.
