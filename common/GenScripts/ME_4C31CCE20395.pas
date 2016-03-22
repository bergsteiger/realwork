unit K223608965;
 {* [RequestLink:223608965] }

// ������: "w:\common\components\rtl\Garant\Daily\K223608965.pas"
// ���������: "TestCase"
// ������� ������: "K223608965" MUID: (4C31CCE20395)
// ��� ����: "TK223608965"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TwoEmptyParaForOneReplacerTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK223608965 = class(TTwoEmptyParaForOneReplacerTest)
  {* [RequestLink:223608965] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK223608965
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
function TK223608965.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK223608965.GetFolder

function TK223608965.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C31CCE20395';
end;//TK223608965.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK223608965.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
