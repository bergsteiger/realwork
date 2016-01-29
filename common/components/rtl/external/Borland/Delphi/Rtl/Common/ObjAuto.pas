unit ObjAuto;

interface

uses TypInfo;

const
  paEAX = Word(0);
  paEDX = Word(1);
  paECX = Word(2);
  paStack = Word(3);

type
  TCallingConvention = (ccRegister, ccCdecl, ccPascal, ccStdCall, ccSafeCall);
  TParamFlags = set of (pfVar, pfConst, pfArray, pfAddress, pfReference, pfOut,
    pfResult);
  PPointer = ^Pointer;
  PWord = ^Word;
  PMethodInfoHeader = ^TMethodInfoHeader;
  TMethodInfoHeader = packed record
    Len: Word;
    Addr: Pointer;
    Name: ShortString;
  end;
  PReturnInfo = ^TReturnInfo;
  TReturnInfo = packed record
    Version: Byte; // Must be 1
    CallingConvention: TCallingConvention;
    ReturnType: ^PTypeInfo;
    ParamSize: Word;
  end;
  PParamInfo = ^TParamInfo;
  TParamInfo = packed record
    Flags: TParamFlags;
    ParamType: ^PTypeInfo;
    Access: Word;
    Name: ShortString;
  end;

function ObjectInvoke(Instance: TObject; MethodHeader: PMethodInfoHeader;
  const ParamIndexes: array of Integer; const Params: array of Variant): Variant;
function GetMethodInfo(Instance: TObject;
  const MethodName: ShortString): PMethodInfoHeader;

// These functions should be overloaded and in TypInfo
function GetPropValue(Instance: TObject; PropInfo: PPropInfo): Variant;
procedure SetPropValue(Instance: TObject; PropInfo: PPropInfo; const Value: Variant);

type
  IMethodHandler = interface
    ['{4E61C8CD-16CC-4830-B1E4-84F86FBC0D23}']
    function Execute(const Args: array of Variant): Variant;
    function InstanceToVariant(Instance: TObject): Variant;
  end;

function CreateMethodPointer(const MethodHandler: IMethodHandler; TypeData: PTypeData): TMethod;
procedure ReleaseMethodPointer(MethodPointer: TMethod);

implementation

uses SysUtils, Variants, VarUtils, RTLConsts;

function SameText(const S1, S2: ShortString): Boolean;
var
  L: Integer;
begin
  L := Length(S1);
  Result := (L = Length(S2)) and (StrLIComp(@S1[1], @S2[1], L) = 0);
end;

function GetTypeSize(TypeInfo: PTypeInfo): Integer;
var
  TypeData: PTypeData;
