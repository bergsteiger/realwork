{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{               Variant Utilities Unit                  }
{*******************************************************}

unit System.VarUtils;

{$BOOLEVAL OFF}

interface

uses
  System.SysUtils, System.Types, System.SysConst;

const
{$IF Defined(MSWINDOWS) and not Defined(NEXTGEN) and not Defined(GENERICVARIANTS)}
  GenericVarUtils = False;
{$ELSE}
  GenericVarUtils = True;
{$ENDIF}

  GenericVariants   = GenericVarUtils;
  GenericOperations = GenericVariants;
  GenericSafeArrays = GenericVarUtils;

{$IFDEF MSWINDOWS}
  // if we running in windows this should never be true
  GenericSafeArrayUsesLibC = FALSE;
{$ELSE}
  GenericSafeArrayUsesLibC = GenericSafeArrays;
{$ENDIF}

// These entry point(s) are used by Variants.pas.  The generic versions
//  of these routines (which are enabled if this unit is compiled under
//  an operating system other than Windows) are as similar as possible to
//  their Windows counter parts.  Please note that there are differences
//  but they have been kept to a minimum.

// error handling routines
function VarExceptionToResult(const E: Exception): HRESULT;

// variant management routines
procedure VariantInit(var V: TVarData); stdcall;
function VariantClear(var V: TVarData): HRESULT; stdcall;
function VariantCopy(var Dest: TVarData;
  const Source: TVarData): HRESULT; stdcall;
function VariantCopyInd(var Dest: TVarData;
  const Source: TVarData): HRESULT; stdcall;
function VariantChangeType(var Dest: TVarData; const Source: TVarData;
  wFlags: Word; VarType: Word): HRESULT; stdcall;

// the following routines are late bound due to the fact they might not be implemented everywhere
var

  // variant coercion routine
  VariantChangeTypeEx: function(var Dest: TVarData; const Source: TVarData;
    LCID: Integer; wFlags: Word; VarType: Word): HRESULT; stdcall;

  // variant unioperation routines
  VarNeg: function(const Source: TVarData; var Dest: TVarData): HRESULT; stdcall;
  VarNot: function(const Source: TVarData; var Dest: TVarData): HRESULT; stdcall;

  // variant bioperation routines
  VarAdd: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
  VarSub: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
  VarMul: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
  VarDiv: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
  VarIDiv: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
  VarMod: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
  VarAnd: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
  VarOr: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
  VarXor: function(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;

  // variant compare routine
  VarCmp: function(const Left, Right: TVarData; LCID: Integer; Flags: LongWord): HRESULT; stdcall;

type
  _POleStr = PWideChar;
  {$EXTERNALSYM _POleStr}

{$IFDEF NEXTGEN}
{$IF not Declared(WideString)}
  WideString = string;
{$ENDIF}
{$ENDIF NEXTGEN}

var
  // string conversion routines
  VarI4FromStr: function(const strIn: _POleStr; LCID: Integer; dwFlags: Longint;
    out lOut: Longint): HRESULT; stdcall;
  VarR4FromStr: function(const strIn: _POleStr; LCID: Integer; dwFlags: Longint;
    out fltOut: Single): HRESULT; stdcall;
  VarR8FromStr: function(const strIn: _POleStr; LCID: Integer; dwFlags: Longint;
    out dblOut: Double): HRESULT; stdcall;
  VarDateFromStr: function(const strIn: _POleStr; LCID: DWORD; dwFlags: Longint;
    out dateOut: TDateTime): HRESULT; stdcall;
  VarCyFromStr: function(const strIn: _POleStr; LCID: DWORD; dwFlags: Longint;
    out cyOut: Currency): HRESULT; stdcall;
  VarBoolFromStr: function(const strIn: _POleStr; LCID: Integer; dwFlags: Longint;
    out boolOut: WordBool): HRESULT; stdcall;

//{$IFNDEF NEXTGEN}
  VarBstrFromCy: function(cyIn: Currency; LCID: Integer; dwFlags: Longint;
    out bstrOut: WideString): HRESULT; stdcall;
  VarBstrFromDate: function(dateIn: TDateTime; LCID: Integer; dwFlags: Longint;
    out bstrOut: WideString): HRESULT; stdcall;
  VarBstrFromBool: function(boolIn: WordBool; LCID: Integer; dwFlags: Longint;
    out bstrOut: WideString): HRESULT; stdcall;
//{$ENDIF !NEXTGEN}

// safe array routines
function SafeArrayCreate(VarType, DimCount: Integer;
  Bounds: PVarArrayBoundArray): PVarArray;{$IFNDEF CPUX64} overload; {$ENDIF} stdcall;
{$IFNDEF CPUX64}
function SafeArrayCreate(VarType, DimCount: Integer;
  const Bounds: TVarArrayBoundArray): PVarArray; overload; stdcall; platform; deprecated 'use SafeArrayCreate(VarType, DimCount: Integer; Bounds: PVarArrayBoundArray)';
{$ENDIF}
function SafeArrayAllocDescriptor(DimCount: Integer;
  out VarArray: PVarArray): HRESULT; stdcall;
function SafeArrayAllocData(VarArray: PVarArray): HRESULT; stdcall;

function SafeArrayDestroy(VarArray: PVarArray): HRESULT; stdcall;
function SafeArrayDestroyDescriptor(VarArray: PVarArray): HRESULT; stdcall;
function SafeArrayDestroyData(VarArray: PVarArray): HRESULT; stdcall;

function SafeArrayRedim(VarArray: PVarArray; NewBound: PVarArrayBound): HRESULT; overload; stdcall;
function SafeArrayRedim(VarArray: PVarArray; const NewBound: TVarArrayBound): HRESULT; overload; stdcall; deprecated 'use SafeArrayRedim(VarArray: PVarArray; NewBound: PVarArrayBound)';

function SafeArrayCopy(SourceArray: PVarArray; out TargetArray: PVarArray): HRESULT; stdcall;
function SafeArrayCopyData(SourceArray, TargetArray: PVarArray): HRESULT; stdcall;

function SafeArrayGetLBound(VarArray: PVarArray; Dim: Integer;
  out LBound: Integer): HRESULT; stdcall;
function SafeArrayGetUBound(VarArray: PVarArray; Dim: Integer;
  out UBound: Integer): HRESULT; stdcall;
function SafeArrayGetDim(VarArray: PVarArray): Integer; stdcall;

function SafeArrayAccessData(VarArray: PVarArray;
  out Data: Pointer): HRESULT; stdcall;
function SafeArrayUnaccessData(VarArray: PVarArray): HRESULT; stdcall;
function SafeArrayLock(VarArray: PVarArray): HRESULT; stdcall;
function SafeArrayUnlock(VarArray: PVarArray): HRESULT; stdcall;

function SafeArrayGetElement(VarArray: PVarArray; Indices: PVarArrayCoorArray;
  Data: Pointer): HRESULT; stdcall;
function SafeArrayPutElement(VarArray: PVarArray; Indices: PVarArrayCoorArray;
  const Data: Pointer): HRESULT; stdcall;
function SafeArrayPtrOfIndex(VarArray: PVarArray; Indices: PVarArrayCoorArray;
  var Address: Pointer): HRESULT; stdcall;
function SafeArrayGetElemSize(VarArray: PVarArray): LongWord; stdcall;

procedure SafeArrayCheck(AResult: HRESULT);
procedure SafeArrayError(AResult: HRESULT);

type
  ESafeArrayError = class(Exception)
  private
    FErrorCode: HRESULT;
  public
    constructor CreateHResult(AResult: HRESULT; const AMessage: string = '');
    property ErrorCode: HRESULT read FErrorCode write FErrorCode;
  end;

  ESafeArrayCreateError = class(ESafeArrayError);
  ESafeArrayBoundsError = class(ESafeArrayError);
  ESafeArrayLockedError = class(ESafeArrayError);

// These equate to Window's constants but are renamed to less OS dependent
const
  VAR_OK            = HRESULT($00000000); // = Windows.S_OK
  VAR_PARAMNOTFOUND = HRESULT($80020004); // = Windows.DISP_E_PARAMNOTFOUND
  VAR_TYPEMISMATCH  = HRESULT($80020005); // = Windows.DISP_E_TYPEMISMATCH
  VAR_BADVARTYPE    = HRESULT($80020008); // = Windows.DISP_E_BADVARTYPE
  VAR_EXCEPTION     = HRESULT($80020009); // = Windows.DISP_E_EXCEPTION
  VAR_OVERFLOW      = HRESULT($8002000A); // = Windows.DISP_E_OVERFLOW
  VAR_BADINDEX      = HRESULT($8002000B); // = Windows.DISP_E_BADINDEX
  VAR_ARRAYISLOCKED = HRESULT($8002000D); // = Windows.DISP_E_ARRAYISLOCKED
  VAR_NOTIMPL       = HRESULT($80004001); // = Windows.E_NOTIMPL
  VAR_OUTOFMEMORY   = HRESULT($8007000E); // = Windows.E_OUTOFMEMORY
  VAR_INVALIDARG    = HRESULT($80070057); // = Windows.E_INVALIDARG
  VAR_UNEXPECTED    = HRESULT($8000FFFF); // = Windows.E_UNEXPECTED

  ARR_NONE          = $0000;  { no flags set }
  ARR_FIXEDSIZE     = $0010;  { ActiveX.FADF_FIXEDSIZE, array may not be resized or reallocated }
  ARR_OLESTR        = $0100;  { ActiveX.FADF_BSTR, an array of BSTRs }
  ARR_UNKNOWN       = $0200;  { ActiveX.FADF_UNKNOWN, an array of IUnknown }
  ARR_DISPATCH      = $0400;  { ActiveX.FADF_DISPATCH, an array of IDispatch }
  ARR_VARIANT       = $0800;  { ActiveX.FADF_VARIANT, an array of VARIANTs }

  VAR_CMP_LT        = 0;      { These are returned by VarCmp }
  VAR_CMP_EQ        = 1;
  VAR_CMP_GT        = 2;
  VAR_CMP_NULL      = 3;

  VAR_LOCALE_USER_DEFAULT = $400; // = Windows.LOCALE_USER_DEFAULT

type
  TVarTypeToElementInfo = record
    ValidBase: Boolean;
    ValidElement: Boolean;
    Size: Integer;
    Flags: Word;
  end;

const
  CMinArrayVarType = varEmpty;
  CMaxArrayVarType = varUInt64;
  CVarTypeToElementInfo: array [CMinArrayVarType..CMaxArrayVarType] of TVarTypeToElementInfo = (

    { * = unsupported as of VCLv6  }
    { varEmpty/vt_empty        $00 }
    (ValidBase: False; ValidElement:  True; Size:  0; Flags: ARR_NONE),
    { varNull/vt_null          $01 }
    (ValidBase: False; ValidElement:  True; Size:  0; Flags: ARR_NONE),
    { varSmallint/vt_i2        $02 }
    (ValidBase:  True; ValidElement:  True; Size:  2; Flags: ARR_NONE),
    { varInteger/vt_i4         $03 }
    (ValidBase:  True; ValidElement:  True; Size:  4; Flags: ARR_NONE),
    { varSingle/vt_r4          $04 }
    (ValidBase:  True; ValidElement:  True; Size:  4; Flags: ARR_NONE),
    { varDouble/vt_r8          $05 }
    (ValidBase:  True; ValidElement:  True; Size:  8; Flags: ARR_NONE),
    { varCurrency/vt_cy        $06 }
    (ValidBase:  True; ValidElement:  True; Size:  8; Flags: ARR_NONE),
    { varDate/vt_date          $07 }
    (ValidBase:  True; ValidElement:  True; Size:  8; Flags: ARR_NONE),
    { varOleStr/vt_bstr        $08 }
    (ValidBase:  True; ValidElement:  True; Size:  4; Flags: ARR_OLESTR),
    { varDispatch/vt_dispatch  $09 }
    (ValidBase:  True; ValidElement:  True; Size:  4; Flags: ARR_DISPATCH),
    { varError/vt_error        $0A }
    (ValidBase:  True; ValidElement:  True; Size:  4; Flags: ARR_NONE),
    { varBoolean/vt_bool       $0B }
    (ValidBase:  True; ValidElement:  True; Size:  2; Flags: ARR_NONE),
    { varVariant/vt_variant    $0C }
    (ValidBase:  True; ValidElement:  True; Size: 16; Flags: ARR_VARIANT),
    { varUnknown/vt_unknown    $0D }
    (ValidBase:  True; ValidElement:  True; Size:  4; Flags: ARR_UNKNOWN),
    {*varDecimal/vt_decimal    $0E }
    (ValidBase: False; ValidElement: False; Size: 14; Flags: ARR_NONE),
    {*unused/undefined         $0F }
    (ValidBase: False; ValidElement: False; Size:  0; Flags: ARR_NONE),
    { varShortInt/vt_i1        $10 }
    (ValidBase:  True; ValidElement:  True; Size:  1; Flags: ARR_NONE),
    { varByte/vt_ui1           $11 }
    (ValidBase:  True; ValidElement:  True; Size:  1; Flags: ARR_NONE),
    { varWord/vt_ui2           $12 }
    (ValidBase:  True; ValidElement:  True; Size:  2; Flags: ARR_NONE),
    { varSmallWord/vt_ui4      $13 }
    (ValidBase:  True; ValidElement:  True; Size:  4; Flags: ARR_NONE),
    { varInt64/vt_i8           $14 }
    (ValidBase: False; ValidElement:  True; Size:  8; Flags: ARR_NONE),
    { varUInt64/vt_ui8         $15 }
    (ValidBase: False; ValidElement: False; Size:  8; Flags: ARR_NONE));

implementation

// This defined is used to insure that rangechecking is handled correctly
{$IFOPT R-}
  {$DEFINE RANGECHECKINGOFF}
{$ENDIF}

uses
{$IF Defined(MSWINDOWS)}
  Winapi.Windows
{$ELSEIF Defined(POSIX)}
  Posix.Stdlib
{$ELSE OTHER_PLATFORM}
{$MESSAGE Fatal 'Unrecognized Platform'}
{$ENDIF MSWINDOWS or POSIX}
{$IF GenericVarUtils or GenericSafeArrayUsesLibC}
  , System.Variants
{$ENDIF GENERICVARIANTS}
  ;

{$IFDEF MSWINDOWS}
const
  oleaut = 'oleaut32.dll';
{$ENDIF}

// has the jump table been initialized yet
var
  VariantInited: Boolean = False;

{******************************************************************************}
{ Common Variant Functions                                                     }
{******************************************************************************}

function VarExceptionToResult(const E: Exception): HRESULT;
begin
  // string to int conversion error
  // string to float conversion error
  // string to currency conversion error
  // string to datetime conversion error
  // float to currency conversion error
  // float to datetime conversion error

  if E is EConvertError then
    Result := VAR_TYPEMISMATCH

  // float range error
  else if E is System.SysUtils.EOverflow then // Symbol collision with LibC
    Result := VAR_OVERFLOW
  else if E is EUnderflow then
    Result := VAR_OVERFLOW

  // int range error
  else if E is ERangeError then
    Result := VAR_OVERFLOW

  // rounding overflow, possible during string conversion
  else if E is EIntOverflow then
    Result := VAR_OVERFLOW

  // something really really bad happened
  else if E is EOutOfMemory then
    Result := VAR_OUTOFMEMORY

  // unknown type of exception
  else
    Result := VAR_INVALIDARG;
end;

{******************************************************************************}
{ Variant Functions                                                            }
{******************************************************************************}

{$IF not GenericVariants}
procedure VariantInit; external oleaut name 'VariantInit';
function VariantClear; external oleaut name 'VariantClear';
function VariantCopy; external oleaut name 'VariantCopy';
function VariantCopyInd; external oleaut name 'VariantCopyInd';
function VariantChangeType; external oleaut name 'VariantChangeType';
{$ELSE}

type
{$IF not Declared(WideString)}
  WideString = UnicodeString;
{$ENDIF !Declared(WideString)}
  _OleStr = WideString;

procedure VarOleStrFromStr(var Dest: TVarData; const Source: string); inline;
begin
  _OleStr(Pointer(Dest.VOleStr)) := _OleStr(Source);
end;

procedure VariantInit(var V: TVarData);
begin
  V.VType := varEmpty;
  FillChar(V.VBytes, SizeOf(V.VBytes), 0);
end;

function VariantClear(var V: TVarData): HRESULT;
begin
  Result := VAR_OK;
  try
    // var is an array
    if (V.VType and varArray) <> 0 then
    begin
      if (v.vType and (not varArray)) = 0 then
        Result := VAR_BADVARTYPE
      else
        Result := SafeArrayDestroy(V.VArray);
    end
    else
    begin

      // var is not byref
      if (V.VType and varByRef) = 0 then
        case V.VType of
          varEmpty, varNull, varSmallint, varInteger, varSingle, varDouble,
          varCurrency, varDate, varError, varBoolean, varShortInt, varByte,
          varWord, varLongWord, varInt64, varUInt64:;
            // the fill char later on will take care of these
          varOleStr:
            VarOleStrFromStr(V, '');
          varDispatch:
            IUnknown(V.VDispatch) := nil;
          //varVariant:
          //  taken care of by the above ByRef code but we should error if not
          varUnknown:
            IUnknown(V.VUnknown) := nil;
                                                                                                     
        else
          Result := VAR_BADVARTYPE;
        end;
    end;

    // all is swell so lets slick it
    if Result = VAR_OK then
      VariantInit(V);
  except
    Result := VAR_BADVARTYPE;
  end;
end;

function VariantCopy(var Dest: TVarData; const Source: TVarData): HRESULT;
begin
  // Dest is pointing to the source, nothing need be done
  if @Source = @Dest then
    Result := VAR_OK
  else
  begin

    // wipe out the destination
    Result := VariantClear(Dest);
    if Result = VAR_OK then
    begin

      // var is an array!
      if (Source.VType and varArray) <> 0 then
        Result := SafeArrayCopy(Source.VArray, Dest.VArray)
      else
      begin
        if (Source.VType and varByRef) <> 0 then // var is byref
          Dest.VPointer := Source.VPointer
        else
          case (Source.VType and varTypeMask) of // strip off modifier flags
            varEmpty, varNull:;
              // nothing do!
            varSmallint, varInteger, varSingle, varDouble, varCurrency, varDate,
            varError, varBoolean, varShortInt, varByte, varWord, varLongWord, varInt64, varUInt64:
              Move(Source.VBytes, Dest.VBytes, SizeOf(Dest.VBytes));
            varOleStr:
{$IFDEF MSWINDOWS}
             VarOleStrFromStr(Dest, Source.VOleStr);
{$ELSE}
             WideString(Pointer(Dest.VOleStr)) := Copy(WideString(Pointer(Source.VOleStr)), 1, MaxInt);
{$ENDIF MSWINDOWS}
            varDispatch:
              IUnknown(Dest.VDispatch) := IUnknown(Source.VDispatch);
            //varVariant:
            //  taken care of by the above ByRef code but we should error if not
            varUnknown:
              IUnknown(Dest.VUnknown) := IUnknown(Source.VUnknown);
          else
            Result := VAR_BADVARTYPE;
          end;
      end;

      // if all is swell then copy over the VType
      if Result = VAR_OK then
        Dest.VType := Source.VType;
    end;
  end;
end;

function VariantCopyInd(var Dest: TVarData; const Source: TVarData): HRESULT;
var
  LSource: TVarData;
begin
  Result := VariantClear(Dest);
  if Result <> VAR_OK then
    Exit;
  if Source.VType = varByRef + varVariant  then
    LSource := PVarData(Source.VPointer)^
  else
    LSource := Source;

  if (LSource.VType and varByRef) = 0 then // var is NOT byref, so just copy
    Exit(VariantCopy(Dest, LSource));
  if (LSource.VType and varArray) <> 0 then // var is an array, bad!
    Exit(VAR_INVALIDARG);

  Result := VAR_OK;
  case (LSource.VType and varTypeMask) of // strip off modifier flags
    varEmpty, varNull:;
      // do nothing
    varSmallint:
      Dest.VSmallInt := PSmallInt(LSource.VPointer)^;
    varInteger:
      Dest.VInteger := PInteger(LSource.VPointer)^;
    varSingle:
      Dest.VSingle := PSingle(LSource.VPointer)^;
    varDouble:
      Dest.VDouble := PDouble(LSource.VPointer)^;
    varCurrency:
      Dest.VCurrency := PCurrency(LSource.VPointer)^;
    varDate:
      Dest.VDate := PDate(LSource.VPointer)^;
    varOleStr:
      VarOleStrFromStr(Dest, PPWideChar(LSource.VPointer)^);
    varDispatch:
      IUnknown(Dest.VDispatch) := IUnknown(PDispatch(LSource.VPointer)^);
    varError:
      Dest.VError := System.PError(LSource.VPointer)^;
    varBoolean:
      Dest.VBoolean := PWordBool(LSource.VPointer)^;
    varUnknown:
      IUnknown(Dest.VUnknown) := IUnknown(PUnknown(LSource.VPointer)^);
    varShortInt:
      Dest.VShortInt := PShortInt(LSource.VPointer)^;
    varByte:
      Dest.VByte := PByte(LSource.VPointer)^;
    varWord:
      Dest.VWord := PWord(LSource.VPointer)^;
    varLongWord:
      Dest.VLongWord := PLongWord(LSource.VPointer)^;
    varInt64:
      Dest.VInt64 := PInt64(LSource.VPointer)^;
    varUInt64:
      Dest.VUInt64 := PUInt64(LSource.VPointer)^;
    varVariant:
      Result := VAR_INVALIDARG;
  else
    Result := VAR_BADVARTYPE;
  end;
  if Result = VAR_OK then
  begin
    Dest.VType := LSource.VType and VarTypeMask; // strip off modifier flags
  end;
end;

function VariantChangeOleStrIntoByteArray(var Dest: TVarData;
  const Source: TVarData): HRESULT;
var
  LArray: PVarArray;
  LData: Pointer;
  LCount: Integer;
  LVarBounds: array[0..0] of TVarArrayBound;
begin
  Result := VAR_OK;

  // how big are we talking?
  LCount := Length(Source.VOleStr) * SizeOf(WideChar);
  LVarBounds[0].LowBound := 0;
  LVarBounds[0].ElementCount := LCount;

  // array please
  LArray := SafeArrayCreate(varByte, 1, PVarArrayBoundArray(@LVarBounds));
  try

    // now aquire the target
    Result := SafeArrayLock(LArray);
    if Result = VAR_OK then
    try

      // take aim
      Result := SafeArrayAccessData(LArray, LData);
      if Result = VAR_OK then
      try
      
        // move the data
        Move(Source.VOleStr^, LData^, LCount);
      finally
        Result := SafeArrayUnaccessData(LArray);
      end;

    // clean up
    finally
      if Result = VAR_OK then
        Result := SafeArrayUnlock(LArray)
      else
        SafeArrayUnlock(LArray);
    end;

  // if all is swell then finish up the destination
  finally
    if Result <> VAR_OK then
      SafeArrayDestroy(LArray)
    else
    begin
      Dest.VType := varArray + varByte;
      Dest.VArray := LArray;
    end;
  end;
end;

function VariantChangeByteArrayIntoOleStr(var Dest: TVarData;
  const Source: TVarData): HRESULT;
var
  LArray: PVarArray;
  LData: Pointer;
  LCount: Integer;
begin

  // we know its a byte array so lets make sure it only has one dimension and
  //  it's element size is one and dest is not the source
  LArray := Source.VArray;
  if (LArray.DimCount <> 1) or (LArray.ElementSize <> 1) or (@Dest = @Source) then
    Result := VAR_INVALIDARG
  else
  begin

    // lock things down for a bit
    Result := SafeArrayLock(LArray);
    if Result = VAR_OK then
    try

      // now try and get the data
      Result := SafeArrayAccessData(LArray, LData);
      if Result = VAR_OK then
      try

        // how big is the data
        LCount := LArray.Bounds[0].ElementCount;

        // resize the destination
        SetLength(string(Pointer(Dest.VOleStr)),
          (LCount + SizeOf(Char) - 1) div SizeOf(Char));

        // mark it as being a ole str
        Dest.VType := varOleStr;

        // finally move the data
        Move(LData^, Dest.VOleStr^, LCount);
      finally
        Result := SafeArrayUnaccessData(LArray);
      end;

    // finally release the lock
    finally
      if Result = VAR_OK then
        Result := SafeArrayUnlock(LArray)
      else
        SafeArrayUnlock(LArray);
    end;
  end;
end;

function VariantChangeSimpleIntoSimple(var Dest: TVarData; const Source: TVarData;
  Flags: Word; VarType: Word): HRESULT;
var
  LSource: TVarData;
begin
  VariantInit(LSource);

  // this will take care of both ByRef Source and Dest = Source
  Result := VariantCopyInd(LSource, Source);
  if Result = VAR_OK then
  try
    Result := VariantClear(Dest);

    {$RANGECHECKS ON}
    if Result = VAR_OK then
    try
      case LSource.VType of
        varEmpty:
          case VarType of
            varEmpty, varNull, varSmallInt, varInteger, varSingle, varDouble,
            varCurrency, varDate, varOleStr, varBoolean, varShortInt, varByte,
            varWord, varLongWord, varInt64, varUInt64:;
              // these are taken care of by the above Dest clear
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varNull:
          case VarType of
            varNull:;
              // this is taken care of by the above Dest clear
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varSmallint:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := LSource.VSmallInt;
            varInteger:
              Dest.VInteger := LSource.VSmallInt;
            varSingle:
              Dest.VSingle := LSource.VSmallInt;
            varDouble:
              Dest.VDouble := LSource.VSmallInt;
            varCurrency:
              Dest.VCurrency := LSource.VSmallInt;
            varDate:
              Dest.VDate := FloatToDateTime(LSource.VSmallInt);
            varOleStr:
              VarOleStrFromStr(Dest, IntToStr(LSource.VSmallInt));
            varBoolean:
              Dest.VBoolean := LSource.VSmallInt <> 0;
            varShortInt:
              Dest.VShortInt := LSource.VSmallInt;
            varByte:
              Dest.VByte := LSource.VSmallInt;
            varWord:
              Dest.VWord := LSource.VSmallInt;
            varLongWord:
              Dest.VLongWord := LSource.VSmallInt;
            varInt64:
              Dest.VInt64 := LSource.VSmallInt;
            varUInt64:
              Dest.VUInt64 := LSource.VSmallInt;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varInteger:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := LSource.VInteger;
            varInteger:
              Dest.VInteger := LSource.VInteger;
            varSingle:
              Dest.VSingle := LSource.VInteger;
            varDouble:
              Dest.VDouble := LSource.VInteger;
            varCurrency:
              Dest.VCurrency := LSource.VInteger;
            varDate:
              Dest.VDate := FloatToDateTime(LSource.VInteger);
            varOleStr:
              VarOleStrFromStr(Dest, IntToStr(LSource.VInteger));
            varBoolean:
              Dest.VBoolean := LSource.VInteger <> 0;
            varShortInt:
              Dest.VShortInt := LSource.VInteger;
            varByte:
              Dest.VByte := LSource.VInteger;
            varWord:
              Dest.VWord := LSource.VInteger;
            varLongWord:
              Dest.VLongWord := LSource.VInteger;
            varInt64:
              Dest.VInt64 := LSource.VInteger;
            varUInt64:                     
              Dest.VUInt64 := LSource.VInteger;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varSingle:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := Round(LSource.VSingle);
            varInteger:
              Dest.VInteger := Round(LSource.VSingle);
            varSingle:
              Dest.VSingle := LSource.VSingle;
            varDouble:
              Dest.VDouble := LSource.VSingle;
            varCurrency:
              Dest.VCurrency := FloatToCurr(LSource.VSingle);
            varDate:
              Dest.VDate := FloatToDateTime(LSource.VSingle);
            varOleStr:
              VarOleStrFromStr(Dest, FloatToStr(LSource.VSingle));
            varBoolean:
              Dest.VBoolean := LSource.VSingle <> 0;
            varShortInt:
              Dest.VShortInt := Round(LSource.VSingle);
            varByte:
              Dest.VByte := Round(LSource.VSingle);
            varWord:
              Dest.VWord := Round(LSource.VSingle);
            varLongWord:
              Dest.VLongWord := Round(LSource.VSingle);
            varInt64:
              Dest.VInt64 := Round(LSource.VSingle);
            varUInt64:
              Dest.VUInt64 := Round(LSource.VSingle);
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varDouble:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := Round(LSource.VDouble);
            varInteger:
              Dest.VInteger := Round(LSource.VDouble);
            varSingle:
              Dest.VSingle := LSource.VDouble;
            varDouble:
              Dest.VDouble := LSource.VDouble;
            varCurrency:
              Dest.VCurrency := FloatToCurr(LSource.VDouble);
            varDate:
              Dest.VDate := FloatToDateTime(LSource.VDouble);
            varOleStr:
              VarOleStrFromStr(Dest, FloatToStr(LSource.VDouble));
            varBoolean:
              Dest.VBoolean := LSource.VDouble <> 0;
            varShortInt:
              Dest.VShortInt := Round(LSource.VDouble);
            varByte:
              Dest.VByte := Round(LSource.VDouble);
            varWord:
              Dest.VWord := Round(LSource.VDouble);
            varLongWord:
              Dest.VLongWord := Round(LSource.VDouble);
            varInt64:
              Dest.VInt64 := Round(LSource.VDouble);
            varUInt64:
              Dest.VUInt64 := Round(LSource.VDouble);
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varCurrency:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := Round(LSource.VCurrency);
            varInteger:
              Dest.VInteger := Round(LSource.VCurrency);
            varSingle:
              Dest.VSingle := LSource.VCurrency;
            varDouble:
              Dest.VDouble := LSource.VCurrency;
            varCurrency:
              Dest.VCurrency := LSource.VCurrency;
            varDate:
              Dest.VDate := FloatToDateTime(LSource.VCurrency);
            varOleStr:
              VarOleStrFromStr(Dest, CurrToStr(LSource.VCurrency));
            varBoolean:
              Dest.VBoolean := LSource.VCurrency <> 0;
            varShortInt:
              Dest.VShortInt := Round(LSource.VCurrency);
            varByte:
              Dest.VByte := Round(LSource.VCurrency);
            varWord:
              Dest.VWord := Round(LSource.VCurrency);
            varLongWord:
              Dest.VLongWord := Round(LSource.VCurrency);
            varInt64:
              Dest.VInt64 := Round(LSource.VCurrency);
            varUInt64:
              Dest.VUInt64 := Round(LSource.VCurrency);
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varDate:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := Round(LSource.VDate);
            varInteger:
              Dest.VInteger := Round(LSource.VDate);
            varSingle:
              Dest.VSingle := LSource.VDate;
            varDouble:
              Dest.VDouble := LSource.VDate;
            varCurrency:
              Dest.VCurrency := FloatToCurr(LSource.VDate);
            varDate:
              Dest.VDate := LSource.VDate;
            varOleStr:
              begin
                if Trunc(LSource.VDate) = 0 then
                  VarOleStrFromStr(Dest, TimeToStr(LSource.VDate))
                else
                  VarOleStrFromStr(Dest, DateTimeToStr(LSource.VDate))
              end;
            varBoolean:
              Dest.VBoolean := LSource.VDate <> 0;
            varShortInt:
              Dest.VShortInt := Round(LSource.VDate);
            varByte:
              Dest.VByte := Round(LSource.VDate);
            varWord:
              Dest.VWord := Round(LSource.VDate);
            varLongWord:
              Dest.VLongWord := Round(LSource.VDate);
            varInt64:
              Dest.VInt64 := Round(LSource.VDate);
            varUInt64:
              Dest.VUInt64 := Round(LSource.VDate);
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varOleStr:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := StrToInt(string(LSource.VOleStr));
            varInteger:
              Dest.VInteger := StrToInt(string(LSource.VOleStr));
            varSingle:
              Dest.VSingle := StrToFloat(string(LSource.VOleStr));
            varDouble:
              Dest.VDouble := StrToFloat(string(LSource.VOleStr));
            varCurrency:
              Dest.VCurrency := StrToCurr(string(LSource.VOleStr));
            varDate:
              Dest.VDate := StrToDateTime(string(LSource.VOleStr));
            varOleStr:
              VarOleStrFromStr(Dest, string(LSource.VOleStr));
            varBoolean:
              Dest.VBoolean := StrToBool(string(LSource.VOleStr));
            varShortInt:
              Dest.VShortInt := StrToInt(string(LSource.VOleStr));
            varByte:
              Dest.VByte := StrToInt(string(LSource.VOleStr));
            varWord:
              Dest.VWord := StrToInt(string(LSource.VOleStr));
            varLongWord:
              Dest.VLongWord := StrToInt64(string(LSource.VOleStr));
            varInt64:
              Dest.VInt64 := StrToInt64(string(LSource.VOleStr));
            varUInt64:
              Dest.VUInt64 := StrToInt64(string(LSource.VOleStr));
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varDispatch:
          Result := VAR_TYPEMISMATCH;
        varError:
          Result := VAR_TYPEMISMATCH;
        varBoolean:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := SmallInt(LSource.VBoolean);
            varInteger:
              Dest.VInteger := Integer(LSource.VBoolean);
            varSingle:
              Dest.VSingle := Integer(LSource.VBoolean);
            varDouble:
              Dest.VDouble := Integer(LSource.VBoolean);
            varCurrency:
              Dest.VCurrency := Integer(LSource.VBoolean);
            varDate:
              Dest.VDate := Integer(LSource.VBoolean);
            varOleStr:
              VarOleStrFromStr(Dest, BoolToStr(LSource.VBoolean));
            varBoolean:
              Dest.VBoolean := LSource.VBoolean;
            varShortInt:
              Dest.VShortInt := ShortInt(LSource.VBoolean);
            varByte:
              Dest.VByte := Byte(LSource.VBoolean);
            varWord:
              Dest.VWord := Word(LSource.VBoolean);
            varLongWord:
              Dest.VLongWord := LongWord(LSource.VBoolean);
            varInt64:
              Dest.VInt64 := Int64(LSource.VBoolean);
            varUInt64:
              Dest.VUInt64 := UInt64(LSource.VBoolean);
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varVariant:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := PVariant(LSource.VPointer)^;
            varInteger:
              Dest.VInteger := PVariant(LSource.VPointer)^;
            varSingle:
              Dest.VSingle := PVariant(LSource.VPointer)^;
            varDouble:
              Dest.VDouble := PVariant(LSource.VPointer)^;
            varCurrency:
              Dest.VCurrency := PVariant(LSource.VPointer)^;
            varDate:
              Dest.VDate := PVariant(LSource.VPointer)^;
            varOleStr:
            begin
              VarOleStrFromStr(Dest, PVariant(LSource.VPointer)^);
            end;
            varBoolean:
              Dest.VBoolean := PVariant(LSource.VPointer)^;
            varShortInt:
              Dest.VShortInt := PVariant(LSource.VPointer)^;
            varByte:
              Dest.VByte := PVariant(LSource.VPointer)^;
            varWord:
              Dest.VWord := PVariant(LSource.VPointer)^;
            varLongWord:
              Dest.VLongWord := PVariant(LSource.VPointer)^;
            varInt64:
              Dest.VInt64 := PVariant(LSource.VPointer)^;
            varUInt64:
              Dest.VUInt64 := PVariant(LSource.VPointer)^;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varUnknown:
          case VarType of
            varEmpty, varNull:;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varShortInt:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := LSource.VSmallInt;
            varInteger:
              Dest.VInteger := LSource.VSmallInt;
            varSingle:
              Dest.VSingle := LSource.VSmallInt;
            varDouble:
              Dest.VDouble := LSource.VSmallInt;
            varCurrency:
              Dest.VCurrency := LSource.VSmallInt;
            varDate:
              Dest.VDate := LSource.VSmallInt;
            varOleStr:
              VarOleStrFromStr(Dest, IntToStr(LSource.VSmallInt));
            varBoolean:
              Dest.VBoolean := LSource.VSmallInt <> 0;
            varShortInt:
              Dest.VShortInt := LSource.VSmallInt;
            varByte:
              Dest.VByte := LSource.VSmallInt;
            varWord:
              Dest.VWord := LSource.VSmallInt;
            varLongWord:
              Dest.VLongWord := LSource.VSmallInt;
            varInt64:
              Dest.VInt64 := LSource.VSmallInt;
            varUInt64:
              Dest.VUInt64 := LSource.VSmallInt;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varByte:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := LSource.VByte;
            varInteger:
              Dest.VInteger := LSource.VByte;
            varSingle:
              Dest.VSingle := LSource.VByte;
            varDouble:
              Dest.VDouble := LSource.VByte;
            varCurrency:
              Dest.VCurrency := LSource.VByte;
            varDate:
              Dest.VDate := LSource.VByte;
            varOleStr:
              VarOleStrFromStr(Dest, IntToStr(LSource.VByte));
            varBoolean:
              Dest.VBoolean := LSource.VByte <> 0;
            varShortInt:
              Dest.VShortInt := LSource.VByte;
            varByte:
              Dest.VByte := LSource.VByte;
            varWord:
              Dest.VWord := LSource.VByte;
            varLongWord:
              Dest.VLongWord := LSource.VByte;
            varInt64:
              Dest.VInt64 := LSource.VByte;
            varUInt64:
              Dest.VUInt64 := LSource.VByte;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varWord:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := LSource.VWord;
            varInteger:
              Dest.VInteger := LSource.VWord;
            varSingle:
              Dest.VSingle := LSource.VWord;
            varDouble:
              Dest.VDouble := LSource.VWord;
            varCurrency:
              Dest.VCurrency := LSource.VWord;
            varDate:
              Dest.VDate := LSource.VWord;
            varOleStr:
              VarOleStrFromStr(Dest, IntToStr(LSource.Vword));
            varBoolean:
              Dest.VBoolean := LSource.VWord <> 0;
            varShortInt:
              Dest.VShortInt := LSource.VWord;
            varByte:
              Dest.VByte := LSource.VWord;
            varWord:
              Dest.VWord := LSource.VWord;
            varLongWord:
              Dest.VLongWord := LSource.VWord;
            varInt64:
              Dest.VInt64 := LSource.VWord;
            varUInt64:
              Dest.VUInt64 := LSource.VWord;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varLongWord:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := LSource.VLongWord;
            varInteger:
              Dest.VInteger := LSource.VLongWord;
            varSingle:
              Dest.VSingle := LSource.VLongWord;
            varDouble:
              Dest.VDouble := LSource.VLongWord;
            varCurrency:
              Dest.VCurrency := LSource.VLongWord;
            varDate:
              Dest.VDate := LSource.VLongWord;
            varOleStr:
                                              
              //WideString(Pointer(Dest.VOleStr)) := IntToStr(LSource.VLongWord);
              VarOleStrFromStr(Dest, IntToStr(LSource.VLongWord));
            varBoolean:
              Dest.VBoolean := LSource.VLongWord <> 0;
            varShortInt:
              Dest.VShortInt := LSource.VLongWord;
            varByte:
              Dest.VByte := LSource.VLongWord;
            varWord:
              Dest.VWord := LSource.VLongWord;
            varLongWord:
              Dest.VLongWord := LSource.VLongWord;
            varInt64:
              Dest.VInt64 := LSource.VLongWord;
            varUInt64:
              Dest.VUInt64 := LSource.VLongWord;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varInt64:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := LSource.VInt64;
            varInteger:
              Dest.VInteger := LSource.VInt64;
            varSingle:
              Dest.VSingle := LSource.VInt64;
            varDouble:
              Dest.VDouble := LSource.VInt64;
            varCurrency:
              Dest.VCurrency := LSource.VInt64;
            varDate:
              Dest.VDate := LSource.VInt64;
            varOleStr:
              VarOleStrFromStr(Dest, IntToStr(LSource.VInt64));
            varBoolean:
              Dest.VBoolean := LSource.VInt64 <> 0;
            varShortInt:
              Dest.VShortInt := LSource.VInt64;
            varByte:
              Dest.VByte := LSource.VInt64;
            varWord:
              Dest.VWord := LSource.VInt64;
            varLongWord:
              Dest.VLongWord := LSource.VInt64;
            varInt64:
              Dest.VInt64 := LSource.VInt64;
            varUInt64:
              Dest.VUInt64 := LSource.VInt64;
          else
            Result := VAR_TYPEMISMATCH;
          end;
        varUInt64:
          case VarType of
            varEmpty, varNull:;
            varSmallInt:
              Dest.VSmallInt := LSource.VUInt64;
            varInteger:
              Dest.VInteger := LSource.VUInt64;
            varSingle:
              Dest.VSingle := LSource.VUInt64;
            varDouble:
              Dest.VDouble := LSource.VUInt64;
            varCurrency:
              Dest.VCurrency := LSource.VUInt64;
            varDate:
              Dest.VDate := LSource.VUInt64;
            varOleStr:
              VarOleStrFromStr(Dest, IntToStr(LSource.VUInt64));
            varBoolean:
              Dest.VBoolean := LSource.VUInt64 <> 0;
            varShortInt:
              Dest.VShortInt := LSource.VUInt64;
            varByte:
              Dest.VByte := LSource.VUInt64;
            varWord:
              Dest.VWord := LSource.VUInt64;
            varLongWord:
              Dest.VLongWord := LSource.VUInt64;
            varInt64:
              Dest.VInt64 := LSource.VUInt64;
            varUInt64:
              Dest.VUInt64 := LSource.VUInt64;
          else
            Result := VAR_TYPEMISMATCH;
          end;
      else
        Result := VAR_BADVARTYPE;
      end;

      if Result = VAR_OK then
        Dest.VType := VarType;
    except
      on E: Exception do
        Result := VarExceptionToResult(E);
    end;

    // Only turn range checking off if it was off to begin with
    {$IFDEF RANGECHECKINGOFF}
      {$RANGECHECKS OFF}
    {$ENDIF}
  finally
    VariantClear(LSource);
  end;
end;

{ Known limitations in VariantChangeType
    Cannot convert from or to anything that is ByRef except for exact
      identity copies
    Cannot convert from or to arrays except for exact identity copies
      and the rather strange, and undocumented, Array of Byte <--> OleStr
    Can convert from a variant containing a reference to a variant but not back }
function VariantChangeType(var Dest: TVarData; const Source: TVarData;
  wFlags: Word; VarType: Word): HRESULT;
begin
  // source is an olestr and dest is..
  if Source.VType = varOleStr then

    // ..array of bytes, that is easy too
    if VarType = varArray + varByte then
      Result := VariantChangeOleStrIntoByteArray(Dest, Source)

    // ..anything else let simple try to handle it
    else
      Result := VariantChangeSimpleIntoSimple(Dest, Source, wFlags, VarType)

  // source is an array of bytes and dest is..
  else if Source.VType = varArray + varByte then

    // ..olestr, easy
    if VarType = varOleStr then
      Result := VariantChangeByteArrayIntoOleStr(Dest, Source)

    // ..anything else, fail
    else
      Result := VAR_INVALIDARG

  // anything into itself
  else if Source.VType = VarType then
    Result := VariantCopy(Dest, Source)

  // simple to anything else, let the simple case try to handle it
  else
    Result := VariantChangeSimpleIntoSimple(Dest, Source, wFlags, VarType);
end;
{$ENDIF}

{******************************************************************************}
{ Backup Variant Functions/Operations                                          }
{******************************************************************************}
// Known limitations in the following functions
//   LCID is currently ignored but for future compatiblity you should always
//   pass VAR_LOCALE_USER_DEFAULT (which equals $400);


function BackupVariantChangeTypeEx(var Dest: TVarData; const Source: TVarData;
  LCID: Integer; wFlags: Word; VarType: Word): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
  begin
    { Try to change the type }
    Result := VariantChangeType(Dest, Source, wFlags, VarType);

    { Try to be as close as possible to the real OLE error codes }
    if (Result = VAR_TYPEMISMATCH) and ((VarType and varArray) = varArray) then
      Result := VAR_BADVARTYPE;
  end;
end;

{ we don't attempt to implement any of the uni/bi/cmp operators}
function UniUnimplemented(const Source: TVarData; var Dest: TVarData): HRESULT; stdcall;
begin
  Result := VAR_NOTIMPL;
end;

function BiUnimplemented(const Left, Right: TVarData; var AResult: TVarData): HRESULT; stdcall;
begin
  Result := VAR_NOTIMPL;
end;

function CmpUnimplemented(const Left, Right: TVarData; LCID: Integer; Flags: LongWord): HRESULT; stdcall;
begin
  Result := VAR_NOTIMPL;
end;

// Known limitations in these conversion functions
//   Windows is much more tolerant of extra characters when converting
//   ints, floats, dates, currs and bools into strings.
const
  CResult: array [False..True] of HRESULT = (VAR_TYPEMISMATCH, VAR_OK);

function BackupVarI4FromStr(const strIn: _POleStr; LCID: Integer; dwFlags: Longint;
  out lOut: Longint): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
    Result := CResult[TryStrToInt(strIn, lOut)];
end;

function BackupVarR4FromStr(const strIn: _POleStr; LCID: Integer; dwFlags: Longint;
  out fltOut: Single): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
    Result := CResult[TryStrToFloat(strIn, fltOut)];
end;

function BackupVarR8FromStr(const strIn: _POleStr; LCID: Integer; dwFlags: Longint;
  out dblOut: Double): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
    Result := CResult[TryStrToFloat(strIn, dblOut)];
end;

function BackupVarDateFromStr(const strIn: _POleStr; LCID: DWORD; dwFlags: Longint;
  out dateOut: TDateTime): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
    Result := CResult[TryStrToDateTime(strIn, dateOut)];
end;

function BackupVarCyFromStr(const strIn: _POleStr; LCID: DWORD; dwFlags: Longint;
  out cyOut: Currency): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
    Result := CResult[TryStrToCurr(strIn, cyOut)];
end;

function BackupVarBoolFromStr(const strIn: _POleStr; LCID: Integer; dwFlags: Longint;
  out boolOut: WordBool): HRESULT; stdcall;
var
  LBoolean: Boolean;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
  begin
    Result := CResult[TryStrToBool(strIn, LBoolean)];
    boolOut := LBoolean;
  end;
end;


//{$IFNDEF NEXTGEN}
function BackupVarBStrFromCy(cyIn: Currency; LCID: Integer; dwFlags: Longint;
  out bstrOut: WideString): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
  begin
    bstrOut := CurrToStr(cyIn);
    Result := VAR_OK;
  end;
end;

function BackupVarBStrFromDate(dateIn: TDateTime; LCID: Integer; dwFlags: Longint;
  out bstrOut: WideString): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
  begin
    bstrOut := DateTimeToStr(dateIn);
    Result := VAR_OK;
  end;
end;

function BackupVarBStrFromBool(boolIn: WordBool; LCID: Integer; dwFlags: Longint;
  out bstrOut: WideString): HRESULT; stdcall;
begin
  if LCID <> VAR_LOCALE_USER_DEFAULT then
    Result := VAR_NOTIMPL
  else
  begin
    bstrOut := BoolToStr(boolIn, True);
    Result := VAR_OK;
  end;
end;
//{$ENDIF !NEXTGEN}

{******************************************************************************}
{ SafeArray Functions                                                          }
{******************************************************************************}

{$IFNDEF CPUX64}
function SafeArrayCreate(VarType, DimCount: Integer; const Bounds: TVarArrayBoundArray): PVarArray;
begin
  Result := SafeArrayCreate(VarType, DimCount, @Bounds);
end;
{$ENDIF}

function SafeArrayRedim(VarArray: PVarArray; const NewBound: TVarArrayBound): HRESULT;
begin
  Result := SafeArrayRedim(VarArray, @NewBound);
end;

{$IF not GenericSafeArrays}
function SafeArrayCreate(VarType, DimCount: Integer;
  Bounds: PVarArrayBoundArray): PVarArray; external oleaut name 'SafeArrayCreate';
function SafeArrayAllocDescriptor; external oleaut name 'SafeArrayAllocDescriptor';
function SafeArrayAllocData; external oleaut name 'SafeArrayAllocData';
function SafeArrayDestroy; external oleaut name 'SafeArrayDestroy';
function SafeArrayDestroyDescriptor; external oleaut name 'SafeArrayDestroyDescriptor';
function SafeArrayDestroyData; external oleaut name 'SafeArrayDestroyData';
function SafeArrayRedim(VarArray: PVarArray; NewBound: PVarArrayBound): HRESULT; external oleaut name 'SafeArrayRedim';
function SafeArrayCopy; external oleaut name 'SafeArrayCopy';
function SafeArrayCopyData; external oleaut name 'SafeArrayCopyData';
function SafeArrayGetLBound; external oleaut name 'SafeArrayGetLBound';
function SafeArrayGetUBound; external oleaut name 'SafeArrayGetUBound';
function SafeArrayGetDim; external oleaut name 'SafeArrayGetDim';
function SafeArrayAccessData; external oleaut name 'SafeArrayAccessData';
function SafeArrayUnaccessData; external oleaut name 'SafeArrayUnaccessData';
function SafeArrayLock; external oleaut name 'SafeArrayLock';
function SafeArrayUnlock; external oleaut name 'SafeArrayUnlock';
function SafeArrayGetElement; external oleaut name 'SafeArrayGetElement';
function SafeArrayPutElement; external oleaut name 'SafeArrayPutElement';
function SafeArrayPtrOfIndex; external oleaut name 'SafeArrayPtrOfIndex';
function SafeArrayGetElemSize; external oleaut name 'SafeArrayGetElemsize';

{$ELSE}
type
  TSafeArrayValidateCheck = (savLockCheck);
  TSafeArrayValidateChecks = set of TSafeArrayValidateCheck;
const
  cCheckAll: TSafeArrayValidateChecks = [savLockCheck];

function SafeArrayValidate(VarArray: PVarArray; AndCheck: TSafeArrayValidateChecks = []): HRESULT;
const
  cResults: array [Boolean] of HRESULT = (VAR_INVALIDARG, VAR_OK);
  cLockResult: array [Boolean] of HRESULT = (VAR_ARRAYISLOCKED, VAR_OK);
begin
  Result := cResults[VarArray <> nil];
  if (savLockCheck in AndCheck) and
     (Result = VAR_OK)  then
    Result := cLockResult[VarArray^.LockCount = 0];
end;

function SafeArrayCalculateElementAddress(VarArray: PVarArray; AElement: Integer): Pointer;
begin
  Result := Pointer(PByte(VarArray^.Data) + (AElement * VarArray^.ElementSize));
end;

function SafeArrayValidateAndCalculateAddress(VarArray: PVarArray;
  Indices: PVarArrayCoorArray; var Address: Pointer; Lockit: Boolean): HRESULT;
var
  LDim: Integer;
  LElement: Integer;
  LDimensionSize: Integer;
  C1: Integer;
  Bound: TVarArrayBound;
  BoundsIndex: Integer;
begin
  // validate the array
  Result := SafeArrayValidate(VarArray);

  // if all is swell so far
  if Result = VAR_OK then
  begin
    Address := nil;
    LElement := 0;
    LDimensionSize := 1;
{$RANGECHECKS OFF}
    //Validate Initial Index
    BoundsIndex := VarArray^.DimCount -1; //Start from last Bound (since they are reversed in the VarArray)
    Bound := VarArray^.Bounds[BoundsIndex];

    C1 := Indices^[0];
    Inc(LElement, C1 - Bound.LowBound);

    if (C1 < Bound.LowBound) or
       (C1 >= (Bound.LowBound + Bound.ElementCount)) then
      Result := VAR_BADINDEX;

    if Result = VAR_OK then
    begin
      //Only loop on dimensions above the first dimension
      for LDim := 1 to VarArray^.DimCount -1 do
      begin
        LDimensionSize := LDimensionSize * Bound.ElementCount;
        Dec(BoundsIndex);
        Bound := VarArray^.Bounds[BoundsIndex];

        if (Bound.ElementCount = 0) or
           (Indices^[LDim] < Bound.LowBound) or
           (Indices^[Ldim] >= (Bound.LowBound + Bound.ElementCount)) then
          begin
            Result := VAR_BADINDEX;
            break;
          end;

        Inc(LElement, (Indices^[LDim] - Bound.LowBound) * LDimensionSize);
      end;
    end;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}

    // all is swell?
    if Result = VAR_OK then
    begin
      Address := SafeArrayCalculateElementAddress(VarArray, LElement);

      // finally lets lock it we need to
      if LockIt then
        Result := SafeArrayLock(VarArray);
    end;
  end;
end;

function SafeArrayElementTotal(VarArray: PVarArray): Integer;
var
  LDim: Integer;
begin
  Result := 1;
  for LDim := 0 to VarArray^.DimCount - 1 do
{$RANGECHECKS OFF}
    Result := Result * VarArray^.Bounds[LDim].ElementCount;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}
end;

type
  TElementStyle = (esNormal, esReference, esOleStr, esVariant);

function SafeArrayElementStyle(VarArray: PVarArray): TElementStyle;
begin
  // interface type thingy
  if ((VarArray^.Flags and ARR_DISPATCH) <> 0) or
     ((VarArray^.Flags and ARR_UNKNOWN) <> 0) then
    Result := esReference

  // string type thingy
  else if (VarArray^.Flags and ARR_OLESTR) <> 0 then
    Result := esOleStr

  // variant type thingy
  else if (VarArray^.Flags and ARR_VARIANT) <> 0 then
    Result := esVariant

  // otherwise is just a normal thingy
  else
    Result := esNormal;
end;

function SafeArrayClearDataSpace(VarArray: PVarArray; WipeBytes: Boolean = True): HRESULT;
var
  LElement: Integer;
  LAddress: Pointer;
  LElementStyle: TElementStyle;
begin
  Result := VAR_OK;

  // just in case
  try

    // what type of data do we have?
    LElementStyle := SafeArrayElementStyle(VarArray);
    case LElementStyle of

      // simple fill
      esNormal:
        if WipeBytes then
          FillChar(VarArray^.Data^, SafeArrayElementTotal(VarArray) *
                                    VarArray^.ElementSize, 0);

      // we have to go though each element
      esReference, esOleStr, esVariant:
        for LElement := 0 to SafeArrayElementTotal(VarArray) - 1 do
        begin
          LAddress := SafeArrayCalculateElementAddress(VarArray, LElement);

          // do the right thing
          case LElementStyle of
            esReference:
              IUnknown(PUnknown(LAddress)^) := nil;
            esOleStr:
              _OleStr(PPointer(LAddress)^) := '';
            esVariant:
              Result := VariantClear(PVarData(LAddress)^);
          else
            Result := VAR_EXCEPTION;
          end;
        end;
    end;

  // oops!
  except
    // something really really bad happened
    on EOutOfMemory do
      Result := VAR_OUTOFMEMORY;

  // catch all else
  else
    Result := VAR_EXCEPTION;
  end;
end;

function SafeArrayCopyDataSpace(SourceArray, TargetArray: PVarArray): HRESULT;
var
  LElement: Integer;
  LSource, LTarget: Pointer;
  LElementStyle: TElementStyle;
begin
  Result := VAR_OK;

  // just in case
  try

    // what type of data do we have?
    LElementStyle := SafeArrayElementStyle(SourceArray);
    case LElementStyle of

      // simple fill
      esNormal:
        Move(SourceArray^.Data^, TargetArray^.Data^, SafeArrayElementTotal(SourceArray) *
                                                     SourceArray^.ElementSize);

      // we have to go though each element
      esReference, esOleStr, esVariant:
        for LElement := 0 to SafeArrayElementTotal(SourceArray) - 1 do
        begin
          LSource := SafeArrayCalculateElementAddress(SourceArray, LElement);
          LTarget := SafeArrayCalculateElementAddress(TargetArray, LElement);

          // do the right thing
          case LElementStyle of
            esReference:
              IUnknown(PUnknown(LTarget)^) := IUnknown(PUnknown(LSource)^);
            esOleStr:
              _OleStr(PPointer(LTarget)^) := PPWideChar(LSource)^;
            esVariant:
              Result := VariantCopy(PVarData(LTarget)^, PVarData(LSource)^);
          else
            Result := VAR_EXCEPTION;
          end;
        end;
    end;

  // oops!
  except
    // something really really bad happened
    on EOutOfMemory do
      Result := VAR_OUTOFMEMORY;

  // catch all else
  else
    Result := VAR_EXCEPTION;
  end;
end;

function SafeArrayAllocMem(const Size: LongWord): Pointer;
begin
  {$IF GenericSafeArrayUsesLibC}
  Result := Posix.Stdlib.calloc(1, Size);
  {$ELSE}
  Result := AllocMem(Size);
  {$ENDIF}
end;

procedure SafeArrayFreeMem(const Address: Pointer);
begin
  {$IF GenericSafeArrayUsesLibC}
  Posix.Stdlib.free(Address);
  {$ELSE}
  FreeMem(Address);
  {$ENDIF}
end;

procedure SafeArrayReallocMem(var Address: Pointer; const OldSize, NewSize: LongWord);
var
  Temp: Pointer;
  Amount: LongWord;
begin
  if Address <> nil then
  begin
    if NewSize > 0 then
    begin
      Temp := SafeArrayAllocMem(NewSize);
      if NewSize > OldSize then
        Amount := OldSize
      else
        Amount := NewSize;

      Move(Address^, Temp^, Amount); //Was copying random data when it used NewSize
      SafeArrayFreeMem(Address);
      Address := Temp;
    end
    else
    begin
      SafeArrayFreeMem(Address);
      Address := nil;
    end;
  end else
    Address := SafeArrayAllocMem(NewSize);
end;

function SafeArrayCreate(VarType, DimCount: Integer; Bounds: PVarArrayBoundArray): PVarArray;
var
  LResult: HRESULT;
  LDim: Integer;
begin
  Result := nil;

  // is this something we want to deal with?
  if (VarType in [CMinArrayVarType..CMaxArrayVarType]) and
     CVarTypeToElementInfo[VarType].ValidBase then
  begin

    // make room for the descriptor
    LResult := SafeArrayAllocDescriptor(DimCount, Result);
    if LResult = VAR_OK then
    begin

      // add our bits of information
      Result^.DimCount := DimCount;
      Result^.Flags := cVarTypeToElementInfo[VarType].Flags;
      Result^.ElementSize := cVarTypeToElementInfo[VarType].Size;

      // fill in the bounds info
      for LDim := 0 to Result^.DimCount - 1 do
      begin
{$RANGECHECKS OFF}
        Result^.Bounds[LDim].ElementCount := Bounds[DimCount - LDim - 1].ElementCount;
        Result^.Bounds[LDim].LowBound := Bounds[DimCount - LDim - 1].LowBound;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}
      end;

      // try to allocate the data
      LResult := SafeArrayAllocData(Result);

      // if not then get rid of the descriptor
      if LResult <> VAR_OK then
      begin
        SafeArrayDestroyDescriptor(Result);
        Result := nil;
      end;
    end;
  end;
