unit K459284359;
 {* [Requestlink:459284359] }

// ������: "w:\common\components\rtl\Garant\Daily\K459284359.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK459284359 = class(THTMLtoEVDTest)
  {* [Requestlink:459284359] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK459284359
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK459284359.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK459284359.GetFolder

function TK459284359.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51AC93AE000C';
end;//TK459284359.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK459284359.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
