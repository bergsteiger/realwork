unit vtAbstractScrollingDropDownWindow;

// Модуль: "w:\common\components\gui\Garant\VT\vtAbstractScrollingDropDownWindow.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtAbstractScrollingDropDownWindow" MUID: (57F4D92C029E)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtAbstractDropDownWindow
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvtAbstractScrollingDropDownWindow = class(TvtAbstractDropDownWindow)
  private
   f_ScrollBars: TScrollStyle;
   f_SizeGrip: Boolean;
  private
   procedure WMSize(var Msg: TWMSize); message WM_SIZE;
   procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
   procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
   procedure WMNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
  protected
   procedure pm_SetScrollBars(aValue: TScrollStyle);
   procedure pm_SetSizeGrip(aValue: Boolean);
   function pm_GetAutoSize: Boolean; virtual;
   procedure pm_SetAutoSize(aValue: Boolean); virtual;
   procedure UpdateScrollInfo;
   procedure GetScrollBarsVisible(out aHScroll: Boolean;
    out aVScroll: Boolean);
   procedure InitFields; override;
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure Paint(aNCArea: Boolean); override;
   procedure HitTest(var Msg: TWMNCHitTest); override;
  public
   property ScrollBars: TScrollStyle
    read f_ScrollBars
    write pm_SetScrollBars;
   property SizeGrip: Boolean
    read f_SizeGrip
    write pm_SetSizeGrip;
   property AutoSize: Boolean
    read pm_GetAutoSize
    write pm_SetAutoSize;
 end;//TvtAbstractScrollingDropDownWindow

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57F4D92C029Eimpl_uses*
 , Classes
 , Windows
 //#UC END# *57F4D92C029Eimpl_uses*
;

procedure TvtAbstractScrollingDropDownWindow.pm_SetScrollBars(aValue: TScrollStyle);
//#UC START# *57F659780060_57F4D92C029Eset_var*
//#UC END# *57F659780060_57F4D92C029Eset_var*
begin
//#UC START# *57F659780060_57F4D92C029Eset_impl*
 // пока что без горизонтального
 if aValue = ssBoth then
  aValue := ssVertical
 else
 if aValue = ssHorizontal then
  aValue := ssNone;

 if (f_ScrollBars <> aValue) then
 begin
  f_ScrollBars := aValue;
  RecreateWnd;
 end;
//#UC END# *57F659780060_57F4D92C029Eset_impl*
end;//TvtAbstractScrollingDropDownWindow.pm_SetScrollBars

procedure TvtAbstractScrollingDropDownWindow.pm_SetSizeGrip(aValue: Boolean);
//#UC START# *57F78829017B_57F4D92C029Eset_var*
//#UC END# *57F78829017B_57F4D92C029Eset_var*
begin
//#UC START# *57F78829017B_57F4D92C029Eset_impl*
 if f_SizeGrip <> aValue then
 begin
  f_SizeGrip := aValue;
  if f_SizeGrip then
   AutoSize := False;
  RecreateWnd; 
 end;
//#UC END# *57F78829017B_57F4D92C029Eset_impl*
end;//TvtAbstractScrollingDropDownWindow.pm_SetSizeGrip

function TvtAbstractScrollingDropDownWindow.pm_GetAutoSize: Boolean;
//#UC START# *57F7C5D10269_57F4D92C029Eget_var*
//#UC END# *57F7C5D10269_57F4D92C029Eget_var*
begin
//#UC START# *57F7C5D10269_57F4D92C029Eget_impl*
 Result := inherited AutoSize;
//#UC END# *57F7C5D10269_57F4D92C029Eget_impl*
end;//TvtAbstractScrollingDropDownWindow.pm_GetAutoSize

procedure TvtAbstractScrollingDropDownWindow.pm_SetAutoSize(aValue: Boolean);
//#UC START# *57F7C5D10269_57F4D92C029Eset_var*
//#UC END# *57F7C5D10269_57F4D92C029Eset_var*
begin
//#UC START# *57F7C5D10269_57F4D92C029Eset_impl*
 inherited AutoSize := aValue;
 if aValue then
 begin
  AllowResize := False;
  SizeGrip := False;
 end;
//#UC END# *57F7C5D10269_57F4D92C029Eset_impl*
end;//TvtAbstractScrollingDropDownWindow.pm_SetAutoSize

procedure TvtAbstractScrollingDropDownWindow.UpdateScrollInfo;
//#UC START# *57F3C62D038B_57F4D92C029E_var*
var
 l_ScrollInfo: TScrollInfo;
 H, V: Boolean;
