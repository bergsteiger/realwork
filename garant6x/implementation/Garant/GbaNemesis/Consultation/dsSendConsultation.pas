unit dsSendConsultation;
 {* ������ ������ "������ �� ������������" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\dsSendConsultation.pas"
// ���������: "ViewAreaControllerImp"
// ������� ������: "TdsSendConsultation" MUID: (491DD030014A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 //#UC START# *491DD030014Aimpl_uses*
 //#UC END# *491DD030014Aimpl_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
