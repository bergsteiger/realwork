
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express side bar component editor                           }
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

unit dxsbared;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dximctrl, ExtCtrls, dxsbar, Menus;

type
  TfrmdxSideBarEditor = class(TForm)
    Panel3: TPanel;
    Bar: TdxSideBar;
    AutoOutLookPopupMenu1: TdxSideBarPopupMenu;
    Panel1: TPanel;
    Panel2: TPanel;
    BOk: TButton;
    BCancel: TButton;
    bHelp: TButton;
    BDefault: TButton;
    BIAdd: TButton;
    BIInsert: TButton;
    BIDelete: TButton;
    BIClear: TButton;
    BIMoveUp: TButton;
    BIMovedown: TButton;
    GGroup: TGroupBox;
    LIconType: TLabel;
    BGAdd: TButton;
    BGDelete: TButton;
    BGRename: TButton;
    CBGIType: TCheckBox;
    GItemProp: TGroupBox;
    LCustomData: TLabel;
    ECustomData: TEdit;
    LTag: TLabel;
    ETag: TEdit;
    SILarge: TdxSpinImage;
    SISmall: TdxSpinImage;
    LSILarge: TLabel;
    LSISmall: TLabel;
    LCaption: TLabel;
    ECaption: TEdit;
    BIDefault: TButton;
    GStoredItems: TGroupBox;
    CBStoredGroup: TComboBox;
    LBStoredItems: TdxImageListBox;
    Bevel1: TBevel;
    EHint: TEdit;
    LHint: TLabel;
    BGUp: TButton;
    BGDown: TButton;
    cbGroupVisible: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBStoredGroupClick(Sender: TObject);
    procedure BGAddClick(Sender: TObject);
    procedure BIAddClick(Sender: TObject);
    procedure BGRenameClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure CBGITypeClick(Sender: TObject);
    procedure BGDeleteClick(Sender: TObject);
    procedure BIInsertClick(Sender: TObject);
    procedure BIDeleteClick(Sender: TObject);
    procedure BIClearClick(Sender: TObject);
    procedure BIMoveUpClick(Sender: TObject);
    procedure BIMovedownClick(Sender: TObject);
    procedure LBStoredItemsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
   procedure LBStoredItemsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure LBItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BDefaultClick(Sender: TObject);
    procedure ECustomDataExit(Sender: TObject);
    procedure ETagKeyPress(Sender: TObject; var Key: Char);
    procedure ETagExit(Sender: TObject);
    procedure BarChangeSelectedItem(Sender: TObject);
    procedure SILargeChange(Sender: TObject; ItemIndex: Integer);
    procedure SISmallChange(Sender: TObject; ItemIndex: Integer);
    procedure BarChangeActiveGroup(Sender: TObject);
    procedure ECaptionChange(Sender: TObject);
    procedure BIDefaultClick(Sender: TObject);
    procedure LBStoredItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LBStoredItemsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure EHintChange(Sender: TObject);
    procedure BGUpClick(Sender: TObject);
    procedure BGDownClick(Sender: TObject);
    procedure cbGroupVisibleClick(Sender: TObject);
  private
    OldSelectedGroup: TdxSideGroup;
    OldSelectedItem: TdxSideBarItem;
    procedure SelectItem;
  end;

function ShowSideBarEditor(ABar: TdxSideBar): Boolean;

implementation

function ShowSideBarEditor(ABar: TdxSideBar): Boolean;
var
  AForm: TfrmdxSideBarEditor;
  i: Integer;
