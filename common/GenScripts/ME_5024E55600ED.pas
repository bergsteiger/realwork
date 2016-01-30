unit nsAACDocumentSynchroViewContainer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsAACDocumentSynchroViewContainer.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsAACDocumentContainerPrim
;

type
 TnsAACDocumentSynchroViewContainer = class(TnsAACDocumentContainerPrim)
  protected
   function AcceptableBlockViewKinds: TnsBlockViewKinds; override;
 end;//TnsAACDocumentSynchroViewContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , evdTypes
;

function TnsAACDocumentSynchroViewContainer.AcceptableBlockViewKinds: TnsBlockViewKinds;
//#UC START# *500E7677002B_5024E55600ED_var*
//#UC END# *500E7677002B_5024E55600ED_var*
begin
//#UC START# *500E7677002B_5024E55600ED_impl*
 Result := [ev_bvkLeft, ev_bvkRight];
//#UC END# *500E7677002B_5024E55600ED_impl*
end;//TnsAACDocumentSynchroViewContainer.AcceptableBlockViewKinds
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
