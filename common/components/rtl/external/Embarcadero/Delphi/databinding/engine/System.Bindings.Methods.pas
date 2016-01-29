{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "System.Bindings.Methods"'}    {Do not Localize}
unit System.Bindings.Methods;

interface

uses
  System.SysUtils, System.Rtti, System.TypInfo, System.Generics.Collections, System.Classes, System.StrUtils, System.Bindings.Evaluator,
  System.Bindings.ObjEval, System.Bindings.EvalProtocol, System.Bindings.EvalSys, System.Bindings.Consts;

type
  EBindOutputError = class(Exception);
  EBindOutputCallbackError = class(Exception);
  EBindConverterError = class(Exception);
  EBindMethodError = class(Exception);

  /// <summary>Bound Output or LValue custom conversion routine signature.</summary>
  TMethodDescription = record
  strict private
    FInvokable: IInvokable;
    FID: string;
    FName: string;
    FUnitName: string;
    FDefaultEnabled: Boolean;
    FFrameworkClass: TPersistentClass;
    FDescription: string;
  public
    constructor Create(const AInvokable: IInvokable; const AID, AName, AUnitName: string;
      ADefaultEnabled: Boolean; const ADescription: string; AFrameworkClass: TPersistentClass); overload;
    property ID: string read FID;
    property Name: string read FName;
    property UnitName: string read FUnitName;
    property DefaultEnabled: Boolean read FDefaultEnabled;
    property FrameWorkClass: TPersistentClass read FFrameWorkClass;
    property Invokable: IInvokable read FInvokable;
    property Description: string read FDescription;
  end;

  TBindingMethods = class
  public type
    TMethodList = TDictionary<string, TMethodDescription>;
  end;

  TBindingMethodsFactory = class
  private
    class var FRegisteredMethods: TBindingMethods.TMethodList;
  public
    class constructor Create;
    class destructor Destroy;
    class function HasMethod(const AID: string): Boolean; overload;
    class procedure RegisterMethod(AMethod: TMethodDescription); overload;
    class procedure UnRegisterMethod(const AID: string); overload;
    class procedure ClearRegisteredMethods;
    class function GetRegisteredMethods: TArray<TMethodDescription>;
//    class function GetMethods: TBindingMethods;
    class function GetMethodScope: IScope; overload;//returns all
    class function GetMethodScope(MethodNames: array of string): IScope; overload;
    class function GetMethodUnitName(const MethodID: string): string;
    class function GetMethodFrameworkClass(const MethodID: string): TPersistentClass;
  end;

type
  TInvokableBody = reference to function(Args: TArray<IValue>): IValue;

function MakeInvokable(const ABody: TInvokableBody): IInvokable;
function MakeLocation(AType: PTypeInfo; const AGetter: TLocationWrapper.TValueGetter;
  const ASetter: TLocationWrapper.TValueSetter): ILocation;

implementation

uses
  System.Bindings.NotifierContracts, System.Math;


function MakeLocation(AType: PTypeInfo; const AGetter: TLocationWrapper.TValueGetter;
  const ASetter: TLocationWrapper.TValueSetter): ILocation;
begin
  Result := TLocationWrapper.Create(AType, AGetter, ASetter);
end;

type
  TInvokable = class(TInterfacedObject, IWrapper, IInvokable)
  private
    FBody: TInvokableBody;
  public
    constructor Create(const ABody: TInvokableBody);
    function Invoke(const Args: TArray<IValue>): IValue;
  end;

function MakeInvokable(const ABody: TInvokableBody): IInvokable;
begin
  Result := TInvokable.Create(ABody);
end;

{ TInvokable }

constructor TInvokable.Create(const ABody: TInvokableBody);
begin
  FBody := ABody;
end;

function TInvokable.Invoke(const Args: TArray<IValue>): IValue;
begin
  Result := FBody(Args);
end;


{ TMethodDescription }

constructor TMethodDescription.Create(const AInvokable: IInvokable; const AID, AName,
  AUnitName: string; ADefaultEnabled: Boolean; const ADescription: string; AFrameworkClass: TPersistentClass);
begin
  FInvokable := AInvokable;
  FID := AID;
  FName := AName;
  FUnitName := AUnitName;
  FDefaultEnabled := ADefaultEnabled;
  FFrameWorkClass := AFrameworkClass;
  FDescription := ADescription;
end;

{ TBindingMethodsFactory }

class procedure TBindingMethodsFactory.ClearRegisteredMethods;
begin
  FRegisteredMethods.Clear;
end;

class constructor TBindingMethodsFactory.Create;
begin
  FRegisteredMethods := TBindingMethods.TMethodList.Create;
end;

class destructor TBindingMethodsFactory.Destroy;
begin
  FRegisteredMethods.Free;
end;

class function TBindingMethodsFactory.GetMethodScope: IScope;
begin
  Result := GetMethodScope([]);
end;

class function TBindingMethodsFactory.GetMethodScope(
  MethodNames: array of string): IScope;
var
  LDictionaryScope: TDictionaryScope;
  LMethod: string;
begin
  LDictionaryScope := TDictionaryScope.Create;
  Result := LDictionaryScope;  // Will free if exception
  if Length(MethodNames) > 0 then
    for LMethod in MethodNames do
    begin
      if not FRegisteredMethods.ContainsKey(LMethod) then
        raise EBindMethodError.Create(Format(sMethodNotFound, [LMethod]));
      LDictionaryScope.Map.Add(LMethod, FRegisteredMethods.Items[LMethod].Invokable);
    end
  else
    for LMethod in FRegisteredMethods.Keys do
    begin
      if FRegisteredMethods.Items[LMethod].DefaultEnabled then
        LDictionaryScope.Map.Add(LMethod, FRegisteredMethods.Items[LMethod].Invokable);
    end;
end;

class function TBindingMethodsFactory.GetMethodUnitName(
  const MethodID: string): string;
begin
  Result := '';
  if FRegisteredMethods.ContainsKey(MethodID) then
    Result := FRegisteredMethods.Items[MethodID].UnitName;
end;

class function TBindingMethodsFactory.GetMethodFrameworkClass(
  const MethodID: string): TPersistentClass;
begin
  Result := nil;
  if FRegisteredMethods.ContainsKey(MethodID) then
    Result := FRegisteredMethods.Items[MethodID].FrameWorkClass;
end;

class function TBindingMethodsFactory.GetRegisteredMethods: TArray<TMethodDescription>;
begin
  Result := FRegisteredMethods.Values.ToArray;
end;

class function TBindingMethodsFactory.HasMethod(
  const AID: string): Boolean;
begin
  if FRegisteredMethods.ContainsKey(AID) then
    Result := True
  else
    Result := False;
end;

class procedure TBindingMethodsFactory.RegisterMethod(
  AMethod: TMethodDescription);
begin
  if FRegisteredMethods.ContainsKey(AMethod.ID) then
    raise EBindMethodError.Create(Format(sDuplicatedMethodName, [AMethod.ID]));
  FRegisteredMethods.Add(AMethod.ID, AMethod);
end;

class procedure TBindingMethodsFactory.UnRegisterMethod(const AID: string);
begin
  FRegisteredMethods.Remove(AID);
end;

function MakeMethodLowerCase: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [1, Length(Args)]));
    v := Args[0];
    if v.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil))
    else
      Exit(TValueWrapper.Create(LowerCase(v.GetValue.AsString)));
  end);