begin
  case TypeInfo^.Kind of
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
    tkString, tkLString, tkWString, tkInterface, tkClass:
      Result := 4;
    tkMethod, tkInt64:
      Result := 8;
    tkVariant:
      Result := 16;
    // TODO: Arrays and records
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
  Codes: array[varEmpty..varInt64, varEmpty..varInt64] of TConvertKind =
    ({v From} {To >}{vt_empty} {vt_null} {vt_i2} {vt_i4} {vt_r4} {vt_r8} {vt_cy} {vt_date} {vt_bstr} {vt_dispatch} {vt_error} {vt_bool} {vt_variant} {vt_unknown} {vt_decimal} {0x0f } {vt_i1} {vt_ui1} {vt_ui2} {vt_ui4} {vt_i8}
    {vt_empty}      (none,      err,      err,    err,    err,    err,    err,    err,      err,      err,          err,       err,      none,         err,         err,         err,    err,    err,     err,     err,     err),
    {vt_null}       (err,       none,     err,    err,    err,    err,    err,    err,      err,      err,          err,       err,      none,         err,         err,         err,    err,    err,     err,     err,     err),
    {vt_i2}         (err,       err,      none,   cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_i4}         (err,       err,      none,   none,   cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_r4}         (err,       err,      cvt,    cvt,    none,   cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_r8}         (err,       err,      cvt,    cvt,    cvt,    none,   none,   none,     cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_cy}         (err,       err,      cvt,    cvt,    cvt,    none,   none,   none,     cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_date}       (err,       err,      cvt,    cvt,    cvt,    none,   none,   none,     cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_bstr}       (err,       err,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      none,     err,          err,       cvt,      none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_dispatch}   (err,       err,      err,    err,    err,    err,    err,    err,      err,      none,         err,       err,      none,         none,        err,         err,    err,    err,     err,     err,     err),
    {vt_error}      (err,       err,      err,    err,    err,    err,    err,    err,      err,      err,          none,      err,      none,         err,         err,         err,    err,    err,     err,     err,     err),
    {vt_bool}       (err,       err,      cvt,    cvt,    err,    err,    err,    err,      cvt,      err,          err,       none,     none,         err,         cvt,         err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_variant}    (cvt,       cvt,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      cvt,          cvt,       cvt,      none,        cvt,         cvt,         cvt,    cvt,    cvt,     cvt,     cvt,     cvt),
    {vt_unknown}    (err,       err,      err,    err,    err,    err,    err,    err,      err,      err,          err,       err,      none,         none,        err,         err,    err,    err,     err,     err,     err),
    {vt_decimal}    (err,       err,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         none,        err,    cvt,    cvt,     cvt,     cvt,     cvt),
    {0x0f }         (err,       err,      err,    err,    err,    err,    err,    err,      err,      err,          err,       err,      none,         err,         err,         none,   err,    err,     err,     err,     err),
    {vt_i1}         (err,       err,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    cvt,     cvt,     cvt),
    {vt_ui1}        (err,       err,      cvt,    cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    cvt,     cvt,     cvt),
    {vt_ui2}        (err,       err,      none,   cvt,    cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    none,    cvt,     cvt),
    {vt_ui4}        (err,       err,      none,   none,   cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    none,    none,    cvt),
    {vt_i8}         (err,       err,      none,   none,   cvt,    cvt,    cvt,    cvt,      cvt,      err,          err,       cvt,      none,         err,         cvt,         err,    none,   none,    none,    none,    none));
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
    // TODO: A string should be allowed as an alternative to the Ord value of an enumeration
    tkInteger, tkChar, tkEnumeration, tkWChar:
      if (TypeInfo = System.TypeInfo(Boolean)) or
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
          ftComp, ftCurr: Result := varCurrency;
        else
          Result := varError;
        end;
      end;
    tkString:   Result := varString;
    tkLString:  Result := varString;
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
    tkInt64:    Result := varInt64;
    // TODO: Arrays and records
  else
    Result := varError;
  end;
end;

procedure GetFloatReturn(var Ret; FloatType: TFloatType);
asm
        CMP     EDX, ftSingle
        JE      @@Single
        CMP     EDX, ftDouble
        JE      @@Double
        CMP     EDX, ftExtended
        JE      @@Extended
        CMP     EDX, ftCurr
        JE      @@Curr
        CMP     EDX, ftComp
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

function GetMethodInfo(Instance: TObject; const MethodName: ShortString): PMethodInfoHeader;
var
  VMT: Pointer;
  MethodInfo: Pointer;
  Count: Integer;
begin
  // Find the method
  VMT := PPointer(Instance)^;
  repeat
    MethodInfo := PPointer(Integer(VMT) + vmtMethodTable)^;
    if MethodInfo <> nil then
    begin
      // Scan method table for the method
      Count := PWord(MethodInfo)^;
      Inc(Integer(MethodInfo), 2);
      while Count > 0 do
      begin
        Result := MethodInfo;
        if SameText(Result^.Name, MethodName) then
          Exit;
        Inc(Integer(MethodInfo), PMethodInfoHeader(MethodInfo)^.Len);
        Dec(Count);
      end;
    end;
    // Find the parent VMT
    VMT := PPointer(Integer(VMT) + vmtParent)^;
    if VMT = nil then
    begin
      Result := nil;
      Exit;
    end;
    VMT := PPointer(VMT)^;
  until False;
