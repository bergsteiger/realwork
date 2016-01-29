{ ********************************************************************** }
{                                                                        }
{ Delphi and Kylix Cross-Platform Visual Component Library               }
{ Component and Property Editor Source                                   }
{                                                                        }
{ Copyright (C) 2000, 2001 Borland Software Corporation                  }
{                                                                        }
{ All Rights Reserved.                                                   }
{                                                                        }
{ ********************************************************************** }


unit ClxNodeEdit;

interface

uses
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  DesignIntf, DesignEditors, DsnConst, LibHelp, QConsts, QStdCtrls, QComCtrls;

type
  TClxTreeViewItems = class(TForm)
    GroupBox1: TGroupBox;
    PropGroupBox: TGroupBox;
    New: TButton;
    Delete: TButton;
    Label1: TLabel;
    Label2: TLabel;
    TreeView: TTreeView;
    NewSub: TButton;
    Text: TEdit;
    Image: TEdit;
    Button4: TButton;
    Cancel: TButton;
    Apply: TButton;
    Help: TButton;
    SelectedIndex: TEdit;
    Label4: TLabel;
    Load: TButton;
    OpenDialog1: TOpenDialog;
    gbSubItems: TGroupBox;
    lbSubItems: TListBox;
    btnAddSub: TButton;
    btnDelSub: TButton;
    gbSubItemProps: TGroupBox;
    lblSubText: TLabel;
    edtSubText: TEdit;
    lblSubImgIndex: TLabel;
    edtSubImgIndex: TEdit;
    procedure NewClick(Sender: TObject);
    procedure NewSubClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ValueChange(Sender: TObject);
    procedure TextExit(Sender: TObject);
    procedure ImageExit(Sender: TObject);
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
      var S: WideString);
    procedure HelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtSubTextExit(Sender: TObject);
    procedure edtSubImgIndexExit(Sender: TObject);
    procedure btnAddSubClick(Sender: TObject);
    procedure btnDelSubClick(Sender: TObject);
    procedure lbSubItemsClick(Sender: TObject);
    procedure edtSubTextChange(Sender: TObject);
  private
    FItems: TTreeNodes;
    FDropping: Boolean;
    FPutting: Boolean;
    procedure FlushControls;
    procedure SetItem(Value: TTreeNode);
    procedure SetStates;
    function SubItemsShouldBeDisabled: Boolean;
    procedure PutSubItemText(const Str: string);
  public
    property Items: TTreeNodes read FItems;
  end;

{ TTreeViewEditor }

type
  TEditInvoker = class
  private
    FDesigner: IDesigner;
    FComponent: TComponent;
    procedure InvokeEdit;
  public
    constructor Create(ADesigner: IDesigner; AComponent: TComponent);
  end;

  TTreeViewEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TTreeViewItemsProperty = class(TClassProperty)
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TTreeViewColumnsProperty = class(TClassProperty)
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

function EditTreeViewItems(AItems: TTreeNodes): Boolean;

implementation

{$R *.xfm}

uses
{$IFDEF MSWINDOWS}
  Qt, ColnEdit;
{$ENDIF}
{$IFDEF LINUX}
  Qt, ColnEdit, Libc;
{$ENDIF}

function EditTreeViewItems(AItems: TTreeNodes): Boolean;
begin
  with TClxTreeViewItems.Create(Application) do
    try
      TreeView.SortType := TTreeView(AItems.Owner).SortType;
      FItems := AItems;
      TreeView.Items.Assign(Items);
      with TreeView do
        if Items.Count > 0 then
        begin
          Selected := Items.GetFirstNode;
          TreeViewChange(nil, Selected);
        end;
      SetStates;
      Apply.Enabled := False;
      Result := ShowModal = mrOK;
      if Result and Apply.Enabled then
        ApplyClick(nil);
    finally
      Free;
    end;
end;

