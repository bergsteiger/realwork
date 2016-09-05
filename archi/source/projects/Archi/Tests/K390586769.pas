unit K390586769;
 {* [Requestlink:390586769] }

// ������: "w:\archi\source\projects\Archi\Tests\K390586769.pas"
// ���������: "TestCase"
// ������� ������: "K390586769" MUID: (5049BB9D03A9)
// ��� ����: "TK390586769"

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
 TK390586769 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:390586769] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK390586769
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5049BB9D03A9impl_uses*
 //#UC END# *5049BB9D03A9impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK390586769.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK390586769.GetFolder

function TK390586769.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5049BB9D03A9';
end;//TK390586769.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK390586769.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
