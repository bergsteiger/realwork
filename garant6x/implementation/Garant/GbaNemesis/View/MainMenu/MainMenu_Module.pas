unit MainMenu_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/MainMenu_Module.pas"
// Начат: 09.09.2009 16:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::MainMenu$FP
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  PrimMainMenuNew_Form,
  vtPanel,
  MainMenuNew_Form
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  
  {$If not defined(NoImageEn)}
  ,
  imageenview
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenio
  {$IfEnd} //not NoImageEn
  ,
  nsLogEvent
  {$If defined(Nemesis)}
  ,
  nscFocusLabel
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  Common_FormDefinitions_Controls
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MainMenuNewKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TMainMenuModule = {formspack} class(TvcmModule)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 public
 // public methods
   class procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
   class function MainMenuChangeableMainMenuTypeSetting: Integer;
     {* Метод для получения значения настройки "Тип изменяемой части основного меню" }
   class procedure WriteMainMenuChangeableMainMenuTypeSetting(aValue: Integer);
     {* Метод для записи значения настройки "Тип изменяемой части основного меню" }
 end;//TMainMenuModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  ,
  afwFacade,
  nsConst,
  nsTypes,
  DataAdapter,
  nsManagers,
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  MainMenuChangeableMainMenuTypeSettingRes,
  stMainMenuChangeableMainMenuTypeItem
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type
  TnsOpenMainMenuEvent = {final} class(TnsLogEvent)
  public
  // public methods
   class procedure Log;
  end;//TnsOpenMainMenuEvent

// start class TnsOpenMainMenuEvent

class procedure TnsOpenMainMenuEvent.Log;
//#UC START# *4B151A5B0057_4B151A2302D2_var*
//#UC END# *4B151A5B0057_4B151A2302D2_var*
begin
//#UC START# *4B151A5B0057_4B151A2302D2_impl*
 GetLogger.AddEvent(LE_OPEN_MAIN_MENU, MakeParamsList);
//#UC END# *4B151A5B0057_4B151A2302D2_impl*
end;//TnsOpenMainMenuEvent.Log

class procedure TMainMenuModule.OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4ABB94DE033F_4AA7A1F80027_var*
 l_Params: IvcmMakeParams;
//#UC END# *4ABB94DE033F_4AA7A1F80027_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TMainMenuModule.OpenMainMenuIfNeeded

class function TMainMenuModule.MainMenuChangeableMainMenuTypeSetting: Integer;
 {-}
begin
 if (afw.Settings = nil) then
  Result := dv_MainMenu_ChangeableMainMenuType
 else
  Result := afw.Settings.LoadInteger(pi_MainMenu_ChangeableMainMenuType, dv_MainMenu_ChangeableMainMenuType);
end;//TMainMenuModule.MainMenuChangeableMainMenuTypeSetting

class procedure TMainMenuModule.WriteMainMenuChangeableMainMenuTypeSetting(aValue: Integer);
 {-}
begin
 if (afw.Settings <> nil) then
  afw.Settings.SaveInteger(pi_MainMenu_ChangeableMainMenuType, aValue);
end;//TMainMenuModule.WriteMainMenuChangeableMainMenuTypeSetting

class procedure TMainMenuModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(Ten_MainMenuNew);
end;

{$IfEnd} //not Admin AND not Monitorings

end.