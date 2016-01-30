unit alcuAutoSpellTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoSpellTaskResult.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , AutoSpellTaskResult_Const
 , k2Base
;

type
 TalcuAutoSpellTaskResult = class(TcsTaskResult)
  protected
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetReportAttach: AnsiString;
   procedure pm_SetReportAttach(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ReportMessage: AnsiString
    read pm_GetReportMessage
    write pm_SetReportMessage;
   property ReportAttach: AnsiString
    read pm_GetReportAttach
    write pm_SetReportAttach;
 end;//TalcuAutoSpellTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;

function TalcuAutoSpellTaskResult.pm_GetReportMessage: AnsiString;
//#UC START# *74ED8BF941B6_53FD813101B0get_var*
//#UC END# *74ED8BF941B6_53FD813101B0get_var*
begin
//#UC START# *74ED8BF941B6_53FD813101B0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *74ED8BF941B6_53FD813101B0get_impl*
end;//TalcuAutoSpellTaskResult.pm_GetReportMessage

procedure TalcuAutoSpellTaskResult.pm_SetReportMessage(const aValue: AnsiString);
//#UC START# *74ED8BF941B6_53FD813101B0set_var*
//#UC END# *74ED8BF941B6_53FD813101B0set_var*
begin
//#UC START# *74ED8BF941B6_53FD813101B0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *74ED8BF941B6_53FD813101B0set_impl*
end;//TalcuAutoSpellTaskResult.pm_SetReportMessage

function TalcuAutoSpellTaskResult.pm_GetReportAttach: AnsiString;
//#UC START# *37893D4ECBBB_53FD813101B0get_var*
//#UC END# *37893D4ECBBB_53FD813101B0get_var*
begin
//#UC START# *37893D4ECBBB_53FD813101B0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *37893D4ECBBB_53FD813101B0get_impl*
end;//TalcuAutoSpellTaskResult.pm_GetReportAttach

procedure TalcuAutoSpellTaskResult.pm_SetReportAttach(const aValue: AnsiString);
//#UC START# *37893D4ECBBB_53FD813101B0set_var*
//#UC END# *37893D4ECBBB_53FD813101B0set_var*
begin
//#UC START# *37893D4ECBBB_53FD813101B0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *37893D4ECBBB_53FD813101B0set_impl*
end;//TalcuAutoSpellTaskResult.pm_SetReportAttach

class function TalcuAutoSpellTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53FD813101B0_var*
//#UC END# *53AC03EE01FD_53FD813101B0_var*
begin
//#UC START# *53AC03EE01FD_53FD813101B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53FD813101B0_impl*
end;//TalcuAutoSpellTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
