unit K377750479;
 {* [Requestlink:377750479] }

// ������: "w:\archi\source\projects\Archi\Tests\K377750479.pas"
// ���������: "TestCase"
// ������� ������: "K377750479" MUID: (516BB93402B5)
// ��� ����: "TK377750479"

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
 TK377750479 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:377750479] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK377750479
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *516BB93402B5impl_uses*
 //#UC END# *516BB93402B5impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK377750479.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK377750479.GetFolder

function TK377750479.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '516BB93402B5';
end;//TK377750479.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK377750479.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
