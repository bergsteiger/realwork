unit K494528807;
 {* [Requestlink:494528807] }

// ������: "w:\common\components\rtl\Garant\Daily\K494528807.pas"
// ���������: "TestCase"
// ������� ������: "K494528807" MUID: (526636F001CE)
// ��� ����: "TK494528807"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK494528807 = class(THTMLtoEVDTest)
  {* [Requestlink:494528807] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK494528807
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK494528807.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK494528807.GetFolder

function TK494528807.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '526636F001CE';
end;//TK494528807.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK494528807.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
