unit alcuImportTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuImportTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuImportTaskResult" MUID: (53E1D0D00252)

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
 TalcuImportTaskResult = class(TcsTaskResult)
  protected
   function pm_GetMailBody: AnsiString;
   procedure pm_SetMailBody(const aValue: AnsiString);
   function pm_GetImportedDocList: ImportedDocListHelper;
   function pm_GetUserNotification: AnsiString;
   procedure pm_SetUserNotification(const aValue: AnsiString);
   function pm_GetMailSubject: AnsiString;
   procedure pm_SetMailSubject(const aValue: AnsiString);
   function pm_GetEMailSubject: AnsiString;
   procedure pm_SetEMailSubject(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property MailBody: AnsiString
    read pm_GetMailBody
    write pm_SetMailBody;
   property ImportedDocList: ImportedDocListHelper
    read pm_GetImportedDocList;
   property UserNotification: AnsiString
    read pm_GetUserNotification
    write pm_SetUserNotification;
   property MailSubject: AnsiString
    read pm_GetMailSubject
    write pm_SetMailSubject;
   property EMailSubject: AnsiString
    read pm_GetEMailSubject
    write pm_SetEMailSubject;
 end;//TalcuImportTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , ImportTaskResult_Const
 //#UC START# *53E1D0D00252impl_uses*
 //#UC END# *53E1D0D00252impl_uses*
;

function TalcuImportTaskResult.pm_GetMailBody: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailBody]);
end;//TalcuImportTaskResult.pm_GetMailBody

procedure TalcuImportTaskResult.pm_SetMailBody(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMailBody, nil] := (aValue);
end;//TalcuImportTaskResult.pm_SetMailBody

function TalcuImportTaskResult.pm_GetImportedDocList: ImportedDocListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TImportedDocListHelper.Make(TaggedData.cAtom(k2_attrImportedDocList));
end;//TalcuImportTaskResult.pm_GetImportedDocList

function TalcuImportTaskResult.pm_GetUserNotification: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrUserNotification]);
end;//TalcuImportTaskResult.pm_GetUserNotification

procedure TalcuImportTaskResult.pm_SetUserNotification(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrUserNotification, nil] := (aValue);
end;//TalcuImportTaskResult.pm_SetUserNotification

function TalcuImportTaskResult.pm_GetMailSubject: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailSubject]);
end;//TalcuImportTaskResult.pm_GetMailSubject

procedure TalcuImportTaskResult.pm_SetMailSubject(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMailSubject, nil] := (aValue);
end;//TalcuImportTaskResult.pm_SetMailSubject

function TalcuImportTaskResult.pm_GetEMailSubject: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrEMailSubject]);
end;//TalcuImportTaskResult.pm_GetEMailSubject

procedure TalcuImportTaskResult.pm_SetEMailSubject(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrEMailSubject, nil] := (aValue);
end;//TalcuImportTaskResult.pm_SetEMailSubject

class function TalcuImportTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typImportTaskResult;
end;//TalcuImportTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
