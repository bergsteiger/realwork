unit NOT_FINISHED_nsConsultationHAFPainterImages_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\NOT_FINISHED_nsConsultationHAFPainterImages_Form.pas"
// Стереотип: "VCMDataModule"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
 , nsHAFPainter
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
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsConsultationHAFPainterImagesForm);
 {* Регистрация nsConsultationHAFPainterImages }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
