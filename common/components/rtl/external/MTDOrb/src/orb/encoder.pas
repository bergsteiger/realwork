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
unit encoder;

interface

uses
  orb_int,orb,orbtypes,SysUtils,code_int,Classes,map_int,utils;

{$IFNDEF USELIB}

type
  TValueState = class(TInterfacedObject,IValueState)
  private
    Fchunk_level: longint;
    Fnesting_level: longint;
    Ftag_pos: longint;
    Fvisited: IInterfaceLongMap;
  protected
    function get_chunk_level: longint;
    procedure set_chunk_level(val: integer);
    function get_nesting_level: longint;
    procedure set_nesting_level(val: integer);
    function get_tag_pos: longint;
    procedure set_tag_pos(val: integer);
    function visited: IInterfaceLongMap;
  public
    constructor Create();
//    procedure reset();
  end;

  TEncoder = class(TORBObject,IEncoder)
  private
    FBuffer : IBuffer;
    FByteOrder,FDataByteOrder : TByteOrder;
    FCodesetConv : ICodesetCoder;
    FValueState : IValueState;
  protected
    function clone(buf: IBuffer = nil; conv : ICodesetCoder = nil): IEncoder;
    function buffer(): IBuffer;  overload;
    procedure buffer(buf: IBuffer); overload;
    procedure byteorder(val: TByteOrder); overload;
    function byteorder(): TByteOrder; overload;
    procedure encaps_begin(var enc: TEncapsState);
    procedure encaps_end(enc: TEncapsState);
    procedure put_any(const a: IAny);
    procedure put_boolean(b : Boolean);
    procedure put_double(d : double);
    procedure put_float(f : float);
    procedure put_octet(b : Octet);
    procedure put_octets(const arr;const len: _ulong);
    procedure put_char(c : AnsiChar);
    procedure put_chars(const arr;const len: _ulong);
    procedure put_wchar(wc : WideChar);
    procedure put_wchars(const arr;const len: _ulong);
    procedure put_principal(const pr: IPrincipal);
    procedure put_short(s : short);
    procedure put_ushort(s : _ushort);
    procedure put_string(str: AnsiString);
    procedure put_wstring(str: WideString);
    procedure put_ulong(u: _ulong);
    procedure put_long(l: longint);
    procedure put_ulonglong(ul: _ulonglong);
    procedure put_longlong(l: longlong);
    procedure put_longdouble(l: longdouble);
    procedure set_converter(conv : ICodesetCoder);
    function get_converter(): ICodesetCoder;
    procedure seq_begin(len: _ulong);
    procedure seq_end();
    function valuestate(): IValueState;
    procedure value_begin(const url: AnsiString; const repoids: TStrings; chunked: Boolean; out value_id: longint); overload;
    procedure value_begin(const url: AnsiString; const repoids: TStrings; chunked: Boolean; out value_id: longint; vstate: IValueState); overload;
    procedure value_end(value_id: longint); overload;
    procedure value_end(value_id: longint; vstate: IValueState); overload;
    procedure value_ref(vid: longint);
    procedure except_begin(const repoid: AnsiString);
    procedure except_end();
    procedure put_typecode(const tc: ITypeCode);
    function max_alignment(): _ulong;
  public
    constructor Create(buf: IBuffer = nil; conv: ICodesetCoder = nil);
  end;

  function CreateEncoder(buf: IBuffer = nil) : IEncoder;

implementation

uses
  buffer,map;

{********************************************************
  TEncoder
********************************************************}
constructor TEncoder.Create(buf: IBuffer; conv: ICodesetCoder);
begin
  FBuffer := buf;
  if FBuffer = nil then
    FBuffer := TBuffer.Create(20);
  FByteOrder := LittleEndian;
  FDataByteOrder := FByteOrder;
  FValueState := TValueState.Create;
  FCodesetConv := conv;
end;

procedure TEncoder.buffer(buf: IBuffer);
begin
  FBuffer := buf;
