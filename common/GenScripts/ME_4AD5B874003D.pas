unit NOT_FINISHED_nsAppConfig;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Config\NOT_FINISHED_nsAppConfig.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , SysUtils
 , ddAppConfigTypes
 , ddConfigStorages
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , ConfigInterfaces
 , Classes
 , ddAppConfigConst
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ddAppConfig
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConfiguration
 , bsInterfaces
 , afwInterfaces
;

const
 {* navigator form position }
 cnfpLeftNavigator = 'fLeftNavigator';
 cnfpRightNavigator = 'fRightNavigator';
 cnfpNavigator = 'vcm_ztNavigator/';
 cnfpZone = cnfpNavigator + 'Zone';
 cnfpFloating = cnfpNavigator + 'Floating';

type
 PnsButtonCaptionArray = ^TnsButtonCaptionArray;

 EDuplicateConfName = class(Exception)
  private
   f_ConfName: AnsiString;
    {* Поле для свойства ConfName }
  protected
   procedure pm_SetConfName(const aValue: AnsiString);
  public
   property ConfName: AnsiString
    read f_ConfName
    write pm_SetConfName;
 end;//EDuplicateConfName

 ECRSettingsAreEqual = class(Exception)
 end;//ECRSettingsAreEqual

 EConfigNotSaved = class(Exception)
 end;//EConfigNotSaved

 TnsHistoryItemsProperty = class(TddIntegerConfigItem)
  {* количество элементов в истории }
  public
   procedure SaveValue(const aStorage: IddConfigStorage); override;
 end;//TnsHistoryItemsProperty

 TnsConfInfoNode = class(TddCustomConfigNode)
  {* панель информации конфигурации }
  private
   f_Frame: TCustomFrame;
   f_ConfName: TnscComboBox;
   f_ConfHint: TnscComboBox;
   f_Changed: Boolean;
   f_Config: Pointer;
  private
   procedure OnResize(Sender: TObject);
    {* подгоняем размеры полей ввода }
   procedure OnChangeName(Sender: TObject);
   procedure OnChangeHint(Sender: TObject);
   procedure SetEditsWidth;
  protected
   function pm_GetChanged: Boolean;
   procedure DoClearControls; override;
   function DoCreateFrame(aOwner: TComponent;
    aTag: Integer): TCustomFrame; override;
   procedure DoGetControlValues; override;
   function DoIsItem(aItem: TObject): Boolean; override;
   procedure DoLoad(const aStorage: IddConfigStorage); override;
   procedure DoSave(const aStorage: IddConfigStorage); override;
   procedure DoSetControlValues(aDefault: Boolean); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetChanged: Boolean; override;
   procedure pm_SetChanged(aValue: Boolean); override;
   function pm_GetValue: TddConfigValue; override;
   procedure pm_SetValue(const aValue: TddConfigValue); override;
   procedure DoFrameSize(aParent: TWinControl;
    out aHeight: Integer;
    out aWidth: Integer); override;
  public
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    const aConfig: InsConfigSettingsInfo = nil); reintroduce;
 end;//TnsConfInfoNode

 TnsAppConfig = class(TddAppConfiguration)
  protected
   function pm_GetIsNeedReinsertForms: Boolean;
  public
   function IsSettingsChanged: Boolean;
  public
   property IsNeedReinsertForms: Boolean
    read pm_GetIsNeedReinsertForms;
 end;//TnsAppConfig

 InsConfigStorage = interface(IddConfigStorage)
  ['{ECE1E738-1242-4DEF-8A1C-41C501162923}']
  function Get_DefaultValuesOperation: Boolean;
  procedure Set_DefaultValuesOperation(aValue: Boolean);
  property DefaultValuesOperation: Boolean
   read Get_DefaultValuesOperation
   write Set_DefaultValuesOperation;
   {* Все операции делаются со значениями по умолчанию:
   Load - восстановить значения по умолчанию и загрузить
   Save - сохранить и сделать значениями по умолчанию }
 end;//InsConfigStorage

 TnsConfigStorage = class(TvcmCacheableBase, InsConfigStorage)
  {* производит запись, чтение настроек }
  private
   f_DefaultValuesOperation: Boolean;
   f_Settings: IvcmSettings;
  protected
   function ReadBool(const Alias: AnsiString;
    Default: Boolean): Boolean; overload; stdcall;
   function ReadDateTime(const Alias: AnsiString;
    Default: TDateTime): TDateTime; overload; stdcall;
   function ReadInteger(const Alias: AnsiString;
    Default: Integer): Integer; overload; stdcall;
   function ReadString(const Alias: AnsiString;
    const Default: AnsiString): Il3CString; overload; stdcall;
   procedure WriteBool(const Alias: AnsiString;
    B: Boolean); overload; stdcall;
   procedure WriteDateTime(const Alias: AnsiString;
    DT: TDateTime); overload; stdcall;
   procedure WriteInteger(const Alias: AnsiString;
    I: Integer); overload; stdcall;
   procedure WriteString(const Alias: AnsiString;
    const S: AnsiString); overload; stdcall;
   function Get_Section: AnsiString; stdcall;
   procedure Set_Section(const aValue: AnsiString); stdcall;
   function Get_DefaultValuesOperation: Boolean;
   procedure Set_DefaultValuesOperation(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aSettings: IvcmSettings = nil); reintroduce;
   function Get_Section: AnsiString;
   function ReadBool(const Alias: AnsiString;
    Default: Boolean): Boolean; overload;
   function ReadDateTime(const Alias: AnsiString;
    Default: TDateTime): TDateTime; overload;
   function ReadInteger(const Alias: AnsiString;
    Default: Integer): Integer; overload;
   function ReadString(const Alias: AnsiString;
    const Default: AnsiString): Il3CString; overload;
   procedure Set_Section(const Value: AnsiString);
   function WriteBool(const Alias: AnsiString;
    Default: Boolean): Boolean; overload;
   procedure WriteDateTime(const Alias: AnsiString;
    DT: TDateTime); overload;
   procedure WriteInteger(const Alias: AnsiString;
    I: Integer); overload;
   procedure WriteString(const Alias: AnsiString;
    const S: AnsiString); overload;
 end;//TnsConfigStorage

 TstgTextSelection = class(TddComboBoxConfigItem)
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstgTextSelection

 TstgShowVersionComments = class(TddComboBoxConfigItem)
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstgShowVersionComments

 TstgShortList = class(TddComboBoxConfigItem)
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstgShortList

 TstgConfirmationItem = class(TddBooleanConfigItem)
  {* для работы с подтверждениями. "Всегда спрашивать", "Да" перемапируется в значения mrNone, mrOk }
  public
   constructor Create(const aAlias: AnsiString;
    const aCaption: AnsiString;
    aDefaultResult: TModalResult;
    const aDefaultValue: TddConfigValue;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
 end;//TstgConfirmationItem

 TstgNavigatorFormPosition = class(TddComboBoxConfigItem)
  {* класс для сохранения позиции форм встраиваемых в область навиагатора }
  private
   f_FloatingValue: Boolean;
    {* Поле для свойства FloatingValue }
   f_ZoneValue: Il3CString;
    {* Поле для свойства ZoneValue }
  protected
   procedure pm_SetFloatingValue(aValue: Boolean);
   procedure pm_SetZoneValue(const aValue: Il3CString);
   function pm_GetZoneSetting: AnsiString;
   function pm_GetFloatingSetting: AnsiString;
   function GetAliasName: AnsiString; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aFormSetting: AnsiString;
    const aCaption: AnsiString;
    aMasterItem: TddBaseConfigItem = nil); reintroduce;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
  public
   property FloatingValue: Boolean
    read f_FloatingValue
    write pm_SetFloatingValue;
   property ZoneValue: Il3CString
    read f_ZoneValue
    write pm_SetZoneValue;
   property ZoneSetting: AnsiString
    read pm_GetZoneSetting;
   property FloatingSetting: AnsiString
    read pm_GetFloatingSetting;
 end;//TstgNavigatorFormPosition

 TstgScalePicture = class(TddComboBoxConfigItem)
  private
   f_SavedValue: TddConfigValue;
  private
   function CheckValue: Boolean;
    {* Были ли исправлены ошибки: true - ошибки были }
  protected
   procedure DoExit; override;
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
   procedure LoadValue(const aStorage: IddConfigStorage); override;
   procedure SaveValue(const aStorage: IddConfigStorage); override;
   procedure GetValueFromControl; override;
 end;//TstgScalePicture

 TstgFilterFormPosition = class(TstgNavigatorFormPosition)
  protected
   function GetAliasName: AnsiString; override;
 end;//TstgFilterFormPosition

 TnsButtonCaptionArray = array [TMsgDlgBtn] of PvcmStringID;

 _afwSettingChanged_Parent_ = TnsEditSettingsInfo;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}
 TnsConfigSettingsInfo = class(_afwSettingChanged_, InsConfigNotificationSource, InsConfigSettingsInfo)
  protected
   function DoSettingChanged(const aSettingId: TafwSettingId): Boolean; override;
    {* Обработчик изменения указанной настройки }
 end;//TnsConfigSettingsInfo

 TstgVersionCommentLinkBehaviour = class(TddComboBoxConfigItem)
  {* [requestlink:513615258] }
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstgVersionCommentLinkBehaviour
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsAppConfigRes
 , nsConfigurationProperties
 , afwFacade
 , afwSettingsChangePublisher
