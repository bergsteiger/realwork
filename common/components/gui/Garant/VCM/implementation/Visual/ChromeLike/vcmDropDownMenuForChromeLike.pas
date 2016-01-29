unit vcmDropDownMenuForChromeLike;

interface
uses
 Classes,
 Controls,
 Messages,
 Menus,
 Graphics,
 Types,
 Windows,
 vcmMainMenuForChromeLikeTypes,
 vcmBaseMenuForChromeLike,
 vcmMenuForChromeLikeItems;

type
 TvcmDropDownMenuForChromeLike = class(TvcmBaseMenuForChromeLike)
 private
  f_Closing: Boolean;
  f_InShowing: Boolean;
  f_ItemHoveredTickCount: Cardinal;
  f_SubmenuItem: TvcmMenuForChromeLikeItem;
  f_ShowingSubmenu: Boolean;
  f_NeedDisplayShadow: Boolean;
  f_IsSubmenu: Boolean;
  f_OpenedSubmenu: TvcmDropDownMenuForChromeLike;
  f_OpenedSubmenuToClose: TvcmDropDownMenuForChromeLike;
  f_OpenedSubmenuCloseRequestedTickCount: Cardinal;
  f_DoNotOpenSubmenuOnHover: Boolean;
  f_BorderColor: TColor;
  f_SubMenuExpandDelay: Cardinal;
  f_SubMenuCollapseDelay: Cardinal;
  f_LastMouseDown: Cardinal;
  f_NeedSelectFirstItem: Boolean;
  f_NeedOpenHoveredAfterClosingItem: Boolean;
  f_IsDragging: Boolean;
 private
  procedure ExpandHoveredItemIfNeeded;
  {-}
  procedure CloseSubmenuAndExpandAnother(const anItem: TvcmMenuForChromeLikeItem);
  {-}
 protected
  function NeedAddItem(aRootItem: TMenuItem;
                       anItem: TMenuItem;
                       anIndex: Integer): Boolean;
    override;
  {-}
  procedure CloseCurrentOpenedSubmenu;
   override;
  {-}
  function GetItemSizeForAlign(const aTotalSize: TSize; anItem: TMenuItem): TSize;
    override;
  {-}
  function pm_GetMenuOrientation: TvcmBaseMenuForChromeLikeOrientation;
    override;
  {-}
  function pm_GetMenuItemMargins: TRect;
    override;
  {-}
  function CanHoverItem: Boolean;
    override;
  {-}
  procedure DoOnMenuClosed(aClosedMenu: TvcmBaseMenuForChromeLike;
                           aClosedMenuResult: TvcmMenuShowingResult);
    override;
  {-}
  procedure ExecuteMenuItem(const anItem: TvcmMenuForChromeLikeItem;
                                  aByKeyboard: Boolean);
    override;
  {-}
  procedure ShowSubmenu(const anItem: TvcmMenuForChromeLikeItem;
                        const aPoint: TPoint;
                              aByKeyboard: Boolean);
    override;
  {-}
  function CheckPopupPoint(const aPoint: TPoint): TPoint;
  {-}
  procedure WMMouseActivate(var aMessage: TWMMouseActivate);
    message WM_MOUSEACTIVATE;
  {-}
  procedure CMCancelMode(var aMessage: TMessage);
    message CM_CANCELMODE;
  {-}
  procedure CMShowingChanged(var aMessage: TMessage);
    message CM_SHOWINGCHANGED;
  {-}
  procedure vcmMsgShowMenu(var aMessage: TMessage);
    message vcm_msgShowMenu;
  {-}
  procedure MouseDown(aButton: TMouseButton;
                     aShift: TShiftState;
                     aX: Integer;
                     aY: Integer);
    override;
  {-}
  procedure CreateParams(var aParams: TCreateParams); override;
  {-}
  function GetSubmenuDropDownPoint(const anItem: TvcmMenuForChromeLikeItem): TPoint;
    override;
  {-}
  function pm_GetIsTopLevelMenu: Boolean;
    override;
  {-}
  function pm_GetCurrentOpenedSubmenu: TvcmBaseMenuForChromeLike;
    override;
  {-}
  procedure PaintItem(const anItem: TvcmMenuForChromeLikeItem; aState: TOwnerDrawState);
    override;
  {-}
  procedure DoAfterItemsPainted;
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
  procedure ActiveChanged(aIsActive: Boolean);
    override;
  {-}
 public
  procedure ShowMenu(const aPoint: TPoint;
                           aNeedSelectFirstItem: Boolean);
  {-}
  procedure CloseMenu(aResult: TvcmMenuShowingResult);
    override;
  {-}
  procedure CloseOpenedSubmenuIfNeeded;
   override;
  {-}
  constructor Create(aOwner: TComponent;
                     aParentMenu: TvcmBaseMenuForChromeLike);
  {-}
  property SubMenuExpandDelay: Cardinal
    read f_SubMenuExpandDelay
    write f_SubMenuExpandDelay;
  {-}
  property SubMenuCollapseDelay: Cardinal
    read f_SubMenuCollapseDelay
    write f_SubMenuCollapseDelay;
  {-}
 end;

