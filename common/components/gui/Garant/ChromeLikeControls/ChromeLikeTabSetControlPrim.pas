unit ChromeLikeTabSetControlPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeTabSetControlPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::TChromeLikeTabSetControlPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Types,
  Messages,
  l3Bitmap,
  Graphics
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  Windows
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  ChromeLikeTabSetTypes,
  Classes
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TChromeLikeTabHintParams = record
   rNeedShowHint : Boolean;
   rHintText : AnsiString;
   rRect : TRect;
 end;//TChromeLikeTabHintParams

 TChromeLikeTabSetControlPrim = class(TWinControl)
 private
 // private fields
   f_BufferBitmap : Tl3Bitmap;
    {* Поле для свойства BufferBitmap}
   f_Images : TCustomImageList;
    {* Поле для свойства Images}
   f_BackgroundBitmap : Tl3Bitmap;
    {* Поле для свойства BackgroundBitmap}
 private
 // private methods
   function GetDrawingContext: IChromeLkeTabSetDrawingContext;
   procedure ResizeBuffer(aNewWidth: Integer;
     aNewHeight: Integer);
   procedure PaintBuffer;
   procedure FlushBuffer(aDC: hDC;
     const aRect: TRect);
   procedure WMNCHitTest(var aMessage: TWMNCHitTest); message WM_NCHITTEST;
   procedure WMMouseActivate(var aMessage: TWMMouseActivate); message WM_MOUSEACTIVATE;
   procedure WMEraseBkgnd(var aMessage: TWMEraseBkGnd); message WM_ERASEBKGND;
   procedure WMPaint(var aMessage: TWMPaint); message WM_PAINT;
   procedure WMSize(var aMessage: TWMSize); message WM_SIZE;
   procedure CMMouseLeave(var aMessage: TMessage); message CM_MOUSELEAVE;
   procedure CMHintShow(var aMessage: TMessage); message CM_HINTSHOW;
   procedure CMMouseEnter(var aMessage: TMessage); message CM_MOUSEENTER;
 protected
 // property methods
   function pm_GetBufferBitmap: Tl3Bitmap;
   function pm_GetBackgroundBitmap: Tl3Bitmap;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
 protected
 // protected methods
   function IsTransparentPoint(const aPoint: TPoint): Boolean; virtual; abstract;
   procedure Paint(const aContext: IChromeLkeTabSetDrawingContext); virtual; abstract;
   procedure PaintBackground(aCanvas: TCanvas); virtual; abstract;
   procedure DoOnMouseLeave; virtual;
     {* Сигнатура метода DoOnMouseLeave }
   procedure DoOnMouseEnter; virtual;
     {* Сигнатура метода DoOnMouseEnter }
   procedure DoOnResize; virtual; abstract;
     {* Сигнатура метода DoOnResize }
   function GetHintParams(const aPoint: TPoint): TChromeLikeTabHintParams; virtual; abstract;
 protected
 // protected properties
   property BufferBitmap: Tl3Bitmap
     read pm_GetBufferBitmap;
   property BackgroundBitmap: Tl3Bitmap
     read pm_GetBackgroundBitmap;
 public
 // public properties
   property Images: TCustomImageList
     read f_Images
     write f_Images;
 end;//TChromeLikeTabSetControlPrim
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
function TChromeLikeTabHintParams_C(aNeedShowHint: Boolean;
    const aHintText: WideString;
    const aRect: TRect): TChromeLikeTabHintParams;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  ChromeLikeDrawingContext,
  ChromeLikeTabSetUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class TChromeLikeTabSetControlPrim

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
function TChromeLikeTabHintParams_C(aNeedShowHint: Boolean;
       const aHintText: WideString;
       const aRect: TRect): TChromeLikeTabHintParams;
//#UC START# *5522508F018E_5522506003AD_var*
//#UC END# *5522508F018E_5522506003AD_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5522508F018E_5522506003AD_impl*
 with Result do
 begin
  rNeedShowHint := aNeedShowHint;
  rHintText := aHintText;
  rRect := aRect;
 end;
//#UC END# *5522508F018E_5522506003AD_impl*
end;//TChromeLikeTabHintParams.C

// start class TChromeLikeTabSetControlPrim

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

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeTabSetControlPrim
 TtfwClassRef.Register(TChromeLikeTabSetControlPrim);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene

end.