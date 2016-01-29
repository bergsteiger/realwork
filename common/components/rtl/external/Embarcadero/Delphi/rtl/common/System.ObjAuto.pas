{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.ObjAuto;

interface

uses System.SysUtils, System.TypInfo;

{$IF Defined(CPUX86) and Defined(ASSEMBLER) and not Defined(PUREPASCAL)}
  {$DEFINE X86ASM}
{$ELSEIF Defined(CPUX64) and Defined(ASSEMBLER) and not Defined(PUREPASCAL)}
  {$DEFINE X64ASM}
{$ENDIF}

{$IF SizeOf(Extended) = 10)}
  {$DEFINE EXTENDEDIS10BYTES}
{$ELSEIF SizeOf(Extended) = 8}
  {$UNDEF EXTENDEDIS10BYTES}
{$ELSE}
  {$MESSAGE ERROR 'Unknown condition'}
{$ENDIF}

{$IFDEF CPUX86}
const
  paEAX = Word(0);
  paEDX = Word(1);
  paECX = Word(2);
  paStack = Word(3);
{$ENDIF CPUX86}

type
{$IFDEF CPUX86}
  TCallingConvention = (ccRegister, ccCdecl, ccPascal, ccStdCall, ccSafeCall) deprecated 'Use System.TypInfo.TCallConv instead.';
{$ELSE !CPUX86}
  TCallingConvention = System.TypInfo.TCallConv deprecated 'Use System.TypInfo.TCallConv instead.';
{$ENDIF !CPUX86}
  TParamFlags = System.TypInfo.TParamFlags deprecated 'Use System.TypInfo.TParamFlags instead.';
  PMethodInfoHeader = ^TMethodInfoHeader;
  TMethodInfoHeader = packed record
    Len: Word;
    Addr: Pointer;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor;
  end;
  PReturnInfo = ^TReturnInfo;
  TReturnInfo = packed record
    Version: Byte; // Must be 3
    CallingConvention: TCallingConvention;
    ReturnType: ^PTypeInfo;
    ParamSize: Word;
    ParamCount: Byte;
  end;
  PParamInfo = ^TParamInfo;
  TParamInfo = packed record
    Flags: System.TypInfo.TParamFlags;
    ParamType: ^PTypeInfo;
    Access: Word;
    Name: TSymbolName;
    function NameFld: TTypeInfoFieldAccessor;
  end;
  TMethodInfoArray = array of PMethodInfoHeader;


{$IFDEF EXTENDEDIS10BYTES}
  EObjectInvokeExtendedTypeException = class(Exception)
  protected
    FExt: Extended;
  public
    constructor Create(const Msg: string; const Ext: Extended = 0.0);
    constructor CreateFmt(const Msg: string; const Args: array of const; const Ext: Extended = 0.0);
    property Ext: Extended read FExt;
  end;

var
  RaiseExceptionForExtendedType: Boolean = True;
{$ENDIF EXTENDEDIS10BYTES}

function ObjectInvoke(Instance: TObject; MethodHeader: PMethodInfoHeader;
  const ParamIndexes: array of Integer; const Params: array of Variant): Variant;

function GetMethodInfo(Instance: TObject; const MethodName: string): PMethodInfoHeader; overload;
{$IFNDEF NEXTGEN}
function GetMethodInfo(Instance: TObject; const MethodName: ShortString): PMethodInfoHeader; overload;
  deprecated 'use String version of GetMethodInfo instead of ShortString version.'
{$ENDIF NEXTGEN}

{$IFDEF MSWINDOWS}
type
  IMethodHandler = interface
    ['{4E61C8CD-16CC-4830-B1E4-84F86FBC0D23}']
    function Execute(const Args: array of Variant): Variant;
    function InstanceToVariant(Instance: TObject): Variant;
  end;

  PParameters = ^TParameters;
  TParameters = packed record
{$IFDEF CPUX86}
    Registers: array[paEDX..paECX] of Cardinal;
    EAXRegister: Cardinal;
    ReturnAddress: Pointer;
{$ENDIF CPUX86}
    Stack: array[0..1023] of Byte;
  end;
  TDynamicInvokeEvent = procedure (Params: PParameters; StackSize: Integer) of object;

function CreateMethodPointer(const MethodHandler: IMethodHandler; TypeData: PTypeData): TMethod; overload;
function CreateMethodPointer(const ADynamicInvokeEvent: TDynamicInvokeEvent; TypeData: PTypeData): TMethod; overload;
procedure ReleaseMethodPointer(MethodPointer: TMethod);
function GetInvokeInstance(MethodPointer: TMethod): TObject;
{$ENDIF MSWINDOWS}

function GetMethods(ClassType: TClass): TMethodInfoArray;

implementation

uses
  System.Rtti,
  System.Variants, System.VarUtils, System.RTLConsts;

{ TMethodInfoHeader }

function TMethodInfoHeader.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

{ TParamInfo }

function TParamInfo.NameFld: TTypeInfoFieldAccessor;
begin
  Result.SetData(@Name);
end;

function GetTypeSize(TypeInfo: PTypeInfo): Integer;
var
  TypeData: PTypeData;
begin
  case TypeInfo^.Kind of
    tkChar:
      Result := 1;
    tkWChar:
      Result := 2;
    tkInteger, tkEnumeration:
      begin
        TypeData := GetTypeData(TypeInfo);
        if TypeData^.MinValue >= 0 then
          if Cardinal(TypeData^.MaxValue) > $FFFF then
            Result := 4
          else if TypeData^.MaxValue > $FF then
            Result := 2
          else
            Result := 1
        else
          if (TypeData^.MaxValue > $7FFF) or (TypeData^.MinValue < -$7FFF - 1) then
            Result := 4
          else if (TypeData^.MaxValue > $7F) or (TypeData^.MinValue < -$7F - 1) then
            Result := 2
          else
            Result := 1;
      end;
    tkFloat:
      begin
        TypeData := GetTypeData(TypeInfo);
        case TypeData^.FloatType of
          ftSingle: Result := 4;
          ftComp, ftCurr, ftDouble: Result := 8;
        else
          Result := -1;
        end;
      end;
    tkString, tkLString, tkUString, tkWString, tkInterface, tkClass:
      Result := SizeOf(Pointer);
    tkMethod:
      Result := SizeOf(TMethod);
    tkInt64:
      Result := 8;
    tkVariant:
                                                               
{$IFDEF CPUX64}
      Result := 24;
{$ELSE !CPUX64}
      Result := 16;
{$ENDIF !CPUX64}
    tkSet:
      begin
        Result := 4;
      end;
                               
  else
    Assert(False);
    Result := -1;
  end;
end;

type
  TConvertKind = (ckNone, ckConvert, ckError);

