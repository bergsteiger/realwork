unit Settings_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Settings_Module.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings
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
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  ConfigInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  vtComboBoxQS,
  vtFocusLabel,
  StyleEditorContainer_Form,
  StyleEditorFont_Form,
  StyleEditorNavigator_Form,
  ConfigurationList_Form,
  Settings_Form,
  StyleEditorExample_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  PrimSettings_Form,
  PrimStyleEditorFont_Form,
  PrimStyleEditorNavigator_Form,
  vtLabel,
  PrimStyleEditorExample_Form,
  l3StringIDEx,
  PrimSelfInfo_Form,
  SelfInfo_Form,
  PrimConfigurationList_Form,
  Common_FormDefinitions_Controls,
  PrimStyleEditorContainerOptions_Form,
  eeEditorWithoutOperations
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  vtCheckBox,
  ElPopBtn,
  vtColorBox,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorContainerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorFontKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorNavigatorKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ConfigurationListKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  SettingsKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorExampleKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  SelfInfoKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TSettingsModule = {formspack} class(TvcmModule)
 protected
  procedure Loaded; override;
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   procedure opOpenStyleEditorAsModal(const aParams: IvcmExecuteParamsPrim);
     {* Редактор стилей... }
   procedure opAutoLoginTest(const aParams: IvcmTestParamsPrim);
     {* Автоматический вход в систему }
   procedure opAutoLogin(const aParams: IvcmExecuteParamsPrim);
     {* Автоматический вход в систему }
   procedure opSelectConfigTest(const aParams: IvcmTestParamsPrim);
     {* Выбор конфигурации }
   procedure opSelectConfig(const aParams: IvcmExecuteParamsPrim);
     {* Выбор конфигурации }
   procedure opOpenConfList(const aParams: IvcmExecuteParamsPrim);
     {* Список конфигураций }
   procedure opLoadActiveSettings(const aParams: IvcmExecuteParamsPrim);
     {* Настройка конфигурации... }
   procedure opUserPropertiesTest(const aParams: IvcmTestParamsPrim);
     {* Изменить мои регистрационные данные... }
   procedure opUserProperties(const aParams: IvcmExecuteParamsPrim);
     {* Изменить мои регистрационные данные... }
 public
 // public methods
   class function OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
   class procedure CloseConfList(const aContainer: IvcmContainer);
     {* Закрыть список конфигураций }
   class function LoadSettings(const anAggregate: IvcmAggregate;
     const aData: InsConfigSettingsInfo): IvcmEntityForm;
     {* Открыть настройки }
   class procedure OpenConfList(const aContainer: IvcmContainer);
 end;//TSettingsModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsStyleEditor,
  evStyleInterface
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsSettingsUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  SysUtils,
  nsConfigurationList
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  PrimStyleEditorExample_utStyleEditorExample_UserType
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
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opOpenStyleEditorAsModal
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opAutoLogin
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opSelectConfig
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opOpenConfList
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opLoadActiveSettings
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Settings_opUserProperties
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a},
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TSettingsModule

class function TSettingsModule.OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
var
 __WasEnter : Boolean;
//#UC START# *4ABA122E00AE_4AA79F72010A_var*
//#UC END# *4ABA122E00AE_4AA79F72010A_var*
var
 l_SettingsData : InsStyleTableSettingsInfo;
 l_Container : IvcmEntityForm;
 l_Params : IvcmMakeParams;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABA122E00AE_4AA79F72010A_impl*
 Result := mrNone;
 if (aData = nil) then
  l_SettingsData := TnsStyleTableSettingsInfo.Make
 else
  l_SettingsData := aData;
 try
  l_Params := vcmCheckAggregate(vcmMakeParams);
  try
   with TevStyleInterface.Make do
    try
     Changing;
     try
      l_Container := TStyleEditorContainerForm.Make(l_SettingsData, l_Params);
      try
       l_Params := vcmMakeParams(l_Params.Aggregate, l_Container.AsContainer, l_Params.Owner);
       TStyleEditorExampleForm.Make(l_Params, vcm_ztChild,
        Ord(utStyleEditorExample));
       TStyleEditorFontForm.Make(l_SettingsData, l_Params);
       TStyleEditorNavigatorForm.Make(l_Params);
       Result := l_Container.ShowModal;
       if (Result <> mrOk) or not l_SettingsData.IsActive then
        LoadStyleTableFromSettings;
      finally
       l_Container := nil;
      end;//try..finally
     finally
      ChangedEx((Result = mrOk) and not l_SettingsData.IsActive);
     end;//try..finally
    finally
     Free;
    end;//try..finally
  finally
   l_Params := nil;
  end;//try..finally
 finally
  l_SettingsData := nil;
 end;//try..finally
