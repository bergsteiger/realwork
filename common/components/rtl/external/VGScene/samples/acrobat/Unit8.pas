unit Unit8;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_effects, vg_layouts, vg_ani,
  vg_controls;

type
  TForm8 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Rectangle1: TvgRectangle;
    Rectangle2: TvgRectangle;
    Rectangle3: TvgRectangle;
    Image1: TvgImage;
    Text1: TvgText;
    Text2: TvgText;
    Layout1: TvgLayout;
    Layout2: TvgLayout;
    Layout3: TvgLayout;
    Rectangle5: TvgRectangle;
    Text3: TvgText;
    Text4: TvgText;
    Text5: TvgText;
    Text6: TvgText;
    vgResources1: TvgResources;
    redBtn: TvgBitmapButton;
    greenBtn: TvgBitmapButton;
    blueBtn: TvgBitmapButton;
    yellowBtn: TvgBitmapButton;
    greenPaddingOut: TvgRectAnimation;
    Container: TvgLayout;
    greenWidthOut: TvgFloatAnimation;
    containerOut: TvgFloatAnimation;
    greenWnd: TvgRectangle;
    redPaddingOut: TvgRectAnimation;
    redWidthOut: TvgFloatAnimation;
    redWnd: TvgRectangle;
    blueWnd: TvgRectangle;
    yellowWnd: TvgRectangle;
    bluePaddingOut: TvgRectAnimation;
    blueWidthOut: TvgFloatAnimation;
    yellowPaddingOut: TvgRectAnimation;
    yellowWidthOut: TvgFloatAnimation;
    procedure greenBtnClick(Sender: TObject);
    procedure greenPaddingOutFinish(Sender: TObject);
    procedure redBtnClick(Sender: TObject);
    procedure redPaddingOutFinish(Sender: TObject);
    procedure blueBtnClick(Sender: TObject);
    procedure bluePaddingOutFinish(Sender: TObject);
    procedure yellowBtnClick(Sender: TObject);
    procedure yellowPaddingOutFinish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Reset;
  end;

var
  Form8: TForm8;

implementation

uses vg_dsgn, shellapi;

{$R *.dfm}

procedure TForm8.Reset;
begin
  greenWnd.Visible := false;
  greenBtn.Width := 110;
  greenBtn.Padding.Rect := vgRect(0, 0, 0, 0);

  redWnd.Visible := false;
  redBtn.Width := 110;
  redBtn.Padding.Rect := vgRect(0, 0, 0, 0);

  blueWnd.Visible := false;
  blueBtn.Width := 110;
  blueBtn.Padding.Rect := vgRect(0, 0, 0, 0);

  yellowWnd.Visible := false;
  yellowBtn.Width := 110;
  yellowBtn.Padding.Rect := vgRect(0, 0, 0, 0);

  Container.Width := 450;
end;

procedure TForm8.greenBtnClick(Sender: TObject);
begin
  Reset;

  greenPaddingOut.Start;
  greenWidthOut.Start;

  containerOut.Start;
end;

procedure TForm8.greenPaddingOutFinish(Sender: TObject);
begin
  greenWnd.Visible := true;
  greenWnd.Opacity := 0;
  greenWnd.AnimateFloat('Opacity', 1, 0.2);
end;

procedure TForm8.redBtnClick(Sender: TObject);
begin
  Reset;

  redPaddingOut.Start;
  redWidthOut.Start;

  containerOut.Start;
end;

procedure TForm8.redPaddingOutFinish(Sender: TObject);
begin
  redWnd.Visible := true;
  redWnd.Opacity := 0;
  redWnd.AnimateFloat('Opacity', 1, 0.2);
end;

procedure TForm8.blueBtnClick(Sender: TObject);
begin
  Reset;

  bluePaddingOut.Start;
  blueWidthOut.Start;

  containerOut.Start;
end;

procedure TForm8.bluePaddingOutFinish(Sender: TObject);
begin
  blueWnd.Visible := true;
  blueWnd.Opacity := 0;
  blueWnd.AnimateFloat('Opacity', 1, 0.2);
end;

procedure TForm8.yellowBtnClick(Sender: TObject);
begin
  Reset;

  yellowPaddingOut.Start;
  yellowWidthOut.Start;

  containerOut.Start;
end;

procedure TForm8.yellowPaddingOutFinish(Sender: TObject);
begin
  yellowWnd.Visible := true;
  yellowWnd.Opacity := 0;
  yellowWnd.AnimateFloat('Opacity', 1, 0.2);
end;

end.