end;

function SafeArrayAllocDescriptor(DimCount: Integer; out VarArray: PVarArray): HRESULT;
begin
  Result := VAR_OK;

  // give it a shot
  try
    VarArray := SafeArrayAllocMem(SizeOf(TVarArray) + SizeOf(TVarArrayBound) * (DimCount - 1));
  except
    // something really really bad happened
    on EOutOfMemory do
      Result := VAR_OUTOFMEMORY;

  // catch all else
  else
    Result := VAR_UNEXPECTED;
  end;
end;

function SafeArrayAllocData(VarArray: PVarArray): HRESULT;
begin
  Result := VAR_OK;

  // give it a shot
  try
    VarArray^.Data := SafeArrayAllocMem(SafeArrayElementTotal(VarArray) *
                                        VarArray^.ElementSize);
  except
    // something really really bad happened
    on EOutOfMemory do
      Result := VAR_OUTOFMEMORY;

  // catch all else
  else
    Result := VAR_UNEXPECTED;
  end;
end;

function SafeArrayDestroy(VarArray: PVarArray): HRESULT;
begin
  // all is swell?
  Result := SafeArrayValidate(VarArray, cCheckAll);
  if Result = VAR_OK then
  begin

    // well then lets try to destroy the pieces parts
    Result := SafeArrayDestroyData(VarArray);
    if Result = VAR_OK then
      Result := SafeArrayDestroyDescriptor(VarArray);
  end;