implementation
uses
 ActnList,
 l3Base,
 SysUtils,
 MultiMon,
 UxTheme,
 Forms,
 afwFacade;

type
  THackCustomForm = class(TCustomForm);

const
 cBackgroundColor                     = $00F9F8FA;
 cDropDownMenuBorderColor             = $00A0A0A0;
 cComboArrowFromTopItemEdgeDistance   = 5;
 cComboArrowFromRightItemEdgeDistance = 6;
 cComboArrowHeight                    = 6;
 cComboArrowWidth                     = 3;
 cSubmenuExpandDelay: Cardinal        = 200;
 cSubmenuCollapseDelay: Cardinal      = 200;
 cMenuMargins: TRect = (Left: 3; Top: 3; Right: 3; Bottom: 3);


procedure TvcmDropDownMenuForChromeLike.ExpandHoveredItemIfNeeded;
var
 l_TickCount: Cardinal;
begin
 l_TickCount := GetTickCount;
 if (not f_DoNotOpenSubmenuOnHover) and
    f_SubMenuItem.IsNull and
    (not HoveredItem.IsNull) and
    (HoveredItem.rItem.Count > 0) and
    ((l_TickCount - f_ItemHoveredTickCount) >= SubmenuExpandDelay) then
 begin
  f_OpenedSubmenuCloseRequestedTickCount := 0;
  ExecuteMenuItem(HoveredItem, False);
 end;
end;

procedure TvcmDropDownMenuForChromeLike.CloseSubmenuAndExpandAnother(const anItem: TvcmMenuForChromeLikeItem);
begin
 // http://mdp.garant.ru/pages/viewpage.action?pageId=585407141
 f_NeedOpenHoveredAfterClosingItem := True;
 CloseCurrentOpenedSubmenu;
end;

function TvcmDropDownMenuForChromeLike.NeedAddItem(aRootItem: TMenuItem;
                                                         anItem: TMenuItem;
                                                         anIndex: Integer): Boolean;
var
 l_NextItem: TMenuItem;
begin
 Result := (not anItem.IsLine) and inherited NeedAddItem(aRootItem, anItem, anIndex);
 if anItem.IsLine then
  if (anIndex < Pred(aRootItem.Count)) then
  begin
   l_NextItem := aRootItem.Items[Succ(anIndex)];
   Result := (not l_NextItem.IsLine) and
             l_NextItem.Visible;
  end;
end;

procedure TvcmDropDownMenuForChromeLike.CloseCurrentOpenedSubmenu;
begin
 if (not f_SubMenuItem.IsNull) and
    (f_OpenedSubmenu <> nil) and
    (not f_OpenedSubmenu.f_InShowing) then
 begin
  f_OpenedSubmenuToClose := f_OpenedSubmenu;
  f_OpenedSubmenuCloseRequestedTickCount := GetTickCount;
 end;
end;

function TvcmDropDownMenuForChromeLike.GetItemSizeForAlign(const aTotalSize: TSize;
                                                                       anItem: TMenuItem): TSize;
begin
 Result := GetItemSize(anItem);
 Result.cx := aTotalSize.cx;
end;

function TvcmDropDownMenuForChromeLike.pm_GetMenuOrientation: TvcmBaseMenuForChromeLikeOrientation;
begin
 Result := vcm_moVertical;
end;

function TvcmDropDownMenuForChromeLike.pm_GetMenuItemMargins: TRect;
var
 l_Rect: TRect;
 l_AdjustedRect: TRect;