end;

resourcestring
  sMethodNotFound = 'Method %s of class %s not found';
  sTypeMisMatch = 'Type mismatch in parameter %d for method %s';
  sInvalidDispID = 'Invalid DispID for parameter %d in method %s';
  sParamRequired = 'Parameter %d required for method %s';
  sMethodOver = 'Method definition for %s has over %d parameters';
  sTooManyParams = 'Too many parameters for method %s';

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
const
  MaxParams = 10;

  procedure Swap(var A, B: PParamInfo);
  var
    T: PParamInfo;
  begin
    T := A;
    A := B;
    B := T;
  end;

var
  MethodName: string;

  procedure ParameterMismatch(I: Integer);
  begin
    raise Exception.CreateFmt(sTypeMisMatch, [I, MethodName]);
  end;

var
  MethodInfo: Pointer;
  ReturnInfo: PReturnInfo;
  MethodAddr: Pointer;
  InfoEnd: Pointer;
  Count: Integer;
  I, K, P: Integer;
  Param: PParamInfo;
  Regs: array[paEAX..paECX] of Cardinal;
  RetVal: Variant;
  ParamType: TVarType;
  VarType: TVarType;
  ParamVarData: PVarData;
  PushData: Pointer;
  ParamBytes: Integer;
  Size: Integer;
  Frame: PChar;
  ResultParam: Pointer;
  ResultPointer: Pointer;
  ParamInfos: array[0..MaxParams- 1] of PParamInfo;
  ParamData: array[0..MaxParams - 1] of Pointer;
  Pointers: array[0..MaxParams - 1] of Pointer;
  Temps: array[0..MaxParams - 1] of Variant;
