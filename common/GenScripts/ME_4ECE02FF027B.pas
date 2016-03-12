unit K299140051;
 {* [RequestLink:299140051] }

// ������: "w:\archi\source\projects\Archi\Tests\K299140051.pas"
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
 TK299140051 = class(TArchiInsiderTest)
  {* [RequestLink:299140051] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK299140051
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK299140051.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScrollTests';
end;//TK299140051.GetFolder

function TK299140051.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4ECE02FF027B';
end;//TK299140051.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK299140051.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
