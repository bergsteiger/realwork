unit ConsultationMark_Form;
 {* Оценка ответа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\ConsultationMark_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "ConsultationMark" MUID: (4AB8D1DB01FD)
// Имя типа: "Ten_ConsultationMark"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimConsultationMarkOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Ten_ConsultationMark = {final} class(TPrimConsultationMarkOptionsForm, ConsultationMarkFormDef)
  {* Оценка ответа }
   Entities : TvcmEntities;
 end;//Ten_ConsultationMark
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ConsultationMarkKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_en_ConsultationMark.SetFactory(Ten_ConsultationMark.Make);
 {* Регистрация фабрики формы ConsultationMark }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_ConsultationMark);
 {* Регистрация ConsultationMark }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
