unit K435460780;
 {* [Requestlink:435460780] }

// ������: "w:\archi\source\projects\Archi\Tests\K435460780.pas"
// ���������: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK435460780 = class(TArchiInsiderTest)
  {* [Requestlink:435460780] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK435460780
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK435460780.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK435460780.GetFolder

function TK435460780.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5141B2B601C7';
end;//TK435460780.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK435460780.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
