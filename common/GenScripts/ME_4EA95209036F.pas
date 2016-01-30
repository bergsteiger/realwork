unit K296094711;
 {* [Requestlink:296094711] }

// ������: "w:\archi\source\projects\Archi\Tests\K296094711.pas"
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
 TK296094711 = class(TArchiInsiderTest)
  {* [Requestlink:296094711] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK296094711
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK296094711.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK296094711.GetFolder

function TK296094711.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EA95209036F';
end;//TK296094711.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK296094711.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
