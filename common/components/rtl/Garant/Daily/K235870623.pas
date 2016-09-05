unit K235870623;
 {* [RequestLink:235870623] }

// ������: "w:\common\components\rtl\Garant\Daily\K235870623.pas"
// ���������: "TestCase"
// ������� ������: "K235870623" MUID: (4D3D44B901C0)
// ��� ����: "TK235870623"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MouseMoveCellsSelectTest
;

type
 TK235870623 = class(TMouseMoveCellsSelectTest)
  {* [RequestLink:235870623] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235870623
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4D3D44B901C0impl_uses*
 //#UC END# *4D3D44B901C0impl_uses*
;

function TK235870623.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK235870623.GetFolder

function TK235870623.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D3D44B901C0';
end;//TK235870623.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235870623.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
