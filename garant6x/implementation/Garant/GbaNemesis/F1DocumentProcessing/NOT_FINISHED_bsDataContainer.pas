unit NOT_FINISHED_bsDataContainer;
 {* Модуль содержит реализации контейнеров данных. Получение данных с адаптера
   может занимать длительное время, поэтому вводятся контейнеры данных, которые
   возвращают данные по первому требованию }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\NOT_FINISHED_bsDataContainer.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "bsDataContainer" MUID: (49258B61023C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TbsMedicFirmNodeContainer = class
 end;//TbsMedicFirmNodeContainer

 TbsNestedDocumentContainer = class
 end;//TbsNestedDocumentContainer

 TbsDocumentContainer = class
 end;//TbsDocumentContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *49258B61023Cimpl_uses*
 //#UC END# *49258B61023Cimpl_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
