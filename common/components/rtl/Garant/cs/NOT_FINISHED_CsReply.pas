unit NOT_FINISHED_CsReply;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_CsReply.pas"
// ���������: "SimpleClass"
// ������� ������: "TCsReply" MUID: (538DEBDF0374)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TCsReply = class
 end;//TCsReply
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CsReplyTool
 //#UC START# *538DEBDF0374impl_uses*
 //#UC END# *538DEBDF0374impl_uses*
;
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
