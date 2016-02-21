unit NewRemindersInterfaces;

// Модуль: "w:\common\components\gui\Garant\VT\NewRemindersInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 IvgRemindersLine = interface
  ['{588786EF-D479-4005-AAEF-1F83B6FDB1EC}']
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
  ['{D526B5C7-8FB6-42EA-816A-B2C19C8CD4B6}']
 end;//IvgReminder

implementation

uses
 l3ImplUses
;

end.
