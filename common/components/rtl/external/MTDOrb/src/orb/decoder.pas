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
unit decoder;

interface

uses
  buffer,orbtypes,orb_int,orb,code_int,Classes,map_int,utils;

{$IFNDEF USELIB}

type

  TDecoderValueState = class(TInterfacedObject,IDecoderValueState)
  private
    FChunk_level: longint;
    FNesting_level: longint;
    FData_nesting_level: longint;
    FSaved_pos: longint;
  protected
    function copy(): IDecoderValueState;
    function get_chunk_level: longint;
    procedure set_chunk_level(val: integer);
    function get_data_nesting_level: longint;
    procedure set_data_nesting_level(val: integer);
    function get_nesting_level: longint;
    procedure set_nesting_level(val: integer);
    function get_saved_pos: longint;
    procedure set_saved_pos(val: integer);
    property chunk_level: longint read get_chunk_level write set_chunk_level;
    property nesting_level: longint read get_nesting_level write set_nesting_level;
    property saved_pos: longint read get_saved_pos write set_saved_pos;
    property data_nesting_level: longint read get_data_nesting_level write set_data_nesting_level;
    procedure reset();
  public
    constructor Create();
  end;

  {** decoded value states holder }
  TDecoderValueStates = class(TInterfacedObject,IDecoderValueStates)
  private
    FSkipped : ILongInterfaceMap;
    FVisited : ILongInterfaceMap;
    FCurrent : IDecoderValueState;
  protected
    function get_current: IDecoderValueState;
    procedure set_current(val: IDecoderValueState);
    {** list of  IDecoderValueState}
    function visited: ILongInterfaceMap;
    {** list of IValueBase}
    function skipped: ILongInterfaceMap;
  public
    constructor Create();
  end;

  TDecoder = class(TORBObject,IDecoder)
  private
    FBuffer: IBuffer;
    FByteOrder,FDataByteOrder : TByteOrder;
    FValueStates : IDecoderValueStates;
    FCodesetConv : ICodesetCoder;
  protected
    function _buffer : IBuffer; overload;
    procedure _buffer(buf: IBuffer); overload;
    procedure byteorder(ord: TByteOrder); overload;
    function byteorder: TByteOrder; overload;
    function clone(buf: IBuffer; conv : ICodesetCoder = nil): IDecoder;
    function encaps_begin(var enc: TEncapsState; var len : _ulong): Boolean;
    function encaps_end(enc: TEncapsState): Boolean;
    function get_double(var d :  double) : Boolean;
    function get_longdouble(var d : longdouble) : Boolean;
    function get_float(var f :  float) : Boolean;
    function get_octet(var o : Octet) : Boolean;
    function get_boolean(var val: boolean): Boolean;
    function get_octets(var buffer; size: _ulong) : Boolean;
    function get_char(var o : AnsiChar) : Boolean;
    function get_chars(var buffer; size: _ulong) : Boolean;
    function get_wchar(var wc : WideChar) : Boolean;
    function get_wchars(var buffer; size: _ulong) : Boolean;
    function get_principal(const pr: IPrincipal) : Boolean;
    function get_any(var a: IAny): Boolean;
    function get_indirect_string(out str: AnsiString): Boolean;
    function get_indirect_string_seq(lst: TStrings): Boolean;
    function get_ulong(var l :  _ulong) : Boolean;
    function get_long(var l :  longint) : Boolean;
    function get_ulonglong(var ll :  _ulonglong) : Boolean;
    function get_longlong(var ll :  longlong) : Boolean;
    function get_ushort(var s :  _ushort) : Boolean;
    function get_short(var s :  short) : Boolean;
    function get_string(var s : AnsiString) : Boolean;
    function get_wstring(var s : WideString) : Boolean;
    function seq_begin(var l : _ulong): boolean;
    function seq_end(): boolean;
    procedure set_converter(conv : ICodesetCoder);
    function get_converter(): ICodesetCoder;
    function value_begin(out url: AnsiString; const repoids: TStrings; out vid: longint; out is_ref: Boolean): Boolean; overload;
    function value_begin(out url: AnsiString; const repoids: TStrings; out vid: longint; out is_ref: Boolean;const vs: IDecoderValueStates): Boolean; overload;
    function value_end(finished_value_id: longint): Boolean; overload;
    function value_end(finished_value_id: longint; const vs: IDecoderValueStates): Boolean; overload;
    function valuestates(): IDecoderValueStates;
    function except_begin(var repoid: RepositoryId): Boolean;
    function except_end(): Boolean;
    function max_alignment(): _ulong;
  public
    constructor Create(buf: IBuffer = nil; conv: ICodesetCoder = nil);
  end;

  function CreateDecoder(buf: IBuffer = nil): IDecoder;

