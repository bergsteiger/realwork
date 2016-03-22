unit moAAC;
 {* Актуальная аналитика }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moAAC.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "AAC" MUID: (4FF2E5990355)
// Имя типа: "Tmo_AAC"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACPrim_Module
;

type
 Tmo_AAC = {final} class(TAACPrimModule)
  {* Актуальная аналитика }
 end;//Tmo_AAC
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
