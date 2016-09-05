unit K258613004;
 {* [$258613004] }

// ������: "w:\common\components\rtl\Garant\Daily\K258613004.pas"
// ���������: "TestCase"
// ������� ������: "K258613004" MUID: (4DA6915201AB)
// ��� ����: "TK258613004"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , LinesTest
;

type
 TK258613004 = class(TLinesTest)
  {* [$258613004] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK258613004
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
 //#UC START# *4DA6915201ABimpl_uses*
 //#UC END# *4DA6915201ABimpl_uses*
;

function TK258613004.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK258613004.GetFolder

function TK258613004.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DA6915201AB';
end;//TK258613004.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK258613004.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