implementation

uses
  map;

//**********************************************************************
// TDecoder
//**********************************************************************
constructor TDecoder.Create(buf: IBuffer; conv: ICodesetCoder);
begin
  FBuffer := buf;
  if FBuffer <> nil then
    FBuffer.RseekFromBegin(0)
  else
    FBuffer := TBuffer.Create();
  FByteOrder := LittleEndian;
  FDataByteOrder := FByteOrder;
  FValueStates := TDecoderValueStates.Create;
  FCodesetConv := conv;
end;

procedure TDecoder.byteorder(ord: TByteOrder);
begin
  FByteOrder := ord;
end;

function TDecoder.byteorder: TByteOrder;
begin
  result := FByteOrder;
end;

function TDecoder.get_char(var o: AnsiChar): Boolean;
begin
  if FCodesetConv = nil then
    result := FBuffer.get1(o)
  else
    result := FCodesetConv.get_char(Self, o);
end;

function TDecoder.get_chars(var buffer; size: _ulong): Boolean;
begin
  if FCodesetConv = nil then
    result := get_octets(buffer,size)
  else
    result := FCodesetConv.get_chars(Self, buffer, size);
end;

function TDecoder.get_wchar(var wc: WideChar): Boolean;
begin
  if FCodesetConv = nil then
    result := get_octets(wc, SizeOf(WideChar))
  else
    result := FCodesetConv.get_wchar(Self, wc);
end;

function TDecoder.get_wchars(var buffer; size: _ulong): Boolean;
begin
  if FCodesetConv = nil then
    result := get_octets(buffer, size * SizeOf(WideChar))
  else
    result := FCodesetConv.get_wchars(Self, buffer, size);
end;

function TDecoder.get_octets(var buffer; size: _ulong) : Boolean;
begin
  result := FBuffer.get(buffer,size);
end;

function TDecoder.get_longlong(var ll: longlong): Boolean;
var
  t : longlong;
begin
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get8(ll)
  else
    begin
      result := FBuffer.get8(t);
      if not result then exit;
      swap8(t,ll);
    end;
end;

function TDecoder.get_ulonglong(var ll: _ulonglong): Boolean;
var
  t : _ulonglong;
begin
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get8(ll)
  else
    begin
      result := FBuffer.get8(t);
      if not result then exit;
      swap8(t,ll);
    end;
end;

function TDecoder.clone(buf: IBuffer; conv : ICodesetCoder): IDecoder;
begin
  result := TDecoder.Create(TBuffer.Create(FBuffer) as IBuffer);
  result.set_converter(conv);
end;

function TDecoder.get_octet(var o : Octet) : Boolean;
begin
  result := FBuffer.get(o);
end;

function TDecoder.get_boolean(var val: boolean): Boolean;
begin
  result := FBuffer.get1(val);
end;

function TDecoder._buffer : IBuffer;
begin
  result := FBuffer;
end;

function TDecoder.get_string(var s : AnsiString) : Boolean;
var
  len : _ulong;
begin
  if FCodesetConv = nil then begin
    result := false;
    len := 0;
    if not get_ulong(len) then exit;
    if (len = 0) or (len > FBuffer.length()) then Exit;
    if len > 1 then
      begin
        setLength(s,len-1);
        FBuffer.get(PAnsiChar(s)^,len);
      end
    else
      begin
        s := '';
        FBuffer.RseekFromCurrent(len);
      end;
    result := true;
  end
  else
    result := FCodesetConv.get_string(Self, s);
end;

