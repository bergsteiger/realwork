unit K452392846;
 {* [Requestlink:452392846] }

// ������: "w:\archi\source\projects\Archi\Tests\K452392846.pas"
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
 TK452392846 = class(TArchiInsiderTest)
  {* [Requestlink:452392846] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK452392846
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK452392846.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK452392846.GetFolder

function TK452392846.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '517E5B500353';
end;//TK452392846.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK452392846.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
