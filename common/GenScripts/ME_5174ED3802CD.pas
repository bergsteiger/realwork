unit NOT_FINISHED_ConfigurationListRes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Config\NOT_FINISHED_ConfigurationListRes.pas"
// ���������: "UtilityPack"
// ������� ������: "ConfigurationListRes" MUID: (5174ED3802CD)

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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
