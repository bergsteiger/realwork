unit l3ListOperations.imp;

interface

uses
 l3IntfUses
;

type
 _l3ListOperations_ = class
  function DeleteList(const aList: _ListType_): Boolean;
   {* ������� �� ������ �������� ������������ � ������ ������ (aList) }
  function InsertList(const aList: _ListType_): Boolean;
   {* ��������� � ������ �������� ������� ������ (aList) }
  function IntersectList(const aList: _ListType_): Boolean;
   {* ������� �� ������ �������� �� ������������ � ������ ������ (aList) }
 end;//_l3ListOperations_
 
implementation

uses
 l3ImplUses
;

end.
