{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.TypInfo;

{$T-,X+}
{$WARN WIDECHAR_REDUCED OFF}
{$WARN UNSAFE_VOID_POINTER OFF}
{$IFDEF CPUX64}
  {$DEFINE PUREPASCAL}
{$ENDIF CPUX64}
{$IFDEF NEXTGEN}
  {$DEFINE PUREPASCAL}
{$ENDIF NEXTGEN}


(*$HPPEMIT END '#if defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)'*)
(*$HPPEMIT END 'using System::Typinfo::PTypeInfo;'*)
(*$HPPEMIT END '#endif'*)

interface
uses
  System.Variants,
  System.SysUtils;

type
  TTypeKind = (tkUnknown, tkInteger, tkChar, tkEnumeration, tkFloat,
    tkString, tkSet, tkClass, tkMethod, tkWChar, tkLString, tkWString,
    tkVariant, tkArray, tkRecord, tkInterface, tkInt64, tkDynArray, tkUString,
    tkClassRef, tkPointer, tkProcedure);

// Easy access methods

function PropType(Instance: TObject; const PropName: string): TTypeKind; overload;
function PropType(AClass: TClass; const PropName: string): TTypeKind; overload;

function PropIsType(Instance: TObject; const PropName: string;
  TypeKind: TTypeKind): Boolean; overload;
function PropIsType(AClass: TClass; const PropName: string;
  TypeKind: TTypeKind): Boolean; overload;

function IsStoredProp(Instance: TObject; const PropName: string): Boolean; overload;

function IsPublishedProp(Instance: TObject; const PropName: string): Boolean; overload;
function IsPublishedProp(AClass: TClass; const PropName: string): Boolean; overload;

function GetOrdProp(Instance: TObject; const PropName: string): NativeInt; overload;
procedure SetOrdProp(Instance: TObject; const PropName: string;
  Value: NativeInt); overload;

function GetEnumProp(Instance: TObject; const PropName: string): string; overload;
procedure SetEnumProp(Instance: TObject; const PropName: string;
  const Value: string); overload;

function GetSetProp(Instance: TObject; const PropName: string;
  Brackets: Boolean = False): string; overload;
procedure SetSetProp(Instance: TObject; const PropName: string;
  const Value: string); overload;

function GetObjectProp(Instance: TObject; const PropName: string;
  MinClass: TClass = nil): TObject; overload;
procedure SetObjectProp(Instance: TObject; const PropName: string;
  Value: TObject); overload;
function GetObjectPropClass(Instance: TObject; const PropName: string): TClass; overload;

function GetStrProp(Instance: TObject; const PropName: string): string; overload;
procedure SetStrProp(Instance: TObject; const PropName: string;
  const Value: string); overload;

{$IFNDEF NEXTGEN}
function GetAnsiStrProp(Instance: TObject; const PropName: string): AnsiString; overload;
procedure SetAnsiStrProp(Instance: TObject; const PropName: string; const Value: AnsiString); overload;

function GetWideStrProp(Instance: TObject; const PropName: string): WideString; overload;
  deprecated 'use GetStrProp';
procedure SetWideStrProp(Instance: TObject; const PropName: string; const Value: WideString); overload;
  deprecated 'use SetStrProp';

function GetUnicodeStrProp(Instance: TObject; const PropName: string): UnicodeString; overload;
  deprecated 'use GetStrProp';
procedure SetUnicodeStrProp(Instance: TObject; const PropName: string;
  const Value: UnicodeString); overload;
  deprecated 'use SetStrProp';
{$ENDIF !NEXTGEN}

function GetFloatProp(Instance: TObject; const PropName: string): Extended; overload;
procedure SetFloatProp(Instance: TObject; const PropName: string;
  const Value: Extended); overload;

function GetVariantProp(Instance: TObject; const PropName: string): Variant; overload;
procedure SetVariantProp(Instance: TObject; const PropName: string;
  const Value: Variant); overload;

function GetMethodProp(Instance: TObject; const PropName: string): TMethod; overload;
procedure SetMethodProp(Instance: TObject; const PropName: string;
  const Value: TMethod); overload;

function GetInt64Prop(Instance: TObject; const PropName: string): Int64; overload;
procedure SetInt64Prop(Instance: TObject; const PropName: string;
  const Value: Int64); overload;

function GetInterfaceProp(Instance: TObject; const PropName: string): IInterface; overload;
procedure SetInterfaceProp(Instance: TObject; const PropName: string;
  const Value: IInterface); overload;

function GetDynArrayProp(Instance: TObject; const PropName: string): Pointer; overload;
procedure SetDynArrayProp(Instance: TObject; const PropName: string;
  const Value: Pointer); overload;

function GetPropValue(Instance: TObject; const PropName: string;
  PreferStrings: Boolean = True): Variant; overload;
procedure SetPropValue(Instance: TObject; const PropName: string;
  const Value: Variant); overload;

{ This will take any RTTI enabled object and free and nil out each of its
  object properties.  Please note that will also clear any objects that this
  object may have property references to, so make sure to nil those out first. }

procedure FreeAndNilProperties(AObject: TObject);

{ TPublishableVariantType - This class further expands on the TCustomVariantType
  by adding easy support for accessing published properties implemented by
  custom descendant variant types.  The descendant variant type simply needs
  to implement the GetInstance function, publish their properties and this
  class will take care of the rest.  For examples on how to do that take a look
  at VarCmplx and, if you have our database components, SqlTimSt. }

type
  TPublishableVariantType = class(TInvokeableVariantType, IVarInstanceReference)
  protected
    { IVarInstanceReference }
    function GetInstance(const V: TVarData): TObject; virtual; abstract;
  public
    function GetProperty(var Dest: TVarData; const V: TVarData;
      const Name: string): Boolean; override;
    function SetProperty(const V: TVarData; const Name: string;
      const Value: TVarData): Boolean; override;
  end;

{ Property access types }

type
  TTypeKinds = set of TTypeKind;

  TOrdType = (otSByte, otUByte, otSWord, otUWord, otSLong, otULong);

  TFloatType = (ftSingle, ftDouble, ftExtended, ftComp, ftCurr);

  TMemberVisibility = (mvPrivate, mvProtected, mvPublic, mvPublished);

  TMethodKind = (mkProcedure, mkFunction, mkConstructor, mkDestructor,
    mkClassProcedure, mkClassFunction, mkClassConstructor, mkClassDestructor,
    mkOperatorOverload,
    { Obsolete }
    mkSafeProcedure, mkSafeFunction);

  TParamFlag = (pfVar, pfConst, pfArray, pfAddress, pfReference, pfOut, pfResult);
  {$EXTERNALSYM TParamFlag}
  TParamFlags = set of TParamFlag;
  TParamFlagsBase = set of TParamFlag;
  {$EXTERNALSYM TParamFlagsBase}
  TIntfFlag = (ifHasGuid, ifDispInterface, ifDispatch);
  {$EXTERNALSYM TIntfFlag}
  TIntfFlags = set of TIntfFlag;
  TIntfFlagsBase = set of TIntfFlag;
  {$EXTERNALSYM TIntfFlagsBase}

const
  tkAny = [Low(TTypeKind)..High(TTypeKind)];
  tkMethods = [tkMethod];
  tkProperties = tkAny - tkMethods - [tkUnknown];

  (*$HPPEMIT OPENNAMESPACE *)
  (*$HPPEMIT '  enum DECLSPEC_DENUM TParamFlag : unsigned char {'*)
  (*$HPPEMIT '    pfVar, pfConst, pfArray, pfAddress, pfReference, pfOut, pfResult'*)
  (*$HPPEMIT '  };'*)
  (*$HPPEMIT '  enum DECLSPEC_DENUM TIntfFlag : unsigned char {ifHasGuid, ifDispInterface, ifDispatch};'*)
  (*$HPPEMIT '  typedef SetBase<TParamFlag, pfVar, pfResult> TParamFlagsBase;'*)
  (*$HPPEMIT '  typedef SetBase<TIntfFlag, ifHasGuid, ifDispatch> TIntfFlagsBase;'*)
  (*$HPPEMIT CLOSENAMESPACE *)

const
{$IF SizeOf(Pointer) = 4}
  PROPSLOT_MASK    = $FF000000;
  PROPSLOT_FIELD   = $FF000000;
  PROPSLOT_VIRTUAL = $FE000000;
{$ELSEIF SizeOf(Pointer) = 8}
  PROPSLOT_MASK    = $FF00000000000000;
  PROPSLOT_FIELD   = $FF00000000000000;
  PROPSLOT_VIRTUAL = $FE00000000000000;
{$ELSE OTHER_PTR_SIZE}
{$MESSAGE Fatal 'Unrecognized pointer size'}
{$ENDIF OTHER_PTR_SIZE}

type
{$IFDEF NEXTGEN}
  TSymbolName = Byte;
{$ELSE  NEXTGEN}
  TSymbolNameBase = string[255];
  TSymbolName = type TSymbolNameBase;
{$ENDIF NEXTGEN}

{$IFDEF NEXTGEN}
  {$NODEFINE TSymbolName } 
  {$HPPEMIT 'typedef System::Byte TSymbolName;'}
{$ELSE  NEXTGEN}
  {$NODEFINE TSymbolNameBase } 
  {$NODEFINE TSymbolName 'TSymbolName' 'TSymbolNameBase'} 
  {$HPPEMIT OPENNAMESPACE }
  {$HPPEMIT 'typedef System::ShortString TSymbolName;'}
  {$HPPEMIT 'typedef System::ShortStringBase TSymbolNameBase;'}
  {$HPPEMIT CLOSENAMESPACE }
{$ENDIF NEXTGEN}

  TTypeInfoFieldAccessor = record
  strict private
    FData: PByte;
  public
    procedure SetData(const Data: PByte); inline;
    class operator Equal(const Left, Right: TTypeInfoFieldAccessor): Boolean; inline;
    function UTF8Length: integer; inline;
    function ToString: string;
{$IFNDEF NEXTGEN}
    function ToShortUTF8String: ShortString; inline;
{$ENDIF !NEXTGEN}
    function ToByteArray: TBytes;
    function Tail: PByte; inline;
  end;

                                                   
  TCallConv = (ccReg, ccCdecl, ccPascal, ccStdCall, ccSafeCall);

  PAttrData = ^TAttrData;
  PVmtMethodEntryTail = ^TVmtMethodEntryTail;
  PIntfMethodEntryTail = ^TIntfMethodEntryTail;
  PTypeData = ^TTypeData;
  PPropData = ^TPropData;
  PPropDataEx = ^TPropDataEx;

  PPTypeInfo = ^PTypeInfo;
  PTypeInfo = ^TTypeInfo;
  TTypeInfo = record
    Kind: TTypeKind;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {TypeData: TTypeData}
    function TypeData: PTypeData; inline;
  end;

  PAttrEntry = ^TAttrEntry;
  TAttrEntry = record
    AttrType: PPTypeInfo;
    AttrCtor: Pointer;
    ArgLen: Word;
    ArgData: array[1..65536 {ArgLen - 2}] of Byte;
  end;

  TAttrData = record
    Len: Word;
   {AttrEntry: array[] of TAttrEntry;}
  end;

  PFieldExEntry = ^TFieldExEntry;
  TFieldExEntry = packed record
    Flags: Byte;
    TypeRef: PPTypeInfo;
    Offset: Longword;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {AttrData: TAttrData}
    function AttrData: PAttrData; inline;
  end;

  PVmtFieldEntry = ^TVmtFieldEntry;
  TVmtFieldEntry = packed record
    FieldOffset: Longword;
    TypeIndex: Word; // index into ClassTab
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {AttrData: TAttrData}
    function AttrData: PAttrData; inline;
  end;

  PVmtFieldClassTab = ^TVmtFieldClassTab;
  TVmtFieldClassTab = packed record
    Count: Word;
    ClassRef: array[Word] of ^TClass;
  end;

  { vmtFieldTable entry in VMT }
  PVmtFieldTable = ^TVmtFieldTable;
  TVmtFieldTable = packed record
    Count: Word; // Published fields
    ClassTab: PVmtFieldClassTab;
   {Entry: array[1..Count] of TVmtFieldEntry;
    ExCount: Word;
    ExEntry: array[1..ExCount] of TVmtFieldExEntry;}
  end;

  PVmtMethodParam = ^TVmtMethodParam;
  TVmtMethodParam = packed record
    Flags: Byte;
    ParamType: PPTypeInfo;
    ParOff: Byte; // Parameter location: 0..2 for reg, >=8 for stack
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {AttrData: TAttrData;}
    function AttrData: PAttrData; inline;
  end;

  PVmtMethodEntry = ^TVmtMethodEntry;
  TVmtMethodEntry = packed record
    Len: Word;
    CodeAddress: Pointer;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {Tail: TVmtMethodEntryTail;} // only exists if Len indicates data here
    function Tail: PVmtMethodEntryTail; inline;
  end;

  TVmtMethodEntryTail = packed record
    Version: Byte; // =3
    CC: TCallConv;
    ResultType: PPTypeInfo; // nil for procedures
    ParOff: Word; // total size of data needed for stack parameters + 8 (ret-addr + pushed EBP)
    ParamCount: Byte;
   {Params: array[1..ParamCount] of TVmtMethodParam;
    AttrData: TAttrData;}
  end;

  PVmtMethodExEntry = ^TVmtMethodExEntry;
  TVmtMethodExEntry = packed record
    Entry: PVmtMethodEntry;
    Flags: Word;
    VirtualIndex: Smallint; // signed word
  end;

  { vmtMethodTable entry in VMT }
  PVmtMethodTable = ^TVmtMethodTable;
  TVmtMethodTable = packed record
    Count: Word;
   {Entry: array[1..Count] of TVmtMethodEntry;}
   {ExCount: Word;}
   {ExEntry: array[1..ExCount] of TVmtMethodExEntry;}
   {VirtCount: Word;}
  end;

  PArrayPropInfo = ^TArrayPropInfo;
  TArrayPropInfo = packed record
    Flags: Byte;
    ReadIndex: Word;
    WriteIndex: Word;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {AttrData: TAttrData;}
    function AttrData: PAttrData; inline;
  end;

  PManagedField = ^TManagedField;
  TManagedField = packed record
    TypeRef: PPTypeInfo;
    FldOffset: NativeInt;
  end;

  PProcedureParam = ^TProcedureParam;
  TProcedureParam = packed record
    Flags: Byte;
    ParamType: PPTypeInfo;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {AttrData: TAttrData;}
    function AttrData: PAttrData; inline;
  end;

  PProcedureSignature = ^TProcedureSignature;
  TProcedureSignature = packed record
    Flags: Byte; // if 255 then record stops here, with Flags
    CC: TCallConv;
    ResultType: PPTypeInfo;
    ParamCount: Byte;
   {Params: array[1..ParamCount] of TProcedureParam;}
  end;

  PIntfMethodTable = ^TIntfMethodTable;
  TIntfMethodTable = packed record
    Count: Word; // methods in this interface
    RttiCount: Word; // =Count, or $FFFF if no further data
   {Entry: array[1..Count] of TIntfMethodEntry;
    AttrData: TAttrData;}
  end;

  PIntfMethodEntry = ^TIntfMethodEntry;
  TIntfMethodEntry = packed record
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {Tail: TIntfMethodEntryTail;}
    function Tail: PIntfMethodEntryTail; inline;
  end;

  TIntfMethodEntryTail = packed record
    Kind: Byte; // 0=proc or 1=func
    CC: TCallConv;
    ParamCount: Byte;
   {Params: array[1..ParamCount] of TIntfMethodParam;
    ResultTypeName: string; // only if func
    ResultType: PPTypeInfo; // only if Len(Name) > 0
    AttrData: TAttrData;}
  end;

  PIntfMethodParam = ^TIntfMethodParam;
  TIntfMethodParam = packed record
    Flags: Byte;
    ParamName: TSymbolName;
    function ParamNameFld: TTypeInfoFieldAccessor; inline;
   {TypeName: ShortString;
    Tail: TIntfMethodParamTail;}
  end;

  PIntfMethodParamTail = ^TIntfMethodParamTail;
  TIntfMethodParamTail = packed record
    ParamType: PPTypeInfo;
    AttrData: TAttrData; // not currently entered
  end;

  PArrayTypeData = ^TArrayTypeData;
  TArrayTypeData = packed record
    Size: Integer;
    ElCount: Integer; // product of lengths of all dimensions
    ElType: PPTypeInfo;
    DimCount: Byte;
    Dims: array[0..255 {DimCount-1}] of PPTypeInfo;
  end;

  PRecordTypeField = ^TRecordTypeField;
  TRecordTypeField = packed record
    Field: TManagedField;
    Flags: Byte;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {AttrData: TAttrData;}
    function AttrData: PAttrData; inline;
  end;

  PRecordTypeMethod = ^TRecordTypeMethod;
  TRecordTypeMethod = packed record
    Flags: Byte;
    Code: Pointer;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
   {Sig: TProcedureSignature;
    AttrData: TAttrData;}
  end;

  TTypeData = packed record
    function NameListFld: TTypeInfoFieldAccessor; inline;
    function UnitNameFld: TTypeInfoFieldAccessor; inline;
    function IntfUnitFld: TTypeInfoFieldAccessor; inline;
    function DynUnitNameFld: TTypeInfoFieldAccessor; inline;

    function PropData: PPropData; inline;
    function IntfMethods: PIntfMethodTable; inline;

    function DynArrElType: PPTypeInfo; inline;
    function DynArrAttrData: PAttrData; inline;

    case TTypeKind of
      tkUnknown: ();
      tkUString,
{$IFNDEF NEXTGEN}
      tkWString,
{$ENDIF !NEXTGEN}
      tkVariant: (AttrData: TAttrData);
{$IFNDEF NEXTGEN}
      tkLString: (
        CodePage: Word
       {LStrAttrData: TAttrData});
{$ENDIF !NEXTGEN}
      tkInteger,
{$IFNDEF NEXTGEN}
      tkChar,
{$ENDIF !NEXTGEN}
      tkEnumeration, tkSet, tkWChar: (
        OrdType: TOrdType;
        case TTypeKind of
          tkInteger, tkChar, tkEnumeration, tkWChar: (
            MinValue: Longint;
            MaxValue: Longint;
            case TTypeKind of
              tkInteger, tkChar, tkWChar: (
                {OrdAttrData: TAttrData});
              tkEnumeration: (
                BaseType: PPTypeInfo;
                NameList: TSymbolName;
               {EnumUnitName: TSymbolName;
                EnumAttrData: TAttrData}));
          tkSet: (
            CompType: PPTypeInfo
           {SetAttrData: TAttrData}));
      tkFloat: (
        FloatType: TFloatType
       {FloatAttrData: TAttrData});
{$IFNDEF NEXTGEN}
      tkString: (
        MaxLength: Byte
       {StrAttrData: TAttrData});
{$ENDIF !NEXTGEN}
      tkClass: (
        ClassType: TClass; // most data for instance types is in VMT offsets
        ParentInfo: PPTypeInfo;
        PropCount: SmallInt; // total properties inc. ancestors
        UnitName: TSymbolName;
       {PropData: TPropData;
        PropDataEx: TPropDataEx;
        ClassAttrData: TAttrData;
        ArrayPropCount: Word;
        ArrayPropData: array[1..ArrayPropCount] of TArrayPropInfo;});
      tkMethod: (
        MethodKind: TMethodKind; // only mkFunction or mkProcedure
        ParamCount: Byte;
{$IFNDEF NEXTGEN}
        ParamList: array[0..1023] of AnsiChar
{$ELSE NEXTGEN}
        ParamList: array[0..1023] of Byte
{$ENDIF NEXTGEN}
       {ParamList: array[1..ParamCount] of
          record
            Flags: TParamFlags;
            ParamName: ShortString;
            TypeName: ShortString;
          end;
        ResultType: ShortString; // only if MethodKind = mkFunction
        ResultTypeRef: PPTypeInfo; // only if MethodKind = mkFunction
        CC: TCallConv;
        ParamTypeRefs: array[1..ParamCount] of PPTypeInfo;
        MethSig: PProcedureSignature;
        MethAttrData: TAttrData});
      tkProcedure: (
        ProcSig: PProcedureSignature;
        ProcAttrData: TAttrData;);
      tkInterface: (
        IntfParent : PPTypeInfo; { ancestor }
        IntfFlags : TIntfFlagsBase;
        Guid : TGUID;
        IntfUnit : TSymbolName
       {IntfMethods: TIntfMethodTable;
        IntfAttrData: TAttrData;});
      tkInt64: (
        MinInt64Value, MaxInt64Value: Int64;
        Int64AttrData: TAttrData;);
      tkDynArray: (
        elSize: Longint;
        elType: PPTypeInfo;       // nil if type does not require cleanup
        varType: Integer;         // Ole Automation varType equivalent
        elType2: PPTypeInfo;      // independent of cleanup
        DynUnitName: TSymbolName;
       {DynArrElType: PPTypeInfo; // actual element type, even if dynamic array
        DynArrAttrData: TAttrData});
      tkRecord: (
        RecSize: Integer;
        ManagedFldCount: Integer;
       {ManagedFields: array[0..ManagedFldCnt - 1] of TManagedField;
        NumOps: Byte;
        RecOps: array[1..NumOps] of Pointer;
        RecFldCnt: Integer;
        RecFields: array[1..RecFldCnt] of TRecordTypeField;
        RecAttrData: TAttrData;
        RecMethCnt: Word;
        RecMeths: array[1..RecMethCnt] of TRecordTypeMethod});
      tkClassRef: (
        InstanceType: PPTypeInfo;
        ClassRefAttrData: TAttrData;);
      tkPointer: (
        RefType: PPTypeInfo;
        PtrAttrData: TAttrData);
      tkArray: (
        ArrayData: TArrayTypeData;
       {ArrAttrData: TAttrData});
  end;

  TPropData = packed record
    PropCount: Word;
    PropList: record end;
   {PropList: array[1..PropCount] of TPropInfo}
  end;

  PPropInfo = ^TPropInfo;
  TPropInfo = packed record
    PropType: PPTypeInfo;
    GetProc: Pointer;
    SetProc: Pointer;
    StoredProc: Pointer;
    Index: Integer;
    Default: Longint;
    NameIndex: SmallInt;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor; inline;
    function Tail: PPropInfo; inline;
  end;

  TPropDataEx = packed record
    PropCount: Word;
    PropList: record end;
   {PropList: array[1..PropCount] of TPropInfoEx}
  end;

  PPropInfoEx = ^TPropInfoEx;
  TPropInfoEx = packed record
    Flags: Byte;
    Info: PPropInfo;
    AttrData: TAttrData
  end;

  TPropInfoProc = procedure(PropInfo: PPropInfo) of object;

  PPropList = ^TPropList;
  TPropList = array[0..16379] of PPropInfo;

  EPropertyError = class(Exception);
  EPropertyConvertError = class(Exception);

{ Property management/access routines }

function GetTypeName(TypeInfo: PTypeInfo): string;

function GetTypeData(TypeInfo: PTypeInfo): PTypeData;

function GetEnumName(TypeInfo: PTypeInfo; Value: Integer): string;
function GetEnumValue(TypeInfo: PTypeInfo; const Name: string): Integer;

function GetPropInfo(Instance: TObject; const PropName: string;
  AKinds: TTypeKinds = []): PPropInfo; overload;
function GetPropInfo(AClass: TClass; const PropName: string;
  AKinds: TTypeKinds = []): PPropInfo; overload;

function GetPropInfo(TypeInfo: PTypeInfo;
  const PropName: string): PPropInfo; overload;
function GetPropInfo(TypeInfo: PTypeInfo; const PropName: string;
  AKinds: TTypeKinds): PPropInfo; overload;

procedure GetPropInfos(TypeInfo: PTypeInfo; PropList: PPropList);

function GetPropList(TypeInfo: PTypeInfo; TypeKinds: TTypeKinds;
  PropList: PPropList; SortList: Boolean = True): Integer; overload;
function GetPropList(TypeInfo: PTypeInfo; out PropList: PPropList): Integer; overload;
function GetPropList(AObject: TObject; out PropList: PPropList): Integer; overload;
procedure SortPropList(PropList: PPropList; PropCount: Integer);

function IsStoredProp(Instance: TObject; PropInfo: PPropInfo): Boolean; overload;

{ Property access routines }

function GetPropName(PropInfo: PPropInfo): string;

function GetPropValue(Instance: TObject; PropInfo: PPropInfo;
  PreferStrings: Boolean = True): Variant; overload;
procedure SetPropValue(Instance: TObject; PropInfo: PPropInfo;
  const Value: Variant); overload;

function GetOrdProp(Instance: TObject; PropInfo: PPropInfo): NativeInt; overload;
procedure SetOrdProp(Instance: TObject; PropInfo: PPropInfo;
  Value: NativeInt); overload;

function GetEnumProp(Instance: TObject; PropInfo: PPropInfo): string; overload;
procedure SetEnumProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: string); overload;

