unit alcuAACImportTaskResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuAACImportTaskResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAACImportTaskResult
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
 TalcuAACImportTaskResult = class(TcsTaskResult)
 protected
 // property methods
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
   function pm_GetAttachFileName: AnsiString;
   procedure pm_SetAttachFileName(const aValue: AnsiString);
   function pm_GetMailBody: AnsiString;
   procedure pm_SetMailBody(const aValue: AnsiString);
   function pm_GetNeedRestart: Boolean;
   procedure pm_SetNeedRestart(aValue: Boolean);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property IsSuccess: Boolean
     read pm_GetIsSuccess
     write pm_SetIsSuccess;
   property AttachFileName: AnsiString
     read pm_GetAttachFileName
     write pm_SetAttachFileName;
   property MailBody: AnsiString
     read pm_GetMailBody
     write pm_SetMailBody;
   property NeedRestart: Boolean
     read pm_GetNeedRestart
     write pm_SetNeedRestart;
 end;//TalcuAACImportTaskResult
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  AACImportTaskResult_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuAACImportTaskResult

function TalcuAACImportTaskResult.pm_GetIsSuccess: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TalcuAACImportTaskResult.pm_GetIsSuccess

procedure TalcuAACImportTaskResult.pm_SetIsSuccess(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TalcuAACImportTaskResult.pm_SetIsSuccess

function TalcuAACImportTaskResult.pm_GetAttachFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrAttachFileName]);
end;//TalcuAACImportTaskResult.pm_GetAttachFileName

procedure TalcuAACImportTaskResult.pm_SetAttachFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrAttachFileName, nil] := (aValue);
end;//TalcuAACImportTaskResult.pm_SetAttachFileName

function TalcuAACImportTaskResult.pm_GetMailBody: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailBody]);
end;//TalcuAACImportTaskResult.pm_GetMailBody

procedure TalcuAACImportTaskResult.pm_SetMailBody(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrMailBody, nil] := (aValue);
end;//TalcuAACImportTaskResult.pm_SetMailBody

function TalcuAACImportTaskResult.pm_GetNeedRestart: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedRestart]);
end;//TalcuAACImportTaskResult.pm_GetNeedRestart

procedure TalcuAACImportTaskResult.pm_SetNeedRestart(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrNeedRestart, nil] := (aValue);
end;//TalcuAACImportTaskResult.pm_SetNeedRestart

class function TalcuAACImportTaskResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAACImportTaskResult;
end;//TalcuAACImportTaskResult.GetTaggedDataType

{$IfEnd} //ServerTasks

end.