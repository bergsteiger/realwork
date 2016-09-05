unit alcuAutoAnnoExportTaskPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoAnnoExportTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAutoAnnoExportTaskPrim" MUID: (53F59F27018A)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExport
 , evdTasksHelpers
 , k2Base
;

type
 TalcuAutoAnnoExportTaskPrim = class(TalcuExport)
  protected
   function pm_GetStartDate: TDateTime;
   procedure pm_SetStartDate(aValue: TDateTime);
   function pm_GetEndDate: TDateTime;
   procedure pm_SetEndDate(aValue: TDateTime);
   function pm_GetBelongsIDList: BelongsIDListHelper;
   {$If NOT Defined(Nemesis)}
   function GetDescription: AnsiString; override;
   {$IfEnd} // NOT Defined(Nemesis)
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property StartDate: TDateTime
    read pm_GetStartDate
    write pm_SetStartDate;
   property EndDate: TDateTime
    read pm_GetEndDate
    write pm_SetEndDate;
   property BelongsIDList: BelongsIDListHelper
    read pm_GetBelongsIDList;
 end;//TalcuAutoAnnoExportTaskPrim
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , AutoAnnoExportTask_Const
 //#UC START# *53F59F27018Aimpl_uses*
 //#UC END# *53F59F27018Aimpl_uses*
;

function TalcuAutoAnnoExportTaskPrim.pm_GetStartDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrStartDate]);
end;//TalcuAutoAnnoExportTaskPrim.pm_GetStartDate

procedure TalcuAutoAnnoExportTaskPrim.pm_SetStartDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrStartDate, nil] := (aValue);
end;//TalcuAutoAnnoExportTaskPrim.pm_SetStartDate

function TalcuAutoAnnoExportTaskPrim.pm_GetEndDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrEndDate]);
end;//TalcuAutoAnnoExportTaskPrim.pm_GetEndDate

procedure TalcuAutoAnnoExportTaskPrim.pm_SetEndDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrEndDate, nil] := (aValue);
end;//TalcuAutoAnnoExportTaskPrim.pm_SetEndDate

function TalcuAutoAnnoExportTaskPrim.pm_GetBelongsIDList: BelongsIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TBelongsIDListHelper.Make(TaggedData.cAtom(k2_attrBelongsIDList));
end;//TalcuAutoAnnoExportTaskPrim.pm_GetBelongsIDList

{$If NOT Defined(Nemesis)}
function TalcuAutoAnnoExportTaskPrim.GetDescription: AnsiString;
//#UC START# *53FB28170339_53F59F27018A_var*
//#UC END# *53FB28170339_53F59F27018A_var*
begin
//#UC START# *53FB28170339_53F59F27018A_impl*
 Result := 'Экспорт аннотаций для дельты';
//#UC END# *53FB28170339_53F59F27018A_impl*
end;//TalcuAutoAnnoExportTaskPrim.GetDescription
{$IfEnd} // NOT Defined(Nemesis)

class function TalcuAutoAnnoExportTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAutoAnnoExportTask;
end;//TalcuAutoAnnoExportTaskPrim.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