begin
  Result := False;
  AForm := TfrmdxSideBarEditor.Create(nil);
  AForm.Caption := AForm.Caption + ABar.Name;
  AForm.Bar.Assign(ABar);
  with AForm do
  begin
    if(ABar.Store = nil) then
    begin
      GStoredItems.Enabled := False;
      CBStoredGroup.Color := clBtnFace;
      LBStoredItems.Color := clBtnFace;
      BDefault.Enabled := False;
      BIDefault.Enabled := False;
    end;
    SILarge.ImageList := ABar.GetLargeImages;
    SISmall.ImageList := ABar.GetSmallImages;
    BGDelete.Enabled := ABar.GroupCount > 0;
    BGRename.Enabled := ABar.GroupCount > 0;
    BGUp.Enabled := ABar.GroupCount > 1;
    BGDown.Enabled := ABar.GroupCount > 1;
    for i := 0 to Bar.Groups.Count - 1 do
    begin
      Bar.Groups[i].Tag := Integer(Bar.Groups[i].Visible);
      Bar.Groups[i].Visible := True;
    end;
    BarChangeActiveGroup(nil);
    ShowModal;
    if(ModalResult = mrOk) then begin
      for i := 0 to Bar.Groups.Count - 1 do
        Bar.Groups[i].Visible := Boolean(Bar.Groups[i].Tag);
      ABar.Assign(Bar);
      Result := True;
    end;
  end;  
  AForm.Free;
end;

{$R *.DFM}
procedure TfrmdxSideBarEditor.SelectItem;
Var
  i: Integer;
begin
  if (Bar.ActiveGroup = nil) then begin
    OldSelectedGroup := nil;
    OldSelectedItem := nil;
    exit;
  end;
  if (OldSelectedGroup = nil) then
   OldSelectedGroup := Bar.Groups[0];

  if(OldSelectedItem = nil) and (OldSelectedGroup.Items.Count > 0) then
    Bar.SelectedItem := OldSelectedGroup.Items[0]
  else
    if(OldSelectedGroup.Items.Count > 0) then
      Bar.SelectedItem := OldSelectedGroup.Items[OldSelectedGroup.Items.Count - 1]
    else
      for i := 0 to Bar.Groups.Count - 1 do
        if(Bar.Groups[i].Items.Count > 0) then
        begin
          Bar.SelectedItem := Bar.Groups[i].Items[0];
          break;
        end;
  if (Bar.SelectedItem <> nil) then
  begin
    Bar.ActiveGroup := Bar.SelectedItem.Group;
    Bar.SelectedItem.MakeVisible;
    OldSelectedItem := Bar.SelectedItem;
    OldSelectedGroup := Bar.ActiveGroup;
  end else begin
    OldSelectedGroup := nil;
    OldSelectedItem := nil;
  end;
end;

procedure TfrmdxSideBarEditor.FormShow(Sender: TObject);
Var
  i: Integer;
begin
  BarChangeActiveGroup(nil);
  BarChangeSelectedItem(nil);
  BIAdd.Enabled := (Bar.Store = nil) or (Bar.Store.Count > 0);
  BIInsert.Enabled := (Bar.Store = nil) or (Bar.Store.Count > 0);
  if(Bar.Store <> nil) and (Bar.Store.Count > 0) then begin
    LBStoredItems.ImageList := Bar.Store.LargeImages;
    for i := 0 to Bar.Store.Categories.Count - 1 do
      if(Bar.Store.GetCountByCategory(Bar.Store.Categories[i]) > 0) then
      CBStoredGroup.Items.Add(Bar.Store.Categories[i]);
    if(CBStoredGroup.Items.Count > 0) then begin
      CBStoredGroup.ItemIndex := 0;
      CBStoredGroupClick(Sender);
    end;
  end;
end;

procedure TfrmdxSideBarEditor.CBStoredGroupClick(Sender: TObject);
Var
  List: TList;
  i: Integer;
  item: TdxStoredSideItem;
begin
  LBStoredItems.Items.Clear;
  List := TList.Create;
  Bar.Store.GetItemsByCategory(CBStoredGroup.Items[CBStoredGroup.ItemIndex], List);
  for i := 0 to List.Count - 1 do begin
    Item := TdxStoredSideItem(List[i]);
    LBStoredItems.AddItem(Item.Caption, Item.LargeImage)
  end;
  List.Free;
  LBStoredItems.ItemIndex := 0;
end;

procedure TfrmdxSideBarEditor.BGAddClick(Sender: TObject);
Var
  Group: TdxSideGroup;
begin
  Group := Bar.Groups.Add;
  Group.Tag := Integer(True);
  Bar.EditGroup(Group);
end;

procedure TfrmdxSideBarEditor.BIAddClick(Sender: TObject);
Var
  item:   TdxSideBarItem;
