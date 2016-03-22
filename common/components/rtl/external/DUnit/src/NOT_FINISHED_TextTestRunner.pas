unit NOT_FINISHED_TextTestRunner;

// Модуль: "w:\common\components\rtl\external\DUnit\src\NOT_FINISHED_TextTestRunner.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "TextTestRunner" MUID: (4B2A0D8A03A0)

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TTextTestListener = class(TInterfacedObject)
  protected
   procedure TestingStarts; virtual;
   procedure TestingEnds(testResult: TTestResult); virtual;
   procedure StartTest(test: ITest); virtual;
   class procedure write(const aStr: AnsiString); virtual;
   class procedure writeln(const aStr: AnsiString = ''); virtual;
   procedure Cleanup; virtual;
   procedure InitFields; virtual;
   function NeedsMilliseconds: Boolean; virtual;
    {* Выводить ли милисекунды }
   function PrintErrorItem(i: Integer;
    r: TTestFailure): AnsiString; virtual;
  public
   constructor Create; reintroduce;
   procedure AddSuccess(const test: ITest); virtual;
   procedure AddError(error: TTestFailure); virtual;
   procedure AddFailure(failure: TTestFailure); virtual;
   destructor Destroy; override;
 end;//TTextTestListener

procedure RunRegisteredTests;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
;

procedure RunRegisteredTests;
//#UC START# *4B2A0DA00060_4B2A0D8A03A0_var*
//#UC END# *4B2A0DA00060_4B2A0D8A03A0_var*
begin
//#UC START# *4B2A0DA00060_4B2A0D8A03A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2A0DA00060_4B2A0D8A03A0_impl*
end;//RunRegisteredTests

constructor TTextTestListener.Create;
//#UC START# *4B2B6BDD018A_4B2A6CAD036B_var*
//#UC END# *4B2B6BDD018A_4B2A6CAD036B_var*
begin
//#UC START# *4B2B6BDD018A_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2B6BDD018A_4B2A6CAD036B_impl*
end;//TTextTestListener.Create

procedure TTextTestListener.AddSuccess(const test: ITest);
//#UC START# *4F16BEF60233_4B2A6CAD036B_var*
//#UC END# *4F16BEF60233_4B2A6CAD036B_var*
begin
//#UC START# *4F16BEF60233_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F16BEF60233_4B2A6CAD036B_impl*
end;//TTextTestListener.AddSuccess

procedure TTextTestListener.AddError(error: TTestFailure);
//#UC START# *4F16BF26031B_4B2A6CAD036B_var*
//#UC END# *4F16BF26031B_4B2A6CAD036B_var*
begin
//#UC START# *4F16BF26031B_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F16BF26031B_4B2A6CAD036B_impl*
end;//TTextTestListener.AddError

procedure TTextTestListener.AddFailure(failure: TTestFailure);
//#UC START# *4F16BF430163_4B2A6CAD036B_var*
//#UC END# *4F16BF430163_4B2A6CAD036B_var*
begin
//#UC START# *4F16BF430163_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F16BF430163_4B2A6CAD036B_impl*
end;//TTextTestListener.AddFailure

procedure TTextTestListener.TestingStarts;
//#UC START# *5374DA8103BC_4B2A6CAD036B_var*
//#UC END# *5374DA8103BC_4B2A6CAD036B_var*
begin
//#UC START# *5374DA8103BC_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5374DA8103BC_4B2A6CAD036B_impl*
end;//TTextTestListener.TestingStarts

procedure TTextTestListener.TestingEnds(testResult: TTestResult);
//#UC START# *5374DA9401BF_4B2A6CAD036B_var*
//#UC END# *5374DA9401BF_4B2A6CAD036B_var*
begin
//#UC START# *5374DA9401BF_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5374DA9401BF_4B2A6CAD036B_impl*
end;//TTextTestListener.TestingEnds

procedure TTextTestListener.StartTest(test: ITest);
//#UC START# *5374DAC503BB_4B2A6CAD036B_var*
//#UC END# *5374DAC503BB_4B2A6CAD036B_var*
begin
//#UC START# *5374DAC503BB_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5374DAC503BB_4B2A6CAD036B_impl*
end;//TTextTestListener.StartTest

class procedure TTextTestListener.write(const aStr: AnsiString);
//#UC START# *4B2A6CBC008B_4B2A6CAD036B_var*
//#UC END# *4B2A6CBC008B_4B2A6CAD036B_var*
begin
//#UC START# *4B2A6CBC008B_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2A6CBC008B_4B2A6CAD036B_impl*
end;//TTextTestListener.write

class procedure TTextTestListener.writeln(const aStr: AnsiString = '');
//#UC START# *4B2A6CCF00BB_4B2A6CAD036B_var*
//#UC END# *4B2A6CCF00BB_4B2A6CAD036B_var*
begin
//#UC START# *4B2A6CCF00BB_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2A6CCF00BB_4B2A6CAD036B_impl*
end;//TTextTestListener.writeln

procedure TTextTestListener.Cleanup;
//#UC START# *4B2B6B800265_4B2A6CAD036B_var*
//#UC END# *4B2B6B800265_4B2A6CAD036B_var*
begin
//#UC START# *4B2B6B800265_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2B6B800265_4B2A6CAD036B_impl*
end;//TTextTestListener.Cleanup

procedure TTextTestListener.InitFields;
//#UC START# *4B2B6BA1037F_4B2A6CAD036B_var*
//#UC END# *4B2B6BA1037F_4B2A6CAD036B_var*
begin
//#UC START# *4B2B6BA1037F_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2B6BA1037F_4B2A6CAD036B_impl*
end;//TTextTestListener.InitFields

function TTextTestListener.NeedsMilliseconds: Boolean;
 {* Выводить ли милисекунды }
//#UC START# *4B2FBFA903C9_4B2A6CAD036B_var*
//#UC END# *4B2FBFA903C9_4B2A6CAD036B_var*
begin
//#UC START# *4B2FBFA903C9_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2FBFA903C9_4B2A6CAD036B_impl*
end;//TTextTestListener.NeedsMilliseconds

function TTextTestListener.PrintErrorItem(i: Integer;
 r: TTestFailure): AnsiString;
//#UC START# *4CACA6980207_4B2A6CAD036B_var*
//#UC END# *4CACA6980207_4B2A6CAD036B_var*
begin
//#UC START# *4CACA6980207_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CACA6980207_4B2A6CAD036B_impl*
end;//TTextTestListener.PrintErrorItem

destructor TTextTestListener.Destroy;
//#UC START# *48077504027E_4B2A6CAD036B_var*
//#UC END# *48077504027E_4B2A6CAD036B_var*
begin
//#UC START# *48077504027E_4B2A6CAD036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *48077504027E_4B2A6CAD036B_impl*
end;//TTextTestListener.Destroy
{$IfEnd} // Defined(nsTest)

end.
