unit stMainMenuChangeableMainMenuTypeItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/stMainMenuChangeableMainMenuTypeItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::TstMainMenuChangeableMainMenuTypeItem
//
// Визуализатор для настройки "Тип изменяемой части основного меню"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  ddAppConfigTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TstMainMenuChangeableMainMenuTypeItem = class(TddComboBoxConfigItem)
  {* Визуализатор для настройки "Тип изменяемой части основного меню" }
 public
 // public methods
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
     {* undefined }
 end;//TstMainMenuChangeableMainMenuTypeItem
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  MainMenuChangeableMainMenuTypeSettingRes,
  l3Base,
  ddAppConfigConst
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TstMainMenuChangeableMainMenuTypeItem

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

{$IfEnd} //not Admin AND not Monitorings

end.