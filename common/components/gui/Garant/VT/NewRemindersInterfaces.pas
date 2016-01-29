unit NewRemindersInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/NewRemindersInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VT$Rem::NewRemindersInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Types
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;

type
 IvgRemindersLine = interface(IUnknown)
   ['{588786EF-D479-4005-AAEF-1F83B6FDB1EC}']
   procedure ControlDropped(aControl: TControl);
   procedure RemindersLineFormDestroyed;
     {* Сигнатура метода RemindersLineFormDestroyed }
   function IsInMove: Boolean;
     {* Линию двигают }
   procedure CorrectBounds(var aLeft: Integer;
     var aTop: Integer;
     var aWidth: Integer;
     var aHeight: Integer);
   procedure UpdateActions;
     {* Сигнатура метода UpdateActions }
   procedure SyncPosition;
     {* Сигнатура метода SyncPosition }
 end;//IvgRemindersLine

 IvgReminder = interface(IUnknown)
   ['{D526B5C7-8FB6-42EA-816A-B2C19C8CD4B6}']
 end;//IvgReminder

implementation

end.