unit K235864238;
 {* [Requestlink:235864238] }

// ������: "w:\archi\source\projects\Archi\Tests\K235864238.pas"
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
 TK235864238 = class(TArchiInsiderTest)
  {* [Requestlink:235864238] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235864238
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235864238.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK235864238.GetFolder

function TK235864238.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F339DC80012';
end;//TK235864238.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235864238.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