end;

function SafeArrayDestroyDescriptor(VarArray: PVarArray): HRESULT;
begin
  // all is swell?
  Result := SafeArrayValidate(VarArray, cCheckAll);
  if Result = VAR_OK then
  try

    // try and free it then
    SafeArrayFreeMem(VarArray);
  except
    Result := VAR_UNEXPECTED;
  end;
end;

function SafeArrayDestroyData(VarArray: PVarArray): HRESULT;
begin
  // all is swell?
  Result := SafeArrayValidate(VarArray, cCheckAll);
  if Result = VAR_OK then
  try

    // slick the data space
    Result := SafeArrayClearDataSpace(VarArray, False);

    // if all is swell and, if we are supposed to, free the data
    if (Result = VAR_OK) and
       ((VarArray^.Flags and ARR_FIXEDSIZE) = 0) then
    begin
      SafeArrayFreeMem(VarArray^.Data);
      VarArray^.Data := nil;
    end;
  except
    Result := VAR_UNEXPECTED;
  end;
end;

function SafeArrayRedim(VarArray: PVarArray; NewBound: PVarArrayBound): HRESULT;
var
  LDim, LDelta: Integer;
  LTotal, LElement: Integer;
  LAddress: Pointer;
  LElementStyle: TElementStyle;
begin
  // check out the array
  Result := SafeArrayValidate(VarArray, cCheckAll);
  if Result = VAR_OK then
  begin
    if (VarArray^.Flags and ARR_FIXEDSIZE) <> 0 then
      Result := VAR_INVALIDARG;

    // is still swell?
    if Result = VAR_OK then
    begin
      Result := SafeArrayLock(VarArray);
      if Result = VAR_OK then
      try
        try

          // calculate the delta
{$RANGECHECKS OFF}
          LDelta := NewBound.ElementCount - VarArray^.Bounds[0].ElementCount;
          for LDim := 1 to VarArray^.DimCount - 1 do
            LDelta := LDelta * VarArray^.Bounds[LDim].ElementCount;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}

          // any change?
          if LDelta <> 0 then
          begin

            // how big are we currently?
            LTotal := SafeArrayElementTotal(VarArray);

            // make things shorter?
            if LDelta < 0 then
            begin

              // what type of stuff are we dealing with?
              LElementStyle := SafeArrayElementStyle(VarArray);

              // for each element
              for LElement := LTotal - 1 downto LTotal + LDelta do { Delta is negative }
              begin
                LAddress := SafeArrayCalculateElementAddress(VarArray, LElement);

                // do the right thing
                case LElementStyle of
                  esReference:
                    IUnknown(PUnknown(LAddress)^) := nil;
                  esOleStr:
                    _OleStr(PPointer(LAddress)^) := '';
                  esVariant:
                    Result := VariantClear(PVarData(LAddress)^);
                  esNormal:
                    FillChar(LAddress^, VarArray^.ElementSize,0);
                else
                  Result := VAR_EXCEPTION;
                end;
              end;
            end;

            // failure?
            if Result <> VAR_OK then
              Exit;

            // regrab the memory
            SafeArrayReallocMem(VarArray^.Data,
                                LTotal * VarArray^.ElementSize,
                                (LTotal + LDelta) * VarArray^.ElementSize);
          end;

          // copy over the new bound info
          VarArray^.Bounds[0].ElementCount := NewBound.ElementCount;
          VarArray^.Bounds[0].LowBound := NewBound.LowBound;

        // oops!
        except

          // something really really bad happened
          on EOutOfMemory do
            Result := VAR_OUTOFMEMORY;

        // catch all else
        else
          Result := VAR_EXCEPTION;
        end;

      // put away our toys
      finally
        if Result = VAR_OK then
          Result := SafeArrayUnlock(VarArray)
        else
          SafeArrayUnlock(VarArray);
      end;
    end;
  end;
