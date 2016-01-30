unit alcuRelPublishTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuRelPublishTaskResult.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , RelPublishTaskResult_Const
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
;

function TalcuRelPublishTaskResult.pm_GetMailBody: AnsiString;
//#UC START# *50F069887B07_53E328BF03DFget_var*
//#UC END# *50F069887B07_53E328BF03DFget_var*
begin
//#UC START# *50F069887B07_53E328BF03DFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *50F069887B07_53E328BF03DFget_impl*
end;//TalcuRelPublishTaskResult.pm_GetMailBody

procedure TalcuRelPublishTaskResult.pm_SetMailBody(const aValue: AnsiString);
//#UC START# *50F069887B07_53E328BF03DFset_var*
//#UC END# *50F069887B07_53E328BF03DFset_var*
begin
//#UC START# *50F069887B07_53E328BF03DFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *50F069887B07_53E328BF03DFset_impl*
end;//TalcuRelPublishTaskResult.pm_SetMailBody

function TalcuRelPublishTaskResult.pm_GetIsError: Boolean;
//#UC START# *7A0D5E0B03BA_53E328BF03DFget_var*
//#UC END# *7A0D5E0B03BA_53E328BF03DFget_var*
begin
//#UC START# *7A0D5E0B03BA_53E328BF03DFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A0D5E0B03BA_53E328BF03DFget_impl*
end;//TalcuRelPublishTaskResult.pm_GetIsError

procedure TalcuRelPublishTaskResult.pm_SetIsError(aValue: Boolean);
//#UC START# *7A0D5E0B03BA_53E328BF03DFset_var*
//#UC END# *7A0D5E0B03BA_53E328BF03DFset_var*
begin
//#UC START# *7A0D5E0B03BA_53E328BF03DFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A0D5E0B03BA_53E328BF03DFset_impl*
end;//TalcuRelPublishTaskResult.pm_SetIsError

class function TalcuRelPublishTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53E328BF03DF_var*
//#UC END# *53AC03EE01FD_53E328BF03DF_var*
begin
//#UC START# *53AC03EE01FD_53E328BF03DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53E328BF03DF_impl*
end;//TalcuRelPublishTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
