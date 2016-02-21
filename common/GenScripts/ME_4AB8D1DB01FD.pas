unit ConsultationMark_Form;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\ConsultationMark_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimConsultationMarkOptions_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_ConsultationMark = {final} class(TPrimConsultationMarkOptionsForm, ConsultationMarkFormDef)
  {* ������ ������ }
 end;//Ten_ConsultationMark
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ConsultationMarkKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_ConsultationMark);
 {* ����������� ConsultationMark }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_ConsultationMark.SetFactory(Ten_ConsultationMark.Make);
 {* ����������� ������� ����� ConsultationMark }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
