unit XPStyleActnCtrls;

interface

uses ActnMan, ActnMenus, ActnCtrls;

type

{ TXPStyleActionBars }

  TXPStyleActionBars = class(TActionBarStyleEx)
  public
    function GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass; override;
    function GetControlClass(ActionBar: TCustomActionBar;
      AnItem: TActionClientItem): TCustomActionControlClass; override;
    function GetPopupClass(ActionBar: TCustomActionBar): TCustomPopupClass; override;
    function GetAddRemoveItemClass(ActionBar: TCustomActionBar): TCustomAddRemoveItemClass; override;
    function GetStyleName: string; override;
    function GetScrollBtnClass: TCustomToolScrollBtnClass; override;
  end;

var
  XPStyle: TXPStyleActionBars;

implementation

uses ListActns, ActnColorMaps, XPActnCtrls;

{ TXPStyleActionBars }

function TXPStyleActionBars.GetAddRemoveItemClass(
  ActionBar: TCustomActionBar): TCustomAddRemoveItemClass;
begin
  Result := TXPStyleAddRemoveItem;
end;

function TXPStyleActionBars.GetColorMapClass(
  ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  Result := TXPColorMap;
end;

function TXPStyleActionBars.GetControlClass(ActionBar: TCustomActionBar;
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  if ActionBar is TCustomActionToolBar then
  begin
    if AnItem.HasItems then
      Result := TXPStyleDropDownBtn
    else
      if (AnItem.Action is TStaticListAction) or
         (AnItem.Action is TVirtualListAction) then
        Result := TCustomComboControl
      else
        Result := TXPStyleButton;
  end
  else if ActionBar is TCustomActionMainMenuBar then
    Result := TXPStyleMenuButton
  else if ActionBar is TCustomizeActionToolBar then
  begin
    with ActionBar as TCustomizeActionToolbar do
      if not Assigned(RootMenu) or
         (AnItem.ParentItem <> TCustomizeActionToolBar(RootMenu).AdditionalItem) then
        Result := TXPStyleMenuItem
      else
        Result := TXPStyleAddRemoveItem;
  end
  else if ActionBar is TCustomActionPopupMenu then
    Result := TXPStyleMenuItem
  else
    Result := TXPStyleButton;
end;

function TXPStyleActionBars.GetPopupClass(
  ActionBar: TCustomActionBar): TCustomPopupClass;
begin
  if ActionBar is TCustomActionToolBar then
    Result := TXPStyleCustomizePopup
  else
    Result := TXPStylePopupMenu;
end;

function TXPStyleActionBars.GetScrollBtnClass: TCustomToolScrollBtnClass;
begin
  Result := TXPStyleToolScrollBtn;
end;

function TXPStyleActionBars.GetStyleName: string;
begin
  Result := 'XP Style'; { Do not localize }
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Vcl\XPStyleActnCtrls.pas initialization enter'); {$EndIf}
  XPStyle := TXPStyleActionBars.Create;
  DefaultActnBarStyle := XPStyle.GetStyleName;
  RegisterActnBarStyle(XPStyle);
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Vcl\XPStyleActnCtrls.pas initialization leave'); {$EndIf}
finalization
  UnregisterActnBarStyle(XPStyle);
  XPStyle.Free;
end.

