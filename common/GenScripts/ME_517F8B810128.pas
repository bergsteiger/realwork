unit K453149163;
 {* [Requestlink:453149163] }

// ������: "w:\archi\source\projects\Archi\Tests\K453149163.pas"
// ���������: "TestCase"
// ������� ������: "K453149163" MUID: (517F8B810128)
// ��� ����: "TK453149163"

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
 TK453149163 = class(TArchiInsiderTest)
  {* [Requestlink:453149163] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK453149163
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK453149163.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableBoundariesAlignment';
end;//TK453149163.GetFolder

function TK453149163.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '517F8B810128';
end;//TK453149163.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK453149163.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
