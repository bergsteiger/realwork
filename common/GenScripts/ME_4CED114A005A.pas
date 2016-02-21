unit K111739572;
 {* [$111739572] }

// ������: "w:\common\components\rtl\Garant\Daily\K111739572.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CellMouseSelectionTest
;

type
 TK111739572 = class(TCellMouseSelectionTest)
  {* [$111739572] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK111739572
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TK111739572.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK111739572.GetFolder

function TK111739572.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CED114A005A';
end;//TK111739572.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK111739572.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
