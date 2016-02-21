unit K384434990;
 {* [Requestlink:384434990] }

// ������: "w:\archi\source\projects\Archi\Tests\K384434990.pas"
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
 TK384434990 = class(TArchiInsiderTest)
  {* [Requestlink:384434990] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK384434990
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK384434990.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK384434990.GetFolder

function TK384434990.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '502B954600A4';
end;//TK384434990.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK384434990.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
