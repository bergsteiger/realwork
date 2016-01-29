unit vcmMainMenuStripForChromeLike;

interface
uses
 Classes,
 Types,
 Menus,
 Controls,
 Graphics,
 Windows,
 Messages,
 vcmMainMenuForChromeLikeTypes,
 vcmBaseMenuForChromeLike,
 vcmDropDownMenuForChromeLike
 ;

type
 TvcmMainMenuStripForChromeLike = class(TvcmBaseMenuForChromeLike)
 (* Полоска главного меню *)
 private
  f_CurrentOpenedSubmenu: TvcmDropDownMenuForChromeLike;
  f_WasSubmenuOpened: Boolean;
  f_OpenedSubmenuItem: TvcmMenuForChromeLikeItem;
  f_DoNotOpenItemOnSelect: Boolean;
  f_ClosingDisabled: Boolean;
  f_NeedSetSelectedOnHovered: Boolean;
  f_LastMouseDown: Cardinal;
  f_NeedShowSubmenuOnSelect: Boolean;
  f_AnotherMenuItemSelected: Boolean;
  f_SelectedChanging: Boolean;
  f_ItemToExecute: TvcmMenuForChromeLikeItem;
  procedure DoDrawItemText(anItem: TMenuItem;
                           aCanvas: TCanvas;
                           const aCaption: string;
                           var aRect: TRect;
                           aSelected: Boolean;
                           aFlags: Longint);
  {-}
  function pm_GetIsMenuActive: Boolean;
  {-}
 protected
  function GetItemSize(anItem: TMenuItem): TSize;
    override;
  {-}
  function pm_GetMenuOrientation: TvcmBaseMenuForChromeLikeOrientation;
    override;
  {-}
  function pm_GetMenuItemMargins: TRect;
    override;
  {-}
  function GetSubmenuDropDownPoint(const anItem: TvcmMenuForChromeLikeItem): TPoint;
    override;
  {-}
  function pm_GetCurrentOpenedSubmenu: TvcmBaseMenuForChromeLike;
    override;
  {-}
  procedure DoOnMenuClosed(aClosedMenu: TvcmBaseMenuForChromeLike;
                           aClosedMenuResult: TvcmMenuShowingResult);
    override;
  {-}
  procedure ShowSubmenu(const anItem: TvcmMenuForChromeLikeItem;
                        const aPoint: TPoint;
                              aByKeyboard: Boolean);
    override;
  {-}
  procedure CloseMenu(aResult: TvcmMenuShowingResult);
    virtual;
  {-}
  procedure CloseCurrentOpenedSubmenu;
    override;
  {-}
  procedure SelectedItemChanged(const aPrevSelected: TvcmMenuForChromeLikeItem;
                                const aNewSelected: TvcmMenuForChromeLikeItem;
                                      aByKeyboard: Boolean);
    override;
  {-}
  procedure HoveredItemChanged(const aPrevHovered: TvcmMenuForChromeLikeItem;
                               const aNewHovered: TvcmMenuForChromeLikeItem);
    override;
  {-}
  procedure BeforeEnterMenuLoop;
    override;
  {-}
  procedure AfterMenuLoopFinished;
    override;
  {-}
  function GetItemOwnerDrawState(const anItem: TvcmMenuForChromeLikeItem): TOwnerDrawState;
    override;
  {-}
  procedure ActiveChanged(aIsActive: Boolean);
    override;
  {-}
  procedure WMSize(var aMessage: TWMSize);
    message WM_SIZE;
  {-}
  procedure vcmMsgShowMenu(var aMessage: TMessage);
    message vcm_msgShowMenu;
  {-}
  procedure DoBeforePeekMessage;
    override;
  {-}
  procedure ProcessMouseMessage(var aMessage: TMsg);
    override;
  {-}
  function ProcessKeyPressed(aKey: Word;
                             aActiveMenu: TvcmBaseMenuForChromeLike): Boolean;
    override;
  {-}
  procedure MouseMovedOverEmptyArea(aShift: TShiftState;
                                    const aPoint: TPoint);
    override;
  {-}
  procedure MouseDown(aButton: TMouseButton;
                      aShift: TShiftState;
                      aX: Integer;
                      aY: Integer);
    override;
  {-}
  procedure CMMouseLeave(var aMessage: TMessage);
    message CM_MOUSELEAVE;
  {-}
 public
  procedure ActivateMenu(aByKeyboard: Boolean = False);
  {-}
  procedure DeactivateMenu;
  {-}
  property IsMenuActive: Boolean
    read pm_GetIsMenuActive;
  {-}
 end;

