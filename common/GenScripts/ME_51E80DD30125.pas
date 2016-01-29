unit ListTest.imp;

interface

uses
 l3IntfUses
 , TestFrameWork
 , AtomicListTest.imp
;

type
 _ListTest_ = class(TTestCase)
  function CreateList: _ListType_;
 end;//_ListTest_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
