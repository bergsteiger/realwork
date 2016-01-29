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
unit tcode;

interface


uses
  orbtypes,code_int,ir_int,Classes,exceptions,except_int,map_int;

{$IFNDEF USELIB}
type
  TTypeCode = class(TInterfacedObject,ITypeCode)
  private
    FKind: TCKind;
    FLen : longint;
    FId,FName : AnsiString;
    FMemberNames : array of AnsiString;
    FMemberTypes : array of ITypeCode;
    FMemberVisibility : array of TVisibility;
    FLabels : array of IAny;
    FContent : ITypeCode;
    FModifier: TValueModifier;
    //FBaseType: ITypeCode;
    FDefaultIndex : integer;
    FDiscriminator : ITypeCode;
    FDigits: _ushort;
    FScale: short;
    FConstant : Boolean;
    FRecurceDepth : longint;
    FRecurce_tc: ITypeCode;
    FValueMode : smallint;
  protected
    function equal(const tc: ITypeCode): Boolean;
    function equivalent(const tc: ITypeCode): Boolean;
    function get_compact_typecode: ITypeCode;
    function kind: TCKind;
    function id: RepositoryID; overload;
    function name: Identifier;
    function member_count: _ulong;
    function member_count_inherited: _ulong;
    function member_name(index: _ulong): Identifier;
    function member_type(index: _ulong): ITypeCode;
    function member_index(a: IAny): integer;
    function member_type_inherited(index: _ulong): ITypeCode;
    function member_label(index: _ulong): IAny;
    function discriminator_type(): ITypeCode;
    function default_index: longint;
    function _length: _ulong;
    function content_type: ITypeCode;
    function fixed_digits: _ushort;
    function fixed_scale: short;
    function member_visibility(index: _ulong): orbtypes.TVisibility;
    function type_modifier: orbtypes.TValueModifier;
    function concrete_base_type(): ITypeCode;
    // DORB extension
    function decode(const dec: IDecoder;omap: ILongObjectMap = nil; level: integer = 0): Boolean;
    procedure encode(const enc: IEncoder; omap: IInterfaceLongMap = nil);
    procedure setlen(bound: _ulong);
    function is_base_type(): Boolean;
    procedure copy(src: TTypeCode);
    function _this: Pointer;
    procedure connect(tc: ITypeCode; depth: longint);
    procedure disconnect(tc: ITypeCode);
    procedure strip();
    function unalias(): ITypeCode;
    function is_object(): Boolean;
    function is_any(): Boolean;
    function from_string(s: AnsiString): Boolean;
    function to_string: AnsiString;
    function resolve_recursion: ITypeCode;
    function repoid: RepositoryId;
    function recurce_tc: ITypeCode;
    procedure recurse_depth(depth: long);
    procedure id(const id: RepositoryID); overload;
  public
    constructor Create(kind: TCKind; id: AnsiString = ''; name: AnsiString = ''); overload;
    constructor Create(tc: ITypeCode); overload;
    constructor Create(const s: AnsiString); overload;
    destructor Destroy(); override;
    procedure content(val: ITypeCode); overload;
    function content: ITypeCode; overload;
    class function create_interface_tc(id, name: AnsiString): ITypeCode;
    class function create_struct_tc(id, name: AnsiString; members: StructMemberSeq): ITypeCode;
    class function create_alias_tc(id, name: AnsiString;original: ITypeCode): ITypeCode;
    class function create_exception_tc(const id: RepositoryID; const name : Identifier; const members: StructMemberSeq): ITypeCode;
    class function create_enum_tc(id, name: AnsiString; members: EnumMemberSeq): ITypeCode;
    class function create_sequence_tc(_type: ITypeCode; bound: _ulong): ITypeCode;
    class function create_recursive_sequence_tc(bound, offset: _ulong): ITypeCode;
    class function create_array_tc(_type: ITypeCode; length: _ulong): ITypeCode;
    class function create_value_tc(id, name: AnsiString; vmod: TValueModifier; base: ITypeCode; members: ValueMemberSeq): ITypeCode;
    class function create_value_box_tc(id, name: AnsiString; orig: ITypeCode): ITypeCode;
    class function create_union_tc(id, name: AnsiString;discr: ITypeCode;members: UnionMemberSeq): ITypeCode;
    class function create_native_tc(id, name: AnsiString): ITypeCode;
    class function create_recursive_tc(const id: AnsiString): ITypeCode;
    class function create_abstract_interface_tc(id, name: AnsiString): ITypeCode;
  end;

  TTypeCodeConst = class(TInterfacedObject,ITypeCodeConst)
  private
    FStrValue : AnsiString;
    FTypeCode: ITypeCode;
  protected
    function typecode : ITypeCode;
    procedure set_string(const str: AnsiString);
  public
    constructor Create(const value: AnsiString = '');
  end;

  TRecordLevel = (LNone, LArray, LSequence, LStruct, LExcept, LUnion, LValue, LValueBox);

  ILevelRecord = interface
  ['{1C534AB1-D445-11d4-9E17-204C4F4F5020}']
    function level: TRecordLevel;
    function tc: ITypeCode;
    function i : integer; overload;
    procedure i(val: integer); overload;
    function n : integer; overload;
    procedure n(val: integer); overload;
    function last_i : integer; overload;
    procedure last_i(val: integer); overload;
    function x : integer; overload;
    procedure x(val: integer); overload;
  end;

  TLevelRecord = class(TInterfacedObject,ILevelRecord)
  private
    FLevel : TRecordLevel;
    FTC : ITypeCode;
    FI,FN,FX,FLast_I : integer;
  protected
    function level: TRecordLevel;
    function tc: ITypeCode;
    function i : integer; overload;
    procedure i(val: integer); overload;
    function n : integer; overload;
    procedure n(val: integer); overload;
    function last_i : integer; overload;
    procedure last_i(val: integer); overload;
    function x : integer; overload;
    procedure x(val: integer); overload;
  public
    constructor Create(lr: ILevelRecord); overload;
    constructor Create(tc: ITypeCode; level: TRecordLevel); overload;
    constructor Create(l : TRecordLevel; tc: ITypeCode; n: integer = 0; i: integer = 0; x: integer = 0); overload;
  end;

  TTypeCodeChecker = class(TInterfacedObject,ITypecodeChecker)
  private
    FTC,FTop : ITypeCode;
    FDone : Boolean;
    FSelIndex : integer;
    FLevels : IInterfaceList;
    procedure _tc(_tc: ITypeCode); overload;
  protected
    function _tc: ITypeCode; overload;
    function top: ITypeCode;
    function inside(kind: TCKind): Boolean;
    function level_finished: Boolean;
    function basic(tc: ITypeCode): Boolean;
    function enumeration(len: _ulong): Boolean;
    function abstract_interface(int: ITypeCode): Boolean;

    function union_begin(): Boolean;
    function union_selection(ind: integer = -1): Boolean;
    function union_end(unst: Boolean = false): Boolean;

    function struct_begin(): Boolean;
    function struct_end(unst: Boolean = false): Boolean;

    function except_begin(): Boolean;
    function except_end(unst: Boolean = false): Boolean;

    function seq_begin(len: _ulong): Boolean;
    function seq_end(unst: Boolean = false): Boolean;

    function arr_begin(): Boolean;
    function arr_end(unst: Boolean = false): Boolean;

    function value_begin(tc: ITypeCode = nil): Boolean;
    function value_end(): Boolean;

    function valuebox_begin(): Boolean;
    function valuebox_end(): Boolean;

    procedure finish();
    function completed(): Boolean;
    procedure restart(_tc: ITypeCode = nil);
    function level_count: _ulong;
    function next_typecode: Boolean;
    function advance: Boolean;
    function level: ILevelRecord;
    function leave(l: TRecordLevel; sloppy: Boolean): Boolean;
    procedure override_tc(t: ITypeCode);
    procedure enter(rec: ILevelRecord);
  public
    constructor Create(tc: ITypeCode = nil); overload;
    constructor Create(tcc: ITypeCodeChecker); overload;
  end;

  function CreateTypeCodeConst(const value: AnsiString = ''): ITypeCodeConst;

