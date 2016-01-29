{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.EvalSys;

interface

uses
  System.SysUtils, System.SyncObjs, System.TypInfo, System.Rtti, System.Generics.Collections,

  System.Bindings.EvalProtocol, System.Bindings.Consts;

/// <summary>Constructs a scope that contains the built-in operators applied to
/// integers, extended, string.</summary>
/// <returns>The scope containing the built-in operators.</returns>
function BasicOperators: IScope;
/// <summary>Constructs a scope that contains the built-in constant values such
/// as nil, true, false and others.</summary>
/// <returns>The scope containing the constant values.</returns>
function BasicConstants: IScope;

type
  /// <summary>Scope that wrapps only one association between a method name
  /// and an IInvokable interface wrapper. </summary>
  TPairScope = class(TInterfacedObject, IScope, IScopeEx)
  private
    FPair: TPair<string, IInvokable>;
  public
    constructor Create(const MethodName: string; MethodInvokable: IInvokable);

    { IScope }
    function Lookup(const Name: string): IInterface; overload;

    { IScopeEx }
    function Lookup(Obj: TObject): IInterface; overload;
  end;

  /// <summary>Some object members such as indexed properties and methods may
  /// return different results based on the input parameters they are given.
  /// These results are wrapped by specific wrappers. The number of result wrappers
  /// present in the result scope indicate the number of distinct calls to
  /// that object member that has to return values based on input parameters.
  /// Internal engine wrappers use this scope type to store multiple result
  /// wrappers for their parameterized object members. The order in which
  /// the result wrappers are stored is very important because this order is
  /// directly dependent with the parse order of the distinct issues of the
  /// object member for which the result wrappers are stored.</summary>
  TObjectMemberGroupScope = class(TInterfacedObject, IScopeEnumerable)
  public
    type
      TWrappers = TList<IInterface>;
  private
    FWrappers: TWrappers;
  public
    constructor Create;
    destructor Destroy; override;

    /// <summary>Stores the result wrappers in a list. The order in which the
    /// result wrappers are stored is directly related to parse order of the
    /// distinct issues of the object member whose result wrappers are stored here.</summary>
    property Wrappers: TWrappers read FWrappers;

    { IScopeEnumerable }
    function GetEnumerator: IScopeEnumerator; inline;

    { Enumerators }
    type
      TWrappersEnumerator = class(TInterfacedObject, IScopeEnumerator)
      private
        FScope: TObjectMemberGroupScope;
        FListEnumerator: TWrappers.TEnumerator;
      public
        constructor Create(Scope: TObjectMemberGroupScope);
        destructor Destroy; override;

        { IScopeEnumerator }
        function GetCurrent: IInterface;
        function MoveNext: Boolean;
        property Current: IInterface read GetCurrent;
      end;
  end;

  /// <summary>
  /// A simple key-value scope. Most scopes are like this. The engine
  /// uses internally such scopes to store associations between token names
  /// and their wrappers.</summary>
  TDictionaryScope = class(TInterfacedObject, IScope, IScopeEx, IScopeEnumerable)
  public
    type
      TMap = TDictionary<string,IInterface>;
  private
    FMap: TMap;
  public
    constructor Create;
    destructor Destroy; override;
    property Map: TMap read FMap;

    { IScope }
    function Lookup(const Name: string): IInterface; overload;

    { IScopeEx }
    function Lookup(Obj: TObject): IInterface; overload;

    { IScopeEnumerable }
    function GetEnumerator: IScopeEnumerator; inline;

    { Enumerators }
    type
      /// <summary>Enumerates all the wrappers inside the dictionary scope.</summary>
      TWrappersEnumerator = class(TInterfacedObject, IScopeEnumerator)
      private
        FScope: TDictionaryScope;
        FMapEnumerator: TMap.TPairEnumerator;
      public
        constructor Create(Scope: TDictionaryScope);
        destructor Destroy; override;

        { IScopeEnumerator }
        function GetCurrent: IInterface;
        function MoveNext: Boolean;
        property Current: IInterface read GetCurrent;
      end;
  end;

  /// <summary>
  /// Lets you merge scopes, like including units, or local vs global.
  /// The lookups try inner scope first, then fall back to outer scope.</summary>
  TNestedScope = class(TInterfacedObject, IInterface, IScope, IScopeEx, IScopeEnumerable, IScopeSelf)
  private
    FOuter: IScope;
    FInner: IScope;
  public
    constructor Create(const AOuter, AInner: IScope);

    /// <summary>The inner scope attached to the nested scope.</summary>
    property Inner: IScope read FInner;
    /// <summary>The outer scope attached to the nested scope.</summary>
    property Outer: IScope read FOuter;

    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;

    { IScopeSelf}
    function GetSelf: IInterface;

    { IScope }
    function Lookup(const Name: string): IInterface; overload;

    { IScopeEx }
    function Lookup(Obj: TObject): IInterface; overload;

    { IScopeEnumerable }
    function GetEnumerator: IScopeEnumerator;

  public type
    TWrapperEnumerator = class(TInterfacedObject, IScopeEnumerator)
    protected type
      TWrappers = array of IInterface;
    private
      FScope: TNestedScope;
      FWrappers: TWrappers;
      FIndex: Integer;
    public
      constructor Create(const Scope: TNestedScope);

      { IScopeEnumerator }
      function GetCurrent: IInterface;
      function MoveNext: Boolean;
      property Current: IInterface read GetCurrent;
    end;
  end;

  /// <summary>Associates a scope with a given name in order to let the user
  /// structure its routines under namespaces to avoid engine confusion i.e.
  /// between properties and system functions with the same name</summary>
  TNamespaceScope = class(TInterfacedObject, IScope, IScopeEnumerable)
  private
    FName: String;
    FScope: IScope;
  public
    constructor Create(const Name: String; const Scope: IScope);

    { IScope }
    function Lookup(const Name: string): IInterface; inline;

                                                                                             
// What happens if GetEnumerator returns nil? If it works with nil, you just have to call
// Supports(FScope, IScopeEnumerable, ScopeEnumerable) and ScopeEnumerable.GetEnumerator()

    { IScopeEnumerator }
    function GetEnumerator: IScopeEnumerator;

    /// <summary>Denotes the name of of the namespace</summary>
    property Name: String read FName;
    /// <summary>The scope associated with the name</summary>
    property Scope: IScope read FScope;

  public type
    /// <summary>Makes it possible to access the subscope of a namespace scope.</summary>
    TWrapperEnumerator = class(TInterfacedObject, IScopeEnumerator)
    private
      FScope: TNamespaceScope;
      FEnumerated: Boolean;
    public
      constructor Create(const Scope: TNamespaceScope);

      { IScopeEnumerator }
      function GetCurrent: IInterface;
      function MoveNext: Boolean;
      property Current: IInterface read GetCurrent;
    end;
  end;

  // One way to handle overloads:
  
  TValueConverter = class
  private type
    TConvPair = record
      FromType: PTypeInfo;
      ToType: PTypeInfo;
      constructor Create(AFrom, ATo: PTypeInfo);
    end;
  private
    FConversions: TDictionary<TConvPair,TFunc<TValue,TValue>>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddConversion(AFrom, ATo: PTypeInfo; AFunc: TFunc<TValue,TValue>);
    function CanConvert(AFrom, ATo: PTypeInfo): Boolean;
    function Convert(AValue: TValue; ATo: PTypeInfo): TValue;
  end;
  
  TOverload = class(TObject)
  private
    FParamTypes: TArray<PTypeInfo>;
    FBody: TFunc<TArray<TValue>,TValue>;
  public
    constructor Create(const ParamTypes: array of PTypeInfo;
      const Body: TFunc<TArray<TValue>,TValue>);
  end;
  
  TOverloadGroup = class(TInterfacedObject, IInvokable)
  private
    FName: string;
    FConverter: TValueConverter;
    FArity: Integer;
    FList: TList<TOverload>;
  public
    constructor Create(AConverter: TValueConverter; const AName: string);
    destructor Destroy; override;
    // Group takes ownership of added overloads.
    procedure AddOverload(AOverload: TOverload);
    property Name: string read FName;
    function Invoke(const Args: TArray<IValue>): IValue;
  end;

implementation

uses
  System.Bindings.Evaluator, System.Bindings.Search;

{ TDictionaryScope }

constructor TDictionaryScope.Create;
begin
  // case sensitive for now
  FMap := TMap.Create;
end;

destructor TDictionaryScope.Destroy;
begin
  FMap.Free;
  inherited;
end;

function TDictionaryScope.GetEnumerator: IScopeEnumerator;
begin
  Result := TWrappersEnumerator.Create(Self);
end;

function TDictionaryScope.Lookup(Obj: TObject): IInterface;
var
  LWrapper: IInterface;
  LScopeEnum: IScopeEnumerable;
  LMemberInst: IInterface; // wrapper for a member instance
begin
                                                                              
// it must check whether the instances of the groups wrap Obj

  Result := nil;
  // cycle through the groups contained in the scope
  for LWrapper in Map.Values do
  begin
    // the scope may contain directly object wrappers
    if TBindingSearch.IsObjectWrapper(LWrapper, Obj) then
      Exit(LWrapper)
    else // and it may also contain group wrappers
      if Supports(LWrapper, IGroup) and Supports(LWrapper, IScopeEnumerable, LScopeEnum) then
        // cycle through the member instances contained in a group
        for LMemberInst in LScopeEnum do
          if TBindingSearch.IsObjectWrapper(LMemberInst, Obj) then
            Exit(LMemberInst);
  end;
end;

function TDictionaryScope.Lookup(const Name: string): IInterface;
begin
  FMap.TryGetValue(Name, Result);
end;

{ TNestedScope }

constructor TNestedScope.Create(const AOuter, AInner: IScope);
begin
  inherited Create;

  FOuter := AOuter;
  FInner := AInner;
end;

function TNestedScope.Lookup(const Name: string): IInterface;
begin
  Result := Inner.Lookup(Name);
  if Result = nil then
    Result := Outer.Lookup(Name);
end;

function TNestedScope.GetEnumerator: IScopeEnumerator;
begin
//  Result := TWrappersEnumerator.Create(Self);
  Result := TWrapperEnumerator.Create(Self);
end;

function TNestedScope.GetSelf: IInterface;
var
  ScopeSelf: IScopeSelf;
begin
  Result := nil;
  if Supports(FInner, IScopeSelf, ScopeSelf) then
    Result := ScopeSelf.GetSelf;
  if Result = nil then
    if Supports(FOuter, IScopeSelf, ScopeSelf) then
      Result := ScopeSelf.GetSelf;
end;

function TNestedScope.Lookup(Obj: TObject): IInterface;
var
  LInnerEx: IScopeEx;
  LOuterEx: IScopeEx;
begin
  Result := nil;

  if Supports(FInner, IScopeEx, LInnerEx) then
    Result := LInnerEx.Lookup(Obj);

  if (Result = nil) and Supports(FOuter, IScopeEx, LOuterEx) then
    Result := LOuterEx.Lookup(Obj);
end;

function TNestedScope.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    if Supports(Inner, IID, Obj) or Supports(Outer, IID, Obj) then
      Result := S_OK;
end;

{ TValueConverter }

procedure TValueConverter.AddConversion(AFrom, ATo: PTypeInfo;
  AFunc: TFunc<TValue, TValue>);
begin
  FConversions.Add(TConvPair.Create(AFrom, ATo), AFunc);
end;

function TValueConverter.CanConvert(AFrom, ATo: PTypeInfo): Boolean;
begin
  Result := FConversions.ContainsKey(TConvPair.Create(AFrom, ATo));
end;

function TValueConverter.Convert(AValue: TValue; ATo: PTypeInfo): TValue;
begin
  Result := FConversions[TConvPair.Create(AValue.TypeInfo, ATo)](AValue);
end;

constructor TValueConverter.Create;
begin
  FConversions := TDictionary<TConvPair,TFunc<TValue,TValue>>.Create;
end;

destructor TValueConverter.Destroy;
begin
  FConversions.Free;
  inherited;
end;

{ TValueConverter.TConvPair }

constructor TValueConverter.TConvPair.Create(AFrom, ATo: PTypeInfo);
begin
  FromType := AFrom;
  ToType := ATo;
end;

{ TOverload }

constructor TOverload.Create(const ParamTypes: array of PTypeInfo;
  const Body: TFunc<TArray<TValue>,TValue>);
begin
  SetLength(FParamTypes, Length(ParamTypes));
  Move(ParamTypes[0], FParamTypes[0], Length(ParamTypes));
  FBody := Body;
end;

{ TOverloadGroup }

procedure TOverloadGroup.AddOverload(AOverload: TOverload);
begin
  if FList.Count = 0 then
    FArity := Length(AOverload.FParamTypes)
  else if Length(AOverload.FParamTypes) <> FArity then
    raise EEvaluatorError.CreateFmt(sOverloadGroupArgCount, [Name, FArity]);
  FList.Add(AOverload);
end;

constructor TOverloadGroup.Create(AConverter: TValueConverter; const AName: string);
begin
  FConverter := AConverter;
  FName := AName;
  FList := TObjectList<TOverload>.Create(True);
end;

destructor TOverloadGroup.Destroy;
begin
  FList.Free;
  inherited;
end;

function TOverloadGroup.Invoke(const Args: TArray<IValue>): IValue;
var
  argTypes: TArray<PTypeInfo>;
  
  function IsApplicable(Ov: TOverload): Boolean;
  var
    i: Integer;
  begin
    for i := 0 to Length(Ov.FParamTypes) - 1 do
      if not FConverter.CanConvert(argTypes[i], ov.FParamTypes[i]) then
        Exit(False);
    Result := True;
  end;

type
  TMoreSpecific = set of (msFirst, msSecond);
  
  function MoreSpecific(Ov1, Ov2: TOverload): TMoreSpecific;
  var
    argPref: TMoreSpecific;
    i: Integer;
    p1, p2: PTypeInfo;
  begin
    argPref := [];
    Result := [];
    for i := 0 to Length(Ov1.FParamTypes) - 1 do
    begin
      p1 := Ov1.FParamTypes[i];
      p2 := Ov2.FParamTypes[i];
      if FConverter.CanConvert(p1, p2) then
        Include(argPref, msFirst);
      if FConverter.CanConvert(p2, p1) then
        Include(argPref, msSecond);
      if argPref = [msFirst] then
        Include(Result, msFirst);
      if argPref = [msSecond] then
        Include(Result, msSecond);
      // any other value of argPref (equal, incompat) then it's not useful
      // for preferring one overload over the other.
    end;
  end;
  
var
  i: Integer;
  candidates: TList<TOverload>;
  ov: TOverload;
  pref: TMoreSpecific;
  argValues: TArray<TValue>;
begin
  if Length(Args) <> FArity then
    raise EEvaluatorError.CreateFmt(sNamedMismatchArgCount,
      [Name, FArity, Length(Args)]);
    
  // Get the actual argument types.
  SetLength(argTypes, FArity);
  for i := 0 to FArity - 1 do
    argTypes[i] := Args[i].GetType;
    
  // Match against overloads
  candidates := TList<TOverload>.Create;
  try
    for ov in FList do
    begin
      if not IsApplicable(ov) then
        Continue;
      
      // Prefer more specific overloads.
      pref := [];
      for i := 0 to candidates.Count - 1 do
        pref := pref + MoreSpecific(ov, candidates[i]);
      if pref = [msFirst] then // no existing candidate is as good => remove all
        candidates.Clear;
      candidates.Add(ov);
    end;
    
    if candidates.Count = 0 then
      raise EEvaluatorError.CreateFmt(sOverloadNotFound, [Name]);
    if candidates.Count > 1 then
      raise EEvaluatorError.CreateFmt(sAmbiguousOverloadCall, [Name]);
    
    // We've found a match - set up, convert args and call.
    SetLength(argValues, Length(Args));
    for i := 0 to Length(Args) - 1 do
      argValues[i] := FConverter.Convert(Args[i].GetValue, argTypes[i]);
    candidates[0].FBody(argValues);
  finally
    candidates.Free;
  end;
end;

type
  TValueInvokableBody = reference to function(Args: TArray<TValue>): TValue;
  TValueInvokable = class(TInterfacedObject, IWrapper, IInvokable)
  private
    FArgCount: Integer;
    FBody: TValueInvokableBody;
  public
    constructor Create(ArgCount: Integer; const Body: TValueInvokableBody);
    function Invoke(const Args: TArray<IValue>): IValue;
  end;

var
  G_BasicOperators: IScope;
  G_BasicConstants: IScope;

function GetBasicOperatorValue(Value: TValue; out AOutValue: string): Boolean; overload;
var
  f: Extended;
  i: Int64;
  s: string;
begin
  if not Value.TryAsType<Extended>(f) then
  begin
    if not Value.TryAsType<Int64>(i) then
    begin
      if not Value.TryAsType<string>(s) then
        Exit(False);
    end
    else
      s := IntToStr(i);
  end
  else
    s := FloatToStr(f);
  AOutValue := s;
  Result := True;
end;

function GetBasicOperatorValue(Value: TValue; out AOutValue: Extended): Boolean; overload;
var
  f: Extended;
  i: Int64;
  s: string;
begin
  if not Value.TryAsType<Extended>(f) then
    if not Value.TryAsType<Int64>(i) then
    begin
      if not Value.TryAsType<string>(s) then
        Exit(False)
      else
        if not TryStrToFloat(s, f, EvalFormatSettings) then
          Exit(False);
    end
    else
      f := i;
  AOutValue := f;
  Result := True;
end;

function MakeBasicOperators: IScope;
var
  scope: TDictionaryScope;
begin
  scope := TDictionaryScope.Create;
  Result := scope; // will clean up scope if we exit due to exception

  scope.Map.Add(BuiltinOpName[boAdd], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    fx, fy: Extended;
    sx, sy: string;
  begin
    if not GetBasicOperatorValue(Args[0], fx) then
    begin
      if GetBasicOperatorValue(Args[0], sx) and GetBasicOperatorValue(Args[1], sy) then
        Exit(sx + sy)
      else
        raise EEvaluatorError.CreateFmt(sAddOpFail, [Args[0].ToString, Args[1].ToString]);
    end;

    if not GetBasicOperatorValue(Args[1], fy) then
    begin
      if GetBasicOperatorValue(Args[0], sx) and GetBasicOperatorValue(Args[1], sy) then
        Exit(sx + sy)
      else
        raise EEvaluatorError.CreateFmt(sAddOpFail, [Args[0].ToString, Args[1].ToString]);
    end;

    Result := fx + fy
  end));

  scope.Map.Add(BuiltinOpName[boSubtract], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    fx, fy: Extended;
    sy: string;
  begin
    if not GetBasicOperatorValue(Args[0], fx) then
      raise EEvaluatorError.CreateFmt(sSubtractOpFail, [Args[0].ToString, Args[1].ToString]);
    if not GetBasicOperatorValue(Args[1], fy) then
    begin
      if GetBasicOperatorValue(Args[1], sy) and sy.IsEmpty then
        Exit(fx)
      else
        raise EEvaluatorError.CreateFmt(sSubtractOpFail, [Args[0].ToString, Args[1].ToString]);
    end;
    Result := fx - fy;
  end));

  scope.Map.Add(BuiltinOpName[boMultiply], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    fx, fy: Extended;
  begin
    if not GetBasicOperatorValue(Args[0], fx) then
      raise EEvaluatorError.CreateFmt(sMultiplyOpFail, [Args[0].ToString, Args[1].ToString]);
    if not GetBasicOperatorValue(Args[1], fy) then
      raise EEvaluatorError.CreateFmt(sMultiplyOpFail, [Args[0].ToString, Args[1].ToString]);
    Result := fx * fy;
  end));

  scope.Map.Add(BuiltinOpName[boDivide], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    fx, fy: Extended;
  begin
    if not GetBasicOperatorValue(Args[0], fx) then
      raise EEvaluatorError.CreateFmt(sDivideOpFail, [Args[0].ToString, Args[1].ToString]);
    if not GetBasicOperatorValue(Args[1], fy) then
      raise EEvaluatorError.CreateFmt(sDivideOpFail, [Args[0].ToString, Args[1].ToString]);
    Result := fx / fy;
  end));

  scope.Map.Add(BuiltinOpName[boNegate], TValueInvokable.Create(1, function(Args: TArray<TValue>): TValue
  var
    ix: Int64;
    fx: Extended;
  begin
    if Args[0].TryAsType<Int64>(ix) then
      Result := - ix
    else if Args[0].TryAsType<Extended>(fx) then
      Result := - fx
    else
      raise EEvaluatorError.CreateFmt(sNegateOpFail, [Args[0].ToString]);
  end));

  scope.Map.Add(BuiltinOpName[boEqualTo], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    ix, iy: Int64;
    sx, sy: string;
    fx, fy: Extended;
    bx, by: Boolean;
  begin
    if Args[0].TryAsType<Int64>(ix) and Args[1].TryAsType<Int64>(iy) then
      Result := ix = iy
    else if Args[0].TryAsType<Extended>(fx) and Args[1].TryAsType<Extended>(fy) then
      Result := fx = fy
    else if Args[0].TryAsType<string>(sx) and Args[1].TryAsType<string>(sy) then
      Result := sx = sy
    else if Args[0].TryAsType<Boolean>(bx) and Args[1].TryAsType<Boolean>(by) then
      Result := bx = by
    else
      raise EEvaluatorError.CreateFmt(sCompareOpFail,
        [Args[0].ToString, Args[1].ToString]);
  end));

  scope.Map.Add(BuiltinOpName[boNotEqual], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    ix, iy: Int64;
    sx, sy: string;
    fx, fy: Extended;
    bx, by: Boolean;
  begin
    if Args[0].TryAsType<Int64>(ix) and Args[1].TryAsType<Int64>(iy) then
      Result := ix <> iy
    else if Args[0].TryAsType<Extended>(fx) and Args[1].TryAsType<Extended>(fy) then
      Result := fx <> fy
    else if Args[0].TryAsType<string>(sx) and Args[1].TryAsType<string>(sy) then
      Result := sx <> sy
    else if Args[0].TryAsType<Boolean>(bx) and Args[1].TryAsType<Boolean>(by) then
      Result := bx <> by
    else
      raise EEvaluatorError.CreateFmt(sCompareOpFail,
        [Args[0].ToString, Args[1].ToString]);
  end));

  scope.Map.Add(BuiltinOpName[boLessThan], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    ix, iy: Int64;
    sx, sy: string;
    fx, fy: Extended;
    bx, by: Boolean;
  begin
    if Args[0].TryAsType<Int64>(ix) and Args[1].TryAsType<Int64>(iy) then
      Result := ix < iy
    else if Args[0].TryAsType<Extended>(fx) and Args[1].TryAsType<Extended>(fy) then
      Result := fx < fy
    else if Args[0].TryAsType<string>(sx) and Args[1].TryAsType<string>(sy) then
      Result := sx < sy
    else if Args[0].TryAsType<Boolean>(bx) and Args[1].TryAsType<Boolean>(by) then
      Result := bx < by
    else
      raise EEvaluatorError.CreateFmt(sCompareOpFail,
        [Args[0].ToString, Args[1].ToString]);
  end));

  scope.Map.Add(BuiltinOpName[boLessEqual], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    ix, iy: Int64;
    sx, sy: string;
    fx, fy: Extended;
    bx, by: Boolean;
  begin
    if Args[0].TryAsType<Int64>(ix) and Args[1].TryAsType<Int64>(iy) then
      Result := ix <= iy
    else if Args[0].TryAsType<Extended>(fx) and Args[1].TryAsType<Extended>(fy) then
      Result := fx <= fy
    else if Args[0].TryAsType<string>(sx) and Args[1].TryAsType<string>(sy) then
      Result := sx <= sy
    else if Args[0].TryAsType<Boolean>(bx) and Args[1].TryAsType<Boolean>(by) then
      Result := bx <= by
    else
      raise EEvaluatorError.CreateFmt(sCompareOpFail,
        [Args[0].ToString, Args[1].ToString]);
  end));

  scope.Map.Add(BuiltinOpName[boGreaterThan], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    ix, iy: Int64;
    sx, sy: string;
    fx, fy: Extended;
    bx, by: Boolean;
  begin
    if Args[0].TryAsType<Int64>(ix) and Args[1].TryAsType<Int64>(iy) then
      Result := ix > iy
    else if Args[0].TryAsType<Extended>(fx) and Args[1].TryAsType<Extended>(fy) then
      Result := fx > fy
    else if Args[0].TryAsType<string>(sx) and Args[1].TryAsType<string>(sy) then
      Result := sx > sy
    else if Args[0].TryAsType<Boolean>(bx) and Args[1].TryAsType<Boolean>(by) then
      Result := bx > by
    else
      raise EEvaluatorError.CreateFmt(sCompareOpFail,
        [Args[0].ToString, Args[1].ToString]);
  end));

  scope.Map.Add(BuiltinOpName[boGreaterEqual], TValueInvokable.Create(2, function(Args: TArray<TValue>): TValue
  var
    ix, iy: Int64;
    sx, sy: string;
    fx, fy: Extended;
    bx, by: Boolean;
  begin
    if Args[0].TryAsType<Int64>(ix) and Args[1].TryAsType<Int64>(iy) then
      Result := ix >= iy
    else if Args[0].TryAsType<Extended>(fx) and Args[1].TryAsType<Extended>(fy) then
      Result := fx >= fy
    else if Args[0].TryAsType<string>(sx) and Args[1].TryAsType<string>(sy) then
      Result := sx >= sy
    else if Args[0].TryAsType<Boolean>(bx) and Args[1].TryAsType<Boolean>(by) then
      Result := bx >= by
    else
      raise EEvaluatorError.CreateFmt(sCompareOpFail,
        [Args[0].ToString, Args[1].ToString]);
  end));

