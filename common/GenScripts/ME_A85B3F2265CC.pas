unit InternetAgentKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы InternetAgent$F }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\InternetAgentKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "InternetAgentKeywordsPack" MUID: (A85B3F2265CC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , InternetAgent_Form
 , tfwControlString
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_InternetAgent = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы InternetAgent$F
----
*Пример использования*:
[code]
'aControl' форма::InternetAgent TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_InternetAgent

function Tkw_Form_InternetAgent.GetString: AnsiString;
begin
 Result := 'InternetAgentForm';
end;//Tkw_Form_InternetAgent.GetString

class function Tkw_Form_InternetAgent.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::InternetAgent';
end;//Tkw_Form_InternetAgent.GetWordNameForRegister

initialization
 Tkw_Form_InternetAgent.RegisterInEngine;
 {* Регистрация Tkw_Form_InternetAgent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TInternetAgentForm));
 {* Регистрация типа TInternetAgentForm }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
