{ ********************************************************************** }
{                                                                        }
{ Delphi and Kylix Cross-Platform Visual Component Library               }
{ Component and Property Editor Source                                   }
{                                                                        }
{ Copyright (C) 2000, 2001 Borland Software Corporation                  }
{ All Rights Reserved.                                                   }
{                                                                        }
{ ********************************************************************** }


unit ClxItemEdit;

interface
           
uses
  SysUtils, Classes, QGraphics, QForms, QDialogs,
  LibHelp, DesignIntf, DesignEditors, DsnConst, QStdCtrls, QComCtrls, QControls;

type
  TItemInfo = class(TObject)
  private
    FSubItems: TStringList;
    FSubItemImages: TList;
    FCaption: string;
    FImageIndex: Integer;
    FStateIndex: Integer;
  public
    constructor Create(Item: TListItem);
    destructor Destroy; override;
  end;

  TClxListViewItems = class(TForm)
    GroupBox1: TGroupBox;
    PropGroupBox: TGroupBox;
    New: TButton;
    Delete: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TreeView: TTreeView;
    NewSub: TButton;
    Text: TEdit;
    Image: TEdit;
    StateImage: TEdit;
    Button4: TButton;
    Cancel: TButton;
    Apply: TButton;
    Button7: TButton;
    procedure NewClick(Sender: TObject);
    procedure NewSubClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ValueChange(Sender: TObject);
    procedure TextExit(Sender: TObject);
    procedure ImageExit(Sender: TObject);
    procedure StateImageExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: WideString);
    procedure Button7Click(Sender: TObject);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeViewEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
  private
    FItems: TListItems;
    FDropping: Boolean;
    procedure FlushControls;
    procedure GetItem(ItemInfo: TItemInfo; Value: TListItem);
    procedure SetItem(Value: TItemInfo);
    procedure SetStates;
    procedure SetSubItem(const S: string; ImageIndex: Integer);
  public
    property Items: TListItems read FItems;
  end;

{ TListViewEditor }

type
  TEditInvoker = class
  private
    FDesigner: IDesigner;
    FComponent: TComponent;
    procedure InvokeEdit;
  public
    constructor Create(ADesigner: IDesigner; AComponent: TComponent);
  end;

  TListViewEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TListViewColumnsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TListViewItemsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

function EditListViewItems(AItems: TListItems): Boolean;

implementation

{$IFDEF MSWINDOWS}
uses Qt, ColnEdit;
{$ENDIF}
{$IFDEF LINUX}
uses Qt, ColnEdit, Libc;
{$ENDIF}

{$R *.xfm}

function EditListViewItems(AItems: TListItems): Boolean;
var
  I, J: Integer;
  Node: TTreeNode;
  ItemInfo: TItemInfo;
begin
  with TClxListViewItems.Create(Application) do
    try
      FItems := AItems;
      for I := 0 to Items.Count - 1 do
      begin
        ItemInfo := TItemInfo.Create(Items[I]);
        Node := TreeView.Items.AddObject(nil, ItemInfo.FCaption, ItemInfo);
        for J := 0 to ItemInfo.FSubItems.Count - 1 do
          ItemInfo.FSubItems.Objects[J] := TreeView.Items.AddChild(Node,
            ItemInfo.FSubItems[J]);
      end;
      with TreeView do
        if Items.Count > 0 then
        begin
          Selected := Items.GetFirstNode;
          TreeViewChange(nil, Selected);
        end;
      SetStates;
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

{ TItemInfo }

constructor TItemInfo.Create(Item: TListItem);
var
  I: Integer;
begin
  inherited Create;
  FSubItems := TStringList.Create;
  FSubItemImages := TList.Create;
  FStateIndex := -1;
  FImageIndex := -1;
  if Assigned(Item) then
  begin
    FCaption := Item.Caption;
    FImageIndex := Item.ImageIndex;
    // FStateIndex := StateIndex;
    FSubItems.Assign(Item.SubItems);
    for I := 0 to Item.SubItems.Count-1 do
      FSubItemImages.Add(Pointer(Item.SubItemImages[I]));
  end;
end;

destructor TItemInfo.Destroy;
begin
  FSubItems.Free;
  FSubItemImages.Free;
  inherited Destroy;
