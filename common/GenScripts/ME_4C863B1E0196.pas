unit PrimDocNumberQueryOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocNumberQueryOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
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
procedure TPrimDocNumberQueryOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_4C863B1E0196exec_var*
//#UC END# *4C762A1501FC_4C863B1E0196exec_var*
begin
//#UC START# *4C762A1501FC_4C863B1E0196exec_impl*
 if Save then
  ModalResult := mrOk;
//#UC END# *4C762A1501FC_4C863B1E0196exec_impl*
end;//TPrimDocNumberQueryOptionsForm.Result_Ok_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDocNumberQueryOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4C762C910358_4C863B1E0196exec_var*
//#UC END# *4C762C910358_4C863B1E0196exec_var*
begin
//#UC START# *4C762C910358_4C863B1E0196exec_impl*
 ModalResult := mrCancel;
//#UC END# *4C762C910358_4C863B1E0196exec_impl*
end;//TPrimDocNumberQueryOptionsForm.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDocNumberQueryOptionsForm);
 {* Регистрация PrimDocNumberQueryOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
