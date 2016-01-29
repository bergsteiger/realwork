
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{                                                                   }
{       Copyright (c) 1998-2000 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE and ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL and PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS and ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE and ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   and PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxsbrsed;

interface
{$I dxSBVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dximctrl, ExtCtrls, dxsbar, {$IFDEF DELPHI6}DesignIntf{$ELSE}DsgnIntf{$ENDIF};

type
  TfrmSideBarStoreEditor = class(TdxSideBarStoreDesigner)
    Panel1: TPanel;
    Panel2: TPanel;
    ListBox: TListBox;
    LItemCaption: TLabel;
    EItemCaption: TEdit;
    LLImage: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    GBGroups: TGroupBox;
    BGAdd: TButton;
    BGInsert: TButton;
    BGDelete: TButton;
    BGRename: TButton;
    BGMoveUp: TButton;
    BGMoveDown: TButton;
    Panel5: TPanel;
    GBItems: TGroupBox;
    BIAdd: TButton;
    BIDelete: TButton;
    BIClear: TButton;
    BIMoveUp: TButton;
    BIMoveDown: TButton;
    LSImage: TLabel;
    BClose: TButton;
    BHelp: TButton;
    ImageListBox: TdxImageListBox;
    SILImage: TdxSpinImage;
    SISImage: TdxSpinImage;
    EItemHint: TEdit;
    LItemHint: TLabel;
    procedure BGAddClick(Sender: TObject);
    procedure BGInsertClick(Sender: TObject);
    procedure BGRenameClick(Sender: TObject);
    procedure BGDeleteClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure BIAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageListBoxClick(Sender: TObject);
    procedure BGMoveUpClick(Sender: TObject);
    procedure BGMoveDownClick(Sender: TObject);
    procedure EItemCaptionExit(Sender: TObject);
    procedure SIImageChange(Sender: TObject; ItemIndex: Integer);
    procedure BIDeleteClick(Sender: TObject);
    procedure BIClearClick(Sender: TObject);
    procedure BIMoveUpClick(Sender: TObject);
    procedure BIMoveDownClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImageListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImageListBoxEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure SISImageChange(Sender: TObject; ItemIndex: Integer);
    procedure BCloseClick(Sender: TObject);
    procedure EItemHintExit(Sender: TObject);
  private
    FLockUpdate: Boolean;
    ActiveItem: TdxStoredSideItem;
    FDesigner: {$IFDEF DELPHI6}IDesigner{$ELSE}{$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}{$ENDIF};
    procedure WMGetMinMaxInfo(var Message: TMessage); message WM_GETMINMAXINFO;
    procedure SelectComponent(AComponent: TComponent);
  protected  
    procedure CloseSideBarStoreEditor; override;
    procedure SideBarStoreEditorUpdate; override;
    procedure SideBarStoreEditorUpdateItem(AItem: TdxStoredSideItem); override;
  end;


procedure ShowSideBarStoreEditor(AStore: TdxSideBarStore;
        ADesigner: {$IFDEF DELPHI6}IDesigner{$ELSE}{$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}{$ENDIF});

implementation

uses dxsbrgre, dxreginf;

{$R *.DFM}

procedure ShowSideBarStoreEditor(AStore: TdxSideBarStore;
        ADesigner: {$IFDEF DELPHI6}IDesigner{$ELSE}{$IFDEF DELPHI4}IFormDesigner{$ELSE}TFormDesigner{$ENDIF}{$ENDIF});
var
  AForm: TfrmSideBarStoreEditor;
begin
  if (AStore.Designer = nil) then
  begin
    AStore.Designer := TfrmSideBarStoreEditor.Create(nil);
    with TfrmSideBarStoreEditor(AStore.Designer) do
    begin
      FDesigner := ADesigner;
      ListBox.Items.Assign(AStore.Categories);
      if (ListBox.Items.Count > 0) then
        ListBox.ItemIndex := 0;
    end;
  end;

  AForm := TfrmSideBarStoreEditor(AStore.Designer);
  AForm.Store := AStore;
  AForm.SideBarStoreEditorUpdate;
  AForm.ListBoxClick(nil);
  AForm.Show;
end;

procedure TfrmSideBarStoreEditor.CloseSideBarStoreEditor;
begin
  Close;
end;

procedure TfrmSideBarStoreEditor.SideBarStoreEditorUpdate;
begin
   Caption := 'SideBarStore Editor:' + Store.Name;
   ImageListBox.ImageList := Store.LargeImages;
   SILImage.ImageList := Store.LargeImages;
   SISImage.ImageList := Store.SmallImages;
end;

procedure TfrmSideBarStoreEditor.SideBarStoreEditorUpdateItem(AItem: TdxStoredSideItem);
begin
  if (AItem <> nil) then
  begin
    if (ListBox.ItemIndex < 0) then Exit;
    if (ListBox.ItemIndex <> AItem.Category) then
    begin
      if (ImageListBox.Items.Count <>
        Store.GetCountByCategory(ListBox.Items[ListBox.ItemIndex])) then
        ListBoxClick(nil);
    end else
    begin
       ImageListBoxClick(nil);
       EItemCaptionExit(nil);
    end;
  end;
end;

procedure TfrmSideBarStoreEditor.WMGetMinMaxInfo(var Message: TMessage);
var
   P: PMinMaxInfo;
begin
    P:=PMinMaxInfo(Message.lParam);
    P^.ptMinTrackSize.X:= 450;
    P^.ptMinTrackSize.Y:= 315;
end;

procedure TfrmSideBarStoreEditor.SelectComponent(AComponent: TComponent);
begin
  if not (csDestroying in Store.ComponentState) and  (csDesigning in Store.ComponentState) then
  FDesigner.SelectComponent(AComponent);
end;

procedure TfrmSideBarStoreEditor.BGAddClick(Sender: TObject);
var
  St: String;
begin
  St := '';
  if ESideBarGroupRename(St, 0) then
  begin
    Store.Categories.Add(St);
    ListBox.Items.Add(St);
  end;
end;

procedure TfrmSideBarStoreEditor.BGInsertClick(Sender: TObject);
var
  St: String;
begin
  St := '';
  if ESideBarGroupRename(St, 1) then
  begin
    Store.Categories.Insert(ListBox.ItemIndex, St);
    ListBox.Items.Insert(ListBox.ItemIndex, St);
  end;
end;

procedure TfrmSideBarStoreEditor.BGRenameClick(Sender: TObject);
var
  St: String;
  Index: Integer;
begin
  if (ListBox.ItemIndex > -1) then
  begin
    Index := ListBox.ItemIndex;
    St := ListBox.Items[ListBox.ItemIndex];
    if ESideBarGroupRename(St, 2) then
    begin
      Store.Categories[ListBox.ItemIndex] := St;
      ListBox.Items[ListBox.ItemIndex] := St;
    end;
    ListBox.ItemIndex := Index;
  end
end;

procedure TfrmSideBarStoreEditor.BGDeleteClick(Sender: TObject);
var
  Index: Integer;
begin
  if (ListBox.ItemIndex > -1) then
  begin
    Index := ListBox.ItemIndex;
    Store.Categories.Delete(ListBox.ItemIndex);
    if (Store.Categories.Count <> ListBox.Items.Count) then
      ListBox.Items.Delete(ListBox.ItemIndex);
    if (Index >= ListBox.Items.Count) then
      Dec(Index);
    ListBox.ItemIndex := Index;
    ListBoxClick(Sender);
  end;
end;

procedure TfrmSideBarStoreEditor.ListBoxClick(Sender: TObject);
var
  List: TList;
  I: Integer;
  item: TdxStoredSideItem;
begin
  ImageListBox.Items.Clear;
  if (ListBox.ItemIndex > -1) then
  begin
    List := TList.Create;
    Store.GetItemsByCategory(ListBox.Items[ListBox.ItemIndex], List);
    for I := 0 to List.Count - 1 do
    begin
      Item := TdxStoredSideItem(List[I]);
      ImageListBox.AddItem(Item.Caption, Item.LargeImage)
    end;
    List.Free;
  end;
  if (ImageListBox.Items.Count > 0) then
    ImageListBox.ItemIndex := 0;
  ImageListBoxClick(Sender);
end;

procedure TfrmSideBarStoreEditor.BIAddClick(Sender: TObject);
var
  item: TdxStoredSideItem;
  I: Integer;
  flag: Boolean;
begin
  item := TdxStoredSideItem.Create(Store.Owner);
  item.Store := Store;
  item.Category := ListBox.ItemIndex;
  I := Store.Count;
  flag := True;
  while Flag do begin
    try
      item.Name := Store.Name + 'Item' + IntToStr(I);
      flag := False;
    except
      Inc(I);
    end;
  end;
  ImageListBox.AddItem(Item.Caption, -1);
  ImageListBox.ItemIndex := ImageListBox.Items.Count - 1;
  ImageListBoxClick(Sender);
end;


procedure TfrmSideBarStoreEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Store.Designer := nil;
  SelectComponent(Store);
  StoreExpressFormsInformation(self);
  Action := caFree;
end;

procedure TfrmSideBarStoreEditor.ImageListBoxClick(Sender: TObject);
var
  AComponent: TComponent;
begin
  ActiveItem := nil;
  if (ImageListBox.ItemIndex > -1) then
    ActiveItem := Store.GetItemByCategory(ListBox.Items[ListBox.ItemIndex], ImageListBox.ItemIndex);

  EItemCaption.Enabled := ActiveItem <> nil;
  EItemHint.Enabled := EItemCaption.Enabled;
  SILImage.Enabled := EItemCaption.Enabled and (SILImage.ImageList <> nil);
  SISImage.Enabled := EItemCaption.Enabled and (SISImage.ImageList <> nil);
  if (ActiveItem <> nil) then
  begin
    FLockUpdate := True;
    EItemCaption.Text := ActiveItem.Caption;
    EItemHint.Text := ActiveItem.Hint;
    SILImage.ItemIndex := ActiveItem.LargeImage;
    SISImage.ItemIndex := ActiveItem.SmallImage;
    FLockUpdate := False;
  end else begin
    EItemCaption.Text := '';
    EItemHint.Text := '';
    SILImage.ItemIndex := -1;
    SISImage.ItemIndex := -1;
  end;
  if (Sender <> nil) then
  begin
    if (ActiveItem <> nil) then
      AComponent := ActiveItem
    else AComponent := Store;
    SelectComponent(AComponent);
  end;
end;

procedure TfrmSideBarStoreEditor.BGMoveUpClick(Sender: TObject);
var
  Index: Integer;
begin
  if ListBox.ItemIndex >  0 then
  begin
    Index := ListBox.ItemIndex;
    ListBox.Items.Exchange(Index, Index - 1);
    Store.Categories.Exchange(Index, Index - 1);
    ListBox.ItemIndex := Index - 1;
    ListBoxClick(Sender);
  end;
end;

procedure TfrmSideBarStoreEditor.BGMoveDownClick(Sender: TObject);
var
  Index: Integer;
begin
  if ListBox.ItemIndex < ListBox.Items.Count - 1 then
  begin
    Index := ListBox.ItemIndex;
    ListBox.Items.Exchange(Index, Index + 1);
    Store.Categories.Exchange(Index, Index + 1);
    ListBox.ItemIndex := Index + 1;
    ListBoxClick(Sender);
  end;
end;

procedure TfrmSideBarStoreEditor.EItemCaptionExit(Sender: TObject);
var
  Index, ImageIndex: Integer;
begin
  if ActiveItem <> nil then
  begin
    ActiveItem.Caption := EItemCaption.Text;
    ImageIndex := ActiveItem.LargeImage;
    Index := ImageListBox.ItemIndex;
    ImageListBox.Items[ImageListBox.ItemIndex] := EItemCaption.Text;
    ImageListBox.ImageIndexes[Index] := ImageIndex;
    ImageListBox.ItemIndex := Index;
    if (Sender <> nil) then
      SelectComponent(Store);
  end;
end;

procedure TfrmSideBarStoreEditor.SIImageChange(Sender: TObject;
  ItemIndex: Integer);
begin
  if (ActiveItem <> nil) and not FLockUpdate  then
  begin
    ActiveItem.LargeImage := ItemIndex;
    ImageListBox.ImageIndexes[ImageListBox.ItemIndex] := ItemIndex;
    if (Sender <> nil) then
     SelectComponent(Store);
  end;
end;

procedure TfrmSideBarStoreEditor.BIDeleteClick(Sender: TObject);
var
  Index: Integer;
begin
  if ActiveItem <> nil then
  begin
    Index := ImageListBox.ItemIndex;
    ActiveItem.Free;
    ImageListBox.Items.Delete(Index);
    if (Index >= ImageListBox.Items.Count) then
      Dec(Index);
    ImageListBox.ItemIndex := Index;
    ImageListBoxClick(Sender);
  end;
end;

procedure TfrmSideBarStoreEditor.BIClearClick(Sender: TObject);
var
  List: TList;
  I: Integer;
  item: TdxStoredSideItem;
begin
  ImageListBox.Items.Clear;
  if ListBox.ItemIndex > -1 then
  begin
    List := TList.Create;
    Store.GetItemsByCategory(ListBox.Items[ListBox.ItemIndex], List);
    for I := 0 to List.Count - 1 do
    begin
      Item := TdxStoredSideItem(List[I]);
      Item.Free;
    end;
    List.Free;
  end;
  ImageListBoxClick(Sender);
end;

procedure TfrmSideBarStoreEditor.BIMoveUpClick(Sender: TObject);
var
  Index: Integer;
  Item1, Item2: TdxStoredSideItem;
begin
  if ImageListBox.ItemIndex >  0 then
  begin
    Index := ImageListBox.ItemIndex;
    Item1 := Store.GetItemByCategory(ListBox.Items[ListBox.ItemIndex], Index);
    Item2 := Store.GetItemByCategory(ListBox.Items[ListBox.ItemIndex], Index - 1);
    ImageListBox.ExchangeItems(Index, Index - 1);
    Store.ExchangeItems(Item1, Item2);
    ImageListBox.ItemIndex := Index - 1;
    ImageListBoxClick(Sender);
  end;
end;

procedure TfrmSideBarStoreEditor.BIMoveDownClick(Sender: TObject);
var
  Index: Integer;
  Item1, Item2: TdxStoredSideItem;
begin
  if ImageListBox.ItemIndex < ImageListBox.Items.Count - 1 then
  begin
    Index := ImageListBox.ItemIndex;
    Item1 := Store.GetItemByCategory(ListBox.Items[ListBox.ItemIndex], Index);
    Item2 := Store.GetItemByCategory(ListBox.Items[ListBox.ItemIndex], Index + 1);
    ImageListBox.ExchangeItems(Index, Index + 1);
    Store.ExchangeItems(Item1, Item2);
    ImageListBox.ItemIndex := Index + 1;
    ImageListBoxClick(Sender);
  end;
end;

procedure TfrmSideBarStoreEditor.FormCreate(Sender: TObject);
begin
  RestoreExpressFormsInformation(self);
end;

procedure TfrmSideBarStoreEditor.ImageListBoxDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
 p: TPoint;
 item: Integer;
begin
  if ImageListBox.ItemIndex = -1 then Exit;
  Accept := False;  
  p.x := X;
  p.y := Y;
  item := ImageListBox.ItemAtPos(p, True);
  if (item > -1) and (item < ImageListBox.Items.Count) then
    Accept := not ImageListBox.Selected[Item];
end;

procedure TfrmSideBarStoreEditor.ListBoxDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
 p: TPoint;
 item: Integer;
begin
  if ImageListBox.ItemIndex = -1 then
    Exit;
  Accept := False;
  p.x := X;
  p.y := Y;
  item := ListBox.ItemAtPos(p, True);
  if (item > -1) and (item < ListBox.Items.Count) then
    Accept := not ListBox.Selected[Item];
end;

procedure TfrmSideBarStoreEditor.ImageListBoxEndDrag(Sender,
  Target: TObject; X, Y: Integer);
var
 p: TPoint;
 item: Integer;
 Index: Integer;
 Item1, Item2: TdxStoredSideItem;
begin
  if ImageListBox.ItemIndex = -1 then Exit;
  p.x := X;
  p.y := Y;
  if (Target = ListBox) then
  begin
    item := ListBox.ItemAtPos(p, True);
    if (item > -1) and (item < ListBox.Items.Count) and not ListBox.Selected[Item] then
    begin
      Item1 := Store.GetItemByCategory(ListBox.Items[ListBox.ItemIndex], ImageListBox.ItemIndex);
      Item1.Category := item;
      ListBoxClick(Sender);
    end;
  end;
  if Target = ImageListBox then
  begin
    item := ImageListBox.ItemAtPos(p, True);
    if (item > -1) and (item < ImageListBox.Items.Count)
      and not ImageListBox.Selected[Item] then
    begin
     Index := ImageListBox.ItemIndex;
     Item1 :=   Store.GetItemByCategory(
                ListBox.Items[ListBox.ItemIndex], Index);
     Item2 :=   Store.GetItemByCategory(
               ListBox.Items[ListBox.ItemIndex], Item);
     ImageListBox.ExchangeItems(Index, Item);
     Store.ExchangeItems(Item1, Item2);
     ImageListBox.ItemIndex := Item;
     ImageListBoxClick(Sender);
    end;
  end;
end;

procedure TfrmSideBarStoreEditor.SISImageChange(Sender: TObject;
  ItemIndex: Integer);
begin
  if (ActiveItem <> nil) and not FLockUpdate then
  begin
    ActiveItem.SmallImage := ItemIndex;
    if (Sender <> nil) then
     SelectComponent(Store);
  end;
end;

procedure TfrmSideBarStoreEditor.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSideBarStoreEditor.EItemHintExit(Sender: TObject);
begin
  if (ActiveItem <> nil) then
  begin
    ActiveItem.Hint := EItemHint.Text;
    SelectComponent(Store);
  end;
end;

end.


