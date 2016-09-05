unit K365844614;
 {* [Requestlink:365844614] }

// ������: "w:\archi\source\projects\Archi\Tests\K365844614.pas"
// ���������: "TestCase"
// ������� ������: "K365844614" MUID: (4FBE296F0084)
// ��� ����: "TK365844614"

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
 TK365844614 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:365844614] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK365844614
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FBE296F0084impl_uses*
 //#UC END# *4FBE296F0084impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK365844614.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK365844614.GetFolder

function TK365844614.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FBE296F0084';
end;//TK365844614.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK365844614.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
