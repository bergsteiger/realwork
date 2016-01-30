unit K517783699;
 {* [Requestlink:517783699] }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K517783699.pas"
// ���������: "TestCase"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK517783699 = class(TArchiInsiderTest)
  {* [Requestlink:517783699] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK517783699
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK517783699.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'PreivewTests';
end;//TK517783699.GetFolder

function TK517783699.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '532164F50223';
end;//TK517783699.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK517783699.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
