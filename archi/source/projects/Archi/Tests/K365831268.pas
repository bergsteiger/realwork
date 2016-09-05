unit K365831268;
 {* [Requestlink:365831268] }

// ������: "w:\archi\source\projects\Archi\Tests\K365831268.pas"
// ���������: "TestCase"
// ������� ������: "K365831268" MUID: (4FBCBE3A00EE)
// ��� ����: "TK365831268"

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
 TK365831268 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:365831268] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK365831268
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FBCBE3A00EEimpl_uses*
 //#UC END# *4FBCBE3A00EEimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK365831268.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK365831268.GetFolder

function TK365831268.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FBCBE3A00EE';
end;//TK365831268.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK365831268.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
