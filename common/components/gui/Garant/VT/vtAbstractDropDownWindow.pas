unit vtAbstractDropDownWindow;

// Модуль: "w:\common\components\gui\Garant\VT\vtAbstractDropDownWindow.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtAbstractDropDownWindow" MUID: (57E125C801C4)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , Types
 , Windows
 , Messages
 , Classes
 , l3PureMixIns
 //#UC START# *57E125C801C4intf_uses*
 //#UC END# *57E125C801C4intf_uses*
;

type
 TvtDropDirection = (
  {* Направление выпадения окна относительно Owner-а. }
  ddDown
  , ddUp
 );//TvtDropDirection

 TvtResizeDirection = (
  rdRight
  , rdBottom
  , rdTop
  , rdBottomRight
  , rdTopRight
 );//TvtResizeDirection

 //#UC START# *57E125C801C4ci*
 //#UC END# *57E125C801C4ci*
 _l3Unknown_Parent_ = TWinControl;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *57E125C801C4cit*
 //#UC END# *57E125C801C4cit*
 TvtAbstractDropDownWindow = {abstract} class(_l3Unknown_)
  private
   f_Done: Boolean;
   f_Canvas: TCanvas;
   f_ResizeDirection: TvtResizeDirection;
   f_Resize: Boolean;
   f_ResizePoint: TPoint;
    {* Точка окна, за которую схватили мышью для изменения размеров }
   f_InitialBounds: TRect;
    {* Положение окна перед началом процесса изменения размеров }
   f_DropDirection: TvtDropDirection;
   f_AllowResize: Boolean;
   f_IsBorderNearOwnerVisible: Boolean;
  private
   procedure WMNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
   procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
   procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
   procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
   procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
   procedure WMNCLButtonDown(var Msg: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
   procedure WMNCMouseMove(var Msg: TWMNCMouseMove); message WM_NCMOUSEMOVE;
   procedure WMNCLButtonUp(var Msg: TWMNCLButtonUp); message WM_NCLBUTTONUP;
   procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
  protected
   procedure pm_SetAllowResize(aValue: Boolean);
   function GetOwnerRect: TRect; virtual;
    {* Расположение главного контрола на экране.
Относительно него будем автоматом располагать наше окно. }
   procedure AdjustPosition; virtual;
    {* Размещаем окно относительно главного контрола }
   function GetTotalClientHeight: Integer; virtual;
    {* Полная высота данных. Для скроллбара. }
   function GetTotalClientWidth: Integer; virtual;
    {* Полная ширина данных. Для скроллбара. }
   function GetOwnerHandle: THandle; virtual;
   procedure CloseUp;
   procedure Paint(aNCArea: Boolean); virtual;
   procedure BeginResize(aResizeDirection: TvtResizeDirection;
    PosX: Integer;
    PosY: Integer); virtual;
    {* (PosX, PosY) - точка окна, за которую схватились мышью }
   procedure ProcessResize(PosX: Integer;
    PosY: Integer); virtual;
    {* (PosX, PosY) - позиция мыши в экранных координатах }
   procedure FinishResize; virtual;
   procedure NCPaint(aDC: hDC);
   procedure HitTest(var Msg: TWMNCHitTest); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure PaintWindow(DC: hDC); override;
    {* Renders the image of a windowed control }
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure AdjustSize; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure Drop;
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(NoVCL)}
   function CanFocus: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
  protected
   property DropDirection: TvtDropDirection
    read f_DropDirection;
  public
   property AllowResize: Boolean
    read f_AllowResize
    write pm_SetAllowResize;
   property IsBorderNearOwnerVisible: Boolean
    read f_IsBorderNearOwnerVisible
    write f_IsBorderNearOwnerVisible;
 //#UC START# *57E125C801C4publ*
    property BorderWidth;
    property Constraints;
 //#UC END# *57E125C801C4publ*
 end;//TvtAbstractDropDownWindow

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , l3MemUtils
 , l3Interlocked
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57E125C801C4impl_uses*
 , l3MinMax
 , Forms
 //#UC END# *57E125C801C4impl_uses*
