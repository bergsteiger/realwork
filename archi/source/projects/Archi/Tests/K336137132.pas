unit K336137132;
 {* [Requestlink:336137132] }

// ������: "w:\archi\source\projects\Archi\Tests\K336137132.pas"
// ���������: "TestCase"
// ������� ������: "TK336137132" MUID: (4F30E48602B2)

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
 TK336137132 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:336137132] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK336137132
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F30E48602B2impl_uses*
 //#UC END# *4F30E48602B2impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK336137132.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK336137132.GetFolder

function TK336137132.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F30E48602B2';
end;//TK336137132.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336137132.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
