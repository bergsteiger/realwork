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
unit code_int;

interface

uses
  orbtypes,SysUtils,Classes,{$IFDEF WIN32}windows,winsock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF},
  map_int;

type

  IAny = interface;

  ITypeCode = interface;

  Pair = record
    first: longint;
    second: ITypeCode;
  end;

  PosTC = record
    first : longint;
    second : Pair;
    less : longint;
  end;

  TCPos = record
    first: ITypeCode;
    second: longint;
    less : ITypeCode;
  end;

  SpecialCS = (_SpecialMin, NativeCS, NativeWCS, FallbackCS, FallbackWCS, DefaultCS, DefaultWCS, _SpecialMax);

  MapPosTC = array of PosTC;
  MapTCPos = array of TCPos;

  IEncoder = interface;
  IDecoder = interface;
  IBuffer = interface;

  ICodeset = interface
  ['{9092E518-6E8C-479A-A251-37AF81B5A085}']
    function id(): CodesetID;
    function codepoint_size(): _ushort;
    function max_codepoints(): _ushort;
  end;

  ICodesetCoder = interface
  ['{0666B0E3-4B68-40B3-8CF3-9673F651661B}']
    function isok: boolean;
    { Decode }
    function get_char(const dec: IDecoder; var o : AnsiChar) : Boolean;
    function get_chars(const dec: IDecoder; var buffer; size: _ulong) : Boolean;
    function get_string(const dec: IDecoder; var s : AnsiString) : Boolean;
    function get_wchar(const dec: IDecoder; var o : WideChar) : Boolean;
    function get_wchars(const dec: IDecoder; var buffer; size: _ulong) : Boolean;
    function get_wstring(const dec: IDecoder; var s : WideString) : Boolean;
    { Encode }
    procedure put_char(const enc: IEncoder; c : AnsiChar);
    procedure put_chars(const enc: IEncoder; const arr;const len: _ulong);
    procedure put_string(const enc: IEncoder; const str: AnsiString);
    procedure put_wchar(const enc: IEncoder; c : WideChar);
    procedure put_wchars(const enc: IEncoder; const arr;const len: _ulong);
    procedure put_wstring(const enc: IEncoder; const str: WideString);
  end;

  ICodesetConverter = interface
  ['{5EB96532-A725-43A0-B6EC-A716BDC68F14}']
    function encode_a(const from: AnsiString; const len: long; const _to: IBuffer; const terminate: boolean = true): long;
    function encode_w(const from: WideString; const len: long; const _to: IBuffer; const terminate: boolean = true): long;
    function decode(const from: IBuffer; const len: long; var _to: AnsiString; const terminate: boolean = true): long; overload;
    function decode(const from: IBuffer; const len: long; var _to: WideString; const terminate: boolean = true): long; overload;
  end;

  IPrincipal = interface
  ['{61252F74-4D23-11d4-9D27-204C4F4F5020}']
    procedure encode(const enc: IEncoder);
    function decode(const dec: IDecoder): Boolean;
    function get_property(const prop_name: string): IAny;
  end;

  IBuffer = interface
  ['{094BE471-218A-11d4-9CCE-204C4F4F5020}']
    function _buffer(): Pointer;
    function data(): PByteLargeArray;
    function get(var o: Octet): Boolean; overload;
    function get(var buffer; size : _ulong): Boolean; overload;
    function get1(var buffer): Boolean;
    function get2(var buffer): Boolean;
    function get4(var buffer): Boolean;
    function get8(var buffer): Boolean;
    function get16(var buffer): Boolean;
    function getRAlignBase : _ulong;
    function getWAlignBase : _ulong;
    function length(): _ulong;
    procedure put(o : Octet); overload;
    procedure put(const buffer;size: _ulong); overload;
    procedure put16(const Buffer);
    procedure put8(const Buffer);
    procedure put4(const Buffer);
    procedure put2(const Buffer);
    procedure put1(const Buffer);
    procedure reset();
    procedure resize(size: _ulong);
    function _size(): _ulong;
    function RPosition : _ulong;
    function RseekFromBegin(pos: _ulong): Boolean;
    function RseekFromCurrent(pos: long): Boolean;
    function peek(var buffer; size: _ulong): boolean;
    procedure setRAlignBase(val: _ulong);
    procedure setWAlignBase(val : _ulong);
    function setRAlign(modulo: _ulong): boolean;
    procedure setWAlign(modulo : _ulong);
    function WseekFromBegin(pos: _ulong): Boolean;
    function WseekFromCurrent(pos: long): Boolean;
    function WPosition : _ulong;
    function WData(): PByteLargeArray;
  end;

  IValueState = interface
  ['{61252F50-4D23-11d4-9D27-204C4F4F5020}']
    function get_chunk_level: longint;
    procedure set_chunk_level(val: integer);
    function get_nesting_level: longint;
    procedure set_nesting_level(val: integer);
    function get_tag_pos: longint;
    procedure set_tag_pos(val: integer);
    property chunk_level: longint read get_chunk_level write set_chunk_level;
    property nesting_level: longint read get_nesting_level write set_nesting_level;
    property tag_pos: longint read get_tag_pos write set_tag_pos;
    function visited: IInterfaceLongMap;
  end;

  IDecoderValueState = interface
  ['{61252F51-4D23-11d4-9D27-204C4F4F5020}']
    function copy(): IDecoderValueState;
    function get_chunk_level: longint;
    procedure set_chunk_level(val: integer);
    function get_data_nesting_level: longint;
    procedure set_data_nesting_level(val: integer);
    function get_nesting_level: longint;
    procedure set_nesting_level(val: integer);
    function get_saved_pos: longint;
    procedure reset();
    procedure set_saved_pos(val: integer);
    property chunk_level: longint read get_chunk_level write set_chunk_level;
    property nesting_level: longint read get_nesting_level write set_nesting_level;
    property saved_pos: longint read get_saved_pos write set_saved_pos;
    property data_nesting_level: longint read get_data_nesting_level write set_data_nesting_level;
  end;

  IDecoderValueStates = interface
  ['{61252F52-4D23-11d4-9D27-204C4F4F5020}']
    function get_current: IDecoderValueState;
    procedure set_current(val: IDecoderValueState);
    {** list of  IDecoderValueState}
    function visited: ILongInterfaceMap;
    {** list of IValueBase}
    function skipped: ILongInterfaceMap;
    property current : IDecoderValueState read get_current write set_current;
  end;

  IDecoder = interface(IUnknown)
  ['{61252F53-4D23-11d4-9D27-204C4F4F5020}']
    function _buffer : IBuffer; overload;
    procedure _buffer(buf: IBuffer); overload;
    procedure byteorder(ord: TByteOrder); overload;
    function byteorder: TByteOrder; overload;
    function clone(buf: IBuffer = nil; conv : ICodesetCoder = nil): IDecoder;
    function encaps_begin(var enc: TEncapsState; var len : _ulong): Boolean;
    function encaps_end(enc: TEncapsState): Boolean;
    function except_begin(var repoid: RepositoryId): Boolean;
    function except_end(): Boolean;
    function get_double(var d :  double) : Boolean;
    function get_longdouble(var d : longdouble) : Boolean;
    function get_float(var f :  float) : Boolean;
    function get_octet(var o : Octet) : Boolean;
    function get_boolean(var val: boolean): Boolean;
    function get_char(var o : AnsiChar) : Boolean;
    function get_chars(var buffer; size: _ulong) : Boolean;
    function get_wchar(var wc : WideChar) : Boolean;
    function get_wchars(var buffer; size: _ulong) : Boolean;
    function get_octets(var buffer; size: _ulong) : Boolean;
    function get_principal(const pr: IPrincipal) : Boolean;
    function get_any(var a: IAny): Boolean;
    function get_ulong(var l :  _ulong) : Boolean;
    function get_ulonglong(var ll :  _ulonglong) : Boolean;
    function get_long(var l :  longint) : Boolean;
    function get_longlong(var ll :  longlong) : Boolean;
    function get_short(var s :  short) : Boolean;
    function get_ushort(var s :  _ushort) : Boolean;
    function get_string(var s : AnsiString) : Boolean;
    function get_wstring(var s : WideString) : Boolean;
    function seq_begin(var l : _ulong): boolean;
    function seq_end(): boolean;
    procedure set_converter(conv : ICodesetCoder);
    function get_converter(): ICodesetCoder;
    function value_begin(out url: AnsiString; const repoids: TStrings; out vid: longint; out is_ref: Boolean): Boolean;
    function value_end(finished_value_id: longint): Boolean;
    function valuestates(): IDecoderValueStates;
    function max_alignment(): _ulong;
  end;

  IEncoder = interface
  ['{61252F54-4D23-11d4-9D27-204C4F4F5020}']
    function clone(buf: IBuffer = nil; conv : ICodesetCoder = nil): IEncoder;
    function buffer(): IBuffer;  overload;
    procedure buffer(buf: IBuffer); overload;
    procedure byteorder(val: TByteOrder); overload;
    function byteorder(): TByteOrder; overload;
    procedure encaps_begin(var enc: TEncapsState);
    procedure encaps_end(enc: TEncapsState);
    procedure except_begin(const repoid: RepositoryId);
    procedure except_end();
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
    procedure put_typecode(const tc: ITypeCode);
    procedure put_ulong(u: _ulong);
    procedure put_ulonglong(u: _ulonglong);
    procedure put_long(u: longint);
    procedure put_longlong(l: longlong);
    procedure put_longdouble(l: longdouble);
    procedure set_converter(conv : ICodesetCoder);
    function get_converter(): ICodesetCoder;
    procedure seq_begin(len: _ulong);
    procedure seq_end();
    function valuestate(): IValueState;
    procedure value_begin(const url: AnsiString; const repoids: TStrings; chunked: Boolean; out value_id: longint);
    procedure value_end(value_id: longint);
    procedure value_ref(vid: longint);
    function max_alignment(): _ulong;
  end;

  ITypeCode = interface
  ['{61252F55-4D23-11d4-9D27-204C4F4F5020}']
    function _length: _ulong;
    function repoid: RepositoryId;
    function concrete_base_type(): ITypeCode;
    function content_type: ITypeCode;
    function default_index: longint;
    function discriminator_type(): ITypeCode;
    function equal(const tc: ITypeCode): Boolean;
    function equivalent(const tc: ITypeCode): Boolean;
    function fixed_digits: _ushort;
    function fixed_scale: short;
    function get_compact_typecode: ITypeCode;
    function id: RepositoryID; overload;
    function kind: TCKind;
    function name: Identifier;
    function member_count: _ulong;
    function member_count_inherited: _ulong;
    function member_name(index: _ulong): Identifier;
    function member_type(index: _ulong): ITypeCode;
    function member_type_inherited(index: _ulong): ITypeCode;
    function member_label(index: _ulong): IAny;
    function member_index(a: IAny): integer;
    function member_visibility(index: _ulong): TVisibility;
    function resolve_recursion: ITypeCode;
    function type_modifier: TValueModifier;
    // DORB extension
    function decode(const dec: IDecoder; omap: ILongObjectMap = nil; level: integer = 0): Boolean;
    procedure encode(const enc: IEncoder; omap: IInterfaceLongMap = nil);
    procedure setlen(bound: _ulong);
    function is_base_type(): Boolean;
    function _this: Pointer;
    procedure connect(tc: ITypeCode; depth: longint = 0);
    procedure disconnect(tc: ITypeCode);
    procedure strip();
    function unalias(): ITypeCode;
    function is_object(): Boolean;
    function is_any(): Boolean;
    function to_string: AnsiString;
    function content: ITypeCode;
    function recurce_tc: ITypeCode;
    procedure recurse_depth(depth: long);
    procedure id(const id: RepositoryID); overload;
  end;

  ITypecodeChecker = interface
  ['{5931B251-D43E-11d4-9E17-204C4F4F5020}']
    function _tc: ITypeCode;
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
    procedure restart(tc: ITypeCode = nil);
    function level_count: _ulong;
  end;

  IStaticTypeInfo = interface
  ['{61252F56-4D23-11d4-9D27-204C4F4F5020}']
    function demarshal(dec: IDecoder; const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode;
    procedure _create(var addr: Pointer);
    procedure _free(var addr: Pointer);
    procedure _assign(dst,src: Pointer);
    function copy(src: Pointer): Pointer;
  end;

  IStaticAny = interface
  ['{094BE484-218A-11d4-9CCE-204C4F4F5020}']
    function demarshal(dec: IDecoder): Boolean;
    function get_flags(): _ulong;
    function marshal(enc: IEncoder): Boolean;
    procedure set_flags(val: _ulong);
    function value(): Pointer; overload;
    procedure value(const info: IStaticTypeInfo;const addr : Pointer = nil; free : Boolean = false); overload;
    function _type(): IStaticTypeInfo;
    procedure _assign(const val: IStaticAny);
  end;

  ITypeCodeConst = interface
  ['{75F61B51-CB59-11d4-9E0D-204C4F4F5020}']
    function typecode : ITypeCode;
    procedure set_string(const str: AnsiString);
  end;

  IAny = interface
  ['{094BE472-218A-11d4-9CCE-204C4F4F5020}']
    function copy_any(const a: IAny): Boolean;
    procedure copy(const src: IAny);
    function __tc: ITypeCode;
    function _enc: IEncoder;
    function _dec: IDecoder;
    function decode(const dec: IDecoder): Boolean;
    function demarshal(const tc: ITypeCode; const dec: IDecoder): Boolean;
    procedure encode(const enc: IEncoder);
    function marshal(const enc: IEncoder): Boolean;
    function from_static_any(const a: IStaticAny): Boolean;
    function to_static_any(const a: IStaticAny): Boolean;
    function get_type: ITypeCode;
    procedure set_type(const value: ITypeCode);
    function any_get(const a: IAny): Boolean;
    function eq(const a: IAny): Boolean;

    function get_any(out val: IAny): Boolean;
    function get_boolean(out val: boolean): Boolean;
    function get_char(out val: AnsiChar): Boolean;
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

    function to_any(out val: IAny): Boolean;
    function to_boolean(out val: boolean): Boolean;
    function to_char(out val: AnsiChar): Boolean;
    function to_double(out val: double): Boolean;
    function to_float(out val: float): Boolean;
    function to_long(out val: longint): Boolean;
    function to_longlong(out val: longlong): Boolean;
    function to_octet(out val: octet): Boolean;
    {** val must be IORBObject }
    function to_object(out val: IUnknown): Boolean;
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

    function put_any(val: IAny): Boolean;
    function put_boolean(val: boolean): Boolean;
    function put_char(val: AnsiChar): Boolean;
    function put_double(val: double): Boolean;
    function put_float(val: float): Boolean;
    function put_long(val: longint): Boolean;
    function put_longlong(val: longlong): Boolean;
    function put_octet(val: octet): Boolean;
    {** val must be IORBObject }
    function put_object(val: IUnknown; const name: AnsiString = ''): Boolean;
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

    function enum_put(val: _ulong): Boolean;
    function enum_get(out val: _ulong): Boolean;

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

    function get_variant(): variant;
    procedure put_variant(const Value: Variant);
    function checker : ITypecodeChecker;
    procedure prepare_read;
    procedure prepare_write;
    procedure rewind;
    procedure reset;
    procedure replace(tc: ITypeCode; value: Pointer = nil);
  end;

  AnySeq = array of IAny;
  IAny_seq = AnySeq;
  TAnySeq = AnySeq;

  TParameter = record
    argument: IAny;
    mode: ParameterMode;
  end;

  TParameterList = array of TParameter;

  TExceptionList = array of ITypeCode;

  TSystemExceptionTypeCodeList = array [SYSEXC_TYPES] of ITypeCode;
  
implementation

end.
