unit K371639884;
 {* [RequestLink:371639884] }

// ������: "w:\common\components\rtl\Garant\Daily\K371639884.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , FormulaRender
;

type
 TK371639884 = class(TFormulaRender)
  {* [RequestLink:371639884] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK371639884
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK371639884.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK371639884.GetFolder

function TK371639884.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '537B49A5027A';
end;//TK371639884.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK371639884.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
