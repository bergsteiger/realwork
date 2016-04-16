unit K424381826;
 {* [Requestlink:424381826] }

// ������: "w:\archi\source\projects\Archi\Tests\K424381826.pas"
// ���������: "TestCase"
// ������� ������: "K424381826" MUID: (50F7C3A20106)
// ��� ����: "TK424381826"

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
 TK424381826 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:424381826] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK424381826
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK424381826.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ColumnResize';
end;//TK424381826.GetFolder

function TK424381826.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50F7C3A20106';
end;//TK424381826.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK424381826.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
