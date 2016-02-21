unit K425284919;
 {* [Requestlink:425284919] }

// ������: "w:\archi\source\projects\Archi\Tests\K425284919.pas"
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
 TK425284919 = class(TArchiInsiderTest)
  {* [Requestlink:425284919] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK425284919
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK425284919.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK425284919.GetFolder

function TK425284919.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5163ED700399';
end;//TK425284919.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425284919.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
