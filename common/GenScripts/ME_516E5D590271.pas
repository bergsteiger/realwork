unit K332202037;
 {* [Requestlink:332202037] }

// ������: "w:\common\components\rtl\Garant\Daily\K332202037.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK332202037 = class(THTMLtoEVDTest)
  {* [Requestlink:332202037] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK332202037
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK332202037.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK332202037.GetFolder

function TK332202037.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '516E5D590271';
end;//TK332202037.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK332202037.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
