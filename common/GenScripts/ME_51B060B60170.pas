unit NOT_FINISHED_nsExternalObjectData;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Common\NOT_FINISHED_nsExternalObjectData.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TnsExternalObjectData = class
 end;//TnsExternalObjectData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
