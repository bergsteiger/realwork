unit alcuAutoExportTaskResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuAutoExportTaskResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAutoExportTaskResult
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
  csTaskResult,
  k2Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAutoExportTaskResult = class(TcsTaskResult)
 protected
 // property methods
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property ReportMessage: AnsiString
     read pm_GetReportMessage
     write pm_SetReportMessage;
   property IsSuccess: Boolean
     read pm_GetIsSuccess
     write pm_SetIsSuccess;
 end;//TalcuAutoExportTaskResult
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  AutoExportTaskResult_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuAutoExportTaskResult

function TalcuAutoExportTaskResult.pm_GetReportMessage: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportMessage]);
end;//TalcuAutoExportTaskResult.pm_GetReportMessage

procedure TalcuAutoExportTaskResult.pm_SetReportMessage(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrReportMessage, nil] := (aValue);
end;//TalcuAutoExportTaskResult.pm_SetReportMessage

function TalcuAutoExportTaskResult.pm_GetIsSuccess: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TalcuAutoExportTaskResult.pm_GetIsSuccess

procedure TalcuAutoExportTaskResult.pm_SetIsSuccess(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TalcuAutoExportTaskResult.pm_SetIsSuccess

class function TalcuAutoExportTaskResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAutoExportTaskResult;
end;//TalcuAutoExportTaskResult.GetTaggedDataType

{$IfEnd} //ServerTasks

end.