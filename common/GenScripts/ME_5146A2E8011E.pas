unit K437519030;
 {* [Requestlink:437519030] }

// ������: "w:\archi\source\projects\Archi\Tests\K437519030.pas"
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
 TK437519030 = class(TArchiInsiderTest)
  {* [Requestlink:437519030] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK437519030
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK437519030.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableResize';
end;//TK437519030.GetFolder

function TK437519030.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5146A2E8011E';
end;//TK437519030.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK437519030.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
