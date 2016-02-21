unit K327812385;
 {* [RequestLink:327812385] }

// ������: "w:\archi\source\projects\Archi\Tests\K327812385.pas"
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
 TK327812385 = class(TArchiInsiderTest)
  {* [RequestLink:327812385] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK327812385
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK327812385.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DialogTest';
end;//TK327812385.GetFolder

function TK327812385.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F13DB7D00E1';
end;//TK327812385.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK327812385.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
