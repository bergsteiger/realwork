unit NOT_FINISHED_CsQueryExecutor;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_CsQueryExecutor.pas"
// ���������: "SimpleClass"
// ������� ������: "TCsQueryExecutor" MUID: (5395BF930007)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
;

type
 TCsQueryExecutor = class(TCsObject)
 end;//TCsQueryExecutor
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CsReplyProcedures
;

{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)
end.
