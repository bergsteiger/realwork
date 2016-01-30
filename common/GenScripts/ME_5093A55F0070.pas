unit K407150049;
 {* [Requestlink:407150049] }

// ������: "w:\archi\source\projects\Archi\Tests\K407150049.pas"
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
 TK407150049 = class(TArchiInsiderTest)
  {* [Requestlink:407150049] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK407150049
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK407150049.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'SelectionTests';
end;//TK407150049.GetFolder

function TK407150049.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5093A55F0070';
end;//TK407150049.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK407150049.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
