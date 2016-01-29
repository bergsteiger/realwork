{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit unit1;



interface

{$I DCPROD.INC}
{.$I DC.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, DcTree,dctsrc, StdCtrls,dctreeed, Menus, ExtCtrls,dcgen, Buttons,
  dcedit, dcstdctl,dcimged, treemod, dctslite, dcmenu, dcDTree,
  dcpedit, dcsystem {$IFDEF D4} ,imglist  {$ENDIF};


type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Demo1: TMenuItem;
    EditTreeView1: TMenuItem;
    EditListView1: TMenuItem;
    EditMenu1: TMenuItem;
    IdeInspector1: TMenuItem;
    DCMenu1: TDCMenu;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    Label2: TLabel;
    SellAllBut: TButton;
    DeSelAllBut: TButton;
    EditMenuBut: TButton;
    EditTreeBut: TButton;
    EditListBut: TButton;
    EdListColumns: TButton;
    IdeInspBut: TButton;
    ImageBut: TBitBtn;
    Panel2: TPanel;
    BoldBut: TSpeedButton;
    ItalicBut: TSpeedButton;
    UnderBut: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DCPropEditor1: TDCPropEditor;
    DCColorEdit1: TDCColorEdit;
    DCPropCheckBox1: TDCPropCheckBox;
    DCPropCheckBox2: TDCPropCheckBox;
    DCPropCheckBox3: TDCPropCheckBox;
    TreeView: TDCMSTreeView;
    DCSplitter1: TDCSplitter;
    TabSheet2: TTabSheet;
    DCTreeView1: TDCTreeView;
    Panel1: TPanel;
    DCListView1: TDCListView;
    DCSplitter2: TDCSplitter;
    DCResViewSource1: TDCResViewSource;
    DCPropEditor2: TDCPropEditor;
    Label1: TLabel;
    WindowList1: TMenuItem;
    ImageList1: TImageList;
    UseCustomDrawbox: TCheckBox;
    ListView: TDCDrawListView;
    DCPropCheckBox4: TDCPropCheckBox;
    procedure SellAllButClick(Sender: TObject);
    procedure DeSelAllButClick(Sender: TObject);
    procedure EditTreeButClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure EditListButClick(Sender: TObject);
    procedure EditMenuButClick(Sender: TObject);
    procedure IdeInspButClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdListColumnsClick(Sender: TObject);
    procedure BoldButClick(Sender: TObject);
    procedure ItalicButClick(Sender: TObject);
    procedure UnderButClick(Sender: TObject);
    procedure ImageButClick(Sender: TObject);
    procedure DCColorEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WindowList1Click(Sender: TObject);
    procedure TreeViewCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure UseCustomDrawboxClick(Sender: TObject);
    procedure TreeViewSelectionChanged(Sender: TObject; Node: TTreeNode);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private declarations }
    procedure SetNodeStyle(style:TFontStyle;value : boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$IFDEF DREAMINSPECTOR}
uses
  treeinsp;
{$ENDIF}

{$R *.DFM}
{$R *.DCR}

procedure TForm1.SellAllButClick(Sender: TObject);
begin
  if TreeView.MultiSelect then
    TreeView.SelectAllItems;
end;

procedure TForm1.DeSelAllButClick(Sender: TObject);
begin
  TreeView.DeselectAllItems;
  TreeView.Selected:=nil;
end;

procedure TForm1.EditTreeButClick(Sender: TObject);
begin
  CallPropertyEdit(TreeView,'Items');
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  ShowMessage('Dream Tree demo '#13#10'Copyright (c) 1998 Dream Company');
end;

procedure TForm1.EditListButClick(Sender: TObject);
begin
  CallPropertyEdit(ListView,'Items');
end;

procedure TForm1.EdListColumnsClick(Sender: TObject);
begin
  CallPropertyEdit(ListView,'Columns');
end;

procedure TForm1.EditMenuButClick(Sender: TObject);
begin
  CallPropertyEdit(MainMenu1,'Items');
end;

procedure TForm1.IdeInspButClick(Sender: TObject);
begin
  {$IFDEF DREAMINSPECTOR}
  ShowIDEInspector;
  {$ENDIF}
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  TreeView.FullExpand;
  {$IFNDEF DREAMINSPECTOR}
  EditTreeBut.Hide;
  EditListBut.Hide;
  IdeInspBut.Hide;
  {$ENDIF}
end;

procedure TForm1.BoldButClick(Sender: TObject);
begin
  SetNodeStyle(fsBold, not BoldBut.Down);
end;

procedure TForm1.ItalicButClick(Sender: TObject);
begin
  SetNodeStyle(fsItalic,not ItalicBut.Down);
end;

procedure TForm1.UnderButClick(Sender: TObject);
begin
  SetNodeStyle(fsUnderline,not UnderBut.Down);
end;

procedure TForm1.SetNodeStyle(style:TFontStyle;value : boolean);
var
  i:integer;
begin
  with TreeView,ItemsSelected  do
    for i := 0 to Count -1 do
      with TDrawNode(Items[i]) do
        if value then
          fontstyle := fontstyle - [style]
        else
          fontstyle := fontstyle + [style];
  TreeViewSelectionChanged(Self,TreeView.Selected);
end;

procedure TForm1.ImageButClick(Sender: TObject);
  var
  sel:integer;
  i:integer;
begin
  with TreeView do
  begin
    if Selected <> nil then
       sel := Selected.ImageIndex
    else
      sel := 0;
    if EditCustomImageList(ImageList1,sel) then
      with ItemsSelected do
        for i := 0 to Count -1 do
          with  TTreeNode(Items[i]) do
          begin
            ImageIndex:= sel;
            SelectedIndex:= sel;
          end;
  end;
end;

procedure TForm1.DCColorEdit1Change(Sender: TObject);
var
  i:integer;
begin
  with TreeView ,ItemsSelected do
    for i := 0 to Count -1 do
       with TDrawNode(Items[i]) do
          FontColor := DCColorEdit1.SelectedColor;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Node : TTreeNode;
begin
  DcResViewSource1.filename := Paramstr(0);
  ImageList1.ResourceLoad(rtBitmap,'IMAGES',clSilver);
  PageControl1.ActivePage := TabSheet1;

  with TreeView, Items do
  begin
    Node := GetFirstNode;
    while Assigned(Node) do
    begin
      TDrawNode(Node).RadioItem := true;
      Node := Node.GetNextSibling;
    end;
  end;

  {$IFNDEF DREAMINSPECTOR}
     EditListBut.Visible := false;
     EdListColumns.Visible := false;
     IdeInspBut.Visible := false;
  {$ENDIF}

end;

procedure TForm1.WindowList1Click(Sender: TObject);
begin
  ShowWindowList;
end;

procedure TForm1.TreeViewCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if  (Node.Level = 0) and not (cdsSelected in State) then
    TreeView.Canvas.Font.Color := clBlue;
end;

procedure TForm1.UseCustomDrawboxClick(Sender: TObject);
begin
  if UseCustomDrawbox.Checked then
    TreeView.OnCustomDrawItem := TreeViewCustomDrawItem
  else
    TreeView.OnCustomDrawItem := nil;
  TreeView.Repaint;
end;

procedure TForm1.TreeViewSelectionChanged(Sender: TObject;
  Node: TTreeNode);
begin
  if TreeView.Selected = nil then
  begin
    BoldBut.Down := false;
    ItalicBut.Down := false;
    UnderBut.Down := false;
    DCColorEdit1.SelectedColor := TreeView.Font.Color;
  end
  else
    if TreeView.ItemsSelected.Count <= 1  then
      with TDrawNode(TreeView.Selected) do
      begin
        BoldBut.Down := fsBold in fontstyle;
        ItalicBut.Down := fsItalic in fontstyle;
        UnderBut.Down := fsUnderline in fontstyle;
        DCColorEdit1.SelectedColor := FontColor;
      end;
end;

procedure TForm1.TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept := true;
end;

end.
