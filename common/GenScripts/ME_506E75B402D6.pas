unit K330705088;
 {* [Requestlink:330705088] }

// ������: "w:\archi\source\projects\Archi\Tests\K330705088.pas"
// ���������: "TestCase"
// ������� ������: "K330705088" MUID: (506E75B402D6)
// ��� ����: "TK330705088"

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
 TK330705088 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:330705088] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK330705088
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK330705088.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DialogTest';
end;//TK330705088.GetFolder

function TK330705088.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '506E75B402D6';
end;//TK330705088.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK330705088.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
