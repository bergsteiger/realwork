unit alcuHavanskyExportTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuHavanskyExportTaskPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuHavanskyExportTaskPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(HavanskyExport) AND defined(ServerTasks)}
uses
  alcuExport,
  k2Base
  ;
{$IfEnd} //HavanskyExport AND ServerTasks

{$If defined(HavanskyExport) AND defined(ServerTasks)}
type
 TalcuHavanskyExportTaskPrim = class(TalcuExport)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TalcuHavanskyExportTaskPrim
{$IfEnd} //HavanskyExport AND ServerTasks

implementation

{$If defined(HavanskyExport) AND defined(ServerTasks)}
uses
  HavanskyExportTask_Const
  ;
{$IfEnd} //HavanskyExport AND ServerTasks

{$If defined(HavanskyExport) AND defined(ServerTasks)}

// start class TalcuHavanskyExportTaskPrim

class function TalcuHavanskyExportTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typHavanskyExportTask;
end;//TalcuHavanskyExportTaskPrim.GetTaggedDataType

{$IfEnd} //HavanskyExport AND ServerTasks

end.