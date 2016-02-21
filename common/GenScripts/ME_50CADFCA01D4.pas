unit K407745210;
 {* [Requestlink:407745210] }

// ������: "w:\archi\source\projects\Archi\Tests\K407745210.pas"
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
 TK407745210 = class(TArchiInsiderTest)
  {* [Requestlink:407745210] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK407745210
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407745210.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK407745210.GetFolder

function TK407745210.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50CADFCA01D4';
end;//TK407745210.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407745210.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
