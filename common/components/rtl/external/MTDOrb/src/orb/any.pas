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
unit any;

interface

{$I dorb.inc}

uses
  {$IFDEF WIN32}windows{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF},orbtypes,code_int,
  {$IFNDEF VER130}Variants,{$ENDIF}ir_int,Classes,exceptions,map,SysUtils;

{$IFNDEF USELIB}

type

  TAny = class(TInterfacedObject,IAny)
  private
    FTypeCode : ITypeCode;
    FEnc: IEncoder;
    FDec: IDecoder;
    FExtractedValue : IStaticAny;
    FChecker : ITypeCodeChecker;
    procedure reset();
  protected
    function copy_any(const a: IAny): Boolean; overload;
    function copy_any(const a: IAny; idmap : TList): Boolean; overload;
    procedure copy(const src: IAny);
    function __tc: ITypeCode;
    function _enc: IEncoder;
    function _dec: IDecoder;
    function decode(const dec: IDecoder): Boolean;
    function demarshal(const tc: ITypeCode; const dec: IDecoder): Boolean;
    procedure encode(const enc: IEncoder);
    function marshal(const enc: IEncoder): Boolean;
    function get_type: ITypeCode;

    function put_any(val: IAny): Boolean;
    function put_boolean(val: boolean): Boolean;
    function put_char(val: AnsiChar): Boolean;
    function put_double(val: double): Boolean;
    function put_float(val: float): Boolean;
    function put_long(val: longint): Boolean;
    function put_longlong(val: longlong): Boolean;
    {** val must be IORBObject }
    function put_object(val: IUnknown; const name: AnsiString = ''): Boolean;
    function put_octet(val: octet): Boolean;
    function put_principal(val: IPrincipal): Boolean;
    function put_short(val: short): Boolean;
    function put_string(val: AnsiString): Boolean;
    function put_typecode(val: ITypeCode): Boolean;
    function put_ulong(val: _ulong): Boolean;
    function put_ulonglong(val: _ulonglong): Boolean;
    function put_ushort(val: _ushort): Boolean;
    function put_wchar(val: wchar): Boolean;
    function put_wstring(val: WideString): Boolean;
    function put_abstractbase(val: IInterface): Boolean;

    function to_any(out val: IAny): Boolean;
    function to_boolean(out val: boolean): Boolean;
    function to_char(out val: AnsiChar): Boolean;
    function to_double(out val: double): Boolean;
    function to_float(out val: float): Boolean;
    function to_long(out val: longint): Boolean;
    function to_longlong(out val: longlong): Boolean;
    {** val must be IORBObject }
    function to_object(out val: IUnknown): Boolean;
    function to_octet(out val: octet): Boolean;
    function to_principal(out val: IPrincipal): Boolean;
    function to_short(out val: short): Boolean;
    function to_string(out val: AnsiString): Boolean;
    function to_typecode(out val: ITypeCode): Boolean;
    function to_ulong(out val: _ulong): Boolean;
    function to_ulonglong(out val: _ulonglong): Boolean;
    function to_ushort(out val: _ushort): Boolean;
    function to_wchar(out val: wchar): Boolean;
    function to_wstring(out val: WideString): Boolean;
    function to_abstractbase(out val: IInterface): Boolean;

    function get_any(out val: IAny): Boolean;
    function get_boolean(out val: boolean): Boolean;
    function get_char(out val: Ansichar): Boolean;
    function get_double(out val: double): Boolean;
    function get_float(out val: float): Boolean;
    function get_long(out val: longint): Boolean;
    function get_longlong(out val: longlong): Boolean;
    function get_octet(out val: octet): Boolean;
    function get_short(out val: short): Boolean;
    function get_string(out val: AnsiString): Boolean;
    function get_ulong(out val: _ulong): Boolean;
    function get_ulonglong(out val: _ulonglong): Boolean;
    function get_ushort(out val: _ushort): Boolean;
    function get_wchar(out val: wchar): Boolean;
    function get_wstring(out val: WideString): Boolean;
    function get_value(out val: IInterface): Boolean;

    function to_static_any(const a: IStaticAny): Boolean; overload;
    function to_static_any(const ti: IStaticTypeInfo;out value: Pointer): Boolean; overload;
    function to_static_any(const ti: IStaticTypeInfo;const tc: ITypeCode;out value: Pointer): Boolean; overload;
    function to_static_any(const sa: IStaticAny;const tc: ITypeCode): Boolean; overload;
    function from_static_any(const a: IStaticAny): Boolean;

    procedure set_type(const value: ITypeCode);
    function get_variant(): variant;
    procedure put_variant(const Value: Variant);

    function enum_put(val: _ulong): Boolean;
    function enum_get(out val: _ulong): Boolean;

    function struct_get_begin(): Boolean;
    function struct_put_begin(): Boolean;
    function struct_get_end(): Boolean;
    function struct_put_end(): Boolean;

    function union_get_begin(): Boolean;
    function union_put_begin(): Boolean;
    function union_get_end(): Boolean;
    function union_put_end(): Boolean;
    function union_get_selection(out val: integer): Boolean;
    function union_put_selection(val: integer): Boolean;

    function seq_get_begin(out val: _ulong): Boolean;
    function seq_put_begin(val: _ulong): Boolean;
    function seq_get_end(): Boolean;
    function seq_put_end(): Boolean;

    function arr_get_begin(): Boolean;
    function arr_put_begin(): Boolean;
    function arr_get_end(): Boolean;
    function arr_put_end(): Boolean;

    function except_get_begin(out repoid: RepositoryId): Boolean;
    function except_put_begin(const repoid: RepositoryId): Boolean;
    function except_get_end(): Boolean;
    function except_put_end(): Boolean;

    function value_get_begin(out id: longint; out isref: Boolean): Boolean;
    function value_put_begin(out id: longint): Boolean;
    function value_get_end(id: longint; isref: Boolean): Boolean;
    function value_put_end(id: longint): Boolean;
    function value_put_ref(id: longint): Boolean;

    function valuebox_get_begin(out id: longint; out isref: Boolean): Boolean;
    function valuebox_put_begin(out id: longint): Boolean;
    function valuebox_get_end(id: longint; isref: Boolean): Boolean;
    function valuebox_put_end(id: longint): Boolean;
    function valuebox_put_ref(id: longint): Boolean;

    procedure prepare_read;
    procedure prepare_write;
    procedure rewind;
    procedure replace(_tc: ITypeCode; value: Pointer = nil);
    function checker: ITypeCodeChecker;
    function any_get(const a: IAny): Boolean;
    function eq(const a: IAny): Boolean;
  public
    constructor Create();
    constructor CreateNull();
    constructor Create_buff(tc: ITypeCode;buf: IBuffer);
    constructor Create_code(tc: ITypeCode;dec: IDecoder;enc: IEncoder);
    constructor Create_any(const a: IAny);
    destructor Destroy(); override;
  end;


  PAny = ^IAny;

  function CreateAny(): IAny;
  function CreateNullAny(): IAny;
  function CreateAny_buff(tc: ITypeCode;buf: IBuffer): IAny;
  function CreateAny_code(tc: ITypeCode;dec: IDecoder;enc: IEncoder): IAny;
  function CreateAny_any(const a: IAny): IAny;

