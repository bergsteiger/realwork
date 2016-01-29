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
unit codeset;

interface

uses
  {$IFDEF WIN32}windows,{$ENDIF}orbcomp,orbtypes,Classes,decoder,orb_int,orb,comp_int,code_int,intercept,
  intercept_int,mcomp_int,codeset_conv;

{$IFNDEF USELIB}

type
  TCodeset = class(TInterfacedObject, ICodeset)
  private
    FInfo: PCodesetInfo;
  protected
    function id(): CodesetID;
    function codepoint_size(): _ushort;
    function max_codepoints(): _ushort;
  public
    constructor Create(const info: PCodesetInfo);
    class function special_cs(const csid: SpecialCS): ICodeset;
    class procedure set_special_cs(const csid: SpecialCS; const cs: ICodeset);
    class function find_codeset(const name: AnsiString): PCodesetInfo;
    class function _create(const id: CodesetID): ICodeset; overload;
    class function _create(const name: AnsiString): ICodeset; overload;
    class procedure disable(const dis: boolean);
    class function disabled(): boolean;
  end;

  TCodesetComponent = class(TORBComponent,IORBComponent,ICodesetComponent)
  private
    FNativeCodeset : CodesetID;
    FNativeWCodeset : CodesetID;
    FCodesets : TList;
    FWCodesets : TList;
    FSelectedCodeset: CodesetID;
    FSelectedWCodeset: CodesetID;
  protected
    procedure encode(const enc: IEncoder); override;
    procedure print(s: TStream); override;
    function selected_cs(): CodesetID;
    function selected_wcs(): CodesetID;
  public
    constructor Create(ncs,nwcs: CodesetID; css,wcss: TList);
    destructor Destroy(); override;
  end;

  TCodesetComponentDecoder = class(TORBComponentDecoder,IORBComponentDecoder)
  private
    FCSets,FWCSets : TList;
  public
    constructor Create(id: ComponentID);
    destructor Destroy(); override;
    function decode(dec: IDecoder; cid: ComponentID; len: _ulong): IORBComponent; override;
  end;

  TCodesetConverter = class(TInterfacedObject, ICodesetConverter)
  protected
    FFrom,
    FTo: ICodeset;
   (*
    * both from and to codesets can be byte oriented and non byte oriented.
    * there is one convert() method for each of those four combinations.
    *)
    function encode_a(const from: AnsiString; const len: long; const _to: IBuffer; const terminate: boolean = true): long; overload; virtual;
    function encode_w(const from: WideString; const len: long; const _to: IBuffer; const terminate: boolean = true): long; overload; virtual;
    function decode(const from: IBuffer; const len: long; var _to: AnsiString; const terminate: boolean = true): long; overload; virtual;
    function decode(const from: IBuffer; const len: long; var _to: WideString; const terminate: boolean = true): long; overload; virtual;
  public
    constructor Create(const from, _to: ICodeset);
    class function can_convert(const from, _to: CodesetID): boolean;
    class function _create(const from, _to: ICodeset): ICodesetConverter;
  end;

  TUniCodesetConverter = class(TCodesetConverter)
  private
    function convert(const from: AnsiString; const len: long; var _to: AnsiString): long;
  protected
   (*
    * both from and to codesets can be byte oriented and non byte oriented.
    * there is one convert() method for each of those four combinations.
    *)
    function encode_a(const from: AnsiString; const len: long; const _to: IBuffer; const terminate: boolean = true): long; overload; override;
    function encode_w(const from: WideString; const len: long; const _to: IBuffer; const terminate: boolean = true): long; overload; override;
    function decode(const from: IBuffer; const len: long; var _to: AnsiString; const terminate: boolean = true): long; overload; override;
    function decode(const from: IBuffer; const len: long; var _to: WideString; const terminate: boolean = true): long; overload; override;
  public
    class function can_convert(const from, _to: CodesetID): boolean;
    class function _create(const from, _to: ICodeset): ICodesetConverter;
    class function supported_csid(const csid: CodesetID): boolean;
  end;

  (*
   * CodeSetCoder implementation for GIOP 1.0
   *   - TCS-C is ISO 8859-1
   *   - no TCS-W
   *)
  TGIOP_1_0_CodesetCoder = class(TORBObject,ICodesetCoder)
  private
    FIsOk: boolean;
    FConverter: ICodesetConverter;
  protected
    function isok: boolean;
    function get_char(const dec: IDecoder; var o : AnsiChar) : Boolean;  virtual;
    function get_chars(const dec: IDecoder; var buffer; size: _ulong) : Boolean; virtual;
    function get_string(const dec: IDecoder; var s : AnsiString) : Boolean; virtual;
    function get_wchar(const dec: IDecoder; var o : WideChar) : Boolean; virtual;
    function get_wchars(const dec: IDecoder; var buffer; size: _ulong) : Boolean; virtual;
    function get_wstring(const dec: IDecoder; var s : WideString) : Boolean; virtual;
    procedure put_char(const enc: IEncoder; c : AnsiChar); virtual;
    procedure put_chars(const enc: IEncoder; const arr;const len: _ulong); virtual;
    procedure put_string(const enc: IEncoder; const str: AnsiString); virtual;
    procedure put_wchar(const enc: IEncoder; c : WideChar); virtual;
    procedure put_wchars(const enc: IEncoder; const arr;const len: _ulong); virtual;
    procedure put_wstring(const enc: IEncoder; const str: WideString); virtual;
  public
    constructor Create;
  end;

  (*
   * CodeSetCoder implementation for GIOP 1.1
   *   - conversion is performed from and to TCS-C
   *   - handling of TCS-W is ignored, it isn't portable anyway
   *
   * If _conv is NULL; then it is assumed that TCS-C is the same as
   * the native charset, and that no conversion is necessary
   *)
  TGIOP_1_1_CodesetCoder = class(TORBObject,ICodesetCoder)
  private
    FIsOk: boolean;
    FTCSC: CodesetID;
    FConvN2T,
    FConvT2N: ICodesetConverter;
    FCodepointSize,
    FMaxCodepoints: _ushort;
    FNativeMaxCP: _ushort;
  protected
    function isok: boolean; virtual;
    function get_char(const dec: IDecoder; var o : AnsiChar) : Boolean;
    function get_chars(const dec: IDecoder; var buffer; size: _ulong) : Boolean;
    function get_string(const dec: IDecoder; var s : AnsiString) : Boolean;
    function get_wchar(const dec: IDecoder; var o : WideChar) : Boolean; virtual;
    function get_wchars(const dec: IDecoder; var buffer; size: _ulong) : Boolean; virtual;
    function get_wstring(const dec: IDecoder; var s : WideString) : Boolean; virtual;
    procedure put_char(const enc: IEncoder; c : AnsiChar);
    procedure put_chars(const enc: IEncoder; const arr;const len: _ulong);
    procedure put_string(const enc: IEncoder; const str: AnsiString);
    procedure put_wchar(const enc: IEncoder; c : WideChar); virtual;
    procedure put_wchars(const enc: IEncoder; const arr;const len: _ulong); virtual;
    procedure put_wstring(const enc: IEncoder; const str: WideString); virtual;
  public
    constructor Create(tcsc: CodesetID);
  end;

  (*
   * CodeSetCoder implementation for GIOP 1.2
   *   - correct handling of TCS-C and TCS-W
   *
   * char and string encoding is the same as in GIOP 1.1, so we
   * inherit the GIOP 1.1 encoder and just overload the wchar and
   * wstring functions.
   *
   * CORBA 2.4 introduced special handling of UTF-16 (optional Byte
   * Order Markers, default Big Endian) without changing the GIOP
   * version number. This is getting complicated ...
   *)
  TGIOP_1_2_CodesetCoder = class(TGIOP_1_1_CodesetCoder,ICodesetCoder)
  private
    FWIsOk: boolean;
    FTCSW: CodesetID;
    FWConvN2T,
    FWConvT2N: ICodesetConverter;
    FWCodepointSize,
    FWMaxCodepoints,
    FWNativeMaxCP: _ushort;
    //FConverter: ICodesetConverter;
  protected
    function isok: boolean; override;
    function get_wchar(const dec: IDecoder; var o : WideChar) : Boolean; override;
    function get_wchars(const dec: IDecoder; var buffer; size: _ulong) : Boolean; override;
    function get_wstring(const dec: IDecoder; var s : WideString) : Boolean; override;
    procedure put_wchar(const enc: IEncoder; c : WideChar); override;
    procedure put_wchars(const enc: IEncoder; const arr;const len: _ulong); override;
    procedure put_wstring(const enc: IEncoder; const str: WideString); override;
  public
    constructor Create(tcsc, tcsw: CodesetID);
  end;

  TCodesetInit = class(TInitInterceptor)
  protected
    function initialize(const orb: IORB; const id: ORBId; argv: TStrings): TStatus; override;
  end;

procedure CodesetInit;

