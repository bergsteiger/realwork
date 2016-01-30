unit K389942714;
 {* [Requestlink:389942714] }

// ������: "w:\archi\source\projects\Archi\Tests\K389942714.pas"
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
 TK389942714 = class(TArchiInsiderTest)
  {* [Requestlink:389942714] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK389942714
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK389942714.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DialogTest';
end;//TK389942714.GetFolder

function TK389942714.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '504497A0037B';
end;//TK389942714.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK389942714.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
