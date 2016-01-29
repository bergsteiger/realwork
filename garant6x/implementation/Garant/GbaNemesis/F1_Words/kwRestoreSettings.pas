unit kwRestoreSettings;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwRestoreSettings.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::RestoreSettings
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
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwRestoreSettings = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwRestoreSettings
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsConfigurationList
  {$IfEnd} //not Admin AND not Monitorings
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwRestoreSettings

procedure TkwRestoreSettings.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_539834A703AD_var*
//#UC END# *4DAEEDE10285_539834A703AD_var*
begin
//#UC START# *4DAEEDE10285_539834A703AD_impl*
 ConfigurationList.ActiveConfig.RestoreAllSettings;
//#UC END# *4DAEEDE10285_539834A703AD_impl*
end;//TkwRestoreSettings.DoDoIt

class function TkwRestoreSettings.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'RestoreSettings';
end;//TkwRestoreSettings.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация RestoreSettings
 TkwRestoreSettings.RegisterInEngine;
{$IfEnd} //not NoScripts

end.