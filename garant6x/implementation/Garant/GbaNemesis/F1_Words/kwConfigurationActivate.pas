unit kwConfigurationActivate;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationActivate.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "configuration_Activate" MUID: (53B2DF9903E3)
// Имя типа: "TkwConfigurationActivate"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwConfigurationWord
 , SettingsUnit
 , tfwScriptingInterfaces
;

type
 TkwConfigurationActivate = {final} class(TkwConfigurationWord)
  protected
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationActivate
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nsConfigurationList
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , DataAdapter
;

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

initialization
 TkwConfigurationActivate.RegisterInEngine;
 {* Регистрация configuration_Activate }
{$IfEnd} // NOT Defined(NoScripts)

end.