implementation

uses
  encoder,decoder,stdstat,static,orb_int,throw,buffer,utils,tcode,iior_int,ior,value,
  value_int;

//***********************************************************************
//  TAny
//***********************************************************************
constructor TAny.Create();
begin
  FTypeCode := _tc_void;
  FEnc := TEncoder.Create(nil);
  FDec := TDecoder.Create(FEnc.buffer);
  FChecker:= TTypecodeChecker.Create;
end;

constructor TAny.CreateNull();
begin
  FTypeCode := _tc_null;
  FEnc := TEncoder.Create(nil);
  FDec := TDecoder.Create(FEnc.buffer);
  FChecker:= TTypecodeChecker.Create;
end;

constructor TAny.Create_code(tc: ITypeCode;dec: IDecoder;enc: IEncoder);
begin
  FChecker:= TTypecodeChecker.Create;
  FTypeCode := tc;
  FDec := dec;
  FEnc := enc;
end;

constructor TAny.Create_buff(tc: ITypeCode;buf: IBuffer);
begin
  FChecker:= TTypecodeChecker.Create;
  FTypeCode := tc;
  FEnc := TEncoder.Create(buf);
  FDec := TDecoder.Create(buf);
end;

constructor TAny.Create_any(const a: IAny);
begin
  copy(a);
end;

destructor TAny.Destroy();
begin
  FEnc := nil;
  FDec := nil;
  inherited Destroy();
end;

function TAny.enum_get(out val: _ulong): Boolean;
begin
  result := false;
  prepare_read;
  if not FDec.get_ulong(val) or not FChecker.enumeration(val) then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.enum_put(val: _ulong): Boolean;
begin
  result := false;
  prepare_write;
  if not FChecker.enumeration(val) then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_ulong(val);
  result := true;
end;

function TAny.get_any(out val: IAny): Boolean;
begin
  result := false;
  prepare_read;
  val := TAny.Create;
  if not FChecker.basic(_tc_any) or not FDec.get_any(val) then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.get_boolean(out val: boolean): Boolean;
begin
  result := FChecker.basic(_tc_boolean) and FDec.get_octet(Octet(val));
end;

function TAny.get_char(out val: Ansichar): Boolean;
begin
  result := FChecker.basic(_tc_char) and FDec.get_octet(Octet(val));
end;

function TAny.get_double(out val: double): Boolean;
begin
  result := FChecker.basic(_tc_double) and FDec.get_double(val);
end;

function TAny.get_float(out val: float): Boolean;
begin
  result := FChecker.basic(_tc_float) and FDec.get_float(val);
end;

function TAny.get_long(out val: Integer): Boolean;
begin
  result := FChecker.basic(_tc_long) and FDec.get_long(val);
end;

function TAny.get_longlong(out val: longlong): Boolean;
begin
  result := FChecker.basic(_tc_longlong) and FDec.get_longlong(val);
end;

function TAny.get_octet(out val: octet): Boolean;
begin
  result := FChecker.basic(_tc_octet) and FDec.get_octet(val);
end;

function TAny.get_short(out val: short): Boolean;
begin
  result := FChecker.basic(_tc_short) and FDec.get_short(val);
end;

function TAny.get_ushort(out val: _ushort): Boolean;
begin
  result := FChecker.basic(_tc_ushort) and FDec.get_ushort(val);
end;

function TAny.get_ulong(out val: _ulong): Boolean;
begin
  result := FChecker.basic(_tc_ulong) and FDec.get_ulong(val);
