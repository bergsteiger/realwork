unit K400523879;
 {* [Requestlink:400523879] }

// ������: "w:\archi\source\projects\Archi\Tests\K400523879.pas"
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
 TK400523879 = class(TArchiInsiderTest)
  {* [Requestlink:400523879] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK400523879
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK400523879.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'InnerTable';
end;//TK400523879.GetFolder

function TK400523879.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '506EA7BD01AB';
end;//TK400523879.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK400523879.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
