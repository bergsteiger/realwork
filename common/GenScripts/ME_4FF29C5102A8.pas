unit K371636355;
 {* [Requestlink:371636355] }

// ������: "w:\archi\source\projects\Archi\Tests\K371636355.pas"
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
 TK371636355 = class(TArchiInsiderTest)
  {* [Requestlink:371636355] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK371636355
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK371636355.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK371636355.GetFolder

function TK371636355.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FF29C5102A8';
end;//TK371636355.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK371636355.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
