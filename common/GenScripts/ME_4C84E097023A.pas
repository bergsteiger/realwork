unit PrimConsultationMarkOptions_Form;
 {* Оценка ответа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMarkOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimConsultationMark_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimConsultationMarkOptionsForm = class(TPrimConsultationMarkForm)
  {* Оценка ответа }
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimConsultationMarkOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ConsultingUnit
 , DataAdapter
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C84E097023A_var*
//#UC END# *4C762A1501FC_4C84E097023A_var*
begin
//#UC START# *4C762A1501FC_4C84E097023A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C84E097023A_impl*
end;//TPrimConsultationMarkOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4C84E097023A_var*
//#UC END# *4C762AB601E1_4C84E097023A_var*
begin
//#UC START# *4C762AB601E1_4C84E097023A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4C84E097023A_impl*
end;//TPrimConsultationMarkOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimConsultationMarkOptionsForm);
 {* Регистрация PrimConsultationMarkOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
