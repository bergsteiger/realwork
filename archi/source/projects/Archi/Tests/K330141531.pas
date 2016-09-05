unit K330141531;
 {* [Requestlink:330141531] }

// ������: "w:\archi\source\projects\Archi\Tests\K330141531.pas"
// ���������: "TestCase"
// ������� ������: "K330141531" MUID: (4F2679EA023D)
// ��� ����: "TK330141531"

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
 TK330141531 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:330141531] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK330141531
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F2679EA023Dimpl_uses*
 //#UC END# *4F2679EA023Dimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK330141531.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DialogTest';
end;//TK330141531.GetFolder

function TK330141531.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F2679EA023D';
end;//TK330141531.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK330141531.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
