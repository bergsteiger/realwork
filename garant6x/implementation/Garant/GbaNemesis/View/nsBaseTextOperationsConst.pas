unit nsBaseTextOperationsConst;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsBaseTextOperationsConst.pas"
// ���������: "UtilityPack"
// ������� ������: "nsBaseTextOperationsConst" MUID: (4D8C88C102D9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 //#UC START# *4D8C88C102D9impl_uses*
 //#UC END# *4D8C88C102D9impl_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