begin
 if IsAppThemed then
  Result := cMenuMargins
 else
 begin
  l_Rect := Rect(0, 0, 12, 12);
  l_AdjustedRect := l_Rect;
  DrawEdge(Canvas.Handle,
           l_AdjustedRect,
           BDR_RAISEDINNER or BDR_RAISEDOUTER,
           BF_RECT or BF_ADJUST);
  Result.Top    := l_AdjustedRect.Top - l_Rect.Top + 1;
  Result.Bottom := l_Rect.Bottom - l_AdjustedRect.Bottom + 1;
  Result.Left   := l_AdjustedRect.Left - l_Rect.Left + 1;
  Result.Right  := l_Rect.Right - l_AdjustedRect.Right + 1;
 end;
end;

function TvcmDropDownMenuForChromeLike.CanHoverItem: Boolean;
begin
 Result := inherited CanHoverItem;
end;

procedure TvcmDropDownMenuForChromeLike.DoOnMenuClosed(aClosedMenu: TvcmBaseMenuForChromeLike;
                                                             aClosedMenuResult: TvcmMenuShowingResult);
begin
 f_ItemHoveredTickCount := 0;
 f_DoNotOpenSubmenuOnHover := True;
 f_OpenedSubmenu := nil;
 f_SubmenuItem := cNullMenuForChromeLikeItem;
 inherited;
 if f_NeedOpenHoveredAfterClosingItem then
 begin
  // - Нужно после закрытия текущего подменю открыть новое, то, которое выделено
  // http://mdp.garant.ru/pages/viewpage.action?pageId=585407141
  f_DoNotOpenSubmenuOnHover := False;
  ExpandHoveredItemIfNeeded;
  f_NeedOpenHoveredAfterClosingItem := False;
 end;
end;

procedure TvcmDropDownMenuForChromeLike.ExecuteMenuItem(const anItem: TvcmMenuForChromeLikeItem;
                                                                    aByKeyboard: Boolean);
var
 l_SubMenuResult: TvcmMenuShowingResult;
 l_Pt: TPoint;
begin
 anItem.rItem.CallInitiateActions;
 if IsActiveItem(anItem) then
 begin
  if (anItem.rItem.Count = 0) then
  begin
   Visible := False;
   CloseMenu(vcm_msrExecuted);
   ClickMenuItem(anItem);
  end//if (anItem.rItem.Count = 0)
  else
  begin
   l_Pt := GetSubmenuDropDownPoint(anItem);
   ShowSubmenu(anItem, l_Pt, aByKeyboard);
  end;//if (not anItem.EQ(f_SubmenuItem))
 end;
end;

procedure TvcmDropDownMenuForChromeLike.ShowSubmenu(const anItem: TvcmMenuForChromeLikeItem;
 const aPoint: TPoint;
 aByKeyboard: Boolean);
var
 l_MenuItem: TMenuItem;
 l_OpenedSubmenu: TvcmBaseMenuForChromeLike;
begin
 l_MenuItem := nil;
 if (f_OpenedSubmenu <> nil) then
 begin
  l_MenuItem := f_OpenedSubmenu.MenuItem;
  l_OpenedSubmenu := f_OpenedSubmenu;
  f_OpenedSubmenu := nil;
  f_SubmenuItem := cNullMenuForChromeLikeItem;
  f_DoNotOpenSubmenuOnHover := True;
  f_ShowingSubmenu := False;
  l_OpenedSubmenu.CloseMenu(vcm_msrClosed);
 end
 else
 if (l_MenuItem <> anItem.rItem) then
 begin
  f_SubmenuItem := anItem;
  f_OpenedSubmenu := TvcmDropDownMenuForChromeLike.Create(Owner, Self);
  f_DoNotOpenSubmenuOnHover := False;
  f_OpenedSubmenu.MenuItem := anItem.rItem;
  f_OpenedSubmenu.Parent := Parent;
  f_OpenedSubmenu.f_IsSubMenu := True;
  f_ShowingSubmenu := True;
  f_OpenedSubmenu.ShowMenu(aPoint, aByKeyboard);
 end;
end;

