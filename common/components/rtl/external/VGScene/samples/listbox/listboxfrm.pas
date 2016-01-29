unit listboxfrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_listbox, vg_layouts, vg_controls, vg_tabcontrol,
  vg_objects, vg_extctrls;

type
  TfrmListBoxDemo = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    TabControl1: TvgTabControl;
    TabItem1: TvgTabItem;
    Layout1: TvgLayout;
    StringListBox1: TvgStringListBox;
    TrackBar1: TvgTrackBar;
    TabItem2: TvgTabItem;
    Layout2: TvgLayout;
    HorzListBox1: TvgHorzListBox;
    Layout3: TvgLayout;
    Splitter1: TvgSplitter;
    Label1: TvgLabel;
    Label2: TvgLabel;
    TrackBar2: TvgTrackBar;
    TrackBar3: TvgTrackBar;
    Label3: TvgLabel;
    Label4: TvgLabel;
    Layout4: TvgLayout;
    ListBox1: TvgListBox;
    HorzListBox2: TvgHorzListBox;
    Splitter2: TvgSplitter;
    TabItem3: TvgTabItem;
    Layout5: TvgLayout;
    ImageListBox1: TvgImageListBox;
    Button1: TvgButton;
    OpenPictureDialog1: TOpenDialog;
    TrackBar4: TvgTrackBar;
    CheckBox1: TvgCheckBox;
    TabItem4: TvgTabItem;
    Layout6: TvgLayout;
    StringListBox2: TvgStringListBox;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListBoxDemo: TfrmListBoxDemo;

implementation

{$R *.dfm}

procedure TfrmListBoxDemo.FormCreate(Sender: TObject);
var
  i: integer;
  Item: TvgListboxItem;
begin
  StringListBox1.BeginUpdate;
  for i := 0 to 200 do
    StringListBox1.Items.add('Item ' + IntToStr(i));
  StringListBox1.EndUpdate;

  HorzListBox1.BeginUpdate;
  for i := 0 to 200 do
  begin
    Item := TvgListboxItem.Create(Self);
    with Item do
    begin
      Parent := HorzListBox1;
      Width := 48;
    end;
    with TvgRectangle.Create(Self) do
    begin
      Parent := Item;
      Padding.Rect := vgRect(5,5,5,5);
      xRadius := 4;
      yRadius := 4;
      Opacity := 0.5;
      HitTest := false;
      Align := vaClient;
    end;
  end;
  HorzListBox1.EndUpdate;

  HorzListBox2.BeginUpdate;
  for i := 0 to 60 do
  begin
    Item := TvgListboxItem.Create(Self);
    with Item do
    begin
      Parent := HorzListBox2;
      Width := 48;
    end;
    with TvgRectangle.Create(Self) do
    begin
      Parent := Item;
      Padding.Rect := vgRect(5,5,5,5);
      xRadius := 4;
      yRadius := 4;
      Opacity := 0.5;
      HitTest := false;
      Align := vaClient;
    end;
  end;
  HorzListBox2.EndUpdate;

  ListBox1.BeginUpdate;
  for i := 0 to 60 do
  begin
    Item := TvgListboxItem.Create(Self);
    with Item do
    begin
      Parent := ListBox1;
    end;
    with TvgRectangle.Create(Self) do
    begin
      Parent := Item;
      Padding.Rect := vgRect(5,5,5,5);
      xRadius := 4;
      yRadius := 4;
      Opacity := 0.5;
      HitTest := false;
      Align := vaClient;
    end;
  end;
  ListBox1.EndUpdate;
end;

procedure TfrmListBoxDemo.TrackBar1Change(Sender: TObject);
begin
  StringListBox1.Columns := Round(TrackBar1.Value);
  HorzListBox1.Columns := Round(TrackBar1.Value);
end;

procedure TfrmListBoxDemo.TrackBar2Change(Sender: TObject);
begin
  ListBox1.ItemWidth := Round(TrackBar2.Value);
  HorzListBox2.ItemWidth := Round(TrackBar2.Value);
end;

procedure TfrmListBoxDemo.TrackBar3Change(Sender: TObject);
begin
  ListBox1.ItemHeight := Round(TrackBar3.Value);
  HorzListBox2.ItemHeight := Round(TrackBar3.Value);
end;

procedure TfrmListBoxDemo.Button1Click(Sender: TObject);
var
  Dir: string;
begin
  { add folder }
  OpenPictureDialog1.Filter := 'Image files|' + DefaultFilterClass.GetFileTypes;
  if OpenPictureDialog1.Execute then
  begin
    Dir := ExtractFilePath(OpenPictureDialog1.FileName);
    ImageListBox1.AddFolder(Dir);
  end;
end;

procedure TfrmListBoxDemo.TrackBar4Change(Sender: TObject);
begin
  ImageListBox1.BeginUpdate;
  ImageListBox1.ItemHeight := Round(TrackBar4.Value);
  ImageListBox1.ItemWidth := Round(TrackBar4.Value);
  ImageListBox1.EndUpdate;
end;

procedure TfrmListBoxDemo.CheckBox1Change(Sender: TObject);
begin
  StringListBox1.MouseTracking := CheckBox1.IsChecked;
  HorzListBox1.MouseTracking := CheckBox1.IsChecked;
end;

end.
