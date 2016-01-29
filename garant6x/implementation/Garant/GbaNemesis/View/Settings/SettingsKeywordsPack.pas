unit SettingsKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/SettingsKeywordsPack.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::SettingsKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Settings_Form,
  tfwControlString
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  tfwScriptingTypes
  ;

type
  Tkw_Form_Settings = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Settings
----
*Пример использования*:
[code]
'aControl' форма::Settings TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Settings

// start class Tkw_Form_Settings

class function Tkw_Form_Settings.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Settings';
end;//Tkw_Form_Settings.GetWordNameForRegister

function Tkw_Form_Settings.GetString: AnsiString;
 {-}
begin
 Result := 'cf_Settings';
end;//Tkw_Form_Settings.GetString
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Settings
 Tkw_Form_Settings.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.