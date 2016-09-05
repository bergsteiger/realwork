unit K358353189;
 {* [Requestlink:358353189] }

// ������: "w:\archi\source\projects\Archi\Tests\K358353189.pas"
// ���������: "TestCase"
// ������� ������: "K358353189" MUID: (4F87CFB600D1)
// ��� ����: "TK358353189"

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
 TK358353189 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:358353189] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK358353189
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F87CFB600D1impl_uses*
 //#UC END# *4F87CFB600D1impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK358353189.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK358353189.GetFolder

function TK358353189.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F87CFB600D1';
end;//TK358353189.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358353189.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