end;

procedure TEncoder.set_converter(conv : ICodesetCoder);
begin
  FCodesetConv := conv;
end;

function TEncoder.get_converter: ICodesetCoder;
begin
  result := FCodesetConv;
end;

procedure TEncoder.put_ushort(s : _ushort);
var
  ss : _ushort;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put2(s)
  else
    begin
      swap2(s,ss);
      FBuffer.put2(ss)
    end;
end;

procedure TEncoder.put_short(s : short);
var
  ss : short;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put2(s)
  else
    begin
      swap2(s,ss);
      FBuffer.put2(ss)
    end;
end;

procedure TEncoder.put_string(str: AnsiString);
begin
  if FCodesetConv = nil then begin
    put_ulong(Length(str)+1);
    FBuffer.put(PAnsiChar(Str)^,Length(str)+1);
  end
  else
    FCodesetConv.put_string(Self, str);
end;

procedure TEncoder.put_wstring(str: WideString);
var
  len, i: integer;
begin
  if FCodesetConv = nil then begin
    len := Length(str) + 1;
    put_ulong(len);
    if len > 1 then
      for i := 1 to len - 1 do
        put_ushort(_ushort(str[i]));
    put_ushort(0);
  end
  else
    FCodesetConv.put_wstring(Self, str);
end;

procedure TEncoder.put_boolean(b : Boolean);
begin
  FBuffer.put1(b);
end;

procedure TEncoder.put_double(d : double);
var
  sd : double;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put8(d)
  else
    begin
      swap8(d,sd);
      FBuffer.put8(sd);
    end;
end;

procedure TEncoder.put_float(f : float);
var
  sf : float;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put4(f)
  else
    begin
      swap4(f,sf);
      FBuffer.put4(sf);
    end;
end;

procedure TEncoder.put_char(c: AnsiChar);
begin
  if FCodesetConv = nil then
    FBuffer.put1(c)
  else
    FCodesetConv.put_char(Self, c);
end;

procedure TEncoder.put_chars(const arr; const len: _ulong);
begin
  if FCodesetConv = nil then
    put_octets(arr,len)
  else
    FCodesetConv.put_chars(Self, arr, len);
end;

procedure TEncoder.put_wchar(wc: WideChar);
begin
  if FCodesetConv = nil then
    put_octets(wc, SizeOf(WideChar))
  else
    FCodesetConv.put_wchar(Self, wc);
end;

procedure TEncoder.put_wchars(const arr; const len: _ulong);
begin
  if FCodesetConv = nil then
    put_octets(arr, len * SizeOf(WideChar))
  else
    FCodesetConv.put_wchars(Self, arr, len);
end;

procedure TEncoder.put_octet(b : Octet);
begin
  FBuffer.put(b);
end;

function TEncoder.byteorder(): TByteOrder;
begin
  result := FByteOrder;
end;

function TEncoder.buffer(): IBuffer;
begin
  result := FBuffer;
end;

procedure TEncoder.put_long(l: longint);
var
  sl : longint;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put4(l)
  else
    begin
      swap4(l,sl);
      FBuffer.put4(sl);
    end;
end;

procedure TEncoder.put_longdouble(l: longdouble);
var
  sl : longdouble;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put16(l)
  else
    begin
      swap16(l,sl);
      FBuffer.put16(sl);
    end;
end;

procedure TEncoder.put_longlong(l: longlong);
var
  sl : longlong;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put8(l)
  else
    begin
      swap8(l,sl);
      FBuffer.put8(sl);
    end;
end;

procedure TEncoder.put_ulonglong(ul: _ulonglong);
var
  sul : _ulonglong;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put8(ul)
  else
    begin
      swap8(ul,sul);
      FBuffer.put8(sul);
    end;
end;

procedure TEncoder.put_ulong(u: _ulong);
var
  su : _ulong;
