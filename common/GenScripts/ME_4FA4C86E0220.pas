unit K362973200;
 {* [Requestlink:362973200] }

// ������: "w:\archi\source\projects\Archi\Tests\K362973200.pas"
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
 TK362973200 = class(TArchiInsiderTest)
  {* [Requestlink:362973200] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK362973200
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK362973200.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableBoundariesAlignment';
end;//TK362973200.GetFolder

function TK362973200.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FA4C86E0220';
end;//TK362973200.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK362973200.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
