unit moBaseSearch;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moBaseSearch.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Основные прецеденты::BaseSearch::BaseSearch$UC
//
// Базовый поиск
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
  BaseSearch_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_BaseSearch = {final formspack} class(TBaseSearchModule)
 {* Базовый поиск }
end;//Tmo_BaseSearch
{$IfEnd} //not Admin AND not Monitorings

implementation

end.