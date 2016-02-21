unit K358976247;
 {* [Requestlink:358976247] }

// ������: "w:\archi\source\projects\Archi\Tests\K358976247.pas"
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
 TK358976247 = class(TArchiInsiderTest)
  {* [Requestlink:358976247] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK358976247
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358976247.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK358976247.GetFolder

function TK358976247.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F90FF6B023B';
end;//TK358976247.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358976247.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
