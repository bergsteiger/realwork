unit K430740658;
 {* [Requestlink:430740658] }

// ������: "w:\archi\source\projects\Archi\Tests\K430740658.pas"
// ���������: "TestCase"
// ������� ������: "K430740658" MUID: (512481A202F2)
// ��� ����: "TK430740658"

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
 TK430740658 = class(TArchiInsiderTest)
  {* [Requestlink:430740658] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK430740658
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK430740658.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'MacrosTest';
end;//TK430740658.GetFolder

function TK430740658.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '512481A202F2';
end;//TK430740658.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK430740658.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