implementation

uses
  {$ifdef LINUX}dynlibs,{$endif} pstream,utils,codeset_ref,throw,ior,SysUtils,buffer;

  {uni_fromUTF8: function(utf8: PChar; const src: PChar; var chars, utf_read: _ulong;
    string_type: _ulong; line_type: char; var written: _ulong): long; stdcall = nil;
  uni_toUTF8: function(utf8: PChar; src: PChar; chars, str_type: _ulong;
    line_type: byte; var written: _ulong): long; stdcall = nil;}

var
  specialVar: array [SpecialCS] of ICodeset;
  disableCSVar: boolean;
  codesetInitVar: IInitInterceptor;
{$IFNDEF BUILDIN_CONV}
  ConverterLibrary: THandle;
{$ENDIF}

procedure CodesetInit;
begin
  codesetInitVar := TCodesetInit.Create(0);
end;

{**********************************************************************
 TCodesetComponent
**********************************************************************}
constructor TCodesetComponent.Create(ncs,nwcs: CodesetID; css,wcss: TList);
var
  i : integer;
begin
  inherited Create();
  set_id(TAG_CODE_SETS);
  FCodesets := TList.Create;
  if css <> nil then
    for i := 0 to Pred(css.Count) do
      FCodesets.add(css[i]);
  FWCodesets := TList.Create;
  if wcss <> nil then
    for i := 0 to Pred(wcss.Count) do
      FwCodesets.add(wcss[i]);
  FNativeCodeset := ncs;
  FNativeWCodeset := nwcs;
end;

destructor TCodesetComponent.Destroy();
begin
  FCodesets.Free;
  FWCodesets.Free;
  inherited Destroy();
end;

procedure TCodesetComponent.print(s: TStream);
var
  ps : TPrintStream;
  normal,wide : PCodesetInfo;
begin
  ps := TPrintStream(s);
  ps.writeln('Native Codesets:');
  normal := find_codeset(FNativeCodeset);
  wide := find_codeset(FNativeWCodeset);
  if normal <> nil then
    ps.writeln('               normal:'+normal^.desc);
  if wide <> nil then
    ps.writeln('                wide:'+wide^.desc);
end;

function TCodesetComponent.selected_cs(): CodesetID;
var
  clnat, svnat: CodesetID;
  i: integer;
begin
  if FSelectedCodeset <> 0 then begin
    result := FSelectedCodeset;
    Exit;
  end;
  clnat := TCodeset.special_cs(NativeCS).id;
  svnat := FNativeCodeset;
  (*
   * this is a workaround for a bug in VB, which specifies
   * a native code set 0 and no conversion code sets
   *)
  if (FNativeCodeset = 0) and (FCodesets.Count = 0) then
    svnat := TCodeset.special_cs(DefaultCS).id;

  // same native code sets?
  if clnat = svnat then begin
    FSelectedCodeset := clnat;
    result := FSelectedCodeset;
    Exit;
  end;
  // can client convert its native code set to servers native code set?
  if TCodesetConverter.can_convert(clnat, svnat) then begin
    FSelectedCodeset := svnat;
    result := FSelectedCodeset;
    Exit;
  end;
  // can server convert clients native code set to its native code set?
  for i := 0 to FCodesets.Count - 1 do
    if clnat = CodesetID(FCodesets.Items[i]) then begin
      FSelectedCodeset := clnat;
      result := FSelectedCodeset;
      Exit;
    end;
  (*
   * is there an intermediate code set client and server can convert
   * their native code sets to? favor server preferences.
   *)
  for i := 0 to FCodesets.Count - 1 do
    if TCodesetConverter.can_convert(clnat, CodesetID(FCodesets.Items[i])) then begin
      FSelectedCodeset := CodesetID(FCodesets.Items[i]);
      result := FSelectedCodeset;
      Exit;
    end;
  // use fallback code set
  FSelectedCodeset := TCodeset.special_cs(FallbackCS).id;
  result := FSelectedCodeset;
end;

function TCodesetComponent.selected_wcs(): CodesetID;
var
  clnat, svnat: CodesetID;
  i: integer;
begin
  if FSelectedWCodeset <> 0 then begin
    result := FSelectedWCodeset;
    Exit;
  end;
  clnat := TCodeset.special_cs(NativeWCS).id;
  svnat := FNativeWCodeset;
  (*
   * this is a workaround for a bug in VB, which specifies
   * a native code set 0 and no conversion code sets
   *)
  if (FNativeWCodeset = 0) and (FWCodesets.Count = 0) then
    svnat := TCodeset.special_cs(DefaultWCS).id;

  // same native code sets?
  if clnat = svnat then begin
    FSelectedWCodeset := clnat;
    result := FSelectedWCodeset;
    Exit;
  end;
  // can client convert its native code set to servers native code set?
  if TCodesetConverter.can_convert(clnat, svnat) then begin
    FSelectedWCodeset := svnat;
    result := FSelectedWCodeset;
    Exit;
  end;
  // can server convert clients native code set to its native code set?
  for i := 0 to FWCodesets.Count - 1 do
    if clnat = CodesetID(FWCodesets.Items[i]) then begin
      FSelectedWCodeset := clnat;
      result := FSelectedWCodeset;
      Exit;
    end;
  (*
   * is there an intermediate code set client and server can convert
   * their native code sets to? favor server preferences.
   *)
  for i := 0 to FWCodesets.Count - 1 do
    if TCodesetConverter.can_convert(clnat, CodesetID(FWCodesets.Items[i])) then begin
      FSelectedWCodeset := CodesetID(FWCodesets.Items[i]);
      result := FSelectedWCodeset;
      Exit;
    end;
  // use fallback code set
  FSelectedWCodeset := TCodeset.special_cs(FallbackWCS).id;
  result := FSelectedWCodeset;
end;

procedure TCodesetComponent.encode(const enc: IEncoder);
var
  i : integer;
begin
  enc.put_ulong(FNativeCodeset);
  enc.seq_begin(FCodesets.Count);
  for i := 0 to Pred(FCodesets.Count) do
    enc.put_ulong(_ulong(FCodesets[i]));
  enc.seq_end;
  enc.put_ulong(FNativeWCodeset);
  enc.seq_begin(FWCodesets.Count);
  for i := 0 to Pred(FWCodesets.Count) do
    enc.put_ulong(_ulong(FWCodesets[i]));
  enc.seq_end;
end;

{**********************************************************************
 TCodesetComponentDecoder
**********************************************************************}
constructor TCodesetComponentDecoder.Create(id: ComponentID);
begin
  inherited Create(id);
  FCSets := TList.Create;
  FWCSets := TList.Create;
end;

destructor TCodesetComponentDecoder.Destroy();
begin
  FreeAndNil(FCSets);
  FreeAndNil(FWCSets);
  inherited Destroy();
end;

function TCodesetComponentDecoder.decode(dec: IDecoder; cid: ComponentID;
  len: _ulong): IORBComponent;
var
  native_cset,native_wcset : CodesetID;
  cnt,cs : _ulong;
begin
  result := nil;
  FCSets.Clear;
  FWCSets.Clear;
  if not dec.get_ulong(native_cset) then exit;
  if not dec.seq_begin(cnt) then exit;
  while cnt > 0 do
    begin
      if not dec.get_ulong(cs) then exit;
      FCSets.Add(Pointer(cs));
      cnt := cnt - 1;
    end;
  if not dec.seq_end() then exit;
  if not dec.get_ulong(native_wcset) then exit;
  if not dec.seq_begin(cnt) then exit;
  while cnt > 0 do
    begin
      if not dec.get_ulong(cs) then exit;
      FWCSets.Add(Pointer(cs));
      cnt := cnt - 1;
    end;
  if not dec.seq_end() then exit;
  result := TCodesetComponent.Create(native_cset,native_wcset,FCSets,FWCSets);
end;

{ TGIOP_1_0_CodesetCoder }

(*
 * GIOP 1.0 does not have code set negotiation.
 *  - TCS-C is fixed to ISO 8859-1 (0x00010001)
 *  - there is no TCS-W
 *)
constructor TGIOP_1_0_CodesetCoder.Create;
var
  native: CodesetID;
  natcs, cstcs: ICodeset;
begin
  inherited Create;
  native := TCodeset.special_cs(NativeCS).id;
  if native = $00010001 then begin
   (*
    * ISO 8859-1 is the native charset, no conversion necessary
    *)
    FIsOk := true;
  end
  else if not TCodesetConverter.can_convert(native, $00010001) then
    FIsOk := false
  else begin
    natcs := TCodeset._create(native);
    cstcs := TCodeset._create($00010001);
    Assert((natcs <> nil) and (cstcs <> nil));
    FConverter := TCodesetConverter._create(natcs, cstcs);
    FIsOk := FConverter <> nil;
  end;
end;

function TGIOP_1_0_CodesetCoder.get_char(const dec: IDecoder;
  var o: AnsiChar): Boolean;
