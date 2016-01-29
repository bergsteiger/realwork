{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "System.Bindings.Outputs"'}    {Do not Localize}
unit System.Bindings.Outputs;

interface

uses
  System.SysUtils, System.Rtti, System.TypInfo, System.Generics.Collections, System.Classes, System.StrUtils, System.Bindings.Evaluator,
  System.Bindings.ObjEval, System.Bindings.EvalProtocol, System.Bindings.EvalSys, System.Bindings.Consts;

type
  EBindOutputError = class(Exception);
  EBindOutputCallbackError = class(Exception);
  EBindConverterError = class(Exception);

  /// <summary>Factory for managing callbacks for assignment to output properties of classes.</summary>
  TBindingCallbackFactory = class
  public type
    /// <summary>Callback signature for TBindingCallbackFactory allowing custom object/object-property assignment</summary>    ///
    TBindingCallback = reference to function(const Obj: TObject; const Val: TValue): Boolean;
  private type
    /// <summary>List of TBindingCallbacks</summary>
    TBindingCallbacksList = TList<TBindingCallback>;
    /// <summary>Dictionary of callbacks</summary>
    TBindingCallbacks = TObjectDictionary<string, TBindingCallbacksList>;
    class var
      FCallbacks: TBindingCallbacks;
    class function Instance: TBindingCallbacks;
    class function GetPair(const ClassType: string; const PropertyName: string): string;
  public
    class destructor Destroy;
    /// <summary>Associate and register a callback with classtypes and class-properties.</summary>
    /// <param name="ClassTypes">Array of class types to associate with the current callback</param>
    /// <param name="Properties">Array of class properties to associate with the current callback</param>
    /// <param name="PropCallback">Custom TBindingCallback for current class and class-properties</param>
    class procedure RegisterCallback(const ClassTypes: Array of string; const Properties: Array of string; const PropCallback: TBindingCallback);
    /// <summary>Finds a registered callback given a class type and class-property.</summary>
    /// <param name="ClassType">Class type associated with a callback</param>
    /// <param name="PropertyName">Class property name associated with a callback</param>
    /// <param name="PropCallbacks">List of callbacks found given classtype and propertyname</param>
    /// <returns>Returns true if any callbacks are found</returns>
    class function GetCallback(const ClassType: string; const PropertyName: string; var PropCallbacks: TBindingCallbacksList): Boolean;
  end;

  /// <summary>Bound Output or LValue custom conversion routine signature.</summary>
  TConvertProc = reference to procedure(const InValue: TValue; var OutValue: TValue);
  /// <summary>Bound Output or LValue custom conversion routine signature.</summary>
  TConvertProc2 = reference to procedure(const InValue: TValue; ATo: PTypeInfo; var OutValue: TValue);
  /// <summary>Conversion Pair of From and To TypeInfo</summary>
  TConvertPair = record
    FromType: PTypeInfo;
    ToType: PTypeInfo;
    constructor Create(AFrom, ATo: PTypeInfo);
  end;
  TConverterDescription = record
  private
    FConvertProc: TConvertProc;
    FConvertProc2: TConvertProc2;
  strict private
    FID: string;
    FDisplayName: string;
    FUnitName: string;
    FDefaultEnabled: Boolean;
    FFrameworkClass: TPersistentClass;
    FDescription: string;
  public
    constructor Create(AConvertProc: TConvertProc; const AID, ADisplayName, AUnitName: string;
      ADefaultEnabled: Boolean; const ADescription: string; AFrameworkClass: TPersistentClass); overload;
    constructor Create2(AConvertProc2: TConvertProc2; const AID, ADisplayName, AUnitName: string;
      ADefaultEnabled: Boolean; const ADescription: string; AFrameworkClass: TPersistentClass); overload;
    property ID: string read FID;
    property DisplayName: string read FDisplayName;
    property UnitName: string read FUnitName;
    property DefaultEnabled: Boolean read FDefaultEnabled;
    property FrameWorkClass: TPersistentClass read FFrameworkClass;
    property Description: string read FDescription;
  end;

  IValueRefConverter = interface
    /// <summary>Determines whether a converter is available given a From/To TypeInfo pair</summary>
    /// <param name="AFrom">From TypeInfo of potential converter</param>
    /// <param name="ATo">To TypeInfo of potential converter</param>
    /// <returns>Returns true if converter for From/To types is available</returns>
    function CanConvert(AFrom, ATo: PTypeInfo): Boolean;
    /// <summary>Converts a supplied TValue given a desired output type</summary>
    /// <param name="InValue">TValue to be converted</param>
    /// <param name="ATo">Desired output TValue type</param>
    /// <param name="OutValue">Converted TValue of type ATo</param>
    procedure Convert(const InValue: TValue; ATo: PTypeInfo; var OutValue: TValue);
  end;

  /// <summary>Converter collection to allow handling type coercion with references to objects for class instances.</summary>
  TValueRefConverter = class(TInterfacedObject, IValueRefConverter)
  public type
    /// <summary>Dictionary of conversion routines</summary>
    TValueConvDict = TDictionary<TConvertPair,TConverterDescription>;
  private
    FConversions: TValueConvDict;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>Dictionary of supported conversions</summary>
    /// <returns>Returns the dictionary of supported conversion routines</returns>
    property Converters: TValueConvDict read FConversions;
    /// <summary>Add conversion to the current converter</summary>
    /// <param name="ConvPair">Conversion pair associated with current conversion routine</param>
    /// <param name="AConverter"></param>
    procedure AddConversion(ConvPair: TConvertPair; AConverter: TConverterDescription); overload;
    procedure AddConversion(ConvPairs: TArray<TConvertPair>; AConverter: TConverterDescription); overload;
    /// <summary>Removes all previously added converters</summary>
    procedure ClearConverters;
    /// <summary>Determines whether a converter is available given a From/To TypeInfo pair</summary>
    /// <param name="AFrom">From TypeInfo of potential converter</param>
    /// <param name="ATo">To TypeInfo of potential converter</param>
    /// <returns>Returns true if converter for From/To types is available</returns>
    function CanConvert(AFrom, ATo: PTypeInfo): Boolean;

    function GetConverter(AFrom, ATo: PTypeInfo; FindBestMatch: Boolean = True): TConvertProc2;

    /// <summary>Converts a supplied TValue given a desired output type</summary>
    /// <param name="InValue">TValue to be converted</param>
    /// <param name="ATo">Desired output TValue type</param>
    /// <param name="OutValue">Converted TValue of type ATo</param>
    procedure Convert(const InValue: TValue; ATo: PTypeInfo; var OutValue: TValue);
  end;

  /// <summary>Factory for registering custom converter routines to be used in bound output assignment.</summary>
  TValueRefConverterFactory = class
  private
    type TConverterValuePair = TPair<TList<TConvertPair>,TConverterDescription>;
    type TNamedOutputConverters = TDictionary<string, TPair<TList<TConvertPair>, TConverterDescription>>;
    class var FRegisteredConversions: TNamedOutputConverters;
    class var FFreeList: TObjectList<TObject>;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure RegisterConversion(AFrom,
      ATo: PTypeInfo; AConverter: TConverterDescription); overload;

    class procedure UnRegisterConversion(const ConverterID: string); overload;
    class procedure UnRegisterConversion(AFrom: PTypeInfo; ATo: PTypeInfo); overload;

    class function HasConverter(const ConverterID: string): Boolean;

    /// <summary>Register conversion to the factory</summary>
    /// <param name="AFrom">Array of From TypeInfo for current conversion routine</param>
    /// <param name="ATo">Array of To TypeInfo for current conversion routine</param>
    /// <param name="AConverter"></param>
    class procedure RegisterConversion(AFrom: Array of PTypeInfo; ATo: Array of PTypeInfo; AConverter: TConverterDescription); overload;
    class procedure RegisterConversion(AFrom: TArray<PTypeInfo>; ATo: TArray<PTypeInfo>; AConverter: TConverterDescription); overload;
    class procedure UnRegisterConversion(AFrom: Array of PTypeInfo; ATo: Array of PTypeInfo); overload;
    class procedure UnRegisterConversion(AFrom: TArray<PTypeInfo>; ATo: TArray<PTypeInfo>); overload;
    /// <summary>Removes all previously registered converters from the factory</summary>
    class procedure ClearRegisteredConverters;

    /// <summary>Instantiates a TValueRefConverter</summary>
    /// <param name="ConverterIDs">Array of IDs used to filter which conversions are available in returned converter</param>
    /// <returns>A TValueRefConverter which may contain converters determined by parameters</returns>
    class function GetConverter(ConverterIDs: TArray<string>): TValueRefConverter;
    class function GetConverterDescriptions: TArray<TConverterDescription>;
    class function GetConverterUnitName(const ConverterID: string): string;
    class function GetConverterFrameworkClass(const ConverterID: string): TPersistentClass;
  end;


  TBindingSetValueEvent = TProc<TValue>;
  TBindingAssignValueRec = record
    Expression: TObject;
    OutObj: TObject;
    OutProp: string;
    constructor Create(Expr: TObject; Obj: TObject; Prop: string);
  end;


  TBindingAssigningValueEvent = procedure(AssignValueRec: TBindingAssignValueRec;
     var Value: TValue; var Handled: Boolean) of object;
  TBindingAssignedValueEvent = procedure(AssignValueRec: TBindingAssignValueRec;
     const Value: TValue) of object;
  TBindingEvalErrorEvent = procedure(AException: Exception) of object;
  TBindingLocationUpdatedEvent = procedure(AOldLocation, ANewLocation: ILocation) of object;

  TBindOutValueFunc = TFunc<IValue>;

  /// <summary>Collection of outputs and routines used by data binding or other TValue based data propagator.</summary>
  TBindingOutput = class
  public
    type
      /// <summary>Output destination pair: classtype and property</summary>
      TOutputPair = TPair<TObject, String>;
      /// <summary>Pair between the output location and its notifier</summary>
      TLocationRec = record
      public
        /// <summary>The location to which the output value is set.</summary>
        Location: ILocation;
        /// <summary>Whether or not the location is based on an expression and needs to be recomputed.</summary>
        IsExpression: Boolean;
        /// <summary>Notifier associated with the location used to notify the
        /// system that the object member wrapped by the location has changed.</summary>
        Notifier: IInterface;
        /// <summary>Maintains a reference to the output compiled expression that
        /// generated the location. It is necessary because the internal wrappers
        /// are structured in such a way that they depend on information sustained
        /// only by a reference to ICompiledBinding.</summary>
        /// <remarks>Locations that are not generated by output expressions have
        /// this parameter set to nil.</remarks>
        CompiledBinding: ICompiledBinding;
        /// <summary>Keeps a reference to the input scope used by the output
        /// compiled expression. The scope is necessary in case the expression
        /// may be reevaluated at certain points.</summary>
        /// <remarks>Locations that are not generated by output expressions have
        /// this parameter set to nil.</remarks>
        Scope: IScope;

        constructor Create(const ALocation: ILocation; const ANotifier: IInterface;
          const ACompiledBinding: ICompiledBinding; const AScope: IScope; const AIsExpression: Boolean);
      end;
      /// <summary>List of output ILocations to assign output to</summary>
      TLocations = TList<TLocationRec>;
      /// <summary>Pair consisting of a location and an output pair record</summary>
      TDestinationPair = TPair<ILocation, TOutputPair>;
      /// <summary>Dictionary of output destination pairs</summary>
      TDestinations = TDictionary<ILocation, TOutputPair>;
      /// <summary>List of callback events to call when assigning an output</summary>
      TOutputProcs = TList<TBindingSetValueEvent>;
      TOption = (opNotify);
      TOptions = set of TOption;
  private
    FOwner: TObject;
    FOutputs: TDestinations;
    FLocations: TLocations;
    FOutputProcs: TOutputProcs;
    FAssigningValueEvent: TBindingAssigningValueEvent;
    FAssignedValueEvent: TBindingAssignedValueEvent;
    FEvalErrorEvent: TBindingEvalErrorEvent;
    FLocationUpdatedEvent: TBindingLocationUpdatedEvent;
    //FOwnsValueConverter: Boolean;
    FValueConverter: IValueRefConverter;
    FOutputConverterIDs: TList<string>;
    FNotify: Boolean;
  protected
    function MakeLocation(AObject: TObject; const PropertyName: String): TLocationRec; overload;
    function MakeLocation(Scope: IScope; const Expr: string;
      out LocationRec: TLocationRec): Boolean; overload;
    function UpdateOutputLocation(var LocationRec: TLocationRec): Boolean;
    function MakeObjScope(const Obj: TObject): IScope;
  public
    constructor Create(AOwner: TObject; AOptions: TOptions = [opNotify]);
    destructor Destroy; override;

    /// <summary>Adds a method to be called when an input changes and gets propagated</summary>
    /// <param name="AProc">Callback event to call when assigning an output</param>
    procedure AddProc(AProc: TBindingSetValueEvent);
    /// <summary>Adds a scope and expression to the outputs</summary>
    /// <param name="AScope">Scope to be used in string expression</param>
    /// <param name="Expression">String expression to evaluate an ILocation (destination)</param>
    procedure Add(AScope: IScope; const Expression: string); overload;
    /// <summary>Adds the specified output to the Outputs map</summary>
    /// <param name="AObject">Object to be set when assigning output value</param>
    /// <param name="PropertyName">Property to set when assigning output value</param>
    procedure Add(AObject: TObject; const PropertyName: string); overload;
    /// <summary>Sets all the outputs and output procs with Value</summary>
    /// <param name="AExpression">TBindingExpression object</param>
    /// <param name="ValueFunc">Value to assign to all output destination and procs</param>
    procedure SetValue(AExpression: TObject; const ValueFunc: TBindOutValueFunc);
    procedure AddConverter(const ConverterID: string);

    /// <summary>Obtains suplimentary information about a given location.</summary>
    /// <param name="Location">The location for which the information is going to be
    /// returned.</param>
    /// <param name="LocationRec">The suplimentary information returned for the
    /// given location.</param>
    /// <returns>True if the suplimentary location information has been successfuly
    /// returned. If the function returns False, then LocationRec must not be used
    /// as if it contained valid information.</returns>
    /// <remarks>The location can be only a location of a </remarks>
    function GetLocationRec(const Location: ILocation; out LocationRec: TLocationRec): Boolean;

    /// <summary>The owner of the binding output. Usually, the owner points to a
    /// binding expression.</summary>
    property Owner: TObject read FOwner;
    /// <summary>Dictionary of output pairs (objects and properties)</summary>
    property Destinations: TDestinations read FOutputs;
    /// <summary>An expression can also call routines when evaluated which takes in the output value as a parameter</summary>
    property Procs: TOutputProcs read FOutputProcs;
    /// <summary>Value converter which contains different in/out conversion routines</summary>
    property ValueConverter: IValueRefConverter read FValueConverter write FValueConverter;
    /// <summary>Notify when set value</summary>
    property Notify: Boolean read FNotify write FNotify;

    /// <summary>Events</summary>
    property OnAssignedValue: TBindingAssignedValueEvent read FAssignedValueEvent write FAssignedValueEvent;
    property OnAssigningValue: TBindingAssigningValueEvent read FAssigningValueEvent write FAssigningValueEvent;
    property OnEvalErrorEvent: TBindingEvalErrorEvent read FEvalErrorEvent write FEvalErrorEvent;
    property OnLocationUpdated: TBindingLocationUpdatedEvent read FLocationUpdatedEvent write FLocationUpdatedEvent;
  end;


implementation

uses
  System.Bindings.NotifierContracts, System.Bindings.Graph,
  System.Bindings.Helper, System.Bindings.Expression,
                                                                                                   
// solution by placing an Owner property in TBindingExpression that depicts the manager
  System.Bindings.ExpressionDefaults,
  System.Bindings.Manager;

// returns the manager of the given Owner object; it is used in conjuction with
// TBindingOutput to avoid circular reference
function GetOwnerManager(Owner: TObject): TBindingManager;
begin
  Result := nil;
  if Assigned(Owner) and (Owner is TBindingExpressionDefault) then
    Result := TBindingExpressionDefault(Owner).Manager;
end;

function GetClassType(TypeInfo: PTypeInfo): TClass;
begin
  if Assigned(TypeInfo) and (TypeInfo.Kind = tkClass) then
    Result := TRttiContext.Create.GetType(TypeInfo).AsInstance.MetaclassType
  else
    Result := nil;
end;

{ TBindingCallbackFactory }

class procedure TBindingCallbackFactory.RegisterCallback(
  const ClassTypes: Array of string; const Properties: Array of string;
  const PropCallback: TBindingCallback);
var
  Pair: string;
  List: TBindingCallbacksList;
  I, J: Integer;
begin
  for J := 0 to Length(ClassTypes) -1 do
    for I := 0 to Length(Properties) -1 do
    begin
      Pair := GetPair(ClassTypes[J], Properties[I]);

      if Instance.ContainsKey(Pair) then
        List := Instance.Items[Pair]
      else
      begin
        List := TBindingCallbacksList.Create;
        Instance.Add(
          Pair,
          List
        );
      end;
      List.Add(PropCallback);
    end;
end;

class destructor TBindingCallbackFactory.Destroy;
begin
  FCallbacks.Free;
end;

class function TBindingCallbackFactory.GetCallback(
  const ClassType: string; const PropertyName: string;
  var PropCallbacks: TBindingCallbacksList): Boolean;
var
  Pair: string;
  List: TList<TBindingCallback>;
  I: Integer;
begin
  Result := False;
  PropCallbacks := nil;
  Pair := GetPair(ClassType, PropertyName);
  if Instance.ContainsKey(Pair) then
  begin
    List := Instance.Items[Pair];
    PropCallbacks := TBindingCallbacksList.Create;
    for I := 0 to List.Count - 1 do
      PropCallbacks.Add(List.Items[I]);
    Result := True;
  end;
end;

class function TBindingCallbackFactory.GetPair(const ClassType: string;
  const PropertyName: string): string;
begin
  if ClassType = '' then
    raise EBindOutputCallbackError.Create(sClassTypeNotFound);
  Result := UpperCase(ClassType+'.'+PropertyName);
end;

class function TBindingCallbackFactory.Instance: TBindingCallbacks;
begin
  if FCallbacks = nil then
    FCallbacks := TBindingCallbacks.Create([doOwnsValues]);
  Result := FCallbacks;
end;

{ TBindingOutput }

constructor TBindingOutput.Create(AOwner: TObject; AOptions: TOptions);
begin
  inherited Create;

  FOwner := AOwner;
  FLocations := TLocations.Create;
  FOutputs := TDestinations.Create;
  FOutputProcs := TOutputProcs.Create;
  FOutputConverterIDs := TList<string>.Create;
  FNotify := opNotify in AOptions;
end;

destructor TBindingOutput.Destroy;
begin
  FValueConverter := nil;
  FOutputConverterIDs.Free;
  FOutputProcs.Free;
  FOutputs.Free;
  FLocations.Free;

  inherited;
end;

function TBindingOutput.GetLocationRec(const Location: ILocation;
  out LocationRec: TLocationRec): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FLocations.Count - 1 do
  begin
    Result := Location = FLocations[i].Location;

    if Result then
    begin
      LocationRec := FLocations[i];
      Break;
    end;
  end;
end;

procedure TBindingOutput.AddConverter(const ConverterID: string);
begin
  if not TValueRefConverterFactory.HasConverter(ConverterID) then
    raise EBindConverterError.Create(Format(sConverterIDNotRegistered, [ConverterID]));
  FValueConverter := nil;  // Recreate
  FOutputConverterIDs.Add(ConverterID);
end;

function TBindingOutput.UpdateOutputLocation(var LocationRec: TLocationRec): Boolean;
var
  Value: IValue;
  Child: IChild;
  BindingNotifier: IBindingNotifier;
  Expression: string;
  OrigIndex: Integer;
  LOldLocation: ILocation;
begin
  Result := True;
  //No need to recompile and generate location if not expression based
  if not LocationRec.IsExpression then
    Exit;

  Expression := Destinations.Items[LocationRec.Location].Value;
  OrigIndex := FLocations.IndexOf(LocationRec);
  FLocations.Remove(LocationRec);
  Destinations.Remove(LocationRec.Location);
  LOldLocation := LocationRec.Location;
  try
    // reevaluate the output expression
    Value := LocationRec.CompiledBinding.Evaluate(LocationRec.Scope, nil, nil);
    if (not Supports(Value, ILocation, LocationRec.Location)) and
      ((Value.GetType = nil) or (Value.GetType^.Kind <> tkClass)) then
      raise EBindOutputError.Create(sOutputIsReadOnly);

    if Supports(Value, IChild, Child) then
      if Child.Parent <> nil then
        if FNotify and (LocationRec.Notifier = nil) then
          LocationRec.Notifier := TBindings.CreateNotifier(Child.Parent, GetOwnerManager(Owner));

    // notifier needs to have its Owner updated
    if FNotify then
    begin
      if Child = nil then
        raise EBindOutputError.Create(sUnavailNotifier);
      if Supports(LocationRec.Notifier, IBindingNotifier, BindingNotifier) then
        BindingNotifier.Owner := Child.Parent;
    end;
    if Child = nil then
      Destinations.Add(LocationRec.Location, TOutputPair.Create(nil, Expression))
    else
      Destinations.Add(LocationRec.Location, TOutputPair.Create(Child.Parent, Expression));
    FLocations.Insert(OrigIndex, LocationRec);
    if Assigned(OnLocationUpdated) then
      OnLocationUpdated(LOldLocation, LocationRec.Location);
  except on E: Exception do
    begin
      if Assigned(OnEvalErrorEvent) then
        OnEvalErrorEvent(E);
      raise;
    end;
  end;
end;

function TBindingOutput.MakeLocation(Scope: IScope; const Expr: string;
  out LocationRec: TLocationRec): Boolean;
var
  Value: IValue;
  Child: IChild;
begin
  Result := True;
  try
    LocationRec.IsExpression := True;
    LocationRec.Scope := Scope;
    LocationRec.CompiledBinding := System.Bindings.Evaluator.Compile(Expr, Scope);

    Value := LocationRec.CompiledBinding.Evaluate(Scope, nil, nil);
    if (not Supports(Value, ILocation, LocationRec.Location)) and
      ((Value.GetType = nil) or (Value.GetType^.Kind <> tkClass)) then
      raise EBindOutputError.Create(sOutputIsReadOnly);
    if FNotify then
    begin
      if not Supports(Value, IChild, Child) then
        raise EBindOutputError.Create(sUnavailNotifier);
      if Child.Parent <> nil then
        LocationRec.Notifier := TBindings.CreateNotifier(Child.Parent, GetOwnerManager(Owner))
    end;
  except on E: Exception do
    begin
      if Assigned(OnEvalErrorEvent) then
        OnEvalErrorEvent(E);
      raise;
    end;
  end;
end;

function TBindingOutput.MakeLocation(AObject: TObject;
  const PropertyName: String): TLocationRec;
begin
  Result := TLocationRec.Create(
    TLocationWrapper.Create(AObject, PropertyName),
    TBindings.CreateNotifier(AObject, GetOwnerManager(Owner)),
    nil, nil, False);
end;

function TBindingOutput.MakeObjScope(const Obj: TObject): IScope;
var
  Scope: TDictionaryScope;
  AliasName: string;
begin
  Scope := TDictionaryScope.Create;
  //Use classname as alias as this will be the only scope,
  // it should be unique within the dictionary/root
  AliasName := Obj.ClassName;
  Scope.Map.Add(AliasName, WrapObject(Obj));
  Result := Scope;
end;

procedure TBindingOutput.AddProc(AProc: TBindingSetValueEvent);
begin
  if not Procs.Contains(AProc) then
    Procs.Add(AProc);
end;

procedure TBindingOutput.Add(AScope: IScope; const Expression: string);
var
  Child: IChild;
  LocRec: TLocationRec;
begin
                                                                                               
// new internal wrappers. The returned location is dependent on the group wrapper to which it
// belongs and that wrapper will be freed along with the expression compiled within MakeLocation.

  if MakeLocation(AScope, Expression, LocRec) then
  begin
    FLocations.Add(LocRec);
    if Supports(LocRec.Location, IChild, Child) then
      Destinations.Add(LocRec.Location, TOutputPair.Create(Child.Parent, Child.MemberName))
    else
      // Coubl be a bidi method
      Destinations.Add(LocRec.Location, TOutputPair.Create(nil, Expression))
  end;
end;

procedure TBindingOutput.Add(AObject: TObject;
  const PropertyName: String);
var
  LocRec: TLocationRec;
begin
                                                                                               
//  Loc := MakeLocation(MakeObjScope(AObject), AObject.ClassName + '.' + PropertyName);

  // try to create a location for the given property an objects
  LocRec := MakeLocation(AObject, PropertyName);

  // add the location information to the internal structures
  FLocations.Add(LocRec);
  Destinations.Add(LocRec.Location, TOutputPair.Create(AObject, PropertyName));
end;


procedure RaiseConverterNotFound(const AValue: TValue; AToType: PTypeInfo);
var
  LName: string;
begin
  if AValue.TypeInfo = nil then
    LName := 'nil'
  else
    LName := AValue.TypeInfo.NameFld.ToString;
  raise EBindConverterError.Create(Format(sConverterNotFound,
    [LName, AToType.Name]));
end;

procedure TBindingOutput.SetValue(AExpression: TObject; const ValueFunc: TBindOutValueFunc);
var
  WrprChild: IChild;
  OutProc: TBindingSetValueEvent;
  LCtx: TRttiContext;
  OutPair: TOutputPair;
  LPropCallbacks: TBindingCallbackFactory.TBindingCallbacksList;
  LPropCallback: TBindingCallbackFactory.TBindingCallback;
  CanConvert, LSet: Boolean;
  CurrentVal, LFinalOutVal: TValue;
  TmpLocationRec, LocationRec: TLocationRec;
  LNotif: IBindingNotifier;
  LNotifType: TBindingNotifReservedType;
  LFurtherNotify: Boolean; // changes to the location need to be notified
  NeedLocationSet: Boolean; // indicates if the Location needs to have its value set
  CurrentOutValue: TValue;
  AllowConverter: Boolean;
begin
  CurrentOutValue := nil;
  // walk through all the registered procs for this setValue event
  if Procs.Count > 0 then
  begin
    CurrentOutValue := ValueFunc.GetValue;
    for OutProc in Procs do
      OutProc(CurrentOutValue);
  end;

  // walk through all the properties and set their values to Value
  LCtx := TRttiContext.Create;
  for TmpLocationRec in FLocations do
  begin
    LocationRec := TmpLocationRec;
    Assert(Destinations.ContainsKey(LocationRec.Location));

    // update the value of the output location and the output pair for it
    if not UpdateOutputLocation(LocationRec) then
    begin
      OutPair := Destinations.Items[LocationRec.Location];
      raise EBindOutputError.Create(Format(sUpdateOutputLocFailed, [Outpair.Key.ClassName, Outpair.Value]));
    end;

    // grab the parent and member name of the output location because it contains
    // the actual object property that will retain the value
    if Supports(LocationRec.Location, IChild, WrprChild) then
    begin
      //WrprChild := LocationRec.Location as IChild;
      OutPair.Key := WrprChild.Parent;
      OutPair.Value := WrprChild.MemberName;
    end
    else
      OutPair := Destinations.Items[LocationRec.Location];

    // change the value of the object property in the output pair only
    // if it hasn't been visited yet
    if FNotify then
    begin
      if OutPair.Key = nil then
        LFurtherNotify := not TBindingGraph.IsIterationMarked(AExpression as TBindingExpression)
      else
        LFurtherNotify := not TBindingGraph.IsIterationMarked(OutPair.Key, OutPair.Value)
    end
    else
      LFurtherNotify := True;
    //if LFurtherNotify is false, we have already set the output obj/property pair in this "cycle"
    if not LFurtherNotify then
      continue;

    try
      CurrentOutValue := ValueFunc.GetValue;
    except on E: Exception do
      begin
        if Assigned(OnEvalErrorEvent) then
          OnEvalErrorEvent(E);
        raise;
      end;
    end;
    LFinalOutVal := CurrentOutValue;
    LSet := False;

    // LNotifType initialization avoids compiler warning
    LNotifType := bnrtExternal;
    try
      // the notification type of the notifier of the object must be set to internal
      // and restored after the value of the property has been set;
      if FNotify and Supports(LocationRec.Notifier, IBindingNotifier, LNotif) then
      begin
        LNotifType := LNotif.Reserved;
        LNotif.Reserved := bnrtInternal;
      end;

      try
        // Local-level event to allow intercepting/override values
        if Assigned(FAssigningValueEvent) then
        begin
          FAssigningValueEvent(TBindingAssignValueRec.Create(AExpression, OutPair.Key, OutPair.Value), LFinalOutVal, LSet);
          //If event handled the assignment, then we can skip the rest of the
          // attempts for the current output destination
          if LSet then
            continue;
        end;

        try
          if Assigned(OutPair.Key) then
          begin
            // Class-level (property) setter callbacks registered to handle
            // expected input values of given types
            LPropCallbacks := nil;
            TBindingCallbackFactory.GetCallback(OutPair.Key.ClassName, OutPair.Value, LPropCallbacks);
            try
              LSet := False;
              if LPropCallbacks <> nil then
              begin
                for LPropCallback in LPropCallbacks do
                begin
                  LSet := LPropCallback(OutPair.Key, LFinalOutVal);
                  if LSet then
                    break;
                end;
              end;
              if LSet then
                continue;
            finally
              LPropCallbacks.Free;
            end;
          end;

          // Scope (ILocation - writable) based assignment to output destination
          // Converter-level as last check against mismatch types
          if ValueConverter = nil then
          begin
            ValueConverter := TValueRefConverterFactory.GetConverter(FOutputConverterIDs.ToArray);
          end;

          //If we have a object reference as input and output, we need to
          // make sure we set the value to change the output object pointer
          // reference to be the input object or nil if input is empty
          // Note that if a converter is available as determined below,
          // we assume the converter is correct and necessary and will not
          // set the property/field via RTTI
          AllowConverter := True;
          if (LocationRec.Location.GetType <> nil) and (LocationRec.Location.GetType.Kind = tkClass) and
            not (Supports(LocationRec.Location, ILocation)) then // Ignore internal objects
          begin
            if LFinalOutVal.IsEmpty then
              NeedLocationSet := True
            else if LFinalOutVal.IsObject and LFinalOutVal.AsObject.InheritsFrom(GetClassType(LocationRec.Location.GetType)) then
            begin
              NeedLocationSet := True;
              // Don't use object converter unless type mismatch
              AllowConverter := False;
            end
            else
              NeedLocationSet := False;
          end
          else
            NeedLocationSet := True;

          if AllowConverter then
            CanConvert := ValueConverter.CanConvert(LFinalOutVal.TypeInfo, LocationRec.Location.GetType)
          else
            CanConvert := False;
          if CanConvert then
          begin
            CurrentVal := LFinalOutVal;
            // If output type is object type, the converter needs the object's
            //   reference instead of instantiating a new instance
            if LocationRec.Location.GetType.Kind = tkClass then
            begin
              // If we have a converter for an object output location, we will
              // assume the converter is necessary and that we should not assign
              // by calling the property/field setter
              NeedLocationSet := False;
              LFinalOutVal := TValue.From<TObject>(LocationRec.Location.GetValue.AsObject);
              LSet := True; // lets us know whether or not the tkClass was handled
            end;
            ValueConverter.Convert(CurrentVal, LocationRec.Location.GetType, LFinalOutVal);
          end;

          // the new value needs to be set explicitly through RTTI to the location
          // only in case the location is not an object or
          // the source value and the location is compatible (descendant -> ancestor)
          // If a converter is registered for an output object type, we assume
          // that has handled the necessary assignment logic and do not override
          // values here
          if NeedLocationSet then
          begin
            // this avoids to alter the value of a property that is part of
            // a cycle and that has already been set
            if LFurtherNotify then
              LocationRec.Location.SetValue(LFinalOutVal);
            LSet := NeedLocationSet;
          end;

          // notify that the Location has been set
          if LSet then
          begin
            // notify further only if the output hasn't been iteration-marked (visited) yet
            if LFurtherNotify and Assigned(LNotif) then
              LNotif.Notify(OutPair.Value)
          end
          else
            RaiseConverterNotFound(CurrentOutValue, LocationRec.Location.GetType);
        except
          on E: EInvalidCast do
            RaiseConverterNotFound(CurrentOutValue, LocationRec.Location.GetType);
          else
            raise;
        end;
      finally
        // Allow implementations to intercept after an actual output gets set to a specific object
        if Assigned(OnAssignedValue) then
          OnAssignedValue(TBindingAssignValueRec.Create(AExpression, OutPair.Key, OutPair.Value), LFinalOutVal);
      end;
    finally
      // restore the notification state of the notifier
      if Assigned(LNotif) then
        LNotif.Reserved := LNotifType;
    end;
  end;
end;

{ TValueRefConverter }

procedure TValueRefConverter.AddConversion(ConvPair: TConvertPair;
  AConverter: TConverterDescription);
begin
  if FConversions.ContainsKey(ConvPair) then
    raise EBindConverterError.Create(Format(sDuplicatedConverterType, [FConversions.Items[ConvPair].ID, ConvPair.FromType.Name, ConvPair.ToType.Name]));
  FConversions.Add(ConvPair, AConverter);
end;

procedure TValueRefConverter.AddConversion(ConvPairs: TArray<TConvertPair>;
  AConverter: TConverterDescription);
var
  ConvPair: TConvertPair;
begin
  for ConvPair in ConvPairs do
    AddConversion(ConvPair, AConverter);
end;

function TValueRefConverter.CanConvert(AFrom, ATo: PTypeInfo): Boolean;
begin
  Result := GetConverter(AFrom, ATo, False) <> nil;
end;

procedure TValueRefConverter.ClearConverters;
begin
  FConversions.Clear;
end;

procedure TValueRefConverter.Convert(const InValue: TValue; ATo: PTypeInfo; var OutValue: TValue);
var
  Converter: TConvertProc2;
begin
  Converter := GetConverter(InValue.TypeInfo, ATo);
  if not Assigned(Converter) then
    RaiseConverterNotFound(InValue, ATo);
  Converter(InValue, ATo, OutValue);
end;

constructor TValueRefConverter.Create;
begin
  FConversions := TValueConvDict.Create;
end;

destructor TValueRefConverter.Destroy;
begin
  FConversions.Free;
  inherited;
end;

function TValueRefConverter.GetConverter(AFrom, ATo: PTypeInfo; FindBestMatch: Boolean): TConvertProc2;

  function GetConvertProc2(const AConverterDescription: TConverterDescription): TConvertProc2;
  var
    LConvertProc: TConvertProc;
  begin
    Result := nil;
    if Assigned(AConverterDescription.FConvertProc2) then
      Result := AConverterDescription.FConvertProc2
    else if Assigned(AConverterDescription.FConvertProc) then
    begin
      LConvertProc := AConverterDescription.FConvertProc;
      Result :=
      procedure(const InValue: TValue; ATo: PTypeInfo; var OutValue: TValue)
      begin
        LConvertProc(InValue, OutValue);
      end
    end
    else
      Assert(False);
  end;
var
  BestFromClass, BestToClass, FromClass, ToClass, ConvPairFromClass, ConvPairToClass: TClass;
  ConvPair: TConvertPair;
  //LConverterDescription: TConverterDescription;
begin
  Result := nil;
  BestFromClass := nil;
  BestToClass := nil;

  //check for exact match
  ConvPair := TConvertPair.Create(AFrom, ATo);
  if FConversions.ContainsKey(ConvPair) then
    Exit(GetConvertProc2(FConversions.Items[ConvPair]));

  //check if we have any class inherited converter
  FromClass := GetClassType(AFrom);
  ToClass := GetClassType(ATo);
  if Assigned(FromClass) or Assigned(ToClass) then
  for ConvPair in FConversions.Keys do
  begin
    ConvPairFromClass := GetClassType(ConvPair.FromType);
    ConvPairToClass := GetClassType(ConvPair.ToType);
    if Assigned(FromClass) and Assigned(ConvPairFromClass) and FromClass.InheritsFrom(ConvPairFromClass) then
      if (ATo = ConvPair.ToType) or ((ToClass <> nil) and ToClass.InheritsFrom(ConvPairToClass)) then
      begin
        if FindBestMatch then
        begin
          if Assigned(Result) then
          begin
            if ConvPairFromClass.InheritsFrom(BestFromClass) then
              if (ATo = ConvPair.ToType) or ((ConvPairToClass <> nil) and ConvPairToClass.InheritsFrom(BestToClass)) then
              begin
                Result := GetConvertProc2(FConversions.Items[ConvPair]);
                BestToClass := ConvPairToClass;
                BestFromClass := ConvPairFromClass;
                continue;
              end;
          end
          else
          begin
            Result := GetConvertProc2(FConversions.Items[ConvPair]);
            BestToClass := ConvPairToClass;
            BestFromClass := ConvPairFromClass;
            continue;
          end;
        end
        else
          Exit(GetConvertProc2(FConversions.Items[ConvPair]));
      end;
    if Assigned(ToClass) and Assigned(ConvPairToClass) and ToClass.InheritsFrom(ConvPairToClass) then
      if (AFrom = ConvPair.FromType) or ((FromClass <> nil) and FromClass.InheritsFrom(ConvPairFromClass)) then
      begin
        if FindBestMatch then
        begin
          if Assigned(Result) then
          begin
            if ConvPairToClass.InheritsFrom(BestToClass) then
              if (AFrom = ConvPair.FromType) or ((ConvPairFromClass <> nil) and ConvPairFromClass.InheritsFrom(BestFromClass)) then
              begin
                Result := GetConvertProc2(FConversions.Items[ConvPair]);
                BestToClass := ConvPairToClass;
                BestFromClass := ConvPairFromClass;
                continue;
              end;
          end
          else
          begin
            Result := GetConvertProc2(FConversions.Items[ConvPair]);
            BestToClass := ConvPairToClass;
            BestFromClass := ConvPairFromClass;
            continue;
          end;
        end
        else
          Exit(GetConvertProc2(FConversions.Items[ConvPair]));
      end;
  end;
end;

{ TValueRefConverterFactory }

class procedure TValueRefConverterFactory.ClearRegisteredConverters;
begin
  FRegisteredConversions.Clear;
end;

class constructor TValueRefConverterFactory.Create;
begin
  FRegisteredConversions := TNamedOutputConverters.Create;
  FFreeList := TObjectList<TObject>.Create;
end;

class destructor TValueRefConverterFactory.Destroy;
begin
  FFreeList.Free;
  FRegisteredConversions.Free;
end;

class function TValueRefConverterFactory.GetConverter(
  ConverterIDs: TArray<string>): TValueRefConverter;
var
  ConvID: string;
  ValuePair: TConverterValuePair;
begin
  Result := TValueRefConverter.Create;
  try
    if Length(ConverterIDs) > 0 then
      for ConvID in ConverterIDs do
      begin
        if not FRegisteredConversions.TryGetValue(ConvID, ValuePair) then
          raise EBindConverterError.Create(Format(sConverterIDNotRegistered, [ConvID]));
        Result.AddConversion(ValuePair.Key.ToArray, ValuePair.Value);
      end
    else
      for ConvID in FRegisteredConversions.Keys do
      begin
        ValuePair := FRegisteredConversions.Items[ConvID];
        if ValuePair.Value.DefaultEnabled then
          Result.AddConversion(ValuePair.Key.ToArray, ValuePair.Value);
      end;
  except
    on E: Exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

class function TValueRefConverterFactory.GetConverterDescriptions: TArray<TConverterDescription>;
var
  ValuePair: TConverterValuePair;
  I: Integer;
begin
  SetLength(Result, FRegisteredConversions.Count);
  I := 0;
  for ValuePair in FRegisteredConversions.Values do
  begin
    Result[I] := ValuePair.Value;
    Inc(I);
  end;
end;

class function TValueRefConverterFactory.GetConverterUnitName(
  const ConverterID: string): string;
begin
  Result := '';
  if FRegisteredConversions.ContainsKey(ConverterID) then
    Result := FRegisteredConversions.Items[ConverterID].Value.UnitName;
end;

class function TValueRefConverterFactory.GetConverterFrameworkClass(
  const ConverterID: string): TPersistentClass;
begin
  Result := nil;
  if FRegisteredConversions.ContainsKey(ConverterID) then
    Result := FRegisteredConversions.Items[ConverterID].Value.FrameworkClass;
end;

class function TValueRefConverterFactory.HasConverter(
  const ConverterID: string): Boolean;
begin
  Result := FRegisteredConversions.ContainsKey(ConverterID);
end;

class procedure TValueRefConverterFactory.RegisterConversion(
  AFrom, ATo: PTypeInfo; AConverter: TConverterDescription);
var
  ConvPairList: TList<TConvertPair>;
  ConverterID: string;
begin
  ConverterID := AConverter.ID;
  if FRegisteredConversions.ContainsKey(ConverterID) then
    ConvPairList := FRegisteredConversions.Items[ConverterID].Key
  else
  begin
    ConvPairList := TList<TConvertPair>.Create;
    FFreeList.Add(ConvPairList);
    FRegisteredConversions.Add(ConverterID,
      TConverterValuePair.Create(ConvPairList, AConverter));
  end;
  ConvPairList.Add(TConvertPair.Create(AFrom, ATo));
end;

class procedure TValueRefConverterFactory.UnRegisterConversion(
  const ConverterID: string);
begin
  FRegisteredConversions.Remove(ConverterID);
end;

class procedure TValueRefConverterFactory.UnRegisterConversion(AFrom,
  ATo: PTypeInfo);
var
  LId: string;
  ConvPair: TConvertPair;
  ValuePair: TConverterValuePair;
begin
  for LId in FRegisteredConversions.Keys do
  begin
    ValuePair := FRegisteredConversions.Items[LId];
    ConvPair := TConvertPair.Create(AFrom, ATo);
    if ValuePair.Key.Contains(ConvPair) then
      ValuePair.Key.Remove(ConvPair);
    if ValuePair.Key.Count = 0 then
      FRegisteredConversions.Remove(LId);
  end;
end;

class procedure TValueRefConverterFactory.RegisterConversion(
  AFrom, ATo: array of PTypeInfo; AConverter: TConverterDescription);
var
  I,J: Integer;
begin
  for I := Low(AFrom) to High(AFrom) do
    for J := Low(ATo) to High(ATo) do
      RegisterConversion(AFrom[I], ATo[J], AConverter);
end;

class procedure TValueRefConverterFactory.RegisterConversion(
  AFrom, ATo: TArray<PTypeInfo>; AConverter: TConverterDescription);
var
  I,J: Integer;
begin
  for I := Low(AFrom) to High(AFrom) do
    for J := Low(ATo) to High(ATo) do
      RegisterConversion(AFrom[I], ATo[J], AConverter);
end;

class procedure TValueRefConverterFactory.UnRegisterConversion(AFrom,
  ATo: array of PTypeInfo);
var
  I,J: Integer;
begin
  for I := Low(AFrom) to High(AFrom) do
    for J := Low(ATo) to High(ATo) do
      UnRegisterConversion(AFrom[I], ATo[J]);
end;

class procedure TValueRefConverterFactory.UnRegisterConversion(AFrom,
  ATo: TArray<PTypeInfo>);
var
  I,J: Integer;
begin
  for I := Low(AFrom) to High(AFrom) do
    for J := Low(ATo) to High(ATo) do
      UnRegisterConversion(AFrom[I], ATo[J]);
end;


{ TValueRefConverter.TConvPair }

constructor TConvertPair.Create(AFrom, ATo: PTypeInfo);
  procedure ProcessTypeInfo(var TypeInf: PTypeInfo);
  begin
    if Assigned(TypeInf) then
    begin
      //Handle common aliased types
      case TypeInf^.Kind of
        tkUString,
        tkString: TypeInf := TypeInfo(string);
        tkInteger: 
            case TypeInf.TypeData.OrdType of
              otSByte, 
              otSWord,
              otSLong:
                TypeInf := TypeInfo(Integer);
              otUByte,
              otUWord,
              otULong: 
                TypeInf := TypeInfo(UInt32);
            else
              TypeInf := TypeInfo(Integer);
            end;
      end;
    end;
  end;
begin
  ProcessTypeInfo(AFrom);
  ProcessTypeInfo(ATo);
  FromType := AFrom;
  ToType := ATo;
end;

{ TBindingAssignValueRec }

constructor TBindingAssignValueRec.Create(Expr: TObject; Obj: TObject; Prop: string);
begin
  Expression := Expr;
  OutObj := Obj;
  OutProp := Prop;
end;

{ TConverterDescription }

constructor TConverterDescription.Create(AConvertProc: TConvertProc; const AID,
  ADisplayName, AUnitName: string; ADefaultEnabled: Boolean; const ADescription: string; AFrameworkClass: TPersistentClass);
begin
  if AID = '' then
    raise EBindConverterError.Create(sConverterIDNotFound);
  FConvertProc := AConvertProc;
  FDisplayName := ADisplayName;
  FUnitName := AUnitName;
  FID := AID;
  FDefaultEnabled := ADefaultEnabled;
  FFrameworkClass := AFrameworkClass;
  FDescription := ADescription;
end;

constructor TConverterDescription.Create2(AConvertProc2: TConvertProc2; const AID,
  ADisplayName, AUnitName: string; ADefaultEnabled: Boolean; const ADescription: string; AFrameworkClass: TPersistentClass);
begin
  if AID = '' then
    raise EBindConverterError.Create(sConverterIDNotFound);
  FConvertProc2 := AConvertProc2;
  FDisplayName := ADisplayName;
  FUnitName := AUnitName;
  FID := AID;
  FDefaultEnabled := ADefaultEnabled;
  FFrameworkClass := AFrameworkClass;
  FDescription := ADescription;
end;


const
  sIDNilToTDateTime = 'NilToDateTime';
  sIDNilToTStrings = 'NilToTStrings';
  sIDPersistentToPersistent = 'PersistentToPersistent';
  sIDBoolToString = 'BoolToString';
  sIDStringToBool = 'StringToBool';
  sIDNilToNumber = 'NilToNumber';
  sIDIntegerToString = 'IntegerToString';
  sIDStringToInteger = 'StringToInteger';
  sIDFloatToString = 'FloatToString';
  sIDCurrencyToString = 'CurrencyToString';
  sIDStrToTDateTime = 'StrToTDateTime';
  sIDTDateTimeToStr = 'TDateTimeToStr';
  sIDStrToTDate = 'StrToTDate';
  sIDStrToTTime = 'StrToTTime';
  sIDNilToString = 'NilToString';
  sIDNilToBoolean = 'NilToBoolean';
  sIDNilToVariant = 'NilToVariant';
  sIDStringToVariant = 'StringToVariant';
  sIDFloatToVariant = 'FloatToVariant';
  sIDIntToVariant = 'IntToVariant';
  sIDBoolToVariant = 'BoolToVariant';
  sIDVariantToBool = 'VariantToBool';
  sIDStrToFloat = 'StrToFloat';
  sIDStrToCurrency = 'StrToCurrency';
  sIDFloatToInteger = 'FloatToInteger';
  sIDTStringsToString = 'TStringsToString';
  sIDStringToTStrings = 'StringToTString';
  sIDStringToChar = 'StringToChar';


procedure RegisterBasicOutputConverters;

var
  LRttiToStringProc: TConvertProc;
  LProcFloatToVariant: TConvertProc;
  LProcAssignZero: TConvertProc;
  LProcStringToInteger: TConvertProc2;
  LProcStrToFloat: TConvertProc;
  LProcIntegerToString: TConvertProc;
  LFloatPTypeInfos: TArray<PTypeInfo>;
  LIntegerPTypeInfos: TArray<PTypeInfo>;
  LDateTimePTypeInfos: TArray<PTypeInfo>;
  LStringPTypeInfos: TArray<PTypeInfo>;
begin

  LFloatPTypeInfos := TArray<PTypeInfo>.Create(TypeInfo(Single), TypeInfo(Extended), TypeInfo(Currency), TypeInfo(Double));   // TDateTime, TDate, and TTime work also
  LDateTimePTypeInfos := TArray<PTypeInfo>.Create(TypeInfo(TDateTime), TypeInfo(TDate), TypeInfo(TTime));   // TDateTime, TDate, and TTime work also
  LIntegerPTypeInfos := TArray<PTypeInfo>.Create(TypeInfo(Integer), TypeInfo(Cardinal), TypeInfo(Int64), TypeInfo(UInt64));
{$IFNDEF NEXTGEN}
  LStringPTypeInfos := TArray<PTypeInfo>.Create(TypeInfo(string), TypeInfo(AnsiString));
{$ELSE}
  LStringPTypeInfos := TArray<PTypeInfo>.Create(TypeInfo(string));
{$ENDIF}
  TValueRefConverterFactory.RegisterConversion(nil, TypeInfo(string),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := '';
    end,
    sIDNilToString,
    sNilToString,
    '', True, sNilToStringDesc, nil)
  );
  TValueRefConverterFactory.RegisterConversion(nil, TypeInfo(Boolean),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := False;
    end,
    sIDNilToBoolean,
    sNilToBoolean,
    '', True, sNilToBooleanDesc, nil)
  );
  TValueRefConverterFactory.RegisterConversion(nil, TypeInfo(Variant),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := TValue.From<Variant>('');
    end,
    sIDNilToVariant,
    sNilToVariant,
    '', True, sNilToVariantDesc, nil)
  );

  LProcAssignZero :=
    procedure(const I: TValue; var O: TValue)
    begin
      O := 0;
    end;

  TValueRefConverterFactory.RegisterConversion(TArray<PTypeInfo>.Create(nil), LFloatPTypeInfos,
    TConverterDescription.Create(
    LProcAssignZero,
    sIDNilToNumber,
    sNilToNumber,
    '', True, sNilToNumberDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(TArray<PTypeInfo>.Create(nil), LDateTimePTypeInfos,
    TConverterDescription.Create(
    LProcAssignZero,
    sIDNilToTDateTime,
    sNilToTDateTime,
    '', True, sNilToTDateTimeDesc, nil)
  );


  TValueRefConverterFactory.RegisterConversion(nil, TypeInfo(TStrings),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      items: TStrings;
    begin
      items := O.AsObject as TStrings;
      if Assigned(items) then
        items.Clear;
    end,
    sIDNilToTStrings,
    sNilToTStrings,
    '', True, sNilToTStringsDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(TypeInfo(TPersistent), TypeInfo(TPersistent),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      oIn, oOut: TObject;
    begin
      oIn := I.AsObject;
      oOut := O.AsObject;

      // use Assign to copy the objects if they are TPersistents
      if (oOut <> nil) and (oIn <> nil) then
        TPersistent(oOut).Assign(TPersistent(oIn))
    end,
    sIDPersistentToPersistent,
    sPersistentToPersistent,
    '', True, sPersistentToPersistentDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(TypeInfo(Boolean), TypeInfo(string),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := TValue.From<string>(BoolToStr(I.AsBoolean, True));
    end,
    sIDBoolToString,
    sBoolToString,
    '', True, sBoolToStringDesc, nil)
  );
  TValueRefConverterFactory.RegisterConversion(TypeInfo(string), TypeInfo(Boolean),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      LBool: Boolean;
    begin
      if not TryStrToBool(I.AsString, LBool) then
        LBool := False;
      O := TValue.From<Boolean>(LBool);
    end,
    sIDStringToBool,
    sStringToBool,
    '', True, sStringToBoolDesc, nil)
  );

  LProcIntegerToString :=
    procedure(const I: TValue; var O: TValue)
    begin
      case I.TypeInfo.Kind of
        tkInteger:
          case I.TypeInfo.TypeData.OrdType of
            otSByte,
            otSWord,
            otSLong:
              O := TValue.From<string>(IntToStr(I.AsInteger));
            otUByte,
            otUWord,
            otULong:
              O := TValue.From<string>(UIntToStr(I.AsType<uint32>))
          end;
        tkInt64:
          with I.TypeInfo.TypeData^ do
            if MinInt64Value > MaxInt64Value then
              O :=  TValue.From<string>(UIntToStr(I.AsType<Uint64>))
            else
              O := TValue.From<string>(IntToStr(I.AsInt64));
      else
        Assert(False);
        O := TValue.Empty;
      end;
    end;

  TValueRefConverterFactory.RegisterConversion(LIntegerPTypeInfos, LStringPTypeInfos,
    TConverterDescription.Create(
    LProcIntegerToString,
    sIDIntegerToString,
    sIntegerToString,
    '', True, sIntegerToStringDesc, nil)
  );


  LProcStringToInteger :=
    procedure(const I: TValue; ATo: PTypeInfo; var O: TValue)
    var
      val: string;
    begin
      val := I.AsString;
      if val = '' then
        O := 0
      else
      begin
        case ATo.Kind of
          tkInteger:
            case ATo.TypeData.OrdType of
              otSByte,
              otSWord,
              otSLong:
                O := TValue.From<Integer>(StrToInt(val));
              otUByte,
              otUWord,
              otULong:
                O := TValue.From<Uint32>(StrToInt64(val))                         
            end;
          tkInt64:
            with I.TypeInfo.TypeData^ do
              if MinInt64Value > MaxInt64Value then
                O := TValue.From<uint64>(StrToInt64(val))                           
              else
                O := TValue.From<int64>(StrToInt64(val));
        else
          Assert(False);
          O := TValue.Empty;
        end;
      end;

    end;

  TValueRefConverterFactory.RegisterConversion(LStringPTypeInfos, LIntegerPTypeInfos,
    TConverterDescription.Create2(
    LProcStringToInteger,
    sIDStringToInteger,
    sStringToInteger,
    '', True, sStringToIntegerDesc, nil)
  );


  LRttiToStringProc :=
    procedure(const I: TValue; var O: TValue)
    begin
      // Use System.Rtti conversions
      O := TValue.From<string>(I.ToString);
    end;

  TValueRefConverterFactory.RegisterConversion(LFloatPTypeInfos, LStringPTypeInfos,
    TConverterDescription.Create(
    LRttiToStringProc, // Also support datetime, date and time
    sIDFloatToString,
    sFloatToString,
    '', True, sFloatToStringDesc, nil)
  );

  LProcStrToFloat :=
    procedure(const I: TValue; var O: TValue)
    var
      LValue: string;
      LCurr: Currency;
      LFloat: Extended;
    begin
      LValue := I.AsString;
      if LValue = '' then
        LValue := '0';
      if not TryStrToFloat(LValue, LFloat) then
        LFloat := 0.0;
      O := TValue.From<Extended>(LFloat);
      case GetTypeData(O.TypeInfo)^.FloatType of
        ftCurr:
          begin
            if TryStrToCurr(LValue, LCurr) then
              O := TValue.From<Currency>(LCurr)
            else
              O := TValue.From<Currency>(0.00)
          end
      else
          O := TValue.From<Extended>(LFloat)
      end;
    end;

  TValueRefConverterFactory.RegisterConversion(LStringPTypeInfos, LFloatPTypeInfos,
    TConverterDescription.Create(
    LProcStrToFloat,
    sIDStrToFloat,
    sStrToFloat,
    '', True, sStrToFloatDesc, nil)
  );


  TValueRefConverterFactory.RegisterConversion(TypeInfo(String), TypeInfo(TDateTime),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := TValue.From<TDateTime>(StrToDateTime(I.AsString));
    end ,
    sIDStrToTDateTime,
    sStrToTDateTime,
    '', True, sStrToTDateTimeDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(LDateTimePTypeInfos, LStringPTypeInfos,
    TConverterDescription.Create(
    LRttiToStringProc,
    sIDTDateTimeToStr,
    sTDateTimeToStr,
    '', True, sTDateTimeToStrDesc, nil)
  );


  TValueRefConverterFactory.RegisterConversion(TypeInfo(string), TypeInfo(TDate),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      LDate: TDateTime;
    begin
      if TryStrToDate(I.AsString, LDate) then
        O := TValue.From<TDate>(LDate)
      else
        O := TValue.Empty;
    end,
    sIDStrToTDate,
    sStrToTDate,
    '', True, sStrToTDateDesc, nil)
  );


  TValueRefConverterFactory.RegisterConversion(TypeInfo(string), TypeInfo(TTime),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := TValue.From<TTime>(StrToTime(I.AsString));
    end,
    sIDStrToTTime,
    sStrToTTime,
    '', True, sStrToTTimeDesc, nil)
  );


  TValueRefConverterFactory.RegisterConversion(TypeInfo(string), TypeInfo(Variant),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := TValue.From<Variant>(I.AsString);
    end,
    sIDStringToVariant,
    sStringToVariant,
    '', True, sStringToVariantDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(TypeInfo(Boolean), TypeInfo(Variant),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      LVariant: Variant;
    begin
      LVariant := I.AsBoolean;
      O := tvalue.From<variant>(LVariant);
    end,
    sIDBoolToVariant,
    sBoolToVariant,
    '', True, sBoolToVariantDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(TypeInfo(Variant), TypeInfo(Boolean),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      LBool: Boolean;
    begin
      LBool := I.AsVariant;
      O := tvalue.From<Boolean>(LBool);
    end,
    sIDVariantToBool,
    sVariantToBool,
    '', True, sVariantToBoolDesc, nil)
  );

  LProcFloatToVariant :=
    procedure(const I: TValue; var O: TValue)
    begin
      O := TValue.From<Variant>(I.AsExtended);
    end;

  TValueRefConverterFactory.RegisterConversion(LFloatPTypeInfos, TArray<PTypeInfo>.Create(TypeInfo(Variant)),
    TConverterDescription.Create(
    LProcFloatToVariant,
    sIDFloatToVariant,
    sFloatToVariant,
    '', True, sFloatToVariantDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(LIntegerPTypeInfos, TArray<PTypeInfo>.Create(TypeInfo(Variant)),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := TValue.From<Variant>(I.AsInt64);
    end,
    sIDIntToVariant,
    sIntToVariant,
    '', True, sIntToVariantDesc, nil)
  );


  TValueRefConverterFactory.RegisterConversion(LFloatPTypeInfos, LIntegerPTypeInfos,
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    begin
      O := TValue.From<Integer>(Round(I.AsExtended));
    end,
    sIDFloatToInteger,
    sFloatToInteger,
    '', True, sFloatToIntegerDesc, nil)
  );



  TValueRefConverterFactory.RegisterConversion(TypeInfo(TStrings), TypeInfo(string),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      oIn: TStrings;
    begin
      if I.IsEmpty then
        O := ''
      else
      begin
        oIn := TStrings(I.AsObject);
        if oIn <> nil then
          O := oIn.Text
        else
          O := '';
      end
    end,
    sIDTStringsToString,
    sTStringsToString,
    '', True, sTStringToStringDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(TypeInfo(string), TypeInfo(TStrings),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      oOut: TStrings;
    begin
      oOut := TStrings(O.AsObject);                                            
      if oOut <> nil then
      begin
        if I.IsEmpty then
          oOut.Text := ''
        else
          oOut.Text := I.AsString;
      end;
    end,
    sIDStringToTStrings,
    sStringToTStrings,
    '', True, sStringToTStringsDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(LStringPTypeInfos, TArray<PTypeInfo>.Create(TypeInfo(char)),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      s: char;
      c: char;
    begin
      c := ' ';
      for s in I.AsString do
      begin
        c := s;
        break;
      end;
      O := TValue.From<char>(c);
    end,
    sIDStringToChar,
    sStringToChar,
    '', True, sStringToCharDesc, nil)
  );

{$IFNDEF NEXTGEN}
  TValueRefConverterFactory.RegisterConversion(TypeInfo(AnsiString), TypeInfo(AnsiChar),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      s: ansichar;
      c: ansichar;
    begin
      c := ' ';
      for s in I.AsType<AnsiString> do
      begin
        c := s;
        break;
      end;
      O := TValue.From<ansichar>(c);
    end,
    sIDStringToChar,
    sStringToChar,
    '', True, sStringToCharDesc, nil)
  );

  TValueRefConverterFactory.RegisterConversion(TypeInfo(String), TypeInfo(AnsiChar),
    TConverterDescription.Create(
    procedure(const I: TValue; var O: TValue)
    var
      s: char;
      c: ansichar;
    begin
      c := ' ';
      for s in I.AsString do
      begin
        c := ansichar(s);
        break;
      end;
      O := TValue.From<ansichar>(c);
    end,
    sIDStringToChar,
    sStringToChar,
    '', True, sStringToCharDesc, nil)
  );
{$ENDIF}

end;

{ TBindingOutput.TLocationRec }

constructor TBindingOutput.TLocationRec.Create(const ALocation: ILocation;
  const ANotifier: IInterface; const ACompiledBinding: ICompiledBinding;
  const AScope: IScope; const AIsExpression: Boolean);
begin
  Location := ALocation;
  Notifier := ANotifier;
  CompiledBinding := ACompiledBinding;
  Scope := AScope;
  IsExpression := AIsExpression;
end;

initialization
  RegisterBasicOutputConverters;

finalization

end.
