unit alcuAnoncedExportPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAnoncedExportPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExport
 , AnoncedExportTask_Const
 , evdTasksHelpers
 , k2Base
;

type
 TalcuAnoncedExportPrim = class(TalcuExport)
  protected
   function pm_GetOnThursdayMode: Boolean;
   procedure pm_SetOnThursdayMode(aValue: Boolean);
   function pm_GetNotifyEMailList: AnsiString;
   procedure pm_SetNotifyEMailList(const aValue: AnsiString);
   function pm_GetAnoncedDate: Integer;
   procedure pm_SetAnoncedDate(aValue: Integer);
   function pm_GetAccGroupsIDList: AccGroupsIDListHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property OnThursdayMode: Boolean
    read pm_GetOnThursdayMode
    write pm_SetOnThursdayMode;
    {* Режим экспорта "по четвергам" }
   property NotifyEMailList: AnsiString
    read pm_GetNotifyEMailList
    write pm_SetNotifyEMailList;
   property AnoncedDate: Integer
    read pm_GetAnoncedDate
    write pm_SetAnoncedDate;
   property AccGroupsIDList: AccGroupsIDListHelper
    read pm_GetAccGroupsIDList;
 end;//TalcuAnoncedExportPrim
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;

function TalcuAnoncedExportPrim.pm_GetOnThursdayMode: Boolean;
//#UC START# *B2413C941E50_53DB5CFF017Dget_var*
//#UC END# *B2413C941E50_53DB5CFF017Dget_var*
begin
//#UC START# *B2413C941E50_53DB5CFF017Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *B2413C941E50_53DB5CFF017Dget_impl*
end;//TalcuAnoncedExportPrim.pm_GetOnThursdayMode

procedure TalcuAnoncedExportPrim.pm_SetOnThursdayMode(aValue: Boolean);
//#UC START# *B2413C941E50_53DB5CFF017Dset_var*
//#UC END# *B2413C941E50_53DB5CFF017Dset_var*
begin
//#UC START# *B2413C941E50_53DB5CFF017Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *B2413C941E50_53DB5CFF017Dset_impl*
end;//TalcuAnoncedExportPrim.pm_SetOnThursdayMode

function TalcuAnoncedExportPrim.pm_GetNotifyEMailList: AnsiString;
//#UC START# *52304882574A_53DB5CFF017Dget_var*
//#UC END# *52304882574A_53DB5CFF017Dget_var*
begin
//#UC START# *52304882574A_53DB5CFF017Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *52304882574A_53DB5CFF017Dget_impl*
end;//TalcuAnoncedExportPrim.pm_GetNotifyEMailList

procedure TalcuAnoncedExportPrim.pm_SetNotifyEMailList(const aValue: AnsiString);
//#UC START# *52304882574A_53DB5CFF017Dset_var*
//#UC END# *52304882574A_53DB5CFF017Dset_var*
begin
//#UC START# *52304882574A_53DB5CFF017Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *52304882574A_53DB5CFF017Dset_impl*
end;//TalcuAnoncedExportPrim.pm_SetNotifyEMailList

function TalcuAnoncedExportPrim.pm_GetAnoncedDate: Integer;
//#UC START# *26C7061E1C18_53DB5CFF017Dget_var*
//#UC END# *26C7061E1C18_53DB5CFF017Dget_var*
begin
//#UC START# *26C7061E1C18_53DB5CFF017Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *26C7061E1C18_53DB5CFF017Dget_impl*
end;//TalcuAnoncedExportPrim.pm_GetAnoncedDate

procedure TalcuAnoncedExportPrim.pm_SetAnoncedDate(aValue: Integer);
//#UC START# *26C7061E1C18_53DB5CFF017Dset_var*
//#UC END# *26C7061E1C18_53DB5CFF017Dset_var*
begin
//#UC START# *26C7061E1C18_53DB5CFF017Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *26C7061E1C18_53DB5CFF017Dset_impl*
end;//TalcuAnoncedExportPrim.pm_SetAnoncedDate

function TalcuAnoncedExportPrim.pm_GetAccGroupsIDList: AccGroupsIDListHelper;
//#UC START# *40D14DD59824_53DB5CFF017Dget_var*
//#UC END# *40D14DD59824_53DB5CFF017Dget_var*
begin
//#UC START# *40D14DD59824_53DB5CFF017Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *40D14DD59824_53DB5CFF017Dget_impl*
end;//TalcuAnoncedExportPrim.pm_GetAccGroupsIDList

class function TalcuAnoncedExportPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53DB5CFF017D_var*
//#UC END# *53AC03EE01FD_53DB5CFF017D_var*
begin
//#UC START# *53AC03EE01FD_53DB5CFF017D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53DB5CFF017D_impl*
end;//TalcuAnoncedExportPrim.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
