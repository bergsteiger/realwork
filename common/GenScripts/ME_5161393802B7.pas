unit RefcountedTest;

interface

uses
 l3IntfUses
 , TestFrameWork
;

type
 TRefcountedTest = class(TTestCase)
  procedure DoIt;
 end;//TRefcountedTest
 
implementation

uses
 l3ImplUses
 , Refcounted
 , SysUtils
;

end.
