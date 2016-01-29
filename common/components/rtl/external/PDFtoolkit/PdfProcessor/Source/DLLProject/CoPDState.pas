unit CoPDState;

interface

uses
  PDStateIntf, PDState, PDMatrixIntf, Contnrs, gtMethods;

type

  TgtCoPDState = class(IgtPDState)
  private
    FPDState: TgtPDState;
    FObjectList: TObjectList;
  protected
    property State: TgtPDState read FPDState write FPDState;
  public

    constructor Create(AState: TgtPDState);
    destructor Destroy;

    function Copy: IgtPDState; override;

  // Transforms.
    procedure Transform(X1: Double; Y1: Double; var X2: Double; var Y2: Double);
      override;
    procedure TransformDelta(X1: Double; Y1: Double; var X2: Double; var Y2: Double);
      override;
    procedure TextTransform(X1: Double; Y1: Double; var X2: Double; var Y2: Double);
      override;
    procedure TextTransformDelta(X1: Double; Y1: Double; var X2: Double; var Y2: Double);
      override;
    function TransformWidth(Width: Double): Double; override;
    function GetTransformedLineWidth: Double; override;
    function GetTransformedFontSize: Double; override;
    function GetFontTransMatrix: IgtPDMatrix; override;

    procedure ConcatCTM(Matrix: IgtPDMatrix); override;
    procedure ShiftCTM(Tx: Double; Ty: Double); override;

  //Path Operations
    procedure MoveTo(X: Double; Y: Double); override;
    procedure LineTo(X: Double; Y: Double); override;
    procedure CurveTo(X1, Y1, X2, Y2, X3, Y3: Double); override;
    procedure ClosePath; override;
    procedure ClearPath; override;
    procedure Clip; override;
    procedure ClipToStrokePath; override;

  // Text position.
    procedure TextSetPos(Tx, Ty: Double); override;
    procedure TextMoveTo(Tx, Ty: Double); override;
    procedure TextShift(Tx, Ty: Double); override;
    procedure Shift(Dx, Dy: Double); override;

  // Push/pop GfxState on/off stack.
    function Save: IgtPDState; override;
    function Restore: IgtPDState; override;
    function HasSaves: Boolean; override;

//    function ParseBlendMode(BlendModeObj: IgtPDBaseObject;      Blend mode
//      var Mode: TgtBlendMode): Boolean; override;
  end;

implementation

{ TgtCoPDState }

procedure TgtCoPDState.ClearPath;
begin
  FPDState.ClearPath;
end;

procedure TgtCoPDState.Clip;
begin
  FPDState.Clip
end;

procedure TgtCoPDState.ClipToStrokePath;
begin
  FPDState.ClipToStrokePath;
end;

procedure TgtCoPDState.ClosePath;
begin
  FPDState.ClosePath;
end;

procedure TgtCoPDState.ConcatCTM(Matrix: IgtPDMatrix);
begin
//  FPDState.co
end;

function TgtCoPDState.Copy: IgtPDState;
var
  LState: TgtPDState;
  LCoState: TgtCoPDState;
begin
  LState := FPDState.Copy;
  LCoState := TgtCoPDState.Create(LState);
  if not Assigned(FObjectList) then
    FObjectList := TObjectList.Create;
  FObjectList.Add(LCoState);
  Result := LCoState;
end;

constructor TgtCoPDState.Create(AState: TgtPDState);
begin
  FPDState := AState;
end;

procedure TgtCoPDState.CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
begin
  FPDState.CurveTo(X1, Y1, X2, Y2, X3, Y3);
end;

destructor TgtCoPDState.Destroy;
begin
  if Assigned(FObjectList) then FreeObject(FObjectList);
end;

function TgtCoPDState.GetFontTransMatrix: IgtPDMatrix;
begin
//
end;

function TgtCoPDState.GetTransformedFontSize: Double;
begin
  Result := FPDState.GetTransformedFontSize;
end;

function TgtCoPDState.GetTransformedLineWidth: Double;
begin
  Result := FPDState.GetTransformedLineWidth;
end;

function TgtCoPDState.HasSaves: Boolean;
begin
  Result := FPDState.HasSaves;
end;

procedure TgtCoPDState.LineTo(X, Y: Double);
begin
  FPDState.LineTo(X, Y);
end;

procedure TgtCoPDState.MoveTo(X, Y: Double);
begin
  FPDState.MoveTo(X, Y);
end;

function TgtCoPDState.Restore: IgtPDState;
var
  LState: TgtPDState;
  LCoState: TgtCoPDState;
begin
  LState := FPDState.Restore;
  LCoState := TgtCoPDState.Create(LState);
  if not Assigned(FObjectList) then
    FObjectList := TObjectList.Create;
  FObjectList.Add(LCoState);
  Result := LCoState;
end;

function TgtCoPDState.Save: IgtPDState;
var
  LState: TgtPDState;
  LCoState: TgtCoPDState;
begin
  LState := FPDState.Save;
  LCoState := TgtCoPDState.Create(LState);
  if not Assigned(FObjectList) then
    FObjectList := TObjectList.Create;
  FObjectList.Add(LCoState);
  Result := LCoState;
end;

procedure TgtCoPDState.Shift(Dx, Dy: Double);
begin
  FPDState.Shift(Dx, Dy);
end;

procedure TgtCoPDState.ShiftCTM(Tx, Ty: Double);
begin
  FPDState.ShiftCTM(Tx, Ty);
end;

procedure TgtCoPDState.TextMoveTo(Tx, Ty: Double);
begin
  FPDState.TextMoveTo(Tx, Ty);
end;

procedure TgtCoPDState.TextSetPos(Tx, Ty: Double);
begin
  FPDState.TextSetPos(Tx, Ty);
end;

procedure TgtCoPDState.TextShift(Tx, Ty: Double);
begin
  FPDState.TextShift(Tx, Ty);
end;

procedure TgtCoPDState.TextTransform(X1, Y1: Double; var X2, Y2: Double);
begin
  FPDState.TextTransform(X1, Y1, X2, Y2);
end;

procedure TgtCoPDState.TextTransformDelta(X1, Y1: Double; var X2, Y2: Double);
begin
  FPDState.TextTransformDelta(X1, Y1, X2, Y2);
end;

procedure TgtCoPDState.Transform(X1, Y1: Double; var X2, Y2: Double);
begin
  FPDState.Transform(X1, Y1, X2, Y2);
end;

procedure TgtCoPDState.TransformDelta(X1, Y1: Double; var X2, Y2: Double);
begin
  FPDState.TransformDelta(X1, Y1, X2, Y2);
end;

function TgtCoPDState.TransformWidth(Width: Double): Double;
begin
  Result:= FPDState.TransformWidth(Width);
end;

end.
