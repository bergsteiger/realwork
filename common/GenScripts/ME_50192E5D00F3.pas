unit K380606923;
 {* [Requestlink:380606923] }

// ������: "w:\archi\source\projects\Archi\Tests\K380606923.pas"
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
 TK380606923 = class(TArchiInsiderTest)
  {* [Requestlink:380606923] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK380606923
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK380606923.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableBoundariesAlignment';
end;//TK380606923.GetFolder

function TK380606923.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50192E5D00F3';
end;//TK380606923.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK380606923.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
