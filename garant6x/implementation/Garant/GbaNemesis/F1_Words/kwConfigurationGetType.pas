unit kwConfigurationGetType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationGetType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::configuration_GetType
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
 TkwConfigurationGetType = {final scriptword} class(TkwConfigurationWord)
 protected
 // realized methods
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetType
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationGetType

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
 {-}
begin
 Result := 'configuration:GetType';
end;//TkwConfigurationGetType.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация configuration_GetType
 TkwConfigurationGetType.RegisterInEngine;
{$IfEnd} //not NoScripts

end.