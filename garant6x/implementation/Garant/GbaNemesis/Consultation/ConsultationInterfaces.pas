unit ConsultationInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/ConsultationInterfaces.pas"
// Начат: 13.11.2008
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Пользовательские сервисы::Consultation::Consultation::ConsultationInterfaces
//
// Интерфейсы для работы с консультациями
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
  QueryCardInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

type
 IsdsQuery = interface(IvcmUseCaseController)
  {* Бизнес объект прецедентов "Поисковый запрос" }
   ['{0D4BCBD4-AA04-45B7-AAF0-34CEFA6EE31C}']
   function pm_GetDsQuery: IdsQuery;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   property dsQuery: IdsQuery
     read pm_GetDsQuery;
     {* для формы поискового запроса }
   property dsSaveLoad: IdsSaveLoad
     read pm_GetDsSaveLoad;
     {* для контейнера поискового запроса }
 end;//IsdsQuery

 IsdsSendConsultation = interface(IsdsQuery)
   ['{B788E478-BE1E-422D-85F0-0AF63DEFB0B9}']
 end;//IsdsSendConsultation
{$IfEnd} //not Admin AND not Monitorings

implementation

end.