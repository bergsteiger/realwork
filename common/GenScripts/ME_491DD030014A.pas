unit dsSendConsultation;
 {* ������ ������ "������ �� ������������" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsSendConsultation.pas"
// ���������: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsQuery
;

type
 TdsSendConsultation = class(TdsQuery)
  {* ������ ������ "������ �� ������������" }
 end;//TdsSendConsultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
