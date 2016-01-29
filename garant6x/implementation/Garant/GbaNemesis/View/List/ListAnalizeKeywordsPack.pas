unit ListAnalizeKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/ListAnalizeKeywordsPack.pas"
// Начат: 31.08.2009 20:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::List$FP::ListAnalizeKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы ListAnalize
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
  ListAnalize_Form,
  tfwControlString
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  tfwScriptingTypes
  ;

type
  Tkw_Form_ListAnalize = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы ListAnalize
----
*Пример использования*:
[code]
'aControl' форма::ListAnalize TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ListAnalize

// start class Tkw_Form_ListAnalize

class function Tkw_Form_ListAnalize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::ListAnalize';
end;//Tkw_Form_ListAnalize.GetWordNameForRegister

function Tkw_Form_ListAnalize.GetString: AnsiString;
 {-}
begin
 Result := 'ListAnalizeForm';
end;//Tkw_Form_ListAnalize.GetString
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_ListAnalize
 Tkw_Form_ListAnalize.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.