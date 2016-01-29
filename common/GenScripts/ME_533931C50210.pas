unit vgReminderWithAction;

interface

uses
 l3IntfUses
 , vgRemindersLine
 , vcmExternalInterfaces
 , ActnList
 , Classes
;

type
 TvgReminderActionLink = class(TActionLink)
 end;//TvgReminderActionLink
 
 TvgReminderWithAction = class(TvgReminder, IvcmComponentWithAction)
  procedure DoActionChange(Sender: TObject);
  procedure InitAction;
  function GetParentForm: TComponent;
  function EntityName: AnsiString;
  function OperationName: AnsiString;
  function Action: TCustomAction;
  function Hint: AnsiString;
  function Caption: AnsiString;
  function Visible: Boolean;
  function GetComponent: TComponent;
 end;//TvgReminderWithAction
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 , vcmUtils
 , TtfwClassRef_Proxy
;

end.
