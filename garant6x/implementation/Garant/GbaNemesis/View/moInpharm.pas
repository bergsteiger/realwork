unit moInpharm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moInpharm.pas"
// Начат: 2008/03/12 11:01:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Встроенные продукты::Inpharm::Inpharm
//
// Инфарм
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
  Inpharm_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Inpharm = {final formspack} class(TInpharmModule)
 {* Инфарм }
end;//Tmo_Inpharm
{$IfEnd} //not Admin AND not Monitorings

implementation

end.