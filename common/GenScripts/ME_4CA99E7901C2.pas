unit K235864157;
 {* [$235864157] }

// ������: "w:\common\components\rtl\Garant\Daily\K235864157.pas"
// ���������: "TestCase"
// ������� ������: "K235864157" MUID: (4CA99E7901C2)
// ��� ����: "TK235864157"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CheckTopAnchorTest
;

type
 TK235864157 = class(TCheckTopAnchorTest)
  {* [$235864157] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235864157
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

function TK235864157.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235864157.GetFolder

function TK235864157.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA99E7901C2';
end;//TK235864157.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235864157.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
