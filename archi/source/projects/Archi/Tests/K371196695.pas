unit K371196695;
 {* [Requestlink:371196695] }

// ������: "w:\archi\source\projects\Archi\Tests\K371196695.pas"
// ���������: "TestCase"
// ������� ������: "K371196695" MUID: (4FF2C919009A)
// ��� ����: "TK371196695"

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
 TK371196695 = class(TArchiInsiderTest)
  {* [Requestlink:371196695] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK371196695
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK371196695.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Drawing Tests';
end;//TK371196695.GetFolder

function TK371196695.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FF2C919009A';
end;//TK371196695.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK371196695.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
