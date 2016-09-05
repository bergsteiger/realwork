unit K342862858;
 {* [Requestlink:342862858] }

// ������: "w:\archi\source\projects\Archi\Tests\K342862858.pas"
// ���������: "TestCase"
// ������� ������: "K342862858" MUID: (4F50C48F01E0)
// ��� ����: "TK342862858"

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
 TK342862858 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:342862858] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK342862858
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F50C48F01E0impl_uses*
 //#UC END# *4F50C48F01E0impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK342862858.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK342862858.GetFolder

function TK342862858.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F50C48F01E0';
end;//TK342862858.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342862858.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
