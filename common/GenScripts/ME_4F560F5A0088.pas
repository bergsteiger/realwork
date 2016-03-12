unit K343640765;
 {* [Requestlink:343640765] }

// ������: "w:\archi\source\projects\Archi\Tests\K343640765.pas"
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
 TK343640765 = class(TArchiInsiderTest)
  {* [Requestlink:343640765] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK343640765
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK343640765.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScrollTests';
end;//TK343640765.GetFolder

function TK343640765.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F560F5A0088';
end;//TK343640765.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK343640765.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
