unit vcmMenuForChromeLikeItemWrap;

interface

uses
 l3IntfUses
 , Classes
 , vcmMainMenuForChromeLikeTypes
 , RectWrap
 , Menus
;

type
 TvcmMenuForChromeLikeItemWrap = class(TPersistent)
  procedure Create(anItem: TvcmMenuForChromeLikeItem);
 end;//TvcmMenuForChromeLikeItemWrap
 
implementation

uses
 l3ImplUses
;

end.