function TDecoder.get_wstring(var s : WideString) : Boolean;
var
  len : _ulong;
  u: _ushort;
  i: Integer;
begin
  if FCodesetConv = nil then begin
    result := false;
    len := 0;
    if not get_ulong(len) then exit;
    if (len = 0) or ((len * SizeOf(WideChar)) > FBuffer.length()) then Exit;
    if len > 1 then begin
      SetLength(s, len - 1);
      for i := 1 to len - 1 do begin
        if not get_ushort(u) then
          Exit;
        s[i] := WideChar(u);
      end;
    end
    else
      s := '';
    if not get_ushort(u) then
      Exit;
    result := true;
  end
  else
    result := FCodesetConv.get_wstring(Self, s);
end;

function TDecoder.get_ulong(var l : _ulong) : Boolean;
var
  t : _ulong;
begin
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get4(l)
  else
    begin
      result := FBuffer.get4(t);
      if not result then exit;
      swap4(t,l);
    end;
end;

function TDecoder.get_long(var l :  longint) : Boolean;
var
  t : longint;
begin
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get4(l)
  else
    begin
      result := FBuffer.get4(t);
      if not result then exit;
      swap4(t,l);
    end;
end;

function TDecoder.get_ushort(var s : _ushort) : Boolean;
var
  t : _ushort;
begin
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get2(s)
  else
    begin
      result := FBuffer.get2(t);
      if not result then exit;
      swap2(t,s);
    end;
end;

function TDecoder.get_short(var s : short) : Boolean;
var
  t : short;
begin
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get2(s)
  else
    begin
      result := FBuffer.get2(t);
      if not result then exit;
      swap2(t,s);
    end;
end;

function TDecoder.encaps_begin(var enc: TEncapsState; var len : _ulong): Boolean;
var
  b : Byte;
begin
  result := false;
  enc.align := FBuffer.getRAlignBase;
  enc.bo := FByteOrder;
  if not get_ulong(len) then
    Exit
  else begin
    if len > FBuffer.length() then
      Exit;
  end;
  FBuffer.setRAlignBase(FBuffer.RPosition);
  if len = 0 then begin
    // if encapsulation contains no data then we dont need to
    // know the byteorder ...
    result := true;
    Exit;
  end;
  Dec(len);
  if not get_octet(Octet(b)) then Exit;
  byteorder(TByteOrder(b));
  result := True;
end;

function TDecoder.encaps_end(enc: TEncapsState): Boolean;
begin
  Result := true;
  byteorder(enc.bo);
  FBuffer.setRAlignBase(enc.align);
end;

function TDecoder.seq_begin(var l : _ulong): boolean;
begin
  (*
   * We want to be protected from ill-formed messages that advertise
   * an invalid sequence length (e.g. with 1G members). Ultimately,
   * this would fail at the end of the message while still reading
   * members, but at that point, the program has already failed from
   * a memory allocation error.
   *
   * We do a crude check here whether the number of elements is larger
   * than the number of bytes left in the message, which is impossible.
   *)
  result := get_ulong(l);
  if result and (l > FBuffer.length()) then
    result := false;
end;

function TDecoder.seq_end(): boolean;
begin
  result := true;
end;

procedure TDecoder._buffer(buf: IBuffer);
begin
  FBuffer := buf;
end;

procedure TDecoder.set_converter(conv : ICodesetCoder);
begin
  FCodesetConv := conv;
end;

function TDecoder.get_converter: ICodesetCoder;
begin
  result := FCodesetConv;
end;

function TDecoder.get_any(var a: IAny): Boolean;
begin
  result := a.decode(self);
end;

function TDecoder.except_begin(var repoid: RepositoryId): Boolean;
begin
  result := get_string(repoid);
end;

function TDecoder.except_end: Boolean;
begin
  result := true;
end;

function TDecoder.value_begin(out url: AnsiString; const repoids: TStrings; out vid: longint; out is_ref: Boolean): Boolean;
begin
  assert(FValueStates<> nil);
  result := value_begin(url,repoids,vid,is_ref,FValueStates);
end;

