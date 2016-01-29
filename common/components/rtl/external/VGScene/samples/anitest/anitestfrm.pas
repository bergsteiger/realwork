unit anitestfrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_listbox, vg_controls, vg_extctrls, vg_scene,
  vg_layouts, vg_ani, vg_objects;

type
  TForm19 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    PlotGrid1: TvgPlotGrid;
    Label1: TvgLabel;
    aniBox: TvgStringListBox;
    Label2: TvgLabel;
    intBox: TvgStringListBox;
    PlotSize: TvgLayout;
    Button1: TvgButton;
    Ellipse1: TvgEllipse;
    testAni: TvgFloatAnimation;
    vgResources1: TvgResources;
    procedure PlotGrid1Paint(Sender: TObject; const Canvas: TvgCanvas;
      const ARect: TvgRect);
    procedure intBoxChange(Sender: TObject);
    procedure aniBoxChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation

{$R *.dfm}

procedure TForm19.PlotGrid1Paint(Sender: TObject; const Canvas: TvgCanvas;
  const ARect: TvgRect);
var
  i: integer;
  P: TvgPolygon;
  x, y: double;
begin
  SetLength(P, 200);
  for i := 0 to High(P) do
  begin
    // calc only in PlotGrid area
    x := ((i / High(P)) * PlotSize.Width);
    // formula here
    case TvgInterpolationType(intBox.ItemIndex) of
      vgInterpolationLinear: y := vgInterpolateLinear(x, 0, PlotSize.Height, PlotSize.Width);
      vgInterpolationQuadratic: y := vgInterpolateQuad(x, 0, PlotSize.Height, PlotSize.Width, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationCubic: y := vgInterpolateCubic(x, 0, PlotSize.Height, PlotSize.Width, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationQuartic: y := vgInterpolateQuart(x, 0, PlotSize.Height, PlotSize.Width, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationQuintic: y := vgInterpolateQuint(x, 0, PlotSize.Height, PlotSize.Width, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationSinusoidal: y := vgInterpolateSine(x, 0, PlotSize.Height, PlotSize.Width, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationExponential: y := vgInterpolateExpo(x, 0, PlotSize.Height, PlotSize.Width, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationCircular: y := vgInterpolateCirc(x, 0, PlotSize.Height, PlotSize.Width, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationElastic: y := vgInterpolateElastic(x, 0, PlotSize.Height, PlotSize.Width, 0, 0, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationBack: y := vgInterpolateBack(x, 0, PlotSize.Height, PlotSize.Width, 0, TvgAnimationType(aniBox.ItemIndex));
      vgInterpolationBounce: y := vgInterpolateBounce(x, 0, PlotSize.Height, PlotSize.Width, TvgAnimationType(aniBox.ItemIndex));
    end;
    //
    P[i] := vgPoint(PlotSize.Position.X + x, PlotSize.Position.Y + y);
  end;
  Canvas.Stroke.Style := vgBrushSolid;
  Canvas.StrokeThickness := 2;
  Canvas.Stroke.Color := '#FFFF0000';
  Canvas.DrawPolygon(P, 1);
end;

procedure TForm19.intBoxChange(Sender: TObject);
begin
  PlotGrid1.Repaint;
end;

procedure TForm19.aniBoxChange(Sender: TObject);
begin
  PlotGrid1.Repaint;
end;

procedure TForm19.Button1Click(Sender: TObject);
begin
  testAni.AnimationType := TvgAnimationType(aniBox.ItemIndex);
  testAni.Interpolation := TvgInterpolationType(intBox.ItemIndex);
  testAni.Start;
end;

end.
