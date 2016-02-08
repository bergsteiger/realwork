unit Settings_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Settings_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConfigInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimStyleEditorContainerOptions_Form
 , PrimStyleEditorFont_Form
 , l3StringIDEx
 , PrimStyleEditorNavigator_Form
 , PrimConfigurationList_Form
 , Common_FormDefinitions_Controls
 , PrimSettings_Form
 , PrimStyleEditorExample_Form
 , PrimSelfInfo_Form
;

const
 fm_StyleEditorContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorContainerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TStyleEditorContainerForm }

const
 fm_StyleEditorFontForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorFontForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TStyleEditorFontForm }

const
 fm_StyleEditorNavigatorForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorNavigatorForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TStyleEditorNavigatorForm }

const
 fm_cf_Settings: TvcmFormDescriptor = (rFormID : (rName : 'cf_Settings'; rID : 0); rFactory : nil);
  {* Идентификатор формы Tcf_Settings }

const
 fm_StyleEditorExampleForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorExampleForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TStyleEditorExampleForm }

const
 fm_SelfInfoForm: TvcmFormDescriptor = (rFormID : (rName : 'SelfInfoForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TSelfInfoForm }

type
 StyleEditorContainerFormDef = interface
  {* Идентификатор формы StyleEditorContainer }
  ['{27578D68-B109-4681-A8A0-250B1511D051}']
 end;//StyleEditorContainerFormDef

 TStyleEditorContainerForm = {final} class(TPrimStyleEditorContainerOptionsForm, StyleEditorContainerFormDef)
  {* Редактор стилей }
 end;//TStyleEditorContainerForm

 StyleEditorFontFormDef = interface
  {* Идентификатор формы StyleEditorFont }
  ['{631D935A-F7C1-48C4-ACCC-923697DDB82E}']
 end;//StyleEditorFontFormDef

 TStyleEditorFontForm = {final} class(TPrimStyleEditorFontForm, StyleEditorFontFormDef)
  {* Параметры шрифта }
 end;//TStyleEditorFontForm

 StyleEditorNavigatorFormDef = interface
  {* Идентификатор формы StyleEditorNavigator }
  ['{CA4048B0-89BD-4120-9949-4497958117C6}']
 end;//StyleEditorNavigatorFormDef

 TStyleEditorNavigatorForm = {final} class(TPrimStyleEditorNavigatorForm, StyleEditorNavigatorFormDef)
  {* Дерево стилей }
 end;//TStyleEditorNavigatorForm

 Ten_ConfigurationList = {final} class(TPrimConfigurationListForm, ConfigurationListFormDef)
  {* Конфигурации }
 end;//Ten_ConfigurationList

 SettingsFormDef = interface
  {* Идентификатор формы Settings }
  ['{AE03AFD6-01DB-435D-9437-B777E585331E}']
 end;//SettingsFormDef

 Tcf_Settings = {final} class(TPrimSettingsForm, SettingsFormDef)
  {* Настройка конфигурации }
 end;//Tcf_Settings

 StyleEditorExampleFormDef = interface
  {* Идентификатор формы StyleEditorExample }
  ['{941E9E1B-2C84-4067-938E-6CFE6F2614A7}']
 end;//StyleEditorExampleFormDef

 TStyleEditorExampleForm = {final} class(TPrimStyleEditorExampleForm, StyleEditorExampleFormDef)
  {* Пример текста }
 end;//TStyleEditorExampleForm

 SelfInfoFormDef = interface
  {* Идентификатор формы SelfInfo }
  ['{58609172-F191-4A45-BABF-5983A3CBE791}']
 end;//SelfInfoFormDef

 TSelfInfoForm = {final} class(TPrimSelfInfoForm, SelfInfoFormDef)
  {* Регистрационные данные }
 end;//TSelfInfoForm

 TSettingsModule = class
  protected
   procedure OpenStyleEditorAsModal; overload;
    {* Редактор стилей... }
   procedure AutoLogin;
    {* Автоматический вход в систему }
   procedure SelectConfig;
    {* Выбор конфигурации }
   procedure OpenConfList; overload;
    {* Список конфигураций }
   procedure LoadActiveSettings;
    {* Настройка конфигурации... }
   procedure UserProperties;
    {* Изменить мои регистрационные данные... }
  public
   function OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer; overload;
   procedure CloseConfList(const aContainer: IvcmContainer);
    {* Закрыть список конфигураций }
   procedure LoadSettings(const anAggregate: IvcmAggregate;
    const aData: InsConfigSettingsInfo);
    {* Открыть настройки }
   procedure OpenConfList(const aContainer: IvcmContainer); overload;
 end;//TSettingsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimStyleEditorExample_utStyleEditorExample_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StyleEditorContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , StyleEditorFontKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StyleEditorNavigatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , ConfigurationListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SettingsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StyleEditorExampleKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SelfInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , nsStyleEditor
 , evStyleInterface
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsSettingsUtils
 , DataAdapter
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConfigurationList
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Локализуемые строки ut_StyleEditorFontLocalConstants }
 str_ut_StyleEditorFontCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_StyleEditorFontCaption'; rValue : 'Параметры шрифта');
  {* Заголовок пользовательского типа "Параметры шрифта" }

const
 {* Локализуемые строки ut_SelfInfoLocalConstants }
 str_ut_SelfInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_SelfInfoCaption'; rValue : 'Регистрационные данные');
  {* Заголовок пользовательского типа "Регистрационные данные" }

function TSettingsModule.OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
var l_SettingsData: InsStyleTableSettingsInfo;
var l_Container: IvcmEntityForm;
var l_Params: IvcmMakeParams;
//#UC START# *4ABA122E00AE_4AA79F72010A_var*
//#UC END# *4ABA122E00AE_4AA79F72010A_var*
begin
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
end;//TSettingsModule.OpenStyleEditorAsModal

procedure TSettingsModule.OpenStyleEditorAsModal;
 {* Редактор стилей... }
//#UC START# *4ABB46310087_4AA79F72010A_var*
//#UC END# *4ABB46310087_4AA79F72010A_var*
begin
//#UC START# *4ABB46310087_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB46310087_4AA79F72010A_impl*
end;//TSettingsModule.OpenStyleEditorAsModal

procedure TSettingsModule.AutoLogin;
 {* Автоматический вход в систему }
//#UC START# *4ABB49400064_4AA79F72010A_var*
//#UC END# *4ABB49400064_4AA79F72010A_var*
begin
//#UC START# *4ABB49400064_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB49400064_4AA79F72010A_impl*
end;//TSettingsModule.AutoLogin

procedure TSettingsModule.SelectConfig;
 {* Выбор конфигурации }
//#UC START# *4ABB4BB100C0_4AA79F72010A_var*
//#UC END# *4ABB4BB100C0_4AA79F72010A_var*
begin
//#UC START# *4ABB4BB100C0_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB4BB100C0_4AA79F72010A_impl*
end;//TSettingsModule.SelectConfig

procedure TSettingsModule.OpenConfList;
 {* Список конфигураций }
//#UC START# *4ABB4E9A0064_4AA79F72010A_var*
//#UC END# *4ABB4E9A0064_4AA79F72010A_var*
begin
//#UC START# *4ABB4E9A0064_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB4E9A0064_4AA79F72010A_impl*
end;//TSettingsModule.OpenConfList

procedure TSettingsModule.CloseConfList(const aContainer: IvcmContainer);
 {* Закрыть список конфигураций }
//#UC START# *4ABB51300045_4AA79F72010A_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *4ABB51300045_4AA79F72010A_var*
begin
//#UC START# *4ABB51300045_4AA79F72010A_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_ConfigurationList.rFormID,
                    vcm_ztNavigator,
                    True,
                    @l_Form);
 if l_Form <> nil then
  l_Form.SafeClose;
