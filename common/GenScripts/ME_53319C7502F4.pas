unit vgRemindersLineForm;

interface

uses
 l3IntfUses
 , Forms
 , vg_scene
 , Controls
 , Messages
 , Classes
;

type
 TvgRemindersLineForm = class(TForm)
  procedure LockActivateProcessing;
  procedure UnlockActivateProcessing;
  procedure WMMouseActivate(var Msg: TWMMouseActivate);
  procedure WMActivate(var Msg: TWMActivate);
  procedure WMContextMenu(var Msg: TMessage);
  procedure WMSyncPos(var Msg: TMessage);
  procedure CMShowingChanged(var Msg: TMessage);
 end;//TvgRemindersLineForm
 
implementation

uses
 l3ImplUses
 , Windows
 , Types
 , vgTypes
 , vtPopupForm
 , SysUtils
 , NewRemindersInterfaces
 , TtfwClassRef_Proxy
 , ReminderWordsPack
;

end.
