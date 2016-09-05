unit Settings_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Settings_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Settings" MUID: (4AA79F72010A)
// Имя типа: "TSettingsModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TSettingsModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure opAutoLoginTest(const aParams: IvcmTestParamsPrim);
    {* Автоматический вход в систему }
   procedure opAutoLoginExecute(const aParams: IvcmExecuteParamsPrim);
    {* Автоматический вход в систему }
   procedure opLoadActiveSettingsExecute(const aParams: IvcmExecuteParamsPrim);
    {* Настройка конфигурации... }
   procedure opOpenConfListExecute(const aParams: IvcmExecuteParamsPrim);
    {* Список конфигураций }
   procedure opOpenStyleEditorAsModalExecute(const aParams: IvcmExecuteParamsPrim);
    {* Редактор стилей... }
   procedure opSelectConfigTest(const aParams: IvcmTestParamsPrim);
    {* Выбор конфигурации }
   procedure opSelectConfigExecute(const aParams: IvcmExecuteParamsPrim);
    {* Выбор конфигурации }
   procedure opUserPropertiesTest(const aParams: IvcmTestParamsPrim);
    {* Изменить мои регистрационные данные... }
   procedure opUserPropertiesExecute(const aParams: IvcmExecuteParamsPrim);
    {* Изменить мои регистрационные данные... }
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TSettingsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , ConfigInterfaces
 , PrimStyleEditorExample_utStyleEditorExample_UserType
 , Common_FormDefinitions_Controls
 , SelfInfo_Form
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsSettingsUtils
 , evStyleInterface
 , nsStyleEditor
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , nsConfigurationList
 , SelfInfo_ut_SelfInfo_UserType
 , l3Base
 , StyleEditorContainer_Form
 , StyleEditorFont_Form
 , StyleEditorNavigator_Form
 , ConfigurationList_Form
 , Settings_Form
 , StyleEditorExample_Form
 //#UC START# *4AA79F72010Aimpl_uses*
 //#UC END# *4AA79F72010Aimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TSettingsServiceImpl = {final} class(TvcmModuleContractImplementation, ISettingsService)
  public
   procedure CloseConfList(const aContainer: IvcmContainer);
    {* Закрыть список конфигураций }
   procedure OpenConfList(const aContainer: IvcmContainer);
   function OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
   function LoadSettings(const anAggregate: IvcmAggregate;
    const aData: InsConfigSettingsInfo): IvcmEntityForm;
    {* Открыть настройки }
   class function Instance: TSettingsServiceImpl;
    {* Метод получения экземпляра синглетона TSettingsServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TSettingsServiceImpl

var g_TSettingsServiceImpl: TSettingsServiceImpl = nil;
 {* Экземпляр синглетона TSettingsServiceImpl }

procedure TSettingsServiceImplFree;
 {* Метод освобождения экземпляра синглетона TSettingsServiceImpl }
begin
 l3Free(g_TSettingsServiceImpl);
end;//TSettingsServiceImplFree

procedure TSettingsServiceImpl.CloseConfList(const aContainer: IvcmContainer);
 {* Закрыть список конфигураций }
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
end;//TSettingsServiceImpl.CloseConfList

procedure TSettingsServiceImpl.OpenConfList(const aContainer: IvcmContainer);
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
end;//TSettingsServiceImpl.OpenConfList

function TSettingsServiceImpl.OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
var l_SettingsData: InsStyleTableSettingsInfo;
var l_Container: IvcmEntityForm;
var l_Params: IvcmMakeParams;
var
 __WasEnter : Boolean;
//#UC START# *4ABA122E00AE_4AA79F72010A_var*
//#UC END# *4ABA122E00AE_4AA79F72010A_var*
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
end;//TSettingsServiceImpl.OpenStyleEditorAsModal

function TSettingsServiceImpl.LoadSettings(const anAggregate: IvcmAggregate;
 const aData: InsConfigSettingsInfo): IvcmEntityForm;
 {* Открыть настройки }
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
end;//TSettingsServiceImpl.LoadSettings

class function TSettingsServiceImpl.Instance: TSettingsServiceImpl;
 {* Метод получения экземпляра синглетона TSettingsServiceImpl }
begin
 if (g_TSettingsServiceImpl = nil) then
 begin
  l3System.AddExitProc(TSettingsServiceImplFree);
  g_TSettingsServiceImpl := Create;
 end;
 Result := g_TSettingsServiceImpl;
end;//TSettingsServiceImpl.Instance

class function TSettingsServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TSettingsServiceImpl <> nil;
end;//TSettingsServiceImpl.Exists

procedure TSettingsModule.opAutoLoginTest(const aParams: IvcmTestParamsPrim);
 {* Автоматический вход в систему }
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

procedure TSettingsModule.opAutoLoginExecute(const aParams: IvcmExecuteParamsPrim);
 {* Автоматический вход в систему }
//#UC START# *4ABB49400064_4AA79F72010Aexec_var*
//#UC END# *4ABB49400064_4AA79F72010Aexec_var*
begin
//#UC START# *4ABB49400064_4AA79F72010Aexec_impl*
  with DefDataAdapter do
   RegistryIsAutoLogin := not(RegistryIsAutoLogin);
//#UC END# *4ABB49400064_4AA79F72010Aexec_impl*
end;//TSettingsModule.opAutoLoginExecute

procedure TSettingsModule.opLoadActiveSettingsExecute(const aParams: IvcmExecuteParamsPrim);
 {* Настройка конфигурации... }
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
end;//TSettingsModule.opLoadActiveSettingsExecute

procedure TSettingsModule.opOpenConfListExecute(const aParams: IvcmExecuteParamsPrim);
 {* Список конфигураций }
//#UC START# *4ABB4E9A0064_4AA79F72010Aexec_var*
//#UC END# *4ABB4E9A0064_4AA79F72010Aexec_var*
begin
//#UC START# *4ABB4E9A0064_4AA79F72010Aexec_impl*
 Assert(((aParams As IvcmExecuteParams).Data = nil),
        'Пользуйтесь фабриками');
 TSettingsService.Instance.OpenConfList(nil);
//#UC END# *4ABB4E9A0064_4AA79F72010Aexec_impl*
end;//TSettingsModule.opOpenConfListExecute

procedure TSettingsModule.opOpenStyleEditorAsModalExecute(const aParams: IvcmExecuteParamsPrim);
 {* Редактор стилей... }
//#UC START# *4ABB46310087_4AA79F72010Aexec_var*
//#UC END# *4ABB46310087_4AA79F72010Aexec_var*
begin
//#UC START# *4ABB46310087_4AA79F72010Aexec_impl*
 Assert(((aParams As IvcmExecuteParams).Data = nil),
        'Пользуйтесь фабриками');
 TSettingsService.Instance.OpenStyleEditorAsModal(nil);
//#UC END# *4ABB46310087_4AA79F72010Aexec_impl*
end;//TSettingsModule.opOpenStyleEditorAsModalExecute

procedure TSettingsModule.opSelectConfigTest(const aParams: IvcmTestParamsPrim);
 {* Выбор конфигурации }
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

procedure TSettingsModule.opSelectConfigExecute(const aParams: IvcmExecuteParamsPrim);
 {* Выбор конфигурации }
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
end;//TSettingsModule.opSelectConfigExecute

procedure TSettingsModule.opUserPropertiesTest(const aParams: IvcmTestParamsPrim);
 {* Изменить мои регистрационные данные... }
//#UC START# *4B506F0902B5_4AA79F72010Atest_var*
//#UC END# *4B506F0902B5_4AA79F72010Atest_var*
begin
//#UC START# *4B506F0902B5_4AA79F72010Atest_impl*
// Do nothing;
//#UC END# *4B506F0902B5_4AA79F72010Atest_impl*
end;//TSettingsModule.opUserPropertiesTest

procedure TSettingsModule.opUserPropertiesExecute(const aParams: IvcmExecuteParamsPrim);
 {* Изменить мои регистрационные данные... }
//#UC START# *4B506F0902B5_4AA79F72010Aexec_var*
//#UC END# *4B506F0902B5_4AA79F72010Aexec_var*
begin
//#UC START# *4B506F0902B5_4AA79F72010Aexec_impl*
 TSelfInfoForm.Make(vcmMakeParams);
//#UC END# *4B506F0902B5_4AA79F72010Aexec_impl*
end;//TSettingsModule.opUserPropertiesExecute

procedure TSettingsModule.Loaded;
begin
 inherited;
 PublishOp('opAutoLogin', opAutoLoginExecute, opAutoLoginTest);
 PublishOp('opLoadActiveSettings', opLoadActiveSettingsExecute, nil);
 PublishOp('opOpenConfList', opOpenConfListExecute, nil);
 PublishOp('opOpenStyleEditorAsModal', opOpenStyleEditorAsModalExecute, nil);
 PublishOp('opSelectConfig', opSelectConfigExecute, opSelectConfigTest);
 PublishOp('opUserProperties', opUserPropertiesExecute, opUserPropertiesTest);
end;//TSettingsModule.Loaded

class procedure TSettingsModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TStyleEditorContainerForm);
 aList.Add(TStyleEditorFontForm);
 aList.Add(TStyleEditorNavigatorForm);
 aList.Add(Ten_ConfigurationList);
 aList.Add(Tcf_Settings);
 aList.Add(TStyleEditorExampleForm);
 aList.Add(TSelfInfoForm);
end;//TSettingsModule.GetEntityForms

initialization
 TSettingsService.Instance.Alien := TSettingsServiceImpl.Instance;
 {* Регистрация TSettingsServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
