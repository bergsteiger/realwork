unit alcuTaskListBasePrim;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskListBasePrim.pas"
// ���������: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3PureMixIns
;

type
 _l3Changing_Parent_ = Tl3ProtoObject;
 {$Include l3Changing.imp.pas}
 TalcuTaskListBasePrim = class(_l3Changing_)
 end;//TalcuTaskListBasePrim
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3ImplUses
;

{$Include l3Changing.imp.pas}
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
