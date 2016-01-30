unit K437125222;
 {* [Requestlink:437125222] }

// ������: "w:\archi\source\projects\Archi\Tests\K437125222.pas"
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
 TK437125222 = class(TArchiInsiderTest)
  {* [Requestlink:437125222] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK437125222
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK437125222.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DialogTest';
end;//TK437125222.GetFolder

function TK437125222.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5142F6DD03A7';
end;//TK437125222.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK437125222.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