{$IFDEF LIBRARY}
var
  tc_void,
  tc_short,
  tc_long,
  tc_ushort,
  tc_ulong,
  tc_float,
  tc_double,
  tc_boolean,
  tc_char,
  tc_octet,
  tc_any,
  tc_TypeCode,
  tc_Principal,
  tc_string,
  tc_objref,
  tc_longlong,
  tc_ulonglong,
  tc_longdouble,
  tc_wchar,
  tc_ConstantDef,
  tc_InterfaceDef,
  tc_ValueBase,
  tc_wstring,
  tc_CompletionStatus,
  tc_AbstractBase : ITypeCode;
  tc_SystemException : TSystemExceptionTypeCodeList;

  function _tc_null : ITypeCode;
  function _tc_void : ITypeCode;
  function _tc_short : ITypeCode;
  function _tc_long : ITypeCode;
  function _tc_ushort : ITypeCode;
  function _tc_ulong : ITypeCode;
  function _tc_float : ITypeCode;
  function _tc_double : ITypeCode;
  function _tc_boolean : ITypeCode;
  function _tc_char : ITypeCode;
  function _tc_octet : ITypeCode;
  function _tc_any : ITypeCode;
  function _tc_TypeCode : ITypeCode;
  function _tc_Principal : ITypeCode;
  function _tc_string : ITypeCode;
  function _tc_objref : ITypeCode;
  function _tc_longlong : ITypeCode;
  function _tc_ulonglong : ITypeCode;
  function _tc_longdouble : ITypeCode;
  function _tc_wchar : ITypeCode;
  function _tc_ConstantDef : ITypeCode;
  function _tc_InterfaceDef : ITypeCode;
  function _tc_ValueBase : ITypeCode;
  function _tc_wstring : ITypeCode;
  function _tc_CompletionStatus : ITypeCode;
  function _tc_AbstractBase : ITypeCode;
  function _tc_SystemException : TSystemExceptionTypeCodeList;
{$ELSE}
var
  _tc_null,
  _tc_void,
  _tc_short,
  _tc_long,
  _tc_ushort,
  _tc_ulong,
  _tc_float,
  _tc_double,
  _tc_boolean,
  _tc_char,
  _tc_octet,
  _tc_any,
  _tc_TypeCode,
  _tc_Principal,
  _tc_string,
  _tc_objref,
  _tc_longlong,
  _tc_ulonglong,
  _tc_longdouble,
  _tc_wchar,
  _tc_ConstantDef,
  _tc_InterfaceDef,
  _tc_ValueBase,
  _tc_wstring,
  _tc_CompletionStatus,
  _tc_AbstractBase : ITypeCode;
  _tc_SystemException: array [SYSEXC_TYPES] of ITypeCode;
{$ENDIF}
const
  TK_RECURSIVE = $FFFFFFFF;

implementation

uses
  SysUtils,encoder,decoder,stdstat,static,throw,buffer,utils,any,map;

procedure CreateSystemExceptionTC;
var
  i: SYSEXC_TYPES;
  ss: StructMemberSeq;
  es: EnumMemberSeq;
begin
  SetLength(es, 3);
  es[0] := 'COMPLETED_YES';
  es[1] := 'COMPLETED_NO';
  es[2] := 'COMPLETED_MAYBE';
  {$IFDEF LIBRARY}tc_CompletionStatus{$ELSE}_tc_CompletionStatus{$ENDIF} := TTypeCode.create_enum_tc('IDL:omg.org/CORBA/CompletionStatus:1.0', 'CompletionStatus', es);

  SetLength(ss, 2);
  ss[0].name := 'minor';
  ss[0]._type := _tc_ulong;
  ss[1].name := 'completed';
  ss[1]._type := _tc_CompletionStatus;

  for i := Low(SYSEXC_TYPES) to High(SYSEXC_TYPES) do
    {$IFDEF LIBRARY}tc_SystemException[i]{$ELSE}_tc_SystemException[i]{$ENDIF} := TTypeCode.create_exception_tc(SYSEXC_REPOID[i], SYSEXC_NAMES[i], ss);
end;

//***********************************************************************
//  TTypeCode
//***********************************************************************
constructor TTypeCode.Create(kind: TCKind; id: AnsiString = ''; name: AnsiString = '');
begin
  FKind := kind;
  FId := id;
  FName := name;
end;

constructor TTypeCode.Create(const s: AnsiString);
begin
  FKind := tk_null;
  assert(from_string(s));
end;

constructor TTypeCode.Create(tc: ITypeCode);
begin
  FKind := tk_null;
  copy(TTypeCode(tc._this));
end;

destructor TTypeCode.Destroy();
begin
  inherited;
end;

class function TTypeCode.create_alias_tc(id, name: AnsiString;original: ITypeCode): ITypeCode;
var
  tc: TTypeCode;
begin
  tc := TTypeCode.Create(tk_alias,id,name);
  tc.content(original);
  result := tc;
  result.content().connect(result);
end;

class function TTypeCode.create_exception_tc(const id: RepositoryID;
  const name: Identifier; const members: StructMemberSeq): ITypeCode;
var
  tc: TTypeCode;
  i : integer;
begin
  tc := TTypeCode.Create(tk_except,id,name);
  result := tc;
  if length(members) > 0 then
    begin
      setLength(tc.FMemberNames,Length(members));
      setLength(tc.FMemberTypes,Length(members));
      for i := 0 to Pred(Length(members)) do
        with StructMember(members[i]) do
          begin
            tc.FMemberNames[i] := name;
            tc.FMemberTypes[i] := _type;
            tc.FMemberTypes[i].connect(result);
          end;
    end;
end;

class function TTypeCode.create_struct_tc(id, name: AnsiString; members: StructMemberSeq): ITypeCode;
var
  tc: TTypeCode;
  i : integer;
begin
  tc := TTypeCode.Create(tk_struct,id,name);
  result := tc;
  if length(members) > 0 then
    begin
      setLength(tc.FMemberNames,Length(members));
      setLength(tc.FMemberTypes,Length(members));
      for i := 0 to Pred(Length(members)) do
        with StructMember(members[i]) do
          begin
            tc.FMemberNames[i] := name;
            tc.FMemberTypes[i] := type_def._type;
            tc.FMemberTypes[i].connect(result);
          end;
    end;
end;

class function TTypeCode.create_interface_tc(id, name: AnsiString): ITypeCode;
begin
  result := TTypeCode.Create(tk_objref,id,name);
end;

type
  TLongTCPair = class
    first: longint;
    second: ITypeCode;
  end;

function MakeLongTCPair(first: longint; second: ITypeCode): TLongTCPair;
begin
  Result := TLongTCPair.Create;
  Result.first := first;
  Result.second := second;
end;

function TTypeCode.decode(const dec: IDecoder; omap: ILongObjectMap; level: integer): Boolean;
var
  tmp,len: _ulong;
  state: TEncapsState;
  i, recurce_pos, rpos: integer;
  s : AnsiString;
  tc : ITypeCode;
  a: IAny;
  sh: short;
  buffer_pos: long;
  pair: TLongTCPair;
