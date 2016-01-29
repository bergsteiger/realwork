unit DocumentWithFlashKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/DocumentWithFlashKeywordsPack.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::DocumentWithFlashKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы DocumentWithFlash
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
  DocumentWithFlash_Form,
  tfwControlString
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  tfwScriptingTypes
  ;

type
  Tkw_Form_DocumentWithFlash = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы DocumentWithFlash
----
*Пример использования*:
[code]
'aControl' форма::DocumentWithFlash TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_DocumentWithFlash

// start class Tkw_Form_DocumentWithFlash

class function Tkw_Form_DocumentWithFlash.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::DocumentWithFlash';
end;//Tkw_Form_DocumentWithFlash.GetWordNameForRegister

function Tkw_Form_DocumentWithFlash.GetString: AnsiString;
 {-}
begin
 Result := 'DocumentWithFlashForm';
end;//Tkw_Form_DocumentWithFlash.GetString
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_DocumentWithFlash
 Tkw_Form_DocumentWithFlash.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.