begin
  if FByteOrder = FDataByteOrder then
    FBuffer.put4(u)
  else
    begin
      swap4(u,su);
      FBuffer.put4(su);
    end;
end;

procedure TEncoder.encaps_begin(var enc: TEncapsState);
begin
  enc.align := FBuffer.getWAlignBase;
  enc.bo := FByteOrder;
  enc.pos := FBuffer.WPosition;
  put_ulong(0);
  FBuffer.setWAlignBase(FBuffer.WPosition);
  put_octet(Octet(enc.bo = LittleEndian))
end;

procedure TEncoder.encaps_end(enc: TEncapsState);
var
  dend,dstart : _ulong;
begin
  FByteOrder := enc.bo;
  FBuffer.setWAlignBase(enc.align);
  dend := FBuffer.WPosition;
  FBuffer.WseekFromBegin(enc.pos);
  put_ulong(0);
  dstart := FBuffer.WPosition;
  // store data size
  FBuffer.WseekFromBegin(enc.pos);
  put_ulong(dend-dstart);
  FBuffer.WseekFromBegin(dend);
end;

procedure TEncoder.seq_begin(len: _ulong);
begin
  put_ulong(len);
end;

procedure TEncoder.seq_end();
begin
  // nothing to do
end;

procedure TEncoder.put_principal(const pr: IPrincipal);
begin
  pr.encode(self);
end;

procedure TEncoder.put_octets(const arr;const len: _ulong);
begin
  FBuffer.put(arr,len);
end;

procedure TEncoder.except_begin(const repoid: AnsiString);
begin
  put_string(repoid);
end;

procedure TEncoder.except_end;
begin

end;

procedure TEncoder.byteorder(val: TByteOrder);
begin
  FByteOrder := val;
end;

procedure TEncoder.put_any(const a: IAny);
begin
  a.encode(self);
end;

procedure TEncoder.value_begin(const url: AnsiString; const repoids: TStrings; chunked: Boolean; out value_id: longint);
begin
  assert(FValueState <> nil);
  value_begin(url,repoids,chunked,value_id,FValueState);
end;

procedure TEncoder.value_end(value_id: longint);
begin
  assert(FValueState <> nil);
  value_end(value_id,FValueState);
end;

procedure TEncoder.value_begin(const url: AnsiString; const repoids: TStrings; chunked: Boolean; out value_id: longint; vstate: IValueState);
var
  wpos: _ulong;
  value_tag : longint;
  i : integer;
begin
  if (vstate.chunk_level <= vstate.nesting_level) and (vstate.tag_pos >= 0) then
    // close previous chunk
    begin
      if _ulong(vstate.tag_pos + sizeof(longint)) = FBuffer.WPosition then
        // chunk is empty
        FBuffer.WseekFromBegin(vstate.tag_pos)
      else
        // chunk contain data, store it size
        begin
          wpos := FBuffer.WPosition;
          FBuffer.WseekFromBegin(vstate.tag_pos);
          put_ulong(longint(wpos) - vstate.tag_pos - sizeof(longint));
          FBuffer.WseekFromBegin(wpos);
        end;
    end;
  vstate.nesting_level := vstate.nesting_level + 1;
  if chunked and (vstate.chunk_level > vstate.nesting_level) then
    vstate.chunk_level := vstate.nesting_level;

  value_tag := $7fffff00;
  if Length(url) > 0 then
    // url will be stored
    value_tag := value_tag or $1;
  if repoids.Count = 1 then
    // one repoid present
    value_tag := value_tag or $2
  else if repoids.Count > 1 then
    // repoid sequence
    value_tag := value_tag or $6;
  if vstate.chunk_level <= vstate.nesting_level then
    // chunked
    value_tag := value_tag or $8;
  put_ulong(value_tag);

  value_id := FBuffer.WPosition - sizeof(longint) + 1;
  // store
  if length(url) > 0 then
    put_string(url);
  if repoids.count = 1 then
    put_string(AnsiString(repoids[0]))
  else if repoids.count > 0 then
    begin
      seq_begin(repoids.count);
      for i := 0 to Pred(repoids.count) do
        put_string(AnsiString(repoids[i]));
      seq_end();
    end;
  if vstate.chunk_level <= vstate.nesting_level then
    // chunked, write out tag for next chunk
    begin
      put_long(0);
      vstate.tag_pos := FBuffer.WPosition - sizeOf(longint);
    end;
