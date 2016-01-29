unit k2InterfacesEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2InterfacesEx.pas"
// �����: 21.03.2008 12:26
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::K2::k2InterfacesEx
//
// �������������� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Interfaces,
  l3PureMixIns,
  l3Variant
  ;

type
 Ik2TagListPrim = interface(IUnknown)
  {* ������ �����. }
   ['{D87DEF16-D91F-4EAB-B5B0-36BFDA811F51}']
  // Ml3List
   function pm_GetEmpty: Boolean;
   function pm_GetFirst: Tl3Variant;
   function pm_GetLast: Tl3Variant;
   function pm_GetItems(anIndex: Integer): Tl3Variant;
   property Empty: Boolean
     read pm_GetEmpty;
   property First: Tl3Variant
     read pm_GetFirst;
     {* ������ �������. }
   property Last: Tl3Variant
     read pm_GetLast;
     {* ��������� �������. }
   property Items[anIndex: Integer]: Tl3Variant
     read pm_GetItems;
     default;
  // Ml3CountHolder
   function pm_GetCount: Integer;
   property Count: Integer
     read pm_GetCount;
     {* ����� ���������. }
 end;//Ik2TagListPrim

  Ik2TagList_ForEach_Action = function (anItem: Tl3Variant;
  anIndex: Integer): Boolean;
   {* ��� �������������� ������� ��� Ik2TagList.ForEach }

 Ik2TagList = interface(Ik2TagListPrim)
   ['{7AC54659-1B8C-4ADA-800F-F62CB90E5A64}']
   {iterator} function ForEach(anAction: Ik2TagList_ForEach_Action): Integer;
     {* ���������� �������� ������.

<!> ��������. ���� ����� ��������� �� Ml3List. }
   {iterator} function ForEachF(anAction: Ik2TagList_ForEach_Action): Integer;
     {* ���������� �������� ������.

<!> ��������. ���� ����� ��������� �� Ml3List. }
 end;//Ik2TagList

function L2Ik2TagListForEachAction(anAction: pointer): Ik2TagList_ForEach_Action;
   {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Ik2TagList.ForEach }

implementation

uses
  l3Base
  ;

// start class Ik2TagList

function L2Ik2TagListForEachAction(anAction: pointer): Ik2TagList_ForEach_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2Ik2TagListForEachAction

end.