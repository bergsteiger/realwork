unit InternetAgentKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы InternetAgent }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\InternetAgentKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "InternetAgentKeywordsPack" MUID: (49EC74D002B8_Pack)

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
 , InternetAgent_Form
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *49EC74D002B8_Packimpl_uses*
 //#UC END# *49EC74D002B8_Packimpl_uses*
;

type
 Tkw_Form_InternetAgent = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы InternetAgent
----
*Пример использования*:
[code]форма::InternetAgent TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_InternetAgent

function Tkw_Form_InternetAgent.GetString: AnsiString;
begin
 Result := 'InternetAgentForm';
end;//Tkw_Form_InternetAgent.GetString

class procedure Tkw_Form_InternetAgent.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TInternetAgentForm);
end;//Tkw_Form_InternetAgent.RegisterInEngine

class function Tkw_Form_InternetAgent.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::InternetAgent';
end;//Tkw_Form_InternetAgent.GetWordNameForRegister

initialization
 Tkw_Form_InternetAgent.RegisterInEngine;
 {* Регистрация Tkw_Form_InternetAgent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TInternetAgentForm));
 {* Регистрация типа TInternetAgentForm }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
