unit FormFrameDecorator;

interface
uses
  Windows,
  Messages,
  Classes,
  Controls,
  Types,
  Graphics,
  Forms,
  UxTheme,
  vcmGlassForm,
  ChromeLikeFormCaptionData,
  ChromeLikeBaseWindowCaptionButton,
  ChromeLikeformFramePainter,
  ChromeLikeInterfaces;

type
 TFormFrameDecoratorMetric = (dmCaption, dmFormBorder);

 TvcmChromeLikeNonAeroFormCaptionLayout = record
  rCaptionRect: TRect;
  rMinimizeButtonRect: TRect;
  rMaximizeRestoreButtonRect: TRect;
  rCloseButtonRect: TRect;
 end;

  TFormFrameDecorator = class;

  TFormFrameDecoratorNeedRecreateButtonsEvent = procedure(aDecorator: TFormFrameDecorator) of object;
  TFormDecoratorClientControlChangedEvent = procedure(aBitmap: TBitmap; aNeedDrawBackground: Boolean) of object;

  TDecoratedFormPlacement = record
   rTopLeft: TPoint;
   rSize: TSize;
  end;

  (* ƒекоратор - отвечает управл€ет внешним видом формы и ее заголовка *)
  TFormFrameDecorator = class(TCustomControl)
  private
   f_UpdateCount: Integer;
   f_HeaderRect: TRect;
   f_ParentForm: TvcmGlassForm;
   f_ParentWndProc: TWndMethod;
   f_Active: Boolean;
   f_UseCustomFrame: Boolean;
   f_CaptionHeight: Integer;
   f_ScaleFactor: Single;
   f_CaptionData: TChromeLikeFormCaptionData;
   f_ButtonsVisible: Boolean;
   f_CaptionLayout: TvcmChromeLikeNonAeroFormCaptionLayout;
   f_CloseButton: TChromeLikeBaseWindowCaptionButton;
   f_MinButton: TChromeLikeBaseWindowCaptionButton;
   f_MaxButton: TChromeLikeBaseWindowCaptionButton;
   f_OnNeedRecreateButtons: TFormFrameDecoratorNeedRecreateButtonsEvent;
   f_ClientControl: TControl;
   f_ClientControlBackground: TBitmap;
   f_OnClientControlBackgroundChanged: TFormDecoratorClientControlChangedEvent;
   f_Painter: TChromeLikeFormFramePainter;
   f_LastSysContextMenuTime: DWORD;
   f_Minimizing: Boolean;
   f_Maximizing: Boolean;
   procedure UpdatePainterSize;
   procedure UpdatePainterTheme;
   procedure SetActive(const Value: Boolean);
   procedure SetUseCustomFrame(const Value: Boolean);
   function GetCaptionHeight: Integer;
   procedure ShowSystemMenu(const aPt: TPoint);
   procedure ShowCustomMenu(const aPt: TPoint);
   procedure CallParentWndProc(var Message: TMessage);
   procedure DrawCustomFrame;
   function IsDesigning: Boolean;
   procedure UpdateButtonsLayout;
   function MakeThemedCaptionLayout: TvcmChromeLikeNonAeroFormCaptionLayout;
   function MakeLegacyCaptionLayout: TvcmChromeLikeNonAeroFormCaptionLayout;
   function MakeCaptionLayout: TvcmChromeLikeNonAeroFormCaptionLayout;
   procedure CloseButtonClick(aSender: TObject);
   procedure MinButtonClick(aSender: TObject);
   procedure MaxButtonClick(aSender: TObject);
   procedure SetCloseButton(aValue: TChromeLikeBaseWindowCaptionButton);
   procedure SetMinButton(aValue: TChromeLikeBaseWindowCaptionButton);
   procedure SetMaxButton(aValue: TChromeLikeBaseWindowCaptionButton);
   function GetCloseButtonClass: RChromeLikeWindowCaptionbuttonClass;
   function GetMinButtonClass: RChromeLikeWindowCaptionbuttonClass;
   function GetMaxButtonClass: RChromeLikeWindowCaptionbuttonClass;
   procedure SetClientControl(aControl: TControl);
   procedure UpdateHeaderRect;
   procedure RecreateFrameData;
   procedure NotifyButtonsFormResized;
   function GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
   procedure ShowContextMenu(const aPoint: TPoint);
   function pm_GetPainter: TChromeLikeFormFramePainter;
   function pm_GetCaptionData: TChromeLikeFormCaptionData;
   property Painter: TChromeLikeFormFramePainter read pm_GetPainter;
   property CaptionData: TChromeLikeFormCaptionData read pm_GetCaptionData;
  protected
   procedure CMBidimodechanged(var Message: TMessage);
     message CM_BIDIMODECHANGED;
   procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
   procedure CustomFrameWndProc(var Message: TMessage); virtual;
   procedure Paint; override;
   procedure RebuildMetrics;
   procedure Resize; override;
   procedure SetParent(aParent: TWinControl); override;
   procedure WMThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
   procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
   procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
   procedure WMSettingChange(var Message: TWMSettingChange);
    message WM_SETTINGCHANGE;
   procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
    message WM_WINDOWPOSCHANGED;
   procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
   procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
   procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
   procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
   procedure AdjustClientRect(var Rect: TRect); override;
   property ScaleFactor: Single read f_ScaleFactor;
  public
   procedure UpdateButtons;
   constructor Create(aOwner: TComponent); override;
   destructor Destroy; override;
   procedure CreateParams(var Params: TCreateParams); override;
   procedure BeginUpdate;
   function CustomFrameSupported: Boolean;
   function GlassFrameSupported: Boolean;
   procedure EndUpdate;
   function GetMetric(const aMetric: TFormFrameDecoratorMetric): Integer;
   procedure InvalidateHeaderArea;
   procedure SetBounds(aLeft: Integer; aTop: Integer; aWidth: Integer;
    aHeight: Integer); override;
   property Active: Boolean read f_Active write SetActive;
   property UseCustomFrame: Boolean read f_UseCustomFrame write SetUseCustomFrame default True;
   property CloseButton: TChromeLikeBaseWindowCaptionButton read f_CloseButton write SetCloseButton;
   property MinButton: TChromeLikeBaseWindowCaptionButton read f_MinButton write SetMinButton;
   property MaxButton: TChromeLikeBaseWindowCaptionButton read f_MaxButton write SetMaxButton;
   property CloseButtonClass: RChromeLikeWindowCaptionbuttonClass read GetCloseButtonClass;
   property MinButtonClass: RChromeLikeWindowCaptionbuttonClass read GetMinButtonClass;
   property MaxButtonClass: RChromeLikeWindowCaptionbuttonClass read GetMaxButtonClass;
   property OnNeedRecreateButtons: TFormFrameDecoratorNeedRecreateButtonsEvent
    read f_OnNeedRecreateButtons write f_OnNeedRecreateButtons;
   property ClientControl: TControl read f_ClientControl write SetClientControl;
   property OnClientControlBackgroundChanged: TFormDecoratorClientControlChangedEvent
    read f_OnClientControlBackgroundChanged write f_OnClientControlBackgroundChanged;
  end;

