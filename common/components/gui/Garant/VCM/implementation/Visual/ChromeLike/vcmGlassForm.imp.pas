{$IfNDef vcmGlassForm_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmGlassForm.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmGlassForm
//
// Форма с расширяемой неклиентской областью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmGlassForm_imp}
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
 _vcmGlassForm_ = {mixin} class(_vcmGlassForm_Parent_)
  {* Форма с расширяемой неклиентской областью }
 private
 // private fields
   f_GlassFrame : TvcmGlassFrame;
    {* Поле для свойства GlassFrame}
   f_GlassFramePainting : Boolean;
    {* Поле для свойства GlassFramePainting}
   f_NCRenderingDisabled : Boolean;
    {* Поле для свойства NCRenderingDisabled}
   f_Active : Boolean;
    {* Поле для свойства Active}
 protected
 // property methods
   procedure pm_SetGlassFrame(aValue: TvcmGlassFrame); virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} //not NoVCL
   procedure Loaded; override;
   {$If not defined(NoVCL)}
   procedure PaintWindow(DC: hDC); override;
     {* Renders the image of a windowed control }
   {$IfEnd} //not NoVCL
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
    {$If not defined(NoVCL)}
   procedure AlignControls(AControl: TControl;
     var Rect: TRect); override;
    {$IfEnd} //not NoVCL
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected fields
   f_RefreshGlassFrame : Boolean;
 public
 // public methods
   procedure UpdateGlassFrame(aSender: TObject);
   procedure UpdateGlassFrameControls(const aRect: TRect);
   function NeedShowSystemContextMenuOnPoint(const aPoint: TPoint): Boolean; virtual;
 protected
 // protected properties
   property GlassFramePainting: Boolean
     read f_GlassFramePainting;
   property NCRenderingDisabled: Boolean
     read f_NCRenderingDisabled;
 public
 // public properties
   property GlassFrame: TvcmGlassFrame
     read f_GlassFrame
     write pm_SetGlassFrame;
   property Active: Boolean
     read f_Active;
 end;//_vcmGlassForm_
{$Else}

 _vcmGlassForm_ = _vcmGlassForm_Parent_;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$Else vcmGlassForm_imp}

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class _vcmGlassForm_

procedure _vcmGlassForm_.UpdateGlassFrame(aSender: TObject);
//#UC START# *53392725015D_5339219B0225_var*
const
 cSheetOfGlassMarginsSize = -1;
 cSheetOfGlassMargins: TElementMargins = (cxLeftWidth: -1; cxRightWidth: -1; cyTopHeight: -1; cyBottomHeight: -1);

 procedure lp_AdjustMargins(var aMargins: TElementMargins);
 begin
  if (not f_GlassFrame.SheetOfGlass) then
  begin
   aMargins.cxLeftWidth := f_GlassFrame.Left;
   aMargins.cxRightWidth := f_GlassFrame.Right;
   aMargins.cyTopHeight := f_GlassFrame.Top;
   aMargins.cyBottomHeight := f_GlassFrame.Bottom;
  end
  else
   aMargins := cSheetOfGlassMargins;
 end;//lp_AdjustMargins;

var
 l_Margins: TElementMargins;
 l_Result: HRESULT;
 l_RenderingPolicy: Integer;
 //#UC END# *53392725015D_5339219B0225_var*
begin
//#UC START# *53392725015D_5339219B0225_impl*
 if DwmCompositionEnabled and HandleAllocated and (not f_NCRenderingDisabled) then
 begin
  lp_AdjustMargins(l_Margins);
  if not (csDesigning in ComponentState) then
   f_GlassFramePainting := True
  else
  begin
   f_GlassFramePainting := False;
   l3FillChar(l_Margins, SizeOf(l_Margins), 0);
  end;//if Enabled
  if (csDesigning in ComponentState) then
   InvalidateRect(Handle, nil, True)
  else
  begin
   l_RenderingPolicy := DWMNCRP_USEWINDOWSTYLE;
   DwmSetWindowAttribute(Handle, DWMWA_NCRENDERING_POLICY, @l_RenderingPolicy,
    SizeOf(l_RenderingPolicy));
   l_Result := DwmExtendFrameIntoClientArea(Handle, l_Margins);
   Assert(l_Result = S_OK);
   Invalidate;
  end;
 end
 else
 begin
  f_GlassFramePainting := False;
  if (csDesigning in ComponentState) then
   InvalidateRect(Handle, nil, True)
 end;//if DwmCompositionEnabled and HandleAllocated
