unit K365824453;
 {* [Requestlink:365824453] }

// ������: "w:\archi\source\projects\Archi\Tests\K365824453.pas"
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
 TK365824453 = class(TArchiInsiderTest)
  {* [Requestlink:365824453] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK365824453
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK365824453.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TableBoundariesAlignment';
end;//TK365824453.GetFolder

function TK365824453.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FC4B03C0085';
end;//TK365824453.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK365824453.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
