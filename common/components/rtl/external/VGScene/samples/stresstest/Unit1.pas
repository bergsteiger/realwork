unit Unit1;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_layouts, vg_objects, vg_controls, vg_effects, 
  ExtCtrls, vg_ani;

type
  TForm1 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    ScrollBox1: TvgScrollBox;
    SizeGrip1: TvgSizeGrip;
    Selection1: TvgSelection;
    Rectangle1: TvgRectangle;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FileList: TStrings;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TvgHackScrollBox = class(TvgScrollbox);

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j: integer;
  R: TvgRectangle;
begin
  ScrollBox1.BeginUpdate;
  for i := 0 to 99 do
    for j := 0 to 99 do
    begin
      R := TvgRectangle.Create(nil);
      with R do
      begin
        parent := ScrollBox1;
        setBounds(i * 40 + 2, j * 40 + 2, 36, 36);
        fill.SolidColor := ((50 + random(205)) shl 24) or random($FFFFFF);
        stroke.style := vgBrushnone;
        hitTest := false;
      end;
    end;
  ScrollBox1.EndUpdate;
end;

end.
