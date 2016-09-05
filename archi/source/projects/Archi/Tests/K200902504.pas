unit K200902504;
 {* [$200902504] }

// ������: "w:\archi\source\projects\Archi\Tests\K200902504.pas"
// ���������: "TestCase"
// ������� ������: "K200902504" MUID: (4E37BDB202A3)
// ��� ����: "TK200902504"

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
 TK200902504 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [$200902504] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK200902504
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E37BDB202A3impl_uses*
 //#UC END# *4E37BDB202A3impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK200902504.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK200902504.GetFolder

function TK200902504.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E37BDB202A3';
end;//TK200902504.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK200902504.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
