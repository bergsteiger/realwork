unit ChromeLikeBaseWindowCaptionButton;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseWindowCaptionButton.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TChromeLikeBaseWindowCaptionButton" MUID: (533D01CB01B1)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , Messages
 , l3Interfaces
;

type
 RChromeLikeWindowCaptionbuttonClass = class of TChromeLikeBaseWindowCaptionButton;

 TChromeLikeWindowCaptionButtonState = (
  cbsDisabled
  , cbsHot
  , cbsNormal
  , cbsPushed
 );//TChromeLikeWindowCaptionButtonState

 TChromeLikeBaseWindowCaptionButton = class(TCustomControl)
  private
   f_State: TChromeLikeWindowCaptionButtonState;
   f_Active: Boolean;
   f_ParentForm: TForm;
   f_OnClick: TNotifyEvent;
  private
   procedure CMMouseEnter(var aMessage: TMessage); message CM_MOUSEENTER;
   procedure CMMouseLeave(var aMessage: TMessage); message CM_MOUSELEAVE;
   procedure WMEraseBkgnd(var aMessage: TWMEraseBkgnd); message WM_ERASEBKGND;
   procedure CMEnabledChanged(var aMessage: TMessage); message CM_ENABLEDCHANGED;
  protected
   function pm_GetState: TChromeLikeWindowCaptionButtonState; virtual;
   procedure pm_SetState(aValue: TChromeLikeWindowCaptionButtonState); virtual;
   function pm_GetActive: Boolean; virtual;
   procedure pm_SetActive(aValue: Boolean); virtual;
   function pm_GetParentForm: TForm; virtual;
   function NeedUpdateHint: Boolean; virtual;
   function GetHintText: Il3CString; virtual;
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Click; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure NotifyFormResized;
   constructor Create(AOwner: TComponent); override;
  protected
   property State: TChromeLikeWindowCaptionButtonState
    read pm_GetState
    write pm_SetState;
   property ParentForm: TForm
    read pm_GetParentForm;
  public
   property Active: Boolean
    read pm_GetActive
    write pm_SetActive;
   property OnClick: TNotifyEvent
    read f_OnClick
    write f_OnClick;
 end;//TChromeLikeBaseWindowCaptionButton
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , Windows
 , UxTheme
 , l3String
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCL)}
function TChromeLikeBaseWindowCaptionButton.pm_GetState: TChromeLikeWindowCaptionButtonState;
//#UC START# *533D0269002B_533D01CB01B1get_var*
//#UC END# *533D0269002B_533D01CB01B1get_var*
begin
//#UC START# *533D0269002B_533D01CB01B1get_impl*
 Result := f_State;
//#UC END# *533D0269002B_533D01CB01B1get_impl*
end;//TChromeLikeBaseWindowCaptionButton.pm_GetState

procedure TChromeLikeBaseWindowCaptionButton.pm_SetState(aValue: TChromeLikeWindowCaptionButtonState);
//#UC START# *533D0269002B_533D01CB01B1set_var*
//#UC END# *533D0269002B_533D01CB01B1set_var*
begin
//#UC START# *533D0269002B_533D01CB01B1set_impl*
 if (aValue <> f_State) then
 begin
  f_State := aValue;
  Invalidate;
 end;
//#UC END# *533D0269002B_533D01CB01B1set_impl*
end;//TChromeLikeBaseWindowCaptionButton.pm_SetState

function TChromeLikeBaseWindowCaptionButton.pm_GetActive: Boolean;
//#UC START# *533D02A3034C_533D01CB01B1get_var*
//#UC END# *533D02A3034C_533D01CB01B1get_var*
begin
//#UC START# *533D02A3034C_533D01CB01B1get_impl*
 Result := f_Active;
//#UC END# *533D02A3034C_533D01CB01B1get_impl*
end;//TChromeLikeBaseWindowCaptionButton.pm_GetActive

procedure TChromeLikeBaseWindowCaptionButton.pm_SetActive(aValue: Boolean);
//#UC START# *533D02A3034C_533D01CB01B1set_var*
//#UC END# *533D02A3034C_533D01CB01B1set_var*
begin
//#UC START# *533D02A3034C_533D01CB01B1set_impl*
 if (aValue <> f_Active) then
 begin
  f_Active := aValue;
  Invalidate;
 end;
//#UC END# *533D02A3034C_533D01CB01B1set_impl*
end;//TChromeLikeBaseWindowCaptionButton.pm_SetActive

function TChromeLikeBaseWindowCaptionButton.pm_GetParentForm: TForm;
//#UC START# *533D035E03BC_533D01CB01B1get_var*
//#UC END# *533D035E03BC_533D01CB01B1get_var*
begin
//#UC START# *533D035E03BC_533D01CB01B1get_impl*
 Result := f_ParentForm;
//#UC END# *533D035E03BC_533D01CB01B1get_impl*
end;//TChromeLikeBaseWindowCaptionButton.pm_GetParentForm

procedure TChromeLikeBaseWindowCaptionButton.NotifyFormResized;
//#UC START# *54744FB502AB_533D01CB01B1_var*
//#UC END# *54744FB502AB_533D01CB01B1_var*
begin
//#UC START# *54744FB502AB_533D01CB01B1_impl*
 if NeedUpdateHint then
  Hint := l3Str(GetHintText);
//#UC END# *54744FB502AB_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.NotifyFormResized

