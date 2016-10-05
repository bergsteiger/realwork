unit vcmBaseMenuForChromeLike;

interface
uses
 Classes,
 Controls,
 Messages,
 Menus,
 Graphics,
 Types,
 Windows,
 l3LongIntList,
 afwInterfaces,
 vcmMainMenuForChromeLikeTypes,
 vcmMenuForChromeLikeItems;

type
 TvcmBaseMenuForChromeLikeOrientation = (vcm_moVertical,   // Пункты меню располагаются по вертикали
                                         vcm_moHorizontal);// Пункты меню располагаются по горизонтали


 TvcmBaseMenuOnCloseActionType = (vcm_mcatExecuteItem,
                                  vcm_mcatDispatchMessage);


 TvcmBaseMenuForChromeLike = class(TWinControl, IafwApplicationDataListener)
 (* Базовый класс для разных меню *)
 private
  f_Buffer: Graphics.TBitmap;
  f_Items: TvcmMenuForChromeLikeItems;
  f_MenuItem: TMenuItem;
  f_HoveredItem: TvcmMenuForChromeLikeItem;
  f_SelectedItem: TvcmMenuForChromeLikeItem;
  f_SubmenuItem: TvcmMenuForChromeLikeItem;
  f_InMenuLoop: Boolean;
  f_MousePos: TPoint;
  f_MouseControl: TControl;
  f_IsActive: Boolean;
  f_DoNotOpenSubmenuOnHover: Boolean;
  f_SkipDisabledItemsOnSelecting: Boolean;
  f_ParentMenu: TvcmBaseMenuForChromeLike;
  f_Closing: Boolean;
  f_ItemChangedByKeyboard: Boolean;
  f_LastMousePos: TPoint;
  f_ChangeHoveredItemLockCount: Integer;
  f_CommandToExecute: IvcmMenuForChromeLikeCommand;
  f_UpdateItemsRequested: Boolean;
 private
  // internal methods
  procedure PaintBuffer;
  {-}
  function pm_GetTotalSize: TSize;
  {-}
  procedure FillItemList;
  {-}
  procedure FillItems;
  {-}
  function FindNearestRealEnabledItem(const aStartItem: TvcmMenuForChromeLikeItem;
                                            aForward: Boolean): TvcmMenuForChromeLikeItem;
  {-}
  function pm_GetCanvas: TCanvas;
  {-}
  function pm_GetSelectedItem: TvcmMenuForChromeLikeItem;
  {-}
  procedure pm_SetSelectedItem(const anItem: TvcmMenuForChromeLikeItem);
  {-}
  function pm_GetHoveredItem: TvcmMenuForChromeLikeItem;
  {-}
  procedure pm_SetHoveredItem(const anItem: TvcmMenuForChromeLikeItem);
  {-}
  function pm_GetMenuItem: TMenuItem;
  {-}
  procedure pm_SetMenuItem(anItem: TMenuItem);
  {-}
  procedure pm_SetMouseControl(const aControl: TControl);
  {-}
  function pm_GetItemCount: Integer;
  {-}
  function pm_GetItem(aIndex: Integer): TvcmMenuForChromeLikeItem;
  {-}
  function pm_GetRootMenu: TvcmBaseMenuForChromeLike;
  {-}
  function pm_GetParentMenu: TvcmBaseMenuForChromeLike;
  {-}
  procedure pm_SetParentMenu(aParentMenu: TvcmBaseMenuForChromeLike);
  {-}
  function pm_GetContentRect: TRect;
  {-}
  procedure pm_SetIsActive(aActive: Boolean);
  {-}
  function IsSelectableItem(const anItem: TvcmMenuForChromeLikeItem): Boolean;
  {-}
 protected
  procedure LockHoveredItemChanging;
  {-}
  procedure UnlockHoveredItemChanging;
  {-}
  procedure ClearKilledMenus;
  {-}
  function NeedAddItem(aRootItem: TMenuItem;
                       anItem: TMenuItem;
                       anIndex: Integer): Boolean;
    virtual;
  {-}
  function GetItemIndex(const anItem: TvcmMenuForChromeLikeItem): Integer;
  {-}
  function GetItemSize(anItem: TMenuItem): TSize;
    virtual;
  {-}
  function GetItemSizeForAlign(const aTotalSize: TSize; anItem: TMenuItem): TSize;
    virtual;
  {-}
  function DoMouseIdle: TControl;
  {-}
  procedure DoActionIdle;
  {-}
  procedure Idle(const aMsg: TMsg);
  {-}
  function pm_GetMenuOrientation: TvcmBaseMenuForChromeLikeOrientation;
    virtual; abstract;
  {-}
  function pm_GetMenuItemMargins: TRect;
    virtual; abstract;
  {-}
  function CanHoverItem: Boolean;
    virtual;
  {-}
  function pm_GetHasSelectedItem: Boolean;
  {-}
  function pm_GetHasHoveredItem: Boolean;
  {-}
  function pm_GetIsTopLevelMenu: Boolean;
    virtual;
  {-}
  function pm_GetCurrentOpenedSubmenu: TvcmBaseMenuForChromeLike;
    virtual; abstract;
  {-}
  function GetSubmenuDropDownPoint(const anItem: TvcmMenuForChromeLikeItem): TPoint;
    virtual; abstract;
  {-}
  procedure ExecuteMenuItem(const anItem: TvcmMenuForChromeLikeItem;
                                  aByKeyboard: Boolean);
    virtual;
  {-}
  procedure ClickMenuItem(const anItem: TvcmMenuForChromeLikeItem);
  {-}
  procedure ShowSubmenu(const anItem: TvcmMenuForChromeLikeItem;
                        const aPoint: TPoint;
                               aByKeyboard: Boolean);
    virtual; abstract;
  {-}
  procedure DoOnMenuClosed(aClosedMenu: TvcmBaseMenuForChromeLike;
                           aClosedMenuResult: TvcmMenuShowingResult);
    virtual;
  {-}
  procedure CloseCurrentOpenedSubmenu;
    virtual; abstract;
  {-}
  procedure Paint(aCanvas: TCanvas);
  {-}
  procedure PaintItem(const anItem: TvcmMenuForChromeLikeItem; aState: TOwnerDrawState);
    virtual;
  procedure PaintClientArea;
    virtual;
  {-}
  procedure DoAfterItemsPainted;
    virtual;
  {-}
  procedure SelectedItemChanged(const aPrevSelected: TvcmMenuForChromeLikeItem;
                                const aNewSelected: TvcmMenuForChromeLikeItem;
                                      aByKeyboard: Boolean);
    virtual;
  {-}
  procedure HoveredItemChanged(const aPrevHovered: TvcmMenuForChromeLikeItem;
                               const aNewHovered: TvcmMenuForChromeLikeItem);
    virtual;
  {-}
  procedure NotifySubMenuClosed(aMenu: TvcmBaseMenuForChromeLike;
                                aResult: TvcmMenuShowingResult);
    virtual;
  {-}
  procedure RequestUpdateItems;
  {-}
 protected

  function IsActiveItem(const anItem: TvcmMenuForChromeLikeItem): Boolean;
  {-}
  function HasSubItems(const anItem: TvcmMenuForChromeLikeItem): Boolean;
  {-}
  function IsEmpty: Boolean;
  {-}
  function GetItemOwnerDrawState(const anItem: TvcmMenuForChromeLikeItem): TOwnerDrawState;
    virtual;
  {-}
  procedure UpdateItems;
  {-}
  procedure EnterMenuLoop;
  {-}
  procedure ActiveChanged(aIsActive: Boolean);
    virtual;
  {-}
  procedure SelectNearestItem(aForward: Boolean;
                              aByKeyboard: Boolean);
  {-}
  procedure SelectPrevItem(aByKeyboard: Boolean);
  {-}
  procedure SelectNextItem(aByKeyboard: Boolean);
  {-}
  procedure SelectFirstItem(aByKeyboard: Boolean);
  {-}
  procedure SelectLastItem(aByKeyboard: Boolean);
  {-}
  procedure BeforeEnterMenuLoop;
    virtual;
  {-}
  procedure AfterMenuLoopFinished;
    virtual;
  {-}
  procedure DoMenuLoop;
    virtual;
  {-}
  procedure DoBeforePeekMessage;
    virtual;
  {-}
  procedure ProcessMouseMessage(var aMessage: TMsg);
    virtual; abstract;
  {-}
  procedure ProcessKeyMessage(var aMessage: TMsg);
    virtual;
  {-}
  function ProcessKeyPressed(aKey: Word;
                             aActiveMenu: TvcmBaseMenuForChromeLike): Boolean;
    virtual; abstract;
  {-}
  procedure MouseMovedOverEmptyArea(aShift: TShiftState;
                                    const aPoint: TPoint);
    virtual;
  {-}
  procedure AlignItems;
  {-}
  procedure CorrectBounds;
  {-}
  procedure WMEraseBkgnd(var aMessage: TWMEraseBkgnd);
    message WM_ERASEBKGND;
  {-}
  procedure WMPaint(var aMessage: TWMPaint);
    message WM_PAINT;
  {-}
  procedure WMSize(var aMessage: TWMSize);
    message WM_SIZE;
  {-}
  procedure CMCancelMode(var aMessage: TMessage);
    message CM_CANCELMODE;
  {-}
  procedure vcmMsgMenuClosed(var aMessage: TMessage); message vcm_msgMenuClosed;
  {-}
  procedure vcmMsgMenuOpened(var aMessage: TMessage); message vcm_msgMenuOpened;
  {-}
  procedure vcmMsgClickMenuItem(var aMessage: TMessage); message vcm_msgClickMenuItem;
  {-}
  procedure vcmMsgUpdateItemsRequested(var aMessage: TMessage); message vcm_msgUpdateItemsRequested;
  {-}
  procedure MouseMove(aShift: TShiftState;
                      aX: Integer;
                      aY: Integer);
    override;
  {-}
  procedure Notification(aComponent: TComponent;
                         aOperation: TOperation);
    override;
  {-}
  procedure NotifyParentMenuOnClosing(aMenuShowingResult: TvcmMenuShowingResult);
  {-}
  procedure KillMenuLater(aMenu: TvcmBaseMenuForChromeLike);
  {-}
  procedure ResetSelection;
  {-}
  procedure ExecuteCommand;
  {-}
  property Canvas: TCanvas
    read pm_GetCanvas;
  {-}
  property MenuOrientation: TvcmBaseMenuForChromeLikeOrientation
    read pm_GetMenuOrientation;
  {-}
  property MenuItemMargins: TRect
    read pm_GetMenuItemMargins;
  {-}
  property SelectedItem: TvcmMenuForChromeLikeItem
    read pm_GetSelectedItem
    write pm_SetSelectedItem;
  {-}
  property HoveredItem: TvcmMenuForChromeLikeItem
    read pm_GetHoveredItem
    write pm_SetHoveredItem;
  {-}
  property HasSelectedItem: Boolean
    read pm_GetHasSelectedItem;
  {-}
  property HasHoveredItem: Boolean
    read pm_GetHasHoveredItem;
  {-}
  property InMenuLoop: Boolean
    read f_InMenuLoop
    write f_InMenuLoop;
  {-}
  property MouseControl: TControl
    read f_MouseControl
    write pm_SetMouseControl;
  {-}
  property ItemCount: Integer
    read pm_GetItemCount;
  {-}
  property Items[Index: Integer]: TvcmMenuForChromeLikeItem
    read pm_GetItem;
  {-}
  property TotalSize: TSize
    read pm_GetTotalSize;
  {-}
  property RootMenu: TvcmBaseMenuForChromeLike
    read pm_GetRootMenu;
  {-}
  property ContentRect: TRect
    read pm_GetContentRect;
  {-}
  property IsTopLevelMenu: Boolean
    read pm_GetIsTopLevelMenu;
  {-}
  property CurrentOpenedSubmenu: TvcmBaseMenuForChromeLike
    read pm_GetCurrentOpenedSubmenu;
  {-}
  property Closing: Boolean
    read f_Closing;
  {-}
 protected
  // IafwApplicationDataListener
  procedure UpdateFinished;
  {-}
  function CheckStamp(const aGUID: TGUID): Boolean;
  {-}
 public
  function GetMenuParentItem(aMenu: TvcmBaseMenuForChromeLike): TvcmMenuForChromeLikeItem;
  {-}
  procedure CloseMenuAndExecute(aMenu: TvcmBaseMenuForChromeLike;
                                aResult: TvcmMenuShowingResult;
                                const aCommand: IvcmMenuForChromeLikeCommand);
  {-}
  function GetItemAtPoint(const aPoint: TPoint): TvcmMenuForChromeLikeItem;
  {-}
  procedure CloseBranch(aResult: TvcmMenuShowingResult);
    virtual;
  {-}
  procedure CloseMenu(aResult: TvcmMenuShowingResult);
    virtual;
  {-}
  procedure CloseOpenedSubmenuIfNeeded;
    virtual;
  {-}
  procedure NotifyKeyPressedInSubmenu(aKey: Word;
                                      aSender: TvcmBaseMenuForChromeLike);
  {-}
  constructor Create(aOwner: TComponent);
    override;
  {-}
  destructor Destroy;
    override;
  {-}
  property MenuItem: TMenuItem
    read f_MenuItem
    write pm_SetMenuItem;
  {-}
  property SkipDisabledItemsOnSelecting: Boolean
    read f_SkipDisabledItemsOnSelecting
    write f_SkipDisabledItemsOnSelecting;
  {-}
  property ParentMenu: TvcmBaseMenuForChromeLike
    read pm_GetParentMenu
    write pm_SetParentMenu;
  {-}
  property IsActive: Boolean
    read f_IsActive
    write pm_SetIsActive;
  {-}
  property Color;
  {-}
 end;