begin
  // omap maps buffer positions to (NestingLevel, TypeCode) pairs.
  // initially TypeCode is set to nil so nested typecodes can
  // detect whether they are recursive or repeated ([12-13]). Only
  // when decoding is finished TypeCode is set to 'this'.
  if omap = nil then
    omap := TLongObjectMap.Create;

  result := false;
  if not dec.get_ulong(tmp) then exit;
  FKind := TCKind(tmp);

  buffer_pos := dec._buffer().RPosition - SizeOf(_ulong);
  omap[buffer_pos] := MakeLongTCPair(level, nil);

  case FKind of
    tk_null,
    tk_void,
    tk_short,
    tk_long,
    tk_longlong,
    tk_ushort,
    tk_ulong,
    tk_ulonglong,
    tk_float,
    tk_double,
    tk_longdouble,
    tk_boolean,
    tk_char,
    tk_wchar,
    tk_octet,
    tk_any,
    tk_TypeCode,
    tk_Principal:;
    tk_string,tk_wstring: begin
        if not dec.get_ulong(tmp) then exit;
        FLen := tmp;
      end;
    tk_objref,tk_native,tk_abstract_interface: begin
        if not dec.encaps_begin(state,len) then exit;
        if not dec.get_string(FId) then exit;
        if not dec.get_string(FName) then exit;
        //if fname = '' then exit;
        if not dec.encaps_end(state) then exit;
      end;
    tk_except,tk_struct: begin
        if not dec.encaps_begin(state,len) then exit;
        if not dec.get_string(FId) then exit;
        if not dec.get_string(FName) then exit;
        if not dec.get_ulong(len) then exit;
        setLength(FMemberNames,len);
        setLength(FMemberTypes,len);
        if len > 0 then
          for i := 0 to Pred(len) do
            begin
              if not dec.get_string(s) then exit;
              FMemberNames[i] := s;
              tc := TTypeCode.Create();
              FMemberTypes[i] := tc;
              if not tc.decode(dec,omap,level+1) then exit;
              tc.connect(self);
            end;
        if not dec.encaps_end(state) then exit;
      end;
    tk_union : begin
        if not dec.encaps_begin(state,len) then exit;
        if not dec.get_string(FId) then exit;
        if not dec.get_string(FName) then exit;
        FDiscriminator := TTypeCode.Create;
        if not FDiscriminator.decode(dec,omap,level+1) then exit;
        if not dec.get_ulong(_ulong(FDefaultIndex)) then exit;
        if not dec.get_ulong(len) then exit;
        setLength(FLabels,len);
        setLength(FMemberNames,len);
        setLength(FMemberTypes,len);
        for i := 0 to Pred(len) do
          begin
            a := CreateAny;
            if not a.demarshal(FDiscriminator,dec) then exit;
            if i = FDefaultIndex then
              a.put_octet(0);
            FLabels[i] := a;
            if not dec.get_string(s) then exit;
            FMemberNames[i] := s;
            FMemberTypes[i] := TTypeCode.Create();
            if not FMemberTypes[i].decode(dec,omap,level+1) then exit;
            FMemberTypes[i].connect(self);
          end;
        if not dec.encaps_end(state) then exit;
      end;
    tk_enum : begin
        if not dec.encaps_begin(state,len) then exit;
        if not dec.get_string(FId) then exit;
        if not dec.get_string(FName) then exit;
        if not dec.get_ulong(len) then exit;
        setLength(FMemberNames,len);
        for i := 0 to Pred(len) do
          begin
            if not dec.get_string(s) then exit;
            FMemberNames[i] := s;
          end;
        if not dec.encaps_end(state) then exit;
      end;
    tk_sequence,tk_array: begin
        if not dec.encaps_begin(state,len) then exit;
        FContent := TTypeCode.Create;
        if not FContent.decode(dec,omap,level+1) then exit;
        FContent.connect(self);
        if not dec.get_ulong(len) then exit;
        FLen := len;
        if not dec.encaps_end(state) then exit;
      end;
    tk_alias : begin
        if not dec.encaps_begin(state,len) then exit;
        if not dec.get_string(FId) then exit;
        if not dec.get_string(FName) then exit;
        FContent := TTypeCode.Create;
        if not FContent.decode(dec,omap,level+1) then exit;
        FContent.connect(self);
        if not dec.encaps_end(state) then exit;
      end;
    tk_fixed : begin
        if not dec.get_ushort(FDigits) then exit;
        if not dec.get_short(FScale) then exit;
      end;
    tk_value : begin
        FLen := -1;
        if not dec.encaps_begin(state,len) then exit;
        if not dec.get_string(FId) then exit;
        if not dec.get_string(FName) then exit;
        if not dec.get_short(short(sh)) then exit;
        FModifier := TValueModifier(sh);
        tc := TTYpeCode.Create();
        if not tc.decode(dec,omap,level+1) then exit;
        if tc.kind = tk_null then
          FContent := nil
        else
          begin
            FContent := tc;
            FContent.connect(self);
          end;
        if not dec.get_ulong(len) then exit;
        setLength(FMemberNames,len);
        setLength(FMemberTypes,len);
        setLength(FMemberVisibility,len);
        if len <> 0 then
          for i := 0 to Pred(len) do
            begin
              if not dec.get_string(s) then exit;
              FMemberNames[i] := s;
              FMemberTypes[i] := TTypeCode.Create;
              if not FMemberTypes[i].decode(dec,omap,level+1) then exit;
              FMemberTypes[i].connect(self);
              if not dec.get_short(sh) then exit;
              FMemberVisibility[i] := TVisibility(sh);
            end;
        if not dec.encaps_end(state) then exit;
      end;
    tk_value_box: begin
        if not dec.encaps_begin(state,len) then exit;
        if not dec.get_string(FId) then exit;
        if not dec.get_string(FName) then exit;
        FContent := TTypeCode.Create;
        if not FContent.decode(dec,omap,level+1) then exit;
        FContent.connect(self);
        if not dec.encaps_end(state) then exit;
      end;
    else begin
      if FKind = TCKind(TK_RECURSIVE) then begin
        if not dec.get_long(recurce_pos) then Exit;
        rpos := dec._buffer.RPosition - SizeOf(long);
        recurce_pos := recurce_pos + rpos;

        if recurce_pos < 0 then Exit;
        pair := TLongTCPair(omap[recurce_pos]);
        if pair = nil then
          Exit;
        if pair.second = nil then
          // recursive typecod
          FRecurceDepth := level - pair.first - 1
        else
          // repeated typecode
          copy(TTypeCode(pair.second._this()));
      end
      else begin
        result := false;
        Exit;
      end;
    end;
  end;
  TLongTCPair(omap[buffer_pos]).second := Self;
  result := true;
end;

procedure TTypeCode.encode(const enc: IEncoder; omap: IInterfaceLongMap);
var
  state: TEncapsState;
  i,cnt : integer;
  a: IAny;
  p: ITypeCode;
begin
  if omap = nil then
    omap := TInterfaceLongMap.Create;
  if FKind = TCKind(TK_RECURSIVE) then begin
    p := resolve_recursion();
    if omap.IndexOf(p) = -1 then begin
      p.encode(enc, omap);
      Exit;
    end;
  end;
  // omap maps TypeCode's to the buffer position where they are first
  // encoded. this is needed for turning recursion depths into buffer
  // positions.
  enc.put_ulong(_ulong(FKind));
  omap[Self as ITypeCode] := long(enc.buffer().WPosition) - long(SizeOf(_ulong));
  case FKind of
    tk_null,
    tk_void,
    tk_short,
    tk_long,
    tk_longlong,
    tk_ushort,
    tk_ulong,
    tk_ulonglong,
    tk_float,
    tk_double,
    tk_longdouble,
    tk_boolean,
    tk_char,
    tk_wchar,
    tk_octet,
    tk_any,
    tk_TypeCode,
    tk_Principal:;
    tk_string,tk_wstring: enc.put_ulong(FLen);
    tk_objref,tk_native,tk_abstract_interface: begin
        enc.encaps_begin(state);
        enc.put_string(FId);
        enc.put_string(FName);
        enc.encaps_end(state);
      end;
    tk_except,tk_struct: begin
        enc.encaps_begin(state);
        enc.put_string(FId);
        enc.put_string(FName);
        enc.put_ulong(Length(FMemberNames));
        for i := 0 to Pred(Length(FMemberNames)) do
          begin
            enc.put_string(FMemberNames[i]);
            FMemberTypes[i].encode(enc);
          end;
        enc.encaps_end(state);
      end;
    tk_union : begin
        enc.encaps_begin(state);
        enc.put_string(repoid);
        enc.put_string(FName);
        FDiscriminator.encode(enc,omap);
        enc.put_long(FDefaultIndex);
        enc.put_ulong(member_count);
        for i := 0 to Pred(member_count) do
          begin
            if i = FDefaultIndex then
              begin
                a := TAny.Create();
                a.replace(FDiscriminator);
                a.marshal(enc);
              end
            else
              FLabels[i].marshal(enc);
            enc.put_string(FMemberNames[i]);
            FMemberTypes[i].encode(enc, omap);
          end;
        enc.encaps_end(state);
      end;
    tk_enum : begin
        enc.encaps_begin(state);
        enc.put_string(repoid);
        enc.put_string(FName);
        enc.put_ulong(member_count);
        for i := 0 to Pred(member_count) do
          enc.put_string(member_name(i));
        enc.encaps_end(state);
      end;
    tk_sequence, tk_array: begin
        enc.encaps_begin(state);
        FContent.encode(enc,omap);
        enc.put_long(FLen);
        enc.encaps_end(state);
      end;
    tk_alias : begin
        enc.encaps_begin(state);
        enc.put_string(repoid);
        enc.put_string(FName);
        FContent.encode(enc,omap);
        enc.encaps_end(state);
      end;
    tk_fixed : begin
        enc.put_ushort(FDigits);
        enc.put_short(FScale);
      end;
    tk_value : begin
        enc.encaps_begin(state);
        enc.put_string(repoid);
        enc.put_string(FName);
        enc.put_short(FValueMode);
        if FContent = nil then
          enc.put_long(0)
        else
          FContent.encode(enc,omap);
        cnt := member_count;
        enc.put_ulong(cnt);
        for i := 0 to Pred(cnt) do
          begin
            enc.put_string(member_name(i));
            FMemberTypes[i].encode(enc,omap);
            enc.put_short(smallint(FMemberVisibility[i]));
          end;
        enc.encaps_end(state);
      end;
    tk_value_box : begin
        enc.encaps_begin(state);
        enc.put_string(repoid);
        enc.put_string(FName);
        FContent.encode(enc,omap);
        enc.encaps_end(state);
      end;
    else begin
      if FKind = TCKind(TK_RECURSIVE) then begin
        p := resolve_recursion();
        if omap.IndexOf(p) <> -1 then
          enc.put_long(long(omap.Item[p]) - long(enc.buffer.WPosition));
      end;
    end;
  end;
  omap.Erase(Self as ITypeCode);
