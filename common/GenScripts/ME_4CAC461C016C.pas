unit DeleteSectionBreakTest;
 {* ���� �� �������� �������. }

// ������: "w:\common\components\gui\Garant\Daily\DeleteSectionBreakTest.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , DrawTestPrim
 , PrimTextLoad_Form
;

type
 TDeleteSectionBreakTest = {abstract} class(TDrawTestPrim)
  {* ���� �� �������� �������. }
  protected
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
    {* ���������� �����-������ �������� ����� ����������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TDeleteSectionBreakTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , TestFrameWork
 , nevTools
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TDeleteSectionBreakTest.DoBeforeDrawing(aForm: TPrimTextLoadForm);
 {* ���������� �����-������ �������� ����� ����������. }
//#UC START# *4CAC45AE011E_4CAC461C016C_var*
//#UC END# *4CAC45AE011E_4CAC461C016C_var*
begin
//#UC START# *4CAC45AE011E_4CAC461C016C_impl*
 EvDeletePara(aForm.Text.StartOp, aForm.Text.Selection.Cursor, []);
//#UC END# *4CAC45AE011E_4CAC461C016C_impl*
end;//TDeleteSectionBreakTest.DoBeforeDrawing

function TDeleteSectionBreakTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TDeleteSectionBreakTest.GetFolder

function TDeleteSectionBreakTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CAC461C016C';
end;//TDeleteSectionBreakTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