implementation
uses
  Multimon,
  ShellApi,
  l3DwmApi,
  l3Base,
  Math,
  SysUtils,
  Themes,
  ChromeLikeLegacyWindowCaptionButtons,
  ChromeLikeThemedWindowCaptionButtons,
  ChromeLikeTypes;

const
 cActiveArr: array[Boolean] of TChromeLikeFormFramePainterKind =
  (ffpkInactive, ffpkActive);

procedure TFormFrameDecorator.UpdatePainterSize;
begin
 Painter.InvalidateSize;
end;

procedure TFormFrameDecorator.UpdatePainterTheme;
begin
 Painter.InvalidateTheme;
end;

procedure TFormFrameDecorator.BeginUpdate;
begin
 Inc(f_UpdateCount);
end;

procedure TFormFrameDecorator.CMBidimodechanged(var Message: TMessage);
begin
 inherited;
 Invalidate;
end;

procedure TFormFrameDecorator.CMFontchanged(var Message: TMessage);
begin
 inherited;
 if not (csLoading in ComponentState) then
  RebuildMetrics;
end;

constructor TFormFrameDecorator.Create(AOwner: TComponent);
begin
 inherited;
 FComponentStyle := FComponentStyle - [csInheritable];
 f_ScaleFactor := 1;
 f_CaptionHeight := -1;
 ControlStyle := ControlStyle - [csOpaque];
 f_UseCustomFrame := True;
 f_UpdateCount := 0;
 Align := alTop;
 f_Active := True;
 DoubleBuffered := True;
 f_ClientControlBackground := TBitmap.Create;
end;

destructor TFormFrameDecorator.Destroy;
begin
 if not IsDesigning then
  if Assigned(f_ParentWndProc) and (f_ParentForm <> nil) then
   f_ParentForm.WindowProc := f_ParentWndProc;
 f_ParentForm := nil;
 FreeAndNil(f_CaptionData);
 FreeAndNil(f_ClientControlBackground);
 inherited;
end;

procedure DrawRoundRect(aCanvas: TCanvas; const aRect: TRect; const aX: Integer;
 const aY: Integer);
begin
 aCanvas.RoundRect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom, aX, aY);
end;

function CenterInRect(aCanvas: TCanvas; const aRect: TRect; const aCaption: string): TPoint;
var
 l_TextWidth: Integer;
begin
 l_TextWidth := aCanvas.TextWidth(aCaption);
 if (l_TextWidth > aRect.Right - aRect.Left) then
  Result.X := 0
 else
  Result.X := (aRect.Right - aRect.Left) div 2 - (l_TextWidth div 2);
 Result.Y := (aRect.Bottom - aRect.Top) div 2 - (aCanvas.TextHeight(aCaption) div 2);
end;

procedure AdjustRect(var aRect: TRect; const aLeft: Integer; const aTop: Integer;
 const aRight: Integer; const aBottom: Integer);
begin
 aRect := Types.Rect(aRect.Left + aLeft, aRect.Top + aTop,
  aRect.Right + aRight, aRect.Bottom + aBottom);
end;

procedure TFormFrameDecorator.EndUpdate;
begin
 Dec(f_UpdateCount);
 if (f_UpdateCount < 0) then
  f_UpdateCount := 0;
 if (f_UpdateCount = 0) then
  Invalidate;
end;

function TFormFrameDecorator.GetCaptionHeight: Integer;
begin
 if (f_CaptionHeight = -1) then
 begin
  f_CaptionHeight := Max(GetSystemMetrics(SM_CYCAPTION), 26);
  if CustomFrameSupported then
   Inc(f_CaptionHeight, GetSystemMetrics(SM_CYFRAME));
 end;
 Result := f_CaptionHeight;
end;

function TFormFrameDecorator.GlassFrameSupported: Boolean;
begin
 Result := DwmCompositionEnabled and
           (f_ParentForm <> nil) and
           f_ParentForm.GlassFrame.Enabled;
end;

procedure TFormFrameDecorator.SetBounds(aLeft: Integer; aTop: Integer;
  aWidth: Integer; aHeight: Integer);
begin
 inherited SetBounds(aLeft, aTop, aWidth, GetCaptionHeight);
 UpdateHeaderRect;
end;

procedure TFormFrameDecorator.InvalidateHeaderArea;
var
 l_Rect: TRect;
begin
 l_Rect := ClientRect;
 l_Rect.Bottom := GetMetric(dmCaption);
 InvalidateRect(Handle, @l_Rect, True);
end;

function TFormFrameDecorator.IsDesigning: Boolean;
begin
 Result := csDesigning in ComponentState;
end;

procedure TFormFrameDecorator.Paint;
var
 l_Rect: TRect;
 l_RectToCopy: TRect;
 l_ControlRect: TRect;
 l_Border: Integer;
 l_PrevColor: TColor;
begin
 if (not ClientControl.Visible) then
  ClientControl.Visible := True;
 inherited;
 Canvas.Font.Assign(Font);
 l_Rect := ClientRect;
 if CustomFrameSupported then
 begin
  if GlassFrameSupported then
  begin
   l_PrevColor := Canvas.Brush.Color;
   Canvas.Brush.Color := clBlack;
   try
    Canvas.FillRect(l_Rect);
   finally
    Canvas.Brush.Color := l_PrevColor;
   end;
  end
  else
  begin
   l_Border := GetMetric(dmFormBorder);
   Dec(l_Rect.Left, l_Border);
   Inc(l_Rect.Right, l_Border);

   Painter.PaintElement(Canvas, ffeCaptionBody, l_Rect);

   l_RectToCopy := ClientControl.BoundsRect;

   Inc(l_RectToCopy.Left, l_Border);

   l_ControlRect := Rect(0, 0, ClientControl.Width, ClientControl.Height);

   Painter.CopyElementPartOnCanvas(f_ClientControlBackground.Canvas,
    l_ControlRect, l_RectToCopy);
  end;
 end;
