unit K206079417;
 {* [RequestLink:206079417] }

// ������: "w:\common\components\rtl\Garant\Daily\K206079417.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMetricsAfterCopyPasteTest
;

type
 TK206079417 = class(TTextMetricsAfterCopyPasteTest)
  {* [RequestLink:206079417] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK206079417
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , evTypes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TK206079417.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK206079417.GetFolder

function TK206079417.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D076ADA00B9';
end;//TK206079417.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK206079417.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
