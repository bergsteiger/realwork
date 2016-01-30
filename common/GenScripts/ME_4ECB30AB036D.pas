unit K300027413;
 {* [RequestLink:300027413] }

// ������: "w:\archi\source\projects\Archi\Tests\K300027413.pas"
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
 TK300027413 = class(TArchiInsiderTest)
  {* [RequestLink:300027413] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK300027413
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK300027413.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ContentsTree';
end;//TK300027413.GetFolder

function TK300027413.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4ECB30AB036D';
end;//TK300027413.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK300027413.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
