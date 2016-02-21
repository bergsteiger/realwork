unit K280859299;
 {* [Requestlink:280859299] }

// ������: "w:\archi\source\projects\Archi\Tests\K280859299.pas"
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
 TK280859299 = class(TArchiInsiderTest)
  {* [Requestlink:280859299] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK280859299
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK280859299.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK280859299.GetFolder

function TK280859299.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E5E325800CB';
end;//TK280859299.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK280859299.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