end;

procedure TFormFrameDecorator.CreateParams(var Params: TCreateParams);
begin
 inherited;
 Params.Style := Params.Style or WS_CLIPCHILDREN;
end;

function TFormFrameDecorator.CustomFrameSupported: Boolean;
begin
 Result := UseCustomFrame and (not IsDesigning);
end;

procedure TFormFrameDecorator.DrawCustomFrame;
const
 cActiveStyleArr: array[Boolean] of TChromeLikeFormFramePainterKind =
  (ffpkInactive, ffpkActive);
var
 l_Rect: TRect;
 l_Canvas: TCanvas;
 l_DC: THandle;
 l_Flags: Cardinal;
 l_Border : Integer;
 l_HeaderRect: TRect;
begin
 if csLoading in ComponentState then
  Exit;

 l_Flags := DCX_CACHE or DCX_CLIPSIBLINGS or DCX_WINDOW or DCX_VALIDATE;
 l_DC := GetDCEx(f_ParentForm.Handle, 0, l_Flags);
 if (l_DC = 0) then
  Exit;
 try
  l_Border := GetMetric(dmFormBorder);
  l_Canvas := TCanvas.Create;
  try
   l_Canvas.Handle := l_DC;

   if GlassFrameSupported then
   begin
    l_HeaderRect := BoundsRect;
    l_HeaderRect.TopLeft := ClientToParent(l_HeaderRect.TopLeft);
    l_HeaderRect.BottomRight := ClientToParent(l_HeaderRect.BOttomRight);

    ExcludeClipRect(l_Canvas.Handle, l_HeaderRect.Left + l_Border, l_HeaderRect.Top,
     l_HeaderRect.Right, l_HeaderRect.Bottom);
   end;

   with Painter do
   begin
    l_Rect := Rect(0, 0, l_Border, GetCaptionHeight);
    CopyElementPartOnCanvas(l_Canvas, l_Rect, l_Rect);
    // - Ћевый угол заголовка

    l_Rect := Rect(f_ParentForm.Width - l_Border, 0, f_ParentForm.Width, GetCaptionHeight);
    CopyElementPartOnCanvas(l_Canvas, l_Rect, l_Rect);
    // - ѕравый угол заголовка

    l_Rect := Rect(0, GetCaptionHeight, l_Border, f_ParentForm.Height - l_Border);
    CopyElementPartOnCanvas(l_Canvas, l_Rect, l_Rect);
    // - Ћева€ граница

    l_Rect := Rect(f_ParentForm.Width - l_Border, GetCaptionHeight, f_ParentForm.Width,
     f_ParentForm.Height - l_Border);
    CopyElementPartOnCanvas(l_Canvas, l_Rect, l_Rect);
    // - ѕрава€ граница

    l_Rect := Rect(0, f_ParentForm.Height - l_Border, f_ParentForm.Width,
     f_ParentForm.Height);
    CopyElementPartOnCanvas(l_Canvas, l_Rect, l_Rect);
    // - Ќижн€€ граница
   end;
  finally
   l_Canvas.Handle := 0;
   FreeAndNil(l_Canvas);
  end;
 finally
  ReleaseDC(f_ParentForm.Handle, l_DC);  // про это Ѕорланд забыл.
  // http://mdp.garant.ru/pages/viewpage.action?pageId=566330515
 end;
end;

type
  THackWinControl = class(TWinControl)
  end;//THackWinControl

procedure TFormFrameDecorator.CustomFrameWndProc(var Message: TMessage);

 function lp_HitTestNCA(aFormHandle : HWND; ptMouse: tpoint) : LRESULT;
 var
  l_Style : LongInt;
  l_rcWindow : TRect;
  l_Border : Integer;
 begin
  // ѕровер€ем только верхнюю границу, остальные проверит ParentWndProc
  l_Border := GetMetric(dmFormBorder);
  l3FillChar(l_rcWindow, SizeOf(l_rcWindow), 0);
  GetWindowRect(aFormHandle, l_rcWindow);
  Result := HTCLIENT;
  if (ptMouse.Y < l_rcWindow.Top + l_Border) then
  begin
   if (ptmouse.X < l_rcWindow.Left + 20) then
    Result := HTTOPLEFT
   else
   if (ptmouse.X > l_rcWindow.Right - 20) then
    Result := HTTOPRIGHT
   else
   begin
    if (f_ParentForm.WindowState <> wsMaximized) then
     Result := HTTOP
    else
     Result := HTCAPTION;
    // - иначе при даблклике по верхней границе заголовка развернутого на весь
    // экран окна с ним ничего не произойдет
   end;
  end
  else
  if (ptMouse.Y < l_rcWindow.Top + GetMetric(dmCaption)) then
    Result := HTCAPTION;
  // - —истемное меню нам показывать не нужно, ибо иконку мы там все равно
  // не показываем
  // http://mdp.garant.ru/pages/viewpage.action?pageId=595977139
  l_Style := GetWindowLong(aFormHandle, GWL_STYLE);
  if (Result >= HTLEFT) and (Result < HTBORDER) and
   (WS_SIZEBOX <> (l_Style and WS_SIZEBOX)) then
   Result := HTBORDER;
 end;//lp_HitTestNCA

