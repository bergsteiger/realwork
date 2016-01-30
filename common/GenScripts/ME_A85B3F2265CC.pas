unit InternetAgentKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы InternetAgent$F }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\InternetAgentKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimInternetAgent_Module
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
//#UC START# *4DDFD2EA0116_688265610B11_var*
//#UC END# *4DDFD2EA0116_688265610B11_var*
begin
//#UC START# *4DDFD2EA0116_688265610B11_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_688265610B11_impl*
end;//Tkw_Form_InternetAgent.GetString

initialization
 Tkw_Form_InternetAgent.RegisterInEngine;
 {* Регистрация Tkw_Form_InternetAgent }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
