unit K425035996;
 {* [Requestlink:425035996] }

// ������: "w:\archi\source\projects\Archi\Tests\K425035996.pas"
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
 TK425035996 = class(TArchiInsiderTest)
  {* [Requestlink:425035996] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK425035996
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK425035996.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK425035996.GetFolder

function TK425035996.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5100E5B30382';
end;//TK425035996.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425035996.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
