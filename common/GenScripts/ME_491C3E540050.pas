unit ConsultationInterfaces;
 {* Интерфейсы для работы с консультациями }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\ConsultationInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "ConsultationInterfaces" MUID: (491C3E540050)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , QueryCardInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
