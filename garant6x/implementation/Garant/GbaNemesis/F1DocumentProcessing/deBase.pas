unit deBase;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\deBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeBase" MUID: (4B1E709D0071)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsBase
;

type
 TdeBase = class(TbsBase)
 end;//TdeBase
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4B1E709D0071impl_uses*
 //#UC END# *4B1E709D0071impl_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
