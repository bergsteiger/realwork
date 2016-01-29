unit l3PureMixIns;

{$IfDef DesignTimeLibrary}
{.$WEAKPACKAGEUNIT ON}
{$EndIf DesignTimeLibrary}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Domain"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3PureMixIns.pas"
// �����: 12.03.2008 20:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi ���������� � �������������� �����������::L3$Domain::l3PureMixIns
//
// ����������� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

(*
 Ml3CountHolder = PureMixIn
   function pm_GetCount: Integer;
   property Count: Integer
     read pm_GetCount;
     {* ����� ���������. }
 end;//Ml3CountHolder
*)

(*
 Ml3List = PureMixIn(Ml3CountHolder)
  {* ������. }
  Params : _ItemType_
   function pm_GetEmpty: Boolean;
   function pm_GetFirst: _ItemType_;
   function pm_GetLast: _ItemType_;
   function pm_GetItems(anIndex: Integer): _ItemType_;
   property Empty: Boolean
     read pm_GetEmpty;
   property First: _ItemType_
     read pm_GetFirst;
     {* ������ �������. }
   property Last: _ItemType_
     read pm_GetLast;
     {* ��������� �������. }
   property Items[anIndex: Integer]: _ItemType_
     read pm_GetItems;
     default;
 end;//Ml3List
*)

(*
 Ml3ListEx = PureMixIn(Ml3List)
   function IndexOf(const anItem: _ItemType_): Integer;
   function Add(const anItem: _ItemType_): Integer;
 end;//Ml3ListEx
*)

(*
 Ml3CheckStamp = PureMixIn
   function CheckStamp(const aGUID: TGUID): Boolean;
     {* ��������� ����� ���������� ����������. �������� ��� ����, ����� ������, ��� ���������� ���� "������". }
 end;//Ml3CheckStamp
*)

(*
 Ml3ChangingChanged = PureMixIn
   procedure Changed;
     {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
   procedure Changing;
     {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
 end;//Ml3ChangingChanged
*)

implementation

end.