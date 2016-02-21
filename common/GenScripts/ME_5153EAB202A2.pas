unit K437519085;
 {* [Requestlink:437519085] }

// ������: "w:\archi\source\projects\Archi\Tests\K437519085.pas"
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
 TK437519085 = class(TArchiInsiderTest)
  {* [Requestlink:437519085] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK437519085
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK437519085.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableBoundariesAlignment';
end;//TK437519085.GetFolder

function TK437519085.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5153EAB202A2';
end;//TK437519085.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK437519085.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
