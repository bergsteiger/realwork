unit effectsfrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, StdCtrls, vg_ani, vg_effects,
  vg_controls, vg_layouts, vg_listbox;

type
  TfrmEffects = class(TForm)
    vgScene1: TvgScene;
    VectorImageRoot: TvgBackground;
    StylesList: TvgListBox;
    Text1: TvgText;
    ListBoxItem1: TvgListBoxItem;
    ListBoxItem2: TvgListBoxItem;
    Rectangle1: TvgRectangle;
    Layout1: TvgLayout;
    Text2: TvgText;
    Track1: TvgTrackBar;
    StyleControls: TvgLayout;
    Text3: TvgText;
    Text4: TvgText;
    textOpacity: TvgText;
    Track2: TvgTrackBar;
    ListBoxItem3: TvgListBoxItem;
    Text6: TvgText;
    Rectangle2: TvgRectangle;
    Text7: TvgText;
    Text8: TvgText;
    Track3: TvgTrackBar;
    ShadowEffect1: TvgShadowEffect;
    BlurEffect1: TvgBlurEffect;
    GlowEffect1: TvgGlowEffect;
    textDirection: TvgText;
    trackDirection: TvgTrackBar;
    ColorAnimation1: TvgColorAnimation;
    ColorAnimation2: TvgColorAnimation;
    Rectangle3: TvgRectangle;
    Text9: TvgText;
    GlowEffect2: TvgGlowEffect;
    ListBoxItem4: TvgListBoxItem;
    Text10: TvgText;
    BevelEffect1: TvgBevelEffect;
    Image1: TvgImage;
    ReflectionEffect1: TvgReflectionEffect;
    Text5: TvgText;
    Text11: TvgText;
    ReflectionEffect2: TvgReflectionEffect;
    Text12: TvgText;
    Text13: TvgText;
    Text14: TvgText;
    Text15: TvgText;
    Path1: TvgPath;
    Text16: TvgText;
    BevelEffect2: TvgBevelEffect;
    RoundRect1: TvgRoundRect;
    InnerGlowEffect1: TvgInnerGlowEffect;
    Text17: TvgText;
    procedure StylesListChange(Sender: TObject);
    procedure Track1Change(Sender: TObject);
    procedure Track2Change(Sender: TObject);
    procedure Track3Change(Sender: TObject);
    procedure trackDirectionChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEffects: TfrmEffects;

implementation

{$R *.dfm}

procedure TfrmEffects.StylesListChange(Sender: TObject);
begin
  ShadowEffect1.Enabled := false;
  GlowEffect1.Enabled := false;
  BlurEffect1.Enabled := false;
  BevelEffect1.Enabled := false;

  case StylesList.ItemIndex of
    0: ShadowEffect1.Enabled := true;
    1: GlowEffect1.Enabled := true;
    2: BlurEffect1.Enabled := true;
    3: BevelEffect1.Enabled := true;
  end;

  textDirection.Visible := ShadowEffect1.Enabled or BevelEffect1.Enabled;
  trackDirection.Visible := ShadowEffect1.Enabled or BevelEffect1.Enabled;
end;

procedure TfrmEffects.Track1Change(Sender: TObject);
begin
  StyleControls.Scale.Point := vgPoint(Track1.Value, Track1.Value);
end;

procedure TfrmEffects.Track2Change(Sender: TObject);
begin
  StyleControls.Opacity := Track2.Value;
end;

procedure TfrmEffects.Track3Change(Sender: TObject);
begin
  case StylesList.ItemIndex of
    0: ShadowEffect1.Softness := Track3.Value;
    1: GlowEffect1.Softness := Track3.Value;
    2: BlurEffect1.Softness := Track3.Value;
    3: BevelEffect1.Size := Trunc(Track3.Value * 20);
  end;
  InnerGlowEffect1.Softness := Track3.Value;
end;

procedure TfrmEffects.trackDirectionChange(Sender: TObject);
begin
  ShadowEffect1.Direction := trackDirection.Value;
  BevelEffect1.Direction := trackDirection.Value;
  BevelEffect2.Direction := trackDirection.Value;
end;

end.