end;

function TTypeCode._length(): _ulong;
begin
  result := FLen;
end;

procedure TTypeCode.setlen(bound: _ulong);
begin
  FLen := bound;
end;

function TTypeCode.member_count: _ulong;
begin
  if FMemberNames <> nil then
    result := length(FMemberNames)
  else
    result := 0;
end;

function TTypeCode.member_count_inherited: _ulong;
begin
  if FLen < 0 then
    begin
      FLen := member_count;
      if FContent <> nil then
        FLen := FLen + longint(FContent.member_count_inherited);
    end;
  result := FLen;
end;

function TTypeCode.member_name(index: _ulong): Identifier;
begin
  result := FMemberNames[Index];
end;

function TTypeCode.member_type(index: _ulong): ITypeCode;
begin
  result := (FMemberTypes[index] as ITypeCode).resolve_recursion();
end;

function TTypeCode.member_index(a: IAny): integer;
var
  i : integer;
begin
  if FKind <> tk_union then dorb_throw(BadKind.Create() as IORBException);
  for i := 0 to Pred(Length(FLabels)) do
    if a.eq(FLabels[i]) then
      begin
        result := i;
        exit;
      end;
  result := FDefaultIndex;
end;

function TTypeCode.member_type_inherited(index: _ulong): ITypeCode;
var
  n : _ulong;
  t : ITypeCode;
begin
  n := member_count_inherited;
  if index > n then
    dorb_throw(Bounds.Create() as IORBException);
  index := n - 1 - index;
  t := self;
  while true do
    begin
      n := t.member_count;
      if index < n then
        break;
      index := -n;
      t := t.Content;
    end;
  result := t.member_type(n - 1 - index);
end;

procedure TTypeCode.content(val: ITypeCode);
begin
  FContent := val;
end;

function TTypeCode.content: ITypeCode;
begin
  result := FContent;
end;

function TTypeCode.content_type: ITypeCode;
begin
  result := FContent.resolve_recursion();
end;

class function TTypeCode.create_enum_tc(id, name: AnsiString;
  members: EnumMemberSeq): ITypeCode;
var
  tc: TTypeCode;
  i : integer;
begin
  tc := TTypeCode.Create(tk_enum,id,name);
  if length(members) > 0 then
    begin
      setLength(tc.FMemberNames,length(members));
      for i := 0 to length(members) -1 do
        tc.FMemberNames[i] := members[i];
    end;
  result := tc;
end;

function TTypeCode.type_modifier(): TValueModifier;
begin
  result := FModifier
end;

function TTypeCode.concrete_base_type(): ITypeCode;
begin
  if FKind <> tk_value then
    dorb_throw('Bad kind');
  result := FContent;
end;

function TTypeCode.member_visibility(index: _ulong): TVisibility;
begin
  if FKind <> tk_value then dorb_throw(BadKind.Create() as IORBException);
  if longint(index) >= Length(FMemberVisibility) then dorb_throw(Bounds.Create as IORBException);
  result := FMemberVisibility[index];
end;

class function TTypeCode.create_value_box_tc(id, name: AnsiString; orig: ITypeCode): ITypeCode;
var
  tc: TTypeCode;
begin
  tc := TTypeCode.Create(tk_value_box);
  tc.FId := id;
  tc.FName := name;
  tc.FContent := orig;
  result := tc;
  result.content.connect(result);
end;

class function TTypeCode.create_value_tc(id, name: AnsiString; vmod: TValueModifier; base: ITypeCode; members: ValueMemberSeq): ITypeCode;
var
  tc: TTypeCode;
  i : integer;
begin
  tc := TTypeCode.Create(tk_value);
  tc.FId := id;
  tc.FName := name;
  tc.FModifier := vmod;
  tc.FContent := base;
  //tc.FBaseType := base;
  setLength(tc.FMemberNames,length(members));
  setLength(tc.FMemberTypes,length(members));
  setLength(tc.FMemberVisibility,length(members));
  result := tc;
  for i := 0 to length(members)-1 do
    begin
      tc.FMemberVisibility[i] := members[i].access;
      tc.FMemberNames[i] := members[i].name;
      tc.FMemberTypes[i] := members[i]._type;
      tc.FMemberTypes[i].connect(result);
    end;
  if result.content <> nil then
    result.content.connect(result);
end;

class function TTypeCode.create_array_tc(_type: ITypeCode; length: _ulong): ITypeCode;
var
  tc: TTypeCode;
begin
  tc := TTypeCode.Create(tk_array);
  tc.FLen := length;
  tc.FContent := _type;
  result := tc;
  result.content().connect(result);
end;

class function TTypeCode.create_sequence_tc(_type: ITypeCode;
  bound: _ulong): ITypeCode;
var
  tc: TTypeCode;
begin
  tc := TTypeCode.Create(tk_sequence);
  tc.FLen := bound;
  tc.FContent := _type;
  result := tc;
  result.content().connect(result);
end;

class function TTypeCode.create_recursive_sequence_tc(bound,
  offset: _ulong): ITypeCode;
var
  tc: TTypeCode;
begin
  tc := TTypeCode.Create(tk_sequence);
  tc.FLen := bound;
  tc.FContent := TTypeCode.Create(TCKind(TK_RECURSIVE));
  tc.FContent.recurse_depth(offset);
  result := tc;
  result.content.connect(result);
end;

class function TTypeCode.create_abstract_interface_tc(id,
  name: AnsiString): ITypeCode;
var
  tc: TTypeCode;
begin
  tc := TTypeCode.Create(tk_abstract_interface);
  tc.FId := id;
  tc.FName := name;
  result := tc;
end;

function TTypeCode.is_base_type: Boolean;
var
  tc: ITypeCode;
begin
  tc := self.unalias();
  result := tc.kind in [tk_null,
  tk_boolean,
  tk_char,
  tk_wchar,
  tk_octet,
  tk_short,
  tk_long,
  tk_ushort,
  tk_ulong,
  tk_longlong,
  tk_ulonglong,
  tk_float,
  tk_double,
  tk_longdouble,
  tk_string,
  tk_wstring,
  tk_fixed];
end;

function TTypeCode.default_index: longint;
begin
  if FKind <> tk_union then dorb_throw(BadKind.Create() as IORBException);
  result := FDefaultIndex;
end;

function TTypeCode.discriminator_type(): ITypeCode;
begin
  if FKind <> tk_union then dorb_throw(BadKind.Create() as IORBException);
  result := FDiscriminator;
end;

function TTypeCode.equal(const tc: ITypeCode): Boolean;
var
  i : integer;
  metc, hetc: ITypeCode;
