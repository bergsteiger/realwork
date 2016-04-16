unit K235060094;
 {* [$235060094] }

// ������: "w:\common\components\rtl\Garant\Daily\K235060094.pas"
// ���������: "TestCase"
// ������� ������: "K235060094" MUID: (4CA1DB0C01D6)
// ��� ����: "TK235060094"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackByLineTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK235060094 = class({$If NOT Defined(NoVCM)}
 TScrollBackByLineTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$235060094] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235060094
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
function TK235060094.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235060094.GetFolder

function TK235060094.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA1DB0C01D6';
end;//TK235060094.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235060094.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
