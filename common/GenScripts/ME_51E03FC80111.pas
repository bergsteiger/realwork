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
   {* Тест удаления элемента }
  procedure AddTest;
   {* Тест добавления элемента }
  procedure RemoveTest;
   {* Тест удаления элемента по значению }
 end;//_AtomicListTest_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
