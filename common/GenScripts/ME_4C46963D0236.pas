unit K227478617;
 {* [RequestLink:227478617] }

// ������: "w:\common\components\rtl\Garant\Daily\K227478617.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DeleteCharTest
;

type
 TK227478617 = class(TDeleteCharTest)
  {* [RequestLink:227478617] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK227478617
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOp
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

function TK227478617.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK227478617.GetFolder

function TK227478617.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C46963D0236';
end;//TK227478617.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK227478617.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
