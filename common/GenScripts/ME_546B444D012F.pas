unit ncsGetTaskDescription;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetTaskDescription.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , csGetTaskDescription_Const
 , k2Base
;

type
 TncsGetTaskDescription = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
 end;//TncsGetTaskDescription
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

function TncsGetTaskDescription.pm_GetTaskID: AnsiString;
//#UC START# *7579AB0F9F12_546B444D012Fget_var*
//#UC END# *7579AB0F9F12_546B444D012Fget_var*
begin
//#UC START# *7579AB0F9F12_546B444D012Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *7579AB0F9F12_546B444D012Fget_impl*
end;//TncsGetTaskDescription.pm_GetTaskID

procedure TncsGetTaskDescription.pm_SetTaskID(const aValue: AnsiString);
//#UC START# *7579AB0F9F12_546B444D012Fset_var*
//#UC END# *7579AB0F9F12_546B444D012Fset_var*
begin
//#UC START# *7579AB0F9F12_546B444D012Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *7579AB0F9F12_546B444D012Fset_impl*
end;//TncsGetTaskDescription.pm_SetTaskID

class function TncsGetTaskDescription.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_546B444D012F_var*
//#UC END# *53AC03EE01FD_546B444D012F_var*
begin
//#UC START# *53AC03EE01FD_546B444D012F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_546B444D012F_impl*
end;//TncsGetTaskDescription.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
