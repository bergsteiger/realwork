unit K331186226;
 {* [RequestLink:331186226] }

// ������: "w:\archi\source\projects\Archi\Tests\K331186226.pas"
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
 TK331186226 = class(TArchiInsiderTest)
  {* [RequestLink:331186226] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK331186226
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK331186226.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ContentsTree';
end;//TK331186226.GetFolder

function TK331186226.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F28D3300037';
end;//TK331186226.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK331186226.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
