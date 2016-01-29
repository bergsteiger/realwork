unit aniform;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, vg_objects, vg_controls, vg_scene, vg_ani;

type
  TForm4 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Ellipse1: TvgEllipse;
    FloatAnimation1: TvgFloatAnimation;
    Rectangle1: TvgRectangle;
    Text1: TvgText;
    ColorAnimation1: TvgColorAnimation;
    Text2: TvgText;
    Rectangle2: TvgRectangle;
    Text3: TvgText;
    FloatAnimation2: TvgFloatAnimation;
    Image1: TvgImage;
    BitmapAnimation1: TvgBitmapAnimation;
    Text4: TvgText;
    Rectangle3: TvgRectangle;
    FloatAnimation4: TvgFloatAnimation;
    Text5: TvgText;
    AniIndicator1: TvgAniIndicator;
    Label1: TvgLabel;
    AniIndicator2: TvgAniIndicator;
    AniIndicator3: TvgAniIndicator;
    RoundRect1: TvgRoundRect;
    PathAnimation1: TvgPathAnimation;
    Text6: TvgText;
    Path1: TvgPath;
    Text7: TvgText;
    PathAnimation2: TvgPathAnimation;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

end.
