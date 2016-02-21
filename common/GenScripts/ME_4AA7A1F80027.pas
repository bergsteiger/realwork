unit MainMenu_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenu_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TMainMenuModule = class
  public
   procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
   class function MainMenuChangeableMainMenuTypeSetting: Integer;
    {* Метод для получения значения настройки "Тип изменяемой части основного меню" }
   class procedure WriteMainMenuChangeableMainMenuTypeSetting(aValue: Integer);
    {* Метод для записи значения настройки "Тип изменяемой части основного меню" }
 end;//TMainMenuModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsLogEvent
 , MainMenuChangeableMainMenuTypeSettingRes
 , stMainMenuChangeableMainMenuTypeItem
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , afwFacade
 , nsConst
 , nsTypes
 , DataAdapter
 , nsManagers
 , Common_FormDefinitions_Controls
 , LoggingUnit
;

type
 TnsOpenMainMenuEvent = {final} class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenMainMenuEvent

class procedure TnsOpenMainMenuEvent.Log;
//#UC START# *4B151A5B0057_4B151A2302D2_var*
//#UC END# *4B151A5B0057_4B151A2302D2_var*
begin
//#UC START# *4B151A5B0057_4B151A2302D2_impl*
 GetLogger.AddEvent(LE_OPEN_MAIN_MENU, MakeParamsList);
//#UC END# *4B151A5B0057_4B151A2302D2_impl*
end;//TnsOpenMainMenuEvent.Log

procedure TMainMenuModule.OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
//#UC START# *4ABB94DE033F_4AA7A1F80027_var*
 l_Params: IvcmMakeParams;
//#UC END# *4ABB94DE033F_4AA7A1F80027_var*
begin
//#UC START# *4ABB94DE033F_4AA7A1F80027_impl*
 if CheckContainer(aContainer).NativeMainForm.HasForm(fm_en_MainMenuNew.rFormID,
  vcm_ztParent) then
  Exit;
{$If not (defined(Monitorings) or defined(Admin))}
 {$IfDef vcmUseProfilers}
 ProfilersManager.MainMenu.Start;
 {$EndIf vcmUseProfilers}
 DefDataAdapter.TimeMachine.SwitchOff(True); // выключаем машину времени при открытии основного меню (CQ: OIT5-25116)

 l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(aContainer)));

 Ten_MainMenuNew.Make(l_Params);
{$IfEnd not (defined(Monitorings) or defined(Admin))}
 TnsOpenMainMenuEvent.Log;
//#UC END# *4ABB94DE033F_4AA7A1F80027_impl*
end;//TMainMenuModule.OpenMainMenuIfNeeded

class function TMainMenuModule.MainMenuChangeableMainMenuTypeSetting: Integer;
 {* Метод для получения значения настройки "Тип изменяемой части основного меню" }
//#UC START# *AD718804750F_4AA7A1F80027_var*
//#UC END# *AD718804750F_4AA7A1F80027_var*
begin
//#UC START# *AD718804750F_4AA7A1F80027_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD718804750F_4AA7A1F80027_impl*
end;//TMainMenuModule.MainMenuChangeableMainMenuTypeSetting

class procedure TMainMenuModule.WriteMainMenuChangeableMainMenuTypeSetting(aValue: Integer);
 {* Метод для записи значения настройки "Тип изменяемой части основного меню" }
//#UC START# *F62C297CC387_4AA7A1F80027_var*
//#UC END# *F62C297CC387_4AA7A1F80027_var*
begin
//#UC START# *F62C297CC387_4AA7A1F80027_impl*
 !!! Needs to be implemented !!!
//#UC END# *F62C297CC387_4AA7A1F80027_impl*
end;//TMainMenuModule.WriteMainMenuChangeableMainMenuTypeSetting
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
