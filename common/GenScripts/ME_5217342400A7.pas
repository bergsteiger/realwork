unit K441354827;
 {* [Requestlink:441354827] }

// ������: "w:\archi\source\projects\Archi\Tests\K441354827.pas"
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
 TK441354827 = class(TArchiInsiderTest)
  {* [Requestlink:441354827] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK441354827
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK441354827.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK441354827.GetFolder

function TK441354827.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5217342400A7';
end;//TK441354827.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK441354827.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
