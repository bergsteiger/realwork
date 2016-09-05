unit K345637305;
 {* [Requestlink:345637305] }

// ������: "w:\archi\source\projects\Archi\Tests\K345637305.pas"
// ���������: "TestCase"
// ������� ������: "K345637305" MUID: (4F60A9A50191)
// ��� ����: "TK345637305"

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
 TK345637305 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:345637305] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK345637305
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F60A9A50191impl_uses*
 //#UC END# *4F60A9A50191impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK345637305.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK345637305.GetFolder

function TK345637305.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F60A9A50191';
end;//TK345637305.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK345637305.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