var
  str: AnsiString;
begin
  Assert(FIsOk);
  if FConverter = nil then
    result := dec._buffer.get1(o)
  else begin
    result := FConverter.decode(dec._buffer, 1, str, false) = 1;
    o := str[1];
  end;
end;

function TGIOP_1_0_CodesetCoder.get_chars(const dec: IDecoder; var buffer;
  size: _ulong): Boolean;
var
  str: AnsiString;
  len: integer;
begin
  Assert(FIsOk);
  if FConverter = nil then
    result := dec._buffer.get(buffer, size)
  else begin
    result := FConverter.decode(dec._buffer, size, str, false) = long(size);
    len := Length(str);
    SetLength(OctetSeq(buffer), len);
    move(Pointer(str)^, buffer, len);
  end;
end;

function TGIOP_1_0_CodesetCoder.get_string(const dec: IDecoder;
  var s: AnsiString): Boolean;
var
  len: _ulong;
  oct: Octet;
begin
  Assert(FIsOk);
  result := false;
  if not dec.get_ulong(len) then Exit;
  if (len = 0) or (len > dec._buffer.length()) then Exit;

  SetLength(s, len - 1);
  if FConverter = nil then begin
    if len > 1 then begin
      dec._buffer.get(PAnsiChar(s)^, len);
    end
    else begin
      s := '';
      dec._buffer.RseekFromCurrent(len);
    end;
    result := true;
  end
  else begin
    SetLength(s, len - 1);
    result := FConverter.decode(dec._buffer, len - 1, s, true) = long(len);
    if result then
      result := dec._buffer.get(oct); // eat up null octet
  end;
end;

(*
 * There is no wchar in GIOP 1.0, so we refuse to handle them
 *)
function TGIOP_1_0_CodesetCoder.get_wchar(const dec: IDecoder;
  var o: WideChar): Boolean;
var
  us: _ushort;
  ul: _ulong;
begin
  result := false;
  if TCodeset.special_cs(NativeWCS).max_codepoints <= 2 then begin
    if not dec._buffer.get2(us) then
      Exit;
    o := WideChar(us);
  end
  else begin
    if not dec._buffer.get4(ul) then
      Exit;
    o := WideChar(ul);
  end;
  result := true;
end;

function TGIOP_1_0_CodesetCoder.get_wchars(const dec: IDecoder; var buffer;
  size: _ulong): Boolean;
var
  i: integer;
  wcs: WCharSeq;
begin
  result := false;
  SetLength(wcs, size);
  for i := 0 to size - 1 do begin
    result := get_wchar(dec, wcs[i]);
    if not result then
      Exit;
  end;
  move(Pointer(wcs)^, buffer, size * SizeOf(WideChar));
end;

function TGIOP_1_0_CodesetCoder.get_wstring(const dec: IDecoder;
  var s: WideString): Boolean;
var
  len: _ulong;
begin
  result := false;
  if not dec.get_ulong(len) and (len = 0) then
    Exit;
  SetLength(s, len);
  result := get_wchars(dec, Pointer(s)^, len);
  SetLength(s, len - 1);
end;

function TGIOP_1_0_CodesetCoder.isok: boolean;
begin
  result := FIsOk;
end;

procedure TGIOP_1_0_CodesetCoder.put_char(const enc: IEncoder; c: AnsiChar);
var
  str: AnsiString;
begin
  Assert(FIsOk);
  if FConverter = nil then
    enc.buffer.put1(c)
  else begin
    SetLength(str, 1);
    str[1] := c;
    FConverter.encode_a(str, 1, enc.buffer, false);
  end;
end;

procedure TGIOP_1_0_CodesetCoder.put_chars(const enc: IEncoder; const arr;
  const len: _ulong);
var
  str: AnsiString;
begin
  Assert(FIsOk);
  if FConverter = nil then
    enc.buffer.put(arr, len)
  else begin
    SetLength(str, len);
    move(arr, Pointer(str)^, len);
    FConverter.encode_a(str, len, enc.buffer, false);
  end;
end;

procedure TGIOP_1_0_CodesetCoder.put_string(const enc: IEncoder;
  const str: AnsiString);
var
  len: _ulong;
begin
  Assert(FIsOk);
  len := Length(str);
  if FConverter = nil then begin
    enc.put_ulong(len+1);
    enc.buffer.put(PAnsiChar(Str)^,len+1);
  end
  else begin
    enc.put_ulong(len+1);
    FConverter.encode_a(str, len, enc.buffer, false);
    enc.put_octet(0);
  end;
end;

procedure TGIOP_1_0_CodesetCoder.put_wchar(const enc: IEncoder; c: WideChar);
var
  us: _ushort;
  ul: _ulong;
begin
  if TCodeset.special_cs(NativeWCS).max_codepoints <= 2 then begin
    us := _ushort(c);
    enc.buffer.put2(us)
  end
  else begin
    ul := _ulong(c);
    enc.buffer.put4(ul);
  end;
end;

procedure TGIOP_1_0_CodesetCoder.put_wchars(const enc: IEncoder; const arr;
  const len: _ulong);
var
  i: integer;
  wcs: WCharSeq;
begin
  SetLength(wcs, len);
  move(arr, Pointer(wcs)^, len * SizeOf(WideChar));
  for i := 0 to len - 1 do
    put_wchar(enc, wcs[i]);
end;

procedure TGIOP_1_0_CodesetCoder.put_wstring(const enc: IEncoder;
  const str: WideString);
var
  i, len: integer;
  us: _ushort;
  ul: _ulong;
begin
  len := Length(str);
  enc.put_ulong(len + 1);
  for i := 1 to len do begin
    if TCodeset.special_cs(NativeWCS).max_codepoints <= 2 then begin
      us := _ushort(str[i]);
      enc.buffer.put2(us)
    end
    else begin
      ul := _ulong(str[i]);
      enc.buffer.put4(ul);
    end;
  end;
  // Write terminating null characte
  if TCodeset.special_cs(NativeWCS).max_codepoints <= 2 then begin
    us := 0;
    enc.buffer.put2(us)
  end
  else begin
    ul := 0;
    enc.buffer.put4(ul);
  end;
end;

{ TCodesetConverter }

function TCodesetConverter.decode(const from: IBuffer; const len: long;
  var _to: AnsiString; const terminate: boolean): long;
var
  us: _ushort;
  l: _ulong;
  i: integer;
begin
  result := -1;
  case FFrom.codepoint_size of
    1: begin
         if not from.get(PAnsiChar(_to)^, len) then Exit;
         //if terminate then
           //_to[Length(_to)] := #0;
       end;
    2: begin
         for i := len downto 0 do begin
           if not from.get2(us) then Exit;
           _to[len - i] := AnsiChar(us);
         end;
         //if terminate then
           //_to^ := #0;
       end;
    3, 4: begin
            for i := len downto 0 do begin
              if not from.get4(l) then Exit;
              _to[len - i] := AnsiChar(l);
            end;
            //if terminate then
              //_to^ := #0;
          end;
    else
      Assert(false);
  end;
  result := len + 1;
end;

class function TCodesetConverter.can_convert(const from,
  _to: CodesetID): boolean;
begin
  result := from = _to;
  if not result then
    result := TUniCodesetConverter.can_convert(from, _to);
end;

function TCodesetConverter.decode(const from: IBuffer; const len: long;
  var _to: WideString; const terminate: boolean): long;
var
  us: _ushort;
  i: integer;
begin
  case FFrom.codepoint_size of
    1: begin
    
    end;
    2: begin
      for i := 1 to len do begin
        if not from.get(us, 2) then begin
          result := -1;
          Exit;
        end;
        _to[i] := WideChar(us);
      end;
    end;
    3, 4: begin
    end;
    else
      Assert(false);
  end;
  // number of codepoints read
  result := len;
end;

function TCodesetConverter.encode_a(const from: AnsiString; const len: long;
  const _to: IBuffer; const terminate: boolean): long;
var
  b: _ushort;
  l: _ulong;
  i: integer;
begin
  case FFrom.codepoint_size of
    1: begin
         _to.put(PAnsiChar(from)^, len);
         if terminate then
           _to.put(0);
       end;
    2: begin
         for i := len downto 0 do begin
           b := _ushort(from[len - i]);
           _to.put2(b);
         end;
         if terminate then begin
           b := 0;
           _to.put2(b);
         end;
       end;
    3, 4: begin
            for i := len downto 0 do begin
              l := _ulong(from[len - i]);
              _to.put4(l);
            end;
            if terminate then begin
              l := 0;
              _to.put4(l);
            end;
           end;
    else
      Assert(false);
  end;
  result := len + long(terminate);
end;

function TCodesetConverter.encode_w(const from: WideString; const len: long;
  const _to: IBuffer; const terminate: boolean): long;
var
  i: integer;
  str: String;
  b: _ushort;
