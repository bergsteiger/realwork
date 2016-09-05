unit K382406560;
 {* [Requestlink:382406560] }

// ������: "w:\archi\source\projects\Archi\Tests\K382406560.pas"
// ���������: "TestCase"
// ������� ������: "K382406560" MUID: (51A489C8039F)
// ��� ����: "TK382406560"

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
 TK382406560 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:382406560] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK382406560
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51A489C8039Fimpl_uses*
 //#UC END# *51A489C8039Fimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK382406560.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK382406560.GetFolder

function TK382406560.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51A489C8039F';
end;//TK382406560.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382406560.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
