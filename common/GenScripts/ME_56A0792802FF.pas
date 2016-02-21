unit K615706665;
 {* [Requestlink:615706665] }

// ������: "w:\common\components\rtl\Garant\Daily\K615706665.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK615706665 = class(THTMLtoEVDTest)
  {* [Requestlink:615706665] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK615706665
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK615706665.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK615706665.GetFolder

function TK615706665.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56A0792802FF';
end;//TK615706665.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK615706665.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
