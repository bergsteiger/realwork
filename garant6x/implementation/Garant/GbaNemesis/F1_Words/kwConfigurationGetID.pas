unit kwConfigurationGetID;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationGetID.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::configuration_GetID
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
 TkwConfigurationGetID = {final scriptword} class(TkwConfigurationWord)
 protected
 // realized methods
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetID
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationGetID

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
 {-}
begin
 Result := 'configuration:GetID';
end;//TkwConfigurationGetID.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация configuration_GetID
 TkwConfigurationGetID.RegisterInEngine;
{$IfEnd} //not NoScripts

end.