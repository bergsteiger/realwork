unit OutlinerForm_ut_OutlinerForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/OutlinerForm_ut_OutlinerForm_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Outliner::OutlinerForm::ut_OutlinerForm
//
// Форма для тестирования списка
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
   { Константы для типа формы ut_OutlinerForm }
  ut_OutlinerFormName = 'ut_OutlinerForm';
   { Строковый идентификатор пользовательского типа "Форма для тестирования списка" }
  ut_OutlinerForm = TvcmUserType(0);
   { Форма для тестирования списка }
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
type
  Tkw_FormUserType_ut_OutlinerForm = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы ut_OutlinerForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_OutlinerForm
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_OutlinerForm

class function Tkw_FormUserType_ut_OutlinerForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_OutlinerForm';
end;//Tkw_FormUserType_ut_OutlinerForm.GetWordNameForRegister

function Tkw_FormUserType_ut_OutlinerForm.GetInteger: Integer;
 {-}
begin
 Result := ut_OutlinerForm;
end;//Tkw_FormUserType_ut_OutlinerForm.GetInteger

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_FormUserType_ut_OutlinerForm
 Tkw_FormUserType_ut_OutlinerForm.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.