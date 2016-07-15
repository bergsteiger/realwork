unit K627006470;
 {* [Requestlink:627006470] }

// ������: "w:\common\components\rtl\Garant\Daily\K627006470.pas"
// ���������: "TestCase"
// ������� ������: "K627006470" MUID: (5787706900B4)
// ��� ����: "TK627006470"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK627006470 = class(THTMLtoEVDFull)
  {* [Requestlink:627006470] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK627006470
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK627006470.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK627006470.GetFolder

function TK627006470.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5787706900B4';
end;//TK627006470.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK627006470.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
