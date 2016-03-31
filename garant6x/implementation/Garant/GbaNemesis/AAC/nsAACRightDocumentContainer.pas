unit nsAACRightDocumentContainer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AAC\nsAACRightDocumentContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsAACRightDocumentContainer" MUID: (500E75C90024)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsAACDocumentContainerPrim
;

type
 TnsAACRightDocumentContainer = class(TnsAACDocumentContainerPrim)
  protected
   function AcceptableBlockViewKinds: TnsBlockViewKinds; override;
 end;//TnsAACRightDocumentContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , evdTypes
;

function TnsAACRightDocumentContainer.AcceptableBlockViewKinds: TnsBlockViewKinds;
//#UC START# *500E7677002B_500E75C90024_var*
//#UC END# *500E7677002B_500E75C90024_var*
begin
//#UC START# *500E7677002B_500E75C90024_impl*
 Result := [ev_bvkRight];
//#UC END# *500E7677002B_500E75C90024_impl*
end;//TnsAACRightDocumentContainer.AcceptableBlockViewKinds
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
