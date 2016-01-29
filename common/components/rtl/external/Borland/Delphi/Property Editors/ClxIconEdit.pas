{ ********************************************************************** }
{                                                                        }
{ Delphi and Kylix Cross-Platform Visual Component Library               }
{ Component and Property Editor Source                                   }
{                                                                        }
{ Copyright (C) 2000, 2001 Borland Software Corporation                  }
{                                                                        }
{ Licensees holding valid Kylix Desktop Developer Edition or             }
{ Kylix Server Developer Edition licenses may use this file in           }
{ accordance with the Borland No-Nonsense License Agreement              }
{ provided with the Software, appearing in the file license.txt.         }
{                                                                        }
{ ********************************************************************** }


unit ClxIconEdit;

interface

uses
  SysUtils, Classes, QGraphics, QForms, QDialogs,
  LibHelp, DesignIntf, DesignEditors, DsnConst, QStdCtrls, QComCtrls, QControls;

type
  TItemInfo = class(TObject)
  private
    FCaption: string;
    FImageIndex: Integer;
  public
    constructor Create(Item: TIconViewItem);
  end;

  TClxIconViewItemsEditor = class(TForm)
    GroupBox1: TGroupBox;
    PropGroupBox: TGroupBox;
    New: TButton;
    Delete: TButton;
    Label1: TLabel;
    Label2: TLabel;
    TreeView: TTreeView;
    Text: TEdit;
    Image: TEdit;
    Button4: TButton;
    Cancel: TButton;
    Apply: TButton;
    Button7: TButton;
    procedure NewClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ValueChange(Sender: TObject);
    procedure TextExit(Sender: TObject);
    procedure ImageExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: string);
    procedure Button7Click(Sender: TObject);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeViewEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
  private
    FItems: TIconViewItems;
    procedure FlushControls;
    procedure GetItem(ItemInfo: TItemInfo; Value: TIconViewItem);
    procedure SetItem(Value: TItemInfo);
    procedure SetStates;
  public
    property Items: TIconViewItems read FItems;
  end;

{ TIconViewEditor }

type
  TIconViewEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TIconViewItemsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

function EditIconViewItems(AItems: TIconViewItems): Boolean;

implementation

uses Qt;

{$R *.xfm}

function EditIconViewItems(AItems: TIconViewItems): Boolean;
var
  I: Integer;
  ItemInfo: TItemInfo;
begin
  with TClxIconViewItemsEditor.Create(Application) do
    try
      FItems := AItems;
      for I := 0 to Items.Count - 1 do
      begin
        ItemInfo := TItemInfo.Create(Items[I]);
        TreeView.Items.AddObject(nil, ItemInfo.FCaption, ItemInfo);
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

constructor TItemInfo.Create(Item: TIconViewItem);
begin
  inherited Create;
  if Item <> nil then
  begin
    with Item do
    begin
      FCaption := Caption;
      FImageIndex := ImageIndex;
    end;
  end
  else
    FImageIndex := -1;
end;

{ TClxIconViewItemsEditor }

procedure TClxIconViewItemsEditor.SetStates;
begin
  Delete.Enabled := TreeView.Items.Count > 0;
  PropGroupBox.Enabled := Delete.Enabled;
  if not PropGroupBox.Enabled then
    New.SetFocus;
  Apply.Enabled := False;
end;

procedure TClxIconViewItemsEditor.GetItem(ItemInfo: TItemInfo; Value: TIconViewItem);
begin
  with Value do
  begin
    Caption := ItemInfo.FCaption;
    ImageIndex := ItemInfo.FImageIndex;
  end;
end;

procedure TClxIconViewItemsEditor.SetItem(Value: TItemInfo);
begin
  Image.Enabled := True;
  if Value <> nil then
    with Value do
    begin
      Text.Text := FCaption;
      Image.Text := IntToStr(FImageIndex);
    end
  else begin
    Text.Text := '';
    Image.Text := '';
  end;
end;

procedure TClxIconViewItemsEditor.FlushControls;
begin
  TextExit(nil);
  ImageExit(nil);
