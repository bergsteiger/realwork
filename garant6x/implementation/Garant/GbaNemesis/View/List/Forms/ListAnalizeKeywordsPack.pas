unit ListAnalizeKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ListAnalize }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalizeKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ListAnalizeKeywordsPack" MUID: (4E36959002CA_Pack)

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
 , ListAnalize_Form
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4E36959002CA_Packimpl_uses*
 //#UC END# *4E36959002CA_Packimpl_uses*
;

type
 Tkw_Form_ListAnalize = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ListAnalize
----
*Пример использования*:
[code]форма::ListAnalize TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ListAnalize

function Tkw_Form_ListAnalize.GetString: AnsiString;
begin
 Result := 'ListAnalizeForm';
end;//Tkw_Form_ListAnalize.GetString

class procedure Tkw_Form_ListAnalize.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TListAnalizeForm);
end;//Tkw_Form_ListAnalize.RegisterInEngine

class function Tkw_Form_ListAnalize.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ListAnalize';
end;//Tkw_Form_ListAnalize.GetWordNameForRegister

initialization
 Tkw_Form_ListAnalize.RegisterInEngine;
 {* Регистрация Tkw_Form_ListAnalize }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TListAnalizeForm));
 {* Регистрация типа TListAnalizeForm }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
