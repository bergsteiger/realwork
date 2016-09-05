unit K226005021;
 {* [$226005021] }

// ������: "w:\common\components\rtl\Garant\Daily\K226005021.pas"
// ���������: "TestCase"
// ������� ������: "K226005021" MUID: (4C3FEF2300B0)
// ��� ����: "TK226005021"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OldNSRCFlagCnahge
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK226005021 = class({$If NOT Defined(NoVCM)}
 TOldNSRCFlagCnahge
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$226005021] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK226005021
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
 //#UC START# *4C3FEF2300B0impl_uses*
 //#UC END# *4C3FEF2300B0impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK226005021.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK226005021.GetFolder

function TK226005021.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C3FEF2300B0';
end;//TK226005021.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226005021.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
