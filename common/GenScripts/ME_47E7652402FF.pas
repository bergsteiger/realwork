unit vcmMainMenuAction;

interface

uses
 l3IntfUses
 , vcmAction
 , vcmInterfaces
 , Classes
 , Menus
;

type
 TvcmMainMenuAction = class(TvcmAction)
  procedure Create(anOwner: TComponent;
   aTest: TvcmTestEvent);
  function MakeForMenu(anItem: TMenuItem;
   aTest: TvcmTestEvent): TvcmMainMenuAction;
 end;//TvcmMainMenuAction
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
