{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{                   Variants Unit                       }
{*******************************************************}

unit System.Variants;

{$LONGSTRINGS ON}
{$OPTIMIZATION ON}
{$STACKFRAMES OFF}
{$BOOLEVAL OFF}
{$WARN IMPLICIT_STRING_CAST OFF}
{$WARN IMPLICIT_STRING_CAST_LOSS OFF}
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN UNSAFE_VOID_POINTER OFF}

{$IFDEF CPUX86}
  {$IFNDEF PUREPASCAL}
    {$DEFINE X86ASM}
  {$ENDIF !PUREPASCAL}
{$ELSE !CPUX86}
  {$DEFINE PUREPASCAL}
  {$DEFINE PUREPASCAL_X64ONLY}
{$ENDIF !CPUX86}

interface

uses
  System.Types, System.SysUtils;

{ Variant support procedures and functions }

function VarType(const V: Variant): TVarType; inline;
function VarAsType(const V: Variant; AVarType: TVarType): Variant;
function VarIsType(const V: Variant; AVarType: TVarType): Boolean; overload;
function VarIsType(const V: Variant; const AVarTypes: array of TVarType): Boolean; overload;
function VarIsByRef(const V: Variant): Boolean;

function VarIsEmpty(const V: Variant): Boolean;
procedure VarCheckEmpty(const V: Variant);
function VarIsNull(const V: Variant): Boolean;
function VarIsClear(const V: Variant): Boolean;

function VarIsCustom(const V: Variant): Boolean;
function VarIsOrdinal(const V: Variant): Boolean;
function VarIsFloat(const V: Variant): Boolean;
function VarIsNumeric(const V: Variant): Boolean;
function VarIsStr(const V: Variant): Boolean;

function VarToStr(const V: Variant): string;
function VarToStrDef(const V: Variant; const ADefault: string): string;
{$IFNDEF NEXTGEN}
function VarToWideStr(const V: Variant): WideString;
function VarToWideStrDef(const V: Variant; const ADefault: WideString): WideString;
{$ENDIF !NEXTGEN}

function VarToDateTime(const V: Variant): TDateTime;
function VarFromDateTime(const DateTime: TDateTime): Variant;

function VarInRange(const AValue, AMin, AMax: Variant): Boolean;
function VarEnsureRange(const AValue, AMin, AMax: Variant): Variant;

type
  TVariantRelationship = (vrEqual, vrLessThan, vrGreaterThan, vrNotEqual);

function VarSameValue(const A, B: Variant): Boolean;
function VarCompareValue(const A, B: Variant): TVariantRelationship;

function VarIsEmptyParam(const V: Variant): Boolean;

function VarIsError(const V: Variant; out AResult: HRESULT): Boolean; overload;
function VarIsError(const V: Variant): Boolean; overload;
function VarAsError(AResult: HRESULT): Variant;

function VarSupports(const V: Variant; const IID: TGUID; out Intf): Boolean; overload;
function VarSupports(const V: Variant; const IID: TGUID): Boolean; overload;

{ Variant copy support }

procedure VarCopyNoInd(var Dest: Variant; const Source: Variant);

{ Variant array support procedures and functions }

function VarIsArray(const A: Variant): Boolean; overload;
function VarIsArray(const A: Variant; AResolveByRef: Boolean): Boolean; overload;

function VarArrayCreate(const Bounds: array of Integer; AVarType: TVarType): Variant;
function VarArrayOf(const Values: array of Variant): Variant;

function VarArrayRef(const A: Variant): Variant;

function VarTypeIsValidArrayType(const AVarType: TVarType): Boolean;
function VarTypeIsValidElementType(const AVarType: TVarType): Boolean;

{ The following functions will handle normal variant arrays as well as
  variant arrays references by another variant using byref }

function VarArrayDimCount(const A: Variant): Integer;
function VarArrayLowBound(const A: Variant; Dim: Integer): Integer;
function VarArrayHighBound(const A: Variant; Dim: Integer): Integer;

function VarArrayLock(const A: Variant): Pointer;
procedure VarArrayUnlock(const A: Variant);

function VarArrayAsPSafeArray(const A: Variant): PVarArray;

function VarArrayGet(const A: Variant; const Indices: array of Integer): Variant;
procedure VarArrayPut(var A: Variant; const Value: Variant; const Indices: array of Integer);

{ Variant Arrays <--> Dynamic Arrays }

procedure DynArrayToVariant(var V: Variant; const DynArray: Pointer; TypeInfo: Pointer);
procedure DynArrayFromVariant(var DynArray: Pointer; const V: Variant; TypeInfo: Pointer);

{ Global constants }

function Unassigned: Variant; inline; // Unassigned standard constant
function Null: Variant;         // Null standard constant

                                                                               
{.$DEFINE EMPTYPARAM_VAR}
{$IFDEF EMPTYPARAM_VAR}
var
  EmptyParam: OleVariant;    // "Empty parameter" standard constant which can be
  {$EXTERNALSYM EmptyParam}  // passed as an optional parameter
{$ELSE}
function EmptyParam: OleVariant;// "Empty parameter" standard constant that
{$EXTERNALSYM EmptyParam}       // can be passed as an optional parameter
{$ENDIF}


{ Custom variant base class }

type
  TVarCompareResult = (crLessThan, crEqual, crGreaterThan);
  TCustomVariantType = class(TObject, IInterface)
  private
    FVarType: TVarType;
  protected
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    procedure SimplisticClear(var V: TVarData);
    procedure SimplisticCopy(var Dest: TVarData; const Source: TVarData;
      const Indirect: Boolean = False);

    procedure RaiseInvalidOp;
    procedure RaiseCastError;
    procedure RaiseDispError;

    function LeftPromotion(const V: TVarData; const Operator: TVarOp;
      out RequiredVarType: TVarType): Boolean; virtual;
    function RightPromotion(const V: TVarData; const Operator: TVarOp;
      out RequiredVarType: TVarType): Boolean; virtual;
    function OlePromotion(const V: TVarData;
      out RequiredVarType: TVarType): Boolean; virtual;
    procedure DispInvoke(Dest: PVarData; [Ref] const Source: TVarData;
      CallDesc: PCallDesc; Params: Pointer); virtual;

    procedure VarDataInit(var Dest: TVarData);
    procedure VarDataClear(var Dest: TVarData);

    procedure VarDataCopy(var Dest: TVarData; const Source: TVarData);
    procedure VarDataCopyNoInd(var Dest: TVarData; const Source: TVarData);

    procedure VarDataCast(var Dest: TVarData; const Source: TVarData);
    procedure VarDataCastTo(var Dest: TVarData; const Source: TVarData;
      const AVarType: TVarType); overload;
    procedure VarDataCastTo(var Dest: TVarData; const AVarType: TVarType); overload;
    procedure VarDataCastToOleStr(var Dest: TVarData);

    procedure VarDataFromStr(var V: TVarData; const Value: string);
{$IFNDEF NEXTGEN}
    procedure VarDataFromOleStr(var V: TVarData; const Value: WideString);
    procedure VarDataFromLStr(var V: TVarData; const Value: AnsiString);
{$ENDIF !NEXTGEN}
    function VarDataToStr(const V: TVarData): string;

    function VarDataIsEmptyParam(const V: TVarData): Boolean;
    function VarDataIsByRef(const V: TVarData): Boolean;
    function VarDataIsArray(const V: TVarData): Boolean;

    function VarDataIsOrdinal(const V: TVarData): Boolean;
    function VarDataIsFloat(const V: TVarData): Boolean;
    function VarDataIsNumeric(const V: TVarData): Boolean;
    function VarDataIsStr(const V: TVarData): Boolean;
  public
    constructor Create; overload;
    constructor Create(RequestedVarType: TVarType); overload;
    destructor Destroy; override;
    property VarType: TVarType read FVarType;

    function IsClear(const V: TVarData): Boolean; virtual;
    procedure Cast(var Dest: TVarData; const Source: TVarData); virtual;
    procedure CastTo(var Dest: TVarData; const Source: TVarData;
      const AVarType: TVarType); virtual;
    procedure CastToOle(var Dest: TVarData; const Source: TVarData); virtual;

    // The following two procedures must be overridden by your custom
    //  variant type class.  Simplistic versions of Clear and Copy are
    //  available in the protected section of this class but depending on the
    //  type of data contained in your custom variant type those functions
    //  may not handle your situation.
    procedure Clear(var V: TVarData); virtual; abstract;
    procedure Copy(var Dest: TVarData; const Source: TVarData;
      const Indirect: Boolean); virtual; abstract;

    procedure BinaryOp(var Left: TVarData; const Right: TVarData;
      const Operator: TVarOp); virtual;
    procedure UnaryOp(var Right: TVarData; const Operator: TVarOp); virtual;
    function CompareOp(const Left, Right: TVarData;
      const Operator: TVarOp): Boolean; virtual;
    procedure Compare(const Left, Right: TVarData;
      var Relationship: TVarCompareResult); virtual;
  end;
  TCustomVariantTypeClass = class of TCustomVariantType;

  TVarDataArray = array of TVarData;
  IVarInvokeable = interface
    ['{1CB65C52-BBCB-41A6-9E58-7FB916BEEB2D}']
    function DoFunction(var Dest: TVarData; const V: TVarData;
      const Name: string; const Arguments: TVarDataArray): Boolean;
    function DoProcedure(const V: TVarData; const Name: string;
      const Arguments: TVarDataArray): Boolean;
    function GetProperty(var Dest: TVarData; const V: TVarData;
      const Name: string): Boolean;
    function SetProperty(const V: TVarData; const Name: string;
      const Value: TVarData): Boolean;
  end;

  TInvokeableVariantType = class(TCustomVariantType, IVarInvokeable)
  protected
    function FixupIdent(const AText: string): string; virtual;
    procedure DispInvoke(Dest: PVarData; [Ref] const Source: TVarData;
      CallDesc: PCallDesc; Params: Pointer); override;
  public
    { IVarInvokeable }
    function DoFunction(var Dest: TVarData; const V: TVarData;
      const Name: string; const Arguments: TVarDataArray): Boolean; virtual;
    function DoProcedure(const V: TVarData; const Name: string;
      const Arguments: TVarDataArray): Boolean; virtual;
    function GetProperty(var Dest: TVarData; const V: TVarData;
      const Name: string): Boolean; virtual;
    function SetProperty(const V: TVarData; const Name: string;
      const Value: TVarData): Boolean; virtual;
  end;

  IVarInstanceReference = interface
    ['{5C176802-3F89-428D-850E-9F54F50C2293}']
    function GetInstance(const V: TVarData): TObject;
  end;

  function FindCustomVariantType(const AVarType: TVarType;
    out CustomVariantType: TCustomVariantType): Boolean; overload;
  function FindCustomVariantType(const TypeName: string;
    out CustomVariantType: TCustomVariantType): Boolean; overload;

// Variant Dispatch/Unknown/Corba Any callbacks
type
  TAnyProc = procedure (var V: TVarData);
  TVarDispProc = procedure (Dest: PVariant; const Source: Variant;
      CallDesc: PCallDesc; Params: Pointer); cdecl;

var
  VarDispProc: TVarDispProc;
  ClearAnyProc: TAnyProc;  { Handler clearing a varAny }
  ChangeAnyProc: TAnyProc; { Handler to change any to variant }
  RefAnyProc: TAnyProc;    { Handler to add a reference to an varAny }

// exceptions
type
  EVariantInvalidOpError = class(EVariantError);
  EVariantTypeCastError = class(EVariantError);

  EVariantOverflowError = class(EVariantError);
  EVariantInvalidArgError = class(EVariantError);
  EVariantBadVarTypeError = class(EVariantError);

  EVariantBadIndexError = class(EVariantError);
  EVariantArrayLockedError = class(EVariantError);
  EVariantNotAnArrayError = class(EVariantError);
  EVariantArrayCreateError = class(EVariantError);

  EVariantNotImplError = class(EVariantError);
  EVariantOutOfMemoryError = class(EVariantError);
  EVariantUnexpectedError = class(EVariantError);
  EVariantDispatchError = class(EVariantError);

  EVariantRangeCheckError = class(EVariantOverflowError);
  EVariantInvalidNullOpError = class(EVariantInvalidOpError);

// error reporting methods
procedure VarCastError; overload;
procedure VarCastError(const ASourceType, ADestType: TVarType); overload;
procedure VarInvalidOp;
procedure VarInvalidNullOp;
procedure VarOverflowError(const ASourceType, ADestType: TVarType);
procedure VarRangeCheckError(const ASourceType, ADestType: TVarType);
procedure VarArrayCreateError;
procedure VarResultCheck(AResult: HRESULT); overload;
procedure VarResultCheck(AResult: HRESULT; ASourceType, ADestType: TVarType); overload;
procedure HandleConversionException(const ASourceType, ADestType: TVarType);
function VarTypeAsText(const AType: TVarType): string;

// FindVarData will resolve byref variants
function FindVarData(const V: Variant): PVarData;

// Variant control
type
  TNullCompareRule = (ncrError, ncrStrict, ncrLoose);
  TBooleanToStringRule = (bsrAsIs, bsrLower, bsrUpper);

var
  // This controls how NULL variants act when doing EQUALITY (= & <>) comparisons.
  //  ncrError:  comparison causes an exception
  //  ncrStrict: comparison always fails (returns FALSE)
  //  ncrLoose:  simply identity testing works (NULL = NULL and NULL <> OTHER)
  NullEqualityRule: TNullCompareRule = ncrLoose;

  // This controls how NULL variants act when doing MAGNITUDE (> & <) comparisons.
  //  ncrError:  comparison causes an exception
  //  ncrStrict: comparison always fails (returns FALSE)
  //  ncrLoose:  NULLs are treated like empties (similar to how Delphi v5 worked)
  NullMagnitudeRule: TNullCompareRule = ncrLoose;

  // This controls how NULL variants act when doing conversions.  TRUE: will
  //  cause exceptions in undefined cases.  FALSE: will simply cause the
  //  undefined cases to return what, with one exception, Empty normally
  //  would.  The one exception is NULL to string conversion which then will
  //  return the contents of NullAsStringValue, see below.
  NullStrictConvert: Boolean = True;

  // This is the value returned when a NULL is converted into a string.  Other
  //  environments return 'NULL' instead of Delphi's default of an empty string.
  NullAsStringValue: string = '';

  // If TRUE then when variants are created we will try to create the smallest
  //  type possible.  Set this to FALSE to simulate Delphi v5 behavior.
  PackVarCreation: Boolean = True;

  // This controls how we fix up results after doing boolean to string conversions
  //  bsrAsIs:  Result is left alone
  //  bsrLower: Result will be all lowercase
  //  bsrUpper: Result will be all UPPERCASE
  BooleanToStringRule: TBooleanToStringRule = bsrAsIs;

  // If TRUE Int64 values are converted to varDouble for compatibility with
  // Windows 9x/2000 platforms which don't support varInt64 in OleVariant.
  OleVariantInt64AsDouble: Boolean = False;

{ Variant support procedures and functions }
{ DO NOT MODIFY -  Required by compiler codegen - DO NOT MODIFY }

procedure _VarClear(var V: TVarData);
procedure _VarCopy(var Dest: TVarData; const Source: TVarData);
procedure _VarCopyNoInd(var Dest: TVarData; const Source: TVarData);
procedure _VarCast(var Dest: TVarData; const Source: TVarData; AVarType: Integer);
procedure _VarCastOle(var Dest: TVarData; const Source: TVarData; AVarType: Integer);
{$IFNDEF X86ASM}
function _VarClr(var V: TVarData): Pointer;
{$ELSE X86ASM}
procedure _VarClr(var V: TVarData);
{$ENDIF X86ASM}

{ Variant math and conversion support }
{ DO NOT MODIFY -  Required by compiler codegen - DO NOT MODIFY }

function _VarToInteger(const V: TVarData): Integer;
function _VarToInt64(const V: TVarData): Int64;
function _VarToUInt64(const V: TVarData): UInt64;
function _VarToBool(const V: TVarData): LongBool;
function _VarToReal(const V: TVarData): Extended;
function _VarToCurrency(const V: TVarData): Currency;
{$IFNDEF NEXTGEN}
procedure _VarToPStr(var S; const V: TVarData);
procedure _VarToLStr(var S: AnsiString; const V: TVarData);
procedure _VarToWStr(var S: WideString; const V: TVarData);
{$ENDIF !NEXTGEN}
procedure _VarToUStr(var S: UnicodeString; const V: TVarData);
procedure _VarToIntf(var Intf: IInterface; const V: TVarData);
procedure _VarToDisp(var Dispatch: IDispatch; const V: TVarData);
procedure _VarToDynArray(var DynArray: Pointer; const V: TVarData; TypeInfo: Pointer);

procedure _VarFromInt(var V: TVarData; const Value: Integer; const Range: ShortInt);
procedure _VarFromInt64(var V: TVarData; const Value: Int64);
procedure _VarFromUInt64(var V: TVarData; const Value: UInt64);
procedure _VarFromBool(var V: TVarData; const Value: Boolean);
{$IFNDEF X86ASM}
procedure _VarFromReal(var V: TVarData; const Value: Real);
procedure _VarFromTDateTime(var V: TVarData; const Value: TDateTime);
procedure _VarFromCurr(var V: TVarData; const Value: Currency);
{$ELSE !X86ASM}
procedure _VarFromReal; // var V: TVarData; const Value: Real
procedure _VarFromTDateTime; // var V: TVarData; const Value: TDateTime
procedure _VarFromCurr; // var V: TVarData; const Value: Currency
{$ENDIF !X86ASM}
{$IFNDEF NEXTGEN}
procedure _VarFromPStr(var V: TVarData; const Value: ShortString);
procedure _VarFromLStr(var V: TVarData; const Value: AnsiString);
procedure _VarFromWStr(var V: TVarData; const Value: WideString);
{$ENDIF !NEXTGEN}
procedure _VarFromUStr(var V: TVarData; const Value: UnicodeString);
procedure _VarFromWChar(var V: TVarData; const Value: WideChar);
procedure _VarFromIntf(var V: TVarData; const Value: IInterface);
procedure _VarFromDisp(var V: TVarData; const Value: IDispatch);
procedure _VarFromDynArray(var V: TVarData; const DynArray: Pointer; TypeInfo: Pointer);
{$IFNDEF NEXTGEN}
procedure _OleVarFromPStr(var V: TVarData; const Value: ShortString);
procedure _OleVarFromLStr(var V: TVarData; const Value: AnsiString);
{$ENDIF !NEXTGEN}
procedure _OleVarFromUStr(var V: TVarData; const Value: UnicodeString);
procedure _OleVarFromVar(var Dest: TVarData; const Source: TVarData);
procedure _OleVarFromInt(var V: TVarData; const Value: Integer; const Range: ShortInt);
procedure _OleVarFromInt64(var V: TVarData; const Value: Int64);
procedure _OleVarFromUInt64(var V: TVarData; const Value: UInt64);

procedure _VarAdd(var Left: TVarData; const Right: TVarData);
procedure _VarSub(var Left: TVarData; const Right: TVarData);
procedure _VarMul(var Left: TVarData; const Right: TVarData);
procedure _VarDiv(var Left: TVarData; const Right: TVarData);
procedure _VarMod(var Left: TVarData; const Right: TVarData);
procedure _VarAnd(var Left: TVarData; const Right: TVarData);
procedure _VarOr(var Left: TVarData; const Right: TVarData);
procedure _VarXor(var Left: TVarData; const Right: TVarData);
procedure _VarShl(var Left: TVarData; const Right: TVarData);
procedure _VarShr(var Left: TVarData; const Right: TVarData);
procedure _VarRDiv(var Left: TVarData; const Right: TVarData);

{$IFNDEF X86ASM}
function _VarCmpEQ(const Left, Right: TVarData): Boolean;
function _VarCmpNE(const Left, Right: TVarData): Boolean;
function _VarCmpLT(const Left, Right: TVarData): Boolean;
function _VarCmpLE(const Left, Right: TVarData): Boolean;
function _VarCmpGT(const Left, Right: TVarData): Boolean;
function _VarCmpGE(const Left, Right: TVarData): Boolean;
{$ELSE X86ASM}
procedure _VarCmpEQ(const Left, Right: TVarData); // result is set in the flags
procedure _VarCmpNE(const Left, Right: TVarData); // result is set in the flags
procedure _VarCmpLT(const Left, Right: TVarData); // result is set in the flags
procedure _VarCmpLE(const Left, Right: TVarData); // result is set in the flags
procedure _VarCmpGT(const Left, Right: TVarData); // result is set in the flags
procedure _VarCmpGE(const Left, Right: TVarData); // result is set in the flags
{$ENDIF X86ASM}

procedure _VarNeg(var Dest: TVarData);
procedure _VarNot(var Dest: TVarData);

{ Variant dispatch and reference support }
{ DO NOT MODIFY -  Required by compiler codegen - DO NOT MODIFY }

{$IFDEF CPUX86}
procedure _DispInvoke(Dest: PVarData; const Source: TVarData;
  CallDesc: PCallDesc; Params: Pointer); cdecl; {varargs;}
{$ELSE}
procedure _DispInvoke(Dest: PVarData; [Ref] const Source: TVarData;
  CallDesc: PCallDesc); cdecl; varargs;
{$ENDIF}
procedure _VarAddRef(var V: TVarData);

{ Variant array support procedures and functions }
{ DO NOT MODIFY -  Required by compiler codegen - DO NOT MODIFY }

procedure _VarArrayRedim(var A : TVarData; HighBound: Integer);
{$IFDEF CPUX86}
function _VarArrayGet(var A: TVarData;
  IndexCount: Integer; const Indices: TVarArrayCoorArray): TVarData; cdecl; {varargs}
procedure _VarArrayPut(var A: TVarData; const Value: TVarData;
  IndexCount: Integer; const Indices: TVarArrayCoorArray); cdecl; {varargs}
{$ELSE !CPUX86}
procedure _VarArrayGet(var Result: TVarData; var A: TVarData;
  IndexCount: Integer; const Indices: PVarArrayCoorArray);
procedure _VarArrayPut(var A: TVarData; const Value: TVarData;
  IndexCount: Integer; const Indices: PVarArrayCoorArray);
{$ENDIF !CPUX86}

const
  { Maximum number of dispatch arguments }
  MaxDispArgs = 64; {+ !!}


type
{$IFNDEF NEXTGEN}
  TStringRef = record
    Wide: WideString;
    Ansi: PAnsiString;
    Unicode: PUnicodeString;

    function FromAnsi(A: PAnsiString): PWideString;
    function FromUnicode(U: PUnicodeString): PWidestring;
  end;
{$ELSE NEXTGEN}
  TStringRef = record
    Wide: string;
    Ansi: PString;
    Unicode: PUnicodeString;

    function FromAnsi(A: PString): PString;
    function FromUnicode(U: PUnicodeString): PString;
  end;
{$ENDIF !NEXTGEN}
  TStringRefList = array[0..MaxDispArgs - 1] of TStringRef;

function GetDispatchInvokeArgs(CallDesc: PCallDesc; Params: Pointer; var Strings: TStringRefList; OrderLTR : Boolean): TVarDataArray;

var
  DispatchUnsignedAsSigned: Boolean;

implementation

// This defined is used to insure that rangechecking is handled correctly
{$IFOPT R-}
  {$DEFINE RANGECHECKINGOFF}
{$ENDIF}

{$IFDEF MACOS}
{ Mac OS/X ABI requires stack to be aligned to 16 bytes at the
  point of a function call. }
{$DEFINE ALIGN_STACK}
{$ENDIF MACOS}

