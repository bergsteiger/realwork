unit RoundedControlsTest;

// Модуль: "w:\common\components\SandBox\RoundedControlsTest.pas"
// Стереотип: "TestCase"

{$Include sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TRoundedControlsTest = class(TTestCase)
  public
   procedure DoIt;
 end;//TRoundedControlsTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , RoundedButton
 , RoundedEdit
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

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

initialization
 TestFramework.RegisterTest(TRoundedControlsTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
