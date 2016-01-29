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
unit ior;

interface

{$I dorb.inc}

uses
  orbtypes,SysUtils,decoder,Classes,address,orbcomp,
  orb_int,orb,code_int,addr_int,iior_int,mcomp_int,iiop_int;

{$IFNDEF USELIB}

type

  TIORProfile = class;

  {** Implements org.omg.CORBA.Environment }
  TIOR = class(TORBObject,IIOR,IORBObject)
  private
    ObjectID : AnsiString;
    FProfiles : IInterfaceList;
    FActiveProfile: IIORProfile;
    FActiveProfileIndex: _ulong;
    FAddressingDisposition: AddressingDisposition;
  protected
    function decode(const dec: IDecoder): Boolean;
    procedure encode(const enc: IEncoder);
    procedure print(s : TStream);
    procedure clean();
    function get_profile(id : ProfileID = TAG_ANY; find_unreachable: boolean = false; prev: IIORProfile = nil): IIORProfile;
    function address(id: ProfileID = TAG_ANY; find_unreachable: boolean = false; prev: IIORProfile = nil): IAddress;
    procedure add_profile(const prof : IIORProfile);
    procedure set_objectkey(const key: AnsiString; const len: _ulong);
    procedure set_objectid(const oid: AnsiString);
    function size: integer;
    function profile(ind: _ulong): IIORProfile;
    function objid: AnsiString;
    function stringify: AnsiString;
    function active_profile(var AIndex: _ulong): IIORProfile; overload;
    procedure active_profile(const AProfile: IIORProfile); overload;
    function addressing_disposition(): AddressingDisposition; overload;
    procedure addressing_disposition(const AddrDisp: AddressingDisposition); overload;
    function from_string(const Value: AnsiString): Boolean;
  public
    constructor Create(); overload;
    constructor Create(const tmpl: IIOR); overload;
    constructor Create(const ref: AnsiString); overload;
  end;

  TIORProfile = class(TORBObject,IIORProfile)
  private
    FID : ProfileID;
    FAddress : IInetAddress;
    FMultiComponent : IMultiComponent;
  protected
    function address(): IAddress; virtual;
    function id(): ProfileID; virtual;
    function encode_id(): ProfileId; virtual;
    function objkey(var len: _ulong): AnsiString; virtual;
    procedure encode(const enc: IEncoder); virtual; abstract;
    function clone(): IIORProfile; virtual; abstract;
    procedure print(s: TStream); virtual; abstract;
    function objkeylen: _ulong; virtual;
    procedure set_objectkey(const val: AnsiString; const len : _ulong); virtual; abstract;
    function reachable(): boolean; virtual; abstract;
    function compare(const p: IIORProfile): boolean; virtual; abstract;
    function get_components(): IInterface; virtual;
  public
    class procedure register_decoder(tipd : Pointer);
    class procedure unregister_decoder(tipd : Pointer);
    class function decode(dec: IDecoder): IIORProfile;
    class function decode_body(dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile;
  end;

  TGIOPSimpleProfile = class(TIORProfile,IIORProfile)
  private
    FObjKey : AnsiString;
    FOKLen : integer;
  protected
    procedure encode(const enc: IEncoder); override;
    function objkey(var len: _ulong): AnsiString; override;
    function clone(): IIORProfile; override;
    procedure print(s: TStream); override;
    procedure set_objectkey(const val: AnsiString; const len : _ulong); override;
    function id(): ProfileID; override;
    function reachable(): boolean; override;
    function compare(const p: IIORProfile): boolean; override;
  public
    constructor Create(const objkey: AnsiString = '';len: _ulong = 0);
    constructor Create_prof(const prof: IIORProfile);
  end;

  TIIOPProfile = class(TIORProfile,IIORProfile,IIOPProfile)
  private
    FObjKey : AnsiString;
    FOKLen : integer;
    FVersion : _ushort;
  protected
    procedure encode(const enc: IEncoder); override;
    function clone(): IIORProfile; override;
    function objkey(var len: _ulong): AnsiString; override;
    procedure print(s: TStream); override;
    //function comps: IMultiComponent;
    function version: _ushort;
    function objkeylen: _ulong; override;
    procedure set_objectkey(const val: AnsiString; const len : _ulong); override;
    function reachable(): boolean; override;
    function compare(const p: IIORProfile): boolean; override;
    function get_components(): IInterface; override;
  public
    constructor Create(const objkey: AnsiString;len: _ulong;
        address: IInetAddress;comps: IMultiComponent;
        version : _ushort = $0100; tagid: ProfileID = TAG_INTERNET_IOP);
    constructor Create_prof(const prof: IIOPProfile);
  end;

  TMultiCompProfile  = class(TIORProfile,IIORProfile,IMultiComponentProfile)
  protected
    procedure encode(const enc: IEncoder); override;
    function clone(): IIORProfile; override;
    procedure set_objectkey(const val: AnsiString; const len : _ulong); override;
    function reachable(): boolean; override;
    function compare(const p: IIORProfile): boolean; override;
    procedure print(s: TStream); override;
    function get_components(): IInterface; override;
  public
    constructor Create(mc: IMultiComponent; id : ProfileID);
    constructor Create_prof(const prof: IMultiComponentProfile);
  end;

  TIORProfileDecoder = class(TORBObject,IIORProfileDecoder)
  private
    FID : Cardinal;
  public
    constructor Create(pid : ProfileID);
    destructor Destroy(); override;
    function has_id(id: ProfileID): Boolean;
    function decode(const dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile; virtual; abstract;
  end;

  TIIOPProfileDecoder = class(TIORProfileDecoder,IIORProfileDecoder)
  public
    function decode(const dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile; override;
  end;

  TMultiCompProfileDecoder = class(TIORProfileDecoder,IIORProfileDecoder)
  public
    function decode(const dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile; override;
  end;

  TUnknownProfile = class(TIORProfile, IUnknownProfile)
  private
    FTagData: OctetSeq;
  protected
    function address(): IAddress; override;
    procedure encode(const enc: IEncoder); override;
    function id(): ProfileID; override;
    function objkey(var len: _ulong): AnsiString; override;
    procedure set_objectkey(const val: AnsiString; const len : _ulong); override;
    function clone(): IIORProfile; override;
    procedure print(s: TStream); override;
    function reachable(): boolean; override;
    function compare(const p: IIORProfile): boolean; override;
    { IUnknownProfile }
    function tagdata: OctetSeq;
  public
    constructor Create(Id: ProfileID); overload;
    constructor Create(prof: IUnknownProfile); overload;
    class function decode(const dec: IDecoder; Id: ProfileID; len: _ulong): IIORProfile;
  end;

  TLocalProfile = class(TIORProfile)
  private
    FHost: AnsiString;
    FPID: Integer;
    FObjKey: AnsiString;
    FOKLen: Integer;
  protected
    function objkey(var len: _ulong): AnsiString; override;
    procedure encode(const enc: IEncoder); override;
    function clone(): IIORProfile; override;
    procedure print(s: TStream); override;
    function objkeylen: _ulong; override;
    procedure set_objectkey(const val: AnsiString; const len : _ulong); override;
    function reachable(): boolean; override;
    function compare(const p: IIORProfile): boolean; override;
    function get_components(): IInterface; override;
  public
    constructor Create(const objkey: AnsiString; len: _ulong; id: ProfileId = TAG_LOCAL;
      const host: AnsiString = ''; pid: long = -1);
  end;

  function CreateIOR():IIOR;
  function CreateIOR_ior(const tmpl: IIOR): IIOR;
  function CreateIOR_ref(const ref: AnsiString): IIOR;
  function ior_from_string(const Value: AnsiString): IIOR;

implementation

uses
  buffer,pstream,Utils,encoder,throw,except_int{$IFDEF HAVE_SSL},ssl,ssl_int{$ENDIF},
  {$IFDEF MSWINDOWS}Windows{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF};

var
  decodersVar : TThreadList = nil;
  IIOPProfileDecoder : IIORProfileDecoder;
  MultiCompProfileDecoder : IIORProfileDecoder;

function Decoders: TThreadList;
begin
  //if decodersVar = nil then
    //decodersVar := TThreadList.Create;
  result := decodersVar;
end;

//**********************************************************************
// TIOR
//**********************************************************************
constructor TIOR.Create();
begin
  inherited Create();
  FProfiles := TInterfaceList.Create();
  ObjectID := '';
end;

constructor TIOR.Create(const ref: AnsiString);
begin
  inherited Create();
  FProfiles := TInterfaceList.Create();
  ObjectID := '';
  from_string(ref);
end;

constructor TIOR.Create(const tmpl: IIOR);
var
  i : integer;
begin
  inherited Create();
  FProfiles := TInterfaceList.Create();
  for i := 0 to tmpl.size -1 do
    add_profile(tmpl.profile(i).clone);
  ObjectID := tmpl.objid;
end;

function TIOR.objid: AnsiString;
begin
  result := ObjectID;
end;

function TIOR.size: integer;
begin
  result := FProfiles.Count
end;

function TIOR.profile(ind: _ulong): IIORProfile;
begin
  result := nil;
  if ind < _ulong(size) then
    result := IIORProfile(FProfiles[ind]);
end;

procedure TIOR.set_objectkey(const key: AnsiString; const len: _ulong);
var
  i : integer;
begin
  for i := 0 to Pred(FProfiles.Count) do
    IIORProfile(FProfiles[i]).set_objectkey(key,len);
end;

procedure TIOR.set_objectid(const oid: AnsiString);
begin
  ObjectID := oid;
end;

function TIOR.from_string(const Value: AnsiString): Boolean;
const
  chars = '0123456789abcdef';
var
  Buffer : IBuffer;
  i,size : integer;
  b_order : TByteOrder;
  dec : IDecoder;
  b,lb,rb : Byte;
  val : string;
begin
  FActiveProfile := nil;
  FActiveProfileIndex := 0;
  FAddressingDisposition := 0;
  result := false;
  size := Length(Value);
  if (Pos('IOR:',String(Value)) <> 1) or ((size mod 2 and 1) <> 0) then
    exit;
  Buffer := TBuffer.Create(round(size/2));
  val := LowerCase(String(Value));
  i := 5;
  while i < size do
    begin
      if val[i] = #13 then break;
      if val[i] = #10 then break;
      if val[i] < 'a' then
        lb := Ord(val[i]) - Ord('0')
      else
        lb := Ord(val[i]) - Ord('a') + 10;
      inc(i);
      if val[i] = #13 then break;
      if val[i] = #10 then break;
      if val[i] < 'a' then
        rb := Ord(val[i]) - Ord('0')
      else
        rb := Ord(val[i]) - Ord('a') + 10;
      inc(i);
      Buffer.put(Octet((lb shl 4) or rb))
    end;
  dec := CreateDecoder(Buffer);
  if dec.get_octet(Octet(b)) then
    begin
      b_order := TByteOrder(b);
      dec.byteorder(b_order);
      if not decode(dec) then
        clean;
    end;
  Result := True;
end;

procedure TIOR.encode(const enc: IEncoder);
var
   i : integer;
   stat : TEncapsState;
begin
  enc.put_string(ObjectId);
  enc.seq_begin(FProfiles.Count);
  for i := 0 to Pred(FProfiles.Count) do
    begin
      enc.put_ulong(IIORProfile(FProfiles[i]).encode_id());
      enc.encaps_begin(stat);
      IIORProfile(FProfiles[i]).encode(enc);
      enc.encaps_end(stat);
    end;
  enc.seq_end;
end;

function TIOR.decode(const dec: IDecoder): Boolean;
var
  len,i : longint;
  prof : IIORProfile;
label
  error;
begin
  result := false;
  clean();
  if dec.get_string(ObjectID) then
    if dec.get_ulong(_ulong(len)) then begin
      for i := 0 to len-1 do begin
        prof := TIORProfile.decode(dec);
        if prof <> nil then begin
          add_profile(prof);
          result := true;
        end;
      end;
      if (len > 0) and (not result) then
        dorb_throw(st_TRANSIENT, MinorNoUsableProfileInIOR);
      result := true;
    end;
end;

procedure TIOR.clean();
begin
  FProfiles.Clear;
end;

procedure TIOR.add_profile(const prof: IIORProfile);
var
  i: Integer;
begin
  //The profile array is sorted by tags
  i := size() - 1;
  while (i >= 0) and (prof.id < IIORProfile(FProfiles[i]).id) do
    Dec(i);
  FProfiles.Insert(i + 1, prof);
end;

procedure TIOR.print(s : TStream);
var
  ps : TPrintStream;
  i : integer;
begin
  ps := TPrintStream(s);
  ps.writestr('Repo ID: ');
  ps.writeln(ObjectID);
  ps.writecrlf;
  for i := 0 to Pred(FProfiles.Count) do
    IIORProfile(FProfiles[i]).print(s);
  ps.writeeol;
end;

function TIOR.stringify: AnsiString;
var
  enc: IEncoder;
  buf : IBuffer;
  i : integer;
  o : Octet;
begin
  result := 'IOR:';
  enc := CreateEncoder();
  enc.put_octet(Octet(enc.byteorder = LittleEndian));
  encode(enc);
  buf := enc.buffer;
  for i := 0 to Pred(buf.length) do
    begin
      buf.get(o);
      result := result + AnsiChar(octet_to_xdigit(Octet(Byte(o) shr 4)));
      result := result + AnsiChar(octet_to_xdigit(Octet(Byte(o) and $F)));
    end;
end;

function TIOR.get_profile(id : ProfileID; find_unreachable: boolean; prev: IIORProfile): IIORProfile;
var
  i, b : integer;
begin
  result := nil;
  b := 0;
  if prev <> nil then
    for i := 0 to Pred(FProfiles.Count) do begin
      b := i;
      if FProfiles[i] = prev then begin
        b := b + 1;
        Break;
      end;
    end;
  for i := b to Pred(FProfiles.Count) do
    if (id = TAG_ANY) or (IIORProfile(FProfiles[i]).id() = id) then begin
      if find_unreachable or IIORProfile(FProfiles[i]).reachable then begin
        result := IIORProfile(FProfiles[i]);
        exit;
      end;
    end;
end;

function TIOR.address(id: ProfileID; find_unreachable: boolean;
  prev: IIORProfile): IAddress;
var
  i: integer;
begin
  i := 0;
  if prev <> nil then begin
    while i < FProfiles.Count do begin
      if IIORProfile(FProfiles[i]) = prev then begin
          Inc(i);
          Break;
      end;
      Inc(i);
    end; { while }
  end;
  while i < FProfiles.Count do begin
    if (id = TAG_ANY) or (IIORProfile(FProfiles[i]).id() = id) then begin
      if find_unreachable or IIORProfile(FProfiles[i]).reachable() then begin
        result := IIORProfile(FProfiles[i]).address();
        Exit;
      end;
    end;
    Inc(i);
  end; { while }
end;

procedure TIOR.active_profile(const AProfile: IIORProfile);
var
  i: integer;
begin
  if AProfile = nil then begin
    FActiveProfile := AProfile;
    Exit;
  end;
  for i := 0 to FProfiles.Count - 1 do
    if FProfiles[i] = AProfile then begin
      FActiveProfileIndex := i;
      Break;
    end;
  FActiveProfile := AProfile;
end;

function TIOR.active_profile(var AIndex: _ulong): IIORProfile;
begin
  if (FActiveProfile <> nil) then
    AIndex := FActiveProfileIndex;
  result := FActiveProfile;
end;        

procedure TIOR.addressing_disposition(
  const AddrDisp: AddressingDisposition);
begin
  FAddressingDisposition := AddrDisp;
end;

function TIOR.addressing_disposition: AddressingDisposition;
begin
  result := FAddressingDisposition;
end;

//**********************************************************************
// TIORProfile
//**********************************************************************
class function TIORProfile.decode(dec: IDecoder): IIORProfile;
var
  state : TEncapsState;
  pid,len,nextpos : _ulong;
begin
  result := nil;
  if not dec.get_ulong(pid) then exit;
  if not dec.encaps_begin(state,len) then exit;
  nextpos := dec._Buffer.RPosition+len;
  result := decode_body(dec,pid,len);
  dec._Buffer.RseekFromBegin(nextpos);
  if not dec.encaps_end(state) then
    result := nil;
end;

function TIORProfile.id(): ProfileID;
begin
  result := FID;
end;

function TIORProfile.encode_id: ProfileId;
begin
  result := FID;
end;

function TIORProfile.objkeylen: _ulong;
begin
  result := 0
end;

function TIORProfile.objkey(var len: _ulong): AnsiString;
begin
  result := '';
  len := 0;
end;

class function TIORProfile.decode_body(dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile;
var
  i : integer;
  decoderList: TList;
begin
  result := nil;
  if Decoders = nil then
    Exit;
  decoderList := Decoders.LockList;
  try
    for i := 0 to Pred(decoderList.Count) do
      if IIORProfileDecoder(decoderList[i]).has_id(pid) then
        break;
    if i <= Pred(decoderList.Count) then
      // known profile
      result := IIORProfileDecoder(decoderList[i]).decode(dec,pid,len)
    else
      // unknown profile
      result := TUnknownProfile.decode(dec, pid, len);
  finally
    Decoders.UnlockList;
  end; { try/finally }
end;

class procedure TIORProfile.register_decoder(tipd : Pointer);
begin
  if Decoders <> nil then
    Decoders.Add(tipd);
end;

class procedure TIORProfile.unregister_decoder(tipd : Pointer);
begin
  if Decoders <> nil then
    Decoders.Remove(tipd);
end;

function TIORProfile.address(): IAddress;
begin
  result := FAddress;
end;

function TIORProfile.get_components: IInterface;
begin
  result := nil;
end;

{$IFNDEF USELIB}
//**********************************************************************
// TIORProfileDecoder
//**********************************************************************
constructor TIORProfileDecoder.Create(pid : ProfileID);
begin
  inherited Create();
  FID := pid;
  TIORProfile.register_decoder(Pointer(IIORProfileDecoder(self)));
end;

destructor TIORProfileDecoder.Destroy();
begin
  TIORProfile.unregister_decoder(Pointer(IIORProfileDecoder(self)));
end;

function TIORProfileDecoder.has_id(id: ProfileID): Boolean;
begin
  result := FID = id;
end;

//**********************************************************************
// TIIOProfileDecoder
//**********************************************************************
function TIIOPProfileDecoder.decode(const dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile;
var
  minor,major : byte;
  version : _ushort;
  port : _ushort;
  host,okey : AnsiString;
  objkey : PByteArray;
  l : _ulong;
  components : IMultiComponent;
begin
  result := nil;
  if not dec.get_octet(Octet(major)) then exit;
  if not dec.get_octet(Octet(minor)) then exit;
  version := ((major shl 8) or minor);
  if not dec.get_string(host) then exit;
  if not dec.get_ushort(port) then exit;
  if not dec.seq_begin(l) then exit;
  if not (dec._Buffer.Length >= l) then exit;
  objkey := PByteArray(dec._Buffer.Data());
  if not dec._Buffer.RseekFromCurrent(l) then exit;
  if not dec.seq_end() then exit;
  components := TMultiComponent.Create;//nil;
  if (major > 1) or (minor > 0) then
    begin
      //components := TMultiComponent.Create;
      if not components.decode(dec) then
        begin
          components := nil;
          exit;
        end;
    end;
  setlength(okey,l);
  move(objkey^,PAnsiChar(okey)^,l);
  result := TIIOPProfile.Create(okey, l,
      TInetAddress.Create(host, port, STREAM) as IInetAddress,
      components,
      version,
      FID);
{$IFDEF HAVE_SSL}
   if (ORB_Instance.get_Properties.get_Property('mtdorb.orb.security.support_ssl') = 'on') and (components.get_component(TAG_SSL_SEC_TRANS) <> nil) then
     result := TSSLProfile.Create(result as IIORProfile, TSSLAddress.Create(result.address(){.clone()}) as ISSLAddress) as ISSLProfile;
{$ENDIF}
end;

//**********************************************************************
// TMultiCompProfileDecoder
//**********************************************************************
function TMultiCompProfileDecoder.decode(const dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile;
var
  components : IMultiComponent;
begin
  result := nil;
  components := TMultiComponent.Create;
  if not components.decode(dec) then
    begin
      components := nil;
      exit;
    end;
  result := TMultiCompProfile.Create(components,pid);
end;

{$ENDIF}

//**********************************************************************
// TIIOPProfile
//**********************************************************************
constructor TIIOPProfile.Create(const objkey: AnsiString;len: _ulong;
   address: IInetAddress;comps: IMultiComponent;
   version : _ushort; tagid: ProfileID);
begin
  inherited Create();
  FOKLen := len;
  FObjKey := objkey;
  FAddress := address;
  self.FMultiComponent := comps;
  FVersion := version;
  if (FVersion < $0101) and (comps <> nil) and (comps.size > 0)  then
    FVersion := $0101;
  FID := tagid;
end;

constructor TIIOPProfile.Create_prof(const prof: IIOPProfile);
var
  objkey: AnsiString;
  len: _ulong;
begin
  inherited Create();
  objkey := prof.objkey(len);
  FOKLen := len;
  FObjKey := objkey;
  FAddress := IInetAddress(prof.address);
  Self.FMultiComponent := IMultiComponent(prof.get_components);
  FVersion := prof.version;
  if (FVersion < $0101) and (FMultiComponent <> nil) and (FMultiComponent.size > 0)  then
    FVersion := $0101;
  FID := prof.id;
end;

function TIIOPProfile.version: _ushort;
begin
  result := FVersion;
end;

function TIIOPProfile.objkeylen: _ulong;
begin
  result := FOKLen;
end;

function TIIOPProfile.get_components: IInterface;
begin
  result := FMultiComponent;
end;

{function TIIOPProfile.comps: IMultiComponent;
begin
  result := FMultiComponent;
end;}

function TIIOPProfile.clone(): IIORProfile;
begin
  result := TIIOPProfile.Create_prof(self);
end;

function TIIOPProfile.compare(const p: IIORProfile): boolean;
var
  obKey: AnsiString;
  len: _ulong;
begin
  result := false;
  if p.id() <> id() then
    Exit;
  if objkeylen() <> p.objkeylen() then
    Exit;
  obKey := p.objkey(len);
  if not CompareMem(PAnsiChar(FObjKey), PAnsiChar(obKey), objkeylen()) then
    Exit;
  if version() <> IIOPProfile(p).version() then
    Exit;
  if not address.compare(p.address()) then
    Exit;
  result := true;
end;

function TIIOPProfile.reachable: boolean;
begin
  result := true;
end;

procedure TIIOPProfile.set_objectkey(const val: AnsiString; const len : _ulong);
begin
  FOKLen := len;
  FObjKey := val;
end;

procedure TIIOPProfile.encode(const enc: IEncoder);
begin
  enc.put_octet(Octet(FVersion shr 8));
  enc.put_octet(Octet(FVersion));
  enc.put_string(AnsiString(FAddress.host));
  enc.put_ushort(FAddress._Port);
  enc.seq_begin(FOKLen);
  enc.put_octets(PAnsiChar(FObjKey)^,FOKLen);
  enc.seq_end;
  if FVersion >= $0101 then
    FMultiComponent.encode(enc);
end;

function TIIOPProfile.objkey(var len: _ulong): AnsiString;
begin
  result := FObjKey;
  len := FOKLen;
end;

procedure TIIOPProfile.print(s: TStream);
var
  ps : TPrintStream;
begin
  ps := TPrintStream(s);
  ps.writeln('IIOP Profile');
  ps.writeln ('   Version: '+ AnsiString(IntToStr(FVersion shr 8)) + '.' + AnsiString(IntToStr(Fversion and $FF)));
  ps.writeln ('   Address: '+ FAddress.toString);
  ps.writestr('   Location: corbaloc::');
  if FVersion <> $0100 then
      ps.writeln(AnsiString(IntToStr(FVersion shr 8)) + '.' + AnsiString(IntToStr(Fversion and $FF)+'@'));
  ps.writestr(AnsiString(FAddress.Host) + ':' + AnsiString(IntToStr(FAddress._Port)));
  if FOKLen > 0 then
    ps.writestr('/' + url_encode(FObjKey));
  ps.writecrlf;
  ps.writecrlf;
end;


//**********************************************************************
// TMultiCompProfile
//**********************************************************************
constructor TMultiCompProfile.Create(mc: IMultiComponent; id : ProfileID);
begin
  FID := id;
  FMultiComponent := mc;
end;

constructor TMultiCompProfile.Create_prof(const prof: IMultiComponentProfile);
begin
  FMultiComponent := IMultiComponent(prof.get_components);
  FID := prof.id;
end;

function TMultiCompProfile.compare(const p: IIORProfile): boolean;
begin
  { TODO -oOVS : implement compare }
  result := true;
end;

function TMultiCompProfile.reachable: boolean;
begin
  result := false;
end;

procedure TMultiCompProfile.set_objectkey(const val: AnsiString; const len : _ulong);
begin

end;

function TMultiCompProfile.clone: IIORProfile;
begin
  result := TMultiCompProfile.Create_prof(self);
end;

procedure TMultiCompProfile.encode(const enc: IEncoder);
begin
  FMultiComponent.encode(enc);
end;

procedure TMultiCompProfile.print(s: TStream);
begin
  TPrintStream(s).writeln('Multiple Components Profile');
  FMultiComponent.print(s);
end;

function TMultiCompProfile.get_components(): IInterface;
begin
  result := FMultiComponent;
end;

//********************************************************************
// TGIOPSimpleProfile
//********************************************************************
constructor TGIOPSimpleProfile.Create(const objkey: AnsiString;len: _ulong);
begin
  FOKLen := len;
  FObjKey := objkey;
end;

constructor TGIOPSimpleProfile.Create_prof(const prof: IIORProfile);
begin
  FObjKey := prof.objkey(_ulong(FOKLen));
end;

function TGIOPSimpleProfile.compare(const p: IIORProfile): boolean;
begin
  { TODO -oOVS : implement compare }
  result := true;
end;

procedure TGIOPSimpleProfile.encode(const enc: IEncoder);
begin
  assert(false);
end;

function TGIOPSimpleProfile.id(): ProfileID;
begin
  result := 10000;
end;

function TGIOPSimpleProfile.objkey(var len: _ulong): AnsiString;
begin
  result := FObjKey;
  len := FOKLen;
end;

function TGIOPSimpleProfile.clone(): IIORProfile;
begin
  result := TGIOPSimpleProfile.Create_prof(self);
end;

procedure TGIOPSimpleProfile.print(s: TStream);
begin
  s.Write(AnsiString('GIOPSimple Profile'),20);
end;

function TGIOPSimpleProfile.reachable: boolean;
begin
  result := true;
end;

procedure TGIOPSimpleProfile.set_objectkey(const val: AnsiString; const len : _ulong);
begin
  FOKLen := len;
  FObjKey := val;
end;

//********************************************************************
// TUnknownProfile
//********************************************************************
function TUnknownProfile.address: IAddress;
begin
  //Unknown profiles don't have an address.
  result := nil;
end;

function TUnknownProfile.clone: IIORProfile;
begin
  result := TUnknownProfile.Create(IUnknownProfile(Self));
end;

function TUnknownProfile.compare(const p: IIORProfile): boolean;
begin
  result := id() = p.id;
  if not result then
    Exit;
  result := CompareMem(Pointer(FTagData), Pointer((p as IUnknownProfile).tagdata), Length(FTagData));
end;

constructor TUnknownProfile.Create(Id: ProfileID);
begin
  FID := Id;
  // byteorder octet
  SetLength(FTagData, 1);
  FTagData[0] := 0;
end;

constructor TUnknownProfile.Create(prof: IUnknownProfile);
begin
  FId := prof.id;
  FTagData := Copy(prof.tagdata, 0, Length(prof.tagdata));
end;

class function TUnknownProfile.decode(const dec: IDecoder; Id: ProfileID;
  len: _ulong): IIORProfile;
var
  p: TUnknownProfile;
begin
  if (len > 10000) then
    // this must be garbage
    Exit;

  if (dec._buffer().length() < len) then
    Exit;

  p := TUnknownProfile.Create(id);

  SetLength(p.FTagData, 0);
  SetLength(p.FTagData, len + 1);
  dec._buffer().RseekFromCurrent(-1);
  dec.get_octets(Pointer(p.FTagData)^, len + 1);

  result := p;
end;

procedure TUnknownProfile.encode(const enc: IEncoder);
begin
  // XXX vector elements need not be continuous ...
  // seek back one byte to overwrite byteorder octet
  enc.buffer().WseekFromCurrent(-1);
  enc.put_octets(FTagData, Length(FTagData));
end;

function TUnknownProfile.id: ProfileID;
begin
  result := inherited id();
end;

function TUnknownProfile.objkey(var len: _ulong): AnsiString;
begin
  //Doesn't return anything useful.
end;

procedure TUnknownProfile.print(s: TStream);
begin
  //Print information to the output stream.
end;

function TUnknownProfile.reachable: boolean;
begin
  //Unknown profiles can't be reachable.
  result := false;
end;

procedure TUnknownProfile.set_objectkey(const val: AnsiString;
  const len: _ulong);
begin
  //Doesn't do anything.
end;

function TUnknownProfile.tagdata: OctetSeq;
begin
  result := FTagData;
end;

{ TLocalProfile }

function TLocalProfile.clone: IIORProfile;
begin

end;

function TLocalProfile.compare(const p: IIORProfile): boolean;
begin
  result := false;
end;

constructor TLocalProfile.Create(const objkey: AnsiString; len: _ulong;
  id: ProfileId; const host: AnsiString; pid: long);
begin
  FId := id;
  if FHost <> '' then
    FHost := host
  else
    FHost := TInetAddress.hostname();
  if pid >= 0 then
    FPID := pid
  else
{$IFDEF MSWINDOWS}
    FPID := GetCurrentProcessId();
{$ENDIF}
{$IFDEF LINUX}
    FPID := getpid();
{$ENDIF}
  FObjKey := objkey;
  FOKLen := len;
end;

procedure TLocalProfile.encode(const enc: IEncoder);
begin
  enc.put_string(AnsiString(FHost));
  enc.put_long(FPID);

  enc.seq_begin(FOKLen);
  enc.put_octets(PAnsiChar(FObjKey)^, FOKLen);
  enc.seq_end();
end;

function TLocalProfile.get_components: IInterface;
begin

end;

function TLocalProfile.objkey(var len: _ulong): AnsiString;
begin
  result := FObjKey;
  len := FOKLen;
end;

function TLocalProfile.objkeylen: _ulong;
begin
  result := FOKLen;
end;

procedure TLocalProfile.print(s: TStream);
var
  ps : TPrintStream;
begin
  ps := TPrintStream(s);
  ps.writeln('Local Profile');
  ps.writecrlf;
end;

function TLocalProfile.reachable: boolean;
begin
{$IFDEF MSWINDOWS}
  Assert(false);
  result := true;
{$ELSE}
  result := (FHost = TInetAddress.hostname()) and (FPID = getpid());
{$ENDIF}
end;

procedure TLocalProfile.set_objectkey(const val: AnsiString;
  const len: _ulong);
begin
  FObjKey := val;
  FOKLen := len;
end;

function CreateIOR():IIOR;
begin
  result := TIOR.Create()
end;

function CreateIOR_ior(const tmpl: IIOR): IIOR;
begin
  result := TIOR.Create(tmpl)
end;

function CreateIOR_ref(const ref: AnsiString): IIOR;
begin
  result := TIOR.Create(ref)
end;

function ior_from_string(const Value: AnsiString): IIOR;
begin
  result := TIOR.Create;
  result.from_string(value);
end;

{$IFDEF LIBRARY}
exports
  CreateIOR,
  CreateIOR_ior,
  CreateIOR_ref,
  ior_from_string;
{$ENDIF}
initialization
  decodersVar := TThreadList.Create;
  IIOPProfileDecoder := TIIOPProfileDecoder.Create(TAG_INTERNET_IOP);
  MultiCompProfileDecoder := TMultiCompProfileDecoder.Create(TAG_MULTIPLE_COMPONENTS);
finalization
  IIOPProfileDecoder := nil;
  MultiCompProfileDecoder := nil;
  FreeAndNil(decodersVar);
{$ELSE}
  function CreateIOR():IIOR; external MTDORB_Library_Name;
  function CreateIOR_ior(const tmpl: IIOR): IIOR;external MTDORB_Library_Name;
  function CreateIOR_ref(const ref: string): IIOR;external MTDORB_Library_Name;
  function ior_from_string(const Value: string): IIOR;external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
