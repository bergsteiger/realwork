unit moMainMenu;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moMainMenu.pas"
// Начат: 09.09.2009 16:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Интерфейсные элементы::MainMenu::MainMenu$UC
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
  MainMenu_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_MainMenu = {final formspack} class(TMainMenuModule)
 {* Основное меню }
end;//Tmo_MainMenu
{$IfEnd} //not Admin AND not Monitorings

implementation

end.