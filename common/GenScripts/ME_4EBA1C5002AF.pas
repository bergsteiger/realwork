unit K297698018;
 {* [Requestlink:297698018] }

// ������: "w:\archi\source\projects\Archi\Tests\K297698018.pas"
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
 TK297698018 = class(TArchiInsiderTest)
  {* [Requestlink:297698018] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK297698018
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK297698018.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK297698018.GetFolder

function TK297698018.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EBA1C5002AF';
end;//TK297698018.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK297698018.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
