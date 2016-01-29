unit codeanifrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_controls, vg_scene, vg_objects, vg_layouts;

type
  TfrmAniCode = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Panel1: TvgPanel;
    Container: TvgLayout;
    Rectangle1: TvgRectangle;
    Rectangle4: TvgRectangle;
    Rectangle2: TvgRectangle;
    Rectangle5: TvgRectangle;
    Rectangle6: TvgRectangle;
    Rectangle7: TvgRectangle;
    Rectangle9: TvgRectangle;
    Rectangle11: TvgRectangle;
    radioVert: TvgRadioButton;
    radioHorz: TvgRadioButton;
    radioGrid: TvgRadioButton;
    Button1: TvgButton;
    Button2: TvgButton;
    procedure FormCreate(Sender: TObject);
    procedure radioVertChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure LayoutItem(Item: TvgVisualObject; Animate: boolean = true);
    { Private declarations }
  public
    { Public declarations }
    procedure Layout;
  end;

var
  frmAniCode: TfrmAniCode;

implementation

{$R *.dfm}

var
  LayoutStyle: integer = 0;

procedure TfrmAniCode.LayoutItem(Item: TvgVisualObject; Animate: boolean = true);
var
  Pos: TvgPoint;
begin
  if radioVert.IsChecked then
    Pos := vgPoint(Container.Width / 2, Item.Index * 60);
  if radioHorz.IsChecked then
    Pos := vgPoint(Item.Index * 60, Container.Height / 2);
  if radioGrid.IsChecked then
    Pos := vgPoint((Item.Index mod 4) * 60, (Item.Index div 4) * 60);

  if Animate then
  begin
    Item.AnimateFloat('Position.X', Pos.X, 0.5);
    Item.AnimateFloat('Position.Y', Pos.Y, 0.5);
  end
  else
    Item.Position.Point := Pos;
end;

procedure TfrmAniCode.Layout;
var
  i: integer;
begin
  for i := 0 to Container.ChildrenCount - 1 do
    LayoutItem(Container.Children[i].Visual);
end;

procedure TfrmAniCode.FormCreate(Sender: TObject);
begin
  Layout;
end;

procedure TfrmAniCode.radioVertChange(Sender: TObject);
begin
  Layout;
end;

procedure TfrmAniCode.Button1Click(Sender: TObject);
var
  Item: TvgRectangle;
begin
  Item := TvgRectangle.Create(Self);
  Item.Parent := Container;
  Item.Opacity := 0; // Make object transparent
  LayoutItem(Item, false); // Layout
  Item.AnimateFloat('Opacity', 1, 0.5); // Animate opacity
end;

procedure TfrmAniCode.Button2Click(Sender: TObject);
begin
  Button2.Enabled := false;
  if Container.ChildrenCount > 0 then
    with Container.Children[Container.ChildrenCount - 1].Visual do // Visual is a just replace of TvgVisualObject()
    begin
      AnimateFloatWait('Opacity', 0, 0.5); // Wait when animation finished
      Free; // Then free object
    end;
  Button2.Enabled := true
end;

end.