function TvcmDropDownMenuForChromeLike.CheckPopupPoint(const aPoint: TPoint): TPoint;

 function lp_GetMonitorRect(aMonitor: HMONITOR): TRect;
 var
  l_MonitorRect: TRect;
  l_MI: TMonitorInfoA;
 begin
  l3FillChar(Result, SizeOf(Result), 0);
  l3FillChar(l_MI, SizeOf(l_MI), 0);

  if (aMonitor <> 0) then
  begin
   l_MI.cbSize := SizeOf(l_MI);
   GetMonitorInfo(aMonitor, @l_MI);
   Result := l_MI.rcWork;
  end;//if (l_Monitor <> 0)...
 end;//lp_GetMonitorRect

 function lp_PlacePointToSingleMonitor(const aPoint: TPoint;
                                       const aMenuWndSize: TSize;
                                       const aFormMonitorRect: TRect;
                                       const aPointMonitorRect: TRect;
                                             aSameMonitor: Boolean): TPoint;
 var
  l_ParentItemCRect: TRect;
  l_ParentItemSRect: TRect;
  l_RightPoint: TPoint;
  l_CenterPoint: TPoint;
  l_DecidedMonitorRect: TRect;
 begin
  Result := aPoint;
  l_ParentItemCRect := ParentMenu.GetMenuParentItem(Self).rRect;
  l_ParentItemSRect.TopLeft := ParentMenu.ClientToScreen(l_ParentItemCRect.TopLeft);
  l_ParentItemSRect.BottomRight := ParentMenu.ClientToScreen(l_ParentItemCRect.BottomRight);

  l_CenterPoint := CenterPoint(l_ParentItemSRect);

  if PtInRect(aPointMonitorRect, l_CenterPoint) then
  begin
   if ((Result.X + aMenuWndSize.cx) > aPointMonitorRect.Right) then
    Result.X := aPointMonitorRect.Right - aMenuWndSize.cx;
  end
  else
  begin
   if (not aSameMonitor) and (ParentMenu = RootMenu) then
   begin
    Result := Point(aFormMonitorRect.Left, aPoint.Y);
    if ((Result.X + aMenuWndSize.cx) > aFormMonitorRect.Right) then
      Result.X := aFormMonitorRect.Right - aMenuWndSize.cx
   end
   else
   begin
    if (l_ParentItemSRect.Right > aFormMonitorRect.Right) and
       (ParentMenu = RootMenu) then
     Result.X := aFormMonitorRect.Right - aMenuWndSize.cx;
   end;
  end;
  if (MonitorFromPoint(Result, MONITOR_DEFAULTTONULL) = 0) then
  begin
   if (Result.X < aFormMonitorRect.Left) then
    Result.X := aFormMonitorRect.Left
   else
   if (Result.X > aFormMonitorRect.Right) then
    Result.X := aFormMonitorRect.Right - aMenuWndSize.cx;
  end;
 end;

var
 l_Size: TSize;
 l_ParentForm: TCustomForm;
 l_ParentFormMonitor: HMONITOR;
 l_PointMonitor: HMONITOR;
 l_ParentFormMonitorRect: TRect;
 l_PointMonitorRect: TRect;
 l_PtOnAnotherMonitor: Boolean;
 l_MenuOnTwoMonitors: Boolean;
begin
 l_PtOnAnotherMonitor := False;
 l_MenuOnTwoMonitors := False;

 l_ParentForm := GetParentForm(RootMenu);

 l_Size := TotalSize;
 CorrectBounds;
 Result := aPoint;

 l_ParentFormMonitor := MonitorFromWindow(l_ParentForm.Handle,
                                          MONITOR_DEFAULTTONEAREST);
 // - монитор, на котором расположена большая часть формы
 l_ParentFormMonitorRect := lp_GetMonitorRect(l_ParentFormMonitor);

 l_PointMonitor := MonitorFromPoint(aPoint,
                                    MONITOR_DEFAULTTONEAREST);
 // - монитор, в который попала точка aPoint
 l_PointMonitorRect := lp_GetMonitorRect(l_PointMonitor);

 Result := lp_PlacePointToSingleMonitor(aPoint,
                                        l_Size,
                                        l_ParentFormMonitorRect,
                                        l_PointMonitorRect,
                                        (l_PointMonitor = l_ParentFormMonitor));
end;

procedure TvcmDropDownMenuForChromeLike.WMMouseActivate(var aMessage: TWMMouseActivate);
begin
 aMessage.Result := MA_NOACTIVATE;
end;

procedure TvcmDropDownMenuForChromeLike.CMCancelMode(var aMessage: TMessage);
begin
 inherited;
 CloseMenu(vcm_msrClosed);
end;

procedure TvcmDropDownMenuForChromeLike.CMShowingChanged(var aMessage: TMessage);
begin
 if Showing then
  ShowWindow(Handle, SW_SHOWNOACTIVATE)
 else
  inherited;
end;

