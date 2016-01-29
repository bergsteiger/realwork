unit TextLoad_ut_TextLoad_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/TextLoad_ut_TextLoad_UserType.pas"
// Начат: 22.12.2009 16:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::TextLoad::ut_TextLoad
//
// Форма для загрузки документа
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
   { Константы для типа формы ut_TextLoad }
  ut_TextLoadName = 'ut_TextLoad';
   { Строковый идентификатор пользовательского типа "Форма для загрузки документа" }
  ut_TextLoad = TvcmUserType(0);
   { Форма для загрузки документа }
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
type
  Tkw_FormUserType_ut_TextLoad = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы ut_TextLoad }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_TextLoad
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_TextLoad

class function Tkw_FormUserType_ut_TextLoad.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_TextLoad';
end;//Tkw_FormUserType_ut_TextLoad.GetWordNameForRegister

function Tkw_FormUserType_ut_TextLoad.GetInteger: Integer;
 {-}
begin
 Result := ut_TextLoad;
end;//Tkw_FormUserType_ut_TextLoad.GetInteger

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_FormUserType_ut_TextLoad
 Tkw_FormUserType_ut_TextLoad.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.