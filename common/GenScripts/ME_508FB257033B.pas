unit K407150878;
 {* [Requestlink:407150878] }

// ������: "w:\archi\source\projects\Archi\Tests\K407150878.pas"
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
 TK407150878 = class(TArchiInsiderTest)
  {* [Requestlink:407150878] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK407150878
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407150878.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScrollTests';
end;//TK407150878.GetFolder

function TK407150878.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '508FB257033B';
end;//TK407150878.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407150878.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