uses
{$ifdef MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
{$IFDEF POSIX}
  Posix.SysTypes,
{$ENDIF POSIX}
  System.SysConst, System.VarUtils;

const
  varLast = varUInt64;

  // The data represented by a variant come in three flavors.
  //1) 'Inline data variant' is one whose data doesn't have to be allocated
  //   and is actually contained within the payload area of the variant.
  //   Since the data wasn't allocated, it doesn't have to be deallocated.
  //   So to clear this type of variant we simply need to change it's VarType
  //   to varEmpty.  Some examples of this type of variant include:
  //   varInteger, varDouble, varDate, etc.
  //2) 'External data variant' is one whose data has to be allocated.  The
  //   payload area of the variant only contains a reference to the allocated
  //   data.  But since we allocated the data we are responsible for
  //   deallocating it. So to clear this type of variant we have to do more
  //   than simply set it's VarType to varEmpty, the referenced data must
  //   also be deallocated.  Some examples of this type of variant include:
  //   varString, varOleStr, varDispatch, varArray, etc.
  //3) 'By ref data' is a variant that simply points to externally managed
  //   data.  Since the data is managed by someone else we don't have to
  //   deallocate the data when clearing this type of variant, we can simply
  //   set the VarType to varEmpty.  This type of variant's VarType will also
  //   reflect the referenced data's VarType.
  //To quickly determine what we need to do for a certain VarType we have
  //created the following mask value.  When 'AND'ed with the VarType of a
  //variant we can quickly determine which of the above three variant data
  //types is being cleared.  This value is not perfect but there are only two
  //cases where it gets it wrong (varBoolean and varError) and those are
  //quickly dealt with when they come up.
  varDeepData = $BFE8;

type
  TBaseType = (btErr, btEmp, btNul, btInt, btFlt, btCur, btStr, btBol, btDat, btI64, btU64, btAny);

const
  BaseTypeMap: array[0..varLast] of TBaseType = (
    btEmp,  { varEmpty    }
    btNul,  { varNull     }
    btInt,  { varSmallint }
    btInt,  { varInteger  }
    btFlt,  { varSingle   }
    btFlt,  { varDouble   }
    btCur,  { varCurrency }
    btDat,  { varDate     }
    btStr,  { varOleStr   }
    btErr,  { varDispatch }
    btErr,  { varError    }
    btBol,  { varBoolean  }
    btErr,  { varVariant  }
    btErr,  { varUnknown  }
    btErr,  { varDecimal  }
    btErr,  { undefined   }
    btInt,  { varShortInt }
    btInt,  { varByte     }
    btI64,  { varWord     }
    btI64,  { varLongWord }
    btI64,  { varInt64    }
    btU64); { varUInt64   }

{ TCustomVariantType support }
{ While there is room for 1791 ($6FF) custom types, the first sixteen are
  reserved.  That leaves room for 1775 ($6EF) 'user' custom variant types. }
const
  CMaxNumberOfCustomVarTypes = $06FF;
  CMinVarType = $0100;
  CMaxVarType = CMinVarType + CMaxNumberOfCustomVarTypes;
  CIncVarType = $000F;
  CFirstUserType = CMinVarType + CIncVarType;
{$IF Defined(AUTOREFCOUNT)}
var
{$ENDIF}
  CInvalidCustomVariantType: TCustomVariantType = TCustomVariantType($FFFFFFFF);

procedure VarClearDeep(var V: TVarData); forward;

{ These internal helper functions are not called by the compiler }
function _VarToBoolean(const V: TVarData): Boolean; forward;
function _VarToByte(const V: TVarData): Byte; forward;
function _VarToWord(const V: TVarData): Word; forward;
function _VarToLongWord(const V: TVarData): LongWord; forward;
function _VarToShortInt(const V: TVarData): ShortInt; forward;
function _VarToSmallInt(const V: TVarData): SmallInt; forward;
function _VarToSingle(const V: TVarData): Single; forward;
function _VarToDouble(const V: TVarData): Double; forward;
function _VarToDate(const V: TVarData): TDateTime; forward;

procedure _VarFromInteger(var V: TVarData; const Value: Integer); forward;
procedure _VarFromByte(var V: TVarData; const Value: Byte); forward;
procedure _VarFromWord(var V: TVarData; const Value: Word); forward;
procedure _VarFromLongWord(var V: TVarData; const Value: LongWord); forward;
procedure _VarFromShortInt(var V: TVarData; const Value: ShortInt); forward;
procedure _VarFromSmallInt(var V: TVarData; const Value: SmallInt); forward;
procedure _VarFromSingle(var Dest: TVarData; const Value: Single); forward;
procedure _VarFromDouble(var Dest: TVarData; const Value: Double); forward;
procedure _VarFromCurrency(var Dest: TVarData; const Value: Currency); forward;
procedure _VarFromDate(var Dest: TVarData; const Value: TDateTime); forward;

type
{$IF not Declared(WideString)}
  WideString = UnicodeString;
{$ENDIF !Declared(WideString)}
  _OleStr = WideString;

{$IFDEF NEXTGEN}
// NextGen specific helpers used to reduce the number of $IFDEFs.
// These 2 functions re-map the WStr functions to UStr functions.
procedure _VarToWStr(var S: _OleStr; const V: TVarData);  inline;
begin
  _VarToUStr(S, V);
end;

procedure _VarFromWStr(var V: TVarData; const Value: _OleStr); inline;
begin
  _VarFromUStr(V, Value);
  V.VType := varOleStr;
end;
{$ENDIF NEXTGEN}

procedure VarOleStrFromStr(var Dest: TVarData; const Source: string); inline;
begin
  _OleStr(Pointer(Dest.VOleStr)) := _OleStr(Source);
end;

procedure VarCastError;
begin
  raise EVariantTypeCastError.Create(SInvalidVarCast);
end;

procedure VarCastError(const ASourceType, ADestType: TVarType);
begin
  raise EVariantTypeCastError.CreateFmt(SVarTypeCouldNotConvert,
    [VarTypeAsText(ASourceType), VarTypeAsText(ADestType)]);
end;

procedure VarInvalidOp;
begin
  raise EVariantInvalidOpError.Create(SInvalidVarOp);
end;

procedure VarInvalidNullOp;
begin
  raise EVariantInvalidNullOpError.Create(SInvalidVarNullOp);
end;

procedure VarOverflowError(const ASourceType, ADestType: TVarType);
begin
  raise EVariantOverflowError.CreateFmt(SVarTypeConvertOverflow,
    [VarTypeAsText(ASourceType), VarTypeAsText(ADestType)]);
end;

procedure VarRangeCheckError(const ASourceType, ADestType: TVarType);
begin
  if ASourceType = ADestType then
    raise EVariantRangeCheckError.CreateFmt(SVarTypeRangeCheck1,
      [VarTypeAsText(ASourceType)])
  else
    raise EVariantRangeCheckError.CreateFmt(SVarTypeRangeCheck2,
      [VarTypeAsText(ASourceType), VarTypeAsText(ADestType)])
end;

procedure VarArrayCreateError;
begin
  raise EVariantArrayCreateError.Create(SVarArrayCreate);
end;

procedure TranslateResult(AResult: HRESULT);
begin
  case AResult of
    VAR_TYPEMISMATCH:  VarCastError;
    VAR_BADVARTYPE:    raise EVariantBadVarTypeError.Create(SVarBadType);
    VAR_EXCEPTION:     VarInvalidOp;
    VAR_OVERFLOW:      raise EVariantOverflowError.Create(SVarOverflow);
    VAR_BADINDEX:      raise EVariantBadIndexError.Create(SVarArrayBounds);
    VAR_ARRAYISLOCKED: raise EVariantArrayLockedError.Create(SVarArrayLocked);
    VAR_NOTIMPL:       raise EVariantNotImplError.Create(SVarNotImplemented);
    VAR_OUTOFMEMORY:   raise EVariantOutOfMemoryError.Create(SOutOfMemory);
    VAR_INVALIDARG:    raise EVariantInvalidArgError.Create(SVarInvalid);
    VAR_UNEXPECTED:    raise EVariantUnexpectedError.Create(SVarUnexpected);
  else
    raise EVariantError.CreateFmt(SInvalidVarOpWithHResultWithPrefix,
      [HexDisplayPrefix, AResult, SysErrorMessage(AResult)]);
  end;
end;

procedure VarResultCheck(AResult: HRESULT); overload;
begin
  if AResult <> VAR_OK then
    TranslateResult(AResult);
end;

procedure VarResultCheck(AResult: HRESULT; ASourceType, ADestType: TVarType); overload;
begin
  if AResult <> VAR_OK then
    case AResult of
      VAR_TYPEMISMATCH:  VarCastError(ASourceType, ADestType);
      VAR_OVERFLOW:      VarOverflowError(ASourceType, ADestType);
    else
      TranslateResult(AResult);
    end;
end;

procedure HandleConversionException(const ASourceType, ADestType: TVarType);
var
  LException: Exception;
begin
  if ExceptObject is ERangeError then
    VarResultCheck(VAR_OVERFLOW, ASourceType, ADestType)
  else if ExceptObject is System.SysUtils.EOverflow then // Symbol collision with LibC
    VarResultCheck(VAR_OVERFLOW, ASourceType, ADestType)
  else if ExceptObject is EConvertError then
    VarResultCheck(VAR_TYPEMISMATCH, ASourceType, ADestType)
  else
  begin
    LException := Exception(AcquireExceptionObject);
    raise LException;
  end;
end;

procedure _DispInvokeError;
begin
  raise EVariantDispatchError.Create(SDispatchError);
end;

//============================================================================

procedure _VarNull(var V: TVarData);
begin
  _VarClear(V);
  V.VType := varNull;
end;

procedure VarArrayClear(var V: TVarData);
var
  LArrayRef: PVarArray;
  Count, I: Integer;
  PData: PVarData;

  function ElementCount(ArrayRef: PVarArray; Dim: Integer):Integer;
  var
    LLowBound, LUpperBound: Integer;
  begin
    VarResultCheck(SafeArrayGetLBound(ArrayRef, Dim, LLowBound));
    VarResultCheck(SafeArrayGetUBound(ArrayRef, Dim, LUpperBound));
    Result := LUpperBound - LLowBound + 1;
  end;
begin
  // sanity test
  if V.VType and varArray = 0 then
    VarResultCheck(VAR_INVALIDARG);

  // if the array contains variants then we need to preprocess them
  if (V.VType and varTypeMask) = varVariant then
  begin
    // where is the array reference?
    if (V.VType and varByRef) <> 0 then
      LArrayRef := PVarArray(V.VPointer^)
    else
      LArrayRef := V.VArray;

    Count := 0;
    if LArrayRef.DimCount > 0 then
    begin
      Count := ElementCount(LArrayRef, 1);
      for I := 2 to LArrayRef^.DimCount do
        Count := Count * ElementCount(LArrayRef, I);
    end;

    PData := LArrayRef^.Data;
    for I := 1 to Count do
    begin
      _VarClear(PData^);
      Inc(PData);
    end;
  end;

  // finish the clear
  VarResultCheck(VariantClear(V));
end;

procedure VarClearDeep(var V: TVarData);
var
  LHandler: TCustomVariantType;
begin
  // quick test for the simple ones
  if (V.VType < varInt64) then
    VarResultCheck(VariantClear(V))

  else if V.VType = varString then
  begin
{$IFNDEF NEXTGEN}
    V.VType := varEmpty;
    AnsiString(V.VString) := '';
{$ELSE NEXTGEN}
    VarInvalidOp;
{$ENDIF !NEXTGEN}
  end

  // clear the pascal unicode string correctly for reference counting
  else if V.VType = varUString then
  begin
    V.VType := varEmpty;
    UnicodeString(V.VUString) := '';
  end

  // let CORBA deal with its own type
  else if V.VType = varAny then
    ClearAnyProc(V)

  // custom handle the arrays
  else if (V.VType and varArray) <> 0 then
    VarArrayClear(V)

  // ok, finally is it a custom variant type?
  else if FindCustomVariantType(V.VType, LHandler) then
  begin
    LHandler.Clear(V);
    V.VPointer := nil;
  end

  // finally let the OS attempt to deal with it
  else
  begin
    // sometimes the OS will return an error that it doesn't know what to do
    // with the given VType.  We don't know what to do either, so we'll just
    // punt here and ignore any errors and then VarInit the variant.
    VariantClear(V);
    VariantInit(V);
  end;
end;

procedure _VarClear(var V: TVarData);
begin
  // byrefs and those inline data types are easy
  if (V.VType and varDeepData) = 0 then
    V.VType := varEmpty
  else
    VarClearDeep(V);
{$IFDEF AUTOREFCOUNT}
  V.VPointer := nil;
{$ENDIF}
end;

{$IFNDEF X86ASM}
function _VarClr(var V: TVarData): Pointer;
begin
  Result := @V;
  _VarClear(V);
end;
{$ELSE X86ASM}
procedure _VarClr(var V: TVarData);
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF ALIGN_STACK}
        PUSH    EAX
        CALL    _VarClear
        POP     EAX
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF ALIGN_STACK}
end;
{$ENDIF X86ASM}

procedure DispInvokeCore(Dest: PVarData; [Ref] const Source: TVarData;
  CallDesc: PCallDesc; Params: Pointer);
var
  LHandler: TCustomVariantType;
  LDest: TVarData;
  LDestPtr: PVarData;
begin
  // figure out destination temp
  if Dest = nil then
    LDestPtr := nil
  else
  begin
    VariantInit(LDest);
    LDestPtr := @LDest;
  end;
  // attempt it
  try
    // we only do this if it is one of those special types
    case Source.VType of
      varDispatch,
      varDispatch + varByRef,
      varUnknown,
      varUnknown + varByRef,
      varAny:
        if Assigned(VarDispProc) then
          VarDispProc(PVariant(LDestPtr), Variant(Source), CallDesc, Params);
    else
      // finally check to see if it is one of those custom types
      if FindCustomVariantType(Source.VType, LHandler) then
        LHandler.DispInvoke(LDestPtr, Source, CallDesc, Params)
      else
        VarInvalidOp;
    end;
  finally
    // finish up with destination temp
    if LDestPtr <> nil then
    begin
      _VarCopy(Dest^, LDestPtr^);
      _VarClear(LDest);
    end;
  end;
end;

{$IFDEF CPUX86}
procedure _DispInvoke(Dest: PVarData; const Source: TVarData;
  CallDesc: PCallDesc; Params: Pointer); cdecl; {varargs;}
var
  Src: PVarData;
begin
  Src := @Source;
  while Src^.VType = varByRef or varVariant do
    Src := PVarData(Src^.VPointer);
  DispInvokeCore(Dest, Src^, CallDesc, @Params);
end;
{$ELSE}
procedure _DispInvoke(Dest: PVarData; [Ref] const Source: TVarData;
  CallDesc: PCallDesc); cdecl; varargs;
var
  Src: PVarData;
  VAList: TVarArgList;
begin
  VarArgStart(VAList);
  Src := @Source;
  while Src^.VType = varByRef or varVariant do
    Src := PVarData(Src^.VPointer);
  DispInvokeCore(Dest, Src^, CallDesc, VAList);
  VarArgEnd(VAList);
end;
{$ENDIF}

{$IFNDEF NEXTGEN}
function TStringRef.FromAnsi(A: PAnsiString): PWideString;
begin
  Ansi := A;
  Unicode := nil;
  Wide := WideString(A^);
  Result := @Wide;
end;

function TStringRef.FromUnicode(U: PUnicodeString): PWidestring;
begin
  Ansi := nil;
  Unicode := U;
  Wide := WideString(U^);
  Result := @Wide;
end;

var
  _EmptyBSTR: PWideChar = nil;

procedure InitEmptyBSTR;
begin
                                                                        
  if _EmptyBSTR = nil then
    _EmptyBSTR := StringToOleStr('');
end;

{$ELSE NEXTGEN}

function TStringRef.FromAnsi(A: PString): PString;
begin
  Ansi := A;
  Unicode := nil;
  Wide := string(A^);
  Result := @Wide;
end;

function TStringRef.FromUnicode(U: PUnicodeString): PString;
begin
  Ansi := nil;
  Unicode := U;
  Wide := string(U^);
  Result := @Wide;
end;

var
  _EmptyBSTR: PChar = nil;

procedure InitEmptyBSTR;
begin
                                                                        
  if _EmptyBSTR = nil then
    _EmptyBSTR := StringToOleStr('');
end;
{$ENDIF !NEXTGEN}

function GetDispatchInvokeArgs(CallDesc: PCallDesc; Params: Pointer; var Strings: TStringRefList; OrderLTR : Boolean): TVarDataArray;

  {$IFDEF CPUX64}
  function _GetXMM3: Double;
  asm
    MOVDQA  XMM0, XMM3
  end;

  function _GetXMM3AsSingle: Single;
  asm
    MOVDQA  XMM0, XMM3
  end;
  {$ENDIF}

const
  { Parameter type masks - keep in sync with decl.h/ap* enumerations}
  atString   = $48;
  atUString  = $4A;
  atVarMask  = $3F;
  atTypeMask = $7F;
  atByRef    = $80;
var
  I: Integer;
  ArgType: Byte;
  PVarParm: PVarData;
  StringCount: Integer;
begin
  InitEmptyBSTR;
  StringCount := 0;
  SetLength(Result, CallDesc^.ArgCount);
  for I := 0 to CallDesc^.ArgCount-1 do
  begin
    ArgType := CallDesc^.ArgTypes[I];

    if OrderLTR then
      PVarParm := @Result[I]
    else
      PVarParm := @Result[CallDesc^.ArgCount-I-1];

    if (ArgType and atByRef) = atByRef then
    begin
{$IFNDEF NEXTGEN}
      if (ArgType and atTypeMask) = atString then
      begin
        PVarData(PVarParm)^.VType := varByRef or varOleStr;
        PVarData(PVarParm)^.VPointer := Strings[StringCount].FromAnsi(PAnsiString(Params^));
        Inc(StringCount);
      end
      else
{$ENDIF !NEXTGEN}
      if (ArgType and atTypeMask) = atUString then
      begin
        PVarData(PVarParm)^.VType := varByRef or varOleStr;
        PVarData(PVarParm)^.VPointer := Strings[StringCount].FromUnicode(PUnicodeString(Params^));
        Inc(StringCount);
      end
      else
      begin
        if ((ArgType and atTypeMask) = varVariant) and
          ((PVarData(Params^)^.VType = varString) or (PVarData(Params^)^.VType = varUString)) then
          VarCast(PVariant(Params^)^, PVariant(Params^)^, varOleStr);
        //PVarData(PVarParm)^.VType := varByRef or (ArgType and atTypeMask);

        ArgType := ArgType and atTypeMask;
        if DispatchUnsignedAsSigned then
        case ArgType of
             varUInt64:   ArgType := varInt64;
             varLongWord: ArgType := varInteger;
             varWord:     ArgType := varSmallint;
             varByte:     ArgType := varShortInt;
        end;
        PVarData(PVarParm)^.VType := varByRef or ArgType;

        PVarData(PVarParm)^.VPointer := PPointer(Params)^;
      end;
      Inc(PByte(Params), SizeOf(Pointer));
    end
    else // ByVal
    begin
      PVarParm^.VType := ArgType;
      case ArgType of
        varEmpty, varNull: ; // Only need to set VType
        varSmallint:  PVarParm^.VSmallInt := PSmallInt(Params)^;
        varInteger:   PVarParm^.VInteger := PInteger(Params)^;
        varSingle:
{$IFDEF CPUX64}
        if I = 0 then
          PVarParm^.VSingle := _GetXMM3AsSingle
        else
{$ENDIF}
          PVarParm^.VSingle := PSingle(Params)^;
        varDouble:
{$IFDEF CPUX64}
        if I = 0 then
          PVarParm^.VDouble := _GetXMM3
        else
{$ENDIF}
          PVarParm^.VDouble := PDouble(Params)^;
        varCurrency:  PVarParm^.VCurrency := PCurrency(Params)^;
        varDate:
{$IFDEF CPUX64}
        if I = 0 then
          PVarParm^.VDate := _GetXMM3
        else
{$ENDIF}
          PVarParm^.VDate := PDateTime(Params)^;

        varOleStr:    PVarParm^.VPointer := PPointer(Params)^;
        varDispatch:  PVarParm^.VDispatch := PPointer(Params)^;
        varError:     PVarParm^.VError := HRESULT($80020004); //DISP_E_PARAMNOTFOUND;
        varBoolean:   PVarParm^.VBoolean := PBoolean(Params)^;
        varVariant:
        begin
          PVarParm^.VType := varEmpty;
{$IFDEF CPUX64}
                                                                                    
          PVariant(PVarParm)^ := PVariant(Params^)^;
{$ELSE}
          PVariant(PVarParm)^ := PVariant(Params)^;
{$ENDIF}
        end;
        varUnknown:   PVarParm^.VUnknown := PPointer(Params)^;
        varShortInt:  PVarParm^.VShortInt := PShortInt(Params)^;
        varByte:      PVarParm^.VByte :=  PByte(Params)^;
        varWord:
        begin
          if DispatchUnsignedAsSigned then
          begin
            PVarParm^.VType := varInteger;
            PVarParm^.VInteger := Integer(PWord(Params)^);
          end else
            PVarParm^.VWord := PWord(Params)^;
        end;
        varLongWord:
        begin
          if DispatchUnsignedAsSigned then
          begin
            PVarParm^.VType := varInteger;
            PVarParm^.VInteger := Integer(PLongWord(Params)^);
          end else
            PVarParm^.VLongWord := PLongWord(Params)^;
        end;
        varInt64:     PVarParm^.VInt64 := PInt64(Params)^;
        varUInt64:
        begin
          if DispatchUnsignedAsSigned then
          begin
            PVarParm^.VType := varInt64;
            PVarParm^.VInt64 := Int64(PInt64(Params)^);
          end else
            PVarParm^.VUInt64 := PUInt64(Params)^;
        end;
{$IFNDEF NEXTGEN}
        atString:
        begin
          PVarParm^.VType := varOleStr;
          if PAnsiString(Params)^ <> '' then
          begin
            PVarParm^.VPointer := PWideChar(Strings[StringCount].FromAnsi(PAnsiString(Params))^);
            Strings[StringCount].Ansi := nil;
            Inc(StringCount);
          end
          else
            PVarParm^.VPointer := _EmptyBSTR;
        end;
{$ENDIF !NEXTGEN}
        atUString:
        begin
          PVarParm^.VType := varOleStr;
          if PUnicodeString(Params)^ <> '' then
          begin
            PVarParm^.VPointer := PWideChar(Strings[StringCount].FromUnicode(PUnicodeString(Params))^);
            Strings[StringCount].Unicode := nil;
            Inc(StringCount);
          end
          else
            PVarParm^.VPointer := _EmptyBSTR;
        end;
      else
        // Unsupported Var Types
        //varDecimal  = $000E; { vt_decimal     14 } {UNSUPPORTED as of v6.x code base}
        //varUndef0F  = $000F; { undefined      15 } {UNSUPPORTED per Microsoft}
        //varRecord   = $0024; { VT_RECORD      36 }
        //varString   = $0100; { Pascal string  256 } {not OLE compatible }
        //varAny      = $0101; { Corba any      257 } {not OLE compatible }
        //varUString  = $0102; { Unicode string 258 } {not OLE compatible }
        _DispInvokeError;
      end;
      case ArgType of
        varError: ; // don't increase param pointer
{$IF defined(CPUX86)  or defined(CPUARM)}
      varDouble, varCurrency, varDate, varInt64, varUInt64:
        Inc(PByte(Params), 8);
      varVariant:
        Inc(PByte(Params), SizeOf(Variant));
{$ENDIF CPUX86 or CPUARM}
      else
        Inc(PByte(Params), SizeOf(Pointer));
      end;
    end;
  end;
end;

type
  TVarArrayForEach = procedure(var Dest: TVarData; const Src: TVarData);

procedure VarArrayCopyForEach(var Dest: TVarData; const Src: TVarData; AProc: TVarArrayForEach);
var
  I, LUBound, LDimCount: Integer;
  LVarArrayRef, LSrcArrayRef: PVarArray;
  LVarBounds: array[0..63] of TVarArrayBound;
  LVarPoint: array[0..63] of Integer;
  PFrom, PTo: Pointer;

  // this support function handles bounds checking
  function InBounds(At: Integer): Boolean;
  begin
    repeat
      Result := LVarPoint[At] < LVarBounds[At].LowBound + LVarBounds[At].ElementCount;
      Dec(At);
    until not Result or (At < 0);
  end;

  // this support function handles the coordinate navigation dealing with
  //   bounds wrapping and the like
  function Increment(At: Integer): Boolean;
  begin
    Result := True;
    Inc(LVarPoint[At]);
    if LVarPoint[At] >= LVarBounds[At].LowBound + LVarBounds[At].ElementCount then
      if At = 0 then
        Result := False
      else
      begin
        LVarPoint[At] := LVarBounds[At].LowBound;
        Result := Increment(At - 1);
      end;
  end;
begin
  // sanity test
  if Src.VType and varArray = 0 then
    VarResultCheck(VAR_INVALIDARG);

  // if the array contains variants then we need to handle the copy ourself
  if (Src.VType and varTypeMask) = varVariant then
  begin

    // where is the array reference
    if (Src.VType and varByRef) <> 0 then
      LSrcArrayRef := PVarArray(Src.VPointer^)
    else
      LSrcArrayRef := Src.VArray;

    // figure our bounds
    LDimCount := LSrcArrayRef^.DimCount;
    for I := 0 to LDimCount - 1 do
      with LVarBounds[I] do
      begin
        VarResultCheck(SafeArrayGetLBound(LSrcArrayRef, I + 1, LowBound));
        VarResultCheck(SafeArrayGetUBound(LSrcArrayRef, I + 1, LUBound));
        ElementCount := LUBound - LowBound + 1;
      end;

    // create a destination array
    LVarArrayRef := SafeArrayCreate(varVariant, LDimCount, PVarArrayBoundArray(@LVarBounds));
    if LVarArrayRef = nil then
      VarArrayCreateError;

    // set up the destination variant
    _VarClear(Dest);
    Dest.VType := varVariant or varArray;
    Dest.VArray := LVarArrayRef;

    // initialize the coordinates
    for I := 0 to LDimCount - 1 do
      LVarPoint[I] := LVarBounds[I].LowBound;

    // find the variant at the current coordinate
    repeat
      if InBounds(LDimCount - 1) then
      begin
        VarResultCheck(SafeArrayPtrOfIndex(LSrcArrayRef, PVarArrayCoorArray(@LVarPoint), PFrom));
        VarResultCheck(SafeArrayPtrOfIndex(LVarArrayRef, PVarArrayCoorArray(@LVarPoint), PTo));

        // call the proc
        AProc(PVarData(PTo)^, PVarData(PFrom)^);
      end;
    until not Increment(LDimCount - 1);
  end

  // array of something other than a variant, just copy it
  else
    VarResultCheck(VariantCopy(Dest, Src));
end;

procedure VarCopyCopyProc(var Dest: TVarData; const Src: TVarData);
begin
  _VarCopy(Dest, Src);
end;

procedure VarCopyDeep(var Dest: TVarData; const Source: TVarData);
var
  LSourceHandler: TCustomVariantType;
begin
  // clear the destination if needed
  if (Dest.VType and varDeepData) <> 0 then
    VarClearDeep(Dest)
  else
    Dest.VPointer := nil;

  // take care of the other simple ones
  if Source.VType < varInt64 then
    VarResultCheck(VariantCopy(Dest, Source))

  // Pascal string
  else if Source.VType = varString then
  begin
{$IFNDEF NEXTGEN}
    Dest.VType := varString;
    Dest.VString := nil;
    AnsiString(Dest.VString) := AnsiString(Source.VString);
{$ELSE NEXTGEN}
    VarInvalidOp; // We shouldn't have variants with AnsiString in NEXTGEN.
{$ENDIF NEXTGEN}
  end

  // Pascal unicode string
  else if Source.VType = varUString then
  begin
    Dest.VType := varUString;
    Dest.VUString := nil;
    UnicodeString(Dest.VUString) := UnicodeString(Source.VUString);
  end

  // By ref strings
  else if (Source.VType = varUString or varByRef) or
    (Source.VType = varString or varByRef) then
  begin
    Dest.VType := Source.VType;
    Dest.VPointer := Source.VPointer;
  end

  // CORBA Any
  else if Source.VType = varAny then
  begin
    Dest.VType := Source.VType;
    Dest.VAny := Source.VAny;
    RefAnyProc(Dest);
  end

  // arrays?
  else if Source.VType and varArray <> 0 then
    VarArrayCopyForEach(Dest, Source, VarCopyCopyProc)

  // otherwise try for custom
  else if FindCustomVariantType(Source.VType, LSourceHandler) then
    LSourceHandler.Copy(Dest, Source, False)

  // finally let the OS deal with it
  else
    VarResultCheck(VariantCopy(Dest, Source));
end;

procedure _VarCopy(var Dest: TVarData; const Source: TVarData);
begin
  // if they are the same then don't do anything
  if @Dest = @Source then
    Exit;

  // inline data or a byref
  if (Source.VType and varDeepData) = 0 then
  begin
    // not inline dest of a byref
    if (Dest.VType and varDeepData) <> 0 then
      VarClearDeep(Dest);

    Move(Source.RawData, Dest.RawData, SizeOf(Source.RawData));
  end
  else
    VarCopyDeep(Dest, Source);