end;

function MakeBasicConstants: IScope;
var
  Scope: TDictionaryScope;
begin
  Scope := TDictionaryScope.Create;
  Result := Scope;

  Scope.Map.Add('nil', TValueWrapper.Create(nil));
  Scope.Map.Add('True', TValueWrapper.Create(true));
  Scope.Map.Add('False', TValueWrapper.Create(false));
  Scope.Map.Add('Pi', TValueWrapper.Create(pi));
end;

function BasicOperators: IScope;
begin
  if G_BasicOperators = nil then
  begin
    Result := MakeBasicOperators;
    if TInterlocked.CompareExchange(Pointer(G_BasicOperators), Pointer(Result), nil) = nil then
      Pointer(Result) := nil;
  end;
  Result := G_BasicOperators;
end;

function BasicConstants: IScope;
begin
  if G_BasicConstants = nil then
  begin
    Result := MakeBasicConstants;
    if TInterlocked.CompareExchange(Pointer(G_BasicConstants), Pointer(Result), nil) = nil then
      Pointer(Result) := nil;
  end;
  Result := G_BasicConstants;
end;

{ TValueInvokable }

constructor TValueInvokable.Create(ArgCount: Integer;
  const Body: TValueInvokableBody);
begin
  FBody := Body;
  FArgCount := ArgCount;
