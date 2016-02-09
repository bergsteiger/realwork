unit K543448591;
 {* [RequestLink:543448591] }

// ������: "w:\common\components\rtl\Garant\Daily\K543448591.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , FormulaRender
;

type
 TK543448591 = class(TFormulaRender)
  {* [RequestLink:543448591] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK543448591
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

function TK543448591.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'RenderFormula';
end;//TK543448591.GetFolder

function TK543448591.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53BE724501DB';
end;//TK543448591.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK543448591.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
