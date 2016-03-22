unit moCompareEditions;
 {* Сравнение редакций }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCompareEditions.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "CompareEditions" MUID: (4A6D5A4902D8)
// Имя типа: "Tmo_CompareEditions"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseEditions_Module
;

type
 Tmo_CompareEditions = {final} class(TBaseEditionsModule)
  {* Сравнение редакций }
 end;//Tmo_CompareEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
