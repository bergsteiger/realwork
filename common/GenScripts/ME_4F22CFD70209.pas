unit vcmEntityFormImplementationModelPart;

interface

uses
 l3IntfUses
 , vcmForm
 , vcmInterfaces
;

type
 TvcmEntityFormImplementationModelPart = class(TvcmFormImplementation)
  function VCMClosing: Boolean;
  function IsBaloon: Boolean;
 end;//TvcmEntityFormImplementationModelPart
 
implementation

uses
 l3ImplUses
 , vcmEntityFormModelPart
;

end.
