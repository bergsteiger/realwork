unit myReferenceCountGuardTest;

interface

uses
 l3IntfUses
 , TestFrameWork
;

type
 TmyReferenceCountGuardTest = class(TTestCase)
  procedure DoIt;
  procedure CheckWithClause;
 end;//TmyReferenceCountGuardTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , myReferenceCountGuard
;

end.