//#UC END# *4ABB51300045_4AA79F72010A_impl*
end;//TSettingsModule.CloseConfList

procedure TSettingsModule.LoadSettings(const anAggregate: IvcmAggregate;
 const aData: InsConfigSettingsInfo);
 {* Открыть настройки }
//#UC START# *4ABB5496029E_4AA79F72010A_var*
//#UC END# *4ABB5496029E_4AA79F72010A_var*
begin
//#UC START# *4ABB5496029E_4AA79F72010A_impl*
 (* aParams содержат редактируемую конфигурацию (IConfiguration), переданную из
  enConfigurationList *)
 Result := Tcf_Settings.Make(aData, vcmMakeParams(anAggregate), vcm_ztModal);
//#UC END# *4ABB5496029E_4AA79F72010A_impl*
end;//TSettingsModule.LoadSettings

procedure TSettingsModule.LoadActiveSettings;
 {* Настройка конфигурации... }
//#UC START# *4ABB5926039A_4AA79F72010A_var*
//#UC END# *4ABB5926039A_4AA79F72010A_var*
begin
//#UC START# *4ABB5926039A_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB5926039A_4AA79F72010A_impl*
end;//TSettingsModule.LoadActiveSettings

procedure TSettingsModule.OpenConfList(const aContainer: IvcmContainer);
//#UC START# *4AC0FF9D0332_4AA79F72010A_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4AC0FF9D0332_4AA79F72010A_var*
begin
//#UC START# *4AC0FF9D0332_4AA79F72010A_impl*
 l_Form := Ten_ConfigurationList.MakeSingleChild(CheckContainer(aContainer),
                             vcmCheckAggregate(
                              vcmMakeParams(nil,
                                        CheckContainer(aContainer))),
                             vcm_ztNavigator);

 if (l_Form <> nil) then
  l_Form.SetActiveInParent;
