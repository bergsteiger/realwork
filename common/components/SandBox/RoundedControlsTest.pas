unit RoundedControlsTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "RoundedControlsTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCase::Class Shared Delphi Sand Box::SandBoxTest::Rounded::RoundedControlsTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbtDefine.inc}

interface

{$If defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TRoundedControlsTest = class(TTestCase)
 published
 // published methods
   procedure DoIt;
 end;//TRoundedControlsTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  RoundedButton,
  RoundedEdit
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TRoundedControlsTest

procedure TRoundedControlsTest.DoIt;
//#UC START# *517C40E900DA_517C11C6019A_var*
var
 l_Form : TCustomForm;
 l_E : TRoundedEdit;
 l_B : TRoundedButton;
//#UC END# *517C40E900DA_517C11C6019A_var*
begin
//#UC START# *517C40E900DA_517C11C6019A_impl*
 l_Form := TCustomForm.CreateNew(Application);
 l_E := TRoundedEdit.Create(l_Form);
 l_B := TRoundedButton.Create(l_Form);

 l_Form.Height := 200;
 l_Form.Width := 200;
 l_E.Left := 10;
 l_B.Left := 10;
 l_E.Top := 20;
 l_B.Top := 50;

 l_E.Text := l_E.ClassName;
 l_B.Caption := l_B.ClassName;

 l_B.Width := l_E.Width;

 l_E.Parent := l_Form;
 l_B.Parent := l_Form;
 l_Form.Show;
//#UC END# *517C40E900DA_517C11C6019A_impl*
end;//TRoundedControlsTest.DoIt

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TRoundedControlsTest.Suite);

end.