;

procedure EDuplicateConfName.pm_SetConfName(const aValue: AnsiString);
//#UC START# *523171D10106_4C4089A10092set_var*
//#UC END# *523171D10106_4C4089A10092set_var*
begin
//#UC START# *523171D10106_4C4089A10092set_impl*
 !!! Needs to be implemented !!!
//#UC END# *523171D10106_4C4089A10092set_impl*
end;//EDuplicateConfName.pm_SetConfName

procedure TnsHistoryItemsProperty.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_523172C0033F_var*
//#UC END# *52172CA801E3_523172C0033F_var*
begin
//#UC START# *52172CA801E3_523172C0033F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52172CA801E3_523172C0033F_impl*
end;//TnsHistoryItemsProperty.SaveValue

constructor TnsConfInfoNode.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 const aConfig: InsConfigSettingsInfo = nil);
//#UC START# *523173A40360_523172E8012E_var*
//#UC END# *523173A40360_523172E8012E_var*
begin
//#UC START# *523173A40360_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *523173A40360_523172E8012E_impl*
end;//TnsConfInfoNode.Create

procedure TnsConfInfoNode.OnResize(Sender: TObject);
 {* подгоняем размеры полей ввода }
//#UC START# *523174570251_523172E8012E_var*
//#UC END# *523174570251_523172E8012E_var*
begin
//#UC START# *523174570251_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *523174570251_523172E8012E_impl*
end;//TnsConfInfoNode.OnResize

