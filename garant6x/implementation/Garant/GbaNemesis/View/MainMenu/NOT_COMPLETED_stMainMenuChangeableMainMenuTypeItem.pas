unit NOT_COMPLETED_stMainMenuChangeableMainMenuTypeItem;
 {* Визуализатор для настройки "Тип изменяемой части основного меню" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\NOT_COMPLETED_stMainMenuChangeableMainMenuTypeItem.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TstMainMenuChangeableMainMenuTypeItem" MUID: (98CD882A435E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstMainMenuChangeableMainMenuTypeItem = class(TddComboBoxConfigItem)
  {* Визуализатор для настройки "Тип изменяемой части основного меню" }
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstMainMenuChangeableMainMenuTypeItem
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , MainMenuChangeableMainMenuTypeSettingRes
 , l3Base
 , ddAppConfigConst
;

constructor TstMainMenuChangeableMainMenuTypeItem.Create(aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5F66B3E8463A_98CD882A435E_var*
//#UC END# *5F66B3E8463A_98CD882A435E_var*
begin
//#UC START# *5F66B3E8463A_98CD882A435E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5F66B3E8463A_98CD882A435E_impl*
end;//TstMainMenuChangeableMainMenuTypeItem.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
