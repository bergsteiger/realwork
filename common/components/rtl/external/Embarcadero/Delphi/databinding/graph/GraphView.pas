{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit GraphView;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, System.Math, System.Types,
  System.Generics.Collections, BindingGraphResStrs;

type
  TGraph = class;
  TGraphNode = class;
  TGraphEdge = class;
  TGraphView = class;

  TGraphNodeClass = class of TGraphNode;
  TGraphEdgeClass = class of TGraphEdge;

  TGraphEntity = class(TPersistent)
  private
    FOwner: TGraph;
    FColor: TColor;
    FCaption: String;
    FRect: TRect;
    FTextColor: TColor;

    // sets Field to Value only if they are different; if so, it calls Update
    procedure SetRectField(var Field: Integer; Value: Integer);
  protected
    function GetCaption: String; virtual;
    function GetRect(const Index: TAlign): Integer; virtual;
    function GetWholeRect: TRect; virtual;
    procedure SetCaption(const Value: String); virtual;
    procedure SetColor(const Value: TColor); virtual;
    procedure SetRect(const Index: TAlign; Value: Integer); virtual;
    procedure SetTextColor(const Value: TColor); virtual;
    procedure SetWholeRect(const Value: TRect); virtual;

    // if the node is attached to a graph, it updates the graphs whenever
    // something changes within the entity; whenever you want to visually reflect
    // some change in the internal data of the entity, call this method
    procedure Update; virtual;
  public
    constructor Create(Owner: TGraph); virtual;

    // owner of the entity
    property Owner: TGraph read FOwner;
    property Color: TColor read FColor write SetColor;
    property TextColor: TColor read FTextColor write SetTextColor;
    property Caption: String read GetCaption write SetCaption;

    // position and dimensions of the entity within the graph
    property Rect: TRect read GetWholeRect write SetWholeRect;
    property Left: Integer index alLeft read GetRect write SetRect;
    property Top: Integer index alTop read GetRect write SetRect;
    property Right: Integer index alRight read GetRect write SetRect;
    property Bottom: Integer index alBottom read GetRect write SetRect;
  end;

  // TGraphNode - a node inside a list of nodes
  TGraphNode = class(TGraphEntity)
  private
    FIndex: Integer;
    FContent: String;
    FFitText: Boolean;
    FKeepHeight: Boolean;
    FKeepWidth: Boolean;
  protected
    function GetContent: String; virtual;
    function GetHeight: Integer; virtual;
    function GetWidth: Integer; virtual;
    procedure SetContent(const Value: String); virtual;
    procedure SetHeight(const Value: Integer); virtual;
    procedure SetWidth(const Value: Integer); virtual;
    procedure SetFitText(const Value: Boolean); virtual;

    procedure SetCaption(const Value: String); override;
    procedure SetRect(const Index: TAlign; Value: Integer); override;

    // if FitText is True, it updates the dimensions of the rectangle so that
    // it at least fits the text inside
    procedure UpdateFitText; virtual;
  public
    // index of the graph node within the list of nodes of the graph
    property Index: Integer read FIndex;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
    // additional information that is displayed below the caption
    property Content: String read GetContent write SetContent;
    // if True when you change the Left coordinate, the Right property is changed
    // so that Width remains the same
    property KeepWidth: Boolean read FKeepWidth write FKeepWidth;
    // if True when you change the Top coordinate, the Bottom property is changed
    // so that Height remains the same
    property KeepHeight: Boolean read FKeepHeight write FKeepHeight;
    // changes the right and bottom so that the node fits the text
    property FitText: Boolean read FFitText write SetFitText;
  end;

  // TGraphEdge - an edge inside the list of edges
  TGraphEdge = class(TGraphEntity)
  private
    FEndNode: TGraphNode;
    FStartNode: TGraphNode;
  public
    property StartNode: TGraphNode read FStartNode;
    property EndNode: TGraphNode read FEndNode;
  end;

  // TGraph - represents an entire graph and contains some shortcuts to handle
  // nodes and edges in it
  EGraphError = class(Exception);

  TGraph = class(TPersistent)
  public
    type
      TFindGraphNodeCallback = reference to function (Node: TGraphNode): Boolean;
      TOutgoingEdges = TObjectList<TGraphEdge>;
  protected
    type
      TEdgeData = TObjectList<TOutgoingEdges>;
      TNodeData = TObjectList<TGraphNode>;
  private
    var
      FNodeData: TNodeData;
      FEdgeData: TEdgeData;
      FEdgeCount: Integer; // caches the value so that we don't have to iterate through EdgeData to calculate it
      FNodeClass: TGraphNodeClass;
      FEdgeClass: TGraphEdgeClass;
      FUpdateCount: Integer;
  protected
    // checks if the specified node index is valid within the graph
    procedure CheckIndex(Index: Integer);
    // checks if the owner of the given Entity is the current Graph
    procedure CheckOwner(Entity: TGraphEntity);

    function GetNodeCount: Integer; inline;
    function GetNodes(Index: Integer): TGraphNode; inline;
    function GetEdges(NodeIndex: Integer): TOutgoingEdges;

    // some node properties use these methods to determine their dimensions
    // based on the contained text; they return 0 in this class, but descendants
    // can override these in order to return more significant values
    function GetTextWidth(const Text: String): Integer; virtual;
    function GetTextHeight(const Text: String): Integer; virtual;

    // called by EndUpdate whenever UpdateCount is zero; it can be
    // used by descendants to update other classes
    procedure Update; virtual;

    // the number of BeginUpdate-s called
    property UpdateCount: Integer read FUpdateCount;
    // access to the internal data structure for storing the nodes
    property NodeData: TNodeData read FNodeData;
    // internal data structure that stores the edges
    property EdgeData: TEdgeData read FEdgeData;
  public
    constructor Create;
    destructor Destroy; override;

    // when large amounts of operations are done on the graph, do them between
    // this couple of routines to update at the end the; you must call them in
    // pairs to have the UpdateCount property zero
    procedure BeginUpdate; inline;
    procedure EndUpdate;

    // Node specific routines

    // adds a node to the graph and returns a reference to it
    function AddNode: TGraphNode;
    // deletes the node at the specified index; if there are any edges that
    // use the node, it removes them from the graph
    procedure DeleteNode(Index: Integer);
    // deletes the specified node from the graph and returns the index where
    // it was located before the deletion
    function RemoveNode(Node: TGraphNode): Integer;

    // Edge specific routines

    // adds a new edge to the graph between the specified node indexes
    function AddEdge(StartIndex, EndIndex: Integer): TGraphEdge;
    procedure DeleteEdge(StartIndex, EndIndex: Integer);
    function RemoveEdge(Edge: TGraphEdge): Integer;
    // searches for the edge that starts from the StartIndex node and ends in
    // the EndIndex node; if it succeeds, it returns the index of the edge
    // in the adiacent list of the start index node; if not, it returns -1
    function FindEdge(StartIndex, EndIndex: Integer; out Edge: TGraphEdge): Integer;
    function FindNode(out Node: TGraphNode; Callback: TFindGraphNodeCallback): Boolean;

    // clear all nodes and edges
    procedure Clear;
    // clear all edges
    procedure ClearEdges;

    // the nodes in the graph
    property Nodes[Index: Integer]: TGraphNode read GetNodes;
    // the number of nodes in the graph
    property NodeCount: Integer read GetNodeCount;
    // returns the list of outgoing edges for the specified node index
    property Edges[NodeIndex: Integer]: TOutgoingEdges read GetEdges;
    // the total number of edges
    property EdgeCount: Integer read FEdgeCount;
    // the class ref of the node that is to be used to create instances of nodes
    property NodeClass: TGraphNodeClass read FNodeClass write FNodeClass;
    // the class ref of the edge that is to be used to create instances of edges
    property EdgeClass: TGraphEdgeClass read FEdgeClass write FEdgeClass;
  end;

  // TGraphViewData - graph instantiated internally by a TGraphView
  TGraphViewGraph = class(TGraph)
  private
    FGraphView: TGraphView;
  protected
    function GetTextWidth(const Text: String): Integer; override;
    function GetTextHeight(const Text: String): Integer; override;
    procedure Update; override;

    // the graph view to which the graph is attached
    property GraphView: TGraphView read FGraphView;
  public
    constructor Create(GraphView: TGraphView);
  end;

  // TGraphView - shows a graph
  TGraphView = class(TCustomControl)
  public
    const
      CBulletSize: TPoint = (X: 4; Y: 4);
  private
    FGraph: TGraph;
    FBulletSize: TPoint;
    FDraggedNode: TGraphNode;
    FBulletColor: TColor;
    FNodeDragging: Boolean;
    // prevents the node to stick to the mouse when double clicked and node dragging
    // enabled; it happens when, i.e. you show a modal form in OnDblClick and then
    // close it
    FDblClicked: Boolean;

    procedure SetBulletSize(const Value: TPoint);
    procedure SetBulletColor(const Value: TColor);

    // returns the closest cross of the line that starts at LineStart and
    // which ends in the center of the node;
    // it doesn't handle situations in which the line is vertical or horizontal
    function GetLineToNodeCross(LineStart: TPoint; ARect: TRect): TPoint;
  protected
    // adds the coordinates of R1 to R2 and returns the new rect
    function AddRects(const R1, R2: TRect): TRect; inline;
    // returns the X coordinate of a point situated on the line defined by StartPt and EndPt
    function PtXOnLine(StartPt, EndPt: TPoint; PtY: Integer): Integer;
    // returns the Y coordinate of a point situated on the line defined by StartPt and EndPt
    function PtYOnLine(StartPt, EndPt: TPoint; PtX: Integer): Integer;
    // returns the length of the line
    function LineLength(StartPt, EndPt: TPoint): Integer;

    procedure PaintNode(Node: TGraphNode);
    procedure PaintNodes;
    procedure PaintEdge(Edge: TGraphEdge);
    procedure PaintEdges;

    procedure Paint; override;

    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // returns the graph node located at the given point; if at that point
    // there is no node, it returns nil
    function GetNodeFromPoint(Point: TPoint): TGraphNode;
    // moves the center of the specified Node at the X and Y coordinates
    procedure MoveNode(Node: TGraphNode; X, Y: Integer);

    // the graph object that is shown by the control
    property Graph: TGraph read FGraph;
    // bullets are represented as small squares that indicate the end of an edge
    property BulletSize: TPoint read FBulletSize write SetBulletSize;
    // the color of the bullets
    property BulletColor: TColor read FBulletColor write SetBulletColor;
    // the node that is currently being dragged; it is Nil if no node is being dragged
    property DraggedNode: TGraphNode read FDraggedNode;
    // specifies whether nodes can be dragged with the mouse
    [Default(True)]
    property NodeDragging: Boolean read FNodeDragging write FNodeDragging default True;
  published
    [Default(True)]
    property DoubleBuffered default True;
    property Color default clWhite;
    property BevelKind default bkFlat;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

implementation

{ TGraphView }

function TGraphView.AddRects(const R1, R2: TRect): TRect;
begin
  Result := System.Types.Rect(
    R1.Left + R2.Left,
    R1.Top + R2.Top,
    R1.Right + R2.Right,
    R1.Bottom + R2.Bottom);
end;

constructor TGraphView.Create(AOwner: TComponent);
begin
  inherited;

  ControlStyle := ControlStyle + [csOpaque, csClickEvents];
  DoubleBuffered := True;
  Color := clWhite;
  Width := 50;
  Height := 50;
  BevelKind := bkFlat;

  FBulletSize := CBulletSize;
  FBulletColor := clWhite;
  FNodeDragging := True;

  FGraph := TGraphViewGraph.Create(Self);
end;

procedure TGraphView.DblClick;
begin
  FDraggedNode := nil;
  FDblClicked := True;

  inherited;
end;

destructor TGraphView.Destroy;
begin
  FGraph.Free;

  inherited;
end;

function TGraphView.GetLineToNodeCross(LineStart: TPoint;
  ARect: TRect): TPoint;
type
  TSquareSide = (sqLeft, sqRight, sqTop, sqBottom);
  TSquareCrosses = array [TSquareSide] of TPoint;
var
  Crosses: TSquareCrosses;
  CenterPt: TPoint;
  CurrLength: Integer;
  MinLength: Integer;
  Side: TSquareSide;
begin
  CenterPt := CenterPoint(ARect);

  // intersect the line from the other end to all the square sides
  Crosses[sqLeft].X := ARect.Left;
  Crosses[sqLeft].Y := PtYOnLine(LineStart, CenterPt, Crosses[sqLeft].X);
  Crosses[sqRight].X := ARect.Right;
  Crosses[sqRight].Y := PtYOnLine(LineStart, CenterPt, Crosses[sqRight].X);
  Crosses[sqTop].Y := ARect.Top;
  Crosses[sqTop].X := PtXOnLine(LineStart, CenterPt, Crosses[sqTop].Y);
  Crosses[sqBottom].Y := ARect.Bottom;
  Crosses[sqBottom].X := PtXOnLine(LineStart, CenterPt, Crosses[sqBottom].Y);

  // inflate it to permit PtInRect to return the True when the cross point
  // has coordinates equal to one of the right or bottom sides
  Inc(ARect.Right);
  Inc(ARect.Bottom);

  // determine the minimum length segment that intersects the square
  // for which the intersection point is on the square side
  MinLength := MaxInt;
  for Side := Low(Crosses) to High(Crosses) do
  begin
    CurrLength := LineLength(Crosses[Side], LineStart);
    if (CurrLength <= MinLength) and ARect.Contains(Crosses[Side]) then
    begin
      MinLength := CurrLength;
      Result := Crosses[Side];
    end;
  end;
end;

function TGraphView.GetNodeFromPoint(Point: TPoint): TGraphNode;
var
  NodeRect: TRect;
  i: Integer;
begin
  Result := nil;
  for i := 0 to Graph.NodeCount - 1 do
  begin
    NodeRect := Graph.Nodes[i].Rect;
    Inc(NodeRect.Right);
    Inc(NodeRect.Bottom);

    if NodeRect.Contains(Point) then
      Exit(Graph.Nodes[i])
  end;
end;

function TGraphView.LineLength(StartPt, EndPt: TPoint): Integer;
begin
  Result := Round(Sqrt(Sqr(EndPt.X - StartPt.X) + Sqr(EndPt.Y - StartPt.Y)));
end;

procedure TGraphView.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;

  if (Button = mbLeft) and NodeDragging and not FDblClicked then
  begin
    FDraggedNode := GetNodeFromPoint(Point(X, Y));
    if Assigned(FDraggedNode) then
      MoveNode(DraggedNode, X, Y);
  end;
end;

procedure TGraphView.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(DraggedNode) then
    MoveNode(DraggedNode, X, Y);
end;

procedure TGraphView.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  FDblClicked := False;
  if (Button = mbLeft) and Assigned(DraggedNode) then
  begin
    MoveNode(DraggedNode, X, Y);
    FDraggedNode := nil;
  end;
end;

procedure TGraphView.MoveNode(Node: TGraphNode; X, Y: Integer);
var
  NodeRect: TRect;
  CenterPt: TPoint;
begin
  NodeRect := Node.Rect;
  CenterPt := CenterPoint(NodeRect);

  OffsetRect(NodeRect, X - CenterPt.X, Y - CenterPt.Y);
  Node.Rect := NodeRect;
end;

procedure TGraphView.Paint;
begin
  inherited;

  PaintNodes;
  PaintEdges;
end;

procedure TGraphView.PaintEdge(Edge: TGraphEdge);
var
  StartPt: TPoint; // center point of the start rect
  EndPt: TPoint; // center point of the end rect
  LineStart: TPoint;
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Edge.Color;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 2;
  Canvas.Pen.Color := Edge.Color;

  StartPt := CenterPoint(Edge.StartNode.Rect);
  EndPt := CenterPoint(Edge.EndNode.Rect);

  // the center points are on the same vertical line
  if StartPt.X = EndPt.X then
    if StartPt.Y < EndPt.Y then
    begin
      StartPt.Y := Edge.StartNode.Bottom;
      EndPt.Y := Edge.EndNode.Top;
    end
    else
    begin
      StartPt.Y := Edge.StartNode.Top;
      EndPt.Y := Edge.EndNode.Bottom;
    end
  else
    // the center points are on the same horizontal line
    if StartPt.Y = EndPt.Y then
      if StartPt.X < EndPt.X then
      begin
        StartPt.X := Edge.StartNode.Right;
        EndPt.X := Edge.EndNode.Left;
      end
      else
      begin
        StartPt.X := Edge.StartNode.Left;
        EndPt.X := Edge.EndNode.Right;
      end
    else // the points have no same coordinates one with each other
    begin
      LineStart := StartPt;
      StartPt := GetLineToNodeCross(EndPt, Edge.StartNode.Rect);
      EndPt := GetLineToNodeCross(LineStart, Edge.EndNode.Rect);
    end;

  // draw the line of the edge
  Canvas.MoveTo(StartPt.X, StartPt.Y);
  Canvas.LineTo(EndPt.X, EndPt.Y);

  // draw the bullet of the edge
  Canvas.Brush.Color := BulletColor;
  Canvas.Rectangle(
    EndPt.X - BulletSize.X,
    EndPt.Y + BulletSize.Y,
    EndPt.X + BulletSize.X,
    EndPt.Y - BulletSize.Y)
end;

procedure TGraphView.PaintEdges;
var
  i, j: Integer;
begin
  for i := 0 to Graph.NodeCount - 1 do
    for j := 0 to Graph.Edges[i].Count - 1 do
      PaintEdge(Graph.Edges[i][j]);
end;

procedure TGraphView.PaintNode(Node: TGraphNode);
var
  NodeRect: TRect;
  NodeText: String;
begin
  NodeRect := Node.Rect;

  // draw the rectangle of the node
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Node.Color;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := Node.Color;
  Canvas.Rectangle(NodeRect);

  // draw the caption of the node
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Color := Node.TextColor;
  NodeText := Node.Caption + sLineBreak + Node.Content;

  Canvas.TextRect(NodeRect, NodeText, [tfCenter, tfWordBreak]);
end;

procedure TGraphView.PaintNodes;
var
  i: Integer;
begin
  for i := 0 to Graph.NodeCount - 1 do
    PaintNode(Graph.Nodes[i]);
end;

function TGraphView.PtXOnLine(StartPt, EndPt: TPoint; PtY: Integer): Integer;
begin
  Result := Round((PtY - StartPt.Y) / (EndPt.Y - StartPt.Y)  * (EndPt.X - StartPt.X) + StartPt.X);
end;

function TGraphView.PtYOnLine(StartPt, EndPt: TPoint; PtX: Integer): Integer;
begin
  Result := Round((PtX - StartPt.X) / (EndPt.X - StartPt.X) * (EndPt.Y - StartPt.Y) + StartPt.Y);
end;

procedure TGraphView.SetBulletColor(const Value: TColor);
begin
  if Value <> FBulletColor then
  begin
    FBulletColor := Value;

    Invalidate;
  end;
end;

procedure TGraphView.SetBulletSize(const Value: TPoint);
begin
  if not CompareMem(@FBulletSize, @Value, SizeOf(TPoint)) then
  begin
    FBulletSize := Value;

    Invalidate;
  end;
end;

{ TGraphEntity }

constructor TGraphEntity.Create(Owner: TGraph);
begin
  inherited Create;

  FOwner := Owner;
end;

function TGraphEntity.GetCaption: String;
begin
  Result := FCaption;
end;

function TGraphEntity.GetRect(const Index: TAlign): Integer;
begin
  Result := 0;
  case Index of
    alLeft: Result := FRect.Left;
    alRight: Result := FRect.Right;
    alTop: Result := FRect.Top;
    alBottom: Result := FRect.Bottom;
  end;
end;

function TGraphEntity.GetWholeRect: TRect;
begin
  Result := FRect;
end;

procedure TGraphEntity.SetCaption(const Value: String);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;

    Update;
  end;
end;

procedure TGraphEntity.SetColor(const Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;

    Update;
  end;
end;

procedure TGraphEntity.SetRect(const Index: TAlign; Value: Integer);
begin
  case Index of
    alLeft: SetRectField(FRect.Left, Value);
    alRight: SetRectField(FRect.Right, Value);
    alTop: SetRectField(FRect.Top, Value);
    alBottom: SetRectField(FRect.Bottom, Value);
  end;
end;

procedure TGraphEntity.SetWholeRect(const Value: TRect);
begin
  if not CompareMem(@Value, @FRect, SizeOf(TRect)) then
  begin
    FRect := Value;

    Update;
  end;
end;

procedure TGraphEntity.SetRectField(var Field: Integer; Value: Integer);
begin
  if Field <> Value then
  begin
    Field := Value;

    Update;
  end;
end;

procedure TGraphEntity.SetTextColor(const Value: TColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;

    Update;
  end;
end;

procedure TGraphEntity.Update;
begin
  if Assigned(Owner) and (Owner.UpdateCount = 0) then
    Owner.Update;
end;

{ TGraph }

function TGraph.AddEdge(StartIndex, EndIndex: Integer): TGraphEdge;
begin
  CheckIndex(StartIndex);
  CheckIndex(EndIndex);

  if FindEdge(StartIndex, EndIndex, Result) = -1 then
    try
      BeginUpdate;
      // create the new edge and set its nodes
      Result := EdgeClass.Create(Self);
      Result.FStartNode := NodeData[StartIndex];
      Result.FEndNode := NodeData[EndIndex];

      // add the node to the internal structure storing the edges
      EdgeData[StartIndex].Add(Result);
      Inc(FEdgeCount);
    finally
      EndUpdate;
    end;
end;

function TGraph.AddNode: TGraphNode;
begin
  try
    BeginUpdate;
    // add the new node and point to the result to it
    Result := NodeClass.Create(Self);
    Result.FIndex := NodeData.Add(Result);

    // add the list in edges data that will store incident edges for this node
    EdgeData.Add(TOutgoingEdges.Create);
  finally
    EndUpdate;
  end;
end;

procedure TGraph.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TGraph.CheckIndex(Index: Integer);
begin
  if (Index < 0) or (Index >= NodeCount) then
    raise EGraphError.CreateFmt(sInvalidNodeIndex, [Index]);
end;

procedure TGraph.CheckOwner(Entity: TGraphEntity);
begin
  if not Assigned(Entity) or not (Entity.Owner <> Self) then
    raise EGraphError.Create(sInvalidOwner);
end;

procedure TGraph.Clear;
begin
  ClearEdges;
  NodeData.Clear;
end;

procedure TGraph.ClearEdges;
begin
  BeginUpdate;
  EdgeData.Clear;
  FEdgeCount := 0;
  EndUpdate;
end;

constructor TGraph.Create;
begin
  inherited;

  FNodeData := TNodeData.Create;
  FEdgeData := TEdgeData.Create;
  FNodeClass := TGraphNode;
  FEdgeClass := TGraphEdge;
end;

procedure TGraph.DeleteEdge(StartIndex, EndIndex: Integer);
var
  Edge: TGraphEdge;
  EdgeIdx: Integer;
begin
  CheckIndex(StartIndex);
  CheckIndex(EndIndex);

  try
    BeginUpdate;
    EdgeIdx := FindEdge(StartIndex, EndIndex, Edge);
    if EdgeIdx <> -1 then
    begin
      EdgeData[StartIndex].Delete(EdgeIdx);
      Dec(FEdgeCount);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TGraph.DeleteNode(Index: Integer);
var
  i, j: Integer;
begin
  CheckIndex(Index);

  try
    BeginUpdate;
    // delete the outgoing edges and the data specific to the node
    EdgeData.Delete(Index);
    NodeData.Delete(Index);

    // delete the incoming edges to the Index node
    for i := 0 to EdgeData.Count - 1 do
      for j := EdgeData[i].Count - 1 downto 0 do
        if EdgeData[i][j].EndNode.Index = Index then
          EdgeData[i].Delete(j);
  finally
    EndUpdate;
  end;
end;

destructor TGraph.Destroy;
begin
  FEdgeData.Free;
  FNodeData.Free;

  inherited;
end;

procedure TGraph.EndUpdate;
begin
  if UpdateCount > 0 then
    Dec(FUpdateCount);
  if UpdateCount = 0 then
    Update;
end;

function TGraph.FindEdge(StartIndex, EndIndex: Integer;
  out Edge: TGraphEdge): Integer;
var
  i: Integer;
begin
  CheckIndex(StartIndex);
  CheckIndex(EndIndex);

  Result := -1;
  for i := 0 to EdgeData[StartIndex].Count - 1do
  begin
    Edge := EdgeData[StartIndex][i];

    if (StartIndex = Edge.StartNode.Index) and (EndIndex = Edge.EndNode.Index) then
      Exit(i);
  end;
end;

function TGraph.FindNode(out Node: TGraphNode; Callback: TFindGraphNodeCallback): Boolean;
var
  i: Integer;
begin
  Result := False;
  Node := nil;
  if Assigned(Callback) then
    for i := 0 to NodeCount - 1 do
    begin
      Result := Callback(Nodes[i]);

      if Result then
      begin
        Node := Nodes[i];
        Exit(True);
      end;
    end;
end;

function TGraph.GetEdges(NodeIndex: Integer): TOutgoingEdges;
begin
  CheckIndex(NodeIndex);

  Result := EdgeData[NodeIndex];
end;

function TGraph.GetNodeCount: Integer;
begin
  Result := NodeData.Count;
end;

function TGraph.GetNodes(Index: Integer): TGraphNode;
begin
  CheckIndex(Index);

  Result := NodeData[Index];
end;

function TGraph.GetTextHeight(const Text: String): Integer;
begin
  Result := 0;
end;

function TGraph.GetTextWidth(const Text: String): Integer;
begin
  Result := 0;
end;

function TGraph.RemoveEdge(Edge: TGraphEdge): Integer;
begin
  CheckOwner(Edge);
  CheckOwner(Edge.StartNode);
  CheckIndex(Edge.StartNode.Index);

  try
    BeginUpdate;
    Result := EdgeData[Edge.StartNode.Index].Remove(Edge);
    if Result <> -1 then
      Dec(FEdgeCount);
  finally
    EndUpdate;
  end;
end;

function TGraph.RemoveNode(Node: TGraphNode): Integer;
begin
  CheckOwner(Node);

  Result := Node.Index;
  DeleteNode(Result);
end;

procedure TGraph.Update;
begin
  // descendants can write their code here
end;

{ TGraphViewData }

constructor TGraphViewGraph.Create(GraphView: TGraphView);
begin
  inherited Create;

  if not Assigned(GraphView) then
    EGraphError.Create(sUnattachedGraphView);

  FGraphView := GraphView;
  FNodeClass := TGraphNode;
  FEdgeClass := TGraphEdge;
end;

function TGraphViewGraph.GetTextHeight(const Text: String): Integer;
var
  LText: String;
  LRect: TRect;
begin
  LText := Text;
  LRect := Rect(0, 0, 0, 0);
  GraphView.Canvas.TextRect(LRect, LText, [tfCalcRect]);
  Result := LRect.Bottom - LRect.Top;
end;

function TGraphViewGraph.GetTextWidth(const Text: String): Integer;
begin
  Result := GraphView.Canvas.TextWidth(Text);
end;

procedure TGraphViewGraph.Update;
begin
  GraphView.Invalidate;
end;

{ TGraphNode }

function TGraphNode.GetContent: String;
begin
  Result := FContent;
end;

function TGraphNode.GetHeight: Integer;
begin
  Result := Bottom - Top;
end;

function TGraphNode.GetWidth: Integer;
begin
  Result := Right - Left;
end;

procedure TGraphNode.SetCaption(const Value: String);
begin
  if Value <> Caption then
  begin
    UpdateFitText;

    inherited;
  end;
end;

procedure TGraphNode.SetContent(const Value: String);
begin
  if Value <> FContent then
  begin
    FContent := Value;

    UpdateFitText;
    Update;
  end;
end;

procedure TGraphNode.SetFitText(const Value: Boolean);
begin
  if FFitText <> Value then
  begin
    FFitText := Value;

    UpdateFitText;
    Update;
  end;
end;

procedure TGraphNode.SetHeight(const Value: Integer);
var
  OldKeepHeight: Boolean;
begin
  if (GetHeight <> Value) and not KeepHeight then
  begin
    OldKeepHeight := KeepHeight;
    FKeepHeight := False;

    Bottom := Top + Value;

    FKeepHeight := OldKeepHeight;
  end;
end;

procedure TGraphNode.SetRect(const Index: TAlign; Value: Integer);
var
  CurrWidth: Integer;
  CurrHeight: Integer;
begin
  Owner.BeginUpdate;

  // store the current width and height
  CurrWidth := Width;
  CurrHeight := Height;

  // set the field to the specified value
  inherited;

  // adjust the width if necessary
  if KeepWidth then
    case Index of
      alLeft: inherited SetRect(alRight, Left + CurrWidth);
      alRight: inherited SetRect(alLeft, Right - CurrWidth);
    end;
  // adjust the height if needed
  if KeepHeight then
    case Index of
      alTop: inherited SetRect(alBottom, Top + CurrHeight);
      alBottom: inherited SetRect(alTop, Bottom - CurrHeight);
    end;

  Owner.EndUpdate;
end;

procedure TGraphNode.SetWidth(const Value: Integer);
var
  OldKeepWidth: Boolean;
begin
  if (GetWidth <> Value) and not KeepWidth then
  begin
    OldKeepWidth := FKeepWidth;
    FKeepWidth := False;

    Right := Left + Value;

    FKeepWidth := OldKeepWidth;
  end;
end;

procedure TGraphNode.UpdateFitText;
var
  CurrWidth: Integer;
  CurrHeight: Integer;
begin
  if FitText then
  begin
    Owner.BeginUpdate;

    // store the current width and height
    CurrWidth := Width;
    CurrHeight := Height;

    CurrWidth := Max(CurrWidth, Owner.GetTextWidth(Caption));
    CurrHeight := Max(CurrHeight, Owner.GetTextHeight(Caption + sLineBreak + Content));
    Rect := System.Types.Rect(Left, Top, Left + CurrWidth, Top + CurrHeight);

    Owner.EndUpdate;
  end;
end;

end.
