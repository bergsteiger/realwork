{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.Expression;

interface

uses
  System.SysUtils, System.Classes, System.Rtti, System.Generics.Collections,

  System.Bindings.EvalProtocol, System.Bindings.EvalSys, System.Bindings.Outputs;

type
  /// <summary>Thrown when errors occur in the behaviour of a binding expression.</summary>
  EBindingExpressionError = class(Exception);

  /// <summary>
  /// Stores an association between a Delphi object and a expression object. </summary>
  TBindingAssociation = record
  public
    /// <summary>The Delphi object in the association.</summary>
    RealObject: TObject;
    /// <summary>The expression object in the association </summary>
    ScriptObject: String;
    /// <summary>Constructs the association using the given Delphi and expression objects.</summary>
    /// <param name="ARealObject">The Delphi object of the association.</param>
    /// <param name="AScriptObject">The expression object of the association.</param>
    constructor Create(ARealObject: TObject; const AScriptObject: String);
  end;

  /// <summary>
  /// Stores an association between an Interface and an expression object.</summary>
  TBidiAssociation = record
  public
    /// <summary>The interface reference that is part of the association.</summary>
    BidiInterface: IInterface;
    /// <summary>The expression object that is part of the association.</summary>
    BidiName: string;
    /// <summary>Constructs the association using the given interface reference and
    /// the given expression object.</summary>
    /// <param name="ABidiInterface">The interface reference of the association.</param>
    /// <param name="ABidiName">The expression object of the association.</param>
    constructor Create(ABidiInterface: IInterface; const ABidiName: string);
  end;

  /// <summary>
  /// Every expression parsed and evaluated must descend from this class.</summary>
  TBindingExpression = class abstract(TObject)
  public
    type
      TAssociationPair = TPair<TObject, String>;
      TAssociations = TDictionary<TObject, String>;
  private
    FSource: String;
    FAssociations: TAssociations;
    FBindingOutput: TBindingOutput;
    FOutputValue: TValue;
    FEvalErrorEvent: TBindingEvalErrorEvent;
  protected
    /// <summary>Scopes that are chained up and used by the compiler to search
    /// for global symbols used in the expression. These scopes are set by
    /// the Compile methods that use scopes among their input parameters.</summary>
    FScopes: Array of IScope;
    function GetCompiled: Boolean; virtual; abstract;
    function GetSource: String; virtual;
    procedure SetSource(const Value: String); virtual;
    function GetOutputValue: TValue; virtual;
    procedure SetOutputValue(const Value: TValue); virtual;
    procedure SetOutputs(const ValueFunc: TBindOutValueFunc); virtual;

    /// <summary>Realizes the actual compilation of the expression based on the
    /// script and real objects Associations</summary>
    procedure Compile; overload; virtual; abstract;
    function GetIsManaged: Boolean; virtual; abstract;

    function GetAssigningValueEvent: TBindingAssigningValueEvent;
    procedure SetAssigningValueEvent(AssigningValueEvent: TBindingAssigningValueEvent);
    function GetAssignedValueEvent: TBindingAssignedValueEvent;
    function GetLocationUpdatedEvent: TBindingLocationUpdatedEvent;
    procedure SetAssignedValueEvent(AssignedValueEvent: TBindingAssignedValueEvent);
    procedure SetEvalErrorEvent(EvalErrorEvent: TBindingEvalErrorEvent);
    procedure SetLocationUpdatedEvent(ALocationUpdatedEvent: TBindingLocationUpdatedEvent);
  public
    /// <summary>Creates an instance of a binding expression.</summary>
    constructor Create;
    /// <summary>Destroyes an instance of a binding expression.</summary>
    destructor Destroy; override;

    /// <summary>Compiles an expression and makes the relationship between
    /// the Delphi components and the expression objects based on the component names.
    /// There cannot be two components with the same name, nor with empty names.</summary>
    /// <param name="Objects">These components and their properties are used in the expression.
    /// The names of the components must match those of the expression objects.</param>
    procedure Compile(const Objects: array of TComponent); overload;
    /// <summary>Compiles the expression based on the associations between
    /// Delphi objects and expression objects.</summary>
    /// <param name="Assocs">An array of associations between Delphi objects and
    /// the corresponding expression objects used in the source of the expression.</param>
    procedure Compile(const Assocs: array of TBindingAssociation); overload;
    /// <summary>Compiles the expression based on the provided IScope.</summary>
    /// <param name="AScope">The scope used by the compiler and the evaluator
    /// to resolve the object names and to determine their values.</param>
    procedure Compile(const AScope: IScope); overload;
    /// <summary>Compiles the expression based on the provided array of scopes.</summary>
    /// <param name="AScopes">The array of scopes used by the compiler and the
    /// evaluator to resolve object names and to determine their actual values.</param>
    procedure Compile(const AScopes: array of IScope); overload;
    /// <summary>Compiles the expression using all the parameters to determine
    /// the relationships between Delphi objects and the expression objects. This
    /// version of the method gives the user the possibility to specifiy associations
    /// between Delphi objects and expression objects by all means possible.
    /// The compiler will use information in all the parameters.</summary>
    /// <param name="Objects">These components and their properties are used in the expression.
    /// The names of the components must match those of the expression objects.</param>
    /// <param name="Assocs">An array of associations between Delphi objects and
    /// the corresponding expression objects used in the source of the expression.</param>
    /// <param name="Scopes">The array of scopes used by the compiler and the
    /// evaluator to resolve object names and to determine their actual values.</param>
    procedure Compile(const Objects: array of TComponent; const Assocs: array of TBindingAssociation; const Scopes: array of IScope); overload;
    /// <summary>Recompiles the expression using the last binding associations
    /// between the Delphi objects and the expression objects.</summary>
    procedure Recompile; inline;
    /// <summary>Evaluates the expression and returns value</summary>
    /// <returns>A value wrapper that wraps the actual calculated value. The value
    /// wrapper may also be a location, which means that the wrapper supports
    /// to change the resulting value within the wrapper.</returns>
    function Evaluate: IValue; virtual; abstract;
    /// <summary>Assigns the expression value to outputs</summary>
    /// <returns>A value wrapper that wraps the actual calculated value. The value
    /// wrapper may also be a location, which means that the wrapper supports
    /// to change the resulting value within the wrapper.</returns>
    procedure EvaluateOutputs; virtual; abstract;
    /// <summary>Clears the current compilation data.</summary>
    procedure Clear; virtual;

    /// <summary>The source code of the expression.</summary>
    property Source: String read GetSource write SetSource;
    /// <summary>Indicates whether the expression has been compiled. An expression
    /// cannot be evaluated if it hasn't been compiled. </summary>
    property Compiled: Boolean read GetCompiled;

    /// <summary>Container for the outputs that receive the value resulting from
    /// the expression evaluation.</summary>
    property Outputs: TBindingOutput read FBindingOutput;

    /// <summary>Sets and gets the computed output value</summary>
    property OutputValue: TValue read GetOutputValue write SetOutputValue;
    /// <summary>Denotes the current associations between the Delphi objects and
    /// the expression objects used by the expression to recompile or evaluate.
    /// Here you put the input objects/properties for the expression.</summary>
    property Associations: TAssociations read FAssociations;

    /// <summary>Indicates whether the expression is managed.  Managed expressions are associated with
    /// a TBindingManager and participate in the notification system.</summary>
    property IsManaged: Boolean read GetIsManaged;
    /// <summary>Issued when an output has a new value about to be assigned to it as a result of
    /// the evaluation of the expression</summary>
    property OnAssigningValueEvent: TBindingAssigningValueEvent read GetAssigningValueEvent write SetAssigningValueEvent;
    /// <summary>Event called whenever an evaluation error occurs.</summary>
    property OnEvalErrorEvent: TBindingEvalErrorEvent read FEvalErrorEvent write SetEvalErrorEvent;
    /// <summary>Issued when an output has a new value assigned to it as a result of
    /// the evaluation of the expression</summary>
    property OnAssignedValueEvent: TBindingAssignedValueEvent read GetAssignedValueEvent write SetAssignedValueEvent;
    /// <summary>Issued when an output location has been regenerated by the expression engine</summary>
    property OnLocationUpdatedEvent: TBindingLocationUpdatedEvent read GetLocationUpdatedEvent write SetLocationUpdatedEvent;
  end;

  /// <summary>
  /// Facilitates grouping and naming binding expressions. The group has a name
  /// itself. Each binding expression object stored in the group can be identified
  /// using its assigned name.</summary>
  TBindExprDict = class
  private
    FName: string;
    FPersistBindings: Boolean;
    FExpressions: TObjectDictionary<string,TBindingExpression>;
    function GetValues: TDictionary<string,TBindingExpression>.TValueCollection;
  public
    /// <summary>Adds a binding expression along with its name to the group.</summary>
    /// <param name="ExpressionStr">Specifies the name of the binding expression.</param>
    /// <param name="BindingExpression">Identifies the binding expression object.</param>
    procedure Add(const ExpressionStr: string; BindingExpression: TBindingExpression);
    /// <summary>Permits manipulation of the stored binding expression objects.</summary>
    property Expressions: TObjectDictionary<string,TBindingExpression> read FExpressions;
    /// <summary>Gives access to the collection containing only the binding expression objects,
    /// without their associated names.</summary>
    property Values: TDictionary<string,TBindingExpression>.TValueCollection read GetValues;
    /// <summary>The name of the group.</summary>
    property Name: string read FName;
    property PersistBindings: Boolean read FPersistBindings write FPersistBindings;

    /// <summary>Creates an instance of a group of binding expressions.</summary>
    /// <param name="GroupName">Specifies the name of the group.</param>
    constructor Create(const GroupName: string);
    /// <summary>Destroys the instance of a group of binding expressions.</summary>
    destructor Destroy; override;
  end;

/// <summary>Provides an easier way to create associations between Delphi objects
/// and the expression objects. This is essentially a record constructor, but
/// permits shorter syntax.</summary>
/// <param name="RealObject">Denotes the Delphi object implied in the association.</param>
/// <param name="ScriptObject">Denotes the expression object implied in the association.</param>
/// <returns>The association generated from the given objects.</returns>
function Associate(RealObject: TObject; const ScriptObject: String): TBindingAssociation;
/// <summary>Provides an easier way to create associations between interface references
/// and the expression objects. This is essentially a record constructor, but
/// permits shorter syntax.</summary>
/// <param name="BidiInterface">Denotes the interface reference implied in the association.</param>
/// <param name="BidiName">Denotes the expression object implied in the association.</param>
/// <returns>The association generated from the given interface reference and expression object.</returns>
function BidiAssociate(BidiInterface: IInterface; const BidiName: string): TBidiAssociation;

implementation

uses
  System.Bindings.Factories, System.Bindings.NotifierContracts;

function BidiAssociate(BidiInterface: IInterface; const BidiName: string): TBidiAssociation;
begin
  Result.BidiInterface := BidiInterface;
  Result.BidiName := BidiName;
end;

function Associate(RealObject: TObject; const ScriptObject: String): TBindingAssociation;
begin
  Result.RealObject := RealObject;
  Result.ScriptObject := ScriptObject;
end;

{ TBindingExpression }

procedure TBindingExpression.Compile(
  const Assocs: array of TBindingAssociation);
var
  i: Integer;
begin
  Clear;
  for i := Low(Assocs) to High(Assocs) do
    Associations.Add(Assocs[i].RealObject, Assocs[i].ScriptObject);

  Compile;
end;

procedure TBindingExpression.Compile(const Objects: array of TComponent);
var
  i: Integer;
begin
  Clear;
  for i := Low(Objects) to High(Objects) do
    Associations.Add(Objects[i], Objects[i].Name);

  Compile;
end;

procedure TBindingExpression.Clear;
begin
  Associations.Clear;
end;

constructor TBindingExpression.Create;
begin
  inherited;

  FOutputValue := TValue.Empty;
  if IsManaged then
    FBindingOutput := TBindingOutput.Create(Self, [opNotify])
  else
    FBindingOutput := TBindingOutput.Create(Self, []);

  FAssociations := TAssociations.Create;
  SetLength(FScopes, 0);
//  FDataChangeEvent := nil;
end;

destructor TBindingExpression.Destroy;
begin
  Clear;
  FBindingOutput.Free;
  FAssociations.Free;

  inherited;
end;

procedure TBindingExpression.SetEvalErrorEvent(
  EvalErrorEvent: TBindingEvalErrorEvent);
begin
  FEvalErrorEvent := EvalErrorEvent;
  Outputs.OnEvalErrorEvent := EvalErrorEvent;
end;

procedure TBindingExpression.SetLocationUpdatedEvent(
  ALocationUpdatedEvent: TBindingLocationUpdatedEvent);
begin
  Outputs.OnLocationUpdated := ALocationUpdatedEvent;
end;

procedure TBindingExpression.SetAssigningValueEvent(
  AssigningValueEvent: TBindingAssigningValueEvent);
begin
  Outputs.OnAssigningValue := AssigningValueEvent;
end;

procedure TBindingExpression.SetAssignedValueEvent(
  AssignedValueEvent: TBindingAssignedValueEvent);
begin
  Outputs.OnAssignedValue := AssignedValueEvent;
end;

function TBindingExpression.GetAssigningValueEvent: TBindingAssigningValueEvent;
begin
  Result := Outputs.OnAssigningValue;
end;

function TBindingExpression.GetLocationUpdatedEvent: TBindingLocationUpdatedEvent;
begin
  Result := Outputs.OnLocationUpdated;
end;

function TBindingExpression.GetAssignedValueEvent: TBindingAssignedValueEvent;
begin
  Result := Outputs.OnAssignedValue;
end;

procedure TBindingExpression.SetOutputs(const ValueFunc: TBindOutValueFunc);
begin
  assert(Assigned(ValueFunc));
  Outputs.SetValue(Self, ValueFunc);
end;

function TBindingExpression.GetOutputValue: TValue;
begin
  Result := FOutputValue;
end;

procedure TBindingExpression.SetOutputValue(const Value: TValue);
begin
  FOutputValue := Value;
end;

function TBindingExpression.GetSource: String;
begin
  Result := FSource;
end;

procedure TBindingExpression.Recompile;
begin
  Compile;
end;

procedure TBindingExpression.SetSource(const Value: String);
begin
  if FSource <> Value then
  begin
    FSource := Value;
    //Clear; //seems to kill the usefulness of Recompile() assuming Input/Output assocaitions haven't changed
  end;
end;

procedure TBindingExpression.Compile(const AScope: IScope);
begin
  SetLength(FScopes, 1);
  FScopes[0] := AScope;

  Compile;
end;

procedure TBindingExpression.Compile(const AScopes: array of IScope);
var
  I: Integer;
begin
  SetLength(FScopes, Length(AScopes));
  for I := Low(AScopes) to High(AScopes) do
    FScopes[I] := AScopes[I];

  Compile;
end;

procedure TBindingExpression.Compile(const Objects: array of TComponent;
  const Assocs: array of TBindingAssociation; const Scopes: array of IScope);
var
  I: Integer;
begin
  Clear;
  for i := Low(Assocs) to High(Assocs) do
    Associations.Add(Assocs[i].RealObject, Assocs[i].ScriptObject);
  for i := Low(Objects) to High(Objects) do
    Associations.Add(Objects[i], Objects[i].Name);
  SetLength(FScopes, Length(Scopes));
  for I := Low(Scopes) to High(Scopes) do
    FScopes[I] := Scopes[I];

  Compile;
end;

{ TBindExprDict }

procedure TBindExprDict.Add(const ExpressionStr: string;
  BindingExpression: TBindingExpression);
begin
  Expressions.Add(ExpressionStr, BindingExpression);
end;

constructor TBindExprDict.Create(const GroupName: string);
begin
  FExpressions := TObjectDictionary<string,TBindingExpression>.Create;
  FPersistBindings := False;
  FName := GroupName;
end;

destructor TBindExprDict.Destroy;
//var
//  BE: TBindingExpression;
begin
                                     
//  if not PersistBindings then
//    for BE in Expressions.Values do
//      TBindings.RemoveBinding(BE);
  FExpressions.Free;
end;


function TBindExprDict.GetValues: TDictionary<string,TBindingExpression>.TValueCollection;
begin
  Result := FExpressions.Values;
end;

{ TBindingAssociation }

constructor TBindingAssociation.Create(ARealObject: TObject;
  const AScriptObject: String);
begin
  RealObject := ARealObject;
  ScriptObject := AScriptObject;
end;

{ TBidiAssociation }

constructor TBidiAssociation.Create(ABidiInterface: IInterface;
  const ABidiName: string);
begin
  BidiInterface := ABidiInterface;
  BidiName := ABidiName;
end;

end.