function GetSetProp(Instance: TObject; PropInfo: PPropInfo;
  Brackets: Boolean = False): string; overload;
procedure SetSetProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: string); overload;

function GetObjectProp(Instance: TObject; PropInfo: PPropInfo;
  MinClass: TClass = nil): TObject; overload;
procedure SetObjectProp(Instance: TObject; PropInfo: PPropInfo;
  Value: TObject; ValidateClass: Boolean = True); overload;

function GetObjectPropClass(Instance: TObject; PropInfo: PPropInfo): TClass; overload;
function GetObjectPropClass(PropInfo: PPropInfo): TClass; overload;

function GetStrProp(Instance: TObject; PropInfo: PPropInfo): string; overload;
procedure SetStrProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: string); overload;

{$IFNDEF NEXTGEN}
function GetAnsiStrProp(Instance: TObject; PropInfo: PPropInfo): AnsiString; overload;
procedure SetAnsiStrProp(Instance: TObject; PropInfo: PPropInfo; const Value: AnsiString); overload;

function GetWideStrProp(Instance: TObject; PropInfo: PPropInfo): WideString; overload;
procedure SetWideStrProp(Instance: TObject; PropInfo: PPropInfo; const Value: WideString); overload;

function GetUnicodeStrProp(Instance: TObject; PropInfo: PPropInfo): UnicodeString; overload;
procedure SetUnicodeStrProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: UnicodeString); overload;
{$ENDIF !NEXTGEN}

function GetFloatProp(Instance: TObject; PropInfo: PPropInfo): Extended; overload;
procedure SetFloatProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: Extended); overload;

function GetVariantProp(Instance: TObject; PropInfo: PPropInfo): Variant; overload;
procedure SetVariantProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: Variant); overload;

function GetMethodProp(Instance: TObject; PropInfo: PPropInfo): TMethod; overload;
procedure SetMethodProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: TMethod); overload;

function GetInt64Prop(Instance: TObject; PropInfo: PPropInfo): Int64; overload;
procedure SetInt64Prop(Instance: TObject; PropInfo: PPropInfo;
  const Value: Int64); overload;

function GetInterfaceProp(Instance: TObject; PropInfo: PPropInfo): IInterface; overload;
procedure SetInterfaceProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: IInterface); overload;

function GetDynArrayProp(Instance: TObject; PropInfo: PPropInfo): Pointer; overload;
procedure SetDynArrayProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: Pointer); overload;

var
  BooleanIdents: array [Boolean] of string = ('False', 'True');
  DotSep: string = '.';

{ Set to String conversion.  Valid only for "register sets" - sets with fewer
  than Sizeof(Integer) * 8 elements.  You will have to typecast the integer
  value to/from your set type.
}
function SetToString(PropInfo: PPropInfo; Value: Integer; Brackets: Boolean = False): string; overload;
function StringToSet(PropInfo: PPropInfo; const Value: string): Integer; overload;

function SetToString(TypeInfo: PTypeInfo; Value: Integer; Brackets: Boolean = False): string; overload;
function StringToSet(TypeInfo: PTypeInfo; const Value: string): Integer; overload;

function GetSetElementName(TypeInfo: PTypeInfo; Value: Integer): string;
function GetSetElementValue(TypeInfo: PTypeInfo; const Name: string): Integer;

function SamePropTypeName(const Name1, Name2: String): Boolean; overload;
{$IFNDEF NEXTGEN}
function SamePropTypeName(const Name1, Name2: ShortString): Boolean; overload
  deprecated 'use string version of SamePropTypeName';
function SamePropTypeName(const Name1: string; const Name2: ShortString): Boolean; overload
  deprecated 'use string version of SamePropTypeName';
function SamePropTypeName(const Name1: ShortString; const Name2: string): Boolean; overload
  deprecated 'use string version of SamePropTypeName';
{$ENDIF !NEXTGEN}

