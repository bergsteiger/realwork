unit NOT_FINISHED_nsIntegration;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Integration\Implementation\NOT_FINISHED_nsIntegration.pas"
// ���������: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsIntegrationModelPart
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
