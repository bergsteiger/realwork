unit vtVGButton;

// Модуль: "w:\common\components\gui\Garant\VT\vtVGButton.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vg_controls
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
;

type
 TvtVGButton = class(TvgButton)
  private
   f_DuplicateButton: TButton;
  private
   procedure UpdateDuplicateButton;
  protected
   procedure SetText(const Value: WideString); override;
   procedure pm_SetModalResult(aValue: TModalResult); override;
   procedure pm_SetOnClick(aValue: TNotifyEvent); override;
   procedure pm_SetDefault(aValue: Boolean); override;
   procedure pm_SetCancel(aValue: Boolean); override;
  public
   constructor Create(AOwner: TComponent); override;
 end;//TvtVGButton
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvtVGButton.UpdateDuplicateButton;
//#UC START# *4D5E5A63025B_4D494D3601A8_var*
//#UC END# *4D5E5A63025B_4D494D3601A8_var*
begin
//#UC START# *4D5E5A63025B_4D494D3601A8_impl*
 if csDesigning in ComponentState then
  Exit;

 if (Self.Owner is TWinControl) then
 begin
  if f_DuplicateButton = nil then
   f_DuplicateButton := TButton.Create(Self);

  with f_DuplicateButton do
  begin
   Parent := TWinControl(Self.Owner);
   Width := 0;  // VK. Кнопка-дубликат должна быть невидимой, но доступной
   TabStop := true;
   Cancel := Self.Cancel;
   Default := Self.Default;
   ModalResult := Self.ModalResult;
   Caption := Self.Text;
   OnClick := Self.OnClick;
  end;
 end;
//#UC END# *4D5E5A63025B_4D494D3601A8_impl*
end;//TvtVGButton.UpdateDuplicateButton

constructor TvtVGButton.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4D494D3601A8_var*
//#UC END# *47D1602000C6_4D494D3601A8_var*
begin
//#UC START# *47D1602000C6_4D494D3601A8_impl*
 inherited;
 f_DuplicateButton := nil;
//#UC END# *47D1602000C6_4D494D3601A8_impl*
end;//TvtVGButton.Create

procedure TvtVGButton.SetText(const Value: WideString);
//#UC START# *4D5E5ACA029B_4D494D3601A8_var*
//#UC END# *4D5E5ACA029B_4D494D3601A8_var*
begin
//#UC START# *4D5E5ACA029B_4D494D3601A8_impl*
 inherited;
 UpdateDuplicateButton;
//#UC END# *4D5E5ACA029B_4D494D3601A8_impl*
end;//TvtVGButton.SetText

procedure TvtVGButton.pm_SetModalResult(aValue: TModalResult);
//#UC START# *4D5E5B530342_4D494D3601A8set_var*
//#UC END# *4D5E5B530342_4D494D3601A8set_var*
begin
//#UC START# *4D5E5B530342_4D494D3601A8set_impl*
 inherited;
 UpdateDuplicateButton;
//#UC END# *4D5E5B530342_4D494D3601A8set_impl*
end;//TvtVGButton.pm_SetModalResult

procedure TvtVGButton.pm_SetOnClick(aValue: TNotifyEvent);
//#UC START# *4D5E5BB000A5_4D494D3601A8set_var*
//#UC END# *4D5E5BB000A5_4D494D3601A8set_var*
begin
//#UC START# *4D5E5BB000A5_4D494D3601A8set_impl*
 inherited;
 UpdateDuplicateButton;
//#UC END# *4D5E5BB000A5_4D494D3601A8set_impl*
end;//TvtVGButton.pm_SetOnClick

procedure TvtVGButton.pm_SetDefault(aValue: Boolean);
//#UC START# *4D5E5C0A01E6_4D494D3601A8set_var*
//#UC END# *4D5E5C0A01E6_4D494D3601A8set_var*
begin
//#UC START# *4D5E5C0A01E6_4D494D3601A8set_impl*
 inherited;
 UpdateDuplicateButton;
//#UC END# *4D5E5C0A01E6_4D494D3601A8set_impl*
end;//TvtVGButton.pm_SetDefault

procedure TvtVGButton.pm_SetCancel(aValue: Boolean);
//#UC START# *4D5E5C27000E_4D494D3601A8set_var*
//#UC END# *4D5E5C27000E_4D494D3601A8set_var*
begin
//#UC START# *4D5E5C27000E_4D494D3601A8set_impl*
 inherited;
 UpdateDuplicateButton;
//#UC END# *4D5E5C27000E_4D494D3601A8set_impl*
end;//TvtVGButton.pm_SetCancel

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtVGButton);
 {* Регистрация TvtVGButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
