unit unit1;

interface

uses
  Classes,  vg_forms, vg_scene,
  vg_objects, vg_controls, vg_ani, vg_colors, vg_listbox, vg_tabcontrol,
  vg_effects, vg_layouts, vg_textbox, vg_memo, vg_extctrls, vg_treeview,
  vg_grid, Controls;

type
  TForm1 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Text1: TvgText;
    FloatAnimation1: TvgFloatAnimation;
    Button1: TvgTextBox;
    Selection1: TvgSelection;
    StringListBox1: TvgStringListBox;
    Path1: TvgPath;
    GradientAnimation1: TvgGradientAnimation;
    StringComboBox1: TvgStringComboBox;
    TrackBar1: TvgTrackBar;
    HorzListBox1: TvgHorzListBox;
    ComboTrackBar1: TvgComboTrackBar;
    vgResources1: TvgResources;
    CheckBox2: TvgCheckBox;
    ComboColorBox1: TvgComboColorBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure ComboColorBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  Item: TvgListboxItem;
  R: TvgRectangle;
begin
  for i := 0 to 20 do
  begin
    Item := TvgListboxItem.Create(Self);
    Item.Parent := HorzListBox1;
    R := TvgRectangle.Create(Self);
    R.Parent := Item;
    R.Fill.Color := vgColorToStr($FF000000 or random($FFFFFF));
    R.Stroke.Style := vgBrushNone;
    R.HitTest := false;
    R.Padding.Rect := vgRect(4, 4, 4, 4);
    R.Align := vaClient;
  end;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
  if CheckBox2.IsChecked then
    vgScene1.Style := vgResources1
  else
    vgScene1.Style := nil;
end;

procedure TForm1.ComboColorBox1Change(Sender: TObject);
begin
  Root1.Fill.Style := vgBrushSolid;
  Root1.Fill.Color := ComboColorBox1.Color;
end;

end.