begin
  case FFrom.codepoint_size of
    1: begin
      str := from;
      for i := 1 to len do begin
        //ch := from[i];
        _to.put1(str[i]);
      end;
      if terminate then
        _to.put(0);
    end;
    2: begin
      for i := 1 to len do begin
        b := _ushort(from[i]);
        _to.put(b, 2);
      end;
      if terminate then begin
        b := 0;
        _to.put(b, 2);
      end;
    end;
    3, 4: begin
    end;
    else
      Assert(false);
  end;
  // number of codepoints written
  result := len + Ord(terminate);
end;

class function TCodesetConverter._create(const from,
  _to: ICodeset): ICodesetConverter;
begin
  if from.id = _to.id then
    result := TCodesetConverter.Create(from, _to) as ICodesetConverter
  else
    result := TUniCodesetConverter._create(from, _to);
end;

constructor TCodesetConverter.Create(const from, _to: ICodeset);
begin
  FFrom := from;
  FTo := _to;
end;

{ TUniCodesetConverter }

function TUniCodesetConverter.decode(const from: IBuffer; const len: long;
  var _to: AnsiString; const terminate: boolean): long;
var
  flen, tlen{, written}: long;
  fr, t: AnsiString;
  i: integer;
begin
  flen := FFrom.codepoint_size();
  if flen = 3 then flen := 4;
  flen := flen * len;
  if ((len * FFrom.codepoint_size()) > long(from.length())) then begin
    result := -1;
    Exit;
  end;

  SetLength(fr, flen);
  if not from.get(PAnsiChar(fr)^, len * FFrom.codepoint_size()) then begin
    result := -1;
    Exit;
  end;

  tlen := FTo.codepoint_size();
  if tlen = 3 then tlen := 4;
  tlen := tlen * len * FTo.max_codepoints();
  if FTo.codepoint_size() <> 1 then
    SetLength(_to, tlen);

  SetLength(t, flen);
  result := convert(fr, flen, t);

  if not terminate then
    Dec(result);

  case FTo.codepoint_size() of
    1: _to := AnsiString(t);
    2: begin
         for i := result downto 0 do
           _to[result - i] := PAnsiChar(PSmallint(t[(result - i) * 2])^)^;
       end;
    3, 4: begin
            for i := result downto 0 do
              _to[result - i] := PAnsiChar(PInteger(t[(result - i) * 2])^)^;
          end;
    else
      Assert(false);
  end;
end;

class function TUniCodesetConverter.can_convert(const from,
  _to: CodesetID): boolean;
begin
  result := TUniCodesetConverter.supported_csid(from) and TUniCodesetConverter.supported_csid(_to);
end;

function TUniCodesetConverter.decode(const from: IBuffer; const len: long;
  var _to: WideString; const terminate: boolean): long;
var
  flen, tlen: long;
  fr, t: AnsiString;
  //i: integer;
begin
  flen := FFrom.codepoint_size();
  if flen = 3 then
    flen := 4;
  flen := flen * len;
  if ((len * FFrom.codepoint_size()) > long(from.length())) then begin
    result := -1;
    Exit;
  end;

  SetLength(fr, flen);
  if not from.get(Pointer(fr)^, len * FFrom.codepoint_size) then begin
    result := -1;
    Exit;
  end;

  tlen := FTo.codepoint_size;
  if tlen = 3 then
    tlen := 4;
  tlen := tlen * FTo.max_codepoints;
  if FTo.codepoint_size < 3 then
    SetLength(t, tlen);

  result := convert(fr, len, t);

  if result < 0 then
    Exit;
  if not terminate then
    result := result - 1;

  case FTo.codepoint_size of
    1: begin
      SetLength(_to, result);
      {for i := 1 to result do
        _to[i] := WideChar(t[i]);}
      _to := WideString(t);
    end;
  end;
end;

function TUniCodesetConverter.encode_a(const from: AnsiString; const len: long;
  const _to: IBuffer; const terminate: boolean): long;
var
  flen, tlen{, written}: long;
  fr, t: AnsiString;
  cp: PAnsiChar;
  i: integer;
begin
  flen := FFrom.codepoint_size();
  Assert((flen = 1) or (flen = 2) or (flen = 4));
  flen := flen * len;
  case FFrom.codepoint_size of
    1: fr := from;
    2: begin
         SetLength(fr, flen);
         cp := PAnsiChar(fr);
         for i := len downto 0 do begin
           PSmallint(cp)^ := Ord(from[len - i]);
           Inc(cp, 2);
         end;
       end;
    3, 4: begin
            SetLength(fr, flen);
            cp := PAnsiChar(fr);
            for i := len downto 0 do begin
              PInteger(cp)^ := Ord(from[len - i]);
              Inc(cp, 4);
            end;
          end;
    else
      Assert(false);
  end;
  tlen := FTo.codepoint_size();
  if tlen = 3 then tlen := 4;
  tlen := tlen * len * FTo.max_codepoints();
  SetLength(t, tlen);
  result := convert(fr, flen, t);
  if result >= 0 then begin
    if not terminate then
      Dec(result);
    //SetLength(t, result);
    _to.put(PAnsiChar(t)^, result * FTo.codepoint_size());
  end;
end;

function TUniCodesetConverter.encode_w(const from: WideString; const len: long;
  const _to: IBuffer; const terminate: boolean): long;
var
  flen, tlen: long;
  fr, t: AnsiString;
  //i: integer;
begin
  flen := FFrom.codepoint_size();
  Assert((flen = 1) or (flen = 2) or (flen = 4));
  //Assert(SizeOf(WideChar) = 4);
  flen := flen * len;

  if FFrom.codepoint_size < 2 then
    SetLength(fr, flen);

  case FFrom.codepoint_size of
    1: begin
      fr := AnsiString(from);
      {for i := 1 to len do
        fr[i] := AnsiChar(from[i]);}
    end;
  end;

  tlen := FTo.codepoint_size;
  if tlen = 3 then
    tlen := 4;
  tlen := tlen * len * FTo.codepoint_size;
  SetLength(t, tlen);
  result := convert(fr, len, t);
  if result < 0 then
    Exit;
  if not terminate then
    result := result - 1;
  _to.put(PAnsiChar(t)^, result * FTo.codepoint_size);
end;

class function TUniCodesetConverter._create(const from,
  _to: ICodeset): ICodesetConverter;
begin
  if TUniCodesetConverter.can_convert(from.id, _to.id) then
    result := TUniCodesetConverter.Create(from, _to) as ICodesetConverter;
end;

class function TUniCodesetConverter.supported_csid(
  const csid: CodesetID): boolean;
begin
  case csid of
    C_ISO8859_1,
    C_ISO8859_2,
    C_ISO8859_3,
    C_ISO8859_4,
    C_ISO8859_5,
    C_ISO8859_6,
    C_ISO8859_7,
    C_ISO8859_8,
    C_ISO8859_9,
    C_ISO8859_10,
    C_IBM_437,
    C_IBM_850,
    C_IBM_852,
    C_IBM_860,
    C_IBM_863,
    C_IBM_865,
    C_UCS4,
    C_UTF16,
    C_UTF8,
    C_WIN31_LATIN1,
    C_ASCII7,
    C_EBCDIC,
    C_MACINTOSH,
    C_KOI8_R,
    C_IBM_1251,
    C_UTF7,
    C_HTML3:
      result := true;
    else
      result := false;
  end;
end;

function TUniCodesetConverter.convert(const from: AnsiString; const len: long;
  var _to: AnsiString): long;
var
  //wstr: WideString;
  tmp: AnsiString;
  chars: _ulong;
  utf_write{, utf_read}, written: _ulong;
  res: long;
begin
  if FFrom.id = C_UTF8 then begin
    chars := len; utf_write := 0; written := 0;
    //res := uni_fromUTF8(PChar(_to), PChar(from), chars, utf_write, FTo.id(), Chr(2), written);
    res := UnicodeFromUTF8(_to, from, chars, utf_write, FTo.id(), written);
    if res = C_OK then
      result := written
    else
      result := -1;
    Exit;
  end;
  if FTo.id = C_UTF8 then begin
    written := 0;                                              {C_LINE_LF}
    //res := uni_toUTF8(PChar(_to), PChar(from), len, FFrom.id(), 2, written);
    res := UnicodeToUTF8(_to, from, len, FFrom.id(), written);
    if res = C_OK then
      result := written
    else
      result := -1;
    Exit;
  end;

  // UTF8 has max 6 code points per char
  SetLength(tmp, len * 6);
  //res := uni_toUTF8(PChar(tmp), PChar(from), len, FFrom.id(), 2, chars);
  res := UnicodeToUTF8(tmp, from, len, FFrom.id(), chars);
  if res <> C_OK then begin
    result := -1;
    Exit;
  end;
  //res := uni_fromUTF8(PChar(_to), PChar(tmp), chars, utf_read, FTo.id(), Chr(2), written);
  res := UnicodeFromUTF8(_to, tmp, chars, utf_write, FTo.id(), written);
  if res = C_OK then
    result := written
  else
    result := -1;
