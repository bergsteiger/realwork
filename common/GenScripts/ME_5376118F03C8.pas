unit vgRemindersLineNotificationProxy;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , spHelpNotifyManager
;

type
 TvgRemindersLineNotificationProxy = class(Tl3ProtoObject, IspHelpNotifyListener)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure HelpShown;
 end;//TvgRemindersLineNotificationProxy
 
implementation

uses
 l3ImplUses
 , vgRemindersLineManager
;

end.
