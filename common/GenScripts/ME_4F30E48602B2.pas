unit K336137132;
 {* [Requestlink:336137132] }

// ������: "w:\archi\source\projects\Archi\Tests\K336137132.pas"
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
 TK336137132 = class(TArchiInsiderTest)
  {* [Requestlink:336137132] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK336137132
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336137132.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK336137132.GetFolder

function TK336137132.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F30E48602B2';
end;//TK336137132.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336137132.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
