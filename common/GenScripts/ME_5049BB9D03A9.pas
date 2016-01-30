unit K390586769;
 {* [Requestlink:390586769] }

// ������: "w:\archi\source\projects\Archi\Tests\K390586769.pas"
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
 TK390586769 = class(TArchiInsiderTest)
  {* [Requestlink:390586769] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK390586769
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK390586769.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK390586769.GetFolder

function TK390586769.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5049BB9D03A9';
end;//TK390586769.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK390586769.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
