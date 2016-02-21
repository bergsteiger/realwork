unit K380604713;
 {* [Requestlink:380604713] }

// ������: "w:\archi\source\projects\Archi\Tests\K380604713.pas"
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
 TK380604713 = class(TArchiInsiderTest)
  {* [Requestlink:380604713] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK380604713
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK380604713.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK380604713.GetFolder

function TK380604713.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5017CA2F0220';
end;//TK380604713.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK380604713.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
