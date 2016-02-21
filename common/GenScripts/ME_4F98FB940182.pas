unit K336667714;
 {* [Requestlink:336667714] }

// ������: "w:\archi\source\projects\Archi\Tests\K336667714.pas"
// ���������: "TestCase"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK336667714 = class(TArchiInsiderTest)
  {* [Requestlink:336667714] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK336667714
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336667714.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK336667714.GetFolder

function TK336667714.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F98FB940182';
end;//TK336667714.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336667714.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
