unit NOT_FINISHED_nsConsultationHAFPainterImages_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\NOT_FINISHED_nsConsultationHAFPainterImages_Form.pas"
// Стереотип: "VCMDataModule"
// Элемент модели: "nsConsultationHAFPainterImages" MUID: (4CF37C170269)
// Имя типа: "TnsConsultationHAFPainterImagesForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
 , nsHAFPainter
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsConsultationHAFPainter = class(TnsHAFPainter)
 end;//TnsConsultationHAFPainter

 TnsConsultationHAFPainterImagesForm = class(TDataModule)
 end;//TnsConsultationHAFPainterImagesForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4CF37C170269impl_uses*
 //#UC END# *4CF37C170269impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsConsultationHAFPainterImagesForm);
 {* Регистрация nsConsultationHAFPainterImages }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
