unit K227477421;
 {* [$227477421] }

// ������: "w:\common\components\rtl\Garant\Daily\K227477421.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackByLineWithCheckTopAnchoTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK227477421 = class(TScrollBackByLineWithCheckTopAnchoTest)
  {* [$227477421] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK227477421
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
function TK227477421.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C46BCC6031B_var*
//#UC END# *4C07AC6F036D_4C46BCC6031B_var*
begin
//#UC START# *4C07AC6F036D_4C46BCC6031B_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C46BCC6031B_impl*
end;//TK227477421.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK227477421.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK227477421.GetFolder

function TK227477421.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C46BCC6031B';
end;//TK227477421.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK227477421.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