end;

function TAny.get_ulonglong(out val: _ulonglong): Boolean;
begin
  result := FChecker.basic(_tc_ulonglong) and FDec.get_ulonglong(val);
end;

function TAny.decode(const dec: IDecoder): Boolean;
begin
  FTypeCode := TTypeCode.Create(tk_null);
  result :=  FTypeCode.decode(dec) and demarshal(FTypeCode,dec);
end;

procedure TAny.encode(const enc: IEncoder);
begin
  FTypeCode.encode(enc);
  marshal(enc);
end;

function TAny.demarshal(const tc: ITypeCode; const dec: IDecoder): Boolean;
var
  a : IAny;
begin
  reset;
  set_type(tc);
  a := TAny.Create_code(FTypeCode,dec,TEncoder.Create() as IEncoder);
  a.checker.restart(a.__tc);
  prepare_write;
  result := self.copy_any(a);
end;

function TAny.marshal(const enc: IEncoder): Boolean;
var
  a : IAny;
begin
  assert(Fchecker.completed);
  a := TAny.Create_code(FTypeCode,TDecoder.Create() as IDecoder,enc.clone(enc.buffer, enc.get_converter));
  a.checker.restart(a.__tc);
  prepare_read;
  result := a.copy_any(self);
end;

procedure TAny.set_type(const value: ITypeCode);
begin
  if FChecker.level_count = 0 then
    begin
      FEnc.buffer.reset;
      FTypeCode := value;
      FExtractedValue := nil;
      if value.unalias.kind in [tk_void,tk_null] then FChecker.finish;
    end;
end;

function TAny.get_type: ITypeCode;
begin
  result := FTypeCode;
end;

function TAny.copy_any(const a: IAny): Boolean;
var
  idmap: TList;
begin
  idmap := TList.Create;
  try
    result := copy_any(a,idmap);
  finally
    idmap.free;
  end;
end;

function TAny.copy_any(const a: IAny; idmap : TList): Boolean;
var
  str : AnsiString;
  wstr : WideString;
  tc : ITypeCode;
  ush : _ushort;
  sh: short;
  ul: _ulong;
  ln : longint;
  fl: float;
  dbl: double;
  b : Boolean;
  c : AnsiChar;
  oct: Octet;
  wc: widechar;
  ll: longlong;
  _a: IAny;
  _tc: ITypeCode;
  _pr: IPrincipal;
  obj : IUnknown;
  i,vid1,vid2,n : integer;
  discr: IAny;
  buf: IBuffer;
