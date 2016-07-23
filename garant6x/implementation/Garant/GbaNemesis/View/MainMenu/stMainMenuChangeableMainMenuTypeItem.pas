unit stMainMenuChangeableMainMenuTypeItem;
 {* Визуализатор для настройки "Тип изменяемой части основного меню" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\stMainMenuChangeableMainMenuTypeItem.pas"
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
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := dv_MainMenu_ChangeableMainMenuType;
 inherited Create(pi_MainMenu_ChangeableMainMenuType,
  str_ChangeableMainMenuType.AsStr,
  l_Value, TChangeableMainMenuTypeValuesMapImpl.Make, aMasterItem);
end;//TstMainMenuChangeableMainMenuTypeItem.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
