{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Direct2D;

interface

uses
  Winapi.Windows, Vcl.Controls, Winapi.D2D1,
  System.Classes, Vcl.Graphics, System.SysUtils, System.Generics.Collections;

type
  TDirect2DCanvas = class;

  EDirect2DException = class(Exception);

  TDirect2DGraphicsObject = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FOwner: TDirect2DCanvas;
  protected
    procedure Changed; dynamic;
    procedure ReleaseHandle; dynamic;
  public
    constructor Create(AOwner: TDirect2DCanvas); dynamic;
    destructor Destroy; override;

    property Owner: TDirect2DCanvas read FOwner;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TDirect2DBrush = class(TDirect2DGraphicsObject)
  private
    FBitmap: TBitmap;
    FBrush: ID2D1Brush;
    FColor: TColor;
    FStyle: TBrushStyle;
    function GetBitmap: TBitmap;
    procedure SetBitmap(const Value: TBitmap);

    procedure BitmapChanged(Sender: TObject);
  protected
    function GetColor: TColor;
    function GetHandle: ID2D1Brush;
    function GetStyle: TBrushStyle;
    procedure SetColor(const Value: TColor);
    procedure SetHandle(const Value: ID2D1Brush);
    procedure SetStyle(const Value: TBrushStyle);
    procedure ReleaseHandle; override;
  public
    constructor Create(Owner: TDirect2DCanvas); override;

    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
  published
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property Color: TColor read GetColor write SetColor;
    property Style: TBrushStyle read GetStyle write SetStyle;
    property Handle: ID2D1Brush read GetHandle write SetHandle;
  end;

  TDirect2DPen = class(TDirect2DGraphicsObject)
  private
    FBrush: TDirect2DBrush;
    FStrokeStyle: ID2D1StrokeStyle;
    FStyle: TPenStyle;
    FWidth: Integer;
  protected
    function GetBrush: TDirect2DBrush;
    function GetColor: TColor;
    function GetStyle: TPenStyle;
    procedure SetBrush(const Value: TDirect2DBrush);
    procedure SetColor(Color: TColor);
    procedure SetStyle(const Value: TPenStyle);
    procedure ReleaseHandle; override;
  public
    constructor Create(Owner: TDirect2DCanvas); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
  published
    property Brush: TDirect2DBrush read GetBrush write SetBrush;
    property Color: TColor read GetColor write SetColor default clBlack;
    property StrokeStyle: ID2D1StrokeStyle read FStrokeStyle;
    property Style: TPenStyle read GetStyle write SetStyle default psSolid;
    property Width: Integer read FWidth write FWidth default 1;
  end;

  TDirect2DFont = class(TDirect2DGraphicsObject)
  private
    FBrush: TDirect2DBrush;
    FHeight: Integer;
    FName: TFontName;
    FOrientation : Integer;
    FPitch: TFontPitch;
    FStyle: TFontStyles;
    FPixelsPerInch: Integer;

  protected
    function GetBrush: TDirect2DBrush;
    function GetColor: TColor;
    function GetHandle: IDWriteTextFormat;
    function GetHeight: Integer;
    function GetSize: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetSize(const Value: Integer);
    procedure SetBrush(const Value: TDirect2DBrush);
    procedure SetColor(const Value: TColor);
    procedure ReleaseHandle; override;

  public
    constructor Create(AOwner: TDirect2DCanvas); override;
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    property Handle: IDWriteTextFormat read GetHandle;
  published
    property Color: TColor read GetColor write SetColor;
    property Brush: TDirect2DBrush read GetBrush write SetBrush;
    property PixelsPerInch: Integer read FPixelsPerInch write FPixelsPerInch;

    property Height: Integer read GetHeight write SetHeight;
    property Name: TFontName read FName write FName;
    property Orientation: Integer read FOrientation write FOrientation default 0;
    property Pitch: TFontPitch read FPitch write FPitch default fpDefault;
    property Size: Integer read GetSize write SetSize;
    property Style: TFontStyles read FStyle write FStyle;
  end;

  TDirect2DCanvas = class(TCustomCanvas)
  strict private
    class var FSupported: TUncertainState;
  private
    FPen: TDirect2DPen;
    FFont: TDirect2DFont;
    FBrush:  TDirect2DBrush;

    FD2DObjects: TList<TDirect2DGraphicsObject>;

    //Attached GDI Resources
    FDC: HDC;
    FHwnd: HWND;
    FSubRect: TRect;

    FRenderTarget: ID2D1RenderTarget;
    FPenPos: TPoint;

    procedure InitResources;
  protected
    function GetBrush: TDirect2DBrush;
    function GetFont: TDirect2DFont;
    function GetPen: TDirect2DPen;
    function GetPenPos: TPoint; override;
    function GetRenderTarget: ID2D1RenderTarget;
    procedure SetBrush(const Value: TDirect2DBrush);
    procedure SetFont(const Value: TDirect2DFont);
    procedure SetPen(const Value: TDirect2DPen);
    procedure SetPenPos(Value: TPoint); override;
    //Unimplemented Getters/Setters for Direct2D
    function GetCanvasOrientation: TCanvasOrientation; override;
    function GetClipRect: TRect; override;
    function GetPixel(X, Y: Integer): TColor; override;
    procedure SetPixel(X, Y: Integer; Value: TColor); override;

    procedure Notification(AD2DObject: TDirect2DGraphicsObject; Operation: TOperation);

    procedure RequiredState(ReqState: TCanvasState); override;
    procedure CreateRenderTarget;

  public
    class function Supported: Boolean;

    constructor Create(DC: HDC; SubRect: TRect); overload;
    constructor Create(Canvas: TCanvas; SubRect: TRect); overload;
    constructor Create(Handle : HWND); overload;
    destructor Destroy; override;

    function CreateBrush(Color: TColor): ID2D1Brush; overload;
    function CreateBrush(Bitmap: TBitmap): ID2D1Brush; overload;
    function CreateBrush(Colors: array of TColor; StartPoint, EndPoint: TD2D1Point2F): ID2D1Brush; overload;
    function CreateBrush(Colors: array of TColor; Center, Offset: TD2D1Point2F;
      RadiusX, RadiusY: Single): ID2D1Brush; overload;

    function CreateBitmap(Bitmap: TBitmap): ID2D1Bitmap;

    procedure BeginDraw;
    procedure EndDraw;

    procedure DrawEllipse(const Ellipse: TD2D1Ellipse);
    procedure DrawGeometry(Geometry: ID2D1Geometry);
    procedure DrawLine(Point0, Point1: TD2DPoint2f);
    procedure DrawRectangle(const Rect: TD2D1RectF);
    procedure DrawRoundedRectangle(const RoundedRect: TD2D1RoundedRect);

    procedure FillEllipse(const Ellipse: TD2D1Ellipse);
    procedure FillGeometry(Geometry: ID2D1Geometry);
    procedure FillRectangle(const Rect: TD2D1RectF);
    procedure FillRoundedRectangle(const roundedRect: TD2D1RoundedRect);

    // Override common functions from TCustomCanvas
    procedure Arc(X1: Integer; Y1: Integer; X2: Integer; Y2: Integer;
      X3: Integer; Y3: Integer; X4: Integer; Y4: Integer); override;
    procedure ArcTo(X1: Integer; Y1: Integer; X2: Integer; Y2: Integer;
      X3: Integer; Y3: Integer; X4: Integer; Y4: Integer); override;
    procedure AngleArc(X, Y: Integer; Radius: Cardinal; StartAngle, SweepAngle: Single); override;
    procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure FillRect(const Rect: TRect); override;
    procedure FrameRect(const Rect: TRect); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    procedure Rectangle(X1, Y1, X2, Y2: Integer); override;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); overload; override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic; Opacity: Byte); overload; override;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); overload; override;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic; Opacity: Byte); reintroduce; overload;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure PolyBezier(const Points: array of TPoint); override;
    procedure Polygon(const Points: array of TPoint); override;
    procedure Polyline(const Points: array of TPoint); override;

    procedure LineTo(X, Y: Integer); override;
    procedure MoveTo(X, Y: Integer); override;
    procedure PolyBezierTo(const Points: array of TPoint); override;
    procedure Refresh; override;

    function TextExtent(const Text: string): TSize; override;
    procedure TextOut(X, Y: Integer; const Text: string); override;
    procedure TextRect(var Rect: TRect; var Text: string; TextFormat: TTextFormat = []); overload; override;
    procedure TextRect(Rect: TRect; X, Y: Integer; const Text: string); overload; override;

    // Operations from TCustomCanvas that are invalid on a TDirect2DCanvas
    procedure BrushCopy(const Dest: TRect; Bitmap: TBitmap;
      const Source: TRect; Color: TColor); override;
    procedure DrawFocusRect(const Rect: TRect); override;  // Doesn't have a concept of XOR brushes/pens
    procedure FloodFill(X, Y: Integer; Color: TColor; FillStyle: TFillStyle); override;  //


    property RenderTarget : ID2D1RenderTarget read GetRenderTarget;
    property Brush: TDirect2DBrush read GetBrush write SetBrush;
    property Pen: TDirect2DPen read GetPen write SetPen;
    property Font: TDirect2DFont read GetFont write SetFont;
  end;