begin
  // MethodInfo now points to the method we found.
  MethodInfo := MethodHeader;
  MethodAddr := MethodHeader^.Addr;
  MethodName := PMethodInfoHeader(MethodInfo)^.Name;
  Inc(Integer(MethodInfo), SizeOf(TMethodInfoHeader) - SizeOf(ShortString) + 1 +
    Length(MethodName));
  ReturnInfo := MethodInfo;
  Inc(Integer(MethodInfo), SizeOf(TReturnInfo));

  InfoEnd := Pointer(Integer(MethodHeader) + MethodHeader^.Len);
  Count := 0;
  while Integer(MethodInfo) < Integer(InfoEnd) do
  begin
    if Count >= MaxParams then
      raise Exception.CreateFmt(sMethodOver, [MethodName, MaxParams]);
    ParamInfos[Count] := MethodInfo;
    Inc(Count);
    Inc(Integer(MethodInfo), SizeOf(TParamInfo) - SizeOf(ShortString) + 1 +
      Length(PParamInfo(MethodInfo)^.Name));
  end;

  if High(Params) >= Count then
    raise Exception.CreateFmt(sTooManyParams, [MethodName]);

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
        raise Exception.CreateFmt(sInvalidDispID, [I, MethodName]);
    end
    else
      K := High(Params) - P + 1;  // Add one to account for Self
    Param := ParamInfos[K];
    ParamType := GetVariantType(Param^.ParamType^);
    ParamVarData := @Params[I];
    VarType := ParamVarData^.VType;
    if Param^.Flags * [pfOut, pfVar] <> [] then
    begin
      // TODO: Should I handle byref variants?
      // For pfVar, the variant must be a byref and equal to the type.
      if (VarType <> ParamType or varByRef) and (ParamType <> varVariant) then
        ParameterMismatch(I);
    end
    else
      // TODO: Arrays?
      // Convert the parameter to the right type
      case ConvertKindOf(VarType and varTypeMask, ParamType) of
        ckConvert:
          try
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
        ckError: ParameterMismatch(I);
      end;

    if ParamType = varVariant then
    begin
      Pointers[K] := ParamVarData;
      ParamData[K] := @Pointers[K];
    end
    else if varByRef and VarType <> 0 then
      ParamData[K] := @ParamVarData^.VPointer 
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
            SUB     ESP,ParamBytes
            MOV     Frame,ESP
  end;
  Dec(Integer(Frame), 4 + 4); // Access numbers include RET and EBP

  // Push the parameters on the stack (or put them into the correct register)
  ResultParam := nil;
  for I := 0 to Count - 1 do
  begin
    Param := ParamInfos[I];
    PushData := ParamData[I];
    if PushData = nil then
      if (Param^.ParamType^.Kind = tkClass) and SameText(Param^.Name, 'SELF') then
        // Self is special. It doesn't appear in the ParamData array since it
        // is not represented in the Params array.
        PushData := @Instance
      else if pfResult in Param^.Flags then
      begin
        ResultParam := Param;
        VarClear(Result);
        TVarData(Result).VType := GetVariantType(Param^.ParamType^);
        if TVarData(Result).VType = varVariant then
          ResultPointer := @Result
        else
          ResultPointer := @TVarData(Result).VInteger;
        PushData := @ResultPointer;
      end
      else
        // TODO: Handle default parameters
        raise Exception.CreateFmt(sParamRequired, [I, MethodName]);
    if Param^.Access < Word(Ord(paStack)) then
      Regs[Param^.Access] := PCardinal(PushData)^
    else
    begin
      if [pfVar, pfOut, pfResult] * Param^.Flags <> [] then
        PCardinal(@Frame[Param^.Access])^ := PCardinal(PushData)^
      else
      begin
        Size := GetTypeSize(Param^.ParamType^);
        case Size of
          1, 2, 4:
            PCardinal(@Frame[Param^.Access])^ := PCardinal(PushData)^;
          8:
          begin
            PCardinal(@Frame[Param^.Access])^ := PCardinal(PushData)^;
            PCardinal(@Frame[Param^.Access + 4])^ :=
              PCardinal(Integer(PushData) + 4)^;
          end;
        else
          Move(PushData^, Frame[Param^.Access and not 3], Size);
        end;
      end;
    end;
  end;

  // Do the call
  asm
            MOV     EAX,DWORD PTR Regs[0]
            MOV     EDX,DWORD PTR Regs[4]
            MOV     ECX,DWORD PTR Regs[8]
            CALL    MethodAddr
            MOV     DWORD PTR Regs[0],EAX
            MOV     DWORD PTR Regs[4],EDX
  end;

  if ReturnInfo^.CallingConvention = ccCdecl then
  asm
            ADD     ESP,ParamBytes
  end;

  // TODO: Handle non-4 byte return results
  if (ResultParam = nil) and (ReturnInfo^.ReturnType <> nil) then
  begin
    // The result came back in registers. Otherwise a result pointer was used
    // and the return variant is already initialized (or it was a procedure)
    TVarData(RetVal).VType := GetVariantType(ReturnInfo^.ReturnType^);
    if ReturnInfo^.ReturnType^.Kind = tkFloat then
      GetFloatReturn(TVarData(RetVal).VDouble, GetTypeData(ReturnInfo^.ReturnType^)^.FloatType)
    else
    begin
      // For regular Boolean types, we must convert it to a boolean to
      // wipe the high order bytes; otherwise the caller may see a false
      // as true.
      if (TVarData(RetVal).VType = varBoolean) and
        (ReturnInfo^.ReturnType^ = System.TypeInfo(Boolean)) then
        TVarData(RetVal).VInteger := Integer(Boolean(Regs[paEAX]))
      else
        TVarData(RetVal).VInteger := Integer(Regs[paEAX]);
      PCardinal(Integer(@TVarData(RetVal).VInteger) + 4)^ := Regs[paEDX];
    end;
    Result := RetVal;
    TVarData(RetVal).VType := varEmpty;
  end;
end;

