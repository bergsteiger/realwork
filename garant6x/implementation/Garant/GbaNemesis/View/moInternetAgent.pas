unit moInternetAgent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moInternetAgent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Встроенные продукты::InternetAgent::InternetAgent$UC
//
// Интернет-агент
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
  PrimInternetAgent_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_InternetAgent = {final formspack} class(TPrimInternetAgentModule)
 {* Интернет-агент }
end;//Tmo_InternetAgent
{$IfEnd} //not Admin AND not Monitorings

implementation

end.