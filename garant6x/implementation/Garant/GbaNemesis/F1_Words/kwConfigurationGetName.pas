unit kwConfigurationGetName;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationGetName.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::configuration_GetName
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
 TkwConfigurationGetName = {final scriptword} class(TkwConfigurationWord)
 protected
 // realized methods
   procedure DoWithConfiguration(const aConfiguration: IConfiguration;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigurationGetName
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  IOUnit,
  nsTypes,
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigurationGetName

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
 {-}
begin
 Result := 'configuration:GetName';
end;//TkwConfigurationGetName.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация configuration_GetName
 TkwConfigurationGetName.RegisterInEngine;
{$IfEnd} //not NoScripts

end.