function D2DFactory(factoryType: TD2D1FactoryType=D2D1_FACTORY_TYPE_SINGLE_THREADED;
  factoryOptions: PD2D1FactoryOptions = nil): ID2D1Factory;

function DWriteFactory(factoryType: TDWriteFactoryType=DWRITE_FACTORY_TYPE_SHARED): IDWriteFactory;


function D2D1ColorF(const AColor: TColor): TD2D1ColorF; overload;
function D2D1ColorF(const AColor: TColor; Alpha: Single): TD2D1ColorF; overload;

implementation

uses 
  Winapi.DxgiFormat, Winapi.UxTheme, System.Win.ComObj, System.Types, 
  System.UITypes, System.Math, Vcl.Forms, Vcl.Consts;

{ TDirect2DGraphicsObject }

constructor TDirect2DGraphicsObject.Create(AOwner: TDirect2DCanvas);
begin
  if AOwner = nil then
    raise EDirect2DException.CreateFmt(SNoOwner, [Self.ClassName]);
  FOwner := AOwner;
  FOwner.Notification(Self, opInsert);
end;

destructor TDirect2DGraphicsObject.Destroy;
begin
  FOwner.Notification(Self, opRemove);
end;

procedure TDirect2DGraphicsObject.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TDirect2DGraphicsObject.ReleaseHandle;
begin
end;

{ TD2DBrush }

procedure TDirect2DBrush.BitmapChanged(Sender: TObject);
begin
  FBrush := nil;
end;

constructor TDirect2DBrush.Create(Owner: TDirect2DCanvas);
begin
  inherited Create(Owner);
  FStyle := bsSolid;
  FColor := clWhite;
end;

destructor TDirect2DBrush.Destroy;
begin
  if Assigned(FBitmap) then
    FreeAndNil(FBitmap);
  inherited;
end;

procedure TDirect2DBrush.Assign(Source: TPersistent);
begin
  if Source is TBrush then
  begin
    FBrush := nil;

    if TBrush(Source).Bitmap <> nil then
    begin
      if Assigned(FBitmap) then FreeAndNil(FBitmap);
      FBitmap := TBitmap.Create;
      FBitmap.Assign(TBrush(Source).Bitmap);
    end;

    Color := TBrush(Source).Color;
    if FStyle in [bsSolid, bsClear] then
      FStyle := TBrush(Source).Style;
  end
  else if Source is TDirect2DBrush then
  begin
    if FOwner <> TDirect2DBrush(Source).FOwner then
      raise EDirect2DException.Create(SRequireSameOwner);

    if TDirect2DBrush(Source).FBitmap <> nil then
    begin
      if Assigned(FBitmap) then FreeAndNil(FBitmap);
      FBitmap := TBitmap.Create;
      FBitmap.Assign(TDirect2DBrush(Source).FBitmap);
      FBitmap.OnChange := BitmapChanged;
    end;

    FColor := TDirect2DBrush(Source).FColor;
    FStyle := TDirect2DBrush(Source).FStyle;
    FBrush := TDirect2DBrush(Source).FBrush;
  end
  else
    inherited;
end;

function TDirect2DBrush.GetHandle: ID2D1Brush;
begin
  if FBrush = nil then
  begin
    if FBitmap <> nil then
      FBrush := FOwner.CreateBrush(FBitmap)
    else
      FBrush := FOwner.CreateBrush(FColor);
  end;
  Result := FBrush;
end;

function TDirect2DBrush.GetBitmap: TBitmap;
begin
  Result := FBitmap;
end;

function TDirect2DBrush.GetColor: TColor;
begin
  if not Assigned(FBrush) or Supports(FBrush, ID2D1SolidColorBrush) then
    Result := FColor
  else
    raise EDirect2DException.Create(SDirect2DInvalidSolidBrush);
end;

function TDirect2DBrush.GetStyle: TBrushStyle;
begin
  Result := FStyle;
end;

procedure TDirect2DBrush.SetHandle(const Value: ID2D1Brush);
var
  LBrush: ID2D1SolidColorBrush;
  LColor: TD2D1ColorF;
begin
  if Supports(Value, ID2D1SolidColorBrush, LBrush) then
  begin
    LBrush.GetColor(LColor);
    FColor := Trunc(LColor.r * $FF) +
              (Trunc(LColor.g * $FF) shl 8) +
              (Trunc(LColor.b * $FF) shl 16);
  end;
  FStyle := bsSolid;
  FBrush := Value;
end;

procedure TDirect2DBrush.SetBitmap(const Value: TBitmap);
begin
  if Assigned(FBitmap) then FreeAndNil(FBitmap);
  FBrush := nil;
  FBitmap := TBitmap.Create;
  FBitmap.Assign(Value);
  FBitmap.OnChange := BitmapChanged;
end;

procedure TDirect2DBrush.SetColor(const Value: TColor);
var
  LBrush: ID2D1SolidColorBrush;
begin
  FColor := Value;
  if Supports(FBrush, ID2D1SolidColorBrush, LBrush) then
  begin
    LBrush.SetColor(D2D1ColorF(Value));
  end
  else
    FBrush := nil;
end;

procedure TDirect2DBrush.SetStyle(const Value: TBrushStyle);
begin
  case Value of
    bsSolid..bsClear:
    begin
      FStyle := Value;
    end;
    bsHorizontal..bsDiagCross:
      raise EDirect2DException.Create(SDirect2DInvalidBrushStyle);
  end;
end;

procedure TDirect2DBrush.ReleaseHandle;
begin
  inherited;
  FBrush := nil;
end;

{ TD2DPen }

constructor TDirect2DPen.Create(Owner: TDirect2DCanvas);
begin
  inherited Create(Owner);
  FWidth := 1;
  FBrush := TDirect2DBrush.Create(Owner);
  FBrush.Color := clBlack;
end;

destructor TDirect2DPen.Destroy;
begin
  FreeAndNil(FBrush);
  inherited;
end;

procedure TDirect2DPen.Assign(Source: TPersistent);
begin
  if Source is TPen then
  begin
    FWidth := TPen(Source).Width;
    Color := TPen(Source).Color;
    Style := TPen(Source).Style;
  end
  else if Source is TDirect2DPen then
  begin
   FBrush.Assign(TDirect2DPen(Source).FBrush);
   FStyle := TDirect2DPen(Source).FStyle;
   FStrokeStyle := TDirect2DPen(Source).FStrokeStyle;
   FWidth := TDirect2DPen(Source).FWidth;
  end
  else
    inherited;
