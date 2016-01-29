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
unit std_seq;

interface

uses
  stdstat,code_int,orbtypes;

{$IFNDEF USELIB}

type

  TStat_octet_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_char_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_wchar_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_string_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_wstring_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_any_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_ulong_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_ulonglong_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_long_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_longlong_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_ushort_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_short_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_boolean_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_object_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_double_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_longdouble_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStat_float_seq = class(TAbstractStat,IStaticTypeInfo)
  private
    FTC: ITypeCode;
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

{$IFDEF LIBRARY}
var
  _stat_seq_octet : IStaticTypeInfo;
  _stat_seq_char : IStaticTypeInfo;
  _stat_seq_wchar : IStaticTypeInfo;
  _stat_seq_string : IStaticTypeInfo;
  _stat_seq_wstring : IStaticTypeInfo;
  _stat_seq_ulong : IStaticTypeInfo;
  _stat_seq_ulonglong : IStaticTypeInfo;
  _stat_seq_long : IStaticTypeInfo;
  _stat_seq_longlong : IStaticTypeInfo;
  _stat_seq_any : IStaticTypeInfo;
  _stat_seq_short : IStaticTypeInfo;
  _stat_seq_ushort : IStaticTypeInfo;
  _stat_seq_boolean : IStaticTypeInfo;
  _stat_seq_object : IStaticTypeInfo;
  _stat_seq_double : IStaticTypeInfo;
  _stat_seq_longdouble : IStaticTypeInfo;
  _stat_seq_float : IStaticTypeInfo;

  function stat_seq_octet : IStaticTypeInfo;
  function stat_seq_char : IStaticTypeInfo;
  function stat_seq_wchar : IStaticTypeInfo;
  function stat_seq_string : IStaticTypeInfo;
  function stat_seq_wstring : IStaticTypeInfo;
  function stat_seq_ulong : IStaticTypeInfo;
  function stat_seq_ulonglong : IStaticTypeInfo;
  function stat_seq_long : IStaticTypeInfo;
  function stat_seq_longlong : IStaticTypeInfo;
  function stat_seq_any : IStaticTypeInfo;
  function stat_seq_short : IStaticTypeInfo;
  function stat_seq_ushort : IStaticTypeInfo;
  function stat_seq_boolean : IStaticTypeInfo;
  function stat_seq_object : IStaticTypeInfo;
  function stat_seq_double : IStaticTypeInfo;
  function stat_seq_longdouble : IStaticTypeInfo;
  function stat_seq_float : IStaticTypeInfo;
{$ELSE}
var
  stat_seq_octet : IStaticTypeInfo;
  stat_seq_char : IStaticTypeInfo;
  stat_seq_wchar : IStaticTypeInfo;
  stat_seq_string : IStaticTypeInfo;
  stat_seq_wstring : IStaticTypeInfo;
  stat_seq_ulong : IStaticTypeInfo;
  stat_seq_ulonglong : IStaticTypeInfo;
  stat_seq_long : IStaticTypeInfo;
  stat_seq_longlong : IStaticTypeInfo;
  stat_seq_any : IStaticTypeInfo;
  stat_seq_short : IStaticTypeInfo;
  stat_seq_ushort : IStaticTypeInfo;
  stat_seq_boolean : IStaticTypeInfo;
  stat_seq_object : IStaticTypeInfo;
  stat_seq_double : IStaticTypeInfo;
  stat_seq_longdouble : IStaticTypeInfo;
  stat_seq_float : IStaticTypeInfo;
{$ENDIF}

implementation

uses
  any,SysUtils,tcode,orb_int,iior_int;

//*********************************************************************
//  TStat_octet_seq
//*********************************************************************
function TStat_octet_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  len: _ulong;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  setLength(OctetSeq(addr^),len);
  if not dec.get_octets(Pointer(addr^)^,len) then exit;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TStat_octet_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  len: _ulong;
begin
  len := length(OctetSeq(addr^));
  enc.seq_begin(len);
  enc.put_octets(Pointer(addr^)^,len);
  enc.seq_end;
