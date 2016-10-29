unit alcuAutoClassTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoClassTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAutoClassTaskResult" MUID: (53F472280036)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , evdTasksHelpers
 , k2Base
;

type
 TalcuAutoClassTaskResult = class(TcsTaskResult)
  protected
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetMissedDocsStr: AnsiString;
   procedure pm_SetMissedDocsStr(const aValue: AnsiString);
   function pm_GetDocumentIDList: DocumentIDListHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ReportMessage: AnsiString
    read pm_GetReportMessage
    write pm_SetReportMessage;
   property MissedDocsStr: AnsiString
    read pm_GetMissedDocsStr
    write pm_SetMissedDocsStr;
   property DocumentIDList: DocumentIDListHelper
    read pm_GetDocumentIDList;
 end;//TalcuAutoClassTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , AutoClassTaskResult_Const
 //#UC START# *53F472280036impl_uses*
 //#UC END# *53F472280036impl_uses*
;

function TalcuAutoClassTaskResult.pm_GetReportMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportMessage]);
end;//TalcuAutoClassTaskResult.pm_GetReportMessage

procedure TalcuAutoClassTaskResult.pm_SetReportMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReportMessage, nil] := (aValue);
end;//TalcuAutoClassTaskResult.pm_SetReportMessage

function TalcuAutoClassTaskResult.pm_GetMissedDocsStr: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMissedDocsStr]);
end;//TalcuAutoClassTaskResult.pm_GetMissedDocsStr

procedure TalcuAutoClassTaskResult.pm_SetMissedDocsStr(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMissedDocsStr, nil] := (aValue);
end;//TalcuAutoClassTaskResult.pm_SetMissedDocsStr

function TalcuAutoClassTaskResult.pm_GetDocumentIDList: DocumentIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocumentIDListHelper.Make(TaggedData.cAtom(k2_attrDocumentIDList));
end;//TalcuAutoClassTaskResult.pm_GetDocumentIDList

class function TalcuAutoClassTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAutoClassTaskResult;
end;//TalcuAutoClassTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