end;

function TDirect2DPen.GetBrush: TDirect2DBrush;
begin
  Result := FBrush;
end;

function TDirect2DPen.GetColor: TColor;
begin
  Result := Brush.Color;
end;

function TDirect2DPen.GetStyle: TPenStyle;
begin
  Result := FStyle;
end;

procedure TDirect2DPen.SetBrush(const Value: TDirect2DBrush);
begin
  if Assigned(Value) and (Value.FOwner = FOwner) then
  begin
    FBrush.Assign(Value);
  end
  else
    raise EDirect2DException.Create(SRequireSameOwner);
end;

procedure TDirect2DPen.SetColor(Color: TColor);
begin
  FBrush.Color := Color;
end;

procedure TDirect2DPen.SetStyle(const Value: TPenStyle);
begin
  FStrokeStyle := nil;
  FStyle := Value;
end;

procedure TDirect2DPen.ReleaseHandle;
begin
  inherited;
  FBrush.ReleaseHandle;
end;

{ TD2DFont }

constructor TDirect2DFont.Create(AOwner: TDirect2DCanvas);
var
  DpiX, DpiY: Single;
begin
  inherited Create(AOwner);
  FBrush := TDirect2DBrush.Create(AOwner);
  FBrush.FColor := clWindowText;

  FName := TFontName(DefFontData.Name);
  FHeight := DefFontData.Height;
  FOrientation := DefFontData.Orientation;
  FPitch := DefFontData.Pitch;
  FStyle := DefFontData.Style;
  AOwner.RenderTarget.GetDpi(DpiX, DpiY);
  FPixelsPerInch := Trunc(DpiX);
end;

destructor TDirect2DFont.Destroy;
begin
  FBrush.Free;
  inherited;
end;

procedure TDirect2DFont.Assign(Source: TPersistent);
begin
  if Source is TFont then
  begin
    Name := TFont(Source).Name;
    Height := TFont(Source).Height;
    Orientation := TFont(Source).Orientation;
    Pitch := TFont(Source).Pitch;
    Color := TFont(Source).Color;
    Style := TFont(Source).Style;
  end
  else if Source is TDirect2DFont then
  begin
    if FOwner <> TDirect2DFont(Source).FOwner then
      raise EDirect2DException.Create(SRequireSameOwner);

    FBrush.Assign(TDirect2DFont(Source).FBrush);

    FHeight := TDirect2DFont(Source).FHeight;
    FName := TDirect2DFont(Source).FName;
    FOrientation := TDirect2DFont(Source).FOrientation;
    FPitch := TDirect2DFont(Source).FPitch;
    FStyle := TDirect2DFont(Source).FStyle;
    FPixelsPerInch := TDirect2DFont(Source).FPixelsPerInch;

  end
  else
    inherited;
end;

function TDirect2DFont.GetBrush: TDirect2DBrush;
begin
  Result := FBrush;
end;

function TDirect2DFont.GetColor: TColor;
begin
  Result := Brush.Color;
end;

function TDirect2DFont.GetHandle: IDWriteTextFormat;
var
  LWeight: TDWriteFontWeight;
  LStyle: TDWriteFontStyle;
begin
  if (fsItalic in FStyle) then
    LStyle := DWRITE_FONT_STYLE_ITALIC
  else
    LStyle := DWRITE_FONT_STYLE_NORMAL;
  if (fsBold in FStyle) then
    LWeight := DWRITE_FONT_WEIGHT_BOLD
  else
    LWeight := DWRITE_FONT_WEIGHT_NORMAL;

  DWriteFactory.CreateTextFormat(PWideChar(FName), nil, LWeight, LStyle,
  DWRITE_FONT_STRETCH_NORMAL, MulDiv(Size, FPixelsPerInch, 72), 'en-us', Result);                                          
end;

function TDirect2DFont.GetHeight: Integer;
begin
  Result := FHeight;
end;

function TDirect2DFont.GetSize: Integer;
begin
  Result := -MulDiv(FHeight, 72, FPixelsPerInch);
end;

procedure TDirect2DFont.SetBrush(const Value: TDirect2DBrush);
begin
  FBrush.Assign(Value);
end;

procedure TDirect2DFont.SetColor(const Value: TColor);
begin
  FBrush.Color := Value;
end;

procedure TDirect2DFont.SetHeight(const Value: Integer);
begin
  FHeight := Value;
end;

procedure TDirect2DFont.SetSize(const Value: Integer);
begin
  FHeight := -MulDiv(Value, FPixelsPerInch, 72);
end;

procedure TDirect2DFont.ReleaseHandle;
begin
  inherited;
  FBrush.ReleaseHandle;
end;

{ TD2DCanvas }

//Helper function for Arc, Pie, Chord
function PointsToArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer;
  out Center, A, B: TD2D1Point2F): TD2D1ArcSegment;
var
  TL, BR: TD2D1Point2F;
  A1, A2: Single;
  DAngle: Single;
  AA, BB: Single;
  Slope : Single;
  SavedExceptionMask: TArithmeticExceptionMask;
begin
  SavedExceptionMask := GetExceptionMask;
  SetExceptionMask(exAllArithmeticExceptions);
  try
    TL.x := Min(X1,x2);
    TL.y := Min(Y1,Y2);
    BR.x := Max(X1, X2);
    BR.y := Max(Y1, Y2);
    Center := D2D1PointF((BR.X +TL.X)/2, (BR.Y + TL.Y)/2);

    A1 := ArcTan2(Center.Y - Y3 - 0.5, Center.X - X3 - 0.5);
    A2 := ArcTan2(Center.Y - Y4 - 0.5, Center.X - X4 - 0.5);
    A1 := Pi - A1;
    A2 := Pi - A2;
    DAngle := A2-A1;
    if (DAngle < 0) and (-DAngle > 0.001) then
      DAngle := DAngle + 2 * PI;
    result.rotationAngle := 0;
    if DAngle > PI then
      result.arcSize := D2D1_ARC_SIZE_LARGE
    else
      result.arcSize := D2D1_ARC_SIZE_SMALL;
    result.sweepDirection := D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE;
    Result.size := D2D1SizeF((BR.X-TL.X-1)/2, (BR.Y - TL.Y-1)/2);

    AA := Result.size.width * Result.size.width;
    BB := Result.size.height * Result.size.height;
    Slope := ((Y3-center.y)*(Y3-center.y))/
             ((X3-center.x)*(X3-center.x));
    A.x := sqrt(AA*BB/(BB+AA*Slope));
    A.y := sqrt(BB*(1-A.x*A.x/AA));

    if (A1 < Pi/2) or (A1 > 3*PI/2) then
      A.x := center.x + A.x
    else
      A.x := center.x - A.x;

    if A1 > PI then
      A.y := center.y + A.y
    else
      A.y := center.y - A.y;
    Slope := ((Y4-center.y)*(Y4-center.y))/
             ((X4-center.x)*(X4-center.x));
    b.x := sqrt(AA*BB/(BB+AA*Slope));
    B.y := sqrt(BB*(1-B.x*B.x/AA));

    if (A2 < Pi/2) or (A2 > 3*PI/2) then
      B.x := center.x + b.x
    else
      B.x := center.x - B.x;

    if A2 > PI then
      B.y := center.y + B.y
    else
      B.y := center.y - B.y;

    result.point := B;
  finally
    SetExceptionMask(SavedExceptionMask);
  end;
end;

procedure TDirect2DCanvas.InitResources;
begin
  FD2DObjects := TList<TDirect2DGraphicsObject>.Create();

  FPen := TDirect2DPen.Create(Self);
  FFont := TDirect2DFont.Create(Self);
  FBrush := TDirect2DBrush.Create(Self);

  FPenPos := Point(0,0);
