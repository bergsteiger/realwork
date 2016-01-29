unit PrimMainMenuNew_utMainMenuNew_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/Forms/PrimMainMenuNew_utMainMenuNew_UserType.pas"
// Начат: 29.12.2008 17:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::PrimMainMenuNew::utMainMenuNew
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utMainMenuNew }
  utMainMenuNewName = 'utMainMenuNew';
   { Строковый идентификатор пользовательского типа "Основное меню" }
  utMainMenuNew = TvcmUserType(0);
   { Основное меню }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utMainMenuNew = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utMainMenuNew }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utMainMenuNew
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utMainMenuNew

class function Tkw_FormUserType_utMainMenuNew.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utMainMenuNew';
end;//Tkw_FormUserType_utMainMenuNew.GetWordNameForRegister

function Tkw_FormUserType_utMainMenuNew.GetInteger: Integer;
 {-}
begin
 Result := utMainMenuNew;
end;//Tkw_FormUserType_utMainMenuNew.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utMainMenuNew
 Tkw_FormUserType_utMainMenuNew.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.