begin
  if(Bar.ActiveGroup = nil) then
  begin
    Bar.Groups.Add;
    Bar.Groups[0].Tag := Integer(True);
  end;
  Item := Bar.ActiveGroup.Items.Add;
  if(Bar.Store <> nil) and (Bar.Store.Count > 0) then
    Item.StoredItem := Bar.Store.GetItemByCategory(
                  CBStoredGroup.Items[CBStoredGroup.ItemIndex],
                  LBStoredItems.ItemIndex);
  Bar.SelectedItem := Item;
  Item.MakeVisible;
end;

procedure TfrmdxSideBarEditor.BGRenameClick(Sender: TObject);
begin
  if(Bar.Groups.Count > 0) then
    Bar.EditGroup(Bar.Groups[Bar.ActiveGroupIndex]);
end;

procedure TfrmdxSideBarEditor.BCancelClick(Sender: TObject);
begin
  if(Bar.IsEditing) then begin
    ModalResult := mrNone;
    Bar.EndEdit(False);
  end;
end;

procedure TfrmdxSideBarEditor.BOkClick(Sender: TObject);
begin
  if(Bar.IsEditing) then begin
    ModalResult := mrNone;
    Bar.EndEdit(True);
  end;
end;

procedure TfrmdxSideBarEditor.CBGITypeClick(Sender: TObject);
begin
  if(Bar.Groups.Count > 0) then
    if(CBGIType.Checked) then
      Bar.Groups[Bar.ActiveGroupIndex].IconType := dxsgLargeIcon
    else Bar.Groups[Bar.ActiveGroupIndex].IconType := dxsgSmallIcon;
end;

procedure TfrmdxSideBarEditor.BGDeleteClick(Sender: TObject);
begin
  if(Bar.Groups.Count > 0) then
    Bar.Groups[Bar.ActiveGroupIndex].Free;
end;

procedure TfrmdxSideBarEditor.BIInsertClick(Sender: TObject);
Var
  item:   TdxSideBarItem;
begin
  if(Bar.ActiveGroup = nil) then
    Bar.Groups.Add;
  Item := Bar.ActiveGroup.Items.Add;
  if(Bar.Store <> nil) and (Bar.Store.Count > 0) then
    Item.StoredItem := Bar.Store.GetItemByCategory(
                  CBStoredGroup.Items[CBStoredGroup.ItemIndex],
                  LBStoredItems.ItemIndex);
  if (Bar.SelectedItem <> nil) then
    Item.Index := Bar.SelectedItem.Index
  else
    Item.Index := 0;
  Bar.SelectedItem := Item;
  Item.MakeVisible;
end;

procedure TfrmdxSideBarEditor.BIDeleteClick(Sender: TObject);
begin
   Bar.SelectedItem.Free;
end;

procedure TfrmdxSideBarEditor.BIClearClick(Sender: TObject);
begin
  Bar.ActiveGroup.Items.Clear;
end;

procedure TfrmdxSideBarEditor.BIMoveUpClick(Sender: TObject);
begin
  if (Bar.SelectedItem.Index > 0) then
  begin
    Bar.SelectedItem.Index := Bar.SelectedItem.Index - 1;
    Bar.SelectedItem.MakeVisible;
 end;
end;

procedure TfrmdxSideBarEditor.BIMovedownClick(Sender: TObject);
begin
  if (Bar.SelectedItem.Index < Bar.ActiveGroup.Items.Count - 1) then
  begin
    Bar.SelectedItem.Index := Bar.SelectedItem.Index + 1;
    Bar.SelectedItem.MakeVisible;
  end;
end;

procedure TfrmdxSideBarEditor.LBStoredItemsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if (LBStoredItems.ItemIndex > -1) and (LBStoredItems.Items.Count > 0) then
    dxSideBarDragObject := TdxSideBarDragObject.Create(LBStoredItems, DragObject, nil,
      Bar.Store.GetItemByCategory(CBStoredGroup.Items[CBStoredGroup.ItemIndex],
      LBStoredItems.ItemIndex));
end;

