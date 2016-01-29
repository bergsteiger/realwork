unit vgRemindersLineTabbedContainerNotificationProxy;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3TabbedContainersDispatcher
;

type
 TvgRemindersLineTabbedContainerNotificationProxy = class(Tl3ProtoObject, Il3TabbedContainersListener)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
 end;//TvgRemindersLineTabbedContainerNotificationProxy
 
implementation

uses
 l3ImplUses
 , vgRemindersLineManager
;

end.
