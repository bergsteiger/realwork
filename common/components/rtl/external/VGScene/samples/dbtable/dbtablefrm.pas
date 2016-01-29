unit dbtablefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, vg_scene, vg_layouts, vg_grid, vg_dbctrls,
  vg_textbox, StdCtrls, Mask, DBCtrls, vg_controls, Grids, DBGrids,
  vg_objects, ImgList, vg_actions;

type
  TForm5 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    DataSource1: TDataSource;
    Table1: TTable;
    DBTable1: TvgDBGrid;
    ToolBar1: TvgToolBar;
    DBNavigator1: TvgDBNavigator;
    Table1Text: TStringField;
    Table1Date: TDateField;
    Table1Number: TFloatField;
    Table1Image: TGraphicField;
    Table1Bool: TBooleanField;
    Button1: TvgButton;
    vgImageList1: TvgImageList;
    DBColumn2: TvgDBColumn;
    DBImageColumn1: TvgDBImageColumn;
    DBCheckColumn1: TvgDBCheckColumn;
    DBColumn1: TvgDBColumn;
    vgResources1: TvgResources;
    Table1Popup: TStringField;
    DBPopupColumn1: TvgDBPopupColumn;
    Table1Progress: TFloatField;
    DBProgressColumn1: TvgDBProgressColumn;
    CheckBox1: TvgCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.FormCreate(Sender: TObject);
begin
  Table1.TableName := ExtractFilePath(ParamStr(0)) + 'demo.db';
  Table1.Active := true;
end;

procedure TForm5.Button1Click(Sender: TObject);
var
  i: integer;
  P: TPicture;
begin
  // just fill table
  P := TPicture.Create;
  Table1.DisableControls;
  for i := 0 to 100 do
  begin
    Table1.Append;
    Table1.FieldByName('text').Value := 'text ' + IntToStr(i);
    Table1.FieldByName('number').Value := i;
    Table1.FieldByName('bool').Value := BoolToStr(Odd(i), true);
    P.Assign(vgImageList1.Images[random(vgImageList1.Count)]);
    Table1.FieldByName('image').Assign(P);
    Table1.FieldByName('popup').Value := DBPopupColumn1.Items[random(DBPopupColumn1.Items.Count)];
    Table1.FieldByName('progress').Value := random(1000);
    Table1.Post;
  end;
  Table1.EnableControls;
  P.Free;
end;

procedure TForm5.CheckBox1Change(Sender: TObject);
begin
  Table1.Active := CheckBox1.IsChecked;
end;

end.
