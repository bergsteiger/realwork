unit vcmTabbedContainersListener.imp;

interface

uses
 l3IntfUses
 , l3TabbedContainersDispatcher
;

type
 _vcmTabbedContainersListener_ = class(Ml3Unknown, Il3TabbedContainersListener)
  procedure ContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
  procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
 end;//_vcmTabbedContainersListener_
 
implementation

uses
 l3ImplUses
 , vcmTabbedContainerFormDispatcher
;

end.
