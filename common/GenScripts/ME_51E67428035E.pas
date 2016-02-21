unit K466752604;
 {* [Requestlink:466752604] }

// ������: "w:\archi\source\projects\Archi\Tests\K466752604.pas"
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
 TK466752604 = class(TArchiInsiderTest)
  {* [Requestlink:466752604] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK466752604
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK466752604.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'FilterTests';
end;//TK466752604.GetFolder

function TK466752604.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51E67428035E';
end;//TK466752604.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK466752604.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
