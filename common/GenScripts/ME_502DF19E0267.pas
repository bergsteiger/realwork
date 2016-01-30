unit K382421131;
 {* [Requestlink:382421131] }

// ������: "w:\archi\source\projects\Archi\Tests\K382421131.pas"
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
 TK382421131 = class(TArchiInsiderTest)
  {* [Requestlink:382421131] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK382421131
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK382421131.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ScrollTests';
end;//TK382421131.GetFolder

function TK382421131.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '502DF19E0267';
end;//TK382421131.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK382421131.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
