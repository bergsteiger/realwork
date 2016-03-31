unit NOT_COMPLETED_AACInterfaces;
 {* Интерфейсы контроллеров прецедента "Актуальная аналитика" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AAC\NOT_COMPLETED_AACInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "AACInterfaces" MUID: (4FF2E6570285)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , WorkWithDocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
