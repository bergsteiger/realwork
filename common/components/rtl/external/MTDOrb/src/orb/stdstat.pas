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
unit stdstat;

interface

uses
  orbtypes, code_int, SysUtils;

type
  TSystemExceptionStaticTypeInfoList = array [SYSEXC_TYPES] of IStaticTypeInfo;

  TAbstractStat = class(TInterfacedObject)
  protected
    procedure _assign(dst,src: Pointer); virtual;
    function copy(src: Pointer): Pointer;
    function typecode(): ITypeCode; virtual;
    procedure _create(var val: Pointer); virtual;
  end;

{$IFNDEF USELIB}

  TStatULong = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatLong = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatFloat = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatDouble = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatLongDouble = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatBoolean = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatObject = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatAny = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatString = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatWideString = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatUShort = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatShort = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatChar = class(TAbstractStat,IStaticTypeInfo)
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    procedure _assign(dst,src: Pointer); override;
  end;

  TStatWideChar = class(TAbstractStat,IStaticTypeInfo)
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    procedure _assign(dst,src: Pointer); override;
  end;

  TStatOctet = class(TAbstractStat,IStaticTypeInfo)
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    procedure _assign(dst,src: Pointer); override;
  end;

  TStatTypeCode = class(TAbstractStat,IStaticTypeInfo)
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    procedure _assign(dst,src: Pointer); override;
  end;

  TStatPrincipal = class(TAbstractStat,IStaticTypeInfo)
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    procedure _assign(dst,src: Pointer); override;
  end;

  TStatLongLong = class(TStatUlong,IStaticTypeInfo)
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatULongLong = class(TStatLongLong);

  TStatValueBase = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  TStatSystemException = class(TAbstractStat,IStaticTypeInfo)
    FExceptionType: SYSEXC_TYPES;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    procedure _assign(dst,src: Pointer); override;
  public
    constructor Create(ExceptionType: SYSEXC_TYPES);
  end;

  TStatAbstractBase = class(TAbstractStat,IStaticTypeInfo)
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode; override;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

var
{$IFDEF LIBRARY}
  _stat_long : IStaticTypeInfo;
  _stat_ulong : IStaticTypeInfo;
  _stat_longlong : IStaticTypeInfo;
  _stat_ulonglong : IStaticTypeInfo;
  _stat_float : IStaticTypeInfo;
  _stat_double : IStaticTypeInfo;
  _stat_longdouble : IStaticTypeInfo;
  _stat_Object : IStaticTypeInfo;
  _stat_Any : IStaticTypeInfo;
  _stat_String : IStaticTypeInfo;
  _stat_WideString : IStaticTypeInfo;
  _stat_Boolean : IStaticTypeInfo;
  _stat_ushort : IStaticTypeInfo;
  _stat_short : IStaticTypeInfo;
  _stat_char : IStaticTypeInfo;
  _stat_octet : IStaticTypeInfo;
  _stat_widechar : IStaticTypeInfo;
  _stat_typecode : IStaticTypeInfo;
  _stat_principal : IStaticTypeInfo;
  _stat_ValueBase : IStaticTypeInfo;
  _stat_SystemException : TSystemExceptionStaticTypeInfoList;
  _stat_AbstractBase : IStaticTypeInfo;

  function stat_long : IStaticTypeInfo;
  function stat_ulong : IStaticTypeInfo;
  function stat_longlong : IStaticTypeInfo;
  function stat_ulonglong : IStaticTypeInfo;
  function stat_float : IStaticTypeInfo;
  function stat_double : IStaticTypeInfo;
  function stat_longdouble : IStaticTypeInfo;
  function stat_Object : IStaticTypeInfo;
  function stat_Any : IStaticTypeInfo;
  function stat_String : IStaticTypeInfo;
  function stat_WideString : IStaticTypeInfo;
  function stat_Boolean : IStaticTypeInfo;
  function stat_ushort : IStaticTypeInfo;
  function stat_short : IStaticTypeInfo;
  function stat_char : IStaticTypeInfo;
  function stat_widechar : IStaticTypeInfo;
  function stat_octet : IStaticTypeInfo;
  function stat_typecode : IStaticTypeInfo;
  function stat_principal : IStaticTypeInfo;
  function stat_ValueBase : IStaticTypeInfo;
  function stat_SystemException : TSystemExceptionStaticTypeInfoList;
  function stat_AbstractBase : IStaticTypeInfo;
{$ELSE}
  stat_long : IStaticTypeInfo;
  stat_ulong : IStaticTypeInfo;
  stat_longlong : IStaticTypeInfo;
  stat_ulonglong : IStaticTypeInfo;
  stat_float : IStaticTypeInfo;
  stat_double : IStaticTypeInfo;
  stat_longdouble : IStaticTypeInfo;
  stat_Object : IStaticTypeInfo;
  stat_Any : IStaticTypeInfo;
  stat_String : IStaticTypeInfo;
  stat_WideString : IStaticTypeInfo;
  stat_Boolean : IStaticTypeInfo;
  stat_ushort : IStaticTypeInfo;
  stat_short : IStaticTypeInfo;
  stat_char : IStaticTypeInfo;
  stat_widechar : IStaticTypeInfo;
  stat_octet : IStaticTypeInfo;
  stat_typecode : IStaticTypeInfo;
  stat_principal : IStaticTypeInfo;
  stat_ValueBase : IStaticTypeInfo;
  stat_SystemException: array [SYSEXC_TYPES] of IStaticTypeInfo;
  stat_AbstractBase : IStaticTypeInfo;
{$ENDIF}
{$ELSE}
  function stat_long : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_ulong : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_longlong : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_ulonglong : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_float : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_double : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_longdouble : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_Object : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_Any : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_String : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_WideString : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_Boolean : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_ushort : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_short : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_char : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_widechar : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_octet : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_typecode : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_principal : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_ValueBase : IStaticTypeInfo; external MTDORB_Library_Name
  function stat_SystemException : TSystemExceptionStaticTypeInfoList; external MTDORB_Library_Name
  function stat_AbstractBase : IStaticTypeInfo; external MTDORB_Library_Name
{$ENDIF}