function TDecoder.value_begin(out url: AnsiString; const repoids: TStrings; out vid: longint; out is_ref: Boolean;const vs: IDecoderValueStates): Boolean;
var
  value_tag: _ulong;
  indir,rpos: longint;
  tmpstate,savedstate : IDecoderValueState;
  str: AnsiString;
  tag : longint;
begin
  result := false;
  if not get_ulong(value_tag) then exit;
  if _ulong(value_tag) = $ffffffff then
    // indirection
    begin
      if not get_long(indir) then exit;
      rpos := FBuffer.RPosition;
      vid := rpos - sizeof(longint) + indir{ + 1};
      vid := vid + 3; // adjust alignment for start of valuetype
      vid := vid - (vid mod 4) + 1; // +1 to avoid vid 0
      tmpstate := IDecoderValueState(vs.skipped[vid]);
      if (tmpstate <> nil) and (tmpstate.saved_pos < 0) then
        begin
          savedstate := vs.current;
          savedstate.saved_pos := FBuffer.RPosition;
          vs.current := tmpstate;
          FBuffer.RseekFromBegin(vid-1);
          result := value_begin(url,repoids,vid,is_ref,vs);
        end
      else
        // already decoded
        begin
          is_ref := true;
          result := true;
          exit;
        end;
    end;
  if value_tag = 0 then
    // nil
    begin
      vid := 0;
      is_ref := true;
      result := true;
      exit;
    end;
  if not ((value_tag >= $7fffff00)  and ( _ulong(value_tag) <= $7fffffff)) then
    // bad tag
    exit;
  vid := FBuffer.RPosition - sizeof(longint) + 1; // +1 to avoid vid 0
  is_ref := false;
  if ((value_tag and $1) = $1) and not get_indirect_string(url) then
    // can`t read url
    exit;
  repoids.Clear;
  if ((value_tag and $6) = $2) then
    // one repoid
    begin
      if not get_indirect_string(str) then exit;
      repoids.Add(String(str));
    end
  else if ((value_tag and $6) = $6) then
    // sequence of repoids
    begin
      if not get_indirect_string_seq(repoids) then exit;
    end;
  vs.current.nesting_level := vs.current.nesting_level + 1;
  if (value_tag and $8) <> 0 then
    // chunk flag
    begin
      if vs.current.chunk_level > vs.current.nesting_level then
        vs.current.chunk_level := vs.current.nesting_level;
      if vs.current.chunk_level <= vs.current.nesting_level then
        // chunked
        begin
          vs.current.nesting_level := vs.current.nesting_level + 1;
          // try to open next chunk
          rpos := FBuffer.RPosition;
          if not get_long(tag) then exit;
          if (tag > 0) and (tag < $7fffff00) then
            // next chunk
            begin
              rpos := FBuffer.RPosition;
              if not FBuffer.RseekFromCurrent(tag) then exit;
              if not get_long(tag) then exit;
              if (tag > 0) and (tag < $7fffff00) then Exit;
            end;
          FBuffer.RseekFromBegin(rpos);
        end;
    end;
  result := true;
end;

function TDecoder.get_indirect_string_seq(lst: TStrings): Boolean;
var
  tag,rpos,indir,i: longint;
  str: AnsiString;
  len: _ulong;
begin
  result := false;
  rpos := FBuffer.RPosition;
  if not get_long(tag) then exit;
  if _ulong(tag) = $ffffffff then
    // indirection
    begin
      rpos := FBuffer.RPosition;
      if not get_long(indir) then exit;
      inc(indir,rpos);
      rpos := FBuffer.RPosition;
      if not FBuffer.RseekFromBegin(indir) then exit;
      if not seq_begin(len) then exit;
      for i := 0 to Pred(len) do
        begin
          if not get_string(str) then exit;
          lst.Add(String(str));
        end;
      if not seq_end() then exit;
      FBuffer.RseekFromBegin(rpos);
    end
  else
    // strings
    begin
      FBuffer.RseekFromBegin(rpos);
      if not seq_begin(len) then exit;
      for i := 0 to Pred(len) do
        begin
          if not get_string(str) then exit;
          lst.Add(String(str));
        end;
      if not seq_end() then exit;
    end;
  result := true;
end;