const
 cBackgroundColor                     = $00F9F8FA;
 (* - цвет фона *)
 cMouseUpInterval                     = 200;
 (* - минимальный интервал между нажатиями мыши*)

implementation

uses
 Forms,
 ActnList,
 m2memLib,
 l3Base,
 l3Interfaces,
 l3InternalInterfaces,
 l3Operations,
 l3Core,
 SysUtils,
 afwTypes,
 afwControl,
 afwFacade,
 OvcBase,
 OvcCmd
 {$If not defined(NoScripts) AND not defined(NoVCM)}
 ,
 vcmTabbedMenuWordsPack
 {$IfEnd} //not NoScripts AND not NoVCM
 ;

{ TvcmBaseMenuForChromeLike }

type
 TKilledMenusList = class(Tl3LongIntList)
 public
  class function Instance: TKilledMenusList;
  procedure ClearIfNeeded;
 end;

var
 g_KilledMenusList: TKilledMenusList = nil;

procedure TKilledMenusList_Free;
begin
 if (g_KilledMenusList <> nil) then
  g_KilledMenusList.ClearIfNeeded;
 FreeAndNil(g_KilledMenusList);
end;

procedure TKilledMenusList.ClearIfNeeded;
var
 l_Index: Integer;
 l_Menu: TvcmBaseMenuForChromeLike;
