unit K459284317;
 {* [Requestlink:459284317] }

// ������: "w:\common\components\rtl\Garant\Daily\K459284317.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK459284317 = class(THTMLtoEVDTest)
  {* [Requestlink:459284317] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK459284317
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK459284317.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK459284317.GetFolder

function TK459284317.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51AC5D28030C';
end;//TK459284317.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK459284317.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