end;

class function TDirect2DCanvas.Supported: Boolean;
var
  LModule: HMODULE;
  LProc: Pointer;
begin
  if FSupported = TUncertainState.Maybe then
  begin
    LModule := LoadLibrary(d2d1lib);
    if LModule > 0 then
    begin
      LProc := GetProcAddress(LModule, 'D2D1CreateFactory'); // Do not localize
      if Assigned(LProc) then
        FSupported := TUncertainState.Yes
      else
        FSupported := TUncertainState.No;
      FreeLibrary(LModule);
    end
    else
      FSupported := TUncertainState.No;
  end;

  Result := FSupported = TUncertainState.Yes;
end;

constructor TDirect2DCanvas.Create(Canvas: TCanvas; SubRect : TRect);
begin
  Create(Canvas.Handle, SubRect);

  Pen.Assign(Canvas.Pen);
  Brush.Assign(Canvas.Brush);
  Font.Assign(Canvas.Font);
end;

constructor TDirect2DCanvas.Create(DC: HDC; SubRect : TRect);
begin
  FHwnd := 0;
  FDC := DC;
  FSubRect := SubRect;

  InitResources;
end;

constructor TDirect2DCanvas.Create(Handle: HWND);
begin
  FHwnd := Handle;
  FDC := 0;
  FSubRect := Rect(0,0,0,0);

  InitResources;
end;

destructor TDirect2DCanvas.Destroy;
begin
  FreeAndNil(FPen);
  FreeAndNil(FFont);
  FreeAndNil(FBrush);

  FreeAndNil(FD2DObjects);

  inherited;
end;

function TDirect2DCanvas.CreateBrush(Colors: array of TColor; StartPoint,
  EndPoint: TD2D1Point2F): ID2D1Brush;
var
  GradientStops: array of TD2D1GradientStop;
  GradientStopCollection: ID2D1GradientStopCollection;
  I: Integer;
  LBrush: ID2D1LinearGradientBrush;
begin
  SetLength(GradientStops, Length(Colors));
  for I := 0 to Length(Colors) - 1 do
  begin
    GradientStops[I].color := D2D1ColorF(Colors[I]);
    GradientStops[I].position := I / (Length(Colors) - 1);
  end;

  RenderTarget.CreateGradientStopCollection(@GradientStops[0], Length(GradientStops),
    D2D1_GAMMA_2_2, D2D1_EXTEND_MODE_CLAMP, GradientStopCollection);
  RenderTarget.CreateLinearGradientBrush(D2D1LinearGradientBrushProperties(StartPoint, EndPoint),
    nil, GradientStopCollection, LBrush);

  Result := LBrush;
end;

function TDirect2DCanvas.CreateBitmap(Bitmap: TBitmap): ID2D1Bitmap;
var
  BitmapInfo: TBitmapInfo;
  buf: array of Byte;
  BitmapProperties: TD2D1BitmapProperties;
begin
  FillChar(BitmapInfo, SizeOf(BitmapInfo), 0);
  BitmapInfo.bmiHeader.biSize := Sizeof(BitmapInfo.bmiHeader);
  BitmapInfo.bmiHeader.biHeight := -Bitmap.Height;
  BitmapInfo.bmiHeader.biWidth := Bitmap.Width;
  BitmapInfo.bmiHeader.biPlanes := 1;
  BitmapInfo.bmiHeader.biBitCount := 32;

  SetLength(buf, Bitmap.Height * Bitmap.Width * 4);
  GetDIBits(Bitmap.Canvas.Handle, Bitmap.Handle, 0, Bitmap.Height, @buf[0], BitmapInfo, DIB_RGB_COLORS);

  BitmapProperties.dpiX := 0;
  BitmapProperties.dpiY := 0;
  BitmapProperties.pixelFormat.format := DXGI_FORMAT_B8G8R8A8_UNORM;
  if (Bitmap.PixelFormat <> pf32bit) or (Bitmap.AlphaFormat = afIgnored) then
    BitmapProperties.pixelFormat.alphaMode := D2D1_ALPHA_MODE_IGNORE
  else
    BitmapProperties.pixelFormat.alphaMode := D2D1_ALPHA_MODE_PREMULTIPLIED;


  FRenderTarget.CreateBitmap(D2D1SizeU(Bitmap.Width, Bitmap.Height), @buf[0], 4*Bitmap.Width, BitmapProperties, Result)
end;

function TDirect2DCanvas.CreateBrush(Colors: array of TColor; Center,
  Offset: TD2D1Point2F; RadiusX, RadiusY: Single): ID2D1Brush;
var
  GradientStops: array of TD2D1GradientStop;
  GradientStopCollection: ID2D1GradientStopCollection;
  I: Integer;
  LBrush: ID2D1RadialGradientBrush;
begin
  SetLength(GradientStops, Length(Colors));
  for I := 0 to Length(Colors) - 1 do
  begin
    GradientStops[I].color := D2D1ColorF(Colors[I]);
    GradientStops[I].position := I / (Length(Colors) - 1);
  end;

  RenderTarget.CreateGradientStopCollection(@GradientStops[0], Length(GradientStops),
    D2D1_GAMMA_2_2, D2D1_EXTEND_MODE_CLAMP, GradientStopCollection);
  RenderTarget.CreateRadialGradientBrush(
    D2D1RadialGradientBrushProperties(Center, Offset, RadiusX, RadiusY),
    nil, GradientStopCollection, LBrush);
  Result := LBrush;
end;

function TDirect2DCanvas.CreateBrush(Bitmap: TBitmap): ID2D1Brush;
var
  LBitmap: ID2D1Bitmap;
  LBrush: ID2D1BitmapBrush;
  BrushProperties: TD2D1BitmapBrushProperties;
begin
  BrushProperties.extendModeX := D2D1_EXTEND_MODE_WRAP;
  BrushProperties.extendModeY := D2D1_EXTEND_MODE_WRAP;
  BrushProperties.interpolationMode := D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR;

  LBitmap := CreateBitmap(Bitmap);
  FRenderTarget.CreateBitmapBrush(LBitmap, @BrushProperties, nil, LBrush);
  Result := LBrush;
end;

function TDirect2DCanvas.CreateBrush(Color: TColor): ID2D1Brush;
var
  Brush: ID2D1SolidColorBrush;
begin
  FRenderTarget.CreateSolidColorBrush(D2D1ColorF(Color), nil, Brush);
  Result := Brush;
end;

procedure TDirect2DCanvas.CreateRenderTarget;
var
  Rect: TRect;
  HR: HRESULT;
begin
  if FHwnd <> 0 then
  begin
    // Render Target
    GetWindowRect(FHwnd, Rect);
    HR := D2DFactory.CreateHwndRenderTarget(D2D1RenderTargetProperties(),
     D2D1HwndRenderTargetProperties(FHwnd, D2D1SizeU(Rect.Right - Rect.Left, Rect.Bottom - Rect.Top)),
     ID2D1HwndRenderTarget(FRenderTarget));
    System.Win.ComObj.OleCheck(HR);
  end
  else if FDC <> 0 then
  begin
    D2DFactory.CreateDCRenderTarget(
      D2D1RenderTargetProperties(
        D2D1_RENDER_TARGET_TYPE_DEFAULT,
        D2D1PixelFormat(DXGI_FORMAT_B8G8R8A8_UNORM, D2D1_ALPHA_MODE_PREMULTIPLIED),
        0, 0, D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE),
      ID2D1DCRenderTarget(FRenderTarget));
    ID2D1DCRenderTarget(FRenderTarget).BindDC(FDC, FSubRect);
  end;
end;

procedure TDirect2DCanvas.BeginDraw;
begin
  RequiredState([csHandleValid]);
  RenderTarget.BeginDraw;
