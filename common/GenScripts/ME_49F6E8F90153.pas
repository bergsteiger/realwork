unit moInternetAgent;
 {* ��������-����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\moInternetAgent.pas"
// ���������: "VCMUseCaseRealization"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimInternetAgent_Module
;

type
 Tmo_InternetAgent = {final} class(TPrimInternetAgentModule)
  {* ��������-����� }
 end;//Tmo_InternetAgent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
