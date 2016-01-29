unit TextMetricsTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Abstract Tests"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Abstract_Tests/TextMetricsTest.pas"
// �����: 14.12.2010 15:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TTextMetricsTest
//
// ���� ����������� ������� ������. ����� ��� AllChildrenCount, NettoCharCount, BruttoCharCount,
// TextParaCount, BitmapParaCount
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TextMetricsPrimTest
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TTextMetricsTest = {abstract} class(TTextMetricsPrimTest)
  {* ���� ����������� ������� ������. ����� ��� AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTextMetricsTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TTextMetricsTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTextMetricsTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4D076A0C03C4_var*
//#UC END# *4BE13147032C_4D076A0C03C4_var*
begin
//#UC START# *4BE13147032C_4D076A0C03C4_impl*
 // - ������ �� ������
//#UC END# *4BE13147032C_4D076A0C03C4_impl*
end;//TTextMetricsTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TTextMetricsTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTextMetricsTest.GetFolder

function TTextMetricsTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D076A0C03C4';
end;//TTextMetricsTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.