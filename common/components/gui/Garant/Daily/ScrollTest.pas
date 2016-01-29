unit ScrollTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Daily/ScrollTest.pas"
// �����: 13.05.2010 16:32
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TScrollTest
//
// ���� �������������� ���������
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
  PrimScrollTest,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TScrollTest = {abstract} class(TPrimScrollTest)
  {* ���� �������������� ��������� }
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* ���������� ����� }
 protected
 // overridden protected methods
   function GetNormalFontSize: Integer; override;
     {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TestFrameWork,
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

// start class TScrollTest

procedure TScrollTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4BEBF13B0076_var*
//#UC END# *4BE419AF0217_4BEBF13B0076_var*
begin
//#UC START# *4BE419AF0217_4BEBF13B0076_impl*
 Scroll(aForm, '');
//#UC END# *4BE419AF0217_4BEBF13B0076_impl*
end;//TScrollTest.DoVisit

function TScrollTest.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4BEBF13B0076_var*
//#UC END# *4C07AC6F036D_4BEBF13B0076_var*
begin
//#UC START# *4C07AC6F036D_4BEBF13B0076_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4BEBF13B0076_impl*
end;//TScrollTest.GetNormalFontSize

function TScrollTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TScrollTest.GetFolder

function TScrollTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BEBF13B0076';
end;//TScrollTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.