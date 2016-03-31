unit ncsCorrectFolder;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsCorrectFolder.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsCorrectFolder" MUID: (549AA9CE0345)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsCorrectFolder = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetNewFolder: AnsiString;
   procedure pm_SetNewFolder(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property NewFolder: AnsiString
    read pm_GetNewFolder
    write pm_SetNewFolder;
 end;//TncsCorrectFolder
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csCorrectFolder_Const
;

function TncsCorrectFolder.pm_GetTaskID: AnsiString;
//#UC START# *C62F9955664F_549AA9CE0345get_var*
//#UC END# *C62F9955664F_549AA9CE0345get_var*
begin
//#UC START# *C62F9955664F_549AA9CE0345get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C62F9955664F_549AA9CE0345get_impl*
end;//TncsCorrectFolder.pm_GetTaskID

procedure TncsCorrectFolder.pm_SetTaskID(const aValue: AnsiString);
//#UC START# *C62F9955664F_549AA9CE0345set_var*
//#UC END# *C62F9955664F_549AA9CE0345set_var*
begin
//#UC START# *C62F9955664F_549AA9CE0345set_impl*
 !!! Needs to be implemented !!!
//#UC END# *C62F9955664F_549AA9CE0345set_impl*
end;//TncsCorrectFolder.pm_SetTaskID

function TncsCorrectFolder.pm_GetNewFolder: AnsiString;
//#UC START# *5C25740B908E_549AA9CE0345get_var*
//#UC END# *5C25740B908E_549AA9CE0345get_var*
begin
//#UC START# *5C25740B908E_549AA9CE0345get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C25740B908E_549AA9CE0345get_impl*
end;//TncsCorrectFolder.pm_GetNewFolder

procedure TncsCorrectFolder.pm_SetNewFolder(const aValue: AnsiString);
//#UC START# *5C25740B908E_549AA9CE0345set_var*
//#UC END# *5C25740B908E_549AA9CE0345set_var*
begin
//#UC START# *5C25740B908E_549AA9CE0345set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C25740B908E_549AA9CE0345set_impl*
end;//TncsCorrectFolder.pm_SetNewFolder

class function TncsCorrectFolder.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_549AA9CE0345_var*
//#UC END# *53AC03EE01FD_549AA9CE0345_var*
begin
//#UC START# *53AC03EE01FD_549AA9CE0345_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_549AA9CE0345_impl*
end;//TncsCorrectFolder.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
