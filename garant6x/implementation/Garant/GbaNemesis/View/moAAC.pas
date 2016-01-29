unit moAAC;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moAAC.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Пользовательские сервисы::AAC::AAC
//
// Актуальная аналитика
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
  AACPrim_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_AAC = {final formspack} class(TAACPrimModule)
 {* Актуальная аналитика }
end;//Tmo_AAC
{$IfEnd} //not Admin AND not Monitorings

implementation

end.