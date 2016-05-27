unit alcuAACImportTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAACImportTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAACImportTaskResult" MUID: (53EB0E6000D4)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , k2Base
;

type
 TalcuAACImportTaskResult = class(TcsTaskResult)
  protected
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
   function pm_GetAttachFileName: AnsiString;
   procedure pm_SetAttachFileName(const aValue: AnsiString);
   function pm_GetMailBody: AnsiString;
   procedure pm_SetMailBody(const aValue: AnsiString);
   function pm_GetNeedRestart: Boolean;
   procedure pm_SetNeedRestart(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
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
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , AACImportTaskResult_Const
;

function TalcuAACImportTaskResult.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TalcuAACImportTaskResult.pm_GetIsSuccess

procedure TalcuAACImportTaskResult.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TalcuAACImportTaskResult.pm_SetIsSuccess

function TalcuAACImportTaskResult.pm_GetAttachFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrAttachFileName]);
end;//TalcuAACImportTaskResult.pm_GetAttachFileName

procedure TalcuAACImportTaskResult.pm_SetAttachFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrAttachFileName, nil] := (aValue);
end;//TalcuAACImportTaskResult.pm_SetAttachFileName

function TalcuAACImportTaskResult.pm_GetMailBody: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailBody]);
end;//TalcuAACImportTaskResult.pm_GetMailBody

procedure TalcuAACImportTaskResult.pm_SetMailBody(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMailBody, nil] := (aValue);
end;//TalcuAACImportTaskResult.pm_SetMailBody

function TalcuAACImportTaskResult.pm_GetNeedRestart: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedRestart]);
end;//TalcuAACImportTaskResult.pm_GetNeedRestart

procedure TalcuAACImportTaskResult.pm_SetNeedRestart(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrNeedRestart, nil] := (aValue);
end;//TalcuAACImportTaskResult.pm_SetNeedRestart

class function TalcuAACImportTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAACImportTaskResult;
end;//TalcuAACImportTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
