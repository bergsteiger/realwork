unit alcuImmidiateRequestInterfaces;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\alcuImmidiateRequestInterfaces.pas"
// ���������: "Interfaces"
// ������� ������: "alcuImmidiateRequestInterfaces" MUID: (57C810400018)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
;

type
 TalcuSpeedupRequestProc = procedure of object;
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(ServerTasks)

end.
