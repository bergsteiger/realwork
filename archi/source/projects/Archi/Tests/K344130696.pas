unit K344130696;
 {* [Requestlink:344130696] }

// ������: "w:\archi\source\projects\Archi\Tests\K344130696.pas"
// ���������: "TestCase"
// ������� ������: "K344130696" MUID: (4F5C65F403D7)
// ��� ����: "TK344130696"

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
 TK344130696 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:344130696] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK344130696
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F5C65F403D7impl_uses*
 //#UC END# *4F5C65F403D7impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK344130696.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK344130696.GetFolder

function TK344130696.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F5C65F403D7';
end;//TK344130696.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK344130696.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
