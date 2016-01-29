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
  This unit implements interfaces for working with TCP/IP.
}
unit address;

interface

uses
  orbtypes,SysUtils,orb,{$IFDEF WIN32}Windows,winsock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF},
  addr_int,mcomp_int,orb_int;

{$IFNDEF USELIB}

type

  {**
     Implements work with Internet protocol
  }
  TInetAddress = class(TORBObject,IInetAddress,IAddress)
  private
    FHost : AnsiString;
    FPort: _ushort;
    FFamily : TFamily;
    FIPAddr : _ulong;
  protected
    function compare(const addr: IAddress): Boolean;
    function toString(): AnsiString;
    function Host: AnsiString;
    function _port: _ushort;
    procedure SetPort(const port: _ushort);
    function Family: TFamily;
    function proto(): AnsiString;
    function make_transport(): ITransport;
    function socketaddress(): TSockAddrIn;
    function resolve_ip(): Boolean;
    function resolve_host(): Boolean;
    function make_transport_server(): ITransportServer;
    procedure set_socketaddress(val:TSockAddrIn);
    function make_ior_profile(const key: AnsiString; const len: _ulong; const mc: IInterface; const version: _ushort): IInterface;
    function ipaddr: _ulong;
    function ipaddrstr: AnsiString;
    function is_local(): Boolean;
    function valid: Boolean;
  public
    constructor Create(host: AnsiString; port : _ushort; family : TFamily = STREAM);
    class function hostid: _ulong;
    class function hostname: AnsiString;
    class function parse(const str: AnsiString): IAddress;
    class procedure register_parser(pars: Pointer);
    class procedure unregister_parser(pars: Pointer);
  end;


  {**    Parser for local addresses  }
  TLocalAddressParser = class(TInterfacedObject,IAddressParser)
  public
    constructor Create();
    destructor Destroy(); override;
    {**       Returns true if protocol supported    }
    function has_protocol(const str: AnsiString): Boolean; virtual;
    {**      Not implemented. Now creates new InetAddres on "localhost"    }
    function parse(const rest: AnsiString; const proto: AnsiString): IAddress; virtual;
  end;

  {**    Parser for Internet addresses  }
  TInetAddressParser = class(TLocalAddressParser,IAddressParser)
  public
    {**       Returns true if protocol supported    }
    function has_protocol(const str: AnsiString): Boolean; override;
    {**      Creates new InetAddress object by parameters    }
    function parse(const rest: AnsiString; const proto: AnsiString): IAddress; override;
  end;

implementation

uses
  Classes,transp,ior,iior_int,osthread;

var
  addrParsersVar: TList = nil;
{$IFDEF USE_RWLOCK}
  addrParsersLock: TRWLock;
  addrParsersCreateLock: TMutex;
{$ENDIF}
  local_parser : IAddressParser;
  inet_parser : IAddressParser;
  hname: AnsiString;
  hid: _ulong;

function addr_parsers: TList;
{$IFDEF USE_RWLOCK}
var
  sync: ISynchronized;
{$ENDIF}
begin
  {$IFDEF USE_RWLOCK}sync := TSynchronized.Create(addrParsersCreateLock);{$ENDIF}
  if addrParsersVar = nil then
    addrParsersVar := TList.Create;
  result := addrParsersVar;
end;

//**********************************************************************
// TInetAddress
//**********************************************************************
constructor TInetAddress.Create(host: AnsiString; port : _ushort; family : TFamily);
begin
  FHost := host;
  FPort := port;
  FFamily := family;
  FIPAddr := DWORD(INADDR_NONE);
end;

function TInetAddress.compare(const addr: IAddress): Boolean;
var
  ia : IInetAddress;
begin
  result := false;
  if proto <> addr.proto then
    exit;
  ia := addr as IInetAddress;
  if ia._Port <> FPort then
    exit;
  if not ia.resolve_ip or not resolve_ip then
    exit;
  if ia.ipaddr <> ipaddr then
    exit;
  result := true;      
end;

function TInetAddress.ipaddrstr: AnsiString;
var
  tmp : PByteArray;
begin
  result := '';
  if not resolve_ip() then exit;
  tmp := PByteArray(Pointer(@FIPAddr));
  result := AnsiString(IntToStr(tmp^[0]) + '.' + IntToStr(tmp^[1]) + '.' +
    IntToStr(tmp^[2]) + '.' + IntToStr(tmp^[3]));
end;

function TInetAddress.is_local(): Boolean;
begin
  result := false;
end;

function TInetAddress.ipaddr: _ulong;
begin
  result := 0;
  if not resolve_ip() then exit;
  result := FIPAddr;
end;

class function TInetAddress.hostid: _ulong;
var
  buffer: array[0..255] of AnsiChar;
  val : AnsiString;
  a : IInetAddress;