procedure TfrmdxSideBarEditor.LBStoredItemsEndDrag(Sender,
  Target: TObject; X, Y: Integer);
var
  groupcount: Integer;
begin
  groupcount := 0;
  if (dxSideBarDragObject <> nil) then
    dxSideBarDragObject.EndDrag(Target, X, Y);
  if (groupcount = 0) and (Bar.GroupCount = 1) then
    Bar.Groups[0].Tag := 1;
end;

procedure TfrmdxSideBarEditor.FormCreate(Sender: TObject);
begin
  OldSelectedGroup := nil;
  OldSelectedItem := nil;
end;

procedure TfrmdxSideBarEditor.LBItemsDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if ((LBStoredItems.ItemIndex = -1) and (LBStoredItems.Items.Count > 0))
    or (Bar.ActiveGroup = nil) then
    Accept := False
  else Accept := True;
end;

procedure TfrmdxSideBarEditor.BDefaultClick(Sender: TObject);
Var
  i, j: Integer;
  fGroup: TdxSideGroup;
  List: TList;
  sItem: TdxStoredSideItem;
  fItem: TdxSideBarItem;
begin
  Bar.Groups.Clear;
  List := TList.Create;
  for i := 0 to Bar.Store.Categories.Count - 1 do
  begin
    fGroup := Bar.Groups.Add;
    fGroup.Caption := Bar.Store.Categories[i];
    fGroup.Tag := Integer(True);
    cbGroupVisible.Checked := True;
    Bar.Store.GetItemsByCategory(Bar.Store.Categories[i], List);
    for j := 0 to List.Count - 1 do
    begin
      sItem := TdxStoredSideItem(List[j]);
      fItem := fGroup.Items.Add;
      fItem.StoredItem := sItem;
    end;
  end;
  List.Free;
end;


procedure TfrmdxSideBarEditor.ECustomDataExit(Sender: TObject);
begin
  Bar.SelectedItem.CustomData := ECustomData.Text;
end;

procedure TfrmdxSideBarEditor.ETagKeyPress(Sender: TObject;
  var Key: Char);
begin
  if((Key < '0') Or (Key > '9')) and (Key <> Char(VK_BACK))
  and ((Key <> '-') Or ((ETag.Text <> '') and (ETag.Text <> ETag.SelText))) then begin
    Key := #0;
    MessageBeep(0);
  end;
end;

procedure TfrmdxSideBarEditor.ETagExit(Sender: TObject);
begin
  if(ETag.Text = '-') then
    ETag.Text := '-1';
  Bar.SelectedItem.Tag := StrToInt(ETag.Text);
end;

procedure TfrmdxSideBarEditor.BarChangeSelectedItem(Sender: TObject);
begin
  if(OldSelectedItem <> nil) then
    with OldSelectedItem do begin
      CustomData := ECustomData.Text;
      Hint := EHint.Text;
      if(ETag.Text = '-') then ETag.Text := '-1';
      if(ETag.Text = '') then ETag.Text := '0';
      Tag := StrToInt(ETag.Text);
    end;
  if (Bar.SelectedItem = nil) then
    SelectItem
  else
  begin
    OldSelectedItem := Bar.SelectedItem;
    OldSelectedGroup := Bar.SelectedItem.Group;
  end;
  ECustomData.Enabled := Bar.SelectedItem <> nil;
  ETag.Enabled := Bar.SelectedItem <> nil;
  BIDelete.Enabled := ETag.Enabled;
  BIClear.Enabled := ETag.Enabled;
  BIMoveUp.Enabled := ETag.Enabled;
  BIMoveDown.Enabled := ETag.Enabled;
  SILarge.Enabled := ETag.Enabled;
  SISmall.Enabled := ETag.Enabled;
  ECaption.Enabled := ETag.Enabled;
  EHint.Enabled := ETag.Enabled;
  BIDefault.Enabled := ETag.Enabled and (Bar.Store <> nil) and (Bar.Store.Count > 0);
  if ECustomData.Enabled then
  begin
    ECustomData.Text := Bar.SelectedItem.CustomData;
    EHint.Text := Bar.SelectedItem.Hint;
    ETag.Text := IntToStr(Bar.SelectedItem.Tag);
    SILarge.ItemIndex := Bar.SelectedItem.LargeImage;
    SISmall.ItemIndex := Bar.SelectedItem.SmallImage;
    ECaption.Text := Bar.SelectedItem.Caption;
  end
  else
  begin
    ECustomData.Text := '';
    EHint.Text := '';
    ECaption.Text := '';
    ETag.Text := '';
    SILarge.ItemIndex := -1;
    SISmall.ItemIndex := -1;
  end;
