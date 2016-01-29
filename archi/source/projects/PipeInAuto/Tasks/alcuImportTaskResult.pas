unit alcuImportTaskResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuImportTaskResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuImportTaskResult
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
 TalcuImportTaskResult = class(TcsTaskResult)
 protected
 // property methods
   function pm_GetMailBody: AnsiString;
   procedure pm_SetMailBody(const aValue: AnsiString);
   function pm_GetImportedDocList: ImportedDocListHelper;
   function pm_GetUserNotification: AnsiString;
   procedure pm_SetUserNotification(const aValue: AnsiString);
   function pm_GetMailSubject: AnsiString;
   procedure pm_SetMailSubject(const aValue: AnsiString);
   function pm_GetEMailSubject: AnsiString;
   procedure pm_SetEMailSubject(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
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
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  ImportTaskResult_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuImportTaskResult

function TalcuImportTaskResult.pm_GetMailBody: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailBody]);
end;//TalcuImportTaskResult.pm_GetMailBody

procedure TalcuImportTaskResult.pm_SetMailBody(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrMailBody, nil] := (aValue);
end;//TalcuImportTaskResult.pm_SetMailBody

function TalcuImportTaskResult.pm_GetImportedDocList: ImportedDocListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TImportedDocListHelper.Make(TaggedData.cAtom(k2_attrImportedDocList));
end;//TalcuImportTaskResult.pm_GetImportedDocList

function TalcuImportTaskResult.pm_GetUserNotification: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrUserNotification]);
end;//TalcuImportTaskResult.pm_GetUserNotification

procedure TalcuImportTaskResult.pm_SetUserNotification(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrUserNotification, nil] := (aValue);
end;//TalcuImportTaskResult.pm_SetUserNotification

function TalcuImportTaskResult.pm_GetMailSubject: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailSubject]);
end;//TalcuImportTaskResult.pm_GetMailSubject

procedure TalcuImportTaskResult.pm_SetMailSubject(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrMailSubject, nil] := (aValue);
end;//TalcuImportTaskResult.pm_SetMailSubject

function TalcuImportTaskResult.pm_GetEMailSubject: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrEMailSubject]);
end;//TalcuImportTaskResult.pm_GetEMailSubject

procedure TalcuImportTaskResult.pm_SetEMailSubject(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrEMailSubject, nil] := (aValue);
end;//TalcuImportTaskResult.pm_SetEMailSubject

class function TalcuImportTaskResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typImportTaskResult;
end;//TalcuImportTaskResult.GetTaggedDataType

{$IfEnd} //ServerTasks

end.