begin
  if hid = 0 then
    begin
      gethostname(@buffer,255);
      val := PAnsiChar(@buffer);
      a := TInetAddress.Create(val,0,STREAM);
      hid := a.ipaddr;
    end;
  result := hid;
end;

class function TInetAddress.hostname: AnsiString;
var
  buffer: array[0..255] of AnsiChar;
  a : IInetAddress;
begin
  if hname = '' then
    begin
      gethostname(@buffer,255);
      a := TInetAddress.Create(PAnsiChar(@buffer),0,STREAM);
      hname := a.ipaddrstr;
    end;
  result := hname;
end;

class function TInetAddress.parse(const str: AnsiString): IAddress;
var
  i,ind : integer;
  proto,rest: AnsiString;
{$IFDEF USE_RWLOCK}
  sync: ISynchronized;
{$ENDIF}
begin
  result := nil;
  {$IFDEF USE_RWLOCK}sync := TSynchronized.Create(addrParsersLock);{$ENDIF}
  if addr_parsers.Count = 0 then exit;
  ind := pos(':',String(str));
  if ind = 0 then
    begin
      proto := str;
      rest := '';
    end
  else
    begin
      proto := copy(str,0,ind-1);
      rest := copy(str,ind+1,100);
    end;
  for i := 0 to Pred(addr_parsers.Count) do
    with IAddressParser(addr_parsers[i]) do
      if has_protocol(proto) then
        break;
  if i < addr_parsers.Count then
    result := IAddressParser(addr_parsers[i]).parse(rest,proto);
end;

function TInetAddress.toString(): AnsiString;
begin
  result := '';
  if not resolve_ip() then exit;
  result := proto() + ':' + AnsiString(host()) + ':' + AnsiString(IntToStr(FPort));
end;

function TInetAddress.proto(): AnsiString;
begin
  case FFamily of
    STREAM: result := 'inet';
    DGRAM: result := 'inet-dgram';
    else
      result := 'unknown';
  end;
end;

function TInetAddress.Host: AnsiString;
begin
  result := '';
  if not resolve_host() then exit;
  result := FHost;
end;

function TInetAddress._Port: _ushort;
begin
  Result := FPort;
end;

procedure TInetAddress.SetPort(const port: _ushort);
begin
  FPort := port;
end;

function TInetAddress.Family: TFamily;
begin
  Result := FFamily
end;

function TInetAddress.make_transport(): ITransport;
begin
  if FFamily = STREAM then
    result := TTCPTransport.Create()//Sock(-1)
  else
    begin
      result := nil;
      assert(false,'not implemented');
    end;
  result.open(-1);
end;

function TInetAddress.make_transport_server(): ITransportServer;
begin
  if FFamily = STREAM then
      result := TTCPTransportServer.Create()
  else
    begin
      result := nil;
      assert(false,'not implemented');
    end;
end;

procedure TInetAddress.set_socketaddress(val:TSockAddrIn);
begin
  FPort := ntohs(val.sin_port);
  FIPAddr := DWORD(val.sin_addr.S_addr);
  FHost := '';
end;

function TInetAddress.socketaddress(): TSockAddrIn;
begin
  FillChar(result,sizeof(result),0);
  if not resolve_ip() then exit;
  result.sin_addr.S_addr := Longint(FIPAddr);
  result.sin_port := htons (FPort);
  result.sin_family := AF_INET;
end;

function TInetAddress.resolve_host(): Boolean;
var
  p : phostent;
  str : AnsiString;
  i : integer;
  tmpAddr : _ulong;
begin
  result := false;
  if FHost <> ''  then
    begin
      result := true;
      exit;
    end;
  if IPAddr = 0 then
    exit;
  p := gethostbyaddr(@FIPAddr,4,AF_INET);
  if p <> nil then begin
    str := p^.h_name;
    tmpAddr := _ulong(inet_addr(PAnsiChar(AnsiString(str))));
    if tmpAddr = DWORD(INADDR_NONE) then begin // dosn`t contain a.b.c.d
      // search in aliases
      i := 0;
      while PPointerList(p^.h_aliases)^[i] <> nil do begin
        str := PAnsiChar(PPointerList(p^.h_aliases)^[i]);
        tmpAddr := _ulong(inet_addr(PAnsiChar(str)));
        if tmpAddr <> DWORD(INADDR_NONE) then begin
          FHost := str;
          break;
        end;
        Inc(i);
      end;
    end
    else
      FHost := str;
  end;
  if FHost = '' then
    FHost := ipaddrstr;
  result := true;
end;

function TInetAddress.resolve_ip(): Boolean;
var
  h : PHostEnt;
