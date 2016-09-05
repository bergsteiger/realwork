unit alcuAutoSpellTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoSpellTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAutoSpellTaskResult" MUID: (53FD813101B0)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , k2Base
;

type
 TalcuAutoSpellTaskResult = class(TcsTaskResult)
  protected
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetReportAttach: AnsiString;
   procedure pm_SetReportAttach(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ReportMessage: AnsiString
    read pm_GetReportMessage
    write pm_SetReportMessage;
   property ReportAttach: AnsiString
    read pm_GetReportAttach
    write pm_SetReportAttach;
 end;//TalcuAutoSpellTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , AutoSpellTaskResult_Const
 //#UC START# *53FD813101B0impl_uses*
 //#UC END# *53FD813101B0impl_uses*
;

function TalcuAutoSpellTaskResult.pm_GetReportMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportMessage]);
end;//TalcuAutoSpellTaskResult.pm_GetReportMessage

procedure TalcuAutoSpellTaskResult.pm_SetReportMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReportMessage, nil] := (aValue);
end;//TalcuAutoSpellTaskResult.pm_SetReportMessage

function TalcuAutoSpellTaskResult.pm_GetReportAttach: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportAttach]);
end;//TalcuAutoSpellTaskResult.pm_GetReportAttach

procedure TalcuAutoSpellTaskResult.pm_SetReportAttach(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReportAttach, nil] := (aValue);
end;//TalcuAutoSpellTaskResult.pm_SetReportAttach

class function TalcuAutoSpellTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAutoSpellTaskResult;
end;//TalcuAutoSpellTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
