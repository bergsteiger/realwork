unit vtAbstractDropDownWindow;

// Модуль: "w:\common\components\gui\Garant\VT\vtAbstractDropDownWindow.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtAbstractDropDownWindow" MUID: (57E125C801C4)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , Types
 , Windows
 , Messages
 , Classes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
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

 //#UC START# *57E125C801C4ci*
 //#UC END# *57E125C801C4ci*
 _l3Unknown_Parent_ = TScrollingWinControl;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *57E125C801C4cit*
 //#UC END# *57E125C801C4cit*
 TvtAbstractDropDownWindow = {abstract} class(_l3Unknown_)
  private
   f_Done: Boolean;
   f_Canvas: TCanvas;
   f_DropDirection: TvtDropDirection;
   f_AllowResize: Boolean;
   f_IsBorderNearOwnerVisible: Boolean;
  private
   procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
   procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
   procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
   procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
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
   procedure Paint; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
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
   property AutoSize;
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
  //RecreateWindow;
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
 l_Pt: TPoint;
//#UC END# *57E24E360013_57E125C801C4_var*
begin
//#UC START# *57E24E360013_57E125C801C4_impl*
 RecreateWnd;
 AdjustPosition;
 l_OwnerHandle := GetOwnerHandle;
 ShowWindow(Handle, SW_SHOWNOACTIVATE);
 SetCapture(l_OwnerHandle);
 try
  f_Done := False;
  while GetMessage(l_Msg, 0, 0, 0) do
  begin
   l_H := GetActiveWindow;
   if (l_H <> l_OwnerHandle) and not IsChild(l_H, l_OwnerHandle) or (GetCapture <> l_OwnerHandle) then
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
      l_Pt.x := LOWORD(LongWord(l_Msg.lParam));
      l_Pt.y := HIWORD(LongWord(l_Msg.lParam));
      MapWindowPoints(l_Msg.hwnd, Handle, l_Pt, 1);
      l_Msg.lParam := MAKELPARAM(Word(l_Pt.x), Word(l_Pt.y));
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

procedure TvtAbstractDropDownWindow.Paint;
//#UC START# *57E53C6D0303_57E125C801C4_var*
//#UC END# *57E53C6D0303_57E125C801C4_var*
begin
//#UC START# *57E53C6D0303_57E125C801C4_impl*
 f_Canvas.Pen.Style := psClear;
 f_Canvas.Brush.Style := bsSolid;
 f_Canvas.Brush.Color := clRed;
 f_Canvas.FillRect(ClientRect);
//#UC END# *57E53C6D0303_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.Paint

procedure TvtAbstractDropDownWindow.WMNCCalcSize(var Message: TWMNCCalcSize);
//#UC START# *57E25F5E0233_57E125C801C4_var*
//#UC END# *57E25F5E0233_57E125C801C4_var*
begin
//#UC START# *57E25F5E0233_57E125C801C4_impl*
 //inherited;
 with Message.CalcSize_Params^ do
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

procedure TvtAbstractDropDownWindow.WMPaint(var Message: TWMPaint);
//#UC START# *57E53C0803A3_57E125C801C4_var*
var
 ps: TPaintStruct;
 dc: HDC;
//#UC END# *57E53C0803A3_57E125C801C4_var*
begin
//#UC START# *57E53C0803A3_57E125C801C4_impl*
 dc := BeginPaint(Handle, ps);
 try
  PaintWindow(dc);
 finally
  EndPaint(Handle, ps);
 end;
//#UC END# *57E53C0803A3_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMPaint

procedure TvtAbstractDropDownWindow.WMNCPaint(var Message: TWMNCPaint);
//#UC START# *57E55FCD0311_57E125C801C4_var*
//#UC END# *57E55FCD0311_57E125C801C4_var*
begin
//#UC START# *57E55FCD0311_57E125C801C4_impl*
 inherited;
//#UC END# *57E55FCD0311_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMNCPaint

procedure TvtAbstractDropDownWindow.WMNCHitTest(var Message: TWMNCHitTest);
//#UC START# *57E8C60B0281_57E125C801C4_var*
 function lp_IsTop(X, Y: Integer): Boolean;
 begin
  if (f_DropDirection = ddDown) then
   Result := f_IsBorderNearOwnerVisible and (Y < BorderWidth)
  else
   Result := (Y < BorderWidth);
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
  Result := (X < BorderWidth);
 end;

 function lp_IsRight(X, Y: Integer): Boolean;
 begin
  Result := (X >= Width - BorderWidth);
 end;

var
 X, Y: Integer;
//#UC END# *57E8C60B0281_57E125C801C4_var*
begin
//#UC START# *57E8C60B0281_57E125C801C4_impl*
 inherited;
 
 if BorderWidth = 0 then
 begin
  Message.Result := HTCLIENT;
  Exit;
 end;

 X := Message.XPos - Left;
 Y := Message.YPos - Top;

 if not f_AllowResize then
 begin
  if lp_IsTop(X, Y) or lp_IsBottom(X, Y) or lp_IsLeft(X, Y) or lp_IsRight(X, Y) then
   Message.Result := HTBORDER
  else
   Message.Result := HTCLIENT;
  Exit;
 end;

 if (f_DropDirection = ddUp) then
  if lp_IsTop(X, Y) then
   if lp_IsRight(X, Y) then
    Message.Result := HTTOPRIGHT
   else
    Message.Result := HTTOP
  else
  if lp_IsBottom(X, Y) then
   if lp_IsRight(X, Y) then
    Message.Result := HTRIGHT
   else
    Message.Result := HTBORDER
  else
  if lp_IsRight(X, Y) then
   Message.Result := HTRIGHT
  else
  if lp_IsLeft(X, Y) then
   Message.Result := HTBORDER
  else
   Message.Result := HTCLIENT
 else //(f_DropDirection = ddDown)
  if lp_IsTop(X, Y) then
   if lp_IsRight(X, Y) then
    Message.Result := HTRIGHT
   else
    Message.Result := HTBORDER
  else
  if lp_IsBottom(X, Y) then
   if lp_IsRight(X, Y) then
    Message.Result := HTBOTTOMRIGHT
   else
    Message.Result := HTBOTTOM
  else
  if lp_IsRight(X, Y) then
   Message.Result := HTRIGHT
  else
  if lp_IsLeft(X, Y) then
   Message.Result := HTBORDER
  else
   Message.Result := HTCLIENT;
//#UC END# *57E8C60B0281_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WMNCHitTest

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
 f_Canvas := TControlCanvas.Create;
 TControlCanvas(f_Canvas).Control := Self;
//#UC END# *47D1602000C6_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.Create

procedure TvtAbstractDropDownWindow.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_57E125C801C4_var*
//#UC END# *47E136A80191_57E125C801C4_var*
begin
//#UC START# *47E136A80191_57E125C801C4_impl*
 case Message.Msg of
  WM_MOUSEACTIVATE: Message.Result := MA_NOACTIVATE;
 else
  inherited;
 end;
//#UC END# *47E136A80191_57E125C801C4_impl*
end;//TvtAbstractDropDownWindow.WndProc

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
   Paint;
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
 Params.Style := WS_POPUP;
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