type
 TEdges = set of Byte;

 function lp_GetAppbarAutohideEdges(aMonitor: HMONITOR): TEdges;

  function lp_MonitorHasTopmostAutohideTaskbarForEdge(anEdge: Integer; aMonitor: HMONITOR): Boolean;
  var
   l_TaskbarData: TAppBarData;
   l_Taskbar: THandle;
  begin
   l3FillChar(l_TaskbarData, SizeOf(l_TaskbarData));
   l_TaskbarData.cbSize := SizeOf(l_TaskbarData);
   l_TaskbarData.uEdge := anEdge;
   // MSDN documents an ABM_GETAUTOHIDEBAREX, which supposedly takes a monitor
   // rect and returns autohide bars on that monitor.  This sounds like a good
   // idea for multi-monitor systems.  Unfortunately, it appears to not work at
   // least some of the time (erroneously returning NULL) and there's almost no
   // online documentation or other sample code using it that suggests ways to
   // address this problem.  So we just use ABM_GETAUTOHIDEBAR and hope the user
   // only cares about autohide bars on the monitor with the primary taskbar.
   //
   // NOTE: This call spins a nested message loop.
   l_Taskbar := THandle(SHAppBarMessage(ABM_GETAUTOHIDEBAR, l_TaskbarData));
   Result := IsWindow(l_Taskbar) and
       (MonitorFromWindow(l_Taskbar, MONITOR_DEFAULTTONULL) = aMonitor) and
       (GetWindowLong(l_Taskbar, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0);
  end;
 var
  I: Integer;
 begin
  Result := [];
  for I := ABE_LEFT to ABE_BOTTOM do
   if lp_MonitorHasTopmostAutohideTaskbarForEdge(I, aMonitor) then
    Include(Result, I);
 end;

const
 cAutoHideTaskbarThicknessPx = 2;

var
  l_NewRect: TRect;
  l_Style: LongInt;
  l_ExStyle : LongInt;
  l_Rgn1: HRGN;
  l_Rgn2: HRGN;
  l_MousePt: TPoint;
  l_NeedCallParentWndProc: Boolean;
  l_Top: Integer;
  l_Monitor: HMONITOR;
  l_AutoHideEdges: TEdges;
begin
 l_NeedCallParentWndProc := False;
 if (DwmCompositionEnabled and
     DwmDefWindowProc(Parent.Handle, Message.Msg, Message.WParam, Message.LParam, Message.Result)) then
  Exit;
 case Message.Msg of
  WM_SYSCOMMAND:
   begin
    case TWMSysCommand(Message).CmdType of
     SC_MINIMIZE:
      begin
       f_Minimizing := True;
       f_Maximizing := False;
      end;
     SC_RESTORE:
      begin
       f_Minimizing := False;
       f_Maximizing := False;
      end;
     SC_MAXIMIZE:
      begin
       f_Minimizing := False;
       f_Maximizing := True;
      end;
     SC_CLOSE: SetForegroundWindow(Screen.ActiveCustomForm.Handle);
    end;
    CallParentWndProc(Message);
   end;
  WM_NCACTIVATE:
   begin
    Active := TWMNCActivate(Message).Active;

    if DwmCompositionEnabled or (f_ParentForm.WindowState = wsMinimized) then
    begin
     CallParentWndProc(Message);
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=567568482
     f_Minimizing := False;
    end
    else
    begin
     Painter.Repaint(Active);
     DrawCustomFrame;
     InvalidateHeaderArea;
     Message.Result := 1;
    end;
   end;
  WM_NCCALCSIZE:
   begin
    if f_Minimizing then
     CallParentWndProc(Message)
     // - в процессе сворачивани€ зовем стандартную обработку этих расчетов,
     // иначе почему-то после разворачивани€ окна оно будет на 140 пикселей больше
     // по высоте. http://mdp.garant.ru/pages/viewpage.action?pageId=567568482
    else
    begin
     l_Style := GetWindowLong(f_ParentForm.Handle, GWL_STYLE);
     l_ExStyle := GetWindowLong(f_ParentForm.Handle, GWL_EXSTYLE);
     l_NewRect := Rect(0, 0, 0, 0);
     AdjustWindowRectEx(l_NewRect, l_Style, False, l_ExStyle);
     with TWMNCCalcSize(Message).CalcSize_Params^.rgrc[0] do
     begin
      Dec(Left, l_NewRect.Left);
      Inc(Top, 0);  // Ѕез верхней границы
      Dec(Right, l_NewRect.Right);
      Dec(Bottom, l_NewRect.Bottom);
     end;

     if (f_Maximizing) or (l_Style and WS_MAXIMIZE <> 0) then
     begin
      // Find all auto-hide taskbars along the screen edges and adjust in by the
      // thickness of the auto-hide taskbar on each such edge, so the window isn't
      // treated as a "fullscreen app", which would cause the taskbars to
      // disappear.
      l_Monitor := MonitorFromWindow(f_ParentForm.Handle, MONITOR_DEFAULTTONULL);
      if (l_Monitor = 0) then
       // We might end up here if the window was previously minimized and the
       // user clicks on the taskbar button to restore it in the previously
       // maximized position. In that case WM_NCCALCSIZE is sent before the
       // window coordinates are restored to their previous values, so our
       // (left,top) would probably be (-32000,-32000) like all minimized
       // windows. So the above MonitorFromWindow call fails, but if we check
       // the window rect given with WM_NCCALCSIZE (which is our previous
       // restored window position) we will get the correct monitor handle.
       l_Monitor := MonitorFromRect(@l_NewRect, MONITOR_DEFAULTTONULL);
      if (l_Monitor <> 0) then
      begin
       l_AutoHideEdges := lp_GetAppbarAutohideEdges(l_Monitor);
       with (TWMNCCalcSize(Message).CalcSize_Params^.rgrc[0]) do
       begin
        if (ABE_LEFT in l_AutoHideEdges) then
         Inc({with Rect.}Left, cAutoHideTaskbarThicknessPx);
        if (ABE_TOP in l_AutoHideEdges) then
         (*if DwmCompositionEnabled then
         // Tricky bit.  Due to a bug in DwmDefWindowProc()'s handling of
         // WM_NCHITTEST, having any nonclient area atop the window causes the
         // caption buttons to draw onscreen but not respond to mouse
         // hover/clicks.
         // So for a taskbar at the screen top, we can't push the
         // client_rect->top down; instead, we move the bottom up by one pixel,
         // which is the smallest change we can make and still get a client area
         // less than the screen size. This is visibly ugly, but there seems to
         // be no better solution.
          Dec({with Rect.}Bottom)
         else
          //Inc({with Rect.}Top, cAutoHideTaskbarThicknessPx);*)
          Dec({with Rect.}Bottom);

        if (ABE_RIGHT in l_AutoHideEdges) then
         Dec({with Rect.}Right, cAutoHideTaskbarThicknessPx);
        if (ABE_Bottom in l_AutoHideEdges) then
         Dec({with Rect.}Bottom, cAutoHideTaskbarThicknessPx);
       end;
      end;
     end;
    end;
   end;
  WM_NCHITTEST:
   begin
    CallParentWndProc(message);
    if CustomFrameSupported and
       ((Message.Result = HTCLOSE) or
        (message.Result = HTMAXBUTTON) or (Message.Result = HTMINBUTTON)) then
     message.Result := HTCLIENT;
    if (message.Result = HTCLIENT) or (message.Result = HTSYSMENU) then
     with TWMNCHitTest(Message) do
      Result := lp_HitTestNCA(Parent.Handle, Point(Pos.x,Pos.y));
   end;
  WM_NCPAINT:
   begin
    if DwmCompositionEnabled then
     Message.Result := CallWindowProc(THackWinControl(f_ParentForm).DefWndProc,
      f_ParentForm.Handle, Message.Msg, Message.WParam, Message.LParam)
    else
    begin
     DrawCustomFrame;
     Message.Result := 0;
    end;
   end;
  WM_NCRBUTTONUP:
   if Message.wParam = HTCAPTION then
   begin
    with TWMNCRButtonUp(Message) do
     ShowContextMenu(Point(XCursor, YCursor));
   end
   else
    CallParentWndProc(Message);
  WM_SIZE:
   begin
    CallParentWndProc(Message);
    if (not DwmCompositionEnabled) then
    begin
     Painter.InvalidateSize;
     DrawCustomFrame;
     if (not (csDestroying in ComponentState)) then
      NotifyButtonsFormResized;
    end;
   end;
  WM_DWMNCRENDERINGCHANGED:
   begin
    f_ButtonsVisible := not BOOL(Message.WParam);
    RecreateFrameData;
    CallParentWndProc(Message);
    UpdateButtons;
    InvalidateHeaderArea;
    if Assigned(f_OnClientControlBackgroundChanged) then
     f_OnClientControlBackgroundChanged(f_ClientControlBackground, f_ButtonsVisible);
   end;
  WM_THEMECHANGED:
   begin
    l_NeedCallParentWndProc := True;
    Perform(WM_THEMECHANGED, 0, 0); 
   end;
  WM_DESTROY:
   begin
    FreeAndNil(f_Painter);
    l_NeedCallParentWndProc := True;
   end;
 else
  l_NeedCallParentWndProc := True;
 end;
 if l_NeedCallParentWndProc then
   CallParentWndProc(Message);
end;

procedure TFormFrameDecorator.SetParent(aParent: TWinControl);
var
 l_CustomFrame : Boolean;
begin
 l_CustomFrame := UseCustomFrame;
 UseCustomFrame := False;
 inherited;
 if (aParent <> nil) then
 begin
  f_ParentForm := TvcmGlassForm(GetParentForm(aParent));
  UseCustomFrame := l_CustomFrame;
  if (f_ParentForm is TForm) then
   f_ScaleFactor := TForm(f_ParentForm).PixelsPerInch / 96;
  TForm(Parent).DoubleBuffered := True;
 end;
end;

function TFormFrameDecorator.GetMetric(const aMetric: TFormFrameDecoratorMetric): Integer;
begin
 case aMetric of
  dmCaption:
   Result := GetCaptionHeight;
  dmFormBorder:
   Result := GetSystemMetrics(SM_CYFRAME);
 else
  Result := -1;
 end;
 Result := Round(Result * f_ScaleFactor);
end;

procedure TFormFrameDecorator.ShowSystemMenu(const aPt: TPoint);
var
 l_Cmd: WPARAM;
 l_Menu: HMENU;

 procedure lp_UpdateItem(aID: UINT; aEnable: Boolean; aMakeDefaultIfEnabled: Boolean = False);
 const
  cFlags: array [Boolean] of UINT = (MF_GRAYED, MF_ENABLED);
 begin
  EnableMenuItem(l_Menu, aID, MF_BYCOMMAND or cFlags[aEnable]);
  if (aMakeDefaultIfEnabled and aEnable) then
   SetMenuDefaultItem(l_Menu, aID, MF_BYCOMMAND);
 end;//lp_UpdateItem

var
 l_HitTestMsg: TWMNCHitTest;
 l_HitTestResult: LongInt;
 l_FormWndState: TWindowState;
begin
 l_Menu := 0;
 l_Menu := GetSystemMenu(f_ParentForm.Handle, False);
 l_FormWndState := f_ParentForm.WindowState;
 Assert(l_Menu <> 0);
 SetMenuDefaultItem(l_Menu, UINT(-1), 0);

 lp_UpdateItem(SC_RESTORE,   l_FormWndState <> wsNormal, False);
 lp_UpdateItem(SC_MOVE,      l_FormWndState <> wsMaximized);
 lp_UpdateItem(SC_SIZE,      l_FormWndState <> wsMaximized);
 lp_UpdateItem(SC_MINIMIZE,  l_FormWndState <> wsMinimized);
 lp_UpdateItem(SC_MAXIMIZE,  l_FormWndState <> wsMaximized, True);

 l3FillChar(l_HitTestMsg, SizeOf(l_HitTestMsg), 0);
 l_HitTestMsg.XPos := aPt.X;
 l_HitTestMsg.YPos := aPt.Y;

 l_HitTestResult := SendMessage(f_ParentForm.Handle, WM_NCHITTEST, TMessage(l_HitTestMsg).WParam,
  TMessage(l_HitTestMsg).LParam);

 if (l_HitTestResult = HTSYSMENU) then
  SetMenuDefaultItem(l_Menu, SC_CLOSE, MF_BYCOMMAND);

 l_Cmd := WPARAM(TrackPopupMenu(l_Menu, TPM_RETURNCMD or GetSystemMetrics(SM_MENUDROPALIGNMENT),
  aPt.X, aPt.Y, 0, f_ParentForm.Handle, nil));
  
 PostMessage(f_ParentForm.Handle, WM_SYSCOMMAND, l_Cmd, 0)
end;

procedure TFormFrameDecorator.ShowCustomMenu(const aPt: TPoint);
var
 l_Control: IChromeLikeCaptionControl;
begin
 if Supports(f_ClientControl, IChromeLikeCaptionControl, l_Control) then
 try
  l_Control.ShowContextMenu(aPt);
 finally
  l_Control := nil;
 end
 else
  Assert(False);
end;

const
 SC_DRAGMOVE = $F012;

procedure TFormFrameDecorator.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
 if (not DwmCompositionEnabled) then
  if Assigned(f_OnClientControlBackgroundChanged) then
   f_OnClientControlBackgroundChanged(f_ClientControlBackground, True);

 Message.Result := 1;
end;

procedure TFormFrameDecorator.WMNCHitTest(var Message: TWMNCHitTest);
var
 l_ptMouse : TPoint;
begin
 l_ptMouse := ScreenToClient(Point(Message.XPos, Message.YPos));
 if (not IsDesigning and (l_ptMouse.Y < GetMetric(dmCaption))) then
  Message.Result := HTTRANSPARENT
 else
  Message.result := HTCLIENT;
end;

function BufferedPaintMakeOpaque(hBufferedPaint: THandle; prc: PRect): HResult;
begin
 Result := BufferedPaintSetAlpha(hBufferedPaint, prc, 255);
end;

procedure TFormFrameDecorator.WMPaint(var Message: TWMPaint);
var
 l_DC: HDC;
 l_MemDC: HDC;
 l_PS: TPaintStruct;
 l_PaintBuffer: THandle;
 l_Rect : TRect;
begin
 if not (csDesigning in ComponentState) and DoubleBuffered and DwmCompositionEnabled then
 begin
  l_DC := BeginPaint(Handle, l_PS);
  try
   l_PaintBuffer := BeginBufferedPaint(l_DC, l_PS.rcPaint, BPBF_COMPOSITED, nil,
    l_MemDC);
   if (l_PaintBuffer <> 0) then
   try
    Perform(WM_PRINTCLIENT, WParam(l_MemDC), PRF_CLIENT);
    l_Rect := ClientRect;
    if CustomFrameSupported then
     Inc(l_Rect.top, GetMetric(dmCaption));
    BufferedPaintMakeOpaque(l_PaintBuffer, @l_Rect);
   finally
    EndBufferedPaint(l_PaintBuffer, True);
   end;
  finally
   EndPaint(Handle, l_PS);
  end;
 end
 else
 begin
  inherited;
  if Assigned(f_OnClientControlBackgroundChanged) then
   f_OnClientControlBackgroundChanged(f_ClientControlBackground, True);
 end;
end;

procedure TFormFrameDecorator.WMSettingChange(var Message: TWMSettingChange);
begin
 inherited;
 RecreateFrameData;
end;

procedure TFormFrameDecorator.WMWindowPosChanged(var Message: TWMWindowPosChanged);
var
 l_Rect: TRect;
begin
 inherited;
 if (f_ParentForm <> nil) AND (not (csDestroying in f_ParentForm.ComponentState)) and
  f_ParentForm.HandleAllocated then
 begin
  f_CaptionLayout := MakeCaptionLayout;
  with f_CaptionLayout do
   l_Rect := Rect(rMinimizeButtonRect.Left, rMinimizeButtonRect.Top,
                  rCloseButtonRect.Right, rCloseButtonRect.Bottom);
  InvalidateRect(Handle, @l_Rect, True);
 end;
end;

procedure TFormFrameDecorator.AdjustClientRect(var Rect: TRect);
var
 l_MinButtonRect: TRect;
 l_MaxButtonRect: TRect;
 l_CloseButtonRect: TRect;
 l_Right: Integer;
 l_BorderWidth: Integer;
 l_BorderHeight: Integer;
 l_ButtonsSumWidth: Integer;
 l_DWMButtonsRect: TRect;
begin
 inherited;
 l_BorderWidth := GetSystemMetrics(SM_CXFRAME);
 l_BorderHeight := GetSystemMetrics(SM_CYFRAME);

 if (not GlassFrameSupported) then
 begin
  l_CloseButtonRect := CaptionData.MakeButtonRect(Rect.Right, cbkClose);
  l_MaxButtonRect := CaptionData.MakeButtonRect(l_CloseButtonRect.Right, cbkMaximizeRestore);
  l_MinButtonRect := CaptionData.MakeButtonRect(l_MaxButtonRect.Right, cbkMinimize);

  l_ButtonsSumWidth := (l_CloseButtonRect.Right - l_CloseButtonRect.Left) +
                       (l_MaxButtonRect.Right - l_MaxButtonRect.Left) +
                       (l_MinButtonRect.Right - l_MinButtonRect.Left);
  Inc(Rect.Top, l_BorderHeight);
  Dec(Rect.Right, l_ButtonsSumWidth + (l_BorderWidth * 2));
 end
 else
 begin
  // ≈сли включен DWM - возьмем размеры области кнопок у него, потому что
  // в ответ на WM_GETTITLEBARINFOEX могли дать неправильные размеры
  // http://mdp.garant.ru/pages/viewpage.action?pageId=585129194
  l3FillChar(l_DWMButtonsRect, SizeOf(l_DWMButtonsRect), 0);
  DwmGetWindowAttribute(f_ParentForm.Handle,
                        DWMWA_CAPTION_BUTTON_BOUNDS,
                        @l_DWMButtonsRect,
                        SizeOf(l_DWMButtonsRect));
  l_ButtonsSumWidth := l_DWMButtonsRect.Right - l_DWMButtonsRect.Left;
  Inc(Rect.Top, l_BorderHeight);
  Dec(Rect.Right, l_ButtonsSumWidth);
 end;
end;

procedure TFormFrameDecorator.RebuildMetrics;
begin
 if (f_ParentForm <> nil) and (f_ParentForm.HandleAllocated) then
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565842245
  CaptionData.UpdateTitleBarInfo(f_ParentForm.Handle);
end;

procedure TFormFrameDecorator.Resize;
begin
 inherited;
 if csDestroying in ComponentState then
  Exit;
 if not (csLoading in ComponentState) then
  RebuildMetrics;
 UpdateButtonsLayout;
 f_ClientControlBackground.Width := ClientWidth;
 f_ClientControlBackground.Height := ClientHeight;
 Painter.InvalidateSize;
end;

procedure TFormFrameDecorator.SetActive(const Value: Boolean);
begin
 if (f_Active <> Value) then
 begin
  f_Active := Value;
  if (not DwmCompositionEnabled) then
  begin
   Painter.Repaint(f_Active);
   InvalidateHeaderArea;
   f_CloseButton.Invalidate;
   f_MinButton.Invalidate;
   f_MaxButton.Invalidate;
  end;
 end;
end;

procedure TFormFrameDecorator.CallParentWndProc(var Message: TMessage);
begin
 if Assigned(f_ParentWndProc) then
  f_ParentWndProc(Message);
end;

procedure TFormFrameDecorator.SetUseCustomFrame(const Value: Boolean);
begin
 if (f_UseCustomFrame <> Value) then
 begin
  if (not IsDesigning) and
     Assigned(f_ParentWndProc) and
     (f_ParentForm <> nil) and
     f_UseCustomFrame then
  begin
   f_ParentForm.WindowProc := f_ParentWndProc;
   f_ParentWndProc := nil;
   f_ParentForm.GlassFrame.Enabled := False;
  end;
  f_UseCustomFrame := Value;
  if (not IsDesigning) and
     (f_ParentForm <> nil) then
  begin
   f_CaptionHeight := -1;
   if Value then
   begin
    f_ParentWndProc := f_ParentForm.WindowProc;
    f_Parentform.WindowProc := CustomFrameWndProc;
    f_ParentForm.GlassFrame.Enabled := True;
    f_ParentForm.GlassFrame.Top := GetMetric(dmCaption);
   end;
   if (ComponentState * [csLoading] = []) then
    f_ParentForm.Perform(CM_RECREATEWND, 0,0);
  end;
 end;
end;

procedure TFormFrameDecorator.UpdateButtonsLayout;
begin
 f_ButtonsVisible := not DwmCompositionEnabled;
 if f_ButtonsVisible then
 begin
  f_CaptionLayout := MakeCaptionLayout;
  if (f_CloseButton <> nil) then
   f_CloseButton.BoundsRect := f_CaptionLayout.rCloseButtonRect;
  if (f_MaxButton <> nil) then
   f_MaxButton.BoundsRect := f_CaptionLayout.rMaximizeRestoreButtonRect;
  if (f_MinButton <> nil) then
   f_MinButton.BoundsRect := f_CaptionLayout.rMinimizeButtonRect;
 end;
end;

procedure TFormFrameDecorator.CMShowingChanged(
  var Message: TMessage);
begin
 inherited;
 if Visible then
  UpdateButtonsLayout;
 f_ButtonsVisible := not DwmCompositionEnabled;
 UpdateButtonsLayout;
end;

procedure TFormFrameDecorator.WMContextMenu(var Message: TWMContextMenu);
begin
 ShowContextMenu(Point(Message.XPos, Message.YPos));
 Message.Result := 1;
end;

procedure TFormFrameDecorator.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
 inherited;
 if (f_ParentForm.WindowState = wsMaximized) then
  f_ParentForm.WindowState := wsNormal
 else
  f_ParentForm.WindowState := wsMaximized;
end;

procedure TFormFrameDecorator.CMSysColorChange(var Message: TMessage);
begin
 inherited;
 RecreateFrameData;
end;

procedure TFormFrameDecorator.WMThemeChanged(var Message: TMessage);
begin
 inherited;
 RecreateFrameData;
end;

function TFormFrameDecorator.MakeThemedCaptionLayout: TvcmChromeLikeNonAeroFormCaptionLayout;

 function lp_MakeButtonRect(const aPrevRect: TRect; aStepToTheLeft: Integer;
  aRightMargin: Integer = 0): TRect;
 var
  l_Right: Integer;
 begin
  l_Right := aPrevRect.Left - aRightMargin;
  Result := Rect(l_Right - aStepToTheLeft, aPrevRect.Top,
   l_Right, aPrevRect.Bottom);
 end;//lp_MakeButtonRect

const
 cWindowCaptionButtonTop = 2;
var
 l_PrevWndStyle: LongInt;
 l_TempWndStyle: LongInt;
 l_BorderWidth: Integer;
 l_BorderHeight: Integer;
 l_ButtonTop: Integer;
 l_ButtonBottom: Integer;
 l_RealCaptionRight: Integer;
 l_ButtonWidth: Integer;
 l_ButtonHeight: Integer;
 l_ButtonRight: Integer;
 l_Right: Integer;
begin
 if (not f_ParentForm.HandleAllocated) then
  Exit;

 l_BorderWidth  := GetSystemMetrics(SM_CXSIZEFRAME);
 l_BorderHeight := GetSystemMetrics(SM_CYSIZEFRAME);
 l_ButtonWidth  := GetSystemMetrics(SM_CXSIZE);
 l_ButtonHeight := GetSystemMetrics(SM_CYSIZE);

 with Result do
 begin
  rCaptionRect := Rect(0, 0, ClientWidth + l_BorderWidth, 0);
  rCaptionRect.Bottom := rCaptionRect.Top + GetMetric(dmCaption);

  l_ButtonRight := rCaptionRect.Right + l_BorderWidth;
  l_ButtonTop := rCaptionRect.Top + l_BorderHeight + cWindowCaptionButtonTop;

  rMinimizeButtonRect := CaptionData.MakeButtonRect(rCaptionRect.Right,
   cbkMinimize);
  rMaximizeRestoreButtonRect := CaptionData.MakeButtonRect(rCaptionRect.Right,
   cbkMaximizeRestore);
  rCloseButtonRect := CaptionData.MakeButtonRect(rCaptionRect.Right,
   cbkClose);
 end;//with Result
end;

function TFormFrameDecorator.MakeLegacyCaptionLayout: TvcmChromeLikeNonAeroFormCaptionLayout;

 function lp_MakeButtonRect(const aPrevRect: TRect; aStepToTheLeft: Integer;
  aRightMargin: Integer = 0): TRect;
 var
  l_Right: Integer;
 begin
  l_Right := aPrevRect.Left - aRightMargin;
  Result := Rect(l_Right - aStepToTheLeft, aPrevRect.Top,
   l_Right, aPrevRect.Bottom);
 end;//lp_MakeButtonRect

var
 l_ButtonWidth: Integer;
 l_ButtonHeight: Integer;
 l_ButtonTop: Integer;
 l_ButtonBottom: Integer;
 l_Left: Integer;
 l_CaptionHeight: Integer;
begin
 Result.rCaptionRect := f_ParentForm.ClientRect;
 l_CaptionHeight := GetMetric(dmCaption);

 Result.rCaptionRect.Bottom := Result.rCaptionRect.Top + l_CaptionHeight;
 l_ButtonWidth := GetSystemMetrics(SM_CXSIZE);
 l_ButtonHeight := GetSystemMetrics(SM_CYSIZE);

 l_ButtonTop := Result.rCaptionRect.Top + GetMetric(dmFormBorder);
 l_ButtonBottom := l_ButtonTop + l_ButtonHeight;

 with Result do
 begin
  Result.rCloseButtonRect := Rect(Result.rCaptionRect.Right - l_ButtonWidth,
   l_ButtonTop, Result.rCaptionRect.Right, l_ButtonBottom);
  InflateRect(rCloseButtonRect, -1, -1);

  Result.rMaximizeRestoreButtonRect := lp_MakeButtonRect(Result.rCloseButtonRect,
   l_ButtonWidth, 1);
  InflateRect(rMaximizeRestoreButtonRect, -1, 0);

  Result.rMinimizeButtonRect := lp_MakeButtonRect(Result.rMaximizeRestoreButtonRect, l_ButtonWidth);
  InflateRect(rMinimizeButtonRect, -1, 0);
 end;
end;

function TFormFrameDecorator.MakeCaptionLayout: TvcmChromeLikeNonAeroFormCaptionLayout;
begin
 if IsAppThemed then
  Result := MakeThemedCaptionLayout
 else
  Result := MakeLegacyCaptionLayout;
end;

procedure TFormFrameDecorator.SetCloseButton(aValue: TChromeLikeBaseWindowCaptionButton);
begin
 f_CloseButton := aValue;
 f_CloseButton.OnClick := CloseButtonClick;
end;

procedure TFormFrameDecorator.SetMinButton(aValue: TChromeLikeBaseWindowCaptionButton);
begin
 f_MinButton := aValue;
 f_MinButton.OnClick := MinButtonClick;
end;

function TFormFrameDecorator.GetCloseButtonClass: RChromeLikeWindowCaptionbuttonClass;
begin
 if IsAppThemed then
  Result := TChromeLikeThemedCloseCaptionButton
 else
  Result := TChromeLikeLegacyCloseCaptionButton;
end;

function TFormFrameDecorator.GetMinButtonClass: RChromeLikeWindowCaptionbuttonClass;
begin
 if IsAppThemed then
  Result := TChromeLikeThemedMinimizeCaptionButton
 else
  Result := TChromeLikeLegacyMinimizeCaptionButton;
end;

function TFormFrameDecorator.GetMaxButtonClass: RChromeLikeWindowCaptionbuttonClass;
begin
 if IsAppThemed then
  Result := TChromeLikeThemedMaximizeCaptionButton
 else
  Result := TChromeLikeLegacyMaximizeCaptionButton;
end;

procedure TFormFrameDecorator.SetClientControl(aControl: TControl);
begin
 if (f_ClientControl <> aControl) then
 begin
  aControl.Visible := False;
  f_ClientControl := aControl;
  f_ClientControl.Parent := Self;
  f_ClientControl.Align := alClient;
 end;
end;

procedure TFormFrameDecorator.UpdateHeaderRect;
begin
 f_HeaderRect := Rect(0, 0, Width, GetMetric(dmCaption));
end;

procedure TFormFrameDecorator.RecreateFrameData;
var
 l_Rect: TRect;
begin
 Sleep(1000);
 f_ButtonsVisible := not DwmCompositionEnabled;
 f_CaptionHeight := -1;
 FreeAndNil(f_CaptionData);
 FreeAndNil(f_Painter);
 UpdateHeaderRect;
 RebuildMetrics;
 f_CaptionLayout := MakeCaptionLayout;
 UpdateButtonsLayout;
 UpdateButtons;
 Painter.BeginUpdate;
 try
  Painter.InvalidateTheme;
  Painter.InvalidateSize;
 finally
  Painter.EndUpdate;
 end;
 Windows.RedrawWindow(f_ParentForm.Handle, nil, 0,
  RDW_FRAME or RDW_INVALIDATE or RDW_INTERNALPAINT);
 UpdateWindow(Self.Handle);
end;

procedure TFormFrameDecorator.NotifyButtonsFormResized;
var
 l_Index: Integer;
 l_Button: TChromeLikeBaseWindowCaptionButton;
begin
 for l_Index := 0 to Pred(ControlCount) do
 begin
  if (Controls[l_Index] is TChromeLikeBaseWindowCaptionButton) then
  begin
   l_Button := TChromeLikeBaseWindowCaptionButton(Controls[l_Index]);
   l_Button.NotifyFormResized;
  end;
 end;
end;

function TFormFrameDecorator.GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
var
 l_Control: IChromeLikeCaptionControl;
begin
 if Supports(f_ClientControl, IChromeLikeCaptionControl, l_Control) then
 try
  Result := l_Control.GetMenuKindAtPoint(aPoint);
 finally
  l_Control := nil;
 end
 else
  Assert(False);
end;

procedure TFormFrameDecorator.ShowContextMenu(const aPoint: TPoint);
var
 l_MenuKind: TChromeLikeCaptionMenuKind;
begin
 l_MenuKind := GetMenuKindAtPoint(aPoint);
 case l_MenuKind of
  cl_cmkSystem:
   ShowSystemMenu(aPoint);
  cl_cmkCustom:
   ShowCustomMenu(aPoint);
 end;
end;

procedure TFormFrameDecorator.SetMaxButton(aValue: TChromeLikeBaseWindowCaptionButton);
begin
 f_MaxButton := aValue;
 f_MaxButton.OnClick := MaxButtonClick;
end;

procedure TFormFrameDecorator.CloseButtonClick(aSender: TObject);
begin
 SendMessage(f_ParentForm.Handle, WM_SYSCOMMAND, SC_CLOSE, 0);
end;

procedure TFormFrameDecorator.MinButtonClick(aSender: TObject);
begin
 SendMessage(f_ParentForm.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

procedure TFormFrameDecorator.MaxButtonClick(aSender: TObject);
const
 cCommandArr: array[Boolean] of LongInt = (SC_MAXIMIZE, SC_RESTORE);
begin
 SendMessage(f_ParentForm.Handle, WM_SYSCOMMAND, cCommandArr[f_ParentForm.WindowState = wsMaximized], 0);
end;

procedure TFormFrameDecorator.UpdateButtons;
begin
 FreeAndNil(f_CloseButton);
 FreeAndNil(f_MaxButton);
 FreeAndNil(f_MinButton);
 if Assigned(f_OnNeedRecreateButtons) then
  f_OnNeedRecreateButtons(Self);
 UpdateButtonsLayout;
end;

function TFormFrameDecorator.pm_GetPainter: TChromeLikeFormFramePainter;
begin
 if (f_Painter = nil) then
  f_Painter := TChromeLikeFormFramePainter.Create(f_ParentForm,
   GetCaptionHeight, GetMetric(dmFormBorder));
 Result := f_Painter;
end;

function TFormFrameDecorator.pm_GetCaptionData: TChromeLikeFormCaptionData;
begin
 if (f_CaptionData = nil) then
  f_CaptionData := TChromeLikeFormCaptionData.Create;
 Result := f_CaptionData;
end;

initialization
 InitThemeLibrary;

finalization
 FreeThemeLibrary;

end.