end;

{function TUniCodesetConverter.uni_toUTF8(var utf8: PChar; src: PChar; chars: _ulong;
  str_type: CodesetID; line_type: byte; var written: long): long;
begin
  result := -1;
end;}

{ TCodeset }

function TCodeset.codepoint_size: _ushort;
begin
  result := FInfo^.codepoint_size;
end;

constructor TCodeset.Create(const info: PCodesetInfo);
begin
  FInfo := info;
end;

class procedure TCodeset.disable(const dis: boolean);
begin
  disableCSVar := dis;
end;

class function TCodeset.disabled: boolean;
begin
  result := disableCSVar;
end;

class function TCodeset.find_codeset(const name: AnsiString): PCodesetInfo;
var
  i : integer;
begin
  result := nil;
  for i := 0 to High(TCodesets) do
{$IFDEF FPC}
    if Pos(UpCase(name), UpCase(String(TCodesets[i].desc))) > 0 then
{$ELSE}
    if Pos(UpperCase(String(name)), UpperCase(String(TCodesets[i].desc))) > 0 then
{$ENDIF}
      begin
        result := @TCodesets[i];
        break;
      end;
end;

function TCodeset.id: CodesetID;
begin
  result := FInfo.id;
end;

function TCodeset.max_codepoints: _ushort;
begin
  result := FInfo.max_codepoints;
end;

class procedure TCodeset.set_special_cs(const csid: SpecialCS;
  const cs: ICodeset);
begin
  specialVar[csid] := cs;
end;

class function TCodeset.special_cs(const csid: SpecialCS): ICodeset;
begin
  result := specialVar[csid];
end;

class function TCodeset._create(const id: CodesetID): ICodeset;
var
  info: PCodesetInfo;
begin
  info := utils.find_codeset(id);
  if info <> nil then
    result := TCodeset.Create(info);
end;

class function TCodeset._create(const name: AnsiString): ICodeset;
var
  info: PCodesetInfo;
begin
  info := find_codeset(name);
  if info <> nil then
    result := TCodeset.Create(info);
end;

{ TCodesetInit }

function TCodesetInit.initialize(const orb: IORB; const id: ORBId;
  argv: TStrings): TStatus;
var
  i: integer;
  str, csname, wcsname: AnsiString;
  disable: boolean;
  cs: ICodeset;
  mcprof : IMultiComponentProfile;
  mc : IMultiComponent;
  //hd: THandle;
begin
  result := INVOKE_ABORT;
  disable := false;
  if argv <> nil then begin
    i := 0;
    while i < argv.Count do begin
{$IFDEF FPC}
      str := AnsiString(UpCase(argv.Strings[i]));
{$ELSE}
      str := AnsiString(UpperCase(argv.Strings[i]));
{$ENDIF}
      //add ssl property
      if (str = '-ORBNATIVECS') then begin
        i := Succ(i);
        csname := AnsiString(argv.Strings[i]);
        orb.get_Properties.set_Property('mtdorb.orb.native_codeset', String(csname));
      end
      else if (str = '-ORBNATIVEWCS') then begin
        i := Succ(i);
        wcsname := AnsiString(argv.Strings[i]);
        orb.get_Properties.set_Property('mtdorb.orb.native_wcodeset', String(wcsname));
      end
      else if (str = '-ORBNOCODESETS') then
        disable := true;

      i := Succ(i);
    end; { while }
  end;
  TCodeset.disable(disable);
  // native char code set
  if csname = '' then
    //csname := '*8859-1*';
    csname := '8859-1';
  cs := TCodeset._create(csname);
  if cs = nil then begin
    Exit;
  end;
  TCodeset.set_special_cs(NativeCS, cs);

  // native wide char code set
  if wcsname = '' then
    //wcsname := '*UTF-16*';
    wcsname := 'UTF-16';
  cs := TCodeset._create(wcsname);
  if cs = nil then begin
    Exit;
  end;
  TCodeset.set_special_cs(NativeWCS, cs);

  // default char code set
  //csname := '*8859-1*';
  csname := '8859-1';
  cs := nil;
  cs := TCodeset._create(csname);
  if cs = nil then begin
    Exit;
  end;
  TCodeset.set_special_cs(DefaultCS, cs);

  // default wide char code set (spec says there is no default ...)
  //wcsname := '*UTF-16*';
  wcsname := 'UTF-16';
  cs := nil;
  cs := TCodeset._create(wcsname);
  if cs = nil then begin
    Exit;
  end;
  TCodeset.set_special_cs(DefaultWCS, cs);

  // fallback char code set
  //csname := '*UTF-8*';
  csname := 'UTF-8';
  cs := nil;
  cs := TCodeset._create(csname);
  if cs = nil then begin
    Exit;
  end;
  TCodeset.set_special_cs(FallbackCS, cs);

  // fallback wide char code set
  //wcsname := '*UTF-16*';
  wcsname := 'UTF-16';
  cs := nil;
  cs := TCodeset._create(wcsname);
  if cs = nil then begin
    result := INVOKE_ABORT;
    Exit;
  end;
  TCodeset.set_special_cs(FallbackWCS, cs);

  // install code set info in ior template
  if not disable then begin
{$IFNDEF BUILDIN_CONV} //build in
{$IFDEF WIN32}
    ConverterLibrary := LoadLibrary('MTDORB_UCUtils.dll');
{$ENDIF}
{$IFDEF LINUX}
    ConverterLibrary := LoadLibrary('MTDORB_UCUtils.so');
{$ENDIF}
    if ConverterLibrary = 0 {<= HINSTANCE_ERROR} then Exit;
    @uni_fromUTF8 := GetProcAddress(ConverterLibrary, 'uni_fromUTF8');
    @uni_toUTF8 := GetProcAddress(ConverterLibrary, 'uni_toUTF8');
    if (@uni_fromUTF8 = nil) or (@uni_toUTF8 = nil) then Exit;
{$ENDIF}
    mc := TMultiComponent.Create();
    mc.set_id(TAG_CODE_SETS);
    mc.add_component(TCodesetComponent.Create(
      TCodeset.special_cs(NativeCS).id,
      TCodeset.special_cs(NativeWCS).id,
      nil,
      nil) as IORBComponent);
    mcprof := TMultiCompProfile.Create(mc,TAG_MULTIPLE_COMPONENTS);
    orb_instance.ior_template.add_profile(mcprof);
  end;
  result := INVOKE_CONTINUE;
end;

{ TGIOP_1_1_CodesetCoder }

(*
 * GIOP 1.1 supports codeset negotiation. However, it is a bit confused
 * about the encoding of wchars and wstrings. Therefore, we handle TCS-C
 * encoding, but don't support wchar and wstring.
 *)

constructor TGIOP_1_1_CodesetCoder.Create(tcsc: CodesetID);
var
  native: CodesetID;
  csnative1,
  cstcs1,
  csnative2,
  cstcs2: ICodeset;
begin
  inherited Create;
  native := TCodeset.special_cs(NativeCS).id;
  FTCSC := tcsc;
  if (native = tcsc) and (TCodeset.special_cs(NativeCS).codepoint_size = SizeOf(Char)) then begin
   (*
    * No conversion is necessary
    *)
    FConvN2T := nil;
    FConvT2N := nil;
    FIsOk := true;
  end
  else if not TCodesetConverter.can_convert(native, tcsc) then
    FIsOk := false
  else begin
    csnative1 := TCodeset._create(native);
    cstcs1 := TCodeset._create(tcsc);
    csnative2 := TCodeset._create(native);
    cstcs2 := TCodeset._create(tcsc);
    Assert((csnative1 <> nil) and (cstcs1 <> nil) and (csnative2 <> nil) and (cstcs2 <> nil));

    FCodepointSize := cstcs1.codepoint_size();
    FMaxCodepoints := cstcs1.max_codepoints();
    FNativeMaxCP := csnative1.max_codepoints();

    FConvN2T := TCodesetConverter._create(csnative1, cstcs1);
    FConvT2N := TCodesetConverter._create(cstcs2, csnative2);
    FIsOk := (FConvN2T <> nil) and (FConvT2N <> nil);
  end;
end;

function TGIOP_1_1_CodesetCoder.get_char(const dec: IDecoder;
  var o: AnsiChar): Boolean;
var
  str: AnsiString;
  oc: OctetSeq;
  buf: IBuffer;