end;

{ TClxListViewItems }

procedure TClxListViewItems.SetStates;
begin
  Delete.Enabled := TreeView.Items.Count > 0;
  PropGroupBox.Enabled := Delete.Enabled;
  Apply.Enabled := False;
  NewSub.Enabled := TreeView.Selected <> nil;
end;

procedure TClxListViewItems.GetItem(ItemInfo: TItemInfo; Value: TListItem);
var
  I: Integer;
begin
  with Value do
  begin
    Caption := ItemInfo.FCaption;
    ImageIndex := ItemInfo.FImageIndex;
    // StateIndex := ItemInfo.FStateIndex;
    SubItems.Assign(ItemInfo.FSubItems);
    for I := 0 to ItemInfo.FSubItems.Count - 1 do
      SubItemImages[I] := Integer(ItemInfo.FSubItemImages[I]);
  end;
end;

procedure TClxListViewItems.SetSubItem(const S: string; ImageIndex: Integer);
begin
  StateImage.Enabled := False;
  Image.Text := IntToStr(ImageIndex);
  Text.Text := S;
end;

procedure TClxListViewItems.SetItem(Value: TItemInfo);
begin
  Image.Enabled := True;
  StateImage.Enabled := True;
  if Value <> nil then
    with Value do
    begin
      Text.Text := FCaption;
      Image.Text := IntToStr(FImageIndex);
      // StateImage.Text := IntToStr(FStateIndex);
    end
  else begin
    Text.Text := '';
    Image.Text := '';
    StateImage.Text := '';
  end;
end;

procedure TClxListViewItems.FlushControls;
begin
  TextExit(nil);
  ImageExit(nil);
  StateImageExit(nil);
end;

procedure TClxListViewItems.TreeViewChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if not FDropping then
    FlushControls;
end;

procedure TClxListViewItems.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  TempEnabled: Boolean;
  ItemInfoSubs: TStrings;
  Index: Integer;
begin
  TempEnabled := Apply.Enabled;
  if Node <> nil then
  begin
    SetStates;
    if Node.Data <> nil then
      SetItem(TItemInfo(Node.Data))
    else begin
      ItemInfoSubs := TItemInfo(Node.Parent.Data).FSubItems;
      Index := ItemInfoSubs.IndexOfObject(Node);
      if Index <> -1 then
        SetSubItem(ItemInfoSubs[Index],
        Integer(TItemInfo(Node.Parent.Data).FSubItemImages[Index]))
      else
        SetSubItem('', -1);
    end;
  end
  else SetItem(nil);
  Apply.Enabled := TempEnabled;
end;

procedure TClxListViewItems.NewClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Items.AddObject(nil, '', TItemInfo.Create(nil));
  Node.MakeVisible;
  TreeView.Selected := Node;
  Text.SetFocus;
  Apply.Enabled := True;
end;

procedure TClxListViewItems.NewSubClick(Sender: TObject);
var
  Node, NewNode: TTreeNode;
begin
  with TreeView do
  begin
    Node := Selected;
    if Node <> nil then
    begin
      if Node.Data <> nil then
      begin
        NewNode := Node.Owner.AddChild(Node, '');
        TItemInfo(Node.Data).FSubItems.AddObject('', NewNode);
        TItemInfo(Node.Data).FSubItemImages.Add(Pointer(-1));
      end
      else begin
        NewNode := Node.Owner.Add(Node, '');
        TItemInfo(Node.Parent.Data).FSubItems.AddObject('', NewNode);
        TItemInfo(Node.Parent.Data).FSubItemImages.Add(Pointer(-1));
      end;
      NewNode.MakeVisible;
      Selected := NewNode;
    end;
  end;
  Text.SetFocus;
  Apply.Enabled := True;
end;

procedure TClxListViewItems.DeleteClick(Sender: TObject);
var
  Node: TTreeNode;
  Index: Integer;
begin
  Node := TreeView.Selected;
  if Node <> nil then
  begin
    if Node.Data = nil then
    begin
      Index := TItemInfo(Node.Parent.Data).FSubItems.IndexOfObject(Node);
      if Index <> -1 then
      begin
        TItemInfo(Node.Parent.Data).FSubItems.Delete(Index);
        TItemInfo(Node.Parent.Data).FSubItemImages.Delete(Index);
      end;
    end
    else
      TItemInfo(Node.Data).Free;
    Node.Free;
  end;
  if TreeView.Items.Count = 0 then SetItem(nil);
  SetStates;
  Apply.Enabled := True;