begin
 while (Count > 0) do
 begin
  l_Index := Pred(Count);
  l_Menu := TvcmBaseMenuForChromeLike(Items[l_Index]);
  Delete(l_Index);
  FreeAndNil(l_Menu);
 end;
end;

class function TKilledMenusList.Instance: TKilledMenusList;
begin
 if (g_KilledMenusList = nil) then
 begin
  g_KilledMenusList := Create;
  l3System.AddExitProc(TKilledMenusList_Free);
 end;
 Result := g_KilledMenusList;
end;

{ TvcmBaseMenuForChromeLike }

procedure TvcmBaseMenuForChromeLike.PaintBuffer;
var
 l_BrushRecall: TBrushRecall;
 l_PenRecall: TPenRecall;
 l_FontRecall: TFontRecall;
begin
  l_BrushRecall := TBrushRecall.Create(f_Buffer.Canvas.Brush);
  try
   l_PenRecall := TPenRecall.Create(f_Buffer.Canvas.Pen);
   try
    l_FontRecall := TFontRecall.Create(f_Buffer.Canvas.Font);
    try
     Paint(f_Buffer.Canvas);
    finally
     FreeAndNil(l_FontRecall);
    end;//try..finally
   finally
    FreeAndNil(l_PenRecall);
   end;//try..finally
  finally
   FreeAndNil(l_BrushRecall);
  end;//try..finally
end;

function TvcmBaseMenuForChromeLike.pm_GetTotalSize: TSize;
var
 l_TotalSize: TSize;

 function lp_DoMeasureItem(anItem: PvcmMenuForChromeLikeItem;
  anIndex: Integer): Boolean;
 var
  l_ItemSize: TSize;
 begin
  l_ItemSize := GetItemSize(anItem^.rItem);
  case MenuOrientation of
   vcm_moVertical:
    begin
     if (l_ItemSize.cx > l_TotalSize.cx) then
      l_TotalSize.cx := l_ItemSize.cx;
     Inc(l_TotalSize.cy, l_ItemSize.cy);
    end;//vcm_moVertical
   vcm_moHorizontal:
    begin
     if (l_ItemSize.cy > l_TotalSize.cy) then
      l_TotalSize.cy := l_ItemSize.cy;
     Inc(l_TotalSize.cx, l_ItemSize.cx);
    end;//vcm_moHorizontal
  end;//case MenuOrientation
  Result := True;
 end;//lp_DoMeasureItem

begin
 l3FillChar(l_TotalSize, SizeOf(l_TotalSize), 0);
 f_Items.IterateAllF(l3L2IA(@lp_DoMeasureItem));
 Result := l_TotalSize;
end;

procedure TvcmBaseMenuForChromeLike.FillItemList;
var
 l_Index: Integer;
 l_NewItem: TvcmMenuForChromeLikeItem;
begin
 Assert(f_MenuItem <> nil);
 f_Items.Clear;
 for l_Index := 0 to Pred(f_MenuItem.Count) do
  if NeedAddItem(f_MenuItem, f_MenuItem.Items[l_Index], l_Index) then
   f_Items.Add(TvcmMenuForChromeLikeItem_C(f_MenuItem.Items[l_Index]));
end;

procedure TvcmBaseMenuForChromeLike.FillItems;
begin
 UpdateItems;
 FillItemList;
end;

function TvcmBaseMenuForChromeLike.FindNearestRealEnabledItem(const aStartItem: TvcmMenuForChromeLikeItem;
                                                                    aForward: Boolean): TvcmMenuForChromeLikeItem;

const
 cMovingDeltaArr: array[Boolean] of Integer = (-1, 1);
var
 l_OrigItemIndex: Integer;
 l_DestItemIndex: Integer;
begin
 l_OrigItemIndex := f_Items.IndexOf(aStartItem);
 l_DestItemIndex := l_OrigItemIndex;
 Inc(l_DestItemIndex, cMovingDeltaArr[aForward]);
 if (l_DestItemIndex < 0) then
  l_DestItemIndex := Pred(f_Items.Count)
 else
 if (l_DestItemIndex > Pred(f_Items.Count)) then
  l_DestItemIndex := 0
 else
 while (not IsSelectableItem(f_Items[l_DestItemIndex])) do
 begin
  Inc(l_DestItemIndex, cMovingDeltaArr[aForward]);
  if (l_DestItemIndex < 0) or (l_DestItemIndex > Pred(f_Items.Count)) then
  begin
   l_DestItemIndex := l_OrigItemIndex;
   Break;
  end;
 end;
 Result := f_Items[l_DestItemIndex];
end;

function TvcmBaseMenuForChromeLike.pm_GetCanvas: TCanvas;
begin
 Result := f_Buffer.Canvas;
end;

function TvcmBaseMenuForChromeLike.pm_GetSelectedItem: TvcmMenuForChromeLikeItem;
begin
 Result := f_SelectedItem;
end;

procedure TvcmBaseMenuForChromeLike.pm_SetSelectedItem(const anItem: TvcmMenuForChromeLikeItem);
var
 l_PrevSelected: TvcmMenuForChromeLikeItem;
begin
 if (not anItem.EQ(f_SelectedItem)) then
 begin
  LockHoveredItemChanging;
  l_PrevSelected := f_SelectedItem;
  f_SelectedItem := anItem;
  Repaint;
  SelectedItemChanged(l_PrevSelected, f_SelectedItem, f_ItemChangedByKeyboard);
  f_ItemChangedByKeyboard := False;
  UnlockHoveredItemChanging;
 end;//if (not anItem.EQ(f_SelectedItem))...
end;

function TvcmBaseMenuForChromeLike.pm_GetHoveredItem: TvcmMenuForChromeLikeItem;
begin
 Result := f_HoveredItem;
end;

procedure TvcmBaseMenuForChromeLike.pm_SetHoveredItem(const anItem: TvcmMenuForChromeLikeItem);
var
 l_PrevHovered: TvcmMenuForChromeLikeItem;
