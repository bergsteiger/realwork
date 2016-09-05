unit K229213001;
 {* [RequestLink:229213001] }

// ������: "w:\common\components\rtl\Garant\Daily\K229213001.pas"
// ���������: "TestCase"
// ������� ������: "K229213001" MUID: (4C5183260027)
// ��� ����: "TK229213001"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , SearchAndReplaceTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK229213001 = class({$If NOT Defined(NoVCM)}
 TSearchAndReplaceTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:229213001] }
  protected
   {$If NOT Defined(NoVCM)}
   function StringForSearch: AnsiString; override;
    {* ������ ��� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function StringForReplace: AnsiString; override;
    {* ������ ��� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK229213001
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
 //#UC START# *4C5183260027impl_uses*
 //#UC END# *4C5183260027impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK229213001.StringForSearch: AnsiString;
 {* ������ ��� ������ }
//#UC START# *4BE051200169_4C5183260027_var*
//#UC END# *4BE051200169_4C5183260027_var*
begin
//#UC START# *4BE051200169_4C5183260027_impl*
 Result := 'bbb';
//#UC END# *4BE051200169_4C5183260027_impl*
end;//TK229213001.StringForSearch

function TK229213001.StringForReplace: AnsiString;
 {* ������ ��� ������ }
//#UC START# *4BE0513800C9_4C5183260027_var*
//#UC END# *4BE0513800C9_4C5183260027_var*
begin
//#UC START# *4BE0513800C9_4C5183260027_impl*
 Result := #13#10;
//#UC END# *4BE0513800C9_4C5183260027_impl*
end;//TK229213001.StringForReplace

function TK229213001.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK229213001.GetFolder

function TK229213001.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C5183260027';
end;//TK229213001.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK229213001.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