//#UC END# *57F3C62D038B_57F4D92C029E_var*
begin
//#UC START# *57F3C62D038B_57F4D92C029E_impl*
 GetScrollBarsVisible(H, V);
 l_ScrollInfo.cbSize := SizeOf(l_ScrollInfo);
 l_ScrollInfo.nMin := 0;
 l_ScrollInfo.nMax := GetTotalClientHeight;
 if V then
  l_ScrollInfo.nPage := ClientHeight
 else
  l_ScrollInfo.nPage := l_ScrollInfo.nMax + 1;
 l_ScrollInfo.nPos := 0;
 l_ScrollInfo.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
 SetScrollInfo(Handle, SB_VERT, l_ScrollInfo, True);
 l_ScrollInfo.cbSize := SizeOf(l_ScrollInfo);
 l_ScrollInfo.nMin := 0;
 l_ScrollInfo.nMax := GetTotalClientWidth;
 if H then
  l_ScrollInfo.nPage := ClientWidth
 else
  l_ScrollInfo.nPage := l_ScrollInfo.nMax + 1;
 l_ScrollInfo.nPos := 0;
 l_ScrollInfo.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
 SetScrollInfo(Handle, SB_HORZ, l_ScrollInfo, True);
//#UC END# *57F3C62D038B_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.UpdateScrollInfo

procedure TvtAbstractScrollingDropDownWindow.GetScrollBarsVisible(out aHScroll: Boolean;
 out aVScroll: Boolean);
//#UC START# *57F6581A0326_57F4D92C029E_var*
var
 l_RealClientWidth,
 l_RealClientHeight: Integer;
//#UC END# *57F6581A0326_57F4D92C029E_var*
begin
//#UC START# *57F6581A0326_57F4D92C029E_impl*
 l_RealClientWidth := Width - 2 * BorderWidth;
 if IsBorderNearOwnerVisible then
  l_RealClientHeight := Height - 2 * BorderWidth
 else
  l_RealClientHeight := Height - BorderWidth;
 if f_SizeGrip then
  l_RealClientHeight := l_RealClientHeight - GetSystemMetrics(SM_CYHSCROLL);

 aHScroll := (f_ScrollBars in [ssHorizontal, ssBoth]) and(l_RealClientWidth < GetTotalClientWidth);
 if aHScroll then
  Dec(l_RealClientHeight, GetSystemMetrics(SM_CYHSCROLL));

 aVScroll := (f_ScrollBars in [ssVertical, ssBoth]) and (l_RealClientHeight < GetTotalClientHeight);
 if aVScroll then
 begin
  Dec(l_RealClientWidth, GetSystemMetrics(SM_CXVSCROLL));
  aHScroll := (f_ScrollBars in [ssHorizontal, ssBoth]) and (l_RealClientWidth < GetTotalClientWidth);
 end;
//#UC END# *57F6581A0326_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.GetScrollBarsVisible

procedure TvtAbstractScrollingDropDownWindow.WMSize(var Msg: TWMSize);
//#UC START# *57F3C8350020_57F4D92C029E_var*
//#UC END# *57F3C8350020_57F4D92C029E_var*
begin
//#UC START# *57F3C8350020_57F4D92C029E_impl*
 inherited;
 UpdateScrollInfo;
//#UC END# *57F3C8350020_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.WMSize

procedure TvtAbstractScrollingDropDownWindow.WMHScroll(var Msg: TWMHScroll);
//#UC START# *57F4DAEA00FB_57F4D92C029E_var*
//#UC END# *57F4DAEA00FB_57F4D92C029E_var*
begin
//#UC START# *57F4DAEA00FB_57F4D92C029E_impl*
 inherited;
//#UC END# *57F4DAEA00FB_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.WMHScroll

procedure TvtAbstractScrollingDropDownWindow.WMVScroll(var Msg: TWMVScroll);
//#UC START# *57F4DAFC0079_57F4D92C029E_var*
//#UC END# *57F4DAFC0079_57F4D92C029E_var*
begin
//#UC START# *57F4DAFC0079_57F4D92C029E_impl*
 inherited;
//#UC END# *57F4DAFC0079_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.WMVScroll

procedure TvtAbstractScrollingDropDownWindow.WMNCCalcSize(var Msg: TWMNCCalcSize);
//#UC START# *57F787EA025B_57F4D92C029E_var*
var
 H, V: Boolean;
//#UC END# *57F787EA025B_57F4D92C029E_var*
begin
//#UC START# *57F787EA025B_57F4D92C029E_impl*
 inherited;
 GetScrollBarsVisible(H, V);
 if not H and f_SizeGrip then
 begin
  if DropDirection = ddDown then
   Dec(Msg.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CYHSCROLL))
  else
   Inc(Msg.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CYHSCROLL));
 end;
//#UC END# *57F787EA025B_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.WMNCCalcSize

procedure TvtAbstractScrollingDropDownWindow.InitFields;
//#UC START# *47A042E100E2_57F4D92C029E_var*
//#UC END# *47A042E100E2_57F4D92C029E_var*
begin
//#UC START# *47A042E100E2_57F4D92C029E_impl*
 inherited;
//#UC END# *47A042E100E2_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.InitFields

{$If NOT Defined(NoVCL)}
procedure TvtAbstractScrollingDropDownWindow.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_57F4D92C029E_var*
const
 P: array[TScrollStyle] of DWORD = (0, WS_HSCROLL, WS_VSCROLL, WS_HSCROLL or WS_VSCROLL);
