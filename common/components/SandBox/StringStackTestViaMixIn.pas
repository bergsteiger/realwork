unit StringStackTestViaMixIn;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "StringStackTestViaMixIn.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::ContainersTests::TStringStackTestViaMixIn
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork,
  StringStack
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 _StackType_ = TStringStack;
 {$Include ..\SandBox\StackTest.imp.pas}
 TStringStackTestViaMixIn = class(_StackTest_)
 protected
 // realized methods
   function GetEtalonData: TEtalonData; override;
 end;//TStringStackTestViaMixIn
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  SysUtils
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

{$Include ..\SandBox\StackTest.imp.pas}

// start class TStringStackTestViaMixIn

function TStringStackTestViaMixIn.GetEtalonData: TEtalonData;
//#UC START# *515993A0015B_515994210223_var*
//#UC END# *515993A0015B_515994210223_var*
begin
//#UC START# *515993A0015B_515994210223_impl*
 Result := ArrayToEtalon(['мама', 'мыла', 'раму', 'весело', 'и', 'споро']);
//#UC END# *515993A0015B_515994210223_impl*
end;//TStringStackTestViaMixIn.GetEtalonData

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TStringStackTestViaMixIn.Suite);

end.