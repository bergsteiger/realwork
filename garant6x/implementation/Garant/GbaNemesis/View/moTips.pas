unit moTips;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moTips.pas"
// Начат: 2008/02/20 11:00:21
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Интерфейсные элементы::DayTips::Tips
//
// Совет дня
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
  DayTips_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Tips = {final formspack} class(TDayTipsModule)
 {* Совет дня }
end;//Tmo_Tips
{$IfEnd} //not Admin AND not Monitorings

implementation

end.