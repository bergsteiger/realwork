unit clockfrm;

interface

uses
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  {$IFDEF DARWIN}
  MacOSAll, CarbonPrivate,
  {$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_effects, vg_objects, vg_layouts, vg_ani, 
  Math, ExtCtrls;

type
  TForm7 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgLayout;
    clockFace: TvgEllipse;
    Ellipse2: TvgEllipse;
    Ellipse3: TvgEllipse;
    Rectangle1: TvgRectangle;
    dayText: TvgText;
    clockShadow: TvgShadowEffect;
    Ellipse4: TvgEllipse;
    secondArrow: TvgPath;
    FloatAnimation1: TvgFloatAnimation;
    FloatAnimation2: TvgFloatAnimation;
    Path2: TvgPath;
    btnClose: TvgEllipse;
    Layout1: TvgLayout;
    clockLayout: TvgLayout;
    Timer1: TTimer;
    minutArrow: TvgRectangle;
    hourArrow: TvgRectangle;
    Ellipse1: TvgEllipse;
    Ellipse5: TvgEllipse;
    Ellipse6: TvgEllipse;
    Ellipse7: TvgEllipse;
    Ellipse8: TvgEllipse;
    Ellipse9: TvgEllipse;
    Text1: TvgText;
    Text2: TvgText;
    Text3: TvgText;
    Text4: TvgText;
    btnRotate: TvgEllipse;
    btnScale: TvgEllipse;
    procedure btnCloseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnRotateMouseMove(Sender: TObject; Shift: TShiftState; X, Y,
      Dx, Dy: Single);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnScaleMouseMove(Sender: TObject; Shift: TShiftState; X, Y,
      Dx, Dy: Single);
    procedure btnScaleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnRotateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.btnCloseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Close;
end;

procedure TForm7.btnRotateMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  btnRotate.AutoCapture := true;
end;

procedure TForm7.btnRotateMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y, Dx, Dy: Single);
var
  P: TvgPoint;
  V, V1: TvgVector;
begin
  if ssLeft in Shift then
  begin
    P := btnRotate.LocalToAbsolute(vgPoint(X, Y));
    V := vgVector(10 - (ClientWidth / 2), 10 - (ClientHeight / 2));
    V1 := vgVector(P.X - (ClientWidth / 2), P.Y - (ClientHeight / 2));
    if vgVectorCrossProductZ(V1, V) > 0 then
      clockLayout.RotateAngle := -vgRadToDeg(ArcCos(vgVectorAngleCosine(V1, V)))
    else
      clockLayout.RotateAngle := vgRadToDeg(ArcCos(vgVectorAngleCosine(V1, V)));
    vgScene1.UpdateBuffer;
  end;
end;

procedure TForm7.Timer1Timer(Sender: TObject);
var
  H, M, S, MS: word;
begin
  { set times }
  DecodeTime(Now, H, M, S, MS);
  secondArrow.RotateAngle := 360 * (S / 60) + (6 * (MS / 1000));
  minutArrow.RotateAngle := 360 * (M / 60);
  hourArrow.RotateAngle := 360 * ((H mod 12) / 12);
  DecodeDate(Now, H, M, S);
  dayText.Text := IntToStr(S); 
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  {$IFDEF DARWIN}
  // disable Mac OS X shadow
  ChangeWindowAttributes(TCarbonWindow(Handle).Window, kWindowNoShadowAttribute, kWindowNoAttributes);
  {$ENDIF}
  Timer1Timer(Self);
end;

procedure TForm7.btnScaleMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  btnScale.AutoCapture := true;
end;

procedure TForm7.btnScaleMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y, Dx, Dy: Single);
var
  P: TvgPoint;
  scale: single;
begin
  if ssLeft in Shift then
  begin
    P := btnScale.LocalToAbsolute(vgPoint(X, Y));
    scale := (P.Y) / 175;
    if scale < 0.5 then scale := 0.5;
    if scale > 1.5 then scale := 1.5;
    clockLayout.Scale.Point := vgPoint(scale, scale);
    vgScene1.UpdateBuffer;
  end;
end;

end.
