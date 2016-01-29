unit IntStackTestViaMixIn;

interface

uses
 l3IntfUses
 , TestFrameWork
 , StackTest.imp
 , IntStack
;

type
 TIntStackTestViaMixIn = class(TTestCase)
  function GetEtalonData: TEtalonData;
 end;//TIntStackTestViaMixIn
 
implementation

uses
 l3ImplUses
;

end.
