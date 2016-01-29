{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit NodeEdit;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Consts;

type
  TTreeViewItems = class(TForm)
    GroupBox1: TGroupBox;
    PropGroupBox: TGroupBox;
    New: TButton;
    Delete: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TreeView: TTreeView;
    NewSub: TButton;
    TextEdit: TEdit;
    Image: TEdit;
    StateImage: TEdit;
    OkButton: TButton;
    Cancel: TButton;
    Apply: TButton;
    Help: TButton;
    SelectedIndex: TEdit;
    Label4: TLabel;
    Load: TButton;
    OpenDialog1: TOpenDialog;
    ExpandedIndex: TEdit;
    Label5: TLabel;
    cbEnabled: TCheckBox;
    procedure NewClick(Sender: TObject);
    procedure NewSubClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ValueChange(Sender: TObject);
    procedure TextEditExit(Sender: TObject);
    procedure ImageExit(Sender: TObject);
    procedure StateImageExit(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure SelectedIndexExit(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: string);
    procedure HelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ExpandedIndexExit(Sender: TObject);
    procedure EnabledChanged(Sender: TObject);
  private
    FItems: TTreeNodes;
    FDropping: Boolean;
    procedure FlushControls;
    procedure SetItem(Value: TTreeNode);
    procedure SetStates;
  public
    property Items: TTreeNodes read FItems;
  end;

function EditTreeViewItems(AItems: TTreeNodes): Boolean;

implementation

{$R *.dfm}

var
  SavedWidth, SavedHeight, SavedLeft, SavedTop: Integer;

function EditTreeViewItems(AItems: TTreeNodes): Boolean;
var
  LTreeViewItems: TTreeViewItems;
begin
  LTreeViewItems := TTreeViewItems.Create(Application);
  try
    LTreeViewItems.TreeView.SortType := TTreeView(AItems.Owner).SortType;
    LTreeViewItems.FItems := AItems;
    LTreeViewItems.TreeView.Items.Assign(LTreeViewItems.Items);
    if LTreeViewItems.TreeView.Items.Count > 0 then
    begin
      LTreeViewItems.TreeView.Selected := LTreeViewItems.TreeView.Items.GetFirstNode;
      LTreeViewItems.TreeViewChange(nil, LTreeViewItems.TreeView.Selected);
    end;
    LTreeViewItems.SetStates;
    Result := LTreeViewItems.ShowModal = mrOK;
    if Result and LTreeViewItems.Apply.Enabled then LTreeViewItems.ApplyClick(nil);
  finally
    LTreeViewItems.Free;
  end;
end;

procedure ConvertError(Value: TEdit);
begin
  Value.SetFocus;
  Value.SelectAll;
end;

{ TTreeViewItems }

procedure TTreeViewItems.SetStates;
begin
  Delete.Enabled := TreeView.Items.Count > 0;
  PropGroupBox.Enabled := Delete.Enabled;
  Apply.Enabled := False;
  NewSub.Enabled := TreeView.Selected <> nil;
end;

procedure TTreeViewItems.SetItem(Value: TTreeNode);
begin
  if Value <> nil then
  begin
    TextEdit.Text := Value.Text;
    Image.Text := IntToStr(Value.ImageIndex);
    Self.SelectedIndex.Text := IntToStr(Value.SelectedIndex);
    StateImage.Text := IntToStr(Value.StateIndex);
    ExpandedIndex.Text := IntToStr(Value.ExpandedImageIndex);
    cbEnabled.Checked := Value.Enabled;
  end
  else begin
    TextEdit.Text := '';
    Image.Text := '';
    SelectedIndex.Text := '';
    StateImage.Text := '';
    cbEnabled.Checked := True;
  end;
end;

procedure TTreeViewItems.FlushControls;
begin
  TextEditExit(nil);
  ImageExit(nil);
  SelectedIndexExit(nil);
  StateImageExit(nil);
  ExpandedIndexExit(nil);  
end;

procedure TTreeViewItems.TreeViewChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if not FDropping then FlushControls;
end;

procedure TTreeViewItems.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  TempEnabled: Boolean;
begin
  TempEnabled := Apply.Enabled;
  SetStates;
  SetItem(Node);
  Apply.Enabled := TempEnabled;
end;

procedure TTreeViewItems.NewClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  Node := TreeView.Items.Add(Node, '');
  Node.MakeVisible;
  TreeView.Selected := Node;
  SetItem(Node);
  TextEdit.SetFocus;
  Apply.Enabled := True;
end;

procedure TTreeViewItems.NewSubClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  if Node <> nil then
  begin
    Node := TreeView.Items.AddChild(Node, '');
    Node.MakeVisible;
    TreeView.Selected := Node;
  end;
  TextEdit.SetFocus;
  Apply.Enabled := True;
end;

procedure TTreeViewItems.DeleteClick(Sender: TObject);
begin
  TreeView.Selected.Free;
  if TreeView.Items.Count = 0 then
    SetItem(nil)
  else if TreeView.Selected <> nil then
    SetItem(TreeView.Selected);
  SetStates;
  Apply.Enabled := True;
end;

procedure TTreeViewItems.EnabledChanged(Sender: TObject);
var
  Node: TTreeNode;
begin
  Apply.Enabled := True;
  if ActiveControl <> Cancel then
  begin
    Node := TreeView.Selected;
      if Node <> nil then
        Node.Enabled := cbEnabled.Checked;
  end;
end;

procedure TTreeViewItems.ExpandedIndexExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if Node <> nil then Node.ExpandedImageIndex := StrToInt(ExpandedIndex.Text);
    except
      ConvertError(ExpandedIndex);
      raise;
    end;
end;

procedure TTreeViewItems.ValueChange(Sender: TObject);
begin
  Apply.Enabled := True;
  if Sender = TextEdit then TextEditExit(Sender);
end;

procedure TTreeViewItems.TextEditExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  if Node <> nil then Node.Text := TextEdit.Text;
end;

procedure TTreeViewItems.ImageExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if Node <> nil then Node.ImageIndex := StrToInt(Image.Text);
    except
      ConvertError(Image);
      raise;
    end;
end;

procedure TTreeViewItems.SelectedIndexExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if Node <> nil then Node.SelectedIndex := StrToInt(SelectedIndex.Text);
    except
      ConvertError(SelectedIndex);
      raise;
    end;
end;

procedure TTreeViewItems.StateImageExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if Node <> nil then Node.StateIndex := StrToInt(StateImage.Text);
    except
      ConvertError(StateImage);
      raise;
    end;
end;

procedure TTreeViewItems.ApplyClick(Sender: TObject);
begin
  FlushControls;
  Items.Assign(TreeView.Items);
  Apply.Enabled := False;
end;

procedure TTreeViewItems.LoadClick(Sender: TObject);
begin
  OpenDialog1.Title := SOpenFileTitle;
  if OpenDialog1.Execute then
  begin
    TreeView.LoadFromFile(OpenDialog1.FileName);
    SetStates;
    Apply.Enabled := True;
  end;
end;

procedure TTreeViewItems.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TTreeViewItems.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Node: TTreeNode;
  AddMode: TNodeAttachMode;
  Child: Boolean;
begin
  if (TreeView.Selected <> nil) then
  begin
    Child := GetKeyState(VK_SHIFT) < 0;
    if Child then
      AddMode := naAddChild
    else
      AddMode := naInsert;
    Node := TreeView.GetNodeAt(X, Y);
    if Node = nil then
    begin
      Node := TreeView.Items[Items.Count - 1];
      while (Node <> nil) and not Node.IsVisible do Node := Node.GetPrev;
      if not Child then AddMode := naAdd;
    end;
    if Node <> nil then
    try
      FDropping := True;
      TreeView.Selected.MoveTo(Node, AddMode);
      TreeView.Selected.Selected := True;
      Apply.Enabled := True;
    finally
      FDropping := False;
    end;
  end;
end;

procedure TTreeViewItems.TreeViewEdited(Sender: TObject; Node: TTreeNode;
  var S: string);
begin
  TextEdit.Text := S;
  TextEditExit(nil);
end;

procedure TTreeViewItems.HelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TTreeViewItems.FormCreate(Sender: TObject);
begin
  if SavedWidth <> 0 then
    Width := SavedWidth;
  if SavedHeight <> 0 then
    Height := SavedHeight;
  if SavedLeft <> 0 then
    Left := SavedLeft
  else
    Left := (Screen.Width - Width) div 2;
  if SavedTop <> 0 then
    Top := SavedTop
  else
    Top := (Screen.Height - Height) div 2;
end;

procedure TTreeViewItems.FormDestroy(Sender: TObject);
begin
  SavedWidth := Width;
  SavedHeight := Height;
  SavedLeft := Left;
  SavedTop := Top;
end;

end.

