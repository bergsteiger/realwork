unit K336666483;
 {* [Requestlink:336666483] }

// ������: "w:\common\components\rtl\Garant\Daily\K336666483.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK336666483 = class(THTMLtoEVDTest)
  {* [Requestlink:336666483] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK336666483
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336666483.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK336666483.GetFolder

function TK336666483.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '516E5E16001A';
end;//TK336666483.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336666483.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