procedure TnsConfInfoNode.OnChangeName(Sender: TObject);
//#UC START# *5231746A03DE_523172E8012E_var*
//#UC END# *5231746A03DE_523172E8012E_var*
begin
//#UC START# *5231746A03DE_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231746A03DE_523172E8012E_impl*
end;//TnsConfInfoNode.OnChangeName

procedure TnsConfInfoNode.OnChangeHint(Sender: TObject);
//#UC START# *52317475018A_523172E8012E_var*
//#UC END# *52317475018A_523172E8012E_var*
begin
//#UC START# *52317475018A_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317475018A_523172E8012E_impl*
end;//TnsConfInfoNode.OnChangeHint

procedure TnsConfInfoNode.SetEditsWidth;
//#UC START# *523174880004_523172E8012E_var*
//#UC END# *523174880004_523172E8012E_var*
begin
//#UC START# *523174880004_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *523174880004_523172E8012E_impl*
end;//TnsConfInfoNode.SetEditsWidth

function TnsConfInfoNode.pm_GetChanged: Boolean;
//#UC START# *5216208C03CD_523172E8012Eget_var*
//#UC END# *5216208C03CD_523172E8012Eget_var*
begin
//#UC START# *5216208C03CD_523172E8012Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5216208C03CD_523172E8012Eget_impl*
end;//TnsConfInfoNode.pm_GetChanged

procedure TnsConfInfoNode.DoClearControls;
//#UC START# *521B285C035B_523172E8012E_var*
//#UC END# *521B285C035B_523172E8012E_var*
begin
//#UC START# *521B285C035B_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B285C035B_523172E8012E_impl*
end;//TnsConfInfoNode.DoClearControls

function TnsConfInfoNode.DoCreateFrame(aOwner: TComponent;
 aTag: Integer): TCustomFrame;
//#UC START# *521B28760177_523172E8012E_var*
//#UC END# *521B28760177_523172E8012E_var*
begin
//#UC START# *521B28760177_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B28760177_523172E8012E_impl*
end;//TnsConfInfoNode.DoCreateFrame

procedure TnsConfInfoNode.DoGetControlValues;
//#UC START# *521B28BE015D_523172E8012E_var*
//#UC END# *521B28BE015D_523172E8012E_var*
begin
//#UC START# *521B28BE015D_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B28BE015D_523172E8012E_impl*
end;//TnsConfInfoNode.DoGetControlValues

