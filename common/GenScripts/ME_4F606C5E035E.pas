unit K342859055;
 {* [Requestlink:342859055] }

// ������: "w:\archi\source\projects\Archi\Tests\K342859055.pas"
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
 TK342859055 = class(TArchiInsiderTest)
  {* [Requestlink:342859055] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK342859055
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK342859055.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'KeyWordsTest';
end;//TK342859055.GetFolder

function TK342859055.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F606C5E035E';
end;//TK342859055.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342859055.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