end;

function TStat_octet_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_octet,0);
  result := FTC;
end;

procedure TStat_octet_seq._assign(dst, src: Pointer);
begin
  OctetSeq(dst^) := System.Copy(OctetSeq(src^));
end;

procedure TStat_octet_seq._create(var addr: Pointer);
begin
  OctetSeq(addr^) := nil;
end;

procedure TStat_octet_seq._free(var addr: Pointer);
begin
  OctetSeq(addr^) := nil;
end;

//*********************************************************************
//  TStat_char_seq
//*********************************************************************
function TStat_char_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  len: _ulong;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  setLength(CharSeq(addr^),len);
  if not dec.get_chars(Pointer(addr^)^,len) then exit;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TStat_char_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  len: _ulong;
begin
  len := length(CharSeq(addr^));
  enc.seq_begin(len);
  enc.put_chars(Pointer(addr^)^,len);
  enc.seq_end;
end;

function TStat_char_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_char,0);
  result := FTC;
end;

procedure TStat_char_seq._assign(dst, src: Pointer);
begin
  CharSeq(dst^) := System.Copy(CharSeq(src^));
end;

procedure TStat_char_seq._create(var addr: Pointer);
begin
  CharSeq(addr^) := nil;
end;

procedure TStat_char_seq._free(var addr: Pointer);
begin
  CharSeq(addr^) := nil;
end;

//*********************************************************************
//  TStat_wchar_seq
//*********************************************************************
function TStat_wchar_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  len: _ulong;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  setLength(WCharSeq(addr^),len);
  if not dec.get_wchars(Pointer(addr^)^,len) then exit;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TStat_wchar_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  len: _ulong;
begin
  len := length(WCharSeq(addr^));
  enc.seq_begin(len);
  enc.put_wchars(Pointer(addr^)^,len);
  enc.seq_end;
end;

function TStat_wchar_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_wchar,0);
  result := FTC;
end;

procedure TStat_wchar_seq._assign(dst, src: Pointer);
begin
  WCharSeq(dst^) := System.Copy(WCharSeq(src^));
end;

procedure TStat_wchar_seq._create(var addr: Pointer);
begin
  WCharSeq(addr^) := nil;
end;

procedure TStat_wchar_seq._free(var addr: Pointer);
begin
  WCharSeq(addr^) := nil;
end;