procedure TvcmDropDownMenuForChromeLike.vcmMsgShowMenu(var aMessage: TMessage);
var
 l_Point: TPoint;
 l_ActualPoint: TPoint;
begin
 if (not f_Closing) then
 begin
  f_InShowing := True;
  Assert(not (csDestroying in ComponentState));
  Assert(not f_Closing);
  l_Point := Point(aMessage.WParam, aMessage.LParam);
  l_ActualPoint := CheckPopupPoint(l_Point);
  Left := l_ActualPoint.X;
  Top  := l_ActualPoint.Y;
  Show;
  f_InShowing := False;
  Assert(not f_Closing);
  Assert(ParentMenu <> nil);

  if f_NeedSelectFirstItem then
  begin
   SelectFirstItem(True);
   f_NeedSelectFirstItem := False;
  end;

  if (not InMenuLoop) then
   EnterMenuLoop;
 end;
end;

procedure TvcmDropDownMenuForChromeLike.MouseDown(aButton: TMouseButton;
                                                       aShift: TShiftState;
                                                       aX: Integer;
                                                       aY: Integer);
var
 l_ItemUnderMouse: TvcmMenuForChromeLikeItem;
begin
 l_ItemUnderMouse := GetItemAtPoint(Point(aX, aY));
 if (aButton = mbLeft) and
    IsActiveItem(l_ItemUnderMouse) and
    ((GetTickCount - f_LastMouseDown) > cMouseUpInterval) then
 begin
  f_LastMouseDown := GetTickCount;
  ExecuteMenuItem(l_ItemUnderMouse, False);
 end;
end;

procedure TvcmDropDownMenuForChromeLike.CreateParams(var aParams: TCreateParams);
begin
 inherited;
 if f_NeedDisplayShadow then
  aParams.WindowClass.Style := aParams.WindowClass.Style or CS_DROPSHADOW;
 aParams.Style   := WS_POPUP and (not WS_VISIBLE);
 aParams.ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST or WS_EX_NOACTIVATE;
end;

function TvcmDropDownMenuForChromeLike.GetSubmenuDropDownPoint(const anItem: TvcmMenuForChromeLikeItem): TPoint;
var
 l_cPt: TPoint;
begin
 l_cPt := Point(anItem.rRect.Right, anItem.rRect.Top);
 Result := ClientToScreen(l_cPt);
end;

function TvcmDropDownMenuForChromeLike.pm_GetIsTopLevelMenu: Boolean;
begin
 Result := (f_OpenedSubmenu = nil);
end;

function TvcmDropDownMenuForChromeLike.pm_GetCurrentOpenedSubmenu: TvcmBaseMenuForChromeLike;
begin
 Result := f_OpenedSubmenu;
end;

procedure TvcmDropDownMenuForChromeLike.PaintItem(const anItem: TvcmMenuForChromeLikeItem;
                                                              aState: TOwnerDrawState);

 procedure lp_DrawArrow(const anItemRect: TRect; aIsHighlighted: Boolean);
 (* - рисует стрелку ">" для пунктов с подменю *)
 const
  cArrowColors: array[Boolean] of TColor = (clMenuText, clWhite);
  (* Для невыделенного пункта цвет стрелки - цвет текста меню,
     для выделенного - белый *)
 var
  l_Rect: TRect;
  l_Points: array[0..2] of TPoint;
  l_BrushRecall: TBrushRecall;
  l_PenRecall: TPenRecall;
  l_ArrowColor: TColor;
 begin
  with l_Rect do
  begin
   Right  := anItemRect.Right - cComboArrowFromRightItemEdgeDistance;
   Left   := l_Rect.Right - cComboArrowWidth;
   Top    := anItemRect.Top + cComboArrowFromTopItemEdgeDistance;
   Bottom := l_Rect.Top + cComboArrowHeight;
  end;//with l_Rect
  l_Points[0] := Point(l_Rect.Left,  l_Rect.Top);
  l_Points[1] := Point(l_Rect.Right, l_Rect.Top + (cComboArrowHeight div 2));
  l_Points[2] := Point(l_Rect.Left,  l_Rect.Bottom);
  l_BrushRecall := TBrushRecall.Create(Canvas.Brush);
  try
   l_PenRecall := TPenRecall.Create(Canvas.Pen);
   try
    l_ArrowColor := cArrowColors[aIsHighLighted];
    with Canvas do
    begin
     Brush.Style := bsSolid;
     Brush.Color := l_ArrowColor;
     Pen.Style   := psSolid;
     Pen.Color   := l_ArrowColor;
    end;//with aCanvas
    Polygon(Canvas.Handle, l_Points[0], 3);
    // - Рисуем стрелку
   finally
    FreeAndNil(l_PenRecall);
   end;//try..finally
  finally
   FreeAndNil(l_BrushRecall);
  end;//try..finally
 end;//lp_DrawArrow

