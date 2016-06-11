{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ListBox.Selection;

interface

{$SCOPEDENUMS ON}

uses
  System.Generics.Collections, System.Generics.Defaults;

/// <summary>Register default selection controllers for TListBox</summary>
procedure RegisterSelectionControllers;

implementation

uses
  System.SysUtils, System.Math, System.UITypes, System.Classes, FMX.Types, FMX.ListBox;

type
  TSingleSelectionController = class(TListBoxSelector)
  strict private
    FUserSetIndex: Integer;
  protected
    function GetMultiSelectStyle: TMultiSelectStyle; override;
  public
    constructor Create(const ListBox: TCustomListBox); override;
    procedure DoMouseSelectStart(const Item: TListBoxItem;  const Shift: TShiftState); override;
    procedure DoMouseSelectMove(const Item: TListBoxItem; const Shift: TShiftState); override;
    procedure DoMouseSelectFinish(const Item: TListBoxItem;  const Shift: TShiftState); override;
    procedure DoKeyboardSelect(const KeyAction: TListBoxSelector.TKeyAction; const Shift: TShiftState; const Item: TListBoxItem); override;
    procedure DoUserSetIndex(const Index: Integer); override;
    procedure DoItemStateChanged(const Item: TListBoxItem; const UserChange: Boolean); override;
  end;

  TMutiselectSelectionController = class(TListBoxSelector)
  private
    FPrevious: Integer;
  protected
    function GetMultiSelectStyle: TMultiSelectStyle; override;
  public
    procedure DoMouseSelectStart(const Item: TListBoxItem;  const Shift: TShiftState); override;
    procedure DoMouseSelectMove(const Item: TListBoxItem; const Shift: TShiftState); override;
    procedure DoMouseSelectFinish(const Item: TListBoxItem;  const Shift: TShiftState); override;
    procedure DoKeyboardSelect(const KeyAction: TListBoxSelector.TKeyAction; const Shift: TShiftState; const Item: TListBoxItem); override;
    procedure DoUserSetIndex(const Index: Integer); override;
    procedure DoItemStateChanged(const Item: TListBoxItem; const UserChange: Boolean); override;
  end;

  TExtendedSelectionController = class(TListBoxSelector)
  protected
    function GetMultiSelectStyle: TMultiSelectStyle; override;
  public
    procedure DoMouseSelectStart(const Item: TListBoxItem;  const Shift: TShiftState); override;
    procedure DoMouseSelectMove(const Item: TListBoxItem; const Shift: TShiftState); override;
    procedure DoMouseSelectFinish(const Item: TListBoxItem;  const Shift: TShiftState); override;
    procedure DoKeyboardSelect(const KeyAction: TListBoxSelector.TKeyAction; const Shift: TShiftState; const Item: TListBoxItem); override;
    procedure DoUserSetIndex(const Index: Integer); override;
    procedure DoItemStateChanged(const Item: TListBoxItem; const UserChange: Boolean); override;
  end;

constructor TSingleSelectionController.Create(const ListBox: TCustomListBox);
begin
  inherited;
  ClearSelection;
  FUserSetIndex := -1;
end;

function TSingleSelectionController.GetMultiSelectStyle: TMultiSelectStyle;
begin
  Result := TMultiSelectStyle.None;
end;

procedure TSingleSelectionController.DoKeyboardSelect(const KeyAction: TListBoxSelector.TKeyAction;
  const Shift: TShiftState; const Item: TListBoxItem);
begin
  if Item.Index <> FCurrent then
  begin
    SetSelected(GetCurrentItem, False);
    SetCurrent(Item.Index);
    Item.IsSelected := True;
  end;
end;

procedure TSingleSelectionController.DoMouseSelectStart(const Item: TListBoxItem; const Shift: TShiftState);
begin
  if (FUserSetIndex = -1) and (Item.Index <> FCurrent) then
  begin
    SetSelected(GetCurrentItem, False);
    if SetCurrent(Item.Index) then
      Item.SetIsSelectedInternal(True, False);
  end;
end;

procedure TSingleSelectionController.DoMouseSelectMove(const Item: TListBoxItem; const Shift: TShiftState);
begin
  if Item.Index <> FCurrent then
  begin
    SetSelected(GetCurrentItem, False);
    if SetCurrent(Item.Index) then
      Item.SetIsSelectedInternal(True, False);
  end;
end;

procedure TSingleSelectionController.DoMouseSelectFinish(const Item: TListBoxItem; const Shift: TShiftState);
begin
  if (FUserSetIndex = -1) and SetCurrent(Item.Index) then
    Change;
  FUserSetIndex := -1;
end;

procedure TSingleSelectionController.DoItemStateChanged(const Item: TListBoxItem; const UserChange: Boolean);
begin
  inherited;
  if Item.IsSelected then
  begin
    if FCurrent <> Item.Index then
      SetSelected(GetCurrentItem, False);
    SetCurrent(Item.Index);
    if MouseSelectActive and UserChange then
      FUserSetIndex := Item.Index;
  end
  else
    SetCurrent(-1);
end;

procedure TSingleSelectionController.DoUserSetIndex(const Index: Integer);
var
  Item: TListBoxItem;
begin
  Item := GetCurrentItem;
  if Item <> nil then
    SetSelected(Item, False);
  SetCurrent(IfThen(Index < 0, -1, Index));
  Item := GetCurrentItem;
  if Item <> nil then
    SetSelected(Item, True);
end;

{ TMutiselectSelectionController }

function TMutiselectSelectionController.GetMultiSelectStyle: TMultiSelectStyle;
begin
  Result := TMultiSelectStyle.Default;
end;

procedure TMutiselectSelectionController.DoKeyboardSelect(const KeyAction: TListBoxSelector.TKeyAction;
  const Shift: TShiftState; const Item: TListBoxItem);
begin
  if ssShift in Shift then
    SelectRange(FListBox.ItemByIndex(FFirst), Item)
  else
  begin
    ClearSelection;
    Item.IsSelected := True;
    FFirst := Item.Index;
  end;
  SetCurrent(Item.Index);
end;

procedure TMutiselectSelectionController.DoMouseSelectStart(const Item: TListBoxItem; const Shift: TShiftState);
begin
{$IFDEF MACOS}
  if ssCommand in Shift then
{$ELSE}
  if ssCtrl in Shift then
{$ENDIF}
    Item.IsSelected := not Item.IsSelected
  else if ssShift in Shift then
  begin
    if FListBox.FirstSelectedItemFrom(GetCurrentItem).Index < Item.Index then
      SelectRange(FListBox.FirstSelectedItemFrom(GetCurrentItem), Item)
    else
      SelectRange(Item, FListBox.LastSelectedItemFrom(GetCurrentItem));
  end
  else
    SelectRange(Item, Item);
  SetCurrent(Item.Index);
  FFirst := Item.Index;
  FPrevious := FFirst;
end;

procedure TMutiselectSelectionController.DoMouseSelectMove(const Item: TListBoxItem; const Shift: TShiftState);
begin
  if Item.Index <> FPrevious then
  begin
    FPrevious := Item.Index;
  {$IFDEF MACOS}
    if ssCommand in Shift then
  {$ELSE}
    if ssCtrl in Shift then
  {$ENDIF}
      Item.IsSelected := not Item.IsSelected
    else
      SelectRange(FListBox.ItemByIndex(FFirst), Item);
  end;
end;

procedure TMutiselectSelectionController.DoMouseSelectFinish(const Item: TListBoxItem; const Shift: TShiftState);
begin
  if SetCurrent(Item.Index) then
    Change;
end;

procedure TMutiselectSelectionController.DoUserSetIndex(const Index: Integer);
begin
  SetCurrent(IfThen(Index < 0, -1, Index));
  SetSelected(GetCurrentItem, True);
end;

procedure TMutiselectSelectionController.DoItemStateChanged(const Item: TListBoxItem; const UserChange: Boolean);
begin
  inherited;
  if FCurrent = -1 then
    FCurrent := Item.Index;
end;

{ TExtendedSelectionController }

function TExtendedSelectionController.GetMultiSelectStyle: TMultiSelectStyle;
begin
  Result := TMultiSelectStyle.Extended;
end;

procedure TExtendedSelectionController.DoItemStateChanged(const Item: TListBoxItem; const UserChange: Boolean);
begin
  inherited;
  if FCurrent = -1 then
    FCurrent := Item.Index;
end;

procedure TExtendedSelectionController.DoKeyboardSelect(const KeyAction: TListBoxSelector.TKeyAction;
  const Shift: TShiftState; const Item: TListBoxItem);
begin
  if KeyAction = TKeyAction.Toggle then
    Item.IsSelected := not Item.IsSelected
  else
  begin
    SetCurrent(Item.Index);
    UpdateSelection;
    FFirst := Item.Index;
  end;
end;

procedure TExtendedSelectionController.DoMouseSelectStart(const Item: TListBoxItem;  const Shift: TShiftState);
begin
  SetCurrent(Item.Index);
  Item.IsSelected := not Item.IsSelected;
  FFirst := Item.Index;
end;

procedure TExtendedSelectionController.DoMouseSelectMove(const Item: TListBoxItem; const Shift: TShiftState);
begin
  SetCurrent(Item.Index);
  UpdateSelection;
end;

procedure TExtendedSelectionController.DoMouseSelectFinish(const Item: TListBoxItem;  const Shift: TShiftState);
begin
  SetCurrent(Item.Index);
end;

procedure TExtendedSelectionController.DoUserSetIndex(const Index: Integer);
begin
  SetCurrent(IfThen(Index < 0, -1, Index));
  SetSelected(GetCurrentItem, True);
end;

procedure RegisterSelectionControllers;
begin
  TListBoxSelectorFactory.RegisterSelector(TMultiSelectStyle.None, TSingleSelectionController);
  TListBoxSelectorFactory.RegisterSelector(TMultiSelectStyle.Default, TMutiselectSelectionController);
  TListBoxSelectorFactory.RegisterSelector(TMultiSelectStyle.Extended, TExtendedSelectionController);
end;

end.