procedure ConvertError(Value: TEdit);
begin
  with Value do
  begin
    SetFocus;
    SelectAll;
  end;
end;

{ TClxTreeViewItems }

procedure TClxTreeViewItems.SetStates;
begin
  Delete.Enabled := TreeView.Items.Count > 0;
  PropGroupBox.Enabled := Delete.Enabled;
  NewSub.Enabled := TreeView.Selected <> nil;
  btnAddSub.Enabled := TreeView.Selected <> nil;
  btnDelSub.Enabled := lbSubItems.ItemIndex <> -1;
  gbSubItemProps.Enabled := btnDelSub.Enabled;
end;

procedure TClxTreeViewItems.SetItem(Value: TTreeNode);
begin
  if Assigned(Value) then
    with Value do
    begin
      Self.Text.Text := Text;
      Image.Text := IntToStr(ImageIndex);
      Self.SelectedIndex.Text := IntToStr(SelectedIndex);
      lbSubItems.Items.Assign(SubItems);
      if lbSubItems.Items.Count = 0 then
      begin
        PutSubItemText('');
        edtSubImgIndex.Text := '-1';
      end;
    end
  else
  begin
    Text.Text := '';
    Image.Text := '';
    SelectedIndex.Text := '';
    lbSubItems.Items.Clear;
    if lbSubItems.ItemIndex = -1 then
    begin
      PutSubItemText('');
      edtSubImgIndex.Text := '-1';
    end;
  end;
  SetStates;
end;

procedure TClxTreeViewItems.FlushControls;
begin
  edtSubTextExit(nil);
  edtSubImgIndexExit(nil);
  TextExit(nil);
  ImageExit(nil);
  SelectedIndexExit(nil);
end;

procedure TClxTreeViewItems.TreeViewChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if not FDropping then
    FlushControls;
end;

procedure TClxTreeViewItems.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  TempEnabled: Boolean;
begin
  if not FDropping then
  begin
    TempEnabled := Apply.Enabled;
    SetStates;
    SetItem(Node);
    Apply.Enabled := TempEnabled;
  end;
end;

procedure TClxTreeViewItems.NewClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  Node := TreeView.Items.Add(Node, '');
  Node.MakeVisible;
  TreeView.Selected := Node;
  SetItem(Node);
  Text.SetFocus;
  Apply.Enabled := True;
end;

procedure TClxTreeViewItems.NewSubClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  with TreeView do
  begin
    Node := Selected;
    if Assigned(Node) then
    begin
      Node := Items.AddChild(Node, '');
      Node.MakeVisible;
      Selected := Node;
    end;
  end;
  Text.SetFocus;
  Apply.Enabled := True;
end;

procedure TClxTreeViewItems.DeleteClick(Sender: TObject);
begin
  TreeView.Selected.Free;
  if TreeView.Items.Count = 0 then
    SetItem(nil)
  else if Assigned(TreeView.Selected) then
    SetItem(TreeView.Selected);
  SetStates;
  Apply.Enabled := True;
end;

procedure TClxTreeViewItems.ValueChange(Sender: TObject);
begin
  Apply.Enabled := True;
  if Sender = Text then
    TextExit(Sender);
end;

procedure TClxTreeViewItems.TextExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  if Assigned(Node) then
    Node.Text := Text.Text;
end;

procedure TClxTreeViewItems.ImageExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if Assigned(Node) then
        Node.ImageIndex := StrToInt(Image.Text);
    except
      ConvertError(Image);
      raise;
    end;
end;

procedure TClxTreeViewItems.SelectedIndexExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if not Assigned(Node) then
        Exit;
      Node.SelectedIndex := StrToInt(SelectedIndex.Text);
    except
      ConvertError(SelectedIndex);
      raise;
    end;
end;

procedure TClxTreeViewItems.ApplyClick(Sender: TObject);
begin
  FlushControls;
  Items.Assign(TreeView.Items);
  Apply.Enabled := False;
