unit direct2dfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_controls, vg_objects, vg_ani, vg_textbox,
  vg_effects;

type
  TfrmD2D = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Rectangle1: TvgRectangle;
    Rectangle2: TvgRectangle;
    FloatAnimation1: TvgFloatAnimation;
    FloatAnimation2: TvgFloatAnimation;
    Ellipse1: TvgEllipse;
    Text1: TvgText;
    Image1: TvgImage;
    Path1: TvgPath;
    GlowEffect1: TvgGlowEffect;
    Text2: TvgText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmD2D: TfrmD2D;

implementation

{$R *.dfm}

initialization
  UseDirect2DCanvas;
end.
