unit K109904163;
 {* [Requestlink:109904163] }

// ������: "w:\archi\source\projects\Archi\Tests\K109904163.pas"
// ���������: "TestCase"
// ������� ������: "K109904163" MUID: (4ED76BDA0286)
// ��� ����: "TK109904163"

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
 TK109904163 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:109904163] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK109904163
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4ED76BDA0286impl_uses*
 //#UC END# *4ED76BDA0286impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK109904163.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SBSTests';
end;//TK109904163.GetFolder

function TK109904163.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4ED76BDA0286';
end;//TK109904163.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK109904163.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
