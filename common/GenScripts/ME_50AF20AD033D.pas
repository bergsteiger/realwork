unit K409747548;
 {* [Requestlink:409747548] }

// ������: "w:\archi\source\projects\Archi\Tests\K409747548.pas"
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
 TK409747548 = class(TArchiInsiderTest)
  {* [Requestlink:409747548] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK409747548
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK409747548.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BlockTest';
end;//TK409747548.GetFolder

function TK409747548.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50AF20AD033D';
end;//TK409747548.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK409747548.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
