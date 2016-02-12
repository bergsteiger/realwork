unit ListAnalizeKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ListAnalize }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\ListAnalizeKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , List_Module
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
 Tkw_Form_ListAnalize = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ListAnalize
----
*Пример использования*:
[code]
'aControl' форма::ListAnalize TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ListAnalize

class function Tkw_Form_ListAnalize.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ListAnalize';
end;//Tkw_Form_ListAnalize.GetWordNameForRegister

function Tkw_Form_ListAnalize.GetString: AnsiString;
begin
 Result := 'ListAnalizeForm';
end;//Tkw_Form_ListAnalize.GetString

initialization
 Tkw_Form_ListAnalize.RegisterInEngine;
 {* Регистрация Tkw_Form_ListAnalize }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
