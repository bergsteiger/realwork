unit l3PureMixIns;
 {* ����������� �������. }

// ������: "w:\common\components\rtl\Garant\L3\l3PureMixIns.pas"
// ���������: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

type
 // _ItemType_

 (*
 Ml3CountHolder = interface
  function pm_GetCount: Integer;
  property Count: Integer
   read pm_GetCount;
   {* ����� ���������. }
 end;//Ml3CountHolder
 *)

 (*
 Ml3List = interface(Ml3CountHolder)
  {* ������. }
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
 Ml3ListEx = interface(Ml3List)
  function IndexOf(const anItem: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
 end;//Ml3ListEx
 *)

 (*
 Ml3CheckStamp = interface
  function CheckStamp(const aGUID: TGUID): Boolean;
   {* ��������� ����� ���������� ����������. �������� ��� ����, ����� ������, ��� ���������� ���� "������". }
 end;//Ml3CheckStamp
 *)

 (*
 Ml3ChangingChanged = interface
  procedure Changed;
   {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  procedure Changing;
   {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
 end;//Ml3ChangingChanged
 *)

implementation

uses
 l3ImplUses
;

end.
