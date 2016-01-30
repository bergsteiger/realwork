unit K210436431;
 {* [RequestLink:210436431] }

// ������: "w:\archi\source\projects\Archi\Tests\K210436431.pas"
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
 TK210436431 = class(TArchiInsiderTest)
  {* [RequestLink:210436431] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK210436431
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210436431.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK210436431.GetFolder

function TK210436431.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EF1A9DE010A';
end;//TK210436431.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210436431.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
