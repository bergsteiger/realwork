{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.EvalProtocol;

interface

uses
  System.SysUtils, System.Generics.Collections, System.TypInfo, System.Rtti, System.RTLConsts, System.Bindings.Consts;

type
  /// <summary>Used to signal errors in the behaviour of a wrapper.</summary>
  EWrapperError = class(Exception);
  /// <summary>Exception for placeholder wrappers functionality.</summary>
  EPlaceholderError = class(Exception);
  /// <summary>Exception risen when evaluation errors are met.</summary>
  EEvaluatorError = class(Exception);

  /// <summary>A wrapper must implement this interface in order for the engine
  /// to recognize it as a wrapper. It is easier and faster for the engine to
  /// test whether an interface reference is a wrapper or not.</summary>
  IWrapper = interface
    ['{743F6B0A-931A-4EF7-9637-8DF639ABA4A9}']
  end;

  /// <summary>
  /// Abstract away the notion of an immediate value in order to support 
  /// querying for ILocation (an lvalue).
  /// </summary>
  IValue = interface
    ['{A495F901-72F5-4384-BA50-EC3B4B42F6C2}']
    /// <summary>Used to obtain the type information for the actual value.</summary> 
    /// <returns>The type information of the actual value.</returns>
    function GetType: PTypeInfo;
    /// <summary>Gives the actual value wrapped by this interface.</summary>
    /// <returns>The actual value.</returns>
    function GetValue: TValue;
  end;

  /// <summary>
  /// presents an lvalue: a logical location, a two-way pipe, 
  /// whose value can be extracted and stored.
  /// </summary>
  ILocation = interface(IValue)
    ['{861746E3-740A-4799-BB14-217066C629A8}']
    /// <summary>Sets the actual value wrapped by this interface.</summary>
    /// <param name="AValue">The new value that is set as the actual value of the location.</param>
    procedure SetValue(const AValue: TValue);
  end;


  /// <summary>
  /// Every property/method/field appertains to an object and it is a member of that object.
  /// Information about wrapped object members can be accessed using this interface.
  /// Internal wrappers implement this interface to let the system gain access to their parent object
  /// and to the name of the member. The member may be only a name for a calculated value and
  /// it may not have a physical representation in the object, such as a physical property of an object.
  /// </summary>
  IChild = interface
    ['{D4DD0F18-4076-4A9B-B87A-F9BA1BC69E26}']
    function GetParent: TObject;
    function GetMemberName: String;

    /// <summary>The parent object that contains the member wrapped by this interface.</summary>
    property Parent: TObject read GetParent;
    /// <summary>The name of the wrapped member.</summary>
    property MemberName: String read GetMemberName;
  end;

  /// <summary>
  /// Internal wrappers implement this interface to let the system gain access to their parent object
  /// and to the RTTI of the member. Only wrapped object members that have a physical representation in
  /// the object can support this interface because they must expose RTTI information of the wrapped member.
  /// </summary>
  IRttiChild = interface(IChild)
    ['{D4DD0F18-4076-4A9B-B87A-F9BA1BC69E26}']
    function GetMember: TRttiMember;

    /// <summary>The RTTI for the wrapped member.</summary>
    property Member: TRttiMember read GetMember;
  end;

  IRecordChild = interface
    ['{0F19D037-D3D4-410D-9E83-4C7013128DD3}']
    function GetParent: TValue;
    function GetMember: TRttiMember;

    property Parent: TValue read GetParent;
    property Member: TRttiMember read GetMember;
  end;

  /// <summary>
  /// A wrapper is considered to be a placeholder when it doesn't wrap around a physical value,
  /// but it is present there as a placeholder for the future value that will be created
  /// at evaluation time and to which the wrapper will then be attached.
  /// All the placeholders needed for an expression are created at compilation time.
  /// </summary>
  IPlaceholder = interface
    ['{4F76D2FA-BED9-476B-AA29-B6399F234DA1}']
    function GetAttachment: TObject;
    function GetMetaClass: TClass;
    function GetAttached: Boolean;
    function GetEvalTimeOnly: Boolean;

    /// <summary>Attaches the wrapper to a new object.</summary>
    /// <param name="Obj">The new object to which the wrapper is attached.
    /// If Obj is nil, the wrapper is detached.</param>
    procedure Attach(Obj: TObject);
    /// <summary>Detaches the wrapper from the physical object and makes the
    /// wrapper a placeholder.</summary>
    procedure Detach;

    /// <summary>The object to which the wrapper is attached.</summary>
    property Attachment: TObject read GetAttachment;
    /// <summary>When the placeholder is not attached, this class reference 
    /// is used to navigate through the metadata as if it was on a class reference
    /// of an object. This permits the placeholder to constraint what types of objects
    /// can be attached. It also gives the ability to created placeholder wrappers
    /// for members of the metaclass that are used in the expression.
    /// </summary>
    property MetaClass: TClass read GetMetaClass;
    /// <summary>Determines if the wrapper is attached to a physical object.</summary>
    property Attached: Boolean read GetAttached;
    /// <summary>Indicates if the value of the wrapped object member can be
    /// determined only at evaluation time. For example, an object-typed result
    /// of an indexed property or of a method can be determined only at evaluation.
    /// </summary>
    property EvalTimeOnly: Boolean read GetEvalTimeOnly;
  end;

  IRecordPlaceholder = interface
    ['{EA75D719-9962-4A60-AAC1-11E9EE820EED}']
    function GetAttachment: TValue;
    function GetAttached: Boolean;
    function GetEvalTimeOnly: Boolean;

    procedure Attach(Rec: TValue);
    procedure Detach;

    property Attachment: TValue read GetAttachment;
    property Attached: Boolean read GetAttached;
    property EvalTimeOnly: Boolean read GetEvalTimeOnly;
  end;

  /// <summary>
  /// Some object members such as methods or indexed properties cannot return 
  /// a value without having passed in a set of arguments. They are called
  /// parameters for methods and indexes for indexed properties. These arguments
  /// can be passed to a wrapper at evaluation time through IArguments interface.
  /// </summary>
  IArguments = interface
    ['{79D93B44-2F1B-4F53-B44D-91913FE68581}']
    function GetArgs: TArray<TValue>;
    procedure SetArgs(const Args: TArray<TValue>);

    /// <summary>Array of actual values to be passed in for the parameters of the wrapped member.</summary>
    property Args: TArray<TValue> read GetArgs write SetArgs;
  end;

  /// <summary>
  /// Represents a function which possibly returns a location,
  /// for "bidirectional" functions. </summary>
  IInvokable = interface
    ['{0BB8361C-AAC7-42DB-B970-5275797DF41F}']
    /// <summary>Executes a function or method which potentially returns an lvalue, for
    /// two-way functions (essentially, functions which return a reference).</summary>
    /// <param name="Args">Array of value wrappers that are passed in as parameters for the function.</param>
    /// <returns>A value wrapper that contains the actual result of the routine.
    /// It may also by a location in case the result of the routine is of an object type.</returns>
    function Invoke(const Args: TArray<IValue>): IValue;
  end;

  /// <summary>Some syntactic entities such as indexed properties may have
  /// different values for different arguments. The resulting values are wrapped
  /// by instance wrappers which are stored in groups. Each instance wrapper
  /// stores its particular value and probably arguments if it's the case.
  /// The group is used to depict that a certain object member is used in the script,
  /// while the instance wrappers of the group are used to depict each usage or
  /// presence of the object member.</summary>
  IGroup = interface
    ['{D6945DB4-6EFB-47A0-A91E-975522DAB28A}']
    function GetWrappers(Index: Integer): IInterface;
    function GetWrapperCount: Integer;

    function Add: Integer; overload;
    function Add(out Wrapper: IInterface): Integer; overload;
    procedure Clear;

    property Wrappers[Index: Integer]: IInterface read GetWrappers;
    property WrapperCount: Integer read GetWrapperCount;
  end;

  /// <summary>Object members specified in the script that cannot be found
  /// among the RTTI of the parent object at compile-time are represented by
  /// dynamic groups. These groups permit lazy determination of the value of
  /// the object member. The object member can be available only at
  /// evaluation-time, but a wrapper for it has to be present at compile-time.
  /// Dynamic groups permit this and link themselves to the actual groups
  /// at evaluation-time in order for the engine to determine the actual value
  /// of the object member.</summary>
  IDynamicGroup = interface(IGroup)
    ['{9F4AA978-B053-4137-87EE-A1C66C53FB25}']
    function GetFixedGroup: IGroup;
    procedure SetFixedGroup(const Group: IGroup);

    /// <summary>The group to which the dynamic member will be linked at
    /// evaluation-time in case the object member is found.</summary>
    property FixedGroup: IGroup read GetFixedGroup write SetFixedGroup;
  end;

  /// <summary>The same object member can be issued multiple times within
  /// an expression. If the object member is wrapped by a dynamic group,
  /// then every issuance of it is represented by a dynamic instance within
  /// the dynamic group. The dynamic instance can link itself to an actual instance,
  /// such as an RTTI instance, in order for the engine to determine the actual
  /// value of the object member.</summary>
  IDynamicInstance = interface
    ['{50F20CB5-22A2-4FF7-A1BD-9D61B463D078}']
    function GetFixedInstance: IInterface;
    procedure SetFixedInstance(const Instance: IInterface);

    /// <summary>The instance to which the dynamic member will be linked at
    /// evaluation-time in case the object member is found.</summary>
    property FixedInstance: IInterface read GetFixedInstance write SetFixedInstance;
  end;

  /// <summary>Represents a subscription to change notifications on a subscribable object.</summary>
  ISubscription = interface
    ['{3AD2F70A-3AAE-4A09-8982-12DE494E8D6A}']
    /// <summary>Terminate an existing subscription.</summary>
    procedure Unsubscribe;
  end;

  /// <summary>Called when a subscribable object changes.</summary>
  // / <param name="ASubscription">The subscription correspondent to the subscribable object that has changed.</param>
  TSubscriptionNotification = reference to procedure(const ASubscription: ISubscription);
  
  /// <summary>A value that supports change notification should implement this interface.</summary>
  ISubscribable = interface
    ['{CFDD03F1-FB50-4B39-99B8-842D5604A14A}']
    /// <summary>The subscribable object should call ANotification when it changes, so
    /// long as the subscription is active. If ISubscription has Unsubscribe
    /// called on it, change notifications should cease.</summary>
    /// <param name="ANotification">The callback routine that is called by the
    /// implementer wrapper of this interface whenever its value changes.</param>
    /// <returns>The subscription reference corresponding to this subscribable object.</returns>
    function Subscribe(const ANotification: TSubscriptionNotification): ISubscription;
  end;

  /// <summary>
  /// Gives access to wrapper that wraps the same object as the wrapper implementing
  /// this interface. Wrappers implement this to facilitate the use of the Self keyword.</summary>
  IScopeSelf = interface
    ['{FAD875D9-7EDE-438C-A477-F7BCEF135147}']
    /// <summary>Gives access to the wrapper itself.</summary>
    /// <returns>The wrapper that wraps around the same object wrapped by the wrapper
    /// implementing this interface.</returns>
    function GetSelf: IInterface;
  end;

  /// <summary>
  /// Represents a scope which can be looked up for wrappers.
  /// For example, the '.' operator in the expressions uses this to find members of an object.
  /// It is also used for lookup of the root of expressions.
  /// Scope implementers can lookup not only on object RTTI, but on everything for which a
  /// valid wrapper with valid information may be created.
  /// </summary>
  IScope = interface
    ['{DAFE2455-3DB6-40CC-B1D6-1EAC0A29ABEC}']
    /// <summary>Look up a name in the scope. 
    /// The thing looked up could be a location, a value, a function, another scope, etc.</summary>
    /// <param name="Name"></param>
    /// <returns>A reference to the correspondent wrapper or nil if no wrapper was found.</returns>
    function Lookup(const Name: string): IInterface;
  end;

  /// <summary>A scope that permits more facilities for searching not only names, but objects too.</summary>
  IScopeEx = interface(IScope)
    ['{B757805E-E2B1-473D-A201-99BF6E1134FF}']
    /// <summary>Searches the scope for an object wrapper.</summary>
    /// <param name="Obj">The object that must be wrapped by the searched wrapper.</param>
    /// <returns>An reference to the wrapper or nil if there is no wrapper around the given object.</returns>
    function Lookup(Obj: TObject): IInterface; overload;
  end;

  /// <summary>
  /// Custom scopes permit the user to return custom wrapper for fake object members.
  /// These members to not physically exist in the object, but are rather
  /// calculated values denoted by names.
  /// Implement this interface to create a custom scope that can be registered
  /// with the custom scope factory. It provides information about the object and
  /// its representing metaclass on which the scope maps.
  /// Keep in mind that the custom scope returns the same custom wrapper for
  /// the same token name of an object and it is the job of the custom scope
  /// to update contents of the custom wrappers that are dependent on information
  /// in the custom scope that might have changed previously.</summary>
  ICustomScope = interface(IScope)
    function GetMappedObject: TObject;
    function GetMetaClass: TClass;
    procedure SetMappedObject(const Value: TObject);

    /// <summary>Represents the object passed to the custom scope factory on which
    /// the custom scope is created. Based on this object the custom scope
    /// will generate the custom wrappers.
    /// The object may also be nil. To handle this case, the custom scope may
    /// make use of the metadata.
    ///  </summary>
    property MappedObject: TObject read GetMappedObject write SetMappedObject;
    /// <summary>The metaclass on which the scope is created. In case the scope
    /// is associated with an object, the metaclass is that of the object.
    /// If the scope doesn't have an object associated, it returns the metaclass
    /// given by the custom scope factory.</summary>
    property MetaClass: TClass read GetMetaClass;
  end;

  /// <summary>An enumerable scope can be enumerated by an implementer of this interface.</summary>
  IScopeEnumerator = interface
    ['{AD60BFF2-4A13-4183-A6A9-20FE60FF035D}']
    /// <summary>Gives access to the current wrapper at any step in the iteration.</summary>
    /// <returns>The current wrapper in the iteration.</returns>
    function GetCurrent: IInterface;
    /// <summary>The iteration loop uses this method to jump to the next wrapper.</summary>
    /// <returns>True when the jump to the next wrapper has been successfuly done.
    /// False if there are no more wrappers to iterate through.</returns>
    function MoveNext: Boolean;
    /// <summary>Access to the current wrapper at any step in the iteration.</summary>
    property Current: IInterface read GetCurrent;
  end;

  /// <summary>
  /// A scope can have its wrappers enumerated if the implementor of the scope
  /// also implements this interface.</summary>
  IScopeEnumerable = interface
    ['{59DE173C-954A-4DBA-BAC1-5D1B9551B85A}']
    /// <summary>Used to obtain an instance to an enumerator that is capable of
    /// enumerating the wrappers of the enumerable scope. Generally, it is used
    /// by loop constructs, but it can also be accessed explicitly.</summary>
    /// <returns>A reference to an enumerator for the enumerable scope.</returns>
    function GetEnumerator: IScopeEnumerator;
  end;

  /// <summary>
  /// Each scope has a list of string symbols that are effectively used in the
  /// binding expression to let the engine know for which members of the scope
  /// is legal to create wrappers. In other words, it permits a scope to return
  /// wrappers only for the symbols present in the expression.</summary>
  IScopeSymbols = interface
    ['{1FF4BA45-C177-4847-ABFF-5D74D06400B1}']
    function GetSymbols(Index: Integer): String;
    procedure SetSymbols(Index: Integer; const Value: String);
    function GetSymbolCount: Integer;

    /// <summary>Adds a new symbol to the storage.</summary>
    /// <param name="Symbol">Specifies the string symbol to be added.</param>
    procedure Add(const Symbol: String);
    /// <summary>Removes an existing symbol from the storage.</summary>
    /// <param name="Symbol">The string symbol to be removed.</param>
    procedure Remove(const Symbol: String);
    /// <summary>Determines if the storage contains a given symbol.</summary>
    /// <param name="Symbol">The string symbol to be tested for containment.</param>
    function Contains(const Symbol: String): Boolean;
    /// <summary>Empties the storage of all the symbols in it.</summary>
    procedure Clear;

    /// <summary>Access to the string symbols.</summary>
    /// <param name="Index">Specifies the Index-th symbol to return. It starts
    /// from 0 up to SymbolCount - 1. </param>
    property Symbols[Index: Integer]: String read GetSymbols write SetSymbols;
    /// <summary>The number of stored string symbols.</summary>
    property SymbolCount: Integer read GetSymbolCount;
  end;

  /// <summary>The type of the custom wrapper is given by the type of the wrapped fake object member.</summary>
  TCustomWrapperType = (cwtProperty, cwtMethod, cwtIndexedProperty);

  /// <summary>Callback used by the custom wrapper to determine the actual value
  /// of the fake object member that it wraps around.</summary>
  // / <param name="ParentObject">The custom scope that has created the custom wrapper
  // / which uses this callback has been created in its turn on the object pointed
  // / by this property.</param>
  // / <param name="MemberName">The name of the fake object member that is wrapped
  // / by the custom wrapper that uses this callback.</param>
  // / <param name="Args">Arguments that are passed from the binding expression script
  // / to this routine to permit it to calculate the value of the wrapped fake
  // / object member. The fake object member must have the form of either an
  // / indexed property, either a method so that parameters can be passed in by
  // / the evaluator. Fake normal properties have this parameter empty.</param>
  /// <returns>The calculated value of the fake object member.</returns>
  TCustomWrapperGetterCallback = reference to function (ParentObject: TObject;
    const MemberName: String; Args: TArray<TValue>): TValue;

  /// <summary>
  /// A custom wrapper always implements this interface. It gives to the engine
  /// information about the syntactic form of the wrapped fake object member
  /// and the user routine that calculates the value for the fake member.
  /// For example, the engine can determine based on the wrapper type whether it
  /// needs to pass parameters or not to the custom wrapper in order to have
  /// the custom wrapper able to calculate the value of the wrapped fake object member.</summary>
  ICustomWrapper = interface
    ['{45963846-9D75-4219-8A5D-1CDEECAEA7CD}']
    function GetWrapperType: TCustomWrapperType;
    function GetGetterCallback: TCustomWrapperGetterCallback;
    procedure SetGetterCallback(const Callback: TCustomWrapperGetterCallback);

    /// <summary>It lets the engine know if the wrapper needs parameters to be
    /// able to return a valid value and also gives information on the syntax of
    /// the wrapped fake object member. It may look like a normal property,
    /// a method call, or a indexed property.</summary>
    property WrapperType: TCustomWrapperType read GetWrapperType;
    /// <summary>The callback is used by the engine to determine the actual value
    /// of the wrapped fake object member.</summary>
    property GetterCallback: TCustomWrapperGetterCallback read GetGetterCallback write SetGetterCallback;
  end;

  /// <summary>Describes the possible phases of the expression compiler.</summary>
  TCompiledBindingPhaseType = (cbpEmpty,
    cbpPrepareCompilation, cbpCompiling, cbpCompiled,
    cbpPrepareEvaluation, cbpEvaluating, cbpEvaluated, cbpEvaluationError);

  /// <summary>Permits evaluation of a compiled expression.</summary>
  ICompiledBinding = interface
    ['{42B9D178-5460-45F8-8CBF-5F8310A4C713}']
    function GetPhase: TCompiledBindingPhaseType;

    /// <summary>Evaluates the compiled expression represented by this interface.</summary>
    /// <param name="ARoot">The evaluator searches this scope for built-in
    /// operators and other global symbols that can be used in the expression.</param>
    /// <param name="ASubscriptionCallback">Any path along the expression which
    /// is subscribable will be subscribed to using this callback if it is not nil.</param>
    /// <param name="Subscriptions">A list of subscriptions that this procedure
    /// will add to each time it subscribes. If it is nil, then nothing will be
    /// subscribed to.</param>
    /// <returns>A wrapper containing the result value of the expression.</returns>
    function Evaluate(ARoot: IScope;
      ASubscriptionCallback: TSubscriptionNotification;
      {out} Subscriptions: TList<ISubscription>): IValue;
    /// <summary>Indicates the phase of the compiled binding at the moment of the call.</summary>
    property Phase: TCompiledBindingPhaseType read GetPhase;
  end;

  /// <summary>Describes a dictionary that holds wrappers. Usually, this kind of
  /// dictionary is used only to lookup for wrappers in order to see if they
  /// exist within the dictionary.</summary>
  TWrapperDictionary = TDictionary<IInterface, Pointer>;

  ICompiledBindingWrappers = interface
    ['{CAEEF849-A88F-4D4D-8980-395042DD56FA}']
    function GetWrappers: TWrapperDictionary;

    property Wrappers: TWrapperDictionary read GetWrappers;
  end;

  /// <summary>A wrapper may have a compiled binding that generated it. A wrapper
  /// may be created without being generated by a compiled binding. Although,
  /// a reference to a compiled binding can be set later on.
  /// Setting a reference to a compiled binding would be an indicator that the
  /// compiled binding created the wrapper.</summary>
  /// <remarks>Normally, the binding should be set only once.</remarks>
  IWrapperBinding = interface
    ['{8B5BF98B-DD68-4013-BBBB-4819CB8DD2AB}']
    function GetBinding: ICompiledBinding;
    procedure SetBinding(const Binding: ICompiledBinding);

    /// <summary>The compiled binding that owns the wrapper.</summary>
    property Binding: ICompiledBinding read GetBinding write SetBinding;
  end;

  IDebugBinding = interface
    ['{1BC1935C-3E46-4DB4-A56E-C1F15460CE8E}']
    procedure Dump(const W: TProc<string>);
  end;

  /// <summary>For rvalues - non-locations - a trivial implementation of IValue.</summary>
  TValueWrapper = class(TInterfacedObject, IWrapper, IValue)
  private
    FValue: TValue;
  public
    constructor Create(const AValue: TValue);

    { IValue }
    function GetValue: TValue;
    function GetType: PTypeInfo;
  end;

  /// <summary>Trivial wrapper for locations. It can wrap either around an object
  /// property, either it can use a getter and a setter provided by the user
  /// to maintain the value of the location as desired.</summary>
  TLocationWrapper = class(TInterfacedObject, IInterface,
    IWrapper,
    IValue, ILocation, IArguments)
  public type
    TValueGetter = reference to function: TValue;
    TValueSetter = reference to procedure(AValue: TValue);
  private type
    TWorkMode = (wmObjectProperty, wmGetterSetter);
  private var
    FProperty: TRttiProperty;
    FIndexedProperty: TRttiIndexedProperty;
    FWorkMode: TWorkMode;
    FObject: TObject;
    FArgs: TArray<TValue>;
    FType: PTypeInfo;
    FGetter: TValueGetter;
    FSetter: TValueSetter;
  public
    constructor Create(AType: PTypeInfo; const AGetter: TValueGetter;
      const ASetter: TValueSetter); overload;
    constructor Create(AObject: TObject; const PropertyName: String); overload;
    constructor Create(AObject: TObject; const PropertyName: String;
      const Args: TArray<TValue>); overload;

    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;

    { IValue }
    function GetType: PTypeInfo;
    function GetValue: TValue;

    { ILocation }
    procedure SetValue(const AValue: TValue);

    { IArguments }
    function GetArgs: TArray<TValue>;
    procedure SetArgs(const Args: TArray<TValue>);
  end;

                                                                                          
  /// <summary>
  /// Trivial implementation for IScopeSymbols. It does not hold duplicate symbols.
  /// Trying to add a duplicate, will result in no addition and no error.</summary>
  TScopeSymbols = class(TInterfacedObject, IScopeSymbols)
  private
    FSymbols: TList<String>;
  protected
    function GetSymbols(Index: Integer): String; inline;
    procedure SetSymbols(Index: Integer; const Value: String); inline;
    function GetSymbolCount: Integer; inline;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const Symbol: String); inline;
    procedure Remove(const Symbol: String); inline;
    function Contains(const Symbol: String): Boolean; inline;
    procedure Clear; inline;

    property Symbols[Index: Integer]: String read GetSymbols write SetSymbols;
    property SymbolCount: Integer read GetSymbolCount;
  end;

