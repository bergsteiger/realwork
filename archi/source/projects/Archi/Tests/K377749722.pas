unit K377749722;
 {* [Requestlink:377749722] }

// ������: "w:\archi\source\projects\Archi\Tests\K377749722.pas"
// ���������: "TestCase"
// ������� ������: "K377749722" MUID: (5170F84503CB)
// ��� ����: "TK377749722"

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
 TK377749722 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:377749722] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK377749722
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5170F84503CBimpl_uses*
 //#UC END# *5170F84503CBimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK377749722.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'OEMTextTests';
end;//TK377749722.GetFolder

function TK377749722.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5170F84503CB';
end;//TK377749722.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK377749722.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
