{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.Manager;

interface

uses
  System.SysUtils, System.Generics.Collections,

  System.Bindings.Expression;

type
  /// <summary>
  /// Manages all the binding expressions and notifies them of changes in the
  /// objects that are contained by the expressions. Managers can notify
  /// sub-managers (or owned managers) about changes in objects.</summary>
  /// <remarks>
  /// For example, the application-wide manager will notify all its owned managers
  /// that a property changed in some object. In this way, all the sub-managers can
  /// re-evaluate their expressions.
  /// </remarks>
                                                               
  TBindingManager = class(TObject)
  protected
    type
      /// <summary>The type of the internal list that stores the sub-managers.</summary>
      TManagerList = TList<TBindingManager>;
      /// <summary>The type of the internal list that stores the binding expressions.</summary>
      TExprList = TObjectList<TBindingExpression>;
  private
    FManagers: TManagerList;
    FExpressions: TExprList;
    FOwner: TBindingManager;

    function GetExprCount: Integer; inline;
    function GetExpressions(Index: Integer): TBindingExpression; inline;
    function GetManagerCount: Integer; inline;
    function GetManagers(Index: Integer): TBindingManager; inline;
  protected
    /// <summary>Stores the sub-managers of this manager. It can be used
    /// by descendant classes to have extensive control over the sub-managers.</summary>
    property ManagerList: TManagerList read FManagers;
    /// <summary>Stores the binding expressions that this manager owns. It is
    /// useful to descendant classes that need more control over the way the
    /// binding expressions are managed internally.</summary>
    property ExprList: TExprList read FExpressions;
  public
    /// <summary>Creates an instance of a binding manager.</summary>
    /// <param name="Owner">The binding manager that will own the new instance.</param>
    /// <remarks>If Owner is nil, it uses the application-wide binding manager
    /// as the owner of the new instance. The new instance adds itself automatically
    /// to the internal list of the list of sub-managers of the specified Owner
    /// manager.</remarks>
    constructor Create(Owner: TBindingManager = nil);
    /// <summary>Destroys a binding manager instance.</summary>
    destructor Destroy; override;

    /// <summary>Creates a new binding expression object based on the given
    /// expression string and adds this binding expression object to the
    /// list of binding expressions.</summary>
    /// <param name="Expr">The actual expression string based on which
    /// the binding expression object is created.</param>
    /// <returns>The index of the binding expression object within the list of
    /// binding expression.</returns>
    function Add(const Expr: String): Integer;
    /// <summary>Adds a new binding expression object based on the given expression
    /// string to the list of binding expressions.</summary>
    /// <param name="Expr">The actual expression string based on which the
    /// binding expression object is created.</param>
    /// <returns>The binding expression object created from the given expression string.</returns>
    function AddExpr(const Expr: String): TBindingExpression; inline;
    /// <summary>Deletes and destroys a binding expression object from the list
    /// of binding expressions.</summary>
    /// <param name="Index">The index of the binding expression object within
    /// the list of binding expressions.</param>
    procedure Delete(Index: Integer); inline;
    /// <summary>Deletes and destroys a given binding expression object located
    /// within the list of binding expressions.</summary>
    /// <param name="Expr">The binding expression object that must be deleted
    /// and destroyed.</param>
    /// <returns>The index of the binding expression object that has been deleted
    /// and destroyed.</returns>
    /// <remarks>It returns -1 if the given expression object was not found among
    /// the binding expressions within the list of binding expressions.</remarks>
    function Remove(Expr: TBindingExpression): Integer; inline;
    /// <summary>Obtains the index of a binding expression object within the list
    /// of binding expressions.</summary>
    /// <param name="Expr">The binding expression object to be searched.</param>
    /// <returns>The index of the given binding expression object.</returns>
    /// <remarks>It returns -1 if the given binding expression object was not
    /// found in the internal list of binding expressions.</remarks>
    function IndexOf(Expr: TBindingExpression): Integer; inline;
    /// <summary>Deletes and destroys all the contained binding expressions.</summary>
    procedure Clear;
    function Extract(Expr: TBindingExpression): TBindingExpression; inline;

    /// <summary>The manager that owns this binding manager.</summary>
    /// <remarks>Only the application-wide binding manager cannot be owned. This
    /// property is nil for the application-wide binding manager.</remarks>
    property Owner: TBindingManager read FOwner;
    /// <summary>The sub-managers owned by this manager.</summary>
    /// <remarks>They can only be added or removed only when a submanager
    /// is created/destroyed.</remarks>
    property Managers[Index: Integer]: TBindingManager read GetManagers;
    /// <summary>The number of owned sub-managers.</summary>
    property ManagerCount: Integer read GetManagerCount;
    /// <summary>Access to the owned binding expression objects..</summary>
    property Expressions[Index: Integer]: TBindingExpression read GetExpressions;
    /// <summary>The number of owned binding expression objects.</summary>
    property ExprCount: Integer read GetExprCount;
  end;

implementation

uses
  System.Bindings.Factories;

{ TBindingManager }

function TBindingManager.Add(const Expr: String): Integer;
var
  LExpr: TBindingExpression;
begin
  LExpr := TBindingExpressionFactory.CreateExpression(Self);
  LExpr.Source := Expr;

  Result := FExpressions.Add(LExpr);
end;

function TBindingManager.AddExpr(const Expr: String): TBindingExpression;
begin
  Result := Expressions[Add(Expr)];
end;

procedure TBindingManager.Clear;
begin
  FExpressions.Clear;
end;

constructor TBindingManager.Create(Owner: TBindingManager);
begin
  inherited Create;

  // determine the owning manager and add it to the owners list;
  // the app wide manager doesn't have any owner, so the first time it is
  // created, it cannot be added in it's (inexistent) owner's list
  if not Assigned(Owner) and Assigned(TBindingManagerFactory.AppManager) then
    Owner := TBindingManagerFactory.AppManager;
  // if this is the AppManager being created, we don't have to add anything
  if Assigned(Owner) then
  begin
    Owner.ManagerList.Add(Self);
    Self.FOwner := Owner;
  end;

  FManagers := TManagerList.Create;
  FExpressions := TExprList.Create;
end;

procedure TBindingManager.Delete(Index: Integer);
begin
  FExpressions.Delete(Index);
end;

destructor TBindingManager.Destroy;
{$IFNDEF NEXTGEN}
var
  Mgr: TBindingManager;
{$ENDIF}
begin
  // delete the manager from its owner's list if it's not the app wide manager
  if Assigned(Owner) then
    Owner.ManagerList.Remove(Self);

  {$IFNDEF NEXTGEN}
  for Mgr in ManagerList do
    Mgr.Free;
  {$ENDIF}
  FManagers.Free;
  FExpressions.Free;

  inherited;
end;

function TBindingManager.GetExprCount: Integer;
begin
  Result := FExpressions.Count;
end;

function TBindingManager.GetExpressions(Index: Integer): TBindingExpression;
begin
  Result := FExpressions[Index];
end;

function TBindingManager.GetManagerCount: Integer;
begin
  Result := FManagers.Count;
end;

function TBindingManager.GetManagers(Index: Integer): TBindingManager;
begin
  Result := FManagers[Index];
end;

function TBindingManager.IndexOf(Expr: TBindingExpression): Integer;
begin
  Result := FExpressions.IndexOf(Expr);
end;

function TBindingManager.Remove(Expr: TBindingExpression): Integer;
begin
  Result := FExpressions.Remove(Expr);
end;

function TBindingManager.Extract(Expr: TBindingExpression): TBindingExpression;
begin
  Result := FExpressions.Extract(Expr);
end;

end.
