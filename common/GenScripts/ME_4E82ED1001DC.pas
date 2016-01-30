unit K281520291;
 {* [Requestlink:281520291] }

// ������: "w:\archi\source\projects\Archi\Tests\K281520291.pas"
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
 TK281520291 = class(TArchiInsiderTest)
  {* [Requestlink:281520291] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK281520291
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK281520291.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Drawing Tests';
end;//TK281520291.GetFolder

function TK281520291.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E82ED1001DC';
end;//TK281520291.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK281520291.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
