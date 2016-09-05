unit K380604713;
 {* [Requestlink:380604713] }

// ������: "w:\archi\source\projects\Archi\Tests\K380604713.pas"
// ���������: "TestCase"
// ������� ������: "TK380604713" MUID: (5017CA2F0220)

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
 TK380604713 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:380604713] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK380604713
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5017CA2F0220impl_uses*
 //#UC END# *5017CA2F0220impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK380604713.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK380604713.GetFolder

function TK380604713.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5017CA2F0220';
end;//TK380604713.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK380604713.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