begin
 inherited;
 if HasSubItems(anItem) and
    IsActiveItem(anItem) then
  lp_DrawArrow(anItem.rRect, (([odSelected, odFocused] * aState) <> []));
end;

procedure TvcmDropDownMenuForChromeLike.DoAfterItemsPainted;
var
 l_Styles: UINT;
 l_EdgesRect: TRect;
 l_AdditionalRect: TRect;
begin
 if IsAppThemed then
  with Canvas do
  begin
   Brush.Style := bsClear;
   Pen.Style := psSolid;
   Pen.Width := 1;
   Pen.Color := cDropDownMenuBorderColor;
   Rectangle(ClientRect);
  end//with Canvas
 else
 begin
  l_Styles := BDR_RAISEDINNER or BDR_RAISEDOUTER;
  l_EdgesRect := ClientRect;
  DrawEdge(Canvas.Handle,
           l_EdgesRect,
           l_Styles,
           BF_RECT);
  l_AdditionalRect := ContentRect;
  InflateRect(l_AdditionalRect, 1, 1);
  with Canvas do
  begin
   Pen.Color := clBtnFace;
   Pen.Style := psSolid;
   Pen.Width := 1;
   Rectangle(l_AdditionalRect);
  end;//with Canvas
 end;
end;

procedure TvcmDropDownMenuForChromeLike.SelectedItemChanged(const aPrevSelected: TvcmMenuForChromeLikeItem;
                                                                  const aNewSelected: TvcmMenuForChromeLikeItem;
                                                                        aByKeyboard: Boolean);
begin
 inherited;
 if (not aPrevSelected.EQ(aNewSelected)) and
    (not aByKeyboard) then
  f_DoNotOpenSubmenuOnHover := False;
end;

procedure TvcmDropDownMenuForChromeLike.HoveredItemChanged(const aPrevHovered: TvcmMenuForChromeLikeItem;
                                                                 const aNewHovered: TvcmMenuForChromeLikeItem);
begin
 f_DoNotOpenSubmenuOnHover := False;
 if (not SelectedItem.IsNull) and
    (not SelectedItem.EQ(aNewHovered)) then
  SelectedItem := aNewHovered;
 Invalidate;
 f_ItemHoveredTickCount := GetTickCount;
 if (not f_SubmenuItem.IsNull) and
    (not f_SubmenuItem.EQ(HoveredItem)) then
  CloseSubmenuAndExpandAnother(aNewHovered);
 // - Нужно закрыть текущее меню и открыть то, которое под мышью
end;

procedure TvcmDropDownMenuForChromeLike.BeforeEnterMenuLoop;
begin
 f_OpenedSubmenuCloseRequestedTickCount := 0;
 f_ItemHoveredTickCount := 0;
 Assert(not f_Closing);
end;

procedure TvcmDropDownMenuForChromeLike.DoBeforePeekMessage;
begin
 inherited;
 if (f_OpenedSubmenuCloseRequestedTickCount = 0) then
  ExpandHoveredItemIfNeeded;
 CloseOpenedSubmenuIfNeeded;
end;

procedure TvcmDropDownMenuForChromeLike.ProcessMouseMessage(var aMessage: TMsg);

 function lp_GetMousePt: TPoint;
 begin
  Result.X := SmallInt(aMessage.LParam and $FFFF);
  Result.Y := SmallInt((aMessage.LParam shr 16) and $FFFF);
 end;//lp_GetMousePt

var
 l_MousePt: TPoint;
 l_Form: TForm;
 l_MouseSPt: TPoint;
 l_MouseCPt: TPoint;
 l_MousePPt: TPoint;
 l_Control: TWinControl;
 l_ParentRect: TRect;
 l_IsClickInParentItem: Boolean;
 l_ShiftState: TShiftState;
 l_WasDragging: Boolean;
 l_Message: TMsg;
