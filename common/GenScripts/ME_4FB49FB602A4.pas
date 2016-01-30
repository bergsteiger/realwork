unit K358365470;
 {* [Requestlink:358365470] }

// ������: "w:\archi\source\projects\Archi\Tests\K358365470.pas"
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
 TK358365470 = class(TArchiInsiderTest)
  {* [Requestlink:358365470] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK358365470
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358365470.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK358365470.GetFolder

function TK358365470.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FB49FB602A4';
end;//TK358365470.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358365470.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