/// <summary>Creates an array of actual values from the given value wrappers.</summary>
/// <param name="Source">Array of value wrappers from which the resulting array is created.</param>
/// <returns>An array of actual values that can be used for RTTI method invokation.</returns>
function AdaptArguments(const Source: TArray<IValue>): TArray<TValue>;

implementation

function AdaptArguments(const Source: TArray<IValue>): TArray<TValue>;
var
  i: Integer;
begin
  SetLength(Result, Length(Source));
  for i := Low(Source) to High(Source) do
    Result[i] := Source[i].GetValue;
end;

{ TValueWrapper }

constructor TValueWrapper.Create(const AValue: TValue);
begin
  FValue := AValue;
end;

function TValueWrapper.GetType: PTypeInfo;
begin
  Result := FValue.TypeInfo;
end;

function TValueWrapper.GetValue: TValue;
begin
  Result := FValue;
end;

{ TLocationWrapper }

constructor TLocationWrapper.Create(AType: PTypeInfo; const AGetter: TValueGetter;
  const ASetter: TValueSetter);
begin
  inherited Create;

                                                                                      
  if not Assigned(AType) then
    raise EWrapperError.CreateFmt(SParamIsNil, ['AType']);
  if not Assigned(AGetter) and not Assigned(ASetter) then
    raise EWrapperError.Create(sNoGetterOrSetter);

  FWorkMode := wmGetterSetter;
  FType := AType;
  FGetter := AGetter;
  FSetter := ASetter;
