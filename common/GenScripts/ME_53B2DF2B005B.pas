unit kwConfigurationsGetConfiguration;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsGetConfiguration.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwConfigurationsWord
 , tfwScriptingInterfaces
;

type
 TkwConfigurationsGetConfiguration = {final} class(TkwConfigurationsWord)
  protected
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetConfiguration
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
 , SettingsUnit
;

procedure TkwConfigurationsGetConfiguration.DoWithConfigurations(const aCtx: TtfwContext);
//#UC START# *53B2E1D201CE_53B2DF2B005B_var*
var
 l_C: IConfigurations;
 l_Res: IConfiguration;
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

initialization
 TkwConfigurationsGetConfiguration.RegisterInEngine;
 {* Регистрация configurations_GetConfiguration }
{$IfEnd} // NOT Defined(NoScripts)

end.
