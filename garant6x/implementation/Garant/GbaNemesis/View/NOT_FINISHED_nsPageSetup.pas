unit NOT_FINISHED_nsPageSetup;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_nsPageSetup.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsPageSetup" MUID: (4ABB686202B1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , ConfigInterfaces
;

type
 TnsPageSetup = class
  private
   f_Metrics: TnsMetrics;
 end;//TnsPageSetup
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 //#UC START# *4ABB686202B1impl_uses*
 //#UC END# *4ABB686202B1impl_uses*
;
{$IfEnd} // NOT Defined(Admin)

end.