{$IF Defined(WEAKREF)}
function HasWeakRef(Info: PTypeInfo): Boolean;
{$ENDIF}

implementation

{$IFDEF MACOS}
{ Mac OS/X ABI requires stack to be aligned to 16 bytes at the
  point of a function call. }
{$DEFINE ALIGN_STACK}
{$ENDIF}

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, // Included for inline expansion of AnsiStrIComp
{$ENDIF}
{$IFDEF POSIX}
  Posix.String_, // Included for inline expansion of CompareMem
{$ENDIF POSIX}
  System.Rtti, System.Classes,
  System.RTLConsts, System.SysConst;

function InternalGetPropInfo(TypeInfo: PTypeInfo; const PropName: string): PPropInfo; forward;

{ TTypeInfoFieldAccessor }

procedure TTypeInfoFieldAccessor.SetData(const Data: PByte);
begin
  FData := Data;
end;

class operator TTypeInfoFieldAccessor.Equal(const Left, Right: TTypeInfoFieldAccessor): Boolean;
begin
  Result := (Left.FData^ = Right.FData^) and CompareMem(Left.FData, Right.FData, Left.FData^);
end;

function TTypeInfoFieldAccessor.UTF8Length: integer;
begin
  Result := FData^;
end;

function TTypeInfoFieldAccessor.ToString: string;
var
  Dest: array[0..511] of Char;
begin
  if FData^ <> 0 then
    SetString(Result, Dest, UTF8ToUnicode(Dest, Length(Dest), MarshaledAString(FData+1), FData^)-1)
  else
    Result := '';
end;

{$IFNDEF NEXTGEN}
function TTypeInfoFieldAccessor.ToShortUTF8String: ShortString;
begin
  Result := PShortString(FData)^;
end;
{$ENDIF !NEXTGEN}

function TTypeInfoFieldAccessor.ToByteArray: TBytes;
var
  Len: Integer;
begin
  Len := FData^;
  SetLength(Result, Len);
  if Len <> 0 then
    Move((FData+1)^, Result[0], Len);
end;


// P points a length field of ShortString.
function AfterString(const P: PByte): Pointer; inline;
begin
  Result := P + P^ + 1;
end;

function TTypeInfoFieldAccessor.Tail: PByte;
begin
  Result := FData + FData^ + 1;
end;

{ TTypeInfo }

function TTypeInfo.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TTypeInfo.TypeData: PTypeData;
begin
  Result := PTypeData(NameFld.Tail);
end;

{ TFieldExEntry }

function TFieldExEntry.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TFieldExEntry.AttrData: PAttrData;
begin
  Result := PAttrData(NameFld.Tail);
end;

{ TVmtFieldEntry }

function TVmtFieldEntry.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TVmtFieldEntry.AttrData: PAttrData;
begin
  Result := PAttrData(NameFld.Tail);
end;

{ TVmtMethodParam }

function TVmtMethodParam.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TVmtMethodParam.AttrData: PAttrData;
begin
  Result := PAttrData(NameFld.Tail);
end;

{ TVmtMethodEntry }

function TVmtMethodEntry.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TVmtMethodEntry.Tail: PVmtMethodEntryTail;
begin
  Result := PVmtMethodEntryTail(NameFld.Tail);
end;

{ TArrayPropInfo }

function TArrayPropInfo.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TArrayPropInfo.AttrData: PAttrData;
begin
  Result := PAttrData(NameFld.Tail);
end;

{ TProcedureParam }

function TProcedureParam.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TProcedureParam.AttrData: PAttrData;
begin
  Result := PAttrData(NameFld.Tail);
end;

{ TIntfMethodEntry }

function TIntfMethodEntry.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TIntfMethodEntry.Tail: PIntfMethodEntryTail;
begin
  Result := PIntfMethodEntryTail(NameFld.Tail);
end;

{ TIntfMethodParam }

function TIntfMethodParam.ParamNameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@ParamName);
end;

{ TRecordTypeField }

function TRecordTypeField.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TRecordTypeField.AttrData: PAttrData;
begin
  Result := PAttrData(NameFld.Tail);
end;

{ TRecordTypeMethod }

function TRecordTypeMethod.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

{ TTypeData }

function TTypeData.NameListFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@NameList);
end;

function TTypeData.UnitNameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@UnitName);
end;

function TTypeData.IntfUnitFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@IntfUnit);
end;

function TTypeData.DynUnitNameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@DynUnitName);
end;

function TTypeData.PropData: PPropData;
begin
  Result := PPropData(UnitNameFld.Tail)
end;

function TTypeData.IntfMethods: PIntfMethodTable;
begin
  Result := PIntfMethodTable(IntfUnitFld.Tail);
end;

function TTypeData.DynArrElType: PPTypeInfo;
type
  PPPTypeInfo = ^PPTypeInfo;
begin
  Result := PPPTypeInfo(DynUnitNameFld.Tail)^;
end;

function TTypeData.DynArrAttrData: PAttrData;
begin
  Result := PAttrData(Self.DynUnitNameFld.Tail + SizeOf(PPTypeInfo));
end;

{ TPropInfo }

function TPropInfo.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function TPropInfo.Tail: PPropInfo;
begin
  Result := PPropInfo(NameFld.Tail);
end;

procedure PropertyNotFound(const Name: string);
begin
  raise EPropertyError.CreateResFmt(@SUnknownProperty, [Name]);
end;

procedure RangeError;
begin
  raise ERangeError.CreateRes(@SRangeError);
end;

function PropIsType(Instance: TObject; const PropName: string; TypeKind: TTypeKind): Boolean;
begin
  Result := PropType(Instance, PropName) = TypeKind;
end;

function PropIsType(AClass: TClass; const PropName: string; TypeKind: TTypeKind): Boolean;
begin
  Result := PropType(AClass, PropName) = TypeKind;
end;

function PropType(Instance: TObject; const PropName: string): TTypeKind;
begin
  Result := PropType(Instance.ClassType, PropName);
end;

function FindPropInfo(AClass: TClass; const PropName: string): PPropInfo; overload;
begin
  Result := InternalGetPropInfo(PTypeInfo(AClass.ClassInfo), PropName);
  if Result = nil then
    PropertyNotFound(PropName);
end;

function FindPropInfo(Instance: TObject; const PropName: string): PPropInfo; overload;
begin
  Result := InternalGetPropInfo(PTypeInfo(Instance.ClassInfo), PropName);
  if Result = nil then
    PropertyNotFound(PropName);
end;

function PropType(AClass: TClass; const PropName: string): TTypeKind;
begin
  Result := FindPropInfo(AClass, PropName)^.PropType^^.Kind;
end;

function IsStoredProp(Instance: TObject; const PropName: string): Boolean;
begin
  Result := IsStoredProp(Instance, FindPropInfo(Instance, PropName));
end;

function GetOrdProp(Instance: TObject; const PropName: string): NativeInt;
begin
  Result := GetOrdProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetOrdProp(Instance: TObject; const PropName: string;
  Value: NativeInt);
begin
  SetOrdProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetEnumProp(Instance: TObject; const PropName: string): string;
begin
  Result := GetEnumProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetEnumProp(Instance: TObject; const PropName: string;
  const Value: string);
begin
  SetEnumProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetSetProp(Instance: TObject; const PropName: string;
  Brackets: Boolean): string;
begin
  Result := GetSetProp(Instance, FindPropInfo(Instance, PropName), Brackets);
end;

procedure SetSetProp(Instance: TObject; const PropName: string;
  const Value: string);
begin
  SetSetProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetObjectProp(Instance: TObject; const PropName: string;
  MinClass: TClass): TObject;
begin
  Result := GetObjectProp(Instance, FindPropInfo(Instance, PropName), MinClass);
end;

procedure SetObjectProp(Instance: TObject; const PropName: string;
  Value: TObject);
begin
  SetObjectProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetObjectPropClass(Instance: TObject; const PropName: string): TClass;
begin
  Result := GetObjectPropClass(FindPropInfo(Instance, PropName));
end;

function GetStrProp(Instance: TObject; const PropName: string): string;
begin
  Result := GetStrProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetStrProp(Instance: TObject; const PropName: string;
  const Value: string);
begin
  SetStrProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

{$IFNDEF NEXTGEN}
function GetAnsiStrProp(Instance: TObject; const PropName: string): AnsiString;
begin
  Result := GetAnsiStrProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetAnsiStrProp(Instance: TObject; const PropName: string; const Value: AnsiString);
begin
  SetAnsiStrProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetWideStrProp(Instance: TObject; const PropName: string): WideString;
begin
  Result := GetWideStrProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetWideStrProp(Instance: TObject; const PropName: string; const Value: WideString);
begin
  SetWideStrProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetUnicodeStrProp(Instance: TObject; const PropName: string): UnicodeString;
begin
  Result := GetStrProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetUnicodeStrProp(Instance: TObject; const PropName: string;
  const Value: UnicodeString);
begin
  SetStrProp(Instance, FindPropInfo(Instance, PropName), Value);
end;
{$ENDIF !NEXTGEN}

function GetFloatProp(Instance: TObject; const PropName: string): Extended;
begin
  Result := GetFloatProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetFloatProp(Instance: TObject; const PropName: string;
  const Value: Extended);
begin
  SetFloatProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetVariantProp(Instance: TObject; const PropName: string): Variant;
begin
  Result := GetVariantProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetVariantProp(Instance: TObject; const PropName: string;
  const Value: Variant);
begin
  SetVariantProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetMethodProp(Instance: TObject; const PropName: string): TMethod;
begin
  Result := GetMethodProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetMethodProp(Instance: TObject; const PropName: string;
  const Value: TMethod);
begin
  SetMethodProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetInt64Prop(Instance: TObject; const PropName: string): Int64;
begin
  Result := GetInt64Prop(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetInt64Prop(Instance: TObject; const PropName: string;
  const Value: Int64);
begin
  SetInt64Prop(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetPropName(PropInfo: PPropInfo): string;
begin
  Result := PropInfo.NameFld.ToString;;
end;

function GetPropValue(Instance: TObject; const PropName: string;
  PreferStrings: Boolean): Variant;
begin
  Result := GetPropValue(Instance,
    FindPropInfo(Instance, PropName), PreferStrings);
end;

function GetPropValue(Instance: TObject; PropInfo: PPropInfo;
  PreferStrings: Boolean): Variant;
var
  DynArray: Pointer;
begin
  // assume failure
  Result := Null;

  // return the right type
  case PropInfo^.PropType^^.Kind of
    tkInteger, tkChar, tkWChar, tkClass:
      Result := GetOrdProp(Instance, PropInfo);
    tkEnumeration:
      if PreferStrings then
        Result := GetEnumProp(Instance, PropInfo)
      else if GetTypeData(PropInfo^.PropType^)^.BaseType^ = TypeInfo(Boolean) then
        Result := Boolean(GetOrdProp(Instance, PropInfo))
      else
        Result := GetOrdProp(Instance, PropInfo);
    tkSet:
      if PreferStrings then
        Result := GetSetProp(Instance, PropInfo)
      else
        Result := GetOrdProp(Instance, PropInfo);
    tkFloat:
      Result := GetFloatProp(Instance, PropInfo);
    tkMethod:
      Result := GetTypeName(PropInfo^.PropType^);
{$IFNDEF NEXTGEN}
    tkString, tkLString:
      Result := GetStrProp(Instance, PropInfo);
    tkWString:
      Result := GetWideStrProp(Instance, PropInfo);
{$ENDIF !NEXTGEN}
    tkUString:
      Result := GetStrProp(Instance, PropInfo);
    tkVariant:
      Result := GetVariantProp(Instance, PropInfo);
    tkInt64:
      Result := GetInt64Prop(Instance, PropInfo);
    tkDynArray:
      begin
        DynArray := GetDynArrayProp(Instance, PropInfo);
        DynArrayToVariant(Result, DynArray, PropInfo^.PropType^);
      end;
  else
    raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType,
                                             [GetTypeName(PropInfo.PropType^)]);
  end;
end;

procedure SetPropValue(Instance: TObject; const PropName: string; const Value: Variant);
begin
  SetPropValue(Instance, FindPropInfo(Instance, PropName), Value);
end;

procedure SetPropValue(Instance: TObject; PropInfo: PPropInfo; const Value: Variant);

  function RangedValue(const AMin, AMax: Int64): Int64;
  begin
    Result := Trunc(Value);
    if (Result < AMin) or (Result > AMax) then
      RangeError;
  end;

  function RangedCharValue(const AMin, AMax: Int64): Int64;
  var
    s: string;
    ws: string;
  begin
    case VarType(Value) of
      varString:
        begin
          s := Value;
          if Length(s) = 1 then
            Result := Ord(s[Low(string)])
          else
            Result := AMin-1;
       end;

      varUString:
      begin
        s := Value;
        if Length(s) = 1 then
          Result := Ord(s[Low(string)])
        else
          Result := AMin-1;
       end;

      varOleStr:
      begin
        ws := Value;
        if Length(ws) = 1 then
          Result := Ord(ws[Low(string)])
        else
          Result := AMin-1;
      end;
    else
      Result := Trunc(Value);
    end;

    if (Result < AMin) or (Result > AMax) then
      RangeError;
  end;

var
  TypeData: PTypeData;
  DynArray: Pointer;
begin
  TypeData := GetTypeData(PropInfo^.PropType^);

  // set the right type
  case PropInfo.PropType^^.Kind of
{$IFNDEF NEXTGEN}
    tkChar,
{$ENDIF !NEXTGEN}
    tkWChar:
      SetOrdProp(Instance, PropInfo, RangedCharValue(TypeData^.MinValue,
        TypeData^.MaxValue));
    tkInteger:
      if TypeData^.MinValue < TypeData^.MaxValue then
        SetOrdProp(Instance, PropInfo, RangedValue(TypeData^.MinValue,
          TypeData^.MaxValue))
      else
        // Unsigned type
        SetOrdProp(Instance, PropInfo,
          RangedValue(LongWord(TypeData^.MinValue),
          LongWord(TypeData^.MaxValue)));
    tkEnumeration:
      if (VarType(Value) = varString) or (VarType(Value) = varOleStr) or (VarType(Value) = varUString) then
        SetEnumProp(Instance, PropInfo, VarToStr(Value))
      else if VarType(Value) = varBoolean then
        // Need to map variant boolean values -1,0 to 1,0
        SetOrdProp(Instance, PropInfo, Abs(Trunc(Value)))
      else
        SetOrdProp(Instance, PropInfo, RangedValue(TypeData^.MinValue,
          TypeData^.MaxValue));
    tkSet:
      if VarType(Value) = varInteger then
        SetOrdProp(Instance, PropInfo, Value)
      else
        SetSetProp(Instance, PropInfo, VarToStr(Value));
    tkFloat:
      SetFloatProp(Instance, PropInfo, Value);
{$IFNDEF NEXTGEN}
    tkString, tkLString:
      SetStrProp(Instance, PropInfo, VarToStr(Value));
    tkWString:
      SetWideStrProp(Instance, PropInfo, VarToWideStr(Value));
{$ENDIF !NEXTGEN}
    tkUString:
      SetStrProp(Instance, PropInfo, VarToStr(Value)); //SB: ??
    tkVariant:
      SetVariantProp(Instance, PropInfo, Value);
    tkInt64:
      SetInt64Prop(Instance, PropInfo, RangedValue(TypeData^.MinInt64Value,
        TypeData^.MaxInt64Value));
    tkDynArray:
      begin
        DynArray := nil; // "nil array"
        DynArrayFromVariant(DynArray, Value, PropInfo^.PropType^);
        SetDynArrayProp(Instance, PropInfo, DynArray);
      end;
  else
    raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType,
      [GetTypeName(PropInfo.PropType^)]);
  end;