implementation


uses
  ior,iior_int,orb,orb_int,tcode,any,transp, value_int, value, except_int,
  exceptions;

{$IFNDEF USELIB}
procedure CreateStatSystemException;
var
  i: SYSEXC_TYPES;
begin
  for i := Low(SYSEXC_TYPES) to High(SYSEXC_TYPES) do
    {$IFDEF LIBRARY}_stat_SystemException[i]{$ELSE}stat_SystemException[i]{$ENDIF} := TStatSystemException.Create(i);
end;
{$ENDIF}

//*********************************************************************
// TAbstractStat
//*********************************************************************
procedure TAbstractStat._create(var val: Pointer);
begin
  assert(false,'not implemented');
end;

procedure TAbstractStat._assign(dst,src: Pointer);
begin
  assert(false,'not implemented');
end;

function TAbstractStat.copy(src: Pointer): Pointer;
begin
  if result <> nil then
    _assign(result,src)
  else
  _create(result);
  _assign(result,src);
end;

function TAbstractStat.typecode(): ITypeCode;
begin
  //assert(false,'not implemented');
  result := nil;
end;

{$IFNDEF USELIB}

//**************************************************************************
// TStatULong
//**************************************************************************
procedure TStatULong._create(var addr: Pointer);
begin
  addr := AllocMem(sizeof(_ulong))
end;

procedure TStatULong._free(var addr: Pointer);
begin
  FreeMem(addr);
end;

function TStatULong.demarshal(dec: IDecoder; const addr : Pointer): Boolean;
begin
  result := dec.get_ulong(_ulong(addr^));
end;

procedure TStatULong.marshal(enc: IEncoder; const addr : Pointer);
begin
  enc.put_ulong(_ulong(addr^));
end;

function TStatULong.typecode(): ITypeCode;
begin
  result := _tc_ulong;
end;

procedure TStatULong._assign(dst, src: Pointer);
begin
  _ulong(dst^) := _ulong(src^)
end;


//**************************************************************************
// TStatULong
//**************************************************************************
procedure TStatLong._assign(dst, src: Pointer);
begin
  long(dst^) := long(src^);