end;

function TValueInvokable.Invoke(const Args: TArray<IValue>): IValue;
var
  argValues: TArray<TValue>;
  i: Integer;
begin
  if Length(Args) <> FArgCount then
    raise EEvaluatorError.CreateFmt(sMismatchArgCount,
      [FArgCount, Length(Args)]);
  SetLength(argValues, FArgCount);
  for i := 0 to FArgCount - 1 do
    argValues[i] := Args[i].GetValue;
  Result := TValueWrapper.Create(FBody(argValues));
end;

{ TDictionaryScope.TDictionaryScopeEnumerator }

constructor TDictionaryScope.TWrappersEnumerator.Create(
  Scope: TDictionaryScope);
begin
  inherited Create;

  FScope := Scope;
  FMapEnumerator := TMap.TPairEnumerator.Create(FScope.Map);
end;

destructor TDictionaryScope.TWrappersEnumerator.Destroy;
begin
  FMapEnumerator.Free;

  inherited;
end;

function TDictionaryScope.TWrappersEnumerator.GetCurrent: IInterface;
begin
  Result := FMapEnumerator.Current.Value;
end;

function TDictionaryScope.TWrappersEnumerator.MoveNext: Boolean;
begin
  Result := FMapEnumerator.MoveNext;
end;

{ TPairScope }

