unit K494524369;
 {* [RequestLink:494524369] }

// ������: "w:\common\components\rtl\Garant\Daily\K494524369.pas"
// ���������: "TestCase"
// ������� ������: "K494524369" MUID: (5264E65902EA)
// ��� ����: "TK494524369"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK494524369 = class(THTMLtoEVDTest)
  {* [RequestLink:494524369] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK494524369
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK494524369.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK494524369.GetFolder

function TK494524369.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5264E65902EA';
end;//TK494524369.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK494524369.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
