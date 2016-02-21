unit K425040715;
 {* [Requestlink:425040715] }

// ������: "w:\archi\source\projects\Archi\Tests\K425040715.pas"
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
 TK425040715 = class(TArchiInsiderTest)
  {* [Requestlink:425040715] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK425040715
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK425040715.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableBoundariesAlignment';
end;//TK425040715.GetFolder

function TK425040715.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5101225B0033';
end;//TK425040715.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425040715.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
