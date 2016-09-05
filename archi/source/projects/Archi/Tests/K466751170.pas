unit K466751170;
 {* [Requestlink:466751170] }

// ������: "w:\archi\source\projects\Archi\Tests\K466751170.pas"
// ���������: "TestCase"
// ������� ������: "K466751170" MUID: (51D16D750188)
// ��� ����: "TK466751170"

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
 TK466751170 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:466751170] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK466751170
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51D16D750188impl_uses*
 //#UC END# *51D16D750188impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK466751170.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK466751170.GetFolder

function TK466751170.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51D16D750188';
end;//TK466751170.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK466751170.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
