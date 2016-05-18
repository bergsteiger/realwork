unit InternetAgent_Form;
 {* Новости онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\InternetAgent_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "InternetAgent" MUID: (49EC74D002B8)
// Имя типа: "TInternetAgentForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimInternetAgent_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_InternetAgentForm: TvcmFormDescriptor = (rFormID : (rName : 'InternetAgentForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TInternetAgentForm }

type
 TInternetAgentForm = class;

 InternetAgentFormDef = interface
  {* Идентификатор формы InternetAgent$F }
  ['{4953CF3C-7760-41BE-BBC7-7CA06BAE484D}']
 end;//InternetAgentFormDef

 TInternetAgentForm = {final} class(TPrimInternetAgentForm, InternetAgentFormDef)
  {* Новости онлайн }
 end;//TInternetAgentForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , InternetAgentKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TInternetAgentForm);
 {* Регистрация InternetAgent$F }
{$IfEnd} // NOT Defined(NoScripts)
 fm_InternetAgentForm.SetFactory(TInternetAgentForm.Make);
 {* Регистрация фабрики формы InternetAgent$F }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
