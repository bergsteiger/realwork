unit K342862858;
 {* [Requestlink:342862858] }

// ������: "w:\archi\source\projects\Archi\Tests\K342862858.pas"
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
 TK342862858 = class(TArchiInsiderTest)
  {* [Requestlink:342862858] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK342862858
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK342862858.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK342862858.GetFolder

function TK342862858.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F50C48F01E0';
end;//TK342862858.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342862858.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
