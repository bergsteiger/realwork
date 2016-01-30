unit K297703832;
 {* [Requestlink:297703832] }

// ������: "w:\archi\source\projects\Archi\Tests\K297703832.pas"
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
 TK297703832 = class(TArchiInsiderTest)
  {* [Requestlink:297703832] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK297703832
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK297703832.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK297703832.GetFolder

function TK297703832.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EF2F4C502FE';
end;//TK297703832.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK297703832.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
