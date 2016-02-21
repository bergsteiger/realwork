unit TextMetricsTest;
 {* ���� ����������� ������� ������. ����� ��� AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\TextMetricsTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMetricsPrimTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TTextMetricsTest = {abstract} class(TTextMetricsPrimTest)
  {* ���� ����������� ������� ������. ����� ��� AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTextMetricsTest
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
;

{$If NOT Defined(NoVCM)}
procedure TTextMetricsTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4D076A0C03C4_var*
//#UC END# *4BE13147032C_4D076A0C03C4_var*
begin
//#UC START# *4BE13147032C_4D076A0C03C4_impl*
 // - ������ �� ������
//#UC END# *4BE13147032C_4D076A0C03C4_impl*
end;//TTextMetricsTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TTextMetricsTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TTextMetricsTest.GetFolder

function TTextMetricsTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D076A0C03C4';
end;//TTextMetricsTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
