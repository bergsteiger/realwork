unit K341838531;
 {* [Requestlink:341838531] }

// ������: "w:\archi\source\projects\Archi\Tests\K341838531.pas"
// ���������: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK341838531 = class(TArchiInsiderTest)
  {* [Requestlink:341838531] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK341838531
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK341838531.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK341838531.GetFolder

function TK341838531.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F4B277E035B';
end;//TK341838531.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK341838531.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
