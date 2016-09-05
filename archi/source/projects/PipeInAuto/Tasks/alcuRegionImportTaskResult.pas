unit alcuRegionImportTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuRegionImportTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuRegionImportTaskResult" MUID: (540867800117)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuImportTaskResult
 , k2Base
;

type
 TalcuRegionImportTaskResult = class(TalcuImportTaskResult)
  protected
   function pm_GetHasMoreFilesToProcess: Boolean;
   procedure pm_SetHasMoreFilesToProcess(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property HasMoreFilesToProcess: Boolean
    read pm_GetHasMoreFilesToProcess
    write pm_SetHasMoreFilesToProcess;
 end;//TalcuRegionImportTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , RegionImportTaskResult_Const
 //#UC START# *540867800117impl_uses*
 //#UC END# *540867800117impl_uses*
;

function TalcuRegionImportTaskResult.pm_GetHasMoreFilesToProcess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrHasMoreFilesToProcess]);
end;//TalcuRegionImportTaskResult.pm_GetHasMoreFilesToProcess

procedure TalcuRegionImportTaskResult.pm_SetHasMoreFilesToProcess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrHasMoreFilesToProcess, nil] := (aValue);
end;//TalcuRegionImportTaskResult.pm_SetHasMoreFilesToProcess

class function TalcuRegionImportTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typRegionImportTaskResult;
end;//TalcuRegionImportTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
