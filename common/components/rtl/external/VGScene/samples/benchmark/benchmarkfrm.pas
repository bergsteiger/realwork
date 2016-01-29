unit benchmarkfrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_ani, vg_effects, vg_objects, vg_controls,
  ExtCtrls, MMSystem, AppEvnts, vg_listbox, vg_memo, vg_layouts;

type
  TfrmBenchmark = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Text1: TvgText;
    ShadowEffect1: TvgShadowEffect;
    FloatAnimation1: TvgFloatAnimation;
    CheckBox1: TvgCheckBox;
    Timer1: TTimer;
    ApplicationEvents1: TApplicationEvents;
    Button1: TvgButton;
    Selection1: TvgSelection;
    Rectangle1: TvgRectangle;
    FloatAnimation2: TvgFloatAnimation;
    StringListBox1: TvgStringListBox;
    Ellipse1: TvgEllipse;
    GlowEffect1: TvgGlowEffect;
    Memo1: TvgMemo;
    Path1: TvgPath;
    GradientAnimation1: TvgGradientAnimation;
    procedure Root1Paint(Sender: TObject; const Canvas: TvgCanvas;
      const ARect: TvgRect);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
  private
    { Private declarations }
    RenderCount: integer;
    Fps, RenderTime, StartTime, NewTime, Time: single;
  public
    { Public declarations }
  end;

var
  frmBenchmark: TfrmBenchmark;

implementation

{$R *.dfm}

type

  THackScene = class(TvgScene);

procedure TfrmBenchmark.FormCreate(Sender: TObject);
begin
  StartTime := {$IFDEF WIN32}timeGetTime;{$else}GetTickCount / 1000; {$endif}
end;

procedure TfrmBenchmark.Root1Paint(Sender: TObject;
  const Canvas: TvgCanvas; const ARect: TvgRect);
begin
  RenderCount := RenderCount + 1;
end;

procedure TfrmBenchmark.CheckBox1Change(Sender: TObject);
begin
  vgScene1.ShowUpdateRects := CheckBox1.IsChecked;
  if not vgScene1.ShowUpdateRects then
    vgScene1.AddUpdateRect(vgRect(0, 0, 2000, 2000));
end;

procedure TfrmBenchmark.Timer1Timer(Sender: TObject);
begin
  Caption := 'VGScene Benchmark ' + vgFloatToStr(Fps) + ' FPS';
end;

procedure TfrmBenchmark.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  Button1.RotateAngle := Button1.RotateAngle + 0.01;

  THackScene(vgScene1).Draw;

  NewTime := {$IFDEF WIN32}(timeGetTime - StartTime) / 1000;{$else}(GetTickCount / 1000) - StartTime; {$endif}
  RenderTime := RenderTime + (NewTime - Time);
  if RenderTime > 1 then
  begin
    Fps := RenderCount / RenderTime;
    RenderTime := 0;
    RenderCount := 0;
  end;
  Time := NewTime;

  Done := false;
end;

end.
