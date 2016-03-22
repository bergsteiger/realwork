unit kwConfigurationsGetActiveConfiguration;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsGetActiveConfiguration.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "configurations_GetActiveConfiguration" MUID: (53B2DF81021D)
// Имя типа: "TkwConfigurationsGetActiveConfiguration"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwConfigurationsWord
 , tfwScriptingInterfaces
;

type
 TkwConfigurationsGetActiveConfiguration = {final} class(TkwConfigurationsWord)
  protected
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetActiveConfiguration
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
 , SettingsUnit
;

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

initialization
 TkwConfigurationsGetActiveConfiguration.RegisterInEngine;
 {* Регистрация configurations_GetActiveConfiguration }
{$IfEnd} // NOT Defined(NoScripts)

end.