end;

procedure TStatLong._create(var addr: Pointer);
begin
  addr := AllocMem(sizeof(long))
end;

procedure TStatLong._free(var addr: Pointer);
begin
  FreeMem(addr);
end;

function TStatLong.demarshal(dec: IDecoder; const addr : Pointer): Boolean;
begin
  result := dec.get_long(long(addr^));
end;

procedure TStatLong.marshal(enc: IEncoder; const addr : Pointer);
begin
  enc.put_long(long(addr^));
end;

function TStatLong.typecode(): ITypeCode;
begin
  result := _tc_long;
end;

//**************************************************************************
// TStatFloat
//**************************************************************************
procedure TStatFloat._assign(dst, src: Pointer);
begin
  float(dst^) := float(src^);
end;

procedure TStatFloat._create(var addr: Pointer);
begin
  addr := AllocMem(sizeof(float))
end;

procedure TStatFloat._free(var addr: Pointer);
begin
  FreeMem(addr);
end;

function TStatFloat.demarshal(dec: IDecoder; const addr : Pointer): Boolean;
begin
  result := dec.get_float(float(addr^));
end;

procedure TStatFloat.marshal(enc: IEncoder; const addr : Pointer);
begin
  enc.put_float(float(addr^));
end;

function TStatFloat.typecode(): ITypeCode;
begin
  result := _tc_float;
end;

//**************************************************************************
// TStatDouble
//**************************************************************************
procedure TStatDouble._assign(dst, src: Pointer);
begin
  double(dst^) := double(src^);
end;

procedure TStatDouble._create(var addr: Pointer);
begin
  addr := AllocMem(sizeof(double))
end;

procedure TStatDouble._free(var addr: Pointer);
begin
  FreeMem(addr);
end;

function TStatDouble.demarshal(dec: IDecoder; const addr : Pointer): Boolean;
begin
  result := dec.get_double(double(addr^));
end;

procedure TStatDouble.marshal(enc: IEncoder; const addr : Pointer);
begin
  enc.put_double(double(addr^));
end;

function TStatDouble.typecode(): ITypeCode;
begin
  result := _tc_double;
end;

//***********************************************************************
// TStatLongDouble 
//***********************************************************************
procedure TStatLongDouble._assign(dst, src: Pointer);
begin
  longdouble(dst^) := longdouble(src^);
end;

procedure TStatLongDouble._create(var addr: Pointer);
begin
  addr := AllocMem(sizeof(longdouble))
end;

procedure TStatLongDouble._free(var addr: Pointer);
begin
  FreeMem(addr);
end;

function TStatLongDouble.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
begin
  result := dec.get_longdouble(longdouble(addr^));
end;

procedure TStatLongDouble.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_longdouble(longdouble(addr^));
end;

function TStatLongDouble.typecode: ITypeCode;
begin
  result := _tc_longdouble;
end;

//***********************************************************************
//  TStatValueBase
//***********************************************************************
procedure TStatValueBase._assign(dst, src: Pointer);
begin
  IValueBase(dst^) := IValueBase(src^)
end;

procedure TStatValueBase._create(var addr: Pointer);
begin
  IValueBase(Pointer(addr^)) := TValueBase.Create as IValueBase;
end;

procedure TStatValueBase._free(var addr: Pointer);
begin
  IValueBase(Pointer(addr^)) := nil;
end;

function TStatValueBase.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
begin
  result := TValueBase._demarshal(dec,IValueBase(Pointer(addr^)),'IDL:omg.org/CORBA/ValueBase:1.0');
end;

procedure TStatValueBase.marshal(enc: IEncoder; const addr: Pointer);
begin
  TValueBase._marshal(enc,IValueBase(Pointer(addr^)));
end;

function TStatValueBase.typecode: ITypeCode;
begin
  result := _tc_AbstractBase;
end;

//**************************************************************************
//  TStatObject
//**************************************************************************
procedure TStatObject._create(var addr: Pointer);
begin
  IORBObject(Pointer(addr^)) := TORBObject.Create as IORBObject;
end;

