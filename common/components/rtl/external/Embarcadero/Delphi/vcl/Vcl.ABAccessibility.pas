{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ABAccessibility;

interface

uses Winapi.Windows, System.Classes, Winapi.ActiveX, Winapi.oleacc, Vcl.ActnMan, Vcl.ActnMenus, Vcl.Controls;

type
  TActionBarAccessibility = class(TInterfacedObject, IDispatch, IAccessible)
  private
    FActionClient: TActionClient;
    FParent: TActionClient;
    { IAccessibility }
    function Get_accParent(out ppdispParent: IDispatch): HResult; stdcall;
    function Get_accChildCount(out pcountChildren: Integer): HResult; stdcall;
    function Get_accChild(varChild: OleVariant; out ppdispChild: IDispatch): HResult; stdcall;
    function Get_accName(varChild: OleVariant; out pszName: WideString): HResult; stdcall;
    function Get_accValue(varChild: OleVariant; out pszValue: WideString): HResult; stdcall;
    function Get_accDescription(varChild: OleVariant; out pszDescription: WideString): HResult; stdcall;
    function Get_accRole(varChild: OleVariant; out pvarRole: OleVariant): HResult; stdcall;
    function Get_accState(varChild: OleVariant; out pvarState: OleVariant): HResult; stdcall;
    function Get_accHelp(varChild: OleVariant; out pszHelp: WideString): HResult; stdcall;
    function Get_accHelpTopic(out pszHelpFile: WideString; varChild: OleVariant;
                              out pidTopic: Integer): HResult; stdcall;
    function Get_accKeyboardShortcut(varChild: OleVariant; out pszKeyboardShortcut: WideString): HResult; stdcall;
    function Get_accFocus(out pvarChild: OleVariant): HResult; stdcall;
    function Get_accSelection(out pvarChildren: OleVariant): HResult; stdcall;
    function Get_accDefaultAction(varChild: OleVariant; out pszDefaultAction: WideString): HResult; stdcall;
    function accSelect(flagsSelect: Integer; varChild: OleVariant): HResult; stdcall;
    function accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer;
                         out pcyHeight: Integer; varChild: OleVariant): HResult; stdcall;
    function accNavigate(navDir: Integer; varStart: OleVariant; out pvarEndUpAt: OleVariant): HResult; stdcall;
    function accHitTest(xLeft: Integer; yTop: Integer; out pvarChild: OleVariant): HResult; stdcall;
    function accDoDefaultAction(varChild: OleVariant): HResult; stdcall;
    function Set_accName(varChild: OleVariant; const pszName: WideString): HResult; stdcall;
    function Set_accValue(varChild: OleVariant; const pszValue: WideString): HResult; stdcall;
    {IDispatch}
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount: Integer; LocaleID: Integer; DispIDs: Pointer): HRESULT; stdcall;
    function GetTypeInfo(Index: Integer; LocaleID: Integer;
      out TypeInfo): HRESULT; stdcall;
    function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult: Pointer; ExcepInfo: Pointer;
      ArgErr: Pointer): HRESULT; stdcall;
  public
    constructor Create(Parent, ActionClient: TActionClient);
  end;

  TActionMenuBarAccessibility = class(TActionBarAccessibility, IAccessible)
  public
    function Get_accChild(varChild: OleVariant;
      out ppdispChild: IDispatch): HRESULT; stdcall;
    function Get_accState(varChild: OleVariant;
      out pvarState: OleVariant): HRESULT; stdcall;
    function Get_accRole(varChild: OleVariant;
      out pvarRole: OleVariant): HRESULT; stdcall;
    function Get_accDescription(varChild: OleVariant; out pszDescription: WideString): HResult; stdcall;
  end;

implementation

uses Vcl.ActnList, System.Variants, System.SysUtils, Vcl.Menus, System.Types;

type
  TCustomActionMenuBarClass = class(TCustomActionMenuBar);

{ TActionBarAccessibility }

