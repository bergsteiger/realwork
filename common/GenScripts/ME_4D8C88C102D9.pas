unit nsBaseTextOperationsConst;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsBaseTextOperationsConst.pas"
// ���������: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Messages
;

const
 CM_NEED_TO_OPEN_CONTENTS = Messages.WM_USER + 202;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
