unit creditsfrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_objects, vg_layouts, vg_scene, ExtCtrls, vg_ani, vg_controls,
  vg_effects;

type
  TForm13 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    AniLayout: TvgLayout;
    Text1: TvgText;
    textList: TvgText;
    CreditsTimer: TTimer;
    Slide: TvgFloatAnimation;
    LogoImage: TvgImage;
    Rectangle2: TvgRectangle;
    Rectangle1: TvgRectangle;
    Rectangle3: TvgRectangle;
    Button1: TvgButton;
    vgResources1: TvgResources;
    Button2: TvgButton;
    FirstLayout: TvgLayout;
    Text2: TvgText;
    Text3: TvgText;
    GlowEffect1: TvgGlowEffect;
    procedure FormCreate(Sender: TObject);
    procedure CreditsTimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

const
  Names: array [0..39] of string = (
   'Jacob',
   'Emily',
   'Michael',
   'Isabella',
   'Ethan',
   'Emma',
   'Joshua',
   'Ava',
   'Daniel',
   'Madison',
   'Christopher',
   'Sophia',
   'Anthony',
   'Olivia',
   'William',
   'Abigail',
   'Matthew',
   'Hannah',
   'Andrew',
   'Elizabeth',
   'Alexander',
   'Addison',
   'David',
   'Samantha',
   'Joseph',
   'Ashley',
   'Noah',
   'Alyssa',
   'James',
   'Mia',
   'Ryan',
   'Chloe',
   'Logan',
   'Natalie',
   'Jayden',
   'Sarah',
   'John',
   'Alexis',
   'Nicholas',
   'Grace');
   
procedure TForm13.FormCreate(Sender: TObject);
var
  i: integer;
begin
  { Add random Names }
  textList.Text := '';
  for i := 0 to 50 do
    textList.Text := textList.Text + Names[random(Length(Names))] + ' ' + Names[random(Length(Names))] + #10#13;
end;

procedure TForm13.CreditsTimerTimer(Sender: TObject);
begin
  // Start animation with some delay
  CreditsTimer.Enabled := false;
  // Start Animation
  Slide.StartFromCurrent := true;
  Slide.StopValue := -AniLayout.Height;
  Slide.Start;
end;

procedure TForm13.Button1Click(Sender: TObject);
begin
  // Scale Image
  LogoImage.AnimateFloat('Scale.X', 0.5, 0.2);
  LogoImage.AnimateFloat('Scale.Y', 0.5, 0.2);
  // Fade hide animation
  FirstLayout.AnimateFloatWait('Opacity', 0, 0.4);
  // Hide
  FirstLayout.Visible := false;
  // Show Layout
  AniLayout.Visible := true;
  AniLayout.Opacity := 0;
  // Fade Show
  AniLayout.AnimateFloatWait('Opacity', 1, 0.6);
  // Show Timer
  CreditsTimer.Enabled := true;
end;

procedure TForm13.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
