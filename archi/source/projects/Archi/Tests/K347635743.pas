unit K347635743;
 {* [Requestlink:347635743] }

// ������: "w:\archi\source\projects\Archi\Tests\K347635743.pas"
// ���������: "TestCase"
// ������� ������: "K347635743" MUID: (4F6C55C0020E)
// ��� ����: "TK347635743"

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
 TK347635743 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:347635743] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK347635743
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F6C55C0020Eimpl_uses*
 //#UC END# *4F6C55C0020Eimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK347635743.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Text2TableTests';
end;//TK347635743.GetFolder

function TK347635743.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F6C55C0020E';
end;//TK347635743.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK347635743.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
