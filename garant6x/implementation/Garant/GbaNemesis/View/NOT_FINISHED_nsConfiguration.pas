unit NOT_FINISHED_nsConfiguration;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_nsConfiguration.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsConfiguration" MUID: (4F8BF9B20239)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TnsEditSettingsInfo = class
 end;//TnsEditSettingsInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4F8BF9B20239impl_uses*
 //#UC END# *4F8BF9B20239impl_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