procedure TStatObject._assign(dst,src: Pointer);
begin
  IORBObject(dst^) := IORBObject(src^)
end;

procedure TStatObject._free(var addr: Pointer);
begin
  IORBObject(Pointer(addr^)) := nil;
end;

function TStatObject.demarshal(dec: IDecoder; const addr : Pointer): Boolean;
var
  ior : IIOR;
  obj : IORBObject;
begin
  result := false;
  ior := TIOR.Create();
  if not ior.decode(dec) then exit;
  obj := orb.ORB_Instance.ior_to_object(ior);
  IORBObject(addr^) := obj;
  result := true;
end;

procedure TStatObject.marshal(enc: IEncoder; const addr : Pointer);
var
  obj : IORBObject;
  ior : IIOR;
begin
  obj := IORBObject(addr^);
  if obj = nil then
    ior := TIOR.Create()
  else
    ior := obj._ior;
  ior.encode(enc);
end;

function TStatObject.typecode(): ITypeCode;
begin
  result := nil;
//  assert(false,'not implemented');
end;

//**************************************************************************
//  TStatAny
//**************************************************************************
procedure TStatAny._create(var addr: Pointer);
begin
  IAny(addr^) := TAny.Create();
end;

procedure TStatAny._free(var addr: Pointer);
begin
  IAny(addr^) := nil;
end;

function TStatAny.demarshal(dec: IDecoder; const addr : Pointer): Boolean;
var
  a : IAny;
begin
  if Pointer(addr^) = nil then
    IAny(addr^) := TAny.Create();
  a := IAny(addr^);
  result := dec.get_any(a);
end;

procedure TStatAny.marshal(enc: IEncoder; const addr : Pointer);
var
  a : IAny;
begin
  if Pointer(addr^) = nil then
    IAny(addr^) := TAny.Create();
  a := IAny(addr^);
  enc.put_any(a);
end;

function TStatAny.typecode(): ITypeCode;
begin
  result := _tc_any
end;

procedure TStatAny._assign(dst,src: Pointer);
begin
  IAny(dst^) := TAny.Create();
  //IAny(src^).copy_any(IAny(dst^));
  IAny(dst^).copy(IAny(src^));
end;


//**********************************************************************
// TStatString
//**********************************************************************
procedure TStatString._create(var addr: Pointer);
begin
  String(addr^) := '';
end;

procedure TStatString._free(var addr: Pointer);
begin
  //Dispose(PString(addr));
  String(addr^) := '';
end;

procedure TStatString._assign(dst, src: Pointer);
begin
  string(dst^) := string(src^);
end;


function TStatString.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := dec.get_string(PAnsiString(addr)^);
end;

procedure TStatString.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_string(PAnsiString(addr)^);
end;

function TStatString.typecode(): ITypeCode;
begin
  result := _tc_string;
end;

//**********************************************************************
// TStatWideString
//**********************************************************************
procedure TStatWideString._create(var addr: Pointer);
begin
  WideString(addr^) := '';
end;

procedure TStatWideString._free(var addr: Pointer);
begin
  //Dispose(PString(addr));
  WideString(addr^) := '';
end;

procedure TStatWideString._assign(dst, src: Pointer);
begin
  Widestring(dst^) := Widestring(src^);
end;


function TStatWideString.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := dec.get_wstring(PWideString(addr)^);
end;

procedure TStatWideString.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_wstring(PWideString(addr)^);
end;

function TStatWideString.typecode(): ITypeCode;
begin
  result := _tc_wstring;
end;

//***********************************************************************
// TStatBoolean
//***********************************************************************
procedure TStatBoolean._create(var addr: Pointer);
begin
  addr := allocmem(1);
end;

procedure TStatBoolean._free(var addr: Pointer);
begin
  freemem(addr)
end;

procedure TStatBoolean._assign(dst, src: Pointer);
begin
  Boolean(dst^) := Boolean(src^);
end;

function TStatBoolean.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := dec.get_octet(Octet(addr^));
end;

procedure TStatBoolean.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_octet(Octet(addr^));
end;

function TStatBoolean.typecode: ITypeCode;
begin
  result := _tc_boolean;
