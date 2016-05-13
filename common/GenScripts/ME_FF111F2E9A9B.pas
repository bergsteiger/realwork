unit ListAnalizeKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ListAnalize }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\ListAnalizeKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ListAnalizeKeywordsPack" MUID: (FF111F2E9A9B)

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
 , ListAnalize_Form
 , tfwControlString
 , SysUtils
 , TtfwTypeRegistrator_Proxy
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ListAnalize

function Tkw_Form_ListAnalize.GetString: AnsiString;
begin
 Result := 'ListAnalizeForm';
end;//Tkw_Form_ListAnalize.GetString

class function Tkw_Form_ListAnalize.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ListAnalize';
end;//Tkw_Form_ListAnalize.GetWordNameForRegister

initialization
 Tkw_Form_ListAnalize.RegisterInEngine;
 {* Регистрация Tkw_Form_ListAnalize }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TListAnalizeForm));
 {* Регистрация типа TListAnalizeForm }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
