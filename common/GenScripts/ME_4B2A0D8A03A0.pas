unit TextTestRunner;

interface

uses
 l3IntfUses
 , TestFrameWork
;

type
 TTextTestListener = class(TInterfacedObject)
  procedure Create;
  procedure AddSuccess(const test: ITest);
  procedure AddError(error: TTestFailure);
  procedure AddFailure(failure: TTestFailure);
  procedure TestingStarts;
  procedure TestingEnds(testResult: TTestResult);
  procedure StartTest(test: ITest);
  procedure write(const aStr: AnsiString);
  procedure writeln(const aStr: AnsiString);
  procedure Cleanup;
  procedure InitFields;
  function NeedsMilliseconds: Boolean;
   {* Выводить ли милисекунды }
  function PrintErrorItem(i: Integer;
   r: TTestFailure): AnsiString;
 end;//TTextTestListener
 
implementation

uses
 l3ImplUses
;

end.