end;

procedure TDirect2DCanvas.EndDraw;
var
  HR: HRESULT;
begin
  HR := RenderTarget.EndDraw;
  if (HR = HRESULT(D2DERR_RECREATE_TARGET)) then
  begin
    Refresh;
  end;
end;

function TDirect2DCanvas.GetBrush: TDirect2DBrush;
begin
  Result := FBrush;
end;

function TDirect2DCanvas.GetFont: TDirect2DFont;
begin
  Result := FFont;
end;

function TDirect2DCanvas.GetPen: TDirect2DPen;
begin
  Result := FPen;
end;

function TDirect2DCanvas.GetPenPos: TPoint;
begin
  Result := FPenPos;
end;

function TDirect2DCanvas.GetRenderTarget: ID2D1RenderTarget;
begin
  if not Assigned(FRenderTarget) then
    CreateRenderTarget;
  Result := FRenderTarget;
end;

procedure TDirect2DCanvas.SetBrush(const Value: TDirect2DBrush);
begin
  if Assigned(Value) and (Value.Owner = Self) then
  begin
    FBrush.Assign(Value);
  end
  else
    raise EDirect2DException.CreateFmt(SDirect2DInvalidOwner,[Value.ClassName]);
end;

procedure TDirect2DCanvas.SetFont(const Value: TDirect2DFont);
begin
  if Assigned(Value) and (Value.Owner = Self) then
  begin
    FFont.Assign(Value);
  end
  else
    raise EDirect2DException.CreateFmt(SDirect2DInvalidOwner,[Value.ClassName]);
end;

procedure TDirect2DCanvas.SetPen(const Value: TDirect2DPen);
begin
  if Assigned(Value) and (Value.Owner = Self) then
  begin
    FreeAndNil(FPen);
    FPen := Value;
  end
  else
    raise EDirect2DException.CreateFmt(SDirect2DInvalidOwner,[Value.ClassName]);
end;

procedure TDirect2DCanvas.SetPenPos(Value: TPoint);
begin
  FPenPos := Value;
end;


procedure TDirect2DCanvas.Notification(AD2DObject: TDirect2DGraphicsObject;
  Operation: TOperation);
begin
  if Operation = opInsert then
    FD2DObjects.Add(AD2DObject)
  else
    FD2DObjects.Remove(AD2DObject);
end;

procedure TDirect2DCanvas.RequiredState(ReqState: TCanvasState);
const
  Styles: array[psDash..psDashDotDot] of TD2D1DashStyle = (D2D1_DASH_STYLE_DASH,
   D2D1_DASH_STYLE_DOT, D2D1_DASH_STYLE_DASH_DOT, D2D1_DASH_STYLE_DASH_DOT_DOT);
begin
  if (csHandleValid in ReqState) and (FRenderTarget = nil) then CreateRenderTarget;
  if (csBrushValid in ReqState) and (FBrush.FBrush = nil) then FBrush.Handle;
  if (csFontValid in ReqState) and (FFont.FBrush.FBrush = nil) then FFont.FBrush.Handle;
  if (csPenValid in ReqState) then
  begin
    if (FPen.FBrush.FBrush = nil) then FPen.FBrush.Handle;
    if not (FPen.FStyle in [psSolid,psClear, psInsideFrame]) and (FPen.FStrokeStyle = nil) then
    begin
      D2DFactory.CreateStrokeStyle(D2D1StrokeStyleProperties(D2D1_CAP_STYLE_FLAT,
        D2D1_CAP_STYLE_FLAT, D2D1_CAP_STYLE_ROUND, D2D1_LINE_JOIN_ROUND, 10, Styles[FPen.FStyle]),
        nil, 0, FPen.FStrokeStyle);
    end;
  end;
end;