function ConvertKindOf(Source, Dest: TVarType): TConvertKind;
const
  none = ckNone;
  cvt = ckConvert;
  err = ckError;
  Codes: array[varEmpty..varUInt64, varEmpty..varUInt64] of TConvertKind =
    ({v From} {To >}{vt_empty} {vt_null} {vt_i2} {vt_i4} {vt_r4} {vt_r8} {vt_cy} {vt_date} {vt_bstr} {vt_dispatch} {vt_error} {vt_bool} {vt_variant} {vt_unknown} {vt_decimal} {0x0f } {vt_i1} {vt_ui1} {vt_ui2} {vt_ui4} {vt_i8} {vt_ui8}
    {vt_empty}      (none,      err,      err,    err,    err,    err,    err,    err,      err,      err,          err,       err,      none,         err,         err,         err,    err,    err,     err,     err,     err,    err),
    {vt_null}       (err,       none,     err,    err,    err,    err,    err,    err,      err,      err,          err,       err,      none,         err,         err,         err,    err,    err,     err,     err,     err,    err),
    {vt_i2}         (err,       err,      none,   cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_i4}         (err,       err,      none,   none,   cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_r4}         (err,       err,      cvt,    cvt,    none,   cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_r8}         (err,       err,      cvt,    cvt,    cvt,    none,   none,   none,     cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_cy}         (err,       err,      cvt,    cvt,    cvt,    none,   none,   none,     cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_date}       (err,       err,      cvt,    cvt,    cvt,    none,   none,   none,     cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_bstr}       (err,       err,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      none,     err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_dispatch}   (err,       err,      err,    err,    err,    err,    err,    err,      err,      none,         err,       err,      none,         none,        err,         err,    err,    err,     err,     err,     err,    err),
    {vt_error}      (err,       err,      err,    err,    err,    err,    err,    err,      err,      err,          none,      err,      none,         err,         err,         err,    err,    err,     err,     err,     err,    err),
    {vt_bool}       (err,       err,      cvt,    cvt,    err,    err,    err,    err,      cvt,      err,          err,       none,     none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_variant}    (cvt,       cvt,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      cvt,          cvt,       cvt,      none,         cvt,         cvt,         cvt,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {vt_unknown}    (err,       err,      err,    err,    err,    err,    err,    err,      err,      err,          err,       err,      none,         none,        err,         err,    err,    err,     err,     err,     err,    err),
    {vt_decimal}    (err,       err,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         none,        err,    cvt,    cvt,     cvt,     cvt,     cvt,    cvt),
    {0x0f }         (err,       err,      err,    err,    err,    err,    err,    err,      err,      err,          err,       err,      none,         err,         err,         none,   err,    err,     err,     err,     err,    err),
    {vt_i1}         (err,       err,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    cvt,     cvt,     cvt,    cvt),
    {vt_ui1}        (err,       err,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    cvt,     cvt,     cvt,    cvt),
    {vt_ui2}        (err,       err,      none,   cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    none,    cvt,     cvt,    cvt),
    {vt_ui4}        (err,       err,      none,   none,   cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    none,    none,    cvt,    cvt),
    {vt_i8}         (err,       err,      none,   none,   cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    none,    none,    none,   none),
    {vt_ui8}        (err,       err,      none,   none,   cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    none,    none,    none,   none));
begin
  if Source = Dest then
    Result := none
  else
    // < Low(Codes) always evaluates to false since it is zero
    if {(Source < Low(Codes)) or} (Source > High(Codes)) or
      {(Dest < Low(Codes)) or} (Dest > High(Codes)) then
      Result := cvt
    else
      Result := Codes[Source][Dest];
end;

function InterfaceDerivesFrom(TypeData: PTypeData; const GUID: TGUID): Boolean;
begin
  Result := True;
  while TypeData <> nil do
  begin
    if IsEqualGUID(TypeData^.Guid, GUID) then
       Exit;
    if (TypeData^.IntfParent <> nil) and (TypeData^.IntfParent^ <> nil) then
      TypeData := GetTypeData(TypeData^.IntfParent^)
    else
      Break;
  end;
  Result := False;
end;

function GetVariantType(TypeInfo: PTypeInfo): TVarType;
var
  TypeData: PTypeData;
begin
  case TypeInfo^.Kind of
    tkUnknown:  Result := varError;
                                                                                            
    tkInteger, tkChar, tkEnumeration, tkWChar:
      if (TypeInfo = System.TypeInfo(Boolean)) or
        (TypeInfo = System.TypeInfo(ByteBool)) or
        (TypeInfo = System.TypeInfo(WordBool)) or
        (TypeInfo = System.TypeInfo(LongBool)) then
        Result := varBoolean
      else
      begin
        TypeData := GetTypeData(TypeInfo);
        if TypeData^.MinValue >= 0 then
          if Cardinal(TypeData^.MaxValue) > $FFFF then
            Result := varLongWord
          else if TypeData^.MaxValue > $FF then
            Result := varWord
          else
            Result := varByte
        else
          if (TypeData^.MaxValue > $7FFF) or (TypeData^.MinValue < -$7FFF - 1) then
            Result := varInteger
          else if (TypeData^.MaxValue > $7F) or (TypeData^.MinValue < -$7F - 1) then
            Result := varSmallint
          else
            Result := varShortint;
      end;
    tkFloat:
      begin
        TypeData := GetTypeData(TypeInfo);
        case TypeData^.FloatType of
          ftSingle: Result := varSingle;
          ftDouble:
            if TypeInfo = System.TypeInfo(TDateTime) then
              Result := varDate
            else
              Result := varDouble;
          ftComp: Result := varInt64;
          ftCurr: Result := varCurrency;
        else
          Result := varError;
        end;
      end;
    tkString:   Result := varString;
    tkLString:  Result := varString;
    tkUString:  Result := varUString;
    tkWString:  Result := varOleStr;
    tkInterface:
      begin
        TypeData := GetTypeData(TypeInfo);
        if InterfaceDerivesFrom(TypeData, IDispatch) then
          Result := varDispatch
        else
          Result := varUnknown;
      end;
    tkVariant:  Result := varVariant;
    tkInt64:
      begin
        TypeData := GetTypeData(TypeInfo);
        if TypeData^.MinInt64Value >= 0 then
          Result := varUInt64
        else
          Result := varInt64;
      end;
    tkClass:    Result := varInteger;
                               
  else
    Result := varError;
  end;
end;

{$IFDEF X86ASM}
procedure GetFloatReturn(var Ret; FloatType: TFloatType);
asm
        CMP     DL, ftSingle
        JE      @@Single
        CMP     DL, ftDouble
        JE      @@Double
        CMP     DL, ftExtended
        JE      @@Extended
        CMP     DL, ftCurr
        JE      @@Curr
        CMP     DL, ftComp
        JE      @@Curr    // Same as Curr
        // should never get here
@@Single:
        FSTP      DWORD PTR [EAX]
        WAIT
        RET
@@Double:
        FSTP      QWORD PTR [EAX]
        WAIT
        RET
@@Extended:
        FSTP      TBYTE PTR [EAX]
        WAIT
        RET
@@Curr:
        FISTP     QWORD PTR [EAX]
        WAIT
end;
{$ENDIF X86ASM}

function GetMethods(ClassType: TClass): TMethodInfoArray;
var
  VMT: Pointer;
  MethodInfo: Pointer;
  Count: Integer;
  I: Integer;
begin
  Count := 0;
  VMT := ClassType;
  repeat
    MethodInfo := PPointer(PByte(VMT) + vmtMethodTable)^;
    if MethodInfo <> nil then
      Inc(Count, PWord(MethodInfo)^);
    // Find the parent VMT
    VMT := PPointer(PByte(VMT) + vmtParent)^;
    if VMT = nil then
      Break;
    VMT := PPointer(VMT)^;
  until False;
  SetLength(Result, Count);
  I := 0;
  VMT := ClassType;
  repeat
    MethodInfo := PPointer(PByte(VMT) + vmtMethodTable)^;
    if MethodInfo <> nil then
    begin
      Count := PWord(MethodInfo)^;
      Inc(PByte(MethodInfo), SizeOf(Word));
      while Count > 0 do
      begin
        Result[I] := MethodInfo;
        Inc(I);
        Inc(PByte(MethodInfo), PMethodInfoHeader(MethodInfo)^.Len);
        Dec(Count);
      end;
    end;
    // Find the parent VMT
    VMT := PPointer(PByte(VMT) + vmtParent)^;
    if VMT = nil then
      Exit;
    VMT := PPointer(VMT)^;
  until False;
end;

function GetMethodInfo(Instance: TObject; const MethodName: string): PMethodInfoHeader;
var
  VMT: Pointer;
  MethodInfo: Pointer;
  Count: Integer;
begin
  // Find the method
  VMT := PPointer(Instance)^;
  repeat
    MethodInfo := PPointer(PByte(VMT) + vmtMethodTable)^;
    if MethodInfo <> nil then
    begin
      // Scan method table for the method
      Count := PWord(MethodInfo)^;
      Inc(PByte(MethodInfo), 2);
      while Count > 0 do
      begin
        Result := MethodInfo;
        if SamePropTypeName(Result^.NameFld.ToString, MethodName) then
          Exit;
        Inc(PByte(MethodInfo), PMethodInfoHeader(MethodInfo)^.Len);
        Dec(Count);
      end;
    end;
    // Find the parent VMT
    VMT := PPointer(PByte(VMT) + vmtParent)^;
    if VMT = nil then
      Exit(nil);
    VMT := PPointer(VMT)^;
  until False;
end;

{$IFNDEF NEXTGEN}
function GetMethodInfo(Instance: TObject; const MethodName: ShortString): PMethodInfoHeader;
begin
  Result := GetMethodInfo(Instance, UTF8ToString(MethodName));
end;
{$ENDIF NEXTGEN}

{$IFDEF EXTENDEDIS10BYTES}
constructor EObjectInvokeExtendedTypeException.Create(const Msg: string; const Ext: Extended);
begin
  inherited Create(Msg);
  FExt := Ext;
end;

constructor EObjectInvokeExtendedTypeException.CreateFmt(const Msg: string; const Args: array of const; const Ext: Extended);
begin
  inherited CreateFmt(Msg, Args);
  FExt := Ext;
end;
{$ENDIF EXTENDEDIS10BYTES}

/// ObjectInvoke - function to dymically invoke a method of an object that
/// has sufficient type information.
///   Instance -      the object to invoke the method on
///   MethodHeader -  the type information for the method obtained through
///                   GetMethodInfo.
///   ParamIndexs -   the indexs of the parameters. This assumes that the
///                   indexs are 1 offset. The number of indexs do not need
///                   to match the number of parameters. The parameters left
///                   over are assumed to fill in the holes left by indexs.
///                   Param indexs are assumed to be in lexical order, not
///                   inverse lexical order like Params.
///   Params -        the parameters for the function invocation. The
///                   order of the parameters is assumed to be in inverse
///                   lexical order, last parameter first.


function ObjectInvoke(Instance: TObject; MethodHeader: PMethodInfoHeader;
  const ParamIndexes: array of Integer;
  const Params: array of Variant): Variant;
{$IF Defined(X86ASM)}
const
  MaxParams = 32;

var
  MethodName: string;

  procedure ParameterMismatch(I: Integer);
  begin
    raise Exception.CreateFmt(STypeMisMatch, [I, MethodName]);
  end;

var
  MethodInfo: Pointer;
  ReturnInfo: PReturnInfo;
  MethodAddr: Pointer;
  //InfoEnd: Pointer;
  Count: Integer;
  I, K, P: Integer;
  Param: PParamInfo;
  Regs: array[paEAX..paECX] of Cardinal;
  RetVal: Variant;
  ParamType: TVarType;
  VarType: TVarType;
  ParamVarData: PVarData;
  PushData: Pointer;
{$IFDEF PIC}
  SavedEBX: Integer;
{$ENDIF PIC}
{$IFDEF ALIGN_STACK}
  AlignBytes: Integer;
{$ENDIF ALIGN_STACK}
  ParamBytes: Integer;
  Size: Integer;
  Frame: PByte;
  ResultParam: Pointer;
  ResultPointer: Pointer;
  ParamInfos: array[0..MaxParams - 1] of PParamInfo;
  ParamData: array[0..MaxParams - 1] of Pointer;
  Pointers: array[0..MaxParams - 1] of Pointer;
  Temps: array[0..MaxParams - 1] of Variant;
  US: String;
{$IFNDEF NEXTGEN}
  S: AnsiString;
  SSReturn: ShortString;
{$ELSE  NEXTGEN}
{$ENDIF NEXTGEN}
  Ext: Extended;
begin
  // MethodInfo now points to the method we found.
  MethodInfo := MethodHeader;
  MethodAddr := MethodHeader^.Addr;
  MethodName := PMethodInfoHeader(MethodInfo).NameFld.ToString;
  MethodInfo := PMethodInfoHeader(MethodInfo).NameFld.Tail;
  ReturnInfo := MethodInfo;
  Inc(PByte(MethodInfo), SizeOf(TReturnInfo));
  if ReturnInfo.Version <> 3 then
    raise Exception.CreateFmt(SNoRTTIInfoType, [MethodName]);

  Count := ReturnInfo^.ParamCount;
  if Count >= MaxParams then
    raise Exception.CreateFmt(SMethodOver, [MethodName, MaxParams]);
  for I := 0 to Count - 1 do
  begin
    ParamInfos[I] := MethodInfo;
    MethodInfo := PParamInfo(MethodInfo).NameFld.Tail;
    // Skip attribute data
    Inc(PByte(MethodInfo), PWord(MethodInfo)^);
  end;

  if High(Params)+1 >= Count then
    raise Exception.CreateFmt(STooManyParams, [MethodName]);

  // Fill the ParamData array, converting the type as necessary, taking
  // into account any ParamIndexes supplied
  P := 0;
  FillChar(ParamData, SizeOf(ParamData), 0);
  for I := 0 to High(Params) do
  begin
    // Figure out what parameter index this parameter refers to.
    // If it is a named parameter it will have an entry in the ParamIndexs
    // array. If not, P points to the current parameter to use for unnamed
    // parameters. K is the formal parameter number.
    // This calculation assumes Self is first and any result parameters are last
    if I <= High(ParamIndexes) then
    begin
      K := ParamIndexes[I];
      if K >= Count then
        raise Exception.CreateFmt(SInvalidDispID, [I, MethodName]);
    end
    else
      K := High(Params) - P + 1;  // Add one to account for Self
    Param := ParamInfos[K];
    ParamType := GetVariantType(Param^.ParamType^);
    ParamVarData := @Params[I];
    VarType := ParamVarData^.VType;
    if Param^.Flags * [pfOut, pfVar] <> [] then
    begin
                                              
      // For pfVar, the variant must be a byref and equal to the type.
      if (VarType <> ParamType or varByRef) and (ParamType <> varVariant) then
        ParameterMismatch(I);
    end
    else
    begin
      if (ParamType = varError) and
         (Param^.ParamType^.Kind = tkFloat) and
         (Param^.ParamType^.TypeData.FloatType = ftExtended) then
      begin
        if RaiseExceptionForExtendedType then
          Raise EObjectInvokeExtendedTypeException.CreateFmt(SParamIsExtended, [I, MethodName]);
        Ext := Params[I];
        TVarData(Temps[I]).VType := varDouble; // Dummy
        Move(Ext, TVarData(Temps[I]).VBytes[0] , SizeOf(Extended));
        ParamVarData := @Temps[I];
      end
{$IFNDEF NEXTGEN}
      else if (Param^.ParamType^.Kind = tkString) then
      begin
        // Copy ShortString on AnsiString strage.
        S := AnsiString(Params[I]);
        Temps[I] := AnsiString( AnsiChar(Byte(Length(S))) + S );
        ParamVarData := @Temps[I];
      end
{$ELSE  NEXTGEN}
{$ENDIF NEXTGEN}
      else
                        
        // Convert the parameter to the right type
        case ConvertKindOf(VarType and varTypeMask, ParamType) of
          ckConvert:
            try
{$IFNDEF NEXTGEN}
              if (Param^.ParamType^.Kind = tkChar) and
                 ((VarType = varString) or (VarType = varUString)) then
              begin
                S := AnsiString(Params[I]);
                if Length(S) = 1 then
                  Temps[I] := Byte(S[low(string)])
                else
                  ParameterMismatch(I);
              end
              else
{$ELSE  NEXTGEN}
{$ENDIF NEXTGEN}
              if (Param^.ParamType^.Kind = tkWChar) and
                      ((VarType = varString) or (VarType = varUString)) then
              begin
                US := Params[I];
                if Length(US) = 1 then
                  Temps[I] := Word(US[low(string)])
                else
                  ParameterMismatch(I);
              end
              else
                Temps[I] := VarAsType(Params[I], ParamType);
              // The data bytes for sizes < 4 are dirty, that is they are not
              // guarenteed to have 0's in the high bytes. We need them to be zero'ed
              if ParamType <= CMaxArrayVarType then
                case CVarTypeToElementInfo[ParamType].Size of
                  1: TVarData(Temps[I]).VLongWord := TVarData(Temps[I]).VByte;
                  2: TVarData(Temps[I]).VLongWord := TVarData(Temps[I]).VWord;
                end;
              ParamVarData := @Temps[I];
            except
              ParameterMismatch(I);
            end;
          ckNone:
            // Convert Boolean/LongBool params to integer via hardcast to Boolean
            // ensuring that _VarToBool is called to fix a bit clearing issue.
            if (VarType = varBoolean) then
            begin
              Temps[I] := Params[I];
              TVarData(Temps[I]).VInteger := Integer(Boolean(Params[I]));
              ParamVarData := @Temps[I];
            end;
          ckError:
            ParameterMismatch(I);
        end;
    end;
    if ParamType = varVariant then
    begin
      Pointers[K] := ParamVarData;
      ParamData[K] := @Pointers[K];
    end
    else if varByRef and VarType <> 0 then
      ParamData[K] := @ParamVarData^.VPointer
    else if ParamType = varError then
      ParamData[K] := @(ParamVarData^.VBytes[0])
    else
      ParamData[K] := @ParamVarData^.VInteger;

    // Update P which is the pointer to the current non-named parameter.
    // This assumes that unnamed parameter fill in the holes left by
    // named parameters.
    while (P <= High(Params)) and (ParamData[High(Params) - P + 1] <> nil) do
      Inc(P)
  end;

  // Set up the call frame        RET EBP
  ParamBytes := ReturnInfo^.ParamSize - (4 + 4);
  asm
{$IFDEF ALIGN_STACK}
            MOV     EAX, ParamBytes
            AND     EAX, $F
            NOT     EAX
            AND     EAX, $C
            MOV     AlignBytes, EAX
            SUB     ESP, AlignBytes
{$ENDIF ALIGN_STACK}
            SUB     ESP,ParamBytes
            MOV     Frame,ESP
{$IFDEF ALIGN_STACK}
            SUB     ESP, 4
{$ENDIF ALIGN_STACK}
  end;

  Dec(PByte(Frame), 4 + 4); // Access numbers include RET and EBP

  // Push the parameters on the stack (or put them into the correct register)
  ResultParam := nil;
  for I := 0 to Count - 1 do
  begin
    Param := ParamInfos[I];
    PushData := ParamData[I];
    if PushData = nil then
      if (Param^.ParamType^.Kind = tkClass) and
         (SamePropTypeName(Param^.NameFld.ToString, 'SELF') or
          SamePropTypeName(Param^.NameFld.ToString, 'this')) then
        // Self is special. It doesn't appear in the ParamData array since it
        // is not represented in the Params array.
        PushData := @Instance
      else if pfResult in Param^.Flags then
      begin
        ResultParam := Param;
        VarClear(Result);
        TVarData(Result).VType := GetVariantType(Param^.ParamType^);
        if TVarData(Result).VType = varVariant then
        begin
          TVarData(Result).VType := varEmpty;
          ResultPointer := @Result
        end
{$IFNDEF NEXTGEN}
        else if (Param^.ParamType^.Kind = tkString) then
        begin
          ResultPointer := @SSReturn;
        end
{$ELSE  NEXTGEN}
{$ENDIF NEXTGEN}
        else if Param^.ParamType^.Kind in [tkLString, tkUString, tkWString] then
        begin
          TVarData(Result).VString := NIL;
          ResultPointer := @TVarData(Result).VString;
        end
        else
          ResultPointer := @TVarData(Result).VInteger;
        PushData := @ResultPointer;
      end
      else
                                          
        raise Exception.CreateFmt(SParamRequired, [I, MethodName]);
    if Param^.Access < Word(Ord(paStack)) then
      Regs[Param^.Access] := PCardinal(PushData)^
    else
    begin
      if [pfVar, pfOut, pfResult, pfAddress, pfReference] * Param^.Flags <> [] then
        PCardinal(@Frame[Param^.Access])^ := PCardinal(PushData)^
      else
      begin
        Size := GetTypeSize(Param^.ParamType^);
        if (Size = -1) and (Param^.ParamType^.Kind = tkFloat) and
                           (Param^.ParamType^.TypeData.FloatType = ftExtended) then
          Size := sizeof(Extended);
        case Size of
          1, 2, 4:
            PCardinal(@Frame[Param^.Access])^ := PCardinal(PushData)^;
          8:
          begin
            PCardinal(@Frame[Param^.Access])^ := PCardinal(PushData)^;
            PCardinal(@Frame[Param^.Access + 4])^ :=
              PCardinal(PByte(PushData) + 4)^;
          end;
          10:
          begin
            PCardinal(@Frame[Param^.Access    ])^ := PCardinal(      PushData     )^;
            PCardinal(@Frame[Param^.Access + 4])^ := PCardinal(PByte(PushData) + 4)^;
            PWord    (@Frame[Param^.Access + 8])^ := PWord    (PByte(PushData) + 8)^;
          end;
        else
          Move(PushData^, Frame[Param^.Access and not 3], Size);
        end;
      end;
    end;
  end;

  // Do the call
  asm
{$IFDEF PIC}
            MOV     SavedEBX, EBX
{$ENDIF PIC}
{$IFDEF ALIGN_STACK}
            ADD     ESP, 4
{$ENDIF ALIGN_STACK}
            MOV     EAX,DWORD PTR Regs[0]
            MOV     EDX,DWORD PTR Regs[4]
            MOV     ECX,DWORD PTR Regs[8]
            CALL    MethodAddr
            MOV     DWORD PTR Regs[0],EAX
            MOV     DWORD PTR Regs[4],EDX
{$IFDEF ALIGN_STACK}
            ADD     ESP, AlignBytes
{$ENDIF ALIGN_STACK}
{$IFDEF PIC}
            MOV     EBX, SavedEBX
{$ENDIF PIC}
  end;

  if ReturnInfo^.CallingConvention = ccCdecl then
  asm
            ADD     ESP,ParamBytes
  end;

                                           
  if (ResultParam = nil) and (ReturnInfo^.ReturnType <> nil) then
  begin
    // The result came back in registers. Otherwise a result pointer was used
    // and the return variant is already initialized (or it was a procedure)
    if ReturnInfo^.ReturnType^.Kind = tkFloat then
    begin
      TVarData(RetVal).VType := GetVariantType(ReturnInfo^.ReturnType^);
      if TVarData(RetVal).VType = varError then
      begin
        // ReturnType is 10bytes-Extended real type.
        GetFloatReturn(Ext, ftExtended);
        RetVal := Ext;
        if RaiseExceptionForExtendedType then
          Raise EObjectInvokeExtendedTypeException.CreateFmt(SResultIsExtended, [MethodName], Ext);
      end
      else
        GetFloatReturn(TVarData(RetVal).VDouble, GetTypeData(ReturnInfo^.ReturnType^)^.FloatType);
    end
    else if ReturnInfo^.ReturnType^.Kind = tkWChar then
      RetVal := WideChar(Word(Regs[paEAX])) // convert to WideChar
{$IFNDEF NEXTGEN}
    else if ReturnInfo^.ReturnType^.Kind = tkChar then
      RetVal := AnsiChar(Byte(Regs[paEAX]))
{$ELSE  NEXTGEN}
{$ENDIF NEXTGEN}
    else
    begin
      // For regular Boolean types, we must convert it to a boolean to
      // wipe the high order bytes; otherwise the caller may see a false
      // as true.
      TVarData(RetVal).VType := GetVariantType(ReturnInfo^.ReturnType^);
      if (TVarData(RetVal).VType = varBoolean) and
        (ReturnInfo^.ReturnType^ = System.TypeInfo(Boolean)) then
        TVarData(RetVal).VInteger := Integer(Boolean(Regs[paEAX]))
      else
        TVarData(RetVal).VInteger := Integer(Regs[paEAX]);
      PCardinal(PByte(@TVarData(RetVal).VInteger) + 4)^ := Regs[paEDX];
    end;
    Result := RetVal;
  end
{$IFNDEF NEXTGEN}
  else if (ResultParam <> nil) and (PParamInfo(ResultParam)^.ParamType^.Kind = tkString) then
    Result := AnsiString(SSReturn);
{$ELSE  NEXTGEN}
{$ENDIF NEXTGEN}
end;
{$ELSEIF Defined(X64ASM)}
{$IFOPT O+}
  {$DEFINE OPTIMIZATIONSON}
  {$O-}
{$ENDIF}
const
  MaxParams = 32;

  type
    PInvokeParamArray = ^TInvokeParamArray;
    TInvokeParamArray = array[0..0] of Int64;

    PInvokeReturnValue = ^TInvokeReturnValue;
    TInvokeReturnValue = record
      I: INT64;
      D: Double;
    end;

  procedure InvokeMethod(MethodAddr: Pointer; Params: PInvokeParamArray; NumOfParams: UInt32;
     RegUsage: UInt8; ReturnValue: PInvokeReturnValue);
  asm
  // RBP+00h : saved RBP
  // RBP+08h : Return Addr
  // RBP+10h : RCX Home
  // RCX : Caller's RBP
  // RDX : MethodAddr
  // R8  : Params
  // R9  : Number of Params
  // RBP+30h  : Register used flag:
  //  ---- --CC  00: 1st register doesn't use. 01:RCX 10:XMM0 11: RCX & XMM0
  //  ---- DD--  00: 2nd register doesn't use. 01:RDX 10:XMM1 11: RDX & XMM1
  //  --88 ----  00: 3rd register doesn't use. 01:R8  10:XMM2 11: R8  & XMM2
  //  99-- ----  00: 4th register doesn't use. 01:R9  10:XMM3 11: R9  & XMM3
  // RBP+38h  : ReturnValue
  //
          MOV     [RBP+$10], RCX
          MOV     [RBP+$18], RDX
          MOV     [RBP+$20], R8
          MOV     [RBP+$28], R9

          MOV     RAX, R9    // Number of Params
          CMP     RAX, 4
          JAE     @@ALLOCSTACK
          MOV     RAX, 4
@@ALLOCSTACK:
          INC     RAX
          AND     RAX, -2 // $FFFF FFFF FFFF FFFE
          NEG     RAX
          LEA     RSP, [RSP+RAX*8-$20]

          MOV     R11, R8   // Params
          MOV     RAX, R9    // Number of Params
          MOV     R10, [RBP+30h] // Register usage

          CMP     RAX, 0
          JZ      @Done

          TEST    R10, $01
          JZ      @@SKIP00
          MOV     RCX, [R11]
@@SKIP00: TEST    R10, $02
          JZ      @@SKIP01
          MOVSD   XMM0,[R11]
@@SKIP01: ADD     R11, $08
          DEC     RAX
          JZ      @Done

          TEST    R10, $04
          JZ      @@SKIP10
          MOV     RDX, [R11]
@@SKIP10: TEST    R10, $08
          JZ      @@SKIP11
          MOVSD   XMM1,[R11]
@@SKIP11: ADD     R11, $08
          DEC     RAX
          JZ      @Done

          TEST    R10, $10
          JZ      @@SKIP20
          MOV     R8,  [R11]
@@SKIP20: TEST    R10, $20
          JZ      @@SKIP21
          MOVSD   XMM2,[R11]
@@SKIP21: ADD     R11, $08
          DEC     RAX
          JZ      @Done

          TEST    R10, $40
          JZ      @@SKIP30
          MOV     R9,  [R11]
@@SKIP30: TEST    R10, $80
          JZ      @@SKIP31
          MOVSD   XMM3,[R11]
@@SKIP31: ADD     R11, $08
          DEC     RAX
          JZ      @Done

          PUSH    R9
          LEA     R9, [RSP + $20 + $8]
@Loop:    MOV     R10,  [R11]
          MOV     [R9], R10
          ADD     R9, 8
          ADD     R11, 8
          DEC     EAX
          JNZ     @Loop
          POP     R9
@Done:
          CALL    [RBP+$18]

          MOV     R8, [RBP+$38] // ReturnValue
          MOV     [R8].TInvokeReturnValue.I, RAX
          MOVSD   [R8].TInvokeReturnValue.D, XMM0
  end;

const
  ruReg = Word(1);
  ruXMM = Word(2);
var
  MethodName: string;

  procedure ParameterMismatch(I: Integer);
  begin
    raise Exception.CreateFmt(STypeMisMatch, [I, MethodName]);
  end;

var
  MethodInfo: Pointer;
  ReturnInfo: PReturnInfo;
  MethodAddr: Pointer;
  Count: Integer;
  I, K, P: Integer;
  Param: PParamInfo;
  ParamD: Pointer;
  RetVal: Variant;
  ParamType: TVarType;
  VarType: TVarType;
  ParamVarData: PVarData;
  ResultParam: Pointer;
  ResultPointer: Pointer;
  ParamInfos: array[0..MaxParams - 1] of PParamInfo;
  ParamData: array[0..MaxParams - 1] of Pointer;
  Pointers: array[0..MaxParams - 1] of Pointer;
  Temps: array[0..MaxParams - 1] of Variant;
  ParamArray: Array of Int64;
  NumOfParams: UInt64;
  ReturnValue: TInvokeReturnValue;
  RegUsage: Word;
  S: AnsiString;
  US: String;
{$IFNDEF NEXTGEN}
  SSReturn: ShortString;
{$ELSE  NEXTGEN}
{$ENDIF NEXTGEN}
begin
  // MethodInfo now points to the method we found.
  MethodInfo := MethodHeader;
  MethodAddr := MethodHeader^.Addr;
  MethodName := PMethodInfoHeader(MethodInfo).NameFld.ToString;
  MethodInfo := PMethodInfoHeader(MethodInfo).NameFld.Tail;
  ReturnInfo := MethodInfo;
  Inc(PByte(MethodInfo), SizeOf(TReturnInfo));
  if ReturnInfo.Version <> 3 then
    raise Exception.CreateFmt(SNoRTTIInfoType, [MethodName]);

  Count := ReturnInfo^.ParamCount;
  if Count >= MaxParams then
    raise Exception.CreateFmt(SMethodOver, [MethodName, MaxParams]);
  for I := 0 to Count - 1 do
  begin
    ParamInfos[I] := MethodInfo;
    MethodInfo := PParamInfo(MethodInfo).NameFld.Tail;
    // Skip attribute data
    Inc(PByte(MethodInfo), PWord(MethodInfo)^);
  end;

  if High(Params)+1 >= Count then
    raise Exception.CreateFmt(STooManyParams, [MethodName]);

  // Fill the ParamData array, converting the type as necessary, taking
  // into account any ParamIndexes supplied
  P := 0;
  FillChar(ParamData, SizeOf(ParamData), 0);
  for I := 0 to High(Params) do
  begin
    // Figure out what parameter index this parameter refers to.
    // If it is a named parameter it will have an entry in the ParamIndexs
    // array. If not, P points to the current parameter to use for unnamed
    // parameters. K is the formal parameter number.
    // This calculation assumes Self is first and any result parameters are last
    if I <= High(ParamIndexes) then
    begin
      K := ParamIndexes[I];
      if K >= Count then
        raise Exception.CreateFmt(SInvalidDispID, [I, MethodName]);
    end
    else
      K := High(Params) - P + 1;  // Add one to account for Self
    Param := ParamInfos[K];
    ParamType := GetVariantType(Param^.ParamType^);
    ParamVarData := @Params[I];
    VarType := ParamVarData^.VType;
    if Param^.Flags * [pfOut, pfVar] <> [] then
    begin
                                              
      // For pfVar, the variant must be a byref and equal to the type.
      if (VarType <> ParamType or varByRef) and (ParamType <> varVariant) then
        ParameterMismatch(I);
    end
    else
    begin
      if (Param^.ParamType^.Kind = tkString) then
      begin
        // Copy ShortString on AnsiString strage.
        S := AnsiString(Params[I]);
        Temps[I] := AnsiString( AnsiChar(Byte(Length(S))) + S );
        ParamVarData := @Temps[I];
      end
      else
                        
        // Convert the parameter to the right type
        case ConvertKindOf(VarType and varTypeMask, ParamType) of
          ckConvert:
            try
              if (Param^.ParamType^.Kind = tkChar) and
                 ((VarType = varString) or (VarType = varUString)) then
              begin
                S := AnsiString(Params[I]);
                if Length(S) = 1 then
                  Temps[I] := Byte(S[1])
                else
                  ParameterMismatch(I);
              end
              else if (Param^.ParamType^.Kind = tkWChar) and
                      ((VarType = varString) or (VarType = varUString)) then
              begin
                US := Params[I];
                if Length(US) = 1 then
                  Temps[I] := Word(US[1])
                else
                  ParameterMismatch(I);
              end
              else
                Temps[I] := VarAsType(Params[I], ParamType);
              // The data bytes for sizes < 4 are dirty, that is they are not
              // guarenteed to have 0's in the high bytes. We need them to be zero'ed
              if ParamType <= CMaxArrayVarType then
                case CVarTypeToElementInfo[ParamType].Size of
                  1: TVarData(Temps[I]).VLongWord := TVarData(Temps[I]).VByte;
                  2: TVarData(Temps[I]).VLongWord := TVarData(Temps[I]).VWord;
                end;
              ParamVarData := @Temps[I];
            except
              ParameterMismatch(I);
            end;
          ckNone:
            // Convert Boolean/LongBool params to integer via hardcast to Boolean
            // ensuring that _VarToBool is called to fix a bit clearing issue.
            if (VarType = varBoolean) then
            begin
              Temps[I] := Params[I];
              TVarData(Temps[I]).VInteger := Integer(Boolean(Params[I]));
              ParamVarData := @Temps[I];
            end;
          ckError:
            ParameterMismatch(I);
        end;
    end;
    if ParamType = varVariant then
    begin
      Pointers[K] := ParamVarData;
      ParamData[K] := @Pointers[K];
    end
    else if varByRef and VarType <> 0 then
      ParamData[K] := @ParamVarData^.VPointer
    else if ParamType = varError then
      ParamData[K] := @(ParamVarData^.VBytes[0])
    else
      ParamData[K] := @ParamVarData^.VInt64;

    // Update P which is the pointer to the current non-named parameter.
    // This assumes that unnamed parameter fill in the holes left by
    // named parameters.
    while (P <= High(Params)) and (ParamData[High(Params) - P + 1] <> nil) do
      Inc(P)
  end;

  // Set the parameters to ParamArray
  ResultParam := nil;

  SetLength(ParamArray, Count);
  NumOfParams := Count;
  RegUsage := $0;

  I := Count - 1;
  Param := ParamInfos[I];
  if pfResult in Param^.Flags then
  begin
    Param := ParamInfos[0];
    if (Param^.ParamType^.Kind = tkClass) and
      (SamePropTypeName(Param^.NameFld.ToString, 'SELF') or
      SamePropTypeName(Param^.NameFld.ToString, 'this')) then
    begin
      K := 1;
    end
    else
      K := 0;
    if I > K then
    begin
      Param := ParamInfos[I];
      ParamD := ParamData[I];
      for I := Count - 2 downto K do
      begin
        ParamInfos[I+1] := ParamInfos[I];
        ParamData[I+1] := ParamData[I];
      end;
      ParamInfos[K] := Param;
      ParamData[K] := ParamD;
    end;
  end;

  for I := 0 to Count - 1 do
  begin
    Param := ParamInfos[I];
    if ParamData[I] = nil then
    begin
      if (Param^.ParamType^.Kind = tkClass) and
         (SamePropTypeName(Param^.NameFld.ToString, 'SELF') or
          SamePropTypeName(Param^.NameFld.ToString, 'this')) then
        // Self is special. It doesn't appear in the ParamData array since it
        // is not represented in the Params array.
        ParamArray[I] := Int64(Instance)
      else if pfResult in Param^.Flags then
      begin
        ResultParam := Param;
        VarClear(Result);
        TVarData(Result).VType := GetVariantType(Param^.ParamType^);
        if TVarData(Result).VType = varVariant then
        begin
          TVarData(Result).VType := varEmpty;
          ResultPointer := @Result
        end
        else if (Param^.ParamType^.Kind = tkString) then
        begin
          ResultPointer := @SSReturn;
        end
        else if Param^.ParamType^.Kind in [tkLString, tkUString, tkWString] then
        begin
          TVarData(Result).VString := NIL;
          ResultPointer := @TVarData(Result).VString;
        end
        else
          ResultPointer := @TVarData(Result).VInteger;
        ParamArray[I] := Int64(ResultPointer);
      end
      else
                                          
        raise Exception.CreateFmt(SParamRequired, [I, MethodName]);
    end
    else
      ParamArray[I] := PInt64(ParamData[I])^;

    if I < 4 then
    begin
      if ([pfVar, pfOut, pfResult, pfAddress, pfReference] * Param^.Flags = [])
          and (Param^.ParamType^.Kind = tkFloat)
          and not ( GetVariantType(Param^.ParamType^) in [varCurrency, varInt64]) then
        RegUsage := RegUsage or (ruXMM shl (I*2))
      else
        RegUsage := RegUsage or (ruReg shl (I*2));
    end;
  end;

  InvokeMethod(MethodAddr, @ParamArray[0], NumOfParams, RegUsage, @ReturnValue);

  if (ResultParam = nil) and (ReturnInfo^.ReturnType <> nil) then
  begin
    // The result came back in registers. Otherwise a result pointer was used
    // and the return variant is already initialized (or it was a procedure)
    TVarData(RetVal).VType := GetVariantType(ReturnInfo^.ReturnType^);
    if ReturnInfo^.ReturnType^.Kind = tkFloat then
    begin
      if TVarData(RetVal).VType = varCurrency then
        TVarData(RetVal).VInt64 := ReturnValue.I
      else
        TVarData(RetVal).VDouble := ReturnValue.D
    end
    else if ReturnInfo^.ReturnType^.Kind = tkWChar then
      RetVal := WideChar(Word(ReturnValue.I)) // convert to WideChar
    else if ReturnInfo^.ReturnType^.Kind = tkChar then
      RetVal := AnsiChar(Byte(ReturnValue.I))
    else
    begin
      // For regular Boolean types, we must convert it to a boolean to
      // wipe the high order bytes; otherwise the caller may see a false
      // as true.
      if (TVarData(RetVal).VType = varBoolean) and
        (ReturnInfo^.ReturnType^ = System.TypeInfo(Boolean)) then
        TVarData(RetVal).VInteger := Integer(Boolean(ReturnValue.I))
      else
        TVarData(RetVal).VInt64 := ReturnValue.I;
    end;
    Result := RetVal;
  end
  else if (ResultParam <> nil) and (PParamInfo(ResultParam)^.ParamType^.Kind = tkString) then
  begin
    Result := AnsiString(SSReturn);
  end;
end; // of X64ASM implementation
{$IFDEF OPTIMIZATIONSON}
  {$UNDEF OPTIMIZATIONSON}
  {$O+}
{$ENDIF}
//{$ELSEIF Defined(CPUARM)}
{$ELSE }
const
  MaxParams = 32;

var
  MethodName: string;

  procedure ParameterMismatch(I: Integer);
  begin
    raise Exception.CreateFmt(STypeMisMatch, [I, MethodName]);
  end;

var
  MethodInfo: Pointer;
  ReturnInfo: PReturnInfo;
  MethodAddr: Pointer;
  ParamCount,
  ArgCount: Integer;
  I, K: Integer;
  ParamInfos: TArray<PParamInfo>;
  Args: TArray<TValue>;
  AResultType: PTypeInfo;
  AResult: TValue;
  VarType: TVarType;
  ParamVarData: PVarData;
{$IFNDEF NEXTGEN}
  S: AnsiString;
{$ENDIF NEXTGEN}
  US: String;
  Ext: Extended;
  Cu: Currency;
begin
  // MethodInfo now points to the method we found.
  MethodInfo := MethodHeader;
  MethodAddr := MethodHeader^.Addr;
  MethodName := PMethodInfoHeader(MethodInfo).NameFld.ToString;
  MethodInfo := PMethodInfoHeader(MethodInfo).NameFld.Tail;
  ReturnInfo := MethodInfo;
  Inc(PByte(MethodInfo), SizeOf(TReturnInfo));
  if ReturnInfo.Version <> 3 then
    raise Exception.CreateFmt(SNoRTTIInfoType, [MethodName]);

  ParamCount := ReturnInfo^.ParamCount;
  ArgCount := ParamCount;
  if ParamCount >= MaxParams then
    raise Exception.CreateFmt(SMethodOver, [MethodName, MaxParams]);

  SetLength(ParamInfos, ParamCount);
  AResultType := nil;
  if ReturnInfo^.ReturnType <> nil then
    AResultType := ReturnInfo^.ReturnType^;
  for I := 0 to ParamCount - 1 do
  begin
    ParamInfos[I] := PParamInfo(MethodInfo);
    if pfResult in ParamInfos[I].Flags then
    begin
      Dec(ArgCount);
      AResultType := ParamInfos[I].ParamType^;
    end;

    MethodInfo := PParamInfo(MethodInfo).NameFld.Tail;
    // Skip attribute data
    Inc(PByte(MethodInfo), PWord(MethodInfo)^);
  end;
  if High(Params)+1+1 > ArgCount then
    raise Exception.CreateFmt(STooManyParams, [MethodName]);
  if High(Params)+1 >= ParamCount then
    raise Exception.CreateFmt(STooManyParams, [MethodName]);

  SetLength(Args, ArgCount);

{$IF Defined(CPUX86) or Defined(CPUX64)}
  if ReturnInfo^.CallingConvention = ccPascal then
    Args[High(Params)+1] := Instance
  else
{$ENDIF}  
    Args[0] := Instance;

  for I := 0 to High(Params) do
  begin
    // Figure out what parameter index this parameter refers to.
    // If it is a named parameter it will have an entry in the ParamIndexs
    // array. If not, P points to the current parameter to use for unnamed
    // parameters. K is the formal parameter number.
    // This calculation assumes Self is first and any result parameters are last
    if I <= High(ParamIndexes) then
    begin
      K := ParamIndexes[I];
      if K - 1 > High(Params) then
        raise Exception.CreateFmt(SInvalidDispID, [I, MethodName]);
    end
    else
    begin
      K := High(Args);
      while (K >= 0) and (Not Args[K].IsEmpty) do
        Dec(K);
    end;
{$IF Defined(CPUX86) or Defined(CPUX64)}
    if ReturnInfo^.CallingConvention = ccPascal then
      Dec(K);
{$ENDIF}  

    ParamVarData := @Params[I];
    VarType := ParamVarData^.VType;

    if pfResult in ParamInfos[I+1].Flags then
      Assert(false)
    else if varByRef and VarType <> 0 then
      Args[K] := TValue.From<Pointer>(ParamVarData^.VPointer)
    else
    begin
      case ParamInfos[K].ParamType^.kind of
        tkFloat:
          begin
            case ParamInfos[K].ParamType^.TypeData.FloatType of
              ftSingle: Args[K] := TValue.From<Single>( Params[I] );
              ftDouble: Args[K] := TValue.From<Double>( Params[I] );
              ftExtended:
                begin
{$IFDEF EXTENDEDIS10BYTES}
                  if RaiseExceptionForExtendedType then
                    Raise EObjectInvokeExtendedTypeException.CreateFmt(SParamIsExtended, [I, MethodName]);
{$ENDIF EXTENDEDIS10BYTES}
                  Args[K] := TValue.From<Extended>( Params[I] );
                end;
              ftComp:
                Args[K] := TValue.From<int64>( TVarData(Params[I]).VInt64 );
              ftCurr:
                begin
                  Cu := Params[I];
                  TValue.Make(@Cu, TypeInfo(Currency), Args[K]);
                end;
            end;
          end;
        tkVariant:
          TValue.Make(@Params[I], ParamInfos[K].ParamType^, Args[K]);
{$IFNDEF NEXTGEN}
        tkChar:
          begin
            if (TVarData(Params[I]).VType = varString) or
               (TVarData(Params[I]).VType = varUString) then
            begin
              S := Params[I];
              if Length(S) = 1 then
                Args[K] := TValue.From<AnsiChar>(S[low(string)])
              else
                ParameterMismatch(I);
            end
            else
              Args[K] := TValue.From<Byte>( Params[I] );
          end
        tkString:
          begin
            S := Params[I];
            Args[K] := TValue.From<AnsiString>( AnsiChar(Byte(Length(S))) + S );
          end;
        tkLString:
          Args[K] := TValue.From<AnsiString>( Params[I] );
{$ENDIF NEXTGEN}
        tkWChar:
          begin
            if (TVarData(Params[I]).VType = varString) or
               (TVarData(Params[I]).VType = varUString) then
            begin
              US := Params[I];
              if Length(US) = 1 then
                Args[K] := TValue.From<WideChar>(US[low(string)])
              else
                ParameterMismatch(I);
            end
            else
              Args[K] := TValue.From<Word>( Params[I] );
          end;
        tkUString:
          Args[K] := TValue.From<string>( Params[I] );
        tkInt64:
          Args[K] := TValue.FromOrdinal( ParamInfos[K].ParamType^, Params[I] );
        tkInteger:
          Args[K] := TValue.From<Int32>( TVarData(Params[I]).VInteger );
      else
        Args[K] := TValue.FromVariant(Params[I]);
      end;
    end;
  end;

  AResult := System.Rtti.Invoke(MethodAddr, Args, TCallConv(ReturnInfo^.CallingConvention), AResultType, False, False);

  if AResultType = nil then
    Result := System.Variants.Null
  else
  begin
    case AResultType.Kind of
      tkEnumeration:
        begin
          TVarData(Result).VType := GetVariantType(AResultType);
          if (TVarData(Result).VType = varBoolean) and
            (ReturnInfo^.ReturnType^ = System.TypeInfo(Boolean)) then
              Result := AResult.AsBoolean
          else
            TVarData(Result).VInt64 := AResult.AsOrdinal;
        end;
      tkInteger,
      tkPointer:
        begin
          // all 32bit unmanaged data are just copied.
          TVarData(Result).VType := GetVariantType(AResultType);
          TVarData(Result).VInteger := AResult.AsInteger;
        end;
      tkInt64:
        begin
          // 64bit unmanaged data is also just copied.
          TVarData(Result).VType := GetVariantType(AResultType);
          TVarData(Result).VInt64 := AResult.AsInt64;
        end;
      tkFloat:
        begin
          TVarData(Result).VType := GetVariantType(AResultType);
          if (AResultType.Kind = tkFloat) and (AResultType.TypeData.FloatType = ftExtended) then
          begin
            // ReturnType is 10bytes-Extended real type.
            Ext := AResult.AsExtended;
            Result := Ext;
{$IFDEF EXTENDEDIS10BYTES}
            if RaiseExceptionForExtendedType then
              Raise EObjectInvokeExtendedTypeException.CreateFmt(SResultIsExtended, [MethodName], Ext);
{$ENDIF EXTENDEDIS10BYTES}
          end
          else
            Result := AResult.AsVariant;
        end;
      else
        Result := AResult.AsVariant;
    end;
  end;
end;
{$ELSE OTHERCPU}
{$MESSAGE Fatal 'Missing ObjectInvoke implementation'}
{$ENDIF OTHERCPU}

{$IFDEF MSWINDOWS}
type
  PParameterInfos = ^TParameterInfos;
  TParameterInfos = array[0..255] of ^PTypeInfo;

  TBaseMethodHandlerInstance = class
  protected
    TypeData: PTypeData;
    ParamInfos: PParameterInfos;
    ParamOffsets: array of Word;
    StackSize: Integer;
{$IFDEF CPUX64}
    RegisterFlag: Word; // If bit is set, XMM is used. LSB is RCX.
{$ENDIF CPUX64}
    procedure InternalHandler(Params: Pointer);
    procedure Handler(Params: Pointer); virtual; abstract;
    procedure RegisterStub;
  public
    constructor Create(TypeData: PTypeData);
  end;

  TMethodHandlerInstance = class(TBaseMethodHandlerInstance)
  protected
    MethodHandler: IMethodHandler;
{$IFDEF CPUX64}
    function InternalHandler(Params: Pointer): NativeUInt;
{$ENDIF CPUX64}
    procedure Handler(Params: Pointer); override;
  public
    constructor Create(const MethodHandler: IMethodHandler; TypeData: PTypeData);
  end;

  TEventHandlerInstance = class(TBaseMethodHandlerInstance)
  protected
    FDynamicInvokeEvent: TDynamicInvokeEvent;
    procedure Handler(Params: Pointer); override;
  public
    constructor Create(const ADynamicInvokeEvent: TDynamicInvokeEvent; TypeData: PTypeData);
  end;

function AdditionalInfoOf(TypeData: PTypeData): Pointer;
var
  P: PByte;
  I: Integer;
begin
  P := @TypeData^.ParamList;
  // Skip parameter names and types
  for I := 1 to TypeData^.ParamCount do
  begin
    Inc(P, 1 + P[1] + 1);
    Inc(P, P[0] + 1 );
  end;
  if TypeData^.MethodKind = mkFunction then
    // Skip return type name and info
    Inc(P, P[0] + 1 + 4);
  Result := P;
end;

function CreateMethodPointer(const MethodHandler: IMethodHandler; TypeData: PTypeData): TMethod;
begin
  TObject(Result.Data) := TMethodHandlerInstance.Create(MethodHandler, TypeData);
  Result.Code := @TMethodHandlerInstance.RegisterStub;
end;

function CreateMethodPointer(const ADynamicInvokeEvent: TDynamicInvokeEvent; TypeData: PTypeData): TMethod; overload;
begin
  TObject(Result.Data) := TEventHandlerInstance.Create(ADynamicInvokeEvent, TypeData);
  Result.Code := @TMethodHandlerInstance.RegisterStub;
end;

procedure ReleaseMethodPointer(MethodPointer: TMethod);
begin
  TObject(MethodPointer.Data).Free;
end;

function GetInvokeInstance(MethodPointer: TMethod): TObject;
begin
  if TObject(MethodPointer.Data) is TEventHandlerInstance then
    Result := TObject(TMethod(TEventHandlerInstance(MethodPointer.Data).FDynamicInvokeEvent).Data)
  else
    Result := nil;
end;

{ TBaseMethodHandlerInstance }

constructor TBaseMethodHandlerInstance.Create(TypeData: PTypeData);
{$IF Defined(CPUX86)} // No ASM blocks in here
var
  P: PByte;
  Offset: Integer;
  CurReg: Integer;
  I: Integer;
  Size: Integer;
begin
  Self.TypeData := TypeData;

  P := AdditionalInfoOf(TypeData);
  ParamInfos := PParameterInfos(Cardinal(P) + 1);

  // Calculate stack size
  CurReg := paEDX;
  P := @TypeData^.ParamList;
  StackSize := 0;
  for I := 0 to TypeData^.ParamCount - 1 do
  begin
    if TParamFlags(P[0]) * [pfVar, pfConst, pfAddress, pfReference, pfOut] <> [] then
      Size := 4
    else
      Size := GetTypeSize(ParamInfos^[I]^);
    if (Size <= 4) and (CurReg <= paECX) then
      Inc(CurReg)
    else
    begin
      if Size < 4 then
        Size := 4;
      Inc(StackSize, Size);
    end;
    Inc(P, 1 + P[1] + 1);
    Inc(P, P[0] + 1);
  end;

  // Calculate parameter offsets
  SetLength(ParamOffsets, TypeData^.ParamCount);
  CurReg := paEDX;
  P := @TypeData^.ParamList;
  Offset := StackSize;
  for I := 0 to TypeData^.ParamCount - 1 do
  begin
    if TParamFlags(P[0]) * [pfVar, pfConst, pfAddress, pfReference, pfOut] <> [] then
      Size := 4
    else
      Size := GetTypeSize(ParamInfos^[I]^);
    if (Size <= 4) and (CurReg <= paECX) then
    begin
      ParamOffsets[I] := CurReg;
      Inc(CurReg);
    end
    else
    begin
      Dec(Offset, Size);
      ParamOffsets[I] := Offset;
    end;
    Inc(P, 1 + P[1] + 1);
    Inc(P, P[0] + 1);
  end;
end; // of CPUX86 implementation
{$ELSEIF Defined(CPUX64)}
var
  P: PByte;
  Offset: Integer;
  I: Integer;
begin
  Self.TypeData := TypeData;

  P := AdditionalInfoOf(TypeData);
  ParamInfos := PParameterInfos(Cardinal(P) + 1);

  RegisterFlag := $00; // GPRs are default
  // Calculate stack size

  P := @TypeData^.ParamList;
  StackSize := 8;
  for I := 0 to TypeData^.ParamCount - 1 do
  begin
    if I < 3 then
    begin
      if (TParamFlags(P[0]) * [pfVar, pfConst, pfAddress, pfReference, pfOut] = [])
          and (ParamInfos^[I]^.Kind = tkFloat) then
        RegisterFlag := RegisterFlag or (1 shl (I+1));
    end;
    StackSize := StackSize + 8;
    Inc(P, 1 + P[1] + 1);
    Inc(P, P[0] + 1);
  end;
  if StackSize < 32 then
    StackSize := 32;

  // Calculate parameter offsets
  SetLength(ParamOffsets, TypeData^.ParamCount);
  P := @TypeData^.ParamList;
  Offset := 0;
  for I := 0 to TypeData^.ParamCount - 1 do
  begin
    Inc(Offset, 8);
    ParamOffsets[I] := Offset;
    Inc(P, 1 + P[1] + 1);
    Inc(P, P[0] + 1);
  end;
end; // of CPUX64 implementaiton
{$ELSEIF Defined(CPUARM)}
begin
                                                                                
end;
{$ELSE OTHERCPU}
{$MESSAGE Fatal 'Missing ObjectInvoke implementation'}
{$ENDIF OTHERCPU}

                                                                                                                
procedure TBaseMethodHandlerInstance.InternalHandler(Params: Pointer);
{$IF Defined(X86ASM)}
asm
        MOV     ECX,[EAX]
        JMP     DWORD PTR [ECX] + VMTOFFSET TMethodHandlerInstance.Handler
end;
{$ELSEIF Defined(X64ASM)}
asm
        MOV     EAX,[EAX]
        JMP     QWORD PTR [EAX] + VMTOFFSET TMethodHandlerInstance.Handler
end;
{$ELSEIF Defined(CPUARM)}
begin
                                                                                         
end;
{$ELSE OTHERCPU}
{$MESSAGE Fatal 'Missing implementation'}
{$ENDIF OTHERCPU}

                                                                                            
procedure TBaseMethodHandlerInstance.RegisterStub;
{$IF Defined(X86ASM)}
const
  PtrSize = SizeOf(Pointer);
asm
        PUSH    EAX
        PUSH    ECX
        PUSH    EDX
        MOV     EDX,ESP
        CALL    InternalHandler
        // Pop EDX and ECX off the stack while preserving all registers.
        MOV     [ESP+4],EAX
        POP     EAX
        POP     EAX
        POP     ECX             // Self
        MOV     ECX,[ECX].TBaseMethodHandlerInstance.StackSize

        TEST    ECX,ECX
        JZ      @@SimpleRet
        // Jump to the actual return instruction since it is most likely not just a RET
        //JMP     ECX    // Data Exec. Prevention: Jumping into a GetMem allocated memory block

        // stack address alignment
        ADD     ECX, PtrSize - 1
        AND     ECX, NOT (PtrSize - 1)
        AND     ECX, $FFFF

        // clean up the stack
        PUSH    EAX                         // we need this register, so save it
        MOV     EAX,[ESP + 4]               // Load the return address
        MOV     [ESP + ECX + 4], EAX        // Just blast it over the first param on the stack
        POP     EAX
        ADD     ESP,ECX                     // This will move the stack back to where the moved
                                            // return address is now located. The next RET
                                            // instruction will do the final stack cleanup
@@SimpleRet:
end;
{$ELSEIF Defined(X64ASM)}
asm
        MOV     AX, WORD PTR [RCX].TBaseMethodHandlerInstance.RegisterFlag
@@FIRST:
        TEST    AX, $01
        JZ      @@SAVE_RCX
@@SAVE_XMM0:
        MOVSD   QWORD PTR [RSP+$08], XMM0
        JMP     @@SECOND
@@SAVE_RCX:
        MOV     QWORD PTR [RSP+$08], RCX

@@SECOND:
        TEST    AX, $02
        JZ      @@SAVE_RDX
@@SAVE_XMM1:
        MOVSD   QWORD PTR [RSP+$10], XMM1
        JMP     @@THIRD
@@SAVE_RDX:
        MOV     QWORD PTR [RSP+$10], RDX

@@THIRD:
        TEST    AX, $04
        JZ      @@SAVE_R8
@@SAVE_XMM2:
        MOVSD   QWORD PTR [RSP+$18], XMM2
        JMP     @@FORTH
@@SAVE_R8:
        MOV     QWORD PTR [RSP+$18], R8

@@FORTH:
        TEST    AX, $08
        JZ      @@SAVE_R9
@@SAVE_XMM3:
        MOVSD   QWORD PTR [RSP+$20], XMM3
        JMP     @@1
@@SAVE_R9:
        MOV     QWORD PTR [RSP+$20], R9

@@1:    LEA     RDX, QWORD PTR [RSP+$08]
        MOV     RAX, RCX
        SUB     RSP, $28
        CALL    InternalHandler
        ADD     RSP, $28
end;
{$ELSEIF Defined(CPUARM)}
begin
                                                                                      
end;
{$ELSE OTHERCPU}
{$MESSAGE Fatal 'Missing implementation'}
{$ENDIF OTHERCPU}

{ TMethodHandlerInstance }

constructor TMethodHandlerInstance.Create(const MethodHandler: IMethodHandler;
  TypeData: PTypeData);
begin
  inherited Create(TypeData);
  Self.MethodHandler := MethodHandler;
end;

{$IF Defined(X86ASM)}
procedure TMethodHandlerInstance.Handler(Params: Pointer);
const
  MaxParams = 10;
var
  P: PByte;
  Parameters: PParameters;
  ReturnValue: Variant;
  ParamValues: array[0..MaxParams - 1] of Variant;
  I: Integer;
  Regs: array[paEAX..paEDX] of Cardinal;
  Offset: Integer;
  Data: Pointer;
  Temp: Variant;
begin
  Parameters := Params;

  // Fetch the parameters into ParamValues
  P := @TypeData^.ParamList;
  for I := 0 to TypeData^.ParamCount - 1 do
  begin
    Offset := ParamOffsets[I];
    if (Offset >= paEDX) and (Offset <= paECX) then
      Data := @Parameters^.Registers[Offset]
    else
      Data := @Parameters^.Stack[Offset];
    if ParamInfos^[I]^.Kind = tkClass then
      ParamValues[TypeData^.ParamCount - I - 1] := MethodHandler.InstanceToVariant(TObject(PPointer(Data)^))
    else if TParamFlags(P[0]) * [pfVar, pfOut] <> [] then
      with TVarData(ParamValues[TypeData^.ParamCount - I - 1]) do
      begin
        VType := GetVariantType(ParamInfos[I]^) or varByRef;
        VPointer := Pointer(PCardinal(Data)^);
      end
    else
    begin
      TVarData(Temp).VType := GetVariantType(ParamInfos[I]^) or varByRef;
      if TParamFlags(P[0]) * [pfVar, pfOut] <> [] then
        TVarData(Temp).VPointer := Pointer(PCardinal(Data)^)
      else
        TVarData(Temp).VPointer := Data;
      ParamValues[TypeData^.ParamCount - I - 1] := Temp;
    end;
    Inc(P, 1 + P[1] + 1);
    Inc(P, P[0] + 1);
  end;
  // P is left pointing to the return type name if there is one.

  ReturnValue := MethodHandler.Execute(Slice(ParamValues, TypeData^.ParamCount));
  if TypeData^.MethodKind = mkFunction then
  begin
    Inc(P, P[0] + 1);
    ReturnValue := VarAsType(ReturnValue, GetVariantType(PPTypeInfo(P)^));
    if PPTypeInfo(P)^.Kind = tkFloat then
                                            
    else
    begin
      Regs[paEAX] := TVarData(ReturnValue).VLongWord;
      Regs[paEDX] := PCardinal(PByte(@TVarData(ReturnValue).VLongWord) + 4)^;
    end;
  end;

                                                          
  // Let Stub procedures know where the RET instruction is
  asm
        MOV     EAX,DWORD PTR Regs[paEAX*4]
        MOV     EDX,DWORD PTR Regs[paEDX*4]
  end;
end; // of X86ASM implementation
{$ELSEIF Defined(X64ASM)}
function TMethodHandlerInstance.InternalHandler(Params: Pointer): NativeUInt;
const
  MaxParams = 10;
var
  P: PByte;
  Parameters: PParameters;
  ReturnValue: Variant;
  ParamValues: array[0..MaxParams - 1] of Variant;
  I: Integer;
  Offset: Integer;
  Data: Pointer;
  Temp: Variant;
begin
  Parameters := Params;

  // Fetch the parameters into ParamValues
  P := @TypeData^.ParamList;
  for I := 0 to TypeData^.ParamCount - 1 do
  begin
    Offset := ParamOffsets[I];
    Data := @Parameters^.Stack[Offset];
    if ParamInfos^[I]^.Kind = tkClass then
      ParamValues[TypeData^.ParamCount - I - 1] := MethodHandler.InstanceToVariant(PPointer(Data)^)
    else if TParamFlags(P[0]) * [pfVar, pfOut] <> [] then
      with TVarData(ParamValues[TypeData^.ParamCount - I - 1]) do
      begin
        VType := GetVariantType(ParamInfos[I]^) or varByRef;
        VPointer := Pointer(PNativeUInt(Data)^);
      end
    else
    begin
      TVarData(Temp).VType := GetVariantType(ParamInfos[I]^) or varByRef;
      if TParamFlags(P[0]) * [pfVar, pfOut] <> [] then
        TVarData(Temp).VPointer := Pointer(PNativeUInt(Data)^)
      else
        TVarData(Temp).VPointer := Data;
      ParamValues[TypeData^.ParamCount - I - 1] := Temp;
    end;
    Inc(P, 1 + P[1] + 1);
    Inc(P, P[0] + 1);
  end;
  // P is left pointing to the return type name if there is one.

  ReturnValue := MethodHandler.Execute(Slice(ParamValues, TypeData^.ParamCount));
  if TypeData^.MethodKind = mkFunction then
  begin
    Inc(P, P[0] + 1);
    ReturnValue := VarAsType(ReturnValue, GetVariantType(PPTypeInfo(P)^));
    Result := TVarData(ReturnValue).VUInt64;
  end
  else
    Result := 0;
end;

procedure TMethodHandlerInstance.Handler(Params: Pointer);
asm
        .NOFRAME
        SUB     RSP, 28H
        CALL    InternalHandler
        MOV     [RSP], RAX
        MOVSD   XMM0, [RSP]
        ADD     RSP, 28H
end;
{$ELSEIF Defined(CPUARM)}
procedure TMethodHandlerInstance.Handler(Params: Pointer);
begin
                                                                             
end;
{$ELSE OTHERCPU}
{$MESSAGE Fatal 'Missing TMethodHandlerInstance.Handler implementation'}
{$ENDIF OTHERCPU}

{ TEventHandlerInstance }

constructor TEventHandlerInstance.Create(const ADynamicInvokeEvent: TDynamicInvokeEvent; TypeData: PTypeData);
begin
  inherited Create(TypeData);
  Self.FDynamicInvokeEvent := ADynamicInvokeEvent;
end;

procedure TEventHandlerInstance.Handler(Params: Pointer);
begin
  if Assigned(FDynamicInvokeEvent) then
    FDynamicInvokeEvent(Params, StackSize);
end;
{$ENDIF MSWINDOWS}

end.
