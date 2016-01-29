unit dsSendConsultation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Морозов М.А
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/dsSendConsultation.pas"
// Начат: 06.04.2006 17.27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::Consultation::Consultation::Consultation::TdsSendConsultation
//
// Бизнес объект "Запрос на консультацию"
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
  dsQuery
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsSendConsultation = {vac} class(TdsQuery)
  {* Бизнес объект "Запрос на консультацию" }
 end;//TdsSendConsultation
{$IfEnd} //not Admin AND not Monitorings

implementation

end.