unit FromWithPanel_ut_FromWithPanel_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/FromWithPanel_ut_FromWithPanel_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations For Tests::TestForms::Forms::FormWithPanel::FromWithPanel::ut_FromWithPanel
//
// FromWithPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  vcmUserControls
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы ut_FromWithPanel }
  ut_FromWithPanelName = 'ut_FromWithPanel';
   { Строковый идентификатор пользовательского типа "FromWithPanel" }
  ut_FromWithPanel = TvcmUserType(0);
   { FromWithPanel }
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
type
  Tkw_FormUserType_ut_FromWithPanel = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы ut_FromWithPanel }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_FromWithPanel
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_FromWithPanel

class function Tkw_FormUserType_ut_FromWithPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_FromWithPanel';
end;//Tkw_FormUserType_ut_FromWithPanel.GetWordNameForRegister

function Tkw_FormUserType_ut_FromWithPanel.GetInteger: Integer;
 {-}
begin
 Result := ut_FromWithPanel;
end;//Tkw_FormUserType_ut_FromWithPanel.GetInteger

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_FormUserType_ut_FromWithPanel
 Tkw_FormUserType_ut_FromWithPanel.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.