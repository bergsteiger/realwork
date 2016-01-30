unit NOT_FINISHED_alcuBaseEngine;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\NOT_FINISHED_alcuBaseEngine.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
;

type
 TalcuBaseEngine = class
 end;//TalcuBaseEngine
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppServerSide)

end.