end;

procedure VarCopyNoIndViaOS(var Dest: TVarData; const Source: TVarData);
begin
  if @Dest <> @Source then
    _VarClear(Dest);
  VarResultCheck(VariantCopyInd(Dest, Source));
end;

function VarCopyNoIndOleStr(const V: TVarData): WideString;
begin
  _VarToWStr(Result, V);
end;

procedure VarCopyNoIndCopyProc(var Dest: TVarData; const Source: TVarData);
begin
  _VarCopyNoInd(Dest, Source);
end;

procedure VarCopyNoIndDeep(var Dest: TVarData; const Source: TVarData);
var
  LSourceHandler: TCustomVariantType;
begin
  // attempt to find a custom variant to deal with source
  if FindCustomVariantType(Source.VType, LSourceHandler) then
    LSourceHandler.Copy(Dest, Source, True)

  // finally let the OS attempt to deal with source
  else
    VarCopyNoIndViaOS(Dest, Source);
end;

procedure VarCopyByRef(var Dest: TVarData; const Source: TVarData);
begin
  case Source.VType and not varByRef of
    varSmallint: Variant(Dest) := PSmallint(Source.VPointer)^;
    varInteger:  Variant(Dest) := PInteger(Source.VPointer)^;
    varSingle:   Variant(Dest) := PSingle(Source.VPointer)^;
    varDouble:   Variant(Dest) := PDouble(Source.VPointer)^;
    varCurrency: Variant(Dest) := PCurrency(Source.VPointer)^;
    varDate:     Variant(Dest) := PDate(Source.VPointer)^;
    varOleStr:   Variant(Dest) := VarCopyNoIndOleStr(Source);
    varBoolean:  Variant(Dest) := PWordBool(Source.VPointer)^;
    varShortInt: Variant(Dest) := PShortInt(Source.VPointer)^;
    varByte:     Variant(Dest) := PByte(Source.VPointer)^;
    varWord:     Variant(Dest) := PWord(Source.VPointer)^;
    varLongWord: Variant(Dest) := PLongWord(Source.VPointer)^;
    varInt64:    Variant(Dest) := PInt64(Source.VPointer)^;
    varUInt64:   Variant(Dest) := PUInt64(Source.VPointer)^;

    varVariant:  _VarCopyNoInd(Dest, PVarData(Source.VPointer)^);

    varDispatch,
    varUnknown:  VarCopyNoIndViaOS(Dest, Source);
  else
    if Source.VType and varArray <> 0 then
      VarArrayCopyForEach(Dest, Source, VarCopyNoIndCopyProc)
    else
      VarCopyNoIndDeep(Dest, Source);
  end
end;

procedure _VarCopyNoInd(var Dest: TVarData; const Source: TVarData);
begin
  if Source.VType and varByRef = 0 then
    _VarCopy(Dest, Source)
  else
    VarCopyByRef(Dest, Source);
end;

procedure VarCopyNoInd(var Dest: Variant; const Source: Variant);
begin
  _VarCopyNoInd(TVarData(Dest), TVarData(Source));
end;

// Dest should be cleared by the caller
procedure VarInt64FromVar(var Dest: TVarData; const Source: TVarData;
  ADestType: TVarType);
begin
  Dest.VType := varInt64;
  Dest.VInt64 := _VarToInt64(Source);
end;

procedure _VarStringToOleStr(var Dest: TVarData; const Source: TVarData);
var
  OleStrPtr: PWideChar;
begin
  if Source.VType = varString then
  begin
{$IFNDEF NEXTGEN}
    OleStrPtr := StringToOleStr(Ansistring(Source.VString))
{$ELSE NEXTGEN}
    raise EVariantInvalidOpError.Create(SInvalidVarOp);
{$ENDIF NEXTGEN}
  end
  else //varUString
    OleStrPtr := StringToOleStr(UnicodeString(Source.VUString));
  _VarClear(Dest);
  Dest.VType := varOleStr;
  Dest.VOleStr := OleStrPtr;
end;

procedure VarStringToOleStr(var Dest: Variant; const Source: Variant);
{$IFNDEF X86ASM}
begin
  _VarStringToOleStr(TVarData(Dest), TVarData(Source));
end;
{$ELSE X86ASM}
asm
        JMP    _VarStringToOleStr
end;
{$ENDIF X86ASM}

procedure VarCastAsAny(var Dest: TVarData; const Source: TVarData; ADestType: TVarType);
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, Source);
    ChangeAnyProc(LTemp);
    _VarCast(Dest, LTemp, ADestType);
  finally
    _VarClear(LTemp);
  end;
end;

procedure VarCastAsOleStr(var Dest: TVarData; const Source: TVarData);
var
  S: WideString;
begin
  _VarToWStr(S, Source);
  _VarFromWStr(Dest, S);
end;

procedure VarCastAsString(var Dest: TVarData; const Source: TVarData);
{$IFNDEF NEXTGEN}
var
  S: AnsiString;
begin
  _VarToLStr(S, Source);
  _VarFromLStr(Dest, S);
end;
{$ELSE NEXTGEN}
begin
  VarCastError(Source.VType, varString)
end;
{$ENDIF !NEXTGEN}

procedure VarCastAsUString(var Dest: TVarData; const Source: TVarData);
var
  S: UnicodeString;
begin
  _VarToUStr(S, Source);
  _VarFromUStr(Dest, S);
end;

procedure VarCastAsDispatch(var Dest: TVarData; const Source: TVarData);
var
  D: IDispatch;
begin
  _VarToDisp(D, Source);
  _VarFromDisp(Dest, D);
end;

procedure VarCastAsInterface(var Dest: TVarData; const Source: TVarData);
var
  I: IInterface;
begin
  _VarToIntf(I, Source);
  _VarFromIntf(Dest, I);
end;

procedure VarCastViaOS(var Dest: TVarData; const Source: TVarData; ADestType: TVarType);
begin
  // if not a simple os type then try to convert it into a olestr
  if Source.VType and varTypeMask >= varInt64 then
  begin
    _VarCast(Dest, Source, varOleStr);
    VarResultCheck(VariantChangeTypeEx(Dest, Dest, VAR_LOCALE_USER_DEFAULT, 0, ADestType),
                   Source.VType, ADestType);
  end

  // only if dest is a simple OS type
  else if ADestType and varTypeMask < varInt64 then
    VarResultCheck(VariantChangeTypeEx(Dest, Source, VAR_LOCALE_USER_DEFAULT, 0, ADestType),
                   Source.VType, ADestType)

  // otherwise burp
  else
    VarCastError(Source.VType, ADestType);
end;

procedure VarCastRare(var Dest: TVarData; const Source: TVarData; ADestType: TVarType);
var
  LHandler: TCustomVariantType;
begin
  if Source.VType = varAny then
    VarCastAsAny(Dest, Source, ADestType)
  else if FindCustomVariantType(Source.VType, LHandler) then
    LHandler.CastTo(Dest, Source, ADestType)
  else if FindCustomVariantType(ADestType, LHandler) then
    LHandler.Cast(Dest, Source)
  else
    VarCastViaOS(Dest, Source, ADestType);
end;

procedure _VarCast(var Dest: TVarData; const Source: TVarData; AVarType: Integer);
begin
  if Source.VType = AVarType then
    _VarCopy(Dest, Source)
  else if Source.VType = varByRef or varVariant then
    _VarCast(Dest, PVarData(Source.VPointer)^, AVarType)
  else
    case AVarType of
      varEmpty:
        if (Source.VType = varNull) and NullStrictConvert then
          VarCastError(varNull, varEmpty)
        else
          _VarClear(Dest);
      varNull:     _VarNull(Dest);
      varSmallInt: _VarFromSmallInt(Dest, _VarToSmallInt(Source));
      varInteger:  _VarFromInteger(Dest, _VarToInteger(Source));
      varSingle:   _VarFromSingle(Dest, _VarToSingle(Source));
      varDouble:   _VarFromDouble(Dest, _VarToDouble(Source));
      varCurrency: _VarFromCurrency(Dest, _VarToCurrency(Source));
      varDate:     _VarFromDate(Dest, _VarToDate(Source));
      varOleStr:   VarCastAsOleStr(Dest, Source);
      varBoolean:  _VarFromBool(Dest, _VarToBoolean(Source));
      varShortInt: _VarFromShortInt(Dest, _VarToShortInt(Source));
      varByte:     _VarFromByte(Dest, _VarToByte(Source));
      varWord:     _VarFromWord(Dest, _VarToWord(Source));
      varLongWord: _VarFromLongWord(Dest, _VarToLongWord(Source));
      varInt64:    _VarFromInt64(Dest, _VarToInt64(Source));
      varUInt64:   _VarFromUInt64(Dest, _VarToUInt64(Source));

      varDispatch: VarCastAsDispatch(Dest, Source);
      varUnknown:  VarCastAsInterface(Dest, Source);
    else
      case AVarType of
        varString: VarCastAsString(Dest, Source);
        varUString: VarCastAsUString(Dest, Source);
        varAny:    VarCastError(Source.VType, varAny);
      else
        VarCastRare(Dest, Source, AVarType);
      end;
    end;
end;

(* VarCast when the destination is OleVariant *)
procedure _VarCastOle(var Dest: TVarData; const Source: TVarData; AVarType: Integer);
var
  LHandler: TCustomVariantType;
begin
  if Source.VType = varByRef or varVariant then
    _VarCastOle(Dest, PVarData(Source.VPointer)^, AVarType)
  else
    if (AVarType = varString) or (AVarType = varUString) or (AVarType = varAny) then
      VarCastError(Source.VType, AVarType)
    else if FindCustomVariantType(Source.VType, LHandler) then
      LHandler.CastTo(Dest, Source, AVarType)
    else
      _VarCast(Dest, Source, AVarType);
end;

{ **************************************************************************** }
{ Quick Int support }
{ **************************************************************************** }

function VarToIntAsString(const V: TVarData): Integer;
var
  S: WideString;
  LResult: HResult;
begin
  _VarToWStr(S, V);
  LResult := VarI4FromStr(PWideChar(S), VAR_LOCALE_USER_DEFAULT, 0, Result);
  case LResult of
    VAR_OK:; // in this case the OS function has put the value into result
    VAR_TYPEMISMATCH:
      if not TryStrToInt(S, Result) then
        Result := Integer(_VarToBoolean(V));
  else
    VarResultCheck(LResult, V.VType, varInteger);
  end;
end;

function VarToIntViaOS(const V: TVarData): Integer;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  VarResultCheck(VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varInteger),
                 V.VType, varInteger);
  Result := LTemp.VInteger;
end;

function VarToIntAny(const V: TVarData): Integer;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    Result := _VarToInteger(LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToIntCustom(const V: TVarData; out AValue: Integer): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    LHandler.CastTo(LTemp, V, varInteger);
    AValue := LTemp.VInteger;
  end;
end;

function _VarToInteger(const V: TVarData): Integer;
begin
  try
    case V.VType of
      varEmpty:    Result := 0;
      varNull:
        begin
          if NullStrictConvert then
            VarCastError(varNull, varInteger);
          Result := 0;
        end;
      varSmallInt: Result := V.VSmallInt;
      varInteger:  Result := V.VInteger;
      {$RANGECHECKS ON}
      varSingle:   Result := Round(V.VSingle);
      varDouble:   Result := Round(V.VDouble);
      varCurrency: Result := Round(V.VCurrency);
      varDate:     Result := Round(V.VDate);
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}
      varOleStr:   Result := VarToIntAsString(V);
      varBoolean:  Result := Integer(V.VBoolean);
      varShortInt: Result := V.VShortInt;
      varByte:     Result := V.VByte;
      varWord:     Result := V.VWord;
      {$RANGECHECKS ON}
      varLongWord: Result := V.VLongWord;
      varInt64:    Result := V.VInt64;
      varUInt64:   Result := V.VUInt64;
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}

      varVariant:  Result := _VarToInteger(PVarData(V.VPointer)^);

      varDispatch,
      varUnknown:  Result := VarToIntViaOS(V);
    else
      case V.VType of
        varString: Result := VarToIntAsString(V);
        varUString: Result := VarToIntAsString(V);
        varAny:    Result := VarToIntAny(V);
      else
        if V.VType and varByRef <> 0 then
          case V.VType and not varByRef of
            varSmallInt: Result := PSmallInt(V.VPointer)^;
            varInteger:  Result := PInteger(V.VPointer)^;
            {$RANGECHECKS ON}
            varSingle:   Result := Round(PSingle(V.VPointer)^);
            varDouble:   Result := Round(PDouble(V.VPointer)^);
            varCurrency: Result := Round(PCurrency(V.VPointer)^);
            varDate:     Result := Round(PDate(V.VPointer)^);
            {$IFDEF RANGECHECKINGOFF}
              {$RANGECHECKS OFF}
            {$ENDIF}
            varOleStr:   Result := VarToIntAsString(V);
            varBoolean:  Result := Integer(PWordBool(V.VPointer)^);
            varShortInt: Result := PShortInt(V.VPointer)^;
            varByte:     Result := PByte(V.VPointer)^;
            varWord:     Result := PWord(V.VPointer)^;
            {$RANGECHECKS ON}
            varLongWord: Result := PLongWord(V.VPointer)^;
            varInt64:    Result := PInt64(V.VPointer)^;
            varUInt64:   Result := PUInt64(V.VPointer)^;
            {$IFDEF RANGECHECKINGOFF}
              {$RANGECHECKS OFF}
            {$ENDIF}

            varVariant:  Result := _VarToInteger(PVarData(V.VPointer)^);
          else
            Result := VarToIntViaOS(V);
          end
        else
          if not VarToIntCustom(V, Result) then
            Result := VarToIntViaOS(V);
      end;
    end;
  except
    HandleConversionException(V.VType, varInteger);
    Result := 0;
  end;
end;

function _VarToShortInt(const V: TVarData): ShortInt;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varShortInt);
        Result := 0;
      end;
    varBoolean:  Result := ShortInt(V.VBoolean);
    varShortInt: Result := V.VShortInt;
  else
    try
      {$RANGECHECKS ON}
      Result := _VarToInteger(V);
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}
    except
      HandleConversionException(V.VType, varShortInt);
      Result := 0;
    end;
  end;
end;

function _VarToByte(const V: TVarData): Byte;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varByte);
        Result := 0;
      end;
    varBoolean:  Result := Byte(V.VBoolean);
    varByte:     Result := V.VByte;
  else
    try
      {$RANGECHECKS ON}
      Result := _VarToInteger(V);
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}
    except
      HandleConversionException(V.VType, varByte);
      Result := 0;
    end;
  end;
end;

function _VarToSmallInt(const V: TVarData): SmallInt;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varSmallInt);
        Result := 0;
      end;
    varSmallInt: Result := V.VSmallInt;
    varBoolean:  Result := SmallInt(V.VBoolean);
    varShortInt: Result := V.VShortInt;
    varByte:     Result := V.VByte;
  else
    try
      {$RANGECHECKS ON}
      Result := _VarToInteger(V);
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}
    except
      HandleConversionException(V.VType, varSmallInt);
      Result := 0;
    end;
  end;
end;

function _VarToWord(const V: TVarData): Word;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varWord);
        Result := 0;
      end;
    varBoolean:  Result := Word(V.VBoolean);
    varByte:     Result := V.VByte;
    varWord:     Result := V.VWord;
  else
    try
      {$RANGECHECKS ON}
      Result := _VarToInteger(V);
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}
    except
      HandleConversionException(V.VType, varWord);
      Result := 0;
    end;
  end;
end;

function _VarToLongWord(const V: TVarData): LongWord;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varLongWord);
        Result := 0;
      end;
    varBoolean:  Result := LongWord(V.VBoolean);
    varByte:     Result := V.VByte;
    varWord:     Result := V.VWord;
    varLongWord: Result := V.VLongWord;
  else
    try
      {$RANGECHECKS ON}
      Result := _VarToInt64(V);
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}
    except
      HandleConversionException(V.VType, varLongWord);
      Result := 0;
    end;
  end;
end;

{ **************************************************************************** }
{ Quick Int64 support }
{ **************************************************************************** }

function VarToInt64ViaOS(const V: TVarData): Int64;
var
  LTemp: TVarData;
  LResult: HResult;
begin
  VariantInit(LTemp);
  LResult := VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varInteger);
  if LResult = VAR_OK then
    Result := LTemp.VInteger
  else
  begin
    LResult := VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varDouble);
    if LResult = VAR_OK then
      Result := Round(LTemp.VDouble)
    else if LResult = VAR_TYPEMISMATCH then
      Result := Int64(_VarToBoolean(V))
    else
    begin
      VarResultCheck(LResult, V.VType, varInt64);
      Result := 0;
    end;
  end;
end;

function VarToInt64AsString(const V: TVarData): Int64;
var
  S: WideString;
  LResult: HResult;
  LInteger: Integer;
  LDouble: Double;
begin
  _VarToWStr(S, V);
  if not TryStrToInt64(S, Result) then
  begin
    LResult := VarI4FromStr(PWideChar(S), VAR_LOCALE_USER_DEFAULT, 0, LInteger);
    if LResult = VAR_OK then
      Result := LInteger
    else
    begin
      LResult := VarR8FromStr(PWideChar(S), VAR_LOCALE_USER_DEFAULT, 0, LDouble);
      if LResult = VAR_OK then
        Result := Round(LDouble)
      else if LResult = VAR_TYPEMISMATCH then
        Result := Int64(_VarToBoolean(V))
      else
      begin
        VarResultCheck(LResult, V.VType, varInt64);
        Result := 0;
      end;
    end;
  end;
end;

function VarToInt64Any(const V: TVarData): Int64;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    Result := _VarToInt64(LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToInt64Custom(const V: TVarData; out AValue: Int64): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    LHandler.CastTo(LTemp, V, varInt64);
    AValue := LTemp.VInt64;
  end;
end;

function _VarToInt64(const V: TVarData): Int64;
begin
  try
    case V.VType of
      varEmpty:    Result := 0;
      varNull:
        begin
          if NullStrictConvert then
            VarCastError(varNull, varInt64);
          Result := 0;
        end;
      varSmallInt: Result := V.VSmallInt;
      varInteger:  Result := V.VInteger;
      varSingle:   Result := Round(V.VSingle);
      varDouble:   Result := Round(V.VDouble);
      varCurrency: Result := Round(V.VCurrency);
      varDate:     Result := Round(V.VDate);
      varOleStr:   Result := VarToInt64AsString(V);
      varBoolean:  Result := Int64(V.VBoolean);
      varShortInt: Result := V.VShortInt;
      varByte:     Result := V.VByte;
      varWord:     Result := V.VWord;
      varLongWord: Result := V.VLongWord;
      varInt64:    Result := V.VInt64;
      varUInt64:   Result := V.VUInt64;

      varVariant:  Result := _VarToInt64(PVarData(V.VPointer)^);

      varDispatch,
      varUnknown:  Result := VarToInt64ViaOS(V);
    else
      case V.VType of
        varString: Result := VarToInt64AsString(V);
        varUString: Result := VarToInt64AsString(V);
        varAny:    Result := VarToInt64Any(V);
      else
        if V.VType and varByRef <> 0 then
          case V.VType and not varByRef of
            varSmallInt: Result := PSmallInt(V.VPointer)^;
            varInteger:  Result := PInteger(V.VPointer)^;
            varSingle:   Result := Round(PSingle(V.VPointer)^);
            varDouble:   Result := Round(PDouble(V.VPointer)^);
            varCurrency: Result := Round(PCurrency(V.VPointer)^);
            varDate:     Result := Round(PDate(V.VPointer)^);
            varOleStr:   Result := VarToInt64AsString(V);
            varBoolean:  Result := Integer(PWordBool(V.VPointer)^);
            varShortInt: Result := PShortInt(V.VPointer)^;
            varByte:     Result := PByte(V.VPointer)^;
            varWord:     Result := PWord(V.VPointer)^;
            varLongWord: Result := PLongWord(V.VPointer)^;
            varInt64:    Result := PInt64(V.VPointer)^;
            varUInt64:   Result := PUInt64(V.VPointer)^;

            varVariant:  Result := _VarToInt64(PVarData(V.VPointer)^);
          else
            Result := VarToInt64ViaOS(V);
          end
        else
          if not VarToInt64Custom(V, Result) then
            Result := VarToInt64ViaOS(V);
      end;
    end;
  except
    HandleConversionException(V.VType, varInt64);
    Result := 0;
  end;
end;

function _VarToUInt64(const V: TVarData): UInt64;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varLongWord);
        Result := 0;
      end;
    varBoolean:  Result := UInt64(V.VBoolean);
    varByte:     Result := V.VByte;
    varWord:     Result := V.VWord;
    varLongWord: Result := V.VLongWord;
    varUInt64:   Result := V.VUInt64;
    varUInt64 or varByRef: Result := PUInt64(V.VPointer)^;
  else
    try
    {$RANGECHECKS ON}
      Result := _VarToInt64(V);
    {$IFDEF RANGECHECKINGOFF}
      {$RANGECHECKS OFF}
    {$ENDIF}
    except
      HandleConversionException(V.VType, varUInt64);
      Result := 0;
    end;
  end;
end;

{ **************************************************************************** }
{ Quick Boolean support }
{ **************************************************************************** }

function VarToBoolAsString(const V: TVarData): Boolean;
var
  S: WideString;
  LResult: HResult;
  LValue: WordBool;
begin
  _VarToWStr(S, V);
  LResult := VarBoolFromStr(PWideChar(S), VAR_LOCALE_USER_DEFAULT, 0, LValue);
  case LResult of
    VAR_OK:
      Result := LValue;
    VAR_TYPEMISMATCH:
      if not TryStrToBool(S, Result) then
        VarResultCheck(VAR_TYPEMISMATCH, V.VType, varBoolean);
  else
    VarResultCheck(LResult, V.VType, varBoolean);
  end;
end;

function VarToBoolViaOS(const V: TVarData): Boolean;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  VarResultCheck(VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varBoolean),
                 V.VType, varBoolean);
  Result := LTemp.VBoolean;
end;

function VarToBoolAny(const V: TVarData): Boolean;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    Result := _VarToBoolean(LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToBoolCustom(const V: TVarData; out AValue: Boolean): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    LHandler.CastTo(LTemp, V, varBoolean);
    AValue := LTemp.VBoolean;
  end;
end;

function _VarToBoolean(const V: TVarData): Boolean;
begin
  case V.VType of
    varEmpty:    Result := False;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varBoolean);
        Result := False;
      end;
    varSmallInt: Result := V.VSmallInt <> 0;
    varInteger:  Result := V.VInteger <> 0;
    varSingle:   Result := V.VSingle <> 0;
    varDouble:   Result := V.VDouble <> 0;
    varCurrency: Result := V.VCurrency <> 0;
    varDate:     Result := V.VDate <> 0;
    varOleStr:   Result := VarToBoolAsString(V);
    varBoolean:  Result := V.VBoolean;
    varShortInt: Result := V.VShortInt <> 0;
    varByte:     Result := V.VByte <> 0;
    varWord:     Result := V.VWord <> 0;
    varLongWord: Result := V.VLongWord <> 0;
    varInt64:    Result := V.VInt64 <> 0;
    varUInt64:   Result := V.VUInt64 <> 0;

    varVariant:  Result := _VarToBoolean(PVarData(V.VPointer)^);

    varDispatch,
    varUnknown:  Result := VarToBoolViaOS(V);
  else
    case V.VType of
      varString: Result := VarToBoolAsString(V);
      varUString: Result := VarToBoolAsString(V);
      varAny:    Result := VarToBoolAny(V);
    else
      if V.VType and varByRef <> 0 then
        case V.VType and not varByRef of
          varSmallInt: Result := PSmallInt(V.VPointer)^ <> 0;
          varInteger:  Result := PInteger(V.VPointer)^ <> 0;
          varSingle:   Result := PSingle(V.VPointer)^ <> 0;
          varDouble:   Result := PDouble(V.VPointer)^ <> 0;
          varCurrency: Result := PCurrency(V.VPointer)^ <> 0;
          varDate:     Result := PDate(V.VPointer)^ <> 0;
          varOleStr:   Result := VarToBoolAsString(V);
          varBoolean:  Result := PWordBool(V.VPointer)^;
          varShortInt: Result := PShortInt(V.VPointer)^ <> 0;
          varByte:     Result := PByte(V.VPointer)^ <> 0;
          varWord:     Result := PWord(V.VPointer)^ <> 0;
          varLongWord: Result := PLongWord(V.VPointer)^ <> 0;
          varInt64:    Result := PInt64(V.VPointer)^ <> 0;
          varUInt64:   Result := PUInt64(V.VPointer)^ <> 0;

          varVariant:  Result := _VarToBoolean(PVarData(V.VPointer)^);
        else
          Result := VarToBoolViaOS(V);
        end
      else
        if not VarToBoolCustom(V, Result) then
          Result := VarToBoolViaOS(V);
    end;
  end;
end;

// this wrapper fixes a boolean/longbool bit clearing issue
function _VarToBool(const V: TVarData): LongBool;
{$IFNDEF X86ASM}
begin
{$IFDEF CPUX86}
  if _VarToBoolean(V) then
    PLongInt(@Result)^ := 1
  else
    PLongInt(@Result)^ := 0;
{$ELSE}
    Result := _VarToBoolean(V);
{$ENDIF}
end;
{$ELSE X86ASM}
asm
{$IFDEF ALIGN_STACK}
  SUB     ESP, 12
{$ENDIF ALIGN_STACK}
  CALL  _VarToBoolean
{$IFDEF ALIGN_STACK}
  ADD     ESP, 12
{$ENDIF ALIGN_STACK}
  NEG   AL
  SBB   EAX,EAX
  NEG   EAX
end;
{$ENDIF X86ASM}

{ **************************************************************************** }
{ Quick Double support }
{ **************************************************************************** }

function VarToDoubleAsString(const V: TVarData): Double;
var
  S: WideString;
  LValue: Extended;
  LResult: HResult;
begin
  _VarToWStr(S, V);
  LResult := VarR8FromStr(PWideChar(S), VAR_LOCALE_USER_DEFAULT, 0, Result);
  case LResult of
    VAR_OK:; // in this case the OS function has put the value into result
    VAR_TYPEMISMATCH:
      if TryStrToFloat(S, LValue) then
        Result := LValue
      else
        VarResultCheck(VAR_TYPEMISMATCH, V.VType, varDouble);
  else
    VarResultCheck(LResult, V.VType, varDouble);
  end;
end;