begin
 if (not anItem.EQ(f_HoveredItem)) and (not anItem.EQ(f_SelectedItem)) then
 begin
  l_PrevHovered := f_HoveredItem;
  f_HoveredItem := anItem;
  HoveredItemChanged(l_PrevHovered, f_HoveredItem);
 end;//if (not anItem.EQ(f_HoveredItem))...
 Repaint; 
end;

function TvcmBaseMenuForChromeLike.pm_GetMenuItem: TMenuItem;
begin
 Result := f_MenuItem;
end;

procedure TvcmBaseMenuForChromeLike.pm_SetMenuItem(anItem: TMenuItem);
begin
 if (anItem <> f_MenuItem) then
 begin
  f_MenuItem := anItem;

  f_MenuItem.CallInitiateActions;

  UpdateItems;
  CorrectBounds;

  f_HoveredItem  := cNullMenuForChromeLikeItem;
  f_SelectedItem := cNullMenuForChromeLikeItem;
  f_SubmenuItem  := cNullMenuForChromeLikeItem;

  Invalidate;
 end;//if (anItem <> f_MenuItem)...
end;

procedure TvcmBaseMenuForChromeLike.pm_SetMouseControl(const aControl: TControl);
begin
 if (aControl <> MouseControl) then
 begin
  if (f_MouseControl <> nil) then
   f_MouseControl.RemoveFreeNotification(Self);
  f_MouseControl := aControl;
  if (f_MouseControl <> nil) then
   f_MouseControl.FreeNotification(Self);
 end;
end;

function TvcmBaseMenuForChromeLike.pm_GetItemCount: Integer;
begin
 Result := f_Items.Count;
end;

function TvcmBaseMenuForChromeLike.pm_GetItem(aIndex: Integer): TvcmMenuForChromeLikeItem;
begin
 Result := f_Items[aIndex];
end;

function TvcmBaseMenuForChromeLike.pm_GetRootMenu: TvcmBaseMenuForChromeLike;
var
 l_Menu: TvcmBaseMenuForChromeLike;
begin
 l_Menu := Self;
 while (l_Menu.ParentMenu <> nil) do
  l_Menu := l_Menu.ParentMenu;
 Result := l_Menu;
end;

function TvcmBaseMenuForChromeLike.pm_GetParentMenu: TvcmBaseMenuForChromeLike;
begin
 Result := f_ParentMenu;
end;

procedure TvcmBaseMenuForChromeLike.pm_SetParentMenu(aParentMenu: TvcmBaseMenuForChromeLike);
begin
 if (aParentMenu <> f_ParentMenu) then
  f_ParentMenu := aParentMenu;
end;

function TvcmBaseMenuForChromeLike.pm_GetContentRect: TRect;
var
 l_Rect: TRect;

 function lp_DoGetContentRect(anItem: PvcmMenuForChromeLikeItem; anIndex: Integer): Boolean;
 begin
  if (anItem^.rRect.Left < l_Rect.Left) then
   l_Rect.Left := anItem^.rRect.Left;
  if (anItem^.rRect.Right > l_Rect.Right) then
   l_Rect.Right := anItem^.rRect.Right;
  if (anItem^.rRect.Top < l_Rect.Top) then
   l_Rect.Top := anItem^.rRect.Top;
  if (anItem^.rRect.Bottom > l_Rect.Bottom) then
   l_Rect.Bottom := anItem^.rRect.Bottom;
  Result := True;
 end;//lp_DoGetContentRect

begin
 l3FillChar(l_Rect, SizeOf(l_Rect), 0);
 f_Items.IterateAllF(l3L2IA(@lp_DoGetContentRect));
 Result := l_Rect;
end;

procedure TvcmBaseMenuForChromeLike.pm_SetIsActive(aActive: Boolean);
begin
 if (aActive <> f_IsActive) then
 begin
  f_IsActive := aActive;
  ActiveChanged(f_IsActive);
 end;
end;

function TvcmBaseMenuForChromeLike.IsSelectableItem(const anItem: TvcmMenuForChromeLikeItem): Boolean;
begin
 if (not anItem.IsNull) then
 begin
  if anItem.rItem.IsLine or (not anItem.rItem.Visible) then
   Result := False
  else
   Result := ((not f_SkipDisabledItemsOnSelecting) or anItem.rItem.Enabled);
 end;
end;

procedure TvcmBaseMenuForChromeLike.LockHoveredItemChanging;
begin
 Inc(f_ChangeHoveredItemLockCount);
end;

procedure TvcmBaseMenuForChromeLike.UnlockHoveredItemChanging;
begin
 Dec(f_ChangeHoveredItemLockCount);
end;

procedure TvcmBaseMenuForChromeLike.ClearKilledMenus;
begin
 TKilledMenusList.Instance.ClearIfNeeded;
end;

function TvcmBaseMenuForChromeLike.NeedAddItem(aRootItem: TMenuItem;
                                               anItem: TMenuItem;
                                               anIndex: Integer): Boolean;
begin
 aRootItem.CallInitiateActions;
 Result := (aRootItem.Visible and anItem.Visible);
end;

function TvcmBaseMenuForChromeLike.GetItemIndex(const anItem: TvcmMenuForChromeLikeItem): Integer;
begin
 Result := f_Items.IndexOf(anItem);
end;

type
 TMenuItemHack = class(TMenuItem)
 end;

function TvcmBaseMenuForChromeLike.GetItemSize(anItem: TMenuItem): TSize;
begin
 Canvas.Font := Screen.MenuFont;
 TMenuItemHack(anItem).MeasureItem(Canvas, Result.cx, Result.cy);
end;

function TvcmBaseMenuForChromeLike.GetItemSizeForAlign(const aTotalSize: TSize;
                                                             anItem: TMenuItem): TSize;
begin
 Result := GetItemSize(anItem);
end;

function TvcmBaseMenuForChromeLike.DoMouseIdle: TControl;
var
 l_CaptureControl: TControl;
 l_Point: TPoint;
begin
 if InMenuLoop then
 begin
  GetCursorPos(l_Point);
  Result := FindDragTarget(l_Point, True);
  l_CaptureControl := GetCaptureControl;
  if (MouseControl <> Result) and not PointsEqual(f_MousePos, Mouse.CursorPos) then
  begin
   f_MousePos := Mouse.CursorPos;
   if ((MouseControl <> nil) and (l_CaptureControl = nil)) or
      ((l_CaptureControl <> nil) and (MouseControl = l_CaptureControl)) then
    MouseControl.Perform(CM_MOUSELEAVE, 0, 0);
   MouseControl := Result;
   if ((MouseControl <> nil) and (l_CaptureControl = nil)) or
      ((l_CaptureControl <> nil) and (MouseControl = l_CaptureControl)) then
    MouseControl.Perform(CM_MOUSEENTER, 0, 0);
  end;
 end;
end;

type
 THackCustomForm = class(TCustomForm);

procedure TvcmBaseMenuForChromeLike.DoActionIdle;
var
 l_Index: Integer;
