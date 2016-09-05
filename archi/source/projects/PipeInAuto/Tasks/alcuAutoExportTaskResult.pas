unit alcuAutoExportTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoExportTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAutoExportTaskResult" MUID: (54001C560310)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , k2Base
;

type
 TalcuAutoExportTaskResult = class(TcsTaskResult)
  protected
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ReportMessage: AnsiString
    read pm_GetReportMessage
    write pm_SetReportMessage;
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
 end;//TalcuAutoExportTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , AutoExportTaskResult_Const
 //#UC START# *54001C560310impl_uses*
 //#UC END# *54001C560310impl_uses*
;

function TalcuAutoExportTaskResult.pm_GetReportMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportMessage]);
end;//TalcuAutoExportTaskResult.pm_GetReportMessage

procedure TalcuAutoExportTaskResult.pm_SetReportMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReportMessage, nil] := (aValue);
end;//TalcuAutoExportTaskResult.pm_SetReportMessage

function TalcuAutoExportTaskResult.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TalcuAutoExportTaskResult.pm_GetIsSuccess

procedure TalcuAutoExportTaskResult.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TalcuAutoExportTaskResult.pm_SetIsSuccess

class function TalcuAutoExportTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAutoExportTaskResult;
end;//TalcuAutoExportTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