begin
  result := false;
  tc := a.checker._tc.unalias;
  case tc.kind of
    tk_null,tk_void: result := a.checker.basic(tc) and checker.basic(tc);
    tk_ushort : result := a.to_ushort(ush) and put_ushort(ush);
    tk_short : result := a.to_short(sh) and put_short(sh);
    tk_ulong: result := a.to_ulong(ul) and put_ulong(ul);
    tk_long: result := a.to_long(ln) and put_long(ln);
    tk_float: result := a.to_float(fl) and put_float(fl);
    tk_double: result := a.to_double(dbl) and put_double(dbl);
    tk_boolean: result := a.to_boolean(b) and put_boolean(b);
    tk_char: result := a.to_char(c) and put_char(c);
    tk_octet: result := a.to_octet(oct) and put_octet(oct);
    tk_any: result := a.to_any(_a) and put_any(_a);
    tk_TypeCode: result := a.to_typecode(_tc) and put_typecode(_tc);
    tk_Principal : result := a.to_principal(_pr) and put_principal(_pr);
    tk_objref : result := a.to_object(obj) and put_object(obj);
    tk_struct : begin
        if not a.struct_get_begin or not struct_put_begin then exit;
        n := tc.member_count;
        for i := 0 to Pred(n) do
          if not copy_any(a,idmap) then exit;
        result := a.struct_get_end and struct_put_end;
      end;
    tk_union : begin
        if not a.union_get_begin or not union_put_begin then exit;
        discr := TAny.Create;
        if not a.any_get(discr) then exit;
        discr.prepare_read;
        if not copy_any(discr,idmap) then exit;
        i := tc.member_index(discr);
        if i >= 0 then
          begin
            if not a.union_get_selection(i) or not union_put_selection(i) then exit;
            if not copy_any(a,idmap) then exit;
          end;
        result := a.union_get_end and union_put_end;
      end;
    tk_enum : result := a.enum_get(ul) and enum_put(ul);
    tk_string: result := a.get_string(str) and put_string(str);
    tk_sequence : begin
          if not a.seq_get_begin(ul) or not seq_put_begin(ul) then exit;
          if tc.content_type.unalias.kind = tk_octet then
            begin
              buf := a._dec._buffer;
              if buf.length < ul then exit;
              FEnc.put_octets(buf.data^,ul);
              buf.RseekFromCurrent(ul);
              result := FChecker.seq_end(true) and a.checker.seq_end(true);
              FExtractedValue := nil;
              exit;
            end;
          if ul <> 0 then
            for i := 0 to ul - 1 do
              if not copy_any(a,idmap) then exit;
          result := a.seq_get_end() and seq_put_end;
       end;
     tk_array : begin
         ul := tc._length;
         if not a.arr_get_begin() or not arr_put_begin() then exit;
         if tc.content_type.unalias.kind = tk_octet then
            begin
              buf := a._dec._buffer;
              if buf.length < ul then exit;
              FEnc.put_octets(buf.data^,ul);
              buf.RseekFromCurrent(ul);
              result := FChecker.arr_end(true) and a.checker.arr_end(true);
              FExtractedValue := nil;
              exit;
            end;
          if ul <> 0 then
            for i := 0 to ul - 1 do
              if not copy_any(a,idmap) then exit;
          result := a.arr_get_end() and arr_put_end;
       end;
    tk_alias : assert(false);
    tk_except : begin
        if not a.except_get_begin(str) or not except_put_begin(str) then exit;
        ul := tc.member_count;
        if ul <> 0 then
          for i := 0 to ul - 1 do
            if not copy_any(a,idmap) then exit;
        result := a.except_get_end and except_put_end;
      end;
    tk_longlong : result := a.to_longlong(ll) and put_longlong(ll);
    tk_ulonglong : result := a.to_ulonglong(ll) and put_ulonglong(ll);
    tk_wchar : result := a.to_wchar(wc) and put_wchar(wc);
    tk_wstring: result := a.get_wstring(wstr) and put_wstring(wstr);
    tk_fixed : assert(false,'not implemented');
    tk_value : begin
        vid1 := 0;
        vid2 := 0;
        if not a.value_get_begin(vid1,b) then exit;
        if b then
          begin
            if vid1 > 0 then
              begin
                assert(idmap.count > vid1);
                vid2 := integer(idmap[vid1]);
              end;
            result := value_put_ref(vid2);
            exit;
          end;
        if not value_put_begin(vid2) then exit;
        if idmap.Count <= vid1 then idmap.Count := vid1+1;
        idmap[vid1] := Pointer(vid2);
        if a.checker.top.id = 'IDL:omg.org/CORBA/WStringValue:1.0' then begin
          // special handling of strings, according to spec
          if not a._dec.get_wstring(wstr) then
            Exit;
          _enc.put_wstring(wstr);
        end
        else begin
          ln := tc.member_count_inherited();
          for i := 0 to Pred(ln) do
            if not copy_any(a,idmap) then exit;
        end;
        Result := a.value_get_end(vid1,b) and value_put_end(vid1)
      end;
    tk_value_box : begin
        vid1 := 0;
        vid2 := 0;
        if not a.valuebox_get_begin(vid1,b) then exit;
        if b then
          begin
            if vid1 > 0 then
              begin
                assert(idmap.count > vid1);
                vid2 := integer(idmap[vid1]);
              end;
            result := valuebox_put_ref(vid2);
            exit;
          end;
        if not valuebox_put_begin(vid2) then exit;
        if idmap.Count <= vid1 then idmap.Count := vid1+1;
        idmap[vid1] := Pointer(vid2);
        if a.checker.top.id = 'IDL:omg.org/CORBA/WStringValue:1.0' then begin
          // special handling of strings, according to spec
          if not a._dec.get_wstring(wstr) then
            Exit;
          _enc.put_wstring(wstr);
        end
        else begin
          //ln := tc.member_count_inherited();
          //for i := 0 to Pred(ln) do
            if not copy_any(a,idmap) then exit;
        end;
        Result := a.valuebox_get_end(vid1,b) and valuebox_put_end(vid1)
      end;
    tk_abstract_interface: result := a.to_abstractbase(obj) and put_abstractbase(obj);
    else
      assert(false);
  end;
end;

function TAny.get_string(out val : AnsiString): Boolean;
var
  temp : Pointer;
begin
  result := false;
  if not to_static_any(stat_string,temp) then exit;
  val := PAnsiString(temp)^;
  result := true;
end;

function TAny.to_static_any(const ti: IStaticTypeInfo;out value: Pointer): Boolean;
var
  tc: ITypeCode;
begin
  tc := ti.typecode;
  if tc = nil then tc := FTypeCode;
  result := to_static_any(ti,tc,value);
end;

function TAny.to_static_any(const ti: IStaticTypeInfo;const tc: ITypeCode; out value: Pointer): Boolean;
begin
  result := false;
  if (FExtractedValue = nil) or not FChecker.completed then
    begin
      FExtractedValue := TStaticAny.Create(ti,nil);
      if not to_static_any(FExtractedValue,tc) then begin
        FExtractedValue := nil;
        Exit;
      end;
      value := FExtractedValue.value;
    end
  else begin
    prepare_read();
    if not FChecker.basic(tc) then begin
      rewind();
      Exit;
    end;
    if FExtractedValue._type <> ti then
      Exit
    else
      value := FExtractedValue.value;
  end;
  result := true;
end;

function TAny.to_static_any(const sa: IStaticAny;const tc: ITypeCode): Boolean;
begin
  result := true;
  prepare_read;
  if not FChecker.basic(tc) or not sa.demarshal(FDec) then
    begin
      rewind;
      result := false;
    end;
end;

function TAny.from_static_any(const a: IStaticAny): Boolean;
var
  tc: ITypeCode;
begin
  result := false;
  tc := a._type.typecode;
  if tc = nil then  tc := FTypeCode;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := tc;
    end
  else if not FChecker.basic(tc) then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  a.marshal(FEnc);
  result := true;
end;

function TAny.to_static_any(const a: IStaticAny): Boolean;
var
  tc: ITypeCode;
begin
  tc := a._type.typecode;
  if tc = nil then
    tc := FTypeCode;
  result := to_static_any(a,tc);
