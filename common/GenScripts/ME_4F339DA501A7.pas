unit K336660676;
 {* [Requestlink:336660676] }

// ������: "w:\archi\source\projects\Archi\Tests\K336660676.pas"
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
 TK336660676 = class(TArchiInsiderTest)
  {* [Requestlink:336660676] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK336660676
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336660676.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK336660676.GetFolder

function TK336660676.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F339DA501A7';
end;//TK336660676.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336660676.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
