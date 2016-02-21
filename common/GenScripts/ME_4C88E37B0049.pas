unit PrimAdminOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimAdminOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimAdmin_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimAdminOptionsForm = class(TPrimAdminForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimAdminOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimAdminOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C88E37B0049_var*
//#UC END# *4C762C910358_4C88E37B0049_var*
begin
//#UC START# *4C762C910358_4C88E37B0049_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C88E37B0049_impl*
end;//TPrimAdminOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAdminOptionsForm.OkExt;
 {* OK }
//#UC START# *4C762D9B0224_4C88E37B0049_var*
//#UC END# *4C762D9B0224_4C88E37B0049_var*
begin
//#UC START# *4C762D9B0224_4C88E37B0049_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762D9B0224_4C88E37B0049_impl*
end;//TPrimAdminOptionsForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAdminOptionsForm);
 {* Регистрация PrimAdminOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
