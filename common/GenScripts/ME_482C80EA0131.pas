unit AbstractDropDown;

// Модуль: "w:\common\components\gui\Garant\VT\ComboTree\AbstractDropDown.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TAbstractDropDown" MUID: (482C80EA0131)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , ctAbstractEdit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , ctTypes
 , Classes
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , Windows
 , ElUxTheme
;

const
 EL_THEMECHANGED = ElUxTheme.EL_THEMECHANGED;

type
 //#UC START# *482C80EA0131ci*
 //#UC END# *482C80EA0131ci*
 //#UC START# *482C80EA0131cit*
 //#UC END# *482C80EA0131cit*
 TAbstractDropDown = class(TctAbstractEdit{$If NOT Defined(NoVCM)}
 , IvcmPopupIgnoresAction
 {$IfEnd} // NOT Defined(NoVCM)
 , Il3WndProcListener, Il3MouseListener)
  private
   f_ComboStyle: TComboStyle;
    {* Поле для свойства ComboStyle }
   f_ExtButton: TComponent;
    {* Поле для свойства ExtButton }
   f_CurrentMode: TCurrentMode;
    {* Поле для свойства CurrentMode }
   f_Dropped: Boolean;
    {* Поле для свойства Dropped }
   f_OnDropDown: TNotifyEvent;
    {* Поле для свойства OnDropDown }
   f_OnCloseUp: TNotifyEvent;
    {* Поле для свойства OnCloseUp }
  protected
   f_IgnoreFocus: Boolean;
   f_IgnoreDrop: Boolean;
  private
   procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
   procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
   procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
   procedure WMActivateApp(var Message: TWMActivateApp); message WM_ACTIVATEAPP;
   procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
   procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
   procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
  protected
   procedure pm_SetComboStyle(aValue: TComboStyle); virtual;
   function pm_GetStyle: TComboBoxStyle; virtual;
   procedure pm_SetStyle(aValue: TComboBoxStyle); virtual;
   procedure pm_SetDropped(aValue: Boolean); virtual;
   procedure DropDown; virtual;
   procedure ButtonClick(Sender: TObject); virtual;
   procedure TriggerDropCloseEvent(aDropped: Boolean); virtual;
   procedure DoWndProc(var Message: TMessage); virtual;
   function TranslateHomeEndToDropDown: Boolean; virtual;
   procedure EscapePressed; virtual;
   procedure CloseUp; virtual;
   function GetActiveSub: TWinControl; virtual; abstract;
   procedure HideDropDown; virtual;
   {$If NOT Defined(NoVCM)}
   function pm_GetPopupIgnoresAction: Boolean;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure MouseListenerNotify(aMouseMessage: WPARAM;
    aHookStruct: PMouseHookStruct;
    var theResult: Tl3HookProcResult);
   procedure WndProcListenerNotify(Msg: PCWPStruct;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure DestroyWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure DoSelect(aStart: Integer;
    aEnd: Integer);
   procedure DoMoveCursor(aIndex: Integer);
   procedure DoUnselect;
   constructor Create(AOwner: TComponent); override;
  protected
   property ComboStyle: TComboStyle
    read f_ComboStyle
    write pm_SetComboStyle;
  public
   property ExtButton: TComponent
    read f_ExtButton
    write f_ExtButton;
   property Style: TComboBoxStyle
    read pm_GetStyle
    write pm_SetStyle;
   property CurrentMode: TCurrentMode
    read f_CurrentMode
    write f_CurrentMode;
   property Dropped: Boolean
    read f_Dropped
    write pm_SetDropped;
   property OnDropDown: TNotifyEvent
    read f_OnDropDown
    write f_OnDropDown;
   property OnCloseUp: TNotifyEvent
    read f_OnCloseUp
    write f_OnCloseUp;
 //#UC START# *482C80EA0131publ*
    property EmptyHint;
    property EmptyHintColor {default clBackground};
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnDblClick;
 //#UC END# *482C80EA0131publ*
 end;//TAbstractDropDown

implementation

uses
 l3ImplUses
 , l3ListenersManager
 , nevTools
 , ElPopBtn
 , l3Bitmap
 , Graphics
 , ElVclUtils
 , l3Base
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , l3GetCaptureHelper
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TAbstractDropDown.pm_SetComboStyle(aValue: TComboStyle);
//#UC START# *53ECCEC9013B_482C80EA0131set_var*
//#UC END# *53ECCEC9013B_482C80EA0131set_var*
begin
//#UC START# *53ECCEC9013B_482C80EA0131set_impl*
 if (aValue <> f_ComboStyle) then
 begin
  f_ComboStyle := aValue;
  Dropped := False;
 end;//Value <> f_ComboStyle
//#UC END# *53ECCEC9013B_482C80EA0131set_impl*
end;//TAbstractDropDown.pm_SetComboStyle

function TAbstractDropDown.pm_GetStyle: TComboBoxStyle;
//#UC START# *53ECCF9101EF_482C80EA0131get_var*
//#UC END# *53ECCF9101EF_482C80EA0131get_var*
begin
//#UC START# *53ECCF9101EF_482C80EA0131get_impl*
 Result := csSimple;
//#UC END# *53ECCF9101EF_482C80EA0131get_impl*
end;//TAbstractDropDown.pm_GetStyle

procedure TAbstractDropDown.pm_SetStyle(aValue: TComboBoxStyle);
//#UC START# *53ECCF9101EF_482C80EA0131set_var*
//#UC END# *53ECCF9101EF_482C80EA0131set_var*
begin
//#UC START# *53ECCF9101EF_482C80EA0131set_impl*
//#UC END# *53ECCF9101EF_482C80EA0131set_impl*
end;//TAbstractDropDown.pm_SetStyle

procedure TAbstractDropDown.pm_SetDropped(aValue: Boolean);
//#UC START# *53ECD12B0045_482C80EA0131set_var*
//#UC END# *53ECD12B0045_482C80EA0131set_var*
begin
//#UC START# *53ECD12B0045_482C80EA0131set_impl*
 if (aValue <> f_Dropped) then
 begin
  f_Dropped := aValue;
  TElGraphicButton(Button).Down := aValue;
  TriggerDropCloseEvent(aValue);
 end;//Value <> f_Dropped
//#UC END# *53ECD12B0045_482C80EA0131set_impl*
end;//TAbstractDropDown.pm_SetDropped

procedure TAbstractDropDown.DropDown;
//#UC START# *52A9A9B802B4_482C80EA0131_var*
//#UC END# *52A9A9B802B4_482C80EA0131_var*
begin
//#UC START# *52A9A9B802B4_482C80EA0131_impl*
 Tl3ListenersManager.AddWndProcListener(Self);
 if Assigned(f_OnDropDown) then
  f_OnDropDown(Self);
//#UC END# *52A9A9B802B4_482C80EA0131_impl*
end;//TAbstractDropDown.DropDown

procedure TAbstractDropDown.ButtonClick(Sender: TObject);
//#UC START# *53ECD28200BF_482C80EA0131_var*
//#UC END# *53ECD28200BF_482C80EA0131_var*
begin
//#UC START# *53ECD28200BF_482C80EA0131_impl*
 if not (csDesigning in ComponentState) then
 begin
  f_CurrentMode := f_CurrentMode + [cmButtonClick];
  try
   Dropped := not Dropped;
  finally
   f_CurrentMode := f_CurrentMode - [cmButtonClick];
  end;//try..finally
 end;//not (csDesigning in ComponentState)
//#UC END# *53ECD28200BF_482C80EA0131_impl*
end;//TAbstractDropDown.ButtonClick

procedure TAbstractDropDown.TriggerDropCloseEvent(aDropped: Boolean);
//#UC START# *53ECD2A2025F_482C80EA0131_var*
//#UC END# *53ECD2A2025F_482C80EA0131_var*
begin
//#UC START# *53ECD2A2025F_482C80EA0131_impl*
 if aDropped then
  DropDown
 else
  CloseUp;
//#UC END# *53ECD2A2025F_482C80EA0131_impl*
end;//TAbstractDropDown.TriggerDropCloseEvent

procedure TAbstractDropDown.DoWndProc(var Message: TMessage);
//#UC START# *53ECD3A8004B_482C80EA0131_var*
//#UC END# *53ECD3A8004B_482C80EA0131_var*
begin
//#UC START# *53ECD3A8004B_482C80EA0131_impl*
//#UC END# *53ECD3A8004B_482C80EA0131_impl*
end;//TAbstractDropDown.DoWndProc

function TAbstractDropDown.TranslateHomeEndToDropDown: Boolean;
//#UC START# *53ECD4060099_482C80EA0131_var*
//#UC END# *53ECD4060099_482C80EA0131_var*
begin
//#UC START# *53ECD4060099_482C80EA0131_impl*
 Result := True;
//#UC END# *53ECD4060099_482C80EA0131_impl*
end;//TAbstractDropDown.TranslateHomeEndToDropDown

procedure TAbstractDropDown.DoSelect(aStart: Integer;
 aEnd: Integer);
//#UC START# *53ECD42C00FA_482C80EA0131_var*
//#UC END# *53ECD42C00FA_482C80EA0131_var*
begin
//#UC START# *53ECD42C00FA_482C80EA0131_impl*
 CheckDoc;
 Selection.Start.MostInner.PositionW := aStart;
 Selection.Finish.MostInner.PositionW := aEnd;
//#UC END# *53ECD42C00FA_482C80EA0131_impl*
end;//TAbstractDropDown.DoSelect

procedure TAbstractDropDown.DoMoveCursor(aIndex: Integer);
//#UC START# *53ECD44B034E_482C80EA0131_var*
//#UC END# *53ECD44B034E_482C80EA0131_var*
begin
//#UC START# *53ECD44B034E_482C80EA0131_impl*
 CheckDoc;
 Selection.Cursor.MostInner.PositionW := aIndex;
//#UC END# *53ECD44B034E_482C80EA0131_impl*
end;//TAbstractDropDown.DoMoveCursor

procedure TAbstractDropDown.DoUnselect;
//#UC START# *53ECD45F0116_482C80EA0131_var*
//#UC END# *53ECD45F0116_482C80EA0131_var*
begin
//#UC START# *53ECD45F0116_482C80EA0131_impl*
 InevSelection(Selection).Unselect;
//#UC END# *53ECD45F0116_482C80EA0131_impl*
end;//TAbstractDropDown.DoUnselect

procedure TAbstractDropDown.EscapePressed;
//#UC START# *53EDCF6F0223_482C80EA0131_var*
//#UC END# *53EDCF6F0223_482C80EA0131_var*
begin
//#UC START# *53EDCF6F0223_482C80EA0131_impl*
//#UC END# *53EDCF6F0223_482C80EA0131_impl*
end;//TAbstractDropDown.EscapePressed

procedure TAbstractDropDown.CloseUp;
//#UC START# *53EDCF83022E_482C80EA0131_var*
//#UC END# *53EDCF83022E_482C80EA0131_var*
begin
//#UC START# *53EDCF83022E_482C80EA0131_impl*
 if Assigned(f_OnCloseUp) then
  f_OnCloseUp(self);
//#UC END# *53EDCF83022E_482C80EA0131_impl*
end;//TAbstractDropDown.CloseUp

procedure TAbstractDropDown.HideDropDown;
//#UC START# *53EDCFAF00AA_482C80EA0131_var*
//#UC END# *53EDCFAF00AA_482C80EA0131_var*
begin
//#UC START# *53EDCFAF00AA_482C80EA0131_impl*
 Tl3ListenersManager.RemoveWndProcListener(Self);
//#UC END# *53EDCFAF00AA_482C80EA0131_impl*
end;//TAbstractDropDown.HideDropDown

procedure TAbstractDropDown.WMSetFocus(var Message: TWMSetFocus);
//#UC START# *53ECD5090329_482C80EA0131_var*
//#UC END# *53ECD5090329_482C80EA0131_var*
begin
//#UC START# *53ECD5090329_482C80EA0131_impl*
 inherited
//#UC END# *53ECD5090329_482C80EA0131_impl*
end;//TAbstractDropDown.WMSetFocus

procedure TAbstractDropDown.CNKeyDown(var Message: TWMKeyDown);
//#UC START# *53ECD52F02E6_482C80EA0131_var*
//#UC END# *53ECD52F02E6_482C80EA0131_var*
begin
//#UC START# *53ECD52F02E6_482C80EA0131_impl*
 with Message do
 begin
  if f_Dropped and (CharCode = VK_ESCAPE) then
  begin
   f_CurrentMode := f_CurrentMode + [cmEscapePressed];
   try
    EscapePressed;
    if f_Dropped then
    begin
     f_CurrentMode := f_CurrentMode + [cmButtonClick];
     try
      Dropped := False;
     finally
      f_CurrentMode := f_CurrentMode - [cmButtonClick];
     end;//try..finally 
    end;//f_Dropped
   finally
    f_CurrentMode := f_CurrentMode - [cmEscapePressed];
   end;//try..finally
   Message.CharCode := 0;
   Message.Result := 1;
   Exit;
  end;//f_Dropped..
  if (not f_Dropped) and (CharCode = VK_DOWN) then
  begin
   f_CurrentMode := f_CurrentMode + [cmButtonClick];
   try
    Dropped := True;
   finally
    f_CurrentMode := f_CurrentMode - [cmButtonClick];
   end;//try..finally
   Message.CharCode := 0;
   Message.Result := 1;
   Exit;
  end;//not f_Dropped..
  if f_Dropped and
     ((CharCode = VK_UP) or (CharCode = VK_DOWN) or
     (CharCode = VK_PRIOR) or (CharCode = VK_NEXT) or
     (((CharCode = VK_HOME) or (CharCode = VK_END)) and TranslateHomeEndToDropDown)) then
  begin
   // в дереве перешли с обработки WM_KEYDOWN на обработку CN_KEYDOWN.
   // Структура сообщений одинакова
   Message.Msg := CN_KEYDOWN;
   GetActiveSub.WindowProc(TMessage(Message));
   Exit;
  end;//CharCode = VK_UP..
 end;//with Message
 inherited;
//#UC END# *53ECD52F02E6_482C80EA0131_impl*
end;//TAbstractDropDown.CNKeyDown

procedure TAbstractDropDown.WMKillFocus(var Message: TWMKillFocus);
//#UC START# *53ECD5A0033A_482C80EA0131_var*
var
 l_NeedUndrop : Boolean;
 {$If Defined(Nemesis) and Defined(Shell)}
 {$IfNDef NoVGScene}
 l_Control : TControl;
 {$EndIf  NoVGScene}
 {$IfEnd}
//#UC END# *53ECD5A0033A_482C80EA0131_var*
begin
//#UC START# *53ECD5A0033A_482C80EA0131_impl*
 Tl3ListenersManager.RemoveWndProcListener(Self);
 l_NeedUndrop := Tl3GetCaptureHelper.Instance.GetCapture <> f_ExtButton;
 if l_NeedUndrop then
  if (not f_IgnoreDrop) and (not f_IgnoreFocus) then
   Dropped := False;
 inherited;
//#UC END# *53ECD5A0033A_482C80EA0131_impl*
end;//TAbstractDropDown.WMKillFocus

procedure TAbstractDropDown.WMActivateApp(var Message: TWMActivateApp);
//#UC START# *53ECD5B50221_482C80EA0131_var*
//#UC END# *53ECD5B50221_482C80EA0131_var*
begin
//#UC START# *53ECD5B50221_482C80EA0131_impl*
 if (Message.Active = False) then
 begin
  Dropped := False;
  CurrentMode := CurrentMode + [cmAppNotActive];
 end//Message.Active = False
 else
  CurrentMode := CurrentMode - [cmAppNotActive];
 inherited;
//#UC END# *53ECD5B50221_482C80EA0131_impl*
end;//TAbstractDropDown.WMActivateApp

procedure TAbstractDropDown.WMMouseWheel(var Msg: TWMMouseWheel);
//#UC START# *53ECD5C8005C_482C80EA0131_var*
//#UC END# *53ECD5C8005C_482C80EA0131_var*
begin
//#UC START# *53ECD5C8005C_482C80EA0131_impl*
 if f_Dropped then
  GetActiveSub.WindowProc(TMessage(Msg))
 else
  inherited;
//#UC END# *53ECD5C8005C_482C80EA0131_impl*
end;//TAbstractDropDown.WMMouseWheel

procedure TAbstractDropDown.CMEnabledChanged(var Msg: TMessage);
//#UC START# *53ECD5EB03AB_482C80EA0131_var*
//#UC END# *53ECD5EB03AB_482C80EA0131_var*
begin
//#UC START# *53ECD5EB03AB_482C80EA0131_impl*
 inherited;
 Button.Enabled := Enabled;
//#UC END# *53ECD5EB03AB_482C80EA0131_impl*
end;//TAbstractDropDown.CMEnabledChanged

procedure TAbstractDropDown.ELThemeChanged(var Message: TMessage);
//#UC START# *53ECD5FF00FA_482C80EA0131_var*
//#UC END# *53ECD5FF00FA_482C80EA0131_var*
begin
//#UC START# *53ECD5FF00FA_482C80EA0131_impl*
 RecreateWnd;
 Message.Result := 1;
//#UC END# *53ECD5FF00FA_482C80EA0131_impl*
end;//TAbstractDropDown.ELThemeChanged

{$If NOT Defined(NoVCM)}
function TAbstractDropDown.pm_GetPopupIgnoresAction: Boolean;
//#UC START# *476964B602C3_482C80EA0131get_var*
//#UC END# *476964B602C3_482C80EA0131get_var*
begin
//#UC START# *476964B602C3_482C80EA0131get_impl*
 Result := f_ComboStyle = ct_cbEdit;
//#UC END# *476964B602C3_482C80EA0131get_impl*
end;//TAbstractDropDown.pm_GetPopupIgnoresAction
{$IfEnd} // NOT Defined(NoVCM)

procedure TAbstractDropDown.MouseListenerNotify(aMouseMessage: WPARAM;
 aHookStruct: PMouseHookStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CEDF005A_482C80EA0131_var*
var
 l_Pt: TPoint;
 l_Handle: THandle;
//#UC END# *4F79CEDF005A_482C80EA0131_var*
begin
//#UC START# *4F79CEDF005A_482C80EA0131_impl*
 case aMouseMessage of
  WM_LBUTTONDOWN,
  WM_NCLBUTTONDOWN,
  WM_RBUTTONDOWN,
  WM_NCRBUTTONDOWN,
  WM_LBUTTONUP,
  WM_NCLBUTTONUP,
  WM_RBUTTONUP,
  WM_NCRBUTTONUP:
   begin
    l_Pt := aHookStruct^.Pt;
    l_Handle := WindowFromPoint(l_Pt);
    if (l_Handle <> Self.Handle) and (l_Handle <> GetActiveSub.Handle) then
     HideDropDown;
   end;
 end;
//#UC END# *4F79CEDF005A_482C80EA0131_impl*
end;//TAbstractDropDown.MouseListenerNotify

procedure TAbstractDropDown.WndProcListenerNotify(Msg: PCWPStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CF3400BB_482C80EA0131_var*
//#UC END# *4F79CF3400BB_482C80EA0131_var*
begin
//#UC START# *4F79CF3400BB_482C80EA0131_impl*
 if Msg.message = WM_ACTIVATEAPP then
  if not Boolean(Msg.WParam) then
   HideDropDown;
//#UC END# *4F79CF3400BB_482C80EA0131_impl*
end;//TAbstractDropDown.WndProcListenerNotify

procedure TAbstractDropDown.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_482C80EA0131_var*
//#UC END# *479731C50290_482C80EA0131_var*
begin
//#UC START# *479731C50290_482C80EA0131_impl*
 Tl3ListenersManager.RemoveWndProcListener(Self);
 Tl3ListenersManager.RemoveMouseListener(Self);
 inherited;
//#UC END# *479731C50290_482C80EA0131_impl*
end;//TAbstractDropDown.Cleanup

constructor TAbstractDropDown.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_482C80EA0131_var*
var
 lGlyph : Tl3Bitmap;
//#UC END# *47D1602000C6_482C80EA0131_var*
begin
//#UC START# *47D1602000C6_482C80EA0131_impl*
 f_ComboStyle := ct_cbDropDown;
 inherited Create(AOwner);
 //DoubleBuffered := True;
 OnButtonClick := ButtonClick;

 TElGraphicButton(Button).ShowText := False;
 TElGraphicButton(Button).Cursor := crArrow;
 TElGraphicButton(Button).IsSwitch := True;
// TElGraphicButton(Button).OldStyled := True;
 TElGraphicButton(Button).Flat := False;

 lGlyph := Tl3Bitmap.Create;
 try
  lGlyph.Width := 9;
  lGlyph.Height := 5;
  lGlyph.PixelFormat := pf32bit;
  lGlyph.TransparentMode := tmFixed;
  lGlyph.TransparentColor := clWhite;
  lGlyph.Canvas.Brush.Color := clWhite;
  lGlyph.Canvas.FillRect(Rect(0, 0, 9, 5));
  DrawArrow(lGlyph.Canvas, eadDown, Rect(0, 1, 9, 5), clBlack, Enabled);
  TElGraphicButton(Button).Glyph := lGlyph;
 finally
  l3Free(lGlyph);
 end;//try..finally

// TElGraphicButton(Button).UseArrow := True;

 f_CurrentMode := [];
 ControlStyle := ControlStyle - [csClickEvents, csCaptureMouse, csFixedHeight];
 EmptyHintColor := clBackground;

 Tl3ListenersManager.AddMouseListener(Self);
//#UC END# *47D1602000C6_482C80EA0131_impl*
end;//TAbstractDropDown.Create

{$If NOT Defined(NoVCL)}
procedure TAbstractDropDown.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_482C80EA0131_var*
//#UC END# *47E136A80191_482C80EA0131_var*
begin
//#UC START# *47E136A80191_482C80EA0131_impl*
 afw.BeginOp;
 try
  inherited;
  DoWndProc(Message);
 finally
  afw.EndOp;
 end;//try..finally
//#UC END# *47E136A80191_482C80EA0131_impl*
end;//TAbstractDropDown.WndProc
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TAbstractDropDown.DestroyWnd;
//#UC START# *4CC841540158_482C80EA0131_var*
//#UC END# *4CC841540158_482C80EA0131_var*
begin
//#UC START# *4CC841540158_482C80EA0131_impl*
 if f_Dropped then
  Dropped := False;
 inherited;
//#UC END# *4CC841540158_482C80EA0131_impl*
end;//TAbstractDropDown.DestroyWnd
{$IfEnd} // NOT Defined(NoVCL)

//#UC START# *482C80EA0131impl*
//#UC END# *482C80EA0131impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAbstractDropDown);
 {* Регистрация TAbstractDropDown }
{$IfEnd} // NOT Defined(NoScripts)

end.
