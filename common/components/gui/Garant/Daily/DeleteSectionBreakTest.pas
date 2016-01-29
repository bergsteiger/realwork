unit DeleteSectionBreakTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/DeleteSectionBreakTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TDeleteSectionBreakTest
//
// ���� �� �������� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  DrawTestPrim,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TDeleteSectionBreakTest = {abstract} class(TDrawTestPrim)
  {* ���� �� �������� �������. }
 protected
 // realized methods
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
     {* ���������� �����-������ �������� ����� ����������. }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TDeleteSectionBreakTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  ,
  TestFrameWork,
  nevTools,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TDeleteSectionBreakTest

procedure TDeleteSectionBreakTest.DoBeforeDrawing(aForm: TPrimTextLoadForm);
//#UC START# *4CAC45AE011E_4CAC461C016C_var*
//#UC END# *4CAC45AE011E_4CAC461C016C_var*
begin
//#UC START# *4CAC45AE011E_4CAC461C016C_impl*
 EvDeletePara(aForm.Text.StartOp, aForm.Text.Selection.Cursor, []);
//#UC END# *4CAC45AE011E_4CAC461C016C_impl*
end;//TDeleteSectionBreakTest.DoBeforeDrawing

function TDeleteSectionBreakTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TDeleteSectionBreakTest.GetFolder

function TDeleteSectionBreakTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CAC461C016C';
end;//TDeleteSectionBreakTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.