end;

function TAny.get_variant(): variant;
var
  l: longint;
  ul: _ulong;
  c: AnsiChar;
  wc: WChar;
  s: AnsiString;
  sh: short;
  us: _ushort;
  ws: WideString;
  o: octet;
  b : Boolean;
  d: double;
  f: float;
{$IFNDEF VER130}
  ll: longlong;
{$ENDIF}
begin
  result := Null;
  //comment by OVS, 30.05.2003, prepare in each method
  //prepare_read;
  case get_type.kind of
    tk_float : if to_float(f) then result := f;
    tk_double : if to_double(d) then result := d;
    tk_long : if to_long(l) then result := l;
    tk_short : if to_short(sh) then result := sh;
    tk_enum : if enum_get(ul) then result := longint(ul);
    tk_ulong : if to_ulong(ul) then result := longint(ul);
    tk_ushort : if to_ushort(us) then result := us;
    tk_boolean : if to_boolean(b) then result := b;
    tk_string : if to_string(s) then result := s;
    tk_wstring : if to_wstring(ws) then result := ws;
    tk_char : if to_char(c) then result := c;
    tk_octet : if to_octet(o) then result := o;
    tk_wchar : if to_wchar(wc) then result := WideString(wc);
    tk_longlong: {$IFNDEF VER130}if to_longlong(ll) then result := ll{$ELSE}dorb_throw(st_NO_IMPLEMENT){$ENDIF};
    tk_ulonglong: {$IFNDEF VER130}if to_ulonglong(ll) then result := ll{$ELSE}dorb_throw(st_NO_IMPLEMENT){$ENDIF};
    tk_longdouble: dorb_throw(st_NO_IMPLEMENT);
  end;
end;

procedure TAny.put_variant(const Value: Variant);
var
  s: string;
begin
  case TVarData(Value).VType of
    varSmallint: put_short(TVarData(Value).VSmallint);
    varInteger:  put_long(TVarData(Value).VInteger);
    varSingle:   put_float(TVarData(Value).VSingle);
    varDouble:   put_double(TVarData(Value).VDouble);
    varCurrency: put_double(TVarData(Value).VCurrency);
    varDate:     put_double(TVarData(Value).VDate);
    varOleStr: begin
      s := Value;
      put_string(AnsiString(s));
    end;
    varBoolean:  put_boolean(TVarData(Value).VBoolean);
{$IFNDEF VER130}
    varShortInt: put_octet(TVarData(Value).VShortInt);
    varWord:     put_ushort(TVarData(Value).VWord);
    varLongWord: put_ulong(TVarData(Value).VLongWord);
{$ENDIF}
    varByte:     put_octet(TVarData(Value).VByte);
    varString: begin
      s := Value;
      put_string(AnsiString(s));
    end;
{$IFNDEF VER130}
    varInt64:    put_longlong(TVarData(Value).VInt64);
{$ENDIF}
    varEmpty:    replace(_tc_void, nil);
    varNull:     replace(_tc_null, nil);
  end; //case
end;

procedure TAny.reset;
begin
  FChecker.restart();
  FEnc.buffer.reset;
  FExtractedValue := nil;
end;

procedure TAny.copy(const src: IAny);
begin
  FTypeCode := src.get_type;
  FChecker := TTypeCodeChecker.Create();
  FEnc := src._enc.clone;
  FDec := src._dec.clone(FEnc.buffer);
  FExtractedValue := nil;
end;

function TAny.__tc: ITypeCode;
begin
  result := FTypeCode;
end;

function TAny._dec: IDecoder;
begin
  result := FDec;
end;

function TAny._enc: IEncoder;
begin
  result := FEnc;
end;

procedure TAny.prepare_write;
begin
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FChecker.restart(__tc());
      FExtractedValue := nil;
    end;
end;

procedure TAny.prepare_read;
begin
  if FChecker.completed then
    begin
      FDec._buffer.RseekFromBegin(0);
      FChecker.restart(__tc());
    end
end;

procedure TAny.rewind;
begin
  FDec._buffer.RseekFromBegin(0);
  FChecker.restart();
end;

procedure TAny.replace(_tc: ITypeCode; value: Pointer);
var
  a: IAny;
  b : IBuffer;
begin
  reset;
  set_type(_tc);
  if value <> nil then
    begin
      b := TBuffer.Create(value);
      a := TAny.Create_buff(_tc,b);
      prepare_write;
      a.prepare_read;
      copy_any(a);
    end;
end;

function TAny.checker: ITypeCodeChecker;
begin
  result := FChecker;
end;

function TAny.put_any(val: IAny): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_any;
    end
  else if not FChecker.basic(_tc_any) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_any(val);
  result := true;
end;

function TAny.put_boolean(val: boolean): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_boolean;
    end
  else if not FChecker.basic(_tc_boolean) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_boolean(val);
  result := true;
end;

function TAny.put_char(val: Ansichar): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_char;
    end
  else if not FChecker.basic(_tc_char) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_char(val);
  result := true;
end;

function TAny.put_double(val: double): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_double;
    end
  else if not FChecker.basic(_tc_double) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_double(val);
  result := true;
end;

function TAny.put_float(val: float): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_float;
    end
  else if not FChecker.basic(_tc_float) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_float(val);
  result := true;
end;