function TnsConfInfoNode.DoIsItem(aItem: TObject): Boolean;
//#UC START# *521B28D60001_523172E8012E_var*
//#UC END# *521B28D60001_523172E8012E_var*
begin
//#UC START# *521B28D60001_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B28D60001_523172E8012E_impl*
end;//TnsConfInfoNode.DoIsItem

procedure TnsConfInfoNode.DoLoad(const aStorage: IddConfigStorage);
//#UC START# *521B28F40355_523172E8012E_var*
//#UC END# *521B28F40355_523172E8012E_var*
begin
//#UC START# *521B28F40355_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B28F40355_523172E8012E_impl*
end;//TnsConfInfoNode.DoLoad

procedure TnsConfInfoNode.DoSave(const aStorage: IddConfigStorage);
//#UC START# *521B295A024F_523172E8012E_var*
//#UC END# *521B295A024F_523172E8012E_var*
begin
//#UC START# *521B295A024F_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B295A024F_523172E8012E_impl*
end;//TnsConfInfoNode.DoSave

procedure TnsConfInfoNode.DoSetControlValues(aDefault: Boolean);
//#UC START# *521B298800F7_523172E8012E_var*
//#UC END# *521B298800F7_523172E8012E_var*
begin
//#UC START# *521B298800F7_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B298800F7_523172E8012E_impl*
end;//TnsConfInfoNode.DoSetControlValues

procedure TnsConfInfoNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_523172E8012E_var*
//#UC END# *479731C50290_523172E8012E_var*
begin
//#UC START# *479731C50290_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_523172E8012E_impl*
end;//TnsConfInfoNode.Cleanup

function TnsConfInfoNode.pm_GetChanged: Boolean;
//#UC START# *5217205002F2_523172E8012Eget_var*
//#UC END# *5217205002F2_523172E8012Eget_var*
begin
//#UC START# *5217205002F2_523172E8012Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5217205002F2_523172E8012Eget_impl*
end;//TnsConfInfoNode.pm_GetChanged

procedure TnsConfInfoNode.pm_SetChanged(aValue: Boolean);
//#UC START# *5217205002F2_523172E8012Eset_var*
//#UC END# *5217205002F2_523172E8012Eset_var*
begin
//#UC START# *5217205002F2_523172E8012Eset_impl*
 !!! Needs to be implemented !!!
//#UC END# *5217205002F2_523172E8012Eset_impl*
end;//TnsConfInfoNode.pm_SetChanged

function TnsConfInfoNode.pm_GetValue: TddConfigValue;
//#UC START# *521725130281_523172E8012Eget_var*
//#UC END# *521725130281_523172E8012Eget_var*
begin
//#UC START# *521725130281_523172E8012Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *521725130281_523172E8012Eget_impl*
end;//TnsConfInfoNode.pm_GetValue

procedure TnsConfInfoNode.pm_SetValue(const aValue: TddConfigValue);
//#UC START# *521725130281_523172E8012Eset_var*
//#UC END# *521725130281_523172E8012Eset_var*
begin
//#UC START# *521725130281_523172E8012Eset_impl*
 !!! Needs to be implemented !!!
//#UC END# *521725130281_523172E8012Eset_impl*
end;//TnsConfInfoNode.pm_SetValue

procedure TnsConfInfoNode.DoFrameSize(aParent: TWinControl;
 out aHeight: Integer;
 out aWidth: Integer);
//#UC START# *521B28930009_523172E8012E_var*
//#UC END# *521B28930009_523172E8012E_var*
begin
//#UC START# *521B28930009_523172E8012E_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B28930009_523172E8012E_impl*
end;//TnsConfInfoNode.DoFrameSize

function TnsAppConfig.pm_GetIsNeedReinsertForms: Boolean;
//#UC START# *523175090090_523174C5029Fget_var*
//#UC END# *523175090090_523174C5029Fget_var*
begin
//#UC START# *523175090090_523174C5029Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *523175090090_523174C5029Fget_impl*
end;//TnsAppConfig.pm_GetIsNeedReinsertForms

function TnsAppConfig.IsSettingsChanged: Boolean;
//#UC START# *5231753901C8_523174C5029F_var*
//#UC END# *5231753901C8_523174C5029F_var*
begin
//#UC START# *5231753901C8_523174C5029F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231753901C8_523174C5029F_impl*
end;//TnsAppConfig.IsSettingsChanged

