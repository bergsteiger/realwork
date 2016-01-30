unit PrimUserPropertyOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserPropertyOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserProperty_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Admin_Users_Controls
;

type
 TPrimUserPropertyOptionsForm = class(TPrimUserPropertyForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Save; override;
    {* Сохранить }
 end;//TPrimUserPropertyOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimUserPropertyOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C8A0B4500F0_var*
//#UC END# *4C762C910358_4C8A0B4500F0_var*
begin
//#UC START# *4C762C910358_4C8A0B4500F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C8A0B4500F0_impl*
end;//TPrimUserPropertyOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUserPropertyOptionsForm.Save;
 {* Сохранить }
//#UC START# *4C7BB8DD0057_4C8A0B4500F0_var*
//#UC END# *4C7BB8DD0057_4C8A0B4500F0_var*
begin
//#UC START# *4C7BB8DD0057_4C8A0B4500F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BB8DD0057_4C8A0B4500F0_impl*
end;//TPrimUserPropertyOptionsForm.Save

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimUserPropertyOptionsForm);
 {* Регистрация PrimUserPropertyOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
