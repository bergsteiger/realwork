unit NOT_FINISHED_DataAdapter;
 {* Фасад для работы с адаптером }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\NOT_FINISHED_DataAdapter.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , DataAdapterInterfaces
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , AdminDomainInterfaces
;

type
 TDataAdapter = class
  {* Объект для связи всех главных форм с адаптером сервера приложений }
  private
   {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
   f_TimeMachine: InsTimeMachine;
    {* Поле для свойства TimeMachine }
   {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
  protected
   {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
   function pm_GetTimeMachine: InsTimeMachine; virtual;
   {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
   function pm_GetAdminInfo: InsAdminInfo; virtual;
  private
   {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
   property TimeMachine: InsTimeMachine
    read pm_GetTimeMachine;
   {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
   property AdminInfo: InsAdminInfo
    read pm_GetAdminInfo;
 end;//TDataAdapter

procedure DefDataAdapter;

var DefDataAdapter: TDataAdapter;
var g_ShowFinalSplash: Boolean;

implementation

uses
 l3ImplUses
 , nsQuestionsWithChoices
 , nsLoginUtils
;

procedure DefDataAdapter;
//#UC START# *4B1E8FAE0380_48FF556602BA_var*
//#UC END# *4B1E8FAE0380_48FF556602BA_var*
begin
//#UC START# *4B1E8FAE0380_48FF556602BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B1E8FAE0380_48FF556602BA_impl*
end;//DefDataAdapter

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function TDataAdapter.pm_GetTimeMachine: InsTimeMachine;
//#UC START# *4AC21B930363_48FF55B500CCget_var*
//#UC END# *4AC21B930363_48FF55B500CCget_var*
begin
//#UC START# *4AC21B930363_48FF55B500CCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC21B930363_48FF55B500CCget_impl*
end;//TDataAdapter.pm_GetTimeMachine
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

function TDataAdapter.pm_GetAdminInfo: InsAdminInfo;
//#UC START# *4AC21F4503DE_48FF55B500CCget_var*
//#UC END# *4AC21F4503DE_48FF55B500CCget_var*
begin
//#UC START# *4AC21F4503DE_48FF55B500CCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC21F4503DE_48FF55B500CCget_impl*
end;//TDataAdapter.pm_GetAdminInfo

end.
