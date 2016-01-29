unit vcmMainFormModelPart;

interface

uses
 l3IntfUses
 , vcmContainerForm
;

type
 TvcmMainFormModelPart = class(TvcmContainerForm)
  procedure DispatcherCreated;
  procedure AfterModulesRegistered;
 end;//TvcmMainFormModelPart
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