//#UC END# *4AC0FF9D0332_4AA79F72010A_impl*
end;//TSettingsModule.OpenConfList

procedure TSettingsModule.UserProperties;
 {* Изменить мои регистрационные данные... }
//#UC START# *4B506F0902B5_4AA79F72010A_var*
//#UC END# *4B506F0902B5_4AA79F72010A_var*
begin
//#UC START# *4B506F0902B5_4AA79F72010A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B506F0902B5_4AA79F72010A_impl*
end;//TSettingsModule.UserProperties

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorContainerForm);
 {* Регистрация StyleEditorContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorFontForm);
 {* Регистрация StyleEditorFont }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_StyleEditorFontCaption.Init;
 {* Инициализация str_ut_StyleEditorFontCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorNavigatorForm);
 {* Регистрация StyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
 fm_StyleEditorNavigatorForm.SetFactory(TStyleEditorNavigatorForm.Make);
 {* Регистрация фабрики формы StyleEditorNavigator }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_ConfigurationList);
 {* Регистрация ConfigurationList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_ConfigurationList.SetFactory(Ten_ConfigurationList.Make);
 {* Регистрация фабрики формы ConfigurationList }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tcf_Settings);
 {* Регистрация Settings }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorExampleForm);
 {* Регистрация StyleEditorExample }
{$IfEnd} // NOT Defined(NoScripts)
 fm_StyleEditorExampleForm.SetFactory(TStyleEditorExampleForm.Make);
 {* Регистрация фабрики формы StyleEditorExample }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSelfInfoForm);
 {* Регистрация SelfInfo }
{$IfEnd} // NOT Defined(NoScripts)
 fm_SelfInfoForm.SetFactory(TSelfInfoForm.Make);
 {* Регистрация фабрики формы SelfInfo }
 str_ut_SelfInfoCaption.Init;
 {* Инициализация str_ut_SelfInfoCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