constructor TPairScope.Create(const MethodName: string;
  MethodInvokable: IInvokable);
begin
  FPair := TPair<string,IInvokable>.Create(MethodName, MethodInvokable);
end;

function TPairScope.Lookup(const Name: string): IInterface;
begin
  Result := nil;
  if FPair.Key = Name then
    Result := FPair.Value;
end;

function TPairScope.Lookup(Obj: TObject): IInterface;
var
  LValue: IValue;
begin
  Result := nil;
  if Supports(FPair.Value, IValue, LValue) and TBindingSearch.IsObjectWrapper(LValue) then
    if Obj = LValue.GetValue.AsObject then
      Exit(LValue);
end;

{ TObjectMemberResultScope.TWrappersEnumerator }

constructor TObjectMemberGroupScope.TWrappersEnumerator.Create(
  Scope: TObjectMemberGroupScope);
begin
  inherited Create;

  FScope := Scope;
  FListEnumerator := TWrappers.TEnumerator.Create(FScope.FWrappers);
end;

destructor TObjectMemberGroupScope.TWrappersEnumerator.Destroy;
begin
  FListEnumerator.Free;

  inherited;
end;

function TObjectMemberGroupScope.TWrappersEnumerator.GetCurrent: IInterface;
begin
  Result := FListEnumerator.Current;