end;

function MakeMethodUpperCase: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [1, Length(Args)]));
    v := Args[0];
    if v.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil))
    else
      Exit(TValueWrapper.Create(UpperCase(v.GetValue.AsString)));
  end);
end;

function MakeMethodRound: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [1, Length(Args)]));
    v := Args[0];
    if v.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil))
    else
      Exit(TValueWrapper.Create(Round(v.GetValue.AsExtended)));
  end);
end;

function MakeMethodFormatDateTime: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v1: IValue;
    LDate: TDateTime;
    formatted: string;
  begin
    if Length(Args) <> 2 then
      raise EEvaluatorError.Create(sFormatArgError);
    v1 := Args[0];
    if not (v1.GetType.Kind in [tkString, tkUString, tkWString]) then
      raise EEvaluatorError.Create(sFormatExpectedStr);
    if Args[1].GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil)) // Handle null
    else
    begin
      LDate := Args[1].GetValue.AsExtended;
      formatted := FormatDateTime(v1.GetValue.AsString, LDate);
    end;
    Result := TValueWrapper.Create(formatted);
  end);
end;

function MakeMethodStrToDateTime: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
    LDate: TDateTime;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sFormatArgError);
    v:= Args[0];
    if v.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil))
    else
      LDate := StrToDateTime(Args[0].GetValue.AsString);
    Result := TValueWrapper.Create(LDate);
  end);
