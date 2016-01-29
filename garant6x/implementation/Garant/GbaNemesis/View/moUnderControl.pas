unit moUnderControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moUnderControl.pas"
// Начат: 29.10.2010 17:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Работа с документом и списком документов::UnderControl::UnderControl$UC
//
// Документы на контроле
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
  UnderControl_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_UnderControl = {final formspack} class(TUnderControlModule)
 {* Документы на контроле }
end;//Tmo_UnderControl
{$IfEnd} //not Admin AND not Monitorings

implementation

end.