begin
  if FIPAddr <> DWORD(INADDR_NONE) then
    begin
      result := true;
      exit;
    end;
  result := false;
  if Length(FHost) = 0 then exit;
  FIPAddr := _ulong(inet_addr(PAnsiChar(AnsiString(FHost))));
  if FIPAddr = DWORD(INADDR_NONE) then begin // FHost dosn`t contain a.b.c.d
    h := gethostbyname(PAnsiChar(AnsiString(FHost)));
    if h <> nil then begin
      with h^ do begin
        PByteArray(@FIPAddr)^[0] := Byte(h_addr^[0]);
        PByteArray(@FIPAddr)^[1] := Byte(h_addr^[1]);
        PByteArray(@FIPAddr)^[2] := Byte(h_addr^[2]);
        PByteArray(@FIPAddr)^[3] := Byte(h_addr^[3]);
      end;
      result := true;
    end;
  end
  else
    result := true;
end;

class procedure TInetAddress.register_parser(pars: Pointer);
{$IFDEF USE_RWLOCK}
var
  sync: ISynchronized;
{$ENDIF}
begin
  {$IFDEF USE_RWLOCK}
  sync := TSynchronized.Create(addrParsersLock, false);
  {$ENDIF}
  addr_parsers.Add(pars);
end;

class procedure TInetAddress.unregister_parser(pars: Pointer);
begin
  if addrParsersVar <> nil then // if parser was destroy
    addrParsersVar.Remove(pars);
end;

function TInetAddress.valid: Boolean;
begin
  result := resolve_host() and resolve_ip();
end;

function TInetAddress.make_ior_profile(const key: AnsiString; const len: _ulong;const mc: IInterface;
  const version: _ushort): IInterface;
var
  sin : TSockAddrIn;
  addr : IInetAddress;
  prof : IIORProfile;
begin
  result := nil;
  sin := socketaddress();
  case FFamily of
    STREAM: begin
        if sin.sin_addr.S_addr = 0 then
          begin
            addr := TInetAddress.Create(hostname, FPort, STREAM);
            prof := TIIOPProfile.Create(key, len, addr, mc as IMultiComponent, version);
          end
        else
          prof := TIIOPProfile.Create(key, len, self, mc as IMultiComponent, version);
      end;
    else
      assert(false,'not implemented');
  end;
  result := prof;
end;

//*****************************************************
// TLocalAddressParser
//*****************************************************
constructor TLocalAddressParser.Create();
begin
  inherited Create();
  TInetAddress.register_parser(Pointer(IAddressParser(self)));
end;

destructor TLocalAddressParser.Destroy();
begin
  TInetAddress.unregister_parser(Pointer(IAddressParser(self)));
  inherited Destroy();
end;

function TLocalAddressParser.has_protocol(const str: AnsiString): Boolean;
begin
  result :=  strcomp('local', PAnsiChar(str)) = 0;
end;

function TLocalAddressParser.parse(const rest: AnsiString; const proto: AnsiString): IAddress;
begin
  result := TInetAddress.Create('localhost',0,STREAM);
end;

//*****************************************************
// TInetAddressParser
//*****************************************************
function TInetAddressParser.has_protocol(const str: AnsiString): Boolean;
begin
  result :=  (strcomp('inet', PAnsiChar(str)) = 0) or
    (strcomp('inet-stream', PAnsiChar(str)) = 0) or
    (strcomp('inet-dgram', PAnsiChar(str)) = 0);
end;

function TInetAddressParser.parse(const rest: AnsiString; const proto: AnsiString): IAddress;
var
  fam: TFamily;
  ind: integer;
  host: AnsiString;
  port : WORD;
begin
  result := nil;
  ind := pos(':',String(rest));
  if ind = 0 then exit;
  if (strcomp('inet', PAnsiChar(proto)) = 0) or (strcomp('inet-stream', PAnsiChar(proto)) = 0) then
    fam := STREAM
  else if (strcomp('inet-dgram', PAnsiChar(proto)) = 0) then
    fam := DGRAM
  else
    exit;
  host := Copy(rest,0,ind-1);
  port := StrToInt(Copy(String(rest),ind+1,100));
  if host <> '' then
    result := TInetAddress.Create(host,port,fam)
  else
    result := TInetAddress.Create('0.0.0.0',port,fam);
  if not result.resolve_ip then
    result := nil;
end;

initialization
  //addr_parsers := TList.Create;
  {$IFDEF USE_RWLOCK}
  addrParsersLock := TRWLock.Create;
  addrParsersCreateLock := TMutex.Create;
  {$ENDIF}
  local_parser := TLocalAddressParser.Create;
  inet_parser := TInetAddressParser.Create;
  local_parser := TLocalAddressParser.Create();
  hname := '';
  hid := 0;
finalization
  local_parser := nil;
  inet_parser := nil;
  FreeAndNil(addrParsersVar);
  {$IFDEF USE_RWLOCK}
  FreeAndNil(addrParsersLock);
  FreeAndNil(addrParsersCreateLock);
  {$ENDIF}
{$ELSE}
implementation  
{$ENDIF}
end.