function TChromeLikeBaseWindowCaptionButton.NeedUpdateHint: Boolean;
//#UC START# *54744FED0113_533D01CB01B1_var*
//#UC END# *54744FED0113_533D01CB01B1_var*
begin
//#UC START# *54744FED0113_533D01CB01B1_impl*
 Result := (Hint = '');
//#UC END# *54744FED0113_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.NeedUpdateHint

function TChromeLikeBaseWindowCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D01CB01B1_var*
//#UC END# *5474500600DA_533D01CB01B1_var*
begin
//#UC START# *5474500600DA_533D01CB01B1_impl*
 Result := nil;
//#UC END# *5474500600DA_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.GetHintText

procedure TChromeLikeBaseWindowCaptionButton.CMMouseEnter(var aMessage: TMessage);
//#UC START# *533D037C00E9_533D01CB01B1_var*
//#UC END# *533D037C00E9_533D01CB01B1_var*
begin
//#UC START# *533D037C00E9_533D01CB01B1_impl*
 if Enabled then
  pm_SetState(cbsHot);
//#UC END# *533D037C00E9_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.CMMouseEnter

procedure TChromeLikeBaseWindowCaptionButton.CMMouseLeave(var aMessage: TMessage);
//#UC START# *533D03A40389_533D01CB01B1_var*
//#UC END# *533D03A40389_533D01CB01B1_var*
begin
//#UC START# *533D03A40389_533D01CB01B1_impl*
 if Enabled then
  pm_SetState(cbsNormal);
//#UC END# *533D03A40389_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.CMMouseLeave

procedure TChromeLikeBaseWindowCaptionButton.WMEraseBkgnd(var aMessage: TWMEraseBkgnd);
//#UC START# *533D03BE0299_533D01CB01B1_var*
//#UC END# *533D03BE0299_533D01CB01B1_var*
begin
//#UC START# *533D03BE0299_533D01CB01B1_impl*
 aMessage.Result := 1;
//#UC END# *533D03BE0299_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.WMEraseBkgnd

procedure TChromeLikeBaseWindowCaptionButton.CMEnabledChanged(var aMessage: TMessage);
//#UC START# *533D04A00242_533D01CB01B1_var*

 function lp_GetParentForm: TForm;
 var
  l_Control: TControl;
 begin
  Result := nil;
  l_Control := Parent;
  while (l_Control <> nil) and (not (l_Control is TCustomForm)) do
  begin
   l_Control := l_Control.Parent;
  end;
  if (l_Control is TCustomForm) then
   Result := TForm(l_Control);
 end;//lp_GetParentForm

//#UC END# *533D04A00242_533D01CB01B1_var*
begin
//#UC START# *533D04A00242_533D01CB01B1_impl*
 inherited;
 if not Enabled then
  pm_SetState(cbsDisabled)
 else
  pm_SetState(cbsNormal);
//#UC END# *533D04A00242_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.CMEnabledChanged

constructor TChromeLikeBaseWindowCaptionButton.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_533D01CB01B1_var*
//#UC END# *47D1602000C6_533D01CB01B1_var*
begin
//#UC START# *47D1602000C6_533D01CB01B1_impl*
 inherited;
 f_Active := False;
 f_State := cbsNormal;
//#UC END# *47D1602000C6_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.Create

procedure TChromeLikeBaseWindowCaptionButton.SetParent(AParent: TWinControl);
//#UC START# *4A97E78202FC_533D01CB01B1_var*

 function lp_GetParentForm: TForm;
 var
  l_Control: TControl;
 begin
  Result := nil;
  l_Control := Parent;
  while (l_Control <> nil) and (not (l_Control is TCustomForm)) do
  begin
   l_Control := l_Control.Parent;
  end;
  if (l_Control is TCustomForm) then
   Result := TForm(l_Control);
 end;//lp_GetParentForm

//#UC END# *4A97E78202FC_533D01CB01B1_var*
begin
//#UC START# *4A97E78202FC_533D01CB01B1_impl*
 inherited;
 if (AParent <> nil) then
  f_ParentForm := lp_GetParentForm;
//#UC END# *4A97E78202FC_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.SetParent

procedure TChromeLikeBaseWindowCaptionButton.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_533D01CB01B1_var*
var
 l_State: TChromeLikeWindowCaptionButtonState;
//#UC END# *4E7896270076_533D01CB01B1_var*
begin
//#UC START# *4E7896270076_533D01CB01B1_impl*
 if Enabled then
 begin
  if PtInRect(ClientRect, Point(X, Y)) then
   l_State := cbsHot
  else
   l_State := cbsNormal;
  pm_SetState(l_State);
 end;
 inherited;
//#UC END# *4E7896270076_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.MouseUp

procedure TChromeLikeBaseWindowCaptionButton.Click;
//#UC START# *4F88469E0021_533D01CB01B1_var*
//#UC END# *4F88469E0021_533D01CB01B1_var*
begin
//#UC START# *4F88469E0021_533D01CB01B1_impl*
 if Assigned(f_OnClick) then
  f_OnClick(Self);
//#UC END# *4F88469E0021_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.Click

procedure TChromeLikeBaseWindowCaptionButton.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_533D01CB01B1_var*
//#UC END# *4F88473B03CD_533D01CB01B1_var*
begin
//#UC START# *4F88473B03CD_533D01CB01B1_impl*
 if Enabled then
  pm_SetState(cbsPushed);
 inherited;
//#UC END# *4F88473B03CD_533D01CB01B1_impl*
end;//TChromeLikeBaseWindowCaptionButton.MouseDown

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeBaseWindowCaptionButton);
 {* Регистрация TChromeLikeBaseWindowCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
end.
