unit StringStackTestViaMixIn;

interface

uses
 l3IntfUses
 , TestFrameWork
 , StackTest.imp
 , StringStack
;

type
 TStringStackTestViaMixIn = class(TTestCase)
  function GetEtalonData: TEtalonData;
 end;//TStringStackTestViaMixIn
 
implementation

uses
 l3ImplUses
;

end.
