unit AutoTestsSuite;

interface

uses
 l3IntfUses
 , AutoTestSuiteWithDUnitSupport
;

type
 TAutoTestsSuite = class(TAutoTestSuiteWithDUnitSupport)
  {* ��������� ������-�������� }
  procedure Register;
 end;//TAutoTestsSuite
 
implementation

uses
 l3ImplUses
 , DailyAutoTest
 , TestFrameWork
;

end.