end;

function TObjectMemberGroupScope.TWrappersEnumerator.MoveNext: Boolean;
begin
  Result := FListEnumerator.MoveNext;
end;

{ TObjectMemberResultScope }

constructor TObjectMemberGroupScope.Create;
begin
  inherited;

  FWrappers := TWrappers.Create;
end;

destructor TObjectMemberGroupScope.Destroy;
begin
  FWrappers.Free;

  inherited;
end;

function TObjectMemberGroupScope.GetEnumerator: IScopeEnumerator;
begin
  Result := TWrappersEnumerator.Create(Self);
end;

{ TNestedScope.TWrappersEnumerator.TEnumeratorRec }
{
constructor TNestedScope.TWrappersEnumerator.TEnumeratorRec.Create(
  const AEnumerable: IScopeEnumerable; const AEnumerator: IScopeEnumerator);
begin
  Enumerable := AEnumerable;
  Enumerator := AEnumerator;
  Included := False;
end;
 }

{ TNestedScope.TWrprEnumerator }

constructor TNestedScope.TWrapperEnumerator.Create(const Scope: TNestedScope);
begin
  inherited Create;

  FScope := Scope;
  FWrappers := TWrappers.Create(FScope.FInner, FScope.FOuter);
  FIndex := Low(FWrappers) - 1;
