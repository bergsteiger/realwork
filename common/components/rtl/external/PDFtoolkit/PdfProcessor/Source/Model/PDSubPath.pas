unit PDSubPath;

interface

uses
  gtObject, Contnrs;

type
  TgtPDSubPath = class(TgtObject)
  private
    FX: TObjectList;
    FY: TObjectList;
    FClosed: Boolean;
    FCurve: TObjectList;
    FCount: Integer;
    FIsIncreased: Boolean;

    function GetNumPoints: Integer;
    constructor Create(SubPath: TgtPDSubPath); overload;
  public
    constructor Create(X1: Double; Y1: Double); overload;
    destructor Destroy; override;

    //copy
    function Copy: TgtPDSubPath;

  // Get points.
    property NumPoints: Integer read GetNumPoints;
    function X(Index: Integer): Double;
    function Y(Index: Integer): Double;
    function Curve(Index: Integer): Boolean;

  // Get last point.
    function LastX: Double;
    function LastY: Double;

  // Add a line segment.
    procedure LineTo(X1: Double; Y1: Double);

  // Add a Bezier curve.
    procedure CurveTo(X1: Double; Y1: Double; X2: Double; Y2: Double;
      X3: Double; Y3: Double);

  // Close the subpath.
    procedure ClosePath;
    function IsClosed: Boolean;

  // Add (<dx>, <dy>) to each point in the subpath.
    procedure AddOffset(Dx: Double; Dy: Double);

  end;


implementation

uses
  PDReal, gtMethods, PDBoolean;

{ TgtPDSubPath }

procedure TgtPDSubPath.AddOffset(Dx, Dy: Double);
var
  LI: Integer;
begin
  for LI := 0 to FCount - 1 do
  begin
    TgtPDReal(FX.Items[LI]).Value := TgtPDReal(FX.Items[LI]).Value + Dx;
    TgtPDReal(FY.Items[LI]).Value := TgtPDReal(FY.Items[LI]).Value + Dx;
  end;
end;

 (*
  * Closes the subpath.
  *
  *)

procedure TgtPDSubPath.ClosePath;
begin
  if (TgtPDReal(FX.Items[FCount - 1]).Value <> TgtPDReal(FX.Items[0]).Value) or
    (TgtPDReal(FY.Items[FCount - 1]).Value <> TgtPDReal(FY.Items[0]).Value) then
    LineTo(TgtPDReal(FX.Items[0]).Value, TgtPDReal(FY.Items[0]).Value);
  FClosed := True;
end;

function TgtPDSubPath.Copy: TgtPDSubPath;
begin
  Result := TgtPDSubPath.Create(Self);
end;

constructor TgtPDSubPath.Create(SubPath: TgtPDSubPath);
var
  LI: Integer;
begin
  //Duplicate FX
  FX := TObjectList.Create;
  for LI := 0 to SubPath.FX.Count - 1 do
    FX.Add(TgtPDReal.Create(TgtPDReal(SubPath.FX.Items[LI]).Value));

  //Duplicate FY
  FY := TObjectList.Create;
  for LI := 0 to SubPath.FY.Count - 1 do
    FY.Add(TgtPDReal.Create(TgtPDReal(SubPath.FY.Items[LI]).Value));

  //Duplicate FCurve
  FCurve := TObjectList.Create();
  for LI := 0 to SubPath.FCurve.Count - 1 do
    FCurve.Add(TgtPDBoolean.Create(TgtPDBoolean(SubPath.FCurve.Items[LI]).Value));

  FClosed := SubPath.FClosed;
  FCount := SubPath.FCount;
  FIsIncreased := SubPath.FIsIncreased;
end;

constructor TgtPDSubPath.Create(X1, Y1: Double);
begin
  FCount := 1;
  FX := TObjectList.Create;
  FY := TObjectList.Create;
  FX.Add(TgtPDReal.Create(X1));
  FY.Add(TgtPDReal.Create(Y1));

  FCurve := TObjectList.Create;

  FCurve.Add(TgtPDBoolean.Create(False));
  FClosed := False;
  FIsIncreased := False;
end;

function TgtPDSubPath.Curve(Index: Integer): Boolean;
begin
  if Index < FCurve.Count then
    Result := TgtPDBoolean(FCurve.Items[Index]).Value
  else
    Result := False;
end;

 (*
  * Ads a Bezier curve.
  * @param X1 Is the first X coordinate point of type Double
  * @param Y1 Is the first Y coordinate point of type Double
  * @param X2 Is the second X coordinate point of type Double
  * @param Y2 Is the second Y coordinate point of type Double
  * @param X3 Is the third X coordinate point of type Double
  * @param Y3 Is the third Y coordinate point of type Double
  *)

procedure TgtPDSubPath.CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
begin
  FX.Add(TgtPDReal.Create(X1));
  FY.Add(TgtPDReal.Create(Y1));
  FX.Add(TgtPDReal.Create(X2));
  FY.Add(TgtPDReal.Create(Y2));
  FX.Add(TgtPDReal.Create(X3));
  FY.Add(TgtPDReal.Create(Y3));
  FCurve.Add(TgtPDBoolean.Create(True));
  FCurve.Add(TgtPDBoolean.Create(True));
  FCurve.Add(TgtPDBoolean.Create(False));
  if FIsIncreased then
    Inc(FCount);
  FIsIncreased := True;
end;

destructor TgtPDSubPath.Destroy;
begin
  FreeObject(FX);
  FreeObject(FY);
  FreeObject(FCurve);
  inherited;
end;

function TgtPDSubPath.GetNumPoints: Integer;
begin
  Result := FCount;
end;

function TgtPDSubPath.IsClosed: Boolean;
begin
  Result := FClosed;
end;

 (*
 * Gets the value of lastX
 * @return Returns the value fo LastX
 *)

function TgtPDSubPath.LastX: Double;
begin
  Result := TgtPDReal(FX.Items[FCount - 1]).Value;
end;

function TgtPDSubPath.LastY: Double;
begin
  Result := TgtPDReal(FY.Items[FCount - 1]).Value;
end;

 (*
  * Ads a line segment
  * @param X1 Is the X coordinate point of type Double
  * @param Y1 Is the Y coordinate point of type Double
  *)

procedure TgtPDSubPath.LineTo(X1, Y1: Double);
begin
  FX.Add(TgtPDReal.Create(X1));
  FY.Add(TgtPDReal.Create(Y1));
  FCurve.Add(TgtPDBoolean.Create(False));
  if FIsIncreased then
    Inc(FCount);
  FIsIncreased := True;
end;

function TgtPDSubPath.X(Index: Integer): Double;
begin
  if Index < FX.Count then
    Result := TgtPDReal(FX.Items[Index]).Value
  else
    Result := TgtPDReal(FX.Items[FX.Count - 1]).Value;
end;

function TgtPDSubPath.Y(Index: Integer): Double;
begin
  if Index < FY.Count then
    Result := TgtPDReal(FY.Items[Index]).Value
  else
    Result := TgtPDReal(FY.Items[FY.Count - 1]).Value;
end;

end.