begin
 l_MousePt := lp_GetMousePt;
 l_Control := FindControl(aMessage.hwnd);
 l_ShiftState := KeysToShiftState(Word(aMessage.WParam));
 l_WasDragging := f_IsDragging;
 case aMessage.message of
   WM_MBUTTONDOWN,
   WM_RBUTTONDOWN,
   WM_RBUTTONDBLCLK,
   WM_LBUTTONDOWN,
   WM_LBUTTONDBLCLK,
   WM_LBUTTONUP:
    if (not Closing) and IsActive then
    begin
     if (aMessage.message = WM_LBUTTONUP) and (not f_IsDragging) then
     begin
      DispatchMessage(aMessage);
      Exit;
     end;
     f_IsDragging := False;
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=586683697
     l_ParentRect := ParentMenu.BoundsRect;
     GetCursorPos(l_MouseSPt);
     l_MouseCPt := ScreenToClient(l_MouseSPt);
     if (not PtInRect(ClientRect, l_MouseCPt)) then
     begin
      l_MousePPt := Parent.ScreenToClient(l_MouseSPt);

      l_IsClickInParentItem := ((l_Control <> nil) and
         (l_Control = ParentMenu) and
         (ParentMenu <> RootMenu) and
         (ParentMenu.GetItemAtPoint(l_MousePt).rItem = Self.MenuItem));

      if (not l_IsClickInParentItem) then
      begin
       if (l_Control = nil) or
          (not (l_Control Is TvcmDropDownMenuForChromeLike)) and
          (l_Control <> RootMenu) and
          (not PtInRect(l_ParentRect, l_MouseSPt)) then
          // - Иначе при клике на пункте с подпунктами при открытом подменю
          // оно закроется. http://mdp.garant.ru/pages/viewpage.action?pageId=578889012
       begin
        Visible := False;
        RootMenu.CloseMenuAndExecute(Self,
                                     vcm_msrClosedRecursive,
                                     MakeDispatchMessageCommand(aMessage));
        Exit;
       end
       else
       begin
        DispatchMessage(aMessage);
        CloseMenu(vcm_msrClosed);
        Exit;
       end;
       DispatchMessage(aMessage);
      end;
     end//if (not PtInRect(ClientRect, l_MouseCPt))
     else
     begin
      if ((aMessage.message = WM_LBUTTONUP) and l_WasDragging) then
        MouseDown(mbLeft, l_ShiftState, l_MouseCPt.X, l_MouseCPt.Y)
      else
      if (aMessage.message = WM_LBUTTONDOWN) then
      begin
       while true do
        if PeekMessage(l_Message, 0, WM_LBUTTONUP, WM_LBUTTONUP, PM_REMOVE) then
        begin
         MouseDown(mbLeft, l_ShiftState, l_MouseCPt.X, l_MouseCPt.Y);
         Break;
         // - http://mdp.garant.ru/pages/viewpage.action?pageId=588040332
        end;
      end
      else
       DispatchMessage(aMessage);
     end;
    end;
  WM_MOUSEMOVE:
   begin
    if (l_Control <> nil) then
    begin
     l_MouseSPt := l_Control.ClientToScreen(lp_GetMousePt);
     l_MouseCPt := ScreenToClient(l_MouseSPt);
     if PtInRect(ClientRect, l_MouseCPt) then
     begin
      if ((aMessage.WParam and MK_LBUTTON) <> 0) then
       f_IsDragging := True;
      MouseMove(l_ShiftState, l_MouseCPt.X, l_MouseCPt.Y)
      // - http://mdp.garant.ru/pages/viewpage.action?pageId=586683697
     end
     else
      DispatchMessage(aMessage);
    end
    else
     DispatchMessage(aMessage);
   end;
  else
   DispatchMessage(aMessage);
 end;//case aMessage.message
end;

function TvcmDropDownMenuForChromeLike.ProcessKeyPressed(aKey: Word;
                                                               aActiveMenu: TvcmBaseMenuForChromeLike): Boolean;
var
 l_CanProcessInParent: Boolean;
