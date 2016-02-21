unit InternetAgentKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы InternetAgent$F }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\InternetAgentKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_InternetAgent

class function Tkw_Form_InternetAgent.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::InternetAgent';
end;//Tkw_Form_InternetAgent.GetWordNameForRegister

function Tkw_Form_InternetAgent.GetString: AnsiString;
begin
 Result := 'InternetAgentForm';
end;//Tkw_Form_InternetAgent.GetString

initialization
 Tkw_Form_InternetAgent.RegisterInEngine;
 {* Регистрация Tkw_Form_InternetAgent }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
