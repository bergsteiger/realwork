unit customlistfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_layouts, vg_listbox, vg_objects, vg_controls;

type
  TfrmCustomList = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    ListBox1: TvgListBox;
    Resources1: TvgResources;
    Button1: TvgButton;
    OpenDialog1: TOpenDialog;
    InfoLabel: TvgLabel;
    Label1: TvgLabel;
    Button2: TvgButton;
    Button3: TvgButton;
    CheckBox1: TvgCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
  private
    { Private declarations }
    procedure DoInfoClick(Sender: TObject);
    procedure DoVisibleChange(Sender: TObject);
    procedure DoApplyResource(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmCustomList: TfrmCustomList;

implementation

{$R *.dfm}

procedure TfrmCustomList.Button1Click(Sender: TObject);
var
  Item: TvgListBoxItem;
  B: TvgBitmap;
  S: TvgPoint;
begin
  OpenDialog1.Filter := DefaultFilterClass.GetFileTypes;
  if OpenDialog1.Execute then
  begin
    // create thumbnail
    B := TvgBitmap.Create(1, 1);
    B.LoadThumbnailFromFile(OpenDialog1.FileName, 100, 100, true);
    // get image size
    S := DefaultFilterClass.GetImageSize(OpenDialog1.FileName);
    // create custom item
    Item := TvgListBoxItem.Create(nil);
    Item.Parent := ListBox1;
    // this code force our style to new item
    Item.Resource := 'CustomItem';
    // use this to set our child controls value - this code use BindingName in style to search
    Item.Binding['image'] := ObjectToVariant(B); // set thumbnail
    Item.Binding['text'] := ExtractFileName(OpenDialog1.FileName); // set filename
    Item.Binding['resolution'] := IntToStr(trunc(S.X)) + 'x' + IntToStr(trunc(S.Y)) + ' px'; // set size
    Item.Binding['depth'] := '32 bit';
    Item.Binding['visible'] := true; // set Checkbox value
    Item.Binding['visible'] := EventToVariant(DoVisibleChange); // set OnChange value
    Item.Binding['info'] := EventToVariant(DoInfoClick); // set OnClick value
    // free thumbnail
    B.Free;
  end;
end;

procedure TfrmCustomList.Button2Click(Sender: TObject);
var
  Item: TvgListBoxItem;
begin
  // create custom item
  Item := TvgListBoxItem.Create(nil);
  Item.Parent := ListBox1;
  // this code set event - when we need to setup item
  Item.OnApplyResource := DoApplyResource;
  // this set our style to new item
  Item.Resource := 'CustomItem';
end;

procedure TfrmCustomList.DoInfoClick(Sender: TObject);
begin
  InfoLabel.Text := 'Info Button click on ' + IntToStr(ListBox1.ItemIndex) + ' listbox item';
end;

procedure TfrmCustomList.DoVisibleChange(Sender: TObject);
begin
  InfoLabel.Text := 'Checkbox changed ' + IntToStr(ListBox1.ItemIndex) + ' listbox item to ' + BoolToStr(Listbox1.Selected.Binding['visible'], true);
end;

procedure TfrmCustomList.Button3Click(Sender: TObject);
var
  i: integer;
begin
  ListBox1.BeginUpdate;
  for i := 1 to 1000 do
    Button2Click(Sender);
  ListBox1.EndUpdate;
end;

procedure TfrmCustomList.DoApplyResource(Sender: TObject);
var
  B: TvgBitmap;
  Item: TvgListboxItem;
begin
  Item := TvgListBoxItem(Sender);
  // create thumbnail
  B := TvgBitmap.Create(10 + random(50), 10 + random(50));
  B.Clear($FF000000 or random($FFFFFF));
  // use this to set our child controls value - this code use BindingName in style to search
  Item.Binding['image'] := ObjectToVariant(B); // set thumbnail
  Item.Binding['text'] := 'item ' + IntToStr(Item.Index); // set filename
  Item.Binding['resolution'] := IntToStr(B.Width) + 'x' + IntToStr(B.Height) + ' px'; // set size
  Item.Binding['depth'] := '32 bit';
  Item.Binding['visible'] := true; // set Checkbox value
  Item.Binding['visible'] := EventToVariant(DoVisibleChange); // set OnChange value
  Item.Binding['info'] := EventToVariant(DoInfoClick); // set OnClick value
  // free thumbnail
  B.Free;
end;

procedure TfrmCustomList.CheckBox1Change(Sender: TObject);
begin
  ListBox1.AllowDrag := CheckBox1.IsChecked;
end;

end.
