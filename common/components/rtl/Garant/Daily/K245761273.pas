unit K245761273;
 {* [RequestLink:245761273] }

// ������: "w:\common\components\rtl\Garant\Daily\K245761273.pas"
// ���������: "TestCase"
// ������� ������: "K245761273" MUID: (4D02576200E5)
// ��� ����: "TK245761273"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoBlockTest
;

type
 TK245761273 = class(TAutoBlockTest)
  {* [RequestLink:245761273] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK245761273
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
 //#UC START# *4D02576200E5impl_uses*
 //#UC END# *4D02576200E5impl_uses*
;

function TK245761273.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK245761273.GetFolder

function TK245761273.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D02576200E5';
end;//TK245761273.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK245761273.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
