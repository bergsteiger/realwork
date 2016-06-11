{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Net.Socket;

interface

{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}

uses System.Types, System.SysUtils, System.Classes,
{$IFDEF MSWINDOWS}
  Winapi.WinSock2;
{$ENDIF}
{$IFDEF POSIX}
  Posix.NetinetIn, Posix.ArpaInet, Posix.SysSocket, Posix.SysSelect;
{$ENDIF}

{$SCOPEDENUMS ON}
{$HPPEMIT NOUSINGNAMESPACE}

const
{$IFDEF MSWINDOWS}
  InvalidSocket = INVALID_SOCKET;
{$ENDIF}
{$IFDEF POSIX}
  InvalidSocket = -1;
{$ENDIF}
  InAddrAny = INADDR_ANY;
  InAddrBroadcast = INADDR_BROADCAST;
  InAddrLoopback = INADDR_LOOPBACK;

type
{$IFDEF MSWINDOWS}
  TSocketHandle = Winapi.WinSock2.TSocket;
{$ENDIF}
{$IFDEF POSIX}
  TSocketHandle = Integer;
{$ENDIF}

  /// <summary>
  ///    Base exception type for all exceptions raised within this unit
  /// </summary>
  ESocketError = class(Exception);

  TSocketType = (TCP, UDP, RAW, RDM, SEQ);
  TSocketFlag = (OOB, PEEK, DONTROUTE, WAITALL);
  TSocketFlags = set of TSocketFlag;
  TSocketState = (Connected, Client, Listening);
  TSocketStates = set of TSocketState;

  /// <summary>Wrapper around a network IP address</summary>
  TIPAddress = record
  private
    FAddr: in_addr;
    class function GetLocalHost: TIPAddress; static; inline;
    class function GetBroadcast: TIPAddress; static; inline;
    class function GetAny: TIPAddress; static; inline;
    class function OctetsToN(const B1, B2, B3, B4: Byte): Cardinal; static; inline;
    function GetAddress: string;
  public
    /// <summary>Create and return an ip address structure based on the domain name</summary>
    class function Create(const Name: string): TIPAddress; overload; static;
    /// <summary>Create and return an ip address structure based on an IPv4 address</summary>
    class function Create(const Address: Cardinal): TIPAddress; overload; static;
    /// <summary>Create and return an ip address structure based on an IPv4 address as individual octets</summary>
    class function Create(const B1, B2, B3, B4: Byte): TIPAddress; overload; static;
    /// <summary>Create and return an ip address suitable for use as a UDP datagram broadcast to the local subnet</summary>
    class function Create(const Address: TIPAddress; Mask: TIPAddress): TIPAddress; overload; static;
    /// <summary>Create and return an ip address structure based on the platform socket api type</summary>
    class function Create(const Address: in_addr): TIPAddress; overload; static;

    /// <summary>Lookup and return an ip address based on passed in the domain name</summary>
    class function LookupName(const Name: string): TIPAddress; static;
    /// <summary>Return an ip address based on the string representation of an IPv4 address</summary>
    class function LookupAddress(const Address: string): TIPAddress; static;

    class operator Implicit(const Address: TIPAddress): in_addr; inline;

    /// <summary>Address suitable for use with various OS socket apis</summary>
    property Addr: in_addr read FAddr;
    /// <summary>Address in string format suitable for display</summary>
    property Address: string read GetAddress;

    /// <summary>Returns an IP address corresponding to the value INADDR_ANY</summary>
    class property Any: TIPAddress read GetAny;
    /// <summary>Returns an IP address corresponding the this host. Sometimes called the loopback address. This will normally be 127.0.0.1</summary>
    class property LocalHost: TIPAddress read GetLocalHost;
    /// <summary>Returns an IP address suitable for broadcasting on the local subnet. This is usually the value in INADDR_BROADCAST</summary>
    class property Broadcast: TIPAddress read GetBroadcast;
  end;

  /// <summary>Wrapper around a network address and port</summary>
  TNetEndpoint = record
  private
    FEndPoint: sockaddr_in;
    function GetAddress: TIPAddress; inline;
    function GetFamily: Word; inline;
    function GetPort: Word; inline;
    procedure SetAddress(const Address: TIPAddress); overload; inline;
    procedure SetFamily(const Family: Word); inline;
    procedure SetPort(const Port: Word); overload; inline;
    class procedure SetSize(var Endpoint: TNetEndpoint); static; inline;
  public
    /// <summary>Create and return a network endpoint based on various address/port forms</summary>
    class function Create(const Name, Service: string; SocketType: TSocketType = TSocketType.TCP): TNetEndpoint; overload; static;
    class function Create(const Address: Cardinal; const Port: Word): TNetEndpoint; overload; static;
    class function Create(const B1, B2, B3, B4: Byte; const Port: Word): TNetEndpoint; overload; static;
    class function Create(const Address: TIPAddress; const Service: string; SocketType: TSocketType = TSocketType.TCP): TNetEndpoint; overload; static;
    class function Create(const Address: TIPAddress; const Port: Word): TNetEndpoint; overload; static;

    class function Create(const Family: Word; const Name, Service: string; SocketType: TSocketType = TSocketType.TCP): TNetEndpoint; overload; static;
    class function Create(const Family: Word; const Address: Cardinal; const Port: Word): TNetEndpoint; overload; static;
    class function Create(const Family: Word; const B1, B2, B3, B4: Byte; const Port: Word): TNetEndpoint; overload; static;
    class function Create(const Family: Word; const Address: TIPAddress; const Service: string; SocketType: TSocketType = TSocketType.TCP): TNetEndpoint; overload; static;
    class function Create(const Family: Word; const Address: TIPAddress; const Port: Word): TNetEndpoint; overload; static;

    class function Create(const Endpoint: sockaddr_in): TNetEndpoint; overload; inline; static;

    class operator Implicit(const EndPoint: TNetEndpoint): sockaddr_in; inline;
    class operator Implicit(const EndPoint: TNetEndpoint): sockaddr; inline;
    class operator Implicit(const Endpoint: sockaddr_in): TNetEndpoint; inline;
    class operator Implicit(const Endpoint: sockaddr): TNetEndpoint; inline;

    /// <summary>Lookup a service by name and optionally by the indicated socket type (tcp or udp). Default is tcp.</summary>
    class function LookupService(const Service: string; SocketType: TSocketType = TSocketType.TCP): Word; static;

    /// <summary>Explicitly set the address of the endpoint</summary>
    procedure SetAddress(const Address: string); overload;
    procedure SetAddress(const Address: Cardinal); overload;
    procedure SetAddress(const B1, B2, B3, B4: Byte); overload;

    /// <summary>Explicitly set the service port using the name of the service</summary>
    procedure SetPort(const Service: string; SocketType: TSocketType = TSocketType.TCP); overload;

    /// <summary>The IP address contained with this endpoint</summary>
    property Address: TIPAddress read GetAddress write SetAddress;
    /// <summary>Address family of the address contained within this endpoint</summary>
    property Family: Word read GetFamily write SetFamily;
    /// <summary>Port number contained within this endpoint</summary>
    property Port: Word read GetPort write SetPort;
  end;

  TSocket = class;

  PFDSet = ^TFDSet;
  /// <summary>Socket descriptor/handle set wrapper for use with TSocket.Select</summary>
  TFDSet = record
  private
    FFDSet: fd_set;
{$IFDEF POSIX}
    FNFds: Integer;
{$ENDIF}
    class function CreateNew(const Sockets: array of TSocket): TFDSet; overload; static;
    procedure ValidateHandle(const ASocket: TSocket); inline;
    function GetFdSet: PFd_Set;
    function GetMaxFd: Integer;
    procedure &Set(const AHandle: TSocketHandle); overload;
    procedure Clear(const AHandle: TSocketHandle); overload; inline;
    function IsSet(const AHandle: TSocketHandle): Boolean; overload; inline;
  public
    /// <summary>Create an emtpy fd_set</summary>
    class function Create: TFDSet; overload; inline; static;
    /// <summary>Create an fd_set with all of the given socket handles within it</summary>
    class function Create(const Sockets: array of TSocket): TFDSet; overload; static;
    /// <summary>Create an fd_set with only the given socket handle within it</summary>
    class function Create(const Socket: TSocket): TFDSet; overload; inline; static;

    /// <summary>Corresponds to FD_SET macro/function</summary>
    procedure &Set(const ASocket: TSocket); overload; inline;
    /// <summary>Corresponds to FD_CLR macro/function</summary>
    procedure Clear(const ASocket: TSocket); overload;
    /// <summary>Corresponds to FD_ZERO macro/function</summary>
    procedure Zero;
    /// <summary>Corresponds to FD_ISSET macro/function</summary>
    function IsSet(const ASocket: TSocket): Boolean; overload;

    class operator Implicit(const [Ref] AFDSet: TFDSet): PFDSet;

    /// <summary>The reference to the internal fd_set field</summary>
    property FdSet: PFd_set read GetFdSet;
    /// <summary>
    ///   For some platforms, returns either the highest numerical value of out of all the socket handles
    ///   within the set. On other platforms, returns the actual number of socket handles in the set.
    /// </summary>
    property MaxFd: Integer read GetMaxFd;
  end;

  /// <summary>Lightweight, multi-platform wrapper for a network socket</summary>
  TSocket = class
  private type
{$IFDEF MSWINDOWS}
    TSockSize = Integer;
{$ENDIF}
{$IFDEF POSIX}
    TSockSize = Cardinal;
{$ENDIF}
    TSocketTypes = set of TSocketType;
  private
    FSocket: TSocketHandle;
    FState: TSocketStates;
    FAddr: sockaddr_in;
    FSockType: TSocketType;
    FEncoding: TEncoding;
    function GetEndpoint: TNetEndpoint; inline;
    function GetLocalHost: string;
    function GetLocalAddress: string;
    function GetLocalPort: Integer;
    function GetLocalEndpoint: TNetEndpoint;
    function GetRemoteHost: string;
    function GetRemoteAddress: string;
    function GetRemotePort: Integer;
    function GetRemoteEndpoint: TNetEndpoint;
    procedure ValidSocketTypes(SocketTypes: TSocketTypes);
    function InternalConvertFlags(Flags: TSocketFlags): Integer;
{$IFDEF MSWINDOWS}
    class constructor Create;
    class destructor Destroy;
{$ENDIF}
  protected type
    TSocketAsyncResult = class(TBaseAsyncResult)
    private
      FAsyncCallback: TAsyncCallback;
      FAsyncCallbackEvent: TAsyncCallbackEvent;
      function GetSocket: TSocket; inline;
    protected
      procedure Complete; override;
      procedure Schedule; override;
      constructor Create(const AContext: TObject;
        const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
      property Socket: TSocket read GetSocket;
    end;
    TSocketReceiveAsyncResult = class(TSocketAsyncResult)
    private
      FBytesFunc: TFunc<TBytes>;
      FResult: TBytes;
      function GetResultBytes: TBytes;
      function GetResultString: string;
    protected
      procedure AsyncDispatch; override;
      constructor Create(const AContext: TObject; const ABytesFunc: TFunc<TBytes>;
        const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
      property ResultBytes: TBytes read GetResultBytes;
      property ResultString: string read GetResultString;
    end;
    TSocketReceiveFromAsyncResult = class(TSocketAsyncResult)
    protected type
      TReceiveFromFunc = reference to function (out NetEndpoint: TNetEndpoint): TBytes;
    private
      FReceiveFromFunc: TReceiveFromFunc;
      FResult: TBytes;
      FNetEndpoint: TNetEndpoint;
      function GetResultBytes: TBytes;
      function GetResultString: string;
    protected
      procedure AsyncDispatch; override;
      constructor Create(const AContext: TObject; const AReceiveFromFunc: TReceiveFromFunc;
        const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
      property ResultBytes: TBytes read GetResultBytes;
      property ResultString: string read GetResultString;
      property NetEndpoint: TNetEndpoint read FNetEndpoint;
    end;
    TSocketSendAsyncResult = class(TSocketAsyncResult)
    private
      FFunc: TFunc<Integer>;
      FResult: Integer;
      function GetResult: Integer;
    protected
      procedure AsyncDispatch; override;
      constructor Create(const AContext: TObject; const AFunc: TFunc<Integer>;
        const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
      property Result: Integer read GetResult;
    end;
    TSocketAcceptAsyncResult = class(TSocketAsyncResult)
    private
      FFunc: TFunc<TSocket>;
      FResult: TSocket;
      function GetResult: TSocket;
    protected
      procedure AsyncDispatch; override;
      constructor Create(const AContext: TObject; const AFunc: TFunc<TSocket>;
        const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
      property Result: TSocket read GetResult;
    end;
    TSocketConnectResult = class(TSocketAsyncResult)
    private
      FProc: TProc;
    protected
      procedure AsyncDispatch; override;
      constructor Create(const AContext: TObject; const AProc: TProc;
        const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
    end;
  protected
    /// <summary>
    ///    For server/listening sockets accepting connections, create a socket instance suitable for communicating
    ///    with a connected client.
    /// </summary>
    function GetClientSocket(Handle: TSocketHandle; const Addr: sockaddr_in): TSocket; virtual;
    /// <summary>
    ///    Create a socket handle using the underlying socket apis. Descendants could override this method to
    ///    use other means of creating a socket handle or creating a handle within a different "family".
    /// </summary>
    function CreateSocket: TSocketHandle; virtual;
    /// <summary>
    ///    Bind the socket to a local ip address.
    /// </summary>
    procedure DoBind; virtual;
    /// <summary>
    ///    Initiate a connection to a remote host
    /// </summary>
    procedure DoConnect; virtual;
    /// <summary>
    ///    Begin listening on a socket for incomming connections
    /// </summary>
    procedure DoListen(QueueSize: Integer = -1); virtual;
    /// <summary>
    ///    Initialize the sockaddr_in structure based on the various parameters. This function will also perform
    ///    address lookups if Name <> '' and service lookups if Service <> ''.
    /// </summary>
    function InitSocket(const Name, Address, Service: string; Port: Word; Client: Boolean; Broadcast: Boolean = False): sockaddr_in;
    /// <summary>
    ///    Converts the given TSocketFlags set to a value suitable for calling certain underlying socket APIs.
    /// </summary>
    function ConvertFlags(Flags: TSocketFlags): Integer; inline;
    /// <summary>
    ///    Blocks the caller until data has been received from a remote host.
    /// </summary>
    function WaitForData(ATimeout: Cardinal = INFINITE): TWaitResult;
    /// <summary>
    ///    Create a socket instance around an existing socket handle. This constructor is called when accepting an
    ///    incomming connection when used as a server socket.
    /// </summary>
    constructor Create(ASocket: TSocketHandle; const AAddr: sockaddr_in; const AEncoding: TEncoding); overload;
  public
    /// <summary>
    ///    Construct a new socket based on the given socket type. Optionally provide an encoding when sending/receiving
    ///    string data. Unless Encoding is set, UTF8 is the default encoding.
    /// </summary>
    constructor Create(ASockType: TSocketType; const AEncoding: TEncoding = nil); overload;
    destructor Destroy; override;

    /// <summary>
    ///  For a socket currently listening for connections, block the caller until a client connects. Returns a
    ///  new TSocket instance which must be freed or otherwise handled by the caller.
    /// </summary>
    function Accept(Timeout: Cardinal = INFINITE): TSocket;

    /// <summary>
    ///  Asynchronously accept incoming connections. This call will return immediately.
    /// </summary>
    function BeginAccept(const AsyncCallbackEvent: TAsyncCallbackEvent; Timeout: Cardinal = INFINITE): IAsyncResult; overload;
    function BeginAccept(const AsyncCallback: TAsyncCallback; Timeout: Cardinal = INFINITE): IAsyncResult; overload;
    function BeginAccept(Timeout: Cardinal = INFINITE): IAsyncResult; overload; inline;

    /// <summary>
    ///  Block the caller until an incoming connection is made or times out.
    /// </summary>
    function EndAccept(const AAsyncResult: IAsyncResult): TSocket;

    /// <summary>
    ///  "Bind" or associate a socket with a local adapter. The adapter may be a physical hardware or virtual device
    /// </summary>
    procedure Bind(const Endpoint: TNetEndpoint); overload;
    procedure Bind(Port: Word); overload;
    /// <summary>
    ///  Perform a safe, orderly shutdown of the communications channel
    /// </summary>
    procedure Close; overload; inline;
    /// <summary>
    ///  If ForceClosed = True, then perform an immediate, possibly dangerous and disorderly shutdown of the
    ///  communications channel. If ForceClosed = False, then just call Close above.
    /// </summary>
    procedure Close(ForceClosed: Boolean); overload;
    /// <summary>
    ///  In order to begin accepting incoming connections, call Listen to configure the socket. Use Accept() to
    ///  begin receiving incoming connections.
    /// </summary>
    procedure Listen(const Address, Service: string; Port: Word; QueueSize: Integer = -1); overload;
    procedure Listen(const Endpoint: TNetEndpoint; QueueSize: Integer = -1); overload;

    /// <summary>
    ///  Asynchronously connect to the specified endpoint. Socket type must be TCP, UDP, RAW, RDM, or SEQ.
    /// </summary>
    function BeginConnect(const AsyncCallbackEvent: TAsyncCallbackEvent; const Name, Address, Service: string; Port: Word): IAsyncResult; overload;
    function BeginConnect(const AsyncCallbackEvent: TAsyncCallbackEvent; const Endpoint: TNetEndpoint): IAsyncResult; overload;
    function BeginConnect(const AsyncCallback: TAsyncCallback; const Name, Address, Service: string; Port: Word): IAsyncResult; overload;
    function BeginConnect(const AsyncCallback: TAsyncCallback; const Endpoint: TNetEndpoint): IAsyncResult; overload;
    function BeginConnect(const Name, Address, Service: string; Port: Word): IAsyncResult; overload; inline;
    function BeginConnect(const Endpoint: TNetEndpoint): IAsyncResult; overload; inline;

    /// <summary>
    ///  Block the caller until the connection is established or times out.
    /// </summary>
    procedure EndConnect(const AAsyncResult: IAsyncResult);

    /// <summary>
    ///  Establish a connection to the specified endpoint. Socket type must be TCP, UDP, RAW, RDM, or SEQ.
    /// </summary>
    procedure Connect(const Name, Address, Service: string; Port: Word); overload;
    procedure Connect(const EndPoint: TNetEndpoint); overload;

    /// <summary>
    ///  Bind and prepare the socket for receiving sub-net broadcasts. Socket type must be TSocketType.UDP
    /// </summary>
    procedure ListenBroadcast(const Endpoint: TNetEndpoint); overload;
    procedure ListenBroadcast(Port: Word); overload; inline;

    /// <summary>
    ///  Prepare and configure the socket for sending local sub-net broadcasts. Socket type must be TSocketType.UDP
    /// </summary>
    procedure OpenBroadcast(const Endpoint: TNetEndpoint); overload;
    procedure OpenBroadcast(Port: Word); overload; inline;

    /// <summary>
    ///  Perform a DNS lookup of 'name'.
    /// </summary>
    function LookupName(const name: string): TIPAddress;
    /// <summary>
    ///  Lookup the port number of the given named service. The service names are usually defined in a "services" text
    ///  file whose location is specific to each operating system.
    /// </summary>
    function LookupService(const service: string): Integer;

    /// <summary>
    ///  Asynchronously Receive data from a connected endpoint.
    /// </summary>
    function BeginReceive(const AsyncCallbackEvent: TAsyncCallbackEvent; Count: Integer; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginReceive(const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginReceive(const AsyncCallback: TAsyncCallback; Count: Integer; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginReceive(const AsyncCallback: TAsyncCallback; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginReceive(Count: Integer; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginReceive(Flags: TSocketFlags = []): IAsyncResult; overload; inline;

    /// <summary>
    ///  Block the caller until the operation initiated from BeginReceive completes and data is returned.
    /// </summary>
    function EndReceiveString(const AAsyncResult: IAsyncResult): string;
    function EndReceiveBytes(const AAsyncResult: IAsyncResult): TBytes;

    /// <summary>
    ///  Returns the number of available pending bytes, if any. This function should return immediately.
    /// </summary>
    function ReceiveLength: Integer; inline;

    /// <summary>
    ///  Obtain data sent from the connected endpoint. Blocks the caller until the requested data is returned.
    /// </summary>
    function Receive(var Buf; Count: Integer; Flags: Integer): Integer; overload;
    function Receive(var Buf; Count: Integer; Flags: TSocketFlags = []): Integer; overload; inline;
    function Receive(Count: Integer = -1; Flags: TSocketFlags = []): TBytes; overload; inline;
    function Receive(out Bytes: TBytes; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;
    function Receive(var Bytes: array of Byte; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;
    /// <summary>
    ///  Obtain data sent from the connected endpoint and translate the bytes into a string based on the Encoding property.
    /// </summary>
    function ReceiveString(Flags: TSocketFlags = []): string;

    /// <summary>
    ///  Asynchronously send the specified data to the connected endpoint.
    /// </summary>
    function BeginSend(const S: string; const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginSend(const B: TBytes; const AsyncCallbackEvent: TAsyncCallbackEvent; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginSend(const S: string; const AsyncCallback: TAsyncCallback; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginSend(const B: TBytes; const AsyncCallback: TAsyncCallback; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginSend(const S: string; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginSend(const B: TBytes; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload; inline;

    /// <summary>
    ///  Blocks the caller until the operation initiated from BeginSend completes.
    /// </summary>
    function EndSend(const AAsyncResult: IAsyncResult): Integer;

    /// <summary>
    ///  Send the specified data to the connected endpoint.
    /// </summary>
    function Send(const Buf; Count: Integer; Flags: Integer): Integer; overload;
    function Send(const Buf; Count: Integer; Flags: TSocketFlags = []): Integer; overload; inline;
    function Send(const S: string; Flags: TSocketFlags = []): Integer; overload;
    function Send(const B: TBytes; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;
    function Send(const B: array of Byte; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;

    /// <summary>
    ///  Asynchronously receive data via TCP, UDP, or UDP broadcast.
    /// </summary>
    function BeginReceiveFrom(const AsyncCallbackEvent: TAsyncCallbackEvent; Count: Integer; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginReceiveFrom(const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginReceiveFrom(const AsyncCallback: TAsyncCallback; Count: Integer; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginReceiveFrom(const AsyncCallback: TAsyncCallback; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginReceiveFrom(Count: Integer; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginReceiveFrom(Flags: TSocketFlags = []): IAsyncResult; overload; inline;

    /// <summary>
    ///  Block the caller until the operation initiated from BeginReceiveFrom completes.
    /// </summary>
    function EndReceiveStringFrom(const AAsyncResult: IAsyncResult; out AEndPoint: TNetEndPoint): string; overload;
    /// <summary>
    ///  Block the caller until the operation initiated from BeginReceiveFrom completes.
    /// </summary>
    function EndReceiveBytesFrom(const AAsyncResult: IAsyncResult; out AEndPoint: TNetEndPoint): TBytes; overload;
    function EndReceiveStringFrom(const AAsyncResult: IAsyncResult): string; overload; inline;
    function EndReceiveBytesFrom(const AAsyncResult: IAsyncResult): TBytes; overload; inline;

    /// <summary>
    ///  Receive data via TCP, UDP, or UDP broadcast.
    /// </summary>
    function ReceiveFrom(var Buf; Count: Integer; Flags: Integer): Integer; overload;
    function ReceiveFrom(var Buf; Count: Integer; Flags: TSocketFlags = []): Integer; overload; inline;
    function ReceiveFrom(Count: Integer = -1; Flags: TSocketFlags = []): TBytes; overload; inline;
    function ReceiveFrom(out Bytes: TBytes; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload; inline;
    function ReceiveFrom(var Bytes: array of Byte; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;
    function ReceiveFrom(var Buf; Count: Integer; out Endpoint: TNetEndpoint; Flags: Integer): Integer; overload;
    function ReceiveFrom(var Buf; Count: Integer; out Endpoint: TNetEndpoint; Flags: TSocketFlags = []): Integer; overload; inline;
    function ReceiveFrom(out Endpoint: TNetEndpoint; Count: Integer = -1; Flags: TSocketFlags = []): TBytes; overload; inline;
    function ReceiveFrom(out Bytes: TBytes; out Endpoint: TNetEndpoint; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;
    function ReceiveFrom(var Bytes: array of Byte; out Endpoint: TNetEndpoint; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;

    /// <summary>
    ///  Receive string data via TCP, UDP, or UDP broadcast.
    /// </summary>
    function ReceiveStringFrom(Flags: TSocketFlags = []): string; overload; inline;
    function ReceiveStringFrom(out Endpoint: TNetEndpoint; Flags: TSocketFlags = []): string; overload;

    /// <summary>
    ///  Asynchronously send data via TCP, UDP, or UDP broadcast.
    /// </summary>
    function BeginSendTo(const S: string; const AsyncCallback: TAsyncCallback; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginSendTo(const S: string; const Endpoint: TNetEndpoint; const AsyncCallback: TAsyncCallback; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginSendTo(const B: TBytes; const AsyncCallback: TAsyncCallback; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginSendTo(const B: TBytes; const Endpoint: TNetEndpoint; const AsyncCallback: TAsyncCallback; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginSendTo(const S: string; const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginSendTo(const S: string; const Endpoint: TNetEndpoint; const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginSendTo(const B: TBytes; const AsyncCallbackEvent: TAsyncCallbackEvent; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginSendTo(const B: TBytes; const Endpoint: TNetEndpoint; const AsyncCallbackEvent: TAsyncCallbackEvent; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload;
    function BeginSendTo(const S: string; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginSendTo(const S: string; const Endpoint: TNetEndpoint; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginSendTo(const B: TBytes; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload; inline;
    function BeginSendTo(const B: TBytes; const Endpoint: TNetEndpoint; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): IAsyncResult; overload; inline;

    /// <summary>
    ///  Block the caller until the operation initiated from BeginSendTo completes.
    /// </summary>
    function EndSendTo(const AAsyncResult: IAsyncResult): Integer; inline;

    /// <summary>
    ///  Send data via TCP, UDP, or UDP broadcast.
    /// </summary>
    function SendTo(const Buf; Count: Integer; Flags: Integer): Integer; overload; inline;
    function SendTo(const Buf; Count: Integer; Flags: TSocketFlags = []): Integer; overload; inline;
    function SendTo(const S: string; Flags: TSocketFlags = []): Integer; overload; inline;
    function SendTo(const B: array of Byte; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;

    function SendTo(const Buf; Count: Integer; const Endpoint: TNetEndpoint; Flags: Integer): Integer; overload;
    function SendTo(const Buf; Count: Integer; const Endpoint: TNetEndpoint; Flags: TSocketFlags = []): Integer; overload; inline;
    function SendTo(const S: string; const Endpoint: TNetEndpoint; Flags: TSocketFlags = []): Integer; overload;
    function SendTo(const B: array of Byte; const Endpoint: TNetEndpoint; Offset: Integer = 0; Count: Integer = -1; Flags: TSocketFlags = []): Integer; overload;

    /// <summary>
    ///  Use TFDSet above to check multiple socket instances for read/write readiness or error state
    /// </summary>
    class function Select(const CheckRead, CheckWrite, CheckError: PFDSet; Microseconds: Int64): TWaitResult; static;

    /// <summary>
    ///    The local host name.
    /// </summary>
    property LocalHost: string read GetLocalHost;
    /// <summary>
    ///    Local IP address as a string
    /// </summary>
    property LocalAddress: string read GetLocalAddress;
    /// <summary>
    ///    Local port number.
    /// </summary>
    property LocalPort: Integer read GetLocalPort;
    /// <summary>
    ///    Returns the local data as a TNetEndpoint.
    /// </summary>
    property LocalEndpoint: TNetEndpoint read GetLocalEndpoint;

    /// <summary>
    ///    The remote connected host name.
    /// </summary>
    property RemoteHost: string read GetRemoteHost;
    /// <summary>
    ///    Remote IP address as a string.
    /// </summary>
    property RemoteAddress: string read GetRemoteAddress;
    /// <summary>
    ///    Remote connected port.
    /// </summary>
    property RemotePort: Integer read GetRemotePort;
    /// <summary>
    ///    Remote connection as a TNetEndpoint
    /// </summary>
    property RemoteEndpoint: TNetEndpoint read GetRemoteEndpoint;

    /// <summary>
    ///    The connected endpoint. For a client socket this is the remote endpoint. For a server, this is the local
    ///    endpoint.
    /// </summary>
    property Endpoint: TNetEndpoint read GetEndpoint;
    /// <summary>
    ///    Current encoding used to encode/decode data sent/received as strings. UTF8 is the default encoding.
    /// </summary>
    property Encoding: TEncoding read FEncoding write FEncoding;
    /// <summary>
    ///    Underlying socket handle if conneted, listening, or bound
    /// </summary>
    property Handle: TSocketHandle read FSocket;
    /// <summary>
    ///    Type of the socket, TCP, UDP, RAW, RDM or SEQ
    /// </summary>
    property SocketType: TSocketType read FSockType;
    /// <summary>
    ///    Current states the socket is in.
    /// </summary>
    property State: TSocketStates read FState;
    /// <summary>
    ///    Property of type sockaddr_in suitable for use by various other OS socket APIs.
    /// </summary>
    property Addr: sockaddr_in read FAddr;
  end;

  /// <summary>
  ///    Stream wrapper around a TSocket suitable for use in cases where a TStream descedant is required.
  ///    NOTE: this stream instance doesn't support position setting using the Position property or the Seek
  ///    method.
  /// </summary>
  TSocketStream = class(TStream)
  private
    FSocket: TSocket;
    FOwnsSocket: Boolean;
  public
    /// <summary>
    ///    Create a TSocketStream with the given socket instance. By default, the socket stream will "own"
    ///    the socket instance which will destroy/close the socket when the stream is destroyed.
    /// </summary>
    constructor Create(const ASocket: TSocket; AOwnsSocket: Boolean = True);
    destructor Destroy; override;

    function Read(var Buffer; Count: LongInt): LongInt; overload; override;
    function Write(const Buffer; Count: LongInt): LongInt; overload; override;
  end;

implementation

uses
{$IFDEF POSIX}
  Posix.StrOpts, Posix.Unistd, Posix.NetDB, Posix.SysTime, Posix.Errno,
  {$IFDEF LINUX}
  KernelIoctl,
  {$ENDIF LINUX}
{$ENDIF}
  System.RTLConsts, System.NetConsts, System.Threading, System.Math;

 resourcestring
  sStaticDynArraySizeError = 'SizeOf(T) must be 1 and Type of ''T'' must be Byte or AnsiChar to Marshal'; // do not localize
  sStaticDynArraySize = 'SizeOf(T) must be 1 or 2'; // do not localize
  sStaticDynArrayArrayError = 'Type of ''J'' must be an array!'; // do not localize

{$IFDEF POSIX}
function closesocket(Socket: TSocketHandle): Integer; inline;
begin
  Result := Posix.Unistd.__close(Socket);
end;

function ioctlsocket(Socket: TSocketHandle; Request: Integer; var Data): Integer; inline;
begin
  Result := ioctl(Socket, Request, @Data);
end;
{$ENDIF}

function socketlisten(Socket: TSocketHandle; QueueSize: Integer): Integer; inline;
begin
  Result := listen(Socket, QueueSize);
end;

function socketsend(Socket: TSocketHandle; const Buf; Count: Integer; Flags: Integer): Integer; inline;
begin
  Result := send(Socket, Buf, Count, Flags);
end;

function socketconnect(Socket: TSocketHandle; var Addr: sockaddr; AddrLen: Integer): Integer; inline;
begin
  Result := connect(Socket, Addr, AddrLen);
end;

function socketsendto(Socket: TSocketHandle; const Buf; Count: Integer; Flags: Integer; const [Ref] ToAddr: TNetEndpoint; ToLen: Integer): Integer; inline;
begin
{$IFDEF MSWINDOWS}
  Result := sendto(Socket, Buf, Count, Flags, @ToAddr.FEndPoint, ToLen);
{$ENDIF}
{$IFDEF POSIX}
  Result := sendto(Socket, Buf, Count, Flags, sockaddr(ToAddr.FEndpoint), ToLen);
{$ENDIF}
end;

function acceptsocket(Socket: TSocketHandle; var Addr: sockaddr_in; var Len: Integer): Integer; inline;
begin
{$IFDEF MSWINDOWS}
  Result := accept(Socket, @Addr, @Len);
{$ENDIF}
{$IFDEF POSIX}
  Result := accept(Socket, sockaddr(Addr), Cardinal(Len));
{$ENDIF}
end;

function setsocketoption(socket: TSocketHandle; level, option_name: Integer; const option_value; option_len: Integer): Integer; inline;
begin
{$IFDEF MSWINDOWS}
  Result := setsockopt(socket, level, option_name, MarshaledAString(@option_value), option_len);
{$ENDIF}
{$IFDEF POSIX}
  Result := setsockopt(socket, level, option_name, option_value, option_len);
{$ENDIF}
end;

function socketselect(nfds: Integer; readfds, writefds, exceptfds: PFd_set; timeout: Ptimeval): Integer; inline;
begin
  Result := select(nfds, readfds, writefds, exceptfds, timeout);
end;

function socketbind(s: TSocketHandle; var name: sockaddr; namelen: Integer): Integer; inline;
begin
  Result := bind(s, name, namelen);
end;

function CheckSocketResult(ResultCode: Integer; const Op: string): Integer;
begin
  if ResultCode < 0 then
  begin
{$IFDEF MSWINDOWS}
    Result := WSAGetLastError;
    if Result <> WSAEWOULDBLOCK then
{$ENDIF}
{$IFDEF POSIX}
    Result := GetLastError;
    if Result <> EWOULDBLOCK then
{$ENDIF}
      raise ESocketError.CreateResFmt(@sSocketError, [SysErrorMessage(Result), Result, Op]);
  end else Result := 0;
end;

{ TIPAddress }

class function TIPAddress.OctetsToN(const B1, B2, B3, B4: Byte): Cardinal;
begin
  Result := (Cardinal(B1) shl 24) or (Cardinal(B2) shl 16) or (Cardinal(B3) shl 8) or Cardinal(B4);
end;

class function TIPAddress.Create(const Address: Cardinal): TIPAddress;
begin
  Result.FAddr.S_addr := htonl(Address);
end;

class function TIPAddress.Create(const Name: string): TIPAddress;
begin
  Result := LookupName(Name);
end;

class function TIPAddress.Create(const B1, B2, B3, B4: Byte): TIPAddress;
begin
  Result.FAddr.S_addr := htonl(OctetsToN(B1, B2, B3, B4));
end;

class function TIPAddress.Create(const Address: in_addr): TIPAddress;
begin
  Result.FAddr := Address;
end;

class function TIPAddress.Create(const Address: TIPAddress; Mask: TIPAddress): TIPAddress;
begin
  Result.FAddr.S_addr := Address.Addr.S_addr or not Mask.Addr.S_addr;
end;

function TIPAddress.GetAddress: string;
begin
  Result := string(inet_ntoa(FAddr));
end;

class function TIPAddress.GetAny: TIPAddress;
begin
  Result.FAddr.S_addr := InAddrAny;
end;

class function TIPAddress.GetBroadcast: TIPAddress;
begin
  Result.FAddr.S_addr := InAddrBroadcast;
end;

class function TIPAddress.GetLocalHost: TIPAddress;
begin
  Result.FAddr.S_addr := InAddrLoopback;
end;

class operator TIPAddress.Implicit(const Address: TIPAddress): in_addr;
begin
  Result := Address.FAddr;
end;

class function TIPAddress.LookupAddress(const Address: string): TIPAddress;
begin
  Result.FAddr.S_addr := inet_addr(MarshaledAString(TEncoding.UTF8.GetBytes(Address)));
end;

class function TIPAddress.LookupName(const Name: string): TIPAddress;
var
  HostEnt: PHostEnt;
begin
  HostEnt := gethostbyname(MarshaledAString(TEncoding.UTF8.GetBytes(Name)));
  FillChar(Result, SizeOf(Result), 0);
  if HostEnt <> nil then
    Result.FAddr.S_addr := PCardinal(HostEnt.h_addr_list^)^;
end;

{ TNetEndpoint }

class procedure TNetEndpoint.SetSize(var EndPoint: TNetEndPoint);
begin
{$IFDEF MACOS}
  EndPoint.FEndPoint.sin_len := SizeOf(EndPoint.FEndPoint);
{$ENDIF}
end;

class function TNetEndpoint.Create(const Address: Cardinal; const Port: Word): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := AF_INET;
  Result.FEndPoint.sin_port := htons(Port);
  Result.FEndPoint.sin_addr.S_addr :=  Address;
end;

class function TNetEndpoint.Create(const Name, Service: string; SocketType: TSocketType): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := AF_INET;
  Result.FEndPoint.sin_addr := TIPAddress.LookupName(Name);
  Result.FEndPoint.sin_port := htons(LookupService(Service, SocketType));
end;

class function TNetEndpoint.Create(const B1, B2, B3, B4: Byte; const Port: Word): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := AF_INET;
  Result.FEndPoint.sin_addr := TIPAddress.Create(B1, B2, B3, B4);
  Result.FEndPoint.sin_port := htons(Port);
end;

class function TNetEndpoint.Create(const Address: TIPAddress; const Port: Word): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := AF_INET;
  Result.FEndPoint.sin_addr := Address;
  Result.FEndPoint.sin_port := htons(Port);
end;

class function TNetEndpoint.Create(const Address: TIPAddress; const Service: string; SocketType: TSocketType): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := AF_INET;
  Result.FEndPoint.sin_addr := Address;
  Result.FEndPoint.sin_port := htons(LookupService(Service, SocketType));
end;

class function TNetEndpoint.Create(const Family: Word; const Address: Cardinal; const Port: Word): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := Family;
  Result.FEndPoint.sin_port := htons(Port);
  Result.FEndPoint.sin_addr.S_addr :=  Address;
end;

class function TNetEndpoint.Create(const Family: Word; const Name, Service: string; SocketType: TSocketType): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := Family;
  Result.FEndPoint.sin_addr := TIPAddress.LookupName(Name);
  Result.FEndPoint.sin_port := htons(LookupService(Service, SocketType));
end;

class function TNetEndpoint.Create(const Family: Word; const B1, B2, B3, B4: Byte; const Port: Word): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := Family;
  Result.FEndPoint.sin_addr := TIPAddress.Create(B1, B2, B3, B4);
  Result.FEndPoint.sin_port := htons(Port);
end;

class function TNetEndpoint.Create(const Family: Word; const Address: TIPAddress; const Port: Word): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := Family;
  Result.FEndPoint.sin_addr := Address;
  Result.FEndPoint.sin_port := htons(Port);
end;

class function TNetEndpoint.Create(const Family: Word; const Address: TIPAddress; const Service: string; SocketType: TSocketType): TNetEndpoint;
begin
  SetSize(Result);
  Result.FEndPoint.sin_family := Family;
  Result.FEndPoint.sin_addr := Address;
  Result.FEndPoint.sin_port := htons(LookupService(Service, SocketType));
end;

class function TNetEndpoint.Create(const Endpoint: sockaddr_in): TNetEndpoint;
begin
  Result.FEndPoint := Endpoint;
end;

function TNetEndpoint.GetAddress: TIPAddress;
begin
  Result := TIPAddress.Create(FEndPoint.sin_addr);
end;

function TNetEndpoint.GetFamily: Word;
begin
  Result := FEndPoint.sin_family;
end;

function TNetEndpoint.GetPort: Word;
begin
  Result := ntohs(FEndPoint.sin_port);
end;

class operator TNetEndpoint.Implicit(const EndPoint: TNetEndpoint): sockaddr_in;
begin
  Result := EndPoint.FEndPoint;
end;

class operator TNetEndpoint.Implicit(const EndPoint: TNetEndpoint): sockaddr;
begin
  Result := sockaddr(EndPoint.FEndPoint);
end;
class operator TNetEndpoint.Implicit(const Endpoint: sockaddr_in): TNetEndpoint;
begin
  Result := TNetEndpoint.Create(Endpoint);
end;

class operator TNetEndpoint.Implicit(const Endpoint: sockaddr): TNetEndpoint;
begin
  Result := TNetEndpoint.Create(sockaddr_in(Endpoint));
end;


class function TNetEndpoint.LookupService(const Service: string; SocketType: TSocketType = TSocketType.TCP): Word;
const
  Proto: array[TSocketType] of MarshaledAString = ('tcp', 'udp', nil, nil, nil);
var
  ServEnt: PServEnt;
begin
  ServEnt := getservbyname(MarshaledAString(TEncoding.UTF8.GetBytes(Service)), Proto[SocketType]);
  if ServEnt <> nil then
    Result := ntohs(ServEnt.s_port)
  else Result := 0;
end;

procedure TNetEndpoint.SetAddress(const B1, B2, B3, B4: Byte);
begin
  FEndPoint.sin_addr.S_addr := TIPAddress.OctetsToN(B1, B2, B3, B4);
end;

procedure TNetEndpoint.SetFamily(const Family: Word);
begin
  FEndPoint.sin_family := Family;
end;

procedure TNetEndpoint.SetAddress(const Address: Cardinal);
begin
  FEndPoint.sin_addr.S_addr := htonl(Address);
end;

procedure TNetEndpoint.SetAddress(const Address: TIPAddress);
begin
  FEndPoint.sin_addr := Address;
end;

procedure TNetEndpoint.SetAddress(const Address: string);
begin
  SetAddress(TIPAddress.LookupName(Address));
end;

procedure TNetEndpoint.SetPort(const Service: string; SocketType: TSocketType);
begin
  SetPort(LookupService(Service, SocketType));
end;

procedure TNetEndpoint.SetPort(const Port: Word);
begin
  FEndPoint.sin_port := htons(Port);
end;

type
  TStaticDynArray<T, J> = record
  private const
    ArraySize = SizeOf(J) div SizeOf(T);
  private type
    TDynArrayHeader = record
    {$IFDEF CPUX64}
      _Padding: Integer; // Make 16 byte align for payload..
    {$ENDIF}
      RefCnt: Integer;
      Length: NativeInt;
    end;
    PT = ^T;
    ArrayType = TArray<T>;
  private
    FHeader: TDynArrayHeader;
    FArray: J;
    procedure SetLength(Value: NativeInt);
    function GetItem(Index: NativeInt): T; inline;
    procedure SetItem(Index: NativeInt; const Value: T); inline;
    function AsMarshaledAString: MarshaledAString; inline;
  public
    procedure Init(InitialLength: NativeInt);
    function IndexOfNull: NativeInt; inline;

    class operator Implicit(const A: TStaticDynArray<T, J>): TArray<T>; inline;
    class operator Implicit(const A: TStaticDynArray<T, J>): MarshaledAString; inline;

    property Length: NativeInt read FHeader.Length write SetLength;
    property Items[Index: NativeInt]: T read GetItem write SetItem;
  end;

{ TStaticDynArray<T, J> }

function TStaticDynArray<T, J>.AsMarshaledAString: MarshaledAString;
begin
  if (SizeOf(T) = 1) and ((GetTypeKind(T) = tkInteger) or (GetTypeKind(T) = tkChar)) then
    Result := MarshaledAString(@FArray)
  else
    raise EInvalidContainer.CreateRes(@sStaticDynArraySizeError);
end;

function TStaticDynArray<T, J>.GetItem(Index: NativeInt): T;
begin
  Result := ArrayType(@FArray)[Index];
end;

class operator TStaticDynArray<T, J>.Implicit(const A: TStaticDynArray<T, J>): TArray<T>;
begin
  Result := ArrayType(@A.FArray);
end;

class operator TStaticDynArray<T, J>.Implicit(const A: TStaticDynArray<T, J>): MarshaledAString;
begin
  Result := A.AsMarshaledAString;
end;

function TStaticDynArray<T, J>.IndexOfNull: NativeInt;
begin
  if SizeOf(T) = 1 then
    Result := System.Length(AsMarshaledAString)
  else if SizeOf(T) = 2 then
    Result := System.Length(PChar(@FArray))
  else
    raise EInvalidContainer.CreateRes(@sStaticDynArraySize);
end;

procedure TStaticDynArray<T, J>.Init(InitialLength: NativeInt);
begin
  if GetTypeKind(J) <> tkArray then
    raise EInvalidContainer.CreateRes(@sStaticDynArrayArrayError);
  FillChar(Self, SizeOf(Self), 0);
  FHeader.RefCnt := -1;
  Self.Length := InitialLength;
end;

procedure TStaticDynArray<T, J>.SetItem(Index: NativeInt; const Value: T);
begin
  PT(@PByte(@FArray)[Index * SizeOf(T)])^ := Value;
end;

procedure TStaticDynArray<T, J>.SetLength(Value: NativeInt);
var
  P: PByte;
begin
  if Value < 0 then
    Value := 0
  else if Value > ArraySize then
    Value := ArraySize;
  P := @FArray;
  if Value > Length then
    FillChar(P[Length * SizeOf(T)], (Value - Length) * SizeOf(T), 0)
  else if IsManagedType(T) then
    if Value < Length then
      FinalizeArray(@P[(Value - 1) * SizeOf(T)], TypeInfo(T), Length - Value);
  FHeader.Length := Value;
end;

{ TSocket }

function TSocket.Accept(Timeout: Cardinal): TSocket;
var
  ClientHandle: TSocketHandle;
  Addr: sockaddr_in;
  Len: Integer;
  FDR: fd_set;
  time: timeval;
  Res: Integer;
begin
  if not (TSocketState.Listening in FState) then
    raise ESocketError.CreateRes(@sSocketNotListening);
  Result := nil;
  if Timeout <> INFINITE then
  begin
    FD_ZERO(FDR);
    _FD_SET(FSocket, FDR);
    time.tv_sec := Timeout div 1000;
    time.tv_usec := (Timeout mod 1000) * 1000;
    Res := socketselect(1, @FDR, nil, nil, @time);
    CheckSocketResult(Res, 'select');
    if Res = 0 then
      Exit;
  end;
  Len := SizeOf(Addr);
  ClientHandle := acceptsocket(FSocket, Addr, Len);
  CheckSocketResult(ClientHandle, 'accept');
  Result := GetClientSocket(ClientHandle, Addr);
end;

procedure TSocket.Bind(const Endpoint: TNetEndpoint);
begin
  if TSocketState.Connected in FState then
    raise ESocketError.CreateRes(@sSocketAlreadyOpen);
  FSocket := CreateSocket;
  if FSocket = InvalidSocket then
    raise ESocketError.CreateRes(@sCannotCreateSocket);
  FAddr := Endpoint;
  DoBind;
end;

function TSocket.BeginReceive(const AsyncCallbackEvent: TAsyncCallbackEvent; Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := TSocketReceiveAsyncResult.Create(Self,
    function: TBytes
    begin
      if Count < 0 then WaitForData;
      Receive(Result, Count, Flags);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginReceive(const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginReceive(AsyncCallbackEvent, -1, Flags);
end;

function TSocket.BeginReceive(const AsyncCallback: TAsyncCallback; Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := TSocketReceiveAsyncResult.Create(Self,
    function: TBytes
    begin
      if Count < 0 then WaitForData;
      Receive(Result, Count, Flags);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginReceive(const AsyncCallback: TAsyncCallback; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginReceive(AsyncCallback, -1, Flags);
end;

function TSocket.BeginReceive(Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginReceive(TAsyncCallback(nil), Count, Flags);
end;

function TSocket.BeginAccept(const AsyncCallback: TAsyncCallback; Timeout: Cardinal): IAsyncResult;
begin
  Result := TSocketAcceptAsyncResult.Create(Self,
    function: TSocket
    begin
      Result := Accept(Timeout);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginAccept(const AsyncCallbackEvent: TAsyncCallbackEvent; Timeout: Cardinal): IAsyncResult;
begin
  Result := TSocketAcceptAsyncResult.Create(Self,
    function: TSocket
    begin
      Result := Accept(Timeout);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginAccept(Timeout: Cardinal): IAsyncResult;
begin
  Result := BeginAccept(TAsyncCallback(nil), Timeout);
end;

function TSocket.BeginConnect(const AsyncCallback: TAsyncCallback; const Name, Address, Service: string; Port: Word): IAsyncResult;
begin
  Result := TSocketConnectResult.Create(Self,
    procedure
    begin
      Connect(Name, Address, Service, Port);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginConnect(const AsyncCallbackEvent: TAsyncCallbackEvent; const Endpoint: TNetEndpoint): IAsyncResult;
var
  LEndpoint: TNetEndpoint;
begin
  LEndpoint := Endpoint;
  Result := TSocketConnectResult.Create(Self,
    procedure
    begin
      Connect(LEndpoint);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginConnect(const AsyncCallbackEvent: TAsyncCallbackEvent; const Name, Address, Service: string; Port: Word): IAsyncResult;
begin
  Result := TSocketConnectResult.Create(Self,
    procedure
    begin
      Connect(Name, Address, Service, Port);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginConnect(const AsyncCallback: TAsyncCallback; const Endpoint: TNetEndpoint): IAsyncResult;
var
  LEndpoint: TNetEndpoint;
begin
  LEndpoint := Endpoint;
  Result := TSocketConnectResult.Create(Self,
    procedure
    begin
      Connect(LEndpoint);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginConnect(const Endpoint: TNetEndpoint): IAsyncResult;
begin
  Result := BeginConnect(TAsyncCallback(nil), Endpoint);
end;

function TSocket.BeginConnect(const Name, Address, Service: string; Port: Word): IAsyncResult;
begin
  Result := BeginConnect(TAsyncCallback(nil), Name, Address, Service, Port);
end;

function TSocket.BeginReceive(Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginReceive(-1, Flags);
end;

function TSocket.BeginReceiveFrom(const AsyncCallbackEvent: TAsyncCallbackEvent; Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := TSocketReceiveFromAsyncResult.Create(Self,
    function (out Endpoint: TNetEndpoint): TBytes
    begin
      if Count < 0 then WaitForData;
      Result := ReceiveFrom(Endpoint, Count, Flags);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginReceiveFrom(const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginReceiveFrom(AsyncCallbackEvent, -1, Flags);
end;

function TSocket.BeginReceiveFrom(const AsyncCallback: TAsyncCallback; Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := TSocketReceiveFromAsyncResult.Create(Self,
    function (out Endpoint: TNetEndpoint): TBytes
    begin
      if Count < 0 then WaitForData;
      Result := ReceiveFrom(Endpoint, Count, Flags);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginReceiveFrom(const AsyncCallback: TAsyncCallback; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginReceiveFrom(AsyncCallback, -1, Flags);
end;

function TSocket.BeginReceiveFrom(Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginReceiveFrom(TAsyncCallback(nil), -1, Flags);
end;

function TSocket.BeginReceiveFrom(Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginReceiveFrom(TAsyncCallback(nil), Count, Flags);
end;

function TSocket.BeginSend(const B: TBytes; const AsyncCallbackEvent: TAsyncCallbackEvent; Offset, Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := TSocketSendAsyncResult.Create(Self,
    function: Integer
    begin
      Result := Send(B, Offset, Count, Flags);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginSend(const S: string; const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags): IAsyncResult;
begin
  Result := TSocketSendAsyncResult.Create(Self,
    function: Integer
    begin
      Result := Send(S, Flags);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginSend(const B: TBytes; const AsyncCallback: TAsyncCallback; Offset, Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := TSocketSendAsyncResult.Create(Self,
    function: Integer
    begin
      Result := Send(B, Offset, Count, Flags);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginSend(const S: string; const AsyncCallback: TAsyncCallback; Flags: TSocketFlags): IAsyncResult;
begin
  Result := TSocketSendAsyncResult.Create(Self,
    function: Integer
    begin
      Result := Send(S, Flags);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginSend(const S: string; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSend(S, TAsyncCallback(nil), Flags);
end;

function TSocket.BeginSend(const B: TBytes; Offset, Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSend(B, TAsyncCallback(nil), Offset, Count, Flags);
end;

function TSocket.BeginSendTo(const B: TBytes; const Endpoint: TNetEndpoint; const AsyncCallback: TAsyncCallback;
  Offset, Count: Integer; Flags: TSocketFlags): IAsyncResult;
var
  LEndpoint: TNetEndpoint;
begin
  LEndpoint := Endpoint;
  Result := TSocketSendAsyncResult.Create(Self,
    function: Integer
    begin
      Result := SendTo(B, LEndpoint, Offset, Count, Flags);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginSendTo(const S: string; const Endpoint: TNetEndpoint; const AsyncCallbackEvent: TAsyncCallbackEvent;
  Flags: TSocketFlags): IAsyncResult;
var
  LEndpoint: TNetEndpoint;
begin
  LEndpoint := Endpoint;
  Result := TSocketSendAsyncResult.Create(Self,
    function: Integer
    begin
      Result := SendTo(S, LEndpoint, Flags);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginSendTo(const S: string; const AsyncCallbackEvent: TAsyncCallbackEvent; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSendTo(S, Endpoint, AsyncCallbackEvent, Flags);
end;

function TSocket.BeginSendTo(const S: string; const Endpoint: TNetEndpoint; const AsyncCallback: TAsyncCallback; Flags: TSocketFlags): IAsyncResult;
var
  LEndpoint: TNetEndpoint;
begin
  LEndpoint := Endpoint;
  Result := TSocketSendAsyncResult.Create(Self,
    function: Integer
    begin
      Result := SendTo(S, LEndpoint, Flags);
    end, AsyncCallback).Invoke;
end;

function TSocket.BeginSendTo(const S: string; const AsyncCallback: TAsyncCallback; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSendTo(S, Endpoint, AsyncCallback, Flags);
end;

function TSocket.BeginSendTo(const B: TBytes; Offset, Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSendTo(B, Endpoint, TAsyncCallback(nil), Offset, Count, Flags);
end;

function TSocket.BeginSendTo(const B: TBytes; const Endpoint: TNetEndpoint; Offset, Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSendTo(B, EndPoint, TAsyncCallback(nil), Offset, Count, Flags);
end;

function TSocket.BeginSendTo(const S: string; const Endpoint: TNetEndpoint; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSendTo(S, EndPoint, TAsyncCallback(nil), Flags);
end;

function TSocket.BeginSendTo(const B: TBytes; const Endpoint: TNetEndpoint; const AsyncCallbackEvent: TAsyncCallbackEvent;
  Offset, Count: Integer; Flags: TSocketFlags): IAsyncResult;
var
  LEndpoint: TNetEndpoint;
begin
  LEndpoint := Endpoint;
  Result := TSocketSendAsyncResult.Create(Self,
    function: Integer
    begin
      Result := SendTo(B, LEndpoint, Offset, Count, Flags);
    end, nil, AsyncCallbackEvent).Invoke;
end;

function TSocket.BeginSendTo(const B: TBytes; const AsyncCallback: TAsyncCallback; Offset, Count: Integer;
  Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSendTo(B, Endpoint, AsyncCallback, Offset, Count, Flags);
end;

function TSocket.BeginSendTo(const B: TBytes; const AsyncCallbackEvent: TAsyncCallbackEvent; Offset, Count: Integer; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSendTo(B, Endpoint, AsyncCallbackEvent, Offset, Count, Flags);
end;

function TSocket.BeginSendTo(const S: string; Flags: TSocketFlags): IAsyncResult;
begin
  Result := BeginSendTo(S, TAsyncCallback(nil), Flags);
end;

procedure TSocket.Bind(Port: Word);
begin
  Bind(TNetEndpoint.Create(TIPAddress.Any, Port));
end;

procedure TSocket.Close(ForceClosed: Boolean);
const
{$IFDEF MSWINDOWS}
  BOTH = SD_BOTH;
{$ENDIF}
{$IFDEF POSIX}
  BOTH = SHUT_RDWR;
{$ENDIF}
var
  Buffer: array[0..1024] of Byte;
begin
  if not (TSocketState.Connected in FState) then
    raise ESocketError.CreateRes(@sSocketAlreadyClosed);
  if not ForceClosed and (FSockType in [TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]) then
  begin
    CheckSocketResult(shutdown(FSocket, BOTH), 'shutdown');
    while recv(FSocket, Buffer, SizeOf(Buffer), 0) > 0 do
  end;
  CheckSocketResult(closesocket(FSocket), 'closesocket');
  FSocket := InvalidSocket;
  FState := [];
end;

{$IFDEF MSWINDOWS}
class constructor TSocket.Create;
var
  Data: WSAData;
begin
  WSAStartup(WINSOCK_VERSION, Data);
end;
{$ENDIF}

procedure TSocket.Close;
begin
  Close(False);
end;

constructor TSocket.Create(ASockType: TSocketType; const AEncoding: TEncoding);
begin
  inherited Create;
  FSocket := InvalidSocket;
  FSockType := ASockType;
  if AEncoding = nil then
    FEncoding := TEncoding.UTF8
  else
    FEncoding := AEncoding;
end;

function TSocket.CreateSocket: TSocketHandle;
const
  _Type: array[TSocketType] of Integer = (SOCK_STREAM, SOCK_DGRAM, SOCK_RAW, SOCK_RDM, SOCK_SEQPACKET);
  Proto: array[TSocketType] of Integer = (IPPROTO_TCP, IPPROTO_UDP, IPPROTO_IP, IPPROTO_IP, IPPROTO_IP);
begin
  Result := socket(PF_INET, _Type[FSockType], Proto[FSockType]);
  CheckSocketResult(Result, 'socket');
end;

constructor TSocket.Create(ASocket: TSocketHandle; const AAddr: sockaddr_in; const AEncoding: TEncoding);
begin
  inherited Create;
  FAddr := AAddr;
  FSocket := ASocket;
  if AEncoding = nil then
    FEncoding := TEncoding.UTF8
  else
    FEncoding := AEncoding;
  FState := [TSocketState.Connected, TSocketState.Client];
end;

destructor TSocket.Destroy;
begin
  if TSocketState.Connected in FState then
    Close;
  inherited;
end;

{$IFDEF MSWINDOWS}
class destructor TSocket.Destroy;
begin
  WSACleanup;
end;
{$ENDIF}

procedure TSocket.DoBind;
begin
  CheckSocketResult(socketbind(FSocket, sockaddr(FAddr), SizeOf(FAddr)), 'bind');
  FState := [TSocketState.Connected];
end;

procedure TSocket.DoListen(QueueSize: Integer);
begin
  DoBind;
  if QueueSize < 0 then QueueSize := SOMAXCONN;
  CheckSocketResult(socketlisten(FSocket, QueueSize), 'listen');
  FState := [TSocketState.Connected, TSocketState.Listening];
end;

function TSocket.EndReceiveStringFrom(const AAsyncResult: IAsyncResult; out AEndPoint: TNetEndPoint): string;
begin
  with AAsyncResult as TSocketReceiveFromAsyncResult do
  begin
    Result := ResultString;
    AEndpoint := EndPoint;
  end;
end;

function TSocket.EndReceiveString(const AAsyncResult: IAsyncResult): string;
var
  Endpoint: TNetEndpoint;
begin
  Result := EndReceiveStringFrom(AAsyncResult, Endpoint);
end;

function TSocket.EndReceiveStringFrom(const AAsyncResult: IAsyncResult): string;
begin
  Result := (AAsyncResult as TSocketReceiveAsyncResult).ResultString;
end;

function TSocket.EndReceiveBytes(const AAsyncResult: IAsyncResult): TBytes;
begin
  Result := (AAsyncResult as TSocketReceiveAsyncResult).ResultBytes;
end;

function TSocket.EndReceiveBytesFrom(const AAsyncResult: IAsyncResult; out AEndPoint: TNetEndPoint): TBytes;
begin
  with AAsyncResult as TSocketReceiveFromAsyncResult do
  begin
    Result := ResultBytes;
    AEndpoint := EndPoint;
  end;
end;

function TSocket.EndAccept(const AAsyncResult: IAsyncResult): TSocket;
begin
  Result := (AAsyncResult as TSocketAcceptAsyncResult).Result;
end;

procedure TSocket.EndConnect(const AAsyncResult: IAsyncResult);
begin
  (AAsyncResult as TSocketConnectResult).WaitForCompletion;
end;

function TSocket.EndReceiveBytesFrom(const AAsyncResult: IAsyncResult): TBytes;
var
  Endpoint: TNetEndpoint;
begin
  Result := EndReceiveBytesFrom(AAsyncResult, Endpoint);
end;

function TSocket.EndSend(const AAsyncResult: IAsyncResult): Integer;
begin
  Result := (AAsyncResult as TSocketSendAsyncResult).Result;
end;

function TSocket.EndSendTo(const AAsyncResult: IAsyncResult): Integer;
begin
  Result := EndSend(AAsyncResult);
end;

procedure TSocket.DoConnect;
begin
  CheckSocketResult(socketconnect(FSocket, sockaddr(FAddr), SizeOf(FAddr)), 'connect');
  FState := [TSocketState.Connected, TSocketState.Client];
end;

function TSocket.GetClientSocket(Handle: TSocketHandle; const Addr: sockaddr_in): TSocket;
begin
  Result := TSocket.Create(Handle, Addr, FEncoding);
end;

function TSocket.GetEndpoint: TNetEndpoint;
begin
  Result := TNetEndpoint.Create(FAddr);
end;

function TSocket.GetLocalAddress: string;
var
  LSockAddr: sockaddr;
  Size: TSockSize;
begin
  Result := '';
  if FSocket = InvalidSocket then Exit;
  Size := SizeOf(LSockAddr);
  if getsockname(FSocket, LSockAddr, Size) = 0 then
    Result := string(inet_ntoa(sockaddr_in(LSockAddr).sin_addr));
end;

function TSocket.GetLocalEndpoint: TNetEndpoint;
var
  LSockAddr: sockaddr;
  Size: TSockSize;
begin
  FillChar(LSockAddr, SizeOf(LSockAddr), 0);
  if FSocket <> InvalidSocket then
  begin
    Size := SizeOf(LSockAddr);
    getsockname(FSocket, LSockAddr, Size);
  end;
  Result := LSockAddr;
end;

function TSocket.GetLocalHost: string;
var
  LocalName: TStaticDynArray<Byte, array[0..255] of Byte>;
begin
  Result := '';
  if FSocket = InvalidSocket then Exit;
  LocalName.Init(256);
  if gethostname(LocalName, LocalName.Length) = 0 then
    Result := TEncoding.Default.GetString(LocalName, 0, LocalName.IndexOfNull);
end;

function TSocket.GetLocalPort: Integer;
var
  LSockAddr: sockaddr;
  Size: TSockSize;
begin
  Result := -1;
  if FSocket = InvalidSocket then Exit;
  Size := SizeOf(LSockAddr);
  if getsockname(FSocket, LSockAddr, Size) = 0 then
    Result := ntohs(sockaddr_in(LSockAddr).sin_port);
end;

function TSocket.GetRemoteAddress: string;
var
  LSockAddr: sockaddr;
  Size: TSockSize;
begin
  Result := '';
  if not (TSocketState.Connected in FState) then Exit;
  Size := SizeOf(LSockAddr);
  CheckSocketResult(getpeername(FSocket, LSockAddr, Size), 'getpeername');
  Result := string(inet_ntoa(sockaddr_in(LSockAddr).sin_addr));
end;

function TSocket.GetRemoteEndpoint: TNetEndpoint;
var
  Size: TSockSize;
  SA: sockaddr_in;
begin
  FillChar(SA, SizeOf(SA), 0);
  if TSocketState.Connected in FState then
  begin
    Size := SizeOf(SA);
    if getpeername(FSocket, sockaddr(SA), Size) <> 0 then
      FillChar(SA, SizeOf(SA), 0);
  end;
  Result := SA;
end;

function TSocket.GetRemoteHost: string;
var
  LSockAddr: sockaddr;
  Size: TSockSize;
  HostEnt: PHostEnt;
begin
  Result := '';
  if not (TSocketState.Connected in FState) then Exit;
  Size := SizeOf(LSockAddr);
  CheckSocketResult(getpeername(FSocket, LSockAddr, Size), 'getpeername');
  HostEnt := gethostbyaddr(sockaddr_in(LSockAddr).sin_addr.s_addr, 4, PF_INET);
  if HostEnt <> nil then
    Result := string(HostEnt.h_name);
end;

function TSocket.GetRemotePort: Integer;
var
  LSockAddr: sockaddr;
  Size: TSockSize;
begin
  Result := 0;
  if not (TSocketState.Connected in FState) then Exit;
  Size := SizeOf(LSockAddr);
  CheckSocketResult(getpeername(FSocket, LSockAddr, Size), 'getpeername');
  Result := ntohs(sockaddr_in(LSockAddr).sin_port);
end;

function TSocket.InitSocket(const Name, Address, Service: string; Port: Word; Client, Broadcast: Boolean): sockaddr_in;

  function AddressToBytes(const S: string): TBytes;
  var
    Len: Integer;
  begin
    Len := Length(S) + 1;
    SetLength(Result, Len);
    FEncoding.GetBytes(S, Low(S), Len - 1, Result, 0);
  end;

begin
  Result.sin_family := PF_INET;
  if Name <> '' then
    Result.sin_addr := LookupName(name)
  else if Address <> '' then
    Result.sin_addr.s_addr := inet_addr(MarshaledAString(AddressToBytes(Address)))
  else if Broadcast then
    Result.sin_addr.s_addr := INADDR_BROADCAST
  else if not Client then
    Result.sin_addr.s_addr := INADDR_ANY;

  if Result.sin_addr.s_addr = INADDR_NONE then
    raise ESocketError.CreateRes(@sNoAddress);

  if Service <> '' then
    Result.sin_port := htons(LookupService(Service))
  else
    Result.sin_port := htons(Port);
end;

function TSocket.InternalConvertFlags(Flags: TSocketFlags): Integer;
const
  FlagValues: array[TSocketFlag] of Integer = (MSG_OOB, MSG_PEEK, MSG_DONTROUTE, MSG_WAITALL);
var
  F: TSocketFlag;
begin
  Result := 0;
  for F := Low(TSocketFlag) to High(TSocketFlag) do
    if F in Flags then
      Result := Result or FlagValues[F];
end;

procedure TSocket.Listen(const Address, Service: string; Port: Word; QueueSize: Integer);
begin
  if TSocketState.Connected in FState then
    raise ESocketError.CreateRes(@sCannotListenOnOpen);
  FSocket := CreateSocket;
  if FSocket = InvalidSocket then
    raise ESocketError.CreateRes(@sCannotCreateSocket);
  FAddr := InitSocket('', Address, Service, Port, False);
  if FSockType in [TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ] then
    DoListen(QueueSize)
  else
    DoBind;
end;

procedure TSocket.Listen(const Endpoint: TNetEndpoint; QueueSize: Integer);
begin
  if TSocketState.Connected in FState then
    raise ESocketError.CreateRes(@sCannotListenOnOpen);
  FSocket := CreateSocket;
  if FSocket = InvalidSocket then
    raise ESocketError.CreateRes(@sCannotCreateSocket);
  FAddr := Endpoint;
  if FSockType in [TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ] then
    DoListen(QueueSize)
  else
    DoBind;
end;

procedure TSocket.ListenBroadcast(const Endpoint: TNetEndpoint);
begin
  if TSocketState.Connected in FState then
    raise ESocketError.CreateRes(@sSocketAlreadyOpen);
  if FSockType <> TSocketType.UDP then
    raise ESocketError.CreateRes(@sBroadcastOnUDPOnly);
  FSocket := CreateSocket;
  FAddr := Endpoint;
  DoBind;
end;

procedure TSocket.ListenBroadcast(Port: Word);
begin
  ListenBroadcast(TNetEndpoint.Create(TIPAddress.Any, Port));
end;

function TSocket.LookupName(const name: string): TIPAddress;
begin
  Result := TIPAddress.LookupName(name);
end;

function TSocket.LookupService(const service: string): Integer;
begin
  Result := TNetEndpoint.LookupService(service, FSockType);
end;

procedure TSocket.Connect(const Name, Address, Service: string; Port: Word);
begin
  if TSocketState.Connected in FState then
    raise ESocketError.CreateRes(@sSocketAlreadyOpen);
  FSocket := CreateSocket;
  FAddr := InitSocket(Name, Address, Service, Port, True);
  if FSockType in [TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ] then
    DoConnect
  else
    DoBind;
end;

procedure TSocket.Connect(const EndPoint: TNetEndpoint);
begin
  if TSocketState.Connected in FState then
    raise ESocketError.CreateRes(@sSocketAlreadyOpen);
  FSocket := CreateSocket;
  FAddr := Endpoint;
  if FSockType in [TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ] then
    DoConnect
  else
    DoBind;
end;

function TSocket.ConvertFlags(Flags: TSocketFlags): Integer;
begin
  Result := 0;
  if Flags <> [] then
    Result := InternalConvertFlags(Flags);
end;

procedure TSocket.OpenBroadcast(const Endpoint: TNetEndpoint);
var
  OptVal: Integer;
begin
  if TSocketState.Connected in FState then
    raise ESocketError.CreateRes(@sSocketAlreadyOpen);
  if FSockType <> TSocketType.UDP then
    raise ESocketError.CreateRes(@sBroadcastOnUDPOnly);
  FSocket := CreateSocket;
  OptVal := 1;
  CheckSocketResult(setsocketoption(FSocket, SOL_SOCKET, SO_BROADCAST, OptVal, SizeOf(OptVal)), 'setsockopt');
  FAddr := Endpoint;
  FState := [TSocketState.Connected];
end;

procedure TSocket.OpenBroadcast(Port: Word);
begin
  OpenBroadcast(TNetEndpoint.Create(TIPAddress.Broadcast, Port));
end;

function TSocket.Receive(var Buf; Count, Flags: Integer): Integer;
var
  LCount: Integer;
begin
  if TSocketState.Connected in FState then
  begin
    ValidSocketTypes([TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]);
    if Count = -1 then
      CheckSocketResult(ioctlsocket(FSocket, FIONREAD, Cardinal(Result)), 'ioctlsocket')
    else
    begin
      if ioctlsocket(FSocket, FIONREAD, Cardinal(LCount)) = 0 then
      begin
        if (LCount > 0) and (LCount < Count) then
          Count := LCount;
      end;
      Result := recv(FSocket, Buf, Count, Flags);
      CheckSocketResult(Result, 'recv');
    end;
  end else
    Result := -1;
end;

function TSocket.Receive(var Buf; Count: Integer; Flags: TSocketFlags): Integer;
begin
  Result := Receive(Buf, Count, ConvertFlags(Flags));
end;

function TSocket.Receive(out Bytes: TBytes; Count: Integer; Flags: TSocketFlags): Integer;
var
  Available: Integer;
begin
  if TSocketState.Connected in FState then
  begin
    ValidSocketTypes([TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]);
    Available := ReceiveLength;
    if Count < 0 then
      Count := Available;
    SetLength(Bytes, Count);
    while Count > 0 do
    begin
      Dec(Count, Receive(Bytes[Length(Bytes) - Count], Available, Flags));
      if Count > 0 then
        Available := ReceiveLength;
    end;
    Result := Length(Bytes);
  end else
    Result := -1;
end;

function TSocket.Receive(var Bytes: array of Byte; Offset, Count: Integer; Flags: TSocketFlags): Integer;
var
  Available: Integer;
begin
  if TSocketState.Connected in FState then
  begin
    ValidSocketTypes([TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]);
    Available := ReceiveLength;
    if Count < 0 then
      Count := Available;
    if Count > Length(Bytes) - Offset then
      Count := Length(Bytes) - Offset;
    Result := Count;
    while Count > 0 do
    begin
      Dec(Count, Receive(Bytes[Offset + (Length(Bytes) - Count)], Available, Flags));
      if Count > 0 then
        Available := ReceiveLength;
    end;
  end else
    Result := -1;
end;

function TSocket.Receive(Count: Integer; Flags: TSocketFlags): TBytes;
begin
  Receive(Result, Count, Flags);
end;

function TSocket.ReceiveStringFrom(out Endpoint: TNetEndpoint; Flags: TSocketFlags): string;
var
  Bytes: TBytes;
begin
  SetLength(Bytes, ReceiveFrom(Pointer(nil)^, -1));
  if Length(Bytes) > 0 then
  begin
    ReceiveFrom(Pointer(Bytes)^, Length(Bytes), Endpoint, Flags);
    Result := FEncoding.GetString(Bytes);
  end else
    Result := '';
end;

function TSocket.ReceiveFrom(var Buf; Count: Integer; out Endpoint: TNetEndpoint; Flags: Integer): Integer;
{$IF not Declared(socklen_t)}
type
  socklen_t = Integer;
{$ENDIF}
var
  LCount: Integer;
  LAddr: sockaddr_in;
  LAddrLen: socklen_t;
begin
  if TSocketState.Connected in FState then
  begin
//    ValidSocketTypes([TSocketType.UDP]);
    if Count < 0 then
      CheckSocketResult(ioctlsocket(FSocket, FIONREAD, Cardinal(Result)), 'ioctlsocket')
    else
    begin
      if ioctlsocket(FSocket, FIONREAD, Cardinal(LCount)) = 0 then
      begin
        if (LCount > 0) and (LCount < Count) then
          Count := LCount;
      end;
      LAddrLen := SizeOf(LAddr);
      FillChar(LAddr, SizeOf(LAddr), 0);
      Result := recvfrom(FSocket, Buf, Count, Flags, sockaddr(LAddr), LAddrLen);
      CheckSocketResult(Result, 'recvfrom');
      Endpoint := LAddr;
    end;
  end else
    Result := -1;
end;

function TSocket.ReceiveFrom(var Buf; Count: Integer; out Endpoint: TNetEndpoint; Flags: TSocketFlags): Integer;
begin
  Result := ReceiveFrom(Buf, Count, EndPoint, ConvertFlags(Flags));
end;

function TSocket.ReceiveFrom(var Bytes: array of Byte; out Endpoint: TNetEndpoint; Offset, Count: Integer; Flags: TSocketFlags): Integer;
var
  Available: Integer;
begin
  if TSocketState.Connected in FState then
  begin
//    ValidSocketTypes([TSocketType.UDP]);
    Available := ReceiveFrom(Pointer(nil)^, -1);
    if Count < 0 then
      Count := Available;
    if Count > Length(Bytes) - Offset then
      Count := Length(Bytes) - Offset;
    Result := Count;
    while Count > 0 do
    begin
      Dec(Count, ReceiveFrom(Bytes[Offset + (Length(Bytes) - Count)], Available, Endpoint, Flags));
      if Count > 0 then
        Available := ReceiveFrom(Pointer(nil)^, -1);
    end;
  end else
    Result := -1;
end;

function TSocket.ReceiveFrom(Count: Integer; Flags: TSocketFlags): TBytes;
begin
  ReceiveFrom(Result, Count, Flags);
end;

function TSocket.ReceiveFrom(out Bytes: TBytes; out Endpoint: TNetEndpoint; Count: Integer; Flags: TSocketFlags): Integer;
var
  Available: Integer;
begin
  if TSocketState.Connected in FState then
  begin
//    ValidSocketTypes([TSocketType.UDP]);
    Available := ReceiveFrom(Pointer(nil)^, -1);
    if Count < 0 then
      Count := Available;
    SetLength(Bytes, Count);
    while Count > 0 do
    begin
      Dec(Count, ReceiveFrom(Bytes[Length(Bytes) - Count], Available, Endpoint, Flags));
      if Count > 0 then
        Available := ReceiveFrom(Pointer(nil)^, -1);
    end;
    Result := Length(Bytes);
  end else
    Result := -1;
end;

function TSocket.ReceiveFrom(out Endpoint: TNetEndpoint; Count: Integer; Flags: TSocketFlags): TBytes;
begin
  ReceiveFrom(Result, Endpoint, Count, Flags);
end;

function TSocket.ReceiveStringFrom(Flags: TSocketFlags): string;
var
  Endpoint: TNetEndpoint;
begin
  Result := ReceiveStringFrom(Endpoint, Flags);
end;

function TSocket.ReceiveFrom(out Bytes: TBytes; Count: Integer; Flags: TSocketFlags): Integer;
var
  Endpoint: TNetEndpoint;
begin
  Result := ReceiveFrom(Bytes, Endpoint, Count, Flags);
end;

function TSocket.ReceiveFrom(var Bytes: array of Byte; Offset, Count: Integer; Flags: TSocketFlags): Integer;
var
  Endpoint: TNetEndpoint;
begin
  Result := ReceiveFrom(Bytes, Endpoint, Offset, Count, Flags);
end;

function TSocket.ReceiveFrom(var Buf; Count, Flags: Integer): Integer;
{$IF not Declared(socklen_t)}
type
  socklen_t = Integer;
{$ENDIF}
var
  LCount: Integer;
  LAddr: sockaddr_in;
  LAddrLen: socklen_t;
begin
  if TSocketState.Connected in FState then
  begin
//    ValidSocketTypes([TSocketType.UDP]);
    if Count < 0 then
      CheckSocketResult(ioctlsocket(FSocket, FIONREAD, Cardinal(Result)), 'ioctlsocket')
    else
    begin
      if ioctlsocket(FSocket, FIONREAD, Cardinal(LCount)) = 0 then
      begin
        if (LCount > 0) and (LCount < Count) then
          Count := LCount;
      end;
      LAddrLen := SizeOf(LAddr);
      FillChar(LAddr, SizeOf(LAddr), 0);
      Result := recvfrom(FSocket, Buf, Count, Flags, sockaddr(LAddr), LAddrLen);
      CheckSocketResult(Result, 'recvfrom');
    end;
  end else
    Result := -1;
end;

function TSocket.ReceiveFrom(var Buf; Count: Integer; Flags: TSocketFlags): Integer;
begin
  Result := ReceiveFrom(Buf, Count, ConvertFlags(Flags));
end;

function TSocket.ReceiveLength: Integer;
begin
  Result := Receive(Pointer(nil)^, -1);
end;

function TSocket.ReceiveString(Flags: TSocketFlags): string;
var
  Bytes: TBytes;
begin
  SetLength(Bytes, ReceiveLength);
  if Length(Bytes) > 0 then
  begin
    Receive(Bytes[0], Length(Bytes), Flags);
    Result := FEncoding.GetString(Bytes);
  end else
    Result := '';
end;

function TSocket.Send(const Buf; Count, Flags: Integer): Integer;
begin
  if TSocketState.Connected in FState then
  begin
    ValidSocketTypes([TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]);
    Result := socketsend(FSocket, Buf, Count, Flags);
    CheckSocketResult(Result, 'send');
  end else
    Result := -1;
end;

function TSocket.Send(const Buf; Count: Integer; Flags: TSocketFlags): Integer;
begin
  Result := Send(Buf, Count, ConvertFlags(Flags));
end;

class function TSocket.Select(const CheckRead, CheckWrite, CheckError: PFDSet; Microseconds: Int64): TWaitResult;
var
  ReadFds, WriteFds, ErrorFds: PFd_Set;
  time: timeval;
  TimePtr: ^timeval;
  Res: Integer;

  function GetFds(const ASet: PFDSet): PFd_Set; inline;
  begin
    if ASet <> nil then
      Result := ASet.GetFdSet
    else
      Result := nil;
  end;

  function GetMaxFds(const ASet: PFDSet): Integer; inline;
  begin
    if ASet <> nil then
      Result := ASet.GetMaxFd
    else
      Result := 0;
  end;

begin
  ReadFds := GetFds(CheckRead);
  WriteFds := GetFds(CheckWrite);
  ErrorFds := GetFds(CheckError);
  if Microseconds >= 0 then
  begin
    time.tv_sec := Microseconds div 1000000;
    time.tv_usec := Microseconds mod 1000000;
    TimePtr := @time;
  end else
    TimePtr := nil;
  Res := socketselect(Max(GetMaxFds(CheckRead), Max(GetMaxFds(CheckWrite), GetMaxFds(CheckError))) + 1, ReadFds, WriteFds, ErrorFds, PTimeVal(TimePtr));
  CheckSocketResult(Res, 'select');
  if Res = 0 then
    Result := TWaitResult.wrTimeout
  else
    Result := TWaitResult.wrSignaled;
end;

function TSocket.Send(const B: array of Byte; Offset, Count: Integer; Flags: TSocketFlags): Integer;
begin
  if TSocketState.Connected in FState then
  begin
    ValidSocketTypes([TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]);
    if Count > Length(B) - Offset then
      Count := Length(B) - Offset;
    Result := Send(B[Offset], Count, Flags);
  end else
    Result := -1;
end;

function TSocket.Send(const B: TBytes; Offset, Count: Integer; Flags: TSocketFlags): Integer;
begin
  if TSocketState.Connected in FState then
  begin
    ValidSocketTypes([TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]);
    if Count > Length(B) - Offset then
      Count := Length(B) - Offset;
    Result := Send(B[Offset], Count, Flags);
  end else
    Result := -1;
end;

function TSocket.SendTo(const Buf; Count: Integer; const Endpoint: TNetEndpoint; Flags: Integer): Integer;
begin
  if TSocketState.Connected in FState then
  begin
//    ValidSocketTypes([TSocketType.UDP]);
    Result := socketsendto(FSocket, Buf, Count, Flags, Endpoint, SizeOf(Endpoint));
    CheckSocketResult(Result, 'sendto');
  end else
    Result := -1;
end;

function TSocket.SendTo(const Buf; Count: Integer; const Endpoint: TNetEndpoint; Flags: TSocketFlags): Integer;
begin
  Result := SendTo(Buf, Count, EndPoint, ConvertFlags(Flags));
end;

function TSocket.SendTo(const S: string; const Endpoint: TNetEndpoint; Flags: TSocketFlags): Integer;
var
  B: TBytes;
begin
  if TSocketState.Connected in FState then
  begin
//    ValidSocketTypes([TSocketType.UDP]);
    B := FEncoding.GetBytes(S);
    Result := SendTo(Pointer(B)^, Length(B), Endpoint, Flags);
  end else
    Result := -1;
end;

function TSocket.SendTo(const B: array of Byte; const Endpoint: TNetEndpoint; Offset, Count: Integer; Flags: TSocketFlags): Integer;
begin
  if TSocketState.Connected in FState then
  begin
//    ValidSocketTypes([TSocketType.UDP]);
    if (Count < 0) or (Count > Length(B) - Offset) then
      Count := Length(B) - Offset;
    Result := SendTo(B[Offset], Count, Endpoint, Flags);
  end else
    Result := -1;
end;

function TSocket.SendTo(const Buf; Count, Flags: Integer): Integer;
begin
  Result := SendTo(Buf, Count, TNetEndpoint(FAddr), Flags);
end;

function TSocket.SendTo(const Buf; Count: Integer; Flags: TSocketFlags): Integer;
begin
  Result := SendTo(Buf, Count, TNetEndpoint(FAddr), Flags);
end;

function TSocket.SendTo(const S: string; Flags: TSocketFlags): Integer;
begin
  Result := SendTo(S, TNetEndpoint(FAddr), Flags);
end;

function TSocket.SendTo(const B: array of Byte; Offset, Count: Integer; Flags: TSocketFlags): Integer;
begin
  Result := SendTo(B, TNetEndpoint(FAddr), Offset, Count);
end;

procedure TSocket.ValidSocketTypes(SocketTypes: TSocketTypes);
begin
  if not (FSockType in SocketTypes) then
    raise ESocketError.CreateRes(@sIncorrectSocketType);
end;

function TSocket.WaitForData(ATimeout: Cardinal): TWaitResult;
var
  ReadFds: TFDSet;
  LTimeout: Int64;
begin
  ReadFds := TFDSet.Create(Self);
  if ATimeout <> INFINITE then
    LTimeout := ATimeout * 1000
  else
    LTimeout := -1;
  Result := Select(ReadFds, nil, nil, LTimeout);
end;

function TSocket.Send(const S: string; Flags: TSocketFlags): Integer;
var
  B: TBytes;
begin
  if TSocketState.Connected in FState then
  begin
    ValidSocketTypes([TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]);
    B := FEncoding.GetBytes(S);
    Result := Send(B[0], Length(B), Flags);
  end else
    Result := -1;
end;

{ TSocketStream }

constructor TSocketStream.Create(const ASocket: TSocket; AOwnsSocket: Boolean);
begin
  inherited Create;
  ASocket.ValidSocketTypes([TSocketType.TCP, TSocketType.RAW, TSocketType.RDM, TSocketType.SEQ]);
  FOwnsSocket := AOwnsSocket;
  FSocket := ASocket;
end;

destructor TSocketStream.Destroy;
begin
  if FOwnsSocket then
    FSocket.DisposeOf;
  inherited;
end;

function TSocketStream.Read(var Buffer; Count: LongInt): LongInt;
begin
  Result := FSocket.Receive(Buffer, Count);
end;

function TSocketStream.Write(const Buffer; Count: LongInt): LongInt;
begin
  Result := FSocket.Send(Buffer, Count);
end;

{ TFDSet }

class function TFDSet.Create: TFDSet;
begin
  Result := TFDSet.Create([]);
end;

class function TFDSet.Create(const Sockets: array of TSocket): TFDSet;
begin
  Result := TFDSet.CreateNew(Sockets);
end;

procedure TFDSet.Clear(const AHandle: TSocketHandle);
begin
  FD_CLR(AHandle, FFDSet)
end;

class function TFDSet.Create(const Socket: TSocket): TFDSet;
begin
  Result := TFDSet.Create([Socket]);
end;

class function TFDSet.CreateNew(const Sockets: array of TSocket): TFDSet;
var
  I: Integer;
begin
  FD_ZERO(Result.FFDSet);
{$IFDEF POSIX}
  Result.FNFds := 0;
{$ENDIF}
  if Length(Sockets) > FD_SETSIZE then
    raise ESocketError.CreateResFmt(@sFDSetSizeTooLarge, [FD_SETSIZE]);
  for I := Low(Sockets) to High(Sockets) do
    Result.&Set(Sockets[I]);
end;

procedure TFDSet.ValidateHandle(const ASocket: TSocket);
begin
  if ASocket.Handle = InvalidSocket then
    raise ESocketError.CreateRes(@sSocketNotValid);
end;

procedure TFDSet.&Set(const AHandle: TSocketHandle);
begin
{$IFDEF POSIX}
  if FNFds < AHandle then
    FNFds := AHandle;
{$ENDIF}
{$IFDEF MSWINDOWS}
  if FFDSet.fd_count >= FD_SETSIZE then
    raise ESocketError.CreateResFmt(@sFDSetSizeTooLarge, [FD_SETSIZE]);
{$ENDIF}
  _FD_SET(AHandle, FFDSet);
end;

procedure TFDSet.Clear(const ASocket: TSocket);
begin
  ValidateHandle(ASocket);
  Clear(ASocket.Handle);
end;

class operator TFDSet.Implicit(const [Ref] AFDSet: TFDSet): PFDSet;
begin
  Result := @AFDSet;
end;

function TFDSet.IsSet(const AHandle: TSocketHandle): Boolean;
begin
  Result := FD_ISSET(AHandle, FFDSet);
end;

function TFDSet.IsSet(const ASocket: TSocket): Boolean;
begin
  ValidateHandle(ASocket);
  Result := IsSet(ASocket.Handle);
end;

procedure TFDSet.&Set(const ASocket: TSocket);
begin
  ValidateHandle(ASocket);
  &Set(ASocket.Handle);
end;

procedure TFDSet.Zero;
begin
  FD_ZERO(FFDSet);
end;

function TFDSet.GetFdSet: PFd_Set;
begin
  Result := @FFDSet;
end;

function TFDSet.GetMaxFd: Integer;
begin
{$IFDEF MSWINDOWS}
  Result := FFDSet.fd_count - 1;
{$ENDIF}
{$IFDEF POSIX}
  Result := FNFds;
{$ENDIF}
end;

{ TSocket.TSocketAsyncResult }

procedure TSocket.TSocketAsyncResult.Complete;
begin
  inherited Complete;
  if Assigned(FAsyncCallback) then
    FAsyncCallback(Self as IAsyncResult)
  else if Assigned(FAsyncCallbackEvent) then
    FAsyncCallbackEvent(Self as IAsyncResult);
end;

constructor TSocket.TSocketAsyncResult.Create(const AContext: TObject;
  const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
begin
  inherited Create(AContext);
  FAsyncCallback := AAsyncCallback;
  FAsyncCallbackEvent := AAsyncCallbackEvent;
end;

function TSocket.TSocketAsyncResult.GetSocket: TSocket;
begin
  Result := Context as TSocket;
end;

procedure TSocket.TSocketAsyncResult.Schedule;
begin
  TTask.Run(DoAsyncDispatch);
end;

{ TSocket.TSocketReceiveAsyncResult }

procedure TSocket.TSocketReceiveAsyncResult.AsyncDispatch;
begin
  FResult := FBytesFunc;
end;

constructor TSocket.TSocketReceiveAsyncResult.Create(const AContext: TObject; const ABytesFunc: TFunc<TBytes>;
  const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
begin
  inherited Create(AContext, AAsyncCallback, AAsyncCallbackEvent);
  if not Assigned(ABytesFunc) then
    raise EArgumentNilException.CreateRes(@sFunctionNil);
  FBytesFunc := ABytesFunc;
end;

function TSocket.TSocketReceiveAsyncResult.GetResultBytes: TBytes;
begin
  WaitForCompletion;
  Result := FResult;
end;

function TSocket.TSocketReceiveAsyncResult.GetResultString: string;
var
  Bytes: TBytes;
begin
  Bytes := GetResultBytes;
  Result := Socket.Encoding.GetString(Bytes);
end;

{ TSocket.TSocketSendAsyncResult }

procedure TSocket.TSocketSendAsyncResult.AsyncDispatch;
begin
  FResult := FFunc;
end;

constructor TSocket.TSocketSendAsyncResult.Create(const AContext: TObject; const AFunc: TFunc<Integer>;
  const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
begin
  inherited Create(AContext, AAsyncCallback, AAsyncCallbackEvent);
  if not Assigned(AFunc) then
    raise EArgumentNilException.CreateRes(@sFunctionNil);
  FFunc := AFunc;
end;

function TSocket.TSocketSendAsyncResult.GetResult: Integer;
begin
  WaitForCompletion;
  Result := FResult;
end;

{ TSocket.TSocketReceiveFromAsyncResult }

procedure TSocket.TSocketReceiveFromAsyncResult.AsyncDispatch;
begin
  FResult := FReceiveFromFunc(FNetEndpoint);
end;

constructor TSocket.TSocketReceiveFromAsyncResult.Create(const AContext: TObject;
  const AReceiveFromFunc: TReceiveFromFunc; const AAsyncCallback: TAsyncCallback = nil; AAsyncCallbackEvent: TAsyncCallbackEvent = nil);
begin
  inherited Create(AContext, AAsyncCallback, AAsyncCallbackEvent);
  if not Assigned(AReceiveFromFunc) then
    raise EArgumentNilException.CreateRes(@sFunctionNil);
  FReceiveFromFunc := AReceiveFromFunc;
end;

function TSocket.TSocketReceiveFromAsyncResult.GetResultBytes: TBytes;
begin
  WaitForCompletion;
  Result := FResult;
end;

function TSocket.TSocketReceiveFromAsyncResult.GetResultString: string;
var
  Bytes: TBytes;
begin
  Bytes := GetResultBytes;
  Result := Socket.Encoding.GetString(Bytes);
end;

{ TSocket.TSocketAcceptAsyncResult }

procedure TSocket.TSocketAcceptAsyncResult.AsyncDispatch;
begin
  FResult := FFunc;
end;

constructor TSocket.TSocketAcceptAsyncResult.Create(const AContext: TObject; const AFunc: TFunc<TSocket>;
  const AAsyncCallback: TAsyncCallback; AAsyncCallbackEvent: TAsyncCallbackEvent);
begin
  inherited Create(AContext, AAsyncCallback, AAsyncCallbackEvent);
  FFunc := AFunc;
end;

function TSocket.TSocketAcceptAsyncResult.GetResult: TSocket;
begin
  Result := FResult;
end;

{ TSocket.TSocketSendConnectResult }

procedure TSocket.TSocketConnectResult.AsyncDispatch;
begin
  FProc;
end;

constructor TSocket.TSocketConnectResult.Create(const AContext: TObject; const AProc: TProc;
  const AAsyncCallback: TAsyncCallback; AAsyncCallbackEvent: TAsyncCallbackEvent);
begin
  inherited Create(AContext, AAsyncCallback, AAsyncCallbackEvent);
  FProc := AProc;
end;

end.
