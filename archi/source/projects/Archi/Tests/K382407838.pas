unit K382407838;
 {* [Requestlink:382407838] }

// ������: "w:\archi\source\projects\Archi\Tests\K382407838.pas"
// ���������: "TestCase"
// ������� ������: "K382407838" MUID: (502A4778025B)
// ��� ����: "TK382407838"

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
 TK382407838 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:382407838] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK382407838
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *502A4778025Bimpl_uses*
 //#UC END# *502A4778025Bimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK382407838.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK382407838.GetFolder

function TK382407838.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '502A4778025B';
end;//TK382407838.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382407838.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