end;

function TNestedScope.TWrapperEnumerator.GetCurrent: IInterface;
begin
  if FIndex <= High(FWrappers) then
    Result := FWrappers[FIndex]
  else
    Result := nil;
end;

function TNestedScope.TWrapperEnumerator.MoveNext: Boolean;
var
  Finish: Boolean;
begin
  repeat
    Inc(FIndex);

    Finish := FIndex > High(FWrappers);
    if Finish then
      Result := False
    else
      Result := Assigned(FWrappers[FIndex])
  until Finish or Result;
end;

{ TNamespaceScope }

constructor TNamespaceScope.Create(const Name: String; const Scope: IScope);
begin
  inherited Create;

  FName := Name;
  FScope := Scope;
end;

function TNamespaceScope.GetEnumerator: IScopeEnumerator;
begin

end;

function TNamespaceScope.Lookup(const Name: string): IInterface;
begin
  if Name = FName then
    Result := FScope.Lookup(Name)
  else
    Result := nil;
end;

{ TNamespaceScope.TWrapperEnumerator }

constructor TNamespaceScope.TWrapperEnumerator.Create(
  const Scope: TNamespaceScope);
begin
  inherited Create;

  FScope := Scope;
end;

function TNamespaceScope.TWrapperEnumerator.GetCurrent: IInterface;
begin
  Result := FScope;
end;

function TNamespaceScope.TWrapperEnumerator.MoveNext: Boolean;
begin
  Result := FEnumerated;
  FEnumerated := True;
end;

end.