function TAny.put_long(val: Integer): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_long;
    end
  else if not FChecker.basic(_tc_long) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_long(val);
  result := true;
end;

function TAny.put_longlong(val: longlong): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_longlong;
    end
  else if not FChecker.basic(_tc_longlong) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_longlong(val);
  result := true;
end;

function TAny.put_octet(val: octet): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_octet;
    end
  else if not FChecker.basic(_tc_octet) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_octet(val);
  result := true;
end;

function TAny.put_short(val: short): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_short;
    end
  else if not FChecker.basic(_tc_short) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_short(val);
  result := true;
end;

function TAny.put_string(val: AnsiString): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_string;
    end
  else if not FChecker.basic(_tc_string) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_string(val);
  result := true;
end;

function TAny.put_ulong(val: _ulong): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_ulong;
    end
  else if not FChecker.basic(_tc_ulong) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_ulong(val);
  result := true;
end;

function TAny.put_ulonglong(val: _ulonglong): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_ulonglong;
    end
  else if not FChecker.basic(_tc_ulonglong) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_ulonglong(val);
  result := true;
end;

function TAny.put_ushort(val: _ushort): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_ushort;
    end
  else if not FChecker.basic(_tc_ushort) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_ushort(val);
  result := true;
end;

function TAny.put_wchar(val: wchar): Boolean;
begin
  result := false;
  if FChecker.completed then begin
    FEnc.buffer().reset();
    FTypeCode := _tc_wchar;
  end
  else if not FChecker.basic(_tc_wchar) then begin
    reset();
    Exit;
  end;
  FExtractedValue := nil;
  FEnc.put_wchar(val);
  result := true;
end;

function TAny.put_wstring(val: WideString): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_wstring;
    end
  else if not FChecker.basic(_tc_wstring) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_wstring(val);
  result := true;
end;

function TAny.get_wchar(out val: wchar): Boolean;
var
  temp : Pointer;
begin
  result := false;
  if not to_static_any(stat_widechar, temp) then exit;
  val := PWideChar(temp)^;
  result := true;
end;

function TAny.get_wstring(out val: WideString): Boolean;
var
  temp : Pointer;
begin
  result := false;
  if not to_static_any(stat_widestring,temp) then exit;
  val := PWideString(temp)^;
  result := true;
end;

function TAny.get_value(out val: IInterface): Boolean;
var
  repoid: RepositoryId;
  v: IValueBase;
begin
  Result := False;
  prepare_read;
  repoid := get_type().repoid();
  if not TValueBase._demarshal(_dec(), v, repoid) then
    Exit;
  val := v;
  Result := True;
end;

