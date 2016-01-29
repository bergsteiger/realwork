unit NewRemindersInterfaces;

interface

uses
 l3IntfUses
 , Controls
;

type
 IvgRemindersLine = interface
  procedure ControlDropped(aControl: TControl);
  procedure RemindersLineFormDestroyed;
  function IsInMove: Boolean;
   {* Линию двигают }
  procedure CorrectBounds(var aLeft: Integer;
   var aTop: Integer;
   var aWidth: Integer;
   var aHeight: Integer);
  procedure UpdateActions;
  procedure SyncPosition;
 end;//IvgRemindersLine
 
 IvgReminder = interface
 end;//IvgReminder
 
implementation

uses
 l3ImplUses
;

end.
