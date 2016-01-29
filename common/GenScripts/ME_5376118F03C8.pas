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
   {* Проверяет создан экземпляр синглетона или нет }
  procedure HelpShown;
 end;//TvgRemindersLineNotificationProxy
 
implementation

uses
 l3ImplUses
 , vgRemindersLineManager
;

end.
