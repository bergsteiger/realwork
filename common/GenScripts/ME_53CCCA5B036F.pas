unit NOT_FINISHED_alcuBaseEngine;

// ������: "w:\archi\source\projects\PipeInAuto\Server\NOT_FINISHED_alcuBaseEngine.pas"
// ���������: "SimpleClass"
// ������� ������: "TalcuBaseEngine" MUID: (53CCCA5B036F)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

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
