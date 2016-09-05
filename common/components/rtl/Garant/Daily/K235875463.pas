unit K235875463;
 {* [$235875463] }

// ������: "w:\common\components\rtl\Garant\Daily\K235875463.pas"
// ���������: "TestCase"
// ������� ������: "K235875463" MUID: (4CB6D8DE0165)
// ��� ����: "TK235875463"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollByLineTest
;

type
 TK235875463 = class(TScrollByLineTest)
  {* [$235875463] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235875463
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
 //#UC START# *4CB6D8DE0165impl_uses*
 //#UC END# *4CB6D8DE0165impl_uses*
;

function TK235875463.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235875463.GetFolder

function TK235875463.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CB6D8DE0165';
end;//TK235875463.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235875463.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
