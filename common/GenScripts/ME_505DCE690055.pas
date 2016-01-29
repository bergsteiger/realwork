unit StatusBarUtils;

interface

uses
 l3IntfUses
 , nscNewInterfaces
 , l3ProtoDataContainer
;

type
 TnscStatusBarItemNotificationType = (
  sbintVisibleChanged
 );//TnscStatusBarItemNotificationType
 
 InscStatusBarItem = interface
  procedure Unsubscribe(const aClient: InscStatusBarItem);
  procedure SendNotificationToClients(aNotificationType: TnscStatusBarItemNotificationType);
  procedure Subscribe(const aClient: InscStatusBarItem);
  procedure Notify(const aSender: InscStatusBarItem;
   aNotificationType: TnscStatusBarItemNotificationType);
 end;//InscStatusBarItem
 
 TnscStatusBarItemsList = class(_l3InterfacePtrList_)
 end;//TnscStatusBarItemsList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
