unit K390585154;
 {* [Requestlink:390585154] }

// ������: "w:\archi\source\projects\Archi\Tests\K390585154.pas"
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
 TK390585154 = class(TArchiInsiderTest)
  {* [Requestlink:390585154] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK390585154
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK390585154.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK390585154.GetFolder

function TK390585154.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5048AA03036F';
end;//TK390585154.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK390585154.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
