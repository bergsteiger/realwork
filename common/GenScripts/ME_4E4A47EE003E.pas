unit K278843000;
 {* [$278843000] }

// ������: "w:\archi\source\projects\Archi\Tests\K278843000.pas"
// ���������: "TestCase"
// ������� ������: "K278843000" MUID: (4E4A47EE003E)
// ��� ����: "TK278843000"

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
 TK278843000 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [$278843000] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK278843000
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK278843000.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'MacrosTest';
end;//TK278843000.GetFolder

function TK278843000.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E4A47EE003E';
end;//TK278843000.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK278843000.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
