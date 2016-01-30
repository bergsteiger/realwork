unit K466751170;
 {* [Requestlink:466751170] }

// ������: "w:\archi\source\projects\Archi\Tests\K466751170.pas"
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
 TK466751170 = class(TArchiInsiderTest)
  {* [Requestlink:466751170] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK466751170
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK466751170.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK466751170.GetFolder

function TK466751170.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51D16D750188';
end;//TK466751170.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK466751170.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
