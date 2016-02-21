unit moCompareEditions;
 {* Сравнение редакций }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCompareEditions.pas"
// Стереотип: "VCMUseCaseRealization"

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