begin
  result := true;
  if (self as ITypeCode) = tc then exit;
  result := false;
  if (FKind = TCKind(TK_RECURSIVE)) or (tc.kind = TCKind(TK_RECURSIVE)) then begin
    if (FKind = TCKind(TK_RECURSIVE)) and (FRecurce_tc = nil) then
      Exit;
    if (tc.kind = TCKind(TK_RECURSIVE)) and (tc.recurce_tc = nil) then
      Exit;
    metc := resolve_recursion();
    hetc := tc.resolve_recursion();
    Result := (metc.kind = hetc.kind) and (metc.id = hetc.id);
    Exit;
  end;
  if kind <> tc.kind then exit;
  case kind of
    tk_string,tk_wstring : result := _length = tc._length;
    tk_fixed : result := (FDigits = tc.fixed_digits) and (FScale = tc.fixed_scale);
    tk_sequence,tk_array : result := (FLen = longint(tc._length)) and FContent.equal(tc.content_type);
    tk_value_box, tk_alias : result := (FId = tc.repoid) and FContent.equal(tc.content_type);
    tk_objref,tk_native,tk_abstract_interface : result := FId = tc.repoid;
    tk_except,tk_struct : if (FID = tc.repoid) and (tc.member_count = member_count) then
      begin
        for i := 0 to pred(member_count) do
          if not member_type(i).equal(tc.member_type(i)) then exit;
        result := true;
      end;
    tk_value : if (FID = tc.repoid) and (tc.member_count = member_count) then
        begin
          for i := 0 to pred(member_count) do
            if not member_type(i).equal(tc.member_type(i)) or
              (member_visibility(i) <> tc.member_visibility(i)) then exit;
          result := true;
        end;
    tk_union : if (FID = tc.repoid) and (tc.member_count = member_count) and
        (tc.default_index = default_index) and (default_index >= 0) and
        discriminator_type.equal(tc.discriminator_type) then
        begin
          for i := 0 to pred(member_count) do
            if not member_type(i).equal(tc.member_type(i)) or
              (member_visibility(i) <> tc.member_visibility(i)) then exit;
          result := true;
        end;
    tk_enum : if (FID = tc.repoid)  and (tc.member_count = member_count) then
      begin
        for i := 0 to pred(member_count) do
          if member_name(i) <> tc.member_name(i) then exit;
        result := true;
      end;
    else  // base type
      result := true;
  end;
end;

function TTypeCode.equivalent(const tc: ITypeCode): Boolean;
var
  t1,t2 : ITypeCode;
  i : integer;
begin
  result := true;
  if (self as ITypeCode) = tc then exit;
  t1 := unalias.resolve_recursion;
  while t1.kind = TK_ALIAS do
    t1 := t1.unalias.resolve_recursion;

  t2 := tc.unalias.resolve_recursion;
  while t2.kind = TK_ALIAS do
    t2 := t2.unalias.resolve_recursion;

  result := false;
  if t1.kind <> t2.kind then exit;

  case t1.kind of
    tk_null,tk_void,tk_short,tk_long,tk_ushort,tk_ulong,tk_float,tk_longlong,tk_ulonglong,
    tk_double,tk_longdouble,tk_boolean,tk_char,tk_octet,tk_any,tk_TypeCode,tk_Principal : begin
         result := true;
         exit;
       end;
    tk_string,tk_wstring : begin
        result := t1._length = t2._length;
        exit;
      end;
    tk_native,tk_abstract_interface,tk_objref : begin
        result := t1.repoid = t2.repoid;
        exit;
      end;
    tk_fixed : begin
        result := t1.fixed_digits = t2.fixed_digits;
        exit;
      end;
    tk_enum : begin
        if t1.member_count <> t2.member_count then exit;
        for i := 0 to Pred(t1.member_count) do
          if t1.member_name(i) <> t2.member_name(i) then exit;
        result := true;
        exit;
      end;
    tk_alias : assert(false);
  end;


  // cache not implemented

  case t1.kind of
    tk_sequence,tk_array : result := (t1._length = t2._length) and
      t1.content_type.equivalent(t2.content_type);
    tk_except,tk_struct : begin
        if t1.member_count <> t2.member_count then exit;
        result := true;
        for i := 0 to pred(t1.member_count) do
          if not t1.member_type(i).equivalent(t2.member_type(i)) then
            begin
              result := false;
              exit;
            end;
      end;
    tk_value : begin
      if (t1.type_modifier <> t2.type_modifier) or
        (t1.member_count <> t2.member_count) then exit;
      result := true;
      for i := 0 to pred(t1.member_count) do
        if not t1.member_type(i).equivalent(t2.member_type(i)) or
          (t1.member_visibility(i) <> t2.member_visibility(i)) then
          begin
            result := false;
            exit;
          end;
    end;
    tk_value_box: result := t1.content.equivalent(t2.content);
    else
      assert(false,'not implemented');
  end;
end;

function TTypeCode.fixed_digits: _ushort;
begin
  if FKind <> tk_fixed then dorb_throw(BadKind.Create() as IORBException);
  result := FDigits;
end;

function TTypeCode.fixed_scale: short;
begin
  if FKind <> tk_fixed then dorb_throw(BadKind.Create() as IORBException);
  result := FScale;
end;

function TTypeCode.repoid: RepositoryId;
begin
  result := FId;
end;

procedure TTypeCode.recurse_depth(depth: long);
begin
  FRecurceDepth := depth;
end;

function TTypeCode.recurce_tc: ITypeCode;
begin
  Result := FRecurce_tc;
end;

function TTypeCode.get_compact_typecode: ITypeCode;
var
  t : TTypeCode;
begin
  t := TTypeCode.Create(self);
  t.strip();
  result := t;
end;

function TTypeCode.id: RepositoryID;
begin
  Result := FId;
end;

procedure TTypeCode.id(const id: RepositoryID);
begin
  FId := id;
end;

function TTypeCode.kind: TCKind;
begin
  Result := FKind;
end;

function TTypeCode.member_label(index: _ulong): IAny;
begin
  if FKind <> tk_union then dorb_throw(BadKind.Create() as IORBException);
  if longint(index) >= Length(FLabels) then dorb_throw(Bounds.Create() as IORBException);
  result := FLabels[index];
end;

procedure TTypeCode.copy(src: TTypeCode);
var
  i : integer;
begin
  FConstant := false;
  FKind := src.FKind;
  FId := src.FId;
  FName := src.FName;
  FDefaultIndex := src.FDefaultIndex;
  FLen := src.FLen;
  FDigits := src.FDigits;
  FScale := src.FScale;
  FRecurceDepth := src.FRecurceDepth;
  FRecurce_tc := src.FRecurce_tc;
  FMemberNames := System.copy(src.FMemberNames);
  FMemberVisibility := System.copy(src.FMemberVisibility);
  FModifier := src.FModifier;
  if src.FContent = nil then
    FContent := nil
  else
    begin
      FContent := TTypeCode.Create(src.FContent);
      FContent.connect(self);
    end;
  if src.FDiscriminator = nil then
    FDiscriminator := nil
  else
    FDiscriminator := TTypeCode.Create(src.FDiscriminator);
  setLength(FMemberTypes,Length(src.FMemberTypes));
  for i := 0 to Pred(Length(src.FMemberTypes)) do
    begin
      FMemberTypes[i] := TTypeCode.Create(src.FMemberTypes[i]);
      FMemberTypes[i].connect(self);
    end;
  setLength(FLabels,Length(src.FLabels));
  for i := 0 to Pred(Length(src.FLabels)) do
    FLabels[i] := TAny.Create_any(src.FLabels[i]);
end;

function TTypeCode.name: Identifier;
begin
  result := FName
end;

function TTypeCode._this: Pointer;
begin
  result := Pointer(self)
end;

procedure TTypeCode.connect(tc: ITypeCode; depth: Integer);
var
  i: Integer;
begin
  (*
   * connect nested recursive types when they are embedded into
   * a new constructed type (parent).
   *)
  if (FKind = TCKind(TK_RECURSIVE)) then begin
    if FRecurce_tc <> nil then
      Exit;
    if (FRecurceDepth = depth) or (FID = tc.repoid) then begin
        FRecurce_tc := tc;
        FRecurceDepth := depth;
    end;
    Exit;
  end;

  if FContent <> nil then
    FContent.connect(tc, depth+1);

  for i := 0 to Length(FMemberTypes) - 1 do
    FMemberTypes[i].connect(tc, depth+1);
end;

procedure TTypeCode.disconnect(tc: ITypeCode);
var
  i: Integer;
begin
  (*
   * disconnect nested recursive types when the enclosing
   * constructed type (parent) is deleted.
   *)
  if tc = nil then
    Exit;

  if (FKind = TCKind(TK_RECURSIVE)) then begin
    if (FRecurce_tc = tc) then begin
        FRecurce_tc := nil;
        if (FID <> '') then
          FRecurceDepth := -1;
    end;
    Exit;
  end;

  if FContent <> nil then
    FContent.disconnect(tc);

  for i := 0 to Length(FMemberTypes) - 1 do
    FMemberTypes[i].disconnect(tc);
