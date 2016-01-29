{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.Helper;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.TypInfo, System.Bindings.EvalProtocol, System.Bindings.EvalSys,
  System.Bindings.NotifierContracts, System.Bindings.NotifierDefaults, System.Bindings.Factories,
  System.Bindings.Expression, System.Bindings.ExpressionDefaults, System.Bindings.Manager, System.Bindings.Outputs;

type
  EBindHelperException = class(Exception);

  /// <summary>Binding Events Record</summary>
  TBindingEventRec = record
  public
    EvalErrorEvent: TBindingEvalErrorEvent;
    AssigningValueEvent: TBindingAssigningValueEvent;
    AssignedValueEvent: TBindingAssignedValueEvent;
    LocationUpdatedEvent: TBindingLocationUpdatedEvent;
    class function Create: TBindingEventRec; overload; static;
    constructor Create(AEvalErrorEvent: TBindingEvalErrorEvent); overload;
    constructor Create(AAssigningValueEvent: TBindingAssigningValueEvent); overload;
    constructor Create(AEvalErrorEvent: TBindingEvalErrorEvent; AAssigningValueEvent: TBindingAssigningValueEvent); overload;
    constructor Create(AEvalErrorEvent: TBindingEvalErrorEvent; AAssigningValueEvent: TBindingAssigningValueEvent;
      AAssignedValueEvent: TBindingAssignedValueEvent); overload;
    constructor Create(AEvalErrorEvent: TBindingEvalErrorEvent; AAssigningValueEvent: TBindingAssigningValueEvent;
      AAssignedValueEvent: TBindingAssignedValueEvent; ALocationUpdatedEvent: TBindingLocationUpdatedEvent); overload;
  end;

  /// <summary>Binding Helper class with utility methods.</summary>
  TBindings = class
  public type
    TCreateOption = (coNotifyOutput, coEvaluate);
    TCreateOptions = set of TCreateOption;
  public
    /// <summary>Creates a bindingNotifier which is used to trigger corresponding expression objects to be re-evaluated</summary>
    /// <param name="AObject">Object used in expression that should be re-evaluated</param>
    /// <param name="Manager">The bindingManager that the expression belongs in.  AppManager is used when left nil</param>
    /// <returns>Returns IBindingNotifier which can be used to trigger found expression object</returns>
    class function CreateNotifier(const AObject: TObject; Manager: TBindingManager = nil): IBindingNotifier;

    /// <summary>Trigger corresponding expression objects to be re-evaluated given an Object and Property</summary>
    /// <param name="Sender">Object used in expression that should be re-evaluated</param>
    /// <param name="PropName">Property used in expression that should be re-evaluated</param>
    /// <param name="Manager">The bindingManager that the expression belongs in.  AppManager is used when left nil</param>
    class procedure Notify(Sender: TObject; PropName: string = ''; Manager: TBindingManager = nil);

    /// <summary>Returns a Scope capable of handling a Invokable function represented by an method alias in a string expression</summary>
    /// <param name="MethodName">Method name or alias that will be used in binding string expressions</param>
    /// <param name="InvokableMethod">Function that will be used in binding string expressions</param>
    /// <returns>Input Scope containing the invokable method which is used when method alias is being looked up by engine evaluator</returns>
    class function CreateMethodScope(const MethodName: string; InvokableMethod: IInvokable): IScope; overload;
    class function CreateMethodScope(AMethod: TArray<TPair<string, IInvokable>>): IScope; overload;
    class function CreateAssociationScope(Assocs: array of TBindingAssociation): IScope;

    /// <summary>Helper function to create a managed binding expression</summary>
    /// <remark>A managed binding expression will be automatically notified based on dependencies with respect to other existing bindings</remark>
    /// <param name="InputScopes">Array of input scopes used for lookups of the binding expression string</param>
    /// <param name="BindExprStr">String expression to be evaluated by the binding engine</param>
    /// <param name="OutputScopes">Array of output scopes used for lookups of the output assignment location</param>
    /// <param name="OutputExpr">String expression to be evaluated with the OutputScopes to determine assignment location</param>
    /// <param name="OutputConverter">Output converters to use with the binding expression.  All default converters will be used if nil</param>
    /// <param name="BindingEventRec">Record containing binding expression events</param>
    /// <param name="Manager">Manager to create the binding expression object in.  Root AppManager will be used if unprovided</param>
    /// <param name="Options">Options which affect behavior of binding expression</param>
    /// <returns>Returns the instantiated binding expression object</returns>
    class function CreateManagedBinding(
      const InputScopes: array of IScope;
      const BindExprStr: string;
      const OutputScopes: array of IScope;
      const OutputExpr: string;
      const OutputConverter: IValueRefConverter;
      BindingEventRec: TBindingEventRec;
      Manager: TBindingManager = nil;
      Options: TCreateOptions = [coNotifyOutput]): TBindingExpression; overload;
    class function CreateManagedBinding(
      const InputScopes: array of IScope;
      const BindExprStr: string;
      const OutputScopes: array of IScope;
      const OutputExpr: string;
      const OutputConverter: IValueRefConverter;
      Manager: TBindingManager = nil;
      Options: TCreateOptions = [coNotifyOutput]): TBindingExpression; overload;

    /// <summary>Helper function to create a unmanaged binding expression</summary>
    /// <remark>An umanaged binding expression will not be evaluated automatically and will not trigger other existing bindings.  It will assign the calculated expression value to the designated outputs when evaluated manually.</remark>
    /// <param name="InputScopes">Array of input scopes used for lookups of the binding expression string</param>
    /// <param name="BindExprStr">String expression to be evaluated by the binding engine</param>
    /// <param name="OutputScopes">Array of output scopes used for lookups of the output assignment location</param>
    /// <param name="OutputExpr">String expression to be evaluated with the OutputScopes to determine assignment location</param>
    /// <param name="OutputConverter">Output converters to use with the binding expression.  All default converters will be used if nil</param>
    /// <param name="BindingEventRec">Record containing binding expression events</param>
    /// <param name="Options">Options which affect behavior of binding expression</param>
    /// <returns>Returns the instantiated binding expression object</returns>
    class function CreateUnmanagedBinding(
      const InputScopes: array of IScope;
      const BindExprStr: string;
      const OutputScopes: array of IScope;
      const OutputExpr: string;
      const OutputConverter: IValueRefConverter;
      BindingEventRec: TBindingEventRec;
      Options: TCreateOptions = [coNotifyOutput]): TBindingExpression; overload;
    class function CreateUnmanagedBinding(
      const InputScopes: array of IScope;
      const BindExprStr: string;
      const OutputScopes: array of IScope;
      const OutputExpr: string;
      const OutputConverter: IValueRefConverter;
      Options: TCreateOptions = []): TBindingExpression; overload;

    /// <summary>Helper function to create an expression</summary>
    /// <remark>An expression is evaluated manually and the resulting value can be retrieved manually.</remark>
    /// <param name="InputScopes">Array of input scopes used for lookups of the binding expression string</param>
    /// <param name="BindExprStr">String expression to be evaluated by the binding engine</param>
    /// <param name="BindingEventRec">Record containing binding expression events</param>
    /// <returns>Returns the instantiated binding expression object</returns>
    class function CreateExpression(
      const InputScopes: array of IScope;
      const BindExprStr: string;
      BindingEventRec: TBindingEventRec): TBindingExpression; overload;
    class function CreateExpression(
      const InputScopes: array of IScope;
      const BindExprStr: string): TBindingExpression; overload;

    /// <summary>Removes the binding expression object supplied</summary>
    /// <param name="Expression">Expression object to remove and delete from the engine</param>
    /// <param name="Manager">Manager which the expression can be found.  It will be looked up if unprovided</param>
    class procedure RemoveBinding(const Expression: TBindingExpression; Manager: TBindingManager = nil); overload;
  end;


implementation

uses
  System.Bindings.ObjEval, System.Bindings.Consts;

{ TBindings }

class function TBindings.CreateExpression(const InputScopes: array of IScope;
  const BindExprStr: string): TBindingExpression;
begin
  Result := CreateExpression(InputScopes, BindExprStr, TBindingEventRec.Create);
end;

class function TBindings.CreateExpression(
  const InputScopes: array of IScope;
  const BindExprStr: string;
  BindingEventRec: TBindingEventRec): TBindingExpression;
begin
  Result := TBindingExpressionDefault.Create(nil);
  try
    Result.Source := BindExprStr;
    Result.OnEvalErrorEvent := BindingEventRec.EvalErrorEvent;
    Result.OnAssigningValueEvent := BindingEventRec.AssigningValueEvent;
    Result.OnAssignedValueEvent := BindingEventRec.AssignedValueEvent;
    Result.OnLocationUpdatedEvent := BindingEventRec.LocationUpdatedEvent;
    Result.Compile(InputScopes);
  except on E: Exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

class function TBindings.CreateManagedBinding(
  const InputScopes: array of IScope; const BindExprStr: string;
  const OutputScopes: array of IScope; const OutputExpr: string;
  const OutputConverter: IValueRefConverter; Manager: TBindingManager;
  Options: TCreateOptions): TBindingExpression;
begin
  Result :=
    CreateManagedBinding(InputScopes, BindExprStr, OutputScopes,
      OutputExpr, OutputConverter, TBindingEventRec.Create, Manager, Options);
end;

class function TBindings.CreateManagedBinding(
  const InputScopes: array of IScope;
  const BindExprStr: string;
  const OutputScopes: array of IScope;
  const OutputExpr: string;
  const OutputConverter: IValueRefConverter;
  BindingEventRec: TBindingEventRec;
  Manager: TBindingManager;
  Options: TCreateOptions): TBindingExpression;
var
  LOutputScope: IScope;
  LScope: IScope;
begin
  if Manager = nil then
    Manager := TBindingManagerFactory.AppManager;

  Result := Manager.AddExpr(BindExprStr);
  try
    Result.Outputs.Notify := coNotifyOutput in Options;
    Result.OnEvalErrorEvent := BindingEventRec.EvalErrorEvent;
    Result.OnAssigningValueEvent := BindingEventRec.AssigningValueEvent;
    Result.OnAssignedValueEvent := BindingEventRec.AssignedValueEvent;
    Result.OnLocationUpdatedEvent := BindingEventRec.LocationUpdatedEvent;
    Result.Compile(InputScopes);

    // Create nested scopes as needed
      LOutputScope := nil;
      for LScope in OutputScopes do
        if LOutputScope = nil then
          LOutputScope := LScope
        else
          LOutputScope := TNestedScope.Create(LOutputScope,
           LScope);
    if LOutputScope = nil then
      raise EBindHelperException.Create(sNoOutputScopes);
    Result.Outputs.Add(LOutputScope, OutputExpr);
    Result.Outputs.ValueConverter := OutputConverter;

    if coEvaluate in Options then
      Result.Evaluate;
  except on E: Exception do
    begin
      RemoveBinding(Result, Manager);
      raise;
    end;
  end;
end;

class function TBindings.CreateUnmanagedBinding(
  const InputScopes: array of IScope; const BindExprStr: string;
  const OutputScopes: array of IScope; const OutputExpr: string;
  const OutputConverter: IValueRefConverter;
  Options: TCreateOptions): TBindingExpression;
begin
  Result :=
    CreateUnmanagedBinding(InputScopes, BindExprStr, OutputScopes, OutputExpr,
      OutputConverter, TBindingEventRec.Create, Options);
end;

class function TBindings.CreateUnmanagedBinding(
  const InputScopes: array of IScope;
  const BindExprStr: string;
  const OutputScopes: array of IScope;
  const OutputExpr: string;
  const OutputConverter: IValueRefConverter;
  BindingEventRec: TBindingEventRec;
  Options: TCreateOptions): TBindingExpression;
var
  LOutputScope: IScope;
  LScope: IScope;
begin
  Result := TBindingExpressionDefault.Create(nil);
  try
    Result.Outputs.Notify := coNotifyOutput in Options;
    Result.Source := BindExprStr;
    Result.OnEvalErrorEvent := BindingEventRec.EvalErrorEvent;
    Result.OnAssigningValueEvent := BindingEventRec.AssigningValueEvent;
    Result.OnAssignedValueEvent := BindingEventRec.AssignedValueEvent;
    Result.OnLocationUpdatedEvent := BindingEventRec.LocationUpdatedEvent;
    Result.Compile(InputScopes);

    // Create nested scopes as needed
      LOutputScope := nil;
      for LScope in OutputScopes do
        if LOutputScope = nil then
          LOutputScope := LScope
        else
          LOutputScope := TNestedScope.Create(LOutputScope,
           LScope);
    if LOutputScope = nil then
      raise EBindHelperException.Create(sNoOutputScopes);
    Result.Outputs.Add(LOutputScope, OutputExpr);
    Result.Outputs.ValueConverter := OutputConverter;

    if coEvaluate in Options then
      Result.Evaluate;
  except on E: Exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

class procedure TBindings.RemoveBinding(const Expression: TBindingExpression; Manager: TBindingManager);
var
  DefBindExpr: TBindingExpressionDefault;
begin
  if Assigned(Manager) then
    Manager.Remove(Expression)
  else
  if Expression is TBindingExpressionDefault then
  begin
    DefBindExpr := TBindingExpressionDefault(Expression);

    if Assigned(DefBindExpr.Manager) then
      DefBindExpr.Manager.Remove(Expression)
    else
      DefBindExpr.Free;
  end;
end;

class function TBindings.CreateMethodScope(const MethodName: string;
  InvokableMethod: IInvokable): IScope;
begin
  Result := TPairScope.Create(MethodName, InvokableMethod);
end;

class function TBindings.CreateAssociationScope(
  Assocs: array of TBindingAssociation): IScope;
var
  LScope: TDictionaryScope;
  I: Integer;
begin
  // add the mappings to a local and specific scope for the expression
  LScope := TDictionaryScope.Create;
  Result := LScope;

  for I := 0 to Length(Assocs) - 1 do
  begin
                                                                                               
    //  and possibly remove them on TObjectWrapper.Destroy? (with ref count)
    LScope.Map.Add(Assocs[I].ScriptObject, WrapObject(Assocs[I].RealObject));
  end;
end;

class function TBindings.CreateMethodScope(AMethod: TArray<TPair<string, IInvokable>>): IScope;
var
  LDictionaryScope: TDictionaryScope;
  LPair: TPair<string, IInvokable>;
begin
  LDictionaryScope := TDictionaryScope.Create;
  Result := LDictionaryScope;  // Will free if exception
  for LPair in AMethod do
    LDictionaryScope.Map.Add(LPair.Key, LPair.Value);
end;

class function TBindings.CreateNotifier(const AObject: TObject;
  Manager: TBindingManager): IBindingNotifier;
begin
  if Manager = nil then
    Manager := TBindingManagerFactory.AppManager;
                                        
  //Result := TBindingNotifierFactory.CreateNotifier(AObject, Manager);
  Result := TBindingNotifier.Create(AObject, Manager);
end;

class procedure TBindings.Notify(Sender: TObject; PropName: string; Manager: TBindingManager);
var
  Notifier: IBindingNotifier;
begin
  Notifier := CreateNotifier(Sender, Manager);
  Notifier.Notify(PropName);
end;

{ TBindingEventRec }

constructor TBindingEventRec.Create(AEvalErrorEvent: TBindingEvalErrorEvent);
begin
  EvalErrorEvent := AEvalErrorEvent;
  AssignedValueEvent := nil;
  AssigningValueEvent := nil;
  LocationUpdatedEvent := nil;
end;

constructor TBindingEventRec.Create(
  AAssigningValueEvent: TBindingAssigningValueEvent);
begin
  EvalErrorEvent := nil;
  AssigningValueEvent := AAssigningValueEvent;
  AssignedValueEvent := nil;
  LocationUpdatedEvent := nil;
end;

constructor TBindingEventRec.Create(AEvalErrorEvent: TBindingEvalErrorEvent;
  AAssigningValueEvent: TBindingAssigningValueEvent);
begin
  EvalErrorEvent := AEvalErrorEvent;
  AssigningValueEvent := AAssigningValueEvent;
  AssignedValueEvent := nil;
  LocationUpdatedEvent := nil;
end;

constructor TBindingEventRec.Create(AEvalErrorEvent: TBindingEvalErrorEvent;
  AAssigningValueEvent: TBindingAssigningValueEvent;
  AAssignedValueEvent: TBindingAssignedValueEvent);
begin
  EvalErrorEvent := AEvalErrorEvent;
  AssigningValueEvent := AAssigningValueEvent;
  AssignedValueEvent := AAssignedValueEvent;
  LocationUpdatedEvent := nil;
end;

constructor TBindingEventRec.Create(AEvalErrorEvent: TBindingEvalErrorEvent;
  AAssigningValueEvent: TBindingAssigningValueEvent;
  AAssignedValueEvent: TBindingAssignedValueEvent;
  ALocationUpdatedEvent: TBindingLocationUpdatedEvent);
begin
  EvalErrorEvent := AEvalErrorEvent;
  AssigningValueEvent := AAssigningValueEvent;
  AssignedValueEvent := AAssignedValueEvent;
  LocationUpdatedEvent := ALocationUpdatedEvent;
end;

class function TBindingEventRec.Create: TBindingEventRec;
begin
  Result.EvalErrorEvent := nil;
  Result.AssigningValueEvent := nil;
  Result.AssignedValueEvent := nil;
  Result.LocationUpdatedEvent := nil;
end;

end.

