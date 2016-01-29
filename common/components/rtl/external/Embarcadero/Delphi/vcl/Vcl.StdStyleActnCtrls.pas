{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.StdStyleActnCtrls;

interface

uses Vcl.ActnMan, Vcl.ActnMenus, Vcl.ActnCtrls;

type

{$IF NOT DEFINED(CLR)}
{$HPPEMIT ''}
{$HPPEMIT '/* automatically link to stdstyleactnctrls.obj so that the property editors are registered */'}
{$HPPEMIT '#pragma link "Vcl.stdstyleactnctrls"'}
{$HPPEMIT ''}
{$ENDIF}

{ TStandardStyleActionBars }

  TStandardStyleActionBars = class(TActionBarStyleEx)
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
  StandardStyle: TStandardStyleActionBars;

implementation

uses
  Vcl.ListActns, Vcl.ActnColorMaps, Vcl.StdActnMenus, Vcl.Consts, Vcl.Themes,
  Vcl.PlatformDefaultStyleActnCtrls;

{ TStandardActionBandStyle }

function TStandardStyleActionBars.GetAddRemoveItemClass(ActionBar: TCustomActionBar): TCustomAddRemoveItemClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetAddRemoveItemClass(ActionBar)
  else
    Result := TStandardAddRemoveItem;
end;

function TStandardStyleActionBars.GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetColorMapClass(ActionBar)
  else
    Result := TStandardColorMap;
end;

function TStandardStyleActionBars.GetControlClass(ActionBar: TCustomActionBar;
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetControlClass(ActionBar, AnItem)
  else
  begin
    if ActionBar is TCustomActionToolBar then
    begin
      if AnItem.HasItems then
        Result := TStandardDropDownButton
      else
        if (AnItem.Action is TStaticListAction) or
           (AnItem.Action is TVirtualListAction) then
          Result := TCustomComboControl
        else
          Result := TStandardButtonControl;
    end
    else if ActionBar is TCustomActionMainMenuBar then
      Result := TStandardMenuButton
    else if ActionBar is TCustomizeActionToolBar then
    begin
      with TCustomizeActionToolbar(ActionBar) do
        if not Assigned(RootMenu) or (AnItem.ParentItem <> TCustomizeActionToolBar(RootMenu).AdditionalItem) then
          Result := TStandardMenuItem
        else
          Result := TStandardAddRemoveItem;
    end
    else if ActionBar is TCustomActionPopupMenu then
      Result := TStandardMenuItem
    else
                                                                                          
      Result := TStandardButtonControl;
  end;
end;

function TStandardStyleActionBars.GetPopupClass(ActionBar: TCustomActionBar): TCustomPopupClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetPopupClass(ActionBar)
  else if ActionBar is TCustomActionToolBar then
    Result := TStandardCustomizePopup
  else
    Result := TStandardMenuPopup;
end;

function TStandardStyleActionBars.GetScrollBtnClass: TCustomToolScrollBtnClass;
begin
  if TStyleManager.IsCustomStyleActive then
    Result := PlatformDefaultStyle.GetScrollBtnClass
  else
    Result := TStandardToolScrollBtn;
end;

function TStandardStyleActionBars.GetStyleName: string;
begin
  Result := 'Standard'; { Do not localize }
end;

initialization
  StandardStyle := TStandardStyleActionBars.Create;
  RegisterActnBarStyle(StandardStyle);
finalization
  UnregisterActnBarStyle(StandardStyle);
  StandardStyle.Free;
end.