function VarToDoubleViaOS(const V: TVarData): Double;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  VarResultCheck(VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varDouble),
                 V.VType, varDouble);
  Result := LTemp.VDouble;
end;

function VarToDoubleAny(const V: TVarData): Double;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    Result := _VarToDouble(LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToDoubleCustom(const V: TVarData; out AValue: Double): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    LHandler.CastTo(LTemp, V, varDouble);
    AValue := LTemp.VDouble;
  end;
end;

function _VarToDouble(const V: TVarData): Double;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varDouble);
        Result := 0;
      end;
    varSmallInt: Result := V.VSmallInt;
    varInteger:  Result := V.VInteger;
    varSingle:   Result := V.VSingle;
    varDouble:   Result := V.VDouble;
    varCurrency: Result := V.VCurrency;
    varDate:     Result := V.VDate;
    varOleStr:   Result := VarToDoubleAsString(V);
    varBoolean:  Result := Integer(V.VBoolean);
    varShortInt: Result := V.VShortInt;
    varByte:     Result := V.VByte;
    varWord:     Result := V.VWord;
    varLongWord: Result := V.VLongWord;
    varInt64:    Result := V.VInt64;
    varUInt64:   Result := V.VUInt64;

    varVariant:  Result := _VarToDouble(PVarData(V.VPointer)^);

    varDispatch,
    varUnknown:  Result := VarToDoubleViaOS(V);
  else
    case V.VType of
      varString: Result := VarToDoubleAsString(V);
      varUString: Result := VarToDoubleAsString(V);
      varAny:    Result := VarToDoubleAny(V);
    else
      if V.VType and varByRef <> 0 then
        case V.VType and not varByRef of
          varSmallInt: Result := PSmallInt(V.VPointer)^;
          varInteger:  Result := PInteger(V.VPointer)^;
          varSingle:   Result := PSingle(V.VPointer)^;
          varDouble:   Result := PDouble(V.VPointer)^;
          varCurrency: Result := PCurrency(V.VPointer)^;
          varDate:     Result := PDate(V.VPointer)^;
          varOleStr:   Result := VarToDoubleAsString(V);
          varBoolean:  Result := Integer(PWordBool(V.VPointer)^);
          varShortInt: Result := PShortInt(V.VPointer)^;
          varByte:     Result := PByte(V.VPointer)^;
          varWord:     Result := PWord(V.VPointer)^;
          varLongWord: Result := PLongWord(V.VPointer)^;
          varInt64:    Result := PInt64(V.VPointer)^;
          varUInt64:   Result := PUInt64(V.VPointer)^;

          varVariant:  Result := _VarToDouble(PVarData(V.VPointer)^);
        else
          Result := VarToDoubleViaOS(V);
        end
      else
        if not VarToDoubleCustom(V, Result) then
          Result := VarToDoubleViaOS(V);
    end;
  end;
end;

function _VarToReal(const V: TVarData): Extended;
begin
  Result := _VarToDouble(V);
end;

function _VarToSingle(const V: TVarData): Single;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varSingle);
        Result := 0;
      end;
    varSmallInt: Result := V.VSmallInt;
    varInteger:  Result := V.VInteger;
    varSingle:   Result := V.VSingle;
    varBoolean:  Result := Integer(V.VBoolean);
    varShortInt: Result := V.VShortInt;
    varByte:     Result := V.VByte;
    varWord:     Result := V.VWord;
    varLongWord: Result := V.VLongWord;
    varUInt64:   Result := V.VUInt64;
    varInt64:    Result := V.VInt64;
  else
    try
      {$RANGECHECKS ON}
      Result := _VarToDouble(V);
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}
    except
      HandleConversionException(V.VType, varSingle);
      Result := 0;
    end;
  end;
end;

{ **************************************************************************** }
{ Quick Date support }
{ **************************************************************************** }

function VarToDateAsString(const V: TVarData): TDateTime;
var
  S: WideString;
  D: Double;
  LResult: HResult;
begin
  _VarToWStr(S, V);
  LResult := VarDateFromStr(PWideChar(S), VAR_LOCALE_USER_DEFAULT, 0, Result);
  case LResult of
    VAR_OK:; // in this case the OS function has put the value into result
    VAR_TYPEMISMATCH:
      if not TryStrToDate(S, Result) then
        if TryStrToFloat(S, D) then
          Result := D
        else
          VarResultCheck(VAR_TYPEMISMATCH, V.VType, varDate);
  else
    VarResultCheck(LResult, V.VType, varDate);
  end;
end;

function VarToDateAsDouble(const V: TVarData; const Value: Double): TDateTime;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  LTemp.VType := varDouble;
  LTemp.VDouble := Value;
  VarResultCheck(VariantChangeTypeEx(LTemp, LTemp, VAR_LOCALE_USER_DEFAULT, 0, varDate),
                 V.VType, varDate);
  Result := LTemp.VDate;
end;

function VarToDateViaOS(const V: TVarData): TDateTime;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  VarResultCheck(VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varDate),
                 V.VType, varDate);
  Result := LTemp.VDate;
end;

function VarToDateAny(const V: TVarData): TDateTime;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    Result := _VarToDate(LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToDateCustom(const V: TVarData; out AValue: TDateTime): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    LHandler.CastTo(LTemp, V, varDate);
    AValue := LTemp.VDate;
  end;
end;

function _VarToDate(const V: TVarData): TDateTime;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varDate);
        Result := 0;
      end;
    varSmallInt: Result := V.VSmallInt;
    varInteger:  Result := V.VInteger;
    varSingle,
    varDouble,
    varCurrency: Result := VarToDateViaOS(V);
    varDate:     Result := V.VDate;
    varOleStr:   Result := VarToDateAsString(V);
    varBoolean:  Result := Integer(V.VBoolean);
    varShortInt: Result := V.VShortInt;
    varByte:     Result := V.VByte;
    varWord:     Result := V.VWord;
    varLongWord: Result := V.VLongWord;
    varInt64:    Result := VarToDateAsDouble(V, V.VInt64);
    varUInt64:   Result := VarToDateAsDouble(V, V.VUInt64);

    varVariant:  Result := _VarToDate(PVarData(V.VPointer)^);

    varDispatch,
    varUnknown:  Result := VarToDateViaOS(V);
  else
    case V.VType of
      varString: Result := VarToDateAsString(V);
      varUString: Result := VarToDateAsString(V);
      varAny:    Result := VarToDateAny(V);
    else
      if V.VType and varByRef <> 0 then
        case V.VType and not varByRef of
          varSmallInt: Result := PSmallInt(V.VPointer)^;
          varInteger:  Result := PInteger(V.VPointer)^;
          varSingle,
          varDouble,
          varCurrency: Result := VarToDateViaOS(V);
          varDate:     Result := PDate(V.VPointer)^;
          varOleStr:   Result := VarToDateAsString(V);
          varBoolean:  Result := Integer(PWordBool(V.VPointer)^);
          varShortInt: Result := PShortInt(V.VPointer)^;
          varByte:     Result := PByte(V.VPointer)^;
          varWord:     Result := PWord(V.VPointer)^;
          varLongWord: Result := PLongWord(V.VPointer)^;
          varInt64:    Result := VarToDateAsDouble(V, PInt64(V.VPointer)^);
          varUInt64:   Result := VarToDateAsDouble(V, PUInt64(V.VPointer)^);

          varVariant:  Result := _VarToDate(PVarData(V.VPointer)^);
        else
          Result := VarToDateViaOS(V);
        end
      else
      begin
        if not VarToDateCustom(V, Result) then
          Result := VarToDateViaOS(V);
      end;
    end;
  end;
end;

{ **************************************************************************** }
{ Quick Currency support }
{ **************************************************************************** }

function VarToCurrencyAsString(const V: TVarData): Currency;
var
  S: WideString;
  LResult: HResult;
begin
  _VarToWStr(S, V);
  LResult := VarCyFromStr(PWideChar(S), VAR_LOCALE_USER_DEFAULT, 0, Result);
  case LResult of
    VAR_OK:; // in this case the OS function has put the value into result
    VAR_TYPEMISMATCH:
      if not TryStrToCurr(S, Result) then
        VarResultCheck(VAR_TYPEMISMATCH, V.VType, varCurrency);
  else
    VarResultCheck(LResult, V.VType, varCurrency);
  end;
end;

function VarToCurrencyAsDouble(const V: TVarData; const Value: Double): Currency;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  LTemp.VType := varDouble;
  LTemp.VDouble := Value;
  VarResultCheck(VariantChangeTypeEx(LTemp, LTemp, VAR_LOCALE_USER_DEFAULT, 0, varCurrency),
                 V.VType, varCurrency);
  Result := LTemp.VCurrency;
end;

function VarToCurrencyViaOS(const V: TVarData): Currency;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  VarResultCheck(VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varCurrency),
                 V.VType, varCurrency);
  Result := LTemp.VCurrency;
end;

function VarToCurrencyAny(const V: TVarData): Currency;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    Result := _VarToCurrency(LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToCurrencyCustom(const V: TVarData; out AValue: Currency): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    LHandler.CastTo(LTemp, V, varCurrency);
    AValue := LTemp.VCurrency;
  end;
end;

function _VarToCurrency(const V: TVarData): Currency;
begin
  case V.VType of
    varEmpty:    Result := 0;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varCurrency);
        Result := 0;
      end;
    varSmallInt: Result := V.VSmallInt;
    varInteger:  Result := V.VInteger;
    varSingle,
    varDouble:   Result := VarToCurrencyViaOS(V);
    varCurrency: Result := V.VCurrency;
    varDate:     Result := VarToCurrencyViaOS(V);
    varOleStr:   Result := VarToCurrencyAsString(V);
    varBoolean:  Result := Integer(V.VBoolean);
    varShortInt: Result := V.VShortInt;
    varByte:     Result := V.VByte;
    varWord:     Result := V.VWord;
    varLongWord: Result := V.VLongWord;
    varInt64:    Result := VarToCurrencyAsDouble(V, V.VInt64);
    varUInt64:   Result := VarToCurrencyAsDouble(V, V.VUInt64);

    varVariant:  Result := _VarToCurrency(PVarData(V.VPointer)^);

    varDispatch,
    varUnknown:  Result := VarToCurrencyViaOS(V);
  else
    case V.VType of
      varString: Result := VarToCurrencyAsString(V);
      varUString: Result := VarToCurrencyAsString(V);
      varAny:    Result := VarToCurrencyAny(V);
    else
      if V.VType and varByRef <> 0 then
        case V.VType and not varByRef of
          varSmallInt: Result := PSmallInt(V.VPointer)^;
          varInteger:  Result := PInteger(V.VPointer)^;
          varSingle,
          varDouble:   Result := VarToCurrencyViaOS(V);
          varCurrency: Result := PCurrency(V.VPointer)^;
          varDate:     Result := VarToCurrencyViaOS(V);
          varOleStr:   Result := VarToCurrencyAsString(V);
          varBoolean:  Result := Integer(PWordBool(V.VPointer)^);
          varShortInt: Result := PShortInt(V.VPointer)^;
          varByte:     Result := PByte(V.VPointer)^;
          varWord:     Result := PWord(V.VPointer)^;
          varLongWord: Result := PLongWord(V.VPointer)^;
          varInt64:    Result := VarToCurrencyAsDouble(V, PInt64(V.VPointer)^);
          varUInt64:   Result := VarToCurrencyAsDouble(V, PUInt64(V.VPointer)^);

          varVariant:  Result := _VarToCurrency(PVarData(V.VPointer)^);
        else
          Result := VarToCurrencyViaOS(V);
        end
      else
      begin
        if not VarToCurrencyCustom(V, Result) then
          Result := VarToCurrencyViaOS(V);
      end;
    end;
  end;
end;

{ **************************************************************************** }
{ Quick String support }
{ **************************************************************************** }

//{$IFNDEF NEXTGEN}
function CurrToWStrViaOS(const AValue: Currency): WideString;
begin
  VarResultCheck(VarBStrFromCy(AValue, VAR_LOCALE_USER_DEFAULT, 0, Result),
                 varCurrency, varOleStr);
end;

function DateToWStrViaOS(const AValue: TDateTime): WideString;
begin
  VarResultCheck(VarBStrFromDate(AValue, VAR_LOCALE_USER_DEFAULT, 0, Result),
                 varDate, varOleStr);
end;

function BoolToWStrViaOS(const AValue: WordBool): WideString;
begin
  VarResultCheck(VarBStrFromBool(AValue, VAR_LOCALE_USER_DEFAULT, 0, Result),
                 varBoolean, varOleStr);
  case BooleanToStringRule of
    bsrAsIs:;
    bsrLower: Result := Lowercase(Result);
    bsrUpper: Result := Uppercase(Result);
  else
    VarInvalidOp;
  end;
end;
//{$ENDIF !NEXTGEN}

function VarToLStrViaOS(const V: TVarData): string;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    VarResultCheck(VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varOleStr),
                   V.VType, varString);
    Result := Copy(LTemp.VOleStr, 1, MaxInt);
  finally
    _VarClear(LTemp);
  end;
end;

{$IFNDEF NEXTGEN}
function VarToLStrAny(const V: TVarData): AnsiString;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    _VarToLStr(Result, LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToLStrCustom(const V: TVarData; out AValue: AnsiString): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    try
      LHandler.CastTo(LTemp, V, varString);
      AValue := AnsiString(LTemp.VString);
    finally
      _VarClear(LTemp);
    end;
  end;
end;

procedure _VarToLStr(var S: AnsiString; const V: TVarData);
begin
  case V.VType of
    varEmpty:    S := '';
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varString);
        S := NullAsStringValue;
      end;
    varSmallInt: S := IntToStr(V.VSmallInt);
    varInteger:  S := IntToStr(V.VInteger);
    varSingle:   S := FloatToStr(V.VSingle);
    varDouble:   S := FloatToStr(V.VDouble);
    varCurrency: S := CurrToWStrViaOS(V.VCurrency);
    varDate:     S := DateToWStrViaOS(V.VDate);
    varOleStr:   S := Copy(WideString(Pointer(V.VOleStr)), 1, MaxInt);
    varBoolean:  S := BoolToWStrViaOS(V.VBoolean);
    varShortInt: S := IntToStr(V.VShortInt);
    varByte:     S := IntToStr(V.VByte);
    varWord:     S := IntToStr(V.VWord);
    varLongWord: S := IntToStr(V.VLongWord);
    varInt64:    S := IntToStr(V.VInt64);
    varUInt64:   S := UIntToStr(V.VUInt64);

    varVariant:  _VarToLStr(S, PVarData(V.VPointer)^);

    varDispatch,
    varUnknown:  S := VarToLStrViaOS(V);
  else
    case V.VType of
      varString: S := AnsiString(V.VString);
      varUString: S := UnicodeString(V.VUString);
      varAny:    S := VarToLStrAny(V);
    else
      if V.VType and varByRef <> 0 then
        case V.VType and not varByRef of
          varSmallInt: S := IntToStr(PSmallInt(V.VPointer)^);
          varInteger:  S := IntToStr(PInteger(V.VPointer)^);
          varSingle:   S := FloatToStr(PSingle(V.VPointer)^);
          varDouble:   S := FloatToStr(PDouble(V.VPointer)^);
          varCurrency: S := CurrToWStrViaOS(PCurrency(V.VPointer)^);
          varDate:     S := DateToWStrViaOS(PDate(V.VPointer)^);
          varOleStr:   S := PWideChar(V.VPointer^);
          varBoolean:  S := BoolToWStrViaOS(PWordBool(V.VPointer)^);
          varShortInt: S := IntToStr(PShortInt(V.VPointer)^);
          varByte:     S := IntToStr(PByte(V.VPointer)^);
          varWord:     S := IntToStr(PWord(V.VPointer)^);
          varLongWord: S := IntToStr(PLongWord(V.VPointer)^);
          varInt64:    S := IntToStr(PInt64(V.VPointer)^);
          varUInt64:   S := UIntToStr(PUInt64(V.VPointer)^);
          varString:    S := PAnsiChar(V.VPointer^);
          varUString:   S := AnsiString(PWideChar(V.VPointer^));
          varVariant:  _VarToLStr(S, PVarData(V.VPointer)^);
        else
          S := VarToLStrViaOS(V);
        end
      else
        if not VarToLStrCustom(V, S) then
          S := VarToLStrViaOS(V);
    end;
  end;
end;

procedure _VarToPStr(var S; const V: TVarData);
var
  LTemp: AnsiString;
begin
  _VarToLStr(LTemp, V);
  ShortString(S) := LTemp;
end;

function VarToWStrViaOS(const V: TVarData): WideString;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    VarResultCheck(VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varOleStr),
                   V.VType, varOleStr);
    Result := Copy(LTemp.VOleStr, 1, MaxInt);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToWStrAny(const V: TVarData): WideString;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    _VarToWStr(Result, LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToWStrCustom(const V: TVarData; out AValue: WideString): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    try
      LHandler.CastTo(LTemp, V, varOleStr);
      AValue := Copy(LTemp.VOleStr, 1, MaxInt);
    finally
      _VarClear(LTemp);
    end;
  end;
end;

procedure _VarToWStr(var S: WideString; const V: TVarData);
begin
  case V.VType of
    varEmpty:    S := '';
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varOleStr);
        S := NullAsStringValue;
      end;
    varSmallInt: S := IntToStr(V.VSmallInt);
    varInteger:  S := IntToStr(V.VInteger);
    varSingle:   S := FloatToStr(V.VSingle);
    varDouble:   S := FloatToStr(V.VDouble);
    varCurrency: S := CurrToWStrViaOS(V.VCurrency);
    varDate:     S := DateToWStrViaOS(V.VDate);
    varOleStr:   S := Copy(WideString(Pointer(V.VOleStr)), 1, MaxInt);
    varBoolean:  S := BoolToWStrViaOS(V.VBoolean);
    varShortInt: S := IntToStr(V.VShortInt);
    varByte:     S := IntToStr(V.VByte);
    varWord:     S := IntToStr(V.VWord);
    varLongWord: S := IntToStr(V.VLongWord);
    varInt64:    S := IntToStr(V.VInt64);
    varUInt64:   S := UIntToStr(V.VUInt64);

    varVariant:  _VarToWStr(S, PVarData(V.VPointer)^);

    varDispatch,
    varUnknown:  S := VarToWStrViaOS(V);
  else
    case V.VType of
      varString: S := AnsiString(V.VString);
      varUString: S := UnicodeString(V.VUString);
      varAny:    S := VarToWStrAny(V);
    else
      if V.VType and varByRef <> 0 then
        case V.VType and not varByRef of
          varSmallInt: S := IntToStr(PSmallInt(V.VPointer)^);
          varInteger:  S := IntToStr(PInteger(V.VPointer)^);
          varSingle:   S := FloatToStr(PSingle(V.VPointer)^);
          varDouble:   S := FloatToStr(PDouble(V.VPointer)^);
          varCurrency: S := CurrToWStrViaOS(PCurrency(V.VPointer)^);
          varDate:     S := DateToWStrViaOS(PDate(V.VPointer)^);
          varOleStr:   S := PWideChar(V.VPointer^);
          varBoolean:  S := BoolToWStrViaOS(PWordBool(V.VPointer)^);
          varShortInt: S := IntToStr(PShortInt(V.VPointer)^);
          varByte:     S := IntToStr(PByte(V.VPointer)^);
          varWord:     S := IntToStr(PWord(V.VPointer)^);
          varLongWord: S := IntToStr(PLongWord(V.VPointer)^);
          varInt64:    S := IntToStr(PInt64(V.VPointer)^);
          varUInt64:   S := UIntToStr(PUInt64(V.VPointer)^);

          varString:   S := WideString(PAnsiChar(V.VPointer^));
          varUString:  S := PWideChar(V.VPointer^);

          varVariant:  _VarToWStr(S, PVarData(V.VPointer)^);
        else
          S := VarToWStrViaOS(V);
        end
      else
        if not VarToWStrCustom(V, S) then
          S := VarToWStrViaOS(V);
    end;
  end;
end;
{$ENDIF !NEXTGEN}

function VarToUStrAny(const V: TVarData): UnicodeString;
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    _VarToUStr(Result, LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

function VarToUStrCustom(const V: TVarData; out AValue: UnicodeString): Boolean;
var
  LHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  Result := FindCustomVariantType(V.VType, LHandler);
  if Result then
  begin
    VariantInit(LTemp);
    try
      //LHandler.CastTo(LTemp, V, varOleStr);
      //AValue := Copy(LTemp.VOleStr, 1, MaxInt);
      LHandler.CastTo(LTemp, V, varUString);
      _VarToUStr(AValue, LTemp);
    finally
      _VarClear(LTemp);
    end;
  end;
end;

procedure _VarToUStr(var S: UnicodeString; const V: TVarData);
begin
  case V.VType of
    varEmpty:    S := '';
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varOleStr);
        S := NullAsStringValue;
      end;
    varSmallInt: S := IntToStr(V.VSmallInt);
    varInteger:  S := IntToStr(V.VInteger);
    varSingle:   S := FloatToStr(V.VSingle);
    varDouble:   S := FloatToStr(V.VDouble);
    varShortInt: S := IntToStr(V.VShortInt);
    varByte:     S := IntToStr(V.VByte);
    varWord:     S := IntToStr(V.VWord);
    varLongWord: S := IntToStr(V.VLongWord);
    varInt64:    S := IntToStr(V.VInt64);
    varUInt64:   S := UIntToStr(V.VUInt64);

    varVariant:  _VarToUStr(S, PVarData(V.VPointer)^);

{$IFNDEF NEXTGEN}
    varCurrency: S := CurrToWStrViaOS(V.VCurrency);
    varDate:     S := DateToWStrViaOS(V.VDate);
    varOleStr:   S := Copy(WideString(Pointer(V.VOleStr)), 1, MaxInt);
    varBoolean:  S := BoolToWStrViaOS(V.VBoolean);
    varDispatch,
    varUnknown:  S := VarToWStrViaOS(V);
{$ELSE}
                                                                                     
    varCurrency: S := CurrToStr(V.VCurrency);
    varDate:     S := DateTimeToStr(V.VDate);
    varOleStr:   S := Copy(PChar(V.VOleStr), 1, MaxInt);
    varBoolean:  S := BoolToStr(V.VBoolean,True);
                                                                                          
{$ENDIF !NEXTGEN}
  else
    case V.VType of
{$IFNDEF NEXTGEN}
      varString: S := AnsiString(V.VString);
{$ENDIF !NEXTGEN}
      varUString: S := UnicodeString(V.VUString);
      varAny:    S := VarToUStrAny(V);
    else
      if V.VType and varByRef <> 0 then
        case V.VType and not varByRef of
          varSmallInt: S := IntToStr(PSmallInt(V.VPointer)^);
          varInteger:  S := IntToStr(PInteger(V.VPointer)^);
          varSingle:   S := FloatToStr(PSingle(V.VPointer)^);
          varDouble:   S := FloatToStr(PDouble(V.VPointer)^);
          varShortInt: S := IntToStr(PShortInt(V.VPointer)^);
          varByte:     S := IntToStr(PByte(V.VPointer)^);
          varWord:     S := IntToStr(PWord(V.VPointer)^);
          varLongWord: S := IntToStr(PLongWord(V.VPointer)^);
          varInt64:    S := IntToStr(PInt64(V.VPointer)^);
          varUInt64:   S := UIntToStr(PUInt64(V.VPointer)^);
          varVariant:  _VarToUStr(S, PVarData(V.VPointer)^);
{$IFNDEF NEXTGEN}
          varCurrency: S := CurrToWStrViaOS(PCurrency(V.VPointer)^);
          varDate:     S := DateToWStrViaOS(PDate(V.VPointer)^);
          varOleStr:   S := PWideChar(V.VPointer^);
          varBoolean:  S := BoolToWStrViaOS(PWordBool(V.VPointer)^);
          varString:    S := UnicodeString(PAnsiChar(V.VPointer^));
          varUString:   S := PWideChar(V.VPointer^);
        else
          S := VarToWStrViaOS(V);
{$ELSE NEXTGEN}
          varCurrency: S := CurrToStr(PCurrency(V.VPointer)^);
          varDate:     S := DateTimeToStr(PDate(V.VPointer)^);
          varOleStr:   S := Copy(PChar(V.VPointer^), 1, MaxInt);
          varBoolean:  S := BoolToStr(PWordBool(V.VPointer)^);
          varUString:   S := PWideChar(V.VPointer^);
                                                            
{$ENDIF NEXTGEN}
        end
      else
        if not VarToUStrCustom(V, S) then
{$IFNDEF NEXTGEN}
          S := VarToWStrViaOS(V);
{$ELSE NEXTGEN}
                                                         
          ; // Now we do nothing
{$ENDIF !NEXTGEN}
    end;
  end;
end;

procedure AnyToIntf(var Intf: IInterface; const V: TVarData);
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, V);
    ChangeAnyProc(LTemp);
    if LTemp.VType <> varUnknown then
      VarCastError(varAny, varUnknown);
    Intf := IInterface(LTemp.VUnknown);
  finally
    _VarClear(LTemp);
  end;
end;

procedure _VarToIntf(var Intf: IInterface; const V: TVarData);
var
  LHandler: TCustomVariantType;
begin
  case V.VType of
    varEmpty                : Intf := nil;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varUnknown);
        Intf := nil;
      end;
    varUnknown,
    varDispatch             : Intf := IInterface(V.VUnknown);
    varUnknown + varByRef,
    varDispatch + varByRef  : Intf := IInterface(V.VPointer^);
    varAny                  : AnyToIntf(Intf, V);
  else
    if not (FindCustomVariantType(V.VType, LHandler) and
            LHandler.GetInterface(IInterface, Intf)) then
      VarCastError(V.VType, varUnknown);
  end;
end;

procedure _VarToDisp(var Dispatch: IDispatch; const V: TVarData);
var
  LHandler: TCustomVariantType;
begin
  case V.VType of
    varEmpty               : Dispatch := nil;
    varNull:
      begin
        if NullStrictConvert then
          VarCastError(varNull, varDispatch);
        Dispatch := nil;
      end;
    varDispatch            : Dispatch := IDispatch(V.VDispatch);
    varDispatch + varByRef : Dispatch := IDispatch(V.VPointer^);
  else
    if not (FindCustomVariantType(V.VType, LHandler) and
            LHandler.GetInterface(IDispatch, Dispatch)) then
      VarCastError(V.VType, varDispatch);
  end;
end;

