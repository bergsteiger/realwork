unit K617316346;
 {* [Requestlink:617316346] }

// ������: "w:\common\components\rtl\Garant\Daily\K617316346.pas"
// ���������: "TestCase"
// ������� ������: "K617316346" MUID: (56C1ABDB02F0)
// ��� ����: "TK617316346"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDWithApplyTextCorrections
;

type
 TK617316346 = class(THTMLtoEVDWithApplyTextCorrections)
  {* [Requestlink:617316346] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK617316346
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK617316346.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK617316346.GetFolder

function TK617316346.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56C1ABDB02F0';
end;//TK617316346.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK617316346.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
