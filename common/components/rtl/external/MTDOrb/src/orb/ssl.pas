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
unit ssl;

interface

uses
  transp,orbtypes,Classes,addr_int,code_int,SysUtils,ior,ssl_int,iior_int,
  {$IFDEF WIN32}Windows, WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF}, mcomp_int,
  comp_int, disp_int, MtDorbSSLOpenSSLHeaders, Intercept, orb_int, Intercept_int,
  orbcomp;

{$I dorb.inc}

{$IFNDEF USELIB}

type
  TSSLPrincipal = class(TPrincipal, ISSLPrincipal)
    FPeer: PX509;
    FSSLCipher: string;
    class function get_x509_entry(name: PX509_NAME; const entry: string): string;
  protected
    function get_property(const prop_name: string): IAny; override;
  public
    constructor Create(peer: PX509; const cipher: string; transp: ITransport = nil);
    destructor Destroy; override;
  end;

  TSSLAddress = class(TInterfacedObject, IAddress, ISSLAddress)
  private
    FAddr: IAddress;
  protected
    { IAddress }
    function compare(const addr: IAddress): Boolean;
    function proto(): AnsiString;
    function toString(): AnsiString;
    function make_transport(): ITransport;
    function make_transport_server(): ITransportServer;
    function make_ior_profile(const key: AnsiString; const len: _ulong;const mc: IInterface; const version: _ushort): IInterface;
    function is_local(): Boolean;
    function socketaddress(): TSockAddrIn;
    procedure set_socketaddress(val:TSockAddrIn);
    function resolve_ip(): Boolean;
    function valid: Boolean;
    { ISSLAddress }
    function content(): IAddress;
    procedure set_content(const addr: IAddress);
  public
    constructor Create(Addr: IAddress);
  end;

  TSSLAddressParser = class(TInterfacedObject, IAddressParser)
  protected
    function has_protocol(const str: AnsiString): Boolean;
    function parse(const rest: AnsiString; const proto: AnsiString): IAddress;
  public
    constructor Create();
    destructor Destroy(); override;
  end;

  TSSLProfile = class(TInterfacedObject, IIORProfile, ISSLProfile)
  private
    FIORProfile: IIORProfile;
    FAddr: ISSLAddress;
  protected
    { IIORProfile }
    function address(): IAddress;
    procedure encode(const enc: IEncoder);
    function id(): ProfileID;
    function encode_id(): ProfileId;
    function clone(): IIORProfile;
    procedure print(s: TStream);
    function objkeylen: _ulong;
    function objkey(var len: _ulong): Identifier;
    procedure set_objectkey(const val: Identifier; const len : _ulong);
    function reachable(): boolean;
    function compare(const p: IIORProfile): boolean;
    function get_components(): IInterface;
    { ISSLProfile }
    function IORProfile(): IIORProfile;
  public
    constructor Create(const objkey: AnsiString; len: _ulong; addr: ISSLAddress; mc: IMultiComponent; const version: _ushort); overload;
    constructor Create(ior: IIORProfile; addr: ISSLAddress); overload;
    constructor Create(sslprof: ISSLProfile); overload;
  end;

  TSSLProfileDecoder = class(TInterfacedObject, IIORProfileDecoder)
  protected
    function has_id(id: ProfileID): Boolean;
    function decode(const dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile;
  public
    constructor Create();
    destructor Destroy(); override;
  end;

  TSSLComponent = class(TInterfacedObject, IORBComponent, ISSLComponent)
  private
    FTargetSupports,
    FTargetRequires: AssociationOptions;
    FPort: _ushort;
    FId : ComponentID;
  protected
    { IORBComponent }
    procedure print(s: TStream);
    procedure encode(const enc: IEncoder);
    function _id(): ComponentID;
    procedure set_id(id:ComponentID);
    { ISSLComponent }
    function port(): _ushort;
  public
    constructor Create(port: _ushort; target_sup: AssociationOptions = 0;
      target_req: AssociationOptions = 0);
  end;

  TSSLComponentDecoder = class(TInterfacedObject, IORBComponentDecoder)
  protected
    function has_id(id: ComponentID): Boolean;
    function decode(dec: IDecoder; cid: ComponentID; len: _ulong): IORBComponent;
  public
    constructor Create();
    destructor Destroy(); override;
  end;

  TSSLTransport = class(TInterfacedObject, ITransport, ITransportCallBack, ISSLTransport)
  private
    FLocalAddr, FPeerAddr: ISSLAddress;
    FTransport: ITransport;
    FReadCallBack,FWriteCallback : ITransportCallBack;
    FBIO: PBIO;
    FSSL: PSSL;
    class function setup_ctx(): boolean;
  protected
    { ITransport }
    function bad(): Boolean; stdcall;
    procedure block(val: Boolean);
    function isblocking(): boolean;
    function bufread(buf: IBuffer;size: _ulong): integer; stdcall;
    function bufwrite(buf: IBuffer; size: _ulong; eat: boolean = true): integer; stdcall;
    function connect(const addr : IAddress): Boolean; stdcall;
    procedure open(fd: Longint); stdcall;
    procedure close(); stdcall;
    function eof(): Boolean; stdcall;
    function peer(): IAddress;
    function read(var buffer; size: _ulong): integer; stdcall;
    procedure rselect(const disp: IORBDispatcher;const cb: ITransportCallback); stdcall;
    procedure wselect(const disp: IORBDispatcher;const cb: ITransportCallback); stdcall;
    function write(const buffer;size: _ulong): integer; stdcall;
    function get_principal(): IPrincipal;
    function get_address: IAddress;
    { ITransportCallBack }
    procedure callback(tr: ITransport; event: TTransportCallBackEvent);
    { ISSLTransport }
    function accept(): boolean;
  public
    constructor Create(addr: ISSLAddress; transp: ITransport = nil);
    destructor Destroy(); override;
  end;

  TSSLTransportServer = class(TInterfacedObject, ITransportServer, ITransportServerCallBack)
  private
    FServer: ITransportServer;
    FLocalAddress : ISSLAddress;
    FCb : ITransportServerCallback;
  protected
    function accept(): ITransport;
    procedure aselect(const disp: IORBDispatcher;const cb: ITransportServerCallback);
    function bind(const addr: IAddress): Boolean;
    function get_address: IAddress;
    procedure listen();
    procedure block(doblock: boolean);
    procedure close();
{$IFDEF HAVE_THREADS}
    procedure create_thread();
    procedure start();
{$ENDIF}
    { ITransportServerCallBack }
    procedure ts_callback(ts: ITransportServer;event :TTransportServerCallBackEvent);
  public
    constructor Create(addr: ISSLAddress);
    destructor Destroy(); override;
  end;

  TSSLInit = class(TInitInterceptor)
  protected
    function initialize(const orb: IORB; const id: ORBId; argv: TStrings): TStatus; override;
  end;

  procedure SslInit(argv: TStrings);

implementation

uses any, address, orb;

type
  PBIO_METHOD_ST = ^BIO_METHOD_ST;
  BIO_METHOD_ST = packed record
    t: integer;
    name: PChar;
    bwrite: PFunction;
    bread: PFunction;
    bputs: PFunction;
    bgets: PFunction;
    ctrl: PFunction;
    create: PFunction;
    destroy: PFunction;
    callback_ctrl: PFunction;
  end;

var
  ssl_parser: IAddressParser;
  ssl_property: TStrings = nil;
  ssl_ctx: PSSL_CTX = nil;
  ssl_verify_depth: integer = 0;
  sslInitVar: IInitInterceptor;
  BIO_DORB: BIO_METHOD_ST;
  SSLProfileDecoder: IIORProfileDecoder;
  SSLComponentDecoder: IORBComponentDecoder;

const
  cBioName = 'mt_dorb_bio';

function ssl_verify_callback(ok: integer; ctx: PX509_STORE_CTX): integer; cdecl;
var
  //err: integer;
  depth: integer;
begin
  result := ok;
  //err := IdSslX509StoreCtxGetError(ctx);
  depth := IdSslX509StoreCtxGetErrorDepth(ctx);
  if ok = 0 then begin
    if ssl_verify_depth <= depth then
      result := 1
    else
      result := 0;
  end;
end;

{ BIO methods }

function mtdorb_bio_new(b: PBIO): integer; cdecl;
begin
  with b^ do begin
    init := 0;
    shutdown := 0;
    flags := 0;
    ptr := nil;
  end; { with }
  result := 1;
end;

function mtdorb_bio_free(b: PBIO): integer; cdecl;
var
  transp: ITransport;
begin
  if b = nil then begin
    result := 0;
    Exit;
  end;

  try
    if b^.shutdown <> 0 then begin
      if b^.init <> 0 then begin
        transp := ITransport(b^.ptr);
        Assert(transp <> nil);
        transp.close();
      end;
      b^.init := 0;
      b^.flags := 0;
    end;
    result := 1;
  except
    result := 0;
  end;
end;

function mtdorb_bio_read(b: PBIO; outbuf: PChar; len: integer): integer; cdecl;
var
  transp: ITransport;
begin
  result := 0;
  try
    if outbuf <> nil then begin
      transp := ITransport(b^.ptr);
      Assert(transp <> nil);
      result := transp.read(outbuf^, len);
      b^.flags := b^.flags and not (OPENSSL_BIO_FLAGS_RWS or OPENSSL_BIO_FLAGS_SHOULD_RETRY);
      if result <= 0 then begin
        if (result <> len) and not transp.eof() then
          b^.flags := b^.flags or OPENSSL_BIO_FLAGS_READ or OPENSSL_BIO_FLAGS_SHOULD_RETRY;
      end;
    end;
  except
  end;
end;

function mtdorb_bio_write(b: PBIO; const inbuf: PChar; len: integer): integer; cdecl;
var
  transp: ITransport;
begin
  try
    transp := ITransport(b^.ptr);
    Assert(transp <> nil);

    result := transp.write(inbuf^, len);
    b^.flags := b^.flags and not (OPENSSL_BIO_FLAGS_RWS or OPENSSL_BIO_FLAGS_SHOULD_RETRY);
    if result <= 0 then begin
      if (result <> len) and not transp.eof() then
        b^.flags := b^.flags or OPENSSL_BIO_FLAGS_WRITE or OPENSSL_BIO_FLAGS_SHOULD_RETRY;
    end;
  except
    Result := 0;
  end;
end;

function mtdorb_bio_puts(b: PBIO; const inbuf: PChar): integer; cdecl;
begin
  result := mtdorb_bio_write(b, inbuf, StrLen(inbuf));
end;

function mtdorb_bio_ctrl(b: PBIO; cmd: integer; num: longint; ptr: Pointer): longint; cdecl;
begin
  case cmd of
    OPENSSL_BIO_CTRL_RESET: result := 0;
    OPENSSL_BIO_CTRL_INFO: result := 0;
    OPENSSL_BIO_CTRL_SET: begin
      b^.ptr := ptr;
      b^.num := 0;
      b^.shutdown := num;
      b^.init := 1;
      result := 1;
    end;
    OPENSSL_BIO_CTRL_GET: begin
      if b^.init <> 0 then begin
        if ptr = nil then
          result := 0
        else begin
          {$ifndef fpc}
          {FIXME}
          PChar(PChar(ptr^)^)^ := PChar(b^.ptr)^;
          {$endif}
          result := 1;
        end;
      end
      else
        result := -1;
    end;
    OPENSSL_BIO_CTRL_GET_CLOSE: result := b^.shutdown;
    OPENSSL_BIO_CTRL_SET_CLOSE: begin
      b^.shutdown := num;
      result := 1;
    end;
    OPENSSL_BIO_CTRL_PENDING, OPENSSL_BIO_CTRL_WPENDING: result := 0;
    OPENSSL_BIO_CTRL_FLUSH, OPENSSL_BIO_CTRL_DUP: result := 1;
    else result := 0;
  end;
end;

procedure SslInit(argv: TStrings);
begin
  with BIO_DORB do begin
    t := OPENSSL_BIO_TYPE_MEM;
    name := cBioName;
    bwrite := @mtdorb_bio_write;
    bread := @mtdorb_bio_read;
    bputs := @mtdorb_bio_puts;
    bgets := nil{dorb_bio_gets};
    ctrl := @mtdorb_bio_ctrl;
    create := @mtdorb_bio_new;
    destroy := @mtdorb_bio_free;
  end; { with }
  sslInitVar := TSSLInit.Create(0);
end;

{ TSSLPrincipal }

constructor TSSLPrincipal.Create(peer: PX509; const cipher: string;
  transp: ITransport);
begin
  inherited Create(transp);
  FPeer := peer;
  FSSLCipher := cipher;
end;

destructor TSSLPrincipal.Destroy;
begin
  if FPeer <> nil then
    IdSslX509Free(FPeer);
  inherited;
end;

function TSSLPrincipal.get_property(const prop_name: string): IAny;
begin
  if CompareStr('auth-method', prop_name) = 0 then begin
    result := CreateAny();
    result.put_string('ssl');
  end
  else if StrLComp('ssl-x509-subject', PChar(prop_name), StrLen('ssl-x509-subject')) = 0 then begin
    result := CreateAny();
    if FPeer <> nil then
      result.put_string(AnsiString(get_x509_entry(IdSslX509GetSubjectName(FPeer), prop_name)))
    else
      result.put_string('');
  end
  else if StrLComp('ssl-x509-issuer', PChar(prop_name), StrLen('ssl-x509-issuer')) = 0 then begin
    result := CreateAny();
    if FPeer <> nil then
      result.put_string(AnsiString(get_x509_entry(IdSslX509GetIssuerName(FPeer), prop_name)))
    else
      result.put_string('');
  end
  else if CompareStr('ssl-cipher', prop_name) = 0 then begin
    result := CreateAny();
    result.put_string(AnsiString(FSSLCipher));
  end
  else
    result := inherited get_property(prop_name);
end;

class function TSSLPrincipal.get_x509_entry(name: PX509_NAME;
  const entry: string): string;
var
  nid: integer;
  buf: array [0..999] of char;
  cppos: integer;
begin
  cppos := Pos(':', entry);
  if cppos = 0 then begin
    result := IdSslX509NameOneline(name, nil, 0);
    Exit;
  end;
  nid := IdSslOBJtxt2nid(PChar(Copy(entry, cppos + 1, Length(entry) - cppos)));
  if nid = OPENSSL_NID_undef then begin
    result := '';
    Exit;
  end;
  if IdSslX509NAMEGetTextByNID(name, nid, buf, sizeof (buf)) < 0 then
    result := ''
  else
    result := buf;
end;

{ TSSLAddress }

function TSSLAddress.compare(const addr: IAddress): Boolean;
begin
  result := proto() = addr.proto();
  if result then
    Exit;
  result := FAddr.compare(addr);
end;

function TSSLAddress.content: IAddress;
begin
  result := FAddr;
end;

constructor TSSLAddress.Create(Addr: IAddress);
begin
  FAddr := Addr;
end;

function TSSLAddress.is_local: Boolean;
begin
  result := FAddr.is_local;
end;

function TSSLAddress.make_ior_profile(const key: AnsiString; const len: _ulong;
  const mc: IInterface; const version: _ushort): IInterface;
begin
  result := TSSLProfile.Create(key, len, Self as ISSLAddress, IMultiComponent(mc), version) as ISSLProfile;
end;

function TSSLAddress.make_transport: ITransport;
begin
  result := TSSLTransport.Create(Self as ISSLAddress);
end;

function TSSLAddress.make_transport_server: ITransportServer;
begin
  result := TSSLTransportServer.Create(Self as ISSLAddress);
end;

function TSSLAddress.proto: AnsiString;
begin
  result := 'ssl';
end;

function TSSLAddress.resolve_ip: Boolean;
begin
  result := FAddr.resolve_ip();
end;

procedure TSSLAddress.set_content(const addr: IAddress);
begin
  FAddr := addr;
end;

procedure TSSLAddress.set_socketaddress(val: TSockAddrIn);
begin
  FAddr.set_socketaddress(val);
end;

function TSSLAddress.socketaddress: TSockAddrIn;
begin
  result := FAddr.socketaddress;
end;

function TSSLAddress.toString: AnsiString;
begin
  result := 'ssl:' + FAddr.toString;
end;

function TSSLAddress.valid: Boolean;
begin
  result := FAddr.valid;
end;

{ TSSLAddressParser }

constructor TSSLAddressParser.Create;
begin
  TInetAddress.register_parser(Pointer(IAddressParser(self)));
end;

destructor TSSLAddressParser.Destroy;
begin
  TInetAddress.unregister_parser(Pointer(IAddressParser(self)));
  inherited;
end;

function TSSLAddressParser.has_protocol(const str: AnsiString): Boolean;
begin
  result := 'ssl' = str;
end;

function TSSLAddressParser.parse(const rest, proto: AnsiString): IAddress;
var
  addr: IAddress;
begin
  addr := TInetAddress.parse(rest);
  if addr = nil then begin
    result := nil;
    Exit;
  end;

  result := TSSLAddress.Create(addr) as ISSLAddress;
end;

{ TSSLProfile }

function TSSLProfile.address: IAddress;
begin
  result := FAddr;
end;

function TSSLProfile.clone: IIORProfile;
begin
  result := TSSLProfile.Create(Self) as ISSLProfile;
end;

constructor TSSLProfile.Create(const objkey: AnsiString; len: _ulong;
  addr: ISSLAddress; mc: IMultiComponent; const version: _ushort);
var
  port: _ushort;
begin
  FAddr := addr;
  // copy port from IIOP profile to SSLComponent
  if FAddr.content().proto() = 'inet' then
    port := IInetAddress(FAddr.content())._port()
  else
    port := 0;
  mc.add_component(TSSLComponent.Create(port) as IORBComponent);
  FIORProfile := FAddr.content().make_ior_profile(objkey, len, mc, version) as IIORProfile;
end;

constructor TSSLProfile.Create(ior: IIORProfile; addr: ISSLAddress);
var
  mc: IMultiComponent;
  c: IORBComponent;
begin
  FAddr := addr;
  FIORProfile := ior;
  // use port from SSLComponent instead of port from IIOP profile ...
  if FAddr.content().proto() = 'inet' then begin
    Assert(ior.id() = TAG_INTERNET_IOP);
    mc := IMultiComponent(ior.get_components());
    c := mc.get_component(TAG_SSL_SEC_TRANS) as ISSLComponent;
    Assert(c <> nil);
    IInetAddress(FAddr.content()).SetPort(ISSLComponent(c).port());
  end;
end;

function TSSLProfile.compare(const p: IIORProfile): boolean;
begin
  result := FIORProfile.compare(p);
end;

constructor TSSLProfile.Create(sslprof: ISSLProfile);
begin
  FAddr := sslprof.address() as ISSLAddress;
  FIORProfile := sslprof.IORProfile().clone();
end;

procedure TSSLProfile.encode(const enc: IEncoder);
begin
  FIORProfile.encode(enc);
end;

function tag_to_ssltag(tag: ProfileID): ProfileID;
begin
  result := 0;
  case tag of
    TAG_INTERNET_IOP: result := TAG_SSL_INTERNET_IOP;
    { TODO -oOVS : for Linux platform }
    //TAG_UNIX_IOP: result := TAG_SSL_UNIX_IOP;
    //TAG_UDP_IOP: result := TAG_SSL_UDP_IOP;
    else Assert(false);
  end;
end;

function TSSLProfile.id: ProfileID;
begin
  result := tag_to_ssltag(FIORProfile.id());
end;

function TSSLProfile.IORProfile: IIORProfile;
begin
  result := FIORProfile;
end;

function TSSLProfile.objkey(var len: _ulong): Identifier;
begin
  result := FIORProfile.objkey(len);
end;

function TSSLProfile.objkeylen: _ulong;
begin
  result := FIORProfile.objkeylen();
end;

procedure TSSLProfile.print(s: TStream);
begin
  s.Write('SSL ', 4);
  FIORProfile.print(s);
end;

function TSSLProfile.reachable: boolean;
begin
  result := FIORProfile.reachable();
end;

procedure TSSLProfile.set_objectkey(const val: Identifier; const len: _ulong);
begin
  FIORProfile.set_objectkey(val, len);
end;

function TSSLProfile.get_components: IInterface;
begin
  result := nil;
end;

function TSSLProfile.encode_id: ProfileId;
begin
  result := FIORProfile.id();
end;

{ TSSLProfileDecoder }

function ssltag_to_tag(tag: ProfileID): ProfileID;
begin
  result := 0;                 
  case tag of
    TAG_SSL_INTERNET_IOP: result := TAG_INTERNET_IOP;
    { TODO -oOVS : for Linux platform }
    //TAG_UNIX_IOP: result := TAG_SSL_UNIX_IOP;
    //TAG_UDP_IOP: result := TAG_SSL_UDP_IOP;
    else Assert(false);
  end;
end;

constructor TSSLProfileDecoder.Create;
begin
  TIORProfile.register_decoder(Pointer(IIORProfileDecoder(self)));
end;

function TSSLProfileDecoder.decode(const dec: IDecoder; pid: ProfileID;
  len: _ulong): IIORProfile;
var
  orig_pid: ProfileID;
begin
  orig_pid := ssltag_to_tag(pid);
  result := TIORProfile.decode_body(dec, orig_pid, len);
  //result := TSSLProfile.Create(result, TSSLAddress.Create(result.address()) as ISSLAddress) as ISSLProfile;
end;

destructor TSSLProfileDecoder.Destroy;
begin
  TIORProfile.unregister_decoder(Pointer(IIORProfileDecoder(self)));
  inherited;
end;

function TSSLProfileDecoder.has_id(id: ProfileID): Boolean;
begin
  result := TAG_SSL_INTERNET_IOP = id;//supported_ssltag(id);
end;

{ TSSLComponent }

constructor TSSLComponent.Create(port: _ushort; target_sup,
  target_req: AssociationOptions);
begin
  FTargetSupports := target_sup;
  FTargetRequires := target_req;
  FPort := port;
  FId := TAG_SSL_SEC_TRANS;
end;

procedure TSSLComponent.encode(const enc: IEncoder);
begin
  if SizeOf(AssociationOptions) = SizeOf(_ulong) then begin
    enc.put_ulong(FTargetSupports);
    enc.put_ulong(FTargetRequires);
  end
  else begin
    enc.put_ushort(FTargetSupports);
    enc.put_ushort(FTargetRequires);
  end;
  enc.put_ushort(FPort);
end;

function TSSLComponent._id: ComponentID;
begin
  result := FId;
end;

function TSSLComponent.port: _ushort;
begin
  result := FPort;
end;

procedure TSSLComponent.print(s: TStream);
var
  str: string;
begin
  str := IntToStr(FPort);
  str := ' SSL: supports ' + IntToHex(FTargetSupports, 8) + ' requires ' + IntToHex(FTargetRequires, 8) + ' port ' + str;
  s.Write(str, 47 + Length(str));
end;

procedure TSSLComponent.set_id(id: ComponentID);
begin
  FId := id;
end;

{ TSSLComponentDecoder }

constructor TSSLComponentDecoder.Create;
begin
  TORBComponent.register_decoder(Pointer(IORBComponentDecoder(self)));
end;

function TSSLComponentDecoder.decode(dec: IDecoder; cid: ComponentID;
  len: _ulong): IORBComponent;
var
  target_sup, target_req: AssociationOptions;
  port: _ushort;
begin
{$IFDEF MTDORB_SSL_VB_COMPAT}
  if not dec.get_ulong(target_sup) then Exit;
  if not dec.get_ulong(target_req) then Exit;
{$ELSE}
  if not dec.get_ushort(target_sup) then Exit;
  if not dec.get_ushort(target_req) then Exit;
{$ENDIF}
  if not dec.get_ushort(port) then Exit;
  result := TSSLComponent.Create(port, target_sup, target_req) as ISSLComponent;
end;

destructor TSSLComponentDecoder.Destroy;
begin
  TORBComponent.unregister_decoder(Pointer(IORBComponentDecoder(self)));
  inherited;
end;

function TSSLComponentDecoder.has_id(id: ComponentID): Boolean;
begin
  result := id = TAG_SSL_SEC_TRANS;
end;

{ TSSLTransport }

function TSSLTransport.accept: boolean;
var
  blocking: boolean;
begin
  blocking := FTransport.isblocking();
  FTransport.block(true);
  result := IdSslAccept(FSSL) > 0;
  FTransport.block(blocking);
end;

function TSSLTransport.bad: Boolean;
begin
  result := false;
end;

procedure TSSLTransport.block(val: Boolean);
begin
  FTransport.block(val);
end;

function TSSLTransport.bufread(buf: IBuffer; size: _ulong): integer;
var
  i : integer;
begin
  buf.resize(size);
  i := read(Pointer(_ulong(buf._buffer)+buf.WPosition)^,size);
  if i > 0 then
    buf.WseekFromCurrent(i);
  result := i;
end;

function TSSLTransport.bufwrite(buf: IBuffer; size: _ulong;
  eat: boolean): integer;
begin
  //result := FTransport.bufwrite(buf, size, eat);
  Assert(size <= buf.length());
  result := write(Pointer(_ulong(buf._buffer) + buf.RPosition)^, size);
  if (result > 0) and eat then
    buf.RseekFromCurrent(result);
end;

procedure TSSLTransport.callback(tr: ITransport; event: TTransportCallBackEvent);
begin
  case event of         
    tcRead : FReadCallback.callback(self as ITransport, tcRead);
    tcWrite : FWriteCallback.callback(self as ITransport, tcWrite);
    tcRemove : begin
      FReadCallback.callback(Self, tcRemove);
      FWriteCallback.callback(Self, tcRemove);
      FReadCallback := nil;
      FWriteCallback := nil;
    end;
    else
      assert(false,'not implemented');
  end;
end;

procedure TSSLTransport.close;
begin
  // XXX what if shutdown cannot be sent immediately ???
  IdSslShutdown(FSSL);
  IdSslSetConnectState(FSSL);
  FTransport.close();
end;

function TSSLTransport.connect(const addr: IAddress): Boolean;
var
  blocking: boolean;
  i: integer;
begin
  Assert(addr.proto() = 'ssl');
  result := false;

  blocking := FTransport.isblocking();
  FTransport.block(true);
  if not FTransport.connect(ISSLAddress(addr).content()) then begin
    //FError := FTransport.errormsg();
    FTransport.block(blocking);
    Exit;
  end;

{$IFDEF VER130}
  if OPENSSL_SSLEAY_VERSION_NUMBER >= $00900000 then
    IdSslSetConnectState(FSSL);
{$ELSE}
{$IF (OPENSSL_SSLEAY_VERSION_NUMBER >= $00900000)}
  IdSslSetConnectState(FSSL);
{$IFEND}
{$ENDIF}

  i := IdSslConnect(FSSL);
  FTransport.block(blocking);
  if i <= 0 then begin
    //FError := 'SSL active connection setup failed';
    Exit;
  end;

  result := true;
end;

constructor TSSLTransport.Create(addr: ISSLAddress; transp: ITransport);
begin
  if transp = nil then
    FTransport := addr.content().make_transport()
  else
    FTransport := transp;
  FLocalAddr := addr{.clone()};
  FPeerAddr := addr{.clone()};
  Assert(setup_ctx());
  FBIO := IdBIONew(@BIO_DORB);
  Assert(FBIO <> nil);
  IdBIOCtrl(FBIO, OPENSSL_BIO_CTRL_SET, 0, Pointer(FTransport));
  FSSL := IdSslNew(ssl_ctx);
  IdSSLSetBio(FSSL, FBIO, FBIO);
end;

destructor TSSLTransport.Destroy;
begin
  if FTransport <> nil then begin
    FTransport.rselect(ORB_Instance.dispatcher(), nil);
    FTransport.wselect(ORB_Instance.dispatcher(), nil);
  end;
  FReadCallBack := nil;
  FWriteCallback := nil;
  // XXX what if shutdown cannot be sent immediately???
  IdSslShutdown(FSSL);
  IdSslFree(FSSL);
  // BIO is freed in SSL_free()
  inherited;
end;

function TSSLTransport.eof: Boolean;
begin
  result := FTransport.eof();
end;

function TSSLTransport.get_address: IAddress;
begin
  result := FLocalAddr;
end;

function TSSLTransport.get_principal: IPrincipal;
begin
  result := TSSLPrincipal.Create(IdSslGetPeerCertificate(FSSL), IdSslCipherGetName(IdSslGetCurrentCipher(FSSL)), Self as ITransport) as ISSLPrincipal;
end;

function TSSLTransport.isblocking: boolean;
begin
  result := FTransport.isblocking();
end;

procedure TSSLTransport.open(fd: Integer);
begin

end;

function TSSLTransport.peer: IAddress;
begin
  FPeerAddr.set_content(FTransport.peer(){.clone()});
  result := FPeerAddr;
end;

function TSSLTransport.read(var buffer; size: _ulong): integer;
begin
  result := IdSslRead(FSSL, @buffer, size);
end;

procedure TSSLTransport.rselect(const disp: IORBDispatcher;
  const cb: ITransportCallback);
begin
  FReadCallBack := cb;
  if cb = nil then
    FTransport.rselect(disp, nil)
  else
    FTransport.rselect(disp, Self as ITransportCallback)
end;

{$IFDEF WIN32}
function GetEnv(const varname: string): string;
var
  buf: array [0..255] of char;
begin
  SetString(result, buf, GetEnvironmentVariable(PChar(varname), buf, SizeOf(buf)));
end;
{$ENDIF}

class function TSSLTransport.setup_ctx: boolean;
var
  cert, key, cipher: string;
  cafile, capath: PChar;
  verify, ret: integer;
  i: integer;
  str: string;
begin
  MtDorbSSLOpenSSLHeaders.Load;
  result := ssl_ctx <> nil;
  if result then Exit;

  verify := OPENSSL_SSL_VERIFY_NONE;

  cafile := nil;
  capath := nil;
  i := 0;
  while i < ssl_property.Count do begin
    str := ssl_property.Strings[i];
    if (str = '-ORBSSLverify') then begin
      verify := OPENSSL_SSL_VERIFY_PEER;
      i := Succ(i);
      ssl_verify_depth := StrToInt(ssl_property.Strings[i]);
    end
    else if (str = '-ORBSSLcert') then begin
      i := Succ(i);
      cert := ssl_property.Strings[i];
    end
    else if (str = '-ORBSSLkey') then begin
      i := Succ(i);
      key := ssl_property.Strings[i];
    end
    else if (str = '-ORBSSLCApath') then begin
      i := Succ(i);
      capath := PChar(ssl_property.Strings[i]);
    end
    else if (str = '-ORBSSLCAfile')  then begin
      i := Succ(i);
      cafile := PChar(ssl_property.Strings[i]);
    end
    else if (str = '-ORBSSLcipher')  then begin
      i := Succ(i);
      cipher := ssl_property.Strings[i];
    end;
    i := Succ(i);
  end; { while }

  if cipher = '' then
    cipher := GetEnv('SSL_CIPHER');
  if cert = '' then
    cert := 'default.pem';
  if key = '' then
    key := cert;

  IdSslAddSslAlgorithms();
  ssl_ctx := IdSslCtxNew(IdSslMethodV23());

  if cipher <> '' then
    IdSslCtxSetCipherList(ssl_ctx, PChar(cipher));

  IdSslCtxSetVerify(ssl_ctx, verify, @ssl_verify_callback);
  IdSSLCTXSetClientCAList(ssl_ctx, IdSSLLoadClientCAFile(cafile));
  if IdSslCtxUseCertificateFile(ssl_ctx, PChar(cert), OPENSSL_SSL_FILETYPE_PEM) <= 0 then begin
    result := false;
    Exit;
  end;
  if IdSslCtxUsePrivateKeyFile(ssl_ctx, PChar(key), OPENSSL_SSL_FILETYPE_PEM) <= 0 then begin
    result := false;
    Exit;
  end;
  if IdSslCtxCheckPrivateKeyFile(ssl_ctx) <= 0 then begin
    result := false;
    Exit;
  end;

  IdSslLoadErrorStrings();

  ret := IdSslCtxLoadVerifyLocations(ssl_ctx, cafile, capath);
  if ((ret = 0) and ((cafile <> nil) or (capath <> nil)) or
    (IdSslCtxSetDefaultVerifyPaths(ssl_ctx) = 0)) then begin
    result := false;
    Exit;
  end;
  result := true;
end;

function TSSLTransport.write(const buffer; size: _ulong): integer;
begin
  result := IdSslWrite(FSSL, @buffer, size);
end;

procedure TSSLTransport.wselect(const disp: IORBDispatcher;
  const cb: ITransportCallback);
begin
  FWriteCallBack := cb;
  if cb = nil then
    FTransport.wselect(disp, nil)
  else
    FTransport.wselect(disp, Self as ITransportCallback)
end;

{ TSSLTransportServer }

function TSSLTransportServer.accept: ITransport;
var
  tr: ITransport;
begin
  tr := FServer.accept();
  if tr = nil then Exit;

  result := TSSLTransport.Create(FLocalAddress, tr) as ISSLTransport;
  ISSLTransport(result).accept();
end;

procedure TSSLTransportServer.aselect(const disp: IORBDispatcher;
  const cb: ITransportServerCallback);
begin
  FCb := cb;
  if cb = nil then
    FServer.aselect(disp, nil)
  else
    FServer.aselect(disp, Self as ITransportServerCallback)
end;

function TSSLTransportServer.bind(const addr: IAddress): Boolean;
begin
  Assert(addr.proto() = 'ssl');

  result := FServer.bind(ISSLAddress(addr).content());
end;

procedure TSSLTransportServer.block(doblock: boolean);
begin
  FServer.block(doblock);
end;

procedure TSSLTransportServer.close;
begin
  FServer.close();
end;

constructor TSSLTransportServer.Create(addr: ISSLAddress);
begin
  FServer := addr.content().make_transport_server();
  FLocalAddress := addr{.clone()} as ISSLAddress;
end;

{$IFDEF HAVE_THREADS}
procedure TSSLTransportServer.create_thread;
begin
  FServer.create_thread();
end;
{$ENDIF}

destructor TSSLTransportServer.Destroy;
begin
  FServer.aselect(ORB_Instance.dispatcher(), nil);
  FServer := nil;
  inherited;
end;

function TSSLTransportServer.get_address: IAddress;
begin
  FLocalAddress.set_content(FServer.get_address(){.clone()});
  result := FLocalAddress;
end;

procedure TSSLTransportServer.listen;
begin
  FServer.listen();
end;

{$IFDEF HAVE_THREADS}
procedure TSSLTransportServer.start;
begin
  FServer.start();
end;
{$ENDIF}

procedure TSSLTransportServer.ts_callback(ts: ITransportServer;
  event: TTransportServerCallBackEvent);
begin
  case event of
    tsAccept: FCb.ts_callback(Self as ITransportServer, tsAccept);
    tsRemove: begin
      FCb.ts_callback(Self as ITransportServer, tsRemove);
      FCb := nil;
    end;
  end;
end;

{ TSSLInit }

function TSSLInit.initialize(const orb: IORB; const id: ORBId;
  argv: TStrings): TStatus;
var
  i: integer;
  str: string;
begin
  ssl_property := TStringList.Create;
  result := INVOKE_CONTINUE;
  if argv = nil then Exit;
  i := 0;
  while i < argv.Count do begin
    str := argv.Strings[i];
    //add ssl property
    if (str = '-ORBSSLverify') or
       (str = '-ORBSSLcert') or
       (str = '-ORBSSLkey') or
       (str = '-ORBSSLCApath') or
       (str = '-ORBSSLCAfile') or
       (str = '-ORBSSLcipher') then begin
      ssl_property.Add(str);
      i := Succ(i);
      ssl_property.Add(argv.Strings[i]);
    end;
    i := Succ(i);
  end; { while }
  ssl_parser := TSSLAddressParser.Create;
  SSLProfileDecoder := TSSLProfileDecoder.Create;
  SSLComponentDecoder := TSSLComponentDecoder.Create;
end;

initialization
finalization
  ssl_parser := nil;
  FreeAndNil(ssl_property);
  SSLProfileDecoder := nil;
  SSLComponentDecoder := nil;
{$ELSE}
implementation
{$ENDIF}
end.