end;

procedure FreeAndNilProperties(AObject: TObject);
var
  I, Count: Integer;
  PropInfo: PPropInfo;
  TempList: PPropList;
  LObject: TObject;
begin
  Count := GetPropList(AObject, TempList);
  if Count > 0 then
  try
    for I := 0 to Count - 1 do
    begin
      PropInfo := TempList^[I];
      if (PropInfo^.PropType^.Kind = tkClass) and
         Assigned(PropInfo^.GetProc) and
         Assigned(PropInfo^.SetProc) then
      begin
        LObject := GetObjectProp(AObject, PropInfo);
        if LObject <> nil then
        begin
          SetObjectProp(AObject, PropInfo, nil);
          LObject.Free;
        end;
      end;
    end;
  finally
    FreeMem(TempList);
  end;
end;

{ TPublishableVariantType }

function TPublishableVariantType.GetProperty(var Dest: TVarData;
  const V: TVarData; const Name: string): Boolean;
begin
  Variant(Dest) := GetPropValue(GetInstance(V), Name);
  Result := True;
end;

function TPublishableVariantType.SetProperty(const V: TVarData;
  const Name: string; const Value: TVarData): Boolean;
begin
  SetPropValue(GetInstance(V), Name, Variant(Value));
  Result := True;
end;

function GetTypeName(TypeInfo: PTypeInfo): string;
begin
  Result := TypeInfo.NameFld.ToString;
end;

function GetTypeData(TypeInfo: PTypeInfo): PTypeData;
{$IFDEF PUREPASCAL}
begin
  Result := TypeInfo.TypeData;
