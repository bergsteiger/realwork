unit K482752570;
 {* [Requestlink:482752570] }

// ������: "w:\archi\source\projects\Archi\Tests\K482752570.pas"
// ���������: "TestCase"

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
 TK482752570 = class(TArchiInsiderTest)
  {* [Requestlink:482752570] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK482752570
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK482752570.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'LoadText';
end;//TK482752570.GetFolder

function TK482752570.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '52369684031C';
end;//TK482752570.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK482752570.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
