unit NewRemindersInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$Rem"
// ������: "w:/common/components/gui/Garant/VT/NewRemindersInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VT$Rem::NewRemindersInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
     {* ��������� ������ RemindersLineFormDestroyed }
   function IsInMove: Boolean;
     {* ����� ������� }
   procedure CorrectBounds(var aLeft: Integer;
     var aTop: Integer;
     var aWidth: Integer;
     var aHeight: Integer);
   procedure UpdateActions;
     {* ��������� ������ UpdateActions }
   procedure SyncPosition;
     {* ��������� ������ SyncPosition }
 end;//IvgRemindersLine

 IvgReminder = interface(IUnknown)
   ['{D526B5C7-8FB6-42EA-816A-B2C19C8CD4B6}']
 end;//IvgReminder

implementation

end.