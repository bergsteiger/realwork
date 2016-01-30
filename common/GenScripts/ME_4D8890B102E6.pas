unit MouseSelectPtTest;
 {* ���� �������� ����� �� ������������ �����. }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\MouseSelectPtTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

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
 , evCustomEditorWindow
 , nevTools
 , l3Units
 , nevGUIInterfaces
;

type
 _MouseClickOnPoint_Parent_ = TTextEditorVisitor;
 {$Include MouseClickOnPoint.imp.pas}
 TMouseSelectPtTest = {abstract} class(_MouseClickOnPoint_)
  {* ���� �������� ����� �� ������������ �����. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TMouseSelectPtTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
;

{$Include MouseClickOnPoint.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TMouseSelectPtTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4D8890B102E6_var*
//#UC END# *4BE419AF0217_4D8890B102E6_var*
begin
//#UC START# *4BE419AF0217_4D8890B102E6_impl*
 ClickOnPoint(aForm.Text, False);
//#UC END# *4BE419AF0217_4D8890B102E6_impl*
end;//TMouseSelectPtTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TMouseSelectPtTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TMouseSelectPtTest.GetFolder

function TMouseSelectPtTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D8890B102E6';
end;//TMouseSelectPtTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