begin
 for l_Index := Pred(Screen.CustomFormCount) downto 0 do
  with THackCustomForm(Screen.CustomForms[l_Index]) do
   if HandleAllocated and
      IsWindowVisible(Handle) and
      IsWindowEnabled(Handle) then
    UpdateActions;
end;

procedure TvcmBaseMenuForChromeLike.Idle(const aMsg: TMsg);
var
 l_Done: Boolean;
begin
 TKilledMenusList.Instance.ClearIfNeeded;
 DoMouseIdle;
 if Application.ShowHint and (MouseControl = nil) then
  Application.CancelHint;
 if (not f_SelectedItem.IsNull) and
    Assigned(f_SelectedItem.rItem.Action) then
  Application.Hint := GetLongHint(TCustomAction(f_SelectedItem.rItem.Action).Hint)
 else
  Application.CancelHint;
 l_Done := True;
 try
  if Assigned(Application.OnIdle) then
   Application.OnIdle(Self, l_Done);
  if l_Done then
   DoActionIdle;
 except
  Application.HandleException(Self);
 end;

 if (GetCurrentThreadID = MainThreadID) and CheckSynchronize then
  l_Done := False;
 if l_Done then WaitMessage;
end;

function TvcmBaseMenuForChromeLike.CanHoverItem: Boolean;
begin
 Result := (f_ChangeHoveredItemLockCount = 0);
end;

function TvcmBaseMenuForChromeLike.pm_GetHasSelectedItem: Boolean;
begin
 Result := not SelectedItem.IsNull;
end;

function TvcmBaseMenuForChromeLike.pm_GetHasHoveredItem: Boolean;
begin
 Result := not HoveredItem.IsNull;
end;

function TvcmBaseMenuForChromeLike.pm_GetIsTopLevelMenu: Boolean;
begin
 Result := False;
end;

procedure TvcmBaseMenuForChromeLike.ExecuteMenuItem(const anItem: TvcmMenuForChromeLikeItem;
                                                          aByKeyboard: Boolean);
var
 l_SubmenuDropDownPoint: TPoint;
begin
 if (not anItem.IsNull) and
    (anItem.rItem <> nil) then
  anItem.rItem.CallInitiateActions;
 if IsActiveItem(anItem) then
 begin
  if HasSubItems(anItem) then
  begin
   // Пункт меню с подпунктами
   if (not anItem.EQ(f_SubmenuItem)) then
   begin
    l_SubmenuDropDownPoint := ClientToScreen(GetSubmenuDropDownPoint(anItem));
    f_SubMenuItem := anItem;
    ShowSubMenu(anItem, l_SubmenuDropDownPoint, aByKeyboard);
    if (not (csDestroying in ComponentState)) then
     f_SubMenuItem := cNullMenuForChromeLikeItem;
   end;
  end
  else
  begin
   // Пункт меню без подпунктов
   CloseMenu(vcm_msrExecuted);
   ClickMenuItem(anItem);
  end;//if HasSubItems(anItem)...
 end;//if IsActiveItem(anItem)...
end;

procedure TvcmBaseMenuForChromeLike.ClickMenuItem(const anItem: TvcmMenuForChromeLikeItem);
begin
 Assert(not anItem.IsNull);
 Assert(anItem.rItem <> nil);
 if (ParentMenu <> nil) then
  PostMessage(ParentMenu.Handle, vcm_msgClickMenuItem, 0, LParam(anItem.rItem))
 else
  anItem.rItem.Click;
end;

procedure TvcmBaseMenuForChromeLike.DoOnMenuClosed(aClosedMenu: TvcmBaseMenuForChromeLike;
                                                   aClosedMenuResult: TvcmMenuShowingResult);
begin
 aClosedMenu.InMenuLoop := False;
 if (not (csDestroying in aClosedMenu.ComponentState)) then
  KillMenuLater(aClosedMenu);
 if (aClosedMenuResult in [vcm_msrClosedRecursive, vcm_msrExecuted]) then
  CloseMenu(aClosedMenuResult);
end;

procedure TvcmBaseMenuForChromeLike.Paint(aCanvas: TCanvas);

 function lp_DoPaintItem(anItem: PvcmMenuForChromeLikeItem;
  anIndex: Integer): Boolean;
 begin
  PaintItem(anItem^, GetItemOwnerDrawState(anItem^));
  Result := True;
 end;//lp_DoPaintItem;

var
 l_Index: Integer;
 l_Rect: TRect;
 l_State: TOwnerDrawState;
begin
 PaintClientArea;
 f_Items.IterateAllF(l3L2IA(@lp_DoPaintItem));
 DoAfterItemsPainted;
end;

procedure TvcmBaseMenuForChromeLike.PaintItem(const anItem: TvcmMenuForChromeLikeItem;
                                                    aState: TOwnerDrawState);
begin
 Canvas.Font := Screen.MenuFont;
 DrawMenuItem(anItem.rItem, Canvas, anItem.rRect, aState);
end;

procedure TvcmBaseMenuForChromeLike.PaintClientArea;
begin
 with Canvas do
 begin
  Brush.Color := Color;
  Brush.Style := bsSolid;
  Pen.Style := psClear;
  FillRect(ClientRect);
 end;//with aCanvas
end;

procedure TvcmBaseMenuForChromeLike.DoAfterItemsPainted;
begin
 // Ничего не делаем
end;

procedure TvcmBaseMenuForChromeLike.SelectedItemChanged(const aPrevSelected: TvcmMenuForChromeLikeItem;
                                                        const aNewSelected: TvcmMenuForChromeLikeItem;
                                                              aByKeyboard: Boolean);
var
 l_Pt: TPoint;
begin
 GetCursorPos(l_Pt);
 f_LastMousePos := ScreenToClient(l_Pt);
 if (not HoveredItem.EQ(SelectedItem)) then
  f_HoveredItem := aNewSelected;
 Invalidate;
end;

procedure TvcmBaseMenuForChromeLike.HoveredItemChanged(const aPrevHovered: TvcmMenuForChromeLikeItem;
                                                       const aNewHovered: TvcmMenuForChromeLikeItem);
begin
 Invalidate;
end;

procedure TvcmBaseMenuForChromeLike.NotifySubMenuClosed(aMenu: TvcmBaseMenuForChromeLike;
                                                        aResult: TvcmMenuShowingResult);
begin
 // Ничего не делаем
end;

procedure TvcmBaseMenuForChromeLike.RequestUpdateItems;
begin
 f_UpdateItemsRequested := True;
 if HandleAllocated then
  PostMessage(Handle, vcm_msgUpdateItemsRequested, 0, 0);
end;

function TvcmBaseMenuForChromeLike.IsActiveItem(const anItem: TvcmMenuForChromeLikeItem): Boolean;
begin
 Result := (not anItem.IsNull) and
           (not anItem.rItem.IsLine) and
           (anItem.rItem.Visible and anItem.rItem.Enabled);
end;

function TvcmBaseMenuForChromeLike.HasSubItems(const anItem: TvcmMenuForChromeLikeItem): Boolean;
begin
 Result := (not anItem.IsNull) and
           (anItem.rItem <> nil) and
           (anItem.rItem.Count > 0);
