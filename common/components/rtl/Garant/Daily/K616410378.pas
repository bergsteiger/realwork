unit K616410378;
 {* [Requestlink:616410378] - � ������ ������� ������ #13 }

// ������: "w:\common\components\rtl\Garant\Daily\K616410378.pas"
// ���������: "TestCase"
// ������� ������: "K616410378" MUID: (56B1B04203D9)
// ��� ����: "TK616410378"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK616410378 = class(THTMLtoEVDTest)
  {* [Requestlink:616410378] - � ������ ������� ������ #13 }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK616410378
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK616410378.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK616410378.GetFolder

function TK616410378.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56B1B04203D9';
end;//TK616410378.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616410378.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
