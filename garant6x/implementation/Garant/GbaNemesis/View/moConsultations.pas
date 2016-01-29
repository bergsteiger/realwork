unit moConsultations;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moConsultations.pas"
// Начат: 25.09.2009 21:16
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Пользовательские сервисы::Consultation::Consultations$UC
//
// Консультации
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
  Consultation_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Consultations = {final formspack} class(TConsultationModule)
 {* Консультации }
end;//Tmo_Consultations
{$IfEnd} //not Admin AND not Monitorings

implementation

end.