unit IntStackTestViaMixIn;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "IntStackTestViaMixIn.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::ContainersTests::TIntStackTestViaMixIn
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork,
  IntStack
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 _StackType_ = TIntStack;
 {$Include ..\SandBox\StackTest.imp.pas}
 TIntStackTestViaMixIn = class(_StackTest_)
 protected
 // realized methods
   function GetEtalonData: TEtalonData; override;
 end;//TIntStackTestViaMixIn
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

{$Include ..\SandBox\StackTest.imp.pas}

// start class TIntStackTestViaMixIn

function TIntStackTestViaMixIn.GetEtalonData: TEtalonData;
//#UC START# *515993A0015B_515993FF0256_var*
//#UC END# *515993A0015B_515993FF0256_var*
begin
//#UC START# *515993A0015B_515993FF0256_impl*
 Result := ArrayToEtalon([10, 20, 3, 5, 6, 19, 21]);
//#UC END# *515993A0015B_515993FF0256_impl*
end;//TIntStackTestViaMixIn.GetEtalonData

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TIntStackTestViaMixIn.Suite);

end.