end;

function SafeArrayCopy(SourceArray: PVarArray; out TargetArray: PVarArray): HRESULT;
var
  LDim: Integer;
begin
  // check out the source array
  Result := SafeArrayValidate(SourceArray);
  if Result = VAR_OK then
  begin
    Result := SafeArrayLock(SourceArray);
    if Result = VAR_OK then
    try //and
      try // again

        // make room for the descriptor
        Result := SafeArrayAllocDescriptor(SourceArray^.DimCount, TargetArray);
        if Result = VAR_OK then
        try

          // add our bits of information
          TargetArray^.DimCount := SourceArray^.DimCount;
          TargetArray^.Flags := SourceArray^.Flags;
          TargetArray^.ElementSize := SourceArray^.ElementSize;

          // fill in the bounds info
          for LDim := 0 to TargetArray^.DimCount - 1 do
          begin
{$RANGECHECKS OFF}
            TargetArray^.Bounds[LDim].ElementCount := SourceArray^.Bounds[LDim].ElementCount;
            TargetArray^.Bounds[LDim].LowBound := SourceArray^.Bounds[LDim].LowBound;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}
          end;

          // try to allocate the data
          Result := SafeArrayAllocData(TargetArray);

          // now copy it!
          if Result = VAR_OK then
            Result := SafeArrayCopyDataSpace(SourceArray, TargetArray);

        // remember to clean up if needed
        finally
          if Result <> VAR_OK then
          begin
            SafeArrayDestroyDescriptor(TargetArray);
            TargetArray := nil;
          end;
        end;

      // oops!
      except

        // something really really bad happened
        on EOutOfMemory do
          Result := VAR_OUTOFMEMORY;

      // catch all else
      else
        Result := VAR_EXCEPTION;
      end;

    // put away our toys
    finally
      if Result = VAR_OK then
        Result := SafeArrayUnlock(SourceArray)
      else
        SafeArrayUnlock(SourceArray);
    end;
  end;
