unit nsAACLeftDocumentContainer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AAC\nsAACLeftDocumentContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsAACLeftDocumentContainer" MUID: (500E75A000B0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsAACDocumentContainerPrim
;

type
 TnsAACLeftDocumentContainer = class(TnsAACDocumentContainerPrim)
  protected
   function AcceptableBlockViewKinds: TnsBlockViewKinds; override;
 end;//TnsAACLeftDocumentContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , evdTypes
 //#UC START# *500E75A000B0impl_uses*
 //#UC END# *500E75A000B0impl_uses*
;

function TnsAACLeftDocumentContainer.AcceptableBlockViewKinds: TnsBlockViewKinds;
//#UC START# *500E7677002B_500E75A000B0_var*
//#UC END# *500E7677002B_500E75A000B0_var*
begin
//#UC START# *500E7677002B_500E75A000B0_impl*
 Result := [ev_bvkLeft];
//#UC END# *500E7677002B_500E75A000B0_impl*
end;//TnsAACLeftDocumentContainer.AcceptableBlockViewKinds
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
