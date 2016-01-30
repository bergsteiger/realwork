unit NOT_FINISHED_CsReply;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_CsReply.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

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
;
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
