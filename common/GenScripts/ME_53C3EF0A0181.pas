unit K554585756;
 {* [RequestLink:554585756] }

// ������: "w:\common\components\rtl\Garant\Daily\K554585756.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , FormulaRender
;

type
 TK554585756 = class(TFormulaRender)
  {* [RequestLink:554585756] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK554585756
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

function TK554585756.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'RenderFormula';
end;//TK554585756.GetFolder

function TK554585756.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53C3EF0A0181';
end;//TK554585756.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK554585756.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