end;

constructor TLocationWrapper.Create(AObject: TObject;
  const PropertyName: String);
var
  LCtx: TRttiContext;
  LType: TRttiType;
begin
  inherited Create;

  if not Assigned(AObject) then
    raise EWrapperError.CreateFmt(SParamIsNil, ['AObject']);

  // get the object RTTI type
  LCtx := TRttiContext.Create;
  FObject := AObject;
  LType := LCtx.GetType(FObject.ClassType);

  // search the property name among normal properties
  FProperty := LType.GetProperty(PropertyName);
  if not Assigned(FProperty) then
  begin
    // search the property name among indexed properties
    FIndexedProperty := LType.GetIndexedProperty(PropertyName);

    if not Assigned(FIndexedProperty) then
      raise EWrapperError.CreateFmt(sPropertyNotFound, [PropertyName]);
  end;

  FWorkMode := wmObjectProperty;
end;

constructor TLocationWrapper.Create(AObject: TObject;
  const PropertyName: String; const Args: TArray<TValue>);
begin
  Create(AObject, PropertyName);

  if Assigned(FIndexedProperty) then
    FArgs := Args;
end;

function TLocationWrapper.GetArgs: TArray<TValue>;
begin
  Result := FArgs;
end;

function TLocationWrapper.GetType: PTypeInfo;
begin
  if FWorkMode = wmObjectProperty then
    if Assigned(FProperty) then
      Result := FProperty.PropertyType.Handle
    else
      Result := FIndexedProperty.PropertyType.Handle
  else
    Result := FType;