function TDecoder.get_double(var d: double): Boolean;
var
  t: double;
begin
  result := false;
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get8(d)
  else
    begin
      if not FBuffer.get8(t) then exit;
      result := true;
      swap8(t,d);
    end;
end;

function TDecoder.get_longdouble(var d: longdouble): Boolean;
var
  t: longdouble;
begin
  result := false;
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get16(d)
  else
    begin
      if not FBuffer.get16(t) then exit;
      result := true;
      swap16(t,d);
    end;
end;

function TDecoder.get_float(var f: float): Boolean;
var
  t: float;
begin
  result := false;
  if FByteOrder = FDataByteOrder then
    result := FBuffer.get4(f)
  else
    begin
      if not FBuffer.get4(t) then exit;
      result := true;
      swap4(t,f);
    end;
end;

function TDecoder.get_principal(const pr: IPrincipal) : Boolean;
begin
  result := pr.decode(self);
end;

function TDecoder.get_indirect_string(out str: AnsiString): Boolean;
var
  tag,rpos,indir: longint;
begin
  result := false;
  rpos := FBuffer.RPosition;
  if not get_long(tag) then exit;
  if _ulong(tag) = $ffffffff then
    // indirection
    begin
      rpos := FBuffer.RPosition;
      if not get_long(indir) then exit;
      indir := indir + rpos;
      rpos := FBuffer.RPosition;
      if not FBuffer.RseekFromBegin(indir) then exit;
      if not self.get_string(str) then exit;
      FBuffer.RseekFromBegin(rpos);
      result := true;
    end
  else
    // string
    begin
      FBuffer.RseekFromBegin(rpos);
      if not self.get_string(str) then exit;
      result := true;
    end;
end;

function TDecoder.value_end(finished_value_id: longint): Boolean;
begin
  assert(FValueStates <> nil);
  value_end(finished_value_id,FValueStates);
  result := true;
end;

function TDecoder.value_end(finished_value_id: longint; const vs: IDecoderValueStates): Boolean;
var
  state,saved: IDecoderValueState;
  tag,rpos,value_id: longint;
  str: AnsiString;
  repoids : TStrings;
  is_ref: Boolean;
begin
  result := false;
  assert(vs.current.nesting_level> 0);
  state := IDecoderValueState(vs.skipped[finished_value_id]);
  if (state <> nil) and (state.saved_pos > 0) then
    begin
      FBuffer.RseekFromBegin(state.saved_pos);
      vs.current := state;
      vs.current.saved_pos := -1;
      vs.skipped.erase(finished_value_id);
      result := true;
      exit;
    end;
  if vs.current.chunk_level > vs.current.nesting_level then
    // not chunked
    begin
      vs.current.nesting_level := vs.current.nesting_level -1;
      result := true;
      exit;
    end;
  if vs.current.data_nesting_level < vs.current.nesting_level then
    // already read the end tag
    begin
      vs.current.nesting_level := vs.current.nesting_level -1;
      result := true;
      exit;
    end;
  // skip until read the end tag
  while vs.current.data_nesting_level >= vs.current.nesting_level do
    begin
      rpos := FBuffer.RPosition;
      if not get_long(tag) then exit;
      if (tag > 0) and (tag < $7fffff00) then
        // chunk
        begin
          if not FBuffer.RseekFromCurrent(tag) then exit;
        end
      else if tag < 0 then
        // end tag
        begin
          if vs.current.data_nesting_level > (-tag - 1) then
            vs.current.data_nesting_level := (-tag - 1)
          else
            // bad end tag
            begin
            end;
        end
      else
        // value, value_ref or nil
        begin
          FBuffer.RseekFromBegin(rpos);
          repoids := TStringList.Create;
          try
            saved := vs.current;
            if not value_begin(str,repoids,value_id,is_ref,vs) then exit;
            if not is_ref and not value_end(value_id,vs) then exit;
            saved.saved_pos := -1;
            vs.skipped[value_id] := saved.copy();
          finally
            repoids.free;
          end;
        end
    end;
  vs.current.nesting_level := vs.current.nesting_level -1;
  while (vs.current.data_nesting_level > 0) and
    (vs.current.chunk_level <= vs.current.data_nesting_level) do
    // still chunked, get next end tag
    begin
      rpos := FBuffer.RPosition;
      if not get_long(tag) then exit;
      if tag < 0 then
        // end tag
        begin
          if vs.current.data_nesting_level > (-tag - 1) then
            vs.current.data_nesting_level := (-tag - 1)
          else
            // bed end tag
            begin
            end;
        end
      else
        // some other tag
        begin
          FBuffer.RseekFromBegin(rpos);
          break;
        end;
    end;
  if (vs.current.data_nesting_level > 0) and
    (vs.current.chunk_level <= vs.current.data_nesting_level) then
    // still chunked, try to open next chunk
    begin
      rpos := FBuffer.RPosition;
      if not get_long(tag) then exit;
      if (tag > 0) and (tag < $7fffff00) then
        // it`s chunk
        begin
          rpos := FBuffer.RPosition;
          if not FBuffer.RseekFromCurrent(tag) then exit;
          if not get_long(tag) then exit;
          if (tag > 0) and (tag < $7fffff00) then Exit;
        end;
      FBuffer.RseekFromBegin(rpos);
    end
  else
    // now follows unchanked data
    vs.current.chunk_level := $7fffffff;
  result := true;
