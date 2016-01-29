unit alcuAutoClassTaskResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuAutoClassTaskResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAutoClassTaskResult
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
  evdTasksHelpers,
  csTaskResult,
  k2Base
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAutoClassTaskResult = class(TcsTaskResult)
 protected
 // property methods
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetMissedDocsStr: AnsiString;
   procedure pm_SetMissedDocsStr(const aValue: AnsiString);
   function pm_GetDocumentIDList: DocumentIDListHelper;
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property ReportMessage: AnsiString
     read pm_GetReportMessage
     write pm_SetReportMessage;
   property MissedDocsStr: AnsiString
     read pm_GetMissedDocsStr
     write pm_SetMissedDocsStr;
   property DocumentIDList: DocumentIDListHelper
     read pm_GetDocumentIDList;
 end;//TalcuAutoClassTaskResult
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  AutoClassTaskResult_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuAutoClassTaskResult

function TalcuAutoClassTaskResult.pm_GetReportMessage: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportMessage]);
end;//TalcuAutoClassTaskResult.pm_GetReportMessage

procedure TalcuAutoClassTaskResult.pm_SetReportMessage(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrReportMessage, nil] := (aValue);
end;//TalcuAutoClassTaskResult.pm_SetReportMessage

function TalcuAutoClassTaskResult.pm_GetMissedDocsStr: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMissedDocsStr]);
end;//TalcuAutoClassTaskResult.pm_GetMissedDocsStr

procedure TalcuAutoClassTaskResult.pm_SetMissedDocsStr(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrMissedDocsStr, nil] := (aValue);
end;//TalcuAutoClassTaskResult.pm_SetMissedDocsStr

function TalcuAutoClassTaskResult.pm_GetDocumentIDList: DocumentIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocumentIDListHelper.Make(TaggedData.cAtom(k2_attrDocumentIDList));
end;//TalcuAutoClassTaskResult.pm_GetDocumentIDList

class function TalcuAutoClassTaskResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAutoClassTaskResult;
end;//TalcuAutoClassTaskResult.GetTaggedDataType

{$IfEnd} //ServerTasks

end.