unit layerfrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_controls, vg_layouts, vg_objects, vg_effects,
  vg_textbox, ComCtrls;

type
  TfrmLayered = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Image1: TvgImage;
    Rectangle1: TvgRectangle;
    Text1: TvgText;
    GlowEffect1: TvgGlowEffect;
    Text2: TvgText;
    Ellipse1: TvgEllipse;
    GlowEffect2: TvgGlowEffect;
    RoundRect1: TvgRoundRect;
    RoundRect2: TvgRoundRect;
    TrackBar1: TvgTrackBar;
    Selection1: TvgSelection;
    Rectangle2: TvgRectangle;
    Layout1: TvgLayout;
    Text3: TvgText;
    AniIndicator1: TvgAniIndicator;
    TextBox1: TvgTextBox;
    HudCloseButton1: TvgHudCloseButton;
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLayered: TfrmLayered;

implementation

{$R *.dfm}

procedure TfrmLayered.TrackBar1Change(Sender: TObject);
begin
  Image1.Opacity := TrackBar1.Value;
  Ellipse1.Opacity := TrackBar1.Value;
end;

end.
