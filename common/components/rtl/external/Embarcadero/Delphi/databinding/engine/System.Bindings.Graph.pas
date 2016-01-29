{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.Graph;

interface

uses
  System.SysUtils, System.Rtti, System.Generics.Collections, System.Bindings.Outputs,
  System.Bindings.EvalProtocol, System.Bindings.Expression, System.Bindings.Manager;

type
  TBindingGraph = class(TObject)
  public
    type
      TVisitedDict = TDictionary<TBindingExpression, Integer>;

      /// <summary>The type of the iteration counter.<summary>
      TIteration = Int64;
      /// <summary>Dictionary type that counts the iteration for each property in it.<summary>
      TProperties = TDictionary<String, TIteration>;
      /// <summary>The type for a dictionary that counts iteration numbers for
      /// each object property.</summary>
      TObjects = TObjectDictionary<TObject, TProperties>;
      /// <summary>Type that counts the iteration for expressions implied in the
      /// evaluation graph.</summary>
      TExpressions = TDictionary<TBindingExpression, TIteration>;

      // relation between an expression and its input wrappers
      TExprWrappersPair = TPair<TBindingExpression, TWrapperDictionary>;
      // depicts an association between an expression and a list of all or some
      // of its internal wrappers
      TExprWrappersDict = TObjectDictionary<TBindingExpression, TWrapperDictionary>;

      // the topological level of a object property
      TPropertyTopology = TPair<String, Integer>;
      // topological levels for all the properties of an object that are implied
      // in a topological scanning
      TPropertiesTopology = TDictionary<String, Integer>;
      // objects and their properties implied in the topological scan
      TObjectsTopology = TObjectDictionary<TObject, TPropertiesTopology>;
      // topological levels for binding expressions implied in the topologic scan
      TExpressionsTopology = TDictionary<TBindingExpression, Integer>;
      // expressions that have input objects marked partially and wait to be executed
      TExpressionsWaitQueue = TList<TBindingExpression>;

      TObjPropMarkedEvent = procedure (Obj: TObject; const PropertyName: String) of object;
      TExprMarkedEvent = procedure (Expr: TBindingExpression) of object;
  private
    class var
      FIteration: TIteration;
      FObjects: TObjects;
      FExpressions: TExpressions;
      FObjectsTopology: TObjectsTopology;
      FExpressionsTopology: TExpressionsTopology;
      FExpressionsWaitQueue: TExpressionsWaitQueue;
      FOnObjPropMarked: TObjPropMarkedEvent;
      FOnExprMarked: TExprMarkedEvent;

    // returns a list of binding expressions that use the given object property as input
    class procedure DoGetDependentExprs(Obj: TObject; const PropertyName: String;
      StartManager: TBindingManager; List: TList<TBindingExpression>);

    // realize the topological scan and go into indirect recurrence
    class procedure DoScanTopology(Obj: TObject; const PropertyName: String; Level: Integer;
      Manager: TBindingManager); overload;
    class procedure DoScanTopology(Expr: TBindingExpression; Level: Integer;
      Manager: TBindingManager); overload;
  public
    class constructor Create;
    class destructor Destroy;

    /// <summary>Marks a given property of an object with the current Iteration.</summary>
    /// <param name="Obj">The object whose property is going to be marked.</param>
    /// <param name="PropertyName">The name of the property that is going to be marked.</param>
    class procedure MarkIteration(Obj: TObject; const PropertyName: String); overload;
    /// <summary>Marks a given expression with the current Iteration.</summary>
    /// <param name="Expr">The expression that is going to be marked.</param>
    class procedure MarkIteration(Expr: TBindingExpression); overload;
    /// <summary>Obtains the iteration number with which the a given property of
    /// an object has been previously marked.</summary>
    /// <param name="Obj">The object whose property iteration count is going to be returned.</param>
    /// <param name="PropertyName">The name of the property for which the iteration
    /// count is going to be returned.</param>
    /// <returns>The iteration number for the object property.</returns>
    class function GetIterationMark(Obj: TObject; const PropertyName: String): TIteration; overload;
    /// <summary>Obtains the iteration number with which a given expression
    /// has been previously marked.</summary>
    /// <param name="Expr">The expression for which the iteration number must be returned.</param>
    /// <returns>The iteration number of the expression.</returns>
    class function GetIterationMark(Expr: TBindingExpression): TIteration; overload;
    /// <summary>Determines if the given object property is marked with the current
    /// iteration number.</summary>
    /// <param name="Obj">The object whose property is checked for the iteration number.</param>
    /// <param name="PropertyName">The name of the object property that is checked
    /// for the iteration number.</param>
    /// <returns>True if the specified object property is marked with the current
    /// Iteration number.</returns>
    class function IsIterationMarked(Obj: TObject; const PropertyName: String): Boolean; overload;
    /// <summary>Determines if the given binding expression object is marked with
    /// the current iteration number.</summary>
    /// <param name="Expr">The binding expression object that is checked for its
    /// iteration number.</param>
    /// <returns>True if the expression is marked with the current Iteration number.</returns>
    class function IsIterationMarked(Expr: TBindingExpression): Boolean; overload; inline;
    /// <summary>Determines if the objects/object properties wrapped by the
    /// wrappers in the given list are marked with the current iteration number.</summary>
    /// <param name="Wrappers">The wrappers to be checked.</param>
    /// <returns>True if all the objects wrapped by the Wrappers in the list are marked.</returns>
    /// <remarks>Placeholder wrappers that are EvalTimeOnly are considered as marked, too.</remarks>
    class function AreAllIterationMarked(Wrappers: TWrapperDictionary): Boolean;
    /// <summary>Clears the iteration markings of objects and object properties
    /// and binding expression objects.</summary>
    /// <remarks>It doesn't reset the iteration counter.</remarks>
    class procedure ClearIteration; inline;

    /// <summary>Determines if the specified object property is used as input
    /// by the given binding expression.</summary>
    /// <param name="Obj">The object whose property is checked to be used as input.</param>
    /// <param name="PropertyName">The name of the property to be checked.</param>
    /// <param name="Expr">The binding expression object on which the function tests
    /// whether the object property is used as input. </param>
    /// <returns>True if the specified object property is used as input by
    /// the binding expression.</returns>
    class function IsInput(Obj: TObject; const PropertyName: String; Expr: TBindingExpression): Boolean;
    /// <summary>Determines if the specified object property is used as output
    /// by the given binding expression.</summary>
    /// <param name="Obj">The object whose property is checked to be used as output.</param>
    /// <param name="PropertyName">The name of the property to be checked.</param>
    /// <param name="Expr">The binding expression object on which the function tests
    /// whether the object property is used as output. </param>
    /// <returns>True if the specified object property is used as output by
    /// the binding expression.</returns>
    class function IsOutput(Obj: TObject; const PropertyName: String; Expr: TBindingExpression): Boolean;

    /// <summary>Obtains a list of binding expression objects that are dependent
    /// on the given object property.</summary>
    /// <param name="Obj">The object to be searched among expressions.</param>
    /// <param name="PropertyName">The property name of the object.</param>
    /// <param name="Manager">The manager where the search starts. Pass nil to
    /// refer to the application-wide manager.</param>
    /// <returns>A list of all the expressions that are dependent on the given
    /// object property.</returns>
    /// <remarks> A binding expression is dependent on an object property if that
    /// expression uses the object property as one of its inputs.
    /// The routine analyzes all binding expressions in all the
    /// binding managers that are present in the application. The user must
    /// free the list when it becomes of no further use.</remarks>
    class function GetDependentExprs(Obj: TObject;
      const PropertyName: String; Manager: TBindingManager): TList<TBindingExpression>;
    /// <summary>Generates a dictionary that relates all the binding expression
    /// objects dependent on a given object property with the input wrappers
    /// in each binding expression that wrap around that object property.</summary>
    /// <param name="Obj">The object whose property is searched throughout all
    /// the binding expressions.</param>
    /// <param name="PropertyName">The name of the property searched throughout
    /// all the binding expressions for their dependencies on the property.</param>
    /// <param name="Manager">The manager from which the search starts.</param>
    /// <returns>A dictionary that relates every expression that is dependent on
    /// the given object property with a full list of the input wrappers that
    /// wrap around that object property.</returns>
    /// <remarks>The user must free the returned dictionary when it becomes
    /// of no further use.</remarks>
    class function GetDependentExprsWrappers(Obj: TObject; const PropertyName: String;
      Manager: TBindingManager): TExprWrappersDict;

    /// <summary>Marks a given object property with the specified topological level.</summary>
    /// <param name="Obj">The object whose property is going to be topologically marked.</param>
    /// <param name="PropertyName">The name of the property that is going to be
    /// topologically marked.</param>
    /// <param name="Level">The level number with which the object property is
    /// going to be topologically marked.</param>
    class procedure MarkTopologic(Obj: TObject; const PropertyName: String;
      Level: Integer); overload;
    /// <summary>Marks the binding expression with the specified topological level.</summary>
    /// <param name="Expr">The binding expression object that is going to be
    /// topologically marked.</param>
    /// <param name="Level">The level number with which the binding expression object
    /// is going to be topologically marked.</param>
    class procedure MarkTopologic(Expr: TBindingExpression; Level: Integer); overload;
    /// <summary>Determines the topological level of a given object property.</summary>
    /// <param name="Obj">The object whose property is checked for the topological
    /// level marking.</param>
    /// <param name="PropertyName">The name of the property whose topological
    /// level is returned.</param>
    /// <returns>The topological level with which the specified object property
    /// is currently marked.</returns>
    /// <remarks>The default level for every object property is 0, which means
    /// that it hasn't been topologically marked yet.</remarks>
    class function GetTopologicLevel(Obj: TObject; const PropertyName: String): Integer; overload;
    /// <summary>Determines the topological level of a given binding expression object.</summary>
    /// <param name="Expr">The binding expression object whose topological
    /// level is returned.</param>
    /// <returns>The topological level with which the specified binding expression
    /// object is currently marked.</returns>
    /// <remarks>The default level for every binding expression object is 0,
    /// which means that it hasn't been topologically marked yet.</remarks>
    class function GetTopologicLevel(Expr: TBindingExpression): Integer; overload;
    /// <summary>Determines if a given object property is topologically marked.</summary>
    /// <param name="Obj">The object whose property is checked for topological marking.</param>
    /// <param name="PropertyName">The name of the property that is checked
    /// for the topological mark.</param>
    /// <returns>True if the specified object property is topologically marked.</returns>
    class function IsTopologicMarked(Obj: TObject; const PropertyName: String): Boolean; overload; inline;
    /// <summary>Determines if a given binding expression object is topologically marked.</summary>
    /// <param name="Expr">The binding expression object that is checked
    /// if it is topologically marked.</param>
    /// <returns>True if the binding expression object is topologically marked.</returns>
    class function IsTopologicMarked(Expr: TBindingExpression): Boolean; overload; inline;
    /// <summary>Starts a topological scan at the specified object property and
    /// marks with topological levels all the objects properties and binding
    /// expression objects on the graph that can be covered by the scan.</summary>
    /// <param name="Obj">The object at which the topological scan will start.</param>
    /// <param name="PropertyName">The name of the property of the object at which
    /// <param name="Manager">The manager at which the scan starts.</param>
    /// the topological scan will start.</param>
    class procedure ScanTopology(Obj: TObject; const PropertyName: String;
      Manager: TBindingManager); overload; inline;
    /// <summary>Starts a topological scan at the specified binding expression object
    /// and marks with topological levels all the objects properties and binding
    /// expression objects on the graph that can be covered by the scan.</summary>
    /// <param name="Expr">The binding expression object at which the topological
    /// scan will start.</param>
    /// <param name="Manager">The manager at which the scan starts. It's used to pass
    /// it further to the topology scan call on object properties.</param>
    class procedure ScanTopology(Expr: TBindingExpression; Manager: TBindingManager); overload; inline;
    /// <summary>Clears the topology data.</summary>
    class procedure ClearTopology; inline;

    /// <summary>Determines if the given binding expression is present in the
    /// binding expression wait queue.</summary>
    /// <param name="Expr">The binding expression object that is checked for
    /// presence in the wait queue.</param>
    /// <returns>True if binding expression object is in the wait queue.</returns>
    class function IsWaiting(Expr: TBindingExpression): Boolean; inline;
    /// <summary>Determines if the binding expression wait queue is empty.</summary>
    /// <returns>True if the wait queue is empty.</returns>
    class function IsWaitQueueEmpty: Boolean; inline;
    /// <summary>Enqueues the ginen binding expression in the binding expression
    /// wait queue.</summary>
    /// <param name="Expr">The binding expression object that is going to be
    /// enqueued.</param>
    /// <remarks>If the given binding expression is already enqueued, it doesn't
    /// add it twice to the wait queue.</remarks>
    class procedure EnqueueWait(Expr: TBindingExpression); inline;
    /// <summary>Dequeues a binding expression from the wait queue.</summary>
    /// <param name="Expr">The binding expression object that is going to be
    /// removed from the wait queue.</param>
    /// <remarks>It removes the binding expression from the wait queue even
    /// if it's not at the head of the queue.</remarks>
    class procedure DequeueWait(Expr: TBindingExpression); overload; inline;
    /// <summary>Dequeues the expression at the head of the queue.</summary>
    /// <returns>The binding expression object that is the head of the queue.</returns>
    /// <remarks>If the queue is empty, it returns nil.</remarks>
    class function DequeueWait: TBindingExpression; overload; inline;

    /// <summary>Increments the value of the current iteration.</summary>
    /// <param name="Step">The amount with which the current iteration is going
    /// to be incremented.</param>
    /// <returns>The new value of the current iteration.</returns>
    class function IncIteration(Step: Integer = 1): Integer; inline;

    /// <summary>The current iteration number.</summary>
    class property Iteration: TIteration read FIteration write FIteration;
    /// <summary>The dictionary of object properties that counts the iteration
    /// number for each property</summary>
    class property Objects: TObjects read FObjects;
    /// <summary>Stores the iteration number for each expression.</summary>
    class property Expressions: TExpressions read FExpressions;
    /// <summary>Stores the topological level of the properties implied in the
    /// topological scan.</summary>
    class property ObjectsTopology: TObjectsTopology read FObjectsTopology;
    /// <summary>Stores the topological level of the binding expressions objects
    /// implied in the topological scan.</summary>
    class property ExpressionsTopology: TExpressionsTopology read FExpressionsTopology;
    /// <summary>The binding expression wait queue that stores binding expressions
    /// which do not get notified internally, but must get notified.
    /// These expressions are in a notification lock and the engine notifies each
    /// one of them after the evaluation cycle in which they must have been
    /// completes.</summary>
    class property ExpressionsWaitQueue: TExpressionsWaitQueue read FExpressionsWaitQueue;

                                                                                            
    class property OnObjPropMarked: TObjPropMarkedEvent read FOnObjPropMarked
      write FOnObjPropMarked;
    class property OnExprMarked: TExprMarkedEvent read FOnExprMarked
      write FOnExprMarked;
  end;

implementation

uses
  System.Bindings.Search, System.Bindings.Factories;

{ TBindingGraph }

class procedure TBindingGraph.MarkTopologic(Obj: TObject;
  const PropertyName: String; Level: Integer);
var
  LProperties: TPropertiesTopology;
begin
  if Assigned(Obj) then
  begin
    // grab/add the properties dictionary for the given object
    if ObjectsTopology.ContainsKey(Obj) then
      LProperties := ObjectsTopology.Items[Obj]
    else
    begin
      LProperties := TPropertiesTopology.Create;
      ObjectsTopology.Add(Obj, LProperties);
    end;

    // grab/add the list of entities for the object and property
    if LProperties.ContainsKey(PropertyName) then
      LProperties.Items[PropertyName] := Level
    else
      LProperties.Add(PropertyName, Level);
  end;
end;

class function TBindingGraph.AreAllIterationMarked(Wrappers: TWrapperDictionary): Boolean;
var
  LWrapper: IInterface;
  LWChild: IChild;
  LWPlaceholder: IPlaceholder;
begin
  Result := Assigned(Wrappers);
  if Result then
    for LWrapper in Wrappers.Keys do
      if Supports(LWrapper, IChild, LWChild) then
      begin
        if Assigned(LWChild.Parent) then        
          Result := IsIterationMarked(LWChild.Parent, LWChild.MemberName);

        // the object member is not iteration-marked in the internal structures;
        // check if its wrapper is a placeholder wrapper that has a valid value set
        // only after evaluation of the expression (EvalTimeOnly)
        if not Result then
          Result := Supports(LWrapper, IPlaceholder, LWPlaceholder) and
                    LWPlaceholder.EvalTimeOnly;

        if not Result then
          Break;
      end;
end;

class procedure TBindingGraph.ClearIteration;
begin
  Objects.Clear;
  Expressions.Clear;
end;

class procedure TBindingGraph.ClearTopology;
begin
  ObjectsTopology.Clear;
  ExpressionsTopology.Clear;
end;

class constructor TBindingGraph.Create;
begin
  inherited;

  FObjects := TObjects.Create([doOwnsValues]);
  FExpressions := TExpressions.Create;
  FObjectsTopology := TObjectsTopology.Create([doOwnsValues]);
  FExpressionsTopology := TExpressionsTopology.Create;
  FExpressionsWaitQueue := TExpressionsWaitQueue.Create;
end;

class procedure TBindingGraph.DequeueWait(Expr: TBindingExpression);
begin
  ExpressionsWaitQueue.Remove(Expr);
end;

class function TBindingGraph.DequeueWait: TBindingExpression;
begin
  Result := nil;
  if not IsWaitQueueEmpty then
  begin
    Result := ExpressionsWaitQueue.First;
    DequeueWait(Result);
  end;
end;

class destructor TBindingGraph.Destroy;
begin
  FObjects.Free;
  FExpressions.Free;
  FObjectsTopology.Free;
  FExpressionsTopology.Free;
  FExpressionsWaitQueue.Free;

  inherited;
end;

class procedure TBindingGraph.DoGetDependentExprs(Obj: TObject;
  const PropertyName: String; StartManager: TBindingManager;
  List: TList<TBindingExpression>);
var
  LExpr: TBindingExpression;
  LExprWrprs: ICompiledBindingWrappers;
  LWrapper: IInterface;
  LObjectOnly: Boolean;
  i: Integer;
begin
  if Assigned(Obj) and Assigned(StartManager) and Assigned(List) then
  begin
    LObjectOnly := PropertyName = '';

    // take each of the expressions in StartManager and check them for dependency
    // on the specified object and property
    for i := 0 to StartManager.ExprCount - 1 do
    begin
      LExpr := StartManager.Expressions[i];

      // check if the current expression is dependent on the specified object and property
      if Supports(LExpr, ICompiledBindingWrappers, LExprWrprs) then
      begin
        if LObjectOnly then
          LWrapper := TBindingSearch.DepthSearchObject(Obj, LExprWrprs.Wrappers)
        else
          LWrapper := TBindingSearch.DepthSearchProperty(Obj, PropertyName, LExprWrprs.Wrappers);

        if Assigned(LWrapper) then
          List.Add(LExpr);
      end;
    end;

    // take each sub-manager and repeat the steps above on their expressions
    for i := 0 to StartManager.ManagerCount - 1 do
      DoGetDependentExprs(Obj, PropertyName, StartManager.Managers[i], List);
  end;
end;

class procedure TBindingGraph.DoScanTopology(Obj: TObject;
  const PropertyName: String; Level: Integer; Manager: TBindingManager);
var
  LExprs: TList<TBindingExpression>;
  LExpr: TBindingExpression;
begin
  if Assigned(Obj) and not IsTopologicMarked(Obj, PropertyName) then
  begin
    MarkTopologic(Obj, PropertyName, Level);

    LExprs := nil;
    try
      LExprs := GetDependentExprs(Obj, PropertyName, Manager);
      for LExpr in LExprs do
        DoScanTopology(LExpr, Level + 1, Manager);
    finally
      LExprs.Free;
    end;
  end;
end;

class procedure TBindingGraph.DoScanTopology(Expr: TBindingExpression;
  Level: Integer; Manager: TBindingManager);
var
  DestPair: TBindingOutput.TDestinationPair;
  WrprChild: IChild;
  LocRec: TBindingOutput.TLocationRec;
  ScopeEnumerable: IScopeEnumerable;
  Parent: TObject;
  MemberName: String;
  Found: Boolean;
begin
  if Assigned(Expr) and not IsTopologicMarked(Expr) then
  begin
    MarkTopologic(Expr, Level);

    for DestPair in Expr.Outputs.Destinations do
    begin
      // the location must be found; otherwise there is a problem with function
      Found := Expr.Outputs.GetLocationRec(DestPair.Key, LocRec);
      Assert(Found, 'TBindingOutput.GetLocationRec() has a problem');

      if Found then
      begin
        // reattach the wrappers for expression generated locations
        if LocRec.IsExpression and Supports(LocRec.Scope, IScopeEnumerable, ScopeEnumerable) then
          TBindingSearch.PrepareWrappersForEvaluation(ScopeEnumerable);

        // the output property is specified directly using the <object, property-name> tuple
        WrprChild := DestPair.Key as IChild;
        Parent := WrprChild.Parent;
        MemberName := WrprChild.MemberName;

        DoScanTopology(Parent, MemberName, Level + 1, Manager)
      end;
    end;
  end;
end;

class function TBindingGraph.GetDependentExprs(Obj: TObject;
  const PropertyName: String; Manager: TBindingManager): TList<TBindingExpression>;
begin
  Result := TList<TBindingExpression>.Create;

  // determine whether the application-wide manager must be used
  if not Assigned(Manager) then
    Manager := TBindingManagerFactory.AppManager;

  DoGetDependentExprs(Obj, PropertyName, Manager, Result);
end;

class function TBindingGraph.GetDependentExprsWrappers(Obj: TObject;
  const PropertyName: String; Manager: TBindingManager): TExprWrappersDict;
var
  BindingWrappers: ICompiledBindingWrappers;
  LExprs: TList<TBindingExpression>;
  LExpr: TBindingExpression;
begin
  LExprs := nil;

  try
    Result := TExprWrappersDict.Create;
    LExprs := GetDependentExprs(Obj, PropertyName, Manager);

    // for each expression grab the input wrappers and relate them in the dictionary
    for LExpr in LExprs do
      if Supports(LExpr, ICompiledBindingWrappers, BindingWrappers) then
        Result.Add(LExpr, BindingWrappers.Wrappers);
  finally
    LExprs.Free;
  end;
end;

class function TBindingGraph.GetIterationMark(Obj: TObject;
  const PropertyName: String): TIteration;
begin
  Result := 0;
  if Objects.ContainsKey(Obj) and Objects.Items[Obj].ContainsKey(PropertyName) then
    Result := Objects[Obj][PropertyName];
end;

class function TBindingGraph.GetIterationMark(Expr: TBindingExpression): TIteration;
begin
  Result := 0;
  if Expressions.ContainsKey(Expr) then
    Result := Expressions[Expr];
end;

class function TBindingGraph.GetTopologicLevel(
  Expr: TBindingExpression): Integer;
begin
  Result := 0;
  if Assigned(Expr) and ExpressionsTopology.ContainsKey(Expr) then
    Result := ExpressionsTopology.Items[Expr];
end;

class function TBindingGraph.GetTopologicLevel(Obj: TObject;
  const PropertyName: String): Integer;
var
  LProperties: TPropertiesTopology;
begin
  Result := 0;
  if Assigned(Obj) and ObjectsTopology.ContainsKey(Obj) then
  begin
    LProperties := ObjectsTopology.Items[Obj];

    if LProperties.ContainsKey(PropertyName) then
      Result := LProperties.Items[PropertyName];
  end;
end;

class function TBindingGraph.IsTopologicMarked(Obj: TObject;
  const PropertyName: String): Boolean;
begin
  Result := GetTopologicLevel(Obj, PropertyName) <> 0;
end;

class function TBindingGraph.IncIteration(Step: Integer): Integer;
begin
  Inc(FIteration, Step);
  Result := FIteration;
end;

class function TBindingGraph.IsWaiting(Expr: TBindingExpression): Boolean;
begin
  Result := Assigned(Expr) and ExpressionsWaitQueue.Contains(Expr);
end;

class function TBindingGraph.IsWaitQueueEmpty: Boolean;
begin
  Result := ExpressionsWaitQueue.Count = 0;
end;

class function TBindingGraph.IsInput(Obj: TObject; const PropertyName: String;
  Expr: TBindingExpression): Boolean;
var
  LExprScopeEx: IScopeEx;
begin
  Result := Assigned(Obj) and
            Supports(Expr, IScopeEx, LExprScopeEx) and
            Assigned(TBindingSearch.DepthSearchProperty(Obj, PropertyName, LExprScopeEx));
end;

class function TBindingGraph.IsIterationMarked(Obj: TObject;
  const PropertyName: String): Boolean;
var
  Props: TProperties;
begin
                                                                  
  Result := False;
  if Assigned(Obj) and Objects.ContainsKey(Obj) then
  begin
    Props := Objects.Items[Obj];
    Result := Props.ContainsKey(PropertyName) and (Props.Items[PropertyName] = Iteration);
  end;
end;

class function TBindingGraph.IsIterationMarked(Expr: TBindingExpression): Boolean;
begin
                                                                  
  Result := Expressions.ContainsKey(Expr) and (Expressions.Items[Expr] = Iteration);
end;

class function TBindingGraph.IsOutput(Obj: TObject; const PropertyName: String;
  Expr: TBindingExpression): Boolean;
begin
  Result := Assigned(Obj) and
            Assigned(Expr) and
            Expr.Outputs.Destinations.ContainsValue(TBindingOutput.TOutputPair.Create(Obj, PropertyName));
end;

class function TBindingGraph.IsTopologicMarked(
  Expr: TBindingExpression): Boolean;
begin
  Result := GetTopologicLevel(Expr) <> 0;
end;

class procedure TBindingGraph.MarkIteration(Expr: TBindingExpression);
begin
  Expressions.AddOrSetValue(Expr, Iteration);

  if Assigned(OnExprMarked) then
    OnExprMarked(Expr);
end;

class procedure TBindingGraph.MarkTopologic(Expr: TBindingExpression;
  Level: Integer);
begin
  if not ExpressionsTopology.ContainsKey(Expr) then
    ExpressionsTopology.Add(Expr, Level)
  else
    ExpressionsTopology.Items[Expr] := Level;
end;

class procedure TBindingGraph.EnqueueWait(Expr: TBindingExpression);
begin
  if not IsWaiting(Expr) then
    ExpressionsWaitQueue.Add(Expr);
end;

class procedure TBindingGraph.ScanTopology(Expr: TBindingExpression;
  Manager: TBindingManager);
begin
  if Assigned(Expr) then
    DoScanTopology(Expr, 1, Manager);
end;

class procedure TBindingGraph.ScanTopology(Obj: TObject;
  const PropertyName: String; Manager: TBindingManager);
begin
  if Assigned(Obj) then
    DoScanTopology(Obj, PropertyName, 1, Manager);
end;

class procedure TBindingGraph.MarkIteration(Obj: TObject; const PropertyName: String);
var
  PropDict: TProperties;
begin
  if Objects.ContainsKey(Obj) then // get the property iteration dictionary
    PropDict := Objects.Items[Obj]
  else // create the property iteration dictionary and get it
  begin
    PropDict := TProperties.Create;
    Objects.Add(Obj, PropDict);
  end;

  PropDict.AddOrSetValue(PropertyName, Iteration);

  if Assigned(OnObjPropMarked) then
    OnObjPropMarked(Obj, PropertyName);
end;

end.