end;

procedure TEncoder.value_end(value_id: longint; vstate: IValueState);
var
  wpos: _ulong;
begin
  assert(vstate.nesting_level > 0);
  if not (vstate.chunk_level <= vstate.nesting_level) then
    // not chunked
    begin
      vstate.nesting_level := vstate.nesting_level - 1;
      exit;
    end;
  if vstate.tag_pos > 0 then
    // close the previous chunk
    begin
      if _ulong(vstate.tag_pos + sizeof(longint)) = FBuffer.WPosition then
        // chunk is empty
        FBuffer.WseekFromBegin(vstate.tag_pos)
      else
        // chunk contain data, store it size
        begin
          wpos := FBuffer.WPosition;
          FBuffer.WseekFromBegin(vstate.tag_pos);
          put_ulong(longint(wpos) - vstate.tag_pos - sizeof(longint));
          FBuffer.WseekFromBegin(wpos);
        end;
    end;
  // write end tag
  put_long(-vstate.nesting_level);
  vstate.nesting_level := vstate.nesting_level - 1;
  if (vstate.nesting_level > 0) and (vstate.chunk_level <= vstate.nesting_level) then
    // still chunked
    begin
      put_long(0);
      vstate.tag_pos := FBuffer.WPosition - sizeof(longint);
    end
  else
    // unchunked data
    begin
      vstate.chunk_level := $7fffffff;
      vstate.tag_pos := -1;
    end;
end;

function TEncoder.valuestate(): IValueState;
begin
  result := FValueState;
end;

procedure TEncoder.value_ref(vid: longint);
begin
  if vid = 0 then
    put_long(0)
  else
    // indirection
    begin
      put_ulong($ffffffff);
      put_long(vid - 1 - longint(FBuffer.WPosition));
    end;
end;

procedure TEncoder.put_typecode(const tc: ITypeCode);
begin
  tc.encode(self);
end;

//**************************************************************
//  TValueState
//**************************************************************
constructor TValueState.Create();
begin
  Fchunk_level:=$7fffffff;
  Fnesting_level:=0;
  Ftag_pos:=-1;
  Fvisited:= interface_long_map;
end;

function TValueState.get_chunk_level: longint;
begin
  result := FChunk_level;
end;

function TValueState.get_nesting_level: longint;
begin
  result := Fnesting_level
end;

function TValueState.get_tag_pos: longint;
begin
  result := Ftag_pos
end;

procedure TValueState.set_chunk_level(val: integer);
begin
  FChunk_level := val;
end;

procedure TValueState.set_nesting_level(val: integer);
begin
  FNesting_Level := val;
end;

procedure TValueState.set_tag_pos(val: integer);
begin
  Ftag_pos := val;
end;

function TValueState.visited: IInterfaceLongMap;
begin
  result := FVisited
end;

function TEncoder.clone(buf: IBuffer; conv : ICodesetCoder): IEncoder;
begin
  if buf = nil then
    result := TEncoder.Create(TBuffer.Create(FBuffer) as IBuffer)
  else
    result := TEncoder.Create(buf);
  result.set_converter(conv);
end;

function CreateEncoder(buf: IBuffer = nil) : IEncoder;
begin
  result := TEncoder.Create(buf);
end;

function TEncoder.max_alignment: _ulong;
begin
  result := 8;
end;

{$IFDEF LIBRARY}
exports
  CreateEncoder;
{$ENDIF}
{$ELSE}
  function CreateEncoder(buf: IBuffer = nil) : IEncoder; external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
