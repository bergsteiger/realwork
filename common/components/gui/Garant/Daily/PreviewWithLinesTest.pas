unit PreviewWithLinesTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Daily/PreviewWithLinesTest.pas"
// �����: 27.12.2010 16:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TPreviewWithLinesTest
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
  PreviewWithLinesTestBefore235875079
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPreviewWithLinesTest = {abstract} class(TPreviewWithLinesTestBefore235875079)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function IsBefore235875079: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TPreviewWithLinesTest
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

// start class TPreviewWithLinesTest

function TPreviewWithLinesTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TPreviewWithLinesTest.GetFolder

function TPreviewWithLinesTest.IsBefore235875079: Boolean;
//#UC START# *4D18990C0329_4D1898CF02B1_var*
//#UC END# *4D18990C0329_4D1898CF02B1_var*
begin
//#UC START# *4D18990C0329_4D1898CF02B1_impl*
 Result := false;
//#UC END# *4D18990C0329_4D1898CF02B1_impl*
end;//TPreviewWithLinesTest.IsBefore235875079

function TPreviewWithLinesTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D1898CF02B1';
end;//TPreviewWithLinesTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.