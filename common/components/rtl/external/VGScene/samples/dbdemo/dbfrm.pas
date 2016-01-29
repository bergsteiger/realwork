unit dbfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, vg_layouts, vg_dbctrls, vg_controls, vg_scene,
  vg_objects, DBCtrls, ExtCtrls, vg_textbox, vg_listbox;

type
  TfrmDB = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    vgResources1: TvgResources;
    ToolBar1: TvgToolBar;
    DBNavigator1: TvgDBNavigator;
    DataSource1: TDataSource;
    Table1: TTable;
    Panel1: TvgPanel;
    DBImage1: TvgDBImage;
    SpeedButton1: TvgSpeedButton;
    OpenDialog2: TOpenDialog;
    DBLabel1: TvgDBLabel;
    DBTextBox1: TvgDBTextBox;
    DBTextBox2: TvgDBTextBox;
    Label2: TvgLabel;
    Label3: TvgLabel;
    Label4: TvgLabel;
    TrackBar1: TvgTrackBar;
    CheckBox1: TvgCheckBox;
    CheckBox2: TvgCheckBox;
    CheckBox3: TvgCheckBox;
    CheckBox4: TvgCheckBox;
    cornerList: TvgHorzListBox;
    Button1: TvgButton;
    vgResources2: TvgResources;
    procedure SpeedButton1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure cornerListChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDB: TfrmDB;

implementation

{$R *.dfm}

procedure TfrmDB.SpeedButton1Click(Sender: TObject);
begin
  OpenDialog2.Filter := DefaultFilterClass.GetFileTypes;
  if OpenDialog2.Execute then
  begin
    DBImage1.Bitmap.LoadFromFile(OpenDialog2.FileName);
  end;
end;

procedure TfrmDB.TrackBar1Change(Sender: TObject);
begin
  DBNavigator1.xRadius := TrackBar1.Value;
  DBNavigator1.yRadius := TrackBar1.Value;
end;

procedure TfrmDB.CheckBox1Change(Sender: TObject);
begin
  DBNavigator1.Corners := [];
  if CheckBox1.IsChecked then
    DBNavigator1.Corners := DBNavigator1.Corners + [vgCornerBottomRight];
  if CheckBox2.IsChecked then
    DBNavigator1.Corners := DBNavigator1.Corners + [vgCornerTopRight];
  if CheckBox3.IsChecked then
    DBNavigator1.Corners := DBNavigator1.Corners + [vgCornerBottomLeft];
  if CheckBox4.IsChecked then
    DBNavigator1.Corners := DBNavigator1.Corners + [vgCornerTopLeft];
end;

procedure TfrmDB.cornerListChange(Sender: TObject);
begin
  DBNavigator1.CornerType := TvgCornerType(cornerList.ItemIndex);
end;

procedure TfrmDB.Button1Click(Sender: TObject);
begin
  if vgScene1.Style = vgResources1 then
    vgScene1.Style := vgResources2
  else
    vgScene1.Style := vgResources1
end;

procedure TfrmDB.FormCreate(Sender: TObject);
begin
  Table1.TableName := ExtractFilePath(ParamStr(0)) + 'clients.dbf';
  Table1.Active := true;
end;

end.
