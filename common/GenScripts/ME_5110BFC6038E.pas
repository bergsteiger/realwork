unit K425036023;
 {* [Requestlink:425036023] }

// ������: "w:\archi\source\projects\Archi\Tests\K425036023.pas"
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
 TK425036023 = class(TArchiInsiderTest)
  {* [Requestlink:425036023] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK425036023
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK425036023.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScrollTests';
end;//TK425036023.GetFolder

function TK425036023.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5110BFC6038E';
end;//TK425036023.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425036023.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
