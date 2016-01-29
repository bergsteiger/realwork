unit nscStatusBarItemNotification.imp;

interface

uses
 l3IntfUses
 , StatusBarUtils
 , nscNewInterfaces
 , Messages
;

type
 _nscStatusBarItemNotification_ = class(Ml3Unknown, InscStatusBarItem)
  procedure CMVisibleChanged(var aMessage: TMessage);
  procedure Subscribe(const aClient: InscStatusBarItem);
  procedure Unsubscribe(const aClient: InscStatusBarItem);
  procedure SendNotificationToClients(aNotificationType: TnscStatusBarItemNotificationType);
  procedure Notify(const aSender: InscStatusBarItem;
   aNotificationType: TnscStatusBarItemNotificationType);
  function Visible: Boolean;
  function NotificationClients: Pointer;
   {* TnscStatusBarItemsList }
  function ItemDef: InscStatusBarItemDef;
 end;//_nscStatusBarItemNotification_
 
implementation

uses
 l3ImplUses
 , l3Base
 , Controls
;

end.
