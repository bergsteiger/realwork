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
;

function TalcuAutoAnnoExportTaskPrim.pm_GetStartDate: TDateTime;
//#UC START# *BBED2D3CA5F4_53F59F27018Aget_var*
//#UC END# *BBED2D3CA5F4_53F59F27018Aget_var*
begin
//#UC START# *BBED2D3CA5F4_53F59F27018Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *BBED2D3CA5F4_53F59F27018Aget_impl*
end;//TalcuAutoAnnoExportTaskPrim.pm_GetStartDate

procedure TalcuAutoAnnoExportTaskPrim.pm_SetStartDate(aValue: TDateTime);
//#UC START# *BBED2D3CA5F4_53F59F27018Aset_var*
//#UC END# *BBED2D3CA5F4_53F59F27018Aset_var*
begin
//#UC START# *BBED2D3CA5F4_53F59F27018Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *BBED2D3CA5F4_53F59F27018Aset_impl*
end;//TalcuAutoAnnoExportTaskPrim.pm_SetStartDate

function TalcuAutoAnnoExportTaskPrim.pm_GetEndDate: TDateTime;
//#UC START# *24FC392D4AC8_53F59F27018Aget_var*
//#UC END# *24FC392D4AC8_53F59F27018Aget_var*
begin
//#UC START# *24FC392D4AC8_53F59F27018Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *24FC392D4AC8_53F59F27018Aget_impl*
end;//TalcuAutoAnnoExportTaskPrim.pm_GetEndDate

procedure TalcuAutoAnnoExportTaskPrim.pm_SetEndDate(aValue: TDateTime);
//#UC START# *24FC392D4AC8_53F59F27018Aset_var*
//#UC END# *24FC392D4AC8_53F59F27018Aset_var*
begin
//#UC START# *24FC392D4AC8_53F59F27018Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *24FC392D4AC8_53F59F27018Aset_impl*
end;//TalcuAutoAnnoExportTaskPrim.pm_SetEndDate

function TalcuAutoAnnoExportTaskPrim.pm_GetBelongsIDList: BelongsIDListHelper;
//#UC START# *04108A210D43_53F59F27018Aget_var*
//#UC END# *04108A210D43_53F59F27018Aget_var*
begin
//#UC START# *04108A210D43_53F59F27018Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *04108A210D43_53F59F27018Aget_impl*
end;//TalcuAutoAnnoExportTaskPrim.pm_GetBelongsIDList

class function TalcuAutoAnnoExportTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53F59F27018A_var*
//#UC END# *53AC03EE01FD_53F59F27018A_var*
begin
//#UC START# *53AC03EE01FD_53F59F27018A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53F59F27018A_impl*
end;//TalcuAutoAnnoExportTaskPrim.GetTaggedDataType

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

{$IfEnd} // Defined(ServerTasks)
end.
