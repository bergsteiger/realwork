unit alcuAutoAnnoExportTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuAutoAnnoExportTaskPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAutoAnnoExportTaskPrim
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
  alcuExport,
  evdTasksHelpers,
  k2Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAutoAnnoExportTaskPrim = class(TalcuExport)
 protected
 // property methods
   function pm_GetStartDate: TDateTime;
   procedure pm_SetStartDate(aValue: TDateTime);
   function pm_GetEndDate: TDateTime;
   procedure pm_SetEndDate(aValue: TDateTime);
   function pm_GetBelongsIDList: BelongsIDListHelper;
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
    {$If not defined(Nemesis)}
   function GetDescription: AnsiString; override;
    {$IfEnd} //not Nemesis
 public
 // public properties
   property StartDate: TDateTime
     read pm_GetStartDate
     write pm_SetStartDate;
   property EndDate: TDateTime
     read pm_GetEndDate
     write pm_SetEndDate;
   property BelongsIDList: BelongsIDListHelper
     read pm_GetBelongsIDList;
 end;//TalcuAutoAnnoExportTaskPrim
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  AutoAnnoExportTask_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuAutoAnnoExportTaskPrim

function TalcuAutoAnnoExportTaskPrim.pm_GetStartDate: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrStartDate]);
end;//TalcuAutoAnnoExportTaskPrim.pm_GetStartDate

procedure TalcuAutoAnnoExportTaskPrim.pm_SetStartDate(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrStartDate, nil] := (aValue);
end;//TalcuAutoAnnoExportTaskPrim.pm_SetStartDate

function TalcuAutoAnnoExportTaskPrim.pm_GetEndDate: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrEndDate]);
end;//TalcuAutoAnnoExportTaskPrim.pm_GetEndDate

procedure TalcuAutoAnnoExportTaskPrim.pm_SetEndDate(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrEndDate, nil] := (aValue);
end;//TalcuAutoAnnoExportTaskPrim.pm_SetEndDate

function TalcuAutoAnnoExportTaskPrim.pm_GetBelongsIDList: BelongsIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TBelongsIDListHelper.Make(TaggedData.cAtom(k2_attrBelongsIDList));
end;//TalcuAutoAnnoExportTaskPrim.pm_GetBelongsIDList

class function TalcuAutoAnnoExportTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAutoAnnoExportTask;
end;//TalcuAutoAnnoExportTaskPrim.GetTaggedDataType

{$If not defined(Nemesis)}
function TalcuAutoAnnoExportTaskPrim.GetDescription: AnsiString;
//#UC START# *53FB28170339_53F59F27018A_var*
//#UC END# *53FB28170339_53F59F27018A_var*
begin
//#UC START# *53FB28170339_53F59F27018A_impl*
 Result := 'Экспорт аннотаций для дельты';
//#UC END# *53FB28170339_53F59F27018A_impl*
end;//TalcuAutoAnnoExportTaskPrim.GetDescription
{$IfEnd} //not Nemesis

{$IfEnd} //ServerTasks

end.