//*********************************************************************
//  TStat_string_seq
//*********************************************************************
function TStat_string_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  len: _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  setLength(StringSeq(addr^),len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      if not dec.get_string(StringSeq(addr^)[i]) then exit;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TStat_string_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  len: _ulong;
  i : integer;
begin
  len := length(StringSeq(addr^));
  enc.seq_begin(len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      enc.put_string(StringSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_string_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_octet,0);
  result := FTC;
end;


procedure TStat_string_seq._assign(dst, src: Pointer);
begin
  StringSeq(dst^) := System.Copy(StringSeq(src^));
end;

procedure TStat_string_seq._create(var addr: Pointer);
begin
  StringSeq(addr^) := nil;
end;

procedure TStat_string_seq._free(var addr: Pointer);
begin
  StringSeq(addr^) := nil;
end;

//*********************************************************************
//  TStat_wstring_seq
//*********************************************************************
function TStat_wstring_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  len: _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  setLength(WStringSeq(addr^),len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      if not dec.get_wstring(WStringSeq(addr^)[i]) then exit;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TStat_wstring_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  len: _ulong;
  i : integer;
begin
  len := length(WStringSeq(addr^));
  enc.seq_begin(len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      enc.put_wstring(WStringSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_wstring_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_wchar,0);
  result := FTC;
end;


procedure TStat_wstring_seq._assign(dst, src: Pointer);
begin
  WStringSeq(dst^) := System.Copy(WStringSeq(src^));
end;

procedure TStat_wstring_seq._create(var addr: Pointer);
begin
  WStringSeq(addr^) := nil;
end;

procedure TStat_wstring_seq._free(var addr: Pointer);
begin
  WStringSeq(addr^) := nil;
end;

//*********************************************************************
//  TStat_any_seq
//*********************************************************************
function TStat_any_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  len: _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  setLength(AnySeq(addr^),len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      //if not dec.get_any(AnySeq(addr^)[i]) then exit;
      if not stat_Any.demarshal(dec, @AnySeq(addr^)[i]) then exit;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TStat_any_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  len: _ulong;
  i : integer;
begin
  len := length(AnySeq(addr^));
  enc.seq_begin(len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      enc.put_any(AnySeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_any_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_any,0);
  result := FTC;
end;


procedure TStat_any_seq._assign(dst, src: Pointer);
begin
  AnySeq(dst^) := System.Copy(AnySeq(src^));
end;

procedure TStat_any_seq._create(var addr: Pointer);
begin
  AnySeq(addr^) := nil;
end;

procedure TStat_any_seq._free(var addr: Pointer);
begin
  AnySeq(addr^) := nil;
end;

//*********************************************************************
//  TStat_long_seq
//*********************************************************************
procedure TStat_long_seq._assign(dst, src: Pointer);
begin
  LongSeq(dst^) := System.copy(LongSeq(src^));
end;

procedure TStat_long_seq._create(var addr: Pointer);
begin
  LongSeq(addr^) := nil;
end;

procedure TStat_long_seq._free(var addr: Pointer);
begin
  LongSeq(addr^) := nil;
end;

function TStat_long_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l : _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(LongSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_long(LongSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_long_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(LongSeq(addr^));
  enc.seq_begin(l);
  if l <> 0 then
    for i := 0 to Pred(l) do
      enc.put_long(LongSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_long_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_long,0);
  result := FTC;
end;

//*********************************************************************
//  TStat_ulong_seq
//*********************************************************************
procedure TStat_ulong_seq._assign(dst, src: Pointer);
begin
  ULongSeq(dst^) := System.copy(ULongSeq(src^));
end;

procedure TStat_ulong_seq._create(var addr: Pointer);
begin
  ULongSeq(addr^) := nil;
end;

procedure TStat_ulong_seq._free(var addr: Pointer);
begin
  ULongSeq(addr^) := nil;
end;

function TStat_ulong_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l : _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(ULongSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_ulong(ULongSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_ulong_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(ULongSeq(addr^));
  enc.seq_begin(l);
  if l <> 0 then
    for i := 0 to Pred(l) do
      enc.put_ulong(ULongSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_ulong_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_ulong,0);
  result := FTC;
end;

//*********************************************************************
// TStat_ulonglong_seq }
//*********************************************************************
procedure TStat_ulonglong_seq._assign(dst, src: Pointer);
begin
  ULongLongSeq(dst^) := System.copy(ULongLongSeq(src^));
end;

procedure TStat_ulonglong_seq._create(var addr: Pointer);
begin
  ULongLongSeq(addr^) := nil;
end;

procedure TStat_ulonglong_seq._free(var addr: Pointer);
begin
  ULongLongSeq(addr^) := nil;
end;

function TStat_ulonglong_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l : _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(ULongLongSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_ulonglong(ULongLongSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_ulonglong_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(ULongLongSeq(addr^));
  enc.seq_begin(l);
  if l <> 0 then
  for i := 0 to Pred(l) do
    enc.put_ulonglong(ULongLongSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_ulonglong_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_ulonglong,0);
  result := FTC;
end;

//*********************************************************************
// TStat_longlong_seq
//*********************************************************************
procedure TStat_longlong_seq._assign(dst, src: Pointer);
begin
  LongLongSeq(dst^) := System.copy(LongLongSeq(src^));
end;

procedure TStat_longlong_seq._create(var addr: Pointer);
begin
  LongLongSeq(addr^) := nil;
end;

procedure TStat_longlong_seq._free(var addr: Pointer);
begin
  LongLongSeq(addr^) := nil;
end;

function TStat_longlong_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l : _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(LongLongSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_longlong(LongLongSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_longlong_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(LongLongSeq(addr^));
  enc.seq_begin(l);
  if l <> 0 then
    for i := 0 to Pred(l) do
      enc.put_longlong(LongLongSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_longlong_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_longlong,0);
  result := FTC;
end;

//*********************************************************************
//  TStat_ushort_seq
//*********************************************************************
procedure TStat_ushort_seq._assign(dst, src: Pointer);
begin
  UShortSeq(dst^) := System.copy(UShortSeq(src^));
end;

procedure TStat_ushort_seq._create(var addr: Pointer);
begin
  UShortSeq(addr^) := nil;
end;

procedure TStat_ushort_seq._free(var addr: Pointer);
begin
  UShortSeq(addr^) := nil;
end;

function TStat_ushort_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l : _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(UShortSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_ushort(UShortSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_ushort_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(UShortSeq(addr^));
  enc.seq_begin(l);
  if l <> 0 then
    for i := 0 to Pred(l) do
      enc.put_ushort(UShortSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_ushort_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_ushort,0);
  result := FTC;
end;

//*********************************************************************
//  TStat_short_seq
//*********************************************************************
procedure TStat_short_seq._assign(dst, src: Pointer);
begin
  ShortSeq(dst^) := System.copy(ShortSeq(src^));
end;

procedure TStat_short_seq._create(var addr: Pointer);
begin
  ShortSeq(addr^) := nil;
end;

procedure TStat_short_seq._free(var addr: Pointer);
begin
  ShortSeq(addr^) := nil;
end;

function TStat_short_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l : _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(ShortSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_short(ShortSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_short_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(ShortSeq(addr^));
  enc.seq_begin(l);
  for i := 0 to Pred(l) do
    enc.put_short(ShortSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_short_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_short,0);
  result := FTC;
end;

//*********************************************************************
//  TStat_boolean_seq
//*********************************************************************
function TStat_boolean_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  len: _ulong;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  setLength(OctetSeq(addr^),len);
  if not dec.get_octets(Pointer(addr^)^,len) then exit;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TStat_boolean_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  len: _ulong;
begin
  len := length(OctetSeq(addr^));
  enc.seq_begin(len);
  enc.put_octets(Pointer(addr^)^,len);
  enc.seq_end;
end;

function TStat_boolean_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_octet,0);
  result := FTC;
end;

procedure TStat_boolean_seq._assign(dst, src: Pointer);
begin
  OctetSeq(dst^) := System.Copy(OctetSeq(src^));
end;

procedure TStat_boolean_seq._create(var addr: Pointer);
begin
  OctetSeq(addr^) := nil;
end;

procedure TStat_boolean_seq._free(var addr: Pointer);
begin
  OctetSeq(addr^) := nil;
end;

{ TStat_object_seq }

procedure TStat_object_seq._create(var addr: Pointer);
begin
  ObjSeq(addr^) := nil;
end;

procedure TStat_object_seq._free(var addr: Pointer);
begin
  ObjSeq(addr^) := nil;
end;

function TStat_object_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  len: _ulong;
  i : integer;
begin
  result := false;
  if not dec.seq_begin(len) then exit;
  setLength(ObjSeq(addr^),len);
  if len <> 0 then
    for i := 0 to Pred(len) do
      if not stat_Object.demarshal(dec, @ObjSeq(addr^)[i]) then exit;
  if not dec.seq_end() then exit;
  result := true;
end;

procedure TStat_object_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  len: _ulong;
  i : integer;
  ior: IIOR;
begin
  len := length(ObjSeq(addr^));
  enc.seq_begin(len);
  if len <> 0 then
    for i := 0 to Pred(len) do begin
      ior := ObjSeq(addr^)[i]._ior;
      ior.encode(enc);
    end;
  enc.seq_end;
end;

function TStat_object_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_objref,0);
  result := FTC;
end;

procedure TStat_object_seq._assign(dst, src: Pointer);
begin
  ObjSeq(dst^) := System.Copy(ObjSeq(src^));
end;

{ TStat_double_seq }

procedure TStat_double_seq._assign(dst, src: Pointer);
begin
  DoubleSeq(dst^) := System.Copy(DoubleSeq(src^));
end;

procedure TStat_double_seq._create(var addr: Pointer);
begin
  DoubleSeq(addr^) := nil;
end;

procedure TStat_double_seq._free(var addr: Pointer);
begin
  DoubleSeq(addr^) := nil;
end;

function TStat_double_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l: _ulong;
  i: integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(DoubleSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_double(DoubleSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_double_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(DoubleSeq(addr^));
  enc.seq_begin(l);
  if l <> 0 then
    for i := 0 to Pred(l) do
      enc.put_double(DoubleSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_double_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_double,0);
  result := FTC;
end;

{ TStat_longdouble_seq }

procedure TStat_longdouble_seq._assign(dst, src: Pointer);
begin
  LongDoubleSeq(dst^) := System.Copy(LongDoubleSeq(src^));
end;

procedure TStat_longdouble_seq._create(var addr: Pointer);
begin
  LongDoubleSeq(addr^) := nil;
end;

procedure TStat_longdouble_seq._free(var addr: Pointer);
begin
  LongDoubleSeq(addr^) := nil;
end;

function TStat_longdouble_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l: _ulong;
  i: integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(LongDoubleSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_longdouble(LongDoubleSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_longdouble_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(LongDoubleSeq(addr^));
  enc.seq_begin(l);
  if l <> 0 then
    for i := 0 to Pred(l) do
      enc.put_longdouble(LongDoubleSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_longdouble_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_longdouble,0);
  result := FTC;
end;

{ TStat_float_seq }

procedure TStat_float_seq._assign(dst, src: Pointer);
begin
  FloatSeq(dst^) := System.Copy(FloatSeq(src^));
end;

procedure TStat_float_seq._create(var addr: Pointer);
begin
  FloatSeq(addr^) := nil;
end;

procedure TStat_float_seq._free(var addr: Pointer);
begin
  FloatSeq(addr^) := nil;
end;

function TStat_float_seq.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  l: _ulong;
  i: integer;
begin
  result := false;
  if not dec.seq_begin(l) then exit;
  setLength(FloatSeq(addr^),l);
  if l <> 0 then
    for i := 0 to pred(l) do
      if not dec.get_float(FloatSeq(addr^)[i]) then exit;
  if not dec.seq_end then exit;
  result := true;
end;

procedure TStat_float_seq.marshal(enc: IEncoder; const addr: Pointer);
var
  i : integer;
  l : _ulong;
begin
  l := length(FloatSeq(addr^));
  enc.seq_begin(l);
  if l <> 0 then
    for i := 0 to Pred(l) do
      enc.put_float(FloatSeq(addr^)[i]);
  enc.seq_end;
end;

function TStat_float_seq.typecode: ITypeCode;
begin
  if FTC = nil then
    FTC := TTypeCode.create_sequence_tc(_tc_float,0);
  result := FTC;
end;

{$IFDEF LIBRARY}
function stat_seq_octet : IStaticTypeInfo;
begin
  result := _stat_seq_octet
end;

function stat_seq_char : IStaticTypeInfo;
begin
  result := _stat_seq_char
end;

function stat_seq_wchar : IStaticTypeInfo;
begin
  result := _stat_seq_wchar
end;

function stat_seq_string : IStaticTypeInfo;
begin
  result := _stat_seq_string
end;

function stat_seq_wstring : IStaticTypeInfo;
begin
  result := _stat_seq_wstring
end;

function stat_seq_ulong : IStaticTypeInfo;
begin
  result := _stat_seq_ulong
end;

function stat_seq_ulonglong : IStaticTypeInfo;
begin
  result := _stat_seq_ulonglong
end;

function stat_seq_long : IStaticTypeInfo;
begin
  result := _stat_seq_long
end;

function stat_seq_longlong : IStaticTypeInfo;
begin
  result := _stat_seq_longlong
end;

function stat_seq_any : IStaticTypeInfo;
begin
  result := _stat_seq_any
end;

function stat_seq_short : IStaticTypeInfo;
begin
  result := _stat_seq_short
end;

function stat_seq_ushort : IStaticTypeInfo;
begin
  result := _stat_seq_ushort
end;

function stat_seq_boolean : IStaticTypeInfo;
begin
  result := _stat_seq_boolean
end;

function stat_seq_object : IStaticTypeInfo;
begin
  result := _stat_seq_object;
end;

function stat_seq_double : IStaticTypeInfo;
begin
  result := _stat_seq_double;
end;

function stat_seq_longdouble : IStaticTypeInfo;
begin
  result := _stat_seq_longdouble;
end;

function stat_seq_float : IStaticTypeInfo;
begin
  result := _stat_seq_float;
end;

exports
  stat_seq_octet,
  stat_seq_char,
  stat_seq_wchar,
  stat_seq_string,
  stat_seq_wstring,
  stat_seq_ulong,
  stat_seq_ulonglong,
  stat_seq_long,
  stat_seq_longlong,
  stat_seq_any,
  stat_seq_short,
  stat_seq_ushort,
  stat_seq_boolean,
  stat_seq_object,
  stat_seq_double,
  stat_seq_longdouble,
  stat_seq_float;
initialization
  _stat_seq_octet := TStat_octet_seq.Create();
  _stat_seq_char := TStat_char_seq.Create();
  _stat_seq_wchar := TStat_wchar_seq.Create();
  _stat_seq_string := TStat_string_seq.Create();
  _stat_seq_wstring := TStat_wstring_seq.Create();
  _stat_seq_ulong := TStat_ulong_seq.Create;
  _stat_seq_ulonglong := TStat_ulonglong_seq.Create;
  _stat_seq_long := TStat_long_seq.Create;
  _stat_seq_longlong := TStat_longlong_seq.Create;
  _stat_seq_any := TStat_any_seq.Create;
  _stat_seq_short := TStat_short_seq.Create;
  _stat_seq_ushort := TStat_ushort_seq.Create;
  _stat_seq_boolean := TStat_boolean_seq.Create;
  _stat_seq_object := TStat_object_seq.Create;
  _stat_seq_double := TStat_double_seq.Create;
  _stat_seq_longdouble := TStat_longdouble_seq.Create;
  _stat_seq_float := TStat_float_seq.Create;
{$ELSE}
initialization
  stat_seq_octet := TStat_octet_seq.Create();
  stat_seq_char := TStat_char_seq.Create();
  stat_seq_wchar := TStat_wchar_seq.Create();
  stat_seq_string := TStat_string_seq.Create();
  stat_seq_wstring := TStat_wstring_seq.Create();
  stat_seq_ulong := TStat_ulong_seq.Create;
  stat_seq_ulonglong := TStat_ulonglong_seq.Create;
  stat_seq_long := TStat_long_seq.Create;
  stat_seq_longlong := TStat_longlong_seq.Create;
  stat_seq_any := TStat_any_seq.Create;
  stat_seq_short := TStat_short_seq.Create;
  stat_seq_ushort := TStat_ushort_seq.Create;
  stat_seq_boolean := TStat_boolean_seq.Create;
  stat_seq_double := TStat_double_seq.Create;
  stat_seq_longdouble := TStat_longdouble_seq.Create;
  stat_seq_float := TStat_float_seq.Create;
{$ENDIF}
{$ELSE}
  function stat_seq_octet : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_char : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_wchar : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_string : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_wstring : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_ulong : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_ulonglong : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_long : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_longlong : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_any : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_short : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_ushort : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_boolean : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_object : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_double : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_longdouble : IStaticTypeInfo; external MTDORB_Library_Name;
  function stat_seq_float : IStaticTypeInfo; external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
