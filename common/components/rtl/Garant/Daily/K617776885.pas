unit K617776885;
 {* [Requestlink:617776885] }

// ������: "w:\common\components\rtl\Garant\Daily\K617776885.pas"
// ���������: "TestCase"
// ������� ������: "K617776885" MUID: (56D6CF100372)
// ��� ����: "TK617776885"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK617776885 = class(THTMLtoEVDFull)
  {* [Requestlink:617776885] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK617776885
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK617776885.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK617776885.GetFolder

function TK617776885.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56D6CF100372';
end;//TK617776885.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK617776885.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
