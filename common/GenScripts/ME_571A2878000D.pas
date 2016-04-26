unit PrimConfigurationListWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\PrimConfigurationListWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "PrimConfigurationListWordsPack" MUID: (571A2878000D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571A2878000Dintf_uses*
 //#UC END# *571A2878000Dintf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , SettingsUnit
 , nsConfigurationList
 , nsStyleEditor
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , DataAdapter
 , IOUnit
 , nsTypes
 , SysUtils
 , bsUtils
 , l3DateSt
 , bsConvert
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , tfwTypeRegistrator
 , tfwScriptingTypes
 //#UC START# *571A2878000Dimpl_uses*
 //#UC END# *571A2878000Dimpl_uses*
;

type
 TkwConfigRestore = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigRestore

 TkwStyleTableRestore = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwStyleTableRestore

 TkwGetEncryptedComplectId = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwGetEncryptedComplectId

 TkwConfigurationsWord = {abstract} class(TtfwRegisterableWord)
  private
   f_ConfigurationManager: IConfigurationManager;
  protected
   procedure DoWithConfigurations(const aCtx: TtfwContext); virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure ClearFields; override;
  protected
   property ConfigurationManager: IConfigurationManager
    read f_ConfigurationManager;
 end;//TkwConfigurationsWord

 TkwConfigurationsGetCount = {final} class(TkwConfigurationsWord)
  protected
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetCount

 TkwConfigurationWord = {abstract} class(TkwConfigurationsWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
 end;//TkwConfigurationWord

 TkwConfigurationsGetConfiguration = {final} class(TkwConfigurationsWord)
  protected
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetConfiguration

 TkwConfigurationsGetActiveConfiguration = {final} class(TkwConfigurationsWord)
  protected
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetActiveConfiguration

 TkwConfigurationGetID = {final} class(TkwConfigurationWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetID

 TkwConfigurationActivate = {final} class(TkwConfigurationWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationActivate

 TkwConfigurationGetName = {final} class(TkwConfigurationWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetName

 TkwConfigurationGetType = {final} class(TkwConfigurationWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetType

 TkwRestoreSettings = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwRestoreSettings

 TkwF1BaseDate = {final} class(TtfwRegisterableWord)
  {* Кладёт на стек дату базы в строковом формате }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1BaseDate

 TkwF1ComplectName = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ComplectName

 TkwF1ComplectOwner = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ComplectOwner

 TkwTimeMachineSetDate = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTimeMachineSetDate

 TkwExportHelp = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwExportHelp

procedure TkwConfigRestore.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68C9020275_var*
//#UC END# *4DAEEDE10285_4E68C9020275_var*
begin
//#UC START# *4DAEEDE10285_4E68C9020275_impl*
 ConfigurationList.ActiveConfig.Load(true);
//#UC END# *4DAEEDE10285_4E68C9020275_impl*
end;//TkwConfigRestore.DoDoIt

class function TkwConfigRestore.GetWordNameForRegister: AnsiString;
begin
 Result := 'Config:Restore';
end;//TkwConfigRestore.GetWordNameForRegister

procedure TkwStyleTableRestore.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68D33202D5_var*
//#UC END# *4DAEEDE10285_4E68D33202D5_var*
begin
//#UC START# *4DAEEDE10285_4E68D33202D5_impl*
 TnsStyleTableSettingsInfo.Make(ConfigurationList.ActiveConfig.Configuration).Load(true);
//#UC END# *4DAEEDE10285_4E68D33202D5_impl*
end;//TkwStyleTableRestore.DoDoIt

class function TkwStyleTableRestore.GetWordNameForRegister: AnsiString;
begin
 Result := 'StyleTable:Restore';
end;//TkwStyleTableRestore.GetWordNameForRegister

procedure TkwGetEncryptedComplectId.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_51AEF36002D1_var*
var
 l_Id: IString;
//#UC END# *4DAEEDE10285_51AEF36002D1_var*
begin
//#UC START# *4DAEEDE10285_51AEF36002D1_impl*
 DefDataAdapter.CommonInterfaces.GetEncryptedComplectId(l_Id);
 aCtx.rEngine.PushString(nsCStr(l_Id));
//#UC END# *4DAEEDE10285_51AEF36002D1_impl*
end;//TkwGetEncryptedComplectId.DoDoIt

class function TkwGetEncryptedComplectId.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetEncryptedComplectId';
end;//TkwGetEncryptedComplectId.GetWordNameForRegister

procedure TkwConfigurationsWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B2E10F03C0_var*
//#UC END# *4DAEEDE10285_53B2E10F03C0_var*
begin
//#UC START# *4DAEEDE10285_53B2E10F03C0_impl*
 f_ConfigurationManager := DefDataAdapter.NativeAdapter.MakeConfigurationManager;
 try
  DoWithConfigurations(aCtx);
 finally
  f_ConfigurationManager := nil;
 end;
//#UC END# *4DAEEDE10285_53B2E10F03C0_impl*
end;//TkwConfigurationsWord.DoDoIt

procedure TkwConfigurationsWord.ClearFields;
begin
 f_ConfigurationManager := nil;
 inherited;
end;//TkwConfigurationsWord.ClearFields

procedure TkwConfigurationsGetCount.DoWithConfigurations(const aCtx: TtfwContext);
//#UC START# *53B2E1D201CE_53B2DE010174_var*
var
 l_C: IConfigurations;
//#UC END# *53B2E1D201CE_53B2DE010174_var*
begin
//#UC START# *53B2E1D201CE_53B2DE010174_impl*
 ConfigurationManager.GetConfigurations(l_C);
 try
  aCtx.rEngine.PushInt(l_C.Count);
 finally
  l_C := nil;
 end;
//#UC END# *53B2E1D201CE_53B2DE010174_impl*
end;//TkwConfigurationsGetCount.DoWithConfigurations

class function TkwConfigurationsGetCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'configurations:GetCount';
end;//TkwConfigurationsGetCount.GetWordNameForRegister

procedure TkwConfigurationWord.DoWithConfigurations(const aCtx: TtfwContext);
//#UC START# *53B2E1D201CE_53B2E13A03D6_var*
var
 l_Unk: IUnknown;
 l_Conf: IConfiguration;
//#UC END# *53B2E1D201CE_53B2E13A03D6_var*
begin
//#UC START# *53B2E1D201CE_53B2E13A03D6_impl*
 RunnerAssert(aCtx.rEngine.IsTopIntf, 'Не передана конфигурация!', aCtx);
 l_Unk := aCtx.rEngine.PopIntf;
 if Supports(l_Unk, IConfiguration, l_Conf) then
  DoWithConfiguration(l_Conf, aCtx)
 else
  RunnerAssert(False, 'Не передана конфигурация!', aCtx);
//#UC END# *53B2E1D201CE_53B2E13A03D6_impl*
end;//TkwConfigurationWord.DoWithConfigurations

procedure TkwConfigurationsGetConfiguration.DoWithConfigurations(const aCtx: TtfwContext);
//#UC START# *53B2E1D201CE_53B2DF2B005B_var*
//#UC END# *53B2E1D201CE_53B2DF2B005B_var*
begin
//#UC START# *53B2E1D201CE_53B2DF2B005B_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, 'Не указан номер конфигурации!', aCtx);
 ConfigurationManager.GetConfigurations(l_C);
 try
  l_C.pm_GetItem(aCtx.rEngine.PopInt, l_Res);
  aCtx.rEngine.PushIntf(l_Res, TypeInfo(IConfiguration));
 finally
  l_C := nil;
  l_Res := nil;
 end;
//#UC END# *53B2E1D201CE_53B2DF2B005B_impl*
end;//TkwConfigurationsGetConfiguration.DoWithConfigurations

class function TkwConfigurationsGetConfiguration.GetWordNameForRegister: AnsiString;
begin
 Result := 'configurations:GetConfiguration';
end;//TkwConfigurationsGetConfiguration.GetWordNameForRegister

procedure TkwConfigurationsGetActiveConfiguration.DoWithConfigurations(const aCtx: TtfwContext);
//#UC START# *53B2E1D201CE_53B2DF81021D_var*
var
 l_C: IConfiguration;
//#UC END# *53B2E1D201CE_53B2DF81021D_var*
begin
//#UC START# *53B2E1D201CE_53B2DF81021D_impl*
 ConfigurationManager.GetActive(l_C);
 try
  aCtx.rEngine.PushIntf(l_C, TypeInfo(IConfiguration));
 finally
  l_C := nil;
 end;
//#UC END# *53B2E1D201CE_53B2DF81021D_impl*
end;//TkwConfigurationsGetActiveConfiguration.DoWithConfigurations

class function TkwConfigurationsGetActiveConfiguration.GetWordNameForRegister: AnsiString;
begin
 Result := 'configurations:GetActiveConfiguration';
end;//TkwConfigurationsGetActiveConfiguration.GetWordNameForRegister

procedure TkwConfigurationGetID.DoWithConfiguration(const aConfiguration: IConfiguration;
 const aCtx: TtfwContext);
//#UC START# *53B2E36A0075_53B2E3EF00C4_var*
//#UC END# *53B2E36A0075_53B2E3EF00C4_var*
begin
//#UC START# *53B2E36A0075_53B2E3EF00C4_impl*
 aCtx.rEngine.PushInt(aConfiguration.GetID);
//#UC END# *53B2E36A0075_53B2E3EF00C4_impl*
end;//TkwConfigurationGetID.DoWithConfiguration

class function TkwConfigurationGetID.GetWordNameForRegister: AnsiString;
begin
 Result := 'configuration:GetID';
end;//TkwConfigurationGetID.GetWordNameForRegister

procedure TkwConfigurationActivate.DoWithConfiguration(const aConfiguration: IConfiguration;
 const aCtx: TtfwContext);
//#UC START# *53B2E36A0075_53B2DF9903E3_var*
//#UC END# *53B2E36A0075_53B2DF9903E3_var*
begin
//#UC START# *53B2E36A0075_53B2DF9903E3_impl*
 ConfigurationList.ActivateConfig(aConfiguration);
//#UC END# *53B2E36A0075_53B2DF9903E3_impl*
end;//TkwConfigurationActivate.DoWithConfiguration

class function TkwConfigurationActivate.GetWordNameForRegister: AnsiString;
begin
 Result := 'configuration:Activate';
end;//TkwConfigurationActivate.GetWordNameForRegister

procedure TkwConfigurationGetName.DoWithConfiguration(const aConfiguration: IConfiguration;
 const aCtx: TtfwContext);
//#UC START# *53B2E36A0075_53B2DF500282_var*
var
 l_S: IString;
//#UC END# *53B2E36A0075_53B2DF500282_var*
begin
//#UC START# *53B2E36A0075_53B2DF500282_impl*
 aConfiguration.GetName(l_S);
 try
  aCtx.rEngine.PushString(nsCStr(l_S));
 finally
  l_S := nil;
 end;
//#UC END# *53B2E36A0075_53B2DF500282_impl*
end;//TkwConfigurationGetName.DoWithConfiguration

class function TkwConfigurationGetName.GetWordNameForRegister: AnsiString;
begin
 Result := 'configuration:GetName';
end;//TkwConfigurationGetName.GetWordNameForRegister

procedure TkwConfigurationGetType.DoWithConfiguration(const aConfiguration: IConfiguration;
 const aCtx: TtfwContext);
//#UC START# *53B2E36A0075_53B2DF6C00CA_var*
//#UC END# *53B2E36A0075_53B2DF6C00CA_var*
begin
//#UC START# *53B2E36A0075_53B2DF6C00CA_impl*
 aCtx.rEngine.PushInt(Ord(aConfiguration.GetType));
//#UC END# *53B2E36A0075_53B2DF6C00CA_impl*
end;//TkwConfigurationGetType.DoWithConfiguration

class function TkwConfigurationGetType.GetWordNameForRegister: AnsiString;
begin
 Result := 'configuration:GetType';
end;//TkwConfigurationGetType.GetWordNameForRegister

procedure TkwRestoreSettings.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_539834A703AD_var*
//#UC END# *4DAEEDE10285_539834A703AD_var*
begin
//#UC START# *4DAEEDE10285_539834A703AD_impl*
 ConfigurationList.ActiveConfig.RestoreAllSettings;
//#UC END# *4DAEEDE10285_539834A703AD_impl*
end;//TkwRestoreSettings.DoDoIt

class function TkwRestoreSettings.GetWordNameForRegister: AnsiString;
begin
 Result := 'RestoreSettings';
end;//TkwRestoreSettings.GetWordNameForRegister

procedure TkwF1BaseDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EC134690154_var*
//#UC END# *4DAEEDE10285_4EC134690154_var*
begin
//#UC START# *4DAEEDE10285_4EC134690154_impl*
 aCtx.rEngine.PushString(bsBaseDateStr);
//#UC END# *4DAEEDE10285_4EC134690154_impl*
end;//TkwF1BaseDate.DoDoIt

class function TkwF1BaseDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1:BaseDate';
end;//TkwF1BaseDate.GetWordNameForRegister

procedure TkwF1ComplectName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50237E1C0249_var*
//#UC END# *4DAEEDE10285_50237E1C0249_var*
begin
//#UC START# *4DAEEDE10285_50237E1C0249_impl*
 aCtx.rEngine.PushString(bsComplectName);
//#UC END# *4DAEEDE10285_50237E1C0249_impl*
end;//TkwF1ComplectName.DoDoIt

class function TkwF1ComplectName.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1:ComplectName';
end;//TkwF1ComplectName.GetWordNameForRegister

procedure TkwF1ComplectOwner.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50237E3A03A5_var*
//#UC END# *4DAEEDE10285_50237E3A03A5_var*
begin
//#UC START# *4DAEEDE10285_50237E3A03A5_impl*
 aCtx.rEngine.PushString(bsComplectOwner);
//#UC END# *4DAEEDE10285_50237E3A03A5_impl*
end;//TkwF1ComplectOwner.DoDoIt

class function TkwF1ComplectOwner.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1:ComplectOwner';
end;//TkwF1ComplectOwner.GetWordNameForRegister

procedure TkwTimeMachineSetDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DC3D8E200AF_var*
//#UC END# *4DAEEDE10285_4DC3D8E200AF_var*
begin
//#UC START# *4DAEEDE10285_4DC3D8E200AF_impl*
 DefDataAdapter.TimeMachine.Date := bsBusinessToAdapter(FlexStr2Date(aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_4DC3D8E200AF_impl*
end;//TkwTimeMachineSetDate.DoDoIt

class function TkwTimeMachineSetDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'timemachine:SetDate';
end;//TkwTimeMachineSetDate.GetWordNameForRegister

procedure TkwExportHelp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DD530DD03D8_var*
var
 l_S : String;
//#UC END# *4DAEEDE10285_4DD530DD03D8_var*
begin
//#UC START# *4DAEEDE10285_4DD530DD03D8_impl*
 l_S := aCtx.rCaller.ResolveOutputFilePath(aCtx.rEngine.PopDelphiString);
 (vcmDispatcher.FormDispatcher.CurrentMainForm.VCLWinControl As TvcmMainForm).DoExportHelp(l_S, false);
 aCtx.rCaller.CheckWithEtalon(l_S, #0);
//#UC END# *4DAEEDE10285_4DD530DD03D8_impl*
end;//TkwExportHelp.DoDoIt

class function TkwExportHelp.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:ExportHelp';
end;//TkwExportHelp.GetWordNameForRegister

initialization
 TkwConfigRestore.RegisterInEngine;
 {* Регистрация TkwConfigRestore }
 TkwStyleTableRestore.RegisterInEngine;
 {* Регистрация TkwStyleTableRestore }
 TkwGetEncryptedComplectId.RegisterInEngine;
 {* Регистрация GetEncryptedComplectId }
 TkwConfigurationsWord.RegisterClass;
 {* Регистрация ConfigurationsWord }
 TkwConfigurationsGetCount.RegisterInEngine;
 {* Регистрация configurations_GetCount }
 TkwConfigurationWord.RegisterClass;
 {* Регистрация ConfigurationWord }
 TkwConfigurationsGetConfiguration.RegisterInEngine;
 {* Регистрация configurations_GetConfiguration }
 TkwConfigurationsGetActiveConfiguration.RegisterInEngine;
 {* Регистрация configurations_GetActiveConfiguration }
 TkwConfigurationGetID.RegisterInEngine;
 {* Регистрация configuration_GetID }
 TkwConfigurationActivate.RegisterInEngine;
 {* Регистрация configuration_Activate }
 TkwConfigurationGetName.RegisterInEngine;
 {* Регистрация configuration_GetName }
 TkwConfigurationGetType.RegisterInEngine;
 {* Регистрация configuration_GetType }
 TkwRestoreSettings.RegisterInEngine;
 {* Регистрация RestoreSettings }
 TkwF1BaseDate.RegisterInEngine;
 {* Регистрация f1_BaseDate }
 TkwF1ComplectName.RegisterInEngine;
 {* Регистрация f1_ComplectName }
 TkwF1ComplectOwner.RegisterInEngine;
 {* Регистрация f1_ComplectOwner }
 TkwTimeMachineSetDate.RegisterInEngine;
 {* Регистрация TkwTimeMachineSetDate }
 TkwExportHelp.RegisterInEngine;
 {* Регистрация TkwExportHelp }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
