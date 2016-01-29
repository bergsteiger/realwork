unit IntStackTest;

interface

uses
 l3IntfUses
 , TestFrameWork
;

type
 TIntStackTest = class(TTestCase)
  procedure DoIt;
 end;//TIntStackTest
 
implementation

uses
 l3ImplUses
 , IntStack
 , SysUtils
;

end.