end;

function SafeArrayCopyData(SourceArray, TargetArray: PVarArray): HRESULT;
var
  LDim: Integer;
begin
  // check out the source array
  Result := SafeArrayValidate(SourceArray);
  if Result = VAR_OK then
  begin
    Result := SafeArrayLock(SourceArray);
    if Result = VAR_OK then
    try

      // check out the target array
      Result := SafeArrayValidate(TargetArray);
      if Result = VAR_OK then
      begin
        Result := SafeArrayLock(TargetArray);
        if Result = VAR_OK then
        try

          // now make sure the two arrays are similar
          if (SourceArray^.DimCount <> TargetArray^.DimCount) or
             (SourceArray^.Flags <> TargetArray^.Flags) or
             (SourceArray^.ElementSize <> TargetArray^.ElementSize) then
            Result := VAR_INVALIDARG
          else
          begin

            // now make sure the bounds match
            for LDim := 0 to SourceArray^.DimCount - 1 do
{$RANGECHECKS OFF}
              if (SourceArray^.Bounds[LDim].LowBound <> TargetArray^.Bounds[LDim].LowBound) or
                 (SourceArray^.Bounds[LDim].ElementCount <> TargetArray^.Bounds[LDim].ElementCount) then
              begin
                Result := VAR_INVALIDARG;
                Break;
              end;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}
            // if all is still well then lets copy the data
            if Result = VAR_OK then
            begin

              // clear the destination
              Result := SafeArrayClearDataSpace(TargetArray);

              // if all is still swell then copy the data space
              if Result = VAR_OK then
                Result := SafeArrayCopyDataSpace(SourceArray, TargetArray);
            end;
          end;

        // put away our toys
        finally
          if Result = VAR_OK then
            Result := SafeArrayUnlock(TargetArray)
          else
            SafeArrayUnlock(TargetArray);
        end;
      end;
    finally
      if Result = VAR_OK then
        Result := SafeArrayUnlock(SourceArray)
      else
        SafeArrayUnlock(SourceArray);
    end;
  end;
