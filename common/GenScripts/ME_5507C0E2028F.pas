unit ChromeLikeTabSetControlPrim;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetControlPrim.pas"
// Стереотип: "GuiControl"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Bitmap
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , ChromeLikeTabSetTypes
 , Windows
 , Types
 , Graphics
 , Classes
;

type
 TChromeLikeTabHintParams = record
  rNeedShowHint: Boolean;
  rHintText: AnsiString;
  rRect: TRect;
 end;//TChromeLikeTabHintParams

 TChromeLikeTabSetControlPrim = class(TWinControl)
  private
   f_BufferBitmap: Tl3Bitmap;
    {* Поле для свойства BufferBitmap }
   f_Images: TCustomImageList;
    {* Поле для свойства Images }
   f_BackgroundBitmap: Tl3Bitmap;
    {* Поле для свойства BackgroundBitmap }
  private
   function GetDrawingContext: IChromeLkeTabSetDrawingContext;
   procedure ResizeBuffer(aNewWidth: Integer;
    aNewHeight: Integer);
   procedure PaintBuffer;
   procedure FlushBuffer(aDC: hDC;
    const aRect: TRect);
   procedure WMNCHitTest(var aMessage: TWMNCHitTest);
   procedure WMMouseActivate(var aMessage: TWMMouseActivate);
   procedure WMEraseBkgnd(var aMessage: TWMEraseBkGnd);
   procedure WMPaint(var aMessage: TWMPaint);
   procedure WMSize(var aMessage: TWMSize);
   procedure CMMouseLeave(var aMessage: TMessage);
   procedure CMHintShow(var aMessage: TMessage);
   procedure CMMouseEnter(var aMessage: TMessage);
  protected
   function pm_GetBufferBitmap: Tl3Bitmap;
   function pm_GetBackgroundBitmap: Tl3Bitmap;
   function IsTransparentPoint(const aPoint: TPoint): Boolean; virtual; abstract;
   procedure Paint(const aContext: IChromeLkeTabSetDrawingContext); virtual; abstract;
   procedure PaintBackground(aCanvas: TCanvas); virtual; abstract;
   procedure DoOnMouseLeave; virtual;
   procedure DoOnMouseEnter; virtual;
   procedure DoOnResize; virtual; abstract;
   function GetHintParams(const aPoint: TPoint): TChromeLikeTabHintParams; virtual; abstract;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
  protected
   property BufferBitmap: Tl3Bitmap
    read pm_GetBufferBitmap;
   property BackgroundBitmap: Tl3Bitmap
    read pm_GetBackgroundBitmap;
  public
   property Images: TCustomImageList
    read f_Images
    write f_Images;
 end;//TChromeLikeTabSetControlPrim

function TChromeLikeTabHintParams_C: TChromeLikeTabHintParams;
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , ChromeLikeDrawingContext
 , SysUtils
 , ChromeLikeTabSetUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TChromeLikeTabHintParams_C: TChromeLikeTabHintParams;
//#UC START# *5522508F018E_5522506003AD_var*
//#UC END# *5522508F018E_5522506003AD_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5522508F018E_5522506003AD_impl*
 with Result do
 begin
  rNeedShowHint := aNeedShowHint;
  rHintText := aHintText;
  rRect := aRect;
 end;
//#UC END# *5522508F018E_5522506003AD_impl*
end;//TChromeLikeTabHintParams_C

function TChromeLikeTabSetControlPrim.pm_GetBufferBitmap: Tl3Bitmap;
//#UC START# *5507C19A032F_5507C0E2028Fget_var*
//#UC END# *5507C19A032F_5507C0E2028Fget_var*
begin
//#UC START# *5507C19A032F_5507C0E2028Fget_impl*
 if (f_BufferBitmap = nil) then
 begin
  f_BufferBitmap := Tl3Bitmap.Create;
  with f_BufferBitmap do
  begin
   PixelFormat := pf32Bit;
   Width := ClientWidth;
   Height := ClientHeight;
  end;//with f_BufferBitmap
  f_BackgroundBitmap := Tl3Bitmap.Create;
  with f_BackgroundBitmap do
  begin
   PixelFormat := pf32Bit;
   Width := ClientWidth;
   Height := ClientHeight;
  end;//with f_BackgroundBitmap
 end;
 Result := f_BufferBitmap;
//#UC END# *5507C19A032F_5507C0E2028Fget_impl*
end;//TChromeLikeTabSetControlPrim.pm_GetBufferBitmap

function TChromeLikeTabSetControlPrim.pm_GetBackgroundBitmap: Tl3Bitmap;
//#UC START# *5512A07A01B0_5507C0E2028Fget_var*
//#UC END# *5512A07A01B0_5507C0E2028Fget_var*
begin
//#UC START# *5512A07A01B0_5507C0E2028Fget_impl*
 Result := f_BackgroundBitmap;
