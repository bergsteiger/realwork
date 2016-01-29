unit PDPath;

interface

uses
  gtObject, PDSubPath, Contnrs;

type
  TgtPDPath = class(TObject)
  private
    FJustMoved: Boolean; // set if a new subpath was just started
    FFirstX: Double; // first point in new subpath
    FFirstY: Double;
    FSubPathList: TObjectList; // List of Subpaths

    constructor Create(JustMoved: Boolean; FirstX1: Double; FirstY1: Double;
      SubPathList: TObjectList); overload;

    function GetSubPath(Index: Integer): TgtPDSubPath;
    function GetSubPathCount: Integer;
  public
    constructor Create; overload;
    destructor Destroy; override;

    //Copy
    function Copy: TgtPDPath;

    //Is there a current point?
    function IsCurrentPoint: Boolean;

    // Is the path non-empty, i.e., is there at least one segment?
    function IsPath: Boolean;

    // Get subpaths.
    property SubPathCount: Integer read GetSubPathCount;
    property SubPaths[Index: Integer]: TgtPDSubPath read GetSubPath;

    // Get last point on last subpath.
    function LastX: Double;
    function LastY: Double;

    // Move the current point.
    procedure MoveTo(X: Double; Y: Double);

    // Add a segment to the last subpath.
    procedure LineTo(X: Double; Y: Double);

    // Add a Bezier curve to the last subpath
    procedure CurveTo(X1: Double; Y1: Double; X2: Double; Y2: Double;
      X3: Double; Y3: Double);

    // Close the last subpath.
    procedure Close;

    // Append <path> to <Self>.
    procedure Append(Path: TgtPDPath);

    // Add (<dx>, <dy>) to each point in the path.
    procedure AddOffset(Dx: Double; Dy: Double);
  end;

implementation

uses
  gtMethods;

{ TgtPDPath }

procedure TgtPDPath.AddOffset(Dx, Dy: Double);
var
  LI: Integer;
begin
  for LI := 0 to FSubPathList.Count - 1 do
    TgtPDSubPath(FSubPathList.Items[LI]).AddOffset(Dx, Dy);
end;

procedure TgtPDPath.Append(Path: TgtPDPath);
var
  LI: Integer;
begin
  for LI := 0 to Path.GetSubPathCount - 1 do
  begin
    FSubPathList.Add(Path.SubPaths[LI]);
  end;
  FJustMoved := False;
end;

procedure TgtPDPath.Close;
begin
  if FJustMoved then
  begin
    FSubPathList.Add(TgtPDSubPath.Create(FFirstX, FFirstY));
    FJustMoved := False;
  end;
  TgtPDSubPath(FSubPathList.Items[FSubPathList.Count - 1]).ClosePath;
end;

function TgtPDPath.Copy: TgtPDPath;
begin
  Result := TgtPDPath.Create(FJustMoved, FFirstX, FFirstY, Self.FSubPathList);
end;

constructor TgtPDPath.Create(JustMoved: Boolean; FirstX1, FirstY1: Double;
  SubPathList: TObjectList);
var
  LI: Integer;
begin
  FJustMoved := JustMoved;
  FFirstX := FirstX1;
  FFirstY := FirstY1;

  //Duplicate FSubPathList
  FSubPathList := TObjectList.Create;
  for LI := 0 to SubPathList.Count - 1 do
    FSubPathList.Add(TgtPDSubPath(SubPathList.Items[LI]).Copy);
end;

constructor TgtPDPath.Create;
begin
  FJustMoved := False;
  FFirstX := 0;
  FFirstY := 0;
  FSubPathList := TObjectList.Create;
end;

procedure TgtPDPath.CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
begin
  if FJustMoved then
  begin
    FSubPathList.Add(TgtPDSubPath.Create(FFirstX, FFirstY));
    FJustMoved := False;
  end;
  TgtPDSubPath(FSubPathList.Items[FSubPathList.Count - 1]).CurveTo(X1, Y1, X2, Y2, X3, Y3);
end;

destructor TgtPDPath.Destroy;
begin
  FreeObject(FSubPathList);
  inherited;
end;

function TgtPDPath.GetSubPath(Index: Integer): TgtPDSubPath;
begin
  Result := nil;
  if Index < FSubPathList.Count then
    Result := TgtPDSubPath(FSubPathList.Items[Index]);
end;

function TgtPDPath.GetSubPathCount: Integer;
begin
  Result := FSubPathList.Count;
end;

// Is there a current point?

function TgtPDPath.IsCurrentPoint: Boolean;
begin
  Result := False;
  if Assigned(FSubPathList) then
    Result := ((FSubPathList.Count > 0) or FJustMoved);
end;

// Is the path non-empty, i.e., is there at least one segment?

function TgtPDPath.IsPath: Boolean;
begin
  Result := (FSubPathList.Count > 0);
end;

function TgtPDPath.LastX: Double;
begin
  Result := TgtPDSubPath(FSubPathList.Items[FSubPathList.Count - 1]).LastX;
end;

function TgtPDPath.LastY: Double;
begin
  Result := TgtPDSubPath(FSubPathList.Items[FSubPathList.Count - 1]).LastY;
end;

procedure TgtPDPath.LineTo(X, Y: Double);
begin
  if FJustMoved then
  begin
    FSubPathList.Add(TgtPDSubPath.Create(FFirstX, FFirstY));
    FJustMoved := False;
  end;
  TgtPDSubPath(FSubPathList.Items[FSubPathList.Count - 1]).LineTo(X, Y);
end;

procedure TgtPDPath.MoveTo(X, Y: Double);
begin
  FJustMoved := True;
  FFirstX := X;
  FFirstY := Y;
end;

end.
