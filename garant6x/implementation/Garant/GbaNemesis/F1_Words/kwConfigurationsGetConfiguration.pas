unit kwConfigurationsGetConfiguration;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationsGetConfiguration.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::configurations_GetConfiguration
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwConfigurationsWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwConfigurationsGetConfiguration = {final scriptword} class(TkwConfigurationsWord)
 protected
 // realized methods
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationsGetConfiguration
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter,
  SettingsUnit
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationsGetConfiguration

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
 {-}
begin
 Result := 'configurations:GetConfiguration';
end;//TkwConfigurationsGetConfiguration.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация configurations_GetConfiguration
 TkwConfigurationsGetConfiguration.RegisterInEngine;
{$IfEnd} //not NoScripts

end.