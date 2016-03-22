unit K444236481;
 {* [Requestlink:444236481] }

// ������: "w:\common\components\rtl\Garant\Daily\K444236481.pas"
// ���������: "TestCase"
// ������� ������: "K444236481" MUID: (5153D3EB035A)
// ��� ����: "TK444236481"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK444236481 = class(THTMLtoEVDTest)
  {* [Requestlink:444236481] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK444236481
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK444236481.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK444236481.GetFolder

function TK444236481.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5153D3EB035A';
end;//TK444236481.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK444236481.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