//#UC END# *53392725015D_5339219B0225_impl*
end;//_vcmGlassForm_.UpdateGlassFrame

procedure _vcmGlassForm_.UpdateGlassFrameControls(const aRect: TRect);
//#UC START# *5339273903A5_5339219B0225_var*

 function lp_ContainsRect(const anOuterRect: TRect; const anInnerRect: TRect): Boolean;
 begin
  with anInnerRect do
   Result := (Left >= anOuterRect.Left) and (Right <= anOuterRect.Right) and
    (Top >= anOuterRect.Top) and (Bottom <= anOuterRect.Bottom);
 end;//lp_ContainsRect

 procedure lp_DoUpdateControls(aControl: TWinControl);
 var
  l_Index: Integer;
  l_Rect: TRect;
  l_Control: TControl;
 begin
  for l_Index := 0 to aControl.ControlCount - 1 do
  begin
   l_Control := aControl.Controls[l_Index];
   if (not f_GlassFrame.SheetOfGlass) then
   begin
    l_Rect := l_Control.ClientRect;
    l_Rect.TopLeft := l_Control.ClientToParent(l_Rect.TopLeft, Self);
    l_Rect.BottomRight := l_Control.ClientToParent(l_Rect.BottomRight, Self);
   end;//if (not f_GlassFrame.SheetOfGlass)
   if (f_GlassFrame.SheetOfGlass) or (not lp_ContainsRect(aRect, l_Rect)) then
   begin
    if (not GlassFramePainting) then
     f_GlassFramePainting := True;
   end
   else
   if GlassFramePainting then
    f_GlassFramePainting := False;
   if l_Control is TWinControl then
    lp_DoUpdateControls(TWinControl(l_Control));
  end;//for l_Index := 0
 end;//lp_DoUpdateControls

//#UC END# *5339273903A5_5339219B0225_var*
begin
//#UC START# *5339273903A5_5339219B0225_impl*
 if ((not (csDesigning in ComponentState)) and DwmCompositionEnabled) then
  lp_DoUpdateControls(Self);
//#UC END# *5339273903A5_5339219B0225_impl*
end;//_vcmGlassForm_.UpdateGlassFrameControls

function _vcmGlassForm_.NeedShowSystemContextMenuOnPoint(const aPoint: TPoint): Boolean;
//#UC START# *53EAF3250169_5339219B0225_var*
//#UC END# *53EAF3250169_5339219B0225_var*
begin
//#UC START# *53EAF3250169_5339219B0225_impl*
 Result := False;
//#UC END# *53EAF3250169_5339219B0225_impl*
end;//_vcmGlassForm_.NeedShowSystemContextMenuOnPoint

procedure _vcmGlassForm_.pm_SetGlassFrame(aValue: TvcmGlassFrame);
//#UC START# *533926AB0375_5339219B0225set_var*
//#UC END# *533926AB0375_5339219B0225set_var*
begin
//#UC START# *533926AB0375_5339219B0225set_impl*
 f_GlassFrame.Assign(aValue);
//#UC END# *533926AB0375_5339219B0225set_impl*
end;//_vcmGlassForm_.pm_SetGlassFrame

procedure _vcmGlassForm_.Cleanup;
//#UC START# *479731C50290_5339219B0225_var*
//#UC END# *479731C50290_5339219B0225_var*
begin
//#UC START# *479731C50290_5339219B0225_impl*
 FreeAndNil(f_GlassFrame);
 inherited;
//#UC END# *479731C50290_5339219B0225_impl*
end;//_vcmGlassForm_.Cleanup

constructor _vcmGlassForm_.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_5339219B0225_var*
//#UC END# *47D1602000C6_5339219B0225_var*
begin
//#UC START# *47D1602000C6_5339219B0225_impl*
 f_GlassFrame := TvcmGlassFrame.Create(Self);
 inherited;
 f_RefreshGlassFrame := False;
//#UC END# *47D1602000C6_5339219B0225_impl*
end;//_vcmGlassForm_.Create