procedure TDirect2DCanvas.DrawEllipse(const Ellipse: TD2D1Ellipse);
begin
  RequiredState([csHandleValid, csPenValid]);
  FRenderTarget.DrawEllipse(Ellipse, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.DrawGeometry(Geometry: ID2D1Geometry);
begin
  RequiredState([csHandleValid, csPenValid]);
  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.DrawLine(Point0, Point1: TD2DPoint2f);
begin
  RequiredState([csHandleValid, csPenValid]);
  FRenderTarget.DrawLine(Point0, Point1, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.DrawRectangle(const Rect: TD2D1RectF);
begin
  RequiredState([csHandleValid, csPenValid]);
  FRenderTarget.DrawRectangle(Rect , FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.DrawRoundedRectangle(const RoundedRect: TD2D1RoundedRect);
begin
  RequiredState([csHandleValid, csPenValid]);
  FRenderTarget.DrawRoundedRectangle(RoundedRect, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.FillEllipse(const Ellipse: TD2D1Ellipse);
begin
  RequiredState([csHandleValid, csBrushValid]);
  FRenderTarget.FillEllipse(Ellipse, FBrush.Handle);
end;

procedure TDirect2DCanvas.FillGeometry(Geometry: ID2D1Geometry);
begin
  RequiredState([csHandleValid, csBrushValid]);
  FRenderTarget.FillGeometry(Geometry , FBrush.Handle);
end;

procedure TDirect2DCanvas.FillRectangle(const Rect: TD2D1RectF);
begin
  RequiredState([csHandleValid, csBrushValid]);
  if FBrush.FStyle <> bsClear then
    FRenderTarget.FillRectangle(Rect, FBrush.Handle);
end;

procedure TDirect2DCanvas.FillRoundedRectangle(const roundedRect: TD2D1RoundedRect);
begin
  RequiredState([csHandleValid, csBrushValid]);
  FRenderTarget.FillRoundedRectangle(roundedRect, FBrush.Handle);
end;

procedure TDirect2DCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  StretchDraw(Rect(X,Y,X+Graphic.Width, Y+Graphic.Height), Graphic, 255);
end;

procedure TDirect2DCanvas.Draw(X, Y: Integer; Graphic: TGraphic; Opacity: Byte);
begin
  StretchDraw(Rect(X,Y,X+Graphic.Width, Y+Graphic.Height), Graphic, Opacity);
end;

procedure TDirect2DCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
  StretchDraw(Rect, Graphic, 255);
end;

procedure TDirect2DCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic;
  Opacity: Byte);
var
  D2DBitmap:  ID2D1Bitmap;
  D2DRect: TD2DRectF;
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.Assign(Graphic);

    D2DBitmap := CreateBitmap(Bitmap);

    D2DRect.Left   := Rect.Left;
    D2DRect.Right  := Rect.Right;
    D2DRect.Top    := Rect.Top;
    D2DRect.Bottom := Rect.Bottom;
    RenderTarget.DrawBitmap(D2DBitmap, @D2DRect, Opacity/255);
  finally
    Bitmap.Free;
  end;
end;

procedure TDirect2DCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var
  A,B, Center: TD2D1Point2F;
  Geometry: ID2D1PathGeometry;
  Sink: ID2D1GeometrySink;
  ArcSegment: TD2D1ArcSegment;
begin
  ArcSegment := PointsToArc(X1,Y1, X2,Y2, X3,Y3, X4,Y4, Center, A, B);
  D2DFactory.CreatePathGeometry(Geometry);
  Geometry.Open(Sink);
  try
    Sink.BeginFigure(A, D2D1_FIGURE_BEGIN_FILLED);
    try
      Sink.AddArc(ArcSegment);
    finally
      Sink.EndFigure(D2D1_FIGURE_END_OPEN);
    end;
  finally
    Sink.Close;
  end;
  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.ArcTo(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var
  A,B, Center: TD2D1Point2F;
  Geometry: ID2D1PathGeometry;
  Sink: ID2D1GeometrySink;
  ArcSegment: TD2D1ArcSegment;
begin
  ArcSegment := PointsToArc(X1,Y1, X2,Y2, X3,Y3, X4,Y4, Center, A, B);
  D2DFactory.CreatePathGeometry(Geometry);
  Geometry.Open(Sink);
  try
    Sink.BeginFigure(D2D1PointF(FPenPos.X+0.5,FPenPos.Y+0.5),
      D2D1_FIGURE_BEGIN_FILLED);
    try
      Sink.AddLine(A);
      Sink.AddArc(ArcSegment);
    finally
      Sink.EndFigure(D2D1_FIGURE_END_OPEN);
    end;
    FPenPos := TPoint(B);
  finally
    Sink.Close;
  end;
  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.AngleArc(X, Y: Integer; Radius: Cardinal;
  StartAngle, SweepAngle: Single);
var
  A,B: TD2D1Point2F;
  Geometry: ID2D1PathGeometry;
  Sink: ID2D1GeometrySink;
  ArcSegment: TD2D1ArcSegment;
  LSin, LCos: Single;
begin
  ArcSegment.size := D2D1SizeF(Radius, Radius);
  ArcSegment.rotationAngle := SweepAngle;
  if SweepAngle > 180 then
    ArcSegment.arcSize := D2D1_ARC_SIZE_LARGE
  else
    ArcSegment.arcSize := D2D1_ARC_SIZE_SMALL;
  SinCos(StartAngle * PI / 180, LSin, LCos);
  A := D2D1PointF(LCos * Radius + X, Y - LSin * Radius);
  SinCos((StartAngle + SweepAngle) * PI / 180, LSin, LCos);
  B := D2D1PointF(LCos * Radius + X, Y - LSin * Radius);
  ArcSegment.point := B;
  if SweepAngle > 0 then
    ArcSegment.sweepDirection := D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE
  else
    ArcSegment.sweepDirection := D2D1_SWEEP_DIRECTION_CLOCKWISE;

  D2DFactory.CreatePathGeometry(Geometry);
  Geometry.Open(Sink);
  try
    Sink.BeginFigure(D2D1PointF(FPenPos.X+0.5,FPenPos.Y+0.5),
      D2D1_FIGURE_BEGIN_FILLED);
    try
      Sink.AddLine(A);
      Sink.AddArc(ArcSegment);
    finally
      Sink.EndFigure(D2D1_FIGURE_END_OPEN);
    end;
    FPenPos := TPoint(B);
  finally
    Sink.Close;
  end;

  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;


procedure TDirect2DCanvas.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var
  A,B, Center: TD2D1Point2F;
  Geometry: ID2D1PathGeometry;
  Sink: ID2D1GeometrySink;
  ArcSegment: TD2D1ArcSegment;
begin
  ArcSegment := PointsToArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4, Center, A, B);
  D2DFactory.CreatePathGeometry(Geometry);
  Geometry.Open(Sink);
  try
    Sink.BeginFigure(A, D2D1_FIGURE_BEGIN_FILLED);
    try
      Sink.AddArc(ArcSegment);
    finally
      Sink.EndFigure(D2D1_FIGURE_END_CLOSED);
    end;
  finally
    Sink.Close;
  end;

  RequiredState([csHandleValid, csPenValid, csBrushValid]);

  if FBrush.FStyle <>  bsClear then                      
    FRenderTarget.FillGeometry(Geometry, FBrush.Handle);

  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
var
  LEllipse: TD2D1Ellipse;
begin
  LEllipse := D2D1Ellipse(D2D1PointF((X2 + X1)/2, (Y2 + Y1)/2),
    (X2 - X1 - 1)/2, (Y2 - Y1 - 1)/2);

  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  if FBrush.FStyle <> bsClear then
    RenderTarget.FillEllipse(LEllipse, FBrush.Handle);
  RenderTarget.DrawEllipse(LEllipse, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.FillRect(const Rect: TRect);
begin
  FillRectangle(Rect);
end;

procedure TDirect2DCanvas.FrameRect(const Rect: TRect);
begin
  RequiredState([csHandleValid, csBrushValid]);
  if FBrush.Style <> bsClear then
    FRenderTarget.DrawRectangle(
      D2D1RectF(Rect.Left + 0.5, Rect.Top + 0.5, Rect.Right - 0.5, Rect.Bottom - 0.5),
      FBrush.Handle);
end;

procedure TDirect2DCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var
  Geometry: ID2D1PathGeometry;
  Sink: ID2D1GeometrySink;
  ArcSegment: TD2D1ArcSegment;
  A, B, Center: TD2D1Point2F;
begin
  ArcSegment := PointsToArc(x1,y1, x2,y2, x3,y3, x4,y4, Center, A, B);
  D2DFactory.CreatePathGeometry(Geometry);
  Geometry.Open(Sink);
  try
    Sink.BeginFigure(Center, D2D1_FIGURE_BEGIN_FILLED);
    try
      Sink.AddLine(A);
      Sink.AddArc(ArcSegment);
    finally
      Sink.EndFigure(D2D1_FIGURE_END_CLOSED);
    end;
  finally
    Sink.Close;
  end;

  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  if FBrush.FStyle <> bsClear then
    FRenderTarget.FillGeometry(Geometry, FBrush.Handle);
  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.PolyBezier(const Points: array of TPoint);
var
  Geometry: ID2D1PathGeometry;
  Sink: ID2D1GeometrySink;
  I: Integer;
begin
  if (Length(Points)-1) mod 3 > 0 then Exit;

  D2DFactory.CreatePathGeometry(Geometry);
  OleCheck(Geometry.Open(Sink));
  try
    Sink.BeginFigure(D2D1PointF(Points[0].X+0.5, Points[0].Y+0.5), D2D1_FIGURE_BEGIN_FILLED);
    try
      i := 1;
      while I < Length(Points) do
      begin
        Sink.AddBezier(D2D1BezierSegment(
          D2D1PointF(Points[I].X+0.5, Points[I].Y+0.5),
          D2D1PointF(Points[I+1].X+0.5, Points[I+1].Y+0.5),
          D2D1PointF(Points[I+2].X+0.5, Points[I+2].Y+0.5)));
        Inc(I,3);
      end;
    finally
      Sink.EndFigure(D2D1_FIGURE_END_OPEN);
    end;
  finally
    Sink.Close;
  end;
  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.Polygon(const Points: array of TPoint);
var
  Geometry: ID2D1PathGeometry;
  Sink: ID2D1GeometrySink;
  I: Integer;
begin
  D2DFactory.CreatePathGeometry(Geometry);
  OleCheck(Geometry.Open(Sink));
  try
    Sink.BeginFigure(D2D1PointF(Points[0].X+0.5, Points[0].Y+0.5), D2D1_FIGURE_BEGIN_FILLED);
    try
      for I := 1 to Length(Points) - 1 do
        Sink.AddLine(D2D1PointF(Points[I].X+0.5, Points[I].Y+0.5));
    finally
      Sink.EndFigure(D2D1_FIGURE_END_CLOSED);
    end;
  finally
    Sink.Close;
  end;

  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  if FBrush.FStyle <> bsClear then
    FRenderTarget.FillGeometry(Geometry, FBrush.Handle);
  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, Fpen.FStrokeStyle);
end;

procedure TDirect2DCanvas.Polyline(const Points: array of TPoint);
var
  Geometry: ID2D1PathGeometry;
  Sink: ID2D1GeometrySink;
  I: Integer;
begin
  D2DFactory.CreatePathGeometry(Geometry);
  OleCheck(Geometry.Open(Sink));
  try
    Sink.BeginFigure(D2D1PointF(Points[0].x+0.5, Points[0].y+0.5), D2D1_FIGURE_BEGIN_HOLLOW);
    try
      for I := 1 to Length(Points) - 1 do
        Sink.AddLine(D2D1PointF(Points[I].X+0.5, Points[I].Y+0.5));
    finally
      Sink.EndFigure(D2D1_FIGURE_END_OPEN);
    end;
  finally
    Sink.Close;
  end;

  RequiredState([csHandleValid, csPenValid]);
  FRenderTarget.DrawGeometry(Geometry, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.Rectangle(X1, Y1, X2, Y2: Integer);
begin
  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  if FBrush.FStyle <> bsClear then
    FRenderTarget.FillRectangle(D2D1RectF(X1+0.5,Y1+0.5, X2-0.5, Y2-0.5), FBrush.Handle);
  FRenderTarget.DrawRectangle(D2D1RectF(X1+0.5,Y1+0.5, X2-0.5, Y2-0.5), FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

procedure TDirect2DCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
var
  RoundRect: TD2D1RoundedRect;
begin
  RoundRect := D2D1RoundedRect(D2D1RectF(X1+0.5, Y1+0.5, X2-0.5, Y2-0.5), X3 / 2, Y3 / 2);
  RequiredState([csHandleValid, csPenValid, csBrushValid]);
  if FBrush.FStyle <> bsClear then
    FRenderTarget.FillRoundedRectangle(RoundRect, FBrush.Handle);
  FRenderTarget.DrawRoundedRectangle(RoundRect, FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
end;

function TDirect2DCanvas.TextExtent(const Text: string): TSize;
var
  TextLayout: IDWriteTextLayout;
  TextMetrics: TDwriteTextMetrics;
begin
  OleCheck(DWriteFactory.CreateTextLayout(PWideChar(Text), Length(text),
    FFont.Handle, 0, 0, TextLayout));
  TextLayout.SetWordWrapping(DWRITE_WORD_WRAPPING_NO_WRAP);
  TextLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_NEAR);
  TextLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_LEADING);

  OleCheck(TextLayout.GetMetrics(TextMetrics));

  Result.cx := Round(TextMetrics.widthIncludingTrailingWhitespace);
  Result.cy := Round(TextMetrics.height);
end;

procedure TDirect2DCanvas.TextOut(X, Y: Integer; const Text: string);
var
  TextRange: TDwriteTextRange;
  TextLayout: IDWriteTextLayout;
  TextMetrics: TDWriteTextMetrics;
begin
  OleCheck(DWriteFactory.CreateTextLayout(PWideChar(Text), Length(Text),
    FFont.Handle, 0, 0, TextLayout));
  TextRange.startPosition := 0;
  TextRange.length := Length(Text);
  if fsUnderline in FFont.Style then
    TextLayout.SetUnderline(True, TextRange);

  if fsStrikeOut in FFont.Style then
    TextLayout.SetStrikethrough(True, TextRange);

  TextLayout.SetWordWrapping(DWRITE_WORD_WRAPPING_NO_WRAP);

  RequiredState([csHandleValid,  csFontValid, csBrushValid]);
  if FBrush.FStyle <> bsClear then
  begin
    TextLayout.GetMetrics(TextMetrics);
    RenderTarget.FillRectangle(D2D1RectF(X, Y,
      X+TextMetrics.widthIncludingTrailingWhitespace,
      Y+TextMetrics.height), FBrush.Handle);
  end;

  RenderTarget.DrawTextLayout(D2D1PointF(x-0.5, y-0.5), TextLayout,
    FFont.FBrush.Handle, D2D1_DRAW_TEXT_OPTIONS_NONE);
end;

procedure TDirect2DCanvas.TextRect(Rect: TRect; X, Y: Integer;
  const Text: string);
var
  TextRange: TDwriteTextRange;
  TextLayout: IDWriteTextLayout;
  TextMetrics: TDwriteTextMetrics;
begin
  OleCheck(DWriteFactory.CreateTextLayout(PWideChar(Text), Length(Text),
    FFont.Handle, 0, 0, TextLayout));
  TextRange.startPosition := 0;
  TextRange.length := Length(Text);
  if fsUnderline in FFont.Style then
    TextLayout.SetUnderline(True, TextRange);

  if fsStrikeOut in FFont.Style then
    TextLayout.SetStrikethrough(True, TextRange);

  TextLayout.SetWordWrapping(DWRITE_WORD_WRAPPING_NO_WRAP);

  RequiredState([csHandleValid, csFontValid, csBrushValid]);
  FRenderTarget.PushAxisAlignedClip(Rect, D2D1_ANTIALIAS_MODE_PER_PRIMITIVE);
  try
    if FBrush.FStyle <> bsClear then
    begin
      TextLayout.GetMetrics(TextMetrics);
      FRenderTarget.FillRectangle(Rect, FBrush.Handle);
    end;

    FRenderTarget.DrawTextLayout(D2D1PointF(x-0.5, y-0.5), TextLayout,
      FFont.FBrush.Handle, D2D1_DRAW_TEXT_OPTIONS_NONE);
  finally
    FRenderTarget.PopAxisAlignedClip;
  end;
end;

procedure TDirect2DCanvas.TextRect(var Rect: TRect; var Text: string;
  TextFormat: TTextFormat);
var
  TextRange: TDwriteTextRange;
  TextLayout: IDWriteTextLayout;
  LText: String;
  LRect: TRect;
  I, J: Integer;
  TrimmingSign: IDWriteInlineObject;
  TrimmingOptions: TDwriteTrimming;
  ClusterMetrics: array of TDwriteClusterMetrics;
  LineMetrics: array of TDwriteLineMetrics;
  Clusters, Lines, StartCluster: Cardinal;
  LineWidth: Single;
  BgRect: TD2DRectF;
begin
  FillChar(TextRange, SizeOf(TextRange), 0);
  SetLength(LText, Length(Text));
  // Replace && with &, set underline position
  if ([tfNoPrefix] * TextFormat) = [] then
  begin
    I := 1;
    J := 1;
    while I <= Length(Text) do
    begin
      if Text[I] = '&' then
      begin
        Inc(I);
        if Text[I] <> '&' then
          TextRange.startPosition := J;
        LText[J] := Text[I];
      end
      else
        LText[J] := Text[I];
      Inc(I);
      Inc(J);
    end;
    SetLength(LText, J-1);
  end
  else
    LText := Text;

  LRect := Rect;
  LRect.Right := Max(LRect.Left, LRect.Right);
  LRect.Bottom := Max(LRect.Bottom, LRect.Top);

  OleCheck(DWriteFactory.CreateTextLayout(PWideChar(LText), Length(LText), FFont.Handle,
    LRect.Right - LRect.Left, LRect.Bottom - LRect.Top, TextLayout));
  if TextLayout = nil then Exit;

  if TextRange.startPosition <> 0 then
  begin
    TextRange.startPosition := TextRange.startPosition - 1;
    TextRange.length := 1;
    TextLayout.SetUnderline(True, TextRange);
  end;

  if [tfPathEllipsis, tfEndEllipsis] * TextFormat <> [] then
  begin
    DWriteFactory.CreateEllipsisTrimmingSign(FFont.Handle, TrimmingSign);                                
    FillChar(TrimmingOptions, SizeOf(TrimmingOptions),0);
    if tfPathEllipsis in TextFormat then
    begin
      TrimmingOptions.delimiter := Ord('\');
      TrimmingOptions.delimiterCount := 1;
    end;
    TrimmingOptions.granularity := DWRITE_TRIMMING_GRANULARITY_CHARACTER;
    TextLayout.SetTrimming(TrimmingOptions, TrimmingSign);
  end;

  //Set Underline and Strike out
  TextRange.startPosition := 0;
  TextRange.length := Length(text);

  if fsUnderline in FFont.Style then
    TextLayout.SetUnderline(True, TextRange);

  if fsStrikeOut in FFont.Style then
    TextLayout.SetStrikethrough(True, TextRange);

  if tfCenter in TextFormat then
    TextLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_CENTER)
  else if tfRight in TextFormat then
    TextLayout.SetTextAlignment(DWRITE_TEXT_ALIGNMENT_TRAILING);

  if not (tfWordBreak in TextFormat) or (tfSingleLine in TextFormat) then
    TextLayout.SetWordWrapping(DWRITE_WORD_WRAPPING_NO_WRAP);

  if tfSingleLine in TextFormat then
  begin
    if tfVerticalCenter in TextFormat then
      TextLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_CENTER)
    else if tfBottom in TextFormat then
      TextLayout.SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT_FAR);
  end;

  if not (tfNoClip in TextFormat) then
    RenderTarget.PushAxisAlignedClip(LRect, D2D1_ANTIALIAS_MODE_PER_PRIMITIVE);
  try
    if FBrush.FStyle <> bsClear then
    begin
      TextLayout.GetClusterMetrics(nil, 0, Clusters);
      SetLength(ClusterMetrics, Clusters);
      TextLayout.GetClusterMetrics(@ClusterMetrics[0], Clusters, Clusters);
      TextLayout.GetLineMetrics(nil, 0, Lines);
      SetLength(LineMetrics, Lines);
      TextLayout.GetLineMetrics(@LineMetrics[0], Lines, Lines);
      StartCluster := 0;

      if [tfSingleLine, tfBottom] * TextFormat = [tfSingleLine, tfBottom] then
        BgRect.top := Rect.Bottom - LineMetrics[0].height
      else if [tfSingleLine, tfVerticalCenter] * TextFormat = [tfSingleLine, tfVerticalCenter] then
        BgRect.top := Rect.top + (Rect.Bottom - rect.Top - LineMetrics[0].height) / 2
      else
        BgRect.top := rect.Top;

      for I := 0 to Lines - 1 do
      begin
        BgRect.bottom := BgRect.top + LineMetrics[I].height;

        LineWidth := 0;
        for J := 0 to LineMetrics[I].length - 1 do
          LineWidth := LineWidth + ClusterMetrics[Integer(StartCluster)+J].width;

        if tfCenter in TextFormat then
        begin
          BgRect.left := Rect.Left+ (Rect.Right - Rect.Left - LineWidth) / 2;
          BgRect.right := Rect.Left+ (Rect.Right - Rect.Left - LineWidth) / 2 + LineWidth;
        end
        else if tfRight in TextFormat then
        begin
          BgRect.left := Rect.Right -LineWidth;
          BgRect.right := Rect.Right;
        end
        else
        begin
          BgRect.left := Rect.left;
          BgRect.right := Rect.left + LineWidth;
        end;

        RenderTarget.FillRectangle(BgRect, FBrush.Handle);

        StartCluster := StartCluster + LineMetrics[I].length;
        BgRect.top := BgRect.top + LineMetrics[i].height;
      end;
    end;

    RenderTarget.DrawTextLayout(D2D1PointF(Rect.Left - 0.5, Rect.Top - 0.5), TextLayout,
      FFont.FBrush.Handle, D2D1_DRAW_TEXT_OPTIONS_NONE);
  finally
    if not (tfNoClip in TextFormat) then
      RenderTarget.PopAxisAlignedClip;
  end;
end;

procedure TDirect2DCanvas.LineTo(X, Y: Integer);
begin
  RequiredState([csHandleValid, csPenValid]);
  FRenderTarget.DrawLine(
    D2D1PointF(FPenPos.X+0.5,FPenPos.Y+0.5), D2D1PointF(X+0.5,Y+0.5),
    FPen.FBrush.Handle, FPen.FWidth, FPen.FStrokeStyle);
  FPenPos := Point(X,Y);
end;

procedure TDirect2DCanvas.MoveTo(X, Y: Integer);
begin
  FPenPos := Point(X,Y);
end;

procedure TDirect2DCanvas.PolyBezierTo(const Points: array of TPoint);
var
  LPoints: array of TPoint;
  I: Integer;
begin
  SetLength(LPoints, Length(Points)+1);
  LPoints[0] := FPenPos;
  for I := 0 to Length(Points) - 1 do
    LPoints[I+1] := Points[I];
  PolyBezier(LPoints);
  FPenPos := Points[Length(Points)-1];
end;

procedure TDirect2DCanvas.Refresh;
var
  I: Integer;
begin
  FRenderTarget := nil;
  for I := 0 to FD2DObjects.Count - 1 do
    FD2DObjects[I].ReleaseHandle;
end;

// Invalid D2DCanvas operations
procedure TDirect2DCanvas.BrushCopy(const Dest: TRect; Bitmap: TBitmap;
    const Source: TRect; Color: TColor);
begin
  raise EInvalidOperation.Create(SInvalidCanvasOperation);
end;

procedure TDirect2DCanvas.DrawFocusRect(const Rect: TRect);
begin
  raise EInvalidOperation.Create(SInvalidCanvasOperation);
end;

procedure TDirect2DCanvas.FloodFill(X, Y: Integer; Color: TColor;
    FillStyle: TFillStyle);
begin
  raise EInvalidOperation.Create(SInvalidCanvasOperation);
end;

function TDirect2DCanvas.GetCanvasOrientation: TCanvasOrientation;
begin
  raise EInvalidOperation.Create(SInvalidCanvasOperation);
end;

function TDirect2DCanvas.GetClipRect: TRect;
begin
  raise EInvalidOperation.Create(SInvalidCanvasOperation);
end;

function TDirect2DCanvas.GetPixel(X, Y: Integer): TColor;
begin
  raise EInvalidOperation.Create(SInvalidCanvasOperation);
end;

procedure TDirect2DCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  raise EInvalidOperation.Create(SInvalidCanvasOperation);
end;

{ Singleton objects }

var
  SingletonD2DFactory: ID2D1Factory;

  function D2DFactory(factoryType: TD2D1FactoryType=D2D1_FACTORY_TYPE_SINGLE_THREADED;
  factoryOptions: PD2D1FactoryOptions=nil): ID2D1Factory;
var
  LD2DFactory: ID2D1Factory;
begin
  if SingletonD2DFactory = nil then
  begin
  D2D1CreateFactory(factoryType, IID_ID2D1Factory, factoryOptions, LD2DFactory);
  if InterlockedCompareExchangePointer(Pointer(SingletonD2DFactory), Pointer(LD2DFactory), nil) = nil then
    LD2DFactory._AddRef;
  end;
  Result := SingletonD2DFactory;
end;

var
  SingletonDWriteFactory: IDWriteFactory;

function DWriteFactory(factoryType: TDWriteFactoryType=DWRITE_FACTORY_TYPE_SHARED): IDWriteFactory;
var
  LDWriteFactory: IDWriteFactory;
begin
  if SingletonDWriteFactory = nil then
  begin
  DWriteCreateFactory(factoryType, IID_IDWriteFactory, IUnknown(LDWriteFactory));
  if InterlockedCompareExchangePointer(Pointer(SingletonDWriteFactory), Pointer(LDWriteFactory), nil) = nil then
    LDWriteFactory._AddRef;
  end;
  Result := SingletonDWriteFactory;
end;

function D2D1ColorF(const AColor: TColor): TD2D1ColorF; overload;
var
  RGB: Cardinal;
begin
  RGB := ColorToRGB(AColor);
  Result.r :=   RGB         and $FF  / 255;
  Result.g := ((RGB shr  8) and $FF) / 255;
  Result.b := ((RGB shr 16) and $FF) / 255;
  if AColor = clNone then
    Result.a := 0.0
  else
    Result.a :=  1.0;
end;

function D2D1ColorF(const AColor: TColor; Alpha: Single): TD2D1ColorF; overload;
begin
 Result := D2D1ColorF(AColor);
 Result.a := Alpha;
end;


end.
