unit K356060358;
 {* [Requestlink:356060358] }

// ������: "w:\archi\source\projects\Archi\Tests\K356060358.pas"
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
 TK356060358 = class(TArchiInsiderTest)
  {* [Requestlink:356060358] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK356060358
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK356060358.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK356060358.GetFolder

function TK356060358.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F7C1F48010A';
end;//TK356060358.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK356060358.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