constructor TnsConfigStorage.Create(const aSettings: IvcmSettings = nil);
//#UC START# *523179500308_5231773202A8_var*
//#UC END# *523179500308_5231773202A8_var*
begin
//#UC START# *523179500308_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *523179500308_5231773202A8_impl*
end;//TnsConfigStorage.Create

function TnsConfigStorage.Get_Section: AnsiString;
//#UC START# *52317AB50172_5231773202A8_var*
//#UC END# *52317AB50172_5231773202A8_var*
begin
//#UC START# *52317AB50172_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317AB50172_5231773202A8_impl*
end;//TnsConfigStorage.Get_Section

function TnsConfigStorage.ReadBool(const Alias: AnsiString;
 Default: Boolean): Boolean;
//#UC START# *52317AC701C4_5231773202A8_var*
//#UC END# *52317AC701C4_5231773202A8_var*
begin
//#UC START# *52317AC701C4_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317AC701C4_5231773202A8_impl*
end;//TnsConfigStorage.ReadBool

function TnsConfigStorage.ReadDateTime(const Alias: AnsiString;
 Default: TDateTime): TDateTime;
//#UC START# *52317AD0002A_5231773202A8_var*
//#UC END# *52317AD0002A_5231773202A8_var*
begin
//#UC START# *52317AD0002A_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317AD0002A_5231773202A8_impl*
end;//TnsConfigStorage.ReadDateTime

function TnsConfigStorage.ReadInteger(const Alias: AnsiString;
 Default: Integer): Integer;
//#UC START# *52317AD901D9_5231773202A8_var*
//#UC END# *52317AD901D9_5231773202A8_var*
begin
//#UC START# *52317AD901D9_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317AD901D9_5231773202A8_impl*
end;//TnsConfigStorage.ReadInteger

function TnsConfigStorage.ReadString(const Alias: AnsiString;
 const Default: AnsiString): Il3CString;
//#UC START# *52317AE302F7_5231773202A8_var*
//#UC END# *52317AE302F7_5231773202A8_var*
begin
//#UC START# *52317AE302F7_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317AE302F7_5231773202A8_impl*
end;//TnsConfigStorage.ReadString

procedure TnsConfigStorage.Set_Section(const Value: AnsiString);
//#UC START# *52317AF50243_5231773202A8_var*
//#UC END# *52317AF50243_5231773202A8_var*
begin
//#UC START# *52317AF50243_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317AF50243_5231773202A8_impl*
end;//TnsConfigStorage.Set_Section

function TnsConfigStorage.WriteBool(const Alias: AnsiString;
 Default: Boolean): Boolean;
//#UC START# *52317B0E02E2_5231773202A8_var*
//#UC END# *52317B0E02E2_5231773202A8_var*
begin
//#UC START# *52317B0E02E2_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317B0E02E2_5231773202A8_impl*
end;//TnsConfigStorage.WriteBool

procedure TnsConfigStorage.WriteDateTime(const Alias: AnsiString;
 DT: TDateTime);
//#UC START# *52317B20018F_5231773202A8_var*
//#UC END# *52317B20018F_5231773202A8_var*
begin
//#UC START# *52317B20018F_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317B20018F_5231773202A8_impl*
end;//TnsConfigStorage.WriteDateTime

procedure TnsConfigStorage.WriteInteger(const Alias: AnsiString;
 I: Integer);
//#UC START# *52317B2E02A0_5231773202A8_var*
//#UC END# *52317B2E02A0_5231773202A8_var*
begin
//#UC START# *52317B2E02A0_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317B2E02A0_5231773202A8_impl*
end;//TnsConfigStorage.WriteInteger

procedure TnsConfigStorage.WriteString(const Alias: AnsiString;
 const S: AnsiString);
//#UC START# *52317B3B0388_5231773202A8_var*
//#UC END# *52317B3B0388_5231773202A8_var*
begin
//#UC START# *52317B3B0388_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52317B3B0388_5231773202A8_impl*
end;//TnsConfigStorage.WriteString

function TnsConfigStorage.ReadBool(const Alias: AnsiString;
 Default: Boolean): Boolean;
//#UC START# *51D51983016F_5231773202A8_var*
//#UC END# *51D51983016F_5231773202A8_var*
begin
//#UC START# *51D51983016F_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D51983016F_5231773202A8_impl*
end;//TnsConfigStorage.ReadBool

function TnsConfigStorage.ReadDateTime(const Alias: AnsiString;
 Default: TDateTime): TDateTime;