end;

procedure TfrmdxSideBarEditor.SILargeChange(Sender: TObject;
  ItemIndex: Integer);
begin
  if (Bar.SelectedItem <> nil) then
    Bar.SelectedItem.LargeImage := ItemIndex;
end;

procedure TfrmdxSideBarEditor.SISmallChange(Sender: TObject;
  ItemIndex: Integer);
begin
  if (Bar.SelectedItem <> nil) then
    Bar.SelectedItem.SmallImage := ItemIndex;
end;

procedure TfrmdxSideBarEditor.BarChangeActiveGroup(Sender: TObject);
begin
  BGDelete.Enabled := Bar.ActiveGroup <> nil;
  BGRename.Enabled := BGDelete.Enabled;
  CBGIType.Enabled := BGDelete.Enabled;
  cbGroupVisible.Enabled := BGDelete.Enabled;
  if Bar.ActiveGroup <> nil then
  begin
    CBGIType.Checked := Bar.ActiveGroup.IconType = dxsgLargeIcon;
    cbGroupVisible.Checked := Boolean(Bar.ActiveGroup.Tag);
  end;
end;

procedure TfrmdxSideBarEditor.ECaptionChange(Sender: TObject);
begin
  if (Bar.SelectedItem <> nil) then
    Bar.SelectedItem.Caption := ECaption.Text;
end;

procedure TfrmdxSideBarEditor.BIDefaultClick(Sender: TObject);
begin
  Bar.SelectedItem.IsDefault := True;
  ECaption.Text := Bar.SelectedItem.Caption;
  ECaption.Hint := Bar.SelectedItem.Hint;
  SILarge.ItemIndex := Bar.SelectedItem.LargeImage;
  SISmall.ItemIndex := Bar.SelectedItem.SmallImage;
end;

procedure TfrmdxSideBarEditor.LBStoredItemsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (Source = Bar) and (dxSideBarDragObject <> nil) then
  begin
    dxSideBarDragObject.DeleteItem := True;
    Accept := True;
  end;
end;

procedure TfrmdxSideBarEditor.LBStoredItemsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  if (Source = Bar) then
    Bar.SelectedItem.Free;
end;

procedure TfrmdxSideBarEditor.EHintChange(Sender: TObject);
begin
  if(Bar.SelectedItem <> nil) then
    Bar.SelectedItem.Hint := EHint.Text;
end;

procedure TfrmdxSideBarEditor.BGUpClick(Sender: TObject);
var
  gr: TdxSideGroup;
begin
  if (Bar.ActiveGroup <> nil) and (Bar.ActiveGroup.Index > 0) then
  begin
    gr := Bar.ActiveGroup;
    Bar.ActiveGroup.Index := Bar.ActiveGroup.Index - 1;
    Bar.ActiveGroupIndex := gr.Index;
    Bar.Repaint;
  end;
end;

procedure TfrmdxSideBarEditor.BGDownClick(Sender: TObject);
var
  gr: TdxSideGroup;
begin
  if (Bar.ActiveGroup <> nil) and (Bar.ActiveGroup.Index < Bar.Groups.Count - 1) then
  begin
    gr := Bar.ActiveGroup;
    Bar.ActiveGroup.Index := Bar.ActiveGroup.Index + 1;
    Bar.ActiveGroupIndex := gr.Index;
    Bar.Repaint;
  end;
end;

procedure TfrmdxSideBarEditor.cbGroupVisibleClick(Sender: TObject);
begin
  if (Bar.ActiveGroup <> nil) then
    Bar.ActiveGroup.Tag := Integer(cbGroupVisible.Checked);
end;

end.