end;

function TvcmBaseMenuForChromeLike.IsEmpty: Boolean;
begin
 Result := (f_Items.Count = 0);
end;

function TvcmBaseMenuForChromeLike.GetItemOwnerDrawState(const anItem: TvcmMenuForChromeLikeItem): TOwnerDrawState;
begin
 Assert(not anItem.IsNull);
 Assert(anItem.rItem <> nil);
 Result := [];
 if anItem.rItem.IsLine then
  Exit;
 if (not anItem.rItem.Enabled) then
  Result := Result + [odDisabled];
 if (anItem.EQ(f_SelectedItem)) or
    (anItem.EQ(f_HoveredItem)) then
  Result := Result + [odSelected];
end;

procedure TvcmBaseMenuForChromeLike.UpdateItems;

 procedure lp_DoInitiateActions(aMenuItem: TMenuItem);
 var
  l_Index: Integer;
 begin
  if (aMenuItem <> nil) then
  begin
   aMenuItem.CallInitiateActions;
   for l_Index := 0 to Pred(aMenuItem.Count) do
    lp_DoInitiateActions(aMenuItem[l_Index]);
  end;
 end;

 function lp_GetVisibleItemCount(aMenuItem: TMenuItem): Integer;
 var
  l_Index: Integer;
 begin
  Result := 0;
  for l_Index := 0 to Pred(aMenuItem.Count) do
   if aMenuItem.Items[l_Index].Visible then
    Inc(Result);
 end;//lp_GetVisibleItemCount

begin
 f_UpdateItemsRequested := False;
 DoActionIdle;
 lp_DoInitiateActions(f_MenuItem);
 f_Items.Clear;
 FillItemList;
 AlignItems;
 Invalidate;
end;

procedure TvcmBaseMenuForChromeLike.EnterMenuLoop;
begin
 UpdateItems;
 BeforeEnterMenuLoop;
 DoMenuLoop;
 AfterMenuLoopFinished;
end;

procedure TvcmBaseMenuForChromeLike.ActiveChanged(aIsActive: Boolean);
begin
 if IsTopLevelMenu then
  CloseMenu(vcm_msrClosedRecursive);
end;

procedure TvcmBaseMenuForChromeLike.SelectNearestItem(aForward: Boolean;
                                                      aByKeyboard: Boolean);
var
 l_OrigItem: TvcmMenuForChromeLikeItem;
 l_NewSelectedItem: TvcmMenuForChromeLikeItem;
begin
 if HasSelectedItem then
  l_OrigItem := SelectedItem
 else
 if HasHoveredItem then
  l_OrigItem := HoveredItem;
 l_NewSelectedItem := FindNearestRealEnabledItem(l_OrigItem, aForward);
 f_ItemChangedByKeyboard := aByKeyboard;
 SelectedItem := l_NewSelectedItem;
end;

procedure TvcmBaseMenuForChromeLike.SelectPrevItem(aByKeyboard: Boolean);
begin
 SelectNearestItem(False, aByKeyboard);
end;

procedure TvcmBaseMenuForChromeLike.SelectNextItem(aByKeyboard: Boolean);
begin
 SelectNearestItem(True, aByKeyboard);
end;

procedure TvcmBaseMenuForChromeLike.SelectFirstItem(aByKeyboard: Boolean);
begin
 if not IsEmpty then
 begin
  f_ItemChangedByKeyboard := aByKeyboard;
  SelectedItem := f_Items.First;
 end;
end;

procedure TvcmBaseMenuForChromeLike.SelectLastItem(aByKeyboard: Boolean);
begin
 if not IsEmpty then
 begin
  f_ItemChangedByKeyboard := aByKeyboard;
  SelectedItem := f_Items.Last;
 end;
end;

procedure TvcmBaseMenuForChromeLike.BeforeEnterMenuLoop;
begin
 // Ничего не делаем
end;

procedure TvcmBaseMenuForChromeLike.AfterMenuLoopFinished;
begin
 // Ничего не делаем
end;

procedure TvcmBaseMenuForChromeLike.DoMenuLoop;
var
 l_Message: TMsg;
 l_ContextID: Integer;
 l_NeedPostMsg: Boolean;
begin
 f_InMenuLoop := True;
 repeat
  DoBeforePeekMessage;
  if (csDestroying in ComponentState) or
     (not f_InMenuLoop) then
   Break;
  if PeekMessage(l_Message, 0, 0, 0, PM_REMOVE) then
  begin
   case l_Message.message of
    WM_NCMBUTTONDOWN,
    WM_NCRBUTTONDOWN,
    WM_NCLBUTTONDOWN,
    CM_RELEASE,
    WM_CLOSE,
    WM_SYSCOMMAND:
     begin
      if (not f_Closing) then
       RootMenu.CloseMenuAndExecute(Self,
                                    vcm_msrClosedRecursive,
                                    MakeDispatchMessageCommand(l_Message))
      else
       DispatchMessage(l_message);
     end;//WM_NCMBUTTONDOWN
    WM_KEYFIRST..WM_KEYLAST:
     begin
      if (l_Message.wParam = VK_F1) then
      begin
       if HasSelectedItem then
       begin
        l_ContextID := f_SelectedItem.rItem.HelpContext;
        if (Screen.ActiveForm = nil) then
         Exit;
        if (l_ContextID = 0) then
         l_ContextID := Screen.ActiveForm.HelpContext;
        if (biHelp in Screen.ActiveForm.BorderIcons) then
         Application.HelpCommand(HELP_CONTEXTPOPUP, l_ContextID)
        else
         Application.HelpContext(l_ContextID);
        Exit;
       end;//if GetHasSelected
      end;//if (l_Message.wParam = VK_F1)...
      if (l_Message.message = WM_SYSKEYDOWN) and (l_Message.wParam = VK_MENU) then
      begin
       ProcessKeyMessage(l_Message);
       TranslateMessage(l_Message);
       DispatchMessage(l_Message);
       Break;
      end//if (l_Message.message = WM_SYSKEYDOWN)...
      else
       ProcessKeyMessage(l_Message);
      if (not f_InMenuLoop) then
       Break;
     end;//WM_KEYFIRST..WM_KEYLAST
    WM_MOUSEFIRST..WM_MOUSELAST:
     begin
      if (l_Message.message <> WM_MOUSEWHEEL) then
      begin
       ProcessMouseMessage(l_Message);
       if (not f_InMenuLoop) then
        Break;
      end;
     end;
    WM_NCACTIVATE,
    WM_ACTIVATE,
    WM_ACTIVATEAPP,
    WM_MOUSEACTIVATE,
    WM_WINDOWPOSCHANGING,
    WM_WINDOWPOSCHANGED,
    WM_CANCELMODE:
     begin
      CloseMenu(vcm_msrClosedRecursive);
      TranslateMessage(l_Message);
      DispatchMessage(l_Message);
      Break;
     end;//WM_NCACTIVATE...
    vcm_msgMenuClosed:
     begin
      if (TvcmBaseMenuForChromeLike(l_Message.LParam) = Self) then
      begin
       f_InMenuLoop := False;
       TranslateMessage(l_Message);
       DispatchMessage(l_Message);
       Break;
      end;
      TranslateMessage(l_Message);
      DispatchMessage(l_Message);
     end;
   else
    if InMenuLoop then
    begin
     TranslateMessage(l_Message);
     DispatchMessage(l_Message);
    end;//if InMenuLoop...
   end;//case l_Message.message
  end//if PeekMessage(l_Message, 0, 0, 0, PM_REMOVE)
  else
  if f_InMenuLoop then
   Idle(l_Message);
 until not f_InMenuLoop;
