unit SelectPtTest;
 {* ���� ���� - ��������� � ������ � ����� �� ��������� ������������ ������-������ ��������� }

// ������: "w:\common\components\rtl\Garant\Daily\SelectPtTest.pas"
// ���������: "TestCase"
// ������� ������: "TSelectPtTest" MUID: (4BF4E6650245)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , l3Units
 , evCustomEditorWindow
;

type
 _Para2Point_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
 TSelectPtTest = {abstract} class(_Para2Point_)
  {* ���� ���� - ��������� � ������ � ����� �� ��������� ������������ ������-������ ��������� }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TSelectPtTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4BF4E6650245impl_uses*
 //#UC END# *4BF4E6650245impl_uses*
;

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}

procedure TSelectPtTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4BF4E6650245_var*
//#UC END# *4BE419AF0217_4BF4E6650245_var*
begin
//#UC START# *4BE419AF0217_4BF4E6650245_impl*
 {$R+}
 aForm.Text.View.Control.Selection.SelectPt(TranslatePara2Point(aForm.Text), True);
 {$R-}
//#UC END# *4BE419AF0217_4BF4E6650245_impl*
end;//TSelectPtTest.DoVisit

function TSelectPtTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TSelectPtTest.GetFolder

function TSelectPtTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BF4E6650245';
end;//TSelectPtTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
