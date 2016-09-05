unit alcuHavanskyExportTaskPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuHavanskyExportTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuHavanskyExportTaskPrim" MUID: (53DF6A58036D)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(HavanskyExport)}
uses
 l3IntfUses
 , alcuExport
 , k2Base
;

type
 TalcuHavanskyExportTaskPrim = class(TalcuExport)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TalcuHavanskyExportTaskPrim
{$IfEnd} // Defined(ServerTasks) AND Defined(HavanskyExport)

implementation

{$If Defined(ServerTasks) AND Defined(HavanskyExport)}
uses
 l3ImplUses
 , HavanskyExportTask_Const
 //#UC START# *53DF6A58036Dimpl_uses*
 //#UC END# *53DF6A58036Dimpl_uses*
;

class function TalcuHavanskyExportTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typHavanskyExportTask;
end;//TalcuHavanskyExportTaskPrim.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks) AND Defined(HavanskyExport)

end.
