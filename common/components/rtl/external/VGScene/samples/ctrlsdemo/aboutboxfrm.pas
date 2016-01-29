unit aboutboxfrm;

interface

uses
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_effects, ExtCtrls, vg_controls,
  vg_ani, StdCtrls, vg_layouts;

type

  TfrmAbout = class(TForm)
    VGScene: TvgScene;
    Layout1: TvgLayout;
    Root: TvgRectangle;
    ShadowEffect1: TvgShadowEffect;
    Rectangle2: TvgRectangle;
    ext1: TvgText;
    ext2: TvgText;
    Rectangle3: TvgRectangle;
    ProductKey: TvgText;
    imageLayout: TvgLayout;
    Rectangle4: TvgRectangle;
    ext4: TvgText;
    Timer1: TTimer;
    Button1: TvgButton;
    ColorAnimation1: TvgColorAnimation;
    ColorAnimation2: TvgColorAnimation;
    Image1: TvgImage;
    Rectangle5: TvgRectangle;
    Rectangle6: TvgRectangle;
    TitleText: TvgText;
    ShadowEffect2: TvgShadowEffect;
    Button2: TvgButton;
    Rectangle7: TvgRectangle;
    ColorAnimation3: TvgColorAnimation;
    ColorAnimation4: TvgColorAnimation;
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.Timer1Timer(Sender: TObject);
begin
  ProductKey.Text := Format('%d-%d-%d-%d', [Random($FFFF), Random($FFFF), Random($FFFF), Random($FFFF)]);
end;

procedure TfrmAbout.Button2Click(Sender: TObject);
begin
  TitleText.Text := 'It''s cool !';
end;

procedure TfrmAbout.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