procedure _VarToDynArray(var DynArray: Pointer; const V: TVarData; TypeInfo: Pointer);
{$IFNDEF X86ASM}
begin
  DynArrayFromVariant(DynArray, Variant(V), TypeInfo);
  if DynArray = nil then
    VarCastError();
end;
{$ELSE X86ASM}
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        CALL    DynArrayFromVariant
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        OR      EAX, EAX
        JNZ     @@1
        JMP     VarCastError
@@1:
end;
{$ENDIF X86ASM}

procedure _VarFromInt(var V: TVarData; const Value: Integer; const Range: ShortInt);
const
  CRangeToType: array [-4..4] of TVarType = (varInteger, varError, varSmallInt, varShortInt,
                                             varError,
                                             varByte, varWord, varError, varLongWord);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  if PackVarCreation then
    V.VType := CRangeToType[Range]
  else
    V.VType := varInteger;
  V.VInteger := Value;
end;

procedure _VarFromInteger(var V: TVarData; const Value: Integer);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varInteger;
  V.VInteger := Value;
end;

procedure _OleVarFromInt(var V: TVarData; const Value: Integer; const Range: ShortInt);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varInteger;
  V.VInteger := Value;
end;

procedure _OleVarFromInt64(var V: TVarData; const Value: Int64);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  // check global flag and decide how to handle int64
  if not OleVariantInt64AsDouble then
  begin
    V.VType := varInt64;
    V.VInt64 := Value;
  end
  else
  begin
    V.VType := varDouble;
    V.VDouble := Value;
  end;
end;

procedure _OleVarFromUInt64(var V: TVarData; const Value: UInt64);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  // check global flag and decide how to handle int64
  if not OleVariantInt64AsDouble then
  begin
    V.VType := varUInt64;
    V.VUInt64 := Value;
  end
  else
  begin
    V.VType := varDouble;
    V.VDouble := Value;
  end;
end;

procedure _VarFromByte(var V: TVarData; const Value: Byte);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varByte;
  V.VByte := Value;
end;

procedure _VarFromWord(var V: TVarData; const Value: Word);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varWord;
  V.VWord := Value;
end;

procedure _VarFromLongWord(var V: TVarData; const Value: LongWord);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varLongWord;
  V.VLongWord := Value;
end;

procedure _VarFromUInt64(var V: TVarData; const Value: UInt64);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varUInt64;
  V.VUInt64 := Value;
end;

procedure _VarFromShortInt(var V: TVarData; const Value: ShortInt);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varShortInt;
  V.VShortInt := Value;
end;

procedure _VarFromSmallInt(var V: TVarData; const Value: SmallInt);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varSmallInt;
  V.VSmallInt := Value;
end;

procedure _VarFromInt64(var V: TVarData; const Value: Int64);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varInt64;
  V.VInt64 := Value;
end;

procedure _VarFromSingle(var Dest: TVarData; const Value: Single);
begin
  if (Dest.VType and varDeepData) <> 0 then
    VarClearDeep(Dest);
  Dest.VSingle := Value;
  Dest.VType := varSingle;
end;

procedure _VarFromDouble(var Dest: TVarData; const Value: Double);
begin
  if (Dest.VType and varDeepData) <> 0 then
    VarClearDeep(Dest);
  Dest.VDouble := Value;
  Dest.VType := varDouble;
end;

procedure _VarFromCurrency(var Dest: TVarData; const Value: Currency);
begin
  if (Dest.VType and varDeepData) <> 0 then
    VarClearDeep(Dest);
  Dest.VCurrency := Value;
  Dest.VType := varCurrency;
end;

procedure _VarFromDate(var Dest: TVarData; const Value: TDateTime);
begin
  if (Dest.VType and varDeepData) <> 0 then
    VarClearDeep(Dest);
  Dest.VDate := Value;
  Dest.VType := varDate;
end;

procedure _VarFromBool(var V: TVarData; const Value: Boolean);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varBoolean;
  V.VBoolean := Value;
end;

{$IFNDEF X86ASM}
procedure _VarFromReal(var V: TVarData; const Value: Real);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varDouble;
  V.VDouble := Value;
end;
{$ELSE X86ASM}
procedure _VarFromReal; // var V: TVarData; const Value: Real
asm
        SUB     ESP, 8
        FSTP    [ESP].Double
        FWAIT
        PUSH    EAX
        CALL    _VarClear
        POP     EAX

        MOV     [EAX].TVarData.VType,varDouble
        FLD     [ESP].Double
        FSTP    [EAX].TVarData.VDouble
        FWAIT
        ADD     ESP, 8
end;
{$ENDIF !X86ASM}

{$IFNDEF X86ASM}
procedure _VarFromTDateTime(var V: TVarData; const Value: TDateTime);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varDate;
  V.VDate := Value;
end;
{$ELSE X86ASM}
procedure _VarFromTDateTime; // var V: TVarData; const Value: TDateTime
asm
        SUB     ESP, 8
        FSTP    [ESP].Double
        FWAIT
        PUSH    EAX
        CALL    _VarClear
        POP     EAX

        MOV     [EAX].TVarData.VType,varDate
        FLD     [ESP].Double
        FSTP    [EAX].TVarData.VDouble
        FWAIT
        ADD     ESP, 8
end;
{$ENDIF X86ASM}

{$IFNDEF X86ASM}
procedure _VarFromCurr(var V: TVarData; const Value: Currency);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VType := varCurrency;
  V.VCurrency := Value;
end;
{$ELSE X86ASM}
procedure _VarFromCurr; // var V: TVarData; const Value: Currency
asm
        SUB     ESP, 8
        FISTP   [ESP].Currency
        FWAIT
        PUSH    EAX
        CALL    _VarClear
        POP     EAX

        MOV     [EAX].TVarData.VType,varCurrency
        FILD    [ESP].Currency
        FISTP   [EAX].TVarData.VCurrency
        FWAIT
        ADD     ESP, 8
end;
{$ENDIF X86ASM}

{$IFNDEF NEXTGEN}
procedure _VarFromLStr(var V: TVarData; const Value: AnsiString);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VString := nil;
  V.VType := varString;
  AnsiString(V.VString) := Value;
end;

procedure _VarFromPStr(var V: TVarData; const Value: ShortString);
begin
  _VarFromLStr(V, Value);
end;

procedure _VarFromWStr(var V: TVarData; const Value: WideString);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VOleStr := nil;
  V.VType := varOleStr;
  WideString(Pointer(V.VOleStr)) := Copy(Value, 1, MaxInt);
end;
{$ENDIF !NEXTGEN}

procedure _VarFromUStr(var V: TVarData; const Value: UnicodeString);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VUString := nil;
  V.VType := varUString;
  UnicodeString(V.VUString) := Value;
end;


procedure _VarFromWChar(var V: TVarData; const Value: WideChar);
begin
  _VarFromWStr(V, Value);
end;

procedure _VarFromIntf(var V: TVarData; const Value: IInterface);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VUnknown := nil;
  V.VType := varUnknown;
  IInterface(V.VUnknown) := Value;
end;

procedure _VarFromDisp(var V: TVarData; const Value: IDispatch);
begin
  if (V.VType and varDeepData) <> 0 then
    VarClearDeep(V);
  V.VDispatch := nil;
  V.VType := varDispatch;
  IInterface(V.VDispatch) := Value;
end;

procedure _VarFromDynArray(var V: TVarData; const DynArray: Pointer; TypeInfo: Pointer);
{$IFNDEF X86ASM}
begin
  DynArrayToVariant(Variant(V), DynArray, TypeInfo);
  if V.VType = varEmpty then
    VarCastError();
end;
{$ELSE X86ASM}
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF ALIGN_STACK}
        PUSH    EAX
        CALL    DynArrayToVariant
        POP     EAX
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF ALIGN_STACK}
        CMP     [EAX].TVarData.VType,varEmpty
        JNE     @@1
        JMP     VarCastError
@@1:
end;
{$ENDIF X86ASM}

{$IFNDEF NEXTGEN}
procedure _OleVarFromLStr(var V: TVarData {OleVariant}; const Value: AnsiString);
begin
  _VarFromWStr(V, WideString(Value));
end;
{$ENDIF !NEXTGEN}

procedure _OleVarFromUStr(var V: TVarData; const Value: UnicodeString);
begin
  _VarFromWStr(V, Value);
end;

{$IFNDEF NEXTGEN}
procedure _OleVarFromPStr(var V: TVarData {OleVariant}; const Value: ShortString);
begin
  _OleVarFromLStr(V, Value);
end;
{$ENDIF !NEXTGEN}

procedure OleVarFromAny(var V: TVarData {OleVariant}; const Value: TVarData);
var
  LTemp: TVarData;
begin
  VariantInit(LTemp);
  try
    _VarCopy(LTemp, Value);
    ChangeAnyProc(LTemp);
    _VarCopy(V, LTemp);
  finally
    _VarClear(LTemp);
  end;
end;

procedure OleVarFromVarArrayProc(var Dest: TVarData; const Src: TVarData);
begin
  _OleVarFromVar(Dest, Src);
end;

procedure _OleVarFromVar(var Dest: TVarData {OleVariant}; const Source: TVarData);
var
  LHandler: TCustomVariantType;
begin
  // figure out source
  if Source.VType = varByRef or varVariant then
    _OleVarFromVar(Dest, PVarData(Source.VPointer)^)
  else
  begin

    // clear the destination
    if (Dest.VType and varDeepData) <> 0 then
      VarClearDeep(Dest);

    // convert the special Delphish types over to their OLE equiv
    case Source.VType of
      varShortInt, varByte, varWord:
        _VarCast(Dest, Source, varInteger);
      varLongWord:
        if Source.VLongWord and $80000000 <> 0 then
          _VarCast(Dest, Source, varDouble)
        else
          _VarCast(Dest, Source, varInteger);
      varInt64:
        if (Source.VInt64 <= High(Integer)) and (Source.VInt64 >= Low(Integer)) then
          _VarCast(Dest, Source, varInteger)
        else
          if not OleVariantInt64AsDouble then
            _VarCast(Dest, Source, varInt64)
          else
            _VarCast(Dest, Source, varDouble);
      varString:
{$IFNDEF NEXTGEN}
        _OleVarFromLStr(Dest, AnsiString(Source.VString));
{$ELSE NEXTGEN}
        VarInvalidOp;
{$ENDIF NEXTGEN}
      varUString:
        _VarFromWStr(Dest, UnicodeString(Source.VUString));
      varAny:
        OleVarFromAny(Dest, Source);
    else

      // do our own special handling for arrays
      if (Source.VType and varArray) <> 0 then
        VarArrayCopyForEach(Dest, Source, OleVarFromVarArrayProc)

      // if the base type of the variant is not custom then let the OS deal with it
      else if (Source.VType and varTypeMask) < CFirstUserType then
        _VarCopy(Dest, Source)

      // now check for custom
      else if FindCustomVariantType(Source.VType, LHandler) then
        LHandler.CastToOle(Dest, Source)

      // else fail
      else
        VarCastError;
    end;
  end;
end;

procedure VarStrCat(var Dest: Variant; const Source: Variant);
begin
  if TVarData(Dest).VType = varUString then
    Dest := UnicodeString(Dest) + UnicodeString(Source)
  else if TVarData(Dest).VType = varString then
{$IFNDEF NEXTGEN}
    Dest := AnsiString(Dest) + AnsiString(Source)
{$ELSE NEXTGEN}
    VarInvalidOp
{$ENDIF NEXTGEN}
  else
    Dest := WideString(Dest) + WideString(Source);
end;

procedure _VarOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp); forward;

