unit K479402808;
 {* [Requestlink:479402808] }

// ������: "w:\archi\source\projects\Archi\Tests\K479402808.pas"
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
 TK479402808 = class(TArchiInsiderTest)
  {* [Requestlink:479402808] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK479402808
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK479402808.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK479402808.GetFolder

function TK479402808.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '521C74DD03CD';
end;//TK479402808.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK479402808.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
