unit alcuRelPublishTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuRelPublishTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuRelPublishTaskResult" MUID: (53E328BF03DF)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , k2Base
;

type
 TalcuRelPublishTaskResult = class(TcsTaskResult)
  protected
   function pm_GetMailBody: AnsiString;
   procedure pm_SetMailBody(const aValue: AnsiString);
   function pm_GetIsError: Boolean;
   procedure pm_SetIsError(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property MailBody: AnsiString
    read pm_GetMailBody
    write pm_SetMailBody;
   property IsError: Boolean
    read pm_GetIsError
    write pm_SetIsError;
 end;//TalcuRelPublishTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , RelPublishTaskResult_Const
;

function TalcuRelPublishTaskResult.pm_GetMailBody: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailBody]);
end;//TalcuRelPublishTaskResult.pm_GetMailBody

procedure TalcuRelPublishTaskResult.pm_SetMailBody(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMailBody, nil] := (aValue);
end;//TalcuRelPublishTaskResult.pm_SetMailBody

function TalcuRelPublishTaskResult.pm_GetIsError: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsError]);
end;//TalcuRelPublishTaskResult.pm_GetIsError

procedure TalcuRelPublishTaskResult.pm_SetIsError(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsError, nil] := (aValue);
end;//TalcuRelPublishTaskResult.pm_SetIsError

class function TalcuRelPublishTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typRelPublishTaskResult;
end;//TalcuRelPublishTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