function TActionBarAccessibility.accDoDefaultAction(varChild: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TActionBarAccessibility.accHitTest(xLeft: Integer; yTop: Integer; out pvarChild: OleVariant): HResult;
var
  Pt: TPoint;
  Control: TControl;
begin
  VariantInit(pvarChild);
  TVarData(pvarChild).VType := VT_I4;
  Control := nil;
  Result := S_FALSE;
  if FActionClient is TActionBarItem then
  begin
    Pt := FActionClient.ActionBar.ScreenToClient(Point(xLeft, yTop));
    Control := FActionClient.ActionBar;
    if Control <> nil then
    begin
      pvarChild := TCustomActionControl(Control).ActionClient.Index + 1;
      Result := S_OK;
    end;
  end
  else if (FActionClient is TActionClientItem) and Assigned(TActionClientItem(FActionClient).Control) then
  begin
    Control := FActionClient.ChildActionBar.ControlAtPos(FActionClient.ChildActionBar.ScreenToClient(Point(xLeft, yTop)), True);
    pvarChild := TCustomActionControl(Control).ActionClient.Index + 1;
    Result := S_OK;
  end
  else
  if Assigned(Control) and Control.BoundsRect.Contains(Pt) then
  begin
    pvarChild := CHILDID_SELF;
    Result := S_OK;
  end
  else
    Result := S_FALSE;
end;

function TActionBarAccessibility.accLocation(out pxLeft: Integer;
  out pyTop: Integer; out pcxWidth: Integer;
  out pcyHeight: Integer; varChild: OleVariant): HResult;
var
  P: TPoint;
  Control: TControl;
begin
  Result := S_FALSE;
  if varChild = CHILDID_SELF then
  begin
    if FActionClient is TActionBarItem then
      Control := FActionClient.ActionBar
    else
      Control := TActionClientItem(FActionClient).Control;
  end
  else
    Control := FActionClient.Items[varChild - 1].Control;
  if Control = nil then
    exit;
  P := Control.ClientToScreen(Control.ClientRect.TopLeft);
  pxLeft := P.X;
  pyTop := P.Y;
  pcxWidth := Control.Width;
  pcyHeight := Control.Height;
  Result := S_OK;
end;

function TActionBarAccessibility.accNavigate(navDir: Integer; varStart: OleVariant;
  out pvarEndUpAt: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TActionBarAccessibility.Get_accSelection(out pvarChildren: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

constructor TActionBarAccessibility.Create(Parent, ActionClient: TActionClient);
begin
  FParent := Parent;
  FActionClient := ActionClient;
  FActionClient.Accessible := Self;
end;

function TActionBarAccessibility.GetIDsOfNames(const IID: TGUID;
  Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TActionBarAccessibility.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TActionBarAccessibility.GetTypeInfoCount(
  out Count: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TActionBarAccessibility.Get_accChild(varChild: OleVariant; out ppdispChild: IDispatch): HResult;
begin
  if varChild = CHILDID_SELF then
    Result := E_INVALIDARG
  else
  begin
    if varChild > FActionClient.Items.Count then
    begin
      ppdispChild := nil;
      Result := S_FALSE;
      exit;
    end;
    ppdispChild := TActionBarAccessibility.Create(FActionClient, FActionClient.Items[varChild - 1]);
    Result := S_OK;
  end;
end;

function TActionBarAccessibility.Get_accChildCount(out pcountChildren: Integer): HResult;
begin
  pcountChildren := FActionClient.Items.Count;
  Result := S_OK;
end;

function TActionBarAccessibility.Get_accDefaultAction(varChild: OleVariant; out pszDefaultAction: WideString): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TActionBarAccessibility.Get_accDescription(varChild: OleVariant; out pszDescription: WideString): HResult;
begin
  Result := S_FALSE;
  if varChild = CHILDID_SELF then
  begin
    if FActionClient is TActionBarItem then
      pszDescription := GetLongHint(FActionClient.ActionBar.Hint)
    else
      pszDescription := GetLongHint(TActionClientItem(FActionClient).Control.Hint);
  end
  else
    pszDescription := GetLongHint(TCustomAction(FActionClient.Items[varChild - 1].Action).Hint);
  if Length(pszDescription) > 0 then
    Result := S_OK;
end;

function TActionBarAccessibility.Get_accFocus(out pvarChild: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TActionBarAccessibility.Get_accHelp(varChild: OleVariant; out pszHelp: WideString): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

function TActionBarAccessibility.Get_accHelpTopic(out pszHelpFile: WideString; varChild: OleVariant;
                          out pidTopic: Integer): HResult;
begin
  pszHelpFile := '';                                 
  pidTopic := 0;
  Result := S_FALSE;
  if varChild = CHILDID_SELF then
    if (FActionClient is TActionClientItem) and Assigned(TActionClientItem(FActionClient).Action) then
    begin
      pidTopic := TCustomAction(TActionClientItem(FActionClient).Action).HelpContext;
      Result := S_OK;
    end;
end;

function TActionBarAccessibility.Get_accKeyboardShortcut(varChild: OleVariant; out pszKeyboardShortcut: WideString): HResult;
begin
  Result := S_FALSE;
  if varChild = CHILDID_SELF then
  begin
    if FActionClient is TActionBarItem then
      pszKeyboardShortcut := ''
    else
    begin
      if TActionClientItem(FActionClient).Action = nil then
        pszKeyboardShortcut := GetHotkey(TActionClientItem(FActionClient).Caption)
      else
        pszKeyboardShortcut := ShortCutToText(TCustomAction(TActionClientItem(FActionClient).Action).ShortCut);
      if Length(pszKeyboardShortcut) > 0 then
        Result := S_OK;
    end;
  end
  else
  begin
     pszKeyboardShortcut := ShortCutToText(TCustomAction(TActionClientItem(FActionClient.Items[varChild - 1]).Action).ShortCut);
     if Length(pszKeyboardShortcut) > 0 then
       Result := S_OK;
  end;
end;

function TActionBarAccessibility.Get_accName(varChild: OleVariant; out pszName: WideString): HResult;
begin
  Result := S_OK;
  if varChild = CHILDID_SELF then
  begin
    if FActionClient is TActionClientItem then
      pszName := StripHotkey(TActionClientItem(FActionClient).Caption)
    else if FActionClient is TActionBarItem then
      FActionClient.ActionBar.Caption;
  end
  else
    if varChild > FActionClient.Items.Count then
      Result := S_FALSE
    else
      pszName := StripHotkey(FActionClient.Items[varChild - 1].Caption);
end;

function TActionBarAccessibility.Get_accParent(out ppdispParent: IDispatch): HResult;
begin
  Result := S_FALSE;
  if FParent <> nil then
  begin
    ppdispParent := FParent.Accessible;
    Result := S_OK;
  end;
end;

function TActionBarAccessibility.Get_accRole(varChild: OleVariant; out pvarRole: OleVariant): HResult;
begin
  Result := S_OK;
  VariantInit(pvarRole);
  TVarData(pvarRole).VType := VT_I4;
  if varChild = CHILDID_SELF then
  begin
    if FActionClient is TActionBarItem then
      TVarData(pvarRole).VInteger := ROLE_SYSTEM_MENUBAR
    else
      if Assigned(TActionClientItem(FActionClient).Control) and (TActionClientItem(FActionClient).Control.Parent is TCustomActionMainMenuBar) then
        TVarData(pvarRole).VInteger := ROLE_SYSTEM_MENUPOPUP
      else
        TVarData(pvarRole).VInteger := ROLE_SYSTEM_MENUITEM;
  end
  else
    TVarData(pvarRole).VInteger := ROLE_SYSTEM_MENUITEM;
end;

function TActionBarAccessibility.accSelect(flagsSelect: Integer; varChild: OleVariant): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND;
end;

type
  TCustomActionControlClass = class(TCustomActionControl);

function TActionBarAccessibility.Get_accState(varChild: OleVariant; out pvarState: OleVariant): HResult;
const
  IsEnabled: array[Boolean] of Integer = (STATE_SYSTEM_UNAVAILABLE, 0);
  HasPopup: array[Boolean] of Integer = (0, STATE_SYSTEM_HASPOPUP);
  IsVisible: array[Boolean] of Integer = (STATE_SYSTEM_INVISIBLE, 0);
  IsChecked: array[Boolean] of Integer = (0, STATE_SYSTEM_CHECKED);
var
  Control: TControl;
begin
  Result := S_OK;
  VariantInit(pvarState);
  TVarData(pvarState).VType := VT_I4;
  Control := nil;
  if varChild = CHILDID_SELF then
  begin
    if FActionClient is TActionBarItem then
      Control := FActionClient.ActionBar
    else if FActionClient is TActionClientItem then
      Control := TActionClientItem(FActionClient).Control;
    if Control = nil then
    begin
      Result := E_INVALIDARG;
      exit;
    end;
    TVarData(pvarState).VInteger := STATE_SYSTEM_FOCUSED or STATE_SYSTEM_FOCUSABLE or STATE_SYSTEM_HOTTRACKED;
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or IsVisible[Control.Visible];
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or IsEnabled[Control.Enabled];
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or IsChecked[TCustomAction(Control.Action).Checked];
  end
  else
  begin
    TVarData(pvarState).VInteger := STATE_SYSTEM_FOCUSED or STATE_SYSTEM_FOCUSABLE or STATE_SYSTEM_HOTTRACKED;
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or
      IsVisible[FActionClient.Items[varChild - 1].Control.Visible];
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or
      HasPopup[FActionClient.Items[varChild - 1].HasItems];
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or
      IsEnabled[FActionClient.Items[varChild - 1].Control.Enabled];
    if TCustomActionControlClass(FActionClient.Items[varChild - 1].Control).IsChecked then
      TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or STATE_SYSTEM_CHECKED;
  end;
end;

function TActionBarAccessibility.Get_accValue(varChild: OleVariant; out pszValue: WideString): HResult;
begin
  pszValue := '';
  Result := S_FALSE;//DISP_E_MEMBERNOTFOUND;
end;

function TActionBarAccessibility.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TActionBarAccessibility.Set_accName(varChild: OleVariant; const pszName: WideString): HResult; stdcall;
begin
  Result := DISP_E_MEMBERNOTFOUND
end;

function TActionBarAccessibility.Set_accValue(varChild: OleVariant; const pszValue: WideString): HResult;
begin
  Result := DISP_E_MEMBERNOTFOUND
end;

{ TActionMenuBarAccessibility }

function TActionMenuBarAccessibility.Get_accChild(varChild: OleVariant;
  out ppdispChild: IDispatch): HRESULT;
begin
  if varChild = CHILDID_SELF then
    Result := E_INVALIDARG
  else
  begin
    if varChild > FActionClient.Items.Count then
    begin
      ppdispChild := nil;
      Result := S_FALSE;
      exit;
    end;
    ppdispChild := TActionMenuBarAccessibility.Create(FActionClient, FActionClient.Items[varChild - 1]);
    Result := S_OK;
  end;
end;

function TActionMenuBarAccessibility.Get_accDescription(varChild: OleVariant;
  out pszDescription: WideString): HResult;
begin
  Result := S_FALSE;
  pszDescription := '';
  if varChild = CHILDID_SELF then
    pszDescription := TActionClientItem(FActionClient).Caption + ' menu';
  if Length(pszDescription) > 0 then
    Result := S_OK;
end;

function TActionMenuBarAccessibility.Get_accRole(varChild: OleVariant;
  out pvarRole: OleVariant): HRESULT;
begin
  Result := S_OK;
  VariantInit(pvarRole);
  TVarData(pvarRole).VType := VT_I4;
  if varChild = CHILDID_SELF then
  begin
    if FActionClient is TActionBarItem then
      TVarData(pvarRole).VInteger := ROLE_SYSTEM_MENUBAR
    else
      TVarData(pvarRole).VInteger := ROLE_SYSTEM_MENUITEM;
  end
  else
    TVarData(pvarRole).VInteger := ROLE_SYSTEM_MENUITEM;
end;

function TActionMenuBarAccessibility.Get_accState(varChild: OleVariant;
  out pvarState: OleVariant): HRESULT;
const
  IsEnabled: array[Boolean] of Integer = (STATE_SYSTEM_UNAVAILABLE, 0);
  HasPopup: array[Boolean] of Integer = (0, STATE_SYSTEM_HASPOPUP);
  IsVisible: array[Boolean] of Integer = (STATE_SYSTEM_INVISIBLE, 0);
  IsChecked: array[Boolean] of Integer = (0, STATE_SYSTEM_CHECKED);
var
  Control: TControl;
begin
  Result := S_OK;
  VariantInit(pvarState);
  TVarData(pvarState).VType := VT_I4;
  Control := nil;
  if varChild = CHILDID_SELF then
  begin
    if FActionClient is TActionBarItem then
      Control := FActionClient.ActionBar
    else if FActionClient is TActionClientItem then
      Control := TActionClientItem(FActionClient).Control;
    if Control <> nil then
    begin
      TVarData(pvarState).VInteger := STATE_SYSTEM_FOCUSED or STATE_SYSTEM_FOCUSABLE;
      TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or IsVisible[Control.Visible];
      TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or IsEnabled[Control.Enabled];
      TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or IsChecked[TCustomActionControlClass(Control).IsChecked];
    end
    else
    begin
      TVarData(pvarState).VInteger := STATE_SYSTEM_FOCUSED or STATE_SYSTEM_FOCUSABLE;
      if TActionClientItem(FActionClient).Action <> nil then
      begin
        TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or IsVisible[TCustomAction(TActionClientItem(FActionClient).Action).Visible];
        TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or IsEnabled[TCustomAction(TActionClientItem(FActionClient).Action).Enabled];
      end;
    end;
  end
  else
  begin
    if varChild > FActionClient.Items.Count then
    begin
      Result := E_INVALIDARG;
      exit;
    end;
    if FActionClient.Items[varChild - 1].Control = nil then
      beep;
    TVarData(pvarState).VInteger := STATE_SYSTEM_FOCUSED or STATE_SYSTEM_FOCUSABLE;
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or
      IsVisible[FActionClient.Items[varChild - 1].Control.Visible];
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or
      HasPopup[FActionClient.Items[varChild - 1].HasItems];
    TVarData(pvarState).VInteger := TVarData(pvarState).VInteger or
      IsEnabled[FActionClient.Items[varChild - 1].Control.Enabled];
  end;
end;

end.