end;

procedure TClxListViewItems.ValueChange(Sender: TObject);
begin
  Apply.Enabled := True;
  if Sender = Text then TextExit(Sender);
end;

procedure TClxListViewItems.TextExit(Sender: TObject);
var
  Node: TTreeNode;
  ItemInfoSubs: TStrings;
  Index: Integer;
begin
  Node := TreeView.Selected;
  if Assigned(Node) then
  begin
    if not Assigned(Node.Data) then
    begin
      ItemInfoSubs := TItemInfo(Node.Parent.Data).FSubItems;
      Index := ItemInfoSubs.IndexOfObject(Node);
      if Index <> -1 then
        ItemInfoSubs[Index] := Text.Text;
    end
    else
      TItemInfo(Node.Data).FCaption := Text.Text;
    Node.Text := Text.Text;
  end;
end;

procedure TClxListViewItems.ImageExit(Sender: TObject);
var
  Node: TTreeNode;
  Index: Integer;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if (Node <> nil) then
      begin
        if (Node.Data <> nil) then
          TItemInfo(Node.Data).FImageIndex := StrToInt(Image.Text)
        else begin
          Index := TItemInfo(Node.Parent.Data).FSubItems.IndexOfObject(Node);
          TItemInfo(Node.Parent.Data).FSubItemImages[Index] := Pointer(StrToInt(Image.Text));
        end;
      end;
    except
      ConvertError(Image);
      raise;
    end;
end;

procedure TClxListViewItems.StateImageExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if (Node <> nil) and (Node.Data <> nil) then
        ; // TItemInfo(Node.Data).FStateIndex := StrToInt(StateImage.Text);
    except
      ConvertError(StateImage);
      raise;
    end;
end;

procedure TClxListViewItems.FormCreate(Sender: TObject);
begin
  HelpContext := hcDListViewItemEdit;
end;

procedure TClxListViewItems.ApplyClick(Sender: TObject);
var
  Node: TTreeNode;
  ListItem: TListItem;
begin
  FlushControls;
  Items.Clear;
  if TreeView.Items.Count > 0 then
    Node := TreeView.Items[0]
  else
    Node := nil;
  while Node <> nil do
  begin
    if Node.Data <> nil then
    begin
      ListItem := Items.Add;
      GetItem(TItemInfo(Node.Data), ListItem);
      Node := Node.GetNextSibling;
    end
  end;                      
  with TListView(Items.Owner) do
    UpdateItems(0, Items.Count -1);
  Apply.Enabled := False;
end;

procedure TClxListViewItems.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
{var
  Node, SelNode: TTreeNode;
  Child: Boolean;}
begin
{
  Child := GetKeyState(VK_SHIFT) < 0;
  SelNode := TreeView.Selected;
  Node := TreeView.GetNodeAt(X, Y);
  if Node = nil then Node := TreeView.DropTarget;
  if Node = nil then
    Accept := False
  else
    Accept := (SelNode <> Node) and not (Child and SelNode.HasAsParent(Node))
      and not Node.HasAsParent(SelNode)
      and not (SelNode.HasChildren and (Node.Data = nil))
      and not (Child and (Node.Data <> nil) and SelNode.HasChildren);\
}
end;

