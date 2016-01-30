unit K425264440;
 {* [Requestlink:425264440] }

// ������: "w:\archi\source\projects\Archi\Tests\K425264440.pas"
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
 TK425264440 = class(TArchiInsiderTest)
  {* [Requestlink:425264440] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK425264440
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK425264440.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK425264440.GetFolder

function TK425264440.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5108C83C00DE';
end;//TK425264440.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK425264440.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
