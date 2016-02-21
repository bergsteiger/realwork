unit alcuAACImportTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAACImportTaskResult.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , AACImportTaskResult_Const
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
;

function TalcuAACImportTaskResult.pm_GetIsSuccess: Boolean;
//#UC START# *4E05B4ABB248_53EB0E6000D4get_var*
//#UC END# *4E05B4ABB248_53EB0E6000D4get_var*
begin
//#UC START# *4E05B4ABB248_53EB0E6000D4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E05B4ABB248_53EB0E6000D4get_impl*
end;//TalcuAACImportTaskResult.pm_GetIsSuccess

procedure TalcuAACImportTaskResult.pm_SetIsSuccess(aValue: Boolean);
//#UC START# *4E05B4ABB248_53EB0E6000D4set_var*
//#UC END# *4E05B4ABB248_53EB0E6000D4set_var*
begin
//#UC START# *4E05B4ABB248_53EB0E6000D4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E05B4ABB248_53EB0E6000D4set_impl*
end;//TalcuAACImportTaskResult.pm_SetIsSuccess

function TalcuAACImportTaskResult.pm_GetAttachFileName: AnsiString;
//#UC START# *7CBA534353E1_53EB0E6000D4get_var*
//#UC END# *7CBA534353E1_53EB0E6000D4get_var*
begin
//#UC START# *7CBA534353E1_53EB0E6000D4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7CBA534353E1_53EB0E6000D4get_impl*
end;//TalcuAACImportTaskResult.pm_GetAttachFileName

procedure TalcuAACImportTaskResult.pm_SetAttachFileName(const aValue: AnsiString);
//#UC START# *7CBA534353E1_53EB0E6000D4set_var*
//#UC END# *7CBA534353E1_53EB0E6000D4set_var*
begin
//#UC START# *7CBA534353E1_53EB0E6000D4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *7CBA534353E1_53EB0E6000D4set_impl*
end;//TalcuAACImportTaskResult.pm_SetAttachFileName

function TalcuAACImportTaskResult.pm_GetMailBody: AnsiString;
//#UC START# *1BF7695AD611_53EB0E6000D4get_var*
//#UC END# *1BF7695AD611_53EB0E6000D4get_var*
begin
//#UC START# *1BF7695AD611_53EB0E6000D4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1BF7695AD611_53EB0E6000D4get_impl*
end;//TalcuAACImportTaskResult.pm_GetMailBody

procedure TalcuAACImportTaskResult.pm_SetMailBody(const aValue: AnsiString);
//#UC START# *1BF7695AD611_53EB0E6000D4set_var*
//#UC END# *1BF7695AD611_53EB0E6000D4set_var*
begin
//#UC START# *1BF7695AD611_53EB0E6000D4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1BF7695AD611_53EB0E6000D4set_impl*
end;//TalcuAACImportTaskResult.pm_SetMailBody

function TalcuAACImportTaskResult.pm_GetNeedRestart: Boolean;
//#UC START# *4DCA9598791F_53EB0E6000D4get_var*
//#UC END# *4DCA9598791F_53EB0E6000D4get_var*
begin
//#UC START# *4DCA9598791F_53EB0E6000D4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DCA9598791F_53EB0E6000D4get_impl*
end;//TalcuAACImportTaskResult.pm_GetNeedRestart

procedure TalcuAACImportTaskResult.pm_SetNeedRestart(aValue: Boolean);
//#UC START# *4DCA9598791F_53EB0E6000D4set_var*
//#UC END# *4DCA9598791F_53EB0E6000D4set_var*
begin
//#UC START# *4DCA9598791F_53EB0E6000D4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DCA9598791F_53EB0E6000D4set_impl*
end;//TalcuAACImportTaskResult.pm_SetNeedRestart

class function TalcuAACImportTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53EB0E6000D4_var*
//#UC END# *53AC03EE01FD_53EB0E6000D4_var*
begin
//#UC START# *53AC03EE01FD_53EB0E6000D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53EB0E6000D4_impl*
end;//TalcuAACImportTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
