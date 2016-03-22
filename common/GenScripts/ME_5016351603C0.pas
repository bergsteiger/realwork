unit K379250166;
 {* [Requestlink:379250166] }

// ������: "w:\archi\source\projects\Archi\Tests\K379250166.pas"
// ���������: "TestCase"
// ������� ������: "K379250166" MUID: (5016351603C0)
// ��� ����: "TK379250166"

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
 TK379250166 = class(TArchiInsiderTest)
  {* [Requestlink:379250166] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK379250166
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK379250166.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK379250166.GetFolder

function TK379250166.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5016351603C0';
end;//TK379250166.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK379250166.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