function GetPropValue(Instance: TObject; PropInfo: PPropInfo): Variant;
begin
  // assume failure
  Result := Null;

  // return the right type
  case PropInfo^.PropType^^.Kind of
    tkInteger, tkChar, tkWChar, tkClass:
      Result := GetOrdProp(Instance, PropInfo);
    tkEnumeration:
      if GetTypeData(PropInfo^.PropType^)^.BaseType^ = TypeInfo(Boolean) then
        Result := Boolean(GetOrdProp(Instance, PropInfo))
      else
        Result := GetOrdProp(Instance, PropInfo);
    tkSet:
      Result := GetOrdProp(Instance, PropInfo);
    tkFloat:
      Result := GetFloatProp(Instance, PropInfo);
    tkMethod:
      Result := PropInfo^.PropType^.Name;
    tkString, tkLString:
      Result := GetStrProp(Instance, PropInfo);
    tkWString:
      Result := GetWideStrProp(Instance, PropInfo);
    tkVariant:
      Result := GetVariantProp(Instance, PropInfo);
    tkInt64:
      Result := GetInt64Prop(Instance, PropInfo);
    tkDynArray:
      DynArrayToVariant(Result, Pointer(GetOrdProp(Instance, PropInfo)), PropInfo^.PropType^);
  else
    raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [PropInfo.PropType^^.Name]);
  end;
end;

procedure SetPropValue(Instance: TObject; PropInfo: PPropInfo; const Value: Variant);

  function RangedValue(const AMin, AMax: Int64): Int64;
  begin
    Result := Trunc(Value);
    if Result < AMin then
      Result := AMin;
    if Result > AMax then
      Result := AMax;
  end;

var
  TypeData: PTypeData;
  DynArray: Pointer;
begin
  // get the prop info
  TypeData := GetTypeData(PropInfo^.PropType^);

  // set the right type
  case PropInfo.PropType^^.Kind of
    tkInteger, tkChar, tkWChar:
      if TypeData^.MinValue < TypeData^.MaxValue then
        SetOrdProp(Instance, PropInfo, RangedValue(TypeData^.MinValue,
          TypeData^.MaxValue))
      else
        // Unsigned type
        SetOrdProp(Instance, PropInfo,
          RangedValue(LongWord(TypeData^.MinValue),
          LongWord(TypeData^.MaxValue)));
    tkEnumeration:
      if VarType(Value) = varString then
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
    tkString, tkLString:
      SetStrProp(Instance, PropInfo, VarToStr(Value));
    tkWString:
      SetWideStrProp(Instance, PropInfo, VarToWideStr(Value));
    tkVariant:
      SetVariantProp(Instance, PropInfo, Value);
    tkInt64:
      SetInt64Prop(Instance, PropInfo, RangedValue(TypeData^.MinInt64Value,
        TypeData^.MaxInt64Value));
    tkDynArray:
      begin
        DynArrayFromVariant(DynArray, Value, PropInfo^.PropType^);
        SetOrdProp(Instance, PropInfo, Integer(DynArray));
      end;
  else
    raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType,
      [PropInfo.PropType^^.Name]);
  end;
end;


type
  PParameterInfos = ^TParameterInfos;
  TParameterInfos = array[0..255] of ^PTypeInfo;

  TMethodHandlerInstance = class
  protected
    MethodHandler: IMethodHandler;
    TypeData: PTypeData;
    ParamInfos: PParameterInfos;
    Return: array[0..2] of Byte;
    ParamOffsets: array of Word;
    procedure Handler(Params: Pointer);
    procedure RegisterStub;
  public
    constructor Create(const MethodHandler: IMethodHandler; TypeData: PTypeData);
    destructor Destroy; override;
  end;

function AdditionalInfoOf(TypeData: PTypeData): Pointer;
var
  P: PChar;
  I: Integer;
