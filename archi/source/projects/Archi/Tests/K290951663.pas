unit K290951663;
 {* [Requestlink:290951663] }

// ������: "w:\archi\source\projects\Archi\Tests\K290951663.pas"
// ���������: "TestCase"
// ������� ������: "K290951663" MUID: (4ECCEB2A01A9)
// ��� ����: "TK290951663"

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
 TK290951663 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:290951663] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK290951663
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4ECCEB2A01A9impl_uses*
 //#UC END# *4ECCEB2A01A9impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK290951663.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK290951663.GetFolder

function TK290951663.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4ECCEB2A01A9';
end;//TK290951663.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK290951663.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
