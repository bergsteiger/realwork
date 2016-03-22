unit K419695643;
 {* [Requestlink:419695643] }

// ������: "w:\archi\source\projects\Archi\Tests\K419695643.pas"
// ���������: "TestCase"
// ������� ������: "K419695643" MUID: (50CAFF2F03AB)
// ��� ����: "TK419695643"

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
 TK419695643 = class(TArchiInsiderTest)
  {* [Requestlink:419695643] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK419695643
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK419695643.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK419695643.GetFolder

function TK419695643.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50CAFF2F03AB';
end;//TK419695643.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK419695643.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
