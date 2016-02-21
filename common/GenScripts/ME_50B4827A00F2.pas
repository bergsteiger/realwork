unit K410628348;
 {* [Requestlink:410628348] }

// ������: "w:\archi\source\projects\Archi\Tests\K410628348.pas"
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
 TK410628348 = class(TArchiInsiderTest)
  {* [Requestlink:410628348] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK410628348
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK410628348.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK410628348.GetFolder

function TK410628348.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50B4827A00F2';
end;//TK410628348.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK410628348.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
