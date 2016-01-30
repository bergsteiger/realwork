unit PrimDocNumberQueryOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocNumberQueryOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocNumberQuery_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimDocNumberQueryOptionsForm = class(TPrimDocNumberQueryForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimDocNumberQueryOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimDocNumberQueryOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C863B1E0196_var*
//#UC END# *4C762A1501FC_4C863B1E0196_var*
begin
//#UC START# *4C762A1501FC_4C863B1E0196_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C863B1E0196_impl*
end;//TPrimDocNumberQueryOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDocNumberQueryOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C863B1E0196_var*
//#UC END# *4C762C910358_4C863B1E0196_var*
begin
//#UC START# *4C762C910358_4C863B1E0196_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C863B1E0196_impl*
end;//TPrimDocNumberQueryOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDocNumberQueryOptionsForm);
 {* Регистрация PrimDocNumberQueryOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
