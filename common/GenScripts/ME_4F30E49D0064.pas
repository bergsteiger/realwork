unit K336137156;
 {* [Requestlink:336137156] }

// ������: "w:\archi\source\projects\Archi\Tests\K336137156.pas"
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
 TK336137156 = class(TArchiInsiderTest)
  {* [Requestlink:336137156] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK336137156
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK336137156.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableTools';
end;//TK336137156.GetFolder

function TK336137156.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F30E49D0064';
end;//TK336137156.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336137156.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