;

{$If NOT Defined(NoVCL)}
{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvtAbstractDropDownWindow.pm_SetAllowResize(aValue: Boolean);
//#UC START# *57E14EBD0128_57E125C801C4set_var*
//#UC END# *57E14EBD0128_57E125C801C4set_var*
begin
//#UC START# *57E14EBD0128_57E125C801C4set_impl*
 if (f_AllowResize <> aValue) then
 begin
  f_AllowResize := aValue;
  if f_AllowResize then
   AutoSize := False;
 end;
//#UC END# *57E14EBD0128_57E125C801C4set_impl*
end;//TvtAbstractDropDownWindow.pm_SetAllowResize

function TvtAbstractDropDownWindow.GetOwnerRect: TRect;
 {* Расположение главного контрола на экране.
Относительно него будем автоматом располагать наше окно. }
//#UC START# *57E2474902DE_57E125C801C4_var*
//#UC END# *57E2474902DE_57E125C801C4_var*
begin
//#UC START# *57E2474902DE_57E125C801C4_impl*
 if Assigned(Owner) and (Owner is TControl) then
  with (Owner as TControl) do
   Result := Rect(ClientToScreen(Point(0, 0)), ClientToScreen(Point(Width, Height)))
 else
  Result := Rect(0, 0, 0, 0);
//#UC END# *57E2474902DE_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.GetOwnerRect

procedure TvtAbstractDropDownWindow.AdjustPosition;
 {* Размещаем окно относительно главного контрола }
//#UC START# *57E248100136_57E125C801C4_var*
var
 l_MonitorRect, l_OwnerRect: TRect;
 l_SpaceAbove, l_SpaceUnder: Integer;
 P: TPoint;
//#UC END# *57E248100136_57E125C801C4_var*
begin
//#UC START# *57E248100136_57E125C801C4_impl*
 if AutoSize then
  AdjustSize;

 l_OwnerRect := GetOwnerRect;
 P := Point(l_OwnerRect.Left, l_OwnerRect.Bottom);
 l_MonitorRect := Screen.MonitorFromPoint(P).WorkareaRect;
 //выбираем, куда будем выпадать:
 l_SpaceUnder := Max(0, l_MonitorRect.Bottom - l_OwnerRect.Bottom); //расстояние от Owner до нижнего края экрана
 if (l_SpaceUnder >= Height) then
  f_DropDirection := ddDown
 else
 begin
  l_SpaceAbove := Max(0, l_OwnerRect.Top - l_MonitorRect.Top); //до верхнего
  if (l_SpaceUnder >= l_SpaceAbove) then
   f_DropDirection := ddDown
  else
   f_DropDirection := ddUp;
 end;
 if (f_DropDirection = ddDown) then
  SetBounds(l_OwnerRect.Left, l_OwnerRect.Bottom, Width, Height)
 else
  SetBounds(l_OwnerRect.Left, l_OwnerRect.Top - Height, Width, Height);
//#UC END# *57E248100136_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.AdjustPosition

procedure TvtAbstractDropDownWindow.Drop;
//#UC START# *57E24E360013_57E125C801C4_var*
var
 l_Msg: TMsg;
 l_H,
 l_OwnerHandle: THandle;
 l_Pt,
 l_PtGlobal: TPoint;
 l_HT: Integer;
 l_NCMsg: Cardinal;
//#UC END# *57E24E360013_57E125C801C4_var*
begin
//#UC START# *57E24E360013_57E125C801C4_impl*
 f_Resize := False;
 //RecreateWnd;
 AdjustPosition;
 l_OwnerHandle := GetOwnerHandle;
 ShowWindow(Handle, SW_SHOWNOACTIVATE);
 SetCapture(l_OwnerHandle);
 try
  f_Done := False;
  while GetMessage(l_Msg, 0, 0, 0) do
  begin
   l_H := GetActiveWindow;
   if (l_H <> l_OwnerHandle) then
    if not IsChild(l_H, l_OwnerHandle) or ((GetCapture <> l_OwnerHandle) and (GetCapture <> Handle)) then
     Break;
   case l_Msg.Message of
    WM_MOUSEMOVE,
    WM_LBUTTONDOWN,
    WM_LBUTTONUP,
    WM_LBUTTONDBLCLK,
    WM_RBUTTONDOWN,
    WM_RBUTTONUP,
    WM_RBUTTONDBLCLK,
    WM_MBUTTONDOWN,
    WM_MBUTTONUP,
    WM_MBUTTONDBLCLK:
     begin
      l_Pt.x := SmallInt(LOWORD(LongWord(l_Msg.lParam)));
      l_Pt.y := SmallInt(HIWORD(LongWord(l_Msg.lParam)));
      MapWindowPoints(l_Msg.hwnd, Handle, l_Pt, 1);
      l_PtGlobal := l_Pt;
      MapWindowPoints(Handle, GetDesktopWindow, l_PtGlobal, 1);
      l_Msg.lParam := MakeLParam(Word(l_Pt.x), Word(l_Pt.y));
      l_HT := Perform(WM_NCHITTEST, 0, LongInt(PointToSmallPoint(l_PtGlobal)));
      case l_Msg.Message of
       WM_MOUSEMOVE: l_NCMsg := WM_NCMOUSEMOVE;
       WM_LBUTTONDOWN: l_NCMsg := WM_NCLBUTTONDOWN;
       WM_LBUTTONUP: l_NCMsg := WM_NCLBUTTONUP;
       WM_LBUTTONDBLCLK: l_NCMsg := WM_NCLBUTTONDBLCLK;
       WM_RBUTTONDOWN: l_NCMsg := WM_NCRBUTTONDOWN;
       WM_RBUTTONUP: l_NCMsg := WM_NCRBUTTONUP;
       WM_RBUTTONDBLCLK: l_NCMsg := WM_NCRBUTTONDBLCLK;
       WM_MBUTTONDOWN: l_NCMsg := WM_NCMBUTTONDOWN;
       WM_MBUTTONUP: l_NCMsg := WM_NCMBUTTONUP;
       WM_MBUTTONDBLCLK: l_NCMsg := WM_NCMBUTTONDBLCLK;
      else
       Assert(False);
       l_NCMsg := 0;
      end;
      Perform(l_NCMsg, l_HT, l_Msg.lParam);
      l_Msg.hwnd := Handle;
     end;

    WM_NCMOUSEMOVE,
    WM_NCLBUTTONDOWN,
    WM_NCLBUTTONUP,
    WM_NCLBUTTONDBLCLK,
    WM_NCRBUTTONDOWN,
    WM_NCRBUTTONUP,
    WM_NCRBUTTONDBLCLK,
    WM_NCMBUTTONDOWN,
    WM_NCMBUTTONUP,
    WM_NCMBUTTONDBLCLK,

    WM_KEYDOWN,
    WM_KEYUP,
    WM_CHAR,
    WM_DEADCHAR,
    WM_SYSKEYDOWN,
    WM_SYSKEYUP,
    WM_SYSCHAR,
    WM_SYSDEADCHAR:
     l_Msg.hwnd := Handle;
   end;

    ???DefaultHandler(l_Msg);

   TranslateMessage(l_Msg);
   DispatchMessage(l_Msg);
   if f_Done then
    Break;
  end;
 finally
  ReleaseCapture;
  ShowWindow(Handle, SW_HIDE);
 end;

 if (l_Msg.Message = WM_QUIT) then
  PostQuitMessage(l_Msg.wParam);
//#UC END# *57E24E360013_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.Drop

function TvtAbstractDropDownWindow.GetTotalClientHeight: Integer;
 {* Полная высота данных. Для скроллбара. }
//#UC START# *57E2564902B7_57E125C801C4_var*
//#UC END# *57E2564902B7_57E125C801C4_var*
begin
//#UC START# *57E2564902B7_57E125C801C4_impl*
 Result := 200;
//#UC END# *57E2564902B7_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.GetTotalClientHeight

function TvtAbstractDropDownWindow.GetTotalClientWidth: Integer;
 {* Полная ширина данных. Для скроллбара. }
//#UC START# *57E2568B01E8_57E125C801C4_var*
//#UC END# *57E2568B01E8_57E125C801C4_var*
begin
//#UC START# *57E2568B01E8_57E125C801C4_impl*
 Result := 100;
//#UC END# *57E2568B01E8_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.GetTotalClientWidth

function TvtAbstractDropDownWindow.GetOwnerHandle: THandle;
//#UC START# *57E3BB8101C2_57E125C801C4_var*
//#UC END# *57E3BB8101C2_57E125C801C4_var*
begin
//#UC START# *57E3BB8101C2_57E125C801C4_impl*
 Result := 0;
 if Assigned(Owner) and (Owner is TWinControl) then
  Result := (Owner as TWinControl).Handle;
//#UC END# *57E3BB8101C2_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.GetOwnerHandle

procedure TvtAbstractDropDownWindow.CloseUp;
//#UC START# *57E3CB0F00A9_57E125C801C4_var*
//#UC END# *57E3CB0F00A9_57E125C801C4_var*
begin
//#UC START# *57E3CB0F00A9_57E125C801C4_impl*
 f_Done := True;
//#UC END# *57E3CB0F00A9_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.CloseUp

procedure TvtAbstractDropDownWindow.Paint(aNCArea: Boolean);
//#UC START# *57E53C6D0303_57E125C801C4_var*
var
 r, cr: TRect;
//#UC END# *57E53C6D0303_57E125C801C4_var*
begin
//#UC START# *57E53C6D0303_57E125C801C4_impl*
 if not aNCArea then
 begin
  f_Canvas.Pen.Style := psClear;
  f_Canvas.Brush.Style := bsSolid;
  f_Canvas.Brush.Color := clRed;
  f_Canvas.FillRect(ClientRect);
  f_Canvas.Brush.Color := clGreen;
  f_Canvas.FillRect(Rect(0, 0, GetTotalClientWidth, GetTotalClientHeight));
 end else
 if (BorderWidth > 0) then
 begin
  f_Canvas.Pen.Style := psSolid;
  f_Canvas.Pen.Width := 1;
  f_Canvas.Pen.Color := clBlue;
  f_Canvas.Brush.Style := bsSolid;
  f_Canvas.Brush.Color := clBlue;
  f_Canvas.Rectangle(0, 0, BorderWidth, Height);
  f_Canvas.Rectangle(Width - BorderWidth, 0, Width, Height);
  if f_DropDirection = ddDown then
  begin
   f_Canvas.Rectangle(0, Height - BorderWidth, Width, Height);
   if IsBorderNearOwnerVisible then
    f_Canvas.Rectangle(0, 0, Width, BorderWidth);
  end else
  begin
   if IsBorderNearOwnerVisible then
    f_Canvas.Rectangle(0, Height - BorderWidth, Width, Height);
   f_Canvas.Rectangle(0, 0, Width, BorderWidth);
  end;
 end;
//#UC END# *57E53C6D0303_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.Paint

procedure TvtAbstractDropDownWindow.BeginResize(aResizeDirection: TvtResizeDirection;
 PosX: Integer;
 PosY: Integer);
 {* (PosX, PosY) - точка окна, за которую схватились мышью }
//#UC START# *57ED30620029_57E125C801C4_var*
//#UC END# *57ED30620029_57E125C801C4_var*
begin
//#UC START# *57ED30620029_57E125C801C4_impl*
 SetCapture(GetOwnerHandle);
 f_ResizePoint := Point(PosX, PosY);
 f_ResizeDirection := aResizeDirection;
 f_Resize := True;
 f_InitialBounds := BoundsRect;
//#UC END# *57ED30620029_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.BeginResize

procedure TvtAbstractDropDownWindow.ProcessResize(PosX: Integer;
 PosY: Integer);
 {* (PosX, PosY) - позиция мыши в экранных координатах }
//#UC START# *57EE6C32020D_57E125C801C4_var*
var
 B: TRect;
//#UC END# *57EE6C32020D_57E125C801C4_var*
begin
//#UC START# *57EE6C32020D_57E125C801C4_impl*
 if f_Resize then
 begin
  B := BoundsRect;
  case f_ResizeDirection of
   rdRight: B.Right := PosX + (f_InitialBounds.Right - f_InitialBounds.Left) - f_ResizePoint.X;
   rdBottom: B.Bottom := PosY + (f_InitialBounds.Bottom - f_InitialBounds.Top) - f_ResizePoint.Y;
   rdTop:
    begin
     B.Top := PosY - f_ResizePoint.Y;
     if B.Top < B.Bottom - Constraints.MaxHeight then
      B.Top := B.Bottom - Constraints.MaxHeight;
     if B.Top > B.Bottom - Constraints.MinHeight then
      B.Top := B.Bottom - Constraints.MinHeight;
    end;
   rdBottomRight:
    begin
     B.Right := PosX + (f_InitialBounds.Right - f_InitialBounds.Left) - f_ResizePoint.X;
     B.Bottom := PosY + (f_InitialBounds.Bottom - f_InitialBounds.Top) - f_ResizePoint.Y;
    end;
   rdTopRight:
    begin
     B.Right := PosX + (f_InitialBounds.Right - f_InitialBounds.Left) - f_ResizePoint.X;
     B.Top := PosY - f_ResizePoint.Y;
     if B.Top < B.Bottom - Constraints.MaxHeight then
      B.Top := B.Bottom - Constraints.MaxHeight;
     if B.Top > B.Bottom - Constraints.MinHeight then
      B.Top := B.Bottom - Constraints.MinHeight;
    end;
  end;
  BoundsRect := B;
 end;
//#UC END# *57EE6C32020D_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.ProcessResize

procedure TvtAbstractDropDownWindow.FinishResize;
//#UC START# *57EE6CDD00B2_57E125C801C4_var*
//#UC END# *57EE6CDD00B2_57E125C801C4_var*
begin
//#UC START# *57EE6CDD00B2_57E125C801C4_impl*
 if f_Resize then
 begin
  f_Resize := False;
  SetCapture(GetOwnerHandle);
 end;
//#UC END# *57EE6CDD00B2_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.FinishResize

procedure TvtAbstractDropDownWindow.NCPaint(aDC: hDC);
//#UC START# *57F62D6B0111_57E125C801C4_var*
//#UC END# *57F62D6B0111_57E125C801C4_var*
begin
//#UC START# *57F62D6B0111_57E125C801C4_impl*
 f_Canvas.Lock;
 try
  f_Canvas.Handle := aDC;
  try
   Paint(True);
  finally
   f_Canvas.Handle := 0;
  end;
 finally
  f_Canvas.Unlock;
 end;
//#UC END# *57F62D6B0111_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.NCPaint

procedure TvtAbstractDropDownWindow.HitTest(var Msg: TWMNCHitTest);
//#UC START# *57F7B58F0176_57E125C801C4_var*
 function lp_IsTop(X, Y: Integer): Boolean;
 begin
  if (f_DropDirection = ddDown) then
   Result := f_IsBorderNearOwnerVisible and (Y <= BorderWidth)
  else
   Result := (Y <= BorderWidth);
 end;

 function lp_IsBottom(X, Y: Integer): Boolean;
 begin
  if (f_DropDirection = ddUp) then
   Result := f_IsBorderNearOwnerVisible and (Y >= Height - BorderWidth)
  else
   Result := (Y >= Height - BorderWidth);
 end;

 function lp_IsLeft(X, Y: Integer): Boolean;
 begin
  Result := (X <= BorderWidth);
 end;

 function lp_IsRight(X, Y: Integer): Boolean;
 begin
  Result := (X >= Width - BorderWidth);
 end;

var
 Dx, Dy: Integer;

 function lp_IsTopRight(X, Y: Integer): Boolean;
 begin
  Result := (lp_IsTop(X, Y) and (X >= Width - Dx)) or
            (lp_IsRight(X, Y) and (Y <= Dy));
 end;

 function lp_IsBottomRight(X, Y: Integer): Boolean;
 begin
  Result := (lp_IsBottom(X, Y) and (X >= Width - Dx)) or
            (lp_IsRight(X, Y) and (Y >= Height - Dy));
 end;

var
 X, Y, R: Integer;
 P: TPoint;
 H: THandle;
//#UC END# *57F7B58F0176_57E125C801C4_var*
begin
//#UC START# *57F7B58F0176_57E125C801C4_impl*
 Dx := GetSystemMetrics(SM_CXVSCROLL) + BorderWidth;
 Dy := GetSystemMetrics(SM_CYHSCROLL) + BorderWidth;

 if not PtInRect(BoundsRect, Point(Msg.XPos, Msg.YPos)) then
 begin
  Msg.Result := HTNOWHERE;
  Exit;
 end;

 if BorderWidth = 0 then
 begin
  Msg.Result := HTCLIENT;
  Exit;
 end;

 X := Msg.XPos - Left;
 Y := Msg.YPos - Top;

 if not f_AllowResize then
 begin
  if lp_IsTop(X, Y) or lp_IsBottom(X, Y) or lp_IsLeft(X, Y) or lp_IsRight(X, Y) then
   Msg.Result := HTBORDER
  else
   Msg.Result := HTCLIENT;
  Perform(WM_SETCURSOR, WPARAM(Handle), MakeLParam(Msg.Result, WM_SETCURSOR));
  Exit;
 end;

 Msg.Result := HTTRANSPARENT;

 if (f_DropDirection = ddUp) then
  if lp_IsTopRight(X, Y) then
   Msg.Result := HTTOPRIGHT
  else
  if lp_IsTop(X, Y) then
   Msg.Result := HTTOP
  else
  if lp_IsBottom(X, Y) then
   if lp_IsRight(X, Y) then
    Msg.Result := HTRIGHT
   else
    Msg.Result := HTBORDER
  else
  if lp_IsRight(X, Y) then
   Msg.Result := HTRIGHT
  else
  if lp_IsLeft(X, Y) then
   Msg.Result := HTBORDER
  else
   Msg.Result := HTCLIENT
 else //(f_DropDirection = ddDown)
 if lp_IsTop(X, Y) then
  if lp_IsRight(X, Y) then
   Msg.Result := HTRIGHT
  else
   Msg.Result := HTBORDER
 else
 if lp_IsBottomRight(X, Y) then
  Msg.Result := HTBOTTOMRIGHT
 else
 if lp_IsBottom(X, Y) then
  Msg.Result := HTBOTTOM
 else
 if lp_IsRight(X, Y) then
  Msg.Result := HTRIGHT
 else
 if lp_IsLeft(X, Y) then
  Msg.Result := HTBORDER
 else
  Msg.Result := HTCLIENT;

 if not f_AllowResize and (Msg.Result in [HTLEFT..HTBOTTOMRIGHT]) then
  Msg.Result := HTBORDER;
//#UC END# *57F7B58F0176_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.HitTest

procedure TvtAbstractDropDownWindow.WMNCCalcSize(var Msg: TWMNCCalcSize);
//#UC START# *57E25F5E0233_57E125C801C4_var*
//#UC END# *57E25F5E0233_57E125C801C4_var*
begin
//#UC START# *57E25F5E0233_57E125C801C4_impl*
 DefaultHandler(Msg);

 with Msg.CalcSize_Params^ do
 begin
  InflateRect(rgrc[0], -BorderWidth, 0);
  if f_IsBorderNearOwnerVisible then // все границы видно: просто уменьшаем клиентскую область
   InflateRect(rgrc[0], 0, -BorderWidth)
  else
  if (f_DropDirection = ddDown) then
   Dec(rgrc[0].Bottom, BorderWidth)
  else //ddUp
   Inc(rgrc[0].Top, BorderWidth);
 end;
//#UC END# *57E25F5E0233_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMNCCalcSize

procedure TvtAbstractDropDownWindow.WMNCPaint(var Msg: TWMNCPaint);
//#UC START# *57E55FCD0311_57E125C801C4_var*
var
 DC: hDC;
//#UC END# *57E55FCD0311_57E125C801C4_var*
begin
//#UC START# *57E55FCD0311_57E125C801C4_impl*
 inherited;
 DC := GetWindowDC(Handle);
 try
  NCPaint(DC);
 finally
  ReleaseDC(Handle, DC);
 end;//try..finally
//#UC END# *57E55FCD0311_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMNCPaint

procedure TvtAbstractDropDownWindow.WMNCHitTest(var Msg: TWMNCHitTest);
//#UC START# *57E8C60B0281_57E125C801C4_var*
//#UC END# *57E8C60B0281_57E125C801C4_var*
begin
//#UC START# *57E8C60B0281_57E125C801C4_impl*
 inherited;
 HitTest(Msg);
// Perform(WM_SETCURSOR, WPARAM(Handle), MakeLParam(Msg.Result, WM_SETCURSOR));
//#UC END# *57E8C60B0281_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMNCHitTest

procedure TvtAbstractDropDownWindow.WMMouseMove(var Msg: TWMMouseMove);
//#UC START# *57ED160D00F8_57E125C801C4_var*
var
 P: TPoint;
//#UC END# *57ED160D00F8_57E125C801C4_var*
begin
//#UC START# *57ED160D00F8_57E125C801C4_impl*
 inherited;
 //DefaultHandler(Msg);
 P := Point(Msg.XPos, Msg.YPos);
 MapWindowPoints(Handle, GetDesktopWindow, P, 1);
 if not PtInRect(BoundsRect, P) then
 begin
  Cursor := crDefault;
  Windows.SetCursor(Screen.Cursors[crDefault]);
 end;
//#UC END# *57ED160D00F8_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMMouseMove

procedure TvtAbstractDropDownWindow.WMPaint(var Msg: TWMPaint);
//#UC START# *57ED16320366_57E125C801C4_var*
var
 ps: TPaintStruct;
 dc: HDC;
//#UC END# *57ED16320366_57E125C801C4_var*
begin
//#UC START# *57ED16320366_57E125C801C4_impl*
 dc := BeginPaint(Handle, ps);
 try
  PaintWindow(dc);
 finally
  EndPaint(Handle, ps);
 end;
//#UC END# *57ED16320366_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMPaint

procedure TvtAbstractDropDownWindow.WMNCLButtonDown(var Msg: TWMNCLButtonDown);
//#UC START# *57ED30370037_57E125C801C4_var*
var
 rd: TvtResizeDirection;
//#UC END# *57ED30370037_57E125C801C4_var*
begin
//#UC START# *57ED30370037_57E125C801C4_impl*
 case Msg.HitTest of
  HTRIGHT: rd := rdRight;
  HTBOTTOM: rd := rdBottom;
  HTTOP: rd := rdTop;
  HTBOTTOMRIGHT: rd := rdBottomRight;
  HTTOPRIGHT: rd := rdTopRight;
 else
  //DefaultHandler(Msg);
  inherited;
  Exit;
 end;
 BeginResize(rd, Msg.XCursor, Msg.YCursor);
//#UC END# *57ED30370037_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMNCLButtonDown

procedure TvtAbstractDropDownWindow.WMNCMouseMove(var Msg: TWMNCMouseMove);
//#UC START# *57ED3384013B_57E125C801C4_var*
//#UC END# *57ED3384013B_57E125C801C4_var*
begin
//#UC START# *57ED3384013B_57E125C801C4_impl*
 DefaultHandler(Msg);
 ProcessResize(Msg.XCursor + Left, Msg.YCursor + Top);
//#UC END# *57ED3384013B_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMNCMouseMove

procedure TvtAbstractDropDownWindow.WMNCLButtonUp(var Msg: TWMNCLButtonUp);
//#UC START# *57EE706D00A3_57E125C801C4_var*
//#UC END# *57EE706D00A3_57E125C801C4_var*
begin
//#UC START# *57EE706D00A3_57E125C801C4_impl*
 FinishResize;
//#UC END# *57EE706D00A3_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMNCLButtonUp

procedure TvtAbstractDropDownWindow.WMMouseActivate(var Msg: TWMMouseActivate);
//#UC START# *57F23AD70393_57E125C801C4_var*
//#UC END# *57F23AD70393_57E125C801C4_var*
begin
//#UC START# *57F23AD70393_57E125C801C4_impl*
 Msg.Result := MA_NOACTIVATE;
//#UC END# *57F23AD70393_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMMouseActivate

procedure TvtAbstractDropDownWindow.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E125C801C4_var*
//#UC END# *479731C50290_57E125C801C4_var*
begin
//#UC START# *479731C50290_57E125C801C4_impl*
 FreeAndNil(f_Canvas);
 inherited;
//#UC END# *479731C50290_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.Cleanup

constructor TvtAbstractDropDownWindow.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57E125C801C4_var*
//#UC END# *47D1602000C6_57E125C801C4_var*
begin
//#UC START# *47D1602000C6_57E125C801C4_impl*
 inherited Create(aOwner);
 AutoSize := True;
 f_IsBorderNearOwnerVisible := False;
 f_Resize := False;
 f_Canvas := TControlCanvas.Create;
 TControlCanvas(f_Canvas).Control := Self;
//#UC END# *47D1602000C6_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.Create

procedure TvtAbstractDropDownWindow.PaintWindow(DC: hDC);
 {* Renders the image of a windowed control }
//#UC START# *48C6BFF80313_57E125C801C4_var*
//#UC END# *48C6BFF80313_57E125C801C4_var*
begin
//#UC START# *48C6BFF80313_57E125C801C4_impl*
 f_Canvas.Lock;
 try
  f_Canvas.Handle := DC;
  try
   Paint(False);
  finally
   f_Canvas.Handle := 0;
  end;
 finally
  f_Canvas.Unlock;
 end;
//#UC END# *48C6BFF80313_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.PaintWindow

procedure TvtAbstractDropDownWindow.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_57E125C801C4_var*
//#UC END# *48C7925A02E5_57E125C801C4_var*
begin
//#UC START# *48C7925A02E5_57E125C801C4_impl*
 inherited;
 Params.Style := (Params.Style and not WS_CHILD) or WS_POPUP;
 Params.ExStyle := WS_EX_TOOLWINDOW or WS_EX_WINDOWEDGE or WS_EX_TOPMOST;
 Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
 Params.WndParent := GetDesktopWindow;
//#UC END# *48C7925A02E5_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.CreateParams

function TvtAbstractDropDownWindow.CanFocus: Boolean;
//#UC START# *4E1350DE0094_57E125C801C4_var*
//#UC END# *4E1350DE0094_57E125C801C4_var*
begin
//#UC START# *4E1350DE0094_57E125C801C4_impl*
 Result := False;
//#UC END# *4E1350DE0094_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.CanFocus

procedure TvtAbstractDropDownWindow.AdjustSize;
//#UC START# *57E12CDC0172_57E125C801C4_var*
var
 H, W: Integer;
//#UC END# *57E12CDC0172_57E125C801C4_var*
begin
//#UC START# *57E12CDC0172_57E125C801C4_impl*
 W := GetTotalClientWidth + 2 * BorderWidth;
 H := GetTotalClientHeight + BorderWidth;
 if f_IsBorderNearOwnerVisible then
  Inc(H, BorderWidth);
 SetBounds(Left, Top, W, H);
//#UC END# *57E12CDC0172_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.AdjustSize

//#UC START# *57E125C801C4impl*
//#UC END# *57E125C801C4impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtAbstractDropDownWindow);
 {* Регистрация TvtAbstractDropDownWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