procedure TClxListViewItems.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  {Node, }SelNode: TTreeNode;
  Child: Boolean;

  procedure AddItem(Source, Dest: TTreeNode);
  var
    ItemInfoSubs: TStrings;
  begin
    // dropping from child to child
    if (Source.Data = nil) and (Dest.Data = nil) then
    begin
      // remove child from parent list
      ItemInfoSubs := TItemInfo(Source.Parent.Data).FSubItems;
      ItemInfoSubs.Delete(ItemInfoSubs.IndexOfObject(Source));
      // move child to new parent
      Source.MoveTo(Dest, naAdd);
      // add child to new parent list
      TItemInfo(Dest.Parent.Data).FSubItems.AddObject(Source.Text, Source);
    end
    // dropping from a parent to a parent
    else if (Source.Data <> nil) and (Dest.Data <> nil) then
    begin
      if not Child then
        Source.MoveTo(Dest, naInsert)
      else begin
        TItemInfo(Source.Data).Free;
        Source.Data := nil;
        // make Source a child of Dest
        Source.MoveTo(Dest, naAddChild);
        // add child to new parent list
        TItemInfo(Dest.Data).FSubItems.AddObject(Source.Text, Source);
      end;
    end
    // dropping from parent to child
    else if (Source.Data <> nil) and (Dest.Data = nil) then
    begin
      // remove Source's parent node data
      TItemInfo(Source.Data).Free;
      Source.Data := nil;
      // make Source a child of Dest
      Source.MoveTo(Dest, naAdd);
      // add child to new parent list
      TItemInfo(Dest.Parent.Data).FSubItems.AddObject(Source.Text, Source);
    end
    // dropping from child to parent
    else if (Source.Data = nil) and (Dest.Data <> nil) then
    begin
      // remove child from parent list
      ItemInfoSubs := TItemInfo(Source.Parent.Data).FSubItems;
      ItemInfoSubs.Delete(ItemInfoSubs.IndexOfObject(Source));
      if Child then
      begin
        // move child to new parent
        Source.MoveTo(Dest, naAddChild);
        // add child to new parent list
        TItemInfo(Dest.Data).FSubItems.AddObject(Source.Text, Source);
      end
      else begin
        // move child to be sibling of Dest
        Source.MoveTo(Dest, naInsert);
        // create Parent node item info for Source
        Source.Data := TItemInfo.Create(nil);
      end;
    end;
  end;

begin
  with TreeView do
  begin
    SelNode := Selected;
    if (SelNode <> nil) then
    begin
      {
      Child := GetKeyState(VK_SHIFT) < 0;
      Node := TreeView.DropTarget; //GetNodeAt(X, Y);
      if Node = nil then
      begin
        Node := Items[Items.Count - 1];
        while (Node <> nil) and not Node.IsVisible do
          Node := Node.GetPrev;
      end;
      if Node <> nil then
        try
          if Child and (Node.Parent <> nil) then Node := Node.Parent;
          FDropping := True;
          AddItem(SelNode, Node);
          SelNode.Selected := True;
          Apply.Enabled := True;
        finally
          FDropping := False;
        end;
      }
    end;
  end;
end;

procedure TClxListViewItems.TreeViewEdited(Sender: TObject; Node: TTreeNode;
  var S: WideString);
begin
  Text.Text := S;
  TextExit(nil);
  New.Default := True;
end;

procedure TClxListViewItems.Button7Click(Sender: TObject);
begin
  InvokeHelp;
end;

procedure TClxListViewItems.TreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // PostMessage(Handle, UM_TREEEDIT, Key, Longint(Self));
end;

procedure TClxListViewItems.TreeViewEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  New.Default := False;
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
  ShowCollectionEditor(FDesigner, FComponent, TListView(FComponent).Columns, 'Columns');
  Free;
end;

{ TListViewEditor }

procedure TListViewEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: with TEditInvoker.Create(Designer, Component) do
         InvokeEdit;
    1: if EditListViewItems(TListView(Component).Items) and
       Assigned(Designer) then
         Designer.Modified;
  end;
end;

function TListViewEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SListColumnsEditor;
    1: Result := SListItemsEditor;
  end;
end;

function TListViewEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TListViewColumnsProperty }

procedure TListViewColumnsProperty.Edit;
var
  Component: TComponent;
begin
  Component := TComponent(GetComponent(0));
  if not Assigned(Component) then
    Exit;
  ShowCollectionEditor(Designer, Component, TListView(Component).Columns, 'Columns');
end;

function TListViewColumnsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paRevertable, paVCL];
end;

{ TListViewItemsProperty }

procedure TListViewItemsProperty.Edit;
var
  Component: TComponent;
begin
  Component := TComponent(GetComponent(0));
  if not Assigned(Component) then
    Exit;
  if EditListViewItems(TListView(Component).Items) and
  Assigned(Designer) then
    Designer.Modified;
end;

function TListViewItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paRevertable];
end;

end.

