unit K449678171;
 {* [Requestlink:449678171] }

// ������: "w:\archi\source\projects\Archi\Tests\K449678171.pas"
// ���������: "TestCase"
// ������� ������: "K449678171" MUID: (51DBB4910007)
// ��� ����: "TK449678171"

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
 TK449678171 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:449678171] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK449678171
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51DBB4910007impl_uses*
 //#UC END# *51DBB4910007impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK449678171.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK449678171.GetFolder

function TK449678171.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51DBB4910007';
end;//TK449678171.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK449678171.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