{$If not defined(NoVCL)}
procedure _vcmGlassForm_.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_5339219B0225_var*
//#UC END# *47E136A80191_5339219B0225_var*
begin
//#UC START# *47E136A80191_5339219B0225_impl*
 if Message.Msg = WM_DWMNCRENDERINGCHANGED then
  f_NCRenderingDisabled := not BOOL(Message.WParam);
 case Message.Msg of
  WM_DWMCOMPOSITIONCHANGED,
  WM_DWMNCRENDERINGCHANGED:
   UpdateGlassFrame(nil);
  WM_ACTIVATE:
   f_Active := TWMActivate(Message).Active in [WA_ACTIVE, WA_CLICKACTIVE];
 end;
 inherited;
//#UC END# *47E136A80191_5339219B0225_impl*
end;//_vcmGlassForm_.WndProc
{$IfEnd} //not NoVCL

procedure _vcmGlassForm_.Loaded;
//#UC START# *484516C00214_5339219B0225_var*
//#UC END# *484516C00214_5339219B0225_var*
begin
//#UC START# *484516C00214_5339219B0225_impl*
 inherited;
 if f_GlassFrame.FrameExtended then
  UpdateGlassFrame(nil);
//#UC END# *484516C00214_5339219B0225_impl*
end;//_vcmGlassForm_.Loaded

{$If not defined(NoVCL)}
procedure _vcmGlassForm_.PaintWindow(DC: hDC);
//#UC START# *48C6BFF80313_5339219B0225_var*
var
 l_ClientRect: TRect;
 l_SaveIndex: Integer;
//#UC END# *48C6BFF80313_5339219B0225_var*
begin
//#UC START# *48C6BFF80313_5339219B0225_impl*
 Canvas.Lock;
 try
  Canvas.Handle := DC;
  try
   l_SaveIndex := SaveDC(DC);
   try
    with f_GlassFrame do
    begin
     if (FrameExtended or ((csDesigning in ComponentState) and Enabled)) and (not f_NCRenderingDisabled) then
     begin
      l_ClientRect := ClientRect;
      if (not SheetOfGlass) and (not f_RefreshGlassFrame) then
       ExcludeClipRect(DC, Left, Top, l_ClientRect.Right - Right, l_ClientRect.Bottom - Bottom)
      else
       f_RefreshGlassFrame := False;
      if (not (csDesigning in ComponentState)) then
       FillRect(Canvas.Handle, l_ClientRect, GetStockObject(BLACK_BRUSH));
     end;
    end;
   finally
    RestoreDC(DC, l_SaveIndex);
   end;
  Paint;
  finally
   Canvas.Handle := 0;
  end;
 finally
  Canvas.Unlock;
 end;
//#UC END# *48C6BFF80313_5339219B0225_impl*
end;//_vcmGlassForm_.PaintWindow
{$IfEnd} //not NoVCL

procedure _vcmGlassForm_.InitControls;
//#UC START# *4A8E8F2E0195_5339219B0225_var*
//#UC END# *4A8E8F2E0195_5339219B0225_var*
begin
//#UC START# *4A8E8F2E0195_5339219B0225_impl*
 inherited;
 f_GlassFrame.OnNeedUpdateGlassFrameControls := UpdateGlassFrameControls;
 f_GlassFrame.OnChange := UpdateGlassFrame;
//#UC END# *4A8E8F2E0195_5339219B0225_impl*
end;//_vcmGlassForm_.InitControls

{$If not defined(NoVCL)}
procedure _vcmGlassForm_.AlignControls(AControl: TControl;
  var Rect: TRect);
//#UC START# *5028E66702B0_5339219B0225_var*
var
 l_RectToUpdate: TRect;
//#UC END# *5028E66702B0_5339219B0225_var*
begin
//#UC START# *5028E66702B0_5339219B0225_impl*
 inherited;
 if (GlassFramePainting and not (csLoading in ComponentState)) then
 begin
  l_RectToUpdate := Types.Rect(f_GlassFrame.Left, f_GlassFrame.Top,
   ClientWidth - f_GlassFrame.Right, ClientHeight - f_GlassFrame.Bottom);
  UpdateGlassFrameControls(l_RectToUpdate);
 end;//if (GlassFramePainting...
//#UC END# *5028E66702B0_5339219B0225_impl*
end;//_vcmGlassForm_.AlignControls
{$IfEnd} //not NoVCL

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$EndIf vcmGlassForm_imp}
