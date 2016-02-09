unit vtPanel;

// Модуль: "w:\common\components\gui\Garant\VT\vtPanel.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , afwTextControl
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Defaults
 , Graphics
 , Messages
 , l3InternalInterfaces
 , Types
 , OvcController
;

type
 //#UC START# *50FD3A9003A4ci*
 TDummy = 0..0;

const
 cDefBack = {$IfDef Nemesis}cGarant2011BackColor{$Else}clBtnFace{$EndIf};

type
 //#UC END# *50FD3A9003A4ci*
 //#UC START# *50FD3A9003A4cit*
 //#UC END# *50FD3A9003A4cit*
 TvtCustomPanelPrim = class(TafwTextControl)
  private
   f_BevelInner: TPanelBevel;
    {* Поле для свойства BevelInner }
   f_BevelOuter: TPanelBevel;
    {* Поле для свойства BevelOuter }
   f_Alignment: TAlignment;
    {* Поле для свойства Alignment }
   f_BevelWidth: TBevelWidth;
    {* Поле для свойства BevelWidth }
   f_BorderWidth: TBorderWidth;
    {* Поле для свойства BorderWidth }
   f_FullRepaint: Boolean;
    {* Поле для свойства FullRepaint }
  protected
   procedure pm_SetBevelInner(aValue: TPanelBevel); virtual;
   procedure pm_SetBevelOuter(aValue: TPanelBevel); virtual;
   procedure pm_SetAlignment(aValue: TAlignment);
   procedure pm_SetBevelWidth(aValue: TBevelWidth); virtual;
   procedure pm_SetBorderWidth(aValue: TBorderWidth);
  protected
   property BevelInner: TPanelBevel
    read f_BevelInner
    write pm_SetBevelInner;
    {* default bvNone; }
   property BevelOuter: TPanelBevel
    read f_BevelOuter
    write pm_SetBevelOuter;
    {* default bvRaised; }
   property Alignment: TAlignment
    read f_Alignment
    write pm_SetAlignment;
    {* default taCenter; }
   property BevelWidth: TBevelWidth
    read f_BevelWidth
    write pm_SetBevelWidth;
    {* default 1; }
   property BorderWidth: TBorderWidth
    read f_BorderWidth
    write pm_SetBorderWidth;
    {* default 0; }
   property FullRepaint: Boolean
    read f_FullRepaint
    write f_FullRepaint;
    {* default True; }
 //#UC START# *50FD3A9003A4publ*
 //#UC END# *50FD3A9003A4publ*
 end;//TvtCustomPanelPrim

 //#UC START# *50FD1AE5027Aci*
 //#UC END# *50FD1AE5027Aci*
 _afwShortcutsHandler_Parent_ = TvtCustomPanelPrim;
 {$Include afwShortcutsHandler.imp.pas}
 //#UC START# *50FD1AE5027Acit*
 //#UC END# *50FD1AE5027Acit*
 TvtCustomPanel = class(_afwShortcutsHandler_)
  private
   {$If Defined(Delphi7)}
   f_ParentBackgroundSet: Boolean;
   {$IfEnd} // Defined(Delphi7)
   f_In64Hack: Boolean;
   {$If Defined(fakefake)}
   fakefakefake: Tl3DefaultsFakeType;
   {$IfEnd} // Defined(fakefake)
   fakefakefakefakefake: TFontStyle;
   {$If NOT Defined(Delphi7)}
   f_OnResize: TNotifyEvent;
    {* Поле для свойства OnResize }
   {$IfEnd} // NOT Defined(Delphi7)
   f_FixW2kWMSize: Boolean;
    {* Поле для свойства FixW2kWMSize }
  private
   procedure CMTextChanged(var Message: TMessage);
   procedure WMSize(var Message: TWMSize);
   procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
  protected
   {$If NOT Defined(Delphi7)}
   procedure Resize; virtual;
   {$IfEnd} // NOT Defined(Delphi7)
   procedure DrawFrame(const CN: Il3Canvas;
    var Rect: TRect);
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure AlignControls(AControl: TControl;
    var Rect: TRect); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetParentBackground(Value: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  protected
   {$If NOT Defined(Delphi7)}
   property OnResize: TNotifyEvent
    read f_OnResize
    write f_OnResize;
   {$IfEnd} // NOT Defined(Delphi7)
  public
   property FixW2kWMSize: Boolean
    read f_FixW2kWMSize
    write f_FixW2kWMSize;
 //#UC START# *50FD1AE5027Apubl*
 public
   {$IfDef Delphi7}
   property ParentBackground stored f_ParentBackgroundSet;
   {$EndIf Delphi7}
 protected
   property Color default cDefBack;
   property ParentColor default False;
   property BevelInner default bvNone;
   property BevelOuter default bvRaised;
   property Alignment default taCenter;
   property BevelWidth default 1;
   property BorderWidth default 0;
   property FullRepaint default True;
 //#UC END# *50FD1AE5027Apubl*
 end;//TvtCustomPanel

 //#UC START# *4A7961A701CFci*
 //#UC END# *4A7961A701CFci*
 //#UC START# *4A7961A701CFcit*
 //#UC END# *4A7961A701CFcit*
 TvtPanel = class(TvtCustomPanel)
 //#UC START# *4A7961A701CFpubl*
 public
  property DockManager;
 published
  property Align;
  property Alignment;
  property Anchors;
  property AutoSize;
  property BevelInner;
  property BevelOuter;
  property BevelWidth;
  property BiDiMode;
  property BorderWidth;
  property BorderStyle;
  property Caption;
  property Color;
  property Constraints;
  property Ctl3D;
  property UseDockManager default True;
  property DockSite;
  property DragCursor;
  property DragKind;
  property DragMode;
  property Enabled;
  property FullRepaint;
  property Font;
  property ParentBiDiMode;
  //property DisableAcceptInDockOver;
  {$IfDef Delphi7}
  property ParentBackground;
  {$EndIf}
  property ParentColor;
  property ParentCtl3D;
  property ParentFont;
  property ParentShowHint;
  property PopupMenu;
  property ShowHint;
  property TabOrder;
  property TabStop;
  property Visible;
  property OnCanResize;
  property OnClick;
  property OnConstrainedResize;
  property OnContextPopup;
  property OnDockDrop;
  property OnDockOver;
  property OnDblClick;
  property OnDragDrop;
  property OnDragOver;
  property OnEndDock;
  property OnEndDrag;
  property OnEnter;
  property OnExit;
  property OnGetSiteInfo;
  property OnMouseDown;
  property OnMouseMove;
  property OnMouseUp;
  property OnResize;
  property OnStartDock;
  property OnStartDrag;
  property OnUnDock;
 //#UC END# *4A7961A701CFpubl*
 end;//TvtPanel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3String
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Themes
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , OvcConst
;

procedure TvtCustomPanelPrim.pm_SetBevelInner(aValue: TPanelBevel);
//#UC START# *50FD17EC01F0_50FD3A9003A4set_var*
//#UC END# *50FD17EC01F0_50FD3A9003A4set_var*
begin
//#UC START# *50FD17EC01F0_50FD3A9003A4set_impl*
  f_BevelInner := aValue;
  Realign;
  Invalidate;
//#UC END# *50FD17EC01F0_50FD3A9003A4set_impl*
end;//TvtCustomPanelPrim.pm_SetBevelInner

procedure TvtCustomPanelPrim.pm_SetBevelOuter(aValue: TPanelBevel);
//#UC START# *50FD1813022C_50FD3A9003A4set_var*
//#UC END# *50FD1813022C_50FD3A9003A4set_var*
begin
//#UC START# *50FD1813022C_50FD3A9003A4set_impl*
  f_BevelOuter := aValue;
  Realign;
  Invalidate;
//#UC END# *50FD1813022C_50FD3A9003A4set_impl*
end;//TvtCustomPanelPrim.pm_SetBevelOuter

procedure TvtCustomPanelPrim.pm_SetAlignment(aValue: TAlignment);
//#UC START# *50FD18B600A0_50FD3A9003A4set_var*
//#UC END# *50FD18B600A0_50FD3A9003A4set_var*
begin
//#UC START# *50FD18B600A0_50FD3A9003A4set_impl*
  f_Alignment := aValue;
  Invalidate;
//#UC END# *50FD18B600A0_50FD3A9003A4set_impl*
end;//TvtCustomPanelPrim.pm_SetAlignment

procedure TvtCustomPanelPrim.pm_SetBevelWidth(aValue: TBevelWidth);
//#UC START# *50FD19A80171_50FD3A9003A4set_var*
//#UC END# *50FD19A80171_50FD3A9003A4set_var*
begin
//#UC START# *50FD19A80171_50FD3A9003A4set_impl*
  f_BevelWidth := aValue;
  Realign;
  Invalidate;
//#UC END# *50FD19A80171_50FD3A9003A4set_impl*
end;//TvtCustomPanelPrim.pm_SetBevelWidth

procedure TvtCustomPanelPrim.pm_SetBorderWidth(aValue: TBorderWidth);
//#UC START# *50FD19BE011A_50FD3A9003A4set_var*
//#UC END# *50FD19BE011A_50FD3A9003A4set_var*
begin
//#UC START# *50FD19BE011A_50FD3A9003A4set_impl*
  f_BorderWidth := aValue;
  Realign;
  Invalidate;
//#UC END# *50FD19BE011A_50FD3A9003A4set_impl*
end;//TvtCustomPanelPrim.pm_SetBorderWidth

//#UC START# *50FD3A9003A4impl*
//#UC END# *50FD3A9003A4impl*

{$Include afwShortcutsHandler.imp.pas}

{$If NOT Defined(Delphi7)}
procedure TvtCustomPanel.Resize;
//#UC START# *50FD3279019E_50FD1AE5027A_var*
//#UC END# *50FD3279019E_50FD1AE5027A_var*
begin
//#UC START# *50FD3279019E_50FD1AE5027A_impl*
 if Assigned(f_OnResize) then
  f_OnResize(Self);
//#UC END# *50FD3279019E_50FD1AE5027A_impl*
end;//TvtCustomPanel.Resize
{$IfEnd} // NOT Defined(Delphi7)

procedure TvtCustomPanel.DrawFrame(const CN: Il3Canvas;
 var Rect: TRect);
//#UC START# *50FD336F020B_50FD1AE5027A_var*
var
 TopColor,
 BottomColor: TColor;
 Canvas: TCanvas;
//#UC END# *50FD336F020B_50FD1AE5027A_var*
begin
//#UC START# *50FD336F020B_50FD1AE5027A_impl*
 Canvas := CN.Canvas;
 if BevelOuter <> bvNone then
 begin
   AdjustColors(BevelOuter, TopColor, BottomColor);
   Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
 end;
 Frame3D(Canvas, Rect, Color, Color, BorderWidth);
 if BevelInner <> bvNone then
 begin
   AdjustColors(BevelInner, TopColor, BottomColor);
   Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
 end;
//#UC END# *50FD336F020B_50FD1AE5027A_impl*
end;//TvtCustomPanel.DrawFrame

procedure TvtCustomPanel.CMTextChanged(var Message: TMessage);
//#UC START# *50FD355100B9_50FD1AE5027A_var*
//#UC END# *50FD355100B9_50FD1AE5027A_var*
begin
//#UC START# *50FD355100B9_50FD1AE5027A_impl*
 Invalidate;
//#UC END# *50FD355100B9_50FD1AE5027A_impl*
end;//TvtCustomPanel.CMTextChanged

procedure TvtCustomPanel.WMSize(var Message: TWMSize);
//#UC START# *50FD356F0225_50FD1AE5027A_var*
var
 l_C: TControl;
//#UC END# *50FD356F0225_50FD1AE5027A_var*
begin
//#UC START# *50FD356F0225_50FD1AE5027A_impl*
 inherited;
 {$IfNDef Delphi7}
 if not (csLoading in ComponentState) then Resize;
 {$EndIf  Delphi7}
 if false
    // http://mdp.garant.ru/pages/viewpage.action?pageId=266410926
    {l3NeedsHackFor64System}
    then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=228692580
 begin
  if not f_In64Hack then
   try
    f_In64Hack := true;
    if (ControlCount = 1) then
    begin
     l_C := Controls[0];
     if (l_C Is TWinControl) then
(*      if (l_C.Align = alClient) then
      begin
       if (l_C.Width <> ClientWidth) then
        SetWindowPos(TWinControl(l_C).Handle, 0,
                     0, 0, ClientWidth, ClientHeight,
                     SWP_FRAMECHANGED + SWP_NOZORDER + SWP_NOACTIVATE)
       else
        SetWindowPos(TWinControl(l_C).Handle, 0,
                     0, 0, ClientWidth - 2, ClientHeight,
                     SWP_FRAMECHANGED + SWP_NOZORDER + SWP_NOACTIVATE);
       TWinControl(l_C).Realign;
      end//l_C.Align = alClient
      else*)
      if (l_C.Align = alNone) then
      begin
       if (l_C Is TCustomForm) then
       begin
        if (Self.Align = alClient) then
        begin
         if (Parent <> nil) then
         begin
          if (Self.Width <> Parent.ClientWidth) then
           SetWindowPos(Self.Handle, 0,
                        0, 0, Parent.ClientWidth, Parent.ClientHeight,
                        SWP_FRAMECHANGED + SWP_NOZORDER + SWP_NOACTIVATE)
          else
           SetWindowPos(Self.Handle, 0,
                        0, 0, Parent.ClientWidth - 2, Parent.ClientHeight,
                        SWP_FRAMECHANGED + SWP_NOZORDER + SWP_NOACTIVATE);
(*          if (TWinControl(l_C).ControlCount = 1) then
          begin
           l_C := TWinControl(l_C).Controls[0];
           if (l_C.Align = alClient) then
            if (l_C Is TWinControl) then
            begin
             if (l_C.Width <> Self.ClientWidth) then
              SetWindowPos(TWinControl(l_C).Handle, 0,
                           0, 0, Self.ClientWidth, Self.ClientHeight,
                           SWP_FRAMECHANGED + SWP_NOZORDER + SWP_NOACTIVATE)
             else
              SetWindowPos(TWinControl(l_C).Handle, 0,
                           0, 0, Self.ClientWidth - 2, Self.ClientHeight,
                           SWP_FRAMECHANGED + SWP_NOZORDER + SWP_NOACTIVATE);
            end;//l_C Is TWinControl
          end;//TWinControl(l_C).ControlCount = 1*)
          //TWinControl(l_C).Realign;
          // - это надо раскомментировать, чтобы скроллеры хоть как-то зажили
          Self.Realign;
         end;//Parent <> nil
        end;//Self.Align = alClient
       end;//l_C Is TCustomForm
       //l_C.Invalidate;
      end;//l_C.Align = alNone
    end;//ControlCount = 1
   finally
    f_In64Hack := false;
   end;//try..finally
 end;//l3NeedsHackFor64System
//#UC END# *50FD356F0225_50FD1AE5027A_impl*
end;//TvtCustomPanel.WMSize

procedure TvtCustomPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
//#UC START# *50FD3584018B_50FD1AE5027A_var*
var
  BevelPixels: Integer;
  Rect: TRect;
//#UC END# *50FD3584018B_50FD1AE5027A_var*
begin
//#UC START# *50FD3584018B_50FD1AE5027A_impl*
  if FullRepaint or l3IsNil(CCaption) then
    Invalidate
  else
  begin
    BevelPixels := BorderWidth;
    if BevelInner <> bvNone then Inc(BevelPixels, BevelWidth);
    if BevelOuter <> bvNone then Inc(BevelPixels, BevelWidth);
    if BevelPixels > 0 then
    begin
      Rect.Right := Width;
      Rect.Bottom := Height;
      if Message.WindowPos^.cx <> Rect.Right then
      begin
        Rect.Top := 0;
        Rect.Left := Rect.Right - BevelPixels - 1;
        Windows.InvalidateRect(Handle, @Rect, True);
      end;
      if Message.WindowPos^.cy <> Rect.Bottom then
      begin
        Rect.Left := 0;
        Rect.Top := Rect.Bottom - BevelPixels - 1;
        Windows.InvalidateRect(Handle, @Rect, True);
      end;
    end;
  end;
  inherited;
  {$If not defined(DesignTimeLibrary)}
  if f_FixW2kWMSize and afw.NeedFixWMSIZE(Self) then
   Resize;
  {$IfEnd} 
//#UC END# *50FD3584018B_50FD1AE5027A_impl*
end;//TvtCustomPanel.WMWindowPosChanged

procedure TvtCustomPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
//#UC START# *50FD3594029E_50FD1AE5027A_var*
//#UC END# *50FD3594029E_50FD1AE5027A_var*
begin
//#UC START# *50FD3594029E_50FD1AE5027A_impl*
 Message.Result := Integer(True);
//#UC END# *50FD3594029E_50FD1AE5027A_impl*
end;//TvtCustomPanel.WMEraseBkgnd

constructor TvtCustomPanel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_50FD1AE5027A_var*
//#UC END# *47D1602000C6_50FD1AE5027A_var*
begin
//#UC START# *47D1602000C6_50FD1AE5027A_impl*
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable];
  { When themes are on in an application default to making
    TCustomPanel's paint with their ParentBackground }
  {$IfDef Delphi7}
  if ThemeServices.ThemesEnabled then
    ControlStyle := ControlStyle + [csParentBackground] - [csOpaque];
  {$EndIf Delphi7}
  Width := 185;
  Height := 41;
  f_Alignment := taCenter;
  BevelOuter := bvRaised;
  BevelWidth := 1;
  BorderStyle := bsNone;
  Color := cDefBack;
  f_FullRepaint := True;
  UseDockManager := True;
//#UC END# *47D1602000C6_50FD1AE5027A_impl*
end;//TvtCustomPanel.Create

procedure TvtCustomPanel.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_50FD1AE5027A_var*
var
  l_Rect: TRect;
  l_FontHeight: Integer;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
//#UC END# *48C6C044025E_50FD1AE5027A_var*
begin
//#UC START# *48C6C044025E_50FD1AE5027A_impl*
 l_Rect := GetClientRect;
 DrawFrame(CN, l_Rect);
 with CN do
 begin
  with Canvas do
  begin
   {$IfDef Delphi7}
   if not ParentBackground or not ThemeServices.ThemesEnabled then
   {$EndIf Delphi7}
   begin
    Brush.Color := Color;
    FillRect(l_Rect);
   end;//not ParentBackground..
   Brush.Style := bsClear;
   BackColor := Color;
   Font := Self.Font;
   l_FontHeight := TextHeight('W');
   with l_Rect do
   begin
    Top := ((Bottom + Top) - l_FontHeight) div 2;
    if Top < 0 then Top := 0;
    Bottom := Top + l_FontHeight;
   end;//with l_Rect
   {$IfDef Delphi7}
   if ParentBackground then
    SetBkMode(Handle, Windows.TRANSPARENT)
   else
   begin
    SetBkColor(Handle, ColorToRGB(BackColor));
    SetBkMode(Handle, Windows.OPAQUE);
   end;//ParentBackground
   {$EndIf Delphi7}
   DrawText(l3PCharLen(CCaption), l_Rect,
            DrawTextBiDiModeFlags((DT_EXPANDTABS or DT_VCENTER) or
                                   Alignments[f_Alignment]));
  end;//with Canvas
 end;//with CN
 l_Rect := GetClientRect;
 DrawFrame(CN, l_Rect);
//#UC END# *48C6C044025E_50FD1AE5027A_impl*
end;//TvtCustomPanel.Paint

{$If NOT Defined(NoVCL)}
procedure TvtCustomPanel.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_50FD1AE5027A_var*
//#UC END# *48C7925A02E5_50FD1AE5027A_var*
begin
//#UC START# *48C7925A02E5_50FD1AE5027A_impl*
 inherited CreateParams(Params);
 with Params do
  WindowClass.Style := WindowClass.Style or CS_HREDRAW or CS_VREDRAW;
//#UC END# *48C7925A02E5_50FD1AE5027A_impl*
end;//TvtCustomPanel.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomPanel.AlignControls(AControl: TControl;
 var Rect: TRect);
//#UC START# *5028E66702B0_50FD1AE5027A_var*
var
  BevelSize: Integer;
//#UC END# *5028E66702B0_50FD1AE5027A_var*
begin
//#UC START# *5028E66702B0_50FD1AE5027A_impl*
  BevelSize := BorderWidth;
  if BevelOuter <> bvNone then Inc(BevelSize, BevelWidth);
  if BevelInner <> bvNone then Inc(BevelSize, BevelWidth);
  InflateRect(Rect, -BevelSize, -BevelSize);
  inherited AlignControls(AControl, Rect);
//#UC END# *5028E66702B0_50FD1AE5027A_impl*
end;//TvtCustomPanel.AlignControls
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomPanel.SetParentBackground(Value: Boolean);
//#UC START# *50FD31EE009B_50FD1AE5027A_var*
//#UC END# *50FD31EE009B_50FD1AE5027A_var*
begin
//#UC START# *50FD31EE009B_50FD1AE5027A_impl*
 {$IfDef Delphi7}
  { TCustomPanel needs to not have csOpaque when painting
    with the ParentBackground in Themed applications }
  if Value then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
  f_ParentBackgroundSet := True;
 {$EndIf Delphi7}
  inherited;
//#UC END# *50FD31EE009B_50FD1AE5027A_impl*
end;//TvtCustomPanel.SetParentBackground
{$IfEnd} // NOT Defined(NoVCL)

//#UC START# *50FD1AE5027Aimpl*
//#UC END# *50FD1AE5027Aimpl*

//#UC START# *4A7961A701CFimpl*
//#UC END# *4A7961A701CFimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomPanelPrim);
 {* Регистрация TvtCustomPanelPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomPanel);
 {* Регистрация TvtCustomPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtPanel);
 {* Регистрация TvtPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
