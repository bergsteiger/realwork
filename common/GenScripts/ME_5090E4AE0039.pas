unit K407150397;
 {* [Requestlink:407150397] }

// ������: "w:\archi\source\projects\Archi\Tests\K407150397.pas"
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
 TK407150397 = class(TArchiInsiderTest)
  {* [Requestlink:407150397] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK407150397
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407150397.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK407150397.GetFolder

function TK407150397.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5090E4AE0039';
end;//TK407150397.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407150397.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
