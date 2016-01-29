unit kwConfigurationActivate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationActivate.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::configuration_Activate
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
  kwConfigurationWord,
  SettingsUnit,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwConfigurationActivate = {final scriptword} class(TkwConfigurationWord)
 protected
 // realized methods
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationActivate
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsConfigurationList
  {$IfEnd} //not Admin AND not Monitorings
  ,
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationActivate

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
 {-}
begin
 Result := 'configuration:Activate';
end;//TkwConfigurationActivate.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация configuration_Activate
 TkwConfigurationActivate.RegisterInEngine;
{$IfEnd} //not NoScripts

end.