end;

procedure TTypeCode.strip;
var
  i : integer;
begin
  FName := '';
  for i := 0 to Pred(Length(FMemberNames)) do
    FMemberNames[i] := '';
  for i := 0 to Pred(Length(FMemberTypes)) do
    FMemberTypes[i].strip;
  if FContent <> nil then
    FContent.strip;
end;

function isdigit(c: AnsiChar): Boolean;
const
  str = '0123456789ABCDEFabcdef';
begin
  result := Pos(Char(c),str) > 0;
end;

function TTypeCode.from_string(s: AnsiString): Boolean;
var
  b: IBuffer;
  i : integer;
  d : IDecoder;
  bo: Octet;
begin
  result := false;
  if length(s) and 1 = 1 then exit;
  b := TBuffer.Create();
  i := 1;
  while i < Length(s) do
    begin
      if not isdigit(s[i]) or not isdigit(s[i+1]) then exit;
      b.put(Octet((byte_from_xdigit(s[i]) shl 4) or (byte_from_xdigit(s[i+1]))));
      inc(i,2);
    end;
  d := TDecoder.Create(b);
  if not d.get_octet(bo) then exit;
  if Byte(bo) <> 0 then
    d.byteorder(LittleEndian)
  else
    d.byteorder(BigEndian);
  result := decode(d);
end;

function TTypeCode.unalias: ITypeCode;
begin
  result := Self;
  while result.kind = tk_alias do
    result := result.content_type;
end;

function TTypeCode.is_object: Boolean;
var
  t : ITypeCode;
  name: AnsiString;
begin
  result := false;
  t := unalias;
  if t.kind = tk_objref then
    begin
      name := t.name;
      result := name = 'Object'
    end;
end;

function TTypeCode.is_any: Boolean;
var
  t : ITypeCode;
begin
  t := unalias;
  result := t.kind = tk_any
end;

class function TTypeCode.create_union_tc(id, name: AnsiString; discr: ITypeCode;
  members: UnionMemberSeq): ITypeCode;
var
  tc: TTypeCode;
  mlen: integer;
  i : integer;
begin
  result := nil;
  //if Length(members) = 0 then dorb_throw(SystemException.Create_type(st_BAD_PARAM) as IORBException);
  tc := TTypeCode.Create(tk_Union);
  tc.FName := name;
  tc.FId := id;
  tc.FDefaultIndex := -1;
  tc.FDiscriminator := discr;
  mlen := Length(members);
  setLength(tc.FMemberTypes,mlen);
  setLength(tc.FLabels,mlen);
  setLength(tc.FMemberNames,mlen);
  result := tc;
  for i := 0 to Pred(mlen) do
    begin
      tc.FMemberNames[i] := members[i].name;
      tc.FMemberTypes[i] := members[i]._type;
      tc.FLabels[i] := members[i]._label;
      tc.FMemberTypes[i].connect(result);
    end;
end;

class function TTypeCode.create_native_tc(id, name: AnsiString): ITypeCode;
begin
  result := TTypeCode.Create(tk_native,id,name);
end;

class function TTypeCode.create_recursive_tc(const id: AnsiString): ITypeCode;
var
  tc: TTypeCode;
begin
  if id = '' then
    dorb_throw(BAD_PARAM.Create());

  tc := TTypeCode.Create(TCKind(TK_RECURSIVE));
  tc.FRecurceDepth := -1;
  tc.FId := id;
  result := tc;
end;

function TTypeCode.to_string: AnsiString;
var
  enc: IEncoder;
  i : integer;
  o: Octet;
begin
  result := '';
  enc := TEncoder.Create();
  if enc.byteorder = BigEndian then
    enc.put_octet(0)
  else
    enc.put_octet(1);
  enc.put_typecode(self);
  setLength(result,enc.buffer.length*2);
  for i := 0 to Pred(enc.buffer.length) do
    begin
      enc.buffer.get(o);
      result[i*2+1] := AnsiChar(octet_to_xdigit(Octet(Byte(o) shr 4)));
      result[i*2+2] := AnsiChar(octet_to_xdigit(Octet(Byte(o) and $F)));
    end;
end;

function TTypeCode.resolve_recursion: ITypeCode;
begin
  if not assigned(FRecurce_tc) then
    result := self
  else
    result := FRecurce_tc;
end;

//*********************************************************************
//  TTypeCodeConst
//*********************************************************************
constructor TTypeCodeConst.Create(const value: AnsiString);
begin
  FStrValue := value;
  FTypecode := nil;
end;

procedure TTypeCodeConst.set_string(const str: AnsiString);
begin
  if FTypeCode = nil then FStrValue := str;
end;

function TTypeCodeConst.typecode: ITypeCode;
begin
  result := nil;
  if FTypeCode = nil then
    begin
      if FStrValue = '' then exit;
      FTypeCode := TTypeCode.Create(FStrValue);
    end;
  result := FTypeCode;
end;

//*********************************************************************
//  TLevelRecord
//*********************************************************************
constructor TLevelRecord.Create(lr: ILevelRecord);
begin
  FLevel := lr.Level;
  FTC := lr.TC;
end;

constructor TLevelRecord.Create(tc: ITypeCode; level: TRecordLevel);
begin
  FLevel := Level;
  FTC := TC;
end;

constructor TLevelRecord.Create(l: TRecordLevel; tc: ITypeCode; n, i,
  x: integer);
begin
  FLevel := l;
  FTC := tc;
  FI := i;
  FLast_I := i - 1;
  FN := n;
  FX := x;
end;

function TLevelRecord.i: integer;
begin
  result := FI;
end;

procedure TLevelRecord.i(val: integer);
begin
  FI := val;
end;

procedure TLevelRecord.last_i(val: integer);
begin
  FLast_I := val;
end;

function TLevelRecord.last_i: integer;
begin
  result := FLast_i
end;

function TLevelRecord.level: TRecordLevel;
begin
  result := FLevel;
end;

function TLevelRecord.n: integer;
begin
  result := FN;
end;

procedure TLevelRecord.x(val: integer);
begin
  FX := val
end;

function TLevelRecord.x: integer;
begin
  result := FX
end;

procedure TLevelRecord.n(val: integer);
begin
  FN := val
end;

function TLevelRecord.tc: ITypeCode;
begin
  result := FTC;
end;

//*********************************************************************
//  TTypeCodeChecker
//*********************************************************************
constructor TTypeCodeChecker.Create(tcc: ITypeCodeChecker);
begin
  FTC := nil;
  FTop := nil;
  FDone := true;
  FLevels := TInterfaceList.Create;
  restart(tcc.top);
end;

constructor TTypeCodeChecker.Create(tc: ITypeCode);
begin
  FLevels := TInterfaceList.Create;
  FTC := nil;
  FTop := nil;
  FDone := true;
  if tc <> nil then restart(tc);
end;

function TTypeCodeChecker.abstract_interface(int: ITypeCode): Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if FTC.kind <> tk_abstract_interface then exit;
  override_tc(int);
  result := true;
end;

function TTypeCodeChecker.arr_begin: Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if FTC.kind <> tk_array then exit;
  advance();
  enter(TLevelRecord.Create(LArray,FTC,FTC._length) as ILevelRecord);
  result := true;
end;

function TTypeCodeChecker.arr_end(unst: Boolean): Boolean;
begin
  result := leave(LArray,unst)
end;

function TTypeCodeChecker.basic(tc: ITypeCode): Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if not FTC.equivalent(tc.unalias) then exit;
  advance();
  if not assigned(level()) then FDone := true;
  result := true;
end;

function TTypeCodeChecker.completed: Boolean;
begin
  result := FDone;
end;

function TTypeCodeChecker.enumeration(len: _ulong): Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if (FTC.kind <> tk_enum) or (FTC.member_count <= len) then exit;
  advance();
  if level() = nil then FDone := true;
  result := true;
end;

function TTypeCodeChecker.except_begin: Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if (FTC.kind <> tk_except) then exit;
  advance();
  enter(TLevelRecord.Create(LExcept,FTC,FTC.member_count) as ILevelRecord);
  result := true;
end;

