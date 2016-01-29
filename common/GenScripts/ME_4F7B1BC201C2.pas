unit vcmContainerFormModelPart;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , vcmInterfaces
;

type
 TvcmContainerFormModelPart = class(TvcmEntityForm)
  procedure AfterInsertForm(const aForm: IvcmEntityForm);
 end;//TvcmContainerFormModelPart
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
