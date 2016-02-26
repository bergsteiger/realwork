unit NOT_FINISHED_alcuStrings;
 {* Ресурс строковых констант }

// Модуль: "w:\archi\source\projects\PipeInAuto\Core\NOT_FINISHED_alcuStrings.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
;

type
 TalcuStrings = class
  {* Ресурс строковых констант }
 end;//TalcuStrings
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppServerSide)

end.