end;

function TLocationWrapper.GetValue: TValue;
begin
  if FWorkMode = wmObjectProperty then
    if Assigned(FProperty) then
      Result := FProperty.GetValue(FObject)
    else
      Result := FIndexedProperty.GetValue(FObject, FArgs)
  else
    Result := FGetter();
end;

function TLocationWrapper.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  // don't permit access to IArguments when not working as an indexed property wrapper
  if ((FWorkMode <> TWorkMode.wmObjectProperty) or not Assigned(FIndexedProperty)) and
     (IID = IArguments) then
    Result := E_NOINTERFACE
  else
    Result := inherited QueryInterface(IID, Obj);
end;

procedure TLocationWrapper.SetArgs(const Args: TArray<TValue>);
begin
  FArgs := Args;
end;

procedure TLocationWrapper.SetValue(const AValue: TValue);
begin
  if FWorkMode = wmObjectProperty then
    if Assigned(FProperty) then
      FProperty.SetValue(FObject, AValue)
    else
      FIndexedProperty.SetValue(FObject, FArgs, AValue)
  else
    FSetter(AValue);
end;

{ TScopeSymbols }

procedure TScopeSymbols.Add(const Symbol: String);
begin
  if not FSymbols.Contains(Symbol) then
    FSymbols.Add(Symbol);
end;

procedure TScopeSymbols.Clear;
begin
  FSymbols.Clear;
end;

function TScopeSymbols.Contains(const Symbol: String): Boolean;
begin
  Result := FSymbols.Contains(Symbol);
end;

constructor TScopeSymbols.Create;
begin
  inherited;

  FSymbols := TList<String>.Create;
end;

destructor TScopeSymbols.Destroy;
begin
  FSymbols.Free;

  inherited;
end;

function TScopeSymbols.GetSymbolCount: Integer;
begin
  Result := FSymbols.Count;
end;

function TScopeSymbols.GetSymbols(Index: Integer): String;
begin
  Result := FSymbols[Index];
end;

procedure TScopeSymbols.Remove(const Symbol: String);
begin
  FSymbols.Remove(Symbol);
end;

procedure TScopeSymbols.SetSymbols(Index: Integer; const Value: String);
begin
  FSymbols[Index] := Value;
end;

end.