function TTypeCodeChecker.except_end(unst: Boolean): Boolean;
begin
  result := leave(LExcept,unst);
end;

procedure TTypeCodeChecker.finish;
begin
  FLevels.Clear;
  FDone := true;
  _tc(FTop);
end;

function TTypeCodeChecker.inside(kind: TCKind): Boolean;
var
  rec : ILevelRecord;
begin
  rec := level();
  result := assigned(rec) and (rec.tc.unalias.kind = kind);
end;

function TTypeCodeChecker.level_count: _ulong;
begin
  Result := FLevels.Count;
end;

function TTypeCodeChecker.level_finished: Boolean;
begin
  result := true;
  if FDone then exit;
  if FLevels.Count > 0 then
    with FLevels.Last as ILevelRecord do
      if i >= n then exit;
  result := false;
end;

procedure TTypeCodeChecker.restart(_tc: ITypeCode);
begin
  FLevels.Clear;
  FDone := _tc = nil;
  if FDone then
    FTop := _tc_void
  else
    FTop := _tc;
  Self._tc(FTop);
end;

function TTypeCodeChecker.seq_begin(len: _ulong): Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if (FTC.kind <> tk_sequence) or ((FTC._length > 0) and (FTC._length <> len)) then exit;
  advance();
  enter(TLevelRecord.Create(LSequence,FTC,len) as ILevelRecord);
  result := true;
end;

function TTypeCodeChecker.seq_end(unst: Boolean): Boolean;
begin
  result := leave(LSequence,unst);
end;

function TTypeCodeChecker.struct_begin: Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if FTC.kind <> tk_struct then exit;
  advance();
  enter(TLevelRecord.Create(LStruct,FTC,FTC.member_count) as ILevelRecord);
  result := true;
end;

function TTypeCodeChecker.struct_end(unst: Boolean): Boolean;
begin
  result := leave(LStruct,unst);
end;

function TTypeCodeChecker._tc: ITypeCode;
begin
  next_typecode;
  if FDone then
    result := _tc_void
  else
    result := FTC;
end;

function TTypeCodeChecker.union_begin: Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if FTC.kind <> tk_union then exit;
  advance();
  enter(TLevelRecord.Create(LUnion,FTC,1) as ILevelRecord);
  result := true;
end;

function TTypeCodeChecker.union_end(unst: Boolean): Boolean;
begin
  result := leave(LUnion,unst);
end;

function TTypeCodeChecker.union_selection(ind: integer): Boolean;
var
  rec: ILevelRecord;
begin
  result := false;
  rec := level();
  if not assigned(rec) or (rec.level <> LUnion) or (rec.i > 1) then exit;
  if (FSelIndex >= 0) and (FSelIndex >= longint(rec.tc.member_count)) then exit;
  if FSelIndex < 0 then rec.n(1) else rec.n(2);
  rec.x(FSelIndex);
  result := true;
end;

function TTypeCodeChecker.value_begin(tc: ITypeCode): Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if FTC.kind <> tk_value then exit;
  override_tc(tc);
  advance();
  enter(TLevelRecord.Create(LValue,FTC,FTC.member_count_inherited) as ILevelRecord);
  result := true;
end;

function TTypeCodeChecker.value_end: Boolean;
begin
  result := leave(LValue,true)
end;

function TTypeCodeChecker.valuebox_begin: Boolean;
begin
  result := false;
  if not next_typecode then exit;
  if FTC.kind <> tk_value_box then exit;
  advance();
  enter(TLevelRecord.Create(LValueBox,FTC,1) as ILevelRecord);
  result := true;
end;

function TTypeCodeChecker.valuebox_end: Boolean;
begin
  result := leave(LValueBox,false);
end;

procedure TTypeCodeChecker._tc(_tc: ITypeCode);
begin
  FTC := _tc.unalias;
end;

function TTypeCodeChecker.top: ITypeCode;
begin
  Result := FTop;
end;

function TTypeCodeChecker.advance: Boolean;
var
  rec: ILevelRecord;
begin
  result := false;
  if FDone then exit;
  rec := level();
  if (rec <> nil) and (rec.i >= rec.n) then exit; // no more elements
  result := true;
  if rec = nil then exit; // toplevel
  rec.i(rec.i + 1);
end;

function TTypeCodeChecker.next_typecode: Boolean;
var
  rec: ILevelRecord;
  t : ITypeCode;
begin
  result := false;
  if FDone then exit;
  rec := level;
  if rec = nil then
    begin
      result := true;
      exit;
    end;
  if rec.i >= rec.n then exit; // no more elements
  if rec.i = rec.last_i then // already set
    begin
      result := true;
      exit;
    end;
  case rec.level of
    LArray,LSequence : if rec.i = 0 then
      begin
        t := rec.tc.content_type;
        _tc(t);
      end;
    LValueBox : begin
        t := rec.tc.content_type;
        _tc(t);
      end;
    LStruct,LExcept : begin
        t := rec.tc.member_type(rec.i);
        _tc(t);
      end;
    LUnion : begin
        if rec.i = 0 then
          t := rec.tc.discriminator_type()
        else
          t := rec.tc.member_type(rec.x);
        _tc(t);
      end;
    LValue : begin
        t := rec.tc.member_type_inherited(rec.i);
        _tc(t);
      end;
    else
      assert(false,'not implemented');
  end;
  rec.last_i(rec.i);
  result := true;
end;

function TTypeCodeChecker.level: ILevelRecord;
begin
  result := nil;
  if FLevels.Count > 0 then
    result := FLevels.Last as ILevelRecord;
end;

function TTypeCodeChecker.leave(l: TRecordLevel; sloppy: Boolean): Boolean;
var
  rec: ILevelRecord;
begin
  result := false;
  rec := level();
  if not assigned(rec) or (rec.level <> l) then exit;
  if not sloppy and (rec.i <> rec.n) then exit;
  _tc(rec.tc);
  FLevels.delete(FLevels.count-1);
  if FLevels.Count = 0 then FDone := true;
  result := true;
end;

procedure TTypeCodeChecker.override_tc(t: ITypeCode);
var
  rec : ILevelRecord;
begin
  if t <> nil then
    begin
      rec := level();
      if assigned(rec) then
        rec.last_i(rec.i);
      FTC := t.unalias;
    end;
end;

procedure TTypeCodeChecker.enter(rec: ILevelRecord);
begin
  FLevels.Add(rec);
end;

function CreateTypeCodeConst(const value: AnsiString): ITypeCodeConst;
begin
  result := TTypeCodeConst.Create(value) as ITypeCodeConst;
end;

{$IFDEF LIBRARY}
function _tc_void : ITypeCode;
begin
  result := tc_void
end;

function _tc_null : ITypeCode;
begin
  result := _tc_null
end;

function _tc_short : ITypeCode;
begin
  result := tc_short
end;

function _tc_long : ITypeCode;
begin
  result := tc_long
end;

function _tc_ushort : ITypeCode;
begin
  result := tc_ushort
end;

function _tc_ulong : ITypeCode;
begin
  result := tc_ulong
end;

function _tc_float : ITypeCode;
begin
  result := tc_float
end;

function _tc_double : ITypeCode;
begin
  result := tc_double
end;

function _tc_boolean : ITypeCode;
begin
  result := tc_boolean
end;

function _tc_char : ITypeCode;
begin
  result := tc_char
end;

function _tc_octet : ITypeCode;
begin
  result := tc_octet
end;

function _tc_any : ITypeCode;
begin
  result := tc_any
end;

function _tc_TypeCode : ITypeCode;
begin
  result := tc_TypeCode
end;

function _tc_Principal : ITypeCode;
begin
  result := tc_Principal
end;

function _tc_string : ITypeCode;
begin
  result := tc_string
end;

function _tc_objref : ITypeCode;
begin
  result := tc_objref
end;

function _tc_longlong : ITypeCode;
begin
  result := tc_longlong
end;

function _tc_ulonglong : ITypeCode;
begin
  result := tc_ulonglong
end;

function _tc_longdouble : ITypeCode;
begin
  result := tc_longdouble
end;

function _tc_wchar : ITypeCode;
begin
  result := tc_wchar
end;

function _tc_ConstantDef : ITypeCode;
begin
  result := tc_ConstantDef
end;

function _tc_InterfaceDef : ITypeCode;
begin
  result := tc_InterfaceDef
end;