end;

//*********************************************************************
//  TStatUShort
//*********************************************************************
procedure TStatUShort._create(var addr: Pointer);
begin
  addr := AllocMem(2);
end;

procedure TStatUShort._free(var addr: Pointer);
begin
  freemem(addr);
end;

function TStatUShort.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := dec.get_ushort(_ushort(addr^));
end;

procedure TStatUShort.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_short(_ushort(addr^));
end;

function TStatUShort.typecode: ITypeCode;
begin
  result := _tc_ushort;
end;

procedure TStatUShort._assign(dst, src: Pointer);
begin
  _ushort(dst^) := _ushort(src^)
end;


//*********************************************************************
//  TStatShort
//*********************************************************************
procedure TStatShort._create(var addr: Pointer);
begin
  addr := AllocMem(2);
end;

procedure TStatShort._free(var addr: Pointer);
begin
  freemem(addr);
end;

function TStatShort.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := dec.get_short(short(addr^));
end;

procedure TStatShort.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_short(short(addr^));
end;

function TStatShort.typecode: ITypeCode;
begin
  result := _tc_short;
end;

procedure TStatShort._assign(dst, src: Pointer);
begin
  short(dst^) := short(src^)
end;

//*********************************************************************
//  TStatChar
//*********************************************************************
procedure TStatChar._create(var addr: Pointer);
begin
  addr := AllocMem(1);
end;

procedure TStatChar._free(var addr: Pointer);
begin
  freemem(addr);
end;

function TStatChar.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  //result := dec.get_octet(char(addr^));
  result := dec.get_char(AnsiChar(addr^));
end;

procedure TStatChar.marshal(enc: IEncoder; const addr: Pointer);
begin
  //enc.put_octet(char(addr^))
  enc.put_char(AnsiChar(addr^));
end;

function TStatChar.typecode: ITypeCode;
begin
  result := _tc_char;
end;

procedure TStatChar._assign(dst, src: Pointer);
begin
  Char(dst^) := Char(src^);
end;

//*********************************************************************
//  TStatWideChar
//*********************************************************************
procedure TStatWideChar._create(var addr: Pointer);
begin
  addr := AllocMem(SizeOf(WideChar));
end;

procedure TStatWideChar._free(var addr: Pointer);
begin
  freemem(addr);
end;

function TStatWideChar.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := dec.get_wchar(widechar(addr^));
end;

procedure TStatWideChar.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_wchar(widechar(addr^));
end;

function TStatWideChar.typecode: ITypeCode;
begin
  result := _tc_wchar;
end;

procedure TStatWideChar._assign(dst, src: Pointer);
begin
  WideChar(dst^) := WideChar(src^);
end;

//*********************************************************************
//  TStatOctet
//*********************************************************************
procedure TStatOctet._create(var addr: Pointer);
begin
  addr := AllocMem(1);
end;

procedure TStatOctet._free(var addr: Pointer);
begin
  freemem(addr);
end;

function TStatOctet.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := dec.get_octet(Octet(addr^));
end;

procedure TStatOctet.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_octet(Octet(addr^))
end;

function TStatOctet.typecode: ITypeCode;
begin
  result := _tc_octet;
end;

procedure TStatOctet._assign(dst, src: Pointer);
begin
  Octet(dst^) := Octet(src^);
end;

//*********************************************************************
//  TStatTypeCode
//*********************************************************************
procedure TStatTypeCode._create(var addr: Pointer);
begin
  ITypeCode(addr^) := TTypeCode.Create();
end;

procedure TStatTypeCode._free(var addr: Pointer);
begin
  ITypeCode(addr^) := nil;
end;

function TStatTypeCode.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := ITypeCode(addr^).decode(dec);
end;

procedure TStatTypeCode.marshal(enc: IEncoder; const addr: Pointer);
begin
  ITypeCode(addr^).encode(enc);
end;

function TStatTypeCode.typecode: ITypeCode;
begin
  result := _tc_TypeCode;
end;

procedure TStatTypeCode._assign(dst, src: Pointer);
begin
  ITypeCode(dst^) := ITypeCode(src^);
end;

