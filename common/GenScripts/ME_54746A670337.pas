unit ncsTaskProgress;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTaskProgress.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , csTaskProgress_Const
 , k2Base
;

type
 TncsTaskProgress = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetDescription: AnsiString;
   procedure pm_SetDescription(const aValue: AnsiString);
   function pm_GetPercent: Integer;
   procedure pm_SetPercent(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property Description: AnsiString
    read pm_GetDescription
    write pm_SetDescription;
   property Percent: Integer
    read pm_GetPercent
    write pm_SetPercent;
 end;//TncsTaskProgress
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

function TncsTaskProgress.pm_GetTaskID: AnsiString;
//#UC START# *89A366919E99_54746A670337get_var*
//#UC END# *89A366919E99_54746A670337get_var*
begin
//#UC START# *89A366919E99_54746A670337get_impl*
 !!! Needs to be implemented !!!
//#UC END# *89A366919E99_54746A670337get_impl*
end;//TncsTaskProgress.pm_GetTaskID

procedure TncsTaskProgress.pm_SetTaskID(const aValue: AnsiString);
//#UC START# *89A366919E99_54746A670337set_var*
//#UC END# *89A366919E99_54746A670337set_var*
begin
//#UC START# *89A366919E99_54746A670337set_impl*
 !!! Needs to be implemented !!!
//#UC END# *89A366919E99_54746A670337set_impl*
end;//TncsTaskProgress.pm_SetTaskID

function TncsTaskProgress.pm_GetDescription: AnsiString;
//#UC START# *F6C2147FAA9F_54746A670337get_var*
//#UC END# *F6C2147FAA9F_54746A670337get_var*
begin
//#UC START# *F6C2147FAA9F_54746A670337get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F6C2147FAA9F_54746A670337get_impl*
end;//TncsTaskProgress.pm_GetDescription

procedure TncsTaskProgress.pm_SetDescription(const aValue: AnsiString);
//#UC START# *F6C2147FAA9F_54746A670337set_var*
//#UC END# *F6C2147FAA9F_54746A670337set_var*
begin
//#UC START# *F6C2147FAA9F_54746A670337set_impl*
 !!! Needs to be implemented !!!
//#UC END# *F6C2147FAA9F_54746A670337set_impl*
end;//TncsTaskProgress.pm_SetDescription

function TncsTaskProgress.pm_GetPercent: Integer;
//#UC START# *F50A58BA5D41_54746A670337get_var*
//#UC END# *F50A58BA5D41_54746A670337get_var*
begin
//#UC START# *F50A58BA5D41_54746A670337get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F50A58BA5D41_54746A670337get_impl*
end;//TncsTaskProgress.pm_GetPercent

procedure TncsTaskProgress.pm_SetPercent(aValue: Integer);
//#UC START# *F50A58BA5D41_54746A670337set_var*
//#UC END# *F50A58BA5D41_54746A670337set_var*
begin
//#UC START# *F50A58BA5D41_54746A670337set_impl*
 !!! Needs to be implemented !!!
//#UC END# *F50A58BA5D41_54746A670337set_impl*
end;//TncsTaskProgress.pm_SetPercent

class function TncsTaskProgress.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54746A670337_var*
//#UC END# *53AC03EE01FD_54746A670337_var*
begin
//#UC START# *53AC03EE01FD_54746A670337_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54746A670337_impl*
end;//TncsTaskProgress.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
