unit K522781517;
 {* [Requestlink:522781517] }

// ������: "w:\common\components\rtl\Garant\Daily\K522781517.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK522781517 = class(THTMLtoEVDTest)
  {* [Requestlink:522781517] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK522781517
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK522781517.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK522781517.GetFolder

function TK522781517.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54CA21700180';
end;//TK522781517.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK522781517.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
