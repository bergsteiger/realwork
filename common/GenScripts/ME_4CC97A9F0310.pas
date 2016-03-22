unit moBaseSearch;
 {* Базовый поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moBaseSearch.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "BaseSearch" MUID: (4CC97A9F0310)
// Имя типа: "Tmo_BaseSearch"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseSearch_Module
;

type
 Tmo_BaseSearch = {final} class(TBaseSearchModule)
  {* Базовый поиск }
 end;//Tmo_BaseSearch
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