//#UC START# *51D519A40189_5231773202A8_var*
//#UC END# *51D519A40189_5231773202A8_var*
begin
//#UC START# *51D519A40189_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D519A40189_5231773202A8_impl*
end;//TnsConfigStorage.ReadDateTime

function TnsConfigStorage.ReadInteger(const Alias: AnsiString;
 Default: Integer): Integer;
//#UC START# *51D519B403D0_5231773202A8_var*
//#UC END# *51D519B403D0_5231773202A8_var*
begin
//#UC START# *51D519B403D0_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D519B403D0_5231773202A8_impl*
end;//TnsConfigStorage.ReadInteger

function TnsConfigStorage.ReadString(const Alias: AnsiString;
 const Default: AnsiString): Il3CString;
//#UC START# *51D519D00291_5231773202A8_var*
//#UC END# *51D519D00291_5231773202A8_var*
begin
//#UC START# *51D519D00291_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D519D00291_5231773202A8_impl*
end;//TnsConfigStorage.ReadString

procedure TnsConfigStorage.WriteBool(const Alias: AnsiString;
 B: Boolean);
//#UC START# *51D519FC00D5_5231773202A8_var*
//#UC END# *51D519FC00D5_5231773202A8_var*
begin
//#UC START# *51D519FC00D5_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D519FC00D5_5231773202A8_impl*
end;//TnsConfigStorage.WriteBool

procedure TnsConfigStorage.WriteDateTime(const Alias: AnsiString;
 DT: TDateTime);
//#UC START# *51D51A0D0133_5231773202A8_var*
//#UC END# *51D51A0D0133_5231773202A8_var*
begin
//#UC START# *51D51A0D0133_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D51A0D0133_5231773202A8_impl*
end;//TnsConfigStorage.WriteDateTime

procedure TnsConfigStorage.WriteInteger(const Alias: AnsiString;
 I: Integer);
//#UC START# *51D51A1E025E_5231773202A8_var*
//#UC END# *51D51A1E025E_5231773202A8_var*
begin
//#UC START# *51D51A1E025E_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D51A1E025E_5231773202A8_impl*
end;//TnsConfigStorage.WriteInteger

procedure TnsConfigStorage.WriteString(const Alias: AnsiString;
 const S: AnsiString);
//#UC START# *51D51A3201BA_5231773202A8_var*
//#UC END# *51D51A3201BA_5231773202A8_var*
begin
//#UC START# *51D51A3201BA_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D51A3201BA_5231773202A8_impl*
end;//TnsConfigStorage.WriteString

function TnsConfigStorage.Get_Section: AnsiString;
//#UC START# *51D51A48025D_5231773202A8get_var*
//#UC END# *51D51A48025D_5231773202A8get_var*
begin
//#UC START# *51D51A48025D_5231773202A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D51A48025D_5231773202A8get_impl*
end;//TnsConfigStorage.Get_Section

procedure TnsConfigStorage.Set_Section(const aValue: AnsiString);
//#UC START# *51D51A48025D_5231773202A8set_var*
//#UC END# *51D51A48025D_5231773202A8set_var*
begin
//#UC START# *51D51A48025D_5231773202A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D51A48025D_5231773202A8set_impl*
end;//TnsConfigStorage.Set_Section

function TnsConfigStorage.Get_DefaultValuesOperation: Boolean;
//#UC START# *5231767E01D3_5231773202A8get_var*
//#UC END# *5231767E01D3_5231773202A8get_var*
begin
//#UC START# *5231767E01D3_5231773202A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231767E01D3_5231773202A8get_impl*
end;//TnsConfigStorage.Get_DefaultValuesOperation

procedure TnsConfigStorage.Set_DefaultValuesOperation(aValue: Boolean);
//#UC START# *5231767E01D3_5231773202A8set_var*
//#UC END# *5231767E01D3_5231773202A8set_var*
begin
//#UC START# *5231767E01D3_5231773202A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231767E01D3_5231773202A8set_impl*
end;//TnsConfigStorage.Set_DefaultValuesOperation

procedure TnsConfigStorage.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5231773202A8_var*
//#UC END# *479731C50290_5231773202A8_var*
begin
//#UC START# *479731C50290_5231773202A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_5231773202A8_impl*
end;//TnsConfigStorage.Cleanup