implementation
uses
 Forms,
 l3Base,
 afwFacade,
 SysUtils,
 vcmPopupControlWindowService;

procedure TvcmMainMenuStripForChromeLike.DoDrawItemText(anItem: TMenuItem;
                                                        aCanvas: TCanvas;
                                                        const aCaption: string;
                                                        var aRect: TRect;
                                                        aSelected: Boolean;
                                                        aFlags: Longint);
var
 l_Text: string;
 l_R: TRect;
begin
 aCanvas.Font := Screen.MenuFont;
 l_Text := aCaption;
 if (aFlags and DT_CALCRECT <> 0) and ((l_Text = '') or
   (l_Text[1] = cHotkeyPrefix) and (l_Text[2] = #0)) then l_Text := l_Text + ' ';
 with aCanvas do
 begin
  Font.Charset := RUSSIAN_CHARSET;
  if (l_Text = cLineCaption) then
  begin
   if (aFlags and DT_CALCRECT = 0) then
   begin
    l_R := aRect;
    Inc(l_R.Top, 4);
    DrawEdge(Handle, l_R, EDGE_ETCHED, BF_TOP);
   end;
  end
  else
  begin
   Brush.Style := bsClear;
   if anItem.Default then
    Font.Style := Font.Style + [fsBold];
   if (not anItem.Enabled) then
   begin
    if (not aSelected) then
    begin
     OffsetRect(aRect, 1, 1);
     Font.Color := clBtnHighlight;
     DrawText(Handle, PChar(l_Text), Length(l_Text), aRect, aFlags);
     OffsetRect(aRect, -1, -1);
    end;//if (not aSelected)
    if aSelected and (ColorToRGB(clHighlight) = ColorToRGB(clBtnShadow)) then
     Font.Color := clBtnHighlight
    else
     Font.Color := clBtnShadow;
   end;//if (not anItem.Enabled)
   DrawText(Handle, PChar(l_Text), Length(l_Text), aRect, aFlags);
   Dec(aRect.Right);
  end;
 end;//with aCanvas
end;

function TvcmMainMenuStripForChromeLike.pm_GetIsMenuActive: Boolean;
begin
 Result := InMenuLoop;
end;

function TvcmMainMenuStripForChromeLike.GetItemSize(anItem: TMenuItem): TSize;
const
 cAlignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
 l_Alignment: TPopupAlignment;
 l_DrawStyle: Integer;
 l_Text: string;
 l_R: TRect;
begin
 Result.cx := 7;
 Canvas.Font := Screen.MenuFont;
 // - При открытии ГМ, выделение корневого пункта не отцентровано
 // http://mdp.garant.ru/pages/viewpage.action?pageId=578889012 
 l3FillChar(l_R, SizeOf(l_R), 0);
 l_Alignment := paCenter;
 l_DrawStyle := cAlignments[l_Alignment] or DT_EXPANDTABS or DT_SINGLELINE or
  DT_NOCLIP or DT_CALCRECT;
 l_Text := anItem.Caption;
 DoDrawItemText(anItem, Canvas, l_Text, l_R, False, l_DrawStyle);
 Inc(Result.cx, l_R.Right - l_R.Left + 7);
 Result.cy := GetSystemMetrics(SM_CYMENU);
end;//GetItemSize

function TvcmMainMenuStripForChromeLike.pm_GetMenuOrientation: TvcmBaseMenuForChromeLikeOrientation;
begin
 Result := vcm_moHorizontal;
end;

function TvcmMainMenuStripForChromeLike.pm_GetMenuItemMargins: TRect;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 Result.Top := 4;
end;

function TvcmMainMenuStripForChromeLike.GetSubmenuDropDownPoint(const anItem: TvcmMenuForChromeLikeItem): TPoint;
begin
 Result := Point(anItem.rRect.Left, anItem.rRect.Bottom);
end;

function TvcmMainMenuStripForChromeLike.pm_GetCurrentOpenedSubmenu: TvcmBaseMenuForChromeLike;
begin
 Result := f_CurrentOpenedSubmenu;
end;

procedure TvcmMainMenuStripForChromeLike.DoOnMenuClosed(aClosedMenu: TvcmBaseMenuForChromeLike;
                                                        aClosedMenuResult: TvcmMenuShowingResult);
begin
 if (aClosedMenu = f_CurrentOpenedSubmenu) then
  f_CurrentOpenedSubmenu := nil;

 f_NeedShowSubmenuOnSelect := (aClosedMenuResult = vcm_msrSiblingSelected) or
                              f_AnotherMenuItemSelected;
 f_OpenedSubmenuItem := cNullMenuForChromeLikeItem;
 f_ItemToExecute := cNullMenuForChromeLikeItem;

 KillMenuLater(aClosedMenu);

 if (aClosedMenuResult in [vcm_msrExecuted, vcm_msrClosedRecursive]) and
    (not f_ClosingDisabled) then
  CloseMenu(aClosedMenuResult);
end;

procedure TvcmMainMenuStripForChromeLike.ShowSubmenu(const anItem: TvcmMenuForChromeLikeItem;
                                                     const aPoint: TPoint;
                                                           aByKeyboard: Boolean);
begin
 Assert(not anItem.IsNull);
 if (not (anItem.EQ(f_OpenedSubmenuItem))) then
 begin
  f_NeedShowSubmenuOnSelect := True;

  f_DoNotOpenItemOnSelect := False;
  f_CurrentOpenedSubmenu := TvcmDropDownMenuForChromeLike.Create(Self, Self);
  f_CurrentOpenedSubmenu.ParentMenu := Self;
  f_WasSubmenuOpened := True;
  f_OpenedSubmenuItem := anItem;
  f_CurrentOpenedSubmenu.MenuItem := anItem.rItem;
  f_CurrentOpenedSubmenu.Parent := Self.Parent;
  f_CurrentOpenedSubmenu.ShowMenu(aPoint, aByKeyboard);
 end;
end;

procedure TvcmMainMenuStripForChromeLike.CloseMenu(aResult: TvcmMenuShowingResult);
begin
 inherited;
end;

procedure TvcmMainMenuStripForChromeLike.CloseCurrentOpenedSubmenu;
begin
 if (f_CurrentOpenedSubmenu <> nil) then
  f_CurrentOpenedSubmenu.CloseMenu(vcm_msrClosedRecursive);
end;

procedure TvcmMainMenuStripForChromeLike.SelectedItemChanged(const aPrevSelected: TvcmMenuForChromeLikeItem;
                                                             const aNewSelected: TvcmMenuForChromeLikeItem;
                                                                   aByKeyboard: Boolean);
var
 l_NeedOpenSubmenu: Boolean;
begin
 f_SelectedChanging := True;
 l_NeedOpenSubmenu := f_NeedShowSubmenuOnSelect;

 f_ClosingDisabled := True;

 if (f_CurrentOpenedSubmenu <> nil) then
  f_CurrentOpenedSubmenu.CloseBranch(vcm_msrSiblingSelected);

 if (HasHoveredItem and (not HoveredItem.EQ(aNewSelected))) then
  HoveredItem := cNullMenuForChromeLikeItem;

 Invalidate;

 if l_NeedOpenSubmenu and
  HasSubItems(aNewSelected) then
 begin
  f_AnotherMenuItemSelected := True;
  ExecuteMenuItem(aNewSelected, aByKeyboard);
  f_AnotherMenuItemSelected := False;
 end;
 f_ClosingDisabled := False;
 f_SelectedChanging := False;
end;

procedure TvcmMainMenuStripForChromeLike.HoveredItemChanged(const aPrevHovered: TvcmMenuForChromeLikeItem;
                                                            const aNewHovered: TvcmMenuForChromeLikeItem);
begin
 if (not f_SelectedChanging) and
    (not aPrevHovered.EQ(aNewHovered)) then
 begin
  if (HasSelectedItem or f_WasSubmenuOpened) and
     (not SelectedItem.EQ(aNewHovered)) and
     (not aNewHovered.IsNull) and
     f_NeedSetSelectedOnHovered then
   SelectedItem := aNewHovered
  else
   SelectedItem := cNullMenuForChromeLikeItem;
 end;
end;

procedure TvcmMainMenuStripForChromeLike.BeforeEnterMenuLoop;
var
 l_Form: TCustomForm;
begin
 inherited;
 l_Form := GetParentForm(Self);
 if (l_Form <> nil) then
  SendMessage(l_Form.Handle, WM_ENTERMENULOOP, 0, 0);
 // - Это чтобы форма думала, что работает настоящее меню
end;

function TvcmMainMenuStripForChromeLike.GetItemOwnerDrawState(const anItem: TvcmMenuForChromeLikeItem): TOwnerDrawState;
begin
 Result := inherited GetItemOwnerDrawState(anItem);
 if (not IsActive) then
  Result := Result + [odInactive];
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=590755050
end;

procedure TvcmMainMenuStripForChromeLike.ActiveChanged(aIsActive: Boolean);
begin
 if (not aIsActive) and
    InMenuLoop then
 begin
  if (f_CurrentOpenedSubmenu <> nil) then
   f_CurrentOpenedSubmenu.IsActive := aIsActive;
 end;
 Invalidate;
end;

procedure TvcmMainMenuStripForChromeLike.AfterMenuLoopFinished;
var
 l_Form: TCustomForm;
begin
 l_Form := GetParentForm(Self);
 if (l_Form <> nil) then
  SendMessage(l_Form.Handle, WM_EXITMENULOOP, 0, 0);
 // - Это чтобы форма думала, что работает настоящее меню
 inherited;
 f_WasSubmenuOpened := False;
 ResetSelection;
 Invalidate;
end;

procedure TvcmMainMenuStripForChromeLike.WMSize(var aMessage: TWMSize);
begin
 inherited;
 Invalidate;
end;

procedure TvcmMainMenuStripForChromeLike.vcmMsgShowMenu(var aMessage: TMessage);
begin
 ActivateMenu;
end;

procedure TvcmMainMenuStripForChromeLike.DoBeforePeekMessage;
begin
 inherited;
 if (not f_ItemToExecute.IsNull) then
 begin
  SelectedItem := f_ItemToExecute;
  f_ItemToExecute := cNullMenuForChromeLikeItem;
  ExecuteMenuItem(SelectedItem, False);
 end;
end;

procedure TvcmMainMenuStripForChromeLike.ProcessMouseMessage(var aMessage: TMsg);
var
 l_Form: TForm;
 l_MouseSPt: TPoint;
 l_MouseCPt: TPoint;
 l_MousePPt: TPoint;
 l_Control: TControl;
 l_ItemAtPt: TvcmMenuForChromeLikeItem;
begin
 case aMessage.message of
  WM_MBUTTONDOWN,
  WM_RBUTTONDOWN,
  WM_RBUTTONDBLCLK,
  WM_LBUTTONDOWN,
  WM_LBUTTONDBLCLK:
   begin
    GetCursorPos(l_MouseSPt);
    l_MouseCPt := ScreenToClient(l_MouseSPt);
    if (not PtInRect(ClientRect, l_MouseCPt)) then
    begin
     l_MousePPt := Parent.ScreenToClient(l_MouseSPt);
     l_Control := FindControl(aMessage.hwnd);
     if (l_Control = nil) or
        ((not (l_Control is TvcmBaseMenuForChromeLike)) or (l_Control.Parent <> Self.Parent)) then
     begin
      DeactivateMenu;
      Invalidate;
     end;//if (l_Control = nil)...
    end//if (not PtInRect(ClientRect, l_MouseCPt))...
    else
    begin
     l_ItemAtPt := GetItemAtPoint(l_MouseCPt);
     if (not l_ItemAtPt.IsNull) then
     begin
      if (not HoveredItem.EQ(l_ItemAtPt)) then
       HoveredItem := l_ItemAtPt;
      // - http://mdp.garant.ru/pages/viewpage.action?pageId=589103274 
     end;
    end;
   end;//WM_MBUTTONDOWN...
 end;//case aMessage.message
 DispatchMessage(aMessage);
end;

function TvcmMainMenuStripForChromeLike.ProcessKeyPressed(aKey: Word;
                                                          aActiveMenu: TvcmBaseMenuForChromeLike): Boolean;
begin
 Result := True;
 case aKey of
  VK_ESCAPE,
  VK_SPACE:
   begin
    f_NeedShowSubmenuOnSelect := False;
    if (aActiveMenu <> f_CurrentOpenedSubmenu) then
     CloseMenu(vcm_msrClosedRecursive);
   end;
  VK_LEFT:
   begin
    if (aActiveMenu <> f_CurrentOpenedSubmenu) and
       (aActiveMenu <> Self) then
     f_NeedShowSubmenuOnSelect := False;
    SelectPrevItem(True);
   end;
  VK_RIGHT:
   begin
    if (aActiveMenu <> f_CurrentOpenedSubmenu) and
       (aActiveMenu <> Self) then
     f_NeedShowSubmenuOnSelect := False;
    SelectNextItem(True);
   end;
  VK_UP,
  VK_DOWN,
  VK_RETURN:
   begin
    if SelectedItem.IsNull then
     SelectedItem := HoveredItem;
    ExecuteMenuItem(SelectedItem, True);
   end;
 else
  Result := False;
 end;
end;

procedure TvcmMainMenuStripForChromeLike.MouseMovedOverEmptyArea(aShift: TShiftState;
                                                                 const aPoint: TPoint);
begin
 if (f_CurrentOpenedSubmenu = nil) and
    (GetAsyncKeyState(VK_LBUTTON) >= 0)  then
 begin
  HoveredItem := cNullMenuForChromeLikeItem;
  SelectedItem := cNullMenuForChromeLikeItem;
 end;
end;

procedure TvcmMainMenuStripForChromeLike.MouseDown(aButton: TMouseButton;
                                                   aShift: TShiftState;
                                                   aX: Integer;
                                                   aY: Integer);
var
 l_ItemUnderMouse: TvcmMenuForChromeLikeItem;
begin
 inherited;
 l_ItemUnderMouse := GetItemAtPoint(Point(aX, aY));
 if (not InMenuLoop) then
 begin
  if PtInRect(ContentRect, Point(aX, aY)) then
   if (aButton = mbLeft) then
    if (not InMenuLoop) then
    begin
     f_ItemToExecute := l_ItemUnderMouse;
     f_NeedSetSelectedOnHovered := True;
     PostMessage(Handle, vcm_msgShowMenu, 0, 0);
    end;
 end
 else
 begin
  if (aButton = mbLeft) and
     IsActiveItem(l_ItemUnderMouse) and
     ((GetTickCount - f_LastMouseDown) > 200) then
  begin
   if HoveredItem.IsNull and SelectedItem.IsNull then
    HoveredItem := l_ItemUnderMouse;
   if (l_ItemUnderMouse.EQ(SelectedItem)) and
      (l_ItemUnderMouse.EQ(f_OpenedSubmenuItem)) then
   begin
    f_NeedSetSelectedOnHovered := False;
   end
   else
    f_NeedSetSelectedOnHovered := True;
   if (f_CurrentOpenedSubmenu = nil) then
    ExecuteMenuItem(l_ItemUnderMouse, False);
  end;
 end;
end;

procedure TvcmMainMenuStripForChromeLike.CMMouseLeave(var aMessage: TMessage);
var
 l_ButtonDown: Boolean;
begin
 l_ButtonDown := (GetAsyncKeyState(VK_LBUTTON) < 0);
 inherited;
 if (f_CurrentOpenedSubmenu = nil) or
    (not f_CurrentOpenedSubmenu.Visible) then
 begin
  if (not InMenuLoop) or
     (not l_ButtonDown) then
  begin
   HoveredItem := cNullMenuForChromeLikeItem;
   SelectedItem := cNullMenuForChromeLikeItem;
   ResetSelection;
   Invalidate;
  end
  else
  if InMenuLoop and
     l_ButtonDown then
  begin
   if (f_CurrentOpenedSubmenu = nil) and
      (not HoveredItem.IsNull) then
   begin
    SelectedItem := HoveredItem;
    ExecuteMenuItem(SelectedItem, True);
   end;
  end;
 end;
end;

procedure TvcmMainMenuStripForChromeLike.ActivateMenu(aByKeyboard: Boolean = False);
begin
 IsActive := True;
 if aByKeyboard then
  SelectFirstItem(True);
 EnterMenuLoop;
end;

procedure TvcmMainMenuStripForChromeLike.DeactivateMenu;
begin
 f_NeedSetSelectedOnHovered := False;
 CloseMenu(vcm_msrClosedRecursive);
 ClearKilledMenus;
 SelectedItem := cNullMenuForChromeLikeItem;
 HoveredItem := cNullMenuForChromeLikeItem;
 Invalidate;
 afw.ProcessMessages;
 ExecuteCommand;
end;

end.
