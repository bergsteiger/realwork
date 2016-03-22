unit K431386215;
 {* [RequestLink:431386215] }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K431386215.pas"
// ���������: "TestCase"
// ������� ������: "K431386215" MUID: (512DCAD901C3)
// ��� ����: "TK431386215"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK431386215 = class(TArchiInsiderTest)
  {* [RequestLink:431386215] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK431386215
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK431386215.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FileFormatTests';
end;//TK431386215.GetFolder

function TK431386215.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '512DCAD901C3';
end;//TK431386215.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK431386215.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