end;

function TDecoder.valuestates(): IDecoderValueStates;
begin
  result := FValueStates
end;

//*****************************************************************
function swap4(val: _ulong): _ulong;
begin
  result := (val shl 24) or (val shl 8 and $ff0000) or (val shr 8 and $ff00) or (val shr 24);
end;

//*********************************************************************
//  TDecoderValueState
//*********************************************************************
constructor TDecoderValueState.Create();
begin
  reset();
end;

procedure TDecoderValueState.reset();
begin
  FSaved_pos := -1;
  FNesting_level := 0;
  FData_nesting_level := 0;
  FChunk_level := $7fffffff;
end;

function TDecoderValueState.get_chunk_level: longint;
begin
  result := FChunk_level;
end;

function TDecoderValueState.get_data_nesting_level: longint;
begin
  result := FData_nesting_level;
end;

function TDecoderValueState.get_nesting_level: longint;
begin
  result := FNesting_level;
end;

function TDecoderValueState.get_saved_pos: longint;
begin
  result := FSaved_pos;
end;

procedure TDecoderValueState.set_chunk_level(val: integer);
begin
  FChunk_level := val;
end;

procedure TDecoderValueState.set_data_nesting_level(val: integer);
begin
  FData_nesting_level := val;
end;

procedure TDecoderValueState.set_nesting_level(val: integer);
begin
  FNesting_level := val;
end;

procedure TDecoderValueState.set_saved_pos(val: integer);
begin
  FSaved_pos := val;
end;

function TDecoderValueState.copy(): IDecoderValueState;
begin
  result := TDecoderValueState.Create;
  result.chunk_level := Fchunk_level;
  result.saved_pos := Fsaved_pos;
  result.data_nesting_level := Fdata_nesting_level;
  result.nesting_level := FData_nesting_level;
end;

//*********************************************************************
//  TDecoderValueStates
//*********************************************************************
constructor TDecoderValueStates.Create();
begin
  FCurrent := TDecoderValueState.Create;
  FVisited := long_interface_map;
  FSkipped := long_interface_map;
end;

procedure TDecoderValueStates.set_current(val: IDecoderValueState);
begin
  FCurrent := val;
end;

function TDecoderValueStates.get_current: IDecoderValueState;
begin
  result := FCurrent;
end;

function TDecoderValueStates.skipped: ILongInterfaceMap;
begin
  result := FSkipped;
end;

function TDecoderValueStates.visited: ILongInterfaceMap;
begin
  result := FVisited;
end;

function CreateDecoder(buf: IBuffer): IDecoder;
begin
  result := TDecoder.Create(buf);
end;

function TDecoder.max_alignment: _ulong;
begin
  result := 8;
end;

{$IFDEF LIBRARY}
exports
  CreateDecoder;
{$ENDIF}
{$ELSE}
  function CreateDecoder(buf: IBuffer = nil): IDecoder; external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
