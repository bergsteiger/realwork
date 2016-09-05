unit K370389917;
 {* [Requestlink:370389917] }

// ������: "w:\archi\source\projects\Archi\Tests\K370389917.pas"
// ���������: "TestCase"
// ������� ������: "K370389917" MUID: (4FF162EF020B)
// ��� ����: "TK370389917"

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
 TK370389917 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:370389917] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK370389917
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FF162EF020Bimpl_uses*
 //#UC END# *4FF162EF020Bimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK370389917.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Drawing Tests';
end;//TK370389917.GetFolder

function TK370389917.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FF162EF020B';
end;//TK370389917.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370389917.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
