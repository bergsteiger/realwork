unit K382408648;
 {* [Requestlink:382408648] }

// ������: "w:\archi\source\projects\Archi\Tests\K382408648.pas"
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
 TK382408648 = class(TArchiInsiderTest)
  {* [Requestlink:382408648] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK382408648
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK382408648.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK382408648.GetFolder

function TK382408648.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5023B65301D1';
end;//TK382408648.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382408648.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
