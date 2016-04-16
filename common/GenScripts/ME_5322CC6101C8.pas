unit K514874341;
 {* [Requestlink:514874341] }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K514874341.pas"
// ���������: "TestCase"
// ������� ������: "K514874341" MUID: (5322CC6101C8)
// ��� ����: "TK514874341"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK514874341 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:514874341] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK514874341
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK514874341.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FileFormatTests';
end;//TK514874341.GetFolder

function TK514874341.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5322CC6101C8';
end;//TK514874341.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK514874341.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