end;

function SafeArrayGetLBound(VarArray: PVarArray; Dim: Integer; out LBound: Integer): HRESULT;
begin
  Result := SafeArrayValidate(VarArray);
  if Result = VAR_OK then
    if (Dim < 1) or (Dim > VarArray^.DimCount) then
      Result := VAR_BADINDEX
    else
{$RANGECHECKS OFF}
      LBound := VarArray^.Bounds[VarArray^.DimCount - Dim].LowBound;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}
end;

function SafeArrayGetUBound(VarArray: PVarArray; Dim: Integer; out UBound: Integer): HRESULT;
begin
  Result := SafeArrayValidate(VarArray);
  if Result = VAR_OK then
    if (Dim < 1) or (Dim > VarArray^.DimCount) then
      Result := VAR_BADINDEX
    else
{$RANGECHECKS OFF}
      UBound := VarArray^.Bounds[VarArray^.DimCount - Dim].LowBound +
                VarArray^.Bounds[VarArray^.DimCount - Dim].ElementCount - 1;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}
end;

function SafeArrayGetDim(VarArray: PVarArray): Integer;
begin
  Result := 0;
  if SafeArrayValidate(VarArray) = VAR_OK then
    Result := VarArray^.DimCount;
end;

function SafeArrayAccessData(VarArray: PVarArray; out Data: Pointer): HRESULT;
begin
  Result := SafeArrayLock(VarArray);
  if Result = VAR_OK then
    Data := VarArray^.Data;
