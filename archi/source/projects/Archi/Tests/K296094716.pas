unit K296094716;
 {* [Requestlink:296094716] }

// ������: "w:\archi\source\projects\Archi\Tests\K296094716.pas"
// ���������: "TestCase"
// ������� ������: "K296094716" MUID: (4EB8DEE400FE)
// ��� ����: "TK296094716"

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
 TK296094716 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:296094716] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK296094716
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4EB8DEE400FEimpl_uses*
 //#UC END# *4EB8DEE400FEimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK296094716.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK296094716.GetFolder

function TK296094716.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EB8DEE400FE';
end;//TK296094716.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK296094716.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
