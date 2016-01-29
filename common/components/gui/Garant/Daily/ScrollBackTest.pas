unit ScrollBackTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Daily/ScrollBackTest.pas"
// �����: 25.05.2010 18:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TScrollBackTest
//
// ���� �������������� ��������� � �������� �������
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
 TScrollBackTest = {abstract} class(TPrimScrollTest)
  {* ���� �������������� ��������� � �������� ������� }
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* ���������� ����� }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollBackTest
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

// start class TScrollBackTest

procedure TScrollBackTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4BFBDEA300F4_var*
//#UC END# *4BE419AF0217_4BFBDEA300F4_var*
begin
//#UC START# *4BE419AF0217_4BFBDEA300F4_impl*
 ScrollBack(aForm, '');
//#UC END# *4BE419AF0217_4BFBDEA300F4_impl*
end;//TScrollBackTest.DoVisit

function TScrollBackTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TScrollBackTest.GetFolder

function TScrollBackTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BFBDEA300F4';
end;//TScrollBackTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.