end;

function SafeArrayUnaccessData(VarArray: PVarArray): HRESULT;
begin
  Result := SafeArrayUnlock(VarArray);
end;

function SafeArrayLock(VarArray: PVarArray): HRESULT;
begin
  Result := SafeArrayValidate(VarArray);
  if Result = VAR_OK then
    Inc(VarArray^.LockCount);
end;

function SafeArrayUnlock(VarArray: PVarArray): HRESULT;
begin
  Result := SafeArrayValidate(VarArray);
  if (Result = VAR_OK) and
     (VarArray^.LockCount > 0) then
    Dec(VarArray^.LockCount);
end;

function SafeArrayGetElement(VarArray: PVarArray; Indices: PVarArrayCoorArray;
  Data: Pointer): HRESULT;
var
  LAddress: Pointer;
begin
  Result := SafeArrayValidateAndCalculateAddress(VarArray, Indices, LAddress, True);
  if Result = VAR_OK then
  try //and
    try // again

      // data type please
      case SafeArrayElementStyle(VarArray) of
        esNormal:
          Move(LAddress^, Data^, VarArray^.ElementSize);
        esReference:
          IUnknown(PUnknown(Data)^) := IUnknown(PUnknown(LAddress)^);
        esOleStr:
          _OleStr(PPointer(Data)^) := PPWideChar(LAddress)^;
        esVariant:
          VariantCopy(PVarData(Data)^, PVarData(LAddress)^);
      end;

    // oops!
    except

      // something really really bad happened
      on EOutOfMemory do
        Result := VAR_OUTOFMEMORY;

    // catch all else
    else
      Result := VAR_EXCEPTION;
    end;

  // clean up please
  finally
    if Result = VAR_OK then
      Result := SafeArrayUnlock(VarArray)
    else
      SafeArrayUnlock(VarArray);
  end;
