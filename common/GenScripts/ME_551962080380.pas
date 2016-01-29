unit ServiceTest;

interface

uses
 l3IntfUses
 , TestFrameWork
 , Classes
;

type
 TServiceTest = class(TTestCase)
  procedure DoIt;
  procedure DoIter;
 end;//TServiceTest
 
implementation

uses
 l3ImplUses
 , IterateableService
 , IterateableServiceProvider
 , Forms
;

end.
