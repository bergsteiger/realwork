unit vcmMenuManagerTypes;

interface

uses
 l3IntfUses
 , vcmMenus
;

type
 IvcmMenuItemClickListener = interface
  procedure NotifyMenuItemClicked(anItem: TvcmMenuItem);
 end;//IvcmMenuItemClickListener
 
 PvcmMenuItemClickListener = ^IvcmMenuItemClickListener;
 
implementation

uses
 l3ImplUses
;

end.
