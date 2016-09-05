unit K347636295;
 {* [Requestlink:347636295] }

// ������: "w:\archi\source\projects\Archi\Tests\K347636295.pas"
// ���������: "TestCase"
// ������� ������: "K347636295" MUID: (4F6C55ED0287)
// ��� ����: "TK347636295"

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
 TK347636295 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:347636295] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK347636295
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F6C55ED0287impl_uses*
 //#UC END# *4F6C55ED0287impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK347636295.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Text2TableTests';
end;//TK347636295.GetFolder

function TK347636295.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F6C55ED0287';
end;//TK347636295.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK347636295.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
