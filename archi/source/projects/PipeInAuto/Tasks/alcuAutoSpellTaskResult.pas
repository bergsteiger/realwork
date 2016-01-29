unit alcuAutoSpellTaskResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuAutoSpellTaskResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAutoSpellTaskResult
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
 TalcuAutoSpellTaskResult = class(TcsTaskResult)
 protected
 // property methods
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetReportAttach: AnsiString;
   procedure pm_SetReportAttach(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property ReportMessage: AnsiString
     read pm_GetReportMessage
     write pm_SetReportMessage;
   property ReportAttach: AnsiString
     read pm_GetReportAttach
     write pm_SetReportAttach;
 end;//TalcuAutoSpellTaskResult
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  AutoSpellTaskResult_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuAutoSpellTaskResult

function TalcuAutoSpellTaskResult.pm_GetReportMessage: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportMessage]);
end;//TalcuAutoSpellTaskResult.pm_GetReportMessage

procedure TalcuAutoSpellTaskResult.pm_SetReportMessage(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrReportMessage, nil] := (aValue);
end;//TalcuAutoSpellTaskResult.pm_SetReportMessage

function TalcuAutoSpellTaskResult.pm_GetReportAttach: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportAttach]);
end;//TalcuAutoSpellTaskResult.pm_GetReportAttach

procedure TalcuAutoSpellTaskResult.pm_SetReportAttach(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrReportAttach, nil] := (aValue);
end;//TalcuAutoSpellTaskResult.pm_SetReportAttach

class function TalcuAutoSpellTaskResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAutoSpellTaskResult;
end;//TalcuAutoSpellTaskResult.GetTaggedDataType

{$IfEnd} //ServerTasks

end.