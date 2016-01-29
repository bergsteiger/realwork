unit Menus;

interface

uses
 l3IntfUses
 , Classes
 , Messages
;

type
 TMenuItem = class(TComponent)
  {* TMenuItem describes the properties of an item in a menu. }
 end;//TMenuItem
 
 TMenu = class(TComponent)
  {* TMenu is the base type for menu components such as TMainMenu and TPopupMenu. }
  function IsShortCut(var Message: TWMKey): Boolean;
 end;//TMenu
 
 TPopupMenu = class(TMenu)
  {* TPopupMenu encapsulates the properties, methods, and events of a pop-up menu. }
  procedure Popup(X: Integer;
   Y: Integer);
 end;//TPopupMenu
 
 TMenuKeyCap = (
 );//TMenuKeyCap
 
 TMainMenu = class(TMenu)
 end;//TMainMenu
 
implementation

uses
 l3ImplUses
 , MenuWordsPack
;

end.