end;

procedure TClxIconViewItemsEditor.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  TempEnabled: Boolean;
begin
  TempEnabled := Apply.Enabled;
  if Node <> nil then
  begin
    SetStates;
    SetItem(TItemInfo(Node.Data));
  end
  else SetItem(nil);
  Apply.Enabled := TempEnabled;
end;

procedure TClxIconViewItemsEditor.NewClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Items.AddObject(nil, '', TItemInfo.Create(nil));
  Node.MakeVisible;
  TreeView.Selected := Node;
  Text.SetFocus;
  Apply.Enabled := True;
end;

procedure TClxIconViewItemsEditor.DeleteClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  if Node <> nil then
  begin
    TItemInfo(Node.Data).Free;
    Node.Free;
  end;
  if TreeView.Items.Count = 0 then SetItem(nil);
  SetStates;
  Apply.Enabled := True;
end;

procedure TClxIconViewItemsEditor.ValueChange(Sender: TObject);
begin
  Apply.Enabled := True;
  if Sender = Text then TextExit(Sender);
end;

procedure TClxIconViewItemsEditor.TextExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TreeView.Selected;
  if Node <> nil then
  begin
    TItemInfo(Node.Data).FCaption := Text.Text;
    Node.Text := Text.Text;
  end;
end;

procedure TClxIconViewItemsEditor.ImageExit(Sender: TObject);
var
  Node: TTreeNode;
begin
  if ActiveControl <> Cancel then
    try
      Node := TreeView.Selected;
      if (Node <> nil) then
      begin
        if (Node.Data <> nil) then
          TItemInfo(Node.Data).FImageIndex := StrToInt(Image.Text);
      end;
    except
      ConvertError(Image);
      raise;
    end;
end;

procedure TClxIconViewItemsEditor.FormCreate(Sender: TObject);
begin
  HelpContext := hcDIconViewItemEdit;
end;

procedure TClxIconViewItemsEditor.ApplyClick(Sender: TObject);
var
  Node: TTreeNode;
  IconViewItem: TIconViewItem;
begin
  FlushControls;
  Items.BeginUpdate;
  try
    Items.Clear;
    if TreeView.Items.Count > 0 then Node := TreeView.Items[0]
    else Node := nil;
    while Node <> nil do
    begin
      if Node.Data <> nil then
      begin
        IconViewItem := Items.Add;
        GetItem(TItemInfo(Node.Data), IconViewItem);
        Node := Node.GetNextSibling;
      end
    end;
  finally
    Items.EndUpdate;
  end;
  with TIconView(Items.Owner) do UpdateItems(0, Items.Count -1);
  Apply.Enabled := False;
end;

procedure TClxIconViewItemsEditor.TreeViewEdited(Sender: TObject; Node: TTreeNode;
  var S: string);
begin
  Text.Text := S;
  TextExit(nil);
  New.Default := True;
end;

procedure TClxIconViewItemsEditor.Button7Click(Sender: TObject);
begin
  InvokeHelp;
end;

procedure TClxIconViewItemsEditor.TreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // PostMessage(Handle, UM_TREEEDIT, Key, Longint(Self));
end;

procedure TClxIconViewItemsEditor.TreeViewEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  New.Default := False;
end;

{ TIconViewEditor }

resourcestring
  SIconViewEditor = 'Items Editor...';

procedure TIconViewEditor.ExecuteVerb(Index: Integer);
begin
  if EditIconViewItems(TIconView(Component).Items) and
  Assigned(Designer) then
    Designer.Modified;
end;

function TIconViewEditor.GetVerb(Index: Integer): string;
begin
  Result := SIconViewEditor;
end;

function TIconViewEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TIconViewItemsProperty }

procedure TIconViewItemsProperty.Edit;
var
  Component: TComponent;
begin
  Component := TComponent(GetComponent(0));
  if not Assigned(Component) then
    Exit;
  if EditIconViewItems(TIconView(Component).Items) and
  Assigned(Designer) then
    Designer.Modified;
end;

function TIconViewItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paRevertable];
end;

end.

