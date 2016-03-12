unit NOT_FINISHED_CsServer;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_CsServer.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
;

type
 TCsServer = class(TCsObject)
 end;//TCsServer
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CsQueryExecutor
;

{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)
end.
