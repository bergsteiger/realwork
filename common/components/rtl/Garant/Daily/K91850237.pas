unit K91850237;
 {* [$91850237] }

// ������: "w:\common\components\rtl\Garant\Daily\K91850237.pas"
// ���������: "TestCase"
// ������� ������: "K91850237" MUID: (4D79E21C03A5)
// ��� ����: "TK91850237"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , VerticalCursorMovingTest
;

type
 TK91850237 = class(TVerticalCursorMovingTest)
  {* [$91850237] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK91850237
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK91850237.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK91850237.GetFolder

function TK91850237.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D79E21C03A5';
end;//TK91850237.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK91850237.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
