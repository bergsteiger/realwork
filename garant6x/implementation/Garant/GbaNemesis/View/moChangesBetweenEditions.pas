unit moChangesBetweenEditions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moChangesBetweenEditions.pas"
// Начат: 24.05.2011 17:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::ChangesBetweenEditions
//
// Просмотр только измененных фрагментов
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
  ChangesBetweenEditions_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_ChangesBetweenEditions = {final formspack} class(TChangesBetweenEditionsModule)
 {* Просмотр только измененных фрагментов }
end;//Tmo_ChangesBetweenEditions
{$IfEnd} //not Admin AND not Monitorings

implementation

end.