end;
{$ELSE}
asm // AlignStackSafe
        { ->    EAX Pointer to type info }
        { <-    EAX Pointer to type data }
        {       it's really just to skip the kind and the name  }
        XOR     EDX,EDX
        MOV     DL,[EAX].TTypeInfo.Name.Byte[0]
        LEA     EAX,[EAX].TTypeInfo.Name[EDX+1]
end;
{$ENDIF}

function _UTF8ToString(P: pointer): string;
var
  Len: Byte;
  Buf: array of Byte;
begin
    Result := '';
                                     
  Len := PByte(P)^;
  if Len <> 0 then
  begin
    SetLength(Buf, Len+1);
    Move(PByte(P)^, Buf[0], Len+1);
    Result := UTF8ToString(Buf); // array of Byte version. [0] is length of data.
  end;
end;

function GetEnumName(TypeInfo: PTypeInfo; Value: Integer): string;
var
  P: Pointer;
  T: PTypeData;
begin
  if TypeInfo^.Kind = tkInteger then
  begin
    Result := IntToStr(Value);
    Exit;
  end;
  T := GetTypeData(GetTypeData(TypeInfo)^.BaseType^);
  if (TypeInfo = System.TypeInfo(Boolean)) or (T^.MinValue < 0) then
  begin
    { LongBool/WordBool/ByteBool have MinValue < 0 and arbitrary
      content in Value; Boolean has Value in [0, 1] }
    Result := BooleanIdents[Value <> 0];
    if SameText(HexDisplayPrefix, '0x') then
      Result := LowerCase(Result);
  end
  else
  begin
    P := @T^.NameList;
    while Value <> 0 do
    begin
      P := AfterString(P);
      Dec(Value);
    end;
    Result := _UTF8ToString(P);                                                         
  end;
end;

{$IFDEF PUREPASCAL}
function GetEnumNameValue(TypeInfo: PTypeInfo; const Name: string): Integer;
var
  TypeData: PTypeData;
  LName: PByte;
  LStr: array[0..511] of WideChar;
  L: String;
  I: Integer;
begin
  TypeData := GetTypeData(GetTypeData(TypeInfo)^.BaseType^);
  LName := PByte(@TypeData.NameList);
  for i := 0 to TypeData.MaxValue do
  begin
    Utf8ToUnicode(LStr, Length(LStr), pointer(LName+1), LName^);
    L := LStr;
    if SameText(L, Name) then
      Exit(I);
    inc(LName, LName^ + 1);
  end;
  Result := -1;
end;
{$ELSE  PUREPASCAL}
function UTF8SameText(const Str1: ShortString; Str2: PAnsiChar): Boolean;
var
  LStr1, LStr2: array[0..511] of WideChar;
begin
  UTF8ToUnicode(LStr1, Length(LStr1), PAnsiChar(@Str1[1]), Length(Str1));
  UTF8ToUnicode(LStr2, Length(LStr2), Str2, Cardinal(-1));
  Result := AnsiStrIComp(LStr1, LStr2) = 0;
end;

function UTF8Compare(const Str1, Str2: PByte): Integer;
var
  LStr1, LStr2: array[0..511] of WideChar;
begin
  UTF8ToUnicode(LStr1, Length(LStr1), @Str1[1], Str1^);
  UTF8ToUnicode(LStr2, Length(LStr2), @Str2[1], Str2^);
  Result := AnsiStrIComp(LStr1, LStr2);
end;

function _GetEnumNameValue(TypeInfo: PTypeInfo; const Name: UTF8String): Integer;
asm //StackAligned
        { ->    EAX Pointer to type info        }
        {       EDX Pointer to string           }
        { <-    EAX Value                       }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        PUSH    0

        TEST    EDX,EDX
        JE      @notFound

        {       point ESI to first name of the base type }
        XOR     ECX,ECX
        MOV     CL,[EAX].TTypeInfo.Name.Byte[0]
        MOV     EAX,[EAX].TTypeInfo.Name[ECX+1].TTypeData.BaseType
        MOV     EAX,[EAX]
        MOV     CL,[EAX].TTypeInfo.Name.Byte[0]
        LEA     ESI,[EAX].TTypeInfo.Name[ECX+1].TTypeData.NameList

        {       make EDI the high bound of the enum type }
        MOV     EDI,[EAX].TTypeInfo.Name[ECX+1].TTypeData.MaxValue

        {       EAX is our running index }
        XOR     EAX,EAX

        {       make ECX the length of the current string }

@outerLoop:
        MOVZX   ECX,[ESI].Byte[0]
        CMP     ECX,[EDX-4]
        JNE     @lengthMisMatch

        {       we know for sure the names won't be zero length }
@cmpLoop:
        TEST    [ESP],1
        JNZ     @utf8compare
        MOV     BL,[EDX+ECX-1]
        TEST    BL,$80
        JNZ     @utf8compareParam
        XOR     BL,[ESI+ECX]
        TEST    BL,$80
        JNZ     @utf8compare
        TEST    BL,0DFH
        JNE     @misMatch
        DEC     ECX
        JNE     @cmpLoop

        {       as we didn't have a mismatch, we must have found the name }
        JMP     @exit

@utf8compareParam:
        MOV     [ESP],1

@utf8compare:
        PUSH    EAX
        PUSH    EDX
        MOV     EAX,ESI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        CALL    UTF8SameText
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        TEST    AL,AL
        POP     EDX
        POP     EAX
        JNZ     @exit

@misMatch:
        MOVZX   ECX,[ESI].Byte[0]
@lengthMisMatch:
        INC     EAX
        LEA     ESI,[ESI+ECX+1]
        CMP     EAX,EDI
        JLE     @outerLoop

        {       we haven't found the thing - return -1  }
@notFound:
        OR      EAX,-1

@exit:

        POP     EDI
        POP     EDI
        POP     ESI
        POP     EBX
end;

function GetEnumNameValue(TypeInfo: PTypeInfo; const Name: string): Integer;
begin
  Result := _GetEnumNameValue(TypeInfo, UTF8Encode(Name));
end;
{$ENDIF}

function GetEnumValue(TypeInfo: PTypeInfo; const Name: string): Integer;
begin
  if TypeInfo^.Kind = tkInteger then
    Result := StrToInt(Name)
  else
  begin
    Assert(TypeInfo^.Kind = tkEnumeration);
    if GetTypeData(TypeInfo)^.MinValue < 0 then  // Longbool/wordbool/bytebool
    begin
      if SameText(Name, BooleanIdents[False]) then
        Result := 0
      else if SameText(Name, BooleanIdents[True]) then
        Result := -1
      else
        Result := StrToInt(Name);
    end
    else
      Result := GetEnumNameValue(TypeInfo, Name);
  end;
end;

{$IFDEF PUREPASCAL}
function InternalGetPropInfo(TypeInfo: PTypeInfo; const PropName: String): PPropInfo;
var
  I: Integer;
  UTF8Length: Integer;
  S1, S2: string;
  TypeData: PTypeData;
  PropData: PPropData;
begin
  if TypeInfo = nil then Exit(nil);

  S1 := PropName;
  UTF8Length := Length(UTF8Encode(PropName));

  TypeData := GetTypeData(TypeInfo);

  while TypeData <> nil do
  begin
    //PropData := AfterString(@(TypeData^.UnitName));
    PropData := TypeData.PropData;
    Result := PPropInfo(@PropData^.PropList);
    for I := 1 to PropData^.PropCount do
    begin
                                                        
      if Result.NameFld.UTF8Length = UTF8Length then
      begin
        S2 := Result.NameFld.ToString;;
        if SameText(S1, S2) then Exit;
      end;
      Result := AfterString(@(Result^.Name));
    end;
    if TypeData^.ParentInfo = nil then
      TypeData := nil
    else
      TypeData := GetTypeData(TypeData^.ParentInfo^);
  end;
  Result := nil;
end;
{$ELSE  PUREPASCAL}
function _InternalGetPropInfo(TypeInfo: PTypeInfo; const PropName: UTF8String): PPropInfo;
asm //StackAligned
        { ->    EAX Pointer to type info        }
        {       EDX Pointer to prop name        }
        { <-    EAX Pointer to prop info        }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        PUSH    0

        TEST    EAX, EAX
        JZ      @exit

        MOV     ECX,EDX
        OR      EDX,EDX
        JE      @outerLoop
        MOV     CL,[EDX-4]
        MOV     CH,[EDX]

@outerLoop:
        XOR     EBX,EBX
        MOV     BL,[EAX].TTypeInfo.Name.Byte[0]
        LEA     ESI,[EAX].TTypeInfo.Name[EBX+1]
        MOV     BL,[ESI].TTypeData.UnitName.Byte[0]
        MOVZX   EDI,[ESI].TTypeData.UnitName[EBX+1].TPropData.PropCount
        TEST    EDI,EDI
        JE      @parent
        LEA     EAX,[ESI].TTypeData.UnitName[EBX+1].TPropData.PropList

@innerLoop:
        TEST    [ESP],1
        JNZ     @matchUTF8
        MOV     BX,[EAX].TPropInfo.Name.Word[0]
        TEST    BH,$80
        JNZ     @matchUTF8
        TEST    CH,$80
        JNZ     @matchUTF8Param
        AND     ECX,0DFFFH
        AND     BH,0DFH
        CMP     EBX,ECX
        JE      @matchStart

@nextProperty:
        MOV     BH,0
        DEC     EDI
        LEA     EAX,[EAX].TPropInfo.Name[EBX+1]
        JNE     @innerLoop

@parent:
        MOV     EAX,[ESI].TTypeData.ParentInfo
        TEST    EAX,EAX
        JE      @exit
        MOV     EAX,[EAX]
        JMP     @outerLoop

@misMatch:
        MOV     CH,[EDX]
        AND     CH,0DFH
        MOV     BL,[EAX].TPropInfo.Name.Byte[0]
        JMP     @nextProperty

@matchStart:
        MOV     BH,0

@matchLoop:
        MOV     CH,[EDX+EBX-1]
        TEST    CH,$80
        JNZ     @matchUTF8Param
        XOR     CH,[EAX].TPropInfo.Name.Byte[EBX]
        TEST    CH,$80
        JNZ     @matchUTF8
        TEST    CH,0DFH
        JNE     @misMatch
        DEC     EBX
        JNE     @matchLoop
        JMP     @exit

@matchUTF8Param:
        MOV     [ESP], 1

@matchUTF8:
        MOV     BH,0
        PUSH    EAX
        PUSH    EDX
        LEA     EAX,[EAX].TPropInfo.Name
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        CALL    UTF8SameText
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     EDX
        MOV     CL,[EDX-4]
        TEST    AL,AL
        POP     EAX
        JZ      @misMatch
@exit:
        POP     EDI
        POP     EDI
        POP     ESI
        POP     EBX
end;

function InternalGetPropInfo(TypeInfo: PTypeInfo; const PropName: String): PPropInfo;
begin
  Result := _InternalGetPropInfo(TypeInfo, UTF8Encode(PropName));
end;
{$ENDIF PUREPASCAL}

function GetPropInfo(TypeInfo: PTypeInfo; const PropName: string): PPropInfo;
begin
  Result := InternalGetPropInfo(TypeInfo, PropName);
end;

function GetPropInfo(TypeInfo: PTypeInfo; const PropName: string; AKinds: TTypeKinds): PPropInfo;
begin
  Result := InternalGetPropInfo(TypeInfo, PropName);
  if (Result <> nil) and
     (AKinds <> []) and
     not (Result^.PropType^^.Kind in AKinds) then
    Result := nil;
end;

function IsPublishedProp(Instance: TObject; const PropName: string): Boolean;
begin
  Result := InternalGetPropInfo(PTypeInfo(Instance.ClassInfo), PropName) <> nil;
end;

function IsPublishedProp(AClass: TClass; const PropName: string): Boolean;
begin
  Result := InternalGetPropInfo(PTypeInfo(AClass.ClassInfo), PropName) <> nil;
end;

function GetPropInfo(Instance: TObject; const PropName: string; AKinds: TTypeKinds): PPropInfo;
begin
  Result := GetPropInfo(PTypeInfo(Instance.ClassInfo), PropName, AKinds);
end;

function GetPropInfo(AClass: TClass; const PropName: string; AKinds: TTypeKinds): PPropInfo;
begin
  Result := GetPropInfo(PTypeInfo(AClass.ClassInfo), PropName, AKinds);
end;

procedure GetPropInfos(TypeInfo: PTypeInfo; PropList: PPropList);
{$IFDEF PUREPASCAL}
var
  TypeData: PTypeData;
  PropData: PPropData;
  PropInfo: PPropInfo;
  I: Integer;
begin
  TypeData := GetTypeData(TypeInfo);
  FillChar(PropList^, Sizeof(PPropInfo) * TypeData.PropCount, #0);
  while TypeData <> nil do
  begin
//    PropData := AfterString(@(TypeData^.UnitNameLen));
    PropData := TypeData.PropData;
    PropInfo := PPropInfo(@PropData^.PropList);
    for I := 1 to PropData^.PropCount do
    begin
      if PropList^[PropInfo.NameIndex] = nil then
        PropList^[PropInfo.NameIndex] := PropInfo;
      PropInfo := AfterString(@PropInfo^.Name);
    end;

    if TypeData^.ParentInfo = nil then
      TypeData := nil
    else
      TypeData := GetTypeData(TypeData^.ParentInfo^);
  end;
end;
{$ELSE !PUREPASCAL}
asm //StackAlignSafe
        { ->    EAX Pointer to type info        }
        {       EDX Pointer to prop list        }
        { <-    nothing                         }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI

        XOR     ECX,ECX
        MOV     ESI,EAX // ESI := TypeInfo
        MOV     CL,[EAX].TTypeInfo.Name.Byte[0]
        MOV     EDI,EDX // EDI := PropList
        XOR     EAX,EAX
        MOVZX   ECX,[ESI].TTypeInfo.Name[ECX+1].TTypeData.PropCount
        REP     STOSD   // zero-out entire property list

@outerLoop:
        MOV     CL,[ESI].TTypeInfo.Name.Byte[0]
        LEA     ESI,[ESI].TTypeInfo.Name[ECX+1]
        MOV     CL,[ESI].TTypeData.UnitName.Byte[0]
        MOVZX   EAX,[ESI].TTypeData.UnitName[ECX+1].TPropData.PropCount
        TEST    EAX,EAX
        JE      @parent
        LEA     EDI,[ESI].TTypeData.UnitName[ECX+1].TPropData.PropList

@innerLoop:

        MOVZX   EBX,[EDI].TPropInfo.NameIndex
        MOV     CL,[EDI].TPropInfo.Name.Byte[0]
        CMP     dword ptr [EDX+EBX*4],0 // check if slot already used by descendant (hoisted prop)
        JNE     @alreadySet
        MOV     [EDX+EBX*4],EDI

@alreadySet:
        LEA     EDI,[EDI].TPropInfo.Name[ECX+1]
        DEC     EAX
        JNE     @innerLoop

@parent:
        MOV     ESI,[ESI].TTypeData.ParentInfo
        XOR     ECX,ECX
        TEST    ESI,ESI
        JE      @exit
        MOV     ESI,[ESI]
        JMP     @outerLoop
@exit:
        POP     EDI
        POP     ESI
        POP     EBX

end;
{$ENDIF !PUREPASCAL}

procedure SortPropList(PropList: PPropList; PropCount: Integer);
{$IFDEF PUREPASCAL}
  function UTF8Compare(const Str1, Str2: PByte): Integer;
  var
    LStr1, LStr2: array[0..511] of WideChar;
  begin
    UTF8ToUnicode(LStr1, Length(LStr1), @Str1[1], Str1^);
    UTF8ToUnicode(LStr2, Length(LStr2), @Str2[1], Str2^);
    Result := AnsiStrIComp(LStr1, LStr2);
  end;

  function Compare(L, R: PByte): Integer;
  var
    I, Max: Integer;
  begin
    if L^ <= R^ then
      Max := L^
    else
      Max := R^;
    for I := 1 to Max do
    begin
      if (Byte(L[I]) and $80) or (Byte(R[I]) and $80) <> 0 then
        Exit(UTF8Compare(L,R));
      Result := (Byte(L[I]) and $DF) - (Byte(R[I]) and $DF);
      if Result <> 0 then Exit;
    end;
    Result := L^ - R^;
  end;

  procedure QSort(Values: PPropList; L, R: Integer);
  var
    I, J: Integer;
    pivot, temp: PPropInfo;
  begin
    if (R - L) <= 0 then
      Exit;
    repeat
      I := L;
      J := R;
      pivot := Values[L + (R - L) shr 1];
      repeat
        while Compare(@Values[I]^.Name, @pivot^.Name) < 0 do
          Inc(I);
        while Compare(@Values[J]^.Name, @pivot^.Name) > 0 do
          Dec(J);
        if I <= J then
        begin
          if I <> J then
          begin
            temp := Values[I];
            Values[I] := Values[J];
            Values[J] := temp;
          end;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then
        QSort(Values, L, J);
      L := I;
    until I >= R;
  end;
begin
  if PropCount = 0 then Exit;
  QSort(PropList, 0, PropCount-1);
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to prop list        }
        {       EDX Property count              }
        { <-    nothing                         }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     ECX,EAX
        XOR     EAX,EAX
        DEC     EDX
        CALL    @@qsort
        POP     EDI
        POP     ESI
        POP     EBX
        JMP     @@exit

@@qsort:
        PUSH    EAX
        PUSH    EDX
        LEA     EDI,[EAX+EDX]           { pivot := (left + right) div 2 }
        SHR     EDI,1
        MOV     EDI,[ECX+EDI*4]
        ADD     EDI,OFFSET TPropInfo.Name
@@repeat:                               { repeat                        }
@@while1:
        CALL    @@compare               { while a[i] < a[pivot] do inc(i);}
        JAE     @@endWhile1
        INC     EAX
        JMP     @@while1
@@endWhile1:
        XCHG    EAX,EDX
@@while2:
        CALL    @@compare               { while a[j] > a[pivot] do dec(j);}
        JBE     @@endWhile2
        DEC     EAX
        JMP     @@while2
@@endWhile2:
        XCHG    EAX,EDX
        CMP     EAX,EDX                 { if i <= j then begin          }
        JG      @@endRepeat
        MOV     EBX,[ECX+EAX*4]         { x := a[i];                    }
        MOV     ESI,[ECX+EDX*4]         { y := a[j];                    }
        MOV     [ECX+EDX*4],EBX         { a[j] := x;                    }
        MOV     [ECX+EAX*4],ESI         { a[i] := y;                    }
        INC     EAX                     { inc(i);                       }
        DEC     EDX                     { dec(j);                       }
                                        { end;                          }
        CMP     EAX,EDX                 { until i > j;                  }
        JLE     @@repeat

@@endRepeat:
        POP     ESI
        POP     EBX

        CMP     EAX,ESI
        JL      @@rightNonEmpty         { if i >= right then begin      }
        CMP     EDX,EBX
        JG      @@leftNonEmpty1         { if j <= left then exit        }
        RET

@@leftNonEmpty1:
        MOV     EAX,EBX
        JMP     @@qsort                 { qsort(left, j)                }

@@rightNonEmpty:
        CMP     EAX,EBX
        JG      @@leftNonEmpty2
        MOV     EDX,ESI                 { qsort(i, right)               }
        JMP     @@qsort
@@leftNonEmpty2:
        PUSH    EAX
        PUSH    ESI
        MOV     EAX,EBX
        CALL    @@qsort                 { qsort(left, j)                }
        POP     EDX
        POP     EAX
        JMP     @@qsort                 { qsort(i, right)               }

@@compare:
        PUSH    EAX
        PUSH    EDI
        MOV     ESI,[ECX+EAX*4]
        ADD     ESI,OFFSET TPropInfo.Name
        PUSH    ESI
        XOR     EBX,EBX
        MOV     BL,[ESI]
        INC     ESI
        CMP     BL,[EDI]
        JBE     @@firstLenSmaller
        MOV     BL,[EDI]
@@firstLenSmaller:
        INC     EDI
        TEST    BL,BL
        JE      @@endLoop
@@loop:
        MOV     AL,[ESI]
        MOV     AH,[EDI]
        TEST    EAX,$8080
        JNZ     @@CompareUTF8
        AND     EAX,$DFDF
        CMP     AL,AH
        JNE     @@difference

@@NoDiff:
        INC     ESI
        INC     EDI
        DEC     EBX
        JNZ     @@loop
@@endLoop:
        POP     ESI
        POP     EDI
        MOV     AL,[ESI]
        MOV     AH,[EDI]
        CMP     AL,AH
        POP     EAX
        RET
@@difference:
        POP     ESI
        POP     EDI
        POP     EAX
        RET

@@CompareUTF8:
        POP     ESI
        POP     EDI
        PUSH    ECX
        PUSH    EDX
        MOV     EAX,ESI
        MOV     EDX,EDI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        CALL    UTF8Compare
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     EDX
        POP     ECX
        TEST    EAX, EAX
        POP     EAX
        RET
@@exit:
end;
{$ENDIF !PUREPASCAL}

{ TypeInfo is the type info of a class. Return all properties matching
  TypeKinds in this class or its ancestors in PropList and return the count }

function GetPropList(TypeInfo: PTypeInfo; TypeKinds: TTypeKinds;
  PropList: PPropList; SortList: Boolean): Integer;
var
  I, Count: Integer;
  PropInfo: PPropInfo;
  TempList: PPropList;
begin
  Result := 0;
  Count := GetPropList(TypeInfo, TempList);
  if Count > 0 then
    try
      for I := 0 to Count - 1 do
      begin
        PropInfo := TempList^[I];
        if PropInfo^.PropType^.Kind in TypeKinds then
        begin
          if PropList <> nil then
            PropList^[Result] := PropInfo;
          Inc(Result);
        end;
      end;
      if SortList and (PropList <> nil) and (Result > 1) then
        SortPropList(PropList, Result);
    finally
      FreeMem(TempList);
    end;
end;

function GetPropList(TypeInfo: PTypeInfo; out PropList: PPropList): Integer;
begin
  Result := GetTypeData(TypeInfo)^.PropCount;
  if Result > 0 then
  begin
    GetMem(PropList, Result * SizeOf(Pointer));
    GetPropInfos(TypeInfo, PropList);
  end;
end;

function GetPropList(AObject: TObject; out PropList: PPropList): Integer;
begin
  Result := GetPropList(PTypeInfo(AObject.ClassInfo), PropList);
end;

function IsField(P: Pointer): Boolean; inline;
begin
  Result := (IntPtr(P) and PROPSLOT_MASK) = PROPSLOT_FIELD;
end;

function GetField(Instance: TObject; P: Pointer): Pointer; inline;
begin
  Result := Pointer(PByte(Instance) + (IntPtr(P) and not PROPSLOT_MASK));
end;

function GetCodePointer(Instance: TObject; P: Pointer): Pointer; inline;
begin
  if (IntPtr(P) and PROPSLOT_MASK) = PROPSLOT_VIRTUAL then // Virtual Method
    Result := PPointer(PNativeUInt(Instance)^ + (UIntPtr(P) and $FFFF))^
  else // Static method
    Result := P;
end;

type
  TPropSet<T> = class
    private
      Type
        PT = ^T;
        TGetProc = function :T of object;
        TIdxGetProc = function (Index: Integer): T of object;
        TSetProc = procedure (const Value: T) of object;
        TIdxSetProc = procedure (Index: Integer; const Value: T) of object;
    public
      class function GetProc(Instance: TObject; PropInfo: PPropInfo): T;
      class procedure SetProc(Instance: TObject; PropInfo: PPropInfo; const Value: T);
  end;

class function TPropSet<T>.GetProc(Instance: TObject; PropInfo: PPropInfo): T;
var
  M: TMethod;
begin
  if IsField(PropInfo^.GetProc) then
    Result := PT(GetField(Instance, PropInfo^.GetProc))^ // auto ref count
  else
  begin
    M.Code := GetCodePointer(Instance, PropInfo^.GetProc);
    M.Data := Instance;
    if PropInfo^.Index = Low(PropInfo^.Index) then  // no index
      Result := TGetProc(M)()
    else
      Result := TIdxGetProc(M)(PropInfo^.Index);
  end;
end;

class procedure TPropSet<T>.SetProc(Instance: TObject; PropInfo: PPropInfo; const Value: T);
var
  M: TMethod;
begin
  if IsField(PropInfo^.SetProc) then
    PT(GetField(Instance, PropInfo^.SetProc))^ := Value
  else
  begin
    M.Code := GetCodePointer(Instance, PropInfo^.SetProc);
    M.Data := Instance;
    if PropInfo^.Index = Low(PropInfo^.Index) then  // no index
      TSetProc(M)(Value)
    else
      TIdxSetProc(M)(PropInfo^.Index, Value);
  end;
end;

function IsStoredPropRTTI(Instance: TObject; PropInfo: PPropInfo): Boolean;
{$IFDEF PUREPASCAL}
type
  TStoredProc = function(Instance: TObject): Boolean;
begin
  // is constant
  if (UIntPtr(PropInfo^.StoredProc) and (not NativeUInt($FF))) = 0 then
    Exit(Boolean(UIntPtr(PropInfo^.StoredProc) and $FF));

  if IsField(PropInfo^.StoredProc) then
    Result := Boolean(PNativeInt(GetField(Instance, PropInfo^.StoredProc))^)
  else
    Result := TStoredProc(GetCodePointer(Instance, PropInfo^.StoredProc))(Instance)
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to Instance         }
        {       EDX Pointer to prop info        }
        { <-    AL  Function result             }

{$IFDEF ALIGN_STACK}
        SUB     ESP,12
{$ENDIF ALIGN_STACK}
        MOV     ECX,[EDX].TPropInfo.StoredProc
        TEST    ECX,0FFFFFF00H
        JE      @@returnCL
        CMP     [EDX].TPropInfo.StoredProc.Byte[3],0FEH
        MOV     EDX,[EDX].TPropInfo.Index
        JB      @@isStaticMethod
        JA      @@isField

        {       the StoredProc is a virtual method }
        MOVSX   ECX,CX                  { sign extend slot offs }
        ADD     ECX,[EAX]               { vmt   + slotoffs      }
        CALL    dword ptr [ECX]         { call vmt[slot]        }
        JMP     @@exit

@@isStaticMethod:
        CALL    ECX
        JMP     @@exit

@@isField:
        AND     ECX,$00FFFFFF
        MOV     CL,[EAX+ECX]

@@returnCL:
        MOV     AL,CL

@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,12
{$ENDIF ALIGN_STACK}
end;
{$ENDIF !PUREPASCAL}

function HasCustomAttribute(const Instance: TObject; const PropInfo: PPropInfo): Boolean;
var
  T: PTypeInfo;
  D: PTypeData;
  C1, C2: Word;
  P: PByte;
begin
  T := PTypeInfo(Instance.ClassInfo);

  while T <> nil do
  begin
    D := T.TypeData;
    P := AfterString(@ D.UnitName );

    C1 := PWord(P)^; Inc(P,2);// PropCount;
    while C1 > 0 do
    begin
      P := AfterString(@PPropInfo(P)^.Name);
      Dec(C1);
    end;
    C1 := PWord(P)^; Inc(P,2);// PropDataEx.PropCount
    while C1 > 0 do
    begin
      if PPropInfoEx(P)^.Info.NameFld = PropInfo.NameFld then
      begin
        P := @PPropInfoEx(P)^.AttrData; // PropDataEx.PropList[C1].AttrData
        C2 := PWord(P)^; // TAttrData.Len
        // find target property
        if C2 <> 2 then // Found CustomAttribute
          Exit (True)
        // Continue to search
      end
      else
      begin
        P := @PPropInfoEx(P)^.AttrData; // PropDataEx.PropList[C1].AttrData
        C2 := PWord(P)^; // TAttrData.Len
      end;
      Inc(P,C2);
      Dec(C1);
    end;
    if D^.ParentInfo = nil then
      Break;
    T := D^.ParentInfo^;
  end;
  Result := False;
end;

function IsStoredPropCA(Instance: TObject; PropInfo: PPropInfo): Boolean;

  function FindProperty(var t: TRttiType; const PropInfo: PPropInfo): TRttiProperty;
  var
    R: TRttiProperty;
  begin
    while t <> nil do
    begin
      for R in t.GetDeclaredProperties do
        if TRttiInstanceProperty(R).PropInfo.NameFld = PropInfo.NameFld then
          exit(R);
      t := t.BaseType;
    end;
    Result := nil;
  end;

var
  RttiType: TRttiType;

  function _FindField(const AName: String): TRttiField;
  var
    R: TRttiField;
    t: TRttiType;
  begin
    t := RttiType;
    while t <> nil do
    begin
      for R in t.GetDeclaredFields do
        if PFieldExEntry(R.Handle)^.NameFld.ToString = AName then
          exit(R);
      t := t.BaseType;
    end;
    Result := nil;
  end;

  function FindMethod(const AName: String): TRttiMethod;
  var
    R: TRttiMethod;
    t: TRttiType;
    s: string;
  begin
    t := RttiType;
    s := AName;
    while t <> nil do
    begin
      for R in t.GetDeclaredMethods do
        if R.Name = s then
          exit(R);
      t := t.BaseType;
    end;
    Result := nil;
  end;

var
  Context: TRttiContext;
  RttiField: TRttiField;
  RttiMethod: TRttiMethod;
  Attribute: TCustomAttribute;
  StoredAtri: StoredAttribute;
  StorageName: String;
  aRttiProperty: TRttiProperty;
begin
  Result := True; // Default is True.
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(Instance.ClassInfo);
    while RttiType <> nil do
    begin
      aRttiProperty := FindProperty(RttiType, PropInfo);
      if aRttiProperty <> nil then
      begin
        for Attribute in aRttiProperty.GetAttributes do
        begin
          if Attribute is StoredAttribute then
          begin
            StoredAtri := StoredAttribute(Attribute);
            if StoredAtri.Name <> '' then
            begin
              StorageName := StoredAtri.Name;
              RttiField := _FindField(StorageName);
              if RttiField <> nil then
                Result := RttiField.GetValue(Instance).AsBoolean
              else
              begin
                RttiMethod := FindMethod(StorageName);
                if RttiMethod <> nil then
                  Result := RttiMethod.Invoke(Instance, []).AsBoolean;
              end;
            end
            else
              Result := StoredAtri.Flag;
            Exit;
          end;
        end;
      end;
      if RttiType <> nil then
        RttiType := RttiType.BaseType;
    end;
  finally
    Context.Free;
  end;
end;

function IsStoredProp(Instance: TObject; PropInfo: PPropInfo): Boolean;
begin
  Result := IsStoredPropRTTI(Instance, PropInfo);
  if Result and HasCustomAttribute(Instance, PropInfo) then
    Result := IsStoredPropCA(Instance, PropInfo);
end;

function GetOrdProp(Instance: TObject; PropInfo: PPropInfo): NativeInt;
{$IFDEF PUREPASCAL}
begin
  Result := 0;
  if PropInfo^.PropType^^.Kind = tkClass then
    Result := NativeInt(TPropSet<TObject>.GetProc(Instance, PropInfo))
  else case GetTypeData(PropInfo^.PropType^)^.OrdType of
    otSByte: Result := TPropSet<ShortInt>.GetProc(Instance, PropInfo);
    otUByte: Result := TPropSet<Byte>.GetProc(Instance, PropInfo);
    otSWord: Result := TPropSet<SmallInt>.GetProc(Instance, PropInfo);
    otUWord: Result := TPropSet<Word>.GetProc(Instance, PropInfo);
    otSLong: Result := TPropSet<Integer>.GetProc(Instance, PropInfo);
    otULong: Result := NativeInt(TPropSet<Cardinal>.GetProc(Instance, PropInfo));
  end;
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        { <-    EAX Longint result              }

        PUSH    EBX
        PUSH    EDI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        MOV     EDI,[EDX].TPropInfo.PropType
        MOV     EDI,[EDI]
        MOV     BL,otSLong
        CMP     [EDI].TTypeInfo.Kind,tkClass
        JE      @@isClass
        XOR     ECX,ECX
        MOV     CL,[EDI].TTypeInfo.Name.Byte[0]
        MOV     BL,[EDI].TTypeInfo.Name[ECX+1].TTypeData.OrdType
@@isClass:
        MOV     ECX,[EDX].TPropInfo.GetProc
        CMP     [EDX].TPropInfo.GetProc.Byte[3],$FE
        MOV     EDX,[EDX].TPropInfo.Index
        JB      @@isStaticMethod
        JA      @@isField

        {       the GetProc is a virtual method }
        MOVSX   ECX,CX                  { sign extend slot offs }
        ADD     ECX,[EAX]               { vmt   + slotoffs      }
        CALL    dword ptr [ECX]         { call vmt[slot]        }
        JMP     @@final

@@isStaticMethod:
        CALL    ECX
        JMP     @@final

@@isField:
        AND     ECX,$00FFFFFF
        ADD     ECX,EAX
        MOV     AL,[ECX]
        CMP     BL,otSWord
        JB      @@final
        MOV     AX,[ECX]
        CMP     BL,otSLong
        JB      @@final
        MOV     EAX,[ECX]
@@final:
        CMP     BL,otSLong
        JAE     @@exit
        CMP     BL,otSWord
        JAE     @@word
        CMP     BL,otSByte
        MOVSX   EAX,AL
        JE      @@exit
        AND     EAX,$FF
        JMP     @@exit
@@word:
        MOVSX   EAX,AX
        JE      @@exit
        AND     EAX,$FFFF
@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     EDI
        POP     EBX
end;
{$ENDIF !PUREPASCAL}

procedure SetOrdProp(Instance: TObject; PropInfo: PPropInfo;
  Value: NativeInt);
{$IFDEF PUREPASCAL}
begin
  if PropInfo^.PropType^^.Kind = tkClass then
    TPropSet<TObject>.SetProc(Instance, PropInfo, TObject(Value))
  else case GetTypeData(PropInfo^.PropType^)^.OrdType of
    otSByte: TPropSet<ShortInt>.SetProc(Instance, PropInfo, ShortInt(Value));
    otUByte: TPropSet<Byte>.SetProc(Instance, PropInfo, Byte(Value));
    otSWord: TPropSet<SmallInt>.SetProc(Instance, PropInfo, SmallInt(Value));
    otUWord: TPropSet<Word>.SetProc(Instance, PropInfo, Word(Value));
    otSLong: TPropSet<Integer>.SetProc(Instance, PropInfo, Integer(Value));
    otULong: TPropSet<Cardinal>.SetProc(Instance, PropInfo, Cardinal(Value));
  end;
end;
{$ELSE !PUREPASCAL}
asm //StackAligned

        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Value                       }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     EDI,EDX

        MOV     ESI,[EDI].TPropInfo.PropType
        MOV     ESI,[ESI]
        MOV     BL,otSLong
        CMP     [ESI].TTypeInfo.Kind,tkClass
        JE      @@isClass
        XOR     EBX,EBX
        MOV     BL,[ESI].TTypeInfo.Name.Byte[0]
        MOV     BL,[ESI].TTypeInfo.Name[EBX+1].TTypeData.OrdType
@@isClass:
        MOV     EDX,[EDI].TPropInfo.Index       { pass Index in DX      }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX     }
@@hasIndex:
        MOV     ESI,[EDI].TPropInfo.SetProc
        CMP     [EDI].TPropInfo.SetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

        {       SetProc turned out to be a virtual method. call it      }
        MOVSX   ESI,SI                          { sign extend slot offset }
        ADD     ESI,[EAX]                       { vmt   + slot offset   }
//StackAligned
        CALL    dword ptr [ESI]
        JMP     @@exit

@@isStaticMethod:
//StackAligned
        CALL    ESI
        JMP     @@exit

@@isField:
        AND     ESI,$00FFFFFF
        ADD     EAX,ESI
        MOV     [EAX],CL
        CMP     BL,otSWord
        JB      @@exit
        MOV     [EAX],CX
        CMP     BL,otSLong
        JB      @@exit
        MOV     [EAX],ECX
@@exit:
        POP     EDI
        POP     ESI
        POP     EBX
end;
{$ENDIF !PUREPASCAL}

function GetSetElementName(TypeInfo: PTypeInfo; Value: Integer): string;
begin
  case TypeInfo^.Kind of
    tkInteger      : Result := IntToStr(Value);      // int  range, like (2..20)
    tkChar, tkWChar: Result := '#'+IntToStr(Value);  // char range, like (#2..#20)
  else
    Result := GetEnumName(TypeInfo, Value);          // enums
  end;
end;

function GetSetElementValue(TypeInfo: PTypeInfo; const Name: string): Integer;
var
  MinValue: integer;
begin
  MinValue := GetTypeData(TypeInfo).MinValue;

  case TypeInfo^.Kind of
    tkInteger      :
    begin
      Result := StrToInt(Name);
      Dec(Result, MinValue);
    end;
    tkChar, tkWChar:
    begin
      Result := StrToInt(Copy(Name,2,Length(Name)-1));
      Dec(Result, MinValue);
    end;
  else
    Result := GetEnumValue(TypeInfo, Name);
  end;
end;

function GetEnumProp(Instance: TObject; PropInfo: PPropInfo): string;
begin
  Result := GetEnumName(PropInfo^.PropType^, GetOrdProp(Instance, PropInfo));
end;

procedure SetEnumProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: string);
var
  Data: NativeInt;
