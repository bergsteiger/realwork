unit K144575411;
 {* [Requestlink:144575411] }

// ������: "w:\archi\source\projects\Archi\Tests\K144575411.pas"
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
 TK144575411 = class(TArchiInsiderTest)
  {* [Requestlink:144575411] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK144575411
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK144575411.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK144575411.GetFolder

function TK144575411.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51F8F9B00364';
end;//TK144575411.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK144575411.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
