unit K358975616;
 {* [Requestlink:358975616] }

// ������: "w:\archi\source\projects\Archi\Tests\K358975616.pas"
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
 TK358975616 = class(TArchiInsiderTest)
  {* [Requestlink:358975616] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK358975616
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358975616.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK358975616.GetFolder

function TK358975616.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F9912860108';
end;//TK358975616.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358975616.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
