unit K460279011;
 {* [Requestlink:460279011] }

// ������: "w:\common\components\rtl\Garant\Daily\K460279011.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK460279011 = class(THTMLtoEVDTest)
  {* [Requestlink:460279011] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK460279011
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK460279011.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.9';
end;//TK460279011.GetFolder

function TK460279011.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51F0F95E0269';
end;//TK460279011.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK460279011.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
