unit SettingsKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Settings }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SettingsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "SettingsKeywordsPack" MUID: (4ABA14800365_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Settings_Form
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_Settings = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Settings
----
*Пример использования*:
[code]форма::Settings TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Settings

function Tkw_Form_Settings.GetString: AnsiString;
begin
 Result := 'cf_Settings';
end;//Tkw_Form_Settings.GetString

class procedure Tkw_Form_Settings.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Tcf_Settings);
end;//Tkw_Form_Settings.RegisterInEngine

class function Tkw_Form_Settings.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Settings';
end;//Tkw_Form_Settings.GetWordNameForRegister

initialization
 Tkw_Form_Settings.RegisterInEngine;
 {* Регистрация Tkw_Form_Settings }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tcf_Settings));
 {* Регистрация типа Tcf_Settings }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
