{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "SyncController"'}    {Do not Localize}
unit SyncController;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Graphics, System.Types, System.Generics.Collections, 
  System.Rtti, System.TypInfo,
  System.Bindings.Expression, System.Bindings.Graph, System.Bindings.Search, GraphView, BindingGraphViewNodes,
  System.Bindings.EvalProtocol, System.Bindings.Outputs;

type
  TSyncController = class(TObject)
  private
    FValueToStringCallback: TFunc<TValue, String>;
    FStringToValueCallback: TFunc<String, TTypeKind, TValue>;
    FWaiting: Boolean;
    FGetObjectByNameProc: TFunc<string, TObject>;
    FGetObjectNameProc: TFunc<TObject, string>;
    FGetGraphViewProc: TFunc<TGraphView>;
    FWaitBetweenMarked: Boolean;
    function GetObjectName(AObject: TObject): string;
    function GetObjectByName(AName: string): TObject;
    function GetGraph: TGraph;
    function GetGraphView: TGraphView;
  protected
    // the wait loop permits the user to call NextStep whenever wanted to
    // let the data-binding system perform the next mark/notification
    procedure WaitLoop;
  public
    constructor Create;

    // proxy calls to the graph view begin/end update routines
    procedure BeginUpdate; inline;
    procedure EndUpdate; inline;

    // returns True if the Node maps the specified object and property
    function MatchGraphNode(Node: TGraphNode; Obj: TObject; const PropertyName: String): Boolean; overload;
    // returns True if the Node maps the specified binding expression
    function MatchGraphNode(Node: TGraphNode; Expr: TBindingExpression): Boolean; overload;
    // returns a random left and top location for the given graph node;
    // the position is clipped to the visible area of the graph control
    procedure SetRandGraphNodePos(Node: TGraphNode);

    // puts a graph node in the graph for the given data and returns the node;
    // if a node for that data already exists, it just returns the node
    function PutGraphNode(Obj: TObject; const PropertyName: String): TGraphNode; overload;
    function PutGraphNode(Expr: TBindingExpression): TGraphNode; overload;
    // creates a connection (edge) from the node FromNode to the node ToNode
    // and returns that edge; if the edge already exists, it just returns it
    function ConnectGraphNodes(FromNode, ToNode: TGraphNode): TGraphEdge;
    // puts on the graph the expression Expr along with all the objects and properties
    // used by the expression; if a node mapping Expr doesn't exist, it is created
    // and all the nodes for the used objects too and then returned;
    function PutExpr(Expr: TBindingExpression): TGraphNode;

    // when you want to let data-binding make the next notification/change within the
    // contents of the properties bound in the current sub-graph of notifications
    procedure NextStep;

    // event-handler called when an object property is iteration marked in the binding graph
    procedure ObjectPropertyMarked(Obj: TObject; const PropertyName: String);
    // event-handler called when a binding expression is iteration marked in the binding graph
    procedure ExpressionMarked(Expr: TBindingExpression);

    // callback anonymous used to transform a TValue into its string representation
    property ValueToStringCallback: TFunc<TValue, String> read FValueToStringCallback;
    // its the reverse of the ValueToStringCallback; it converts the first string parameter containing
    // the input value into a value of type TTypeKind and returns the converted value in the result
    // of the function as a TValue
    property StringToValueCallback: TFunc<String, TTypeKind, TValue> read FStringToValueCallback;
    // if in the wait loop, this property is True
    property Waiting: Boolean read FWaiting;

    property GetObjectNameProc: TFunc<TObject, string> read FGetObjectNameProc write FGetObjectNameProc;
    property GetObjectByNameProc: TFunc<string, TObject> read FGetObjectByNameProc write FGetObjectByNameProc;
    property GetGraphViewProc: TFunc<TGraphView> read FGetGraphViewProc write FGetGraphViewProc;
    property WaitBetweenMarked: Boolean read FWaitBetweenMarked write FWaitBetweenMarked;
  end;

function Controller: TSyncController;

implementation

//uses
//  TestGraphView;

var
  _SyncController: TSyncController;

function Controller: TSyncController;
begin
  if not Assigned(_SyncController) then
    _SyncController := TSyncController.Create;

  Result := _SyncController;
end;

{ TSyncController }

procedure TSyncController.BeginUpdate;
begin
  GetGraph.BeginUpdate;
end;

function TSyncController.ConnectGraphNodes(FromNode,
  ToNode: TGraphNode): TGraphEdge;
begin
  Result := nil;
  if Assigned(FromNode) and Assigned(ToNode) then
    Result := GetGraph.AddEdge(FromNode.Index, ToNode.Index)
end;

function TSyncController.GetObjectName(AObject: TObject): string;
begin
  Assert(Assigned(FGetObjectNameProc));
  Result := FGetObjectNameProc(AObject)
end;

function TSyncController.GetObjectByName(AName: string): TObject;
begin
  Assert(Assigned(FGetObjectByNameProc));
  Result := FGetObjectByNameProc(AName)
end;

constructor TSyncController.Create;
begin
  inherited;

  FValueToStringCallback :=
    function (Value: TValue): String
    begin
      Result := '';
      case Value.Kind of
        tkInteger: Result := IntToStr(Value.AsInteger);
        tkInt64: Result := IntToStr(Value.AsInt64);
        tkFloat: Result := FloatToStrF(Value.AsExtended, ffGeneral, 7, 2);
        tkString: Result := Value.AsString;
        tkPointer: Result := Format('%p', [Value.AsType<Pointer>]);
        tkClass:
          if Value.AsObject <> nil then
            Result := GetObjectName(Value.AsObject)
          else
            Result := 'nil';
      end;
    end;

  FStringToValueCallback :=
    function (Value: String; TypeKind: TTypeKind): TValue
    begin
      Result := Default(TValue);
      case TypeKind of
        tkInteger: Result := StrToInt(Value);
        tkInt64: Result := StrToInt64(Value);
        tkFloat: Result := StrToFloat(Value);
        tkString: Result := Value;
        tkPointer: Result := Pointer(StrToInt(Value));
        tkClass: Result := GetObjectByName(Value);
      end;
    end;
end;

procedure TSyncController.EndUpdate;
begin
  GetGraph.EndUpdate;
end;

procedure TSyncController.ExpressionMarked(Expr: TBindingExpression);
var
  Node: TGraphNode;
begin
  Node := PutGraphNode(Expr);
  if Node <> nil then
    if Node.Color <> clRed then
    begin
      Node.Color := clRed;

      WaitLoop;
    end;
end;

function TSyncController.MatchGraphNode(Node: TGraphNode; Obj: TObject;
  const PropertyName: String): Boolean;
begin
  Result := Assigned(Node) and
           (Node is TGraphNodeProp) and
           (TGraphNodeProp(Node).Obj = Obj) and
           (TGraphNodeProp(Node).PropertyName = PropertyName);
end;

function TSyncController.MatchGraphNode(Node: TGraphNode;
  Expr: TBindingExpression): Boolean;
begin
  Result := Assigned(Node) and
           (Node is TGraphNodeExpr) and
           (TGraphNodeExpr(Node).Expression = Expr);
end;

procedure TSyncController.NextStep;
begin
  FWaiting := False;
end;

procedure TSyncController.WaitLoop;
begin
  if WaitBetweenMarked then
  begin
  FWaiting := True;
    repeat
      Application.HandleMessage;
    until not Waiting or Application.Terminated;
  end;
end;

procedure TSyncController.ObjectPropertyMarked(Obj: TObject;
  const PropertyName: String);
var
  Node: TGraphNode;
begin
  // if the object is not present on the graph, put it now
  Node := PutGraphNode(Obj, PropertyName);
  if Node <> nil then
    if Node.Color <> clMaroon then // the node hasn't been already marked
    begin
      Node.Color := clMaroon;

      // enter wait state to let the user jump to the next marking whenever wanted
      WaitLoop;
    end;
end;

function TSyncController.GetGraph: TGraph;
begin
  if GetGraphView <> nil then
    Result := GetGraphView.Graph
  else
    Result := nil;
end;

function TSyncController.PutGraphNode(Obj: TObject;
  const PropertyName: String): TGraphNode;
var
  Graph: TGraph;
  Node: TGraphNodeProp;
begin
  Result := nil;
  Graph := GetGraph;
  if Graph = nil then
    Exit;

  if not Graph.FindNode(Result,
    function (Node: TGraphNode): Boolean
    begin
      Result := MatchGraphNode(Node, Obj, PropertyName);
    end) then
  try
    BeginUpdate;

    Graph.NodeClass := TGraphNodeProp;
    Node := Graph.AddNode as TGraphNodeProp;
    Node.Obj := Obj;
    Node.PropertyName := PropertyName;
    Node.Caption := GetObjectName(Obj) + '.' + PropertyName;
    Node.FitText := True;
    Node.ValueToStringCallback := FValueToStringCallback;
    Node.ValueAsContent := True;
    SetRandGraphNodePos(Node);

    Result := Node;
  finally
    EndUpdate;
  end;
end;

function TSyncController.PutGraphNode(Expr: TBindingExpression): TGraphNode;
var
  Graph: TGraph;
  Node: TGraphNodeExpr;
begin
  Result := nil;
  Graph := GetGraph;
  if Graph = nil then
    Exit;

  if not Graph.FindNode(Result,
    function (Node: TGraphNode): Boolean
    begin
      Result := MatchGraphNode(Node, Expr);
    end) then
  try
    BeginUpdate;

    Graph.NodeClass := TGraphNodeExpr;
    Node := Graph.AddNode as TGraphNodeExpr;
    Node.Expression := Expr;
    Node.Caption := Expr.Source;
    Node.FitText := True;
    Node.ValueToStringCallback := FValueToStringCallback;
    Node.ValueAsContent := True;
    SetRandGraphNodePos(Node);

    Result := Node;
  finally
    EndUpdate;
  end;
end;

function TSyncController.PutExpr(Expr: TBindingExpression): TGraphNode;
var
  ExprScope: IScope;
  Wrappers: TWrapperDictionary;
  Wrapper: IInterface;
  Child: IChild;
  OutputPair: TBindingOutput.TOutputPair;
  Node: TGraphNode;
begin
  Result := nil;
  if GetGraph = nil then
    Exit;
  Wrappers := nil;
  if Supports(Expr, IScope, ExprScope) then
    try
      BeginUpdate;
      Result := PutGraphNode(Expr);

      // put nodes for objects and properties used as input in the expression
      Wrappers := TBindingSearch.DepthGetWrappers(ExprScope);
      for Wrapper in Wrappers.Keys do
        if Supports(Wrapper, IChild, Child) then
        begin
          Node := PutGraphNode(Child.Parent, Child.MemberName);
          ConnectGraphNodes(Node, Result);
        end;

      // put nodes for objects and properties used as outputs by the expression
      for OutputPair in Expr.Outputs.Destinations.Values do
      begin
        Node := PutGraphNode(OutputPair.Key, OutputPair.Value);
        ConnectGraphNodes(Result, Node);
      end;
    finally
      Wrappers.Free;
      EndUpdate;
    end;
end;

function TSyncController.GetGraphView: TGraphView;
begin
  if Assigned(FGetGraphViewProc) then
    Result := FGetGraphViewProc
  else
    Result := nil;

end;

procedure TSyncController.SetRandGraphNodePos(Node: TGraphNode);
var
  GraphView: TGraphView;
begin
  if Assigned(Node) then
  begin
    GraphView := GetGraphView;
    BeginUpdate;

    Node.Left := Random(GraphView.Width - Node.Width);
    Node.Top := Random(GraphView.Height - Node.Height);

    EndUpdate;
  end;
end;

initialization

  Randomize;

  // initialization of binding graph events
  // This could be multicast event like TEvent.
  TBindingGraph.OnObjPropMarked := Controller.ObjectPropertyMarked;
  TBindingGraph.OnExprMarked := Controller.ExpressionMarked;

finalization

  Controller.Free;

end.