end;

procedure TvcmBaseMenuForChromeLike.DoBeforePeekMessage;
begin
 TKilledMenusList.Instance.ClearIfNeeded;
end;

procedure TvcmBaseMenuForChromeLike.ProcessKeyMessage(var aMessage: TMsg);

 function lp_ProcessCommand(aCmd: Tl3OperationCode;
                            aForce: Boolean;
                            aCount: Integer): Boolean;
 begin
  Result := (aCmd = l3_ocShortCut) OR (aCmd = l3_ccPartial);
 end;//lp_ProcessCommand

 function lp_ProcessMessageInController(var aMessage: TMessage): Boolean;
 var
  l_Commands: TafwCommands;
 begin
  l_Commands := nil;
  Result := (GetDefController.EntryCommands.TranslateUsing([OvcCmd.scDefaultTableName],
   TMessage(aMessage), GetTickCount) <> l3_ocShortcut);
 end;//lp_ProcessMessageInController

var
 l_KeyDownMessage: TWMKeyDown;
 l_HandledByController: Boolean;
 l_HandledByMenu: Boolean;
begin
 if (aMessage.message = WM_KEYDOWN) or
    (aMessage.message = WM_SYSKEYDOWN) then
 begin
  TMessage(l_KeyDownMessage).WParam := aMessage.WParam;
  TMessage(l_KeyDownMessage).LParam := aMessage.LParam;
  l_HandledByMenu := ProcessKeyPressed(l_KeyDownMessage.CharCode, Self);
  if (not l_HandledByMenu) then
  begin
   l_HandledByController := lp_ProcessMessageInController(TMessage(l_KeyDownMessage));
   CloseMenu(vcm_msrExecuted);
  end;
 end;//if (aMessage.message = WM_KEYDOWN)...
end;

procedure TvcmBaseMenuForChromeLike.AlignItems;
var
 l_TotalSize: TSize;
 l_TopOffset: Integer;
 l_LeftOffset: Integer;
 l_Margins: TRect;

 function lp_DoAlignItem(anItem: PvcmMenuForChromeLikeItem;
  anIndex: Integer): Boolean;
 var
  l_ItemSize: TSize;
 begin
  l_ItemSize := GetItemSizeForAlign(l_TotalSize, anItem^.rItem);
  case MenuOrientation of
   vcm_moVertical:
    begin
     with anItem^.rRect do
     begin
      Left   := l_Margins.Left;
      Top    := l_TopOffset + l_Margins.Top;
      Right  := Left + l_ItemSize.cx;
      Bottom := Top  + l_ItemSize.cy;
     end;//with anItem^.rRect
     Inc(l_TopOffset, l_ItemSize.cy);
    end;//vcm_moVertical
   vcm_moHorizontal:
    begin
     with anItem^.rRect do
     begin
      Left   := l_LeftOffset + l_Margins.Left;
      Top    := l_Margins.Top;
      Right  := Left + l_ItemSize.cx;
      Bottom := Top  + l_ItemSize.cy;
     end;//with anItem^.rRect
     Inc(l_LeftOffset, l_ItemSize.cx);
    end;//vcm_moHorizontal
  end;//case MenuOrientation...
  Result := True;
 end;//lp_DoAlignItem

begin
 l_TotalSize := TotalSize;
 l_TopOffset  := 0;
 l_LeftOffset := 0;
 l_Margins := MenuItemMargins;
 f_Items.IterateAllF(l3L2IA(@lp_DoAlignItem));
end;

procedure TvcmBaseMenuForChromeLike.MouseMovedOverEmptyArea(aShift: TShiftState;
                                                            const aPoint: TPoint);
begin
 // Ничего не делаем
end;

procedure TvcmBaseMenuForChromeLike.CorrectBounds;
var
 l_TotalSize: TSize;
 l_Margins: TRect;
begin
 l_TotalSize := TotalSize;
 l_Margins   := MenuItemMargins;
 ClientWidth  := l_TotalSize.cx + l_Margins.Left + l_Margins.Right;
 ClientHeight := l_TotalSize.cy + l_Margins.Top  + l_Margins.Bottom;
end;

procedure TvcmBaseMenuForChromeLike.WMEraseBkgnd(var aMessage: TWMEraseBkgnd);
begin
 if f_UpdateItemsRequested then
  UpdateItems;
 PaintBuffer;
 aMessage.Result := 1;
end;

procedure TvcmBaseMenuForChromeLike.WMPaint(var aMessage: TWMPaint);
var
 l_PS: TPaintStruct;
 l_DC: HDC;
 l_PaintRect: TRect;
 l_PaintSize: TSize;
begin
 l3FillChar(l_PS, SizeOf(l_PS), 0);
 l_DC := BeginPaint(Handle, l_PS);
 try
  l_PaintRect := l_PS.rcPaint;
  with l_PaintSize do
  begin
   cx := l_PaintRect.Right  - l_PaintRect.Left;
   cy := l_PaintRect.Bottom - l_PaintRect.Top;
  end;//with l_PaintSize
  BitBlt(l_DC,
         l_PaintRect.Left, l_PaintRect.Top,
         l_PaintSize.cx, l_PaintSize.cy,
         f_Buffer.Canvas.Handle,
         l_PaintRect.Left, l_PaintRect.Top,
         SRCCOPY);
 finally
  EndPaint(Handle, l_PS);
 end;//try..finally
end;

procedure TvcmBaseMenuForChromeLike.WMSize(var aMessage: TWMSize);
begin
 inherited;
 AlignItems;
 f_Buffer.Width := Width;
 f_Buffer.Height := Height;
end;

procedure TvcmBaseMenuForChromeLike.CMCancelMode(var aMessage: TMessage);
begin
 inherited;
end;

procedure TvcmBaseMenuForChromeLike.vcmMsgMenuClosed(var aMessage: TMessage);
var
 l_ClosedMenu: TvcmBaseMenuForChromeLike;
 l_ClosedMenuResult: TvcmMenuShowingResult;
begin
 l_ClosedMenu := TvcmBaseMenuForChromeLike(aMessage.LParam);
 l_ClosedMenuResult := TvcmMenuShowingResult(aMessage.WParam);
 Assert(l_ClosedMenu <> nil);
 DoOnMenuClosed(l_ClosedMenu, l_ClosedMenuResult);
 ExecuteCommand;
end;

