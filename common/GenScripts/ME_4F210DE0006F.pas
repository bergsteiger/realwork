unit K330140756;
 {* [Requestlink:330140756] }

// ������: "w:\archi\source\projects\Archi\Tests\K330140756.pas"
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
 TK330140756 = class(TArchiInsiderTest)
  {* [Requestlink:330140756] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK330140756
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK330140756.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableBoundariesAlignment';
end;//TK330140756.GetFolder

function TK330140756.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F210DE0006F';
end;//TK330140756.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK330140756.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
