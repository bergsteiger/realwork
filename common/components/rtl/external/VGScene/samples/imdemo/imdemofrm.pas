unit imdemofrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_effects, vg_objects, vg_layouts, vg_controls,
  vg_listbox;

type
  TfrmIM = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgLayout;
    back: TvgRectangle;
    Rectangle1: TvgRectangle;
    title: TvgLayout;
    Path1: TvgPath;
    Rectangle2: TvgRectangle;
    SizeGrip1: TvgSizeGrip;
    avatar: TvgRectangle;
    Image1: TvgImage;
    ShadowEffect1: TvgShadowEffect;
    Text1: TvgText;
    statusBox: TvgPopupBox;
    backShadow: TvgShadowEffect;
    Text2: TvgText;
    SpeedButton1: TvgSpeedButton;
    SpeedButton2: TvgSpeedButton;
    SpeedButton3: TvgSpeedButton;
    ListBox1: TvgListBox;
    Layout1: TvgLayout;
    tempItem: TvgListBoxItem;
    Image2: TvgImage;
    Text3: TvgText;
    Rectangle3: TvgRectangle;
    Text4: TvgText;
    list: TvgRectangle;
    vgResources1: TvgResources;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIM: TfrmIM;

implementation

uses vg_dsgn;

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

procedure TfrmIM.SpeedButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmIM.FormCreate(Sender: TObject);
var
  i: integer;
  Item: TvgListBoxItem;
begin
  { create items }
  for i := 0 to 20 do
  begin
    Item := TvgListBoxItem(tempItem.Clone(Self));
    Item.Parent := ListBox1;
    Item.Binding['name'] := LowerCase(Names[random(Length(Names))]);
    Item.Binding['text'] := 'I''m on SMS';
  end;
end;

procedure TfrmIM.SpeedButton3Click(Sender: TObject);
begin
  { change back fill }
  ShowBrushDialog(back.Fill, [vgBrushSolid, vgBrushGradient, vgBrushBitmap], false);
end;

end.
