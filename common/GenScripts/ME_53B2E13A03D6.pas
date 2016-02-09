unit kwConfigurationWord;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationWord.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwConfigurationsWord
 , SettingsUnit
 , tfwScriptingInterfaces
;

type
 TkwConfigurationWord = {abstract} class(TkwConfigurationsWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoWithConfigurations(const aCtx: TtfwContext); override;
 end;//TkwConfigurationWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , DataAdapter
;

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
{$IfEnd} // NOT Defined(NoScripts)

end.
