unit K397291894;
 {* [Requestlink:397291894] }

// ������: "w:\archi\source\projects\Archi\Tests\K397291894.pas"
// ���������: "TestCase"
// ������� ������: "K397291894" MUID: (5069994C0040)
// ��� ����: "TK397291894"

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
 TK397291894 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:397291894] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK397291894
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5069994C0040impl_uses*
 //#UC END# *5069994C0040impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK397291894.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK397291894.GetFolder

function TK397291894.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5069994C0040';
end;//TK397291894.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK397291894.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