procedure VarOpRare(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  LNewLeftType, LNewRightType: TVarType;
  LLeftHandler, LRightHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  // simple and ???
  if (Left.VType and varTypeMask) < CFirstUserType then
  begin

    // simple and custom but the custom doesn't really exist (nasty but possible )
    if not FindCustomVariantType(Right.VType, LRightHandler) then
      VarInvalidOp

    // does the custom want to take over?
    else if LRightHandler.LeftPromotion(Left, OpCode, LNewLeftType) then
    begin

      // convert the left side
      if Left.VType <> LNewLeftType then
      begin
        VariantInit(LTemp);
        try
          _VarCast(LTemp, Left, LNewLeftType);
          _VarCopy(Left, LTemp);
          if Left.VType <> LNewLeftType then
            VarCastError;
        finally
          _VarClear(LTemp);
        end;
      end;
      LRightHandler.BinaryOp(Left, Right, OpCode);
    end

    // simple then converts custom then
    else
    begin
      VariantInit(LTemp);
      try
        // convert the right side to the left side's type
        _VarCast(LTemp, Right, Left.VType);
        if LTemp.VType <> Left.VType then
          VarCastError;
        _VarOp(Left, LTemp, OpCode);
      finally
        _VarClear(LTemp);
      end;
    end;
  end

  // custom and something else
  else
  begin
    if not FindCustomVariantType(Left.VType, LLeftHandler) then
      VarInvalidOp;

    // does the left side like what is in the right side?
    if LLeftHandler.RightPromotion(Right, OpCode, LNewRightType) then
    begin

      // make the right side right
      if Right.VType <> LNewRightType then
      begin
        VariantInit(LTemp);
        try
          _VarCast(LTemp, Right, LNewRightType);
          if LTemp.VType <> LNewRightType then
            VarCastError;
          LLeftHandler.BinaryOp(Left, LTemp, OpCode);
        finally
          _VarClear(LTemp);
        end;
      end

      // type is correct so lets go!
      else
        LLeftHandler.BinaryOp(Left, Right, OpCode);
    end

    // custom and simple and the right one can't convert the simple
    else if (Right.VType and varTypeMask) < CFirstUserType then
    begin

      // convert the left side to the right side's type
      if Left.VType <> Right.VType then
      begin
        VariantInit(LTemp);
        try
          _VarCast(LTemp, Left, Right.VType);
          _VarCopy(Left, LTemp);
          if Left.VType <> Right.VType then
            VarCastError;
        finally
          _VarClear(LTemp);
        end;
      end;
      _VarOp(Left, Right, OpCode);
    end

    // custom and custom but the right one doesn't really exist (nasty but possible )
    else if not FindCustomVariantType(Right.VType, LRightHandler) then
      VarInvalidOp

    // custom and custom and the right one can handle the left's type
    else if LRightHandler.LeftPromotion(Left, OpCode, LNewLeftType) then
    begin

      // convert the left side
      if Left.VType <> LNewLeftType then
      begin
        VariantInit(LTemp);
        try
          _VarCast(LTemp, Left, LNewLeftType);
          _VarCopy(Left, LTemp);
          if Left.VType <> LNewLeftType then
            VarCastError;
        finally
          _VarClear(LTemp);
        end;
      end;
      LRightHandler.BinaryOp(Left, Right, OpCode);
    end

    // custom and custom but neither type can deal with each other
    else
      VarInvalidOp;
  end;
end;

function CheckType(T: TVarType): TVarType;
begin
  Result := T and varTypeMask;
  if Result > varLast then
    if (Result = varString) or (Result = varUString) then
      Result := varOleStr
    else
      VarInvalidOp;
end;

procedure AnyOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  LTemp: TVarData;
begin
  if Left.VType = varAny then
    ChangeAnyProc(Left);
  if Right.VType = varAny then
  begin
    VariantInit(LTemp);
    try
      _VarCopy(LTemp, Right);
      ChangeAnyProc(LTemp);
      _VarOp(Left, LTemp, OpCode);
    finally
      _VarClear(LTemp);
    end;
  end
  else
    _VarOp(Left, Right, OpCode);
end;

procedure RealOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  L, R: Double;
begin
  L := _VarToDouble(Left);
  R := _VarToDouble(Right);
  case OpCode of
    opAdd      :  L := L + R;
    opSubtract :  L := L - R;
    opMultiply :  L := L * R;
    opDivide   :  L := L / R;
  else
    VarInvalidOp;
  end;
  if (Left.VType and varDeepData) <> 0 then
    VarClearDeep(Left);
  Left.VDouble := L;
  Left.VType := varDouble;
end;

procedure DateOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  L, R: TDateTime;
begin
  L := _VarToDate(Left);
  R := _VarToDate(Right);
  case OpCode of
    opAdd      :  L := L + R;
    opSubtract :  L := L - R;
  else
    VarInvalidOp;
  end;
  if (Left.VType and varDeepData) <> 0 then
    VarClearDeep(Left);
  Left.VDate := L;
  Left.VType := varDate;
end;

procedure IntOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  L, R: Integer;
  Overflow: Boolean;
{$IFNDEF X86ASM}
  K: Int64;
{$ENDIF !X86ASM}
begin
  Overflow := False;
  L := _VarToInteger(Left);
  R := _VarToInteger(Right);
  case OpCode of
{$IFNDEF X86ASM}
    opAdd        : begin
                     K := Int64(L) + Int64(R);
                     L := Integer(K);
                     Overflow := K <> L;
                   end;
    opSubtract   : begin
                     K := Int64(L) - Int64(R);
                     L := Integer(K);
                     Overflow := K <> L;
                   end;
    opMultiply   : begin
                     K := Int64(L) * Int64(R);
                     L := Integer(K);
                     Overflow := K <> L
                   end;
{$ELSE X86ASM}
    opAdd        : asm
                     MOV  EAX, L
                     MOV  EDX, R
                     ADD  EAX, EDX
                     SETO Overflow
                     MOV  L, EAX
                   end;
    opSubtract   : asm
                     MOV  EAX, L
                     MOV  EDX, R
                     SUB  EAX, EDX
                     SETO Overflow
                     MOV  L, EAX
                   end;
    opMultiply   : asm
                     MOV  EAX, L
                     MOV  EDX, R
                     IMUL EDX
                     SETO Overflow
                     MOV  L, EAX
                   end;
{$ENDIF X86ASM}
    opDivide     : Overflow := True;
    opIntDivide  : L := L div R;
    opModulus    : L := L mod R;
    opShiftLeft  : L := L shl R;
    opShiftRight : L := L shr R;
    opAnd        : L := L and R;
    opOr         : L := L or R;
    opXor        : L := L xor R;
  else
    VarInvalidOp;
  end;

  if Overflow then
    RealOp(Left, Right, OpCode)
  else
  begin
    if (Left.VType and varDeepData) <> 0 then
      VarClearDeep(Left);
    Left.VInteger := L;
    Left.VType := varInteger;
  end;
end;

procedure Int64Op(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  L, R: Int64;
  Overflow: Boolean;
begin
  Overflow := False;
  L := _VarToInt64(Left);
  R := _VarToInt64(Right);
  case OpCode of
    opAdd, opSubtract, opMultiply:
      {$RANGECHECKS ON}
      try
        case OpCode of
          opAdd      : L := L + R;
          opSubtract : L := L - R;
          opMultiply : L := L * R;
        end;
      except
        on System.SysUtils.EOverflow do // Symbol collision with LibC
          Overflow := True
        else
          raise;
      end;
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}

    opDivide     : Overflow := True;
    opIntDivide  : L := L div R;
    opModulus    : L := L mod R;
    opShiftLeft  : L := L shl R;
    opShiftRight : L := L shr R;
    opAnd        : L := L and R;
    opOr         : L := L or R;
    opXor        : L := L xor R;
  else
    VarInvalidOp;
  end;

  if Overflow then
    RealOp(Left, Right, OpCode)
  else
  begin
    if (Left.VType and varDeepData) <> 0 then
      VarClearDeep(Left);
    Left.VInt64 := L;
    Left.VType := varInt64;
  end;
end;

procedure UInt64Op(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  L, R: UInt64;
  Overflow: Boolean;
begin
  Overflow := False;
  L := _VarToUInt64(Left);
  R := _VarToUInt64(Right);
  case OpCode of
    opAdd, opSubtract, opMultiply:
      {$RANGECHECKS ON}
      try
        case OpCode of
          opAdd      : L := L + R;
          opSubtract : L := L - R;
          opMultiply : L := L * R;
        end;
      except
        on System.SysUtils.EOverflow do // Symbol collision with LibC
          Overflow := True
        else
          raise;
      end;
      {$IFDEF RANGECHECKINGOFF}
        {$RANGECHECKS OFF}
      {$ENDIF}

    opDivide     : Overflow := True;
    opIntDivide  : L := L div R;
    opModulus    : L := L mod R;
    opShiftLeft  : L := L shl R;
    opShiftRight : L := L shr R;
    opAnd        : L := L and R;
    opOr         : L := L or R;
    opXor        : L := L xor R;
  else
    VarInvalidOp;
  end;

  if Overflow then
    RealOp(Left, Right, OpCode)
  else
  begin
    if (Left.VType and varDeepData) <> 0 then
      VarClearDeep(Left);
    Left.VUInt64 := L;
    Left.VType := varUInt64;
  end;
end;

procedure NullOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
begin
  case OpCode of
    opAnd:
      if Left.VType = varNull then
        if (Right.VType = varNull) or _VarToBoolean(Right) then
          _VarNull(Left)

        else
          _VarCopy(Left, Right)

      else if _VarToBoolean(Left) and (Right.VType = varNull) then
        _VarNull(Left);

    opOr:
      if Left.VType = varNull then
        if (Right.VType = varNull) or not _VarToBoolean(Right) then
          _VarNull(Left)
        else
          _VarCopy(Left, Right)

      else if not _VarToBoolean(Left) and (Right.VType = varNull) then
        _VarNull(Left);

  // all other operators act like blackholes
  else
    _VarNull(Left);
  end;
end;

procedure EmptyOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
begin
  case OpCode of
    opDivide:    raise EZeroDivide.Create(SZeroDivide); // ie: Empty/Empty = 0/0
    opIntDivide,                                        // ie: Empty/Empty = 0 div 0
    opModulus:   raise EDivByZero.Create(SDivByZero);   // ie: Empty/Empty = 0 mod 0
  else
    _VarClear(Left);
  end;
end;

procedure CurrOp(var Left: TVarData; const Right: TVarData;
  const OpCode: TVarOp; const LeftBase, RightBase: TBaseType);
var
  C: Currency;
begin
  case OpCode of
    opAdd:      C := _VarToCurrency(Left) + _VarToCurrency(Right);
    opSubtract: C := _VarToCurrency(Left) - _VarToCurrency(Right);
    opMultiply,
    opDivide:
      begin
        if (LeftBase = btCur) and (RightBase = btCur) then
        begin
          if OpCode = opMultiply then
            C := _VarToCurrency(Left) * _VarToCurrency(Right)
          else
            C := _VarToCurrency(Left) / _VarToCurrency(Right);
        end
        else if RightBase = btCur then // LeftBase <> btCur
        begin
          if OpCode = opMultiply then
            C := _VarToDouble(Left) * _VarToCurrency(Right)
          else
          begin
            if (Left.VType and varDeepData) <> 0 then
              VarClearDeep(Left);
            Left.VDouble := _VarToCurrency(Left) / _VarToCurrency(Right);
            Left.VType := varDouble;
            Exit;
          end;
        end
        else  // LeftBase = btCur, RightBase <> btCur
        begin
          if OpCode = opMultiply then
            C := _VarToCurrency(Left) * _VarToDouble(Right)
          else
            C := _VarToCurrency(Left) / _VarToDouble(Right);
        end;
      end;
  else
    IntOp(Left, Right, OpCode);
    Exit;
  end;

  if (Left.VType and varDeepData) <> 0 then
    VarClearDeep(Left);
  Left.VCurrency := C;
  Left.VType := varCurrency;
end;

procedure SimpleVarOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  LeftBase, RightBase: TBaseType;

const
  OpTypeMap: array[TBaseType, TBaseType] of TBaseType = (
         {btErr, btEmp, btNul, btInt, btFlt, btCur, btStr, btBol, btDat, btI64, btU64, btAny}
  {btErr}(btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr),
  {btEmp}(btErr, btEmp, btNul, btInt, btFlt, btCur, btStr, btBol, btDat, btI64, btU64, btAny),
  {btNul}(btErr, btNul, btNul, btNul, btNul, btNul, btNul, btNul, btNul, btNul, btNul, btAny),
  {btInt}(btErr, btInt, btNul, btInt, btFlt, btCur, btFlt, btInt, btDat, btI64, btU64, btAny),
  {btFlt}(btErr, btFlt, btNul, btFlt, btFlt, btCur, btFlt, btFlt, btDat, btFlt, btFlt, btAny),
  {btCur}(btErr, btCur, btNul, btCur, btCur, btCur, btCur, btCur, btDat, btCur, btCur, btAny),
  {btStr}(btErr, btStr, btNul, btFlt, btFlt, btCur, btStr, btBol, btDat, btFlt, btFlt, btAny),
  {btBol}(btErr, btBol, btNul, btInt, btFlt, btCur, btBol, btBol, btDat, btI64, btU64, btAny),
  {btDat}(btErr, btDat, btNul, btDat, btDat, btDat, btDat, btDat, btDat, btDat, btDat, btAny),
  {btI64}(btErr, btI64, btNul, btI64, btFlt, btCur, btFlt, btI64, btDat, btI64, btU64, btAny),
  {btU64}(btErr, btU64, btNul, btU64, btFlt, btCur, btFlt, btU64, btDat, btU64, btU64, btAny),
  {btAny}(btErr, btAny, btAny, btAny, btAny, btAny, btAny, btAny, btAny, btAny, btAny, btAny));

begin
  LeftBase := BaseTypeMap[CheckType(Left.VType)];
  RightBase := BaseTypeMap[CheckType(Right.VType)];
  case OpTypeMap[LeftBase, RightBase] of
    btErr:
      VarInvalidOp;

    btNul:
      NullOp(Left, Right, OpCode);

    btEmp:
      EmptyOp(Left, Right, OpCode);

    btInt:
      if OpCode = opDivide then
        RealOp(Left, Right, OpCode)
      else
        IntOp(Left, Right, OpCode);

    btFlt:
      if OpCode >= opIntDivide then
        IntOp(Left, Right, OpCode)
      else
        RealOp(Left, Right, OpCode);

    btCur:
      CurrOp(Left, Right, OpCode, LeftBase, RightBase);

    btStr:
      if OpCode = opAdd then
        VarStrCat(Variant(Left), Variant(Right))
      else
        if OpCode >= opIntDivide then
          IntOp(Left, Right, OpCode)
        else
          RealOp(Left, Right, OpCode);

    btBol:
      if OpCode < opAnd then
        if OpCode >= opIntDivide then
          IntOp(Left, Right, OpCode)
        else
          RealOp(Left, Right, OpCode)
      else
      begin
        case OpCode of
          opAnd:  Variant(Left) := _VarToBoolean(Left) and _VarToBoolean(Right);
          opOr :  Variant(Left) := _VarToBoolean(Left) or _VarToBoolean(Right);
          opXor:  Variant(Left) := _VarToBoolean(Left) xor _VarToBoolean(Right);
        end;
      end;

    btDat:
      case OpCode of
        opAdd:
          DateOp(Left, Right, OpCode);
        opSubtract:
          begin
            DateOp(Left, Right, OpCode);
            if (LeftBase = btDat) and (RightBase = btDat) then
              Left.VType := varDouble;
          end;
        opMultiply,
        opDivide:
          RealOp(Left, Right, OpCode);
      else
        IntOp(Left, Right, OpCode);
      end;

    btI64:
      if OpCode = opDivide then
        RealOp(Left, Right, OpCode)
      else
        Int64Op(Left, Right, OpCode);

    btU64:
      if OpCode = opDivide then
        RealOp(Left, Right, OpCode)
      else
        UInt64Op(Left, Right, OpCode);

    btAny:
      AnyOp(Left, Right, OpCode);
  else
    VarInvalidOp;
  end;
end;

procedure _VarOp(var Left: TVarData; const Right: TVarData; const OpCode: TVarOp);
var
  LLeftType, LRightType: TVarType;
begin
  LLeftType := Left.VType;
  LRightType := Right.VType;

  // simple and simple (optimized test to make sure both types are not custom)
  if (LLeftType < CFirstUserType) and (LRightType < CFirstUserType) then
    SimpleVarOp(Left, Right, OpCode)

  // fix up left if needed
  else if LLeftType = varByRef or varVariant then
  begin
    _VarCopyNoInd(Left, Left);
    _VarOp(Left, Right, OpCode);
  end

  // fix up right if needed
  else if LRightType = varByRef or varVariant then
    _VarOp(Left, PVarData(Right.VPointer)^, OpCode)

  // check for other forms of byref then
  else if ((LLeftType and varTypeMask) < CFirstUserType) and
          ((LRightType and varTypeMask) < CFirstUserType) then
    SimpleVarOp(Left, Right, OpCode)

  // something rare then
  else
    VarOpRare(Left, Right, OpCode);
end;


function VarCompare(const Left, Right: TVarData; const OpCode: TVarOp): TVarCompareResult; forward;

function VarCompareAny(const Left, Right: TVarData; const OpCode: TVarOp): TVarCompareResult;
var
  LLeft, LRight: TVarData;
begin
  VariantInit(LLeft);
  try

    // resolve the left side into a normal simple type
    _VarCopy(LLeft, Left);
    if Left.VType = varAny then
      ChangeAnyProc(LLeft);

    // does the right side need to be reduced to a simple type
    if Right.VType = varAny then
    begin
      VariantInit(LRight);
      try
        _VarCopy(LRight, Right);
        ChangeAnyProc(LRight);
        Result := VarCompare(LLeft, LRight, OpCode);
      finally
        _VarClear(LRight);
      end;
    end

    // right side is fine as is
    else
      Result := VarCompare(LLeft, Right, OpCode);
  finally
    _VarClear(LLeft);
  end;
end;

const
  CBooleanToRelationship: array [opCmpEQ..opCmpGE, Boolean] of TVarCompareResult =
   // False          True
    ((crLessThan,    crEqual),        // opCmpEQ = 14;
     (crEqual,       crLessThan),     // opCmpNE = 15;
     (crEqual,       crLessThan),     // opCmpLT = 16;
     (crGreaterThan, crLessThan),     // opCmpLE = 17;
     (crEqual,       crGreaterThan),  // opCmpGT = 18;
     (crLessThan,    crGreaterThan)); // opCmpGE = 19;

function EmptyCompare(L, R: TBaseType): TVarCompareResult;
begin
  if L = btEmp then
    if R = btEmp then
      Result := crEqual
    else
      Result := crLessThan
  else
    Result := crGreaterThan;
end;

function NullCompare(L, R: TBaseType; OpCode: TVarOp): TVarCompareResult;
begin
  Result := crEqual; // suppress the warning
  case OpCode of
    opCmpEQ:
      case NullEqualityRule of
        ncrError:  VarInvalidNullOp;
        ncrStrict: Result := CBooleanToRelationship[opCmpEQ, False];
        ncrLoose:  Result := CBooleanToRelationship[opCmpEQ, (L = btNul) and (R = btNul)];
      end;
    opCmpNE:
      case NullEqualityRule of
        ncrError:  VarInvalidNullOp;
        ncrStrict: Result := CBooleanToRelationship[opCmpNE, False];
        ncrLoose:  Result := CBooleanToRelationship[opCmpNE, (L <> btNul) or (R <> btNul)];
      end;
    opCmpLT, opCmpLE, opCmpGT, opCmpGE:
      case NullMagnitudeRule of
        ncrError:  VarInvalidNullOp;
        ncrStrict: Result := CBooleanToRelationship[OpCode, False];
        ncrLoose:  if L = btNul then
                     if R = btNul then
                       Result := crEqual
                     else
                       Result := crLessThan
                   else
                     Result := crGreaterThan;
      end;
  else
    VarInvalidOp;
  end;
end;

function IntCompare(A, B: Integer): TVarCompareResult;
begin
  if A < B then
    Result := crLessThan
  else if A > B then
    Result := crGreaterThan
  else
    Result := crEqual;
end;

function Int64Compare(const A, B: Int64): TVarCompareResult;
begin
  if A < B then
    Result := crLessThan
  else if A > B then
    Result := crGreaterThan
  else
    Result := crEqual;
end;

function UInt64Compare(const A, B: UInt64): TVarCompareResult;
begin
  if A < B then
    Result := crLessThan
  else if A > B then
    Result := crGreaterThan
  else
    Result := crEqual;
end;

function RealCompare(const A, B: Double): TVarCompareResult;
begin
  if A < B then
    Result := crLessThan
  else if A > B then
    Result := crGreaterThan
  else
    Result := crEqual;
end;

function DateCompare(const A, B: TDateTime): TVarCompareResult;
begin
  if A < B then
    Result := crLessThan
  else if A > B then
    Result := crGreaterThan
  else
    Result := crEqual;
end;

function CurrCompare(const A, B: Currency): TVarCompareResult;
begin
  if A < B then
    Result := crLessThan
  else if A > B then
    Result := crGreaterThan
  else
    Result := crEqual;
end;

// keep string temps out of the main proc
function StringCompare(const L, R: TVarData): TVarCompareResult;
var
  A, B: UnicodeString;
begin
  _VarToUStr(A, L);
  _VarToUStr(B, R);
  Result := IntCompare(CompareStr(A, B), 0);
end;

function VarCompareSimple(const Left, Right: TVarData; const OpCode: TVarOp): TVarCompareResult;
const
  CmpTypeMap: array[TBaseType, TBaseType] of TBaseType = (
         {btErr, btEmp, btNul, btInt, btFlt, btCur, btStr, btBol, btDat, btI64, btU64, btAny}
  {btErr}(btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr, btErr),
  {btEmp}(btErr, btEmp, btNul, btInt, btFlt, btCur, btStr, btBol, btDat, btI64, btU64, btAny),
  {btNul}(btErr, btNul, btNul, btNul, btNul, btNul, btNul, btNul, btNul, btNul, btNul, btAny),
  {btInt}(btErr, btInt, btNul, btInt, btFlt, btCur, btFlt, btInt, btDat, btI64, btU64, btAny),
  {btFlt}(btErr, btFlt, btNul, btFlt, btFlt, btCur, btFlt, btFlt, btDat, btFlt, btFlt, btAny),
  {btCur}(btErr, btCur, btNul, btCur, btCur, btCur, btCur, btCur, btDat, btCur, btCur, btAny),
  {btStr}(btErr, btStr, btNul, btFlt, btFlt, btCur, btStr, btBol, btDat, btFlt, btFlt, btAny),
  {btBol}(btErr, btBol, btNul, btInt, btFlt, btCur, btBol, btBol, btDat, btI64, btU64, btAny),
  {btDat}(btErr, btDat, btNul, btDat, btDat, btDat, btDat, btDat, btDat, btDat, btDat, btAny),
  {btI64}(btErr, btI64, btNul, btI64, btFlt, btCur, btFlt, btI64, btDat, btI64, btU64, btAny),
  {btU64}(btErr, btU64, btNul, btU64, btFlt, btCur, btFlt, btU64, btDat, btU64, btU64, btAny),
  {btAny}(btErr, btAny, btAny, btAny, btAny, btAny, btAny, btAny, btAny, btAny, btAny, btAny));

var
  L, R: TBaseType;
begin
  L := BaseTypeMap[CheckType(Left.VType)];
  R := BaseTypeMap[CheckType(Right.VType)];
  case CmpTypeMap[L, R] of
    btErr:
      begin
        VarInvalidOp;
        Result := crEqual;
      end;
    btEmp:  Result := EmptyCompare(L, R);
    btNul:  Result := NullCompare(L, R, OpCode);
    btInt:  Result := IntCompare(_VarToInteger(Left), _VarToInteger(Right));
    btI64:  Result := Int64Compare(_VarToInt64(Left), _VarToInt64(Right));
    btU64:  Result := UInt64Compare(_VarToUInt64(Left), _VarToUInt64(Right));
    btFlt:  Result := RealCompare(_VarToDouble(Left), _VarToDouble(Right));
    btDat:  Result := DateCompare(_VarToDate(Left), _VarToDate(Right));
    btCur:  Result := CurrCompare(_VarToCurrency(Left), _VarToCurrency(Right));
    btStr:  Result := StringCompare(Left, Right);
    btBol:  Result := IntCompare(Integer(_VarToBoolean(Left)), Integer(_VarToBoolean(Right)));
    btAny:  Result := VarCompareAny(Left, Right, OpCode);
  else
    VarInvalidOp;
    Result := crEqual;
  end;
end;

function VarCompareRare(const Left, Right: TVarData; const OpCode: TVarOp): TVarCompareResult;
var
  LNewLeftType, LNewRightType: TVarType;
  LLeftHandler, LRightHandler: TCustomVariantType;
  LTemp: TVarData;
begin
  // assume the best
  Result := crEqual;

  // simple and something else
  if Left.VType and varTypeMask < CFirstUserType then
  begin
    // empty and custom, right side's type doesn't matter in this case
    if Left.VType = varEmpty then
      Result := EmptyCompare(btEmp, btErr)

    // null and custom, right side's type doesn't matter in this case
    else if Left.VType = varNull then
      Result := NullCompare(btNul, btErr, OpCode)

    // [simple and custom] but the custom doesn't really exist (nasty but possible )
    else if not FindCustomVariantType(Right.VType, LRightHandler) then
      VarInvalidOp

    // does the custom want to take over?
    else if LRightHandler.LeftPromotion(Left, opCompare, LNewLeftType) then
    begin

      // convert the simple side
      if Left.VType <> LNewLeftType then
      begin
        VariantInit(LTemp);
        try
          _VarCast(LTemp, Left, LNewLeftType);
          if (LTemp.VType and varTypeMask) <> LNewLeftType then
            VarCastError;
          Result := CBooleanToRelationship[OpCode, LRightHandler.CompareOp(LTemp, Right, OpCode)];
        finally
          _VarClear(LTemp);
        end;
      end

      // already that type!
      else
        Result := CBooleanToRelationship[OpCode, LRightHandler.CompareOp(Left, Right, OpCode)];
    end

    // convert custom side to simple's type
    else
    begin
      VariantInit(LTemp);
      try
        _VarCast(LTemp, Right, Left.VType);
        if (LTemp.VType and varTypeMask) <> Left.VType then
          VarCastError;
        Result := VarCompareSimple(Left, LTemp, OpCode)
      finally
        _VarClear(LTemp);
      end;
    end;
  end

  // custom and something else
  else
  begin

    // custom and empty, left side's type doesn't matter in this case
    if Right.VType = varEmpty then
      Result := EmptyCompare(btErr, btEmp)

    // custom and null, left side's type doesn't matter in this case
    else if Right.VType = varNull then
      Result := NullCompare(btErr, btNul, OpCode)

    // find the custom left side
    else if not FindCustomVariantType(Left.VType, LLeftHandler) then
      VarInvalidOp

    // does the left side like what is in the right side?
    else if LLeftHandler.RightPromotion(Right, opCompare, LNewRightType) then
    begin

      // make the right side right
      if Right.VType <> LNewRightType then
      begin
        VariantInit(LTemp);
        try
          _VarCast(LTemp, Right, LNewRightType);
          if LTemp.VType <> LNewRightType then
            VarCastError;
          Result := CBooleanToRelationship[OpCode, LLeftHandler.CompareOp(Left, LTemp, OpCode)];
        finally
          _VarClear(LTemp);
        end;
      end

      // already that type
      else
        Result := CBooleanToRelationship[OpCode, LLeftHandler.CompareOp(Left, Right, OpCode)];
    end

    // [custom and simple]
    else if Right.VType and varTypeMask < CFirstUserType then
    begin
      VariantInit(LTemp);
      try
        // convert the left side to the right side's type
        _VarCast(LTemp, Left, Right.VType);
        if LTemp.VType <> Right.VType then
          VarCastError;
        Result := VarCompareSimple(LTemp, Right, OpCode)
      finally
        _VarClear(LTemp);
      end;
    end

    // [custom and custom] but the right one doesn't really exist (nasty but possible )
    else if not FindCustomVariantType(Right.VType, LRightHandler) then
      VarInvalidOp

    // [custom and custom] and the right one can handle the left's type
    else if LRightHandler.LeftPromotion(Left, opCompare, LNewLeftType) then
    begin

      // convert the left side
      if Left.VType <> LNewLeftType then
      begin
        VariantInit(LTemp);
        try
          _VarCast(LTemp, Left, LNewLeftType);
          if LTemp.VType <> LNewLeftType then
            VarCastError;
          Result := CBooleanToRelationship[OpCode, LRightHandler.CompareOp(LTemp, Right, OpCode)];
        finally
          _VarClear(LTemp);
        end;
      end

      // it's already correct!
      else
        Result := CBooleanToRelationship[OpCode, LRightHandler.CompareOp(Left, Right, OpCode)];
    end

    // [custom and custom] but neither type can deal with each other
    else
      VarInvalidOp;
  end;
end;

function VarCompare(const Left, Right: TVarData; const OpCode: TVarOp): TVarCompareResult;
var
  LLeftType, LRightType: TVarType;
begin
  LLeftType := Left.VType;
  LRightType := Right.VType;

  // simples are handled by simple
  if (LLeftType < CFirstUserType) and (LRightType < CFirstUserType) then
    Result := VarCompareSimple(Left, Right, OpCode)

  // by refs need to recurse to remove the byrefs
  else if LLeftType = varByRef or varVariant then
    Result := VarCompare(PVarData(Left.VPointer)^, Right, OpCode)
  else if LRightType = varByRef or varVariant then
    Result := VarCompare(Left, PVarData(Right.VPointer)^, OpCode)

  // check for other forms of byref then
  else if ((LLeftType and varTypeMask) < CFirstUserType) and
          ((LRightType and varTypeMask) < CFirstUserType) then
    Result := VarCompareSimple(Left, Right, OpCode)

  // others are not
  else
    Result := VarCompareRare(Left, Right, OpCode);
end;

// *****************************************************************************
// NEGATE
// *****************************************************************************

procedure NegateAsDouble(var Dest: TVarData);
begin
  Variant(Dest) := -_VarToDouble(Dest);
end;

procedure NegateViaOS(var Dest: TVarData);
begin
  VarResultCheck(VarNeg(Dest, Dest));
end;

procedure NegateVariant(Source: PVarData; var Dest: TVarData);
begin
  Variant(Dest) := -PVariant(Source)^;
end;

procedure NegateByte(const Value: Byte; var Dest: TVarData);
begin
  Dest.VSmallInt := -Value;
  Dest.VType := varSmallInt;
end;

procedure NegateWord(const Value: Word; var Dest: TVarData);
begin
  Dest.VInteger := -Value;
  Dest.VType := varInteger;
end;

procedure NegateLongWord(const Value: LongWord; var Dest: TVarData);
begin
  if Value and $80000000 <> 0 then
  begin
    Dest.VInt64 := -Value;
    Dest.VType := varInt64;
  end
  else
  begin
    Dest.VInteger := -Integer(Value);
    Dest.VType := varInteger;
  end;
end;

procedure NegateUInt64(const Value: UInt64; var Dest: TVarData);
begin
  Dest.VInt64 := -Int64(Value);
  Dest.VType := varInt64;
end;

procedure NegateAny(var Dest: TVarData);
begin
  ChangeAnyProc(Dest);
  _VarNeg(Dest);
end;

function NegateCustom(var Dest: TVarData): Boolean;
var
  LHandler: TCustomVariantType;
begin
  Result := FindCustomVariantType(Dest.VType, LHandler);
  if Result then
    LHandler.UnaryOp(Dest, opNegate);
end;

procedure _VarNeg(var Dest: TVarData);
const
  CTruth: array [False..True] of Byte = (0, 1);
begin
  case Dest.VType of
    varEmpty:    NegateByte(0, Dest);
    varNull:;    // Negation while allowed on nulls effectively means nothing
    varSmallint: Dest.VSmallInt := -Dest.VSmallInt;
    varInteger:  Dest.VInteger := -Dest.VInteger;
    varSingle:   Dest.VSingle := -Dest.VSingle;
    varDouble:   Dest.VDouble := -Dest.VDouble;
    varCurrency: Dest.VCurrency := -Dest.VCurrency;
    varDate:     Dest.VDate := -Dest.VDate;
    varOleStr:   NegateAsDouble(Dest);
    varBoolean:  NegateByte(CTruth[Dest.VBoolean = True], Dest);
    varShortInt: Dest.VShortInt := -Dest.VShortInt;
    varByte:     NegateByte(Dest.VByte, Dest);
    varWord:     NegateWord(Dest.VWord, Dest);
    varLongWord: NegateLongWord(Dest.VLongWord, Dest);
    varInt64:    Dest.VInt64 := -Dest.VInt64;
    varUInt64:   NegateUInt64(Dest.VUInt64, Dest);

    varVariant:  NegateVariant(PVarData(Dest.VPointer), Dest);

    varDispatch,
    varUnknown:  NegateViaOS(Dest);
  else
    case Dest.VType of
      varString: NegateAsDouble(Dest);
      varUString: NegateAsDouble(Dest);
      varAny:    NegateAny(Dest);
    else
      if (Dest.VType and varByRef) <> 0 then
        case Dest.VType and not varByRef of
          varSmallint: Variant(Dest) := -PSmallint(Dest.VPointer)^;
          varInteger:  Variant(Dest) := -PInteger(Dest.VPointer)^;
          varSingle:   Variant(Dest) := -PSingle(Dest.VPointer)^;
          varDouble:   Variant(Dest) := -PDouble(Dest.VPointer)^;
          varCurrency: Variant(Dest) := -PCurrency(Dest.VPointer)^;
          varDate:     Variant(Dest) := -PDate(Dest.VPointer)^;
          varOleStr:   NegateAsDouble(Dest);
          varBoolean:  NegateByte(CTruth[PWordBool(Dest.VPointer)^ = True], Dest);
          varShortInt: Variant(Dest) := -PShortInt(Dest.VPointer)^;
          varByte:     NegateByte(PByte(Dest.VPointer)^, Dest);
          varWord:     NegateWord(PWord(Dest.VPointer)^, Dest);
          varLongWord: NegateLongWord(PLongWord(Dest.VPointer)^, Dest);
          varInt64:    Variant(Dest) := -PInt64(Dest.VPointer)^;
          varUInt64:   NegateUInt64(PUInt64(Dest.VPointer)^, Dest);

          varVariant:  NegateVariant(PVarData(Dest.VPointer), Dest);
        else
          NegateViaOS(Dest);
        end
      else
        if not NegateCustom(Dest) then
          NegateViaOS(Dest);
    end;
  end;
end;

// *****************************************************************************
// NOT
// *****************************************************************************

procedure NotAsString(var Dest: TVarData);
var
  S: WideString;
  LResult: HResult;
  LInteger: Integer;
begin
  _VarToWStr(S, Dest);
  LResult := VarI4FromStr(PWideChar(S), VAR_LOCALE_USER_DEFAULT, 0, LInteger);
  case LResult of
    VAR_OK:
      Variant(Dest) := not LInteger;
    VAR_TYPEMISMATCH:
      if TryStrToInt(S, LInteger) then
        Variant(Dest) := not LInteger
      else
        Variant(Dest) := not _VarToBoolean(Dest);
  else
    VarResultCheck(LResult, Dest.VType, varInteger);
  end;
end;

procedure NotAsOrdinal(var Dest: TVarData);
var
  LVal64: Int64;
begin
  LVal64 := _VarToInt64(Dest);

  // is it in the integer range?
  if (LVal64 <= High(Integer)) and (LVal64 >= Low(Integer)) then
    Variant(Dest) := not Integer(LVal64)
  else
    Variant(Dest) := not LVal64;
end;

procedure NotViaOS(var Dest: TVarData);
begin
  VarResultCheck(VarNot(Dest, Dest));
end;

procedure NotVariant(Source: PVarData; var Dest: TVarData);
begin
  Variant(Dest) := not PVariant(Source)^;
end;

procedure NotAny(var Dest: TVarData);
begin
  ChangeAnyProc(Dest);
  _VarNot(Dest);
end;

function NotCustom(var Dest: TVarData): Boolean;
var
  LHandler: TCustomVariantType;
begin
  Result := FindCustomVariantType(Dest.VType, LHandler);
  if Result then
    LHandler.UnaryOp(Dest, opNot);
end;

procedure _VarNot(var Dest: TVarData);
begin
  case Dest.VType of
    varEmpty:    Variant(Dest) := -1;
    varNull:;    // Not while allowed on nulls effectively means nothing
    varSmallint: Dest.VSmallInt := not Dest.VSmallInt;
    varInteger:  Dest.VInteger := not Dest.VInteger;
    varSingle,
    varDouble,
    varCurrency,
    varDate:     NotAsOrdinal(Dest);
    varOleStr:   NotAsString(Dest);
    varBoolean:  Dest.VBoolean := not Dest.VBoolean;
    varShortInt: Dest.VShortInt := not Dest.VShortInt;
    varByte:     Dest.VByte := not Dest.VByte;
    varWord:     Dest.VWord := not Dest.VWord;
    varLongWord: Dest.VLongWord := not Dest.VLongWord;
    varInt64:    Dest.VInt64 := not Dest.VInt64;
    varUInt64:   Dest.VUInt64 := not Dest.VUInt64;

    varVariant:  NotVariant(PVarData(Dest.VPointer), Dest);

    varDispatch,
    varUnknown:  NotViaOS(Dest);
  else
    case Dest.VType of
      varString: NotAsString(Dest);
      varUString: NotAsString(Dest);
      varAny:    NotAny(Dest);
    else
      if (Dest.VType and varByRef) <> 0 then
        case Dest.VType and not varByRef of
          varSmallInt: Variant(Dest) := not PSmallInt(Dest.VPointer)^;
          varInteger:  Variant(Dest) := not PInteger(Dest.VPointer)^;
          varSingle,
          varDouble,
          varCurrency,
          varDate:     NotAsOrdinal(Dest);
          varOleStr:   NotAsString(Dest);
          varBoolean:  Variant(Dest) := not PWordBool(Dest.VPointer)^;
          varShortInt: Variant(Dest) := not PShortInt(Dest.VPointer)^;
          varByte:     Variant(Dest) := not PByte(Dest.VPointer)^;
          varWord:     Variant(Dest) := not PWord(Dest.VPointer)^;
          varLongWord: Variant(Dest) := not PLongWord(Dest.VPointer)^;
          varInt64:    Variant(Dest) := not PInt64(Dest.VPointer)^;
          varUInt64:   Variant(Dest) := not PUInt64(Dest.VPointer)^;

          varVariant:  NotVariant(PVarData(Dest.VPointer), Dest);
        else
          NotViaOS(Dest);
        end
      else
        if not NotCustom(Dest) then
          NotViaOS(Dest);
    end;
  end;
end;

procedure _VarAddRef(var V: TVarData);
{$IFNDEF X86ASM}
var
  Temp: TVarData;
begin
  if V.VType >= varOleStr then
  begin
    Temp := V;
    V.VType := varEmpty;
    _VarCopy(V, Temp);
  end;
end;
{$ELSE X86ASM}
asm
        CMP     [EAX].TVarData.VType,varOleStr
        JB      @@1
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        PUSH    [EAX].Integer[12]
        PUSH    [EAX].Integer[8]
        PUSH    [EAX].Integer[4]
        PUSH    [EAX].Integer[0]
        MOV     [EAX].TVarData.VType,varEmpty
        MOV     EDX,ESP
        CALL    _VarCopy
        ADD     ESP,16
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
@@1:
end;
{$ENDIF X86ASM}

function VarTypeAsText(const AType: TVarType): string;
const
  CText: array [varEmpty..varUInt64] of string = ('Empty', 'Null', 'Smallint', //Do not localize
    'Integer', 'Single', 'Double', 'Currency', 'Date', 'OleStr', 'Dispatch', //Do not localize
    'Error', 'Boolean', 'Variant', 'Unknown', 'Decimal', '$0F', 'ShortInt', //Do not localize
    'Byte', 'Word', 'LongWord', 'Int64', 'UInt64'); //Do not localize
var
  LHandler: TCustomVariantType;
begin
  if AType and varTypeMask <= varUInt64 then
    Result := CText[AType and varTypeMask]
  else if AType = varString then
    Result := 'String' //Do not localize
  else if AType = varUString then
    Result := 'UnicodeString' //Do not localize
  else if AType = varAny then
    Result := 'Any' //Do not localize
  else if FindCustomVariantType(AType, LHandler) then
    Result := Copy(LHandler.ClassName, 2, High(Integer))
  else
    Result := HexDisplayPrefix + IntToHex(AType and varTypeMask, 4);

  if AType and varArray <> 0 then
    Result := 'Array ' + Result; //Do not localize
  if AType and varByRef <> 0 then
    Result := 'ByRef ' + Result; //Do not localize
end;

function VarType(const V: Variant): TVarType;
begin
  Result := TVarData(V).VType;
end;

function FindVarData(const V: Variant): PVarData;
begin
  Result := @TVarData(V);
  while Result.VType = varByRef or varVariant do
    Result := PVarData(Result.VPointer);
end;

function VarAsType(const V: Variant; AVarType: TVarType): Variant;
begin
  _VarCast(TVarData(Result), TVarData(V), AVarType);
end;

function VarIsType(const V: Variant; AVarType: TVarType): Boolean;
begin
  Result := FindVarData(V)^.VType = AVarType;
end;

function VarIsType(const V: Variant; const AVarTypes: array of TVarType): Boolean;
var
  I: Integer;
begin
  Result := False;
  with FindVarData(V)^ do
    for I := Low(AVarTypes) to High(AVarTypes) do
      if VType = AVarTypes[I] then
      begin
        Result := True;
        Break;
      end;
end;

function VarIsClear(const V: Variant): Boolean;
var
  LHandler: TCustomVariantType;
  LVarData: TVarData;
begin
  LVarData := FindVarData(V)^;
  with LVarData do
    if VType < CFirstUserType then
      Result := (VType = varEmpty) or
                (((VType = varDispatch) or (VType = varUnknown)) and
                  (VDispatch = nil))
    else if FindCustomVariantType(VType, LHandler) then
      Result := LHandler.IsClear(LVarData)
    else
      Result := False;
end;

function VarTypeIsCustom(const AVarType: TVarType): Boolean;
var
  LHandler: TCustomVariantType;
begin
  Result := FindCustomVariantType(AVarType, LHandler);
end;

function VarIsCustom(const V: Variant): Boolean;
begin
  Result := VarTypeIsCustom(FindVarData(V)^.VType);
end;

function VarTypeIsOrdinal(const AVarType: TVarType): Boolean;
begin
  Result := AVarType in [varSmallInt, varInteger, varBoolean, varShortInt,
                         varByte, varWord, varLongWord, varInt64, varUInt64];
end;

function VarIsOrdinal(const V: Variant): Boolean;
begin
  Result := VarTypeIsOrdinal(FindVarData(V)^.VType);
end;

function VarTypeIsFloat(const AVarType: TVarType): Boolean;
begin
  Result := AVarType in [varSingle, varDouble, varCurrency];
end;

function VarIsFloat(const V: Variant): Boolean;
begin
  Result := VarTypeIsFloat(FindVarData(V)^.VType);
end;

function VarTypeIsNumeric(const AVarType: TVarType): Boolean;
begin
  Result := VarTypeIsOrdinal(AVarType) or VarTypeIsFloat(AVarType);
end;

function VarIsNumeric(const V: Variant): Boolean;
begin
  Result := VarTypeIsNumeric(FindVarData(V)^.VType);
end;

function VarTypeIsStr(const AVarType: TVarType): Boolean;
begin
  Result := (AVarType = varOleStr) or (AVarType = varString) or (AVarType = varUString);
end;

function VarIsStr(const V: Variant): Boolean;
begin
  Result := VarTypeIsStr(FindVarData(V)^.VType);
end;

function VarIsEmpty(const V: Variant): Boolean;
begin
  Result := FindVarData(V)^.VType = varEmpty;
end;

procedure VarCheckEmpty(const V: Variant);
begin
  if VarIsEmpty(V) then
    raise EVariantError.Create(SVarIsEmpty);
end;

function VarIsNull(const V: Variant): Boolean;
begin
  Result := FindVarData(V)^.VType = varNull;
end;

function VarToStr(const V: Variant): string;
begin
  Result := VarToStrDef(V, NullAsStringValue);
end;

function VarToStrDef(const V: Variant; const ADefault: string): string;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := ADefault;
end;

{$IFNDEF NEXTGEN}
function VarToWideStr(const V: Variant): WideString;
begin
  Result := VarToWideStrDef(V, NullAsStringValue);
end;

function VarToWideStrDef(const V: Variant; const ADefault: WideString): WideString;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := ADefault;
end;
{$ENDIF !NEXTGEN}

function VarFromDateTime(const DateTime: TDateTime): Variant;
begin
  _VarClear(TVarData(Result));
  TVarData(Result).VType := varDate;
  TVarData(Result).VDate := DateTime;
end;

function VarToDateTime(const V: Variant): TDateTime;
begin
  Result := _VarToDate(TVarData(V));
end;

function VarInRange(const AValue, AMin, AMax: Variant): Boolean;
begin
  Result := (AValue >= AMin) and (AValue <= AMax);
end;

function VarEnsureRange(const AValue, AMin, AMax: Variant): Variant;
begin
  Result := AValue;
  if Result < AMin then
    Result := AMin;
  if Result > AMax then
    Result := AMax;
end;

function VarSameValue(const A, B: Variant): Boolean;
var
  LA, LB: TVarData;
begin
  LA := FindVarData(A)^;
  LB := FindVarData(B)^;
  if LA.VType = varEmpty then
    Result := LB.VType = varEmpty
  else if LA.VType = varNull then
    Result := LB.VType = varNull
  else if LB.VType in [varEmpty, varNull] then
    Result := False
  else
    Result := A = B;
end;

function VarCompareValue(const A, B: Variant): TVariantRelationship;
const
  CTruth: array [Boolean] of TVariantRelationship = (vrNotEqual, vrEqual);
var
  LA, LB: TVarData;
begin
  LA := FindVarData(A)^;
  LB := FindVarData(B)^;
  if LA.VType = varEmpty then
    Result := CTruth[LB.VType = varEmpty]
  else if LA.VType = varNull then
    Result := CTruth[LB.VType = varNull]
  else if LB.VType in [varEmpty, varNull] then
    Result := vrNotEqual
  else if A = B then
    Result := vrEqual
  else if A < B then
    Result := vrLessThan
  else
    Result := vrGreaterThan;
end;

procedure SetVarAsError(var V: TVarData; AResult: HRESULT);
begin
  _VarClear(V);
  V.VType := varError;
  V.VError := AResult;
end;

function VarIsEmptyParam(const V: Variant): Boolean;
var
  LResult: HRESULT;
begin
  Result := VarIsError(V, LResult) and
            (LResult = VAR_PARAMNOTFOUND);
end;

procedure SetClearVarToEmptyParam(var V: TVarData);
begin
  SetVarAsError(V, VAR_PARAMNOTFOUND);
end;

function VarIsError(const V: Variant; out AResult: HRESULT): Boolean;
var
  LVarData: PVarData;
begin
  LVarData := FindVarData(V);
  Result := Assigned(LVarData) and (LVarData^.VType = varError);
  if Result then
    AResult := LVarData^.VError;
end;

function VarIsError(const V: Variant): Boolean;
var
  LResult: HRESULT;
begin
  Result := VarIsError(V, LResult);
end;

function VarAsError(AResult: HRESULT): Variant;
begin
  SetVarAsError(TVarData(Result), AResult);
end;

function VarIsByRef(const V: Variant): Boolean;
begin
  Result := (TVarData(V).VType and varByRef) <> 0;
end;

function VarSupports(const V: Variant; const IID: TGUID; out Intf): Boolean;
var
  LInstance: IVarInstanceReference;
begin
  Result := (Supports(V, IVarInstanceReference, LInstance) and
             Supports(LInstance.GetInstance(TVarData(V)), IID, Intf)) or
            Supports(V, IID, Intf);
end;

function VarSupports(const V: Variant; const IID: TGUID): Boolean;
var
  LInstance: IVarInstanceReference;
  LInterface: IInterface;
begin
  Result := (Supports(V, IVarInstanceReference, LInstance) and
             Supports(LInstance.GetInstance(TVarData(V)), IID, LInterface)) or
            Supports(V, IID, LInterface);
end;


{ ----------------------------------------------------- }
{       Variant array support                           }
{ ----------------------------------------------------- }

function GetVarDataArrayInfo(const AVarData: TVarData; out AVarType: TVarType;
  out AVarArray: PVarArray): Boolean;
begin
  // variant that points to another variant?  lets go spelunking
  if AVarData.VType = varByRef or varVariant then
    Result := GetVarDataArrayInfo(PVarData(AVarData.VPointer)^, AVarType, AVarArray)
  else
  begin

    // make sure we are pointing to an array then
    AVarType := AVarData.VType;
    Result := (AVarType and varArray) <> 0;

    // figure out the array data pointer
    if Result then
      if (AVarType and varByRef) <> 0 then
        AVarArray := PVarArray(AVarData.VPointer^)
      else
        AVarArray := AVarData.VArray
    else
      AVarArray := nil;
  end;
end;

const
  tkDynArray  = 17;

function VarArrayCreate(const Bounds: array of Integer;
  AVarType: TVarType): Variant;
var
  I, LDimCount: Integer;
  LVarArrayRef: PVarArray;
  LVarBounds: array[0..63] of TVarArrayBound;
begin
  if (not Odd(High(Bounds)) or (High(Bounds) > 127)) or
     (not VarTypeIsValidArrayType(AVarType)) then
    VarArrayCreateError;

  LDimCount := (High(Bounds) + 1) div 2;
  for I := 0 to LDimCount - 1 do
    with LVarBounds[I] do
    begin
      LowBound := Bounds[I * 2];
      ElementCount := Bounds[I * 2 + 1] - LowBound + 1;
    end;

  LVarArrayRef := SafeArrayCreate(AVarType, LDimCount, PVarArrayBoundArray(@LVarBounds));
  if LVarArrayRef = nil then
    VarArrayCreateError;

  _VarClear(TVarData(Result));

  TVarData(Result).VType := AVarType or varArray;
  TVarData(Result).VArray := LVarArrayRef;
end;

function VarArrayOf(const Values: array of Variant): Variant;
var
  I: Integer;
begin
  Result := VarArrayCreate([0, High(Values)], varVariant);
  for I := 0 to High(Values) do
    Result[I] := Values[I];
end;

procedure _VarArrayRedim(var A: TVarData; HighBound: Integer);
var
  VarBound: TVarArrayBound;
  LVarType: TVarType;
  LVarArray: PVarArray;
begin
  if not GetVarDataArrayInfo(A, LVarType, LVarArray) then
    VarResultCheck(VAR_INVALIDARG);

{$RANGECHECKS OFF}
    VarBound.LowBound := LVarArray.Bounds[0].LowBound;
{$IFNDEF RANGECHECKINGOFF}
  {$RANGECHECKS ON}
{$ENDIF}

  VarBound.ElementCount := HighBound - VarBound.LowBound + 1;

  if SafeArrayRedim(LVarArray, @VarBound) <> VAR_OK then
    VarArrayCreateError;
end;

function VarArrayAsPSafeArray(const A: Variant): PVarArray;
var
  LVarType: TVarType;
begin
  if not GetVarDataArrayInfo(TVarData(A), LVarType, Result) then
    VarResultCheck(VAR_INVALIDARG);
end;

function VarArrayDimCount(const A: Variant): Integer;
var
  LVarType: TVarType;
  LVarArray: PVarArray;
begin
  if GetVarDataArrayInfo(TVarData(A), LVarType, LVarArray) then
    Result := LVarArray^.DimCount
  else
    Result := 0;
end;

function VarArrayLowBound(const A: Variant; Dim: Integer): Integer;
begin
  VarResultCheck(SafeArrayGetLBound(VarArrayAsPSafeArray(A), Dim, Result));
end;

function VarArrayHighBound(const A: Variant; Dim: Integer): Integer;
begin
  VarResultCheck(SafeArrayGetUBound(VarArrayAsPSafeArray(A), Dim, Result));
end;

function VarArrayLock(const A: Variant): Pointer;
begin
  VarResultCheck(SafeArrayAccessData(VarArrayAsPSafeArray(A), Result));
end;

procedure VarArrayUnlock(const A: Variant);
begin
  VarResultCheck(SafeArrayUnaccessData(VarArrayAsPSafeArray(A)));
end;

function VarArrayRef(const A: Variant): Variant;
begin
  if (TVarData(A).VType and varArray) = 0 then
    VarResultCheck(VAR_INVALIDARG);

  _VarClear(TVarData(Result));

  TVarData(Result).VType := TVarData(A).VType or varByRef;
  if (TVarData(A).VType and varByRef) <> 0 then
    TVarData(Result).VPointer := TVarData(A).VPointer
  else
    TVarData(Result).VPointer := @TVarData(A).VArray;
end;

function VarIsArray(const A: Variant): Boolean;
begin
  Result := VarIsArray(A, True);
end;

function VarIsArray(const A: Variant; AResolveByRef: Boolean): Boolean;
var
  LVarType: TVarType;
  LVarArray: PVarArray;
begin
  if AResolveByRef then
    Result := GetVarDataArrayInfo(TVarData(A), LVarType, LVarArray)
  else
    Result := (TVarData(A).VType and varArray) = varArray;
end;

function VarTypeIsValidArrayType(const AVarType: TVarType): Boolean;
begin
  Result := (AVarType in [CMinArrayVarType..CMaxArrayVarType]) and
            CVarTypeToElementInfo[AVarType].ValidBase;
end;

function VarTypeIsValidElementType(const AVarType: TVarType): Boolean;
begin
  Result := (((AVarType and not varByRef) in [CMinArrayVarType..CMaxArrayVarType]) and
             CVarTypeToElementInfo[AVarType and not varByRef].ValidElement) or
            VarTypeIsCustom(AVarType);
end;

{$IFDEF CPUX86}
function _VarArrayGet(var A: TVarData;
  IndexCount: Integer; const Indices: TVarArrayCoorArray): TVarData; cdecl;
{$ELSE}
procedure _VarArrayGet(var Result: TVarData; var A: TVarData;
  IndexCount: Integer; const Indices: PVarArrayCoorArray);
{$ENDIF}
var
  LVarType: TVarType;
  LVarArrayPtr: PVarArray;
  LArrayVarType: Integer;
  P: Pointer;
  LResult: TVarData;
begin
  if not GetVarDataArrayInfo(A, LVarType, LVarArrayPtr) then
    VarResultCheck(VAR_INVALIDARG);

  if LVarArrayPtr^.DimCount <> IndexCount then
    VarResultCheck(VAR_BADINDEX);

  // use a LTemp for result just in case the result points back to source, icky
  VariantInit(LResult);
  try
    LArrayVarType := LVarType and varTypeMask;
    if LArrayVarType = varVariant then
    begin
      {$IFDEF CPUX86}
      VarResultCheck(SafeArrayPtrOfIndex(LVarArrayPtr, @Indices, P));
      {$ELSE}
      VarResultCheck(SafeArrayPtrOfIndex(LVarArrayPtr, Indices, P));
      {$ENDIF}
      _VarCopy(LResult, PVarData(P)^);
    end
    else
    begin
      {$IFDEF CPUX86}
      VarResultCheck(SafeArrayGetElement(LVarArrayPtr, @Indices, @TVarData(LResult).VPointer));
      {$ELSE}
      VarResultCheck(SafeArrayGetElement(LVarArrayPtr, Indices, @TVarData(LResult).VPointer));
      {$ENDIF}
      TVarData(LResult).VType := LArrayVarType;
    end;

    // copy the LTemp result over to result
    _VarCopy(Result, LResult);
  finally
    _VarClear(LResult);
  end;
end;

// Thin wrapper around _VarArrayGet. On x86, _VarArrayGet is cdecl and varargs, so
// assembly is required to push the Indices parameters onto the stack.
function VarArrayGet(const A: Variant; const Indices: array of Integer): Variant;
{$IFNDEF X86ASM}
begin
  _VarArrayGet(PVarData(@Result)^, PVarData(@A)^,
    Length(Indices), PVarArrayCoorArray(@Indices));
end;
{$ELSE X86ASM}
asm
        {     ->EAX     Pointer to A            }
        {       EDX     Pointer to Indices      }
        {       ECX     High bound of Indices   }
        {       [EBP+8] Pointer to result       }
{       PUSH    EBP        Hidden stack Frame   }
{       MOV     EBP, ESP                        }
        PUSH    EBX

        MOV     EBX,ECX
{$IFDEF ALIGN_STACK}
        TEST    EBX, EBX
        JS      @@noalign0
        NEG     EBX  // Need to adjust by (1-n)%4 bytes to align
        INC     EBX
        AND     EBX, 3
        NEG     EBX
        LEA     ESP,[ESP+EBX*4]
@@noalign0:
        MOV     EBX, ECX
{$ENDIF ALIGN_STACK}
        INC     EBX
        JLE     @@endLoop
@@loop:
        PUSH    [EDX+ECX*4].Integer
        DEC     ECX
        JNS     @@loop
@@endLoop:
        PUSH    EBX
        PUSH    EAX
        MOV     EAX,[EBP+8]
        PUSH    EAX
        CALL    _VarArrayGet
{$IFDEF MACOS}
        LEA     ESP,[ESP+EBX*4+2*4]
{$ELSE}
        LEA     ESP,[ESP+EBX*4+3*4]
{$ENDIF}
{$IFDEF ALIGN_STACK}
        DEC     EBX
        JS      @@noalign1
        NEG     EBX // Need to adjust by (1-n)%4 bytes to align
        INC     EBX
        AND     EBX, 3
        LEA     ESP,[ESP+EBX*4]
@@noalign1:
{$ENDIF ALIGN_STACK}

        POP     EBX
{       POP     EBP  //Hidden stack frame }
end;
{$ENDIF X86ASM}

{$IFDEF CPUX86}
procedure _VarArrayPut(var A: TVarData; const Value: TVarData;
  IndexCount: Integer; const Indices: TVarArrayCoorArray); cdecl;
{$ELSE !CPUX86}
procedure _VarArrayPut(var A: TVarData; const Value: TVarData;
  IndexCount: Integer; const Indices: PVarArrayCoorArray);
{$ENDIF !CPUX86}
type
  TAnyPutArrayProc = procedure (var A: Variant; const Value: Variant; Index: Integer);
var
  LVarType: TVarType;
  LVarArrayPtr: PVarArray;
  LValueType: TVarType;
  LValueArrayPtr: PVarArray;
  LArrayVarType: Integer;
  P: Pointer;
  LTemp: TVarData;
begin
  if not GetVarDataArrayInfo(A, LVarType, LVarArrayPtr) then
    VarResultCheck(VAR_INVALIDARG);

  if not GetVarDataArrayInfo(TVarData(Value), LValueType, LValueArrayPtr) and
     not VarTypeIsValidElementType(LValueType) and
     (LValueType <> varString) and
     (LValueType <> varUString) then
    VarResultCheck(VAR_TYPEMISMATCH);

  if LVarArrayPtr^.DimCount <> IndexCount then
    VarResultCheck(VAR_BADINDEX);

  LArrayVarType := LVarType and varTypeMask;

  if (LArrayVarType = varVariant) and
     (((LValueType <> varString) and (LValueType <> varUString)) or
      VarTypeIsCustom(LValueType)) then
  begin
    {$IFDEF CPUX86}
    VarResultCheck(SafeArrayPtrOfIndex(LVarArrayPtr, @Indices, P));
    {$ELSE}
    VarResultCheck(SafeArrayPtrOfIndex(LVarArrayPtr, Indices, P));
    {$ENDIF}
    PVariant(P)^ := Variant(Value);
  end else
  begin
    VariantInit(LTemp);
    try
      if LArrayVarType = varVariant then
      begin
        VarStringToOleStr(Variant(LTemp), Variant(Value));
        P := @LTemp;
      end else
      begin
        _VarCast(LTemp, TVarData(Value), LArrayVarType);
        case LArrayVarType of
          varOleStr, varDispatch, varUnknown:
            P := LTemp.VPointer;
        else
          P := @LTemp.VPointer;
        end;
      end;
      {$IFDEF CPUX86}
      VarResultCheck(SafeArrayPutElement(LVarArrayPtr, @Indices, P));
      {$ELSE}
      VarResultCheck(SafeArrayPutElement(LVarArrayPtr, Indices, P));
      {$ENDIF}
    finally
      _VarClear(LTemp);
    end;
  end;
end;

// Thin wrapper around _VarArrayPut. On x86, _VarArrayPut is cdecl and varargs, so
// assembly is required to push the Indices parameters onto the stack.
procedure VarArrayPut(var A: Variant; const Value: Variant; const Indices: array of Integer);
{$IFNDEF X86ASM}
begin
  _VarArrayPut(TVarData(A), TVarData(Value), Length(Indices), PVarArrayCoorArray(@Indices));
end;
{$ELSE X86ASM}
asm
        {     ->EAX     Pointer to A            }
        {       EDX     Pointer to Value        }
        {       ECX     Pointer to Indices      }
        {       [EBP+8] High bound of Indices   }
{       PUSH    EBP        Hidden stack Frame   }
{       MOV     EBP, ESP                        }

        PUSH    EBX
        MOV     EBX,[EBP+8]
        TEST    EBX,EBX
        JS      @@endLoop

{$IFDEF ALIGN_STACK}
        NEG     EBX
        ADD     EBX, 5
        AND     EBX, 3
        JE      @@endloop0
@@loop0:
        PUSH    EBX
        DEC     EBX
        JNE     @@loop0
@@endloop0:
        MOV     EBX,[EBP+8]
{$ENDIF ALIGN_STACK}

@@loop:
        PUSH    [ECX+EBX*4].Integer
        DEC     EBX
        JNS     @@loop
@@endLoop:
        MOV     EBX,[EBP+8]
        INC     EBX
        PUSH    EBX
        PUSH    EDX
        PUSH    EAX
        CALL    _VarArrayPut
        LEA     ESP,[ESP+EBX*4+3*4]

{$IFDEF ALIGN_STACK}
        DEC     EBX
        TEST    EBX,EBX
        JS      @@endLoop1
        NEG     EBX
        ADD     EBX, 5
        AND     EBX, 3
        JE      @@endLoop1
@@loop1:
        POP     EAX  //Anything but EBX
        DEC     EBX
        JNE     @@loop1
@@endloop1:
        MOV     EBX,[EBP+8]
{$ENDIF ALIGN_STACK}
        POP     EBX
{       POP     EBP  //Hidden stack frame }
end;
{$ENDIF X86ASM}

type
  TVariantBoundArray = array of Integer;

{ Decrements to next lower index - Returns True if successful }
{ Indices: Indices to be decremented }
{ Bounds : High bounds of each dimension }
function DecIndices(var Indices: TVariantBoundArray; const Bounds: TVariantBoundArray): Boolean;
var
  I, J: Integer;
begin
  { Find out if we're done: all at zeroes }
  Result := False;
  for I := Low(Indices)  to High(Indices) do
    if Indices[I] <> 0  then
    begin
      Result := True;
      break;
    end;
  if not Result then
    Exit;

  { Two arrays must be of same length }
  Assert(Length(Indices) = Length(Bounds));

  { Find index of item to tweak }
  for I := High(Indices) downto Low(Bounds) do
  begin
    // If not reach zero, dec and bail out
    if Indices[I] <> 0 then
    begin
      Dec(Indices[I]);
      Exit;
    end
    else
    begin
      J := I;
      while Indices[J] = 0 do
      begin
        // Restore high bound when we've reached zero on a particular dimension
        Indices[J] := Bounds[J];
        // Move to higher dimension
        Dec(J);
        Assert(J >= 0);
      end;
      Dec(Indices[J]);
      Exit;
    end;
  end;
end;

// Returns Bounds of a DynamicArray in a format usable for creating a Variant.
//  i.e. The format of the bounds returns contains pairs of lo and hi bounds where
//       lo is always 0, and hi is the size dimension of the array-1.
function DynArrayVariantBounds(const DynArray: Pointer; typeInfo: PDynArrayTypeInfo): TVariantBoundArray;
var
  Dim, I: Integer;
  P: Pointer;
begin
  P := DynArray;

  Dim := DynArrayDim(typeInfo);
  SetLength(Result, Dim * 2);

  I := 0;
  while I < dim * 2 do
  begin
    Result[I] := 0;   // Always use 0 as low-bound in low/high pair
    Inc(I);
    if P <> nil then
    begin
      Result[I] := DynArraySize(P) - 1; // Adjust for 0-base low-bound
      P := PPointerArray(p)[0];         // Assume rectangular arrays
    end
    else
      Result[I] := -1;
    Inc(I);
  end;
end;

// The dynamicArrayTypeInformation contains the VariantType of the element type
// when the kind == tkDynArray. This function returns that VariantType.
function DynArrayVarType(typeInfo: PDynArrayTypeInfo): Integer;
begin
  Result := varNull;
  if (typeInfo <> nil) and (typeInfo.Kind = tkDynArray) then
  begin
    Inc(PByte(typeInfo), typeInfo.name);
    Result := typeInfo.varType;

    { NOTE: DECL.H and SYSTEM.PAS have different values for varString }
    if Result = $48 then
      Result := varString;
    if Result = $4A then
      Result := varUString;
  end;

  { Validate the Result }
  if (Result <= varNull) or
     (Result = $000E{varDecimal}) or
     (Result = $000F{varUndef0F}) or
     ((Result > varInt64) and not ((Result = varString) or (Result = varUString))) then
    VarCastError;
end;

// Copy Contents of Dynamic Array to Variant
// NOTE: The Dynamic array must be rectangular
//       The Dynamic array must contain items whose type is Automation compatible
// In case of failure, the function returns with a Variant of type VT_EMPTY.
procedure DynArrayToVariant(var V: Variant; const DynArray: Pointer; TypeInfo: Pointer);
var
  LVarBounds, Bounds, Indices: TVariantBoundArray;
  DynBounds: TBoundArray;
  I: Integer;
  DAVarType, VVarType, DynDim: Integer;
  PDAData: Pointer;
  Value: Variant;
begin
  LVarBounds := nil;
  Bounds    := nil;

  { This resets the Variant to VT_EMPTY - flag which is used to determine whether the }
  { the cast to Variant succeeded or not }
  VarClear(V);

  { Get variantType code from DynArrayTypeInfo }
  DAVarType := DynArrayVarType(PDynArrayTypeInfo(TypeInfo));

  {NOTE: Map varString to varOleStr for SafeArrayCreate call }
  if (DAVarType = varString) or (DAVarType = varUString) then
    VVarType := varOleStr
  else
    VVarType := DAVarType;

  { Get dimension of Dynamic Array }
  DynDim := DynarrayDim(PDynArrayTypeInfo(TypeInfo));

  { If more than one dimension, make sure we're dealing with a rectangular array }
  if DynDim > 1 then
    if not IsDynArrayRectangular(DynArray, PDynArrayTypeInfo(TypeInfo)) then
      Exit;

  { Get Variant-style Bounds (lo/hi pair) of Dynamic Array }
  LVarBounds := DynArrayVariantBounds(DynArray, TypeInfo);

  { Get DynArray Bounds }
  DynBounds := DynArrayBounds(DynArray, TypeInfo);
  SetLength(Bounds, Length(DynBounds));
  for I := Low(DynBounds) to High(DynBounds) do
    Bounds[I] := DynBounds[I];

  Indices:= Copy(Bounds);

  { Create Variant of SAFEARRAY }
  V := VarArrayCreate(LVarBounds, VVarType);
  Assert(VarArrayDimCount(V) = DynDim);

  { Keep the data around for a bit }
  VarArrayLock(V);
  try
    repeat
      PDAData := DynArrayIndex(DynArray, Indices, TypeInfo);
      if PDAData <> nil then
      begin
        case DAVarType of
          varSmallInt:  Value := PSmallInt(PDAData)^;
          varInteger:   Value := PInteger(PDAData)^;
          varSingle:    value := PSingle(PDAData)^;
          varDouble:    value := PDouble(PDAData)^;
          varCurrency:  Value := PCurrency(PDAData)^;
          varDate:      Value := PDouble(PDAData)^;
          varDispatch:  Value := PDispatch(PDAData)^;
          varError:     Value := Integer(System.PError(PDAData)^); // Symbol collision with LibC
          varBoolean:   Value := PWordBool(PDAData)^;
          varVariant:   Value := PVariant(PDAData)^;
          varUnknown:   Value := PUnknown(PDAData)^;
          varShortInt:  Value := PShortInt(PDAData)^;
          varByte:      Value := PByte(PDAData)^;
          varWord:      Value := PWord(PDAData)^;
          varLongWord:  Value := PLongWord(PDAData)^;
          varInt64:     Value := PInt64(PDAData)^;
          varUInt64:    Value := PUInt64(PDAData)^;
{$IFNDEF NEXTGEN}
          varOleStr:    Value := PWideString(PDAData)^;
          varString:    Value := PAnsiString(PDAData)^;
{$ENDIF !NEXTGEN}
          varUString:   Value := PUnicodeString(PDAData)^
        else
          VarClear(Value);
        end; { case }
        VarArrayPut(V, Value, Indices);
      end;
    until not DecIndices(Indices, Bounds);

  { Let go of the data }
  finally
    VarArrayUnlock(V);
  end;
end;

// Copies data from the Variant to the DynamicArray
procedure DynArrayFromVariant(var DynArray: Pointer; const V: Variant; TypeInfo: Pointer);
var
  DADimCount, VDimCount: Integer;
  DAVarType, I: Integer;
  VLength: array of NativeInt;
  DynBounds: TBoundArray;
  Bounds, Indices: TVariantBoundArray;
  Value: Variant;
  PDAData: Pointer;
begin
  { Get Variant information }
  VDimCount:= VarArrayDimCount(V);

  { Make sure we have got something usable }
  if VDimCount = 0 then
    VarResultCheck(VAR_INVALIDARG);

  { Keep the data around for a bit }
  VarArrayLock(V);
  try

    { Allocate vector for lengths }
    SetLength(VLength, VDimCount);

    { Initialize lengths - NOTE: VarArrayxxxxBound are 1 - based.}
    for I := 0  to  VDimCount - 1 do
      VLength[I] := (VarArrayHighBound(V, I + 1) - VarArrayLowBound(V, I + 1)) + 1;

    { Set Length of DynArray }
    DynArraySetLength(DynArray, PDynArrayTypeInfo(TypeInfo), VDimCount, @VLength[0]);

    { Get DynArray information }
    DADimCount:= DynArrayDim(PDynArrayTypeInfo(TypeInfo));
    DAVarType := DynArrayVarType(PDynArrayTypeInfo(TypeInfo));
    Assert(VDimCount = DADimCount);

    { Get DynArray Bounds }
    DynBounds := DynArrayBounds(DynArray, TypeInfo);
    SetLength(Bounds, Length(DynBounds));
    for I := Low(DynBounds) to High(DynBounds) do
      Bounds[I] := DynBounds[I];

    Indices:= Copy(Bounds);

    { Copy data over}
    repeat
      Value   := VarArrayGet(V, Indices);
      PDAData := DynArrayIndex(DynArray, Indices, TypeInfo);
      case DAVarType of
        varSmallInt:  PSmallInt(PDAData)^     := Value;
        varInteger:   PInteger(PDAData)^      := Value;
        varSingle:    PSingle(PDAData)^       := Value;
        varDouble:    PDouble(PDAData)^       := Value;
        varCurrency:  PCurrency(PDAData)^     := Value;
        varDate:      PDouble(PDAData)^       := Value;
        varDispatch:  PDispatch(PDAData)^     := Value;
        varError:     System.PError(PDAData)^ := Value; // Symbol collision with LibC
        varBoolean:   PWordBool(PDAData)^     := Value;
        varVariant:   PVariant(PDAData)^      := Value;
        varUnknown:   PUnknown(PDAData)^      := Value;
        varShortInt:  PShortInt(PDAData)^     := Value;
        varByte:      PByte(PDAData)^         := Value;
        varWord:      PWord(PDAData)^         := Value;
        varLongWord:  PLongWord(PDAData)^     := Value;
        varInt64:     PInt64(PDAData)^        := Value;
        varUInt64:    PUInt64(PDAData)^       := Value;
{$IFNDEF NEXTGEN}
        varString:    PAnsiString(PDAData)^   := Value;
        varOleStr:    PWideString(PDAData)^   := Value;
{$ENDIF !NEXTGEN}
        varUString:   PUnicodeString(PDAData)^:= Value;
      end; { case }
    until not DecIndices(Indices, Bounds);

  { Let go of the data }
  finally
    VarArrayUnlock(V);
  end;
end;

{ TCustomVariantType support }

var
                                                                                                 
  LVarTypes: array of TCustomVariantType;
  LNextVarType: Integer = CFirstUserType;
  LVarTypeSync: TObject;

procedure ClearVariantTypeList;
var
  I: Integer;
begin
  MonitorEnter(LVarTypeSync);
  try
    for I := Length(LVarTypes) - 1 downto 0 do
    begin
      if LVarTypes[I] <> nil then
      begin
        if LVarTypes[I] <> CInvalidCustomVariantType then
          LVarTypes[I].Free;
        if LVarTypes[I] = CInvalidCustomVariantType then
          Pointer(LVarTypes[I]) := nil;
      end;
    end;
    LVarTypes := nil;
  finally
    MonitorExit(LVarTypeSync);
  end;
end;

{ TCustomVariantType }

constructor TCustomVariantType.Create;
begin
  Create(LNextVarType);
  Inc(LNextVarType);
end;

constructor TCustomVariantType.Create(RequestedVarType: TVarType);
var
  LSlot, LWas, LNewLength, I: Integer;
begin
  inherited Create;
  MonitorEnter(LVarTypeSync);
  try
    LSlot := RequestedVarType - CMinVarType;
    if (LSlot < 0) or (RequestedVarType < CFirstUserType) then
      raise EVariantError.CreateFmt(SVarTypeOutOfRangeWithPrefix, [HexDisplayPrefix, RequestedVarType]);
    LWas := Length(LVarTypes);
    if LSlot >= LWas then
    begin
      LNewLength := ((LSlot div CIncVarType) + 1) * CIncVarType;
      if LNewLength > CMaxVarType then
        raise EVariantError.Create(SVarTypeTooManyCustom);
      SetLength(LVarTypes, LNewLength);
      for I := LWas to Length(LVarTypes) - 1 do
        LVarTypes[I] := nil;
    end;
    if LVarTypes[LSlot] <> nil then
      if LVarTypes[LSlot] = CInvalidCustomVariantType then
        raise EVariantError.CreateFmt(SVarTypeNotUsableWithPrefix, [HexDisplayPrefix, RequestedVarType])
      else
        raise EVariantError.CreateFmt(SVarTypeAlreadyUsedWithPrefix, [HexDisplayPrefix, RequestedVarType, LVarTypes[LSlot].ClassName]);
    LVarTypes[LSlot] := Self;
    FVarType := RequestedVarType;
  finally
    MonitorExit(LVarTypeSync);
  end;
end;

destructor TCustomVariantType.Destroy;
begin
  MonitorEnter(LVarTypeSync);
  try
    if FVarType <> 0 then
    begin
      Assert (Length(LVarTypes) > VarType - CMinVarType);
      LVarTypes[VarType - CMinVarType] := nil;
      Pointer(LVarTypes[VarType - CMinVarType]) := CInvalidCustomVariantType;
    end;
  finally
    MonitorExit(LVarTypeSync);
  end;

  inherited;
end;

procedure TCustomVariantType.BinaryOp(var Left: TVarData;
  const Right: TVarData; const Operator: TVarOp);
begin
  RaiseInvalidOp;
end;

procedure TCustomVariantType.Cast(var Dest: TVarData; const Source: TVarData);
var
  LSourceHandler: TCustomVariantType;
begin
  if FindCustomVariantType(Source.VType, LSourceHandler) then
    LSourceHandler.CastTo(Dest, Source, VarType)
  else
    RaiseCastError;
end;

procedure TCustomVariantType.CastTo(var Dest: TVarData; const Source: TVarData;
  const AVarType: TVarType);
var
  LSourceHandler: TCustomVariantType;
begin
  if (AVarType <> VarType) and
     FindCustomVariantType(Source.VType, LSourceHandler) then
    LSourceHandler.CastTo(Dest, Source, AVarType)
  else
    RaiseCastError;
end;

procedure TCustomVariantType.Compare(const Left, Right: TVarData;
  var Relationship: TVarCompareResult);
begin
  RaiseInvalidOp;
end;

function TCustomVariantType.CompareOp(const Left, Right: TVarData;
  const Operator: TVarOp): Boolean;
const
  CRelationshipToBoolean: array [opCmpEQ..opCmpGE, TVarCompareResult] of Boolean =
  //  crLessThan, crEqual, crGreaterThan
    ((False,      True,    False), // opCmpEQ = 14;
     (True,       False,   True),  // opCmpNE = 15;
     (True,       False,   False), // opCmpLT = 16;
     (True,       True,    False), // opCmpLE = 17;
     (False,      False,   True),  // opCmpGT = 18;
     (False,      True,    True)); // opCmpGE = 19;
var
  LRelationship: TVarCompareResult;
begin
  Compare(Left, Right, LRelationship);
  Result := CRelationshipToBoolean[Operator, LRelationship];
end;

procedure TCustomVariantType.CastToOle(var Dest: TVarData;
  const Source: TVarData);
var
  LBestOleType: TVarType;
begin
  if OlePromotion(Source, LBestOleType) then
    CastTo(Dest, Source, LBestOleType)
  else
    RaiseCastError;
end;

function TCustomVariantType.IsClear(const V: TVarData): Boolean;
begin
  Result := False;
end;

function TCustomVariantType.LeftPromotion(const V: TVarData;
  const Operator: TVarOp; out RequiredVarType: TVarType): Boolean;
begin
  RequiredVarType := VarType;
  Result := True;
end;

function TCustomVariantType.OlePromotion(const V: TVarData;
  out RequiredVarType: TVarType): Boolean;
begin
  RequiredVarType := varOleStr;
  Result := True;
end;

procedure TCustomVariantType.RaiseCastError;
begin
  VarCastError;
end;

procedure TCustomVariantType.RaiseInvalidOp;
begin
  VarInvalidOp;
end;

procedure TCustomVariantType.RaiseDispError;
begin
  _DispInvokeError;
end;

function TCustomVariantType.RightPromotion(const V: TVarData;
  const Operator: TVarOp; out RequiredVarType: TVarType): Boolean;
begin
  RequiredVarType := VarType;
  Result := True;
end;

procedure TCustomVariantType.SimplisticClear(var V: TVarData);
begin
  VarDataInit(V);
end;

procedure TCustomVariantType.SimplisticCopy(var Dest: TVarData;
  const Source: TVarData; const Indirect: Boolean);
begin
  if Indirect and VarDataIsByRef(Source) then
    VarDataCopyNoInd(Dest, Source)
  else
    Dest := Source; // simple block copy
end;

procedure TCustomVariantType.UnaryOp(var Right: TVarData; const Operator: TVarOp);
begin
  RaiseInvalidOp;
end;

procedure TCustomVariantType.VarDataInit(var Dest: TVarData);
begin
  VariantInit(Dest);
end;

procedure TCustomVariantType.VarDataClear(var Dest: TVarData);
begin
  _VarClear(Dest);
end;

procedure TCustomVariantType.VarDataCopy(var Dest: TVarData; const Source: TVarData);
begin
  _VarCopy(Dest, Source);
end;

procedure TCustomVariantType.VarDataCopyNoInd(var Dest: TVarData; const Source: TVarData);
begin
  _VarCopyNoInd(Dest, Source);
end;

procedure TCustomVariantType.VarDataCast(var Dest: TVarData;
  const Source: TVarData);
begin
  VarDataCastTo(Dest, Source, VarType);
end;

procedure TCustomVariantType.VarDataCastTo(var Dest: TVarData;
  const Source: TVarData; const AVarType: TVarType);
begin
  _VarCast(Dest, Source, AVarType);
end;

procedure TCustomVariantType.VarDataCastTo(var Dest: TVarData;
  const AVarType: TVarType);
begin
  VarDataCastTo(Dest, Dest, AVarType);
end;

procedure TCustomVariantType.VarDataCastToOleStr(var Dest: TVarData);
begin
  if (Dest.VType = varString) or (Dest.VType = varUString) then
    _VarStringToOleStr(Dest, Dest)
  else
    VarDataCastTo(Dest, Dest, varOleStr);
end;

function TCustomVariantType.VarDataIsArray(const V: TVarData): Boolean;
begin
  Result := (V.VType and varArray) <> 0;
end;

function TCustomVariantType.VarDataIsByRef(const V: TVarData): Boolean;
begin
  Result := (V.VType and varByRef) <> 0;
end;

procedure TCustomVariantType.DispInvoke(Dest: PVarData;
  [Ref] const Source: TVarData; CallDesc: PCallDesc; Params: Pointer);
begin
  RaiseDispError;
end;

function TCustomVariantType.VarDataIsEmptyParam(const V: TVarData): Boolean;
begin
  Result := VarIsEmptyParam(Variant(V));
end;

procedure TCustomVariantType.VarDataFromStr(var V: TVarData; const Value: string);
begin
  _VarFromUStr(V, Value);
end;

{$IFNDEF NEXTGEN}
procedure TCustomVariantType.VarDataFromLStr(var V: TVarData; const Value: AnsiString);
begin
  _VarFromLStr(V, Value);
end;

procedure TCustomVariantType.VarDataFromOleStr(var V: TVarData; const Value: WideString);
begin
  _VarFromWStr(V, Value);
end;
{$ENDIF !NEXTGEN}

function TCustomVariantType._AddRef: Integer;
begin
  Result := -1;
end;

function TCustomVariantType._Release: Integer;
begin
  Result := -1;
end;

function TCustomVariantType.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TCustomVariantType.VarDataIsNumeric(const V: TVarData): Boolean;
begin
  Result := VarTypeIsNumeric(V.VType);
end;

function TCustomVariantType.VarDataIsOrdinal(const V: TVarData): Boolean;
begin
  Result := VarTypeIsOrdinal(V.VType);
end;

function TCustomVariantType.VarDataIsStr(const V: TVarData): Boolean;
begin
  Result := VarTypeIsStr(V.VType);
end;

function TCustomVariantType.VarDataIsFloat(const V: TVarData): Boolean;
begin
  Result := VarTypeIsFloat(V.VType);
end;

function TCustomVariantType.VarDataToStr(const V: TVarData): string;
begin
  Result := VarToStr(Variant(V));
end;

{ TInvokeableVariantType }

function TInvokeableVariantType.FixupIdent(const AText: string): string;
begin
  Result := AnsiUppercase(AText);
end;


procedure TInvokeableVariantType.DispInvoke(Dest: PVarData; [Ref] const Source: TVarData;
  CallDesc: PCallDesc; Params: Pointer);
type
  PParamRec = ^TParamRec;
  TParamRec = array[0..3] of LongInt;
  TStringDesc = record
    BStr: WideString;
    PStr: PString;
  end;
const
  CDoMethod    = $01;
  CPropertyGet = $02;
  CPropertySet = $04;
var
  I, LArgCount: Integer;
  LIdent: string;
  LTemp: TVarData;
  VarParams : TVarDataArray;
  Strings: TStringRefList;
  PIdent: PByte;
  BIdent: TBytes;
begin
  // Grab the identifier
  LArgCount := CallDesc^.ArgCount;
  PIdent := @CallDesc^.ArgTypes[LArgCount];
                                                                                  
  SetLength(BIdent, 255);
  I := 0;
  while PIDent[I] <> 0 do
  begin
    BIdent[I] := PIdent[I];
    Inc(I);
  end;
  LIdent := FixupIdent(TEncoding.UTF8.GetString(BIdent, 0, I));

  FillChar(Strings, SizeOf(Strings), 0);
  VarParams := GetDispatchInvokeArgs(CallDesc, Params, Strings, true);

  // What type of invoke is this?
  case CallDesc^.CallType of
    CDoMethod:
      // procedure with N arguments
      if Dest = nil then
      begin
        if not DoProcedure(Source, LIdent, VarParams) then
        begin

          // ok maybe its a function but first we must make room for a result
          VarDataInit(LTemp);
          try

            // notate that the destination shouldn't be bothered with
            // functions can still return stuff, we just do this so they
            //  can tell that they don't need to if they don't want to
            SetClearVarToEmptyParam(LTemp);

            // ok lets try for that function
            if not DoFunction(LTemp, Source, LIdent, VarParams) then
              RaiseDispError;
          finally
            VarDataClear(LTemp);
          end;
        end
      end

      // property get or function with 0 argument
      else if LArgCount = 0 then
      begin
        if not GetProperty(Dest^, Source, LIdent) and
           not DoFunction(Dest^, Source, LIdent, VarParams) then
          RaiseDispError;
      end

      // function with N arguments
      else if not DoFunction(Dest^, Source, LIdent, VarParams) then
        RaiseDispError;

    CPropertyGet:
      if not ((Dest <> nil) and                         // there must be a dest
              (LArgCount = 0) and                       // only no args
              GetProperty(Dest^, Source, LIdent)) then  // get op be valid
        RaiseDispError;

    CPropertySet:
      if not ((Dest = nil) and                          // there can't be a dest
              (LArgCount = 1) and                       // can only be one arg
              SetProperty(Source, LIdent, VarParams[0])) then // set op be valid
        RaiseDispError;
  else
    RaiseDispError;
  end;

  for I := 0 to Length(Strings) - 1 do
  begin
    if Pointer(Strings[I].Wide) = nil then
      Break;
{$IFNDEF NEXTGEN}
    if Strings[I].Ansi <> nil then
      Strings[I].Ansi^ := AnsiString(Strings[I].Wide)
    else
{$ENDIF !NEXTGEN}
      if Strings[I].Unicode <> nil then
        Strings[I].Unicode^ := UnicodeString(Strings[I].Wide)
  end;
end;

function TInvokeableVariantType.GetProperty(var Dest: TVarData; const V: TVarData;
  const Name: string): Boolean;
begin
  Result := False;
end;

function TInvokeableVariantType.SetProperty(const V: TVarData; const Name: string;
  const Value: TVarData): Boolean;
begin
  Result := False;
end;

function TInvokeableVariantType.DoFunction(var Dest: TVarData; const V: TVarData;
  const Name: string; const Arguments: TVarDataArray): Boolean;
begin
  Result := False;
end;

function TInvokeableVariantType.DoProcedure(const V: TVarData; const Name: string;
  const Arguments: TVarDataArray): Boolean;
begin
  Result := False;
end;

{ TCustomVariantType support }

function FindCustomVariantType(const AVarType: TVarType; out CustomVariantType: TCustomVariantType): Boolean;
begin
  // fail if no custom types are defined or if the vartype is way out of range
  Result := (LVarTypes <> nil) and
            (AVarType >= CMinVarType) and (AVarType <= CMaxVarType);
  if Result then
  begin
    MonitorEnter(LVarTypeSync);
    try
      Result := AVarType - CMinVarType < Length(LVarTypes);
      if Result then
      begin
        CustomVariantType := LVarTypes[AVarType - CMinVarType];
        Result := (CustomVariantType <> nil) and
                  (CustomVariantType <> CInvalidCustomVariantType);
      end;
    finally
      MonitorExit(LVarTypeSync);
    end;
  end;
end;

function FindCustomVariantType(const TypeName: string; out CustomVariantType: TCustomVariantType): Boolean;
var
  I: Integer;
  LPossible: TCustomVariantType;
begin
  Result := False;
  MonitorEnter(LVarTypeSync);
  try
    for I := Low(LVarTypes) to High(LVarTypes) do
    begin
      LPossible := LVarTypes[I];
      if (LPossible <> nil) and (LPossible <> CInvalidCustomVariantType) and
         SameText(LPossible.ClassName, TypeName) then
      begin
        CustomVariantType := LPossible;
        Result := True;
        Break;
      end;
    end;
  finally
    MonitorExit(LVarTypeSync);
  end;
end;

function Unassigned: Variant;
begin
  _VarClear(TVarData(Result));
end;

function Null: Variant;
begin
  _VarNull(TVarData(Result));
end;

{$IFNDEF EMPTYPARAM_VAR}
function EmptyParam: OleVariant;
begin
  SetClearVarToEmptyParam(TVarData(Result));
end;
{$ENDIF}

procedure _VarAdd(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opAdd);
{$ELSE}
asm
        MOV     ECX,opAdd
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarSub(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opSubtract);
{$ELSE}
asm
        MOV     ECX,opSubtract
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarMul(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opMultiply);
{$ELSE}
asm
        MOV     ECX,opMultiply
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarDiv(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opIntDivide);
{$ELSE}
asm
        MOV     ECX,opIntDivide
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarMod(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opModulus);
{$ELSE}
asm
        MOV     ECX,opModulus
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarAnd(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opAnd);
{$ELSE}
asm
        MOV     ECX,opAnd
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarOr(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opOr);
{$ELSE}
asm
        MOV     ECX,opOr
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarXor(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opXor);
{$ELSE}
asm
        MOV     ECX,opXor
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarShl(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opShiftLeft);
{$ELSE}
asm
        MOV     ECX,opShiftLeft
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarShr(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opShiftRight);
{$ELSE}
asm
        MOV     ECX,opShiftRight
        JMP     _VarOp
{$ENDIF}
end;

procedure _VarRDiv(var Left: TVarData; const Right: TVarData);
{$IF Defined(PIC) or Defined(PUREPASCAL)}
begin
  _VarOp(Left, Right, opDivide);
{$ELSE}
asm
        MOV     ECX,opDivide
        JMP     _VarOp
{$ENDIF}
end;

// Variant comparison helper fucntions
// On x86, the compiler expects the result to be in the flags register,
// so these functions must be implemented in assembly.
{$IFNDEF X86ASM}
function _VarCmpEQ(const Left, Right: TVarData): Boolean;
begin
  Result := VarCompare(Left, Right, opCmpEQ) = crEqual;
end;
{$ELSE X86ASM}
procedure _VarCmpEQ(const Left, Right: TVarData); // result is set in the flags
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        MOV     ECX, opCmpEQ
        CALL    VarCompare
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        CMP     AL, crEqual
end;
{$ENDIF X86ASM}

{$IFNDEF X86ASM}
function _VarCmpNE(const Left, Right: TVarData): Boolean;
begin
  Result := VarCompare(Left, Right, opCmpNE) <> crEqual;
end;
{$ELSE X86ASM}
procedure _VarCmpNE(const Left, Right: TVarData); // result is set in the flags
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        MOV     ECX, opCmpNE
        CALL    VarCompare
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        CMP     AL, crEqual
end;
{$ENDIF X86ASM}

{$IFNDEF X86ASM}
function _VarCmpLT(const Left, Right: TVarData): Boolean;
begin
  Result := VarCompare(Left, Right, opCmpLT) = crLessThan;
end;
{$ELSE X86ASM}
procedure _VarCmpLT(const Left, Right: TVarData); // result is set in the flags
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        MOV     ECX, opCmpLT
        CALL    VarCompare
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        CMP     AL, crEqual
end;
{$ENDIF X86ASM}

{$IFNDEF X86ASM}
function _VarCmpLE(const Left, Right: TVarData): Boolean;
var
  LResult: TVarCompareResult;
begin
  LResult := VarCompare(Left, Right, opCmpLE);
  Result := (LResult = crLessThan) or (LResult = crEqual);
end;
{$ELSE X86ASM}
procedure _VarCmpLE(const Left, Right: TVarData); // result is set in the flags
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        MOV     ECX, opCmpLE
        CALL    VarCompare
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        CMP     AL, crEqual
end;
{$ENDIF X86ASM}

{$IFNDEF X86ASM}
function _VarCmpGT(const Left, Right: TVarData): Boolean;
begin
  Result := VarCompare(Left, Right, opCmpGT) = crGreaterThan;
end;
{$ELSE X86ASM}
procedure _VarCmpGT(const Left, Right: TVarData); // result is set in the flags
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        MOV     ECX, opCmpGT
        CALL    VarCompare
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        CMP     AL, crEqual
end;
{$ENDIF X86ASM}

{$IFNDEF X86ASM}
function _VarCmpGE(const Left, Right: TVarData): Boolean;
var
  LResult: TVarCompareResult;
begin
  LResult := VarCompare(Left, Right, opCmpGE);
  Result := (LResult = crGreaterThan) or (LResult = crEqual);
end;
{$ELSE X86ASM}
procedure _VarCmpGE(const Left, Right: TVarData); // result is set in the flags
asm
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        MOV     ECX, opCmpGE
        CALL    VarCompare
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        CMP     AL, crEqual
end;
{$ENDIF X86ASM}


initialization
{$IFDEF EMPTYPARAM_VAR}
  SetClearVarToEmptyParam(TVarData(EmptyParam));
{$ENDIF}

  VarDispProc := @_DispInvokeError;
  ClearAnyProc := @VarInvalidOp;
  ChangeAnyProc := @VarCastError;
  RefAnyProc := @VarInvalidOp;

  System.VarClearProc := @_VarClr;
  System.VarAddRefProc := @_VarAddRef;
  System.VarCopyProc   := @_VarCopy;
{$IFNDEF NEXTGEN}
  System.VarToLStrProc := @_VarToLStr;
  System.VarToWStrProc := @_VarToWStr;
{$ENDIF !NEXTGEN}
  System.VarToUStrProc := @_VarToUStr;

  LVarTypeSync := TObject.Create;
finalization
  ClearVariantTypeList;
  LVarTypeSync.Free;
{$IF Defined(AUTOREFCOUNT)}
  Pointer((@CInvalidCustomVariantType)^) := nil;
{$ENDIF}
end.