function _tc_ValueBase : ITypeCode;
begin
  result := tc_ValueBase
end;

function _tc_wstring : ITypeCode;
begin
  result := tc_wstring
end;

function _tc_CompletionStatus : ITypeCode;
begin
  result := tc_CompletionStatus;
end;

function _tc_SystemException: TSystemExceptionTypeCodeList;
begin
  result := tc_SystemException;
end;

function _tc_AbstractBase : ITypeCode;
begin
  result := tc_AbstractBase;
end;

exports
  CreateTypeCodeConst,
  _tc_void,
  _tc_null,
  _tc_short,
  _tc_long,
  _tc_ushort,
  _tc_ulong,
  _tc_float,
  _tc_double,
  _tc_boolean,
  _tc_char,
  _tc_octet,
  _tc_any,
  _tc_TypeCode,
  _tc_Principal,
  _tc_string,
  _tc_objref,
  _tc_longlong,
  _tc_ulonglong,
  _tc_longdouble,
  _tc_wchar,
  _tc_wstring,
  _tc_ValueBase,
  _tc_ConstantDef,
  _tc_InterfaceDef,
  _tc_CompletionStatus,
  _tc_SystemException,
  _tc_AbstractBase;
initialization
  tc_void := TTypeCode.Create(tk_void);
  tc_short := TTypeCode.Create(tk_short);
  tc_long := TTypeCode.Create(tk_long);
  tc_ushort := TTypeCode.Create(tk_ushort);
  tc_ulong := TTypeCode.Create(tk_ulong);
  tc_float := TTypeCode.Create(tk_float);
  tc_double := TTypeCode.Create(tk_double);
  tc_boolean := TTypeCode.Create(tk_boolean);
  tc_char := TTypeCode.Create(tk_char);
  tc_octet := TTypeCode.Create(tk_octet);
  tc_any := TTypeCode.Create(tk_any);
  tc_TypeCode := TTypeCode.Create(tk_TypeCode);
  tc_Principal := TTypeCode.Create(tk_Principal);
  tc_string := TTypeCode.Create(tk_string);
  tc_objref := TTypeCode.Create(tk_objref,'IDL:omg.org/CORBA/Object:1.0','Object');
  tc_longlong := TTypeCode.Create(tk_longlong);
  tc_ulonglong := TTypeCode.Create(tk_ulonglong);
  tc_longdouble := TTypeCode.Create(tk_longdouble);
  tc_wchar := TTypeCode.Create(tk_wchar);
  tc_wstring := TTypeCode.Create(tk_wstring);
  tc_ValueBase := TTypeCode.create_value_tc('IDL:omg.org/CORBA/ValueBase:1.0',
    'ValueBase',
    VM_NONE,
    nil,
    nil);
  tc_ConstantDef := TTypeCode.Create('010000000e0000003c000000010000002200000049444c3a6f6d672e6f72672f434f5242412f436f6e7374616e744465663a312e300000000c000000436f6e7374616e7444656600');
  tc_InterfaceDef := TTypeCode.Create('01000000150000009c000000010000002600000049444c3a6f6d672e6f72'+
    '672f434f5242412f496e746572666163654465665365713a312e30000000'+
    '10000000496e746572666163654465665365710013000000500000000100'+
    '00000e0000003d000000010000002300000049444c3a6f6d672e6f72672f'+
    '434f5242412f496e746572666163654465663a312e3000000d000000496e'+
    '746572666163654465660000000000000000');
  tc_AbstractBase := TTypeCode.create_abstract_interface_tc('IDL:omg.org/CORBA/AbstractBase:1.0', 'AbstractBase');
  CreateSystemExceptionTC;
{$ELSE}
initialization
  _tc_void := TTypeCode.Create(tk_void);
  _tc_null := TTypeCode.Create(tk_null);
  _tc_short := TTypeCode.Create(tk_short);
  _tc_long := TTypeCode.Create(tk_long);
  _tc_ushort := TTypeCode.Create(tk_ushort);
  _tc_ulong := TTypeCode.Create(tk_ulong);
  _tc_float := TTypeCode.Create(tk_float);
  _tc_double := TTypeCode.Create(tk_double);
  _tc_boolean := TTypeCode.Create(tk_boolean);
  _tc_char := TTypeCode.Create(tk_char);
  _tc_octet := TTypeCode.Create(tk_octet);
  _tc_any := TTypeCode.Create(tk_any);
  _tc_TypeCode := TTypeCode.Create(tk_TypeCode);
  _tc_Principal := TTypeCode.Create(tk_Principal);
  _tc_string := TTypeCode.Create(tk_string);
  _tc_objref := TTypeCode.Create(tk_objref,'IDL:omg.org/CORBA/Object:1.0','Object');
  _tc_longlong := TTypeCode.Create(tk_longlong);
  _tc_ulonglong := TTypeCode.Create(tk_ulonglong);
  _tc_longdouble := TTypeCode.Create(tk_longdouble);
  _tc_wchar := TTypeCode.Create(tk_wchar);
  _tc_wstring := TTypeCode.Create(tk_wstring);
  _tc_ValueBase := TTypeCode.create_value_tc('IDL:omg.org/CORBA/ValueBase:1.0',
    'ValueBase',
    VM_NONE,
    nil,
    nil);
  _tc_ConstantDef := TTypeCode.Create('010000000e0000003c000000010000002200000049444c3a6f6d672e6f72672f434f5242412f436f6e7374616e744465663a312e300000000c000000436f6e7374616e7444656600');
  _tc_InterfaceDef := TTypeCode.Create('01000000150000009c000000010000002600000049444c3a6f6d672e6f72'+
    '672f434f5242412f496e746572666163654465665365713a312e30000000'+
    '10000000496e746572666163654465665365710013000000500000000100'+
    '00000e0000003d000000010000002300000049444c3a6f6d672e6f72672f'+
    '434f5242412f496e746572666163654465663a312e3000000d000000496e'+
    '746572666163654465660000000000000000');
  _tc_AbstractBase := TTypeCode.create_abstract_interface_tc('IDL:omg.org/CORBA/AbstractBase:1.0', 'AbstractBase');
  CreateSystemExceptionTC;
{$ENDIF}
{$ELSE}
  function _tc_void : ITypeCode; external MTDORB_Library_Name
  function _tc_null : ITypeCode; external MTDORB_Library_Name
  function _tc_short : ITypeCode; external MTDORB_Library_Name
  function _tc_long : ITypeCode; external MTDORB_Library_Name
  function _tc_ushort : ITypeCode; external MTDORB_Library_Name
  function _tc_ulong : ITypeCode; external MTDORB_Library_Name
  function _tc_float : ITypeCode; external MTDORB_Library_Name
  function _tc_double : ITypeCode; external MTDORB_Library_Name
  function _tc_boolean : ITypeCode; external MTDORB_Library_Name
  function _tc_char : ITypeCode; external MTDORB_Library_Name
  function _tc_octet : ITypeCode; external MTDORB_Library_Name
  function _tc_any : ITypeCode; external MTDORB_Library_Name
  function _tc_TypeCode : ITypeCode; external MTDORB_Library_Name
  function _tc_Principal : ITypeCode; external MTDORB_Library_Name
  function _tc_string : ITypeCode; external MTDORB_Library_Name
  function _tc_objref : ITypeCode; external MTDORB_Library_Name
  function _tc_longlong : ITypeCode; external MTDORB_Library_Name
  function _tc_ulonglong : ITypeCode; external MTDORB_Library_Name
  function _tc_longdouble : ITypeCode; external MTDORB_Library_Name
  function _tc_wchar : ITypeCode; external MTDORB_Library_Name
  function _tc_ConstantDef : ITypeCode; external MTDORB_Library_Name
  function _tc_InterfaceDef : ITypeCode; external MTDORB_Library_Name
  function _tc_ValueBase : ITypeCode; external MTDORB_Library_Name
  function _tc_wstring : ITypeCode; external MTDORB_Library_Name
  function CreateTypeCodeConst(const value: string = ''): ITypeCodeConst; external MTDORB_Library_Name
  function _tc_CompletionStatus : ITypeCode; external MTDORB_Library_Name
  function _tc_SystemException : TSystemExceptionTypeCodeList; external MTDORB_Library_Name
  function _tc_AbstractBase : ITypeCode; external MTDORB_Library_Name
implementation
{$ENDIF}
end.