//#UC END# *48C7925A02E5_57F4D92C029E_var*
begin
//#UC START# *48C7925A02E5_57F4D92C029E_impl*
 inherited CreateParams(Params);
 Params.Style := Params.Style or P[f_ScrollBars];
//#UC END# *48C7925A02E5_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtAbstractScrollingDropDownWindow.CreateWnd;
//#UC START# *4CC8414403B8_57F4D92C029E_var*
//#UC END# *4CC8414403B8_57F4D92C029E_var*
begin
//#UC START# *4CC8414403B8_57F4D92C029E_impl*
 inherited;
//#UC END# *4CC8414403B8_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.CreateWnd
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtAbstractScrollingDropDownWindow.Paint(aNCArea: Boolean);
//#UC START# *57E53C6D0303_57F4D92C029E_var*
var
 V, H: Boolean;

 function lp_SizeGripRect: TRect;
 var
  CX, CY: Integer;
 begin
  CX := GetSystemMetrics(SM_CXVSCROLL);
  CY := GetSystemMetrics(SM_CYHSCROLL);
  if DropDirection = ddDown then
   if H then
    Result := Rect(Width - BorderWidth - CX, Height - BorderWidth - CY, Width - BorderWidth, Height - BorderWidth)
   else
    Result := Rect(BorderWidth, Height - BorderWidth - CY, Width - BorderWidth, Height - BorderWidth)
  else
   if H then
    Result := Rect(Width - BorderWidth - CX, BorderWidth, Width - BorderWidth, Height - BorderWidth)
   else
    Result := Rect(BorderWidth, BorderWidth, Width - BorderWidth, BorderWidth + CY);
 end;

var
 DC: hDC;
 l_Bitmap: HBITMAP;
 l_CacheDC: HDC;
 l_Width, l_Height: Integer;
 r: TRect;
//#UC END# *57E53C6D0303_57F4D92C029E_var*
begin
//#UC START# *57E53C6D0303_57F4D92C029E_impl*
 inherited;
 if not aNCArea then
  Exit;
 if f_SizeGrip then
 begin
  GetScrollBarsVisible(H, V);
  DC := GetWindowDC(Handle);
  try
   r := lp_SizeGripRect;
   l_Width := r.Right - r.Left;
   l_Height := r.Bottom - r.Top;

   l_CacheDC := CreateCompatibleDC(DC);
   l_Bitmap := CreateCompatibleBitmap(DC, l_Width, l_Height);
   SelectObject(l_CacheDC, l_Bitmap);
   DrawFrameControl(l_CacheDC, Rect(0, 0, l_Width, l_Height), DFC_SCROLL, DFCS_SCROLLSIZEGRIP);

   if DropDirection = ddDown then
    StretchBlt(DC, r.Left, r.Top, l_Width, l_Height, l_CacheDC, 0, 0, l_Width, l_Height, SRCCOPY)
   else
    StretchBlt(DC, r.Left, r.Top + l_Height - 1, l_Width, -l_Height, l_CacheDC, 0, 0, l_Width, l_Height, SRCCOPY);

   DeleteObject(l_Bitmap);
   DeleteDC(l_CacheDC);
  finally
   ReleaseDC(Handle, DC);
  end;
 end;
//#UC END# *57E53C6D0303_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.Paint

procedure TvtAbstractScrollingDropDownWindow.HitTest(var Msg: TWMNCHitTest);
//#UC START# *57F7B58F0176_57F4D92C029E_var*
var
 X, Y: Integer;
 VS, HS: Boolean;
//#UC END# *57F7B58F0176_57F4D92C029E_var*
begin
//#UC START# *57F7B58F0176_57F4D92C029E_impl*
 inherited;

 if (Msg.Result = HTCLIENT) then
 begin
  X := Msg.XPos - Left;
  Y := Msg.YPos - Top;
  GetScrollBarsVisible(HS, VS);
  if (X >= Width - BorderWidth - GetSystemMetrics(SM_CXVSCROLL)) then
  begin
   if DropDirection = ddDown then
    if f_SizeGrip and (Y >= Height - BorderWidth - GetSystemMetrics(SM_CXVSCROLL)) then
     Msg.Result := HTBOTTOMRIGHT
    else
    if VS then
     Msg.Result := HTVSCROLL
    else
     //inherited
   else
    if f_SizeGrip and (Y <= BorderWidth + GetSystemMetrics(SM_CXVSCROLL)) then
     Msg.Result := HTTOPRIGHT
    else
    if VS then
     Msg.Result := HTVSCROLL
    else
     //inherited
  end;
 end;
//#UC END# *57F7B58F0176_57F4D92C029E_impl*
end;//TvtAbstractScrollingDropDownWindow.HitTest

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtAbstractScrollingDropDownWindow);
 {* Регистрация TvtAbstractScrollingDropDownWindow }
{$IfEnd} // NOT Defined(NoScripts)

end.