//#UC END# *4ABA122E00AE_4AA79F72010A_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSettingsModule.OpenStyleEditorAsModal

procedure TSettingsModule.opOpenStyleEditorAsModal(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ABB46310087_4AA79F72010Aexec_var*
//#UC END# *4ABB46310087_4AA79F72010Aexec_var*
begin
//#UC START# *4ABB46310087_4AA79F72010Aexec_impl*
 Assert(((aParams As IvcmExecuteParams).Data = nil),
        'Пользуйтесь фабриками');
 OpenStyleEditorAsModal(nil);
//#UC END# *4ABB46310087_4AA79F72010Aexec_impl*
end;//TSettingsModule.opOpenStyleEditorAsModal

procedure TSettingsModule.opAutoLoginTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4ABB49400064_4AA79F72010Atest_var*
//#UC END# *4ABB49400064_4AA79F72010Atest_var*
begin
//#UC START# *4ABB49400064_4AA79F72010Atest_impl*
{$IfDef nsAutoLoginDisable}
 aParams.Op.Flag[vcm_ofEnabled] := False;
{$Else}
 aParams.Op.Flag[vcm_ofChecked] := DefDataAdapter.RegistryIsAutoLogin;
{$EndIf}
//#UC END# *4ABB49400064_4AA79F72010Atest_impl*
end;//TSettingsModule.opAutoLoginTest

procedure TSettingsModule.opAutoLogin(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ABB49400064_4AA79F72010Aexec_var*
//#UC END# *4ABB49400064_4AA79F72010Aexec_var*
begin
//#UC START# *4ABB49400064_4AA79F72010Aexec_impl*
  with DefDataAdapter do
   RegistryIsAutoLogin := not(RegistryIsAutoLogin);
//#UC END# *4ABB49400064_4AA79F72010Aexec_impl*
end;//TSettingsModule.opAutoLogin

procedure TSettingsModule.opSelectConfigTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4ABB4BB100C0_4AA79F72010Atest_var*
var
 l_List : IvcmNodes;
//#UC END# *4ABB4BB100C0_4AA79F72010Atest_var*
begin
//#UC START# *4ABB4BB100C0_4AA79F72010Atest_impl*
 with aParams do
 begin
  Op.Flag[vcm_ofEnabled] := True;

  l_List := Op.SubNodes;
  if (l_List <> nil) then
  begin
   l_List.ShowRoot := false;
   if (l_List.Count = 0) then
   begin
    l_List.Clear;
    l_List.Add(ConfigurationList.MenuTree);
   end;//l_List.Count = 0
   l_List.Current := ConfigurationList.ActiveMenuNode;
  end;//l_List <> nil
 end;//with aParams
//#UC END# *4ABB4BB100C0_4AA79F72010Atest_impl*
end;//TSettingsModule.opSelectConfigTest

procedure TSettingsModule.opSelectConfig(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ABB4BB100C0_4AA79F72010Aexec_var*
var
 l_Node: InsConfigNode;
//#UC END# *4ABB4BB100C0_4AA79F72010Aexec_var*
begin
//#UC START# *4ABB4BB100C0_4AA79F72010Aexec_impl*
 if Supports(aParams.CurrentNode, InsConfigNode, l_Node) then
 try
  ConfigurationList.ActivateConfig(l_Node);
 finally
  l_Node := nil;
 end;
//#UC END# *4ABB4BB100C0_4AA79F72010Aexec_impl*
end;//TSettingsModule.opSelectConfig

procedure TSettingsModule.opOpenConfList(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ABB4E9A0064_4AA79F72010Aexec_var*
//#UC END# *4ABB4E9A0064_4AA79F72010Aexec_var*
begin
//#UC START# *4ABB4E9A0064_4AA79F72010Aexec_impl*
 Assert(((aParams As IvcmExecuteParams).Data = nil),
        'Пользуйтесь фабриками');
 OpenConfList(nil);
//#UC END# *4ABB4E9A0064_4AA79F72010Aexec_impl*
end;//TSettingsModule.opOpenConfList

class procedure TSettingsModule.CloseConfList(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4ABB51300045_4AA79F72010A_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *4ABB51300045_4AA79F72010A_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABB51300045_4AA79F72010A_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_ConfigurationList.rFormID,
                    vcm_ztNavigator,
                    True,
                    @l_Form);
 if l_Form <> nil then
  l_Form.SafeClose;
//#UC END# *4ABB51300045_4AA79F72010A_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSettingsModule.CloseConfList

class function TSettingsModule.LoadSettings(const anAggregate: IvcmAggregate;
  const aData: InsConfigSettingsInfo): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4ABB5496029E_4AA79F72010A_var*
//#UC END# *4ABB5496029E_4AA79F72010A_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABB5496029E_4AA79F72010A_impl*
 (* aParams содержат редактируемую конфигурацию (IConfiguration), переданную из
  enConfigurationList *)
 Result := Tcf_Settings.Make(aData, vcmMakeParams(anAggregate), vcm_ztModal);
//#UC END# *4ABB5496029E_4AA79F72010A_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSettingsModule.LoadSettings

procedure TSettingsModule.opLoadActiveSettings(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ABB5926039A_4AA79F72010Aexec_var*
var
 l_Form       : IvcmEntityForm;
 l_Params     : IvcmMakeParams;
//#UC END# *4ABB5926039A_4AA79F72010Aexec_var*
begin
//#UC START# *4ABB5926039A_4AA79F72010Aexec_impl*
 (* Агрегация не определена *)
 if CheckContainer(nil).NativeMainForm.
  HasForm(fm_en_ConfigurationList.rFormID, vcm_ztNavigator, True, @l_Form) then
 try
  (* У формы "Список конфигураций" агрегация не определена *)
  if not Assigned(l_Form.Aggregate) then
  begin
   l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(nil)));
   (l_Form.VCLWinControl As TvcmEntityForm).Aggregate := l_Params.Aggregate;
  end//not Assigned(l_Form.Aggregate)
  (* Установим параметрам агрегацию формы *)
  else
   l_Params := vcmSetAggregate(l_Form.Aggregate, vcmMakeParams(nil, CheckContainer(nil)));
 finally
  l_Form := nil;
 end//try..finally
 else
  l_Params := vcmMakeParams(nil, CheckContainer(nil));
 Tcf_Settings.Make(ConfigurationList.ActiveConfig, l_Params, vcm_ztModal);
//#UC END# *4ABB5926039A_4AA79F72010Aexec_impl*
end;//TSettingsModule.opLoadActiveSettings

class procedure TSettingsModule.OpenConfList(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AC0FF9D0332_4AA79F72010A_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4AC0FF9D0332_4AA79F72010A_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC0FF9D0332_4AA79F72010A_impl*
 l_Form := Ten_ConfigurationList.MakeSingleChild(CheckContainer(aContainer),
                             vcmCheckAggregate(
                              vcmMakeParams(nil,
                                        CheckContainer(aContainer))),
                             vcm_ztNavigator);

 if (l_Form <> nil) then
  l_Form.SetActiveInParent;
//#UC END# *4AC0FF9D0332_4AA79F72010A_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSettingsModule.OpenConfList

procedure TSettingsModule.opUserPropertiesTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4B506F0902B5_4AA79F72010Atest_var*
//#UC END# *4B506F0902B5_4AA79F72010Atest_var*
begin
//#UC START# *4B506F0902B5_4AA79F72010Atest_impl*
// Do nothing;
//#UC END# *4B506F0902B5_4AA79F72010Atest_impl*
end;//TSettingsModule.opUserPropertiesTest

procedure TSettingsModule.opUserProperties(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4B506F0902B5_4AA79F72010Aexec_var*
//#UC END# *4B506F0902B5_4AA79F72010Aexec_var*
begin
//#UC START# *4B506F0902B5_4AA79F72010Aexec_impl*
 TSelfInfoForm.Make(vcmMakeParams);
//#UC END# *4B506F0902B5_4AA79F72010Aexec_impl*
end;//TSettingsModule.opUserProperties

procedure TSettingsModule.Loaded;
begin
 inherited;
 PublishOp('opOpenStyleEditorAsModal', opOpenStyleEditorAsModal, nil);
 PublishOp('opAutoLogin', opAutoLogin, opAutoLoginTest);
 PublishOp('opSelectConfig', opSelectConfig, opSelectConfigTest);
 PublishOp('opOpenConfList', opOpenConfList, nil);
 PublishOp('opLoadActiveSettings', opLoadActiveSettings, nil);
 PublishOp('opUserProperties', opUserProperties, opUserPropertiesTest);
end;

class procedure TSettingsModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TStyleEditorContainerForm);
 aList.Add(TStyleEditorFontForm);
 aList.Add(TStyleEditorNavigatorForm);
 aList.Add(Ten_ConfigurationList);
 aList.Add(Tcf_Settings);
 aList.Add(TStyleEditorExampleForm);
 aList.Add(TSelfInfoForm);
end;

{$IfEnd} //not Admin AND not Monitorings

end.