procedure TvcmBaseMenuForChromeLike.vcmMsgMenuOpened(var aMessage: TMessage);
begin
 // Ничего не делаем
end;

procedure TvcmBaseMenuForChromeLike.vcmMsgClickMenuItem(var aMessage: TMessage);
var
 l_MenuItem: TMenuItem;
begin
 l_MenuItem := TMenuItem(aMessage.LParam);
 Assert(l_MenuItem <> nil);
 l_MenuItem.Click;
end;

procedure TvcmBaseMenuForChromeLike.vcmMsgUpdateItemsRequested(var aMessage: TMessage);
begin
 UpdateItems;
end;

procedure TvcmBaseMenuForChromeLike.MouseMove(aShift: TShiftState;
                                              aX: Integer;
                                              aY: Integer);
var
 l_ItemUnderMouse: TvcmMenuForChromeLikeItem;
 l_LastMousePos: TPoint;
begin
 l_LastMousePos := f_LastMousePos;
 f_LastMousePos := Point(aX, aY);

 l_ItemUnderMouse := GetItemAtPoint(Point(aX, aY));
 if (aX <> l_LastMousePos.X) or
    (aY <> l_LastMousePos.Y) or
    l_ItemUnderMouse.IsNull then
 begin
  if IsSelectableItem(l_ItemUnderMouse) and
    (not l_ItemUnderMouse.IsNull) then
  begin
   Assert(not l_ItemUnderMouse.IsNull);
   if (ssLeft in aShift) then
   begin
    HoveredItem := l_ItemUnderMouse;
    SelectedItem := l_ItemUnderMouse;
   end
   else
   if CanHoverItem then
    HoveredItem := l_ItemUnderMouse;
  end
  else
  if l_ItemUnderMouse.IsNull then
   MouseMovedOverEmptyArea(aShift, Point(aX, aY));
 end;
end;

procedure TvcmBaseMenuForChromeLike.Notification(aComponent: TComponent;
                                                 aOperation: TOperation);
begin
 inherited;
 if (aOperation = opRemove) then
  if (aComponent = f_MouseControl) then
   f_MouseControl := nil;
end;

procedure TvcmBaseMenuForChromeLike.NotifyParentMenuOnClosing(aMenuShowingResult: TvcmMenuShowingResult);
var
 l_ParentMenu: TvcmBaseMenuForChromeLike;
begin
 Assert(not f_InMenuLoop);

 l_ParentMenu := ParentMenu;

 if (l_ParentMenu <> nil) and
    (l_ParentMenu <> Self) then
  PostMessage(l_ParentMenu.Handle, vcm_msgMenuClosed, WParam(aMenuShowingResult),
   LParam(Self));
end;

procedure TvcmBaseMenuForChromeLike.KillMenuLater(aMenu: TvcmBaseMenuForChromeLike);
begin
 Assert(TKilledMenusList.Instance.IndexOf(LongInt(aMenu)) = -1);
 aMenu.ParentMenu := nil;
 aMenu.Parent := nil;
 TKilledMenusList.Instance.Add(LongInt(aMenu));
end;

procedure TvcmBaseMenuForChromeLike.ResetSelection;
begin
 f_HoveredItem := cNullMenuForChromeLikeItem;
 f_SelectedItem := cNullMenuForChromeLikeItem;
end;

procedure TvcmBaseMenuForChromeLike.ExecuteCommand;
begin
 if (f_CommandToExecute <> nil) then
 try
  f_CommandToExecute.Execute;
 finally
  f_CommandToExecute := nil;
 end;//try..finally
end;

procedure TvcmBaseMenuForChromeLike.UpdateFinished;
begin
 RequestUpdateItems;
end;

function TvcmBaseMenuForChromeLike.CheckStamp(const aGUID: TGUID): Boolean;
begin
 Result := False;
end;

function TvcmBaseMenuForChromeLike.GetMenuParentItem(aMenu: TvcmBaseMenuForChromeLike): TvcmMenuForChromeLikeItem;
var
 l_Item: TvcmMenuForChromeLikeItem;

 function lp_DoFindItem(const anItem: PvcmMenuForChromeLikeItem;
                              anIndex: Integer): Boolean;
 begin
  if (anItem^.rItem = aMenu.MenuItem) then
  begin
   l_Item := anItem^;
   Result := False;
  end
  else
   Result := True;
 end;//lp_DoFindItem


begin
 l_Item := cNullMenuForChromeLikeItem;
 f_Items.IterateAllF(l3L2IA(@lp_DoFindItem));
 Result := l_Item;
end;

procedure TvcmBaseMenuForChromeLike.CloseMenuAndExecute(aMenu: TvcmBaseMenuForChromeLike;
                                                        aResult: TvcmMenuShowingResult;
                                                        const aCommand: IvcmMenuForChromeLikeCommand);
begin
 f_CommandToExecute := aCommand;
 aMenu.CloseMenu(aResult);
end;

function TvcmBaseMenuForChromeLike.GetItemAtPoint(const aPoint: TPoint): TvcmMenuForChromeLikeItem;
begin
 Result := f_Items.FindItemAtPoint(aPoint);
end;

procedure TvcmBaseMenuForChromeLike.CloseBranch(aResult: TvcmMenuShowingResult);
begin
 if (CurrentOpenedSubmenu <> nil) then
  CurrentOpenedSubmenu.CloseBranch(aResult);
 CloseMenu(aResult);
end;

procedure TvcmBaseMenuForChromeLike.CloseMenu(aResult: TvcmMenuShowingResult);
begin
 f_Closing := True;
 f_InMenuLoop := False;
 CloseCurrentOpenedSubmenu;
 f_HoveredItem := cNullMenuForChromeLikeItem;
 f_SelectedItem := cNullMenuForChromeLikeItem;
 NotifyParentMenuOnClosing(aResult);
end;

procedure TvcmBaseMenuForChromeLike.CloseOpenedSubmenuIfNeeded;
begin
 // Ничего не делаем
end;

procedure TvcmBaseMenuForChromeLike.NotifyKeyPressedInSubmenu(aKey: Word;
                                                              aSender: TvcmBaseMenuForChromeLike);
begin
 ProcessKeyPressed(aKey, aSender);
end;

constructor TvcmBaseMenuForChromeLike.Create(aOwner: TComponent);
begin
 inherited;
 Color := cBackgroundColor;
 f_Items := TvcmMenuForChromeLikeItems.Create;
 f_Buffer := Graphics.TBitmap.Create;
 f_SkipDisabledItemsOnSelecting := False;
 f_IsActive := True;
 f_Closing := False;
 if (afw.Application <> nil) and (afw.Application.Data <> nil) then
  afw.Application.Data.Notify.AddListener(Self);
end;

destructor TvcmBaseMenuForChromeLike.Destroy;
begin
 if (afw.Application <> nil) and (afw.Application.Data <> nil) then
  afw.Application.Data.Notify.RemoveListener(Self);
 TKilledMenusList.Instance.ClearIfNeeded;
 FreeAndNil(f_Items);
 FreeAndNil(f_Buffer);
 inherited;
end;

end.