end;

function SafeArrayPutElement(VarArray: PVarArray; Indices: PVarArrayCoorArray;
  const Data: Pointer): HRESULT;
var
  LAddress: Pointer;
begin
  Result := SafeArrayValidateAndCalculateAddress(VarArray, Indices, LAddress, True);
  if Result = VAR_OK then
  try // and
    try // again

      // data type please
      case SafeArrayElementStyle(VarArray) of
        esNormal:
          Move(Data^, LAddress^, VarArray^.ElementSize);
        esReference:
          IUnknown(PUnknown(LAddress)^) := IUnknown(PUnknown(Data)^);
        esOleStr:
          _OleStr(PPointer(LAddress)^) := PWideChar(Data);
        esVariant:
          VariantCopy(PVarData(LAddress)^, PVarData(Data)^);
      end;

    // oops!
    except
      // something really really bad happened
      on EOutOfMemory do
        Result := VAR_OUTOFMEMORY;

    // catch all else
    else
      Result := VAR_EXCEPTION;
    end;

  // clean up please
  finally
    if Result = VAR_OK then
      Result := SafeArrayUnlock(VarArray)
    else
      SafeArrayUnlock(VarArray);
  end;
end;

function SafeArrayPtrOfIndex(VarArray: PVarArray; Indices: PVarArrayCoorArray;
  var Address: Pointer): HRESULT;
begin
  // call the common code
  Result := SafeArrayValidateAndCalculateAddress(VarArray, Indices, Address, False);
end;

function SafeArrayGetElemSize(VarArray: PVarArray): LongWord;
begin
  Result := 0;
  if SafeArrayValidate(VarArray) = VAR_OK then
    Result := VarArray^.ElementSize;
end;
{$ENDIF}

procedure SafeArrayCreateError;
begin
  raise ESafeArrayCreateError.Create(SVarArrayCreate);
end;

procedure SafeArrayCheck(AResult: HRESULT);
begin
  if AResult and $80000000 <> 0 then
    SafeArrayError(AResult);
end;

procedure SafeArrayError(AResult: HRESULT);
begin
  case AResult of
    VAR_BADINDEX:      raise ESafeArrayBoundsError.CreateHResult(AResult, SVarArrayBounds);
    VAR_ARRAYISLOCKED: raise ESafeArrayLockedError.CreateHResult(AResult, SVarArrayLocked);
  else
    raise ESafeArrayError.CreateHResult(AResult);
  end;
end;

constructor ESafeArrayError.CreateHResult(AResult: HRESULT; const AMessage: string);
var
  S: string;
begin
  S := AMessage;
  if S = '' then
    S := Format(SVarArrayWithHResult, [HexDisplayPrefix, AResult]);
  Create(S);
  FErrorCode := AResult;
end;

{$IFDEF MSWINDOWS}
procedure InitializeVarUtils;
var
  LHandle: THandle;

  function FindProc(const AName: MarshaledAString; ADefault: Pointer): Pointer;
  begin
    Result := ADefault;
    if LHandle <> 0 then
    begin
      Result := GetProcAddress(LHandle, AName);
      if not Assigned(Result) then
        Result := ADefault;
    end;
  end;

begin
  LHandle := GetModuleHandle(oleaut);

{$IF GenericVariants} // portable code
  VariantChangeTypeEx := BackupVariantChangeTypeEx;

{$ELSE} // oleaut32 code
  VariantChangeTypeEx := FindProc('VariantChangeTypeEx', @BackupVariantChangeTypeEx);
{$ENDIF}

{$IF GenericOperations} // portable code
  VarNeg := UniUnimplemented;
  VarNot := UniUnimplemented;

  VarAdd := BiUnimplemented;
  VarSub := BiUnimplemented;
  VarMul := BiUnimplemented;
  VarDiv := BiUnimplemented;
  VarIDiv := BiUnimplemented;
  VarMod := BiUnimplemented;
  VarAnd := BiUnimplemented;
  VarOr := BiUnimplemented;
  VarXor := BiUnimplemented;

  VarCmp := CmpUnimplemented;

  VarI4FromStr := BackupVarI4FromStr;
  VarR4FromStr := BackupVarR4FromStr;
  VarR8FromStr := BackupVarR8FromStr;
  VarDateFromStr := BackupVarDateFromStr;
  VarCyFromStr := BackupVarCyFromStr;
  VarBoolFromStr := BackupVarBoolFromStr;

//{$IFNDEF NEXTGEN}
  VarBstrFromCy := BackupVarBstrFromCy;
  VarBstrFromDate := BackupVarBstrFromDate;
  VarBstrFromBool := BackupVarBstrFromBool;
//{$ENDIF NEXTGEN}

{$ELSE} // oleaut32 code
  VarNeg := FindProc('VarNeg', @UniUnimplemented);
  VarNot := FindProc('VarNot', @UniUnimplemented);

  VarAdd := FindProc('VarAdd', @BiUnimplemented);
  VarSub := FindProc('VarSub', @BiUnimplemented);
  VarMul := FindProc('VarMul', @BiUnimplemented);
  VarDiv := FindProc('VarDiv', @BiUnimplemented);
  VarIDiv := FindProc('VarIdiv', @BiUnimplemented);
  VarMod := FindProc('VarMod', @BiUnimplemented);
  VarAnd := FindProc('VarAnd', @BiUnimplemented);
  VarOr := FindProc('VarOr', @BiUnimplemented);
  VarXor := FindProc('VarXor', @BiUnimplemented);

  VarCmp := FindProc('VarCmp', @CmpUnimplemented);

  VarI4FromStr := FindProc('VarI4FromStr', @BackupVarI4FromStr);
  VarR4FromStr := FindProc('VarR4FromStr', @BackupVarR4FromStr);
  VarR8FromStr := FindProc('VarR8FromStr', @BackupVarR8FromStr);
  VarDateFromStr := FindProc('VarDateFromStr', @BackupVarDateFromStr);
  VarCyFromStr := FindProc('VarCyFromStr', @BackupVarCyFromStr);
  VarBoolFromStr := FindProc('VarBoolFromStr', @BackupVarBoolFromStr);

//{$IFNDEF NEXTGEN}
  VarBstrFromCy := FindProc('VarBstrFromCy', @BackupVarBstrFromCy);
  VarBstrFromDate := FindProc('VarBstrFromDate', @BackupVarBstrFromDate);
  VarBstrFromBool := FindProc('VarBstrFromBool', @BackupVarBstrFromBool);
//{$ENDIF NEXTGEN}
{$ENDIF}
end;
{$ENDIF}

{$IFDEF POSIX}
procedure InitializeVarUtils;
begin
  VariantChangeTypeEx := BackupVariantChangeTypeEx;

  VarNeg := UniUnimplemented;
  VarNot := UniUnimplemented;

  VarAdd := BiUnimplemented;
  VarSub := BiUnimplemented;
  VarMul := BiUnimplemented;
  VarDiv := BiUnimplemented;
  VarIDiv := BiUnimplemented;
  VarMod := BiUnimplemented;
  VarAnd := BiUnimplemented;
  VarOr := BiUnimplemented;
  VarXor := BiUnimplemented;

  VarCmp := CmpUnimplemented;

  VarI4FromStr := BackupVarI4FromStr;
  VarR4FromStr := BackupVarR4FromStr;
  VarR8FromStr := BackupVarR8FromStr;
  VarDateFromStr := BackupVarDateFromStr;
  VarCyFromStr := BackupVarCyFromStr;
  VarBoolFromStr := BackupVarBoolFromStr;

  VarBstrFromCy := BackupVarBstrFromCy;
  VarBstrFromDate := BackupVarBstrFromDate;
  VarBstrFromBool := BackupVarBstrFromBool;
end;
{$ENDIF}

initialization
  InitializeVarUtils;
end.
