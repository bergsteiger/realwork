unit PrimSimpleMainMenu_utSimpleMainMenu_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/Forms/PrimSimpleMainMenu_utSimpleMainMenu_UserType.pas"
// Начат: 29.12.2008 17:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::PrimSimpleMainMenu::utSimpleMainMenu
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
   { Константы для типа формы utSimpleMainMenu }
  utSimpleMainMenuName = 'utSimpleMainMenu';
   { Строковый идентификатор пользовательского типа "Основное меню" }
  utSimpleMainMenu = TvcmUserType(0);
   { Основное меню }

type
  Tkw_FormUserType_utSimpleMainMenu = class(TtfwInteger)
   {* Слово словаря для типа формы utSimpleMainMenu }
  protected
  // overridden protected methods
    {$If not defined(NoScripts)}
   function GetInteger: Integer; override;
    {$IfEnd} //not NoScripts
  end;//Tkw_FormUserType_utSimpleMainMenu
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
// start class Tkw_FormUserType_utSimpleMainMenu

{$If not defined(NoScripts)}
function Tkw_FormUserType_utSimpleMainMenu.GetInteger: Integer;
 {-}
begin
 Result := utSimpleMainMenu;
end;//Tkw_FormUserType_utSimpleMainMenu.GetInteger
{$IfEnd} //not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация Tkw_FormUserType_utSimpleMainMenu
 Tkw_FormUserType_utSimpleMainMenu.Register('тип_формы::utSimpleMainMenu');
{$IfEnd} //not Admin AND not Monitorings

end.