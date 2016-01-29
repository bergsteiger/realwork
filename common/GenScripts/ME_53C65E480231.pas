unit vcmChromeLikeTabbedContainerFormPrim;

interface

uses
 l3IntfUses
 , vcmGlassForm
 , vcmInterfaces
;

type
 TvcmChromeLikeTabbedContainerFormPrim = class(TvcmGlassForm, IvcmSizeableForm)
  function CanChangeSize: Boolean;
  function CanBeMaximized: Boolean;
 end;//TvcmChromeLikeTabbedContainerFormPrim
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
