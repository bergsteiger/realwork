unit CustomizeToolsKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/CustomizeToolsKeywordsPack.pas"
// Начат: 13.09.2010 18:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::PrimToolbarMenu::CustomizeToolsKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы CustomizeTools
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  CustomizeTools_Form,
  tfwControlString
  ;

{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes
  ;

type
  Tkw_Form_CustomizeTools = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы CustomizeTools
----
*Пример использования*:
[code]
'aControl' форма::CustomizeTools TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Form_CustomizeTools

// start class Tkw_Form_CustomizeTools

class function Tkw_Form_CustomizeTools.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::CustomizeTools';
end;//Tkw_Form_CustomizeTools.GetWordNameForRegister

function Tkw_Form_CustomizeTools.GetString: AnsiString;
 {-}
begin
 Result := 'CustomizeToolsForm';
end;//Tkw_Form_CustomizeTools.GetString

class procedure Tkw_Form_CustomizeTools.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TCustomizeToolsForm);
end;//Tkw_Form_CustomizeTools.RegisterInEngine
{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_Form_CustomizeTools
 Tkw_Form_CustomizeTools.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.