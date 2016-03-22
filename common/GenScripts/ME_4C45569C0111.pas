unit K227477159;
 {* [$227477159] }

// ������: "w:\common\components\rtl\Garant\Daily\K227477159.pas"
// ���������: "TestCase"
// ������� ������: "K227477159" MUID: (4C45569C0111)
// ��� ����: "TK227477159"

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
 TK227477159 = class(TScrollBackByLineTest)
  {* [$227477159] }
  protected
   {$If NOT Defined(NoVCM)}
   function MaxHeight: Integer; override;
    {* ���� ������������ �� 0, �� ����� ����������� ���� ������� ������ �� FormExtent.Y �� MaxHeight }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK227477159
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
function TK227477159.MaxHeight: Integer;
 {* ���� ������������ �� 0, �� ����� ����������� ���� ������� ������ �� FormExtent.Y �� MaxHeight }
//#UC START# *4C0E56F000A4_4C45569C0111_var*
//#UC END# *4C0E56F000A4_4C45569C0111_var*
begin
//#UC START# *4C0E56F000A4_4C45569C0111_impl*
 Result := 12;
//#UC END# *4C0E56F000A4_4C45569C0111_impl*
end;//TK227477159.MaxHeight

function TK227477159.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK227477159.GetFolder

function TK227477159.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C45569C0111';
end;//TK227477159.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK227477159.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
