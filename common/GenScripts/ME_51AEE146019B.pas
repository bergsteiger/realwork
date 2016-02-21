unit K358976813;
 {* [Requestlink:358976813] }

// ������: "w:\archi\source\projects\Archi\Tests\K358976813.pas"
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
 TK358976813 = class(TArchiInsiderTest)
  {* [Requestlink:358976813] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK358976813
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358976813.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableResize';
end;//TK358976813.GetFolder

function TK358976813.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51AEE146019B';
end;//TK358976813.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358976813.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
