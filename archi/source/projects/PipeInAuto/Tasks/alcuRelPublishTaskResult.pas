unit alcuRelPublishTaskResult;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuRelPublishTaskResult.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuRelPublishTaskResult
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
 TalcuRelPublishTaskResult = class(TcsTaskResult)
 protected
 // property methods
   function pm_GetMailBody: AnsiString;
   procedure pm_SetMailBody(const aValue: AnsiString);
   function pm_GetIsError: Boolean;
   procedure pm_SetIsError(aValue: Boolean);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property MailBody: AnsiString
     read pm_GetMailBody
     write pm_SetMailBody;
   property IsError: Boolean
     read pm_GetIsError
     write pm_SetIsError;
 end;//TalcuRelPublishTaskResult
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  RelPublishTaskResult_Const
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuRelPublishTaskResult

function TalcuRelPublishTaskResult.pm_GetMailBody: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMailBody]);
end;//TalcuRelPublishTaskResult.pm_GetMailBody

procedure TalcuRelPublishTaskResult.pm_SetMailBody(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrMailBody, nil] := (aValue);
end;//TalcuRelPublishTaskResult.pm_SetMailBody

function TalcuRelPublishTaskResult.pm_GetIsError: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsError]);
end;//TalcuRelPublishTaskResult.pm_GetIsError

procedure TalcuRelPublishTaskResult.pm_SetIsError(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrIsError, nil] := (aValue);
end;//TalcuRelPublishTaskResult.pm_SetIsError

class function TalcuRelPublishTaskResult.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typRelPublishTaskResult;
end;//TalcuRelPublishTaskResult.GetTaggedDataType

{$IfEnd} //ServerTasks

end.