begin
  P := @TypeData^.ParamList;
  // Skip parameter names and types
  for I := 1 to TypeData^.ParamCount do
  begin
    Inc(P, 1 + Byte(P[1]) + 1);
    Inc(P, Byte(P[0]) + 1 );
  end;
  if TypeData^.MethodKind = mkFunction then
    // Skip return type name and info
    Inc(P, Byte(P[0]) + 1 + 4);
  Result := P;
end;

function CreateMethodPointer(const MethodHandler: IMethodHandler; TypeData: PTypeData): TMethod;
begin
  Result.Data := TMethodHandlerInstance.Create(MethodHandler, TypeData);
  Result.Code := @TMethodHandlerInstance.RegisterStub;
end;

procedure ReleaseMethodPointer(MethodPointer: TMethod);
begin
  TObject(MethodPointer.Data).Free;
end;

{ TMethodHandlerInstance }

type
  PParameters = ^TParameters;
  TParameters = packed record
    Registers: array[paEDX..paECX] of Cardinal;
    Stack: array[0..1023] of Byte;
  end;

constructor TMethodHandlerInstance.Create(const MethodHandler: IMethodHandler;
  TypeData: PTypeData);
var
  P: PChar;
  Offset: Integer;
  CurReg: Integer;
  StackSize: Integer;
  I: Integer;
  Size: Integer;
begin
  Self.TypeData := TypeData;
  Self.MethodHandler := MethodHandler;

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
      Inc(StackSize, Size);
    Inc(P, 1 + Byte(P[1]) + 1);
    Inc(P, Byte(P[0]) + 1);
  end;

  // Calculate parameter offsets
  SetLength(ParamOffsets, TypeData^.PropCount);
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
    Inc(P, 1 + Byte(P[1]) + 1);
    Inc(P, Byte(P[0]) + 1);
  end;

  // Calculate the return instruction
  if StackSize > 0 then
  begin
    Return[0] := $C2;
    Return[1] := StackSize and $FF;
    Return[2] := StackSize shr 8;
  end
  else
    Return[0] := $C3;
end;

destructor TMethodHandlerInstance.Destroy;
begin

  inherited;
end;

procedure TMethodHandlerInstance.Handler(Params: Pointer);
const
  MaxParams = 10;
var
  P: PChar;
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
      ParamValues[TypeData^.ParamCount - I - 1] := MethodHandler.InstanceToVariant(PPointer(Data)^)
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
    Inc(P, 1 + Byte(P[1]) + 1);
    Inc(P, Byte(P[0]) + 1);
  end;
  // P is left pointing to the return type name if there is one.

  ReturnValue := MethodHandler.Execute(Slice(ParamValues, TypeData^.ParamCount));
  if TypeData^.MethodKind = mkFunction then
  begin
    Inc(P, Byte(P[0]) + 1);
    ReturnValue := VarAsType(ReturnValue, GetVariantType(PPTypeInfo(P)^));
    if PPTypeInfo(P)^.Kind = tkFloat then
      // TODO: Handle Floating point results
    else
    begin
      Regs[paEAX] := TVarData(ReturnValue).VLongWord;
      Regs[paEDX] := PCardinal(Integer(@TVarData(ReturnValue).VLongWord) + 4)^;
    end;
  end;

  // Let Stub procedures know where the RET instruction is
  asm
        MOV     EAX,DWORD PTR Regs[paEAX*4]
        MOV     EDX,DWORD PTR Regs[paEDX*4]
  end;
end;

procedure TMethodHandlerInstance.RegisterStub;
asm
        PUSH    EAX
        PUSH    ECX
        PUSH    EDX
        MOV     EDX,ESP
        CALL    Handler
        // Pop EDX and ECX off the stack while preserving all registers.
        MOV     [ESP+4],EAX
        POP     EAX
        POP     EAX
        POP     ECX		// Self
        LEA     ECX,[ECX].TMethodHandlerInstance.Return
        // Jump to the actual return instruction since it is most likely not just a RET
        JMP     ECX
end;

end.
