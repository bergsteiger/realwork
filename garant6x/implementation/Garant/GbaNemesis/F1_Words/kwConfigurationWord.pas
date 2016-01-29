unit kwConfigurationWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationWord.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::ConfigurationWord
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
  SettingsUnit,
  tfwScriptingInterfaces,
  kwConfigurationsWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwConfigurationWord = {abstract scriptword} class(TkwConfigurationsWord)
 protected
 // realized methods
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
 protected
 // protected methods
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwConfigurationWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationWord

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

{$IfEnd} //not NoScripts

end.