function TAny.to_boolean(out val: boolean): Boolean;
begin
  result := false;
  prepare_read;
  if not get_boolean(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_char(out val: AnsiChar): Boolean;
begin
  result := false;
  prepare_read;
  if not get_char(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_double(out val: double): Boolean;
begin
  result := false;
  prepare_read;
  if not get_double(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_float(out val: float): Boolean;
begin
  result := false;
  prepare_read;
  if not get_float(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_long(out val: Integer): Boolean;
begin
  result := false;
  prepare_read;
  if not get_long(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_longlong(out val: longlong): Boolean;
begin
  result := false;
  prepare_read;
  if not get_longlong(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_octet(out val: octet): Boolean;
begin
  result := false;
  prepare_read;
  if not get_octet(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_short(out val: short): Boolean;
begin
  result := false;
  prepare_read;
  if not get_short(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_string(out val: AnsiString): Boolean;
begin
  result := false;
  prepare_read;
  if not get_string(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_ulong(out val: _ulong): Boolean;
begin
  result := false;
  prepare_read;
  if not get_ulong(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_ulonglong(out val: _ulonglong): Boolean;
begin
  result := false;
  prepare_read;
  if not get_ulonglong(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_ushort(out val: _ushort): Boolean;
begin
  result := false;
  prepare_read;
  if not get_ushort(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_wchar(out val: wchar): Boolean;
begin
  result := false;
  prepare_read;
  if not get_wchar(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_wstring(out val: WideString): Boolean;
begin
  result := false;
  prepare_read;
  if not get_wstring(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.to_any(out val: IAny): Boolean;
begin
  result := false;
  prepare_read;
  if not get_any(val) then
    begin
      rewind;
      exit;
    end;
  Result := true;
end;

function TAny.put_typecode(val: ITypeCode): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_typecode;
    end
  else if not FChecker.basic(_tc_typecode) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_typecode(val);
  result := true;
end;

function TAny.to_typecode(out val: ITypeCode): Boolean;
var
  ptr : Pointer;
begin
  result := false;
  if to_static_any(stat_typecode,ptr) then
    begin
      val := ITypeCode(ptr^);
      result := true;
    end;
end;

function TAny.put_principal(val: IPrincipal): Boolean;
begin
  result := false;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := _tc_principal;
    end
  else if not FChecker.basic(_tc_principal) then
    begin
      reset();
      exit;
    end;
  FExtractedValue := nil;
  FEnc.put_principal(val);
  result := true;
end;

function TAny.to_principal(out val: IPrincipal): Boolean;
var
  ptr: Pointer;
begin
  result := false;
  if to_static_any(stat_principal,ptr) then
    begin
      val := IPrincipal(ptr^);
      result := true;
    end;
end;

{** val must be IORBObject }
function TAny.put_object(val: IUnknown; const name: AnsiString = ''): Boolean;
var
  ior : IIOR;
  repoid: RepositoryId;
begin
  result := false;
  if (val as IORBObject)._ior = nil then
    ior := TIOR.Create()
  else
    begin
      ior := (val as IORBObject)._ior;
      if ior = nil then
        begin
          reset();
          exit;
        end;
    end;
  repoid := ior.objid;
  if FChecker.completed then
    begin
      FEnc.buffer.reset;
      FTypeCode := TTypeCode.create_interface_tc(repoid,name);
    end
  else if (FChecker._tc.kind <> tk_objref) or not FChecker.basic(FChecker._tc) then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  ior.encode(FEnc);
  result := true;
end;

{** val must be IORBObject }
function TAny.to_object(out val: IUnknown): Boolean;
var
  temp: Pointer;
begin
  result := false;
  prepare_read;
  if FChecker._tc.kind <> tk_objref then
    begin
      rewind;
      exit;
    end;
  if to_static_any(stat_Object,FChecker._tc,temp) then
    begin
      val := IORBObject(temp^);
      result := true;
    end;
end;

function TAny.struct_get_begin: Boolean;
begin
  result := false;
  prepare_read;
  if not FChecker.struct_begin then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.struct_get_end: Boolean;
begin
  result := false;
  if not FChecker.struct_end then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.struct_put_begin: Boolean;
begin
  result := false;
  prepare_write;
  if not FChecker.struct_begin then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.struct_put_end: Boolean;
begin
  result := false;
  if not FChecker.struct_end then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.union_get_begin: Boolean;
begin
  result := false;
  prepare_read;
  if not FChecker.union_begin then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.union_get_end: Boolean;
begin
  result := false;
  if not FChecker.union_end then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.union_put_begin: Boolean;
begin
  result := false;
  prepare_write;
  if not FChecker.union_begin then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.union_put_end: Boolean;
begin
  result := false;
  if not FChecker.union_end then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.any_get(const a: IAny): Boolean;
begin
  result := false;
  prepare_read;
  a.set_type(FChecker._tc);
  a.prepare_write;
  if not a.copy_any(self) then
    begin
      rewind;
      a.reset;
      exit;
    end;
  result := true;
end;

function TAny.eq(const a: IAny): Boolean;
begin
  result := (self as IAny) = a;
  if result then exit;
  if not __tc.equivalent(a.__tc) then exit;
  result := comparemem(a._enc.buffer._buffer,_enc.buffer._buffer,_enc.buffer.WPosition);
end;

function TAny.union_get_selection(out val: integer): Boolean;
begin
  result := false;
  if not FChecker.union_selection(val) then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.union_put_selection(val: integer): Boolean;
begin
  result := false;
  if not FChecker.union_selection(val) then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.seq_get_begin(out val: _ulong): Boolean;
begin
  result := false;
  prepare_read;
  if not FDec.seq_begin(val) or not FChecker.seq_begin(val) then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.seq_get_end: Boolean;
begin
  result := false;
  if not FChecker.seq_end() then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.seq_put_begin(val: _ulong): Boolean;
begin
  result := false;
  prepare_write;
  if not FChecker.seq_begin(val) then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  FEnc.seq_begin(val);
  result := true;
end;

function TAny.seq_put_end: Boolean;
begin
  result := false;
  if not FChecker.seq_end() then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.arr_get_begin: Boolean;
begin
  result := false;
  prepare_read;
  if not FChecker.arr_begin() then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.arr_get_end: Boolean;
begin
  result := false;
  if not FChecker.arr_end() then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.arr_put_begin: Boolean;
begin
  result := false;
  prepare_write;
  if not FChecker.arr_begin() then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.arr_put_end: Boolean;
begin
  result := false;
  if not FChecker.arr_end() then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  result := true;
end;

function TAny.except_get_begin(out repoid: RepositoryId): Boolean;
begin
  result := false;
  prepare_read;
  if not FChecker.except_begin() or not FDec.except_begin(repoid) then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.except_get_end: Boolean;
begin
  result := false;
  if not FChecker.except_end() or not FDec.except_end then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.except_put_begin(const repoid: RepositoryId): Boolean;
begin
  result := false;
  prepare_write;
  if not FChecker.except_begin() then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  FEnc.except_begin(repoid);
  result := true;
end;

function TAny.except_put_end: Boolean;
begin
  result := false;
  if not FChecker.except_end() then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  FEnc.except_end;
  result := true;
end;

function TAny.value_get_begin(out id: Integer;
  out isref: Boolean): Boolean;
var
  tc: ITypeCode;
  url,rid : AnsiString;
  repoids : TStrings;
  i : integer;
begin
  result := false;
  prepare_read;
  tc := FChecker._tc;
  repoids := TStringList.Create;
  try
    if not FChecker.value_begin() or not FDec.value_begin(url,repoids,id,isref) then
      begin
        rewind;
        exit;
      end;
    if isref then
      begin
        FChecker.basic(FChecker._tc);
        result := true;
        exit;
      end;
    // check if we can truncate to the requested type
    rid := tc.id;
    for i := 0 to pred(repoids.count) do
      if repoids[i] = String(rid) then
        begin
          result := true;
          exit;
        end;
    rewind;
  finally
    repoids.free;
  end;
end;

function TAny.value_get_end(id: Integer; isref: Boolean): Boolean;
begin
  result := false;
  if not FChecker.value_end or (not isref and not Fdec.value_end(id)) then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.value_put_begin(out id: Integer): Boolean;
var
  tc: ITypeCode;
  chunked: Boolean;
  repoids : TStrings;
begin
  result := false;
  prepare_write;
  tc := FChecker._tc;
  if not FChecker.value_begin(tc) then
    begin
      reset;
      exit;
    end;
  // use chunked encoding if value is truncatable
  chunked := VM_TRUNCATABLE = tc.type_modifier;
  // collect repoids of base types we can truncate to
  repoids := TStringList.Create;
  try
    repoids.add(String(tc.id));
    while VM_TRUNCATABLE = tc.type_modifier do
      begin
        tc := tc.concrete_base_type;
        assert(tc <> nil);
        repoids.add(String(tc.id));
      end;
    FExtractedValue := nil;
    FEnc.value_begin('',repoids,chunked,id);
    result := true;
  finally
    repoids.free;
  end;
end;

function TAny.value_put_end(id: Integer): Boolean;
begin
  result := false;
  if not FChecker.value_end then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  FEnc.value_end(id);
  result := true;
end;

function TAny.value_put_ref(id: longint): Boolean;
begin
  FChecker.basic(FChecker._tc);
  FExtractedValue := nil;
  FEnc.value_ref(id);
  result := true;
end;

function TAny.valuebox_get_begin(out id: Integer;
  out isref: Boolean): Boolean;
var
  tc: ITypeCode;
  url,rid : AnsiString;
  repoids : TStrings;
  i : integer;
begin
  result := false;
  prepare_read;
  tc := FChecker._tc;
  repoids := TStringList.Create;
  try
    if not FChecker.valuebox_begin or not FDec.value_begin(url,repoids,id,isref) then
      begin
        rewind;
        exit;
      end;
    if isref then
      begin
        FChecker.basic(FChecker._tc);
        result := true;
        exit;
      end;
    // check if we can truncate to the requested type
    rid := tc.id;
    for i := 0 to pred(repoids.count) do
      if repoids[i] = String(rid) then
        begin
          result := true;
          exit;
        end;
    rewind;
  finally
    repoids.free;
  end;
end;

function TAny.valuebox_get_end(id: Integer; isref: Boolean): Boolean;
begin
  result := false;
  if not FChecker.valuebox_end or (not isref  and not Fdec.value_end(id)) then
    begin
      rewind;
      exit;
    end;
  result := true;
end;

function TAny.valuebox_put_begin(out id: Integer): Boolean;
var
  tc: ITypeCode;
  repoids : TStrings;
begin
  result := false;
  prepare_write;
  tc := FChecker._tc;
  if not FChecker.valuebox_begin() then
    begin
      reset;
      exit;
    end;
  // collect repoids of base types we can truncate to
  repoids := TStringList.Create;
  try
    repoids.add(String(tc.id));
    FExtractedValue := nil;
    FEnc.value_begin('',repoids,false,id);
    result := true;
  finally
    repoids.free;
  end;
end;

function TAny.valuebox_put_end(id: Integer): Boolean;
begin
  result := false;
  if not FChecker.valuebox_end then
    begin
      reset;
      exit;
    end;
  FExtractedValue := nil;
  FEnc.value_end(id);
  result := true;
end;

function TAny.valuebox_put_ref(id: longint): Boolean;
begin
  FChecker.basic(FChecker._tc);
  FExtractedValue := nil;
  FEnc.value_ref(id);
  result := true;
end;

function TAny.put_abstractbase(val: IInterface): Boolean;
var
  sa: IStaticAny;
begin
  sa := StaticAny(stat_AbstractBase, @val);
  result := from_static_any(sa);
end;

function TAny.to_abstractbase(out val: IInterface): Boolean;
var
  temp: Pointer;
begin
  result := false;
  prepare_read;
  if FChecker._tc.kind <> tk_abstract_interface then
    begin
      rewind;
      exit;
    end;
  if to_static_any(stat_AbstractBase,FChecker._tc,temp) then
    begin
      val := IAbstractBase(temp^);
      result := true;
    end;
end;

//*********************************************************************
function CreateAny(): IAny;
begin
  result := TAny.Create
end;

function CreateNullAny(): IAny;
begin
  result := TAny.CreateNull;
end;

function CreateAny_buff(tc: ITypeCode;buf: IBuffer): IAny;
begin
  result := TAny.Create_buff(tc,buf)
end;

function CreateAny_code(tc: ITypeCode;dec: IDecoder;enc: IEncoder): IAny;
begin
  result := TAny.Create_code(tc,dec,enc)
end;

function CreateAny_any(const a: IAny): IAny;
begin
  result := TAny.Create_any(a)
end;

{$IFDEF LIBRARY}
exports
  CreateAny,
  CreateNullAny,
  CreateAny_buff,
  CreateAny_code,
  CreateAny_any;
{$ENDIF}
{$ELSE}
    function CreateAny(): IAny; external MTDORB_Library_Name;
    function CreateNullAny(): IAny; external MTDORB_Library_Name;
    function CreateAny_buff(tc: ITypeCode;buf: IBuffer): IAny; external MTDORB_Library_Name;
    function CreateAny_code(tc: ITypeCode;dec: IDecoder;enc: IEncoder): IAny; external MTDORB_Library_Name;
    function CreateAny_any(const a: IAny): IAny; external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