end;

function MakeMethodFormat: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
    FmtArgs: array of TVarRec;
    I: Integer;
    str, formatted: string;
    LExtended: Extended;
    LNull: Boolean;
  begin
    LNull := False;
    if Length(Args) < 2 then
      raise EEvaluatorError.Create(sFormatArgError);
    v := Args[0];
    if not (v.GetType.Kind in [tkString, tkUString, tkWString]) then
      raise EEvaluatorError.Create(sFormatExpectedStr);
    formatted := '';
    str := v.GetValue.AsString;
    SetLength(FmtArgs, Length(Args)-1);
    for I := 0 to Length(FmtArgs) - 1 do
    begin
      if Args[I+1].GetValue.IsEmpty then
      begin
        LNull := True;
        break;
      end;
      case Args[I+1].GetType.Kind of
        tkInteger, tkInt64:
          begin
            FmtArgs[I].VInteger := Args[I+1].GetValue.AsInteger;
            FmtArgs[I].VType := vtInteger;
          end;
        tkFloat:
          begin
            LExtended := Args[I+1].GetValue.AsExtended;
            FmtArgs[I].VExtended := @LExtended;
            FmtArgs[I].VType := vtExtended;
          end;
        {$IFNDEF NEXTGEN}
        tkWString:
          begin
            FmtArgs[I].VWideString := Pointer(WideString(Args[I+1].GetValue.AsString));
            FmtArgs[I].VType := vtWideString;
          end;
        {$ENDIF}
        tkUString:
          begin
            FmtArgs[I].VUnicodeString := Pointer(UnicodeString(Args[I+1].GetValue.AsString));
            FmtArgs[I].VType := vtUnicodeString;
          end;
        tkString:
          begin
            FmtArgs[I].VString := Pointer(Args[I+1].GetValue.AsString);
            FmtArgs[I].VType := vtString;
        {$IFNDEF NEXTGEN}
          end;
        tkLString:
          begin
            FmtArgs[I].VAnsiString := Pointer(AnsiString(Args[I+1].GetValue.AsString));
            FmtArgs[I].VType := vtAnsiString;
        {$ENDIF}
          end
        else raise EBindMethodError.Create(Format(sFormatUnexpectedType, [Args[I+1].GetType.NameFld.ToString]));
      end;
    end;

    if LNull then
      Exit(TValueWrapper.Create(nil))
    else
      formatted := Format(str, FmtArgs);
    Result := TValueWrapper.Create(formatted);
  end);
end;

function MakeMethodToNotifyEvent: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
    LRttiChild: IRttiChild;
    LNotifyEvent: TNotifyEvent;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [1, Length(Args)]));
    v := Args[0];
    if v.GetValue.IsEmpty then
    begin
      if Supports(v, IRttiChild, LRttiChild) and
         (LRttiChild.Member is TRttiMethod) then
      begin
        TMethod(LNotifyEvent).Code := TRttiMethod(LRttiChild.Member).CodeAddress;
        TMethod(LNotifyEvent).Data := LRttiChild.Parent;
        Exit(TValueWrapper.Create(TValue.From<TNotifyEvent>(LNotifyEvent)));
      end;
    end;
    Exit(TValueWrapper.Create(nil));
  end);
end;

// From System.Rtti
function GetEnumBaseType(ATypeInfo: PTypeInfo): PTypeInfo;
var
  pResult: PPTypeInfo;
begin
  if (ATypeInfo = nil) or (ATypeInfo^.Kind <> tkEnumeration) then
    Exit(nil);
  Result := ATypeInfo;
  while True do
  begin
    pResult := GetTypeData(Result)^.BaseType;
    if (pResult <> nil) and (pResult^ <> nil) and (pResult^ <> Result) then
      Result := pResult^
    else
      Break;
  end;
end;

function IsBoolType(ATypeInfo: PTypeInfo): Boolean;
begin
  ATypeInfo := GetEnumBaseType(ATypeInfo);
  Result := (ATypeInfo = System.TypeInfo(Boolean)) or
    (ATypeInfo = System.TypeInfo(ByteBool)) or
    (ATypeInfo = System.TypeInfo(WordBool)) or
    (ATypeInfo = System.TypeInfo(LongBool));
end;

