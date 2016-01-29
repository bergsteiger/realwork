unit evButton;

interface

uses
 l3IntfUses
 , tb97Ctls
;

type
 TevCustomButton = class(TCustomToolbarButton97)
  function HackCheck: Boolean;
 end;//TevCustomButton
 
 TevCustomButtonActionLink = class(TToolbarButton97ActionLink)
 end;//TevCustomButtonActionLink
 
 TevButton = class(TevCustomButton)
 end;//TevButton
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
