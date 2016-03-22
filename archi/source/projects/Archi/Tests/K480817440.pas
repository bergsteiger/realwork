unit K480817440;
 {* [Requestlink:480817440] }

// ������: "w:\archi\source\projects\Archi\Tests\K480817440.pas"
// ���������: "TestCase"
// ������� ������: "K480817440" MUID: (521F395B0241)
// ��� ����: "TK480817440"

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
 TK480817440 = class(TArchiInsiderTest)
  {* [Requestlink:480817440] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK480817440
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK480817440.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'LoadText';
end;//TK480817440.GetFolder

function TK480817440.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '521F395B0241';
end;//TK480817440.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK480817440.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
