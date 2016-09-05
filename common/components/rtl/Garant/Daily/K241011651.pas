unit K241011651;
 {* [$241011651] }

// ������: "w:\common\components\rtl\Garant\Daily\K241011651.pas"
// ���������: "TestCase"
// ������� ������: "K241011651" MUID: (4CE3E6A10030)
// ��� ����: "TK241011651"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SelectRowAndDeleteTest
;

type
 TK241011651 = class(TSelectRowAndDeleteTest)
  {* [$241011651] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK241011651
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4CE3E6A10030impl_uses*
 //#UC END# *4CE3E6A10030impl_uses*
;

function TK241011651.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK241011651.GetFolder

function TK241011651.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CE3E6A10030';
end;//TK241011651.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK241011651.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
