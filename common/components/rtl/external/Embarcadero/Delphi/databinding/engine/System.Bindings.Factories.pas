{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.Factories;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Rtti, System.RTLConsts, System.Bindings.Consts,

  System.Bindings.NotifierContracts, System.Bindings.Expression, System.Bindings.Manager, System.Bindings.CustomScope;

type

  { TBindingExpressionFactory

    Creates instances of binding expressions that are used the binding manager.
    Do not use the factory to create standalone instances. Use a manager instead.
    Creating instances using the factory will make the manager unaware of the
    existance of the expression and therefore the expression will not be
    recompiled and reevaluated in case a script property changes. }

  TBindingExpressionFactory = class(TObject)
  public
    class function CreateExpression(Manager: TBindingManager = nil): TBindingExpression;
  end;

  { TBindingManagerFactory

    Creates instances of binding managers that are used to handle binding expressions. }

  TBindingManagerFactory = class(TObject)
  private
    class var
      FAppManager: TBindingManager;

    // creates an instance of the default implementation for TBindingManager
    class function CreateManagerInstance(Owner: TBindingManager): TBindingManager;
  public
    class constructor Create;
    class destructor Destroy;

    // creates a new manager that is owner by the Owner manager;
    // if Owner is Nil, the new manager will be owned by the
    // application wide manager
    class function CreateManager(Owner: TBindingManager = nil): TBindingManager;
    // the instance of the application wide binding manager
    class property AppManager: TBindingManager read FAppManager;
  end;

  // Exception for errors that are raised when managing custom scopes.
  EBindingScopeFactoryError = class(Exception);

  /// <summary>Instantiates custom scope objects based on the registred associations
  /// between a scope class and an object class for which the scope is created.</summary>
  TBindingScopeFactory = class(TObject)
  public
    type
      TScopeTuple = TPair<TClass, TScopeClass>;
  private
    type
      TScopeTuples = TDictionary<TClass, TScopeClass>;
    class var
      FScopeTuples: TScopeTuples;
    class function GetScopeTuples: TScopeTuples; static;
    class function GetScopeClassCount: Integer; static; inline;
    class function GetScopeClasses(const ObjectType: TClass): TScopeClass; static; inline;
  public
    class destructor Destroy;

    /// <summary>Registers the specified scope class for the specified object class.</summary>
    /// <param name="ObjectType">Class reference for the object to which the scope type is attached.</param>
    /// <param name="ScopeClass">Scope class reference registered for the given object type.</param>
    class procedure RegisterScope(ObjectType: TClass; ScopeClass: TScopeClass);
    /// <summary>Unregisters the scope class associated with the given object type.</summary>
    /// <param name="ObjectType">Class reference for the object to which the scope type is associated.</param>
    class procedure UnregisterObjectType(ObjectType: TClass);
    // Unregisters all the associations that have the given scope class.
    class procedure UnregisterScope(ScopeClass: TScopeClass);
    /// <summary>Unregisters all the scopes in the factory.</summary>
    class procedure UnregisterScopes; inline;

    // returns True if the given object type has a scope class registered with it
    class function IsObjectTypeRegistered(ObjectType: TClass; InheritOkay: Boolean = False): Boolean; inline;
    // returns True if the given scope class is registered with an object type
    class function IsScopeClassRegistered(ScopeClass: TScopeClass): Boolean; inline;

    // returns the scope class associated with the given object type that object type
    // is registered; if not, it returns the scope class for the closest registered
    // ancestor for the given object type; if no ancestor is found, it returns nil
    class function GetBestFitScope(ObjectType: TClass): TScopeClass;

                                                                                                    
    class function GetEnumerator: TScopeTuples.TPairEnumerator; inline;

    /// <summary>Instantiates a custom scope associated to either the type of the passed object,
    /// either to the passed class reference.</summary>
    /// <param name="AObject">The object which the custom scope will be able to use
    /// to create custom wrappers.</param>
    /// <param name="MetaClass">The class reference to be used in case the object is nil.
    /// This parameter cannot be nil if the passed object is nil.</param>
    /// <returns>The custom scope instance.</returns>
    class function CreateScope(const AObject: TObject; MetaClass: TClass): TCustomScope; overload;
    /// <param name="AObject">The object which the custom scope will be able to use
    /// to create custom wrappers.</param>
    /// <param name="MetaClass">The class reference to be used in case the object is nil.
    /// This parameter cannot be nil if the passed object is nil.</param>
    /// <param name="AObject"></param>
    /// <param name="MetaClass"></param>
    /// <param name="CustomScope">If the function succeeds, it contains a reference
    /// to the custom scope instance. If no association is found for the passed class references,
    /// this parameter contains nil.</param>
    /// <returns>True if it succeeds and False if it doesn't.</returns>
    class function CreateScope(const AObject: TObject; MetaClass: TClass;
      out CustomScope: TCustomScope): Boolean; overload; inline;
    /// <summary>Instantiates a custom scope associated to the type of the passed object.</summary>
    /// <param name="AObject">The object which the custom scope will be able to use
    /// to create custom wrappers. It cannot be nil.</param>
    /// <returns>The custom scope instance.</returns>
    class function CreateScope(const AObject: TObject): TCustomScope; overload;
    class function CreateScope(const AObject: TObject; out CustomScope: TCustomScope): Boolean; overload; inline;

                                                                                                                    
    // access to the registered custom scope classes
    class property ScopeClasses[const ObjectType: TClass]: TScopeClass read GetScopeClasses;
    // the total number of registered custom scope classes
    class property ScopeClassCount: Integer read GetScopeClassCount;
  end;

implementation

uses
  System.Bindings.NotifierDefaults, System.Bindings.ExpressionDefaults,
  System.Bindings.ManagerDefaults, System.SyncObjs;


{ TBindingExpressionFactory }

class function TBindingExpressionFactory.CreateExpression(
  Manager: TBindingManager): TBindingExpression;
begin
  if not Assigned(Manager) then
    Manager := TBindingManagerFactory.AppManager;

  Result := TBindingExpressionDefault.Create(Manager);
end;

{ TBindingManagerFactory }

class constructor TBindingManagerFactory.Create;
begin
  inherited;

  FAppManager := CreateManagerInstance(nil);
end;

class function TBindingManagerFactory.CreateManager(Owner: TBindingManager): TBindingManager;
begin
  if not Assigned(Owner) then
    Owner := AppManager;

  Result := CreateManagerInstance(Owner);
end;

class function TBindingManagerFactory.CreateManagerInstance(
  Owner: TBindingManager): TBindingManager;
begin
  Result := TBindingManagerDefault.Create(Owner);
end;

class destructor TBindingManagerFactory.Destroy;
begin
  FAppManager.Free;

  inherited;
end;

{ TBindingScopeFactory }

class function TBindingScopeFactory.CreateScope(
  const AObject: TObject; MetaClass: TClass): TCustomScope;
var
  ScopeClass: TScopeClass;
begin
  if not Assigned(AObject) and not Assigned(MetaClass) then
    raise EBindingScopeFactoryError.CreateFmt(sParamIsNil, ['MetaClass']);

  Result := nil;
  if AObject = nil then
    ScopeClass := GetBestFitScope(MetaClass)
  else
    ScopeClass := GetBestFitScope(AObject.ClassType);
  if Assigned(ScopeClass) then
    Result := ScopeClass.Create(AObject, MetaClass);
end;

class function TBindingScopeFactory.CreateScope(
  const AObject: TObject): TCustomScope;
begin
  if not Assigned(AObject) then
    raise EBindingScopeFactoryError.CreateFmt(SParamIsNil, ['AObject']);

  Result := CreateScope(AObject, AObject.ClassType);
end;

class function TBindingScopeFactory.CreateScope(const AObject: TObject;
  MetaClass: TClass; out CustomScope: TCustomScope): Boolean;
begin
  CustomScope := CreateScope(AObject, MetaClass);
  Result := Assigned(CustomScope);
end;

class destructor TBindingScopeFactory.Destroy;
begin
  FreeAndNil(FScopeTuples);
end;

class function TBindingScopeFactory.GetBestFitScope(
  ObjectType: TClass): TScopeClass;
var
  ScopeTuple: TScopeTuple;
  BestObjType: TClass;
  Found: Boolean;
  LScopeTuples: TScopeTuples;
begin
  LScopeTuples := GetScopeTuples;
  // try to find an exact match
  if not LScopeTuples.TryGetValue(ObjectType, Result) then
  begin
    // determine the best fit by cycling among all the registered types
    // and select the closest existing ancestor for ObjectType
    BestObjType := TObject;
    Found := False;
    for ScopeTuple in LScopeTuples do
    begin
      if ObjectType.InheritsFrom(ScopeTuple.Key) and ScopeTuple.Key.InheritsFrom(BestObjType) then
      begin
        BestObjType := ScopeTuple.Key;
        Found := True;
      end;
    end;

    // get the scope class associated with the closest existing ancestor for object type
    if Found then
      Result := LScopeTuples.Items[BestObjType]
    else
      Result := nil;
  end;
end;

class function TBindingScopeFactory.GetEnumerator: TScopeTuples.TPairEnumerator;
begin
  Result := GetScopeTuples.GetEnumerator;
end;

class function TBindingScopeFactory.GetScopeClassCount: Integer;
begin
  Result := GetScopeTuples.Count
end;

class function TBindingScopeFactory.GetScopeClasses(
  const ObjectType: TClass): TScopeClass;
begin
  Result := GetScopeTuples[ObjectType]
end;

class function TBindingScopeFactory.IsObjectTypeRegistered(
  ObjectType: TClass; InheritOkay: Boolean = False): Boolean;
begin
  if InheritOkay then
    Result := GetBestFitScope(ObjectType) <> nil
  else
    Result := GetScopeTuples.ContainsKey(ObjectType);
end;

class function TBindingScopeFactory.IsScopeClassRegistered(
  ScopeClass: TScopeClass): Boolean;
begin
  Result := GetScopeTuples.ContainsValue(ScopeClass);
end;

class procedure TBindingScopeFactory.RegisterScope(ObjectType: TClass;
  ScopeClass: TScopeClass);
begin
  if IsScopeClassRegistered(ScopeClass) then
    raise EBindingScopeFactoryError.CreateFmt(sScopeClassAlreadyRegistered, [ScopeClass.ClassName]);

  GetScopeTuples.Add(ObjectType, ScopeClass);
end;

class procedure TBindingScopeFactory.UnregisterObjectType(ObjectType: TClass);
begin
  if not IsObjectTypeRegistered(ObjectType) then
    raise EBindingScopeFactoryError.CreateFmt(sObjectTypeNotRegistered, [ObjectType.ClassName]);

  GetScopeTuples.Remove(ObjectType);
end;

class procedure TBindingScopeFactory.UnregisterScope(ScopeClass: TScopeClass);
var
  ScopeTuple: TScopeTuple;
  TupleList: TList<TScopeTuple>;
  LScopeTuples: TScopeTuples;
begin
  LScopeTuples := GetScopeTuples;
  if not IsScopeClassRegistered(ScopeClass) then
    raise EBindingScopeFactoryError.CreateFmt(sScopeClassNotRegistered, [ScopeClass.ClassName]);

  TupleList := nil;
  try
    // generate a list that stores the tuples containing the given scope class
    TupleList := TList<TScopeTuple>.Create;
    for ScopeTuple in LScopeTuples do
      if ScopeTuple.Value = ScopeClass then
        TupleList.Add(ScopeTuple);

    // delete the associations that reference the given scope class
    for ScopeTuple in TupleList do
      LScopeTuples.Remove(ScopeTuple.Key);
  finally
    TupleList.Free;
  end;
end;

class procedure TBindingScopeFactory.UnregisterScopes;
begin
  GetScopeTuples.Clear;
end;

class function TBindingScopeFactory.CreateScope(const AObject: TObject;
  out CustomScope: TCustomScope): Boolean;
begin
  CustomScope := CreateScope(AObject);
  Result := Assigned(CustomScope);
end;

class function TBindingScopeFactory.GetScopeTuples: TScopeTuples;
var
  LScopeTuples: TScopeTuples;
begin
  if FScopeTuples = nil then
  begin
    LScopeTuples := TScopeTuples.Create;
    if TInterlocked.CompareExchange(TObject(FScopeTuples), TObject(LScopeTuples), TObject(nil)) <> nil then
      LScopeTuples.Free;
  end;
  Result := FScopeTuples;
end;

end.