//#UC END# *5512A07A01B0_5507C0E2028Fget_impl*
end;//TChromeLikeTabSetControlPrim.pm_GetBackgroundBitmap

function TChromeLikeTabSetControlPrim.GetDrawingContext: IChromeLkeTabSetDrawingContext;
//#UC START# *5507C214017E_5507C0E2028F_var*
//#UC END# *5507C214017E_5507C0E2028F_var*
begin
//#UC START# *5507C214017E_5507C0E2028F_impl*
 Result := TChromeLikeDrawingContext.Make(BufferBitmap.Canvas);
//#UC END# *5507C214017E_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.GetDrawingContext

procedure TChromeLikeTabSetControlPrim.ResizeBuffer(aNewWidth: Integer;
 aNewHeight: Integer);
//#UC START# *5507C239016D_5507C0E2028F_var*
//#UC END# *5507C239016D_5507C0E2028F_var*
begin
//#UC START# *5507C239016D_5507C0E2028F_impl*
 BufferBitmap.Width := ClientWidth;
 BufferBitmap.Height := ClientHeight;
 BackgroundBitmap.Width := ClientWidth;
 BackgroundBitmap.Height := ClientHeight;
//#UC END# *5507C239016D_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.ResizeBuffer

procedure TChromeLikeTabSetControlPrim.PaintBuffer;
//#UC START# *5507C24300FB_5507C0E2028F_var*
var
 l_DrawingContext: IChromeLkeTabSetDrawingContext;
//#UC END# *5507C24300FB_5507C0E2028F_var*
begin
//#UC START# *5507C24300FB_5507C0E2028F_impl*
 l_DrawingContext := GetDrawingContext;
 try
  Paint(l_DrawingContext);
 finally
  l_DrawingContext := nil;
 end;//try..finally
//#UC END# *5507C24300FB_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.PaintBuffer

procedure TChromeLikeTabSetControlPrim.FlushBuffer(aDC: hDC;
 const aRect: TRect);
//#UC START# *5507C24E035D_5507C0E2028F_var*
var
 l_UpdateSize: TSize;

 procedure lp_FlushBitmap(aBitmap: Tl3Bitmap);
 begin
  BitBlt(aDC,
         aRect.Left, aRect.Top,
         l_UpdateSize.cx, l_UpdateSize.cy,
         aBitmap.Canvas.Handle,
         aRect.Left, aRect.Top,
         SRCCOPY);
 end;

//#UC END# *5507C24E035D_5507C0E2028F_var*
begin
//#UC START# *5507C24E035D_5507C0E2028F_impl*
 l_UpdateSize.cx := RectWidth(aRect);
 l_UpdateSize.cy := RectHeight(aRect);

 lp_FlushBitmap(f_BufferBitmap);
//#UC END# *5507C24E035D_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.FlushBuffer

procedure TChromeLikeTabSetControlPrim.DoOnMouseLeave;
//#UC START# *5507DE800105_5507C0E2028F_var*
//#UC END# *5507DE800105_5507C0E2028F_var*
begin
//#UC START# *5507DE800105_5507C0E2028F_impl*
 // Ничего не делаем
//#UC END# *5507DE800105_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.DoOnMouseLeave

procedure TChromeLikeTabSetControlPrim.DoOnMouseEnter;
//#UC START# *5507DE9302F6_5507C0E2028F_var*
//#UC END# *5507DE9302F6_5507C0E2028F_var*
begin
//#UC START# *5507DE9302F6_5507C0E2028F_impl*
 // Ничего не делаем
//#UC END# *5507DE9302F6_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.DoOnMouseEnter

procedure TChromeLikeTabSetControlPrim.WMNCHitTest(var aMessage: TWMNCHitTest);
//#UC START# *5507C2E301DB_5507C0E2028F_var*
var
 l_sPt: TPoint;
 l_cPt: TPoint;
//#UC END# *5507C2E301DB_5507C0E2028F_var*
begin
//#UC START# *5507C2E301DB_5507C0E2028F_impl*
 inherited;
 l_sPt := Point(aMessage.XPos, aMessage.YPos);
 l_cPt := ScreenToClient(l_sPt);
 if (GetAsyncKeyState(VK_LBUTTON) < 0) then
  if IsTransparentPoint(l_cPt) then
   aMessage.Result := HTTRANSPARENT;
//#UC END# *5507C2E301DB_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.WMNCHitTest

procedure TChromeLikeTabSetControlPrim.WMMouseActivate(var aMessage: TWMMouseActivate);
//#UC START# *5507C4170179_5507C0E2028F_var*
var
 l_ParentForm: TCustomForm;
//#UC END# *5507C4170179_5507C0E2028F_var*
begin
//#UC START# *5507C4170179_5507C0E2028F_impl*
 aMessage.Result := MA_NOACTIVATE;
 l_ParentForm := GetParentForm(Self);
 Assert(l_ParentForm <> nil);
 if (l_ParentForm <> nil) and (GetActiveWindow <> l_ParentForm.Handle) then
  SetActiveWindow(l_ParentForm.Handle);