constructor TstgTextSelection.Create(aMasterItem: TddBaseConfigItem = nil);
//#UC START# *523180FA00BB_523180E30271_var*
//#UC END# *523180FA00BB_523180E30271_var*
begin
//#UC START# *523180FA00BB_523180E30271_impl*
 !!! Needs to be implemented !!!
//#UC END# *523180FA00BB_523180E30271_impl*
end;//TstgTextSelection.Create

constructor TstgShowVersionComments.Create(aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5231812F0159_5231811400D7_var*
//#UC END# *5231812F0159_5231811400D7_var*
begin
//#UC START# *5231812F0159_5231811400D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231812F0159_5231811400D7_impl*
end;//TstgShowVersionComments.Create

constructor TstgShortList.Create(aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5231815901FC_52318145015D_var*
//#UC END# *5231815901FC_52318145015D_var*
begin
//#UC START# *5231815901FC_52318145015D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231815901FC_52318145015D_impl*
end;//TstgShortList.Create

constructor TstgConfirmationItem.Create(const aAlias: AnsiString;
 const aCaption: AnsiString;
 aDefaultResult: TModalResult;
 const aDefaultValue: TddConfigValue;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5231820200C6_5231818801B4_var*
//#UC END# *5231820200C6_5231818801B4_var*
begin
//#UC START# *5231820200C6_5231818801B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231820200C6_5231818801B4_impl*
end;//TstgConfirmationItem.Create

procedure TstgConfirmationItem.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_5231818801B4_var*
//#UC END# *52172B72014C_5231818801B4_var*
begin
//#UC START# *52172B72014C_5231818801B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52172B72014C_5231818801B4_impl*
end;//TstgConfirmationItem.LoadValue

procedure TstgConfirmationItem.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_5231818801B4_var*
//#UC END# *52172CA801E3_5231818801B4_var*
begin
//#UC START# *52172CA801E3_5231818801B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52172CA801E3_5231818801B4_impl*
end;//TstgConfirmationItem.SaveValue

procedure TstgNavigatorFormPosition.pm_SetFloatingValue(aValue: Boolean);
//#UC START# *523182DE0307_523182220295set_var*
//#UC END# *523182DE0307_523182220295set_var*
begin
//#UC START# *523182DE0307_523182220295set_impl*
 !!! Needs to be implemented !!!
//#UC END# *523182DE0307_523182220295set_impl*
end;//TstgNavigatorFormPosition.pm_SetFloatingValue

procedure TstgNavigatorFormPosition.pm_SetZoneValue(const aValue: Il3CString);
//#UC START# *523182FF0327_523182220295set_var*
//#UC END# *523182FF0327_523182220295set_var*
begin
//#UC START# *523182FF0327_523182220295set_impl*
 !!! Needs to be implemented !!!
//#UC END# *523182FF0327_523182220295set_impl*
end;//TstgNavigatorFormPosition.pm_SetZoneValue

function TstgNavigatorFormPosition.pm_GetZoneSetting: AnsiString;
//#UC START# *523183A1003F_523182220295get_var*
//#UC END# *523183A1003F_523182220295get_var*
begin
//#UC START# *523183A1003F_523182220295get_impl*
 !!! Needs to be implemented !!!
//#UC END# *523183A1003F_523182220295get_impl*
end;//TstgNavigatorFormPosition.pm_GetZoneSetting

function TstgNavigatorFormPosition.pm_GetFloatingSetting: AnsiString;
//#UC START# *523183B70159_523182220295get_var*
//#UC END# *523183B70159_523182220295get_var*
begin
//#UC START# *523183B70159_523182220295get_impl*
 !!! Needs to be implemented !!!
//#UC END# *523183B70159_523182220295get_impl*
end;//TstgNavigatorFormPosition.pm_GetFloatingSetting

constructor TstgNavigatorFormPosition.Create(const aFormSetting: AnsiString;
 const aCaption: AnsiString;
 aMasterItem: TddBaseConfigItem = nil);
//#UC START# *52318340035D_523182220295_var*
//#UC END# *52318340035D_523182220295_var*
begin
//#UC START# *52318340035D_523182220295_impl*
 !!! Needs to be implemented !!!
//#UC END# *52318340035D_523182220295_impl*
end;//TstgNavigatorFormPosition.Create

function TstgNavigatorFormPosition.GetAliasName: AnsiString;
//#UC START# *523183550370_523182220295_var*
//#UC END# *523183550370_523182220295_var*
begin
//#UC START# *523183550370_523182220295_impl*
 !!! Needs to be implemented !!!
//#UC END# *523183550370_523182220295_impl*
end;//TstgNavigatorFormPosition.GetAliasName

procedure TstgNavigatorFormPosition.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_523182220295_var*
//#UC END# *479731C50290_523182220295_var*
begin
//#UC START# *479731C50290_523182220295_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_523182220295_impl*
end;//TstgNavigatorFormPosition.Cleanup

procedure TstgNavigatorFormPosition.ClearFields;
begin
 ZoneValue := nil;
 inherited;
end;//TstgNavigatorFormPosition.ClearFields

procedure TstgNavigatorFormPosition.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_523182220295_var*
//#UC END# *52172B72014C_523182220295_var*
begin
//#UC START# *52172B72014C_523182220295_impl*
 !!! Needs to be implemented !!!
//#UC END# *52172B72014C_523182220295_impl*
end;//TstgNavigatorFormPosition.LoadValue

procedure TstgNavigatorFormPosition.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_523182220295_var*
//#UC END# *52172CA801E3_523182220295_var*
begin
//#UC START# *52172CA801E3_523182220295_impl*
 !!! Needs to be implemented !!!
//#UC END# *52172CA801E3_523182220295_impl*
end;//TstgNavigatorFormPosition.SaveValue

function TstgScalePicture.CheckValue: Boolean;
 {* Были ли исправлены ошибки: true - ошибки были }
//#UC START# *5231842D0096_523183F100D3_var*
//#UC END# *5231842D0096_523183F100D3_var*
begin
//#UC START# *5231842D0096_523183F100D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231842D0096_523183F100D3_impl*
end;//TstgScalePicture.CheckValue

constructor TstgScalePicture.Create(aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5231846102D6_523183F100D3_var*
//#UC END# *5231846102D6_523183F100D3_var*
begin
//#UC START# *5231846102D6_523183F100D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5231846102D6_523183F100D3_impl*
end;//TstgScalePicture.Create

procedure TstgScalePicture.LoadValue(const aStorage: IddConfigStorage);
//#UC START# *52172B72014C_523183F100D3_var*
//#UC END# *52172B72014C_523183F100D3_var*
begin
//#UC START# *52172B72014C_523183F100D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52172B72014C_523183F100D3_impl*
end;//TstgScalePicture.LoadValue

procedure TstgScalePicture.SaveValue(const aStorage: IddConfigStorage);
//#UC START# *52172CA801E3_523183F100D3_var*
//#UC END# *52172CA801E3_523183F100D3_var*
begin
//#UC START# *52172CA801E3_523183F100D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52172CA801E3_523183F100D3_impl*
end;//TstgScalePicture.SaveValue

procedure TstgScalePicture.GetValueFromControl;
//#UC START# *521B058801FD_523183F100D3_var*
//#UC END# *521B058801FD_523183F100D3_var*
begin
//#UC START# *521B058801FD_523183F100D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *521B058801FD_523183F100D3_impl*
end;//TstgScalePicture.GetValueFromControl

procedure TstgScalePicture.DoExit;
//#UC START# *522599F1033C_523183F100D3_var*
//#UC END# *522599F1033C_523183F100D3_var*
begin
//#UC START# *522599F1033C_523183F100D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *522599F1033C_523183F100D3_impl*
end;//TstgScalePicture.DoExit

function TstgFilterFormPosition.GetAliasName: AnsiString;
//#UC START# *523183550370_523184C702AE_var*
//#UC END# *523183550370_523184C702AE_var*
begin
//#UC START# *523183550370_523184C702AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *523183550370_523184C702AE_impl*
end;//TstgFilterFormPosition.GetAliasName

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}

function TnsConfigSettingsInfo.DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
 {* Обработчик изменения указанной настройки }
//#UC START# *47EA863A035C_523185C200C7_var*
//#UC END# *47EA863A035C_523185C200C7_var*
begin
//#UC START# *47EA863A035C_523185C200C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47EA863A035C_523185C200C7_impl*
end;//TnsConfigSettingsInfo.DoSettingChanged

constructor TstgVersionCommentLinkBehaviour.Create(aMasterItem: TddBaseConfigItem = nil);
//#UC START# *53A0448D00B6_53A0441300B9_var*
//#UC END# *53A0448D00B6_53A0441300B9_var*
begin
//#UC START# *53A0448D00B6_53A0441300B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *53A0448D00B6_53A0441300B9_impl*
end;//TstgVersionCommentLinkBehaviour.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