begin
  Assert(FIsOk);
  result := true;
  if FConvT2N = nil then begin
    dec._buffer.get1(o);
    Exit;
  end;
 (*
  * A character is encoded as a single octet. If TCS-C is a multi-byte
  * character set, only the first octet is sent. Doesn't make a lot of
  * sense, does it?
  *)
  if (FCodepointSize = 1) and (FMaxCodepoints = 1) then begin
    SetLength(str, 1);
    if FConvT2N.decode(dec._buffer, 1, str, false) <> 1 then begin
      result := false;
      Exit;
    end;
    o := str[1];
  end
  else begin
    SetLength(oc, 8);
    if not dec._buffer.get1(Pointer(oc)^) then begin
      result := false;
      Exit;
    end;
    SetLength(str, 1);
    buf := TBuffer.Create(oc);
    if FConvT2N.decode(buf, 1, str, false) <> 1 then begin
      result := false;
      Exit;
    end;
  end;
end;

function TGIOP_1_1_CodesetCoder.get_chars(const dec: IDecoder; var buffer;
  size: _ulong): Boolean;
var
  str: AnsiString;
  buf: IBuffer;
  b: pointer;
  idx, len: integer;
begin
  Assert(FIsOk);
  result := true;
  if FConvT2N = nil then begin
    dec._buffer.get(buffer, size);
    Exit;
  end;
  if (FCodepointSize = 1) and (FMaxCodepoints = 1) then begin
    SetLength(str, size);
    if FConvT2N.decode(dec._buffer, size, str, false) < 0 then begin
      result := false;
      Exit;
    end;
    len := Length(str);
    SetLength(OctetSeq(buffer), len);
    move(Pointer(str)^, buffer, len);
  end
  else begin
    buf := TBuffer.Create(8);
    SetLength(str, 1);
    SetLength(OctetSeq(buffer), size);
    idx := 0;
    while idx < long(size) do begin
      buf.RseekFromBegin(0);
      b := buf._buffer();
      if not dec._buffer.get1(b) then begin
        result := false;
        Exit;
      end;
      if FConvT2N.decode(buf, 1, str, false) <> 1 then begin
        result := false;
        Exit;
      end;
      OctetSeq(buffer)[idx] := Octet(str[1]);
      idx := Succ(idx);
    end; { while }
  end;
end;

function TGIOP_1_1_CodesetCoder.get_string(const dec: IDecoder;
  var s: AnsiString): Boolean;
var
  len: _ulong;
  c: char;
  cp: _ulong;
  swap: boolean;
  bom: OctetSeq;
  temp: IBuffer;
  count: integer;
  tptr: pointer;
begin
  Assert(FIsOk);
  result := false;
  
  if not dec.get_ulong(len) then
    Exit;
  if (len = 0) then
    Exit;
    
  if FConvT2N = nil then begin
    if len > dec._buffer().length() then Exit;

    if len > 1 then begin
      SetLength(s, len - 1);
      if not dec._buffer.get(PAnsiChar(s)^, len) then Exit;
    end
    else begin
      s := '';
      dec._buffer.RseekFromCurrent(len);
      result := true;
      Exit;
    end;
  end
  else if (FCodepointSize = 1) and (FMaxCodepoints = 1) and (FNativeMaxCP = 1) then begin
    if len > dec._buffer().length() then Exit;

    SetLength(s, len - 1);
    if FConvT2N.decode(dec._buffer, len - 1, s, true) <> long(len) then Exit;
    if not dec._buffer.get1(c) then Exit; (* eat up null octet *)
  end
  else if FTCSC = $00010109 then begin (* special handling for UTF-16 *)
   (*
    * Handle BOM if TCS-C is UTF-16
    *)
    cp := len div 2 - 1;
    SetLength(bom, 2);
    if cp > 0 then begin
      if not dec._buffer.peek(Pointer(bom)^, 2) then Exit;
      if (bom[0] = $FE) and (bom[1] = $FF) then begin
       (*
	* BOM says that codepoints are in Big Endian
	*)
{$IFDEF HAVE_BYTEORDER_BE}
        swap := false;
{$ELSE}
        swap := true;
{$ENDIF}
        dec._buffer.get(Pointer(bom)^, 2); (* eat up BOM *)
        cp := Pred(cp);
      end
      else if (bom[0] = $FF) and (bom[1] = $FE) then begin
       (*
        * BOM says that codepoints are in Little Endian
        *)
        swap := false;
        dec._buffer.get(Pointer(bom)^, 2); (* eat up BOM *)
        cp := Pred(cp);
      end
      else begin
       (*
        * There is no BOM, so default to Big Endian
        *)
        swap := true;
      end;
    end
    else begin
     (*
      * zero codepoints, so it doesn't matter anyway
      *)
      swap := false;
    end;

    if (cp * FCodepointSize) > dec._buffer().length() then Exit;

    SetLength(s, cp);
    if not swap then begin
      if FConvT2N.decode(dec._buffer, cp, s, true) < 0 then Exit;
    end
    else begin
     (*
      * codepoint swapping is necessary
      *)
      temp := TBuffer.Create(cp * 2);
      tptr := temp._buffer();
      for count := 0 to cp - 1 do begin
        if not dec._buffer.get1(PChar(PChar(tptr) + 1)^) and
           not dec._buffer.get1(PChar(tptr)^) then Exit;
        Inc(PChar(tptr), 2);
      end;
      if FConvT2N.decode(temp, cp, s, true) < 0 then Exit;
    end;
    if not dec._buffer.get(Pointer(bom)^, 2) then Exit; (* eat up BOM *)
  end
  else begin
    cp := len div FCodepointSize - 1;
    if (cp * FCodepointSize) > dec._buffer().length() then Exit;

    SetLength(s, cp * FNativeMaxCP);
    if FConvT2N.decode(dec._buffer, cp, s, true) < 0 then Exit;
    (*
     * eat up null octets
     *)
    count := FCodepointSize - 1;
    while count >= 0 do begin
      if not dec._buffer.get1(len) then Exit;
      count := Pred(count);
    end; { while }
  end;
  result := true;
end;

function TGIOP_1_1_CodesetCoder.get_wchar(const dec: IDecoder;
  var o: WideChar): Boolean;
var
  us: _ushort;
  ul: _ulong;
begin
  result := false;
  if TCodeset.special_cs(NativeWCS).max_codepoints <= 2 then begin
    if not dec._buffer.get2(us) then
      Exit;
    o := WideChar(us);
  end
  else begin
    if not dec._buffer.get4(ul) then
      Exit;
    o := WideChar(ul);
  end;
  result := true;
end;

function TGIOP_1_1_CodesetCoder.get_wchars(const dec: IDecoder; var buffer;
  size: _ulong): Boolean;
var
  i: integer;
  wcs: WCharSeq;
begin
  result := false;
  SetLength(wcs, size);
  for i := 0 to size - 1 do begin
    result := get_wchar(dec, wcs[i]);
    if not result then
      Exit;
  end;
  move(Pointer(wcs)^, buffer, size * SizeOf(WideChar));
end;

function TGIOP_1_1_CodesetCoder.get_wstring(const dec: IDecoder;
  var s: WideString): Boolean;
var
  len: _ulong;
begin
  result := false;
  if not dec.get_ulong(len) and (len = 0) then
    Exit;
  SetLength(s, len);
  result := get_wchars(dec, Pointer(s)^, len);
  SetLength(s, len - 1);
end;

function TGIOP_1_1_CodesetCoder.isok: boolean;
begin
  result := FIsOk;
end;

procedure TGIOP_1_1_CodesetCoder.put_char(const enc: IEncoder; c: AnsiChar);
var
  str: AnsiString;
  buf: IBuffer;
  p: pointer;
begin
  Assert(FIsOk);
  if FConvN2T = nil then begin
    enc.buffer.put1(c);
    Exit;
  end;
  if (FCodepointSize = 1) and (FMaxCodepoints = 1) then begin
    SetLength(str, 1);
    str[1] := c;
    FConvN2T.encode_a(str, 1, enc.buffer, false);
  end
  else begin
    buf := TBuffer.Create(8);
    SetLength(str, 1);
    str[1] := c;
    if FConvN2T.encode_a(str, 1, buf, false) <= 0 then Exit;
    p := buf._buffer();
    enc.buffer.put1(p);
  end;
end;

procedure TGIOP_1_1_CodesetCoder.put_chars(const enc: IEncoder; const arr;
  const len: _ulong);
var
  str: AnsiString;
  count: integer;
  buf: IBuffer;
  p: pointer;
begin
  Assert(FIsOk);
  if FConvN2T = nil then begin
    enc.buffer.put(arr, len);
    Exit;
  end;
  if (FCodepointSize = 1) and (FMaxCodepoints = 1) then begin
    SetLength(str, len);
    move(arr, Pointer(str)^, len);
    FConvN2T.encode_a(str, len, enc.buffer, false);
  end
  else begin
    buf := TBuffer.Create(8);
    p := buf._buffer;
    count := Pred(len);
    SetLength(str, 1);
    while count < long(len) do begin
      buf.WseekFromBegin(0);
      str[1] := AnsiChar(OctetSeq(arr)[count]);
      if FConvN2T.encode_a(str, 1, buf, false) <= 0 then Exit;
      count := Succ(count);
      enc.buffer.put1(p);
    end; { while }
  end;
