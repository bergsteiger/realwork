unit K423593340;
 {* [Requestlink:423593340] }

// ������: "w:\archi\source\projects\Archi\Tests\K423593340.pas"
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
 TK423593340 = class(TArchiInsiderTest)
  {* [Requestlink:423593340] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK423593340
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK423593340.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScrollTests';
end;//TK423593340.GetFolder

function TK423593340.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50EFBD870384';
end;//TK423593340.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK423593340.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