//*********************************************************************
//  TStatPrincipal
//*********************************************************************
procedure TStatPrincipal._create(var addr: Pointer);
begin
  IPrincipal(addr^) := TPrincipal.Create();
end;

procedure TStatPrincipal._free(var addr: Pointer);
begin
  IPrincipal(addr^) := nil;
end;

function TStatPrincipal.demarshal(dec: IDecoder; const addr: Pointer): Boolean;
begin
  result := IPrincipal(addr^).decode(dec);
end;

procedure TStatPrincipal.marshal(enc: IEncoder; const addr: Pointer);
begin
  IPrincipal(addr^).encode(enc);
end;

function TStatPrincipal.typecode: ITypeCode;
begin
  result := _tc_Principal;
end;

procedure TStatPrincipal._assign(dst, src: Pointer);
begin
  IPrincipal(dst^) := IPrincipal(src^);
end;

//**************************************************************************
// TStatLongLong
//**************************************************************************
procedure TStatLongLong._create(var addr: Pointer);
begin
  addr := AllocMem(sizeof(longlong))
end;

procedure TStatLongLong._free(var addr: Pointer);
begin
  FreeMem(addr);
end;

function TStatLongLong.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
begin
  result := dec.get_longlong(longlong(addr^));
end;

procedure TStatLongLong.marshal(enc: IEncoder; const addr: Pointer);
begin
  enc.put_longlong(longlong(addr^));
end;

function TStatLongLong.typecode: ITypeCode;
begin
  result := _tc_longlong;
end;

{ TStatSystemException }

procedure TStatSystemException._assign(dst, src: Pointer);
begin
  ISystemException(dst^) := ISystemException(src^);
end;

procedure TStatSystemException._create(var addr: Pointer);
begin
  ISystemException(addr^) := SystemException.create_sysex(FExceptionType);
end;

procedure TStatSystemException._free(var addr: Pointer);
begin
  ISystemException(addr^) := nil;
end;

constructor TStatSystemException.Create(ExceptionType: SYSEXC_TYPES);
begin
  FExceptionType := ExceptionType;
end;

function TStatSystemException.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  se: ISystemException;
begin
  se := SystemException.decode(dec) as ISystemException;
  result := se <> nil;
  if result then
    ISystemException(addr^).assign(se);
end;

procedure TStatSystemException.marshal(enc: IEncoder; const addr: Pointer);
begin
  ISystemException(addr^).encode(enc);
end;

function TStatSystemException.typecode: ITypeCode;
begin
  result := _tc_SystemException[FExceptionType];
end;

{ TAbstractBase }

procedure TStatAbstractBase._assign(dst, src: Pointer);
begin
  IAbstractBase(dst^) := IAbstractBase(src^)
end;

procedure TStatAbstractBase._create(var addr: Pointer);
begin
  IAbstractBase(Pointer(addr^)) := TAbstractBase.Create as IAbstractBase;
end;

procedure TStatAbstractBase._free(var addr: Pointer);
begin
  IAbstractBase(Pointer(addr^)) := nil;
end;

function TStatAbstractBase.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
begin
  result := TAbstractBase._demarshal(dec, IAbstractBase(Pointer(addr^)));
end;

procedure TStatAbstractBase.marshal(enc: IEncoder; const addr: Pointer);
begin
  TAbstractBase._marshal(enc, IAbstractBase(Pointer(addr^)));
end;

function TStatAbstractBase.typecode: ITypeCode;
begin

end;

{$IFDEF LIBRARY}
//*********************************************************************
//  Export functions
//*********************************************************************
function stat_long : IStaticTypeInfo;
begin
  result := _stat_long
end;

function stat_ulong : IStaticTypeInfo;
begin
  result := _stat_ulong
end;

function stat_longlong : IStaticTypeInfo;
begin
  result := _stat_longlong
end;

function stat_ulonglong : IStaticTypeInfo;
begin
  result := _stat_ulonglong
end;


function stat_float : IStaticTypeInfo;
begin
  result := _stat_float
end;

function stat_double : IStaticTypeInfo;
begin
  result := _stat_double
end;