end;

procedure TClxTreeViewItems.LoadClick(Sender: TObject);
begin
  OpenDialog1.Title := SOpenFileTitle;
  with OpenDialog1 do
    if Execute then
    begin
      TreeView.LoadFromFile(FileName);
      SetStates;
      Apply.Enabled := True;
    end;
end;

procedure TClxTreeViewItems.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TClxTreeViewItems.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Node: TTreeNode;
  AddMode: TNodeAttachMode;
begin
  FDropping := True;
  try
    with TreeView do
      if Assigned(Selected) then
      begin
        if ssCtrl in Application.KeyState then
          AddMode := naAddChildFirst
        else
          AddMode := naInsert;
        Node := TreeView.DropTarget;
        if Assigned(Node) then
          Selected.MoveTo(Node, AddMode);
        Apply.Enabled := True;
  {      if Node = nil then
        begin
          Node := Items[Items.Count - 1];
          while Assigned(Node) and not Node.IsVisible do
            Node := Node.GetPrev;
        end;
        if Assigned(Node) then
          with Selected do
          try
            FDropping := True;
            MoveTo(Node, AddMode);
            Selected := True;
            Apply.Enabled := True;
          finally
            FDropping := False;
          end; }
      end;
  finally
    FDropping := False;
  end;
end;

procedure TClxTreeViewItems.TreeViewEdited(Sender: TObject; Node: TTreeNode;
  var S: WideString);
begin
  Text.Text := S;
  TextExit(nil);
end;

procedure TClxTreeViewItems.edtSubTextExit(Sender: TObject);
var
  Node: TTreeNode;
  ItemIndex: Integer;
begin
  if SubItemsShouldBeDisabled then
    Exit;
  Node := TreeView.Selected;
  ItemIndex := lbSubItems.ItemIndex;
  if ItemIndex <> -1 then
  begin
    lbSubItems.Items[ItemIndex] := edtSubText.Text;
    Node.SubItems[ItemIndex] := lbSubItems.Items[ItemIndex];
  end;
end;

procedure TClxTreeViewItems.edtSubImgIndexExit(Sender: TObject);
var
  Node: TTreeNode;
  ItemIndex: Integer;
begin
  if SubItemsShouldBeDisabled then
    Exit;
  Node := TreeView.Selected;
  ItemIndex := lbSubItems.ItemIndex;
  if ItemIndex <> -1 then
    try
      Node.SubItemImages[ItemIndex] := StrToInt(edtSubImgIndex.Text);
    except
      ConvertError(edtSubImgIndex);
      raise;
    end;
end;

procedure TClxTreeViewItems.HelpClick(Sender: TObject);
begin
  InvokeHelp;
end;

procedure TClxTreeViewItems.FormCreate(Sender: TObject);
begin
  HelpContext := hcDTreeViewItemEdit;
  OpenDialog1.Filter := SOpenDialogFilter;
end;

procedure TClxTreeViewItems.btnAddSubClick(Sender: TObject);
begin
  if not Assigned(TreeView.Selected) then
  begin
    PutSubItemText('');
    edtSubImgIndex.Text := '-1';
    gbSubItemProps.Enabled := False;
    Exit;
  end;
  TreeView.Selected.SubItems.Add('');
  lbSubItems.ItemIndex := lbSubItems.Items.Add('');
  gbSubItemProps.Enabled := True;
  PutSubItemText('');
  edtSubImgIndex.Text := '-1';
  Apply.Enabled := True;
  edtSubText.SetFocus;
end;

procedure TClxTreeViewItems.btnDelSubClick(Sender: TObject);
var
  ItemIndex: Integer;