function MakeMethodToVariant: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
    LVariant: Variant;
    procedure TryConvert;
    begin
      try
        LVariant := v.GetValue.AsVariant;
      except on E: EInvalidCast do
        raise EBindMethodError.Create(Format(sConversionUnavailable, [v.GetType.Name, 'Variant']))
      end;
    end;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [1, Length(Args)]));
    v := Args[0];
    // Non-bidi ToVariant()
    if v.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil));
    case v.GetType.Kind of
      tkInteger, tkInt64: LVariant := v.GetValue.AsInteger;
      tkFloat: LVariant := v.GetValue.AsExtended;
      tkString, tkLString, tkWString, tkUString: LVariant := v.GetValue.AsString;
      tkVariant: LVariant := v.GetValue.AsVariant;
      tkClass: LVariant := v.GetValue.AsClass.ClassName;
      tkEnumeration:
         if IsBoolType(v.GetType) then
          LVariant := v.GetValue.AsBoolean
        else TryConvert;
      else TryConvert;
    end;
    Exit(TValueWrapper.Create(TValue.From<Variant>(LVariant)));
  end);
end;

function MakeMethodToStr: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sToStrArgCount);
    v := Args[0];
    // Non-bidi ToStr()
    if v.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil)); // Do not localize

    case v.GetType.Kind of
      tkInteger, tkInt64: Exit(TValueWrapper.Create(IntToStr(v.GetValue.AsInteger)));
      tkFloat: Exit(TValueWrapper.Create(FloatToStr(v.GetValue.AsExtended)));
      tkWChar, tkChar, tkString, tkLString, tkWString, tkUString: Exit(TValueWrapper.Create(v.GetValue.AsString));
      tkVariant: Exit(TValueWrapper.Create(String(v.GetValue.AsVariant)));
      tkRecord, tkClass: Exit(TValueWrapper.Create(v.GetType.NameFld.ToString));
      tkEnumeration: Exit(TValueWrapper.Create(GetEnumName(v.GetType, v.GetValue.AsOrdinal)))
    else
    begin
      if v.GetType <> nil then
        Exit(TValueWrapper.Create(v.GetType.NameFld.ToString))
      else
        Exit(TValueWrapper.Create(nil));
    end;
    end;
  end);
end;


function MakeMethodMin: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v1: IValue;
    v2: IValue;
    LInt1, LInt2: Int64;
  begin
    if Length(Args) <> 2 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [2, Length(Args)]));
    v1 := Args[0];
    v2 := Args[1];
    if v1.GetValue.IsEmpty or v2.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil)); // Do not localize
    if v1.GetValue.TryAsType<Int64>(LInt1) and
      v2.GetValue.TryAsType<Int64>(LInt2) then
      Exit(TValueWrapper.Create(Min(LInt1, LInt2)))
    else
      Exit(TValueWrapper.Create(Min(v1.GetValue.AsExtended, v2.GetValue.AsExtended)));
  end);
end;

function MakeMethodMax: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v1: IValue;
    v2: IValue;
    LInt1, LInt2: Int64;
  begin
    if Length(Args) <> 2 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [2, Length(Args)]));
    v1 := Args[0];
    v2 := Args[1];
    if v1.GetValue.IsEmpty or v2.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil)); // Do not localize
    if v1.GetValue.TryAsType<Int64>(LInt1) and
      v2.GetValue.TryAsType<Int64>(LInt2) then
      Exit(TValueWrapper.Create(Max(LInt1, LInt2)))
    else
      Exit(TValueWrapper.Create(Max(v1.GetValue.AsExtended, v2.GetValue.AsExtended)));
  end);
end;

function MakeIfAll: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
    I: Integer;
  const
    sMaxArgs = 100;
  begin
    if Length(Args) > sMaxArgs then
      raise EEvaluatorError.Create(Format(sMaxArgsExceeded, [sMaxArgs]));
    for I := 0 to Length(Args) - 1 do
    begin
      v := Args[I];
      if v.GetValue.IsEmpty then
        Exit(TValueWrapper.Create(False));
      if not v.GetValue.IsType<Boolean> then
        Exit(TValueWrapper.Create(False));
      if not v.GetValue.AsType<Boolean> then
        Exit(TValueWrapper.Create(False));
    end;
    Exit(TValueWrapper.Create(True));
  end);
end;

