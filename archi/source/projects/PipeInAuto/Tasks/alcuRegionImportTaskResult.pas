unit alcuRegionImportTaskResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuRegionImportTaskResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuRegionImportTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  alcuImportTaskResult,
  k2Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuRegionImportTaskResult = class(TalcuImportTaskResult)
 protected
 // property methods
   function pm_GetHasMoreFilesToProcess: Boolean;
   procedure pm_SetHasMoreFilesToProcess(aValue: Boolean);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property HasMoreFilesToProcess: Boolean
     read pm_GetHasMoreFilesToProcess
     write pm_SetHasMoreFilesToProcess;
 end;//TalcuRegionImportTaskResult
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  RegionImportTaskResult_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuRegionImportTaskResult

function TalcuRegionImportTaskResult.pm_GetHasMoreFilesToProcess: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrHasMoreFilesToProcess]);
end;//TalcuRegionImportTaskResult.pm_GetHasMoreFilesToProcess

procedure TalcuRegionImportTaskResult.pm_SetHasMoreFilesToProcess(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrHasMoreFilesToProcess, nil] := (aValue);
end;//TalcuRegionImportTaskResult.pm_SetHasMoreFilesToProcess

class function TalcuRegionImportTaskResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typRegionImportTaskResult;
end;//TalcuRegionImportTaskResult.GetTaggedDataType

{$IfEnd} //ServerTasks

end.