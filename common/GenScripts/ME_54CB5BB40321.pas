unit alcuTaskListBasePrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskListBasePrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3PureMixIns
;

type
 _l3Changing_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 TalcuTaskListBasePrim = class(_l3Changing_)
 end;//TalcuTaskListBasePrim
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3ImplUses
;

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