function MakeIfAny: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
    I: Integer;
  const
    sMaxArgs = 100;
  begin
    if Length(Args) > sMaxArgs then
      raise EEvaluatorError.Create(Format(sMaxArgsExceeded, [sMaxArgs]));
    for I := 0 to Length(Args) - 1 do
    begin
      v := Args[I];
      if not v.GetValue.IsEmpty then
        if v.GetValue.IsType<Boolean> then
          if v.GetValue.AsType<Boolean> then
            Exit(TValueWrapper.Create(True));
    end;
    Exit(TValueWrapper.Create(False));
  end);
end;

function MakeIfThen: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v1: IValue;
    v2: IValue;
    v3: IValue;
  begin
    if Length(Args) <> 3 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [3, Length(Args)]));
    v1 := Args[0];
    v2 := Args[1];
    v3 := Args[2];
    if v1.GetValue.IsEmpty then
      Exit(TValueWrapper.Create(nil)); // Do not localize
    if v1.GetValue.AsType<Boolean>  then
      Exit(TValueWrapper.Create(v2.GetValue))
    else
      Exit(TValueWrapper.Create(v3.GetValue))

  end);
end;


function MakeSubString: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    LString: IValue;
    LIndex: Integer;
    LLength: Integer;
  begin
    if Length(Args) > 3 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [3, Length(Args)]));
    if Length(Args) < 2 then
      raise EEvaluatorError.Create(Format(sUnexpectedArgCount, [2, Length(Args)]));
    LString := Args[0];
    LIndex := Args[1].GetValue.AsType<Integer>;
    if Length(Args) > 2 then
      LLength := Args[2].GetValue.AsType<integer>
    else
      LLength := MaxInt;
    Result := MakeLocation(TypeInfo(TValue),
      function: TValue
      begin
        if LString.GetValue.IsEmpty then
          Result := TValue.Empty
        else
          Result := LString.GetValue.AsType<string>.SubString(LIndex, LLength)
      end,
      procedure(x: TValue)
      begin
        //SetSelectedValue(v.GetValue.AsObject, x);
        if LString.GetValue.IsEmpty then
          Exit
        else
        begin
          //Result := LString.GetValue.AsType<string>.SubString(LIndex, LLength);
          Assert(False);
        end;
      end);
  end);
end;

const
  sIDToStr = 'ToStr';
  sIDToVariant = 'ToVariant';
  sIDToNotifyEvent = 'ToNotifyEvent';
  sIDRound = 'Round';
  sIDFormat = 'Format';
  sIDUpperCase = 'UpperCase';
  sIDLowerCase = 'LowerCase';
  sIDFormatDateTime = 'FormatDateTime';
  sIDStrToDateTime = 'StrToDateTime';
  sIDMin = 'Math_Min';
  sIDMax = 'Math_Max';
  sIDIfThen = 'IfThen';
  sIDIfAny = 'IfAny';
  sIDIfAll = 'IfAll';
  sIDSubString = 'SubString';

procedure RegisterBasicMethods;
begin
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodFormat,
      sIDFormat,
      sIDFormat, '', True,
      sFormatDesc,
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodFormatDateTime,
      sIDFormatDateTime,
      sIDFormatDateTime, '', True,
      '',
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodStrToDateTime,
      sIDStrToDateTime,
      sIDStrToDateTime, '', True,
      '',
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodLowerCase,
      sIDLowerCase,
      sIDLowerCase, '', True,
      sLowerCaseDesc,
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodUpperCase,
      sIDUpperCase,
      sIDUpperCase, '', True,
      sUpperCaseDesc,
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodToStr,
      sIDToStr,
      sIDToStr, '', True,
      sToStrDesc,
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodToVariant,
      sIDToVariant,
      sIDToVariant, '', True,
      sToVariantDesc,
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodToNotifyEvent,
      sIDToNotifyEvent,
      sIDToNotifyEvent, '', True,
      sToNotifyEventDesc,
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodRound,
      sIDRound,
      sIDRound, '', True,
      '',
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodMin,
      sIDMin,
      sIDMin, '', True,
      '',
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeMethodMax,
      sIDMax,
      sIDMax, '', True,
      '',
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeIfThen,
      sIDIfThen,
      sIDIfThen, '', True,
      '',
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeIfAll,
      sIDIfAll,
      sIDIfAll, '', True,
      '',
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeIfAny,
      sIDIfAny,
      sIDIfAny, '', True,
      '',
      nil));
  TBindingMethodsFactory.RegisterMethod(
    TMethodDescription.Create(
      MakeSubString,
      sIDSubString,
      sIDSubString, '', True,
      '',
      nil));
end;

initialization
  RegisterBasicMethods;

finalization

end.
