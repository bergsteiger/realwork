unit K320743144;
 {* [Requestlink:320743144] }

// ������: "w:\archi\source\projects\Archi\Tests\K320743144.pas"
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
 TK320743144 = class(TArchiInsiderTest)
  {* [Requestlink:320743144] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK320743144
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK320743144.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SBSTests';
end;//TK320743144.GetFolder

function TK320743144.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EF03F8103BB';
end;//TK320743144.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK320743144.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
