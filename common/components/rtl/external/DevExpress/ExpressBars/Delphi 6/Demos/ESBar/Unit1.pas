unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, dxsbar, dximctrl, Menus, ComCtrls;

type
  TForm1 = class(TForm)
    SideBar: TdxSideBar;
    dxSideBarPopupMenu1: TdxSideBarPopupMenu;
    SideBarStore: TdxSideBarStore;
    imgSmall: TImageList;
    imgLarge: TImageList;
    SideBarStoreItem1: TdxStoredSideItem;
    SideBarStoreItem2: TdxStoredSideItem;
    SideBarStoreItem3: TdxStoredSideItem;
    SideBarStoreItem4: TdxStoredSideItem;
    SideBarStoreItem5: TdxStoredSideItem;
    SideBarStoreItem6: TdxStoredSideItem;
    SideBarStoreItem7: TdxStoredSideItem;
    SideBarStoreItem8: TdxStoredSideItem;
    SideBarStoreItem9: TdxStoredSideItem;
    SideBarStoreItem10: TdxStoredSideItem;
    Label1: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox3: TCheckBox;
    Label2: TLabel;
    Edit2: TEdit;
    TreeView: TTreeView;
    Label3: TLabel;
    procedure SideBarItemClick(Sender: TObject; Item: TdxSideBarItem);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SideBarChangeActiveGroup(Sender: TObject);
    procedure SideBarChangeGroupCaption(Sender: TObject;
      Group: TdxSideGroup);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeViewStartDrag(Sender: TObject;
      var DragObject: TDragObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.SideBarItemClick(Sender: TObject; Item: TdxSideBarItem);
begin
  Edit1.Text := Item.Caption;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
    SideBar.PaintStyle := sbpsFlat
  else SideBar.PaintStyle := sbpsStandard;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  SideBar.CanSelected := CheckBox1.Checked;
  SideBar.SelectedItem := nil;
end;

procedure TForm1.SideBarChangeActiveGroup(Sender: TObject);
begin
  if(SideBar.ActiveGroup = nil) then
    Edit2.Text := ''
  else begin
    Edit2.Text := SideBar.ActiveGroup.Caption;
    CheckBox3.Checked := SideBar.ActiveGroup.IconType = dxsgLargeIcon;
  end;
  CheckBox3.Enabled := SideBar.ActiveGroup <> nil;
  Button2.Enabled := CheckBox3.Enabled;
  Button3.Enabled := CheckBox3.Enabled;
end;

procedure TForm1.SideBarChangeGroupCaption(Sender: TObject;
  Group: TdxSideGroup);
begin
  if Group = SideBar.ActiveGroup then
   Edit2.Text := Group.Caption;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SideBar.Groups.Add;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SideBar.EditGroup(SideBar.ActiveGroup);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SideBar.ActiveGroup.Free;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
    SideBar.ActiveGroup.IconType := dxsgLargeIcon
  else SideBar.ActiveGroup.IconType := dxsgSmallIcon;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Node, Node1 : TTreeNode;
  i, j : Integer;
  St : String;
  Item : TdxStoredSideItem;
begin
  for i := 0 to SideBarStore.Categories.Count - 1 do
  begin
    St := SideBarStore.Categories[i];
    Node := TreeView.Items.Add(nil, St);
    Node.ImageIndex := -1;
    Node.SelectedIndex := -1;
    for j := 0 to SideBarStore.GetCountByCategory(St) - 1 do
    begin
      Item := SideBarStore.GetItemByCategory(St, j);
      Node1 := TreeView.Items.AddChild(Node, Item.Caption);
      Node1.Data := Item;
      Node1.ImageIndex := Item.SmallImage;
      Node1.SelectedIndex := Node1.ImageIndex;
    end;
  end;
end;

procedure TForm1.TreeViewStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if (TreeView.Selected <> nil) and (TreeView.Selected.Data <> nil) then
  begin
    dxSideBarDragObject := TdxSideBarDragObject.Create(SideBar, DragObject, nil, TdxStoredSideItem(TreeView.Selected.Data));
//    dxSideBarDragObject.StoredItem := ;
  end;
end;

end.
