unit K522796828;
 {* [Requestlink:522796828] }

// ������: "w:\archi\source\projects\Archi\Tests\K522796828.pas"
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
 TK522796828 = class(TArchiInsiderTest)
  {* [Requestlink:522796828] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK522796828
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK522796828.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DialogTest';
end;//TK522796828.GetFolder

function TK522796828.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5333FE1F0324';
end;//TK522796828.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK522796828.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