begin
  Data := GetEnumValue(PropInfo^.PropType^, Value);
  if Data < 0 then
    raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyElement, [Value]);
  SetOrdProp(Instance, PropInfo, Data);
end;

function GetSetProp(Instance: TObject; PropInfo: PPropInfo;
  Brackets: Boolean): string;
begin
  Result := SetToString(PropInfo, GetOrdProp(Instance, PropInfo), Brackets);
end;

function SetToString(PropInfo: PPropInfo; Value: Integer; Brackets: Boolean): string;
begin
  Result := SetToString(PropInfo^.PropType^, Value, Brackets);
end;

function SetToString(TypeInfo: PTypeInfo; Value: Integer; Brackets: Boolean): string;
var
  S: TIntegerSet;
  I: Integer;
begin
  Result := '';
  Integer(S) := Value;
  TypeInfo := GetTypeData(TypeInfo)^.CompType^;
  for I := 0 to SizeOf(Integer) * 8 - 1 do
    if I in S then
    begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + GetEnumName(TypeInfo, I);
    end;
  if Brackets then
    Result := '[' + Result + ']';
end;

function StringToSet(PropInfo: PPropInfo; const Value: string): Integer;
begin
  Result := StringToSet(PropInfo^.PropType^, Value);
end;

function StringToSet(TypeInfo: PTypeInfo; const Value: string): Integer;
var
  P: PChar;
  EnumName: string;
  EnumValue: NativeInt;
  EnumInfo: PTypeInfo;

  // grab the next enum name
  function NextWord(var P: PChar): string;
  var
    i: Integer;
  begin
    i := 0;

    // scan til whitespace
    while not (P[i] in [',', ' ', #0,']']) do
      Inc(i);

    SetString(Result, P, i);

    // skip whitespace
    while (P[i] in [',', ' ',']']) do
      Inc(i);

    Inc(P, i);
  end;

begin
  Result := 0;
  if Value = '' then Exit;
  P := PChar(Value);

  // skip leading bracket and whitespace
  while (P^ in ['[',' ']) do
    Inc(P);

  EnumInfo := GetTypeData(TypeInfo)^.CompType^;
  EnumName := NextWord(P);
  while EnumName <> '' do
  begin
    EnumValue := GetEnumValue(EnumInfo, EnumName);
    if EnumValue < 0 then
      raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyElement, [EnumName]);
    Include(TIntegerSet(Result), EnumValue);
    EnumName := NextWord(P);
  end;
end;

procedure SetSetProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: string);
begin
  SetOrdProp(Instance, PropInfo, StringToSet(PropInfo, Value));
end;

