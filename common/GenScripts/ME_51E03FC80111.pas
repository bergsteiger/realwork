unit AtomicListTest.imp;

interface

uses
 l3IntfUses
 , TestFrameWork
 , ListTest.imp
;

type
 // _ListType_
 
 _AtomicListTest_ = class(TTestCase)
  procedure DoIt;
  procedure TestTwoLists;
  procedure TestInsert;
  function RandomItem: _ItemType_;
  procedure TestInsertAt0;
  procedure DeleteTest;
   {* ���� �������� �������� }
  procedure AddTest;
   {* ���� ���������� �������� }
  procedure RemoveTest;
   {* ���� �������� �������� �� �������� }
 end;//_AtomicListTest_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
