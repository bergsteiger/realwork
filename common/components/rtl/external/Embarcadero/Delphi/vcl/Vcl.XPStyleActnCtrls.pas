{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.XPStyleActnCtrls;

interface

uses Vcl.ActnMan, Vcl.ActnMenus, Vcl.ActnCtrls;

type

{$IF NOT DEFINED(CLR)}
{$HPPEMIT ''}
{$HPPEMIT '/* automatically link to xpstyleactnctrls.obj so that the property editors are registered */'}
{$HPPEMIT '#pragma link "Vcl.xpstyleactnctrls"'}
{$HPPEMIT ''}
{$ENDIF}

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

uses
  Vcl.ListActns, Vcl.ActnColorMaps, Vcl.XPActnCtrls, Vcl.Themes,
  Vcl.PlatformDefaultStyleActnCtrls;

{ TXPStyleActionBars }

function TXPStyleActionBars.GetAddRemoveItemClass(
  ActionBar: TCustomActionBar): TCustomAddRemoveItemClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetAddRemoveItemClass(ActionBar)
  else
    Result := TXPStyleAddRemoveItem;
end;

function TXPStyleActionBars.GetColorMapClass(
  ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetColorMapClass(ActionBar)
  else
    Result := TXPColorMap;
end;

function TXPStyleActionBars.GetControlClass(ActionBar: TCustomActionBar;
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetControlClass(ActionBar, AnItem)
  else
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
      with TCustomizeActionToolbar(ActionBar) do
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
end;

function TXPStyleActionBars.GetPopupClass(
  ActionBar: TCustomActionBar): TCustomPopupClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetPopupClass(ActionBar)
  else if ActionBar is TCustomActionToolBar then
    Result := TXPStyleCustomizePopup
  else
    Result := TXPStylePopupMenu;
end;

function TXPStyleActionBars.GetScrollBtnClass: TCustomToolScrollBtnClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetScrollBtnClass
  else
    Result := TXPStyleToolScrollBtn;
end;

function TXPStyleActionBars.GetStyleName: string;
begin
  Result := 'XP Style'; { Do not localize }
end;

initialization
  XPStyle := TXPStyleActionBars.Create;
  RegisterActnBarStyle(XPStyle);
finalization
  UnregisterActnBarStyle(XPStyle);
  XPStyle.Free;
end.

