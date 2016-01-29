{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit ItemEdit;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, DsnConst;

const
  UM_TREEEDIT = WM_USER;

type
  TItemInfo = class(TObject)
  private
    FSubItems: TStringList;
    FSubItemImages: TList;
    FCaption: string;
    FImageIndex: Integer;
    FStateIndex: Integer;
    FGroupID: Integer;
  public
    constructor Create(Item: TListItem);
    destructor Destroy; override;
  end;

  TListViewItems = class(TForm)
    GroupBox1: TGroupBox;
    PropGroupBox: TGroupBox;
    New: TButton;
    Delete: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TreeView: TTreeView;
    NewSub: TButton;
    CaptionEdit: TEdit;
    Image: TEdit;
    StateImage: TEdit;
    OkButton: TButton;
    Cancel: TButton;
    Apply: TButton;
    Button7: TButton;
    Label4: TLabel;
    cbGroupID: TComboBox;
    procedure NewClick(Sender: TObject);
    procedure NewSubClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ValueChange(Sender: TObject);
    procedure CaptionEditExit(Sender: TObject);
    procedure ImageExit(Sender: TObject);
    procedure StateImageExit(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: string);
    procedure Button7Click(Sender: TObject);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeViewEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbGroupIDChange(Sender: TObject);
  private
    FItems: TListItems;
    FDropping: Boolean;
    procedure FlushControls;
    procedure GetItem(ItemInfo: TItemInfo; Value: TListItem);
    procedure SetItem(Value: TItemInfo);
    procedure SetStates;
    procedure SetSubItem(const S: string; ImageIndex: Integer);
    procedure UMTreeEdit(var M: TMessage); message UM_TREEEDIT;
  public
    property Items: TListItems read FItems;
  end;

function EditListViewItems(AItems: TListItems): Boolean;

implementation

uses CommCtrl;

{$R *.dfm}

var
  SavedWidth, SavedHeight, SavedLeft, SavedTop: Integer;

function EditListViewItems(AItems: TListItems): Boolean;
var
  I, J: Integer;
  Node: TTreeNode;
  ItemInfo: TItemInfo;
  ListView: TListView;
begin
  with TListViewItems.Create(Application)do
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

      ListView := TListView(FItems.Owner);
      cbGroupID.AddItem(SItemEditNoGroupID, nil);
      for I := 0 to ListView.Groups.Count - 1 do
        cbGroupID.AddItem(Format(SItemEditGroupIDStr, [ListView.Groups[I].GroupID, ListView.Groups[I].Header]), ListView.Groups[I]);
      

      with TreeView do
        if Items.Count > 0 then
        begin
          Selected := Items.GetFirstNode;
          TreeViewChange(nil, Selected);
        end;
      SetStates;

      Result := ShowModal = mrOK;
      if Result and Apply.Enabled then ApplyClick(nil);
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
  FGroupID := -1;
  if Item <> nil then
    with Item do
    begin
      FCaption := Caption;
      FImageIndex := ImageIndex;
      FStateIndex := StateIndex;
      FGroupID := GroupID;
      FSubItems.Assign(SubItems);
      for I := 0 to SubItems.Count-1 do
        FSubItemImages.Add(Pointer(SubItemImages[I]));
    end;
end;

destructor TItemInfo.Destroy;
begin
  FSubItems.Free;
  FSubItemImages.Free;
  inherited Destroy;
end;

{ TListViewItems }

procedure TListViewItems.SetStates;
begin
  Delete.Enabled := TreeView.Items.Count > 0;
  PropGroupBox.Enabled := Delete.Enabled;
  Apply.Enabled := False;
  NewSub.Enabled := TreeView.Selected <> nil;
end;

procedure TListViewItems.GetItem(ItemInfo: TItemInfo; Value: TListItem);
var
  I: Integer;
begin
  with Value do
  begin
    Caption := ItemInfo.FCaption;
    ImageIndex := ItemInfo.FImageIndex;
    StateIndex := ItemInfo.FStateIndex;
    GroupID := ItemInfo.FGroupID;
    SubItems.Assign(ItemInfo.FSubItems);
    for I := 0 to ItemInfo.FSubItems.Count - 1 do
      SubItemImages[I] := Integer(ItemInfo.FSubItemImages[I]);
  end;
end;

procedure TListViewItems.SetSubItem(const S: string; ImageIndex: Integer);
begin
  StateImage.Enabled := False;
  cbGroupID.Enabled := False;
  Image.Text := IntToStr(ImageIndex);
  CaptionEdit.Text := S;
end;

procedure TListViewItems.SetItem(Value: TItemInfo);
var
  I: Integer;
begin
  Image.Enabled := True;
  StateImage.Enabled := True;
  cbGroupID.Enabled := True;
  if Value <> nil then
    with Value do
    begin
      CaptionEdit.Text := FCaption;
      Image.Text := IntToStr(FImageIndex);
      StateImage.Text := IntToStr(FStateIndex);

      if FGroupID < 0 then
        cbGroupID.ItemIndex := 0
      else
      begin
        for I := 1 to cbGroupID.Items.Count - 1 do
        begin
          if TListGroup(cbGroupID.Items.Objects[I]).GroupID = FGroupID then
          begin
            cbGroupID.ItemIndex := I;
            break;
          end;
        end;
      end;
    end
  else begin
    CaptionEdit.Text := '';
    Image.Text := '';
    StateImage.Text := '';
  end;
end;

procedure TListViewItems.FlushControls;
begin
  CaptionEditExit(nil);
  ImageExit(nil);
  StateImageExit(nil);
end;

procedure TListViewItems.TreeViewChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if not FDropping then FlushControls;
end;

procedure TListViewItems.TreeViewChange(Sender: TObject; Node: TTreeNode);
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
      SetSubItem(ItemInfoSubs[Index], Integer(TItemInfo(Node.Parent.Data).FSubItemImages[Index]));
    end;
  end
  else SetItem(nil);
  Apply.Enabled := TempEnabled;
end;

procedure TListViewItems.NewClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Items.AddObject(nil, '', TItemInfo.Create(nil));
  Node.MakeVisible;
  TreeView.Selected := Node;
  CaptionEdit.SetFocus;
  Apply.Enabled := True;
end;

procedure TListViewItems.NewSubClick(Sender: TObject);
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
  CaptionEdit.SetFocus;
  Apply.Enabled := True;
end;

procedure TListViewItems.DeleteClick(Sender: TObject);
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
      TItemInfo(Node.Parent.Data).FSubItems.Delete(Index);
      TItemInfo(Node.Parent.Data).FSubItemImages.Delete(Index);
    end
    else TItemInfo(Node.Data).Free;
    Node.Free;
  end;
  if TreeView.Items.Count = 0 then SetItem(nil);
  SetStates;
  Apply.Enabled := True;
end;

procedure TListViewItems.ValueChange(Sender: TObject);
begin
  Apply.Enabled := True;
  if Sender = CaptionEdit then CaptionEditExit(Sender);
end;

procedure TListViewItems.CaptionEditExit(Sender: TObject);
var
  Node: TTreeNode;
  ItemInfoSubs: TStrings;
begin
  Node := TreeView.Selected;
  if Node <> nil then
  begin
    if Node.Data = nil then
    begin
      ItemInfoSubs := TItemInfo(Node.Parent.Data).FSubItems;
      ItemInfoSubs[ItemInfoSubs.IndexOfObject(Node)] := CaptionEdit.Text;
    end
    else TItemInfo(Node.Data).FCaption := CaptionEdit.Text;
    Node.Text := CaptionEdit.Text;
  end;
end;

procedure TListViewItems.cbGroupIDChange(Sender: TObject);
var
  Node: TTreeNode;
begin
  ValueChange(Sender);

  Node := TreeView.Selected;
  if (Node <> nil) and (Node.Data <> nil) then
  begin
    if cbGroupID.ItemIndex = 0 then
    begin
      TItemInfo(Node.Data).FGroupID := -1;
    end
    else
    begin
      TItemInfo(Node.Data).FGroupID := TListGroup(cbGroupID.Items.Objects[cbGroupID.ItemIndex]).GroupID;
    end;
  end;
end;

procedure TListViewItems.ImageExit(Sender: TObject);
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

procedure TListViewItems.StateImageExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if (Node <> nil) and (Node.Data <> nil) then
        TItemInfo(Node.Data).FStateIndex := StrToInt(StateImage.Text);
    except
      ConvertError(StateImage);
      raise;
    end;
end;

procedure TListViewItems.ApplyClick(Sender: TObject);
var
  Node: TTreeNode;
  ListItem: TListItem;
begin
  FlushControls;
  Items.Clear;
  if TreeView.Items.Count > 0 then Node := TreeView.Items[0]
  else Node := nil;
  while Node <> nil do
  begin
    if Node.Data <> nil then
    begin
      ListItem := Items.Add;
      GetItem(TItemInfo(Node.Data), ListItem);
      Node := Node.GetNextSibling;
    end
  end;
  with TListView(Items.Owner) do UpdateItems(0, Items.Count -1);
  Apply.Enabled := False;
end;

procedure TListViewItems.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Node, SelNode: TTreeNode;
  Child: Boolean;
begin
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
      and not (Child and (Node.Data <> nil) and SelNode.HasChildren);
end;

procedure TListViewItems.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Node, SelNode: TTreeNode;
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
    end;
  end;
end;

procedure TListViewItems.TreeViewEdited(Sender: TObject; Node: TTreeNode;
  var S: string);
begin
  CaptionEdit.Text := S;
  CaptionEditExit(nil);
  New.Default := True;
end;

procedure TListViewItems.Button7Click(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TListViewItems.TreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  PostMessage(Handle, UM_TREEEDIT, Key, Longint(Self));
end;

procedure TListViewItems.UMTreeEdit(var M: TMessage);
var
  ItemInfoSubs: TStrings;
  TextBuf: array[0..255] of char;
  EditNode: TTreeNode;
  EditHand: HWnd;
begin
  if TreeView.IsEditing then
  begin
    EditNode := TreeView.Selected;
    EditHand := TreeView_GetEditControl(TreeView.Handle);
    if (EditHand = 0) or (EditNode = nil) then Exit;
    GetWindowText(EditHand, TextBuf, SizeOf(TextBuf));
    if EditNode.Data = nil then
    begin
      ItemInfoSubs := TItemInfo(EditNode.Parent.Data).FSubItems;
      ItemInfoSubs[ItemInfoSubs.IndexOfObject(EditNode)] := TextBuf;
    end
    else
      TItemInfo(EditNode.Data).FCaption := TextBuf;
    CaptionEdit.Text := TextBuf;
  end;
end;

procedure TListViewItems.TreeViewEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  New.Default := False;
end;

procedure TListViewItems.FormCreate(Sender: TObject);
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

procedure TListViewItems.FormDestroy(Sender: TObject);
begin
  SavedWidth := Width;
  SavedHeight := Height;
  SavedLeft := Left;
  SavedTop := Top;
end;

end.

