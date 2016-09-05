unit K459282006;
 {* [Requestlink:459282006] }

// ������: "w:\common\components\rtl\Garant\Daily\K459282006.pas"
// ���������: "TestCase"
// ������� ������: "K459282006" MUID: (51AD9D4501CF)
// ��� ����: "TK459282006"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PageCountTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK459282006 = class({$If NOT Defined(NoVCM)}
 TPageCountTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [Requestlink:459282006] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK459282006
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
 //#UC START# *51AD9D4501CFimpl_uses*
 //#UC END# *51AD9D4501CFimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TK459282006.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK459282006.GetFolder

function TK459282006.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51AD9D4501CF';
end;//TK459282006.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK459282006.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