begin
 l_CanProcessInParent := (aActiveMenu = Self) and (ParentMenu <> nil);
 Result := True;
 case aKey of
  VK_ESCAPE:
   begin
    if (aActiveMenu = Self) then
    begin
     CloseMenu(vcm_msrClosed);
     ParentMenu.NotifyKeyPressedInSubmenu(aKey, Self);
    end;
   end;
  VK_UP:
   begin
    f_DoNotOpenSubmenuOnHover := True;
    SelectPrevItem(True);
   end;
  VK_DOWN:
   begin
    f_DoNotOpenSubmenuOnHover := True;
    SelectNextItem(True);
   end;
  VK_RIGHT:
   begin
    if (not HasSelectedItem) and HasHoveredItem then
     SelectedItem := HoveredItem;
    if HasSelectedItem and
       (SelectedItem.rItem.Count > 0) and
       SelectedItem.rItem.Enabled then
     ExecuteMenuItem(SelectedItem, True)
    else
    if l_CanProcessInParent then
     ParentMenu.NotifyKeyPressedInSubmenu(aKey, Self);
   end;
  VK_LEFT:
   if f_IsSubMenu then
    CloseMenu(vcm_msrClosed)
   else
   if l_CanProcessInParent then
    ParentMenu.NotifyKeyPressedInSubmenu(aKey, Self);
  VK_RETURN,
  VK_SPACE:
   begin
    if HasSelectedItem then
     ExecuteMenuItem(SelectedItem, True);
   end;//VK_RETURN
 else
  Result := False;
 end;//case l_KeyDownMessage.CharCode
end;

procedure TvcmDropDownMenuForChromeLike.MouseMovedOverEmptyArea(aShift: TShiftState;
                                                                      const aPoint: TPoint);
begin
 inherited;
 if (ssLeft in aShift) then
 begin
  ResetSelection;
  Invalidate;
 end;//if (ssLeft in aShift)
end;

procedure TvcmDropDownMenuForChromeLike.ActiveChanged(aIsActive: Boolean);
begin
 if (not aIsActive) and
    InMenuLoop then
 begin
  if IsTopLevelMenu then
   CloseMenu(vcm_msrClosedRecursive)
  else
   f_OpenedSubmenu.IsActive := aIsActive;
 end;
end;

procedure TvcmDropDownMenuForChromeLike.ShowMenu(const aPoint: TPoint;
                                                       aNeedSelectFirstItem: Boolean);
begin
 UpdateItems;
 Assert(not f_Closing);
 Handle;
 f_NeedSelectFirstItem := aNeedSelectFirstItem;
 PostMessage(Handle, vcm_msgShowMenu, aPoint.X, aPoint.Y);
end;

procedure TvcmDropDownMenuForChromeLike.CloseMenu(aResult: TvcmMenuShowingResult);
var
 l_ParentForm: TCustomForm;
begin
 Assert(not f_InShowing);
 CloseCurrentOpenedSubmenu;
 f_Closing := True;
 InMenuLoop := False;
 Visible := False;
 inherited;
 l_ParentForm := GetParentForm(Self);
 if (l_ParentForm <> nil) then
  UpdateWindow(l_ParentForm.Handle);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=589874760
end;

procedure TvcmDropDownMenuForChromeLike.CloseOpenedSubmenuIfNeeded;
var
 l_TickCount: Cardinal;
begin
 l_TickCount := GetTickCount;
 if (not f_SubMenuItem.IsNull) and
    (f_OpenedSubmenu <> nil) and
    (f_OpenedSubmenuCloseRequestedTickCount <> 0) and
    (f_OpenedSubmenu = f_OpenedSubmenuToClose) and
    ((l_TickCount - f_OpenedSubmenuCloseRequestedTickCount) > SubmenuCollapseDelay) then
 begin
  f_OpenedSubmenu.CloseMenu(vcm_msrClosed);
  f_OpenedSubmenuCloseRequestedTickCount := 0;
  f_OpenedSubmenuToClose := nil;
 end;//if (not f_SubMenuItem.IsNull)...
 if (ParentMenu <> nil) and
    (not (csDestroying in ParentMenu.ComponentState)) then
  ParentMenu.CloseOpenedSubmenuIfNeeded;
end;

constructor TvcmDropDownMenuForChromeLike.Create(aOwner: TComponent;
                                                aParentMenu: TvcmBaseMenuForChromeLike);
var
 l_DisplayShadow: BOOL;
begin
 if SystemParametersInfo(SPI_GETDROPSHADOW, 0, @l_DisplayShadow, 0) then
  f_NeedDisplayShadow := l_DisplayShadow;

 ParentMenu := aParentMenu;
 f_OpenedSubmenu := nil;
 inherited Create(aOwner);
 Visible := False;

 f_BorderColor := cDropDownMenuBorderColor;
 f_SubMenuExpandDelay := cSubmenuExpandDelay;
 f_SubMenuCollapseDelay := cSubmenuCollapseDelay
end;

initialization
 InitThemeLibrary;
finalization
 FreeThemeLibrary;

end.


