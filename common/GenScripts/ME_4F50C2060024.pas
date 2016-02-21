unit K342861821;
 {* [Requestlink:342861821] }

// ������: "w:\archi\source\projects\Archi\Tests\K342861821.pas"
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
 TK342861821 = class(TArchiInsiderTest)
  {* [Requestlink:342861821] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK342861821
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK342861821.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TK342861821.GetFolder

function TK342861821.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F50C2060024';
end;//TK342861821.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342861821.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
