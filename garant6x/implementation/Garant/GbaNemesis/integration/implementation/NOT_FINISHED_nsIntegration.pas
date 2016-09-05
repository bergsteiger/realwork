unit NOT_FINISHED_nsIntegration;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Integration\Implementation\NOT_FINISHED_nsIntegration.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsIntegration" MUID: (513607DC03D4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsIntegrationModelPart
 //#UC START# *513607DC03D4impl_uses*
 //#UC END# *513607DC03D4impl_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