function GetObjectProp(Instance: TObject; PropInfo: PPropInfo; MinClass: TClass): TObject;
begin
  Result := TObject(GetOrdProp(Instance, PropInfo));
  if (Result <> nil) and (MinClass <> nil) and
    not (Result is MinClass) then
    Result := nil;
end;

procedure SetObjectProp(Instance: TObject; PropInfo: PPropInfo;
  Value: TObject; ValidateClass: Boolean);
begin
  if (Value = nil) or
     (not ValidateClass) or
     (Value is GetObjectPropClass(PropInfo)) then
    SetOrdProp(Instance, PropInfo, IntPtr(Value));
end;

function GetObjectPropClass(Instance: TObject; PropInfo: PPropInfo): TClass;
begin
  Result := GetObjectPropClass(PropInfo);
end;

function GetObjectPropClass(PropInfo: PPropInfo): TClass;
var
  TypeData: PTypeData;
begin
  TypeData := GetTypeData(PropInfo^.PropType^);
  if TypeData = nil then
    raise EPropertyError.CreateRes(@SInvalidPropertyValue);
  Result := TypeData^.ClassType;
end;

{$IFNDEF NEXTGEN}
procedure GetShortStrProp(Instance: TObject; PropInfo: PPropInfo; var Value: ShortString);
{$IFDEF PUREPASCAL}
begin
  Value := TPropSet<ShortString>.GetProc(Instance, PropInfo)
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to result string    }
{       PUSH    EBP
        MOV     EBP, ESP}
        PUSH    ESI
        PUSH    EDI
        MOV     EDI,EDX

        MOV     EDX,[EDI].TPropInfo.Index       { pass index in EDX }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX }
@@hasIndex:
        MOV     ESI,[EDI].TPropInfo.GetProc
        CMP     [EDI].TPropInfo.GetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

        {       GetProc turned out to be a virtual method       }
        MOVSX   ESI,SI                          { sign extend slot offset}
        ADD     ESI,[EAX]                       { vmt + slot offset     }
        CALL    dword ptr [ESI]
        JMP     @@exit

@@isStaticMethod:
        CALL    ESI
        JMP     @@exit

@@isField:
        AND     ESI,$00FFFFFF
        MOV     EDX, EAX
        ADD     EDX, ESI
        MOV     EAX, ECX
        CALL    System.@PStrCpy

@@exit:
        POP     EDI
        POP     ESI
{       POP     EBP}
end;
{$ENDIF !PUREPASCAL}

procedure SetShortStrProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: ShortString);
{$IFDEF PUREPASCAL}
begin
  TPropSet<ShortString>.SetProc(Instance, PropInfo, Value)
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to string value     }

        PUSH    ESI
        PUSH    EDI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        MOV     ESI,EDX

        MOV     EDX,[ESI].TPropInfo.Index       { pass index in EDX }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX }
@@hasIndex:
        MOV     EDI,[ESI].TPropInfo.SetProc
        CMP     [ESI].TPropInfo.SetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

        {       SetProc is a virtual method }
        MOVSX   EDI,DI
        ADD     EDI,[EAX]
        CALL    dword ptr [EDI]
        JMP     @@exit

@@isStaticMethod:
        CALL    EDI
        JMP     @@exit

@@isField:
        AND     EDI,$00FFFFFF
        ADD     EDI,EAX
        MOV     EAX,[ESI].TPropInfo.PropType
        MOV     EAX,[EAX]
        MOV     ESI,ECX
        XOR     ECX,ECX
        MOV     CL,[EAX].TTypeInfo.Name.Byte[0]
        MOV     CL,[EAX].TTypeInfo.Name[ECX+1].TTypeData.MaxLength

        LODSB
        CMP     AL,CL
        JB      @@noTruncate
        MOV     AL,CL
@@noTruncate:
        STOSB
        MOV     CL,AL
        REP     MOVSB
@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     EDI
        POP     ESI
end;
{$ENDIF !PUREPASCAL}

procedure GetShortStrPropAsLongStr(Instance: TObject; PropInfo: PPropInfo; var Value: AnsiString);
var
  Temp: ShortString;
begin
  GetShortStrProp(Instance, PropInfo, Temp);
  Value := Temp;
end;

procedure SetShortStrPropAsLongStr(Instance: TObject; PropInfo: PPropInfo; const Value: AnsiString);
var
  Temp: ShortString;
begin
  Temp := Value;
  SetShortStrProp(Instance, PropInfo, Temp);
end;
{$ENDIF !NEXTGEN}

{$IFNDEF NEXTGEN}
procedure GetLongStrProp(Instance: TObject; PropInfo: PPropInfo; var Value: AnsiString);
{$IFDEF PUREPASCAL}
begin
  Value := TPropSet<AnsiString>.GetProc(Instance, PropInfo)
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to result string    }

        PUSH    ESI
        PUSH    EDI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        MOV     EDI,EDX

        MOV     EDX,[EDI].TPropInfo.Index       { pass index in EDX }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX }
@@hasIndex:
        MOV     ESI,[EDI].TPropInfo.GetProc
        CMP     [EDI].TPropInfo.GetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

@@isVirtualMethod:
        MOVSX   ESI,SI                          { sign extend slot offset }
        ADD     ESI,[EAX]                       { vmt + slot offset }
        CALL    DWORD PTR [ESI]
        JMP     @@exit

@@isStaticMethod:
        CALL    ESI
        JMP     @@exit

@@isField:
        AND  ESI,$00FFFFFF
        MOV  EDX,[EAX+ESI]
        MOV  EAX,ECX
        CALL  System.@LStrAsg

@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     EDI
        POP     ESI
end;
{$ENDIF !PUREPASCAL}

procedure SetLongStrProp(Instance: TObject; PropInfo: PPropInfo; const Value: AnsiString); overload;
{$IFDEF PUREPASCAL}
begin
  TPropSet<AnsiString>.SetProc(Instance, PropInfo, Value)
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to string value     }

        PUSH    ESI
        PUSH    EDI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        MOV     ESI,EDX

        MOV     EDX,[ESI].TPropInfo.Index       { pass index in EDX }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX }
@@hasIndex:
        MOV     EDI,[ESI].TPropInfo.SetProc
        CMP     [ESI].TPropInfo.SetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

@@isVirtualMethod:
        MOVSX   EDI,DI
        ADD     EDI,[EAX]
        CALL    DWORD PTR [EDI]
        JMP     @@exit

@@isStaticMethod:
        CALL    EDI
        JMP     @@exit

@@isField:
        AND  EDI,$00FFFFFF
        ADD  EAX,EDI
        MOV  EDX,ECX
        CALL  System.@LStrAsg

@@exit:
 {$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     EDI
        POP     ESI
end;
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

{$IFNDEF NEXTGEN}
procedure SetLongStrPropAsUnicodeString(Instance: TObject; PropInfo: PPropInfo;
  const Value: UnicodeString); overload;
begin
  SetLongStrProp(Instance, PropInfo, AnsiString(Value));
end;

procedure GetWideStrPropAsLongStr(Instance: TObject; PropInfo: PPropInfo; var Value: AnsiString);
begin
  Value := AnsiString(GetWideStrProp(Instance, PropInfo));
end;

procedure SetWideStrPropAsLongStr(Instance: TObject; PropInfo: PPropInfo; const Value: AnsiString);
var
  Temp: WideString;
begin
  Temp := WideString(Value);
  SetWideStrProp(Instance, PropInfo, Temp);
end;

procedure GetUnicodeStrPropAsLongStr(Instance: TObject; PropInfo: PPropInfo; var Value: AnsiString);
begin
  Value := AnsiString(GetStrProp(Instance, PropInfo));
end;

procedure SetUnicodeStrPropAsLongStr(Instance: TObject; PropInfo: PPropInfo; const Value: AnsiString);
var
  Temp: UnicodeString;
begin
  Temp := UnicodeString(Value);
  SetUnicodeStrProp(Instance, PropInfo, Temp);
end;
{$ENDIF !NEXTGEN}

function GetStrProp(Instance: TObject; PropInfo: PPropInfo): string;
begin
  case PropInfo^.PropType^.Kind of
{$IFNDEF NEXTGEN}
    tkString,
    tkLString: Result := UnicodeString(GetAnsiStrProp(Instance, PropInfo));
    tkWString: Result := GetWideStrProp(Instance, PropInfo);
{$ENDIF !NEXTGEN}
    tkUString: Result := TPropSet<String>.GetProc(Instance, PropInfo);
  else
    Result := '';
  end;
end;

{$IFNDEF NEXTGEN}
                                                                
procedure SetRawByteStrProp(Instance: TObject; PropInfo: PPropInfo; const Value: UnicodeString);
var
  Len: Integer;
  LTypeData: PTypeData;
  LString: RawByteString;
begin
  LTypeData := GetTypeData(PropInfo^.PropType^);
  if LTypeData.CodePage <> CP_ACP then
  begin
    Len := LocaleCharsFromUnicode(LTypeData.CodePage, 0, PWideChar(Value), Length(Value), nil, 0, nil, nil);
    SetLength(LString, Len);
    LocaleCharsFromUnicode(LTypeData.CodePage, 0, PWideChar(Value), Length(Value),
      PAnsiChar(LString), Len, nil, nil);
    SetCodePage(LString, LTypeData.CodePage, False);
    SetAnsiStrProp(Instance, PropInfo, LString);
  end
  else
    SetAnsiStrProp(Instance, PropInfo, AnsiString(Value));
end;
{$ENDIF !NEXTGEN}

procedure SetStrProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: string);
begin
//  SetUnicodeStrProp(Instance, PropInfo, Value);
  case PropInfo^.PropType^.Kind of
{$IFNDEF NEXTGEN}
    tkString: SetShortStrProp(Instance, PropInfo, ShortString(Value));
    tkLString: SetRawByteStrProp(Instance, PropInfo, Value);
    tkWString: SetWideStrProp(Instance, PropInfo, Value);
{$ENDIF !NEXTGEN}
    tkUString: TPropSet<UnicodeString>.SetProc(Instance, PropInfo, Value);
  end;
end;

{$IFNDEF NEXTGEN}
function GetAnsiStrProp(Instance: TObject; PropInfo: PPropInfo): AnsiString;
begin    // helper functions minimize temps in general case
  case PropInfo^.PropType^.Kind of
    tkString: GetShortStrPropAsLongStr(Instance, PropInfo, Result);
    tkLString: GetLongStrProp(Instance, PropInfo, Result);
    tkWString: GetWideStrPropAsLongStr(Instance, PropInfo, Result);
    tkUString: GetUnicodeStrPropAsLongStr(Instance, PropInfo, Result);
  else
    Result := '';
  end;
end;

procedure SetAnsiStrProp(Instance: TObject; PropInfo: PPropInfo; const Value: AnsiString);
begin    // helper functions minimize temps in general case
  case PropInfo^.PropType^.Kind of
    tkString: SetShortStrPropAsLongStr(Instance, PropInfo, Value);
    tkLString: SetLongStrProp(Instance, PropInfo, Value);
    tkWString: SetWideStrPropAsLongStr(Instance, PropInfo, Value);
    tkUString: SetUnicodeStrPropAsLongStr(Instance, PropInfo, Value);
  end;
end;

function GetWideStrProp(Instance: TObject; PropInfo: PPropInfo): WideString;
begin
  case PropInfo^.PropType^.Kind of
    tkString,
    tkLString: Result := GetStrProp(Instance, PropInfo);
    tkUString: Result := GetStrProp(Instance, PropInfo);
    tkWString: Result := TPropSet<WideString>.GetProc(Instance, PropInfo);
  else
    Result := '';
  end;
end;

procedure SetWideStrProp(Instance: TObject; PropInfo: PPropInfo; const Value: WideString); overload;
begin
  case PropInfo^.PropType^.Kind of
    tkString,
    tkLString: SetStrProp(Instance, PropInfo, Value);
    tkUString: SetUnicodeStrProp(Instance, PropInfo, Value);
    tkWString: TPropSet<WideString>.SetProc(Instance, PropInfo, Value);
  end;
end;
{$ENDIF !NEXTGEN}

function GetUnicodeStrProp(Instance: TObject; PropInfo: PPropInfo): UnicodeString;
begin
  Result := GetStrProp(Instance, PropInfo);
end;

procedure SetUnicodeStrProp(Instance: TObject; PropInfo: PPropInfo; const Value: UnicodeString);
begin
  SetStrProp(Instance, PropInfo, Value);
end;

function GetFloatProp(Instance: TObject; PropInfo: PPropInfo): Extended;
begin
  case GetTypeData(PropInfo^.PropType^).FloatType of
    ftSingle:   Result := TPropSet<Single>.GetProc(Instance, PropInfo);
    ftDouble:   Result := TPropSet<Double>.GetProc(Instance, PropInfo);
    ftExtended: Result := TPropSet<Extended>.GetProc(Instance, PropInfo);
    ftComp:     Result := TPropSet<Comp>.GetProc(Instance, PropInfo);
    ftCurr:     Result := TPropSet<Currency>.GetProc(Instance, PropInfo);
  else
    Result := 0;
  end;
end;

procedure SetFloatProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: Extended);
begin
  case GetTypeData(PropInfo^.PropType^).FloatType of
    ftSingle:   TPropSet<Single>.SetProc(Instance, PropInfo, Value);
    ftDouble:   TPropSet<Double>.SetProc(Instance, PropInfo, Value);
    ftExtended: TPropSet<Extended>.SetProc(Instance, PropInfo, Value);
    ftComp:     TPropSet<Comp>.SetProc(Instance, PropInfo, Value);
    ftCurr:     TPropSet<Currency>.SetProc(Instance, PropInfo, Value);
  end;
end;

procedure AssignVariant(var Dest: Variant; const Source: Variant);
begin
  Dest := Source;
end;

function GetVariantProp(Instance: TObject; PropInfo: PPropInfo): Variant;
{$IFDEF PUREPASCAL}
begin
  Result := TPropSet<Variant>.GetProc(Instance, PropInfo);
end;
{$ELSE !PUREPASCAL}
asm // StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to result variant   }

        PUSH    ESI
        PUSH    EDI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        MOV     EDI,EDX

        MOV     EDX,[EDI].TPropInfo.Index       { pass index in EDX }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX }
@@hasIndex:
        MOV     ESI,[EDI].TPropInfo.GetProc
        CMP     [EDI].TPropInfo.GetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

