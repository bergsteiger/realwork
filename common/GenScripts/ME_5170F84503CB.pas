unit K377749722;
 {* [Requestlink:377749722] }

// ������: "w:\archi\source\projects\Archi\Tests\K377749722.pas"
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
 TK377749722 = class(TArchiInsiderTest)
  {* [Requestlink:377749722] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK377749722
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK377749722.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'OEMTextTests';
end;//TK377749722.GetFolder

function TK377749722.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5170F84503CB';
end;//TK377749722.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK377749722.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