begin
  if SubItemsShouldBeDisabled then
    Exit;
  ItemIndex := lbSubItems.ItemIndex;
  lbSubItems.Items.Delete(ItemIndex);
  TreeView.Selected.SubItems.Delete(ItemIndex);
  if lbSubItems.Items.Count <> 0 then
    if ItemIndex <> 0 then
      lbSubItems.ItemIndex := ItemIndex - 1
    else
      lbSubItems.ItemIndex := 0;
  gbSubItemProps.Enabled := lbSubItems.Items.Count <> 0;
  if lbSubItems.ItemIndex <> -1 then
  begin
    edtSubText.Text := lbSubItems.Items.Strings[lbSubItems.Itemindex];
    edtSubImgIndex.Text := IntToStr(TreeView.Selected.SubItemImages[lbSubItems.ItemIndex]);
  end;
  Apply.Enabled := True;
end;

procedure TClxTreeViewItems.PutSubItemText(const Str: string);
begin
  FPutting := True;
  try
    edtSubText.Text := Str;
  finally
    FPutting := False;
  end;
end;

procedure TClxTreeViewItems.lbSubItemsClick(Sender: TObject);
begin
  if not btnAddSub.Enabled then
    Exit;
  if SubItemsShouldBeDisabled then
     Exit;
  edtSubImgIndex.Text := IntToStr(TreeView.Selected.SubItemImages[lbSubItems.ItemIndex]);
  if TreeView.Selected.SubItems.Count > lbSubItems.ItemIndex then
    PutSubItemText(TreeView.Selected.SubItems[lbSubItems.ItemIndex])
  else
    PutSubItemText('');
  SetStates;
end;

function TClxTreeViewItems.SubItemsShouldBeDisabled: Boolean;
begin
  if (not Assigned(TreeView.Selected)) or (lbSubItems.ItemIndex = -1) then
  begin
    PutSubItemText('');
    edtSubImgIndex.Text := '-1';
    gbSubItemProps.Enabled := False;
    Result := True;
  end
  else
    Result := False;
end;

procedure TClxTreeViewItems.edtSubTextChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  if FPutting then
    Exit;
  Apply.Enabled := True;
  if Sender = edtSubText then
  begin
    ItemIndex := lbSubItems.ItemIndex;
    if ItemIndex = -1 then
      Exit;
    lbSubItems.Items[ItemIndex] := edtSubText.Text;
    TreeView.Selected.SubItems[ItemIndex] := lbSubItems.Items[ItemIndex];
  end;
end;

{ TEditInvoker }
constructor TEditInvoker.Create(ADesigner: IDesigner; AComponent: TComponent);
begin
  inherited Create;
  FDesigner := ADesigner;
  FComponent := AComponent;
end;

procedure TEditInvoker.InvokeEdit;
begin
  ShowCollectionEditor(FDesigner, FComponent, TTreeView(FComponent).Columns, 'Columns');
  Free;
end;

{ TTreeViewEditor }

procedure TTreeViewEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:
      if EditTreeViewItems(TTreeView(Component).Items) and
      Assigned(Designer) then
        Designer.Modified;
    1: TEditInvoker.Create(Designer, Component).InvokeEdit;
  end;
end;

function TTreeViewEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := STreeItemsEditor;
    1: Result := STreeColumnsEditor;
  end;
end;

function TTreeViewEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TTreeViewItemsProperty }

procedure TTreeViewItemsProperty.Edit;
var
  Component: TComponent;
begin
  Component := TComponent(GetComponent(0));
  if not Assigned(Component) then
    Exit;
  if EditTreeViewItems(TTreeView(Component).Items) and Assigned(Designer) then
    Designer.Modified;
end;

function TTreeViewItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paRevertable];
end;

{ TTreeViewColumnsProperty }

procedure TTreeViewColumnsProperty.Edit;
var
  Component: TComponent;
begin
  Component := TComponent(GetComponent(0));
  if not Assigned(Component) then
    Exit;
  ShowCollectionEditor(Designer, Component, TTreeView(Component).Columns, 'Columns');
end;

function TTreeViewColumnsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paRevertable, paVCL];
end;

end.