@@isVirtualMethod:
        MOVSX   ESI,SI                          { sign extend slot offset }
        ADD     ESI,[EAX]                       { vmt + slot offset }
        CALL    DWORD PTR [ESI]
        JMP     @@exit

@@isStaticMethod:
        CALL    ESI
        JMP     @@exit

@@isField:
        AND  ESI,$00FFFFFF
        LEA  EDX,[EAX+ESI]
        MOV  EAX,ECX
        CALL  AssignVariant

@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     EDI
        POP     ESI
end;
{$ENDIF !PUREPASCAL}

procedure SetVariantProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: Variant);
{$IFDEF PUREPASCAL}
begin
  TPropSet<Variant>.SetProc(Instance, PropInfo, Value);
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to variant value    }

        PUSH    ESI
        PUSH    EDI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        MOV     ESI,EDX

        MOV     EDX,[ESI].TPropInfo.Index       { pass index in EDX }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX }
@@hasIndex:
        MOV     EDI,[ESI].TPropInfo.SetProc
        CMP     [ESI].TPropInfo.SetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

@@isVirtualMethod:
        MOVSX   EDI,DI
        ADD     EDI,[EAX]
        CALL    DWORD PTR [EDI]
        JMP     @@exit

@@isStaticMethod:
        CALL    EDI
        JMP     @@exit

@@isField:
        AND  EDI,$00FFFFFF
        ADD  EAX,EDI
        MOV  EDX,ECX
        CALL  AssignVariant

@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     EDI
        POP     ESI
end;
{$ENDIF !PUREPASCAL}

type
  TProc =  procedure of object;
function GetMethodProp(Instance: TObject; PropInfo: PPropInfo): TMethod;
{$IFDEF PUREPASCAL}
begin
  Result := TMethod(TPropSet<TProc>.GetProc(Instance, PropInfo));
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to result           }

        PUSH    EBX
        PUSH    ESI
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        MOV     ESI,EDX

        MOV     EDX,[ESI].TPropInfo.Index       { pass Index in DX      }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX     }
@@hasIndex:

        MOV     EBX,[ESI].TPropInfo.GetProc
        CMP     [ESI].TPropInfo.GetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

        {       GetProc is a virtual method     }
        MOVSX   EBX,BX                          { sign extend slot number }
        ADD     EBX,[EAX]
        CALL    dword ptr [EBX]
        JMP     @@exit

@@isStaticMethod:
        CALL    EBX
        JMP     @@exit

@@isField:
        AND     EBX,$00FFFFFF
        ADD     EAX,EBX
{$IF Defined(AUTOREFCOUNT)}
        MOV     EDX,EAX
        MOV     EAX,ECX
        CALL    System.@CopyClosure
{$ELSE}
        MOV     EDX,[EAX]
        MOV     EBX,[EAX+4]
        MOV     [ECX],EDX
        MOV     [ECX+4],EBX
{$ENDIF}

@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
        POP     ESI
        POP     EBX
end;
{$ENDIF !PUREPASCAL}

procedure SetMethodProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: TMethod);
{$IFDEF PUREPASCAL}
begin
  TPropSet<TProc>.SetProc(Instance, PropInfo, TProc(Value));
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Pointer to value            }
        PUSH    EBX
        MOV     EBX,[EDX].TPropInfo.SetProc
        CMP     [EDX].TPropInfo.SetProc.Byte[3],$FE
        JA      @@isField
        MOV     EDX,[EDX].TPropInfo.Index
        PUSH    dword ptr [ECX+4]
        PUSH    dword ptr [ECX]
        JB      @@isStaticMethod

        {       SetProc is a virtual method     }
        MOVSX   EBX,BX
        ADD     EBX,[EAX]
        CALL    dword ptr [EBX]
        JMP     @@exit

@@isStaticMethod:
        CALL    EBX
        JMP     @@exit

@@isField:
        AND     EBX,$00FFFFFF
        ADD     EAX,EBX
{$IF Defined(AUTOREFCOUNT)}
        MOV     EDX,ECX
        CALL    System.@CopyClosure
{$ELSE}
        MOV     EDX,[ECX]
        MOV     EBX,[ECX+4]
        MOV     [EAX],EDX
        MOV     [EAX+4],EBX
{$ENDIF}

@@exit:
        POP     EBX
end;
{$ENDIF !PUREPASCAL}

function GetInt64Prop(Instance: TObject; PropInfo: PPropInfo): Int64;
{$IFDEF PUREPASCAL}
begin
  Result := TPropSet<Int64>.GetProc(Instance, PropInfo);
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        { <-    EDX:EAX result                  }

{$IFDEF ALIGN_STACK}
        SUB     ESP,12
{$ENDIF ALIGN_STACK}
        CMP     [EDX].TPropInfo.GetProc.Byte[3],$FE

        MOV     ECX,[EDX].TPropInfo.GetProc
        MOV     EDX,[EDX].TPropInfo.Index       { pass Index in EDX     }

        JA      @@isField
        JB      @@isStaticMethod

        {       GetProc is a virtual method     }
        MOVSX   ECX,CX                          { sign extend slot number }
        ADD     ECX,[EAX]
        CALL    dword ptr [ECX]
        JMP     @@exit

@@isStaticMethod:
        CALL    ECX
        JMP     @@exit

@@isField:
        AND     ECX,$00FFFFFF
        ADD     EAX,ECX
        MOV     EDX,[EAX].Integer[4]
        MOV     EAX,[EAX].Integer[0]

@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,12
{$ENDIF ALIGN_STACK}
end;
{$ENDIF !PUREPASCAL}

procedure SetInt64Prop(Instance: TObject; PropInfo: PPropInfo;
  const Value: Int64);
{$IFDEF PUREPASCAL}
begin
  TPropSet<Int64>.SetProc(Instance, PropInfo, Value);
end;
{$ELSE !PUREPASCAL}
asm
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       [ESP+4] Value                   }
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        CMP     [EDX].TPropInfo.SetProc.Byte[3],$FE
        MOV     ECX,[EDX].TPropInfo.SetProc
        JA      @@isField
        MOV     EDX,[EDX].TPropInfo.Index
        PUSH    Value.Integer[4]
        PUSH    Value.Integer[0]
        JB      @@isStaticMethod

        {       SetProc is a virtual method     }
        MOVSX   ECX,CX
        ADD     ECX,[EAX]
        CALL    dword ptr [ECX]
        JMP     @@exit

@@isStaticMethod:
        CALL    ECX
        JMP     @@exit

@@isField:
        AND     ECX,$00FFFFFF
        ADD     EAX,ECX
        MOV     EDX,Value.Integer[0]
        MOV     ECX,Value.Integer[4]
        MOV     [EAX].Integer[0],EDX
        MOV     [EAX].Integer[4],ECX

@@exit:
{$IFDEF ALIGN_STACK}
        ADD     ESP,4
{$ENDIF ALIGN_STACK}
end;
{$ENDIF !PUREPASCAL}

function GetInterfaceProp(Instance: TObject; const PropName: string): IInterface;
begin
  Result := GetInterfaceProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetInterfaceProp(Instance: TObject; const PropName: string;
  const Value: IInterface);
begin
  SetInterfaceProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetInterfaceProp(Instance: TObject; PropInfo: PPropInfo): IInterface;
begin
  Result := TPropSet<IInterface>.GetProc(Instance, PropInfo);
end;

procedure SetInterfaceProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: IInterface);
begin
  TPropSet<IInterface>.SetProc(Instance, PropInfo, Value);
end;

function GetDynArrayProp(Instance: TObject; const PropName: string): Pointer;
begin
  Result := GetDynArrayProp(Instance, FindPropInfo(Instance, PropName));
end;

procedure SetDynArrayProp(Instance: TObject; const PropName: string;
  const Value: Pointer);
begin
  SetDynArrayProp(Instance, FindPropInfo(Instance, PropName), Value);
end;

function GetDynArrayProp(Instance: TObject; PropInfo: PPropInfo): Pointer;
type
  { Need a(ny) dynamic array type to force correct call setup.
    (Address of result passed in EDX) }
  TDynamicArray = array of Byte;
begin
  Result := TPropSet<TDynamicArray>.GetProc(Instance, PropInfo)
end;

procedure SetDynArrayProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: Pointer);
type
  TDynArraySetProc = procedure (const Value: Pointer) of object;
  TDynArrayIndexedSetProc = procedure (Index: Integer;
                                       const Value: Pointer) of object;
var
  M: TMethod;
begin
  if IsField(PropInfo^.SetProc) then
    //Can't call System._DynArrayAsg directly, but CopyArray calls it
    CopyArray(GetField(Instance, PropInfo^.SetProc), @Value,
      PropInfo^.PropType^, 1)
  else
  begin
    M.Code := GetCodePointer(Instance, PropInfo^.SetProc);
    M.Data := Instance;
    if PropInfo^.Index = Low(PropInfo^.Index) then // no index
      TDynArraySetProc(M)(Value)
    else
      TDynArrayIndexedSetProc(M)(PropInfo^.Index, Value);

  end;
end;

function SamePropTypeName(const Name1, Name2: String): Boolean;
begin
  Result := AnsiSameText(Name1, Name2);
end;

{$IFNDEF NEXTGEN}
function SameUTF8Text(const Str1, Str2: ShortString): Boolean;
var
  LStr1, LStr2: array[0..511] of WideChar;
begin
  LStr1[UTF8ToUnicode(LStr1, Length(LStr1), PAnsiChar(@Str1[1]), Length(Str1))] := #0;
  LStr2[UTF8ToUnicode(LStr2, Length(LStr2), PAnsiChar(@Str2[1]), Length(Str2))] := #0;
  Result := AnsiStrIComp(LStr1, LStr2) = 0;
end;

function SamePropTypeName(const Name1, Name2: ShortString): Boolean;
{$IFDEF PUREPASCAL}
var
  PName1, PName2: PByte;
  I: Integer;
begin
  if Length(Name1) <> Length(Name2) then
    Exit(False);
  I := Length(Name1) div 4;
                                                                                                                 
  PName1 := PByte(@Name1[1]);
  PName2 := PByte(@Name2[1]);
  while I > 0 do
  begin
    if ((PCardinal(PName1)^ and $80808080) <> 0) or ((PCardinal(PName2)^ and $80808080) <> 0) then
      Exit(SameUTF8Text(Name1, Name2));
    if ((PCardinal(PName1)^ xor PCardinal(PName2)^) and $5F5F5F5F) <> 0 then
      Exit(False);
    Inc(PName1, 4);
    Inc(PName2, 4);
    Dec(I);
  end;
  I := Length(Name1) and 3;
  while I > 0 do
  begin
    if ((PName1^ and $80) <> 0) or ((PName1^ and $80) <> 0) then
      Exit(SameUTF8Text(Name1, Name2));
    if (PName1^ xor PName2^) and $5F <> 0 then
      Exit(False);
    Inc(PName1);
    Inc(PName2);
    Dec(I);
  end;
  Result := True;
end;
{$ELSE !PUREPASCAL}
asm //StackAligned
        { ->    EAX Name1        }
        {       EDX Name2        }
        { <-    True if Same     }
        MOV     CH,[EAX]
        MOV     CL,[EDX]
        CMP     CH,CL
        JE      @@DoCompare
        XOR     EAX,EAX
        RET

@@DoCompare:
        PUSH    EAX
        PUSH    EDX
        MOVZX   ECX,CL
        PUSH    ESI
        PUSH    EDI
        PUSH    ECX
        MOV     ESI,EAX
        MOV     EDI,EDX
        INC     ESI
        INC     EDI
        SHR     ECX,2
        JZ      @@CharLoop

@@Loop:
        MOV     EAX,[ESI]
        TEST    EAX,$80808080
        JNZ     @@Utf8Compare
        MOV     EDX,[EDI]
        TEST    EDX,$80808080
        JNZ     @@UTF8Compare
        XOR     EAX,EDX
        AND     EAX,$5F5F5F5F
        JNZ     @@NotEqual
        ADD     ESI,4
        ADD     EDI,4
        DEC     ECX
        JNZ     @@Loop

@@CharLoop:
        MOV     ECX,[ESP]
        AND     ECX,3
        JZ      @@Equal

@@Loop2:
        MOV     AL,[ESI]
        TEST    AL,$80
        JNZ     @@Utf8Compare
        MOV     DL,[EDI]
        TEST    DL,$80
        JNZ     @@Utf8Compare
        XOR     AL,DL
        AND     AL,$5F
        JNZ     @@NotEqual
        INC     ESI
        INC     EDI
        DEC     ECX
        JNZ     @@Loop2

@@Equal:
        POP     ECX
        POP     EDI
        POP     ESI
        POP     EDX
        POP     EAX
        MOV     EAX,1
        JMP     @@Exit

@@Utf8Compare:
        POP     ECX
        POP     EDI
        POP     ESI
        POP     EDX
        POP     EAX
        JMP     SameUtf8Text

@@NotEqual:
        POP     ECX
        POP     EDI
        POP     ESI
        POP     EDX
        POP     EAX
        XOR     EAX,EAX
@@Exit:
end;
{$ENDIF !PUREPASCAL}

function SamePropTypeName(const Name1: string; const Name2: ShortString): Boolean;
begin
  Result := SamePropTypeName(Name1, UTF8ToString(Name2));
end;

function SamePropTypeName(const Name1: ShortString; const Name2: string): Boolean;
begin
  Result := SamePropTypeName(UTF8ToString(Name1), Name2);
end;
{$ENDIF !NEXTGEN}

{$IF Defined(WEAKREF)}
type
  PFieldTable = ^TFieldTable;
  TFieldTable = record
    Size: Cardinal;
    Count: Cardinal;
    Fields: array [0..4095] of TManagedField;
  end;

function HasWeakRef(Info: PTypeInfo): Boolean;
var
  Data: PTypeData;
  Table: PFieldTable;
  I: Integer;
begin
  if Info <> nil then
  begin
    case Info.Kind of
      tkMethod: Exit(True);
      tkArray:
        begin
          Data := GetTypeData(Info);
          if HasWeakRef(Data.ArrayData.elType^) then
            Exit(True);
        end;
      tkRecord:
        begin
          Table := PFieldTable(GetTypeData(Info));
          if Table.Count > 0 then
            for I := 0 to Table.Count - 1 do
            begin
              if (Table.Fields[I].TypeRef = nil) or HasWeakRef(Table.Fields[I].TypeRef^) then
                Exit(True);
            end;
        end;
    end;
  end;
  Result := False;
end;
{$ENDIF}

end.
