unit SettingsKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Settings }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\SettingsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Settings_Module
 , tfwControlString
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
;

type
 Tkw_Form_Settings = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Settings
----
*Пример использования*:
[code]
'aControl' форма::Settings TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Settings

class function Tkw_Form_Settings.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Settings';
end;//Tkw_Form_Settings.GetWordNameForRegister

function Tkw_Form_Settings.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DBC85121A203_var*
//#UC END# *4DDFD2EA0116_DBC85121A203_var*
begin
//#UC START# *4DDFD2EA0116_DBC85121A203_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DBC85121A203_impl*
end;//Tkw_Form_Settings.GetString

initialization
 Tkw_Form_Settings.RegisterInEngine;
 {* Регистрация Tkw_Form_Settings }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