function stat_longdouble : IStaticTypeInfo;
begin
  result := _stat_longdouble
end;

function stat_Object : IStaticTypeInfo;
begin
  result := _stat_Object
end;

function stat_Any : IStaticTypeInfo;
begin
  result := _stat_Any
end;

function stat_String : IStaticTypeInfo;
begin
  result := _stat_String
end;

function stat_WideString : IStaticTypeInfo;
begin
  result := _stat_WideString
end;

function stat_Boolean : IStaticTypeInfo;
begin
  result := _stat_Boolean
end;

function stat_ushort : IStaticTypeInfo;
begin
  result := _stat_ushort
end;

function stat_short : IStaticTypeInfo;
begin
  result := _stat_short
end;

function stat_char : IStaticTypeInfo;
begin
  result := _stat_char
end;

function stat_widechar : IStaticTypeInfo;
begin
  result := _stat_widechar
end;

function stat_octet : IStaticTypeInfo;
begin
  result := _stat_octet
end;

function stat_typecode : IStaticTypeInfo;
begin
  result := _stat_typecode
end;

function stat_principal : IStaticTypeInfo;
begin
  result := _stat_principal
end;

function stat_ValueBase : IStaticTypeInfo;
begin
  result := _stat_ValueBase;
end;

function stat_SystemException : TSystemExceptionStaticTypeInfoList;
begin
  result := _stat_SystemException;
end;

function stat_AbstractBase : IStaticTypeInfo;
begin
  result := _stat_AbstractBase;
end;

exports
  stat_long,
  stat_ulong,
  stat_longlong,
  stat_ulonglong,
  stat_float,
  stat_double,
  stat_longdouble,
  stat_Object,
  stat_Any,
  stat_String,
  stat_WideString,
  stat_Boolean,
  stat_ushort,
  stat_short,
  stat_char,
  stat_widechar,
  stat_octet,
  stat_typecode,
  stat_principal,
  stat_ValueBase,
  stat_SystemException,
  stat_AbstractBase;
initialization
  _stat_ulong := TStatULong.Create;
  _stat_char := TStatChar.Create;
  _stat_widechar := TStatWideChar.Create;
  _stat_octet := TStatOctet.Create;
  _stat_long := TStatLong.Create;
  _stat_longlong := TStatLongLong.Create;
  _stat_ulonglong := TStatULongLong.Create;
  _stat_float := TStatFloat.Create;
  _stat_double := TStatDouble.Create;
  _stat_longdouble := TStatLongDouble.Create;
  _stat_Object := TStatObject.Create;
  _stat_Any := TStatAny.Create;
  _stat_string := TStatString.Create;
  _stat_widestring := TStatWideString.Create;
  _stat_boolean := TStatBoolean.Create;
  _stat_ushort := TStatUShort.Create;
  _stat_short := TStatShort.Create;
  _stat_typecode := TStatTypeCode.Create;
  _stat_principal := TStatTypeCode.Create;
  _stat_ValueBase := TStatValueBase.Create;
  _stat_AbstractBase := TStatAbstractBase.Create;
  CreateStatSystemException;
{$ELSE}
initialization
  stat_long := TStatLong.Create;
  stat_ulong := TStatULong.Create;
  stat_longlong := TStatLongLong.Create;
  stat_ulonglong := TStatULongLong.Create;
  stat_char := TStatChar.Create;
  stat_widechar := TStatWideChar.Create;
  stat_octet := TStatOctet.Create;
  stat_float := TStatFloat.Create;
  stat_double := TStatDouble.Create;
  stat_Object := TStatObject.Create;
  stat_Any := TStatAny.Create;
  stat_string := TStatString.Create;
  stat_widestring := TStatWideString.Create;
  stat_boolean := TStatBoolean.Create;
  stat_ushort := TStatUShort.Create;
  stat_short := TStatShort.Create;
  stat_typecode := TStatTypeCode.Create;
  stat_principal := TStatTypeCode.Create;
  stat_ValueBase := TStatValueBase.Create;
  stat_AbstractBase := TStatAbstractBase.Create;
  CreateStatSystemException;
{$ENDIF}
{$ENDIF}
end.