end;

procedure TGIOP_1_1_CodesetCoder.put_string(const enc: IEncoder;
  const str: AnsiString);
var
  len, i: integer;
  pos, npos: _ulong;
begin
  Assert(FIsOk);
  len := Length(str);
  //if len = 0 then Exit;
  if FConvN2T = nil then begin
    enc.put_ulong(len + 1);
    enc.buffer.put(PAnsiChar(str)^, len + 1);
    Exit;
  end;
  if (FCodepointSize = 1) and (FMaxCodepoints = 1) and (FNativeMaxCP = 1) then begin
    enc.put_ulong(len + 1);
    if FConvN2T.encode_a(str, len, enc.buffer, false) <> len then Exit;
    enc.put_octet(0);
  end
  else begin
    enc.put_ulong(0); (* dummy value *)
    pos := enc.buffer.WPosition;
   (*
    * place BOM if TCS-C is UTF-16 and HostByteOrder is not the
    * default BigEndian
    *)
    if FTCSC = $00010109 then
      enc.buffer.put2(#$FF#$FE);
    if FConvN2T.encode_a(str, len, enc.buffer, false) < 0 then Exit;
   (*
    * put null octets
    *)
    for i := 0 to FCodepointSize - 1 do
      enc.put_octet(0);
   (*
    * fix length info
    *)
    npos := enc.buffer.WPosition;
    enc.buffer.WseekFromBegin(pos - 4);
    enc.put_ulong(npos - pos);
    enc.buffer.WseekFromBegin(npos);
  end;
end;

procedure TGIOP_1_1_CodesetCoder.put_wchar(const enc: IEncoder;
  c: WideChar);
var
  us: _ushort;
  ul: _ulong;
begin
  if TCodeset.special_cs(NativeWCS).max_codepoints <= 2 then begin
    us := _ushort(c);
    enc.buffer.put2(us)
  end
  else begin
    ul := _ulong(c);
    enc.buffer.put4(ul);
  end;
end;

procedure TGIOP_1_1_CodesetCoder.put_wchars(const enc: IEncoder; const arr;
  const len: _ulong);
var
  i: integer;
  wcs: WCharSeq;
begin
  SetLength(wcs, len);
  move(arr, Pointer(wcs)^, len * SizeOf(WideChar));
  for i := 0 to len - 1 do
    put_wchar(enc, wcs[i]);
end;

procedure TGIOP_1_1_CodesetCoder.put_wstring(const enc: IEncoder;
  const str: WideString);
var
  i, len: integer;
  us: _ushort;
  ul: _ulong;
begin
  len := Length(str);
  enc.put_ulong(len + 1);
  for i := 1 to len do begin
    if TCodeset.special_cs(NativeWCS).max_codepoints <= 2 then begin
      us := _ushort(str[i]);
      enc.buffer.put2(us)
    end
    else begin
      ul := _ulong(str[i]);
      enc.buffer.put4(ul);
    end;
  end;
  // Write terminating null characte
  if TCodeset.special_cs(NativeWCS).max_codepoints <= 2 then begin
    us := 0;
    enc.buffer.put2(us)
  end
  else begin
    ul := 0;
    enc.buffer.put4(ul);
  end;
end;

{ TGIOP_1_2_CodesetCoder }

constructor TGIOP_1_2_CodesetCoder.Create(tcsc, tcsw: CodesetID);
var
  nativew: CodesetID;
  wcsnative1,
  wcstcs1,
  wcsnative2,
  wcstcs2: ICodeset;
begin
  inherited Create(tcsc);
  nativew := TCodeset.special_cs(NativeWCS).id;
  FTCSW := tcsw;
  if (nativew = tcsw) and (TCodeset.special_cs(NativeWCS).codepoint_size = SizeOf(WideChar)) then begin
   (*
    * No conversion is necessary
    *)
    FWConvN2T := nil;
    FWConvT2N := nil;
    FWCodepointSize := TCodeset.special_cs(NativeWCS).codepoint_size;
    FWMaxCodepoints := TCodeset.special_cs(NativeWCS).max_codepoints;
    FWNativeMaxCP := FWMaxCodepoints;
    FWIsOk := true;
  end
  else if not TCodesetConverter.can_convert(nativew, tcsw) then
    FWIsOk := false
  else begin
    wcsnative1 := TCodeset._create(nativew);
    wcstcs1 := TCodeset._create(tcsw);
    wcsnative2 := TCodeset._create(nativew);
    wcstcs2 := TCodeset._create(tcsw);
    Assert((wcsnative1 <> nil) and (wcstcs1 <> nil) and (wcsnative2 <> nil) and (wcstcs2 <> nil));

    FWCodepointSize := wcstcs1.codepoint_size;
    FWMaxCodepoints := wcstcs1.max_codepoints;
    FWNativeMaxCP := wcsnative1.max_codepoints;
    FWConvN2T := TCodesetConverter._create(wcsnative1, wcstcs1);
    FWConvT2N := TCodesetConverter._create(wcstcs2, wcsnative2);
    FWIsOk := (FWConvN2T <> nil) and (FWConvT2N <> nil);
  end;
end;

function TGIOP_1_2_CodesetCoder.isok: boolean;
begin
  result := FWIsOk and inherited isok();
end;

function TGIOP_1_2_CodesetCoder.get_wchar(const dec: IDecoder;
  var o: WideChar): Boolean;
var
  wstr: WideString;
  len: Octet;
  bom: array [0..1] of Octet;
  swap: boolean;
  temp: IBuffer;
begin
  Assert(FWIsOk);
  result := false;

  if not dec.get_octet(len) then
    Exit;

  if (len mod FWCodepointSize) <> 0 then
    Exit;

  if FWConvT2N = nil then begin
   (*
    * Special handling if TCS-W is UTF-16. There can be a BOM
    *)
    if (FTCSW = $00010109) and (len = 4) then begin
      if not dec._buffer.get(bom, 2) then
        Exit;
      if (bom[0] = $FE) and (bom[1] = $FF) then begin
{$IFDEF HAVE_BYTEORDER_BE}
{$ELSE}
{$ENDIF}
{$IFDEF HAVE_BYTEORDER_BE}
{$ELSE}
        result := dec._buffer.get1(Pointer(PChar(@o) + 1)^) and dec._buffer.get1(Pointer(PChar(@o))^);
{$ENDIF}
        Exit;
      end
      else if (bom[0] = $FF) and (bom[1] = $FE) then begin
{$IFDEF HAVE_BYTEORDER_BE}
{$ELSE}
        result := dec._buffer.get(o, 2);
{$ENDIF}
        Exit;
      end
      else
        // oops, no BOM, but a length of 4?
        Exit;
    end
    else if (FTCSW = $00010109) and (len = 2) then begin
{$IFDEF HAVE_BYTEORDER_BE}
{$ELSE}
      result := dec._buffer.get1(Pointer(PChar(@o) + 1)^) and dec._buffer.get1(Pointer(PChar(@o))^);
{$ENDIF}
      Exit;
    end;
    // can this happen?
    if len <> FWCodepointSize then
      Exit;
    result := dec._buffer.get(o, FWCodepointSize);
    Exit;
  end
  else if FTCSW = $00010109 then begin
   (*
    * Special handling for UTF-16
    *)
    if len = 4 then begin
      if not dec._buffer.get(bom, 2) then
        Exit;
      if (bom[0] = $FE) and (bom[1] = $FF) then
{$IFDEF HAVE_BYTEORDER_BE}
        swap := false
{$ELSE}
        swap := true
{$ENDIF}
      else if (bom[0] = $FF) and (bom[1] = $FE) then
{$IFDEF HAVE_BYTEORDER_BE}
        swap := true
{$ELSE}
        swap := false
{$ENDIF}
      else
        // oops, no BOM, but a length of 4?
        Exit;
    end
    else if len = 2 then
{$IFDEF HAVE_BYTEORDER_BE}
      swap := false
{$ELSE}
      swap := true
{$ENDIF}
    else
      // len != 4 && len != 2
      Exit;

    if not swap then begin
      SetLength(wstr, 1);
      if FWConvT2N.decode(dec._buffer, 1, wstr, false) <> 1 then
        Exit;
      o := wstr[1];
    end
    else begin
      temp := TBuffer.Create(2);
      if not dec._buffer.get1(Pointer(PChar(temp._buffer) + 1)^) or not (dec._buffer.get1(temp._buffer^)) then
        Exit;
    end;
  end
  else if len = FWCodepointSize then begin
    SetLength(wstr, 1);
    if FWConvT2N.decode(dec._buffer, 1, wstr, false) <> 1 then
      Exit;
    o := wstr[1];
  end
  else begin
    SetLength(wstr, len);
    if FWConvT2N.decode(dec._buffer, len div FWCodepointSize, wstr, false) <= 0 then
      Exit;
    o := wstr[1];
  end;

  result := true;
end;

function TGIOP_1_2_CodesetCoder.get_wchars(const dec: IDecoder; var buffer;
  size: _ulong): Boolean;
var
  i: integer;
begin
 (*
  * Nothing to optimize here
  *)
  for i := 1 to size do
    if not get_wchar(dec, WCharSeq(@buffer)[i]) then begin
      result := false;
      Exit;
    end;
  result := true;
end;

function TGIOP_1_2_CodesetCoder.get_wstring(const dec: IDecoder;
  var s: WideString): Boolean;
var
  len: _ulong;
  swap: boolean;
  bom: array [0..1] of Octet;
  buf: WideString;
  ptr: PWideChar;
  codepoints: _ulong;
  temp: IBuffer;
  tptr: ^Octet;
  count: _ulong;
begin
  Assert(FWIsOk);
  result := false;

  if not dec.get_ulong(len) then
    Exit;

  if (len mod FWCodepointSize) <> 0 then
    Exit;

  if len > dec._buffer().length() then
    Exit;

  if FWConvT2N = nil then begin
   (*
    * Special handling if TCS-W is UTF-16. There can be a BOM
    *)
    if FTCSW = $00010109 then begin
      swap := false;
      if len >= 2 then begin
        if not dec._buffer.peek(bom, 2) then
          Exit;
        if (bom[0] = $FE) and (bom[1] = $FF) then begin
{$IFDEF HAVE_BYTEORDER_BE}
          swap := false;
{$ELSE}
          swap := true;
{$ENDIF}
          dec._buffer.get(bom, 2);
          len := len - 2;
        end
        else if (bom[0] = $FF) and (bom[1] = $FE) then begin
{$IFDEF HAVE_BYTEORDER_BE}
          swap := true;
{$ELSE}
          swap := false;
{$ENDIF}
          dec._buffer.get(bom, 2);
          len := len - 2;
        end
        else
{$IFDEF HAVE_BYTEORDER_BE}
          swap := false;
{$ELSE}
          swap := true;
{$ENDIF}
      end;

      SetLength(buf, len div 2);

      if not swap then begin
        if not dec._buffer.get(Pointer(buf)^, len) then
          Exit;
      end
      else begin
        ptr := PWideChar(buf);
        while len <> 0 do begin
          if not dec._buffer.get1(Pointer(PChar(ptr) + 1)^) or
             not dec._buffer.get1(ptr^) then
            Exit;
          len := len - 2;
          ptr := ptr + 1;
        end; { while }
      end;
    end
    else begin
     (*
      * Native WCS == TCS-W != UTF-8
      *)
      SetLength(buf, len div FWCodepointSize);
      if not dec._buffer.get(buf, len) then
        Exit;
    end;
  end
  else if FTCSW = $00010109 then begin
   (*
    * Handle BOM if TCS-C is UTF-16
    *)
    codepoints := len div 2;

    if (codepoints > 0) then begin
      if not dec._buffer().peek(bom, 2) then
        Exit;

      if (bom[0] = $FE) and (bom[1] = $FF) then begin
       (*
        * BOM says that codepoints are in Big Endian
        *)
{$IFDEF HAVE_BYTEORDER_BE}
        swap := false;
{$ELSE}
        swap := true;
{$ENDIF}
        dec._buffer().get(bom, 2); // eat up BOM
        codepoints := codepoints - 2;
      end
      else if (bom[0] = $FF) and (bom[1] = $FE) then begin
       (*
        * BOM says that codepoints are in Little Endian
        *)
{$IFDEF HAVE_BYTEORDER_BE}
        swap := true;
{$ELSE}
        swap := false;
{$ENDIF}
        dec._buffer().get(bom, 2); // eat up BOM
        codepoints := codepoints - 2;
      end
      else begin
       (*
        * There is no BOM, so default to Big Endian
        *)
{$IFDEF HAVE_BYTEORDER_BE}
        swap := false;
{$ELSE}
        swap := true;
{$ENDIF}
      end
    end
    else begin
     (*
      * zero codepoints, so it doesn't matter anyway
      *)
      swap := false;
    end;

    SetLength(buf, codepoints * FWNativeMaxCP);

    if not swap then begin
      if (FWConvT2N.decode(dec._buffer(), codepoints, buf, true) < 0) then
        Exit;
    end
    else begin
     (*
      * codepoint swapping is necessary
      *)

      temp := TBuffer.Create(codepoints * 2);
      tptr := temp._buffer();

      for count := 0 to codepoints - 1 do begin
        if not dec._buffer().get1(Pointer(PChar(tptr) + 1)^) or not dec._buffer().get1(tptr^) then
          Exit;
        PChar(tptr) := PChar(tptr) + 2;
      end;

      temp.WseekFromBegin(codepoints * 2);

      if FWConvT2N.decode(temp, codepoints, buf, true) < 0 then
        Exit;
    end;
  end
  else begin
   (*
    * TCS-W != UTF-16
    *)
    SetLength(buf, len div FWCodepointSize * FWNativeMaxCP);
    if FWConvT2N.decode(dec._buffer(), len div FWCodepointSize, buf, false) < 0 then
      Exit;
  end;

  s := buf;
  result := true;
end;

procedure TGIOP_1_2_CodesetCoder.put_wchar(const enc: IEncoder;
  c: WideChar);
var
  p, np: integer;
begin
  Assert(FWIsOk);
  if FWConvN2T = nil then begin
{$IFNDEF HAVE_BYTEORDER_BE}
    if FTCSW = $00010109 then begin
     (*
      * place BOM if TCS-C is UTF-16 and HostByteOrder is not the
      * default BigEndian
      *)
      enc.put_octet(4);
      enc.buffer.put(#$FF#$FE, 2);
      enc.buffer.put(c, 2);
      Exit;
    end;
{$ENDIF}
    enc.put_octet(FWCodepointSize);
    enc.buffer.put(c, FWCodepointSize);
  end
  else begin
    enc.put_octet(FWCodepointSize); // dummy value
    p := enc.buffer.WPosition;
{$IFNDEF HAVE_BYTEORDER_BE}
    if FTCSW = $00010109 then
     (*
      * place BOM if TCS-C is UTF-16 and HostByteOrder is not the
      * default BigEndian
      *)
      enc.buffer.put(#$FF#$FE, 2);
{$ENDIF}
    if FWConvN2T.encode_w(c, 1, enc.buffer, false) <= 0 then
      Exit;
    np := enc.buffer.WPosition;
    if (np - p) <> FWCodepointSize then begin
      // fix dummy length
      enc.buffer.WseekFromBegin(p - 1);
      enc.put_octet(np - p);
      enc.buffer.WseekFromBegin(np);
    end;
  end;
end;

procedure TGIOP_1_2_CodesetCoder.put_wchars(const enc: IEncoder; const arr;
  const len: _ulong);
var
  i: integer;
begin
 (*
  * Nothing to improve here
  *)
  for i := 1 to len do
    put_wchar(enc, WCharSeq(@arr)[i]);
end;

procedure TGIOP_1_2_CodesetCoder.put_wstring(const enc: IEncoder;
  const str: WideString);
var
  len: _ulong;
  p, np: integer;
begin
  Assert(FWIsOk);
  len := Length(str);

  if len = 0 then begin
    enc.put_ulong(0);
    Exit;
  end;

  if FWConvN2T = nil then begin
{$IFNDEF HAVE_BYTEORDER_BE}
    if (FTCSW = $00010109) then begin
      enc.put_ulong(len * FWCodepointSize + 2);
      enc.buffer().put2(#$FF#$FE);
      enc.buffer().put(Pointer(str)^, len * FWCodepointSize);
      //result := true;
      Exit;
    end;
{$ENDIF}
    enc.put_ulong(len * FWCodepointSize);
    enc.buffer().put(Pointer(str)^, len * FWCodepointSize);
  end
  else begin
    enc.put_ulong({ dummy value } 0);
    p := enc.buffer().WPosition;

{$IFNDEF HAVE_BYTEORDER_BE}
    if (FTCSW = $00010109) then
     (*
      * place BOM if TCS-C is UTF-16 and HostByteOrder is not the
      * default BigEndian
      *)
      enc.buffer().put2(#$FF#$FE);
{$ENDIF}

    if FWConvN2T.encode_w(str, len, enc.buffer(), false) < 0 then
      Exit;

   (*
    * fix length info
    *)
    np := enc.buffer().WPosition();
    enc.buffer().WseekFromBegin(p - 4);
    enc.put_ulong(np - p);
    enc.buffer().WseekFromBegin(np);
  end;
end;

initialization
finalization

{$IFNDEF BUILDIN_CONV}
  if ConverterLibrary <> 0 then
    FreeLibrary(ConverterLibrary);
{$ENDIF}

{$ELSE}
implementation
{$ENDIF}
end.