//#UC END# *5507C4170179_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.WMMouseActivate

procedure TChromeLikeTabSetControlPrim.WMEraseBkgnd(var aMessage: TWMEraseBkGnd);
//#UC START# *5507C43301ED_5507C0E2028F_var*
//#UC END# *5507C43301ED_5507C0E2028F_var*
begin
//#UC START# *5507C43301ED_5507C0E2028F_impl*
 PaintBackground(f_BackgroundBitmap.Canvas);
 f_BufferBitmap.Canvas.CopyRect(ClientRect, f_BackgroundBitmap.Canvas, ClientRect);
 PaintBuffer;
 aMessage.Result := 0;
//#UC END# *5507C43301ED_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.WMEraseBkgnd

procedure TChromeLikeTabSetControlPrim.WMPaint(var aMessage: TWMPaint);
//#UC START# *5507C4560295_5507C0E2028F_var*
var
 l_PS: TPaintStruct;
 l_DC: HDC;
//#UC END# *5507C4560295_5507C0E2028F_var*
begin
//#UC START# *5507C4560295_5507C0E2028F_impl*
 l_DC := BeginPaint(Handle, l_PS);
 try
  FlushBuffer(l_DC, l_PS.rcPaint);
 finally
  EndPaint(Handle, l_PS);
 end;
//#UC END# *5507C4560295_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.WMPaint

procedure TChromeLikeTabSetControlPrim.WMSize(var aMessage: TWMSize);
//#UC START# *5507C4690029_5507C0E2028F_var*
//#UC END# *5507C4690029_5507C0E2028F_var*
begin
//#UC START# *5507C4690029_5507C0E2028F_impl*
 inherited;
 ResizeBuffer(Width, Height);
 DoOnResize;
 Invalidate;
//#UC END# *5507C4690029_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.WMSize

procedure TChromeLikeTabSetControlPrim.CMMouseLeave(var aMessage: TMessage);
//#UC START# *5507C47E00FD_5507C0E2028F_var*
//#UC END# *5507C47E00FD_5507C0E2028F_var*
begin
//#UC START# *5507C47E00FD_5507C0E2028F_impl*
 inherited;
 DoOnMouseLeave;
//#UC END# *5507C47E00FD_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.CMMouseLeave

procedure TChromeLikeTabSetControlPrim.CMHintShow(var aMessage: TMessage);
//#UC START# *5507C49701E2_5507C0E2028F_var*
var
 l_HintParams: TChromeLikeTabHintParams;
 l_ScreenRect: TRect;
//#UC END# *5507C49701E2_5507C0E2028F_var*
begin
//#UC START# *5507C49701E2_5507C0E2028F_impl*
 l_HintParams := GetHintParams(TCMHintShow(aMessage).HintInfo^.CursorPos);
 if l_HintParams.rNeedShowHint then
 begin
  l_ScreenRect.TopLeft := ClientToScreen(l_HintParams.rRect.TopLeft);
  l_ScreenRect.BottomRight := ClientToScreen(l_HintParams.rRect.BottomRight);
  with TCMHintShow(aMessage).HintInfo^ do
  begin
   HintStr := l_HintParams.rHintText;
   CursorRect := l_ScreenRect;
  end;
 end
 else
  aMessage.Result := 0;
//#UC END# *5507C49701E2_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.CMHintShow

procedure TChromeLikeTabSetControlPrim.CMMouseEnter(var aMessage: TMessage);
//#UC START# *5507DEAF02CE_5507C0E2028F_var*
//#UC END# *5507DEAF02CE_5507C0E2028F_var*
begin
//#UC START# *5507DEAF02CE_5507C0E2028F_impl*
 inherited;
 DoOnMouseEnter;
//#UC END# *5507DEAF02CE_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.CMMouseEnter

constructor TChromeLikeTabSetControlPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_5507C0E2028F_var*
//#UC END# *47D1602000C6_5507C0E2028F_var*
begin
//#UC START# *47D1602000C6_5507C0E2028F_impl*
 inherited;
//#UC END# *47D1602000C6_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.Create

destructor TChromeLikeTabSetControlPrim.Destroy;
//#UC START# *48077504027E_5507C0E2028F_var*
//#UC END# *48077504027E_5507C0E2028F_var*
begin
//#UC START# *48077504027E_5507C0E2028F_impl*
 FreeAndNil(f_BufferBitmap);
 FreeAndNil(f_BackgroundBitmap);
 inherited;
//#UC END# *48077504027E_5507C0E2028F_impl*
end;//TChromeLikeTabSetControlPrim.Destroy

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeTabSetControlPrim);
 {* Регистрация TChromeLikeTabSetControlPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
